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

# Oracle DB 19c Net Services Administrator's Guide
# 16.2.2 Diagnosing Client Problems

echo 
echo "View what is supported for Network Encryption by the oracle binary."
echo

echo 
echo "Utilize the adapters utility:"
which adapters

echo
echo "The script will navigate to \$ORACLE_HOME/bin and run adapters command."
echo "The output of 'adapters oracle' shows:"
cd $ORACLE_HOME/bin/
adapters oracle

