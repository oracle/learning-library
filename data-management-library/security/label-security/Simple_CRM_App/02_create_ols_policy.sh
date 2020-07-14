#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

#02_create_ols_policy.sh

source $DBSEC_ADMIN/cdb.env 

#echo "Start the cdb.environment..."
#$DBSEC_HOME/00-init_env/admin/start_cdb.sh

$ORACLE_HOME/bin/sqlplus c##oscar_ols/Oracle123@pdb1 << EOF

set trimspool on
set lines 180
set pages 999
set echo on

spool 02_create_ols_policy.out

show user;
show con_name;

-------------------------------------------------
-- Step 1: Create Oracle Label Security Policy --
-------------------------------------------------
prompt Create OLS Policy
BEGIN
 SA_SYSDBA.CREATE_POLICY (
  policy_name      => 'OLS_DEMO_GDPR',
  column_name      => 'GDPR_COL',
  default_options => 'READ_CONTROL,LABEL_DEFAULT,HIDE');
END;
/

--------------------------------------------------------------
-- Step 2: Create Data Labels for the Label Security Policy --
--------------------------------------------------------------
conn c##oscar_ols/Oracle123@pdb1
Prompt Create Data Labels
prompt Create CONSENT level
BEGIN
 SA_COMPONENTS.CREATE_LEVEL (
   policy_name   => 'OLS_DEMO_GDPR',
   level_num     => 10,
   short_name    => 'CNST',
   long_name     => 'CONSENT');
END;
/

prompt Create ANONYMIZED level
BEGIN
 SA_COMPONENTS.CREATE_LEVEL (
   policy_name   => 'OLS_DEMO_GDPR',
   level_num     => 20,
   short_name    => 'ANON',
   long_name     => 'ANONYMIZED');
END;
/

prompt Create FORGET level
BEGIN
 SA_COMPONENTS.CREATE_LEVEL (
   policy_name   => 'OLS_DEMO_GDPR',
   level_num     => 30,
   short_name    => 'FRGT',
   long_name     => 'FORGET');
END;
/

prompt Create NOCONSENT level
BEGIN
 SA_COMPONENTS.CREATE_LEVEL (
   policy_name   => 'OLS_DEMO_GDPR',
   level_num     => 40,
   short_name    => 'NCNST',
   long_name     => 'NOCONSENT');
END;
/

-- Create Groups
-- In our example we used a hierarchy of groups
-- to control which data can be processed (based on given consent)
-- DATA_PROCESSING
	-- CAMPAIGN_MGMT
	  -- EMAIL
    -- POST_MAIL
    -- ONLINE_ADS
	-- ANALYTICS
    -- REC_ENGINE
	-- THIRDPARTY
	  -- CONTACT_DETAILS
    -- PREF_DETAILS
    -- PURCH_HIST

prompt Create DATA_PROCESSING group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1000
 , short_name => 'DT_PROC'
 , long_name => 'DATA_PROCESSING'
 , parent_name => null); 
end; 
/

prompt Create CAMPAIGN_MGMT group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1100
 , short_name => 'CAMP_MGMT'
 , long_name => 'CAMPAIGN_MGMT'
 , parent_name => 'DT_PROC'); 
end;
/

prompt Create EMAIL group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1210
 , short_name => 'EMAIL'
 , long_name => 'EMAIL'
 , parent_name => 'CAMP_MGMT'); 
end; 
/


prompt Create POST_MAIL group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1220
 , short_name => 'POST_MAIL'
 , long_name => 'POST_MAIL'
 , parent_name => 'CAMP_MGMT'); 
end; 
/


prompt Create ONLINE_ADS group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1230
 , short_name => 'WEB_ADS'
 , long_name => 'WEB_ADS'
 , parent_name => 'CAMP_MGMT'); 
end; 
/


prompt Create ANALYTICS group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1300
 , short_name => 'ANALYTICS'
 , long_name => 'ANALYTICS'
 , parent_name => 'DT_PROC'); 
end;
/


prompt Create REC_ENGINE group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1310
 , short_name => 'REC_ENGINE'
 , long_name => 'RECOMMENDATION_ENGINE'
 , parent_name => 'ANALYTICS'); 
end;
/


prompt Create THIRDPARTY group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1400
 , short_name => 'THIRDPARTY'
 , long_name => 'THIRDPARTY'
 , parent_name => 'DT_PROC'); 
end; 
/

prompt Create CONTACT_DETAILS group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1410
 , short_name => 'CONTACT_DET'
 , long_name => 'CONTACT_DETAILS'
 , parent_name => 'THIRDPARTY'); 
end; 
/

prompt Create PREFERENCE_DETAILS group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1420
 , short_name => 'PREF_DETAILS'
 , long_name => 'PREFERENCE_DETAILS'
 , parent_name => 'THIRDPARTY'); 
end; 
/

prompt Create PURCHASE_HIST group
begin 
 LBACSYS.SA_COMPONENTS.CREATE_GROUP(
   policy_name => 'OLS_DEMO_GDPR'
 , group_num => 1430
 , short_name => 'PURCH_HIST'
 , long_name => 'PURCHASE_HIST'
 , parent_name => 'THIRDPARTY'); 
end; 
/

-- Create Data Labels
-- The label is automatically designated as a valid data label. This functionality limits the labels that can be assigned to data. 
-- If a user widthraws consent the row label will have that compartment removed.
-- Allowed Labels: (Trim down/add to suite the use cases)
--
-- CNST::                                         500
-- CNST::DT_PROC                                  1000
-- CNST::CAMP_MGMT                                1100
-- CNST::ANALYTICS                                1200    
-- CNST::THIRDPARTY                               1300  
-- CNST::CAMP_MGMT,ANALYTICS,THIRDPARTY           1160
-- CNST::CAMP_MGMT,ANALYTICS                      1170
-- CNST::CAMP_MGMT,THIRDPARTY                     1180
-- CNST::ANALYTICS,THIRDPARTY                     1190
-- CNST::EMAIL                                    1110
-- CNST::POST_MAIL                                1120
-- CNST::WEB_ADS                                  1130  
-- CNST::EMAIL,POST_MAIL                          1140
-- CNST::EMAIL,WEB_ADS                            1150
-- CNST::POST_MAIL,WEB_ADS                        1160
-- CNST::REC_ENGINE                               1210
-- CNST::CONTACT_DETAILS                          1310
-- CNST::PREF_DETAILS                             1320        
-- CNST::PURCH_HIST                               1330        
-- CNST::CONTACT_DETAILS,PREF_DETAILS             1340
-- CNST::CONTACT_DETAILS,PURCH_HIST               1350
-- CNST::PREF_DETAILS,PURCH_HIST                  1360
-- FORGET::                                       700
-- ANON::                                         800
-- NOCONSENT::                                    999


BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '500',
  label_value     => 'CNST::',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1000',
  label_value     => 'CNST::DT_PROC',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1100',
  label_value     => 'CNST::CAMP_MGMT',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1200',
  label_value     => 'CNST::ANALYTICS',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1300',
  label_value     => 'CNST::THIRDPARTY',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1160',
  label_value     => 'CNST::CAMP_MGMT,ANALYTICS,THIRDPARTY',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1170',
  label_value     => 'CNST::CAMP_MGMT,ANALYTICS',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1180',
  label_value     => 'CNST::CAMP_MGMT,THIRDPARTY',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1190',
  label_value     => 'CNST::ANALYTICS,THIRDPARTY',
  data_label      => TRUE);
END;
/


BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1110',
  label_value     => 'CNST::EMAIL',
  data_label      => TRUE);
END;
/


BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1120',
  label_value     => 'CNST::POST_MAIL',
  data_label      => TRUE);
END;
/


BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1130',
  label_value     => 'CNST::WEB_ADS',
  data_label      => TRUE);
END;
/


BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1140',
  label_value     => 'CNST::EMAIL,POST_MAIL',
  data_label      => TRUE);
END;
/



BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1145',
  label_value     => 'CNST::EMAIL,ANALYTICS',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1150',
  label_value     => 'CNST::EMAIL,WEB_ADS',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1195',
  label_value     => 'CNST::POST_MAIL,WEB_ADS',
  data_label      => TRUE);
END;
/


BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1210',
  label_value     => 'CNST::REC_ENGINE',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1310',
  label_value     => 'CNST::CONTACT_DET',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1320',
  label_value     => 'CNST::PREF_DETAILS',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1330',
  label_value     => 'CNST::PURCH_HIST',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1340',
  label_value     => 'CNST::CONTACT_DET,PREF_DETAILS',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1350',
  label_value     => 'CNST::CONTACT_DET,PURCH_HIST',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '1360',
  label_value     => 'CNST::PREF_DETAILS,PURCH_HIST',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '700',
  label_value     => 'FRGT::',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '800',
  label_value     => 'ANON::',
  data_label      => TRUE);
END;
/

BEGIN
 SA_LABEL_ADMIN.CREATE_LABEL  (
  policy_name     => 'OLS_DEMO_GDPR',
  label_tag       => '999',
  label_value     => 'NCNST::',
  data_label      => TRUE);
END;
/

prompt Set User Labels...
------------------------
-- Set the User Labels
------------------------
-- USERS:
--    AppPreference
--    APPFORGET
--    APPMKT 
--    APPBI 
--    APP3RD 
--------------------------------------------------------------------------
-- Assing level CONSENT and GROUP to the APPPREFERENCE user
-- APPPREFERENCE, will be able to process all data
--------------------------------------------------------------------------

prompt Set Levels for APPPREFERENCE
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APPPREFERENCE', 
  max_level     => 'NCNST',
  min_level     => 'CNST',
  def_level     => 'NCNST',
  row_level     => 'CNST');
END;
/

prompt Set Group for APPPREFERENCE
BEGIN
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APPPREFERENCE', 
  READ_GROUPS   => 'DT_PROC',
  WRITE_GROUPS  => 'DT_PROC',
  DEF_GROUPS    => 'DT_PROC',
  ROW_GROUPS    => 'DT_PROC');
END;
/

--------------------------------------------------------------------------
-- Assing level FRGT to user APPFORGET
-- APPFORGET, will be able to process data marked as to be forgotten
--------------------------------------------------------------------------
prompt Set Level for APPFORGET
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APPFORGET', 
  max_level     => 'FRGT',
  min_level     => 'ANON',
  def_level     => 'FRGT',
  row_level     => 'FRGT');
END;
/

-------------------------------------------------------------------------------
-- Assing level CONSENT to user APPMKT and group EMAIL
-- APPMKT, will be able to process data belonging to group EMAIL only
-------------------------------------------------------------------------------
prompt Set Level for APPMKT
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APPMKT', 
  max_level     => 'CNST',
  min_level     => 'CNST',
  def_level     => 'CNST',
  row_level     => 'CNST');
END;
/

prompt Set Group for APPMKT
BEGIN
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APPMKT', 
  READ_GROUPS   => 'EMAIL',
  WRITE_GROUPS  => 'EMAIL',
  DEF_GROUPS    => 'EMAIL',
  ROW_GROUPS    => 'EMAIL');
END;
/

-------------------------------------------------------------------------------
-- Assing level CONSENT to user APPBI
-- APPBI, will be able to process data belonging to group ANALYTICS
-------------------------------------------------------------------------------
prompt Set Level for APPBI
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APPBI', 
  max_level     => 'ANON',
  min_level     => 'CNST',
  def_level     => 'ANON',
  row_level     => 'ANON');
END;
/

prompt Set Group for APPBI
BEGIN
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APPBI', 
  READ_GROUPS   => 'ANALYTICS',
  WRITE_GROUPS  => 'ANALYTICS',
  DEF_GROUPS    => 'ANALYTICS',
  ROW_GROUPS    => 'ANALYTICS');
END;
/


-------------------------------------------------------------------------------
-- Assing level CONSENT to user APP3RD
-- APP3RD, will be able to process data belonging to group THIRDPARTY
-------------------------------------------------------------------------------
prompt Set Level for APP3RD
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APP3RD', 
  max_level     => 'CNST',
  min_level     => 'CNST',
  def_level     => 'CNST',
  row_level     => 'CNST');
END;
/

prompt Set Group for APP3RD
BEGIN
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'OLS_DEMO_GDPR',
  user_name     => 'APP3RD', 
  READ_GROUPS   => 'THIRDPARTY',
  WRITE_GROUPS  => 'THIRDPARTY',
  DEF_GROUPS    => 'THIRDPARTY',
  ROW_GROUPS    => 'THIRDPARTY');
END;
/

BEGIN
 SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
  policy_name    => 'OLS_DEMO_GDPR',
  schema_name    => 'APPCRM', 
  table_name     => 'CRM_CUSTOMER',
  table_options  => 'READ_CONTROL,UPDATE_CONTROL',
  label_function => NULL,
  predicate      => NULL);
END;
/

spool off
EOF
