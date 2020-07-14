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
column ols_read_label format a40
column ols_write_label format a40
column label_to_char format a40
column country format a25

prompt connect crm/Oracle123@pdb1
connect crm/Oracle123@pdb1
prompt
show user;

prompt
prompt select count(*) customer_count from crm.customers;
select count(*) customer_count from crm.customers;

prompt select sa_session.read_label('OLS_CRM_DEMO') OLS_READ_LABEL, sa_session.write_label('OLS_CRM_DEMO') OLS_WRITE_LABEL from dual;
select sa_session.read_label('OLS_CRM_DEMO') OLS_READ_LABEL, sa_session.write_label('OLS_CRM_DEMO') OLS_WRITE_LABEL from dual;

prompt select olslabel, label_to_char(olslabel) label_to_char, count(*) count_of_labels from crm.customers 
prompt group by olslabel, label_to_char(olslabel) 
prompt order by 1;
prompt

select olslabel, label_to_char(olslabel) label_to_char, count(*) count_of_labels 
  from crm.customers 
 group by olslabel, label_to_char(olslabel) 
 order by 1;
 
prompt
prompt select country, count(*) count_of_each, olslabel, label_to_char(olslabel) label_to_char from crm.customers
prompt group by olslabel, label_to_char(olslabel), country
prompt order by country;
prompt 

select country, count(*) count_of_each, olslabel, label_to_char(olslabel) label_to_char
  from crm.customers
 group by olslabel, label_to_char(olslabel), country
 order by country;

EOF
