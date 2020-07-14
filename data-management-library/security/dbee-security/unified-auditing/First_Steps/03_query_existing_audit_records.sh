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

if [ -z $1 ]; then
  pdb_name=${PDB_NAME}
else
  pdb_name=${1}
fi

  

echo
echo "View Audit Data for ${pdb_name}..."
echo

sqlplus -s sys/${DBUSR_PWD}@${pdb_name} as sysdba << EOF
set echo on
set pages 9999
set lines 120

column oldest_audit_record format a40
column newest_audit_record format a40
column action_name format a40

select min(event_timestamp) oldest_audit_record, max(event_timestamp) newest_audit_record from unified_audit_trail;
select count(*) total_unified_audit_records from unified_audit_trail;
select action_name, count(*) from unified_audit_trail group by action_name order by action_name;


EOF

