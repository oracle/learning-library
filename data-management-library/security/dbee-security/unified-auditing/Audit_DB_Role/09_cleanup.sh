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
prompt
--
prompt noaudit policy aud_role_pol;
noaudit policy aud_role_pol;
--
prompt noaudit policy aud_dba_pol;
noaudit policy aud_dba_pol;
--
prompt drop audit policy aud_role_pol;
drop audit policy aud_role_pol;
--
prompt drop audit policy aud_dba_pol;
drop audit policy aud_dba_pol;
--
prompt drop user DBA_JUNIOR cascade;
drop user DBA_JUNIOR cascade;
--
prompt drop role MGR_ROLE;
drop role MGR_ROLE;
--
prompt
EOF
