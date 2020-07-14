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

set lines 110
set pages 9999

col audit_option format A20
col policy_name format A18
prompt select POLICY_NAME, AUDIT_OPTION, CONDITION_EVAL_OPT from AUDIT_UNIFIED_POLICIES where POLICY_NAME in ('AUD_ROLE_POL','AUD_DBA_POL');
select POLICY_NAME, AUDIT_OPTION, CONDITION_EVAL_OPT from AUDIT_UNIFIED_POLICIES where POLICY_NAME in ('AUD_ROLE_POL','AUD_DBA_POL');
 
col policy_name format A38
col entity_name format A28
column entity_type format a14

prompt select POLICY_NAME, ENABLED_OPTION, ENTITY_NAME, ENTITY_TYPE, SUCCESS, FAILURE from AUDIT_UNIFIED_ENABLED_POLICIES order by policy_name;
select POLICY_NAME, ENABLED_OPTION, ENTITY_NAME, ENTITY_TYPE, SUCCESS, FAILURE from AUDIT_UNIFIED_ENABLED_POLICIES order by policy_name;
--
prompt
EOF
