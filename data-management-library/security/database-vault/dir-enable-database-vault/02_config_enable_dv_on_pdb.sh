#!/bin/bash

#
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

# This script dir may vary from script to script, depending on where the necessary files are located

# Script Dir
SCRIPT_DIR=$DBSEC_HOME/workshops/dbsec/dv_scripts

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
echo "Configure and Enable Database Vault for the pluggable database ${pdb_name} ..."	
echo

$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
set echo on;
show user
show con_name
--
@${SCRIPT_DIR}/query_dv_status.sql
--
alter session set container=${pdb_name};
BEGIN
 DVSYS.CONFIGURE_DV (
   dvowner_uname         => 'C##DVOWNER',
   dvacctmgr_uname       => 'c##DVACCTMGR');
 END;
/
--
connect c##dvowner/${DBUSR_PWD}@${pdb_name}
show user
show con_name
exec dvsys.dbms_macadm.enable_dv;
--
connect / as sysdba
show user
show con_name
alter pluggable database ${pdb_name} close immediate;
alter pluggable database ${pdb_name} open;
@${SCRIPT_DIR}/query_dv_status.sql
EOF


