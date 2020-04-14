#!/bin/bash

OPC_CONF="/etc/oci-hostname.conf"
log_template="/tmp/dhclient-exit-hooksXXX.log"
rm -f /tmp/dhclient-exit-hooks*.log
log_file=`mktemp $log_template`

echo "set hostname begin `date`: $reason" >> $log_file

# import the oci-hostname configuration info
if [ -f $OPC_CONF ]; then
	. $OPC_CONF
fi

# ER-28862654 - Add custom header text to /etc/resolv.conf
if ! grep -q "docs.cloud.oracle.com" /etc/resolv.conf; then
sed -i '1i; Any changes made to this file will be overwritten whenever the\
; DHCP lease is renewed. To persist changes you must update the\
; /etc/oci-hostname.conf file. For more information see\
;[https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingDHCP.htm#notes]\
;' /etc/resolv.conf
fi

function retry_command() 
{

  retry_attempts=30
  retry_interval_sec=2
  while [ "$retry_attempts" -gt 0 ]; do

    command_success=true
    "$@" || { command_success=false; }
    if [ "$command_success" == false ]; then
      (( retry_attempts-- ))
      echo "Error occurred running command $@. Will retry in $retry_interval_sec seconds" >> $log_file
      sleep $retry_interval_sec
    else
      echo "Successfully executed the command $@" >> $log_file
      break
    fi
  done

  # Check if issue running command still existed after all retry_attempts
  if [ "$command_success" == false ]; then
    echo "ERROR: failed to execute command '$@' (Retried $retry_attempts times)" >> $log_file
    return 1
  fi
}

#Usage: add_entries <file name> <keyword> <an array of the corresponding values for the keyword>
#We pass array by name so if the array name is 'arr', pass it as 'arr' instead of $arr
#This function can be used to add entries to files with a mapping format.
#For example, /etc/hosts has <ip> mapped to <fqdn/host alias>
#The function checks to see if a line containing the given 'keyword' is in the file
#If so, we check the given array of values against the existing values for the keyword in that line.
#Append the values specified in the array to the line if it doesn't already exist.
#If the file does not contain a line with the given keyword,
#the function will add a new line with the given keyword mapped to all values in the given array.
function add_entries() 
{
    local file=${1}
    local keyword=${2}
    local values=$3[@]
    values=("${!values}")
    # grep needs quiet option. See bug: 30155909 
    if ! grep -qw "^$keyword" $file; then
        echo "Line with '$keyword' not found in $file" >> $log_file
        new_entry="$keyword"
        for value in "${values[@]}"
        do
            new_entry="$new_entry $value"
        done
        echo "Adding '$new_entry' to $file" >> $log_file
        echo "$new_entry" >>  $file

    else
        echo "Found line with '$keyword'" >> $log_file
        target_line=$(grep -w "^$keyword" $file)
        for value in "${values[@]}"
        do
            #First case needs spaces around $value to make sure it's not the prefix or suffix of another value
            #Second case checks if $value is at the end of the line
            if [[ $target_line == *" $value "* ]] || [[ $target_line == *" $value" ]]; then
                echo "'$value' already exists in line" >> $log_file
            else
                echo "Adding '$value' to line" >> $log_file
                sed -i "s/^\<$keyword\>.*$/& $value/g" $file
            fi
        done
    fi
}


# This function updates the hostname 
# Arguments: 
#   Arg1 --  OS version information to set hostname accordingly
#   Arg2 --  Hostname that needs to be set
function update_hostname()
{
    local os_version=${1}
    local new_host_name=${2}

    echo "Updating hostname" >> $log_file

    # 1. run hostname command
    if [ $os_version == 6 ]; then
        # use short hostname for /etc/sysconfig/network
        # https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/sn-Netconfig-x86.html
        new_host_name_config="HOSTNAME=$new_host_name"
        echo "Update /etc/sysconfig/network with new host name $new_host_name_config" >> $log_file

        if grep --quiet '^HOSTNAME=' /etc/sysconfig/network; then
            echo "HOSTNAME exists in /etc/sysconfig/network. Updating its value" >> $log_file
            sed -i "s/^HOSTNAME=.*$/$new_host_name_config/g"  /etc/sysconfig/network
        else
            echo "Adding HOSTNAME to /etc/sysconfig/network" >> $log_file
            echo "$new_host_name_config" >> /etc/sysconfig/network
        fi

        echo "Running hostname command: hostname $new_host_name" >> $log_file
        hostname $new_host_name

    elif [ $os_version == 7 ]; then
        echo "Running hostnamectl command: hostnamectl set-hostname $new_host_name" >> $log_file
        hostnamectl set-hostname $new_host_name

    fi
}


# This function updates /etc/hosts and /etc/resolv.conf
# Arguments:
#   Arg1 -- new IP address
#   Arg2 -- new hostname of the system
function update_hosts_resolv()
{
    local new_ip_address=${1}
    local new_host_name=${2}

    # Remove old entry from /etc/hosts so that we avoid getting
    # stale information from ipcalc. 
    # First though, save the entries for
    # restoration if ipcalc encounters failures.
    old_vals=`grep "^$new_ip_address" /etc/hosts`
    old_fqdn=`echo $old_vals | awk -F " " '{print $2}'`
    old_host_name=`echo $old_vals | awk -F " " '{print $3}'`
    echo "Pre-existing fqdn is $old_fqdn and hostname is $old_host_name" >> $log_file
    # Now remove old entry
    sed -i "/^\<$new_ip_address\>.*$/d" /etc/hosts

    # Get fqdn
    fqdn=`retry_command ipcalc -h $new_ip_address`
    ipcalc_success=$?
    if [ $ipcalc_success -ne 0 ]; then
        echo "WARNING: ipcalc unsuccessful. This usually happens when there is no DNS." >> $log_file
        # Restore previously existing hostname entry but first:
        # Check for existing exact matches of hostname and delete them, if any.
        sed -i -e "/[[:space:]]\<$old_host_name\>[[:space:]\.]/d; /[[:space:]]\<$old_host_name\>$/d" /etc/hosts

        old_host_values=("$old_fqdn" "$old_host_name")
        add_entries "/etc/hosts" "$new_ip_address" old_host_values
    else

        # ipcalc returns HOSTNAME=xxxx, need to remove "HOSTNAME="
        fqdn=${fqdn#HOSTNAME=}

        # get subnet_domain_name
        subnet_domain_name=${fqdn#$new_host_name.}

        # verify that the subnet domain is valid, we expect it is of the 
        # form <subnet-name>.<vcn-name>.<oraclevcn>.<com>
        if [[ $subnet_domain_name != *.*.*.* ]]; then
            echo "WARNING: invalid subnet domain name '$subnet_domain_name'."  \
                 "This can happen when there is no DNS." >> $log_file
        else
            # get vcn domain name - everything after the first dot in the subnet domain name
            vcn_domain_name=${subnet_domain_name#*.}
            echo "fqdn=$fqdn" >> $log_file
            echo "subnet_domain_name=$subnet_domain_name" >> $log_file
            echo "vcn_domain_name=$vcn_domain_name" >> $log_file

            # 2. Update /etc/hosts if needed
            # Check for existing exact matches of hostname and delete them, if any.
            sed -i -e "/[[:space:]]\<$new_host_name\>[[:space:]\.]/d; /[[:space:]]\<$new_host_name\>$/d" /etc/hosts

            new_host_values=("$fqdn" "$new_host_name")
            # Pass array by name
            add_entries "/etc/hosts" "$new_ip_address" new_host_values

            # 3. Update /etc/resolv.conf
            # This is a temp fix till we have a resolution for a proper dhcp response
            new_search_domains=("$subnet_domain_name" "$vcn_domain_name")
            add_entries "/etc/resolv.conf" "search" new_search_domains
        fi
    fi
}

# This function updates /etc/resolv.conf
# Arguments:
#   Arg1 -- new IP address
#   Arg2 -- new hostname of the system
function update_resolv()
{
    local new_ip_address=${1}
    local new_host_name=${2}

    # Since the hostname might have been changed in /etc/hosts and we're not
    # updating it, only using ipcalc might give us stale hostname information.
    # To get the DNS provided hostname, use host and compare it with ipcalc's 
    # generated version. If they don't match use the one from host.
    host_name=`host $new_ip_address | awk -F " " '{print $5}'`
    host_success=$?
    ipcalc_name=`retry_command ipcalc -h $new_ip_address`
    ipcalc_success=$?
    if [[ $ipcalc_success -ne 0 ]] || [[ $host_success -ne 0 ]]; then
        echo "WARNING: ipcalc and host commands were unsuccessful." \
	     "This usually happens when there is no DNS." >> $log_file
    else

        # ipcalc returns HOSTNAME=xxxx, need to remove "HOSTNAME="
        ipcalc_name=${ipcalc_name#HOSTNAME=}
	echo "ipcalc returned hostname: $ipcalc_name" >> $log_file

	# host substring will have a "." at the end. Drop it
	host_name=${host_name%?}
	echo "host returned hostname: $host_name" >> $log_file

	use_ipcalc_hostname=0
	if [ "$host_name" = "$ipcalc_name" ]; then
		# either one will do
		fqdn=$ipcalc_name
	else
		# Likely that ipcalc has a user changed hostname. 
		# This will not match the new_host_name one.
		# Use the one from host. But before that confirm
		# that host has returned a valid name.
		if [[ "$host_name" != *.*.*.*.* ]]; then
			echo "Invalid hostname $host_name from host command" >> $log_file
			fqdn=$ipcalc_name

			# Need an additional check here for the host_name
			# being identical to the new_host_name as the user
			# could have changed the /etc/host host_name
			# entry which would not match the dhclient one.
			ipcalc_host_name=`echo $ipcalc_name | awk -F "." '{print $1}'`
			if [[ "$ipcalc_host_name" != "$new_host_name" ]]; then
				echo "ipcalc returned host $ipcalc_host_name" >> $log_file
				echo "dhclient returned host $new_host_name" >> $log_file
				echo "Using ipcalc returned hostname" >> $log_file
				use_ipcalc_hostname=1
			fi
		else
			fqdn=$host_name
		fi
	fi

        # get subnet_domain_name
	if [[ "$use_ipcalc_hostname" -eq 1 ]]; then
        	subnet_domain_name=${fqdn#$ipcalc_host_name.}
	else
        	subnet_domain_name=${fqdn#$new_host_name.}
	fi

        # verify that the subnet domain is valid, we expect it is of the 
        # form <subnet-name>.<vcn-name>.<oraclevcn>.<com>
        if [[ $subnet_domain_name != *.*.*.* ]]; then
            echo "WARNING: invalid subnet domain name '$subnet_domain_name'."  \
                 "This can happen when there is no DNS." >> $log_file
        else
            # get vcn domain name - everything after the first dot in the subnet domain name
            vcn_domain_name=${subnet_domain_name#*.}
            echo "fqdn=$fqdn" >> $log_file
            echo "subnet_domain_name=$subnet_domain_name" >> $log_file
            echo "vcn_domain_name=$vcn_domain_name" >> $log_file

            # Update /etc/resolv.conf
            new_search_domains=("$subnet_domain_name" "$vcn_domain_name")
            add_entries "/etc/resolv.conf" "search" new_search_domains
        fi
    fi
}

# This function adds NM_CONTROLLED=no entry to the primary interface config file 
# So that network manger does not take cotrol when installed.
# Arguments:
# Arg1 -- primary_ip

function disable_NMcontrol()
{
    local primary_ip=${1}

    # find the primary interface
    primary_if=`ifconfig | grep -B1 $primary_ip | head -n1 | awk -F '[: ]' '{print $1}'`

    # generate the primary interface's ifconfig filepath.
    cfg_file="/etc/sysconfig/network-scripts/ifcfg-${primary_if}"

    # check if the file is present.
    if [ ! -f $cfg_file ]; then
        echo "$cfg_file not found, skip NM_CONTROLLED setting." >> $log_file
        return
    fi

    # check if the keyword is present or not
    # grep needs quiet option. See bug: 30155909 
    if ! grep -qw "^NM_CONTROLLED" $cfg_file; then
            # append the line..
            echo "NM_CONTROLLED=no" >> $cfg_file
    else
           # modify the line
           sed -i "s/^\<NM_CONTROLLED\>.*$/NM_CONTROLLED=no/g" $cfg_file
    fi
}

# Get the primary vnic ip only if interface has been initialized.
# Ref:  https://www.isc.org/wp-content/uploads/2018/02/dhcp44cscript.html#PREINIT
if [ "$reason" != "PREINIT" ]; then
    primary_ip=`retry_command curl 169.254.169.254/opc/v1/vnics/ -sf  | jq -r '.[0] | .privateIp'`
fi

# This script is invoked whenever dhclient is run.
# We want to skip hostname update if $new_ip_address != $primary_ip 
# so we don't run this for all interfaces
if [ -z "$primary_ip" ]; then
    echo "Skip updating hostname because primary ip is empty." >> $log_file
elif [ "$new_ip_address" != "$primary_ip" ];then
    echo "Skip updating hostname because this was not invoked for the primary vnic" >> $log_file
else
    # add NM_Controlled="no" to primary network interface configuration file 
    disable_NMcontrol $primary_ip

    if [[ $PRESERVE_HOSTINFO -eq 2 ]]; then
        echo "Skip updating hostname, /etc/hosts and /etc/resolv.conf " \
            "as per PRESERVE_HOSTINFO=${PRESERVE_HOSTINFO} setting" >> $log_file
        return 0
    fi

    # reason why this hook was invoked. It is set by dhclient script
    echo "reason=$reason" >> $log_file

    # https://linux.die.net/man/8/dhclient-script
    if [ "$reason" = "BOUND" ] || [ "$reason" = "RENEW" ] || [ "$reason" = "REBIND" ] || [ "$reason" = "REBOOT" ]; then

        os_version=0
        os_string=$(grep -w VERSION /etc/os-release | awk -F "\"" '{print $2}')
        echo "INFO: Obtained $os_string from /etc/os-release" >> $log_file
        if [[ "$os_string" == "6."* ]]; then
            os_version=6
        elif [[ "$os_string" == "7."* ]]; then
            os_version=7
        fi

	    if [[ "$os_version" == 0 ]]; then
            echo "INFO: Could not determine valid OS version." >> $log_file
            echo "INFO: Attempting to get OS version via uname -mrs" >> $log_file

            kernel_version=$(uname -mrs)
            if [[ "$kernel_version" == *"el6"* ]]; then
                os_version=6
            elif [[ "$kernel_version" == *"el7"* ]]; then
                os_version=7
            else
                os_version=0
            fi
	    fi

	    if [ "$os_version" == 0 ]; then
            echo "ERROR: Could not obtain valid OS version " >> $log_file
            exit_status=1
        else
            echo "os version = $os_version" >> $log_file
            #These variables are set by dhclient script
            echo "new_ip_address=$new_ip_address" >> $log_file
            echo "new_host_name=$new_host_name" >> $log_file
            echo "new_domain_name=$new_domain_name" >> $log_file

            #Retrieve hostname from metadata if its empty
            if [ -z $new_host_name ]; then
                new_host_name=`retry_command curl -sf 169.254.169.254/openstack/latest/meta_data.json  | jq '.hostname' -r`
            fi

            if [ -z $new_host_name ]; then
                echo "ERROR: new_host_name is empty after retrieving it from metadata json. Exiting." >> $log_file
                exit_status=1
            else
                if [[ $PRESERVE_HOSTINFO -eq 0 ]]; then
                    # update the hostname with new hostname
                    update_hostname $os_version $new_host_name
                    # update hosts and resolv conf files
                    update_hosts_resolv $new_ip_address $new_host_name
                elif [[ $PRESERVE_HOSTINFO -eq 1 ]]; then
                    echo "Skip updating hostname as per "   \
                        "PRESERVE_HOSTINFO=${PRESERVE_HOSTINFO} setting" >> $log_file
                    # update hosts and resolv conf files
                    update_hosts_resolv $new_ip_address $new_host_name
                elif [[ $PRESERVE_HOSTINFO -eq 3 ]]; then
                    echo "Skip updating hostname and /etc/hosts as per "   \
                        "PRESERVE_HOSTINFO=${PRESERVE_HOSTINFO} setting" >> $log_file
                    echo "Updating subnet in /etc/resolv "   >> $log_file
                    # update resolv conf file alone
                    update_resolv $new_ip_address $new_host_name
				fi
           fi
      fi
    else
       echo "Not updating because reason=$reason" >> $log_file
    fi
    echo "sethostname END" >> $log_file
fi
