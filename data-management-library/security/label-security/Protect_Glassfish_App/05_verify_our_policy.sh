#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

#05_verify_our_policy.sh

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1


$ORACLE_HOME/bin/sqlplus -s /nolog << EOF

set trimspool on;

set lines 180
set pages 999

--set echo on;

prompt
prompt Now lets verify our stuff works...
prompt

connect EMPLOYEESEARCH_PROD/Oracle123@pdb1

column OLS_READ_LABEL format a40
column location format a30
column char_label format a40

show user

prompt
prompt First we will clean up the DEMO_HR_ERROR_LOG table so we can see errors if we have them...
prompt

truncate table EMPLOYEESEARCH_PROD.demo_hr_error_log;
select * from EMPLOYEESEARCH_PROD.demo_hr_error_log;

prompt
prompt Before we query based on OLS, lets get an overview of the data we will work with
prompt  (This is all of the rows in DEMO_HR_EMPLOYEES)

select count(*) from EMPLOYEESEARCH_PROD.demo_hr_employees;

prompt
prompt  Here is the distribution of location data
prompt

select location, count(location) count_location
  from EMPLOYEESEARCH_PROD.demo_hr_employees
 group by location
 order by location;

prompt Enable Policy
prompt
--
-- Enable our Policy now that we have labeled data into DEMO_HR_EMPLOYEES
--
connect lbacsys/Oracle123@pdb1
show user
begin
 LBACSYS.SA_SYSDBA.ENABLE_POLICY(
    policy_name => 'OLS_DEMO_HR_APP');
end;
/

connect EMPLOYEESEARCH_PROD/Oracle123@pdb1

prompt
prompt Now lets verify our stuff works...
prompt


-- this is what EMPLOYEESEARCH_PROD sees...
prompt
prompt this is what our DB user, and schema owner, EMPLOYEESEARCH_PROD has for a label...
prompt He should have everything because we want him to be able to see every combination of labels
prompt
select sa_session.read_label('OLS_DEMO_HR_APP') OLS_READ_LABEL from dual;

prompt
prompt
prompt **********************************************************************************
prompt
prompt

-- this is what hradmin sees

prompt
prompt This is what app user HRADMIN sees when we use our procedure to set his label 
prompt  His label is set based on his row value in DEMO_HR_USER_LABELS
prompt

exec EMPLOYEESEARCH_PROD.set_app_user_label('hradmin');

prompt
prompt this is what our app user HRADMIN has for a label...
prompt He should have everything because we want him to be able to see every combination of labels
prompt
select sa_session.read_label('OLS_DEMO_HR_APP') OLS_READ_LABEL from dual;

prompt 
prompt How many rows get returned? It should be every row in the table. 
prompt Does it match the number from the query above? I hope so!
prompt
select count(*) from EMPLOYEESEARCH_PROD.demo_hr_employees;

prompt
prompt How many locations can be seen by app user HRADMIN
prompt
select location, count(location) count_location
  from EMPLOYEESEARCH_PROD.demo_hr_employees
 group by location
 order by location;

prompt 
prompt How many distinct OLSLABELS, and the varchar translation, are accessible
prompt
select distinct olslabel, label_to_char(olslabel) char_label from EMPLOYEESEARCH_PROD.demo_hr_employees;

-- this is what eu_evan sees
prompt
prompt This is what App User EU_EVAN sees when we use our procedure to set his label 
prompt  His label is set based on his row value in DEMO_HR_USER_LABELS
prompt

exec EMPLOYEESEARCH_PROD.set_app_user_label('eu_evan');
select sa_session.read_label('OLS_DEMO_HR_APP') OLS_READ_LABEL from dual;
select count(*) from EMPLOYEESEARCH_PROD.demo_hr_employees;

prompt
prompt How many locations can be seen by app user EU_EVAN
prompt
select location, count(location) count_location
  from EMPLOYEESEARCH_PROD.demo_hr_employees
 group by location
 order by location;

prompt 
prompt How many distinct OLSLABELS, and the varchar translation, are accessible by app user EU_EVAN
prompt  His label is set based on his row value in DEMO_HR_USER_LABELS
prompt
select distinct olslabel, label_to_char(olslabel) char_label from EMPLOYEESEARCH_PROD.demo_hr_employees;

prompt
prompt
prompt **********************************************************************************
prompt
prompt

prompt
prompt
prompt **********************************************************************************
prompt
prompt

-- this is what can_candy sees
prompt
prompt This is what app user CAN_CANDY sees when we use our procedure to set her label 
prompt  Her label is set based on his row value in DEMO_HR_USER_LABELS
prompt

exec EMPLOYEESEARCH_PROD.set_app_user_label('can_candy');
select sa_session.read_label('OLS_DEMO_HR_APP') OLS_READ_LABEL from dual;
select count(*) from EMPLOYEESEARCH_PROD.demo_hr_employees;

prompt
prompt How many locations can be seen by app user CAN_CANDY
prompt
select location, count(location) count_location
  from EMPLOYEESEARCH_PROD.demo_hr_employees
 group by location
 order by location;

prompt 
prompt How many distinct OLSLABELS, and the varchar translation, are accessible by app user CAN_CANDY
prompt
select distinct olslabel, label_to_char(olslabel) char_label from EMPLOYEESEARCH_PROD.demo_hr_employees;

exit;
EOF

