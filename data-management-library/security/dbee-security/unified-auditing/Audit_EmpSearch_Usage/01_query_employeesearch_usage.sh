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

if [ `ps -ef | grep $GLASSFISH_HOME | grep -v grep | wc -l` -eq 0 ]; then
 echo 
 echo "Glassfish is not starting so we will start it..."
 echo
 $DBSEC_ADMIN/start_Glassfish.sh
fi

echo
echo "You will use the Glassfish application for this script."
echo
echo "Open your browser to http://${PUBLIC_IP}:8080/hr_prod_${PDB_NAME}"
echo 
echo "Login as hradmin/Oracle123 and search the employee data at random."
echo
read -p "Press [return] when you have done so."
echo

$ORACLE_HOME/bin/sqlplus -l -s sys/${DBUSR_PWD}@${PDB_NAME} as sysdba << EOF

set trimspool on
set echo on
set termout on
set lines 120
set pages 999
set feedback on

column osuser format a18
column machine format a55
colum module format a35

prompt
show con_name;
show user;

prompt 
prompt SELECT osuser, machine, module
prompt FROM v\$session
prompt WHERE username = 'EMPLOYEESEARCH_PROD';

SELECT osuser, machine, module
FROM v\$session
WHERE username = 'EMPLOYEESEARCH_PROD';

exit;
EOF

