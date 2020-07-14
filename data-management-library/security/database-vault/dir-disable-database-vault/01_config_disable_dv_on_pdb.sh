#!/bin/bash

# Script: 01_config_disable_dv_on_pdb.sh
#

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

if [ -z "$1" ]; then
 echo
 echo "You did not include a PDB name."
 echo
 exit 1
else
 pdb_name=$1
 echo
 echo
fi

echo
echo "Disable Database Vault for the pluggable database ${pdb_name} ..."
echo

# This script dir may vary from script to script, depending on where the necessary files are located

# Script Dir
SCRIPT_DIR=$DBSEC_HOME/workshops/dbsec/dv_scripts

source $DBSEC_ADMIN/cdb.env

$ORACLE_HOME/bin/sqlplus -s /nolog <<EOF
set echo on;

connect / as sysdba
@${SCRIPT_DIR}/query_dv_status.sql

connect c##dvowner/${DBUSR_PWD}@${pdb_name};
show user
show con_name
--
exec dvsys.dbms_macadm.disable_dv;
--
connect / as sysdba
show user
show con_name
alter pluggable database ${pdb_name} close immediate;
alter pluggable database ${pdb_name} open;
@${SCRIPT_DIR}/query_dv_status.sql
EOF

#echo
#echo
#read -p "Press enter to close"

