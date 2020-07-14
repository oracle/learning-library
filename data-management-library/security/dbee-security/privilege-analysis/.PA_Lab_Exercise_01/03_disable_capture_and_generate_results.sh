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

$ORACLE_HOME/bin/sqlplus /nolog <<EOF

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TAB OFF
SET PAGESIZE 100
set serveroutput on;

spool Step_3_Disable_Capture_and_Generate_Results.out

conn DBA_Debra/Oracle123@pdb1;

begin
	dbms_privilege_capture.disable_capture(
	name	=> 'DBA_Tuning_Privilege_Analysis');
end;
/

 
begin
	dbms_privilege_capture.generate_result(
	name	=> 'DBA_Tuning_Privilege_Analysis');
end;
/

