#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

echo
echo
echo

sqlplus /nolog <<EOF

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 100
SET TAB OFF
SET PAGESIZE 100

spool Step_4_View_PA_Output.out

conn DBA_Debra/Oracle123@pdb1;

set heading off;

select 'GRANT '||SYS_PRIV||' to dba_tuning_role; ' from dba_used_sysprivs where username = 'DBA_NICOLE';

select 'GRANT '||OBJ_PRIV||' ON '||OBJECT_OWNER||'.'||OBJECT_NAME||' to dba_tuning_role;' from  dba_used_objprivs where USED_ROLE <> 'PUBLIC' and username = 'DBA_NICOLE' order by OBJECT_OWNER, OBJECT_NAME;

set heading on;

EOF
