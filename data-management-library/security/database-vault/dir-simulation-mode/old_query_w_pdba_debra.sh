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

sqlplus -s /nolog <<EOF
--
set lines 110
set pages 999
column owner format a24
column table_name format a24
column tablespace_name format a26
--
connect dba_debra/Oracle123@pdb1 
show user
show con_name
select owner, table_name, tablespace_name from dba_tables where table_name = 'DEMO_HR_EMPLOYEES' and owner = 'EMPLOYEESEARCH_PROD';
select count(*) from employeesearch_prod.demo_hr_employees;
--
connect dba_debra/Oracle123@pdb2 
show user
show con_name
select owner, table_name, tablespace_name from dba_tables where table_name = 'DEMO_HR_EMPLOYEES' and owner = 'EMPLOYEESEARCH_PROD';
select count(*) from employeesearch_prod.demo_hr_employees;
--
EOF



