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
echo "Drop the capture..."
echo

sqlplus -s / as sysdba <<EOF

set lines 210
set pages 999
column name format a35
column has_role format a20

connect PA_ADMIN/${DBUSR_PWD}@${PDB_NAME}
show user;
show con_name

set lines 210
set pages 999
column name format a35
column has_role format a20
column enabled format a20

--
-- Do you have the CAPTURE_ADMIN role? 
--
select sys_context('SYS_SESSION_ROLES','CAPTURE_ADMIN') has_role from dual;


--
-- Has the capture been disabled?
--
select NAME, ENABLED from DBA_PRIV_CAPTURES where NAME = 'All Database Capture';

--
-- Drop our Database-wide capture
-- 
BEGIN 
 DBMS_PRIVILEGE_CAPTURE.DROP_CAPTURE(
      name => 'All Database Capture');
END; 
/


--
-- Make sure it's gone!
--
SELECT SYS_PRIV, OBJECT_OWNER, OBJECT_NAME, RUN_NAME FROM DBA_USED_PRIVS WHERE RUN_NAME = 'All_Database_Capture_20181212';


EOF
