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
column label_to_char format a20
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
prompt
prompt connect lbac_super/Oracle123@pdb1
connect lbac_super/Oracle123@pdb1

prompt
prompt Total rows in CRM.CUSTOMERS
select count(*) from crm.customers;

--------------------------------------------------------------------------------------------
prompt
prompt Label data from England
select country, count(*) 
  from crm.customers 
 where country = 'England' 
 group by country 
 order by 1;

prompt
prompt Update CRM.CUSTOMERS table to label English customers with D::ENG
prompt
prompt update crm.customers 
prompt    set olslabel = to_data_label('OLS_CRM_DEMO','D::ENG') 
prompt  where country = 'England';
prompt
update crm.customers 
   set olslabel = to_data_label('OLS_CRM_DEMO','D::ENG') 
 where country = 'England';

prompt
prompt Show results
select olslabel, label_to_char(olslabel) label_to_char, count(*) count_of_labels 
  from crm.customers 
 group by olslabel, label_to_char(olslabel) 
 order by 1;
--------------------------------------------------------
prompt 

EOF
