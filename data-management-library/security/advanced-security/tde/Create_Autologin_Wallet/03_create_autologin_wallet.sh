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
echo "In this step, we will create the auto_login keystore so we do not need to use a password to open our wallet when the database is restarted."
echo "This is extremely useful in a RAC, Data Guard, or Golden Gate environment."
echo

sqlplus -s / as sysdba <<EOF
administer key management create auto_login keystore from keystore '${WALLET_DIR}/tde' identified by Oracle123;

--administer key management add secret 'Oracle123' for client 'HSM_PASSWORD' force keystore identified by Oracle123 with backup;
EOF
