#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo
echo "View the Audit from Data Pump..."
echo

sqlplus -s sys/${DBUSR_PWD}@${PDB_NAME} as sysdba << EOF
--
set lines 180
set pages 9999
--
column user_name format A20
column policy_name format A20
column entity_name format a20
--
column os_username format a10
column userhost format a25
column dbusername format a20
column action_name format a15
column DP_TEXT_PARAMETERS1 format a60 word_wrap
column DP_BOOLEAN_PARAMETERS1 format a60 word_wrap
column entity_name format a20
column audit_type format a20
column event_timestamp format a34
column client_program_name format a24
--
select * from AUDIT_UNIFIED_ENABLED_POLICIES where POLICY_NAME like '%DP%';
--
select audit_type, dbusername, client_program_name, event_timestamp, action_name, return_code
  from  UNIFIED_AUDIT_TRAIL where (AUDIT_TYPE = 'Datapump' or ACTION_NAME = 'EXPORT');
--
EOF
