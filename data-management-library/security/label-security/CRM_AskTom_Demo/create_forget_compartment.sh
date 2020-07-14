#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

sqlplus -s lbac_super/Oracle123@pdb1 <<EOF

set lines 125
set pages 9999

column POLICY_NAME format a12
column LONG_NAME format a12
column SHORT_NAME format a12

prompt
show user

prompt
prompt Create the FORGET compartment to remove records
prompt 
prompt begin
prompt LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
prompt     policy_name => 'OLS_CRM_DEMO'
prompt   , comp_num => 100
prompt   , short_name => 'FGT'
prompt   , long_name => 'FORGET');
prompt end;;
prompt /
prompt
begin
 LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'OLS_CRM_DEMO'
  , comp_num => 100
  , short_name => 'FGT'
  , long_name => 'FORGET');
end;
/

prompt
prompt Show all OLS Compartments
select * from all_sa_compartments;

EOF
