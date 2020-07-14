#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

#
# Script: Reset_Infrastructure.sh
#

# generate a log file for our script output
rm -f Reset_Infrastructure.out
exec > >(tee -a Reset_Infrastructure.out) 2>&1

# Script Dir
SCRIPT_DIR=$DBSEC_HOME/workshops/dbsec/redaction_scripts

. $DBSEC_ADMIN/scripts/cdb.env

$ORACLE_HOME/bin/sqlplus '/ as sysdba'<<EOF

conn sys/Oracle123@pdb1 as sysdba
set echo on;
set serveroutput on;

show user;

drop tablespace HR_ENC including contents and datafiles;
drop table HR.DEPARTMENTS_TOO;
create table HR.DEPARTMENTS_TOO as select * from HR.DEPARTMENTS
exit;

connect sys/Oracle123@pdb1 as sysdba
show user

@${SCRIPT_DIR}/query_redaction_policies.sql
@${SCRIPT_DIR}/drop_redaction_policies_empsearch.sql
@${SCRIPT_DIR}/query_redaction_policies.sql

@${SCRIPT_DIR}/query_policy_expressions.sql
@${SCRIPT_DIR}/drop_policy_expressions.sql
@${SCRIPT_DIR}/query_policy_expressions.sql

connect dbv_acctmgr_pdb1/Oracle123@pdb1
show user;

drop user american_al cascade;
drop user british_bob cascade;

EOF

echo ""
echo ""

read -p "Press enter to close"
