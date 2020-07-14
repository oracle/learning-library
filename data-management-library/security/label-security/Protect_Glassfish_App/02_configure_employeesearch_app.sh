#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null
 

#02_configure_employeesearch_app.sh

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1


$ORACLE_HOME/bin/sqlplus -s /nolog << EOF

set trimspool on;

set lines 180
set pages 999

set echo on;

show user;

connect employeesearch_prod/Oracle123@pdb1

prompt make sure we remove our demo users so we can start fresh

delete from employeesearch_prod.demo_hr_users where userid in ('revans','eu_evan','can_candy');
delete from employeesearch_prod.demo_hr_user_labels where userid in ('revans','eu_evan','can_candy');

/***************************************************************************/

-- Create our User Labels table so we can set the label for our app users when they login
-- 

connect employeesearch_prod/Oracle123@pdb1

-- Create our User Labels table so we can use it for our app user when they login
prompt Create our User Labels table so we can use it for our app user when they login

drop table employeesearch_prod.demo_hr_user_labels;

create table employeesearch_prod.demo_hr_user_labels
(userid    VARCHAR2(128) NOT NULL
,olslabel   VARCHAR2(128) NOT NULL);

alter table employeesearch_prod.demo_hr_user_labels add primary key (userid);

-- Insert all users from DEMO_HR_USERS into our DEMO_HR_USER_LABELS table and give them 'P' as their label
prompt Insert all users from DEMO_HR_USERS into our DEMO_HR_USER_LABELS table and give them 'P' as their label
insert into employeesearch_prod.demo_hr_user_labels (userid,olslabel) select distinct userid, 'P' from employeesearch_prod.demo_hr_users order by 1;

-- Create our demo users 
prompt Create our demo users within the HR APP table

-- Insert our Canadian Lady...

insert into employeesearch_prod.demo_hr_users 
  values ('can_candy','Oracle123','CAN','Candy','can.candy@oracle.com','ENABLE',sysdate-30,sysdate);

insert into employeesearch_prod.demo_hr_roles
	values ('can_candy','SELECT');

insert into DEMO_HR_USER_LABELS values ('can_candy','P::CAN');

-- Insert our EU dude...
insert into employeesearch_prod.demo_hr_users 
  values ('eu_evan','Oracle123','EU','Evan','eu.evan@oracle.com','ENABLE',sysdate-30,sysdate);

insert into employeesearch_prod.demo_hr_roles
	values ('eu_evan','SELECT');

insert into employeesearch_prod.demo_hr_roles
	values ('eu_evan','CORPORATE');

insert into employeesearch_prod.demo_hr_roles
	values ('eu_evan','INSERT');

delete from demo_hr_roles where userid = 'eu_evan' and roleid = 'ENGINEERING';

insert into employeesearch_prod.DEMO_HR_USER_LABELS values ('eu_evan','P::EU');


-- Make all of our HR App Users have "Public" access level
prompt Make all of our HR App Users have "Public" access level
update employeesearch_prod.demo_hr_user_labels set olslabel = 'P';

-- set the OLSLABEL for hradmin, eu_evan, and can_candy in our DEMO_HR_USER_LABELS table
prompt set the OLSLABEL for hradmin, eu_evan, and can_candy in our DEMO_HR_USER_LABELS table
update employeesearch_prod.demo_hr_user_labels set olslabel = 'HC::GBL' where userid = 'hradmin';
update employeesearch_prod.demo_hr_user_labels set olslabel = 'P::EU' where userid = 'eu_evan';
update employeesearch_prod.demo_hr_user_labels set olslabel = 'P::CAN' where userid = 'can_candy';

commit;

-- create our error log table...
prompt create our error log table...

drop table employeesearch_prod.demo_hr_error_log;

create table employeesearch_prod.demo_hr_error_log (userid varchar2(128) not null, olslabel  varchar2(120), login_timestamp timestamp);

/***************************************************************************/

-- Create procedure to set our labels 
-- This should be updated to accept p_policy_name too so we can pass the policy name dynamically
prompt Create our employeesearch_prod.SET_APP_USER_LABEL procedure

connect employeesearch_prod/Oracle123@pdb1

create or replace procedure set_app_user_label(p_username VARCHAR2)
is

v_username          VARCHAR2(30);
v_olslabel          VARCHAR2(120) := 'P';
v_ols_policy_name   VARCHAR2(60) := 'OLS_DEMO_HR_APP';
v_code              NUMBER;
v_errm              VARCHAR2(128);

begin

select upper(SYS.DBMS_ASSERT.simple_sql_name(p_username))
        into v_username
      from dual;

    DBMS_APPLICATION_INFO.SET_CLIENT_INFO('DEMO_HR_APP');
    DBMS_SESSION.SET_IDENTIFIER(v_username);
    select olslabel into v_olslabel from employeesearch_prod.demo_hr_user_labels where upper(userid) = v_username;

BEGIN
 SA_SESSION.SET_LABEL (
policy_name => 'OLS_DEMO_HR_APP',
label       => v_olslabel);
END;

BEGIN
 SA_SESSION.SET_ROW_LABEL (
policy_name => 'OLS_DEMO_HR_APP',
label       => v_olslabel);
END;

--insert into employeesearch_prod.demo_hr_error_log (userid, olslabel, login_timestamp) values (v_username, v_olslabel, systimestamp);
commit;

end;
/
show errors;

exit;
EOF

