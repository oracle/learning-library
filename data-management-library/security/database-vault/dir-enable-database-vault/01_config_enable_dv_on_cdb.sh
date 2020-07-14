#!/bin/bash

#
# Script: 01_config_enable_dv.sh
#

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm $outfile 2>&1
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

source $DBSEC_ADMIN/cdb.env

$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
set echo on;
show user
show con_name
--
@${SCRIPT_DIR}/query_dv_status.sql
--
BEGIN
 DVSYS.CONFIGURE_DV (
   dvowner_uname         => 'C##DVOWNER',
   dvacctmgr_uname       => 'c##DVACCTMGR');
 END;
/
--
connect c##dvowner/${DBUSR_PWD}
show user
show con_name
exec dvsys.dbms_macadm.enable_dv;
--
connect / as sysdba
show user
show con_name
shutdown immediate;
startup;
@${SCRIPT_DIR}/query_dv_status.sql
EOF

#echo
#echo
#read -p "Press enter to close"

