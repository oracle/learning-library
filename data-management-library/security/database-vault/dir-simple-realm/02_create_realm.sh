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
echo "Create the realm..."

sqlplus -s c##dvowner/${DBUSR_PWD}@${PDB_NAME} <<EOF

show user;
show con_name;
set lines 110
set pages 9999
column name format a31
column description format a65
column enabled format a8

select name, description, enabled from dba_dv_realm where id# >= 5000 order by 1;

begin 
 DVSYS.DBMS_MACADM.CREATE_REALM(
   realm_name => 'PROTECT_EMPLOYEESEARCH_PROD'
  ,description => 'A mandatory realm to protect the EMPLOYEESEARCH_PROD schema.'
  ,enabled => DBMS_MACUTL.G_YES
  ,audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL
  ,realm_type => 1); 
END;
/

select name, description, enabled from dba_dv_realm where id# >= 5000 order by 1;

EOF

