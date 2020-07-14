#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo "Viewing TDE-related init parameters..."
echo " "
sqlplus -s / as sysdba <<EOF
set lines 110
set pages 999
column name format a40
column value format a40
select name, value
 from v\$parameter
where name in ('encrypt_new_tablespaces'
              ,'tde_configuration'
              ,'external_keystore_credential_location'
              ,'wallet_root'
              ,'one_step_plugin_for_pdb_with_tde');
EOF

