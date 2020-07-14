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

------------------------------------------------------------------------
prompt Create the LBAC_SUPER user 
prompt Grant it CONNECT, RESOURCE, DBA, and LBAC_DBA
prompt
alter session set container=pdb1;
create user lbac_super identified by Oracle123;
grant connect, resource, dba, lbac_dba to lbac_super;
grant select_catalog_role to lbac_super;
grant unlimited tablespace to lbac_super;

prompt connect lbac_super/Oracle123@pdb1
prompt
connect lbac_super/Oracle123@pdb1

prompt Count rows in CRM.CUSTOMERS
prompt
select count(*) count_of_crm_customers from crm.customers;

prompt Create OLS Policy called OLS_CRM_DEMO
prompt
begin
 LBACSYS.SA_SYSDBA.CREATE_POLICY(
    policy_name => 'OLS_CRM_DEMO'
  , column_name => 'OLSLABEL'
  , default_options => 'READ_CONTROL,WRITE_CONTROL,LABEL_DEFAULT,HIDE');
end;
/

prompt Disable OLS_CRM_DEMO Policy to configure components  
prompt
begin
 LBACSYS.SA_SYSDBA.DISABLE_POLICY(
    policy_name => 'OLS_CRM_DEMO');
end;
/

connect lbac_super/Oracle123@pdb1
prompt Create DEFAULT level
prompt
begin
 LBACSYS.SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'OLS_CRM_DEMO'
  , level_num => 1000
  , short_name => 'D'
   , long_name => 'DEFAULT');
end;
/

prompt Create Global Group
prompt
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1000
 , short_name => 'GBL'
 , long_name => 'GLOBAL'
 , parent_name => null);
end;
/

prompt Create USA group under Global
prompt
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1100
 , short_name => 'USA'
 , long_name => 'USA'
 , parent_name => 'GBL');
end;
/

prompt Create EMEA group as a child of GLOBAL
prompt
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1300
 , short_name => 'EMEA'
 , long_name => 'EMEA'
 , parent_name => 'GBL');
end;
/

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

prompt Create Japan group under EMEA
begin
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_CRM_DEMO'
 , group_num => 1330
 , short_name => 'JPN'
 , long_name => 'JAPAN'
 , parent_name => 'EMEA');
end;
/

--------------------------------------------------------------------------------------------
connect lbac_super/Oracle123@pdb1
prompt Create User/Data Label for DEFAULT
prompt
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '1000',
  label_value     => 'D',
  data_label      => TRUE);
END;
/


prompt Create User/Data Label for D::GBL
prompt
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '8000',
  label_value     => 'D::GBL',
  data_label      => TRUE);
END;
/

prompt Create User/Data Label for D::USA
prompt
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '4000',
  label_value     => 'D::USA',
  data_label      => TRUE);
END;
/

prompt Create User/Data Label for D::EMEA
prompt
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '6000',
  label_value     => 'D::EMEA',
  data_label      => TRUE);
END;
/

prompt Create User/Data Label for D::ENG
prompt
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '6500',
  label_value     => 'D::ENG',
  data_label      => TRUE);
END;
/

prompt Create User/Data Label for D::FRA
prompt
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '6600',
  label_value     => 'D::FRA',
  data_label      => TRUE);
END;
/

prompt Create User/Data Label for D::JPN
prompt
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '6800',
  label_value     => 'D::JPN',
  data_label      => TRUE);
END;
/

select * from all_sa_labels;

--------------------------------------------------------------------------------------------
BEGIN
   SA_USER_ADMIN.SET_USER_LABELS(
       policy_name => 'OLS_CRM_DEMO'
      ,user_name =>   'CRM'
      ,max_read_label => 'D::GBL'
   );
END;
/

select * From all_sa_users;

--------------------------------------------------------------------------------------------

begin
 SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
   policy_name => 'OLS_CRM_DEMO'
 , schema_name =>'CRM'
 , table_name =>'CUSTOMERS');
end;
/

select * from ALL_SA_TABLE_POLICIES;

--------------------------------------------------------------------------------------------
select country, count(*) 
  from crm.customers 
 where country = 'England' 
 group by country 
 order by 1;

update crm.customers 
   set olslabel = char_to_label('OLS_CRM_DEMO','D::ENG') 
 where country = 'England';

select olslabel, label_to_char(olslabel) label_to_char, count(*) count_of_labels 
  from crm.customers 
 group by olslabel, label_to_char(olslabel) 
 order by 1;
--------------------------------------------------------
select country, count(*) 
  from crm.customers 
 where country = 'United States' 
 group by country 
 order by 1;

update crm.customers 
   set olslabel = char_to_label('OLS_CRM_DEMO','D::USA') 
 where country = 'United States';

select olslabel, label_to_char(olslabel) label_to_char, count(*) count_of_labels 
  from crm.customers 
 group by olslabel, label_to_char(olslabel) 
 order by 1;
--------------------------------------------------------
select country, count(*) 
  from crm.customers 
 where country = 'France' 
 group by country 
 order by 1;

update crm.customers 
   set olslabel = char_to_label('OLS_CRM_DEMO','D::FRA') 
 where country = 'France';

select olslabel, label_to_char(olslabel) label_to_char, count(*) count_of_labels 
  from crm.customers 
 group by olslabel, label_to_char(olslabel) 
 order by 1;
--------------------------------------------------------
select country, count(*) 
  from crm.customers 
 where country = 'Japan' 
 group by country 
 order by 1;

update crm.customers 
   set olslabel = char_to_label('OLS_CRM_DEMO','D::JPN') 
 where country = 'Japan';

select olslabel, label_to_char(olslabel) label_to_char, count(*) count_of_labels 
  from crm.customers 
 group by olslabel, label_to_char(olslabel) 
 order by 1;
--------------------------------------------------------

connect lbac_super/Oracle123@pdb1

begin
 LBACSYS.SA_SYSDBA.ENABLE_POLICY(
    policy_name => 'OLS_CRM_DEMO');
end;
/

--------------------------------------------------------------------------------------------

EOF
