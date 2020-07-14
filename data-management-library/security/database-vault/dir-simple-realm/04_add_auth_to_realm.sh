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
echo "Add an owner participant to the realm..."

sqlplus -s c##dvowner/${DBUSR_PWD}@${PDB_NAME} <<EOF

show user;
show con_name;
set lines 110
set pages 9999
column realm_name format a28
column grantee format a22
column auth_options format a28

select realm_name, grantee, auth_options
  from dvsys.dba_dv_realm_auth
 where realm_name in (select name from dvsys.dv\$realm where id# >= 5000);

begin
 DVSYS.DBMS_MACADM.ADD_AUTH_TO_REALM(
   realm_name => 'PROTECT_EMPLOYEESEARCH_PROD'
  ,grantee => 'EMPLOYEESEARCH_PROD'
  ,rule_set_name => '' 
  ,auth_options => '1' ); 
end;
/

select realm_name, grantee, auth_options
  from dvsys.dba_dv_realm_auth
 where realm_name in (select name from dvsys.dv\$realm where id# >= 5000);

EOF

