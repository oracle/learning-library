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
echo "Disable and Remove the Audit Policy..."
echo

sqlplus -s -l sys/${DBUSR_PWD}@${PDB_NAME} as sysdba <<EOF

prompt
show con_name;
show user;

prompt
prompt noaudit policy AUDIT_EMPLOYEESEARCH_USAGE;
prompt
prompt drop audit policy AUDIT_EMPLOYEESEARCH_USAGE;

BEGIN
 EXECUTE IMMEDIATE 'NOAUDIT POLICY AUDIT_EMPLOYEESEARCH_USAGE';
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
/

BEGIN
 EXECUTE IMMEDIATE 'DROP AUDIT POLICY AUDIT_EMPLOYEESEARCH_USAGE';
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
/


EOF

