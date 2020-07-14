#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

sqlplus -s sys/${DBUSR_PWD}@${PDB_NAME} as sysdba << EOF
prompt
show con_name
show user;
--
prompt
prompt create role MGR_ROLE;
create role MGR_ROLE;
grant create tablespace to MGR_ROLE;
prompt grant create tablespace to MGR_ROLE;
grant MGR_ROLE, create session to DBA_NICOLE;
prompt grant MGR_ROLE, create session to DBA_NICOLE;
prompt
--
EOF
