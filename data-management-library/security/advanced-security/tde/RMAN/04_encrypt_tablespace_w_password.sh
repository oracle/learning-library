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

echo
echo "Perform an RMAN backup of the EMPDATA_PROD tablespace..."
echo

mkdir -v /tmp/RMAN
rm -rf /tmp/RMAN/empdata_prod_encrypted_password.dbf
echo

rman target sys/Oracle123@pdb1 <<EOF
SET ENCRYPTION IDENTIFIED BY Oracle123 ONLY ON FOR ALL TABLESPACES;
BACKUP FORMAT '/tmp/RMAN/empdata_prod_encrypted_password.dbf' tablespace EMPDATA_PROD;
EOF

echo
echo "View the output of the RMAN backup file..."
echo
ls -al /tmp/RMAN/empdata_prod_encrypted_password.dbf

echo
strings /tmp/RMAN/empdata_prod_encrypted_password.dbf
echo
echo "Press return to exit"
