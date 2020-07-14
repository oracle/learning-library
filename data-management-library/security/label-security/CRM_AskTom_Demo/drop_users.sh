#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

sqlplus -s / as sysdba <<EOF

connect lbacsys/Oracle123@pdb1
begin
 LBACSYS.SA_SYSDBA.DROP_POLICY(
    policy_name => 'OLS_CRM_DEMO',
     drop_column => TRUE);
end;
/

connect sys/Oracle123@pdb1 as sysdba
drop user crm_pam cascade;
drop user crm_brian cascade;
drop user crm cascade;
drop user lbac_super cascade;
EOF
