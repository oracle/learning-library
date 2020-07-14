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
echo "Identify who has AUDIT_ADMIN or AUDIT_VIEWER roles..."
echo

sqlplus -s / as sysdba << EOF
set echo on
col CON_NAME format A12
col GRANTEE format A19
col GRANTED_ROLE format A19
col admin_option format a12
col delegate_option format a16
col default_role format a14
col common format a9
col inherited format a9
set PAGES 9999
set lines 120
 select b.name con_name, a.grantee, a.granted_role, a.admin_option, a.delegate_option, a.default_role, a.common, a.inherited from cdb_role_privs a, v\$containers b where a.con_id = b.con_id
  and a.granted_role in ('AUDIT_ADMIN','AUDIT_VIEWER')
  order by 1,2,3;

EOF
