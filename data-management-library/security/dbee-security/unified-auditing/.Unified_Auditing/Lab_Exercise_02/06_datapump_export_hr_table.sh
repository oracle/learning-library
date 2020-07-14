#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

echo
echo "Create a DB Directory and grant read,write to SYSTEM..."
echo

export current_dir=`pwd`

sqlplus -s / as sysdba <<EOF
alter session set container=pdb1;

create or replace directory DATA_FILE_DIR as '${current_dir}';
grant read,write on directory DATA_FILE_DIR to system;
EOF

echo
echo "Perform a Data Pump Export as a user authorized..."
echo

expdp system/Oracle123@pdb1 dumpfile=HR_table.dmp DIRECTORY=DATA_FILE_DIR tables=EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES reuse_dumpfiles=y

echo
echo "Attempt a Data Pump Export as a user who is not authorized..."
echo

expdp dbsat_admin/Oracle123@pdb1 dumpfile=steal_data DIRECTORY=DATA_FILE_DIR tables=EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES reuse_dumpfiles=y
