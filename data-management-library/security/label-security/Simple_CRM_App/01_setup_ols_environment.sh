#!/bin/bash

#01_setup_ols_environment.sh

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

source $DBSEC_ADMIN/cdb.env 

#echo "Start the cdb.environment..."
#$DBSEC_HOME/00-init_env/admin/start_cdb.sh

$ORACLE_HOME/bin/sqlplus sys/Oracle123@cdb1 as sysdba << EOF

set trimspool on
set lines 180
set pause on
set echo on

spool 01_setup_ols_environment.out

show user;
show con_name;

prompt Creating OLS admin user...
create user c##oscar_ols identified by Oracle123;
set echo on
set pause on

prompt Granting OLS admin user roles and privileges...
grant create session to c##oscar_ols container=all;
GRANT EXECUTE ON sa_components TO c##oscar_ols WITH GRANT OPTION container=all;
GRANT EXECUTE ON sa_user_admin TO c##oscar_ols WITH GRANT OPTION container=all;
GRANT EXECUTE ON sa_label_admin TO c##oscar_ols WITH GRANT OPTION container=all;
GRANT EXECUTE ON sa_policy_admin TO c##oscar_ols WITH GRANT OPTION container=all;
GRANT EXECUTE ON sa_audit_admin  TO c##oscar_ols WITH GRANT OPTION container=all;
GRANT EXECUTE ON sa_sysdba TO c##oscar_ols container=all;
GRANT EXECUTE ON to_lbac_data_label TO c##oscar_ols container=all;
GRANT lbac_dba TO c##oscar_ols container=all;

set pause "Press [Enter] to continue"
alter session set container=pdb1;

@load_crm_customer_data.sql

prompt Creating Users for the labs in pdb1...
prompt Creating User: APPFORGET - App user that processes records marked to be forgotten
create user APPFORGET identified by Oracle123;
grant create session to APPFORGET;
grant select, insert, delete, update on APPCRM.CRM_CUSTOMER to APPFORGET;
grant create table to APPFORGET;
grant create procedure to APPFORGET;

prompt Creating User: APPMKT - MKT App user that processes records marked CONSENT::EMAIL
create user APPMKT identified by Oracle123;

prompt Creating User: APPBI - BI App user that processes records marked CONSENT::ANALYTICS
create user APPBI identified by Oracle123;

prompt Creating User: APP3RD - 3rd Party App user that processes records marked CONSENT::THIRDPARTY
create user APP3RD identified by Oracle123;

prompt Creating User: AppPreference - Preference setting App user that can process all records
create user AppPreference identified by Oracle123;
grant create procedure to AppPreference;

grant create session to APPMKT, APPBI, APPFORGET, APP3RD, AppPreference;
grant insert, update, select on APPCRM.CRM_CUSTOMER to APPMKT, APPBI, APPFORGET, APP3RD, AppPreference;
set pause "Press [Enter] to continue"

------------------------------------------------------------
-- Step 1: Configure and Enable Label Security in the pdb --
------------------------------------------------------------

EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;

spool off
EOF
