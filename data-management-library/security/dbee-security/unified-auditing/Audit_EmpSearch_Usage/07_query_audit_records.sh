#!/bin/bash

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

echo
echo "View the Audit records generated..."
echo

sqlplus -s -l sys/${DBUSR_PWD}@${PDB_NAME} as sysdba<<EOF
--
prompt 
show con_name
show user;
set serveroutput on;
set echo on;
set lines 140
set pages 9999
--
column event_timestamp format a31
column os_username format a12
column userhost format a20
column dbusername format a20
column client_program_name format a33
column action_name format a12
column object_schema format a20
column object_name format a20
column sql_text format a50 word_wrapped
--
prompt
prompt select event_timestamp, os_username, userhost, dbusername, client_program_name, action_name, return_code, object_schema, object_name, sql_text 
prompt   from unified_audit_trail 
prompt  where UNIFIED_AUDIT_POLICIES like '%AUDIT_EMPLOYEESEARCH_USAGE%'
prompt  order by 1;
--
select event_timestamp, os_username, userhost, dbusername, client_program_name, action_name, return_code, object_schema, object_name, sql_text 
  from unified_audit_trail 
 where UNIFIED_AUDIT_POLICIES like '%AUDIT_EMPLOYEESEARCH_USAGE%'
 order by 1;
--
EOF

