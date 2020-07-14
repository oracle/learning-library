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
echo "Check if pure Unified Auditing is enabled..."
echo

if [ -z $1 ]; then
  pdb_name=${PDB_NAME}
else
  pdb_name=${1}
fi


sqlplus -s sys/${DBUSR_PWD}@${pdb_name} as sysdba << EOF
set echo on
set PAGES 9999
set lines 120
show user
show con_name
prompt
--
prompt DROP USER schema_only CASCADE;
DROP USER schema_only CASCADE;
--
prompt
prompt CREATE USER schema_only NO AUTHENTICATION QUOTA UNLIMITED ON users;
CREATE USER schema_only NO AUTHENTICATION QUOTA UNLIMITED ON users;
--  
prompt
prompt CREATE SESSION, GRANT RESOURCE TO schema_only;
GRANT CREATE SESSION, RESOURCE TO schema_only;
--
COLUMN username FORMAT A30
COLUMN account_status FORMAT A20
prompt
prompt SELECT username, account_status, authentication_type FROM   dba_users WHERE  username = 'SCHEMA_ONLY';
SELECT username, account_status, authentication_type FROM   dba_users WHERE  username = 'SCHEMA_ONLY';
--
EOF
