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

sqlplus -s / as sysdba <<EOF
--
set lines 90
set pages 999
BREAK ON PDB_NAME SKIP PAGE ON PDB_NAME
column pdb_name format a20
column name format a25
column status format a20
column open_mode format a20
select * from dba_dv_status;
--
select a.name pdb_name, a.open_mode, b.name, b.status
  from v\$pdbs a, cdb_dv_status b
 where a.con_id = b.con_id
 order by 1,2;
--
EOF
