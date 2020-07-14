#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1


FQDN_HOST=`hostname --fqdn`

echo
echo "We must update the script to have the fully-qualified hostname for your VM."
echo
echo "Your machine is: ${FQDN_HOST}"

# Copy it from the output from Step 04.

echo
echo "The default rule set looks like this:"
echo
echo "SYS_CONTEXT('USERENV','SESSION_USER') = 'EMPLOYEESEARCH_PROD'
AND SYS_CONTEXT('USERENV','OS_USER') = 'oracle'
AND SYS_CONTEXT('USERENV','MODULE') = 'JDBC Thin Client'
AND SYS_CONTEXT('USERENV','HOST') = 'dbsec-lab.dbsecvcn.oraclevcn.com'"

RULE_EXPR="'SYS_CONTEXT(''USERENV'',''SESSION_USER'') = ''EMPLOYEESEARCH_PROD'' AND SYS_CONTEXT(''USERENV'',''OS_USER'') = ''oracle'' AND SYS_CONTEXT(''USERENV'',''MODULE'') = ''JDBC Thin Client'' AND SYS_CONTEXT(''USERENV'',''HOST'') = ''${FQDN_HOST}'''"

echo
echo "Your Rule Set will look like this:"
echo
echo ${RULE_EXPR}

sqlplus -s -l c##dvowner/${DBUSR_PWD}@${PDB_NAME} <<EOF

set serveroutput on;
set echo on;

begin
 DVSYS.DBMS_MACADM.CREATE_RULE(
  rule_name => 'Application Connection'
, rule_expr => ${RULE_EXPR});
end;
/

set lines 140
set pages 9999
column name format a30
column rule_expr format a90
SELECT name, rule_expr FROM DBA_DV_RULE where name = 'Application Connection';

EOF

