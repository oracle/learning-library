#!/bin/bash

echo
echo
echo

$ORACLE_HOME/bin/sqlplus /nolog <<EOF

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TAB OFF
SET PAGESIZE 100

conn DBA_Debra/Oracle123@pdb1;
drop role dba_tuning_role;

spool Step_6_Create_tuning_role_for_DBA_NICOLE.out

conn DBA_Debra/Oracle123@pdb1;

create role dba_tuning_role;

exit;

EOF
