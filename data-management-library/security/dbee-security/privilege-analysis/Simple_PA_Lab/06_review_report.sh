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
echo "Next, review the report from the PA capture run..."
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


-- How Privilege Analysis Works with Pre-Compiled Database Objects
-- Privilege analysis can be used to capture the privileges that have been exercised on pre-compiled database objects.
-- 
-- Examples of these objects are PL/SQL packages, procedures, functions, views, triggers, and Java classes and data.
-- 
-- Because these privileges may not be exercised during run time when a stored procedure is called, 
-- these privileges are collected when you generate the results for any database-wide capture, along with run-time captured privileges. 
-- A privilege is treated as an unused privilege when it is not used in either pre-compiled database objects or run-time capture, 
-- and it is saved under the run-time capture name. If a privilege is used for pre-compiled database objects, 
-- then it is saved under the capture name ORA$DEPENDENCY. 
-- If a privilege is captured during run time, then it is saved under the run-time capture name. 
-- If you want to know what the used privileges are for both pre-compiled database objects and run-time usage, 
-- then you must query both the ORA$DEPENDENCY and run-time captures. 
-- For unused privileges, you only need to query with the run-time capture name.
-- 
-- To find a full list of the pre-compiled objects on which privilege analysis can be used
--  query the TYPE column of the ALL_DEPENDENCIES data dictionary view
--

--
-- Privilege analysis can be used to capture the privileges that have been exercised on pre-compiled database objects.
-- 
-- Examples of these objects are PL/SQL packages, procedures, functions, views, triggers, and Java classes and data.
--

--
-- System Privileges used by User and Role
-- 
SELECT USERNAME, USED_ROLE, SYS_PRIV, OBJECT_OWNER, OBJECT_NAME, OBJECT_TYPE, PATH
  FROM DBA_USED_PRIVS 
 WHERE CAPTURE = 'ORA$DEPENDENCY'
   AND SYS_PRIV is not null
    order by username, used_role;

--
-- Object Privileges used by User and Role
--
SELECT USERNAME, USED_ROLE, OBJ_PRIV, OBJECT_OWNER, OBJECT_NAME, OBJECT_TYPE, PATH
  FROM DBA_USED_PRIVS 
 WHERE CAPTURE = 'ORA$DEPENDENCY'
   AND SYS_PRIV is null
 order by username, used_role;

--
-- Capture the used privileges by EMPLOYEESEARCH 
--
SELECT USERNAME, USED_ROLE, SYS_PRIV, OBJECT_OWNER, OBJECT_NAME, OBJECT_TYPE, PATH
  FROM DBA_USED_PRIVS 
 WHERE USERNAME = 'EMPLOYEESEARCH'
 order by username, used_role;


--
-- Unused Privileges by EMPLOYEESEARCH 
--
select username, obj_priv, object_owner, object_name, object_type
from DBA_UNUSED_OBJPRIVS 
 where capture = 'All Database Capture'
   and USERNAME = 'EMPLOYEESEARCH'
 order by username, obj_priv;
  

--
-- Used Privileges on EMPLOYEESEARCH Objects
-- 
select username, used_role, sys_priv, obj_priv, object_owner, object_name, object_type, path
  from DBA_USED_PRIVS
 where capture = 'All Database Capture'
   and object_owner = 'EMPLOYEESEARCH'
 order by username, used_role;
 
--
-- Unused Privileges on EMPLOYEESEARCH Objects
-- 
select username, sys_priv, obj_priv, object_owner, object_name, object_type, path
  from DBA_UNUSED_PRIVS
 where capture = 'All Database Capture'
   and object_owner = 'EMPLOYEESEARCH'
 order by username;

--
-- Unused System Privileges 
--
select username, sys_priv, admin_option
  from DBA_UNUSED_SYSPRIVS 
 where capture = 'All Database Capture'
   and username in ('EMPLOYEESEARCH','PU_PETE')
 order by username, sys_priv;
 
--
-- Unused User Privileges
--
select username, user_priv, onuser, grant_option
  from DBA_UNUSED_USERPRIVS
 where capture = 'All Database Capture'
   and username in ('EMPLOYEESEARCH','PU_PETE')
 order by username, user_priv;


--
--  Used Object Privileges  
--
select username, used_role, os_user, userhost, module, obj_priv, object_owner, object_name, object_type
  from DBA_USED_OBJPRIVS 
  where capture = 'All Database Capture'
    and username in ('EMPLOYEESEARCH','DBA_DEBRA','DBA_HARVEY','PU_PETE')
  order by username, used_role;
     
--
--  Used Public Privileges  
--
select username, obj_priv, os_user, userhost, module, object_owner, object_name, object_type
  from DBA_USED_PUBPRIVS
 where capture = 'All Database Capture'
   and username in ('EMPLOYEESEARCH','DBA_DEBRA','DBA_HARVEY','PU_PETE')
 order by username, obj_priv;
 
--
-- Unused Sys Privileges
--
select username, used_role, os_user, userhost, module, sys_priv, admin_option
   from DBA_USED_SYSPRIVS
  where capture = 'All Database Capture'
   and username in ('EMPLOYEESEARCH','DBA_DEBRA','DBA_HARVEY','PU_PETE')
 order by username, used_role; 

--
-- Used User Privileges 
--
select username, used_role, os_user, userhost, module, user_priv, onuser, grant_option
  from DBA_USED_USERPRIVS
 where capture = 'All Database Capture'
 order by username, used_role; 

EOF
