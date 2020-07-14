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

echo
echo "Generate a sample workload..."
echo

sqlplus -s / as sysdba <<EOF

--
-- PA_Workload.sql
--

connect dba_harvey/${DBUSR_PWD}@${PDB_NAME}
select sysdate from dual;
select count(*) From v\$session;
select count(*) from gv\$instance;
select count(*) from v\$process;
select sessions_max, sessions_current, sessions_highwater, users_max from v\$license;
select b.paddr , b.name nme, b.description descr, to_char(b.error) cerror from  v\$bgprocess b, v\$process p where  b.paddr = p.addr;
select sequence#, group# first_change# first_time, archived, bytes from v\$log order by sequence#, group#;
select sum(getmisses)/sum(gets)*100 dictcache from v\$rowcache;
select sum(reloads)/sum(pins) *100 libcache from v\$librarycache;
select * from v\$log;
select * from v\$parameter where name like '%optimizer_index%';
select owner, table_name from dba_tables where table_name like 'EMP%';
select * from dba_users where username = 'PU_PETE';
select * from dba_role_privs where grantee = 'PU_PETE';

select count(*) From dba_objects;
select count(*) from user_objects;
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES

connect employeesearch_prod/${DBUSR_PWD}@${PDB_NAME}
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES;
select count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_ROLES;
SELECT count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA;
SELECT count(*) from EMPLOYEESEARCH_PROD.DEMO_HR_USERS;


connect dba_debra/${DBUSR_PWD}@${PDB_NAME}
select * from dba_users;
select * from dba_tab_privs where grantee = 'DBA_HARVEY';
select * from dba_users where username = 'DBA_HARVEY';
select * from dba_role_privs where grantee = 'DBA_HARVEY';
select * from dba_tab_privs where grantee = 'DBA_HARVEY';


connect employeesearch_prod/${DBUSR_PWD}@${PDB_NAME}

select FIRSTNAME, LASTNAME, EMAIL, PHONEMOBILE, STARTDATE,LOCATION from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES where USERID = 101 order by LASTNAME;
select * from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where USERID = 101;
select LASTNAME, FIRSTNAME, EMAIL from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES where manager_id = 101 order by 2;
select count(*) From user_tables;
select count(*) from user_objects;
select USERID, MEMBER_ID, BONUS_AMOUNT from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA order by 1;
select * from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where rownum < 10 order by 1;

connect pu_pete/${DBUSR_PWD}@${PDB_NAME}
select USERID, MEMBER_ID, BONUS_AMOUNT from EMPLOYEESEARCH_PROD.DEMO_HR_SUPPLEMENTAL_DATA where rownum < 10 order by 1;
select FIRSTNAME, LASTNAME, EMAIL, PHONEMOBILE, STARTDATE,LOCATION from EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES where USERID = 101 order by LASTNAME;


connect dba_harvey/${DBUSR_PWD}@${PDB_NAME}
select count(*) from unified_audit_trail;
select sysdate from dual;

EOF
