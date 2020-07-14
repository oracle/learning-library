#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo
echo "Review the output of the Unified Audit Trail..."
echo 

sqlplus -s sys/Oracle123@pdb1 as sysdba << EOF
set echo on
set lines 180
set pages 9999
column action_name format a20
column object_name format a20
column object_schema format a10
column audit_type format a15
column dbusername format a10
column audit_option format a30
select audit_type, action_name, dbusername, action_name, OBJECT_SCHEMA, object_name, audit_option from unified_audit_trail where event_timestamp > sysdate-1/24;
EOF
