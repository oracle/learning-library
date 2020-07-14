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
prompt
prompt connect lbac_super/Oracle123@pdb1
connect lbac_super/Oracle123@pdb1

prompt
prompt Create User/Data Label for DEFAULT
prompt
prompt BEGIN
prompt  SA_LABEL_ADMIN.CREATE_LABEL  (
prompt   policy_name     => 'OLS_CRM_DEMO',
prompt   label_tag       => '1000',
prompt   label_value     => 'D',
prompt   data_label      => TRUE);
prompt END;;
prompt /

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '1000',
  label_value     => 'D',
  data_label      => TRUE);
END;
/

prompt
prompt Create User/Data Label for D::GBL
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '8000',
  label_value     => 'D::GBL',
  data_label      => TRUE);
END;
/

prompt
prompt Create User/Data Label for D::USA
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '4000',
  label_value     => 'D::USA',
  data_label      => TRUE);
END;
/

prompt
prompt Create User/Data Label for D::EMEA
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '6000',
  label_value     => 'D::EMEA',
  data_label      => TRUE);
END;
/

prompt
prompt Create User/Data Label for D::ENG
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '6500',
  label_value     => 'D::ENG',
  data_label      => TRUE);
END;
/

prompt
prompt Create User/Data Label for D::FRA
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '6600',
  label_value     => 'D::FRA',
  data_label      => TRUE);
END;
/

prompt
prompt Create User/Data Label for D::JPN
prompt
prompt BEGIN
prompt  SA_LABEL_ADMIN.CREATE_LABEL  (
prompt   policy_name     => 'OLS_CRM_DEMO',
prompt   label_tag       => '6800',
prompt   label_value     => 'D::JPN',
prompt   data_label      => TRUE);
prompt END;;
prompt /
prompt
BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_CRM_DEMO',
  label_tag       => '6800',
  label_value     => 'D::JPN',
  data_label      => TRUE);
END;
/

prompt
prompt Show all user/data labels
select * from all_sa_labels;

EOF
