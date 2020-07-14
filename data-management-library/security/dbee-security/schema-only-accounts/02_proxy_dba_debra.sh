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
--
prompt
prompt ALTER USER schema_only GRANT CONNECT THROUGH dba_debra;
ALTER USER schema_only GRANT CONNECT THROUGH dba_debra;
--
EOF
