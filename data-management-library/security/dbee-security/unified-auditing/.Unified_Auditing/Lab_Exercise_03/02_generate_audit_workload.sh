#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo 
echo "Generate audit activity..."
echo 

sqlplus -s sys/Oracle123@pdb1 as sysdba << EOF
set lines 180
set pages 9999
col user_name format A10
col policy_name format A10
column event_timestamp format a33
column os_username format a10
column userhost format a25
column dbusername format a20
column DP_TEXT_PARAMETERS1 format a60 word_wrap
column DP_BOOLEAN_PARAMETERS1 format a60 word_wrap
column OBJECT_PRIVILEGES format a20
select count(*) from UNIFIED_AUDIT_TRAIL where unified_audit_policies = 'AUDIT_OUTSIDE_HR_APP' and object_name = 'DEMO_HR_EMPLOYEES';

show user;
select count('AS SYSDBA') from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES;

connect hr/hr@pdb1
show user;
select count('AS HR') from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES;

connect employeesearch_prod/${DBUSR_PWD}@pdb1
show user;
select count('AS EMPLOYEESEARCH_PROD') from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES;

connect dba_debra/Oracle123@pdb1 
show user;
select count('AS DBA_DEBRA') from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES;

connect sys/Oracle123@pdb1 as sysdba
show user;
--EXEC DBMS_AUDIT_MGMT.FLUSH_UNIFIED_AUDIT_TRAIL;

select count(*) from UNIFIED_AUDIT_TRAIL where unified_audit_policies = 'AUDIT_OUTSIDE_HR_APP' and object_name = 'DEMO_HR_EMPLOYEES';
select EVENT_TIMESTAMP, OS_USERNAME, USERHOST, DBUSERNAME, SQL_TEXT, OBJECT_PRIVILEGES, ROLE from UNIFIED_AUDIT_TRAIL where unified_audit_policies = 'AUDIT_OUTSIDE_HR_APP' and object_name = 'DEMO_HR_EMPLOYEES';

exit;
EOF
