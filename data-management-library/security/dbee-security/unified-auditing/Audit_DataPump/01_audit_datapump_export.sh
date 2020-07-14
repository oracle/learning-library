#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo
echo "What is auditable for Data Pump..."
echo

sqlplus -s sys/${DBUSR_PWD}@${PDB_NAME} as sysdba << EOF

SELECT name FROM auditable_system_actions WHERE component = 'Datapump';
EOF


echo
echo "Create a Data Pump Audit Policy..."
echo

sqlplus -s sys/${DBUSR_PWD}@${PDB_NAME} as sysdba << EOF
--
show user
show con_name
--
noaudit policy DP_POL;
drop audit policy DP_POL;
--
set lines 110
set pages 999
column user_name format A10
column policy_name format A20
column entity_name format a20
--
select * from AUDIT_UNIFIED_ENABLED_POLICIES  where POLICY_NAME like '%DP%';
--
create audit policy DP_POL actions component=datapump all; 
--
audit policy DP_POL;
--
select * from AUDIT_UNIFIED_ENABLED_POLICIES  where POLICY_NAME like '%DP%';
--
EOF
