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
echo "Create the master key for the container database..."
echo

sqlplus -s / as sysdba <<EOF
--
show con_name;
--
set lines 110
set pages 9999
column wrl_type format a12
column wrl_parameter format a40
column activation_time format a36
column key_use format a14
column tag format a36
column name format a10
--
select a.con_id, b.name, a.wrl_type, a.wrl_parameter, a.status from v\$encryption_wallet a, v\$containers b where a.con_id=b.con_id order by a.con_id;
--
ADMINISTER KEY MANAGEMENT SET KEY USING TAG 'CDB: Initial Master Key' IDENTIFIED BY Oracle123 WITH BACKUP container=current;
--
select a.con_id, b.name, a.wrl_type, a.wrl_parameter, a.status from v\$encryption_wallet a, v\$containers b where a.con_id=b.con_id order by a.con_id;
--
EOF
