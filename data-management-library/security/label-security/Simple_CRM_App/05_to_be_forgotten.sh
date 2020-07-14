#!/bin/bash

#05_to_be_forgotten.sh

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

source $DBSEC_ADMIN/cdb.env 

#echo "Start the cdb.environment..."
#$DBSEC_HOME/00-init_env/admin/start_cdb.sh

$ORACLE_HOME/bin/sqlplus appforget/Oracle123@pdb1 << EOF

set trimspool on
set lines 180
set pages 999
set echo on

spool 05_to_be_forgotten.out

show user;
show con_name;

prompt Create procedure to process requests to be forgotten
-- run as APPFORGET (def_level: FRGT)
prompt For anonymization purposes...

create or replace procedure process_data 
as
v_session_label VARCHAR2(4000);
v_cnt   number;

CURSOR c1 IS
    SELECT first_name, last_name, email
      FROM APPCRM.CRM_CUSTOMER
     WHERE gdpr_col = CHAR_TO_LABEL('OLS_DEMO_GDPR','FRGT::');
BEGIN

SELECT label 
  INTO v_session_label
  FROM user_sa_session;

FOR item IN c1
  LOOP
    DBMS_OUTPUT.PUT_LINE('Processing Data for = ' || item.first_name||' '||item.last_name || ' - email = ' || item.email);
    v_cnt:=c1%ROWCOUNT;
  END LOOP;

DBMS_OUTPUT.PUT_LINE('User Session Label = ' || v_session_label);
DBMS_OUTPUT.PUT_LINE('Employees Processed = ' ||v_cnt);
END;
/

Prompt These would be the records to be anonimized...
set serverout on
exec process_data;


Prompt Create a procedure to forget customers
conn AppPreference/Oracle123@pdb1

create or replace procedure forget_me (p_customerid number) 
as
BEGIN
  UPDATE APPCRM.CRM_CUSTOMER
     SET GDPR_COL = CHAR_TO_LABEL('OLS_DEMO_GDPR','FRGT::')
   WHERE customerid = p_customerid;

COMMIT;

DBMS_OUTPUT.PUT_LINE('User ' || p_customerid||' is now forgotten.' );
END;
/

col label format a25
col count format 999999

Prompt Lets check the current number of requests to be forgotten
SELECT LABEL_TO_CHAR (GDPR_COL) LABEL, count(*) count 
FROM  APPCRM.CRM_CUSTOMER GROUP BY GDPR_COL;

Prompt User 100 asked to be forgotten
set serverout on
exec forget_me(100);

Prompt How many records are marked FRGT now...
SELECT LABEL_TO_CHAR (GDPR_COL) LABEL, count(*) count 
FROM  APPCRM.CRM_CUSTOMER GROUP BY GDPR_COL;

spool off
EOF
