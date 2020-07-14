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

sqlplus -l -s c##dvowner/${DBUSR_PWD}@${PDB_NAME} <<EOF

set serveroutput on;
set echo on;

begin
 DVSYS.DBMS_MACADM.CREATE_CONNECT_COMMAND_RULE(
   user_name	=> 'EMPLOYEESEARCH_PROD'
  ,rule_set_name => 'Trusted Application Path'
  ,enabled => DBMS_MACUTL.G_YES);
end;
/
 
set lines 140
set pages 9999
column command format a20
column object_owner format a24
column object_name format a24
column rule_set_name format a40
select command, object_owner, object_name, rule_set_name from dba_dv_command_rule where command = 'CONNECT';

EOF

