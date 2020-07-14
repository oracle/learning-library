#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

. $DBSEC_ADMIN/cdb.env 

$ORACLE_HOME/bin/sqlplus -s c##dvowner/Oracle123@pdb1 << EOF

set echo on
spool 03_Create_Realms_via_DV_API.out

exec dvsys.dbms_macadm.create_realm(realm_name=>'EMPLOYEESEARCH_DATA',description=>'Protect the EMPLOYEESEARCH_PROD Schema',enabled=>'Y',audit_options=>1);

exec dvsys.dbms_macadm.add_object_to_realm(realm_name=>'EMPLOYEESEARCH_DATA',object_owner=>'EMPLOYEESEARCH_PROD',object_name=>'%',object_type=>'%');

exec dvsys.dbms_macadm.add_auth_to_realm(realm_name=>'EMPLOYEESEARCH_DATA',grantee=>'DBA_HARVEY');

exit;
EOF


