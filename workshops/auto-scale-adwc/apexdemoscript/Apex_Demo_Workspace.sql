prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.05.24'
,p_default_workspace_id=>1472078314024846
);
end;
/
prompt  WORKSPACE 1472078314024846
--
-- Workspace, User Group, User, and Team Development Export:
--   Date and Time:   12:04 Friday November 2, 2018
--   Exported By:     ADMIN
--   Export Type:     Workspace Export
--   Version:         18.2.0.00.12
--   Instance ID:     248231472099575
--
-- Import:
--   Using Instance Administration / Manage Workspaces
--   or
--   Using SQL*Plus as the Oracle user APEX_180200
 
begin
    wwv_flow_api.set_security_group_id(p_security_group_id=>1472078314024846);
end;
/
----------------
-- W O R K S P A C E
-- Creating a workspace will not create database schemas or objects.
-- This API creates only the meta data for this APEX workspace
prompt  Creating workspace PDBUSER...
begin
wwv_flow_fnd_user_api.create_company (
  p_id => 1472117795024859
 ,p_provisioning_company_id => 1472078314024846
 ,p_short_name => 'PDBUSER'
 ,p_display_name => 'PDBUSER'
 ,p_first_schema_provisioned => 'PDBUSER'
 ,p_company_schemas => 'PDBUSER'
 ,p_account_status => 'ASSIGNED'
 ,p_allow_plsql_editing => 'Y'
 ,p_allow_app_building_yn => 'Y'
 ,p_allow_packaged_app_ins_yn => 'Y'
 ,p_allow_sql_workshop_yn => 'Y'
 ,p_allow_websheet_dev_yn => 'Y'
 ,p_allow_team_development_yn => 'Y'
 ,p_allow_to_be_purged_yn => 'Y'
 ,p_allow_restful_services_yn => 'Y'
 ,p_source_identifier => 'PDBUSER'
 ,p_webservice_logging_yn => 'Y'
 ,p_path_prefix => 'PDBUSER'
 ,p_files_version => 1
);
end;
/
----------------
-- G R O U P S
--
prompt  Creating Groups...
begin
wwv_flow_fnd_user_api.create_user_group (
  p_id => 1460828040145004,
  p_GROUP_NAME => 'OAuth2 Client Developer',
  p_SECURITY_GROUP_ID => 10,
  p_GROUP_DESC => 'Users authorized to register OAuth2 Client Applications');
end;
/
begin
wwv_flow_fnd_user_api.create_user_group (
  p_id => 1460758914145004,
  p_GROUP_NAME => 'RESTful Services',
  p_SECURITY_GROUP_ID => 10,
  p_GROUP_DESC => 'Users authorized to use RESTful Services with this workspace');
end;
/
begin
wwv_flow_fnd_user_api.create_user_group (
  p_id => 1460696089145003,
  p_GROUP_NAME => 'SQL Developer',
  p_SECURITY_GROUP_ID => 10,
  p_GROUP_DESC => 'Users authorized to use SQL Developer with this workspace');
end;
/
prompt  Creating group grants...
----------------
-- U S E R S
-- User repository for use with APEX cookie-based authentication.
--
prompt  Creating Users...
begin
wwv_flow_fnd_user_api.create_fnd_user (
  p_user_id                      => '1471981410024846',
  p_user_name                    => 'ADMIN',
  p_first_name                   => 'matt',
  p_last_name                    => 'theodoseau',
  p_description                  => '',
  p_email_address                => 'matt.theodoseau@oracle.com',
  p_web_password                 => 'CA07045208ED357895C45C6B8B0F4397CC5A84CC841DE5B6836D8BD41517E7A8A56A868020D7D509592CD0591E4A4EAC8EAEFC939B7271DC8E82AFB9B6F3702A',
  p_web_password_format          => '5;5;10000',
  p_group_ids                    => '',
  p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
  p_default_schema               => 'PDBUSER',
  p_account_locked               => 'N',
  p_account_expiry               => to_date('201810050058','YYYYMMDDHH24MI'),
  p_failed_access_attempts       => 0,
  p_change_password_on_first_use => 'Y',
  p_first_password_use_occurred  => 'N',
  p_allow_app_building_yn        => 'Y',
  p_allow_sql_workshop_yn        => 'Y',
  p_allow_websheet_dev_yn        => 'Y',
  p_allow_team_development_yn    => 'Y',
  p_allow_access_to_schemas      => '');
end;
/
begin
wwv_flow_fnd_user_api.create_fnd_user (
  p_user_id                      => '1472671707040076',
  p_user_name                    => 'APEXDEMO',
  p_first_name                   => 'matt',
  p_last_name                    => 'theodoseau',
  p_description                  => '',
  p_email_address                => 'matt.theodoseau@oracle.com',
  p_web_password                 => '6760DBB53BA0D6AAAA3326C5D2E39448358E9D4397162FFA8DF905960FEC6621B2AA6EB8287FC4156EF27C06BE3D084AC7E064859F3EA87E583C9E8F3B44795C',
  p_web_password_format          => '5;5;10000',
  p_group_ids                    => '',
  p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
  p_default_schema               => 'PDBUSER',
  p_account_locked               => 'N',
  p_account_expiry               => to_date('201810050100','YYYYMMDDHH24MI'),
  p_failed_access_attempts       => 0,
  p_change_password_on_first_use => 'N',
  p_first_password_use_occurred  => 'N',
  p_allow_app_building_yn        => 'Y',
  p_allow_sql_workshop_yn        => 'Y',
  p_allow_websheet_dev_yn        => 'Y',
  p_allow_team_development_yn    => 'Y',
  p_allow_access_to_schemas      => '');
end;
/
----------------
--App Builder Preferences
--
----------------
--Click Count Logs
--
----------------
--csv data loading
--
----------------
--mail
--
----------------
--mail log
--
----------------
--app models
--
----------------
--password history
--
begin
  wwv_flow_api.create_password_history (
    p_id => 1472376913024871,
    p_user_id => 1471981410024846,
    p_password => 'CA07045208ED357895C45C6B8B0F4397CC5A84CC841DE5B6836D8BD41517E7A8A56A868020D7D509592CD0591E4A4EAC8EAEFC939B7271DC8E82AFB9B6F3702A');
end;
/
begin
  wwv_flow_api.create_password_history (
    p_id => 1472784576040086,
    p_user_id => 1472671707040076,
    p_password => '6760DBB53BA0D6AAAA3326C5D2E39448358E9D4397162FFA8DF905960FEC6621B2AA6EB8287FC4156EF27C06BE3D084AC7E064859F3EA87E583C9E8F3B44795C');
end;
/
----------------
--preferences
--
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1490498228464156,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P273_W48571614952501952',
    p_attribute_value => '48572307979502610____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1490667533464651,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P527_W478911116494917969',
    p_attribute_value => '478911808086918993____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1536301237511076,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P516_W478906809191866600',
    p_attribute_value => '478908119205874812____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1594031715451700,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P405_W3852329031687921',
    p_attribute_value => '3853503855690337____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1594471908451885,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P4050_W10642116325440827',
    p_attribute_value => '10643624462441172____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1476170832054790,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'PERSISTENT_ITEM_P1_DISPLAY_MODE',
    p_attribute_value => 'ICONS');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1476392821054801,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P1_W3326806401130228',
    p_attribute_value => '3328003692130542____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1476407755054810,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FB_FLOW_ID',
    p_attribute_value => '100');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1476774889059838,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P1500_W3519715528105919',
    p_attribute_value => '3521529006112497____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1477024348103524,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'PD_GAL_CUR_TAB',
    p_attribute_value => '0');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1477125338104990,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'F4000_1157687726908338238_SPLITTER_STATE',
    p_attribute_value => '155:false');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1477222109104997,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'F4000_203906404237009921_SPLITTER_STATE',
    p_attribute_value => '610:false');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1483436987677171,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'F4000_203904827661009901_SPLITTER_STATE',
    p_attribute_value => '280:false');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1484000464995713,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P4110_W1548412223182178',
    p_attribute_value => '1550029190194632____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1484372615035006,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4500_P1004_W467833818073240350',
    p_attribute_value => '467836414517307027____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1489755957155796,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'PD_PE_CODE_EDITOR_DLG_W',
    p_attribute_value => '930');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1500323425121899,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P19_W451745617575288584',
    p_attribute_value => '451746507039288843____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1500870674219805,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'PERSISTENT_ITEM_P34_ROWS',
    p_attribute_value => '');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1500956694219811,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP4000_P34_R77549119545304597_SORT',
    p_attribute_value => 'fsp_sort_1_desc');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1501644282225664,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P939_W451352700445603348',
    p_attribute_value => '451353909559603360____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1504830254496178,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P959_W483659607062898467',
    p_attribute_value => '483660631524898748____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1505081097496964,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P431_W478896025956673213',
    p_attribute_value => '478896612991674411____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1505227930497202,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_4000_P514_W478900029710775865',
    p_attribute_value => '478900807852776971____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1581026467849639,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'WIZARD_SQL_SOURCE_TYPE',
    p_attribute_value => 'TABLE');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1587146681878619,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_100_P9_W1581512872849652',
    p_attribute_value => '1586626128878614_N___');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1587367735880939,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP_IR_100_P6_W1800040658857336',
    p_attribute_value => '1803681710860288____');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1587448996882577,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP100_P10_R5163813989022318_SORT',
    p_attribute_value => 'fsp_sort_1_desc');
end;
/
begin
  wwv_flow_api.create_preferences$ (
    p_id => 1587510157883173,
    p_user_id => 'APEXDEMO',
    p_preference_name => 'FSP100_P8_R3314485534149848_SORT',
    p_attribute_value => 'fsp_sort_1_desc');
end;
/
----------------
--query builder
--
----------------
--sql scripts
--
----------------
--sql commands
--
----------------
--user access log
--
begin
  wwv_flow_api.create_user_access_log1$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201811011545','YYYYMMDDHH24MI'),
    p_ip_address => '67.83.99.243',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301820','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.174',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301911','YYYYMMDDHH24MI'),
    p_ip_address => '148.87.23.10',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEX_DEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810251826','YYYYMMDDHH24MI'),
    p_ip_address => '67.83.99.243',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810251826','YYYYMMDDHH24MI'),
    p_ip_address => '67.83.99.243',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDB',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301654','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDB',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301655','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'ADMIN',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301656','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 5,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301659','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301846','YYYYMMDDHH24MI'),
    p_ip_address => '148.87.23.10',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 4,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301846','YYYYMMDDHH24MI'),
    p_ip_address => '148.87.23.10',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 4,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDB',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301655','YYYYMMDDHH24MI'),
    p_ip_address => '67.83.99.243',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301847','YYYYMMDDHH24MI'),
    p_ip_address => '148.87.23.10',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDB',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301656','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 1,
    p_custom_status_text => 'Invalid Login Credentials');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Application Express Authentication',
    p_app => 100,
    p_owner => 'PDBUSER',
    p_access_date => to_date('201810301713','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Application Express Authentication',
    p_app => 100,
    p_owner => 'PDBUSER',
    p_access_date => to_date('201810301732','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810301742','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Application Express Authentication',
    p_app => 100,
    p_owner => 'PDBUSER',
    p_access_date => to_date('201810301746','YYYYMMDDHH24MI'),
    p_ip_address => '137.254.7.186',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
begin
  wwv_flow_api.create_user_access_log2$ (
    p_login_name => 'APEXDEMO',
    p_auth_method => 'Internal Authentication',
    p_app => 4500,
    p_owner => 'APEX_180200',
    p_access_date => to_date('201810181216','YYYYMMDDHH24MI'),
    p_ip_address => '67.83.99.243',
    p_remote_user => 'APEX_PUBLIC_USER',
    p_auth_result => 0,
    p_custom_status_text => '');
end;
/
prompt Check Compatibility...
begin
-- This date identifies the minimum version required to import this file.
wwv_flow_team_api.check_version(p_version_yyyy_mm_dd=>'2010.05.13');
end;
/
 
begin wwv_flow.g_import_in_progress := true; wwv_flow.g_user := USER; end; 
/
 
--
prompt ...news
--
begin
null;
end;
/
--
prompt ...links
--
begin
null;
end;
/
--
prompt ...bugs
--
begin
null;
end;
/
--
prompt ...events
--
begin
null;
end;
/
--
prompt ...feature types
--
begin
null;
end;
/
--
prompt ...features
--
begin
null;
end;
/
--
prompt ...feature map
--
begin
null;
end;
/
--
prompt ...tasks
--
begin
null;
end;
/
--
prompt ...feedback
--
begin
null;
end;
/
--
prompt ...task defaults
--
begin
null;
end;
/
 
prompt ...workspace objects
 
 
prompt ...RESTful Services
 
-- SET SCHEMA
 
begin
 
   wwv_flow_api.g_id_offset := 0;
   wwv_flow_hint.g_schema   := 'PDBUSER';
   wwv_flow_hint.check_schema_privs;
 
end;
/

 
--------------------------------------------------------------------
prompt  SCHEMA PDBUSER - User Interface Defaults, Table Defaults
--
-- Import using sqlplus as the Oracle user: APEX_180200
-- Exported 12:04 Friday November 2, 2018 by: ADMIN
--
 
--------------------------------------------------------------------
prompt User Interface Defaults, Attribute Dictionary
--
-- Exported 12:04 Friday November 2, 2018 by: ADMIN
--
-- SHOW EXPORTING WORKSPACE
 
begin
 
   wwv_flow_api.g_id_offset := 0;
   wwv_flow_hint.g_exp_workspace := 'PDBUSER';
 
end;
/

begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
