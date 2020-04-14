#!/bin/bash

# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
yum update -y
DEVICE_DISK_MAPPINGS="${device_disk_mappings}"
ATT_TYPE="${block_vol_att_type}"
LENGTH="${length}"

if [ $${ATT_TYPE} != "iscsi" || $${ATT_TYPE} != "paravirtualized" ]; then
  echo "You have not selected a correct attachment type. Supported values are paravirtualized, iscsi."
  exit 1
fi

sleep 120
if [ $${ATT_TYPE} == "iscsi" ]; then
  BASEADDR="169.254.2.2"
  # Set a base address incrementor so we can loop through all the
  # addresses.
  addrCount=0
  while [ $${addrCount} -lt $${LENGTH} ]
  do
    CURRADDR=`echo $${BASEADDR} | awk -F\. '{last=$4+'$${addrCount}';print $1"."$2"."$3"."last}'`
    clear
    echo "Attempting connection to $${CURRADDR}"
    mkfifo discpipe
    # Find all the iSCSI Block Storage volumes attached to the instance but
    # not configured for use on the instance.  Basically, get a list of the
    # volumes that the instance can see, the loop through the ones it has,
    # and add volumes not already configured on the instance.
    #
    # First get the list of volumes visible (attached) to the instance
    iscsiadm -m discovery -t st -p $${CURRADDR}:3260 | grep -v uefi | awk '{print $2}' > discpipe 2> /dev/null &
    # If the result is non-zero, that generally means that there are no targets available or
    # that the portal is reachable but not active.  We make no distinction between the two
    # and simply skip ahead.
    result=$?
    if [ $${result} -ne 0 ]
    then
      (( addrCount = addrCount + 1 ))
      continue
    fi
    # Loop through the list (via the named FIFO pipe below)
    while read target
    do
        mkfifo sesspipe
        # Get the list of the currently attached Block Storage volumes
        iscsiadm -m session -P 0 | grep -v uefi | awk '{print $4}' > sesspipe 2> /dev/null &
        # Set a flag, and loop through the sessions (attached, but not configured)
        # and see if the volumes match.  If so, skip to the next until we get
        # through the list.  Session list is via the pipe.
        found="false"
        while read session
        do
            if [ $${target} = $${session} ]
            then
                found="true"
                break
            fi
        done < sesspipe
        # If the volume is not found, configure it.  Get the resulting device file.
        if [ $${found} = "false" ]
        then
            iscsiadm -m node -o new -T $${target} -p $${CURRADDR}:3260
            iscsiadm -m node -o update -T $${target} -n node.startup -v automatic
            iscsiadm -m node -T $${target} -p $${CURRADDR}:3260 -l
            sleep 10
        fi
    done < discpipe
    (( addrCount = addrCount + 1 ))
    find . -maxdepth 1 -type p -exec rm {} \;
  done
  echo "Scan Complete."
fi

for device_mapping in $${DEVICE_DISK_MAPPINGS}; do
    part="$(echo $${device_mapping}|cut -f 2 -d :)"
    mp="$(echo $${device_mapping}|cut -f 1 -d :)"
    mkdir -p $${mp}
    parted $${part} --script -- mklabel gpt
    parted $${part} --script -- mkpart primary 0% 100%
    sleep 10
    mkfs.ext4 $${part}1
    sleep 10
    echo "$${part}1 $${mp} ext4         defaults,_netdev,nofail       0       0" >> /etc/fstab
  done

sleep 10
mount -a