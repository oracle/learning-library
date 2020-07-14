#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

# generate a log file for our script output
rm 04_redact_nonapp_queries.out 2>&1
exec > >(tee -a 04_redact_nonapp_queries.out) 2>&1

sqlplus system/${DBUSR_PWD}@pdb1 <<EOF
--
set lines 110
set pages 9999
column policy_name format a30
column expression format a40
column enable format a8
column object_owner format a19
column object_name format a20
column column_name format a15
column function_type format a25

select policy_name, expression, enable from redaction_policies;
select object_owner, object_name, column_name, function_type from redaction_columns;

BEGIN  
  DBMS_REDACT.ALTER_POLICY  (
     OBJECT_SCHEMA => 'EMPLOYEESEARCH_PROD'
    ,object_name => 'DEMO_HR_EMPLOYEES'
    ,policy_name => 'PROTECT_EMPLOYEES'
    ,action => DBMS_REDACT.MODIFY_EXPRESSION
    ,expression => 'NOT (SYS_CONTEXT(''USERENV'',''SESSION_USER'') = ''EMPLOYEESEARCH_PROD'' AND SYS_CONTEXT(''USERENV'',''OS_USER'') = ''oracle'' AND SYS_CONTEXT(''USERENV'',''MODULE'') = ''JDBC Thin Client'' AND SYS_CONTEXT(''USERENV'',''HOST'') = ''dbsec-lab'' )'); 
END; 
/
--
select policy_name, expression, enable from redaction_policies;
select object_owner, object_name, column_name, function_type from redaction_columns;
--
EOF

