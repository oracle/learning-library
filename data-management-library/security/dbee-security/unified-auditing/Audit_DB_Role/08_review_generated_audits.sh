#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

sqlplus -s sys/${DBUSR_PWD}@${PDB_NAME} as sysdba << EOF
prompt
show con_name
show user
--
prompt

--
set echo on
set lines 180
set pages 9999
--
column action_name format a20
column unified_audit_policies format a30
column object_name format a20
column object_schema format a10
column audit_type format a15
column dbusername format a10
column audit_option format a30
--
prompt select action_name, dbusername, action_name, OBJECT_SCHEMA, object_name, SQL_TEXT 
prompt   from unified_audit_trail 
prompt  where unified_audit_policies like '%AUD_DBA_POL%'
prompt     or unified_audit_policies like '%AUD_ROLE_POL%'
prompt  order by event_timestamp desc;
prompt
select action_name, dbusername, action_name, OBJECT_SCHEMA, object_name, SQL_TEXT 
  from unified_audit_trail 
 where unified_audit_policies like '%AUD_DBA_POL%'
    or unified_audit_policies like '%AUD_ROLE_POL%'
 order by event_timestamp desc;
--
prompt
EOF
