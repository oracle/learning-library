#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

. $DBSEC_ADMIN/cdb.env 

$ORACLE_HOME/bin/sqlplus -s sys/Oracle123@pdb1 as sysdba << EOF

set echo on;
spool 02_Operations_as_SYSDBA_before_DV_Realms.out

show user;

desc employeesearch_prod.demo_hr_employees;

col userid format a10
col firstname format a20
col lastname format a20

select userid, firstname, lastname from employeesearch_prod.demo_hr_employees where rownum < 5;

set autotrace on
select userid, firstname, lastname from employeesearch_prod.demo_hr_employees where rownum < 5;
set autotrace off

create table employeesearch_prod.junk(id number);
drop table employeesearch_prod.junk;

exit;
EOF

