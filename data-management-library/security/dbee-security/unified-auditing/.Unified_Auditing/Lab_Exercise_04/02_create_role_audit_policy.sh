#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

sqlplus -s sys/Oracle123@pdb1 as sysdba << EOF
create audit policy aud_role_pol ROLES mgr_role;
EOF

