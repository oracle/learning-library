#!/bin/bash

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

echo
echo "Check if pure Unified Auditing is enabled..."
echo

if [ -z $1 ]; then
  pdb_name=${PDB_NAME}
else
  pdb_name=${1}
fi


sqlplus -s sys/${DBUSR_PWD}@${pdb_name} as sysdba << EOF
set echo on
column POLICY_NAME format A40
column ENABLED_POLICIES format A40
column AUDIT_OPTION format A40
column parameter format a50
column value format a40
column namespace format a35
column attribute format a35
column user_name format a25
column partition_name format a20
column tablespace_name format a20
column high_value format a60
set PAGES 9999
set lines 120
show user
show con_name
--
select partition_name, tablespace_name, high_value from dba_tab_partitions where table_name = 'AUD\$UNIFIED';
--
select DBMS_AUDIT_MGMT.GET_AUDIT_COMMIT_DELAY from dual;
--
--select DBMS_AUDIT_MGMT.GET_LAST_ARCHIVE_TIMESTAMP('AUDIT_TRAIL_UNIFIED') from dual;
--
SET SERVEROUTPUT ON
DECLARE
 LAT_TS TIMESTAMP;
BEGIN
 LAT_TS := DBMS_AUDIT_MGMT.GET_LAST_ARCHIVE_TIMESTAMP(
      audit_trail_type          => DBMS_AUDIT_MGMT.AUDIT_TRAIL_OS);
 IF LAT_TS is not NULL THEN
  DBMS_OUTPUT.PUT_LINE('The Last Archive Timestamp is: ' || to_char(LAT_TS));
 ELSE 
  DBMS_OUTPUT.PUT_LINE('No reults because the SET_LAST_ARCHIVE_TIMESTAMP Procedure is available only on a READ ONLY database.');
 END IF;
END;
/
--
--SET_AUDIT_TRAIL_PROPERTY
SET SERVEROUTPUT ON
DECLARE
 OS_MAX_AGE_VAL NUMBER;
BEGIN
 OS_MAX_AGE_VAL := DBMS_AUDIT_MGMT.GET_AUDIT_TRAIL_PROPERTY_VALUE(
      audit_trail_type          => DBMS_AUDIT_MGMT.AUDIT_TRAIL_OS,
      audit_trail_property      => DBMS_AUDIT_MGMT. OS_FILE_MAX_AGE);
 IF OS_MAX_AGE_VAL is not NULL THEN
  DBMS_OUTPUT.PUT_LINE('The Maximum Age configured for OS Audit files is: ' ||
                       OS_MAX_AGE_VAL);
 END IF;
END;
/
--
EOF
