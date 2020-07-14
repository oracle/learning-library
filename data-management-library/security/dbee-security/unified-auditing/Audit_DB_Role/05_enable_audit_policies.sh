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
prompt audit policy AUD_ROLE_POL;
audit policy AUD_ROLE_POL;
prompt audit policy AUD_DBA_POL;
audit policy AUD_DBA_POL;
prompt
EOF
 
