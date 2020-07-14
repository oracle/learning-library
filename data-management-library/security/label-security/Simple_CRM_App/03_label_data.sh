#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null
#03_label_data.sh

source $DBSEC_ADMIN/cdb.env 

#echo "Start the cdb.environment..."
#$DBSEC_HOME/00-init_env/admin/start_cdb.sh

$ORACLE_HOME/bin/sqlplus sys/Oracle123@pdb1 as sysdba << EOF

set trimspool on
set lines 180
set pages 999
set echo on

spool 03_label_data.out

show user;
show con_name;

-----------------------------------------------------------------------
-- Mass Update the labels to get some diversity (Total records: 389) --
-- In real life, we could have created a labelling function to label -- 
-- records based on other column values                              --
-----------------------------------------------------------------------
-- Did not consent or revoked consent: 50 records
UPDATE APPCRM.CRM_CUSTOMER
SET GDPR_COL = CHAR_TO_LABEL('OLS_DEMO_GDPR','NCNST')
where customerid between 1 and 50;

-- Already anonymized: 10 records
UPDATE APPCRM.CRM_CUSTOMER
SET gdpr_col = CHAR_TO_LABEL('OLS_DEMO_GDPR','ANON')
where customerid between 51 and 60;

-- Asked to be forgotten: 5 records
UPDATE APPCRM.CRM_CUSTOMER
SET gdpr_col = CHAR_TO_LABEL('OLS_DEMO_GDPR','FRGT')
where customerid between 61 and 65;

-- Consented to be processed for analytics: 200 records
UPDATE APPCRM.CRM_CUSTOMER
SET gdpr_col = CHAR_TO_LABEL('OLS_DEMO_GDPR','CNST::ANALYTICS')
where customerid between 66 and 265;

-- Consented to be processed for email: 123 records
UPDATE APPCRM.CRM_CUSTOMER
SET gdpr_col = CHAR_TO_LABEL('OLS_DEMO_GDPR','CNST::EMAIL')
where customerid between 266 and 388;

-- Consented to be processed for email and bi: 1 records
UPDATE APPCRM.CRM_CUSTOMER
SET gdpr_col = CHAR_TO_LABEL('OLS_DEMO_GDPR','CNST::EMAIL,ANALYTICS')
where customerid = 389;

commit;

col label format a50
col count format 9999999

prompt Show the count per Label
SELECT LABEL_TO_CHAR (GDPR_COL) LABEL, count(*) count
FROM  APPCRM.CRM_CUSTOMER
GROUP BY GDPR_COL;


spool off
EOF
