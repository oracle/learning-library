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
prompt create user DBA_JUNIOR identified by ${DBUSR_PWD};
create user DBA_JUNIOR identified by ${DBUSR_PWD};
prompt grant DBA to DBA_JUNIOR;
grant DBA to DBA_JUNIOR;
prompt
--
EOF

