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
echo "Next, generate the report from the PA capture run..."
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
column capture format a20
column name format a35
column has_role format a20
column obj_priv format a20
column object_name format a30
column object_owner format a20
column path format a35
column capture format a20
column os_user  format a15
column userhost format a20
column username format a20
column used_role format a20
column run_name format a20
column module format a30
column sys_priv format a25
column rolename format a20

--
-- Do you have the CAPTURE_ADMIN role? 
--
select sys_context('SYS_SESSION_ROLES','CAPTURE_ADMIN') has_role from dual;

--
-- Generate the PA Capture Results
-- 
BEGIN 
 DBMS_PRIVILEGE_CAPTURE.GENERATE_RESULT(
      name => 'All Database Capture');
END; 
/


EOF
