#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo
echo "Create a Data Pump Audit Policy..."
echo

sqlplus -s sys/Oracle123@pdb1 as sysdba << EOF
noaudit policy DP_POL;
drop audit policy DP_POL;
select * from AUDIT_UNIFIED_ENABLED_POLICIES  where POLICY_NAME like '%DP%';
create audit policy DP_POL actions component=datapump export;
audit policy DP_POL;
col user_name format A10
col policy_name format A10
select * from AUDIT_UNIFIED_ENABLED_POLICIES  where POLICY_NAME like '%DP%';
EOF
