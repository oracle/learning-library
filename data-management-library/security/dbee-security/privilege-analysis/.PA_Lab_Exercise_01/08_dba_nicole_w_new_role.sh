#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

echo
echo
echo

$ORACLE_HOME/bin/sqlplus /nolog <<EOF

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TAB OFF
SET PAGESIZE 100

spool Step_8_DBA_NICOLE_w_New_Role.out

conn DBA_Nicole/Oracle123@pdb1;

select * from session_roles order by 1;
select * from session_privs order by 1;

drop table plan_table;
drop table chained_rows;

set echo off;
@$ORACLE_HOME/rdbms/admin/utlxplan.sql

explain plan set statement_id = 'Raise Salary in Tokyo' into plan_table for update HR.employees set salary = salary * 1.1 where department_id = (select department_id from HR.departments where location_id = 1200);

@$ORACLE_HOME/rdbms/admin/utlchain.sql

set echo on;
analyze table HR.employees list chained rows into chained_rows;

connect dba_nicole/Oracle123@pdb1


select FIRSTNAME, LASTNAME, EMAIL, PHONEMOBILE, STARTDATE,LOCATION from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES where USERID = 101 order by LASTNAME;
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where USERID = 101;
select LASTNAME, FIRSTNAME, EMAIL from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES where manager_id = 101 order by 2;
select count(*) From user_tables;
select count(*) from user_objects;
select USERID, MEMBER_ID, BONUS_AMOUNT from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where rownum < 11 order by 1;
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where rownum < 10 order by 1;


EOF
