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
echo "Enable Archivelog Mode on the CDB and PDBs..."
echo "This will require a reboot."
echo

if [ -z $1 ]; then
 cdb_name="cdb1"
 echo
 echo "No variable passed. Using the default ${cdb_name}"
 echo
else
 cdb_name=$1
 echo
 echo "Variable passed. Using the passed variable ${cdb_name}"
 echo
fi

source ${DBSEC_ADMIN}/setEnv-cdb.sh ${cdb_name}

sqlplus -s / as sysdba<<EOF
show con_name
prompt
archive log list;
prompt
shutdown immediate;
prompt
startup mount;
prompt
alter database archivelog;
prompt
alter database open;
prompt
alter pluggable database all open;
prompt
show pdbs
prompt
archive log list;
prompt
EOF


