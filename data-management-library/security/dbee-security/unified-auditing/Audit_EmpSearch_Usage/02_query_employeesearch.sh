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

$ORACLE_HOME/bin/sqlplus -s -l employeesearch_prod/${DBUSR_PWD}@${PDB_NAME} << EOF


set lines 100
set pages 999

column firstname format a10
column lastname format a10
column emptype format a9
column position format a16
column location format a11
column ssn format a11
column sin format a11
column nino format a13

prompt 
show con_name
show user;
prompt 
desc employeesearch_prod.demo_hr_employees;

set lines 180
prompt 
prompt select userid, firstname, lastname, emptype, position, location, ssn, sin, nino
prompt   from employeesearch_prod.demo_hr_employees
prompt  where rownum < 10;
prompt 
set echo on
set trimspool on
set serveroutput on
set termout on
select userid, firstname, lastname, emptype, position, location, ssn, sin, nino
  from employeesearch_prod.demo_hr_employees
 where rownum < 10;

exit;
EOF

