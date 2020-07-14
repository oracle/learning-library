#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

#
# Script: 09_remove_nne.sh
#

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

# Script Dir
SCRIPT_DIR=$DBSEC_HOME/workshops/dbsec/network_encryption

echo 
echo "Existing sqlnet.ora file:"
cat ${ORACLE_HOME}/network/admin/sqlnet.ora

# Return the sqlnet.ora file to it's original state:
echo 
echo "Remove SQLNET.ENCRYPTION_SERVER line..."
sed -i '/SQLNET.ENCRYPTION_SERVER/d' ${ORACLE_HOME}/network/admin/sqlnet.ora

echo 
echo "New sqlnet.ora file:"
cat ${ORACLE_HOME}/network/admin/sqlnet.ora

echo
read -p "Press enter to close"
