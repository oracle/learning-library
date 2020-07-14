#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null
#04_label_sec_in_action.sh

source $DBSEC_ADMIN/cdb.env 

#echo "Start the cdb.environment..."
#$DBSEC_HOME/00-init_env/admin/start_cdb.sh

$ORACLE_HOME/bin/sqlplus /nolog << EOF

set trimspool on
set lines 180
set pages 999
set echo on

spool 04_label_sec_in_action.out

prompt Marketing App would only show 124 records. Can process data labeled: CNST::EMAIL and CNST::ANALYTICS, EMAIL
conn APPMKT/Oracle123@pdb1
select count(*) from APPCRM.CRM_CUSTOMER;

prompt BI App would only show 211 records. Can process data labeled: CNST::ANALYTICS, ANON, CNST::ANALYTICS, EMAIL
conn APPBI/Oracle123@pdb1
select count(*) from APPCRM.CRM_CUSTOMER;

prompt App that processes FORGET records would only process 15 records. Can process data labeled: FRGT and ANON
conn APPFORGET/Oracle123@pdb1
select count(*) from APPCRM.CRM_CUSTOMER;

prompt Let's connect as the APP that can be used to set consent. What records can it see? All records - 389.
conn  APPPREFERENCE/Oracle123@pdb1
select count(*) from APPCRM.CRM_CUSTOMER;

prompt What labels are currently in session?
select label from user_sa_session;

prompt What is the session row label?
select SA_SESSION.ROW_LABEL('OLS_DEMO_GDPR') from DUAL;

spool off
EOF
