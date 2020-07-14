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

echo "Encrypt all new tablespaces..."
echo "Use a hidden parameter to set all new tablespaces to AES256"
echo

sqlplus -s / as sysdba <<EOF
show parameter encrypt_new_tablespaces
prompt alter system set encrypt_new_tablespaces = 'ALWAYS' scope=both;
alter system set encrypt_new_tablespaces = 'ALWAYS' scope=both;
prompt alter system set "_tablespace_encryption_default_algorithm" = 'AES256' scope = both;
alter system set "_tablespace_encryption_default_algorithm" = 'AES256' scope = both;
show parameter encrypt_new_tablespaces
EOF
