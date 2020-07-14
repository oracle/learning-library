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
echo "Create a new role for the application"
echo
echo

sqlplus -s -l sys/${DBUSR_PWD}@${PDB_NAME} as sysdba <<EOF

set lines 110
set pages 9999
column role format a30
column external_name format a30
set serveroutput on;
set echo on;
--
create role EMPSEARCH_APP;
--
select * from dba_roles where role = 'EMPSEARCH_APP';
--
EOF

