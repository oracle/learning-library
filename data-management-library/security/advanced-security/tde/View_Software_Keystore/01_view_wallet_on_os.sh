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
echo "To view the contents of the wallet run the following OS command..."
echo

WALLET_DIR=/etc/ORACLE/WALLETS/$ORACLE_SID

ls -al $WALLET_DIR/tde

echo
orapki wallet display -wallet $WALLET_DIR/tde -pwd $DBUSR_PWD

