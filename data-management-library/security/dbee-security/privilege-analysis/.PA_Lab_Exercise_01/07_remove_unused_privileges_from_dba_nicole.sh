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

spool Step_7_Remove_Unused_Privileges_from_DBA_NICOLE.out

conn sys/Oracle123@pdb1 as sysdba;

set serveroutput on;

begin
for x in (select granted_role from dba_role_privs where grantee = 'DBA_NICOLE' and granted_role not in ('CONNECT','RESOURCE')) loop
  
  execute immediate 'REVOKE '||x.granted_role||' from DBA_NICOLE';
end loop;
end;
/
 
-- As DBA_DEBRA:
-- "UNLIMITED TABLESPACE" is too powerful and not needed for DBA_Nicole's tuning work.
-- Replace with:

conn dbv_acctmgr_pdb1/Oracle123@pdb1
alter user DBA_Nicole quota unlimited on USERS;

conn sys/Oracle123@pdb1 as sysdba;

set serveroutput on;

begin
for x in (select sys_priv from dba_used_sysprivs where username = 'DBA_NICOLE' and sys_priv != 'UNLIMITED TABLESPACE') loop
 execute immediate 'GRANT '||x.SYS_PRIV||' to dba_tuning_role';
end loop;
end;
/

conn dba_harvey/Oracle123@pdb1

begin
for x in (select object_owner, object_name, obj_priv from  dba_used_objprivs where USED_ROLE <> 'PUBLIC' and username = 'DBA_NICOLE') loop
execute immediate 'GRANT '||x.OBJ_PRIV||' ON '||x.OBJECT_OWNER||'.'||x.OBJECT_NAME||' to dba_tuning_role';
end loop;
end;
/


grant dba_tuning_role to DBA_Nicole;
EOF
