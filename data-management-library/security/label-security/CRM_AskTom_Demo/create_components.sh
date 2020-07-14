#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

sqlplus -s / as sysdba <<EOF

set echo on
set serveroutput on
set pages 9999
set lines 125
------------------------------------------------------------------------
column ols_read_label format a40
column ols_write_label format a40
column label_to_char format a40
column country format a25
column policy_name format a13
column schema_name format a12
column table_name format a11
column table_options format a35
column function format a20
column predicate format a20
column user_name format a9
column USER_PRIVILEGES format a15
column MAX_READ_LABEL format a14
column MAX_WRITE_LABEL format a15
column MIN_WRITE_LABEL format a15
column DEFAULT_READ_LABEL format a18
column DEFAULT_ROW_LABEL format a17
column DEFAULT_WRITE_LABEL format a19
column LABEL format a30
column short_name format a10
column long_name format a20
column COLUMN_NAME format a10
column POLICY_OPTIONS format a85

------------------------------------------------------------------------
prompt
prompt connect lbac_super/Oracle123@pdb1
connect lbac_super/Oracle123@pdb1
set lines 140

prompt
prompt Count rows in CRM.CUSTOMERS
select count(*) count_of_crm_customers from crm.customers;

prompt
prompt Create OLS Policy called OLS_CRM_DEMO
begin
 LBACSYS.SA_SYSDBA.CREATE_POLICY(
    policy_name => 'OLS_CRM_DEMO'
  , column_name => 'OLSLABEL'
  , default_options => 'READ_CONTROL,WRITE_CONTROL,LABEL_DEFAULT,HIDE');
end;
/

prompt
prompt Disable OLS_CRM_DEMO Policy to configure components  
begin
 LBACSYS.SA_SYSDBA.DISABLE_POLICY(
    policy_name => 'OLS_CRM_DEMO');
end;
/

connect lbac_super/Oracle123@pdb1
prompt
prompt Create DEFAULT level
begin
 LBACSYS.SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'OLS_CRM_DEMO'
  , level_num => 1000
  , short_name => 'D'
   , long_name => 'DEFAULT');
end;
/

prompt
prompt Create Global Group
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1000
 , short_name => 'GBL'
 , long_name => 'GLOBAL'
 , parent_name => null);
end;
/

prompt
prompt Create USA group under Global
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1100
 , short_name => 'USA'
 , long_name => 'USA'
 , parent_name => 'GBL');
end;
/

prompt
prompt Create EMEA group as a child of GLOBAL
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1300
 , short_name => 'EMEA'
 , long_name => 'EMEA'
 , parent_name => 'GBL');
end;
/

prompt
prompt Create England group under EMEA
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1310
 , short_name => 'ENG'
 , long_name => 'ENGLAND'
 , parent_name => 'EMEA');
end;
/

prompt
prompt Create France group under EMEA
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1320
 , short_name => 'FRA'
 , long_name => 'FRANCE'
 , parent_name => 'EMEA');
end;
/

prompt
prompt Create Japan group under Global
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1330
 , short_name => 'JPN'
 , long_name => 'JAPAN'
 , parent_name => 'GBL');
end;
/

prompt
prompt Show all Policies
select * from all_sa_policies;

prompt
prompt Show all Levels
select * from all_sa_levels;

prompt
prompt Show all Compartments
select * from all_sa_compartments;

prompt
prompt Show all Groups
select * from all_sa_groups;

EOF
