# Launch Your LDAP service
## Introduction

In this Lab, you will learn how to launch an LDAP service. This purpose of this lab is to provide detailed steps on how to integrate ExaCC with existing LDAP configuration for authentication to ExaCC.

Estimated Lab Time: 30 minutes

### About LDAP Service

The Lightweight Directory Access Protocol (LDAP) is an open, vendor-neutral, industry standard application protocol for accessing and maintaining distributed directory information services over an Internet Protocol (IP) network. A common use of LDAP is to provide a central place to store usernames and passwords. This allows many different applications and services to connect to the LDAP server to validate users.

ExaCC is able to leverage existing LDAP configuration for user authentication. This document provides the detailed steps on the necessary configurations that will be need to integrate ExaCC with LDAP to allow users to authenticate access using their LDAP credentials.

### Objectives

In this lab, you will be guided through the following steps:

- Configure LDAP
- Precheck
- Modify files: nsswitch.conf and ldap.conf
- Generate certificates
- Modify SSSD config file
- Modifiy files: sshd_config and PAM config 
- Start NSCD and change the config to avoid caching issues, validating NSCD.
- Verify the LDAP/AD user existence 
- Backup procedures
- Troubleshooting

### Prerequisites

- An Oracle Cloud Account
- Some Experience with Linux OS
- Understand the principle of LDAP

## **STEP 1**: Configure LDAP

All steps need to be performed as the root user or each ExaCC compute node. 

1. Connect as user opc and sudo to root.

    You need to know your ldap server. This doc uses ldap.acme.com as an example.
    Do NOT log off as root before you proven that you can connect as you may lock yourself out.

2. Avoid timeout of your session by setting a keep alive signal from putty. Alternatively do

    ````
    export TMOUT=0
    ````

## **STEP 2**: Precheck

1. Check if LDAP is already configured. If yes you will get information about the user. If not the command will return no output. In this example we query for “testuser”

    ````
    getent passwd testuser   
    ````

## **STEP 3**: Modified files: nsswitch.conf and ldap.conf

1. Make a backup copy and then replace the entire content with the listing below.

    ````
    cd /etc 
    cp nsswitch.conf nsswitch.conf.orig
    vi nsswitch.conf
    
    To use db, put the "db" in front of "files" for entries you want to be
    looked up first in the databases

    Example:
    #passwd:    db files nisplus nis
    #shadow:    db files nisplus nis
    #group:     db files nisplus nis

    passwd:     files sss
    shadow:     files sss
    group:      files sss
    #initgroups: files sss

    #hosts:     db files nisplus nis dns
    hosts: files dns/etc/nsswitch.conf

    An example Name Service Switch config file. This file should be
    sorted with the most-used services at the beginning.

    The entry '[NOTFOUND=return]' means that the search for an
    entry should stop if the search in the previous entry turned
    up nothing. Note that if the search failed due to some other reason
    (like no NIS server responding) then the search continues with the
    next entry.

    Valid entries include:

    nisplus                 Use NIS+ (NIS version 3)
    nis                     Use NIS (NIS version 2), also called YP
    dns                     Use DNS (Domain Name Service)
    files                   Use the local files
    db                      Use the local database (.db) files
    compat                  Use NIS on compat mode
    hesiod                  Use Hesiod for user lookups
    [NOTFOUND=return]       Stop searching if not found so far

    Example - obey only what nisplus tells us...
    #services:   nisplus [NOTFOUND=return] files
    #networks:   nisplus [NOTFOUND=return] files
    #protocols:  nisplus [NOTFOUND=return] files
    #rpc:        nisplus [NOTFOUND=return] files
    #ethers:     nisplus [NOTFOUND=return] files
    #netmasks:   nisplus [NOTFOUND=return] files

    bootparams: nisplus [NOTFOUND=return] files

    ethers:     files
    netmasks:   files
    networks:   files
    protocols:  files
    rpc:        files
    services:   files sss

    netgroup:   nisplus sss

    publickey:  nisplus

    automount:  files nisplus sss
    aliases:    files nisplus
    ````

2. Modify ldap.conf

    Make a backup copy and then replace the entire content with the listing below.
    This has the non-prod LDAP server hardcoded. Will be different for Prod.
    
    ````
    cd /etc/openldap
    cp ldap.conf ldap.conf.orig
    vi ldap.conf

    LDAP Defaults

    See ldap.conf(5) for details
    This file should be world readable but not world writable.

    #BASE   dc=example,dc=com
    #URI    ldap://ldap.example.com ldap://ldap-master.example.com:666

    #SIZELIMIT      12
    #TIMELIMIT      15
    #DEREF          never

    TLS_CACERT /etc/openldap/certs/ldap.acme.com.cert
    TLS_CACERTDIR /etc/openldap/certs
    #TLS_REQCERT never

    Turning this off breaks GSSAPI used with krb5 when rdns = false
    SASL_NOCANON    on
    URI ldaps://ldap.acme.com
    BASE ou=ADPeople,ou=people,ou=Entsys,dc=acme.com
    ````

## **STEP 4:** Generate certificate

1. Generate Certificate

    Certificates will vary for each LDAP server.

    Use this command to get a list of the existing certificates. Copy all lines including the begin / end certificate.

    ````
    openssl s_client -connect ldap.acme.com:3061 -showcerts
    ````

    Create these certificate files

    ````
    cd /etc/openldap/certs
    vi ldap.acme.com.cert

    -----BEGIN CERTIFICATE-----
    Dsafasdfgadgagdf
    Adfdsfasdfasdfsadssdg
    -----END CERTIFICATE-----
    ````

## **STEP 5:** Modify SSSD config file

1. modify SSSD config file

    If file exists make a backup copy and then replace the entire content with the listing below.

    ````
    cd /etc/sssd
    ls
    cp sssd.conf sssd.conf.orig
    vi sssd.conf
    chmod 600 sssd.conf

    [sssd]
    config_file_version = 2
    reconnection_retries = 3
    sbus_timeout = 30
    services = nss, pam
    domains = LDAP
    [nss]
    filter_groups = root
    filter_users = root
    reconnection_retries = 3
    [pam]
    reconnection_retries = 3
    [domain/LOCAL]
    description = LOCAL Users domain
    id_provider = local
    enumerate = true
    [domain/LDAP]
    auth_provider = ldap
    #access_provider = ldap
    cache_credentials = True
    chpass_provider = ldap
    id_provider = ldap
    #ldap_schema = rfc2307bis
    #ldap_group_member = uniquemember
    ldap_id_use_start_tls = True
    #only for debugging purposes change debug level to 10
    #debug_level = 10
    debug_level = 0
    min_id = 100
    enumerate = False
    ldap_tls_cacertdir = /etc/openldap/certs
    ldap_tls_reqcert = never
    ldap_uri = ldaps://ldap.acme.com
    ldap_search_base = ou=ADPeople,ou=people,ou=Entsys,dc=acme.com
    ldap_group_search_base = ou=UXgroups,ou=groups,ou=Entsys,dc=acme.com
    ldap_netgroup_search_base = ou=Netgroup,ou=Groups,ou=Entsys,dc=acme.com
    ````

    Make sure the permissions are correct

    ````
    chmod 600 sssd.conf
    restart sssd service
    service sssd restart 
    ````

## **STEP 6:** Modifiy files: sshd_config and PAM config 

1. Modify sshd_config

    ````
    cd /etc/ssh 
    cp -p sshd_config sshd_config.orig
    vi sshd_config

    Change the password authentication related lines to look like the example below.

    Uncomment yes
    Comment out no
    To disable tunneled clear text passwords, change to no here!
    PasswordAuthentication yes
    PermitEmptyPasswords no
    #PasswordAuthentication no
    ````

    Restart the service for the changes to take effect

    ````
    service sshd restart
    ````

2. Modify PAM config file.

    Make a backup copy and then replace the entire content with the listing below.

    ````
    cd /etc/pam.d
    cp password-auth password-auth.orig
    vi password-auth

    #%PAM-1.0
    This file is auto-generated.
    User changes will be destroyed the next time authconfig is run.

    auth        required      pam_env.so
    auth        sufficient    pam_unix.so nullok try_first_pass
    auth        requisite     pam_succeed_if.so uid >= 1000 quiet
    auth        sufficient    pam_sss.so use_first_pass
    auth        required      pam_deny.so

    account     sufficient   pam_ldap.so
    account     required      pam_unix.so

    password    requisite    pam_passwdqc.so min=disabled,disabled,16,12,8 similar=deny enforce=everyone max=40
    password    sufficient    pam_unix.so try_first_pass use_authtok sha512 shadow remember=10
    password    sufficient    pam_sss.so use_authtok
    password    required      pam_deny.so

    session     optional      pam_mkhomedir.so debug
    session     optional      pam_keyinit.so revoke
    session     required      pam_limits.so
    session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
    session     required      pam_unix.so
    session     optional    pam_ldap.so
    ````

## **STEP 7:** Start NSCD and change the config to avoid caching issues, validating NSCD.

1. By default NSCD is NOT running on ExaCC.
    For LDAP we need to start NSCD and change the config to avoid caching issues.
    The note below is output from Exachk with guidance on how to set the services status.
    Verifying the NSCD configuration ensures the correct configuration when providing cache for the most common name service requests, like passwords, groups, hosts.

    The impact of verifying the NSCD configuration is minimal. While configuring and starting the NSCD can be done without a reboot, a reboot is recommended to prove the configuration is correct and survives a boot procedure.

    NOTE: The recommended NSCD attribute values varying depending upon whether or not the System Security Service Daemon (SSSD) is also in use.

    If the output is not as expected take the following actions as the root userid:

2. If the NSCD is not set for autostart, enable the NSCD to autostart on reboots:

    ````
    systemctl is-enabled nscd.service 2>&1 | tr -cd "[:print:]\n" #command to show if NSCD is enabled for autostart
    systemctl enable nscd.service
    ````

3. The entries for the /etc/nscd.conf file depend upon whether or not SSSD is in use with NSCD. For NSCD without SSSD, the following entries should be present in the /etc/nscd.conf file:

    ````

    enable-cache            passwd          yes
    enable-cache            group           yes
    enable-cache            hosts           yes
    enable-cache            services        yes
    enable-cache            netgroup        no

    ````

    For NSCD with SSSD, the following entries should be present in the /etc/nscd.conf file:

    ````
    enable-cache            passwd          no
    enable-cache            group           no
    enable-cache            hosts           yes
    enable-cache            services        no
    enable-cache            netgroup        no
    ````

    If the values are not as expected, modify the /etc/nscd.conf file.

    ````
    NOTE: the /etc/nscd.conf file can be edited with the "vi" editor.
    NOTE: these attributes are spread throughout the /etc/nscd.conf file, at the head of other attributes that pertain to each cache. They are not grouped together. For example:

    enable-cache            services        yes
    positive-time-to-live   services        28800
    negative-time-to-live   services        20
    suggested-size          services        211
    check-files             services        yes
    persistent              services        yes
    shared                  services        yes
    max-db-size             services        33554432
    ````

4. It is a best practice recommendation to reboot the database server to ensure that the configuration is correct and is persistent across the reboot process.

5. If a reboot is not immediately possible, as a workaround, the service may be started or restarted manually:

    NOTE: there is no output with the stop, start or restart command; check with "is-active".

    ````
    systemctl stop nscd.service
    systemctl is-active nscd.service
    inactive
    systemctl start nscd.service
    systemctl is-active nscd.service
    active
    --Check is the nscd service is enabled to start upon reboot and running. Default is no for both.
    systemctl is-enabled nscd.service
    systemctl is-active nscd.service
    --To enable and start the service 
    systemctl enable nscd.service
    systemctl start nscd.service
    ````

    Do not log off (or reboot) before you verified that you can still connect with ssh key as OCI user.

    To enable sudo you need a file in /etc/sudoers.d. Permissions need to be 440.
    To allow a group called EXADBA to sudo to root you need a line like
    %EXADBA	 ALL=(root)
    Verify the LDAP/AD user existence using "getent" command to make sure the configuration is proper.
    ````
    getent passwd testuser      
    ````
    Verify that you can now connect using LDAP username password.
    Verify that you can still connect as opc using the ssh key.
    If not fix the issue. Worst case backout the changes and restart the services.

## **STEP 8:** Backup procedures.

1. Backup procedures

    If LDAP is not working and you need to backup the changes follow these steps.

    ````
    cd /etc
    cp -p nsswitch.conf.orig nsswitch.conf
    cd /etc/openldap
    cp -p ldap.conf.orig ldap.conf
    cd /etc/sssd
    mv sssd.conf sssd.conf.ldap
    service sssd restart
    cd /etc/ssh 
    cp -p sshd_config.orig sshd_config
    service sshd restart
    cd /etc/pam.d
    cp -p password-auth.orig password-auth
    ````

    Do NOT log off as root before you proven that you can connect as opc as a misconfiguration may lock your out.

## **STEP 9:** Troubleshooting

1. Troubleshooting
    If you lock your account by mistyping your password you may need to reset it.
    To check the user's failed login attempts as root:
    ````
    pam_tally2 --user testuser
    ````
    To reset a locked-out user:
    ````
    pam_tally2 --reset --user testuser
    ````

    If there is an issue with sudo look at MOS note
    Users can login to a server with their LDAP credentials, but running commands with sudo fails on Oracle Linux 7 with SSSD (Doc ID 2505124.1)
    Add the following line to nslcd.conf:
    ````
    ssl off
    ````
    Restart nslcd and sssd services.
    ````
    service nslcd restart 
    service sssd restart 
    ````

 
