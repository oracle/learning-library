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

alter session set container=pdb1;
show con_name;
prompt
show user;

prompt create user crm_brian identified by Oracle123;;
prompt grant connect to crm_brian;;
prompt grant select on crm.customers to crm_brian;;
prompt
@set_off.sql
create user crm_brian identified by Oracle123;
grant connect to crm_brian;
grant select on crm.customers to crm_brian;
@set_on.sql
--
prompt create user crm_pam identified by Oracle123;;
prompt grant connect to crm_pam;;
prompt grant select on crm.customers to crm_pam;;

prompt
@set_off.sql
create user crm_pam identified by Oracle123;
grant connect to crm_pam;
grant select on crm.customers to crm_pam;
@set_on.sql

set pages 9999
set lines 125
column ols_read_label format a40
column ols_write_label format a40
column country format a25

prompt connect as crm_brian
connect crm_brian/Oracle123@pdb1
show con_name;
prompt
show user;
prompt
prompt select count(*) customer_count from crm.customers;;
select count(*) customer_count from crm.customers;

prompt
prompt connect as crm_pam
connect crm_pam/Oracle123@pdb1
show con_name;
prompt
show user;
prompt
prompt select count(*) customer_count from crm.customers;;
select count(*) customer_count from crm.customers;
EOF
