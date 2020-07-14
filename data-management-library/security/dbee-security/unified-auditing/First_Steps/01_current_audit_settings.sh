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
echo "Check if pure Unified Auditing is enabled..."
echo

if [ -z $1 ]; then
  pdb_name=${PDB_NAME}
else
  pdb_name=${1}
fi


sqlplus -s sys/${DBUSR_PWD}@${pdb_name} as sysdba << EOF
set echo on
column POLICY_NAME format A40
column ENABLED_POLICIES format A40
column AUDIT_OPTION format A40
column parameter format a50
column value format a40
column namespace format a35
column attribute format a35
column user_name format a25
set PAGES 9999
set lines 120
show user
show con_name
--
select parameter, value from v\$option where PARAMETER = 'Unified Auditing';
--
select policy_name, count(*) audited_attributes from audit_unified_policies group by policy_name order by policy_name;
--
select POLICY_NAME as ENABLED_POLICIES from AUDIT_UNIFIED_ENABLED_POLICIES order by 1; 
--
select NAMESPACE, ATTRIBUTE, USER_NAME from AUDIT_UNIFIED_CONTEXTS order by 1,2,3;
--
EOF
