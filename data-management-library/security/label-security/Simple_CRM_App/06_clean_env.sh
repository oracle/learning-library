#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null
#06_clean_env.sh

source $DBSEC_ADMIN/cdb.env 

#echo "Start the cdb.environment..."
#$DBSEC_HOME/00-init_env/admin/start_cdb.sh

$ORACLE_HOME/bin/sqlplus c##oscar_ols/Oracle123@pdb1 << EOF

set echo on
set feedback on

spool 06_clean_env.out

show user;
show con_name;

col policy_name format a20
col column_name format a20
col status format a15
col short_name format a15

prompt Existing OLS Policies, Levels and Groups
prompt Existing OLS Policies
select policy_name, column_name, status from all_sa_policies;

prompt Existing OLS Levels
select policy_name, level_num, short_name from ALL_SA_LEVELS;

prompt Existing OLS Groups
select policy_name, group_num, short_name from ALL_SA_GROUPS;

conn c##oscar_ols/Oracle123@pdb1;
EXEC SA_SYSDBA.DROP_POLICY(policy_name => 'OLS_DEMO_GDPR');
/

prompt Existing OLS Policies, Levels and Groups
prompt Existing OLS Policies
select policy_name, column_name, status from all_sa_policies;

prompt Existing OLS Levels
select policy_name, level_num, short_name from ALL_SA_LEVELS;

prompt Existing OLS Groups
select policy_name, group_num, short_name from ALL_SA_GROUPS;

prompt Dropping OLS lab users
conn sys/Oracle123@pdb1 as sysdba
drop user appcrm cascade;
drop user appmkt cascade;
drop user appbi cascade;
drop user appforget cascade;
drop user app3rd cascade;
drop user AppPreference cascade;
EXEC LBACSYS.OLS_ENFORCEMENT.DISABLE_OLS;

conn sys/Oracle123@cdb1 as sysdba
drop user c##oscar_ols cascade;

spool off
EOF
