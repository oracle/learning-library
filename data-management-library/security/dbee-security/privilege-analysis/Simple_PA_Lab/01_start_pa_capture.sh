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
echo "First, make sure the user has the CAPTURE_ADMIN role." 
echo "Next, create the PA Capture."
echo

sqlplus -s / as sysdba <<EOF

set lines 210
set pages 999
column name format a35
column has_role format a20
column enabled format a20

connect PA_ADMIN/${DBUSR_PWD}@${PDB_NAME}
show user;
show con_name

--
-- Do you have the CAPTURE_ADMIN role? 
--
select sys_context('SYS_SESSION_ROLES','CAPTURE_ADMIN') has_role from dual;


--
-- Look to see if our capture exists
--
select NAME, TYPE, ENABLED from DBA_PRIV_CAPTURES where NAME = 'All Database Capture';

--
-- Create our Capture to capture everything!
--
-- Database-wide privilege capture. --- 
-- If you do not specify any type in your privilege analysis policy,
--  then the used privileges in the database will be captured.
--  except those for the user SYS. 
--  (This is also referred to as unconditional analysis, because it is turned on without any conditions.)
--
BEGIN 
 DBMS_PRIVILEGE_CAPTURE.CREATE_CAPTURE(
      name => 'All Database Capture' 
    , description => '' 
    , type => 1 );
END; 
/


--
-- Now it should exist
--
select NAME, TYPE, ENABLED from DBA_PRIV_CAPTURES where NAME = 'All Database Capture';

EOF
