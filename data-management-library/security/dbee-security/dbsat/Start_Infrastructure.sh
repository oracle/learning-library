#!/bin/bash

#
# Script: Start_Infrastructure.sh
#

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

# This script dir may vary from script to script, depending on where the necessary files are located

# Script Dir
SCRIPT_DIR=$DBSEC_ADMIN

# Start DB
$SCRIPT_DIR/start_cdb.sh


echo
echo
read -p "Press enter to close"

