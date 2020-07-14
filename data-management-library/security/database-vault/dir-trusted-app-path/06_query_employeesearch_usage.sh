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


$ORACLE_HOME/bin/sqlplus -l -s sys/Oracle123@pdb1 as sysdba << EOF

set trimspool on;

set lines 120
set pages 999

column osuser format a18
column machine format a55
colum module format a35

set echo on;

show user;

SELECT osuser, machine, module
FROM v\$session
WHERE username = 'EMPLOYEESEARCH_PROD';


exit;
EOF

