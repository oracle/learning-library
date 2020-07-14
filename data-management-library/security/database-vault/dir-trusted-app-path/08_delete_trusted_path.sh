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
echo "Remove Command Rule, Rule Set, and Rule..."
echo

sqlplus -s -l c##dvowner/${DBUSR_PWD}@${PDB_NAME} <<EOF

set serveroutput on;
set echo on;

begin
 DVSYS.DBMS_MACADM.DELETE_CONNECT_COMMAND_RULE(
  user_name => 'EMPLOYEESEARCH_PROD');
end;
/

begin
 DVSYS.DBMS_MACADM.DELETE_RULE_SET(
  rule_set_name => 'Trusted Application Path');
end;
/

begin
 DVSYS.DBMS_MACADM.DELETE_RULE(
  rule_name => 'Application Connection');
end;
/

EOF

