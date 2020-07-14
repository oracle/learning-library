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

spool Step_1_Create_Privilege_Capture_for_DBA_NICOLE.out

conn dbv_acctmgr_pdb1/Oracle123@pdb1;
create user dba_nicole identified by Oracle123;
grant connect to dba_nicole;
conn sys/Oracle123@pdb1 as sysdba;
grant create session, dba to dba_nicole;

conn employeesearch_prod/Oracle123@pdb1

grant select on employeesearch_prod.demo_hr_employees to DBA_NICOLE;
grant select on employeesearch_prod.demo_hr_supplemental_data to DBA_NICOLE;
grant select on employeesearch_prod.demo_hr_users to DBA_NICOLE;

connect dba_harvey/Oracle123@pdb1 

grant select on employeesearch_prod.demo_hr_employees to DBA_NICOLE;
grant select on employeesearch_prod.demo_hr_supplemental_data to DBA_NICOLE;
grant select on employeesearch_prod.demo_hr_users to DBA_NICOLE;


conn DBA_Nicole/Oracle123@pdb1;
drop table chained_rows;
drop table plan_table;

conn DBA_Debra/Oracle123@pdb1;

begin
	dbms_privilege_capture.disable_capture(
	name 		=> 'DBA_Tuning_Privilege_Analysis');
end;
/

begin
	dbms_privilege_capture.drop_capture(
	name 		=> 'DBA_Tuning_Privilege_Analysis');
end;
/

begin
	dbms_privilege_capture.create_capture(
	name 		=> 'DBA_Tuning_Privilege_Analysis'
	, type		=> dbms_privilege_capture.g_context
	, condition	=> 'sys_context(''USERENV'',''SESSION_USER'') = ''DBA_NICOLE''');
end;
/

begin
	dbms_privilege_capture.enable_capture(
	name 		=> 'DBA_Tuning_Privilege_Analysis');
end;
/
EOF



