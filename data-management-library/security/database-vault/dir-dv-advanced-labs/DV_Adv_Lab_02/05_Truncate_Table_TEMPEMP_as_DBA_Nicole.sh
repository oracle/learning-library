#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

. $DBSEC_ADMIN/cdb.env

$ORACLE_HOME/bin/sqlplus -s dba_nicole/Oracle123@pdb1 << EOF

spool 05_Truncate_Table_TEMPEMP_as_DBA_NICOLE.out

truncate table employeesearch_prod.temp_emp;

exit
EOF
