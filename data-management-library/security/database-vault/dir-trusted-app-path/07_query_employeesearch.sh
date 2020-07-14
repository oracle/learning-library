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

$ORACLE_HOME/bin/sqlplus -l employeesearch_prod/Oracle123@pdb1 << EOF


set trimspool on;

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

set echo on;

show user;

desc employeesearch_prod.demo_hr_employees;

set lines 180

select userid, firstname, lastname, emptype, position, location, ssn, sin, nino
  from employeesearch_prod.demo_hr_employees
 where rownum < 10;

exit;
EOF

