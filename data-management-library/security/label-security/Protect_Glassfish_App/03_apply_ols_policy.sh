#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null


# 03_apply_ols_policy.sh

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1


$ORACLE_HOME/bin/sqlplus -s /nolog << EOF

set trimspool on;

set lines 180
set pages 999

set echo on;

-- Apply the policy to our table, EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES
prompt Apply the policy to EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES

connect lbacsys/Oracle123@pdb1

show user;

begin
 SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
   policy_name => 'OLS_DEMO_HR_APP'
 , schema_name =>'EMPLOYEESEARCH_PROD'
 , table_name =>'DEMO_HR_EMPLOYEES');
end;
/

exit;
EOF

