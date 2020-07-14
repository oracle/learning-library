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


echo
echo "Create a Rule Set from the Rule we created..."
echo

sqlplus -s -l c##dvowner/${DBUSR_PWD}@${PDB_NAME} <<EOF

set serveroutput on;
set echo on;

begin
 DVSYS.DBMS_MACADM.CREATE_RULE_SET(
  rule_set_name => 'Trusted Application Path'
 ,description   => 'Protecting the App User'
 ,enabled       => DBMS_MACUTL.G_YES
 ,eval_options  => DBMS_MACUTL.G_RULESET_EVAL_ALL
 ,audit_options => DBMS_MACUTL.G_RULESET_AUDIT_FAIL
 ,fail_options  => DBMS_MACUTL.G_RULESET_FAIL_SHOW
 ,fail_message  => 'You cannot use the app account this way.'
 ,fail_code     => -20000
 ,handler_options => null
 ,handler         => null
 ,is_static     => TRUE);
end;
/

begin
 DVSYS.DBMS_MACADM.ADD_RULE_TO_RULE_SET(
  rule_set_name  => 'Trusted Application Path'
 ,rule_name      => 'Has EMPSEARCH_APP Role'
 ,rule_order     => 1
 ,enabled        => DBMS_MACUTL.G_YES);
end;
/

set lines 140
set pages 9999
column rule_set_name format a30
column eval_options_meaning format a20
column fail_message format a45
SELECT rule_set_name, enabled, eval_options_meaning, audit_options, fail_message, fail_code, is_static FROM DBA_DV_RULE_SET where rule_set_name = 'Trusted Application Path';

EOF

