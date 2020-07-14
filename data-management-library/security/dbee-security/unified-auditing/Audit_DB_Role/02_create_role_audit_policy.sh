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
prompt create audit policy aud_role_pol ROLES mgr_role;
create audit policy aud_role_pol ROLES mgr_role;
prompt
--
EOF

