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
echo "Enable Native Network Encryption in REQUESTED mode in \$ORACLE_HOME/network/admin/sqlnet.ora"
echo

sed -i '/SQLNET.ENCRYPTION_SERVER/d' ${ORACLE_HOME}/network/admin/sqlnet.ora
echo -e "\nSQLNET.ENCRYPTION_SERVER=REQUESTED" >> ${ORACLE_HOME}/network/admin/sqlnet.ora

echo 
echo "Display the new contents of the sqlnet.ora:"
echo
cat ${ORACLE_HOME}/network/admin/sqlnet.ora

echo
