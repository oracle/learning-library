#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

# generate a log file for our script output
rm -f Start_Infrastructure.out
exec > >(tee -a Start_Infrastructure.out) 2>&1

. $DBSEC_ADMIN/scripts/cdb.env

$DBSEC_ADMIN/start_Glassfish.sh

$DBSEC_ADMIN/start_cdb.sh

echo ""
echo ""
read -p "Press enter to close"

