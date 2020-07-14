#!/bin/bash

#01_setup_ols_environment.sh

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

$ORACLE_HOME/bin/sqlplus -s / as sysdba << EOF
--
set trimspool on;
set lines 180
set pages 999
--
column osuser format a18
column machine format a25
colum program format a35
--
set echo on;
--connect c##dvacctmgr/Oracle123
show user;
alter user lbacsys identified by Oracle123 account unlock container=all;

column pdb_name format a12
column name format a25
column description format a40
column status format a12
select a.name pdb_name, b.name, b.status, b.description from v$containers a, cdb_ols_status b where a.con_id = b.con_id

EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;

shutdown immediate;
startup;
alter pluggable database all open;

select a.name pdb_name, b.name, b.status, b.description from v$containers a, cdb_ols_status b where a.con_id = b.con_id


connect sys/Oracle123@pdb1 as sysdba

grant select_catalog_role to lbacsys;
EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;

connect / as sysdba
alter pluggable database pdb1 close immediate;
alter pluggable database pdb1 open;

show pdbs

connect lbacsys/Oracle123@pdb1

prompt Drop OLS Policy
-- Drop existing policy
begin 
 LBACSYS.SA_SYSDBA.DROP_POLICY(
    policy_name => 'OLS_DEMO_HR_APP',
     drop_column => TRUE);
end;
/

prompt Create Policy
-- Create our OLS Policy "OLS_DEMO_HR_APP" 
-- Protect all DML: READ,INSERT,UPDATE,DELETE 
-- Create a hdiden column named OLSLABEL on any table we control with this policy
begin 
 LBACSYS.SA_SYSDBA.CREATE_POLICY(
    policy_name => 'OLS_DEMO_HR_APP'
  , column_name => 'OLSLABEL'
  , default_options => 'READ_CONTROL,WRITE_CONTROL,LABEL_DEFAULT,HIDE'); 
end;
/

prompt Disable Policy
--
-- Start with our policy disabled so we can label the data that is already in the table
-- DEMO_HR_EMPLOYEES
--
begin
 LBACSYS.SA_SYSDBA.DISABLE_POLICY(
    policy_name => 'OLS_DEMO_HR_APP');
end;
/


/***************************************************************************/
prompt Create Public Level
-- Create our Levels and assign them a number value 
begin 
 LBACSYS.SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'OLS_DEMO_HR_APP'
  , level_num => 1000
  , short_name => 'P'
   , long_name => 'PUBLIC'); 
end;
/

prompt Create Confidential Level
begin 
 LBACSYS.SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'OLS_DEMO_HR_APP'
  , level_num => 3000
  , short_name => 'C'
   , long_name => 'CONFIDENTIAL'); 
end;
/

prompt Create Highly Confidential Level
begin 
 LBACSYS.SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'OLS_DEMO_HR_APP'
  , level_num => 5000
  , short_name => 'HC'
   , long_name => 'HIGHLY CONFIDENTIAL'); 
end;
/

/***************************************************************************/
-- Create Compartments
prompt Create HR compartment
begin 
 LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'OLS_DEMO_HR_APP'
  , comp_num => 100
  , short_name => 'HR'
  , long_name => 'HR'); 
end; 
/

prompt Create FIN compartment
begin 
 LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'OLS_DEMO_HR_APP'
  , comp_num => 200
  , short_name => 'FIN'
  , long_name => 'FINANCE'); 
end; 
/

prompt Create IP compartment
begin 
 LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'OLS_DEMO_HR_APP'
  , comp_num => 300
  , short_name => 'IP'
  , long_name => 'INTELLECTUAL_PROPERTY'); 
end; 
/

prompt Create IT compartment
begin 
 LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'OLS_DEMO_HR_APP'
  , comp_num => 400
  , short_name => 'IT'
  , long_name => 'INFORMATION_TECHNOLOGY'); 
end; 
/

/***************************************************************************/
-- Create Groups
-- Our example is a heiararchy of groups
-- GLOBAL
	-- US
	-- EU
		- GERMANY
	-- CAN
	-- LATAM

prompt Create GBL group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_HR_APP'
 , group_num => 1000
 , short_name => 'GBL'
 , long_name => 'GLOBAL'
 , parent_name => null); 
end; 
/

prompt Create USA group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_HR_APP'
 , group_num => 1100
 , short_name => 'USA'
 , long_name => 'USA'
 , parent_name => 'GBL'); 
end;
/

prompt Create CAN group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_HR_APP'
 , group_num => 1200
 , short_name => 'CAN'
 , long_name => 'CANADA'
 , parent_name => 'GBL'); 
end; 
/

prompt Create EU group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_HR_APP'
 , group_num => 1300
 , short_name => 'EU'
 , long_name => 'EU'
 , parent_name => 'GBL'); 
end;
/

prompt Create GER group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_HR_APP'
 , group_num => 1310
 , short_name => 'GER'
 , long_name => 'GERMANY'
 , parent_name => 'EU'); 
end;
/

prompt Create LTM group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_HR_APP'
 , group_num => 1400
 , short_name => 'LTM'
 , long_name => 'LATAM'
 , parent_name => 'GBL'); 
end; 
/

prompt Set EMPLOYEESERCH to have highest level, all compartments, and GBL group
BEGIN
   SA_USER_ADMIN.SET_USER_LABELS(
       policy_name => 'OLS_DEMO_HR_APP' 
      ,user_name =>   'EMPLOYEESEARCH_PROD'
      ,max_read_label => 'HC:IT,IP,FIN,HR:GBL'
   );
END;
/

prompt create Labels

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_HR_APP',
  label_tag       => '1000',
  label_value     => 'P',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_HR_APP',
  label_tag       => '3000',
  label_value     => 'C',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_HR_APP',
  label_tag       => '5000',
  label_value     => 'HC',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_HR_APP',
  label_tag       => '1100',
  label_value     => 'P::USA',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_HR_APP',
  label_tag       => '1300',
  label_value     => 'P::EU',
  data_label      => TRUE);
END;
/

-- Generate Data Labels for our combinations
prompt Generate Data Labels for our combinations of Levels, Compartments, or Groups

select to_data_label('OLS_DEMO_HR_APP','P') from dual;
select to_data_label('OLS_DEMO_HR_APP','C') from dual;
select to_data_label('OLS_DEMO_HR_APP','HC') from dual;
select to_data_label('OLS_DEMO_HR_APP','P:IT') from dual;
select to_data_label('OLS_DEMO_HR_APP','P:IP') from dual;
select to_data_label('OLS_DEMO_HR_APP','P:HR') from dual;
select to_data_label('OLS_DEMO_HR_APP','P:FIN') from dual;

-- Create HC data labels with groups
prompt create HC data labels with groups
select to_data_label('OLS_DEMO_HR_APP','HC::GBL') from dual;
select to_data_label('OLS_DEMO_HR_APP','HC::USA') from dual;
select to_data_label('OLS_DEMO_HR_APP','HC::EU') from dual;
select to_data_label('OLS_DEMO_HR_APP','HC::GER') from dual;
select to_data_label('OLS_DEMO_HR_APP','HC::CAN') from dual;
select to_data_label('OLS_DEMO_HR_APP','HC::LTM') from dual;

-- Create Public data labels with groups
prompt create HC data labels with groups
select to_data_label('OLS_DEMO_HR_APP','P::GBL') from dual;
select to_data_label('OLS_DEMO_HR_APP','P::USA') from dual;
select to_data_label('OLS_DEMO_HR_APP','P::EU') from dual;
select to_data_label('OLS_DEMO_HR_APP','P::GER') from dual;
select to_data_label('OLS_DEMO_HR_APP','P::LTM') from dual;
select to_data_label('OLS_DEMO_HR_APP','P::CAN') from dual;

prompt create EMPLOYEESEARCH_PROD data labels with everything
select to_data_label('OLS_DEMO_HR_APP','HC:IT,FIN,HR,IP:GBL,USA,EU,GER,LTM,CAN') from dual;

prompt create EMPLOYEESEARCH_PROD data labels with everything
select to_data_label('OLS_DEMO_HR_APP','HC:IT,FIN,HR,IP:GBL') from dual;

-- Set the User Labels
prompt Set Levels for EMPLOYEESEARCH_PROD
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'OLS_DEMO_HR_APP',
  user_name     => 'EMPLOYEESEARCH_PROD', 
  max_level     => 'HC',
  min_level     => 'P',
  def_level     => 'HC',
  row_level     => 'HC');
END;
/

prompt Set Group for EMPLOYEESEARCH_PROD
BEGIN
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'OLS_DEMO_HR_APP',
  user_name     => 'EMPLOYEESEARCH_PROD', 
  READ_GROUPS   => 'GBL',
  WRITE_GROUPS  => 'GBL',
  DEF_GROUPS    => 'GBL',
  ROW_GROUPS    => 'GBL');
END;
/

-- Give EMPLOYEESEARCH_PROD NULL privileges on OLS controlled objects

prompt Make sure EMPLOYEESEARCH_PROD has NULL privileges on OLS controlled objects
prompt Other options include FULL which would bypass OLS but we do not want that here

BEGIN
 SA_USER_ADMIN.SET_USER_PRIVS(
  policy_name   => 'OLS_DEMO_HR_APP',
  user_name     => 'EMPLOYEESEARCH_PROD', 
  privileges    => null);
END;
/

spool off

exit;
EOF
