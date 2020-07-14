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
AND (SYS_CONTEXT('USERENV','OS_USER') != 'oracle'
OR SYS_CONTEXT('USERENV','MODULE') != 'JDBC Thin Client'
OR SYS_CONTEXT('USERENV','HOST') != 'dbsec-lab.dbsecvcn.oraclevcn.com')"

RULE_EXPR="'SYS_CONTEXT(''USERENV'',''SESSION_USER'') = ''EMPLOYEESEARCH_PROD'' AND (SYS_CONTEXT(''USERENV'',''OS_USER'') != ''oracle'' OR SYS_CONTEXT(''USERENV'',''MODULE'') != ''JDBC Thin Client'' OR SYS_CONTEXT(''USERENV'',''HOST'') != ''${FQDN_HOST}'')'"

echo
echo "Your Rule Set will look like this:"
echo
echo ${RULE_EXPR}

sqlplus -s -l sys/${DBUSR_PWD}@${PDB_NAME} as sysdba <<EOF

set serveroutput on;
set echo on;

show con_name
show user

BEGIN
 EXECUTE IMMEDIATE 'NOAUDIT POLICY AUDIT_EMPLOYEESEARCH_USAGE';
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'DROP AUDIT POLICY AUDIT_EMPLOYEESEARCH_USAGE';
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
/

prompt 
prompt CREATE AUDIT POLICY AUDIT_EMPLOYEESEARCH_USAGE
prompt   ACTIONS ALL ON EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES
prompt         , ALL ON EMPLOYEESEARCH_PROD.DEMO_HR_USERS
prompt   WHEN ${RULE_EXPR}
prompt  EVALUATE PER STATEMENT;

CREATE AUDIT POLICY AUDIT_EMPLOYEESEARCH_USAGE
  ACTIONS ALL ON EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES
        , ALL ON EMPLOYEESEARCH_PROD.DEMO_HR_USERS
  WHEN ${RULE_EXPR}
 EVALUATE PER STATEMENT;

set lines 140
set pages 9999


column audit_option format A18
column object_schema format A21
column object_name format A20
column condition_eval_opt format a20

prompt select OBJECT_SCHEMA, OBJECT_NAME, OBJECT_TYPE, AUDIT_OPTION, CONDITION_EVAL_OPT, AUDIT_CONDITION from AUDIT_UNIFIED_POLICIES where POLICY_NAME = 'AUDIT_EMPLOYEESEARCH_USAGE';
select OBJECT_SCHEMA, OBJECT_NAME, OBJECT_TYPE, AUDIT_OPTION, CONDITION_EVAL_OPT, AUDIT_CONDITION from AUDIT_UNIFIED_POLICIES where POLICY_NAME = 'AUDIT_EMPLOYEESEARCH_USAGE';

EOF


