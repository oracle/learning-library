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

sqlplus -s / as sysdba << EOF
set echo on
col POLICY_NAME format A20
col AUDIT_OPTION format A40
column parameter format a50
column value format a40
set PAGES 9999
set lines 120
select parameter, value from v\$option where PARAMETER = 'Unified Auditing';
select policy_name, count(*) audited_attributes from audit_unified_policies group by policy_name order by policy_name;

--select POLICY_NAME, AUDIT_OPTION from AUDIT_UNIFIED_POLICIES where policy_name = 'ORA_SECURECONFIG' order by 2;
select POLICY_NAME from AUDIT_UNIFIED_ENABLED_POLICIES where  policy_name = 'ORA_SECURECONFIG';
show parameter AUDIT;
EOF
