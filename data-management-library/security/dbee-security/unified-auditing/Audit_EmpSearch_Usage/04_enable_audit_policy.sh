#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

echo
echo "Enable the new Audit Policy..."
echo

sqlplus -s -l sys/${DBUSR_PWD}@${PDB_NAME} as sysdba<<EOF

set serveroutput on;
set echo on;
set lines 140
set pages 9999

prompt audit policy audit_employeesearch_usage;
audit policy audit_employeesearch_usage;

col policy_name format A38
col entity_name format A22
column entity_type format a12
column enabled_option format a20

prompt select POLICY_NAME, ENABLED_OPTION, ENTITY_NAME, ENTITY_TYPE, SUCCESS, FAILURE from AUDIT_UNIFIED_ENABLED_POLICIES order by policy_name;
select POLICY_NAME, ENABLED_OPTION, ENTITY_NAME, ENTITY_TYPE, SUCCESS, FAILURE from AUDIT_UNIFIED_ENABLED_POLICIES order by policy_name;

EOF

