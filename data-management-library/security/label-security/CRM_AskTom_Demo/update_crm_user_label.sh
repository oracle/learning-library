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
set lines 165
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
column user_name format a12
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
prompt Show Existing User Labels
select * From all_sa_users;

prompt
prompt Add FGT to the CRM User Label so it is now D:FGT:GBL
prompt
prompt BEGIN
prompt    SA_USER_ADMIN.SET_USER_LABELS(
prompt        policy_name => 'OLS_CRM_DEMO'
prompt       ,user_name =>   'CRM'
prompt       ,max_read_label => 'D:FGT:GBL'
prompt       ,max_write_label => 'D:FGT:GBL'
prompt       ,min_write_label => 'D'
prompt       ,def_label => 'D::GBL'
prompt       ,row_label => 'D::GBL'
prompt    );
prompt END;;
prompt /

BEGIN
   SA_USER_ADMIN.SET_USER_LABELS(
       policy_name => 'OLS_CRM_DEMO'
      ,user_name =>   'CRM'
      ,max_read_label => 'D:FGT:GBL'
      ,max_write_label => 'D:FGT:GBL'
      ,min_write_label => 'D'
      ,def_label => 'D::GBL'
      ,row_label => 'D::GBL'
   );
END;
/

prompt
prompt Show Updated User Labels
select * From all_sa_users;

------------------------------------------------------------------------

EOF
