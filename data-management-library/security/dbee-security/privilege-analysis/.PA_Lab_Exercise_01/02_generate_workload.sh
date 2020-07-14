#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

#
# Script: Step_2_Execute_Explain_Plan_as_DBA_NICOLE.sh
#

$ORACLE_HOME/bin/sqlplus /nolog <<EOF

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TAB OFF
SET PAGESIZE 100

spool Step_2_Generate_Workload.out

set echo off;
conn DBA_Nicole/Oracle123@pdb1;

@$ORACLE_HOME/rdbms/admin/utlxplan.sql

explain plan set statement_id = 'Raise Salary in Tokyo' into plan_table for update HR.employees set salary = salary * 1.1 where department_id = (select department_id from HR.departments where location_id = 1200);

@$ORACLE_HOME/rdbms/admin/utlchain.sql

set echo on;
analyze table HR.employees list chained rows into chained_rows;


connect dba_harvey/Oracle123@pdb1
select sysdate from dual;
select count(*) From v\$session;
select count(*) from gv\$instance;
select count(*) from v\$process;
select sessions_max, sessions_current, sessions_highwater, users_max from v\$license;
select b.paddr , b.name nme, b.description descr, to_char(b.error) cerror from  v\$bgprocess b, v\$process p where  b.paddr = p.addr;
select sequence#, group# first_change# first_time, archived, bytes from v\$log order by sequence#, group#;
select sum(getmisses)/sum(gets)*100 dictcache from v\$rowcache;
select sum(reloads)/sum(pins) *100 libcache from v\$librarycache;
select count(*) from v\$log;
select count(*) from v\$parameter where name like '%optimizer_index%';
select owner, table_name from dba_tables where table_name like 'EMP%';
select count(*) from dba_users where username = 'PU_PETE';
select count(*) from dba_role_privs where grantee = 'PU_PETE';

select count(*) From dba_objects;
select count(*) from user_objects;
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES

connect EMPLOYEESEARCH_PROD/Oracle123@pdb1
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES;
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_ROLES;
SELECT count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA;
SELECT count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_USERS;


connect dba_debra/Oracle123@pdb1
select count(*) from dba_users;
select count(*) from dba_tab_privs where grantee = 'DBA_HARVEY';
select count(*) from dba_users where username = 'DBA_HARVEY';
select count(*) from dba_role_privs where grantee = 'DBA_HARVEY';
select count(*) from dba_tab_privs where grantee = 'DBA_HARVEY';


connect dba_nicole/Oracle123@pdb1


select FIRSTNAME, LASTNAME, EMAIL, PHONEMOBILE, STARTDATE,LOCATION from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES where USERID = 101 order by LASTNAME;
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where USERID = 101;
select LASTNAME, FIRSTNAME, EMAIL from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES where manager_id = 101 order by 2;
select count(*) From user_tables;
select count(*) from user_objects;
select USERID, MEMBER_ID, BONUS_AMOUNT from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where rownum < 11 order by 1;
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where rownum < 10 order by 1;

connect pu_pete/Oracle123@pdb1
select USERID, MEMBER_ID, BONUS_AMOUNT from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where rownum < 10 order by 1;
select FIRSTNAME, LASTNAME, EMAIL, PHONEMOBILE, STARTDATE,LOCATION from EMPLOYEESEARCH.DEMO_HR_EMPLOYEES where USERID = 101 order by LASTNAME;


connect dba_harvey/Oracle123@pdb1
select count(*) from unified_audit_trail;
select sysdate from dual;

EOF

