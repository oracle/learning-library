#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

source $DBSEC_ADMIN/cdb.env

#
SCRIPT_DIR=${DBSEC_HOME}/workshops/dbsec/dv_scripts

$ORACLE_HOME/bin/sqlplus -s c##dvowner/Oracle123@pdb1 << EOF

spool 99_Cleanup.out

@${SCRIPT_DIR}/reset_dv.sql

exit;

EOF
