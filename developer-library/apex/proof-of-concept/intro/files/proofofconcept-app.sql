prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>15286096474620102
,p_default_application_id=>117
,p_default_id_offset=>0
,p_default_owner=>'WORKSHOPATP'
);
end;
/
 
prompt APPLICATION 117 - Quick Projects
--
-- Application Export:
--   Application:     117
--   Name:            Quick Projects
--   Date and Time:   09:27 Wednesday August 12, 2020
--   Exported By:     WORKSHOPATP
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     33
--       Items:                   99
--       Validations:             16
--       Processes:               37
--       Regions:                 79
--       Buttons:                 65
--       Dynamic Actions:         25
--     Shared Components:
--       Logic:
--         App Settings:           2
--         Build Options:          6
--       Navigation:
--         Lists:                  8
--         Breadcrumbs:            1
--           Entries:              8
--       Security:
--         Authentication:         1
--         Authorization:          3
--         ACL Roles:              3
--       User Interface:
--         Themes:                 1
--         Templates:
--           Page:                 9
--           Region:              16
--           Label:                7
--           List:                13
--           Popup LOV:            1
--           Calendar:             1
--           Breadcrumb:           1
--           Button:               3
--           Report:              11
--         LOVs:                  14
--         Shortcuts:              1
--       Globalization:
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included (auto-install)
--       Install scripts:          2
--   Version:         20.1.0.00.13
--   Instance ID:     9487797534824556
--

prompt --application/delete_application
begin
wwv_flow_api.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'WORKSHOPATP')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Quick Projects')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'QUICK-PROJECTS')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'5D1E76B4C8CC096BF710374965ED0A45A24C3B4252EB269B0F0B3B5A8F5E0911'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'19.2'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DD-MON-YYYY'
,p_date_time_format=>'DD-MON-YYYY HH24:MI'
,p_timestamp_format=>'DD-MON-YYYY HH24:MI'
,p_timestamp_tz_format=>'DD-MON-YYYY HH24:MI'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_documentation_banner=>'Application created from create application wizard 2020.08.12.'
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(17625077645408888)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'Quick Projects'
,p_app_builder_icon_name=>'app-icon.svg'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_runtime_api_usage=>'T'
,p_security_scheme=>wwv_flow_api.id(17768290746408972)
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'Quick Projects'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812092731'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>3
,p_ui_type_name => null
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_menu
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(17625823169408889)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(17785139332409000)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(17786654179409001)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Team Members'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(17814981680409025)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Projects'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(17839865455409046)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Milestones'
,p_list_item_link_target=>'f?p=&APP_ID.:6:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table-pointer'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(17850702005409063)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Tasks'
,p_list_item_link_target=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(17879908726409087)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'To Dos'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(17904076774409108)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Links'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18201795857409408)
,p_list_item_display_sequence=>10000
,p_list_item_link_text=>'Administration'
,p_list_item_link_target=>'f?p=&APP_ID.:10000:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-user-wrench'
,p_security_scheme=>wwv_flow_api.id(17768108323408972)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_bar
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(17763788787408965)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18198397005409405)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Feedback'
,p_list_item_link_target=>'f?p=&APP_ID.:10050:&SESSION.::&DEBUG.:RP,10050:P10050_PAGE_ID:&APP_PAGE_ID.:'
,p_list_item_icon=>'fa-comment-o'
,p_list_text_02=>'icon-only'
,p_required_patch=>wwv_flow_api.id(17765617625408970)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18198647219409406)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'About'
,p_list_item_icon=>'fa-question-circle-o'
,p_list_text_02=>'icon-only'
,p_required_patch=>wwv_flow_api.id(17766194438408970)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18199140754409406)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Page Help'
,p_list_item_link_target=>'f?p=&APP_ID.:10061:&SESSION.::&DEBUG.::P10061_PAGE_ID:&APP_PAGE_ID.:'
,p_list_item_icon=>'fa-question-circle-o'
,p_parent_list_item_id=>wwv_flow_api.id(18198647219409406)
,p_list_text_02=>'icon-only'
,p_required_patch=>wwv_flow_api.id(17766194438408970)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18199530516409406)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_api.id(18198647219409406)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18199927510409406)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'About Page'
,p_list_item_link_target=>'f?p=&APP_ID.:10060:&SESSION.::&DEBUG.:10060'
,p_list_item_icon=>'fa-info-circle-o'
,p_parent_list_item_id=>wwv_flow_api.id(18198647219409406)
,p_required_patch=>wwv_flow_api.id(17766194438408970)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18200217004409407)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'&APP_USER.'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18200775733409407)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'---'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_api.id(18200217004409407)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18201197951409407)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'Sign Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_parent_list_item_id=>wwv_flow_api.id(18200217004409407)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/page_navigation
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(18062735254409259)
,p_name=>'Page Navigation'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18063181590409260)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Team Members'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18063575873409260)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Projects'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18063904890409260)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Milestones'
,p_list_item_link_target=>'f?p=&APP_ID.:6:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table-pointer'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18064342047409260)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Tasks'
,p_list_item_link_target=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18064769703409261)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'To Dos'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18065142730409261)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Links'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/application_configuration
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(18202803917409409)
,p_name=>'Application Configuration'
,p_list_status=>'PUBLIC'
,p_required_patch=>wwv_flow_api.id(17765856857408970)
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18203291213409409)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Configuration Options'
,p_list_item_link_target=>'f?p=&APP_ID.:10010:&SESSION.::&DEBUG.:10010:::'
,p_list_item_icon=>'fa-sliders'
,p_list_text_01=>'Enable or disable application features'
,p_required_patch=>wwv_flow_api.id(17765856857408970)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/user_interface
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(18203520541409409)
,p_name=>'User Interface'
,p_list_status=>'PUBLIC'
,p_required_patch=>wwv_flow_api.id(17766246912408970)
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18203970797409409)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Theme Style Selection'
,p_list_item_link_target=>'f?p=&APP_ID.:10020:&SESSION.::&DEBUG.:10020:::'
,p_list_item_icon=>'fa-paint-brush'
,p_list_text_01=>'Set the default application look and feel'
,p_required_patch=>wwv_flow_api.id(17766246912408970)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/activity_reports
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(18204296141409410)
,p_name=>'Activity Reports'
,p_list_status=>'PUBLIC'
,p_required_patch=>wwv_flow_api.id(17765587082408970)
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18204658928409410)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Dashboard'
,p_list_item_link_target=>'f?p=&APP_ID.:10030:&SESSION.::&DEBUG.:10030:::'
,p_list_item_icon=>'fa-area-chart'
,p_list_text_01=>'View application activity metrics'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18205028127409410)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Top Users'
,p_list_item_link_target=>'f?p=&APP_ID.:10031:&SESSION.::&DEBUG.:10031:::'
,p_list_item_icon=>'fa-user-chart'
,p_list_text_01=>'Report of page views aggregated by user'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18205429467409410)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Application Error Log'
,p_list_item_link_target=>'f?p=&APP_ID.:10032:&SESSION.::&DEBUG.:10032:::'
,p_list_item_icon=>'fa-exclamation'
,p_list_text_01=>'Report of errors logged by this application'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18205881269409411)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Page Performance'
,p_list_item_link_target=>'f?p=&APP_ID.:10033:&SESSION.::&DEBUG.:10033:::'
,p_list_item_icon=>'fa-file-chart'
,p_list_text_01=>'Report of activity and performance by application page'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18206246928409411)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Page Views'
,p_list_item_link_target=>'f?p=&APP_ID.:10034:&SESSION.::&DEBUG.:RR,10034:::'
,p_list_item_icon=>'fa-file-search'
,p_list_text_01=>'Report of each page view by user including date of access and elapsed time'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/access_control
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(18206560100409411)
,p_name=>'Access Control'
,p_list_status=>'PUBLIC'
,p_required_patch=>wwv_flow_api.id(17765471426408970)
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18206962572409411)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Users'
,p_list_item_link_target=>'f?p=&APP_ID.:10041:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-users'
,p_list_text_01=>'Change access control settings and disable access control'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18207319067409411)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Access Control'
,p_list_item_link_target=>'f?p=&APP_ID.:10040:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-key'
,p_list_text_01=>'Set level of access for authenticated users of this application'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/feedback
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(18207620580409412)
,p_name=>'Feedback'
,p_list_status=>'PUBLIC'
,p_required_patch=>wwv_flow_api.id(17765617625408970)
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(18208048022409412)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'User Feedback'
,p_list_item_link_target=>'f?p=&APP_ID.:10053:&SESSION.::&DEBUG.:10053:::'
,p_list_item_icon=>'fa-comment-o'
,p_list_text_01=>'Report of all feedback submitted by application users'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/files/app_icon_svg
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3C73766720786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F737667222076696577426F783D22302030203634203634222077696474683D22363422206865696768743D223634223E3C726563742077696474683D2231303025';
wwv_flow_api.g_varchar2_table(2) := '22206865696768743D2231303025222066696C6C3D222333303946444222202F3E3C67206F7061636974793D222E32223E3C7061746820643D224D333220323661322E3520322E3520302031203020322E3520322E3541322E35303320322E3530332030';
wwv_flow_api.g_varchar2_table(3) := '203020302033322032367A6D30203461312E3520312E3520302031203120312E352D312E3541312E35303220312E3530322030203020312033322033307A222F3E3C7061746820643D224D34322E3533362033362E3832386C2D322E3637332D322E3637';
wwv_flow_api.g_varchar2_table(4) := '324131382E3937332031382E39373320302030203020343020333263302D352E3835352D322E3732332D31312E3439332D372E3636382D31352E383734612E352E352030203020302D2E36363420304332362E3732332032302E3530372032342032362E';
wwv_flow_api.g_varchar2_table(5) := '3134352032342033326131382E3937332031382E393733203020302030202E31333720322E3135366C2D322E36373320322E36373341342E39363720342E3936372030203020302032302034302E3336345634372E35612E352E35203020302030202E35';
wwv_flow_api.g_varchar2_table(6) := '2E3568312E30373561332E30303220332E30303220302030203020312E3935322D2E3732326C342E332D332E363835632E3431312E3538322E38343720312E31353520312E33323220312E37313261322E30303120322E30303120302030203020312E35';
wwv_flow_api.g_varchar2_table(7) := '32372E363935682E38323476312E35612E352E3520302030203020312030563436682E38323461322E30303120322E30303120302030203020312E3532372D2E3639352032332E37382032332E373820302030203020312E3332332D312E3731326C342E';
wwv_flow_api.g_varchar2_table(8) := '32393820332E36383461332E30303220332E30303220302030203020312E3935332E3732334834332E35612E352E35203020302030202E352D2E35762D372E31333661342E393720342E39372030203020302D312E3436342D332E3533367A4D33322031';
wwv_flow_api.g_varchar2_table(9) := '372E3137334132322E3839372032322E3839372030203020312033362E363237203233682D392E3235344132322E3839372032322E3839372030203020312033322031372E3137337A4D32322E3837362034362E3532613220322030203020312D312E33';
wwv_flow_api.g_varchar2_table(10) := '2E343831483231762D362E36333661332E39373320332E39373320302030203120312E3137312D322E3832386C322E31342D322E31346132302E3330312032302E33303120302030203020322E39353920372E3335377A6D31312E3231342D312E383633';
wwv_flow_api.g_varchar2_table(11) := '61312E30313420312E3031342030203020312D2E3736362E3334344833322E35762D392E35612E352E352030203020302D312030563435682D2E38323461312E30313420312E3031342030203020312D2E3736362D2E3334344131392E342031392E3420';
wwv_flow_api.g_varchar2_table(12) := '30203020312032352033326131382E3434362031382E34343620302030203120312E3835382D386831302E3238344131382E3434362031382E3434362030203020312033392033326131392E342031392E342030203020312D342E39312031322E363536';
wwv_flow_api.g_varchar2_table(13) := '7A4D3433203437682D2E353735613220322030203020312D312E3330322D2E3438326C2D342E3339332D332E3736356132302E332032302E3320302030203020322E3935382D372E3335386C322E313420322E313441332E39373520332E393735203020';
wwv_flow_api.g_varchar2_table(14) := '3020312034332034302E3336347A222F3E3C2F673E3C7061746820643D224D33322031372E3137334132322E3839372032322E3839372030203020312033362E363237203233682D392E3235344132322E3839372032322E383937203020302031203332';
wwv_flow_api.g_varchar2_table(15) := '2031372E3137337A4D32322E3837362034362E3532613220322030203020312D312E332E343831483231762D362E36333661332E39373320332E39373320302030203120312E3137312D322E3832386C322E31342D322E31346132302E3330312032302E';
wwv_flow_api.g_varchar2_table(16) := '33303120302030203020322E39353920372E3335377A4D3433203437682D2E353735613220322030203020312D312E3330322D2E3438326C2D342E3339332D332E3736356132302E332032302E3320302030203020322E3935382D372E3335386C322E31';
wwv_flow_api.g_varchar2_table(17) := '3420322E313441332E39373520332E3937352030203020312034332034302E3336347A222066696C6C3D222366636662666122206F7061636974793D222E34222F3E3C7061746820643D224D33372E3134322032344832362E3835384131382E34343620';
wwv_flow_api.g_varchar2_table(18) := '31382E3434362030203020302032352033326131392E342031392E3420302030203020342E39312031322E36353620312E30313420312E303134203020302030202E3736362E333434682E383234762D392E35612E352E35203020302031203120305634';
wwv_flow_api.g_varchar2_table(19) := '35682E38323461312E30313420312E303134203020302030202E3736362D2E3334344131392E342031392E342030203020302033392033326131382E3434362031382E3434362030203020302D312E3835382D387A4D333220333161322E3520322E3520';
wwv_flow_api.g_varchar2_table(20) := '302031203120322E352D322E3541322E35303320322E3530332030203020312033322033317A222066696C6C3D222366666622206F7061636974793D222E3935222F3E3C7061746820643D224D333220333061312E3520312E3520302031203120312E35';
wwv_flow_api.g_varchar2_table(21) := '2D312E3541312E35303220312E3530322030203020312033322033307A222066696C6C3D222366636662666122206F7061636974793D222E36222F3E3C2F7376673E';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(17764920513408968)
,p_file_name=>'app-icon.svg'
,p_mime_type=>'image/svg+xml'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/app_icon_css
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6170702D69636F6E207B0A202020206261636B67726F756E642D696D6167653A2075726C286170702D69636F6E2E737667293B0A202020206261636B67726F756E642D7265706561743A206E6F2D7265706561743B0A202020206261636B67726F756E';
wwv_flow_api.g_varchar2_table(2) := '642D73697A653A20636F7665723B0A202020206261636B67726F756E642D706F736974696F6E3A203530253B0A202020206261636B67726F756E642D636F6C6F723A20233330394644423B0A7D';
wwv_flow_api.create_app_static_file(
 p_id=>wwv_flow_api.id(17765206070408969)
,p_file_name=>'app-icon.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(17622901714408887)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(17623256484408887)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_CSS_CALENDAR'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(17623528489408887)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'modern'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(17623876823408887)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attribute_01=>'fa-star'
,p_attribute_04=>'#VALUE#'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(17624142658408887)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
,p_attribute_05=>'SWITCH_CB'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(17624447313408888)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_RICH_TEXT_EDITOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(17624785126408888)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'IG'
);
end;
/
prompt --application/shared_components/security/authorizations/administration_rights
begin
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(17768108323408972)
,p_name=>'Administration Rights'
,p_scheme_type=>'NATIVE_IS_IN_GROUP'
,p_attribute_01=>'Administrator'
,p_attribute_02=>'A'
,p_error_message=>'Insufficient privileges, user is not an Administrator'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/security/authorizations/reader_rights
begin
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(17768290746408972)
,p_name=>'Reader Rights'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if nvl(apex_app_setting.get_value(',
'   p_name => ''ACCESS_CONTROL_SCOPE''),''x'') = ''ALL_USERS'' then',
'    -- allow user not in the ACL to access the application',
'    return true;',
'else',
'    -- require user to have at least one role',
'    return apex_acl.has_user_any_roles (',
'        p_application_id => :APP_ID, ',
'        p_user_name      => :APP_USER);',
'end if;'))
,p_error_message=>'You are not authorized to view this application, either because you have not been granted access, or your account has been locked. Please contact the application administrator.'
,p_caching=>'BY_USER_BY_SESSION'
);
end;
/
prompt --application/shared_components/security/authorizations/contribution_rights
begin
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(17768397041408972)
,p_name=>'Contribution Rights'
,p_scheme_type=>'NATIVE_IS_IN_GROUP'
,p_attribute_01=>'Administrator,Contributor'
,p_attribute_02=>'A'
,p_error_message=>'Insufficient privileges, user is not a Contributor'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/security/app_access_control/administrator
begin
wwv_flow_api.create_acl_role(
 p_id=>wwv_flow_api.id(17767795758408972)
,p_static_id=>'ADMINISTRATOR'
,p_name=>'Administrator'
,p_description=>'Role assigned to application administrators.'
);
end;
/
prompt --application/shared_components/security/app_access_control/contributor
begin
wwv_flow_api.create_acl_role(
 p_id=>wwv_flow_api.id(17767932151408972)
,p_static_id=>'CONTRIBUTOR'
,p_name=>'Contributor'
,p_description=>'Role assigned to application contributors.'
);
end;
/
prompt --application/shared_components/security/app_access_control/reader
begin
wwv_flow_api.create_acl_role(
 p_id=>wwv_flow_api.id(17768073228408972)
,p_static_id=>'READER'
,p_name=>'Reader'
,p_description=>'Role assigned to application readers.'
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_settings
begin
wwv_flow_api.create_app_setting(
 p_id=>wwv_flow_api.id(17769492277408974)
,p_name=>'FEEDBACK_ATTACHMENTS_YN'
,p_value=>'Y'
,p_is_required=>'N'
,p_valid_values=>'Y, N'
,p_on_upgrade_keep_value=>true
,p_required_patch=>wwv_flow_api.id(17765617625408970)
);
wwv_flow_api.create_app_setting(
 p_id=>wwv_flow_api.id(17769745265408974)
,p_name=>'ACCESS_CONTROL_SCOPE'
,p_value=>'ACL_ONLY'
,p_is_required=>'N'
,p_valid_values=>'ACL_ONLY, ALL_USERS'
,p_on_upgrade_keep_value=>true
,p_required_patch=>wwv_flow_api.id(17765471426408970)
,p_comments=>'The default access level given to authenticated users who are not in the access control list'
);
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs/access_roles
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18146883491409364)
,p_lov_name=>'ACCESS_ROLES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select role_name d, role_id r',
'from APEX_APPL_ACL_ROLES where application_id = :APP_ID ',
'order by 1'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
);
end;
/
prompt --application/shared_components/user_interface/lovs/desktop_theme_styles
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18075781251409272)
,p_lov_name=>'DESKTOP THEME STYLES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.name d,',
'    s.theme_style_id r',
'from apex_application_theme_styles s, apex_application_themes t',
'where s.application_id = t.application_id',
'    and s.theme_number = t.theme_number',
'    and s.application_id = :app_id',
'    and t.ui_type_name   = ''DESKTOP''',
'    and t.is_current = ''Yes''',
'order by 1'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_return_column_name=>'R'
,p_display_column_name=>'D'
);
end;
/
prompt --application/shared_components/user_interface/lovs/email_username_format
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18154566139409369)
,p_lov_name=>'EMAIL_USERNAME_FORMAT'
,p_lov_query=>'.'||wwv_flow_api.id(18154566139409369)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18154864202409369)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Email Addresses'
,p_lov_return_value=>'EMAIL'
);
end;
/
prompt --application/shared_components/user_interface/lovs/feedback_rating
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18171693153409382)
,p_lov_name=>'FEEDBACK_RATING'
,p_lov_query=>'.'||wwv_flow_api.id(18171693153409382)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18171989476409383)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Positive'
,p_lov_return_value=>'3'
,p_lov_template=>'<span title="#DISPLAY_VALUE#" aria-label="#DISPLAY_VALUE#"><span class="fa fa-smile-o fa-2x feedback-positive" aria-hidden="true" ></span></span>'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18172306383409383)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Neutral'
,p_lov_return_value=>'2'
,p_lov_template=>'<span title="#DISPLAY_VALUE#" aria-label="#DISPLAY_VALUE#"><span class="fa fa-emoji-neutral fa-2x feedback-neutral" aria-hidden="true" ></span></span>'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18172797980409383)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Negative'
,p_lov_return_value=>'1'
,p_lov_template=>'<span title="#DISPLAY_VALUE#" aria-label="#DISPLAY_VALUE#"><span class="fa fa-frown-o fa-2x feedback-negative" aria-hidden="true" ></span></span>'
);
end;
/
prompt --application/shared_components/user_interface/lovs/feedback_status
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18181743719409390)
,p_lov_name=>'FEEDBACK_STATUS'
,p_lov_query=>'.'||wwv_flow_api.id(18181743719409390)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18182089808409390)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'No Action'
,p_lov_return_value=>'0'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18182480752409390)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Acknowledged'
,p_lov_return_value=>'1'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18182890055409390)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Open'
,p_lov_return_value=>'3'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18183263779409391)
,p_lov_disp_sequence=>4
,p_lov_disp_value=>'Closed'
,p_lov_return_value=>'4'
);
end;
/
prompt --application/shared_components/user_interface/lovs/hol_milestones_name
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(17857911420409069)
,p_lov_name=>'HOL_MILESTONES.NAME'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'HOL_MILESTONES'
,p_return_column_name=>'ID'
,p_display_column_name=>'NAME'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/hol_milestones_name_page_8
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18224007942442494)
,p_lov_name=>'HOL_MILESTONES.NAME PAGE 8'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'HOL_MILESTONES'
,p_query_where=>'project_id = :P8_PROJECT_ID'
,p_return_column_name=>'ID'
,p_display_column_name=>'NAME'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/hol_projects_name
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(17849183181409061)
,p_lov_name=>'HOL_PROJECTS.NAME'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'HOL_PROJECTS'
,p_return_column_name=>'ID'
,p_display_column_name=>'NAME'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18221765883428668)
,p_query_column_name=>'ID'
,p_display_sequence=>10
,p_data_type=>'NUMBER'
,p_is_visible=>'N'
,p_is_searchable=>'N'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18222131951428668)
,p_query_column_name=>'NAME'
,p_heading=>'Name'
,p_display_sequence=>20
,p_data_type=>'VARCHAR2'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18222510350428668)
,p_query_column_name=>'STATUS'
,p_heading=>'Status'
,p_display_sequence=>30
,p_data_type=>'VARCHAR2'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18222988871428669)
,p_query_column_name=>'COMPLETED_DATE'
,p_heading=>'Completed Date'
,p_display_sequence=>40
,p_data_type=>'TIMESTAMP_LTZ'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18223399525428669)
,p_query_column_name=>'DESCRIPTION'
,p_heading=>'Description'
,p_display_sequence=>50
,p_data_type=>'VARCHAR2'
);
end;
/
prompt --application/shared_components/user_interface/lovs/hol_tasks_name
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(17885598273409092)
,p_lov_name=>'HOL_TASKS.NAME'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id',
',      (select p.name from hol_projects p where p.id = t.project_id) project',
',      (select m.name from hol_milestones m where m.id = t.milestone_id) milestone',
',      name',
'from hol_tasks t'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_query_table=>'HOL_TASKS'
,p_return_column_name=>'ID'
,p_display_column_name=>'NAME'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18227526192500684)
,p_query_column_name=>'ID'
,p_display_sequence=>10
,p_data_type=>'NUMBER'
,p_is_visible=>'N'
,p_is_searchable=>'N'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18227897840500684)
,p_query_column_name=>'PROJECT'
,p_heading=>'Project'
,p_display_sequence=>20
,p_data_type=>'VARCHAR2'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18228206501500684)
,p_query_column_name=>'MILESTONE'
,p_heading=>'Milestone'
,p_display_sequence=>30
,p_data_type=>'VARCHAR2'
);
wwv_flow_api.create_list_of_values_cols(
 p_id=>wwv_flow_api.id(18228664199500684)
,p_query_column_name=>'NAME'
,p_heading=>'Name'
,p_display_sequence=>40
,p_data_type=>'VARCHAR2'
);
end;
/
prompt --application/shared_components/user_interface/lovs/hol_team_members_username
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(17820993840409030)
,p_lov_name=>'HOL_TEAM_MEMBERS.USERNAME'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'HOL_TEAM_MEMBERS'
,p_return_column_name=>'ID'
,p_display_column_name=>'USERNAME'
,p_default_sort_column_name=>'USERNAME'
,p_default_sort_direction=>'ASC'
);
end;
/
prompt --application/shared_components/user_interface/lovs/login_remember_username
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(17780365855408996)
,p_lov_name=>'LOGIN_REMEMBER_USERNAME'
,p_lov_query=>'.'||wwv_flow_api.id(17780365855408996)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(17780783984408996)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Remember username'
,p_lov_return_value=>'Y'
);
end;
/
prompt --application/shared_components/user_interface/lovs/timeframe_4_weeks
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18096199609409288)
,p_lov_name=>'TIMEFRAME (4 WEEKS)'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'      val as seconds',
' from table( apex_util.get_timeframe_lov_data )',
'order by insert_order'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_return_column_name=>'SECONDS'
,p_display_column_name=>'DISP'
);
end;
/
prompt --application/shared_components/user_interface/lovs/user_theme_preference
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18076452122409272)
,p_lov_name=>'USER_THEME_PREFERENCE'
,p_lov_query=>'.'||wwv_flow_api.id(18076452122409272)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18076778406409272)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Allow End Users to choose Theme Style'
,p_lov_return_value=>'Yes'
);
end;
/
prompt --application/shared_components/user_interface/lovs/view_as_report_chart
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(18131268775409352)
,p_lov_name=>'VIEW_AS_REPORT_CHART'
,p_lov_query=>'.'||wwv_flow_api.id(18131268775409352)||'.'
,p_location=>'STATIC'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18131593030409352)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Add Report Page'
,p_lov_return_value=>'REPORT'
,p_lov_template=>'<span class="fa fa-table" aria-hidden="true"></span><span class="u-VisuallyHidden">#DISPLAY_VALUE#</span>'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(18131970456409353)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Add Chart Page'
,p_lov_return_value=>'CHART'
,p_lov_template=>'<span class="fa fa-pie-chart" aria-hidden="true"></span><span class="u-VisuallyHidden">#DISPLAY_VALUE#</span>'
);
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_api.create_page_group(
 p_id=>wwv_flow_api.id(17770014052408975)
,p_group_name=>'Administration'
);
end;
/
prompt --application/comments
begin
null;
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_api.create_menu(
 p_id=>wwv_flow_api.id(17625334366408888)
,p_name=>'Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(17625505558408889)
,p_short_name=>'Home'
,p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(17795019527409008)
,p_short_name=>'Team Members'
,p_link=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>2
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(17822743741409031)
,p_short_name=>'Projects'
,p_link=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(17850399146409063)
,p_short_name=>'Milestones'
,p_link=>'f?p=&APP_ID.:6:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>6
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(17860308272409071)
,p_short_name=>'Tasks'
,p_link=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>7
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(17887652465409094)
,p_short_name=>'To Dos'
,p_link=>'f?p=&APP_ID.:9:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>9
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(17910757946409114)
,p_short_name=>'Links'
,p_link=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>11
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(18202634613409409)
,p_short_name=>'Administration'
,p_link=>'f?p=&APP_ID.:10000:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10000
);
end;
/
prompt --application/shared_components/user_interface/templates/page/left_side_column
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17626135339408889)
,p_theme_id=>42
,p_name=>'Left Side Column'
,p_internal_name=>'LEFT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.leftSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-side" id="t_Body_side">#REGION_POSITION_02#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525196570560608698
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17626485076408890)
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17626718596408890)
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17627083195408890)
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17627323513408890)
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17627639398408890)
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17627979472408890)
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17628258983408891)
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17628522340408891)
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/left_and_right_side_columns
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17628982342408891)
,p_theme_id=>42
,p_name=>'Left and Right Side Columns'
,p_internal_name=>'LEFT_AND_RIGHT_SIDE_COLUMNS'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.bothSideCols();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-side" id="t_Body_side">#REGION_POSITION_02#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525203692562657055
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17629277875408891)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17629540485408891)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17629827089408892)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17630104714408892)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17630498263408892)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17630751089408892)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17631048120408892)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17631346356408892)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17631635478408892)
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>6
);
end;
/
prompt --application/shared_components/user_interface/templates/page/login
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17632029951408893)
,p_theme_id=>42
,p_name=>'Login'
,p_internal_name=>'LOGIN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.appLogin();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody--login no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-container">',
'  <header class="t-Login-containerHeader">#REGION_POSITION_01#</header>',
'  <main class="t-Login-containerBody" id="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</main>',
'  <footer class="t-Login-containerFooter">#REGION_POSITION_02#</footer>',
'</div>',
''))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>6
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2099711150063350616
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17632324461408893)
,p_page_template_id=>wwv_flow_api.id(17632029951408893)
,p_name=>'Body Footer'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17632674441408893)
,p_page_template_id=>wwv_flow_api.id(17632029951408893)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17632970991408893)
,p_page_template_id=>wwv_flow_api.id(17632029951408893)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/master_detail
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17634351233408894)
,p_theme_id=>42
,p_name=>'Marquee'
,p_internal_name=>'MASTER_DETAIL'
,p_is_popup=>false
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'))
,p_javascript_code_onload=>'apex.theme42.initializePage.masterDetail();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--masterDetail t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-info" id="t_Body_info">#REGION_POSITION_02#</div>',
'        <div class="t-Body-contentInner" role="main">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1996914646461572319
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17634689410408894)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17634979054408894)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17635224166408895)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17635583783408895)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17635829135408895)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17636181518408895)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17636442403408895)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17636761802408895)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17637081389408895)
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/minimal_no_navigation
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17637446989408896)
,p_theme_id=>42
,p_name=>'Minimal (No Navigation)'
,p_internal_name=>'MINIMAL_NO_NAVIGATION'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES# t-PageBody--noNav" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>4
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2977628563533209425
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17637711659408896)
,p_page_template_id=>wwv_flow_api.id(17637446989408896)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17638011100408896)
,p_page_template_id=>wwv_flow_api.id(17637446989408896)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17638396201408896)
,p_page_template_id=>wwv_flow_api.id(17637446989408896)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17638695255408896)
,p_page_template_id=>wwv_flow_api.id(17637446989408896)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17638931030408897)
,p_page_template_id=>wwv_flow_api.id(17637446989408896)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17639221161408897)
,p_page_template_id=>wwv_flow_api.id(17637446989408896)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17639597429408897)
,p_page_template_id=>wwv_flow_api.id(17637446989408896)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/page/modal_dialog
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17639907376408897)
,p_theme_id=>42
,p_name=>'Modal Dialog'
,p_internal_name=>'MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--standard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'    <div class="t-Dialog-bodyWrapperIn">',
'      <div class="t-Dialog-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--standard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2098960803539086924
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17640236913408897)
,p_page_template_id=>wwv_flow_api.id(17639907376408897)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17640525808408897)
,p_page_template_id=>wwv_flow_api.id(17639907376408897)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17640831623408898)
,p_page_template_id=>wwv_flow_api.id(17639907376408897)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/right_side_column
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17641478676408898)
,p_theme_id=>42
,p_name=>'Right Side Column'
,p_internal_name=>'RIGHT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.rightSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8"> ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" aria-label="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button'
||'>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525200116240651575
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17641794576408898)
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17642022380408898)
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17642358613408898)
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17642617083408899)
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17642927762408899)
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17643226528408899)
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17643552054408899)
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17643843207408899)
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/standard
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17644236651408899)
,p_theme_id=>42
,p_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="t'
||'rue"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">#NAVIGATION_BAR#</div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>1
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>4070909157481059304
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17644552567408900)
,p_page_template_id=>wwv_flow_api.id(17644236651408899)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17644804990408900)
,p_page_template_id=>wwv_flow_api.id(17644236651408899)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17645175513408900)
,p_page_template_id=>wwv_flow_api.id(17644236651408899)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17645479608408900)
,p_page_template_id=>wwv_flow_api.id(17644236651408899)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17645766466408900)
,p_page_template_id=>wwv_flow_api.id(17644236651408899)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17646090658408900)
,p_page_template_id=>wwv_flow_api.id(17644236651408899)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17646318139408901)
,p_page_template_id=>wwv_flow_api.id(17644236651408899)
,p_name=>'Before Content Body'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/page/wizard_modal_dialog
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(17646751789408901)
,p_theme_id=>42
,p_name=>'Wizard Modal Dialog'
,p_internal_name=>'WIZARD_MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.wizardModal();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--wizard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'    <div class="t-Dialog-bodyWrapperIn">',
'      <div class="t-Dialog-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--wizard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2120348229686426515
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17647064985408901)
,p_page_template_id=>wwv_flow_api.id(17646751789408901)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17647304868408901)
,p_page_template_id=>wwv_flow_api.id(17646751789408901)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(17647652048408901)
,p_page_template_id=>wwv_flow_api.id(17646751789408901)
,p_name=>'Wizard Buttons'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/button/icon
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(17740742065408952)
,p_template_name=>'Icon'
,p_internal_name=>'ICON'
,p_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"><'
||'/span></button>'
,p_hot_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-h'
||'idden="true"></span></button>'
,p_reference_id=>2347660919680321258
,p_translate_this_template=>'N'
,p_theme_class_id=>5
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(17741443504408953)
,p_template_name=>'Text'
,p_internal_name=>'TEXT'
,p_template=>'<button onclick="#JAVASCRIPT#" class="t-Button #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_hot_template=>'<button onclick="#JAVASCRIPT#" class="t-Button t-Button--hot #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_reference_id=>4070916158035059322
,p_translate_this_template=>'N'
,p_theme_class_id=>1
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text_with_icon
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(17741566209408953)
,p_template_name=>'Text with Icon'
,p_internal_name=>'TEXT_WITH_ICON'
,p_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-label">#LABEL#'
||'</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_hot_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-'
||'label">#LABEL#</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_reference_id=>2081382742158699622
,p_translate_this_template=>'N'
,p_theme_class_id=>4
,p_preset_template_options=>'t-Button--iconRight'
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/region/alert
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17648207118408902)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">#BODY#</div>',
'    </div>',
'    <div class="t-Alert-buttons">#PREVIOUS##CLOSE##CREATE##NEXT#</div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Alert'
,p_internal_name=>'ALERT'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2039236646100190748
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17648574202408902)
,p_plug_template_id=>wwv_flow_api.id(17648207118408902)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17651912627408904)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">#PREVIOUS##BODY##SUB_REGIONS##NEXT#</div>'
,p_page_plug_template_name=>'Blank with Attributes'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4499993862448380551
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes_no_grid
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17652105806408904)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">#PREVIOUS##BODY##SUB_REGIONS##NEXT#</div>'
,p_page_plug_template_name=>'Blank with Attributes (No Grid)'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES_NO_GRID'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3369790999010910123
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17652480078408904)
,p_plug_template_id=>wwv_flow_api.id(17652105806408904)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17652725993408904)
,p_plug_template_id=>wwv_flow_api.id(17652105806408904)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/buttons_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17652975206408904)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ButtonRegion t-Form--floatLeft #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ButtonRegion-wrap">',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##CLOSE##DELETE#</div></div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--content">',
'      <h2 class="t-ButtonRegion-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      #BODY#',
'      <div class="t-ButtonRegion-buttons">#CHANGE#</div>',
'    </div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Buttons Container'
,p_internal_name=>'BUTTONS_CONTAINER'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>17
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2124982336649579661
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17653242844408905)
,p_plug_template_id=>wwv_flow_api.id(17652975206408904)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17653527746408905)
,p_plug_template_id=>wwv_flow_api.id(17652975206408904)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/carousel_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17655136893408906)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--carousel #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'   <div class="t-Region-carouselRegions">',
'     #SUB_REGIONS#',
'   </div>',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Carousel Container'
,p_internal_name=>'CAROUSEL_CONTAINER'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#plugins/com.oracle.apex.carousel/1.1/com.oracle.apex.carousel#MIN#.js?v=#APEX_VERSION#'))
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-Region--showCarouselControls'
,p_preset_template_options=>'t-Region--hiddenOverflow'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2865840475322558786
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17655449548408906)
,p_plug_template_id=>wwv_flow_api.id(17655136893408906)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17655743628408906)
,p_plug_template_id=>wwv_flow_api.id(17655136893408906)
,p_name=>'Slides'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/collapsible
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17662386249408910)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--hideShow #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems  t-Region-headerItems--controls"><button class="t-Button t-Button--icon t-Button--hideShow" type="button"></button></div>',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#EDIT#</div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#CLOSE#</div>',
'    <div class="t-Region-buttons-right">#CREATE#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #COPY#',
'     #BODY#',
'     #SUB_REGIONS#',
'     #CHANGE#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
' </div>',
'</div>'))
,p_page_plug_template_name=>'Collapsible'
,p_internal_name=>'COLLAPSIBLE'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>1
,p_preset_template_options=>'is-expanded:t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2662888092628347716
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17662634580408910)
,p_plug_template_id=>wwv_flow_api.id(17662386249408910)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17662947491408910)
,p_plug_template_id=>wwv_flow_api.id(17662386249408910)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/content_block
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17667727194408912)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ContentBlock #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ContentBlock-header">',
'    <div class="t-ContentBlock-headerItems t-ContentBlock-headerItems--title">',
'      <span class="t-ContentBlock-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'      <h1 class="t-ContentBlock-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'      #EDIT#',
'    </div>',
'    <div class="t-ContentBlock-headerItems t-ContentBlock-headerItems--buttons">#CHANGE#</div>',
'  </div>',
'  <div class="t-ContentBlock-body">#BODY#</div>',
'  <div class="t-ContentBlock-buttons">#PREVIOUS##NEXT#</div>',
'</div>',
''))
,p_page_plug_template_name=>'Content Block'
,p_internal_name=>'CONTENT_BLOCK'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-ContentBlock--h1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2320668864738842174
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/hero
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17669729187408913)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-HeroRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-HeroRegion-wrap">',
'    <div class="t-HeroRegion-col t-HeroRegion-col--left"><span class="t-HeroRegion-icon t-Icon #ICON_CSS_CLASSES#"></span></div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--content">',
'      <h1 class="t-HeroRegion-title">#TITLE#</h1>',
'      #BODY#',
'    </div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--right"><div class="t-HeroRegion-form">#SUB_REGIONS#</div><div class="t-HeroRegion-buttons">#NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Hero'
,p_internal_name=>'HERO'
,p_theme_id=>42
,p_theme_class_id=>22
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672571031438297268
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17670074620408914)
,p_plug_template_id=>wwv_flow_api.id(17669729187408913)
,p_name=>'Region Body'
,p_placeholder=>'#BODY#'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_dialog
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17671837072408915)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionDialog" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Dialog'
,p_internal_name=>'INLINE_DIALOG'
,p_theme_id=>42
,p_theme_class_id=>24
,p_default_template_options=>'js-modal:js-draggable:js-resizable'
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2671226943886536762
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17672115330408915)
,p_plug_template_id=>wwv_flow_api.id(17671837072408915)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_popup
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17674132559408916)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionPopup" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Popup'
,p_internal_name=>'INLINE_POPUP'
,p_theme_id=>42
,p_theme_class_id=>24
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>1483922538999385230
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17674446862408916)
,p_plug_template_id=>wwv_flow_api.id(17674132559408916)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/interactive_report
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17677439644408917)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-IRR-region #REGION_CSS_CLASSES#">',
'  <h2 class="u-VisuallyHidden" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Interactive Report'
,p_internal_name=>'INTERACTIVE_REPORT'
,p_theme_id=>42
,p_theme_class_id=>9
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2099079838218790610
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/login
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17678042343408918)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-region t-Form--stretchInputs t-Form--labelsAbove #REGION_CSS_CLASSES#" id="#REGION_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Login-header">',
'    <span class="t-Login-logo #ICON_CSS_CLASSES#"></span>',
'    <h1 class="t-Login-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'  </div>',
'  <div class="t-Login-body">#BODY#</div>',
'  <div class="t-Login-buttons">#NEXT#</div>',
'  <div class="t-Login-links">#EDIT##CREATE#</div>',
'  <div class="t-Login-subRegions">#SUB_REGIONS#</div>',
'</div>'))
,p_page_plug_template_name=>'Login'
,p_internal_name=>'LOGIN'
,p_theme_id=>42
,p_theme_class_id=>23
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672711194551076376
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17678313210408918)
,p_plug_template_id=>wwv_flow_api.id(17678042343408918)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/standard
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17679306367408919)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'     #SUB_REGIONS#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>',
''))
,p_page_plug_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4070912133526059312
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17679665489408919)
,p_plug_template_id=>wwv_flow_api.id(17679306367408919)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17679950363408919)
,p_plug_template_id=>wwv_flow_api.id(17679306367408919)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/tabs_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17686188479408922)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-TabsRegion #REGION_CSS_CLASSES# apex-tabs-region" #REGION_ATTRIBUTES# id="#REGION_STATIC_ID#">',
'  #BODY#',
'  <div class="t-TabsRegion-items">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Tabs Container'
,p_internal_name=>'TABS_CONTAINER'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>5
,p_preset_template_options=>'t-TabsRegion-mod--simple'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3221725015618492759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17686406338408922)
,p_plug_template_id=>wwv_flow_api.id(17686188479408922)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17686747615408923)
,p_plug_template_id=>wwv_flow_api.id(17686188479408922)
,p_name=>'Tabs'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/title_bar
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17688764363408924)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-BreadcrumbRegion #REGION_CSS_CLASSES#"> ',
'  <div class="t-BreadcrumbRegion-body">',
'    <div class="t-BreadcrumbRegion-breadcrumb">',
'      #BODY#',
'    </div>',
'    <div class="t-BreadcrumbRegion-title">',
'      <h1 class="t-BreadcrumbRegion-titleText">#TITLE#</h1>',
'    </div>',
'  </div>',
'  <div class="t-BreadcrumbRegion-buttons">#PREVIOUS##CLOSE##DELETE##HELP##CHANGE##EDIT##COPY##CREATE##NEXT#</div>',
'</div>'))
,p_page_plug_template_name=>'Title Bar'
,p_internal_name=>'TITLE_BAR'
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BreadcrumbRegion--showBreadcrumb'
,p_preset_template_options=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2530016523834132090
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/wizard_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(17689739537408924)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Wizard #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Wizard-header">',
'    <h1 class="t-Wizard-title">#TITLE#</h1>',
'    <div class="u-Table t-Wizard-controls">',
'      <div class="u-Table-fit t-Wizard-buttons">#PREVIOUS##CLOSE#</div>',
'      <div class="u-Table-fill t-Wizard-steps">',
'        #BODY#',
'      </div>',
'      <div class="u-Table-fit t-Wizard-buttons">#NEXT#</div>',
'    </div>',
'  </div>',
'  <div class="t-Wizard-body">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Wizard Container'
,p_internal_name=>'WIZARD_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Wizard--hideStepsXSmall'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2117602213152591491
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(17690061935408924)
,p_plug_template_id=>wwv_flow_api.id(17689739537408924)
,p_name=>'Wizard Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/list/badge_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17715078125408938)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_theme_id=>42
,p_theme_class_id=>3
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--cols t-BadgeList--3cols:t-BadgeList--circular'
,p_list_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Value'
,p_a02_label=>'List item CSS Classes'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'Link Classes'
,p_reference_id=>2062482847268086664
,p_list_template_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A01: Large Number',
'A02: List Item Classes',
'A03: Link Attributes'))
);
end;
/
prompt --application/shared_components/user_interface/templates/list/cards
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17719030469408940)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item is-active #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3><h4 class="t-Card-subtitle">#A07#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3><h4 class="t-Card-subtitle">#A07#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_list_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Secondary Information'
,p_a03_label=>'Initials'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Attributes'
,p_a06_label=>'Card Color Class'
,p_a07_label=>'Subtitle'
,p_reference_id=>2885322685880632508
);
end;
/
prompt --application/shared_components/user_interface/templates/list/links_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17724619808408943)
,p_list_template_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_list_template_name=>'Links List'
,p_internal_name=>'LINKS_LIST'
,p_theme_id=>42
,p_theme_class_id=>18
,p_list_template_before_rows=>'<ul class="t-LinksList #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<ul class="t-LinksList-list">'
,p_after_sub_list=>'</ul>'
,p_sub_list_item_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_sub_list_item_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_item_templ_curr_w_child=>'<li class="t-LinksList-item is-current is-expanded #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t'
||'-LinksList-badge">#A01#</span></a>#SUB_LISTS#</li>'
,p_item_templ_noncurr_w_child=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'Link Attributes'
,p_a03_label=>'List Item CSS Classes'
,p_reference_id=>4070914341144059318
);
end;
/
prompt --application/shared_components/user_interface/templates/list/media_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17726217906408944)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item is-active #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item  #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-MediaList--showIcons:t-MediaList--showDesc'
,p_list_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Class'
,p_a06_label=>'Icon Color Class'
,p_reference_id=>2066548068783481421
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_bar
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17729079768408946)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Menu Bar'
,p_internal_name=>'MENU_BAR'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  iconType: ''fa'',',
'  menubar: true,',
'  menubarOverflow: true,',
'  callout: e.hasClass("js-menu-callout")',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-showSubMenuIcons'
,p_list_template_before_rows=>'<div class="t-MenuBar #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_reference_id=>2008709236185638887
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_popup
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17730057710408946)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_name=>'Menu Popup'
,p_internal_name=>'MENU_POPUP'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menu", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({ iconType: ''fa'', callout: e.hasClass("js-menu-callout")});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<div id="#PARENT_STATIC_ID#_menu" class="#COMPONENT_CSS_CLASSES#" style="display:none;"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_reference_id=>3492264004432431646
);
end;
/
prompt --application/shared_components/user_interface/templates/list/navigation_bar
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17730617898408946)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Navigation Bar'
,p_internal_name=>'NAVIGATION_BAR'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<ul class="t-NavigationBar #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<div class="t-NavigationBar-menu" style="display: none" id="menu_#PARENT_LIST_ITEM_ID#"><ul>'
,p_after_sub_list=>'</ul></div></li>'
,p_sub_list_item_current=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_sub_templ_curr_w_child=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_templ_noncurr_w_child=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'List  Item CSS Classes'
,p_reference_id=>2846096252961119197
);
end;
/
prompt --application/shared_components/user_interface/templates/list/side_navigation_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17731088352408947)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Side Navigation Menu'
,p_internal_name=>'SIDE_NAVIGATION_MENU'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.treeView#MIN#.js?v=#APEX_VERSION#'
,p_javascript_code_onload=>'apex.jQuery(''body'').addClass(''t-PageBody--leftNav'');'
,p_theme_id=>42
,p_theme_class_id=>19
,p_default_template_options=>'js-defaultCollapsed'
,p_preset_template_options=>'js-navCollapsed--hidden:t-TreeNav--styleA'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-nav" id="t_Body_nav" role="navigation" aria-label="&APP_TITLE!ATTR.">',
'<div class="t-TreeNav #COMPONENT_CSS_CLASSES#" id="t_TreeNav" data-id="#PARENT_STATIC_ID#_tree" aria-label="&APP_TITLE!ATTR."><ul style="display:none">'))
,p_list_template_after_rows=>'</ul></div></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a06_label=>'Link Target'
,p_reference_id=>2466292414354694776
);
end;
/
prompt --application/shared_components/user_interface/templates/list/tabs
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17732655005408948)
,p_list_template_current=>'<li class="t-Tabs-item is-active #A03#" id="#A01#"><a href="#LINK#" class="t-Tabs-link #A04#"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-Tabs-item #A03#" id="#A01#"><a href="#LINK#" class="t-Tabs-link #A04#"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_name=>'Tabs'
,p_internal_name=>'TABS'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Tabs--simple'
,p_list_template_before_rows=>'<ul class="t-Tabs #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_reference_id=>3288206686691809997
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_mega_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17734294624408949)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--noSub is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--noSub #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_list_template_name=>'Top Navigation Mega Menu'
,p_internal_name=>'TOP_NAVIGATION_MEGA_MENU'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-MegaMenu #COMPONENT_CSS_CLASSES#" id="t_MenuNav" style="display:none;">',
'  <div class="a-Menu-content t-MegaMenu-container">',
'    <div class="t-MegaMenu-body">',
'    <ul class="t-MegaMenu-list t-MegaMenu-list--top">'))
,p_list_template_after_rows=>' </ul></div></div></div>'
,p_before_sub_list=>'<ul class="t-MegaMenu-list t-MegaMenu-list--sub">'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_sub_list_item_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--hasSub is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--hasSub #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_sub_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_sub_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Description'
,p_a04_label=>'List Item Class'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_a07_label=>'Badge Class'
,p_a08_label=>'Menu Item Class'
,p_reference_id=>1665447133514362075
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17736008470408949)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Top Navigation Menu'
,p_internal_name=>'TOP_NAVIGATION_MENU'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("#t_MenuNav", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  menubar: true,',
'  menubarOverflow: true,',
'  callout: e.hasClass("js-menu-callout")',
'});',
''))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-tabLike'
,p_list_template_before_rows=>'<div class="t-Header-nav-list #COMPONENT_CSS_CLASSES#" id="t_MenuNav"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_reference_id=>2525307901300239072
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_tabs
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17737056870408950)
,p_list_template_current=>'<li class="t-NavTabs-item #A03# is-active" id="#A01#"><a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-NavTabs-label">#TEXT_ESC_SC#</span><span class'
||'="t-NavTabs-badge #A05#">#A02#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-NavTabs-item #A03#" id="#A01#"><a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-NavTabs-label">#TEXT_ESC_SC#</span><span class="t-NavTab'
||'s-badge #A05#">#A02#</span></a></li>'
,p_list_template_name=>'Top Navigation Tabs'
,p_internal_name=>'TOP_NAVIGATION_TABS'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-NavTabs--inlineLabels-lg:t-NavTabs--displayLabels-sm'
,p_list_template_before_rows=>'<ul class="t-NavTabs #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_navtabs">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a02_label=>'Badge Value'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_a05_label=>'Badge Class'
,p_reference_id=>1453011561172885578
);
end;
/
prompt --application/shared_components/user_interface/templates/list/wizard_progress
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(17738691346408951)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-WizardSteps-step is-active" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap" data-link="#LINK#"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></'
||'div></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-WizardSteps-step" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap" data-link="#LINK#"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></div></li>',
''))
,p_list_template_name=>'Wizard Progress'
,p_internal_name=>'WIZARD_PROGRESS'
,p_javascript_code_onload=>'apex.theme.initWizardProgressBar();'
,p_theme_id=>42
,p_theme_class_id=>17
,p_preset_template_options=>'t-WizardSteps--displayLabels'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2 class="u-VisuallyHidden">#CURRENT_PROGRESS#</h2>',
'<ul class="t-WizardSteps #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'))
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>2008702338707394488
);
end;
/
prompt --application/shared_components/user_interface/templates/report/alerts
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17691095965408925)
,p_row_template_name=>'Alerts'
,p_internal_name=>'ALERTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title">#ALERT_TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #ALERT_DESC#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      #ALERT_ACTION#',
'    </div>',
'  </div>',
'</div>'))
,p_row_template_before_rows=>'<div class="t-Alerts #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_alerts" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</div>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>14
,p_reference_id=>2881456138952347027
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/badge_list
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17691276630408925)
,p_row_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item">',
' <span class="t-BadgeList-wrap u-color">',
'  <span class="t-BadgeList-label">#COLUMN_HEADER#</span>',
'  <span class="t-BadgeList-value">#COLUMN_VALUE#</span>',
' </span>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed:t-BadgeList--circular'
,p_reference_id=>2103197159775914759
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/cards
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17695268177408927)
,p_row_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <a href="#CARD_LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':CARD_LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <div class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_cards" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_reference_id=>2973535649510699732
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/comments
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17700698145408930)
,p_row_template_name=>'Comments'
,p_internal_name=>'COMMENTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item #COMMENT_MODIFIERS#">',
'    <div class="t-Comments-icon">',
'        <div class="t-Comments-userIcon #ICON_MODIFIER#" aria-hidden="true">#USER_ICON#</div>',
'    </div>',
'    <div class="t-Comments-body">',
'        <div class="t-Comments-info">',
'            #USER_NAME# <span class="t-Comments-date">#COMMENT_DATE#</span> <span class="t-Comments-actions">#ACTIONS#</span>',
'        </div>',
'        <div class="t-Comments-comment">',
'            #COMMENT_TEXT##ATTRIBUTE_1##ATTRIBUTE_2##ATTRIBUTE_3##ATTRIBUTE_4#',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Comments #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>',
''))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Comments--chat'
,p_reference_id=>2611722012730764232
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/content_row
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17701816926408931)
,p_row_template_name=>'Content Row'
,p_internal_name=>'CONTENT_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-ContentRow-item #ITEM_CLASSES#">',
'  <div class="t-ContentRow-wrap">',
'    <div class="t-ContentRow-selection">#SELECTION#</div>',
'    <div class="t-ContentRow-iconWrap">',
'      <span class="t-ContentRow-icon #ICON_CLASS#">#ICON_HTML#</span>',
'    </div>',
'    <div class="t-ContentRow-body">',
'      <div class="t-ContentRow-content">',
'        <h3 class="t-ContentRow-title">#TITLE#</h3>',
'        <div class="t-ContentRow-description">#DESCRIPTION#</div>',
'      </div>',
'      <div class="t-ContentRow-misc">#MISC#</div>',
'      <div class="t-ContentRow-actions">#ACTIONS#</div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-ContentRow #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>1797843454948280151
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/media_list
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17705060061408933)
,p_row_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'            <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_row_template_condition1=>':LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'    <div class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'            <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_default_template_options=>'t-MediaList--showDesc:t-MediaList--showIcons'
,p_preset_template_options=>'t-MediaList--stack'
,p_reference_id=>2092157460408299055
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/search_results
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17708010188408934)
,p_row_template_name=>'Search Results'
,p_internal_name=>'SEARCH_RESULTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition1=>':LABEL_02 is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition2=>':LABEL_03 is null'
,p_row_template3=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition3=>':LABEL_04 is null'
,p_row_template4=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'      <span class="t-SearchResults-misc">#LABEL_04#: #VALUE_04#</span>',
'    </div>',
'  </li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-SearchResults #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">',
'<ul class="t-SearchResults-list">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>',
'</div>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'NOT_CONDITIONAL'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070913431524059316
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/standard
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17708296566408934)
,p_row_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_row_template1=>'<td class="t-Report-cell" #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>'
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Report #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation">#TOP_PAGINATION#</table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" id="report_table_#REGION_STATIC_ID#" aria-label="#REGION_TITLE#">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'      </tbody>',
'    </table>',
'    </div>',
'    <div class="t-Report-links">#EXTERNAL_LINK##CSV_LINK#</div>',
'    <table class="t-Report-pagination t-Report-pagination--bottom" role="presentation">#PAGINATION#</table>',
'  </div>',
'</div>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_before_column_heading=>'<thead>'
,p_column_heading_template=>'<th class="t-Report-colHead" #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>'
,p_after_column_heading=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</thead>',
'<tbody>'))
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Report--altRowsDefault:t-Report--rowHighlight'
,p_reference_id=>2537207537838287671
,p_translate_this_template=>'N'
);
begin
wwv_flow_api.create_row_template_patch(
 p_id=>wwv_flow_api.id(17708296566408934)
,p_row_template_before_first=>'<tr>'
,p_row_template_after_last=>'</tr>'
);
exception when others then null;
end;
end;
/
prompt --application/shared_components/user_interface/templates/report/timeline
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17710870105408936)
,p_row_template_name=>'Timeline'
,p_internal_name=>'TIMELINE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <div class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':EVENT_LINK is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <a href="#EVENT_LINK#" class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </a>',
'</li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-Timeline #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_timeline" data-region-id="#REGION_STATIC_ID#">',
''))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_reference_id=>1513373588340069864
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_column
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17711244065408936)
,p_row_template_name=>'Value Attribute Pairs - Column'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_COLUMN'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #COLUMN_HEADER#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #COLUMN_VALUE#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068636272681754
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_row
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(17713269817408937)
,p_row_template_name=>'Value Attribute Pairs - Row'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #1#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #2#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068321678681753
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/hidden
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(17740098066408952)
,p_template_name=>'Hidden'
,p_internal_name=>'HIDDEN'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer t-Form-labelContainer--hiddenLabel col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label u-VisuallyHidden">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--hiddenLabel rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>13
,p_reference_id=>2039339104148359505
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(17740152874408952)
,p_template_name=>'Optional'
,p_internal_name=>'OPTIONAL'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>',
''))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>2317154212072806530
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_above
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(17740263294408952)
,p_template_name=>'Optional - Above'
,p_internal_name=>'OPTIONAL_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>#HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>3030114864004968404
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_floating
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(17740369355408952)
,p_template_name=>'Optional - Floating'
,p_internal_name=>'OPTIONAL_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>1607675164727151865
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(17740475620408952)
,p_template_name=>'Required'
,p_internal_name=>'REQUIRED'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer is-required rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>2525313812251712801
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_above
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(17740575429408952)
,p_template_name=>'Required - Above'
,p_internal_name=>'REQUIRED_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>3030115129444970113
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_floating
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(17740632513408952)
,p_template_name=>'Required - Floating'
,p_internal_name=>'REQUIRED_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>1607675344320152883
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/breadcrumb/breadcrumb
begin
wwv_flow_api.create_menu_template(
 p_id=>wwv_flow_api.id(17742856676408953)
,p_name=>'Breadcrumb'
,p_internal_name=>'BREADCRUMB'
,p_before_first=>'<ul class="t-Breadcrumb #COMPONENT_CSS_CLASSES#">'
,p_current_page_option=>'<li class="t-Breadcrumb-item is-active"><h1 class="t-Breadcrumb-label">#NAME#</h1></li>'
,p_non_current_page_option=>'<li class="t-Breadcrumb-item"><a href="#LINK#" class="t-Breadcrumb-label">#NAME#</a></li>'
,p_after_last=>'</ul>'
,p_max_levels=>6
,p_start_with_node=>'PARENT_TO_LEAF'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916542570059325
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/popuplov
begin
wwv_flow_api.create_popup_lov_template(
 p_id=>wwv_flow_api.id(17743003311408954)
,p_page_name=>'winlov'
,p_page_title=>'Search Dialog'
,p_page_html_head=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html lang="&BROWSER_LANGUAGE.">',
'<head>',
'<title>#TITLE#</title>',
'#APEX_CSS#',
'#THEME_CSS#',
'#THEME_STYLE_CSS#',
'#FAVICONS#',
'#APEX_JAVASCRIPT#',
'#THEME_JAVASCRIPT#',
'<meta name="viewport" content="width=device-width,initial-scale=1.0" />',
'</head>'))
,p_page_body_attr=>'onload="first_field()" class="t-Page t-Page--popupLOV"'
,p_before_field_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_filter_width=>'20'
,p_filter_max_width=>'100'
,p_filter_text_attr=>'class="apex-item-text"'
,p_find_button_text=>'Search'
,p_find_button_attr=>'class="t-Button t-Button--hot t-Button--padLeft"'
,p_close_button_text=>'Close'
,p_close_button_attr=>'class="t-Button u-pullRight"'
,p_next_button_text=>'Next &gt;'
,p_next_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_prev_button_text=>'&lt; Previous'
,p_prev_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_after_field_text=>'</div>'
,p_scrollbars=>'1'
,p_resizable=>'1'
,p_width=>'380'
,p_result_row_x_of_y=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_result_rows_per_pg=>100
,p_before_result_set=>'<div class="t-PopupLOV-links">'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>2885398517835871876
,p_translate_this_template=>'N'
,p_after_result_set=>'</div>'
);
end;
/
prompt --application/shared_components/user_interface/templates/calendar/calendar
begin
wwv_flow_api.create_calendar_template(
 p_id=>wwv_flow_api.id(17742965493408953)
,p_cal_template_name=>'Calendar'
,p_internal_name=>'CALENDAR'
,p_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" aria-label="#IMONTH# #YYYY#">'
,p_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>',
''))
,p_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_day_close_format=>'</td>'
,p_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_close_format=>'</td>'
,p_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_nonday_close_format=>'</td>'
,p_week_open_format=>'<tr>'
,p_week_close_format=>'</tr> '
,p_daily_title_format=>'<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>'
,p_daily_open_format=>'<tr>'
,p_daily_close_format=>'</tr>'
,p_weekly_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--weekly">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_weekly_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_weekly_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" aria-label="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_weekly_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_weekly_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_day_close_format=>'</div></td>'
,p_weekly_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_close_format=>'</div></td>'
,p_weekly_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_weekly_time_close_format=>'</th>'
,p_weekly_time_title_format=>'#TIME#'
,p_weekly_hour_open_format=>'<tr>'
,p_weekly_hour_close_format=>'</tr>'
,p_daily_day_of_week_format=>'<th scope="col" id="#DY#" class="t-ClassicCalendar-dayColumn">#IDAY#</th>'
,p_daily_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--daily">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #DD#, #YYYY#</h1>'))
,p_daily_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" aria-label="#CALENDAR_TITLE# #START_DL#" class="t-ClassicCalendar-calendar">'
,p_daily_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_daily_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_day_close_format=>'</div></td>'
,p_daily_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol" id="#TIME#">'
,p_daily_time_close_format=>'</th>'
,p_daily_time_title_format=>'#TIME#'
,p_daily_hour_open_format=>'<tr>'
,p_daily_hour_close_format=>'</tr>'
,p_cust_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_cust_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_cust_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" aria-label="#IMONTH# #YYYY#">'
,p_cust_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_week_open_format=>'<tr>'
,p_cust_week_close_format=>'</tr> '
,p_cust_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_day_close_format=>'</td>'
,p_cust_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">'
,p_cust_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_cust_nonday_close_format=>'</td>'
,p_cust_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">'
,p_cust_weekend_close_format=>'</td>'
,p_cust_hour_open_format=>'<tr>'
,p_cust_hour_close_format=>'</tr>'
,p_cust_time_title_format=>'#TIME#'
,p_cust_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_cust_time_close_format=>'</th>'
,p_cust_wk_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_cust_wk_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_cust_wk_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_cust_wk_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_wk_week_open_format=>'<tr>'
,p_cust_wk_week_close_format=>'</tr> '
,p_cust_wk_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_day_close_format=>'</div></td>'
,p_cust_wk_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_weekend_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_wk_weekend_close_format=>'</td>'
,p_agenda_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--list">',
'  <div class="t-ClassicCalendar-title">#IMONTH# #YYYY#</div>',
'  <ul class="t-ClassicCalendar-list">',
'    #DAYS#',
'  </ul>',
'</div>'))
,p_agenda_past_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-past">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_today_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-today">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_future_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-future">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_past_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-past">#DATA#</li>'
,p_agenda_today_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-today">#DATA#</li>'
,p_agenda_future_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-future">#DATA#</li>'
,p_month_data_format=>'#DAYS#'
,p_month_data_entry_format=>'<span class="t-ClassicCalendar-event">#DATA#</span>'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916747979059326
);
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(17744232654408954)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(17644236651408899)
,p_default_dialog_template=>wwv_flow_api.id(17639907376408897)
,p_error_template=>wwv_flow_api.id(17632029951408893)
,p_printer_friendly_template=>wwv_flow_api.id(17644236651408899)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(17632029951408893)
,p_default_button_template=>wwv_flow_api.id(17741443504408953)
,p_default_region_template=>wwv_flow_api.id(17679306367408919)
,p_default_chart_template=>wwv_flow_api.id(17679306367408919)
,p_default_form_template=>wwv_flow_api.id(17679306367408919)
,p_default_reportr_template=>wwv_flow_api.id(17679306367408919)
,p_default_tabform_template=>wwv_flow_api.id(17679306367408919)
,p_default_wizard_template=>wwv_flow_api.id(17679306367408919)
,p_default_menur_template=>wwv_flow_api.id(17688764363408924)
,p_default_listr_template=>wwv_flow_api.id(17679306367408919)
,p_default_irr_template=>wwv_flow_api.id(17677439644408917)
,p_default_report_template=>wwv_flow_api.id(17708296566408934)
,p_default_label_template=>wwv_flow_api.id(17740369355408952)
,p_default_menu_template=>wwv_flow_api.id(17742856676408953)
,p_default_calendar_template=>wwv_flow_api.id(17742965493408953)
,p_default_list_template=>wwv_flow_api.id(17724619808408943)
,p_default_nav_list_template=>wwv_flow_api.id(17736008470408949)
,p_default_top_nav_list_temp=>wwv_flow_api.id(17736008470408949)
,p_default_side_nav_list_temp=>wwv_flow_api.id(17731088352408947)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(17652975206408904)
,p_default_dialogr_template=>wwv_flow_api.id(17651912627408904)
,p_default_option_label=>wwv_flow_api.id(17740369355408952)
,p_default_required_label=>wwv_flow_api.id(17740632513408952)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(17730617898408946)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.5/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(17743238015408954)
,p_theme_id=>42
,p_name=>'Vita - Red'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Red.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Red#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>1938457712423918173
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(17743488482408954)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(17743624320408954)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>true
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Slate.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(17743808019408954)
,p_theme_id=>42
,p_name=>'Vita - Dark'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Dark.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Dark#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3543348412015319650
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(17744064482408954)
,p_theme_id=>42
,p_name=>'Vista'
,p_css_file_urls=>'#THEME_IMAGES#css/Vista#MIN#.css?v=#APEX_VERSION#'
,p_is_current=>false
,p_is_public=>false
,p_is_accessible=>false
,p_theme_roller_read_only=>true
,p_reference_id=>4007676303523989775
);
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_display_points
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17633223858408893)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND'
,p_display_name=>'Page Background'
,p_display_sequence=>20
,p_template_types=>'PAGE'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17634000772408894)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT'
,p_display_name=>'Page Layout'
,p_display_sequence=>10
,p_template_types=>'PAGE'
,p_null_text=>'Floating (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17649016295408902)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17649497941408902)
,p_theme_id=>42
,p_name=>'ALERT_TITLE'
,p_display_name=>'Alert Title'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the title of the alert is displayed.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17650041132408903)
,p_theme_id=>42
,p_name=>'ALERT_ICONS'
,p_display_name=>'Alert Icons'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets how icons are handled for the Alert Region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17650452481408903)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17653811217408905)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the region is styled. Use the "Remove Borders" template option to remove the region''s borders and shadows.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17654230439408905)
,p_theme_id=>42
,p_name=>'BODY_PADDING'
,p_display_name=>'Body Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body padding for the region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17656058504408906)
,p_theme_id=>42
,p_name=>'TIMER'
,p_display_name=>'Timer'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets the timer for when to automatically navigate to the next region within the Carousel Region.'
,p_null_text=>'No Timer'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17656848829408906)
,p_theme_id=>42
,p_name=>'BODY_HEIGHT'
,p_display_name=>'Body Height'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body height. You can also specify a custom height by modifying the Region''s CSS Classes and using the height helper classes "i-hXXX" where XXX is any increment of 10 from 100 to 800.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17658070394408907)
,p_theme_id=>42
,p_name=>'ACCENT'
,p_display_name=>'Accent'
,p_display_sequence=>30
,p_template_types=>'REGION'
,p_help_text=>'Set the Region''s accent. This accent corresponds to a Theme-Rollable color and sets the background of the Region''s Header.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17659222403408908)
,p_theme_id=>42
,p_name=>'HEADER'
,p_display_name=>'Header'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Determines the display of the Region Header which also contains the Region Title.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17659674795408908)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17661650662408909)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the animation when navigating within the Carousel Region.'
,p_null_text=>'Fade'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17665060782408911)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17665421797408911)
,p_theme_id=>42
,p_name=>'COLLAPSIBLE_ICON_POSITION'
,p_display_name=>'Collapsible Icon Position'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the position of the expand and collapse toggle for the region.'
,p_null_text=>'Start'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17666235206408912)
,p_theme_id=>42
,p_name=>'COLLAPSIBLE_BUTTON_ICONS'
,p_display_name=>'Collapsible Button Icons'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines which arrows to use to represent the icons for the collapse and expand button.'
,p_null_text=>'Arrows'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17668291110408913)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17669024015408913)
,p_theme_id=>42
,p_name=>'BODY_STYLE'
,p_display_name=>'Body Style'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the region''s body container.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17670348471408914)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON'
,p_display_name=>'Display Icon'
,p_display_sequence=>50
,p_template_types=>'REGION'
,p_help_text=>'Display the Hero Region icon.'
,p_null_text=>'Yes (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17670951918408914)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'REGION'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Rounded Corners'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17672864612408915)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17674722194408916)
,p_theme_id=>42
,p_name=>'CALLOUT_POSITION'
,p_display_name=>'Callout Position'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Determines where the callout for the popup will be positioned relative to its parent.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17678643201408918)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER'
,p_display_name=>'Login Header'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the Login region header.'
,p_null_text=>'Icon and Title (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17687007629408923)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17687463625408923)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17688252856408923)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17690347482408924)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17691588126408925)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17691934759408926)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17693950588408927)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the overall style for the component.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17695734170408928)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'REPORT'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17697506586408928)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>70
,p_template_types=>'REPORT'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17698393772408929)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Controls how to handle icons in the report.'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17699704617408930)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'REPORT'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Circle'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17700931757408931)
,p_theme_id=>42
,p_name=>'COMMENTS_STYLE'
,p_display_name=>'Comments Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the style in which comments are displayed.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17702122934408931)
,p_theme_id=>42
,p_name=>'COL_ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>150
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17702556150408931)
,p_theme_id=>42
,p_name=>'CONTENT_ALIGNMENT'
,p_display_name=>'Content Alignment'
,p_display_sequence=>90
,p_template_types=>'REPORT'
,p_null_text=>'Center (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17702975261408932)
,p_theme_id=>42
,p_name=>'COL_CONTENT_DESCRIPTION'
,p_display_name=>'Description'
,p_display_sequence=>130
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17703357331408932)
,p_theme_id=>42
,p_name=>'COL_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>110
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17703732027408932)
,p_theme_id=>42
,p_name=>'COL_MISC'
,p_display_name=>'Misc'
,p_display_sequence=>140
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17704142231408932)
,p_theme_id=>42
,p_name=>'COL_SELECTION'
,p_display_name=>'Selection'
,p_display_sequence=>100
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17704794105408933)
,p_theme_id=>42
,p_name=>'COL_CONTENT_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>120
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17706736689408934)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>35
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17708533016408935)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17709139866408935)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17709569892408935)
,p_theme_id=>42
,p_name=>'REPORT_BORDER'
,p_display_name=>'Report Border'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of the Report''s borders.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17711597882408936)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17715312614408938)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17716580167408939)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17717751140408940)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17719541308408941)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'LIST'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17721514515408942)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>80
,p_template_types=>'LIST'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17722122868408942)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17723598594408943)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'LIST'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Circle'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17725707144408944)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17727910521408945)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17731505414408947)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE'
,p_display_name=>'Collapse Mode'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17737387280408950)
,p_theme_id=>42
,p_name=>'MOBILE'
,p_display_name=>'Mobile'
,p_display_sequence=>100
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a mobile-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17737978870408951)
,p_theme_id=>42
,p_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_sequence=>90
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a desktop-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17738972615408951)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17740994058408952)
,p_theme_id=>42
,p_name=>'ICON_HOVER_ANIMATION'
,p_display_name=>'Icon Hover Animation'
,p_display_sequence=>55
,p_template_types=>'BUTTON'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17741915086408953)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17744491014408955)
,p_theme_id=>42
,p_name=>'PAGINATION_DISPLAY'
,p_display_name=>'Pagination Display'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of pagination for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17744846544408955)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>30
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the style of the button. Use the "Simple" option for secondary actions or sets of buttons. Use the "Remove UI Decoration" option to make the button appear as text.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17745205749408955)
,p_theme_id=>42
,p_name=>'SPACING_TOP'
,p_display_name=>'Spacing Top'
,p_display_sequence=>90
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the top of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17745860652408956)
,p_theme_id=>42
,p_name=>'SPACING_BOTTOM'
,p_display_name=>'Spacing Bottom'
,p_display_sequence=>100
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the bottom of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17746441938408956)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the size of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17746807069408956)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17747265993408956)
,p_theme_id=>42
,p_name=>'WIDTH'
,p_display_name=>'Width'
,p_display_sequence=>60
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the width of the button.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17748468314408957)
,p_theme_id=>42
,p_name=>'SPACING_LEFT'
,p_display_name=>'Spacing Left'
,p_display_sequence=>70
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the left of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17749674887408958)
,p_theme_id=>42
,p_name=>'SPACING_RIGHT'
,p_display_name=>'Spacing Right'
,p_display_sequence=>80
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the right of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17750201082408958)
,p_theme_id=>42
,p_name=>'BUTTON_SET'
,p_display_name=>'Button Set'
,p_display_sequence=>40
,p_template_types=>'BUTTON'
,p_help_text=>'Enables you to group many buttons together into a pill. You can use this option to specify where the button is within this set. Set the option to Default if this button is not part of a button set.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17751012957408958)
,p_theme_id=>42
,p_name=>'LABEL_ALIGNMENT'
,p_display_name=>'Label Alignment'
,p_display_sequence=>130
,p_template_types=>'REGION'
,p_help_text=>'Set the label text alignment for items within this region.'
,p_null_text=>'Right'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17751446922408959)
,p_theme_id=>42
,p_name=>'ITEM_SIZE'
,p_display_name=>'Item Size'
,p_display_sequence=>110
,p_template_types=>'REGION'
,p_help_text=>'Sets the size of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17752019982408959)
,p_theme_id=>42
,p_name=>'ITEM_PADDING'
,p_display_name=>'Item Padding'
,p_display_sequence=>100
,p_template_types=>'REGION'
,p_help_text=>'Sets the padding around items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17752667250408959)
,p_theme_id=>42
,p_name=>'LABEL_POSITION'
,p_display_name=>'Label Position'
,p_display_sequence=>140
,p_template_types=>'REGION'
,p_help_text=>'Sets the position of the label relative to the form item.'
,p_null_text=>'Inline - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17753052543408959)
,p_theme_id=>42
,p_name=>'ITEM_WIDTH'
,p_display_name=>'Item Width'
,p_display_sequence=>120
,p_template_types=>'REGION'
,p_help_text=>'Sets the width of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17753409735408960)
,p_theme_id=>42
,p_name=>'ITEM_PRE_TEXT'
,p_display_name=>'Item Pre Text'
,p_display_sequence=>20
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Pre Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17753865933408960)
,p_theme_id=>42
,p_name=>'ITEM_POST_TEXT'
,p_display_name=>'Item Post Text'
,p_display_sequence=>30
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Post Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17754215763408960)
,p_theme_id=>42
,p_name=>'REGION_TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'REGION'
,p_help_text=>'Set the top margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17755202397408960)
,p_theme_id=>42
,p_name=>'REGION_BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>210
,p_template_types=>'REGION'
,p_help_text=>'Set the bottom margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17756297022408961)
,p_theme_id=>42
,p_name=>'REGION_RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'REGION'
,p_help_text=>'Set the right margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17757255703408961)
,p_theme_id=>42
,p_name=>'REGION_LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'REGION'
,p_help_text=>'Set the left margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17758265371408962)
,p_theme_id=>42
,p_name=>'BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the bottom margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17759241132408962)
,p_theme_id=>42
,p_name=>'LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the left margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17760231176408963)
,p_theme_id=>42
,p_name=>'RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'FIELD'
,p_help_text=>'Set the right margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17761247430408963)
,p_theme_id=>42
,p_name=>'TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'FIELD'
,p_help_text=>'Set the top margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17762261037408964)
,p_theme_id=>42
,p_name=>'RADIO_GROUP_DISPLAY'
,p_display_name=>'Item Group Display'
,p_display_sequence=>300
,p_template_types=>'FIELD'
,p_help_text=>'Determines the display style for radio and check box items.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(17762686937408964)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/user_interface/template_options
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17628810585408891)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(17626135339408889)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17631972991408893)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(17628982342408891)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17633438160408894)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_1'
,p_display_name=>'Background 1'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(17632029951408893)
,p_css_classes=>'t-LoginPage--bg1'
,p_group_id=>wwv_flow_api.id(17633223858408893)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17633646834408894)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_2'
,p_display_name=>'Background 2'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(17632029951408893)
,p_css_classes=>'t-LoginPage--bg2'
,p_group_id=>wwv_flow_api.id(17633223858408893)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17633834346408894)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_3'
,p_display_name=>'Background 3'
,p_display_sequence=>30
,p_page_template_id=>wwv_flow_api.id(17632029951408893)
,p_css_classes=>'t-LoginPage--bg3'
,p_group_id=>wwv_flow_api.id(17633223858408893)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17634236249408894)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT_SPLIT'
,p_display_name=>'Split'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(17632029951408893)
,p_css_classes=>'t-LoginPage--split'
,p_group_id=>wwv_flow_api.id(17634000772408894)
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17637305731408896)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(17634351233408894)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17639829700408897)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(17637446989408896)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17641197411408898)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(17639907376408897)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17641375596408898)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(17639907376408897)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17644145854408899)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(17641478676408898)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17646613742408901)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(17644236651408899)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17647946312408902)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(17646751789408901)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17648179676408902)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(17646751789408901)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17648803358408902)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17649231011408902)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(17649016295408902)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17649658281408903)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_api.id(17649497941408902)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17649856653408903)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--removeHeading'
,p_group_id=>wwv_flow_api.id(17649497941408902)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17650274548408903)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(17650041132408903)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17650603245408903)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(17650452481408903)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17650813494408903)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(17649016295408902)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17651016464408903)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(17650041132408903)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17651275274408903)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(17649016295408902)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17651442021408903)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(17650041132408903)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17651645838408904)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(17649016295408902)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17651884904408904)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17648207118408902)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(17650452481408903)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17654049726408905)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17652975206408904)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17654400242408905)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(17652975206408904)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(17654230439408905)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17654679477408905)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(17652975206408904)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17654860414408905)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(17652975206408904)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(17654230439408905)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17655061056408906)
,p_theme_id=>42
,p_name=>'STICK_TO_BOTTOM'
,p_display_name=>'Stick to Bottom for Mobile'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17652975206408904)
,p_css_classes=>'t-ButtonRegion--stickToBottom'
,p_template_types=>'REGION'
,p_help_text=>'This will position the button container region to the bottom of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17656248802408906)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(17656058504408906)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17656406515408906)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(17656058504408906)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17656647812408906)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(17656058504408906)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17657091084408907)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17657270263408907)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17657418426408907)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17657682224408907)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(17656058504408906)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17657862268408907)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17658290634408907)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17658464769408907)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17658661009408907)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17658872548408907)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17659034850408908)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17659446879408908)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(17659222403408908)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17659892022408908)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(17659674795408908)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17660011361408908)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(17659222403408908)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17660202321408908)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17660429704408908)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17660618543408908)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17660830673408908)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(17659674795408908)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17661077095408909)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17661278444408909)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17661475813408909)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17661856802408909)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(17661650662408909)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17662013445408909)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(17661650662408909)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17662298485408910)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17655136893408906)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17663268987408910)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17663453625408910)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17663649784408910)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17663877680408910)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17664046580408911)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17664254993408911)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17664418443408911)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17664689670408911)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17664804045408911)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17665262395408911)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(17665060782408911)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17665601829408911)
,p_theme_id=>42
,p_name=>'CONRTOLS_POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--controlsPosEnd'
,p_group_id=>wwv_flow_api.id(17665421797408911)
,p_template_types=>'REGION'
,p_help_text=>'Position the expand / collapse button to the end of the region header.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17665846950408911)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(17665060782408911)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17666073256408912)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(17659674795408908)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17666473787408912)
,p_theme_id=>42
,p_name=>'ICONS_PLUS_OR_MINUS'
,p_display_name=>'Plus or Minus'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--hideShowIconsMath'
,p_group_id=>wwv_flow_api.id(17666235206408912)
,p_template_types=>'REGION'
,p_help_text=>'Use the plus and minus icons for the expand and collapse button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17666625989408912)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17666836029408912)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17667050690408912)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17667210762408912)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17667417515408912)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(17659674795408908)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17667691495408912)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17662386249408910)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17668006761408913)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17667727194408912)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17668463052408913)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Heading Level 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17667727194408912)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_api.id(17668291110408913)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17668674522408913)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Heading Level 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17667727194408912)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_api.id(17668291110408913)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17668888181408913)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Heading Level 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17667727194408912)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_api.id(17668291110408913)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17669281407408913)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17667727194408912)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_api.id(17669024015408913)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17669418270408913)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17667727194408912)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_api.id(17669024015408913)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17669680936408913)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17667727194408912)
,p_css_classes=>'t-ContentBlock--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17670580629408914)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17669729187408913)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_api.id(17670348471408914)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17670718456408914)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17669729187408913)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17671114846408914)
,p_theme_id=>42
,p_name=>'ICONS_CIRCULAR'
,p_display_name=>'Circle'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17669729187408913)
,p_css_classes=>'t-HeroRegion--iconsCircle'
,p_group_id=>wwv_flow_api.id(17670951918408914)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a circle.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17671397026408914)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17669729187408913)
,p_css_classes=>'t-HeroRegion--iconsSquare'
,p_group_id=>wwv_flow_api.id(17670951918408914)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a square.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17671547635408914)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17669729187408913)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17671769198408915)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17669729187408913)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17672436993408915)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17671837072408915)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17672684055408915)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17671837072408915)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17673072452408915)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17671837072408915)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(17672864612408915)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17673237117408915)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17671837072408915)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(17672864612408915)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17673426546408915)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17671837072408915)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17673629781408916)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(17671837072408915)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17673828965408916)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17671837072408915)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17674030919408916)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17671837072408915)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(17672864612408915)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17674966285408916)
,p_theme_id=>42
,p_name=>'ABOVE'
,p_display_name=>'Above'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-popup-pos-above'
,p_group_id=>wwv_flow_api.id(17674722194408916)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout above or typically on top of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17675127129408916)
,p_theme_id=>42
,p_name=>'AFTER'
,p_display_name=>'After'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-popup-pos-after'
,p_group_id=>wwv_flow_api.id(17674722194408916)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout after or typically to the right of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17675399162408916)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17675529968408917)
,p_theme_id=>42
,p_name=>'BEFORE'
,p_display_name=>'Before'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-popup-pos-before'
,p_group_id=>wwv_flow_api.id(17674722194408916)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout before or typically to the left of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17675766941408917)
,p_theme_id=>42
,p_name=>'BELOW'
,p_display_name=>'Below'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-popup-pos-below'
,p_group_id=>wwv_flow_api.id(17674722194408916)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout below or typically to the bottom of the parent.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17675902710408917)
,p_theme_id=>42
,p_name=>'DISPLAY_POPUP_CALLOUT'
,p_display_name=>'Display Popup Callout'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-popup-callout'
,p_template_types=>'REGION'
,p_help_text=>'Use this option to add display a callout for the popup. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17676164300408917)
,p_theme_id=>42
,p_name=>'INSIDE'
,p_display_name=>'Inside'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-popup-pos-inside'
,p_group_id=>wwv_flow_api.id(17674722194408916)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout inside of the parent. This is useful when the parent is sufficiently large, such as a report or large region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17676364703408917)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(17672864612408915)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17676575867408917)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(17672864612408915)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17676752226408917)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_api.id(17672864612408915)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17676980193408917)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17677101220408917)
,p_theme_id=>42
,p_name=>'REMOVE_PAGE_OVERLAY'
,p_display_name=>'Remove Page Overlay'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-popup-noOverlay'
,p_template_types=>'REGION'
,p_help_text=>'This option will display the inline dialog without an overlay on the background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17677360261408917)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17674132559408916)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(17672864612408915)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17677750879408918)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17677439644408917)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17677943773408918)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17677439644408917)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17678834211408918)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17678042343408918)
,p_css_classes=>'t-Login-region--headerIcon'
,p_group_id=>wwv_flow_api.id(17678643201408918)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Icon in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17679043551408919)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17678042343408918)
,p_css_classes=>'t-Login-region--headerTitle'
,p_group_id=>wwv_flow_api.id(17678643201408918)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Title in the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17679290499408919)
,p_theme_id=>42
,p_name=>'LOGO_HEADER_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17678042343408918)
,p_css_classes=>'t-Login-region--headerHidden'
,p_group_id=>wwv_flow_api.id(17678643201408918)
,p_template_types=>'REGION'
,p_help_text=>'Hides both the Region Icon and Title from the Login region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17680221342408919)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17680475425408919)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17680621547408919)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17680858153408920)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(17656848829408906)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17681050546408920)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17681250983408920)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17681436422408920)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17681630387408920)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17681889774408920)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17682006534408920)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17682262155408920)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17682437057408920)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17682690244408920)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17682898612408921)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17683065347408921)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17683279986408921)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17683482673408921)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17683632037408921)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17683892621408921)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_api.id(17658070394408907)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17684077731408921)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(17659222403408908)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17684253490408921)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(17659674795408908)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17684416115408921)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(17659222403408908)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17684682521408921)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17684875725408922)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17685064707408922)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17685294034408922)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(17659674795408908)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17685439104408922)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17685677506408922)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17685815950408922)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17686099584408922)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(17679306367408919)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_api.id(17653811217408905)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17687246380408923)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17686188479408922)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(17687007629408923)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17687621433408923)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17686188479408922)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(17687463625408923)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17687885709408923)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17686188479408922)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17688023106408923)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17686188479408922)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(17687463625408923)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17688404584408923)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17686188479408922)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(17688252856408923)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17688625706408923)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17686188479408922)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(17688252856408923)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17689098128408924)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17688764363408924)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(17668291110408913)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17689257271408924)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17688764363408924)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17689407161408924)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(17688764363408924)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(17668291110408913)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17689669699408924)
,p_theme_id=>42
,p_name=>'USE_COMPACT_STYLE'
,p_display_name=>'Use Compact Style'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17688764363408924)
,p_css_classes=>'t-BreadcrumbRegion--compactTitle'
,p_template_types=>'REGION'
,p_help_text=>'Uses a compact style for the breadcrumbs.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17690592215408925)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(17689739537408924)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(17690347482408924)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17690741523408925)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17689739537408924)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(17690347482408924)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17690936038408925)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(17689739537408924)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17691748419408925)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(17691588126408925)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17692169871408926)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17692342690408926)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(17691588126408925)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17692507224408926)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17692799862408926)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(17691588126408925)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17692964239408926)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17693197962408926)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17693320538408926)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(17691588126408925)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17693558019408926)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(17691588126408925)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17693751018408926)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17694138233408927)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(17693950588408927)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17694329136408927)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17694557946408927)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17694739712408927)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17694942463408927)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(17693950588408927)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17695180919408927)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17691276630408925)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17695518484408927)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17695927017408928)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(17695734170408928)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17696135589408928)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17696328921408928)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(17695734170408928)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17696532169408928)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17696721372408928)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(17695734170408928)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17696943824408928)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17697186944408928)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(17693950588408927)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17697304500408928)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(17693950588408927)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17697765562408929)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(17697506586408928)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17697919380408929)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(17697506586408928)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17698124022408929)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(17693950588408927)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17698592919408929)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(17698393772408929)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17698769356408929)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(17698393772408929)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17698986738408929)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17699175462408929)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(17693950588408927)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17699317505408930)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17699546319408930)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(17695734170408928)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17699913959408930)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(17699704617408930)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17700124034408930)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(17699704617408930)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17700390641408930)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17700574154408930)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17695268177408927)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17701183145408931)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17700698145408930)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(17700931757408931)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17701357932408931)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17700698145408930)
,p_css_classes=>'t-Comments--iconsRounded'
,p_group_id=>wwv_flow_api.id(17699704617408930)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17701570306408931)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17700698145408930)
,p_css_classes=>'t-Comments--iconsSquare'
,p_group_id=>wwv_flow_api.id(17699704617408930)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17701749905408931)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17700698145408930)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(17700931757408931)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17702317578408931)
,p_theme_id=>42
,p_name=>'ACTIONS_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(17701816926408931)
,p_css_classes=>'t-ContentRow--hideActions'
,p_group_id=>wwv_flow_api.id(17702122934408931)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Actions column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17702784227408932)
,p_theme_id=>42
,p_name=>'ALIGNMENT_TOP'
,p_display_name=>'Top'
,p_display_sequence=>100
,p_report_template_id=>wwv_flow_api.id(17701816926408931)
,p_css_classes=>'t-ContentRow--alignTop'
,p_group_id=>wwv_flow_api.id(17702556150408931)
,p_template_types=>'REPORT'
,p_help_text=>'Aligns the content to the top of the row. This is useful when you expect that yours rows will vary in height (e.g. some rows will have longer descriptions than others).'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17703152587408932)
,p_theme_id=>42
,p_name=>'DESCRIPTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17701816926408931)
,p_css_classes=>'t-ContentRow--hideDescription'
,p_group_id=>wwv_flow_api.id(17702975261408932)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Description from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17703572283408932)
,p_theme_id=>42
,p_name=>'ICON_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17701816926408931)
,p_css_classes=>'t-ContentRow--hideIcon'
,p_group_id=>wwv_flow_api.id(17703357331408932)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Icon from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17703933507408932)
,p_theme_id=>42
,p_name=>'MISC_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(17701816926408931)
,p_css_classes=>'t-ContentRow--hideMisc'
,p_group_id=>wwv_flow_api.id(17703732027408932)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Misc column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17704329901408932)
,p_theme_id=>42
,p_name=>'SELECTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17701816926408931)
,p_css_classes=>'t-ContentRow--hideSelection'
,p_group_id=>wwv_flow_api.id(17704142231408932)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Selection column from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17704533025408932)
,p_theme_id=>42
,p_name=>'STYLE_COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(17701816926408931)
,p_css_classes=>'t-ContentRow--styleCompact'
,p_group_id=>wwv_flow_api.id(17693950588408927)
,p_template_types=>'REPORT'
,p_help_text=>'This option reduces the padding and font sizes to present a compact display of the same information.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17704922660408933)
,p_theme_id=>42
,p_name=>'TITLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17701816926408931)
,p_css_classes=>'t-ContentRow--hideTitle'
,p_group_id=>wwv_flow_api.id(17704794105408933)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Title from being rendered on the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17705311907408933)
,p_theme_id=>42
,p_name=>'2_COLUMN_GRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17705528217408933)
,p_theme_id=>42
,p_name=>'3_COLUMN_GRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17705752789408933)
,p_theme_id=>42
,p_name=>'4_COLUMN_GRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17705921646408933)
,p_theme_id=>42
,p_name=>'5_COLUMN_GRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17706145108408933)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17706336319408933)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(17699704617408930)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17706510824408934)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(17699704617408930)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17706945276408934)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(17706736689408934)
,p_template_types=>'REPORT'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17707199812408934)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17707335182408934)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17707525511408934)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17707785880408934)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17707907458408934)
,p_theme_id=>42
,p_name=>'STACK'
,p_display_name=>'Stack'
,p_display_sequence=>5
,p_report_template_id=>wwv_flow_api.id(17705060061408933)
,p_css_classes=>'t-MediaList--stack'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17708703640408935)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(17708533016408935)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17708938564408935)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(17708533016408935)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17709347424408935)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(17709139866408935)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17709722301408935)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(17709569892408935)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17709976687408935)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(17709569892408935)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17710126217408935)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(17709569892408935)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17710369155408935)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(17709139866408935)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17710507010408936)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17710745001408936)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17708296566408934)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(17709569892408935)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17711110253408936)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(17710870105408936)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(17693950588408927)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17711777696408936)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17711244065408936)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17711904631408936)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17711244065408936)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17712133122408936)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17711244065408936)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17712336986408937)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17711244065408936)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17712553143408937)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17711244065408936)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17712755897408937)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(17711244065408936)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17712994703408937)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(17711244065408936)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17713115458408937)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17711244065408936)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17713535361408937)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(17713269817408937)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17713710349408937)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17713269817408937)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17713927213408938)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17713269817408937)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17714188506408938)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(17713269817408937)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17714354347408938)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(17713269817408937)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(17691934759408926)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17714535223408938)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(17713269817408937)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17714743460408938)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(17713269817408937)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17714936794408938)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(17713269817408937)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(17711597882408936)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17715567379408938)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17715797246408939)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17715934698408939)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17716112118408939)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17716326273408939)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17716714985408939)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17716904401408939)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17717109309408939)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17717389519408939)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17717597153408939)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17717966692408940)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(17717751140408940)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17718152853408940)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(17717751140408940)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17718302821408940)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(17717751140408940)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17718573951408940)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17718780065408940)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(17717751140408940)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17718999270408940)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(17715078125408938)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(17717751140408940)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17719362200408940)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17719752809408941)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(17719541308408941)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17719905234408941)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17720175803408941)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(17719541308408941)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17720312137408941)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17720548331408941)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(17719541308408941)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17720747002408941)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17720972809408941)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17721109050408941)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17721371015408942)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17721763679408942)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(17721514515408942)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17721966330408942)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17722323412408942)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(17722122868408942)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17722580076408942)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(17722122868408942)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17722784026408942)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17722956579408942)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17723139027408942)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17723371694408943)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(17719541308408941)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17723722941408943)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_api.id(17723598594408943)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17723942633408943)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_api.id(17723598594408943)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17724157324408943)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(17721514515408942)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17724372389408943)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17724545344408943)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17724913900408943)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17724619808408943)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17725199087408943)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17724619808408943)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17725334825408944)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17724619808408943)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17725508970408944)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17724619808408943)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17725986183408944)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17724619808408943)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(17725707144408944)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17726167197408944)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17724619808408943)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(17725707144408944)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17726558697408944)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17726779056408944)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17726965959408944)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17727199541408944)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17727394104408945)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17727529860408945)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_api.id(17723598594408943)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17727727867408945)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_api.id(17723598594408943)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17728159534408945)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(17727910521408945)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17728395889408945)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17728541080408945)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17728756108408945)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17728910294408946)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17729356114408946)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17729079768408946)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17729584207408946)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17729079768408946)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17729762787408946)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(17729079768408946)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17729973395408946)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17729079768408946)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17730379966408946)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17730057710408946)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Enables you to define a keyboard shortcut to activate the menu item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17730556015408946)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17730057710408946)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17730990795408947)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17730617898408946)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17731313330408947)
,p_theme_id=>42
,p_name=>'COLLAPSED_DEFAULT'
,p_display_name=>'Collapsed by Default'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17731088352408947)
,p_css_classes=>'js-defaultCollapsed'
,p_template_types=>'LIST'
,p_help_text=>'This option will load the side navigation menu in a collapsed state by default.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17731770291408947)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17731088352408947)
,p_css_classes=>'js-navCollapsed--hidden'
,p_group_id=>wwv_flow_api.id(17731505414408947)
,p_template_types=>'LIST'
,p_help_text=>'Completely hide the navigation menu when it is collapsed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17731982135408947)
,p_theme_id=>42
,p_name=>'ICON_DEFAULT'
,p_display_name=>'Icon (Default)'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17731088352408947)
,p_css_classes=>'js-navCollapsed--default'
,p_group_id=>wwv_flow_api.id(17731505414408947)
,p_template_types=>'LIST'
,p_help_text=>'Display icons when the navigation menu is collapsed for large screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17732122299408947)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17731088352408947)
,p_css_classes=>'t-TreeNav--styleA'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation A'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17732326734408948)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17731088352408947)
,p_css_classes=>'t-TreeNav--styleB'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation B'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17732568788408948)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Classic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17731088352408947)
,p_css_classes=>'t-TreeNav--classic'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
,p_help_text=>'Classic Style'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17732938322408948)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17732655005408948)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(17722122868408942)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17733176219408948)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(17732655005408948)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17733327074408948)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17732655005408948)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(17722122868408942)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17733503282408948)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17732655005408948)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(17727910521408945)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17733752173408948)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17732655005408948)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17733901792408948)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17732655005408948)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(17716580167408939)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17734145125408949)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(17732655005408948)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(17727910521408945)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17734551191408949)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17734294624408949)
,p_css_classes=>'t-MegaMenu--layout2Cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17734764753408949)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17734294624408949)
,p_css_classes=>'t-MegaMenu--layout3Cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17734984405408949)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17734294624408949)
,p_css_classes=>'t-MegaMenu--layout4Cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17735124254408949)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17734294624408949)
,p_css_classes=>'t-MegaMenu--layout5Cols'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17735350454408949)
,p_theme_id=>42
,p_name=>'CUSTOM'
,p_display_name=>'Custom'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(17734294624408949)
,p_css_classes=>'t-MegaMenu--layoutCustom'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17735593341408949)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17734294624408949)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Displays a callout arrow that points to where the menu was activated from.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17735792927408949)
,p_theme_id=>42
,p_name=>'FULL_WIDTH'
,p_display_name=>'Full Width'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17734294624408949)
,p_css_classes=>'t-MegaMenu--fullWidth'
,p_template_types=>'LIST'
,p_help_text=>'Stretches the menu to fill the width of the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17735919783408949)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(17734294624408949)
,p_css_classes=>'t-MegaMenu--layoutStacked'
,p_group_id=>wwv_flow_api.id(17715312614408938)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17736387177408950)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(17736008470408949)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17736561690408950)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(17736008470408949)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17736739134408950)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(17736008470408949)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17736960412408950)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(17736008470408949)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17737583523408950)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_SM'
,p_display_name=>'Display labels'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17737056870408950)
,p_css_classes=>'t-NavTabs--displayLabels-sm'
,p_group_id=>wwv_flow_api.id(17737387280408950)
,p_template_types=>'LIST'
,p_help_text=>'Displays the label for the list items below the icon'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17737790969408950)
,p_theme_id=>42
,p_name=>'HIDE_LABELS_SM'
,p_display_name=>'Do not display labels'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(17737056870408950)
,p_css_classes=>'t-NavTabs--hiddenLabels-sm'
,p_group_id=>wwv_flow_api.id(17737387280408950)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17738144894408951)
,p_theme_id=>42
,p_name=>'LABEL_ABOVE_LG'
,p_display_name=>'Display labels above'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17737056870408950)
,p_css_classes=>'t-NavTabs--stacked'
,p_group_id=>wwv_flow_api.id(17737978870408951)
,p_template_types=>'LIST'
,p_help_text=>'Display the label stacked above the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17738360006408951)
,p_theme_id=>42
,p_name=>'LABEL_INLINE_LG'
,p_display_name=>'Display labels inline'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17737056870408950)
,p_css_classes=>'t-NavTabs--inlineLabels-lg'
,p_group_id=>wwv_flow_api.id(17737978870408951)
,p_template_types=>'LIST'
,p_help_text=>'Display the label inline with the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17738593719408951)
,p_theme_id=>42
,p_name=>'NO_LABEL_LG'
,p_display_name=>'Do not display labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17737056870408950)
,p_css_classes=>'t-NavTabs--hiddenLabels-lg'
,p_group_id=>wwv_flow_api.id(17737978870408951)
,p_template_types=>'LIST'
,p_help_text=>'Hides the label for the list item'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17739162568408951)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17738691346408951)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(17738972615408951)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17739363844408951)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(17738691346408951)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(17738972615408951)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17739557149408951)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(17738691346408951)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(17738972615408951)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17739798154408951)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(17738691346408951)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17739900141408952)
,p_theme_id=>42
,p_name=>'WIZARD_PROGRESS_LINKS'
,p_display_name=>'Make Wizard Steps Clickable'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(17738691346408951)
,p_css_classes=>'js-wizardProgressLinks'
,p_template_types=>'LIST'
,p_help_text=>'This option will make the wizard steps clickable links.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17741158456408952)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(17740742065408952)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(17740994058408952)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17741336367408953)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(17740742065408952)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(17740994058408952)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17741793176408953)
,p_theme_id=>42
,p_name=>'HIDE_LABEL_ON_MOBILE'
,p_display_name=>'Hide Label on Mobile'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_css_classes=>'t-Button--mobileHideLabel'
,p_template_types=>'BUTTON'
,p_help_text=>'This template options hides the button label on small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17742185314408953)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(17741915086408953)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17742334979408953)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_api.id(17740994058408952)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17742569442408953)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(17741915086408953)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17742725052408953)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_api.id(17740994058408952)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17744687448408955)
,p_theme_id=>42
,p_name=>'HIDE_WHEN_ALL_ROWS_DISPLAYED'
,p_display_name=>'Hide when all rows displayed'
,p_display_sequence=>10
,p_css_classes=>'t-Report--hideNoPagination'
,p_group_id=>wwv_flow_api.id(17744491014408955)
,p_template_types=>'REPORT'
,p_help_text=>'This option will hide the pagination when all rows are displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17745076139408955)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_api.id(17744846544408955)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17745442667408956)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_api.id(17745205749408955)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17745659158408956)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_api.id(17745205749408955)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17746018831408956)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_api.id(17745860652408956)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17746280504408956)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_api.id(17745860652408956)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17746670240408956)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_api.id(17746441938408956)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17747094076408956)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(17746807069408956)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17747487051408957)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(17747265993408956)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17747600577408957)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(17746807069408956)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17747864501408957)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(17746807069408956)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17748038411408957)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(17744846544408955)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17748286672408957)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(17746441938408956)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17748656775408957)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(17748468314408957)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17748842418408957)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(17746441938408956)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17749013457408957)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(17746807069408956)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17749223609408957)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(17744846544408955)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17749485997408958)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(17748468314408957)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17749809537408958)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(17749674887408958)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17750030869408958)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(17749674887408958)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17750456477408958)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(17750201082408958)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17750657963408958)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(17750201082408958)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17750850812408958)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(17750201082408958)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17751295287408958)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(17751012957408958)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17751674934408959)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(17751446922408959)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17751852745408959)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(17751446922408959)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17752243512408959)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(17752019982408959)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17752451863408959)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(17752019982408959)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17752815184408959)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(17752667250408959)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17753277307408959)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(17753052543408959)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17753658769408960)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_api.id(17753409735408960)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17754026651408960)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_api.id(17753865933408960)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17754406203408960)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(17754215763408960)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17754670698408960)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(17754215763408960)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17754877821408960)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(17754215763408960)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17755065802408960)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(17754215763408960)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17755490632408961)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(17755202397408960)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17755669821408961)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(17755202397408960)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17755823513408961)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(17755202397408960)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17756010617408961)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(17755202397408960)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17756459142408961)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(17756297022408961)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17756640994408961)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(17756297022408961)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17756822295408961)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(17756297022408961)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17757063753408961)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(17756297022408961)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17757463635408962)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(17757255703408961)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17757606599408962)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(17757255703408961)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17757873403408962)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(17757255703408961)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17758022317408962)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(17757255703408961)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17758410608408962)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(17758265371408962)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17758663450408962)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(17758265371408962)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17758860898408962)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(17758265371408962)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17759036027408962)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(17758265371408962)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17759463543408963)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(17759241132408962)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17759663477408963)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(17759241132408962)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17759868472408963)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(17759241132408962)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17760012968408963)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(17759241132408962)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17760471887408963)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(17760231176408963)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17760648993408963)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(17760231176408963)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17760879819408963)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(17760231176408963)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17761030836408963)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(17760231176408963)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17761466782408964)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(17761247430408963)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17761603352408964)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(17761247430408963)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17761812096408964)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(17761247430408963)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17762048721408964)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(17761247430408963)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17762410587408964)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_api.id(17762261037408964)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17762865411408964)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(17762686937408964)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17763054704408964)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(17762686937408964)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(17763236961408964)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/globalization/translations
begin
null;
end;
/
prompt --application/shared_components/logic/build_options
begin
wwv_flow_api.create_build_option(
 p_id=>wwv_flow_api.id(17765471426408970)
,p_build_option_name=>'Feature: Access Control'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_ACCESS_CONTROL'
,p_build_option_comment=>'Incorporate role based user authentication within your application and manage username mappings to application roles.'
);
wwv_flow_api.create_build_option(
 p_id=>wwv_flow_api.id(17765587082408970)
,p_build_option_name=>'Feature: Activity Reporting'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_ACTIVITY_REPORTING'
,p_build_option_comment=>'Include numerous reports and charts on end user activity.'
);
wwv_flow_api.create_build_option(
 p_id=>wwv_flow_api.id(17765617625408970)
,p_build_option_name=>'Feature: Feedback'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_FEEDBACK'
,p_build_option_comment=>'Provide a mechanism for end users to post general comments back to the application administrators and developers.'
);
wwv_flow_api.create_build_option(
 p_id=>wwv_flow_api.id(17765856857408970)
,p_build_option_name=>'Feature: Configuration Options'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_CONFIGURATION'
,p_build_option_comment=>'Allow application administrators to enable or disable specific functionality, associated with an Application Express build option, from within the application.'
);
wwv_flow_api.create_build_option(
 p_id=>wwv_flow_api.id(17766194438408970)
,p_build_option_name=>'Feature: About Page'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_ABOUT_PAGE'
,p_build_option_comment=>'About this application page.'
);
wwv_flow_api.create_build_option(
 p_id=>wwv_flow_api.id(17766246912408970)
,p_build_option_name=>'Feature: Theme Style Selection'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_THEME_STYLE_SELECTION'
,p_build_option_comment=>'Allow administrators to select a default color scheme (theme style) for the application. Administrators can also choose to allow end users to choose their own theme style. '
);
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/user_interface/shortcuts/delete_confirm_msg
begin
wwv_flow_api.create_shortcut(
 p_id=>wwv_flow_api.id(17769101838408974)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>'Would you like to perform this delete action?'
);
end;
/
prompt --application/shared_components/security/authentications/application_express_authentication
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(17625077645408888)
,p_name=>'Application Express Authentication'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(17764051383408965)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN:&APP_SESSION.::&DEBUG.:::'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_api.id(17625823169408889)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(17731088352408947)
,p_nav_list_template_options=>'#DEFAULT#:t-TreeNav--styleA:js-navCollapsed--hidden'
,p_css_file_urls=>'#APP_IMAGES#app-icon.css?version=#APP_VERSION#'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(17763788787408965)
,p_nav_bar_list_template_id=>wwv_flow_api.id(17730617898408946)
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_api.create_page(
 p_id=>0
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Global Page - Desktop'
,p_step_title=>'Global Page - Desktop'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054526'
);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Home'
,p_alias=>'HOME'
,p_step_title=>'Quick Projects'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054529'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17786011485409001)
,p_plug_name=>'Quick Projects'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17669729187408913)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18065469721409261)
,p_plug_name=>'Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--featured t-Cards--block force-fa-lg:t-Cards--displayIcons:t-Cards--4cols:t-Cards--hideBody:t-Cards--animColorFill'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(18062735254409259)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(17719030469408940)
,p_plug_query_num_rows=>15
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Team Members'
,p_alias=>'TEAM-MEMBERS'
,p_step_title=>'Team Members'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define additiona'
||'l views of the data using the chart, group by, and pivot options.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data. Enter you email address and time frame under subscription to be sent the data on a regular basis.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054528'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17787386547409002)
,p_plug_name=>'Team Members'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_TEAM_MEMBERS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Team Members'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(17787441100409002)
,p_name=>'Team Members'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:3:&APP_SESSION.:::3:P3_ID:\#ID#\'
,p_detail_link_text=>'<span class="fa fa-edit" aria-hidden="true"></span>'
,p_detail_link_auth_scheme=>wwv_flow_api.id(17768397041408972)
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>17787441100409002
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17787854454409003)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17788297650409003)
,p_db_column_name=>'ROW_VERSION'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Row Version'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17788661790409003)
,p_db_column_name=>'USERNAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Username'
,p_column_link=>'f?p=&APP_ID.:9:&SESSION.:::9,RR:IR_ASSINGEE:\#USERNAME#\'
,p_column_linktext=>'#USERNAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17789065623409004)
,p_db_column_name=>'FULL_NAME'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Full Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17789471352409004)
,p_db_column_name=>'EMAIL'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Email'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17789829461409004)
,p_db_column_name=>'PHONE_NUMBER'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Phone Number'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17790248214409005)
,p_db_column_name=>'PROFILE'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Profile'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17790669770409005)
,p_db_column_name=>'PHOTO_FILENAME'
,p_display_order=>9
,p_column_identifier=>'H'
,p_column_label=>'Photo Filename'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17791082868409005)
,p_db_column_name=>'PHOTO_MIMETYPE'
,p_display_order=>10
,p_column_identifier=>'I'
,p_column_label=>'Photo Mimetype'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17791454720409005)
,p_db_column_name=>'PHOTO_CHARSET'
,p_display_order=>11
,p_column_identifier=>'J'
,p_column_label=>'Photo Charset'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17791812905409006)
,p_db_column_name=>'PHOTO_LASTUPD'
,p_display_order=>12
,p_column_identifier=>'K'
,p_column_label=>'Photo Lastupd'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17792233888409006)
,p_db_column_name=>'CREATED'
,p_display_order=>13
,p_column_identifier=>'L'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17792657698409006)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>14
,p_column_identifier=>'M'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17793083754409006)
,p_db_column_name=>'UPDATED'
,p_display_order=>15
,p_column_identifier=>'N'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17793450006409007)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>16
,p_column_identifier=>'O'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(17927220538409132)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'179273'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'USERNAME:FULL_NAME:EMAIL:PHONE_NUMBER:PROFILE'
,p_sort_column_1=>'USERNAME'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17794630065409008)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17688764363408924)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(17625334366408888)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(17742856676408953)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17793817377409007)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17787386547409002)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17796457691409009)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17787386547409002)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:3'
,p_security_scheme=>wwv_flow_api.id(17768397041408972)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17795533534409009)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(17787386547409002)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17796043403409009)
,p_event_id=>wwv_flow_api.id(17795533534409009)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(17787386547409002)
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_api.create_page(
 p_id=>3
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Team Member'
,p_alias=>'TEAM-MEMBER'
,p_page_mode=>'MODAL'
,p_step_title=>'Team Member'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(17768397041408972)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054528'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17797129230409012)
,p_plug_name=>'Team Member'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_TEAM_MEMBERS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17809903533409021)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17810320196409022)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17809903533409021)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17811918655409023)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(17809903533409021)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P3_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17812338172409023)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17809903533409021)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17812736165409023)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(17809903533409021)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17797505475409012)
,p_name=>'P3_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ID'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17797963798409013)
,p_name=>'P3_ROW_VERSION'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Row Version'
,p_source=>'ROW_VERSION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17798326660409013)
,p_name=>'P3_USERNAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Username'
,p_source=>'USERNAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17798795242409013)
,p_name=>'P3_FULL_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Full Name'
,p_source=>'FULL_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17799198305409013)
,p_name=>'P3_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Email'
,p_source=>'EMAIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17799570455409014)
,p_name=>'P3_PHONE_NUMBER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Phone Number'
,p_source=>'PHONE_NUMBER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17799906680409014)
,p_name=>'P3_PROFILE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Profile'
,p_source=>'PROFILE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>5
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17800398597409014)
,p_name=>'P3_PHOTO'
,p_source_data_type=>'BLOB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Photo'
,p_source=>'PHOTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17800749277409015)
,p_name=>'P3_PHOTO_FILENAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Photo Filename'
,p_source=>'PHOTO_FILENAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>512
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17801190914409015)
,p_name=>'P3_PHOTO_MIMETYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Photo Mimetype'
,p_source=>'PHOTO_MIMETYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>512
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17801553231409015)
,p_name=>'P3_PHOTO_CHARSET'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Photo Charset'
,p_source=>'PHOTO_CHARSET'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>512
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17801970003409016)
,p_name=>'P3_PHOTO_LASTUPD'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Photo Lastupd'
,p_source=>'PHOTO_LASTUPD'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17802710399409016)
,p_name=>'P3_CREATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created'
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17803500901409017)
,p_name=>'P3_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created By'
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17803998177409017)
,p_name=>'P3_UPDATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated'
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17804763916409017)
,p_name=>'P3_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(17797129230409012)
,p_item_source_plug_id=>wwv_flow_api.id(17797129230409012)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated By'
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17802426897409016)
,p_validation_name=>'P3_PHOTO_LASTUPD must be timestamp'
,p_validation_sequence=>110
,p_validation=>'P3_PHOTO_LASTUPD'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17801970003409016)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17803233503409017)
,p_validation_name=>'P3_CREATED must be timestamp'
,p_validation_sequence=>120
,p_validation=>'P3_CREATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17802710399409016)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17804441194409017)
,p_validation_name=>'P3_UPDATED must be timestamp'
,p_validation_sequence=>140
,p_validation=>'P3_UPDATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17803998177409017)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17810469988409022)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(17810320196409022)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17811205536409022)
,p_event_id=>wwv_flow_api.id(17810469988409022)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17813593339409024)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(17797129230409012)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Team Member'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17813906515409024)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17813167896409024)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(17797129230409012)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Team Member'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00004
begin
wwv_flow_api.create_page(
 p_id=>4
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Projects'
,p_alias=>'PROJECTS'
,p_step_title=>'Projects'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define additiona'
||'l views of the data using the chart, group by, and pivot options.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data. Enter you email address and time frame under subscription to be sent the data on a regular basis.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054528'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17815664372409026)
,p_plug_name=>'Projects'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_PROJECTS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Projects'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(17815778545409026)
,p_name=>'Projects'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:5:&APP_SESSION.:::5:P5_ID:\#ID#\'
,p_detail_link_text=>'<span class="fa fa-edit" aria-hidden="true"></span>'
,p_detail_link_auth_scheme=>wwv_flow_api.id(17768397041408972)
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>17815778545409026
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17816129730409026)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17816532268409027)
,p_db_column_name=>'ROW_VERSION'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Row Version'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17816928263409027)
,p_db_column_name=>'NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Name'
,p_column_link=>'f?p=&APP_ID.:7:&SESSION.:::7,RR:IR_PROJECT_ID:\#NAME#\'
,p_column_linktext=>'#NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17817317711409027)
,p_db_column_name=>'PROJECT_LEAD'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Project Lead'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(17820993840409030)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17817735784409028)
,p_db_column_name=>'BUDGET'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Budget'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17818102160409028)
,p_db_column_name=>'STATUS'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17818593522409028)
,p_db_column_name=>'COMPLETED_DATE'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Completed Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17818920945409028)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17819364685409029)
,p_db_column_name=>'CREATED'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17819785501409029)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17820190922409029)
,p_db_column_name=>'UPDATED'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17820544886409030)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(17959454158409163)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'179595'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:PROJECT_LEAD:BUDGET:STATUS:COMPLETED_DATE:DESCRIPTION'
,p_sort_column_1=>'NAME'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17822320017409031)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17688764363408924)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(17625334366408888)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(17742856676408953)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17821518460409030)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17815664372409026)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17824185690409032)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17815664372409026)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:5'
,p_security_scheme=>wwv_flow_api.id(17768397041408972)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17823259799409032)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(17815664372409026)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17823770507409032)
,p_event_id=>wwv_flow_api.id(17823259799409032)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(17815664372409026)
);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_api.create_page(
 p_id=>5
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Project'
,p_alias=>'PROJECT'
,p_page_mode=>'MODAL'
,p_step_title=>'Project'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(17768397041408972)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054529'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17824888642409035)
,p_plug_name=>'Project'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_PROJECTS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17834811369409042)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17835265035409042)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17834811369409042)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17836846493409043)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(17834811369409042)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17837218416409044)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17834811369409042)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17837676376409044)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(17834811369409042)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17825202052409035)
,p_name=>'P5_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ID'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17825697650409035)
,p_name=>'P5_ROW_VERSION'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Row Version'
,p_source=>'ROW_VERSION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17826019653409036)
,p_name=>'P5_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17826497006409036)
,p_name=>'P5_PROJECT_LEAD'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Project Lead'
,p_source=>'PROJECT_LEAD'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'HOL_TEAM_MEMBERS.USERNAME'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17826808081409036)
,p_name=>'P5_BUDGET'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Budget'
,p_source=>'BUDGET'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17827252418409037)
,p_name=>'P5_STATUS'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Status'
,p_source=>'STATUS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17827674640409037)
,p_name=>'P5_COMPLETED_DATE'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Completed Date'
,p_source=>'COMPLETED_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17828436778409037)
,p_name=>'P5_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Description'
,p_source=>'DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>5
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17828851383409038)
,p_name=>'P5_CREATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created'
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17829627249409038)
,p_name=>'P5_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created By'
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17830065329409039)
,p_name=>'P5_UPDATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated'
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17830863436409039)
,p_name=>'P5_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(17824888642409035)
,p_item_source_plug_id=>wwv_flow_api.id(17824888642409035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated By'
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17828173327409037)
,p_validation_name=>'P5_COMPLETED_DATE must be timestamp'
,p_validation_sequence=>60
,p_validation=>'P5_COMPLETED_DATE'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17827674640409037)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17829319390409038)
,p_validation_name=>'P5_CREATED must be timestamp'
,p_validation_sequence=>80
,p_validation=>'P5_CREATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17828851383409038)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17830552788409039)
,p_validation_name=>'P5_UPDATED must be timestamp'
,p_validation_sequence=>100
,p_validation=>'P5_UPDATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17830065329409039)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17835337320409042)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(17835265035409042)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17836150409409043)
,p_event_id=>wwv_flow_api.id(17835337320409042)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17838425201409044)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(17824888642409035)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Project'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17838837934409045)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17838078058409044)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(17824888642409035)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Project'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_api.create_page(
 p_id=>6
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Milestones'
,p_alias=>'MILESTONES'
,p_step_title=>'Milestones'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>You can insert, update, and delete data directly within this interactive grid.<br>',
'  Insert a new row by clicking the Add Row button.<br>',
'  Double click into a cell, or click the <strong>Edit</strong> button to update data values, similar to editing data in a spreadsheet.</p>',
'',
'<p>Use the Row Actions menu ( <span class="fa fa-bars" aria-hidden="true"></span> ) at the top of the report to duplicate, delete, refresh or revert selected rows.<br> ',
'  Use the Row Actions menu on individual rows to also access the single row view or add a new row.</p>',
'',
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define an additi'
||'onal view of the data using the chart option.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive grid back to the default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054529'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17840561852409047)
,p_plug_name=>'Milestones'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_MILESTONES'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_page_header=>'Milestones'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17841765956409050)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17842215814409051)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17842879293409055)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'ID'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_enable_filter=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17843409245409057)
,p_name=>'PROJECT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Project'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(17849183181409061)
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17844043250409057)
,p_name=>'ROW_VERSION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROW_VERSION'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Row Version'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>50
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17844640025409058)
,p_name=>'NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17845252351409058)
,p_name=>'DUE_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_DATE'
,p_data_type=>'TIMESTAMP_LTZ'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Due Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17845807827409058)
,p_name=>'DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17846451115409059)
,p_name=>'CREATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED'
,p_data_type=>'TIMESTAMP_LTZ'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Created'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17847076402409059)
,p_name=>'CREATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_BY'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Created By'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17847623753409060)
,p_name=>'UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED'
,p_data_type=>'TIMESTAMP_LTZ'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Updated'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(17848246700409060)
,p_name=>'UPDATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED_BY'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_heading=>'Updated By'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>true
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(17841007834409048)
,p_internal_uid=>17841007834409048
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(17841404530409049)
,p_interactive_grid_id=>wwv_flow_api.id(17841007834409048)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(17841500688409049)
,p_report_id=>wwv_flow_api.id(17841404530409049)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17842648524409052)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(17842215814409051)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17843239545409057)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(17842879293409055)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17843852520409057)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(17843409245409057)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17844458243409057)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(17844043250409057)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17845059531409058)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(17844640025409058)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17845656732409058)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(17845252351409058)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17846253697409059)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(17845807827409058)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17846879097409059)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(17846451115409059)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17847406860409059)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(17847076402409059)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17848089438409060)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(17847623753409060)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(17848696594409060)
,p_view_id=>wwv_flow_api.id(17841500688409049)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(17848246700409060)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17849987798409062)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17688764363408924)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(17625334366408888)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(17742856676408953)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17848884893409060)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(17840561852409047)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Milestones - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_api.create_page(
 p_id=>7
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Tasks'
,p_alias=>'TASKS'
,p_step_title=>'Tasks'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define additiona'
||'l views of the data using the chart, group by, and pivot options.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data. Enter you email address and time frame under subscription to be sent the data on a regular basis.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054529'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17851446455409064)
,p_plug_name=>'Tasks'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_TASKS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Tasks'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(17851515102409064)
,p_name=>'Tasks'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:8:&APP_SESSION.:::8:P8_ID:\#ID#\'
,p_detail_link_text=>'<span class="fa fa-edit" aria-hidden="true"></span>'
,p_detail_link_auth_scheme=>wwv_flow_api.id(17768397041408972)
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>17851515102409064
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17851907746409065)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17852304906409065)
,p_db_column_name=>'PROJECT_ID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Project'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(17849183181409061)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17852717432409065)
,p_db_column_name=>'MILESTONE_ID'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Milestone'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(17857911420409069)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17853175868409066)
,p_db_column_name=>'ROW_VERSION'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Row Version'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17853592508409066)
,p_db_column_name=>'NAME'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Name'
,p_column_link=>'f?p=&APP_ID.:11:&SESSION.:::11,RR:IR_TASK_ID:\#NAME#\'
,p_column_linktext=>'#NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17853923342409066)
,p_db_column_name=>'ASSIGNEE'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Assignee'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(17820993840409030)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17854376134409066)
,p_db_column_name=>'START_DATE'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17854794277409067)
,p_db_column_name=>'END_DATE'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'End Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17855130889409067)
,p_db_column_name=>'COST'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Cost'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17855510867409067)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17855965114409068)
,p_db_column_name=>'IS_COMPLETE_YN'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Is Complete '
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17856372620409068)
,p_db_column_name=>'CREATED'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17856765240409068)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17857103145409068)
,p_db_column_name=>'UPDATED'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17857524664409069)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(17990400499409193)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'179905'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT_ID:MILESTONE_ID:NAME:ASSIGNEE:START_DATE:END_DATE:COST:DESCRIPTION:IS_COMPLETE_YN'
,p_sort_column_1=>'PROJECT_ID'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17859977562409071)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17688764363408924)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(17625334366408888)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(17742856676408953)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17859103332409070)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17851446455409064)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17861763949409072)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17851446455409064)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:8'
,p_security_scheme=>wwv_flow_api.id(17768397041408972)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17860856987409071)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(17851446455409064)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17861370304409072)
,p_event_id=>wwv_flow_api.id(17860856987409071)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(17851446455409064)
);
end;
/
prompt --application/pages/page_00008
begin
wwv_flow_api.create_page(
 p_id=>8
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Task'
,p_alias=>'TASK'
,p_page_mode=>'MODAL'
,p_step_title=>'Task'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(17768397041408972)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812055327'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17862470478409074)
,p_plug_name=>'Task'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_TASKS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17874989213409084)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17875398522409084)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17874989213409084)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17876920461409085)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(17874989213409084)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P8_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17877342217409085)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17874989213409084)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P8_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17877749365409085)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(17874989213409084)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P8_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17862850210409075)
,p_name=>'P8_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ID'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17863293387409075)
,p_name=>'P8_PROJECT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_prompt=>'Project'
,p_source=>'PROJECT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'HOL_PROJECTS.NAME'
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17863659777409075)
,p_name=>'P8_MILESTONE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_prompt=>'Milestone'
,p_source=>'MILESTONE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'HOL_MILESTONES.NAME PAGE 8'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P8_PROJECT_ID'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17864003619409076)
,p_name=>'P8_ROW_VERSION'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Row Version'
,p_source=>'ROW_VERSION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17864415127409076)
,p_name=>'P8_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17864890043409076)
,p_name=>'P8_ASSIGNEE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Assignee'
,p_source=>'ASSIGNEE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'HOL_TEAM_MEMBERS.USERNAME'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17865219307409077)
,p_name=>'P8_START_DATE'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Start Date'
,p_source=>'START_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17866015613409077)
,p_name=>'P8_END_DATE'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'End Date'
,p_source=>'END_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17866855994409078)
,p_name=>'P8_COST'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cost'
,p_source=>'COST'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17867296588409078)
,p_name=>'P8_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Description'
,p_source=>'DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>5
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17867624711409078)
,p_name=>'P8_IS_COMPLETE_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Is Complete '
,p_source=>'IS_COMPLETE_YN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_cSize=>32
,p_cMaxlength=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17868057660409079)
,p_name=>'P8_CREATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created'
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17868847105409079)
,p_name=>'P8_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created By'
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17869288303409079)
,p_name=>'P8_UPDATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated'
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17870081323409080)
,p_name=>'P8_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(17862470478409074)
,p_item_source_plug_id=>wwv_flow_api.id(17862470478409074)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated By'
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17865728366409077)
,p_validation_name=>'P8_START_DATE must be timestamp'
,p_validation_sequence=>60
,p_validation=>'P8_START_DATE'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17865219307409077)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17866527672409077)
,p_validation_name=>'P8_END_DATE must be timestamp'
,p_validation_sequence=>70
,p_validation=>'P8_END_DATE'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17866015613409077)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17868513895409079)
,p_validation_name=>'P8_CREATED must be timestamp'
,p_validation_sequence=>110
,p_validation=>'P8_CREATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17868057660409079)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17869732533409080)
,p_validation_name=>'P8_UPDATED must be timestamp'
,p_validation_sequence=>130
,p_validation=>'P8_UPDATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17869288303409079)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17875481354409084)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(17875398522409084)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17876225731409084)
,p_event_id=>wwv_flow_api.id(17875481354409084)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17878585036409086)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(17862470478409074)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Task'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17878943643409086)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17878105033409086)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(17862470478409074)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Task'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00009
begin
wwv_flow_api.create_page(
 p_id=>9
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'To Dos'
,p_alias=>'TO-DOS'
,p_step_title=>'To Dos'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define additiona'
||'l views of the data using the chart, group by, and pivot options.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data. Enter you email address and time frame under subscription to be sent the data on a regular basis.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812055836'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17880681019409088)
,p_plug_name=>'To Dos'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'     (select p.name',
'      from hol_projects p, hol_tasks t',
'      where p.id = t.project_id',
'      and t.id = td.task_id',
'     ) project,',
'     (select m.name',
'      from hol_milestones m, hol_tasks t',
'      where m.id = t.milestone_id',
'      and   t.id = td.task_id',
'     ) milestone,',
'     TASK_ID,',
'     ROW_VERSION,',
'     TODO,',
'     ASSINGEE,',
'     DUE_DATE,',
'     DETAILS,',
'     CREATED,',
'     CREATED_BY,',
'     UPDATED,',
'     UPDATED_BY',
'from HOL_TO_DOS td'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_page_header=>'To Dos'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(17880756888409088)
,p_name=>'To Dos'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:10:&APP_SESSION.:::10:P10_ID:\#ID#\'
,p_detail_link_text=>'<span class="fa fa-edit" aria-hidden="true"></span>'
,p_detail_link_auth_scheme=>wwv_flow_api.id(17768397041408972)
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>17880756888409088
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17881113598409089)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17881534002409089)
,p_db_column_name=>'TASK_ID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Task'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(17885598273409092)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17881970486409089)
,p_db_column_name=>'ROW_VERSION'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Row Version'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17882352348409090)
,p_db_column_name=>'TODO'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Todo'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17882771789409090)
,p_db_column_name=>'ASSINGEE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Assingee'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(17820993840409030)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17883152172409090)
,p_db_column_name=>'DUE_DATE'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Due Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17883532813409091)
,p_db_column_name=>'DETAILS'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Details'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17883996188409091)
,p_db_column_name=>'CREATED'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17884384660409091)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17884733721409091)
,p_db_column_name=>'UPDATED'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17885188046409092)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17442413413394443)
,p_db_column_name=>'PROJECT'
,p_display_order=>21
,p_column_identifier=>'L'
,p_column_label=>'Project'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17442509509394444)
,p_db_column_name=>'MILESTONE'
,p_display_order=>31
,p_column_identifier=>'M'
,p_column_label=>'Milestone'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18019398784409220)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'180194'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:MILESTONE:TASK_ID:TODO:ASSINGEE:DUE_DATE:DETAILS:'
,p_sort_column_1=>'TASK_ID'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17887206293409093)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17688764363408924)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(17625334366408888)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(17742856676408953)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17886479228409093)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17880681019409088)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.:RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17889014536409095)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17880681019409088)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:10'
,p_security_scheme=>wwv_flow_api.id(17768397041408972)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17888115318409094)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(17880681019409088)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17888674455409094)
,p_event_id=>wwv_flow_api.id(17888115318409094)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(17880681019409088)
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'To Dos'
,p_alias=>'TO-DOS1'
,p_page_mode=>'MODAL'
,p_step_title=>'To Dos'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(17768397041408972)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812060201'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17889712636409097)
,p_plug_name=>'To Dos'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_TO_DOS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17899036207409104)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17899496762409104)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17899036207409104)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17901039932409106)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(17899036207409104)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P10_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17901488104409106)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17899036207409104)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17901879596409106)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(17899036207409104)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17890173142409097)
,p_name=>'P10_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ID'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17890534747409098)
,p_name=>'P10_TASK_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_prompt=>'Task'
,p_source=>'TASK_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'HOL_TASKS.NAME'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id',
',      (select p.name from hol_projects p where p.id = t.project_id) project',
',      (select m.name from hol_milestones m where m.id = t.milestone_id) milestone',
',      name',
'from hol_tasks t'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17890907986409098)
,p_name=>'P10_ROW_VERSION'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Row Version'
,p_source=>'ROW_VERSION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17891302696409098)
,p_name=>'P10_TODO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Todo'
,p_source=>'TODO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17891764080409099)
,p_name=>'P10_ASSINGEE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Assingee'
,p_source=>'ASSINGEE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'HOL_TEAM_MEMBERS.USERNAME'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17892174685409099)
,p_name=>'P10_DUE_DATE'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Due Date'
,p_source=>'DUE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17892942229409100)
,p_name=>'P10_DETAILS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Details'
,p_source=>'DETAILS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>5
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17893315114409100)
,p_name=>'P10_CREATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created'
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17894111074409100)
,p_name=>'P10_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created By'
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17894576205409101)
,p_name=>'P10_UPDATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated'
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17895374300409101)
,p_name=>'P10_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(17889712636409097)
,p_item_source_plug_id=>wwv_flow_api.id(17889712636409097)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated By'
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17892682234409099)
,p_validation_name=>'P10_DUE_DATE must be timestamp'
,p_validation_sequence=>50
,p_validation=>'P10_DUE_DATE'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17892174685409099)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17893829595409100)
,p_validation_name=>'P10_CREATED must be timestamp'
,p_validation_sequence=>70
,p_validation=>'P10_CREATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17893315114409100)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17895080756409101)
,p_validation_name=>'P10_UPDATED must be timestamp'
,p_validation_sequence=>90
,p_validation=>'P10_UPDATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17894576205409101)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17899548500409104)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(17899496762409104)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17900331910409105)
,p_event_id=>wwv_flow_api.id(17899548500409104)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17902627963409107)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(17889712636409097)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form To Dos'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17903030054409107)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17902230408409107)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(17889712636409097)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form To Dos'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_api.create_page(
 p_id=>11
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Links'
,p_alias=>'LINKS'
,p_step_title=>'Links'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>To find data enter a search term into the search dialog, or click on the column headings to limit the records returned.</p>',
'',
'<p>You can perform numerous functions by clicking the <strong>Actions</strong> button. This includes selecting the columns that are displayed / hidden and their display sequence, plus numerous data and format functions.  You can also define additiona'
||'l views of the data using the chart, group by, and pivot options.</p>',
'',
'<p>If you want to save your customizations select report, or click download to unload the data. Enter you email address and time frame under subscription to be sent the data on a regular basis.<p>',
'',
'<p>For additional information click Help at the bottom of the Actions menu.</p> ',
'',
'<p>Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812060532'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17904765580409109)
,p_plug_name=>'Links'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'   (select p.name',
'    from hol_projects p, hol_tasks t',
'    where p.id = t.project_id',
'    and t.id = l.task_id',
'   ) project,',
'   (select m.name',
'    from hol_milestones m, hol_tasks t',
'    where m.id = t.milestone_id',
'    and   t.id = l.task_id',
'   ) milestone,',
'   TASK_ID,',
'   ROW_VERSION,',
'   URL,',
'   NAME,',
'   DESCRIPTION,',
'   CREATED,',
'   CREATED_BY,',
'   UPDATED,',
'   UPDATED_BY',
'from HOL_LINKS l'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_page_header=>'Links'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(17904853455409109)
,p_name=>'Links'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:12:&APP_SESSION.:::12:P12_ID:\#ID#\'
,p_detail_link_text=>'<span class="fa fa-edit" aria-hidden="true"></span>'
,p_detail_link_auth_scheme=>wwv_flow_api.id(17768397041408972)
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>17904853455409109
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17905266127409110)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17905667713409110)
,p_db_column_name=>'TASK_ID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Task'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(17885598273409092)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17906064238409110)
,p_db_column_name=>'ROW_VERSION'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Row Version'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17906409329409111)
,p_db_column_name=>'URL'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'URL'
,p_column_link=>'#URL#'
,p_column_linktext=>'#URL#'
,p_column_link_attr=>'target="_blank"'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17906844095409111)
,p_db_column_name=>'NAME'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17907291840409111)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17907603320409112)
,p_db_column_name=>'CREATED'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17908052646409112)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17908483474409112)
,p_db_column_name=>'UPDATED'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'Y'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17908826677409112)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17442622892394445)
,p_db_column_name=>'PROJECT'
,p_display_order=>20
,p_column_identifier=>'K'
,p_column_label=>'Project'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(17442738570394446)
,p_db_column_name=>'MILESTONE'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'Milestone'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18041991827409240)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'180420'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROJECT:MILESTONE:TASK_ID:URL:NAME:DESCRIPTION:'
,p_sort_column_1=>'TASK_ID'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17910302046409114)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17688764363408924)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(17625334366408888)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(17742856676408953)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17909557964409113)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17904765580409109)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17912182898409115)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17904765580409109)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:12'
,p_security_scheme=>wwv_flow_api.id(17768397041408972)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17911278471409115)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(17904765580409109)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17911708578409115)
,p_event_id=>wwv_flow_api.id(17911278471409115)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(17904765580409109)
);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_api.create_page(
 p_id=>12
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Link'
,p_alias=>'LINK'
,p_page_mode=>'MODAL'
,p_step_title=>'Link'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(17768397041408972)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812060615'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17912890973409118)
,p_plug_name=>'Link'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'HOL_LINKS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17921041495409124)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17921481962409124)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(17921041495409124)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17923088919409125)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(17921041495409124)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P12_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17923410137409125)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(17921041495409124)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P12_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17923833263409126)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(17921041495409124)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P12_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17913278952409118)
,p_name=>'P12_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ID'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17913646822409118)
,p_name=>'P12_TASK_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_prompt=>'Task'
,p_source=>'TASK_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'HOL_TASKS.NAME'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id',
',      (select p.name from hol_projects p where p.id = t.project_id) project',
',      (select m.name from hol_milestones m where m.id = t.milestone_id) milestone',
',      name',
'from hol_tasks t'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17914093731409119)
,p_name=>'P12_ROW_VERSION'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Row Version'
,p_source=>'ROW_VERSION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17914431223409119)
,p_name=>'P12_URL'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'URL'
,p_source=>'URL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17914897517409119)
,p_name=>'P12_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17915295225409119)
,p_name=>'P12_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Description'
,p_source=>'DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>5
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17915614789409120)
,p_name=>'P12_CREATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created'
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17916445568409120)
,p_name=>'P12_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Created By'
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17916816977409121)
,p_name=>'P12_UPDATED'
,p_source_data_type=>'TIMESTAMP_LTZ'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated'
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17917658470409121)
,p_name=>'P12_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(17912890973409118)
,p_item_source_plug_id=>wwv_flow_api.id(17912890973409118)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Updated By'
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_cSize=>60
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17916141656409120)
,p_validation_name=>'P12_CREATED must be timestamp'
,p_validation_sequence=>60
,p_validation=>'P12_CREATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17915614789409120)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(17917342671409121)
,p_validation_name=>'P12_UPDATED must be timestamp'
,p_validation_sequence=>80
,p_validation=>'P12_UPDATED'
,p_validation_type=>'ITEM_IS_TIMESTAMP'
,p_error_message=>'#LABEL# must be a valid timestamp.'
,p_associated_item=>wwv_flow_api.id(17916816977409121)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(17921571569409124)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(17921481962409124)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(17922369713409125)
,p_event_id=>wwv_flow_api.id(17921571569409124)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17924620731409126)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(17912890973409118)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Link'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17925047766409126)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17924210219409126)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(17912890973409118)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Link'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_09999
begin
wwv_flow_api.create_page(
 p_id=>9999
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'Quick Projects - Sign In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(17632029951408893)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054527'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17779266206408995)
,p_plug_name=>'Quick Projects'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17678042343408918)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17783941141408998)
,p_plug_name=>'Language Selector'
,p_parent_plug_id=>wwv_flow_api.id(17779266206408995)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>'apex_lang.emit_language_selector_list;'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17782031049408997)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(17779266206408995)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_alignment=>'LEFT'
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17779616510408995)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(17779266206408995)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740098066408952)
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17780030864408996)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(17779266206408995)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(17740098066408952)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(17781129185408996)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(17779266206408995)
,p_prompt=>'Remember username'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOGIN_REMEMBER_USERNAME'
,p_lov=>'.'||wwv_flow_api.id(17780365855408996)||'.'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(17740098066408952)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'If you select this checkbox, the application will save your username in a persistent browser cookie named "LOGIN_USERNAME_COOKIE".',
'When you go to the login page the next time,',
'the username field will be automatically populated with this value.',
'</p>',
'<p>',
'If you deselect this checkbox and your username is already saved in the cookie,',
'the application will overwrite it with an empty value.',
'You can also use your browser''s developer tools to completely remove the cookie.',
'</p>'))
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17782846463408998)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P9999_USERNAME),',
'    p_consent  => :P9999_REMEMBER = ''Y'' );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17782481571408997)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P9999_USERNAME,',
'    p_password => :P9999_PASSWORD );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17783671019408998)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(17783226403408998)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P9999_USERNAME := apex_authentication.get_login_username_cookie;',
':P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;'))
);
end;
/
prompt --application/pages/page_10000
begin
wwv_flow_api.create_page(
 p_id=>10000
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Administration'
,p_alias=>'ADMIN'
,p_step_title=>'Administration'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_deep_linking=>'N'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The administration page allows application owners (Administrators) to configure the application and maintain common data used across the application.',
'By selecting one of the available settings, administrators can potentially change how the application is displayed and/or features available to the end users.</p>',
'<p>Access to this page should be limited to Administrators only.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054531'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18202274376409408)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17688764363408924)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(17625334366408888)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(17742856676408953)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18208334149409412)
,p_plug_name=>'Column 1'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652105806408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18208754716409412)
,p_plug_name=>'Configuration'
,p_parent_plug_id=>wwv_flow_api.id(18208334149409412)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17679306367408919)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(18202803917409409)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_plug_query_num_rows=>15
,p_required_patch=>wwv_flow_api.id(17765856857408970)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18209133607409413)
,p_plug_name=>'User Interface'
,p_parent_plug_id=>wwv_flow_api.id(18208334149409412)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17679306367408919)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(18203520541409409)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_plug_query_num_rows=>15
,p_required_patch=>wwv_flow_api.id(17766246912408970)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18209593138409413)
,p_plug_name=>'Activity Reports'
,p_parent_plug_id=>wwv_flow_api.id(18208334149409412)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17679306367408919)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(18204296141409410)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_plug_query_num_rows=>15
,p_required_patch=>wwv_flow_api.id(17765587082408970)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18209954813409413)
,p_plug_name=>'Column 2'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652105806408904)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18210381434409413)
,p_plug_name=>'Access Control'
,p_parent_plug_id=>wwv_flow_api.id(18209954813409413)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17679306367408919)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_required_patch=>wwv_flow_api.id(17765471426408970)
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18211143163409414)
,p_plug_name=>'ACL Information'
,p_parent_plug_id=>wwv_flow_api.id(18210381434409413)
,p_region_css_classes=>'margin-sm'
,p_region_template_options=>'#DEFAULT#:t-Alert--colorBG:t-Alert--horizontal:t-Alert--noIcon:t-Alert--warning:t-Alert--accessibleHeading'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17648207118408902)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_acl_scope   varchar2(45);',
'begin',
'    l_acl_scope   := apex_app_setting.get_value( p_name => ''ACCESS_CONTROL_SCOPE'' );',
'',
'    if l_acl_scope = ''ALL_USERS'' then',
'        sys.htp.p( apex_lang.message(''APEX.FEATURE.ACL.INFO.ALL_USERS'') );',
'    elsif l_acl_scope = ''ACL_ONLY'' then',
'        sys.htp.p( apex_lang.message(''APEX.FEATURE.ACL.INFO.ACL_ONLY'') );',
'    else',
'        sys.htp.p( apex_lang.message(''APEX.FEATURE.ACL.INFO.ACL_VALUE_INVALID'', l_acl_scope) );',
'    end if;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(18211539414409414)
,p_name=>'User Counts Report'
,p_parent_plug_id=>wwv_flow_api.id(18210381434409413)
,p_template=>wwv_flow_api.id(17679306367408919)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody:t-Region--noPadding'
,p_component_template_options=>'#DEFAULT#:t-AVPList--rightAligned'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.role_name, (select count(*) from apex_appl_acl_user_roles ur where r.role_id = ur.role_id) user_count, r.role_id',
'from  APEX_APPL_ACL_ROLES r',
'where r.application_id = :APP_ID',
'group by r.role_name, r.role_id',
'order by 2 desc, 1'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(17713269817408937)
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18212206622409415)
,p_query_column_id=>1
,p_column_alias=>'ROLE_NAME'
,p_column_display_sequence=>1
,p_column_heading=>'Role Name'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18212665982409416)
,p_query_column_id=>2
,p_column_alias=>'USER_COUNT'
,p_column_display_sequence=>2
,p_column_heading=>'User Count'
,p_column_format=>'999G999G999G999G999G999G990'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18213059327409416)
,p_query_column_id=>3
,p_column_alias=>'ROLE_ID'
,p_column_display_sequence=>3
,p_column_heading=>'Role Id'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18216130578409419)
,p_plug_name=>'Access Control Actions'
,p_parent_plug_id=>wwv_flow_api.id(18210381434409413)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(18206560100409411)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_plug_query_num_rows=>15
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18216570637409419)
,p_plug_name=>'Feedback'
,p_parent_plug_id=>wwv_flow_api.id(18209954813409413)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17679306367408919)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_required_patch=>wwv_flow_api.id(17765617625408970)
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(18216937456409419)
,p_name=>'Report'
,p_parent_plug_id=>wwv_flow_api.id(18216570637409419)
,p_template=>wwv_flow_api.id(17679306367408919)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody:t-Region--noPadding'
,p_component_template_options=>'#DEFAULT#:t-AVPList--rightAligned'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.display_value feedback_status, ',
'(select count(*) from apex_team_feedback f where f.application_id = :APP_ID and f.feedback_status = l.return_value) feedback_count ',
'from apex_application_lov_entries l',
'where l.application_id = :APP_ID',
'and l.list_of_values_name = ''FEEDBACK_STATUS''',
'order by 2 desc, 1'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(17713269817408937)
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18217640868409420)
,p_query_column_id=>1
,p_column_alias=>'FEEDBACK_STATUS'
,p_column_display_sequence=>1
,p_column_heading=>'Feedback Status'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18218016959409421)
,p_query_column_id=>2
,p_column_alias=>'FEEDBACK_COUNT'
,p_column_display_sequence=>2
,p_column_heading=>'Feedback Count'
,p_column_format=>'999G999G999G999G999G999G990'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18219917310409422)
,p_plug_name=>'Feedback'
,p_parent_plug_id=>wwv_flow_api.id(18216570637409419)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(18207620580409412)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(17726217906408944)
,p_plug_query_num_rows=>15
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18210739044409414)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18210381434409413)
,p_button_name=>'ADD_USER'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Add'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10042:&SESSION.::&DEBUG.:RP,10042::'
,p_icon_css_classes=>'fa-user-plus'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18215287173409418)
,p_name=>'Refresh on Dialog Close'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18210739044409414)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18215729084409418)
,p_event_id=>wwv_flow_api.id(18215287173409418)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18211539414409414)
);
end;
/
prompt --application/pages/page_10010
begin
wwv_flow_api.create_page(
 p_id=>10010
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Configuration Options'
,p_alias=>'CONFIGURATION-OPTIONS'
,p_page_mode=>'MODAL'
,p_step_title=>'Configuration Options'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765856857408970)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Configuration settings allow you to make specific functionality either available (enabled) or unavailable (disabled) to end users.</p>',
'<p>If a specific function is not 100% ready, or needs to be temporarily removed, click <strong>Disabled</strong>. ',
'Once it should be made available, simply click <strong>Enabled</strong>.</p>',
'<p><em><strong>Note:</strong> Changes made here will not be reflected for individual end users currently running the application. Once the end user signs out and then signs back in the revised feature settings will be invoked.</em></p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054529'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18065822967409262)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18066038434409262)
,p_plug_name=>'Configuration Options'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    build_option_id     ID, ',
'    build_option_name   application_option,',
'    apex_item.hidden(1, build_option_id) ||',
'    apex_item.hidden(2, build_option_status) ||',
'    apex_item.switch ( ',
'         p_idx        => 3,',
'         p_value      => build_option_status,',
'         p_on_value   => ''Include'',',
'         p_on_label   => m.enabled,',
'         p_off_value  => ''Exclude'',',
'         p_off_label  => m.disabled,',
'         p_item_id    => ''BO_OPT_'' || rownum,',
'         p_item_label => ( case when build_option_status = ''Include'' then',
'                               apex_lang.message( ''APEX.FEATURE.CONFIG.IS_ENABLED'', apex_escape.html(build_option_name) )',
'                           when build_option_status = ''Exclude'' then',
'                               apex_lang.message( ''APEX.FEATURE.CONFIG.IS_DISABLED'', apex_escape.html(build_option_name) )',
'                           end ),',
'         p_attributes => ''style="white-space:pre;"'') "STATUS",',
'    component_comment   description,',
'    last_updated_on        updated,',
'    lower(last_updated_by) updated_by,',
'    build_option_status current_status',
'  from apex_application_build_options,',
'  (select apex_lang.message(''APEX.FEATURE.CONFIG.ENABLED'') enabled, apex_lang.message(''APEX.FEATURE.CONFIG.DISABLED'') disabled from dual) m',
' where application_id = :APP_ID ',
' and feature_identifier not in ( ''APPLICATION_ACCESS_CONTROL'', ''APPLICATION_CONFIGURATION'')'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Configuration Options'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18066980509409262)
,p_name=>'Configuration Options'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>18066980509409262
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18067027918409263)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18067412357409263)
,p_db_column_name=>'APPLICATION_OPTION'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Feature'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18068143095409264)
,p_db_column_name=>'STATUS'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18068513871409265)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18068949497409266)
,p_db_column_name=>'UPDATED'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18069390603409266)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18069740532409267)
,p_db_column_name=>'CURRENT_STATUS'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Current Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18070406667409268)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'180705'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'APPLICATION_OPTION:STATUS:DESCRIPTION:UPDATED:UPDATED_BY'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18072002099409269)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18065822967409262)
,p_button_name=>'APPLY_CHANGES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18071348206409268)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18066038434409262)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(18072844018409270)
,p_branch_name=>'Refresh Admin Page'
,p_branch_action=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18072420153409269)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for i in 1..apex_application.g_f01.count loop',
'    for c1 in ( select application_id, build_option_name, build_option_status',
'                from apex_application_build_options',
'                where apex_application.g_f01(i) = build_option_id',
'                   and application_Id = :APP_ID) loop',
'        if c1.build_option_status != apex_application.g_f03(i) then',
'            apex_util.set_build_option_status(  p_application_id => :APP_ID,',
'                                                p_id => apex_application.g_f01(i),',
'                                                p_build_status => upper(apex_application.g_f03(i)) );',
'        end if;',
'    end loop;',
'end loop;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Configuration Options updated. '
);
end;
/
prompt --application/pages/page_10020
begin
wwv_flow_api.create_page(
 p_id=>10020
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Application Appearance'
,p_alias=>'APPLICATION-APPEARANCE'
,p_page_mode=>'MODAL'
,p_step_title=>'Application Appearance'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17766246912408970)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Select the default color scheme used to display the application.</p>',
'<p>If <strong>Allow End Users to choose Theme Style</strong> is checked, then each end user can select from the available theme styles by clicking the <em>Customize</em> link in the bottom left corner of the Home page.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054529'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18073133629409270)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18073223100409270)
,p_plug_name=>'Configure Appearance'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18074922105409271)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18073133629409270)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18074400496409271)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18073133629409270)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(18075361250409271)
,p_branch_name=>'Branch to Admin Page'
,p_branch_action=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18075602815409272)
,p_name=>'P10020_DESKTOP_THEME_STYLE_ID'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18073223100409270)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Desktop Theme Style'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.theme_style_id',
'from apex_application_theme_styles s,',
'    apex_application_themes t',
'where s.application_id = t.application_id',
'    and s.theme_number = t.theme_number',
'    and s.application_id = :app_id',
'    and t.ui_type_name   = ''DESKTOP''',
'    and s.is_current = ''Yes'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'DESKTOP THEME STYLES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.name d,',
'    s.theme_style_id r',
'from apex_application_theme_styles s, apex_application_themes t',
'where s.application_id = t.application_id',
'    and s.theme_number = t.theme_number',
'    and s.application_id = :app_id',
'    and t.ui_type_name   = ''DESKTOP''',
'    and t.is_current = ''Yes''',
'order by 1'))
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null',
'from apex_application_theme_styles s,',
'    apex_application_themes t',
'where s.application_id = t.application_id',
'    and s.theme_number = t.theme_number',
'    and s.application_id = :app_id',
'    and t.ui_type_name   = ''DESKTOP'''))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_restricted_characters=>'WEB_SAFE'
,p_inline_help_text=>'The default Theme Style applies to all users.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18076380837409272)
,p_name=>'P10020_END_USER_STYLE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18073223100409270)
,p_use_cache_before_default=>'NO'
,p_prompt=>'End User Theme Preference'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ui.theme_style_by_user_pref',
'  from apex_application_themes t, apex_appl_user_interfaces ui',
' where ui.application_id = t.application_id',
'   and ui.theme_number   = t.theme_number',
'   and t.application_id  = :app_id ',
'   and t.ui_type_name    = ''DESKTOP''',
'   and t.is_current      = ''Yes'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'USER_THEME_PREFERENCE'
,p_lov=>'.'||wwv_flow_api.id(18076452122409272)||'.'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(17740098066408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_inline_help_text=>'If checked, end users may choose their own Theme Style using the Customize link.'
,p_attribute_01=>'1'
,p_attribute_02=>'VERTICAL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18073484734409270)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18074400496409271)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18077887077409273)
,p_event_id=>wwv_flow_api.id(18073484734409270)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18078376540409274)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Theme Style'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P10020_DESKTOP_THEME_STYLE_ID is not null then',
'    for c1 in (select theme_number',
'               from apex_application_themes',
'               where application_id = :app_id',
'               and ui_type_name   = ''DESKTOP''',
'               and is_current = ''Yes'')',
'    loop',
'        apex_util.set_current_theme_style (',
'            p_theme_number   => c1.theme_number,',
'            p_theme_style_id => :P10020_DESKTOP_THEME_STYLE_ID',
'            );',
'    end loop;',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Application Appearance Settings Saved.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18078766915409274)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save End User Style Preference'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_enabled boolean := case when :P10020_END_USER_STYLE = ''Yes'' then true else false end;',
'begin',
'    for c1 in ( select ui.theme_number',
'                from apex_application_themes t,',
'                    apex_appl_user_interfaces ui',
'                where ui.application_id = t.application_id',
'                    and ui.theme_number   = t.theme_number',
'                    and t.application_id  = :APP_ID',
'                    and t.ui_type_name    = ''DESKTOP''',
'                    and t.is_current      = ''Yes'' ) loop',
'        if l_enabled then',
'            apex_theme.enable_user_style (',
'                p_application_id => :APP_ID,',
'                p_theme_number   => c1.theme_number );',
'        else',
'            apex_theme.disable_user_style (',
'                p_application_id => :APP_ID,',
'                p_theme_number   => c1.theme_number );',
'            apex_theme.clear_all_users_style(:APP_ID);',
'        end if;',
'  end loop;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Application Appearance Settings Saved.'
);
end;
/
prompt --application/pages/page_10030
begin
wwv_flow_api.create_page(
 p_id=>10030
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Activity Dashboard'
,p_alias=>'ACTIVITY-DASHBOARD'
,p_page_mode=>'MODAL'
,p_step_title=>'Activity Dashboard'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765587082408970)
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18079082863409274)
,p_plug_name=>'Hourly Page Events'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h320:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17679306367408919)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(18079183016409274)
,p_region_id=>wwv_flow_api.id(18079082863409274)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_time_axis_type=>'enabled'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(18081282459409275)
,p_chart_id=>wwv_flow_api.id(18079183016409274)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with nw as (',
'    -- APEX_ACTIVITY_LOG uses dates; convert system time to local time zone.',
'    select from_tz( cast( sysdate as timestamp ), to_char( systimestamp, ''TZR'' ) ) at local as tm from dual',
'),',
'window as (',
'    select',
'         trunc(nw.tm - ((level-1)/24),''HH'') start_tm,',
'         trunc(nw.tm - ((level-2)/24),''HH'') end_tm,',
'         trunc(sysdate-((level-1)/24),''HH'') log_start_tm,',
'         trunc(sysdate-((level-2)/24),''HH'') log_end_tm',
'    from nw',
'    connect by level <= round( 24 * ( 1/24/60/60 * nvl(:P10030_TIMEFRAME,1) ) )',
')',
'select  w.start_tm log_time,',
'    (   select count(*)',
'        from apex_activity_log l',
'        where l.flow_id = :app_id',
'            and l.time_stamp between w.log_start_tm and w.log_end_tm ) as value',
'from window w',
'order by 1'))
,p_max_row_count=>350
,p_ajax_items_to_submit=>'P10030_TIMEFRAME'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LOG_TIME'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(18081876249409276)
,p_chart_id=>wwv_flow_api.id(18079183016409274)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(18082494152409276)
,p_chart_id=>wwv_flow_api.id(18079183016409274)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_type=>'datetime-short'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'on'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18079238319409274)
,p_plug_name=>'Most Active Pages'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h320:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17679306367408919)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(18079384480409274)
,p_region_id=>wwv_flow_api.id(18079238319409274)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(18086265731409279)
,p_chart_id=>wwv_flow_api.id(18079384480409274)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.step_id||''. ''||(select page_name from apex_application_pages p where p.application_id = :app_id and page_id = x.step_id) label, ',
'        value ',
'from',
'(',
'select step_id,',
'    count(*) as value',
'from apex_activity_log',
'where flow_id = :app_id',
'    and time_stamp >= sysdate - ( 1/24/60/60 * :P10030_TIMEFRAME )',
'    and step_id is not null',
'group by step_id',
'order by 2 desc',
') x'))
,p_max_row_count=>10
,p_ajax_items_to_submit=>'P10030_TIMEFRAME'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(18086869779409279)
,p_chart_id=>wwv_flow_api.id(18079384480409274)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(18087489461409280)
,p_chart_id=>wwv_flow_api.id(18079384480409274)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18079484874409274)
,p_plug_name=>'Top Users'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h320:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17679306367408919)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(18079570557409274)
,p_region_id=>wwv_flow_api.id(18079484874409274)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(18083706017409277)
,p_chart_id=>wwv_flow_api.id(18079570557409274)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl( userid_lc, apex_lang.message(''APEX.FEATURE.TOP_USERS.USERNAME.NOT_IDENTIFIED'') ) as label,',
'       count(*) as value',
'from apex_activity_log',
'where flow_id = :app_id',
'and time_stamp >= sysdate - ( 1/24/60/60 * :P10030_TIMEFRAME )',
'group by nvl( userid_lc, apex_lang.message(''APEX.FEATURE.TOP_USERS.USERNAME.NOT_IDENTIFIED'') )',
'order by 2 desc'))
,p_max_row_count=>10
,p_ajax_items_to_submit=>'P10030_TIMEFRAME'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(18084318190409278)
,p_chart_id=>wwv_flow_api.id(18079570557409274)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(18084954248409278)
,p_chart_id=>wwv_flow_api.id(18079570557409274)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(18079602837409274)
,p_name=>'Recent Errors'
,p_template=>wwv_flow_api.id(17679306367408919)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--inline'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'    sqlerrm label,',
'    time_stamp value',
'from apex_activity_log',
'where flow_id = :app_id',
'and time_stamp >= sysdate - ( 1/24/60/60 * :P10030_TIMEFRAME )',
'and sqlerrm is not null',
'order by 2 desc, 1'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P10030_TIMEFRAME'
,p_query_row_template=>wwv_flow_api.id(17708296566408934)
,p_query_num_rows=>20
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18088570060409281)
,p_query_column_id=>1
,p_column_alias=>'LABEL'
,p_column_display_sequence=>1
,p_column_heading=>'Label'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18088917967409281)
,p_query_column_id=>2
,p_column_alias=>'VALUE'
,p_column_display_sequence=>2
,p_column_heading=>'Value'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(18079789468409274)
,p_name=>'Latest Activity'
,p_template=>wwv_flow_api.id(17679306367408919)
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--inline'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select userid_lc as username,',
'    max(time_stamp) as last_activity',
'from apex_activity_log',
'where flow_id = :app_id',
'    and time_stamp >= sysdate - ( 1/24/60/60 * :P10030_TIMEFRAME )',
'    and userid_lc is not null',
'group by userid_lc',
'order by 2 desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P10030_TIMEFRAME'
,p_query_row_template=>wwv_flow_api.id(17708296566408934)
,p_query_num_rows=>20
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No activities found'
,p_query_row_count_max=>500
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18091619699409284)
,p_query_column_id=>1
,p_column_alias=>'USERNAME'
,p_column_display_sequence=>1
,p_column_heading=>'Username'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18092029505409285)
,p_query_column_id=>2
,p_column_alias=>'LAST_ACTIVITY'
,p_column_display_sequence=>2
,p_column_heading=>'Last Activity'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18079882605409274)
,p_plug_name=>'Filters'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noUI:t-Form--large'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18094393548409287)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18079082863409274)
,p_button_name=>'VIEW_ACTIVITY_BY_USER'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>wwv_flow_api.id(17740742065408952)
,p_button_image_alt=>'View Details'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10031:&SESSION.::&DEBUG.:RP,10031::'
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18094763300409287)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18079238319409274)
,p_button_name=>'VIEW_ACTIVITY_DETAILS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>wwv_flow_api.id(17740742065408952)
,p_button_image_alt=>'View Details'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10034:&SESSION.::&DEBUG.:RP,10034::'
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18095141879409287)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18079484874409274)
,p_button_name=>'VIEW_ACTIVITY_BY_USER'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>wwv_flow_api.id(17740742065408952)
,p_button_image_alt=>'View Details'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10031:&SESSION.::&DEBUG.:RP,10031::'
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18095505528409288)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18079602837409274)
,p_button_name=>'VIEW_RECENT_ERRORS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>wwv_flow_api.id(17740742065408952)
,p_button_image_alt=>'View Details'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10032:&SESSION.::&DEBUG.:RP,10032::'
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18079960383409274)
,p_name=>'P10030_TIMEFRAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18079882605409274)
,p_item_default=>'900'
,p_prompt=>'Timeframe'
,p_source=>'900'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TIMEFRAME (4 WEEKS)'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'      val as seconds',
' from table( apex_util.get_timeframe_lov_data )',
'order by insert_order'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18080006918409274)
,p_name=>'Change Filters'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10030_TIMEFRAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18097171397409289)
,p_event_id=>wwv_flow_api.id(18080006918409274)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18079082863409274)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18097668002409289)
,p_event_id=>wwv_flow_api.id(18080006918409274)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18079484874409274)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18098199778409290)
,p_event_id=>wwv_flow_api.id(18080006918409274)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18079238319409274)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18098690614409290)
,p_event_id=>wwv_flow_api.id(18080006918409274)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18079602837409274)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18099110129409290)
,p_event_id=>wwv_flow_api.id(18080006918409274)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18079789468409274)
);
end;
/
prompt --application/pages/page_10031
begin
wwv_flow_api.create_page(
 p_id=>10031
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Top Users'
,p_alias=>'TOP-USERS'
,p_page_mode=>'MODAL'
,p_step_title=>'Top Users'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* Remove padding around dialog page */',
'.hour-graph { display: table; width: 100%; }',
'span.hour { display: table-cell; padding: 0; font-size: 11px; text-align: center; background-color: #a6ffa6; min-width: 32px; }',
'span.hour.is-over1k { background-color: #7bdc7b; }',
'span.hour.is-null { background-color: #E0E0E0; }',
'span.hour-label { opacity: 0.5; }',
'span.hour-value { display: block; }'))
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765587082408970)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Use this report and chart to see the users with the most page views for the specified timeframe.</p>',
'<p>Select the reporting timeframe (Default = 1 day) and choose between the report and chart icons at the top of the page.</p>',
'<p>For the interactive report, use the search field, or select the <strong>User</strong> column heading, to select a specific user. You can perform numerous functions by clicking the <strong>Actions</strong> button, such as columns displayed / hidden'
||', rows per page, filter, and so forth. Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18122122826409323)
,p_plug_name=>'Top Users'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select the_user,',
'    ''<div class="hour-graph">''||',
'        ''<span class="hour''|| case when h00 = 0 then '' is-null'' when h00 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 0</span> <span class="hour-value">''|| ',
'        case when h00 > 999 then to_char((h00/1000),''99999999D0'') ||''k'' else to_char(h00) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h01 = 0 then '' is-null'' when h01 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 1</span> <span class="hour-value">''|| ',
'        case when h01 > 999 then to_char((h01/1000),''99999999D0'') ||''k'' else to_char(h01) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h02 = 0 then '' is-null'' when h02 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 2</span> <span class="hour-value">''|| ',
'        case when h02 > 999 then to_char((h02/1000),''99999999D0'') ||''k'' else to_char(h02) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h03 = 0 then '' is-null'' when h03 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 3</span> <span class="hour-value">''|| ',
'        case when h03 > 999 then to_char((h03/1000),''99999999D0'') ||''k'' else to_char(h03) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h04 = 0 then '' is-null'' when h04 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 4</span> <span class="hour-value">''|| ',
'        case when h04 > 999 then to_char((h04/1000),''99999999D0'') ||''k'' else to_char(h04) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h05 = 0 then '' is-null'' when h05 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 5</span> <span class="hour-value">''|| ',
'        case when h05 > 999 then to_char((h05/1000),''99999999D0'') ||''k'' else to_char(h05) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h06 = 0 then '' is-null'' when h06 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 6</span> <span class="hour-value">''|| ',
'        case when h06 > 999 then to_char((h06/1000),''99999999D0'') ||''k'' else to_char(h06) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h07 = 0 then '' is-null'' when h07 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 7</span> <span class="hour-value">''|| ',
'        case when h07 > 999 then to_char((h07/1000),''99999999D0'') ||''k'' else to_char(h07) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h08 = 0 then '' is-null'' when h08 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 8</span> <span class="hour-value">''|| ',
'        case when h08 > 999 then to_char((h08/1000),''99999999D0'') ||''k'' else to_char(h08) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h09 = 0 then '' is-null'' when h09 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 9</span> <span class="hour-value">''|| ',
'        case when h09 > 999 then to_char((h09/1000),''99999999D0'') ||''k'' else to_char(h09) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h10 = 0 then '' is-null'' when h10 > 999 then '' is-over1k'' end ||''"><span class="hour-label">10</span> <span class="hour-value">''|| ',
'        case when h10 > 999 then to_char((h10/1000),''99999999D0'') ||''k'' else to_char(h10) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h11 = 0 then '' is-null'' when h11 > 999 then '' is-over1k'' end ||''"><span class="hour-label">11</span> <span class="hour-value">''|| ',
'        case when h11 > 999 then to_char((h11/1000),''99999999D0'') ||''k'' else to_char(h11) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h12 = 0 then '' is-null'' when h12 > 999 then '' is-over1k'' end ||''"><span class="hour-label">12</span> <span class="hour-value">''|| ',
'        case when h12 > 999 then to_char((h12/1000),''99999999D0'') ||''k'' else to_char(h12) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h13 = 0 then '' is-null'' when h13 > 999 then '' is-over1k'' end ||''"><span class="hour-label">13</span> <span class="hour-value">''|| ',
'        case when h13 > 999 then to_char((h13/1000),''99999999D0'') ||''k'' else to_char(h13) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h14 = 0 then '' is-null'' when h14 > 999 then '' is-over1k'' end ||''"><span class="hour-label">14</span> <span class="hour-value">''|| ',
'        case when h14 > 999 then to_char((h14/1000),''99999999D0'') ||''k'' else to_char(h14) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h15 = 0 then '' is-null'' when h15 > 999 then '' is-over1k'' end ||''"><span class="hour-label">15</span> <span class="hour-value">''|| ',
'        case when h15 > 999 then to_char((h15/1000),''99999999D0'') ||''k'' else to_char(h15) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h16 = 0 then '' is-null'' when h16 > 999 then '' is-over1k'' end ||''"><span class="hour-label">16</span> <span class="hour-value">''|| ',
'        case when h16 > 999 then to_char((h16/1000),''99999999D0'') ||''k'' else to_char(h16) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h17 = 0 then '' is-null'' when h17 > 999 then '' is-over1k'' end ||''"><span class="hour-label">17</span> <span class="hour-value">''|| ',
'        case when h17 > 999 then to_char((h17/1000),''99999999D0'') ||''k'' else to_char(h17) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h18 = 0 then '' is-null'' when h18 > 999 then '' is-over1k'' end ||''"><span class="hour-label">18</span> <span class="hour-value">''|| ',
'        case when h18 > 999 then to_char((h18/1000),''99999999D0'') ||''k'' else to_char(h18) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h19 = 0 then '' is-null'' when h19 > 999 then '' is-over1k'' end ||''"><span class="hour-label">19</span> <span class="hour-value">''|| ',
'        case when h19 > 999 then to_char((h19/1000),''99999999D0'') ||''k'' else to_char(h19) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h20 = 0 then '' is-null'' when h20 > 999 then '' is-over1k'' end ||''"><span class="hour-label">20</span> <span class="hour-value">''|| ',
'        case when h20 > 999 then to_char((h20/1000),''99999999D0'') ||''k'' else to_char(h20) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h21 = 0 then '' is-null'' when h21 > 999 then '' is-over1k'' end ||''"><span class="hour-label">21</span> <span class="hour-value">''|| ',
'        case when h21 > 999 then to_char((h21/1000),''99999999D0'') ||''k'' else to_char(h21) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h22 = 0 then '' is-null'' when h22 > 999 then '' is-over1k'' end ||''"><span class="hour-label">22</span> <span class="hour-value">''|| ',
'        case when h22 > 999 then to_char((h22/1000),''99999999D0'') ||''k'' else to_char(h22) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h23 = 0 then '' is-null'' when h23 > 999 then '' is-over1k'' end ||''"><span class="hour-label">23</span> <span class="hour-value">''|| ',
'        case when h23 > 999 then to_char((h23/1000),''99999999D0'') ||''k'' else to_char(h23) end ||''</span></span>''||',
'        ''</div>'' hours,',
'        page_events,',
'    median_elapsed,',
'    rows_fetched,',
'    ir_searches,',
'    errors,',
'    most_recent',
'    from (  ',
'    select userid_lc                    as the_user,',
'        count(*)                        as page_events,',
'        median(elap)                    as median_elapsed,',
'        sum(num_rows)                   as rows_fetched,',
'        sum(decode(ir_search,null,0,1)) as ir_searches,',
'        sum(decode(sqlerrm,null,0,1))   as errors,',
'        max(time_stamp)                 as most_recent,',
'        sum(decode(to_char(time_stamp,''HH24''),0,1,0)) h00,',
'        sum(decode(to_char(time_stamp,''HH24''),1,1,0)) h01,',
'        sum(decode(to_char(time_stamp,''HH24''),2,1,0)) h02,',
'        sum(decode(to_char(time_stamp,''HH24''),3,1,0)) h03,',
'        sum(decode(to_char(time_stamp,''HH24''),4,1,0)) h04,',
'        sum(decode(to_char(time_stamp,''HH24''),5,1,0)) h05,',
'        sum(decode(to_char(time_stamp,''HH24''),6,1,0)) h06,',
'        sum(decode(to_char(time_stamp,''HH24''),7,1,0)) h07,',
'        sum(decode(to_char(time_stamp,''HH24''),8,1,0)) h08,',
'        sum(decode(to_char(time_stamp,''HH24''),9,1,0)) h09,',
'        sum(decode(to_char(time_stamp,''HH24''),10,1,0)) h10,',
'        sum(decode(to_char(time_stamp,''HH24''),11,1,0)) h11,',
'        sum(decode(to_char(time_stamp,''HH24''),12,1,0)) h12,',
'        sum(decode(to_char(time_stamp,''HH24''),13,1,0)) h13,',
'        sum(decode(to_char(time_stamp,''HH24''),14,1,0)) h14,',
'        sum(decode(to_char(time_stamp,''HH24''),15,1,0)) h15,',
'        sum(decode(to_char(time_stamp,''HH24''),16,1,0)) h16,',
'        sum(decode(to_char(time_stamp,''HH24''),17,1,0)) h17,',
'        sum(decode(to_char(time_stamp,''HH24''),18,1,0)) h18,',
'        sum(decode(to_char(time_stamp,''HH24''),19,1,0)) h19,',
'        sum(decode(to_char(time_stamp,''HH24''),20,1,0)) h20,',
'        sum(decode(to_char(time_stamp,''HH24''),21,1,0)) h21,',
'        sum(decode(to_char(time_stamp,''HH24''),22,1,0)) h22,',
'        sum(decode(to_char(time_stamp,''HH24''),23,1,0)) h23',
'    from apex_activity_log l',
'    where flow_id = :APP_ID',
'        and time_stamp >= sysdate - ( 1/24/60/60 * :P10031_TIMEFRAME )',
'        and userid is not null',
'    group by userid_lc) x'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10031_TIMEFRAME'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P10031_VIEW_AS'
,p_plug_display_when_cond2=>'REPORT'
,p_prn_page_header=>'Top Users'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18123590452409324)
,p_name=>'Top Users'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>18123590452409324
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18123692133409326)
,p_db_column_name=>'THE_USER'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'User'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18124086773409328)
,p_db_column_name=>'HOURS'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Activity by Hour'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18124480241409331)
,p_db_column_name=>'PAGE_EVENTS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Page Events'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18124818676409333)
,p_db_column_name=>'MEDIAN_ELAPSED'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Median Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D0000'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18125214584409336)
,p_db_column_name=>'ROWS_FETCHED'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Rows Fetched'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18125628736409340)
,p_db_column_name=>'IR_SEARCHES'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'IR Searches'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18126012484409342)
,p_db_column_name=>'ERRORS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Errors'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18126444205409345)
,p_db_column_name=>'MOST_RECENT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Most_Recent'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18127168087409347)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'181272'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'THE_USER:HOURS:PAGE_EVENTS'
,p_sort_column_1=>'PAGE_EVENTS'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'MOST_RECENT'
,p_sort_direction_2=>'DESC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18122221366409323)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noUI:t-Form--large'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18122485278409323)
,p_plug_name=>'Top Users Chart'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--hiddenOverflow'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P10031_VIEW_AS'
,p_plug_display_when_cond2=>'CHART'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(18122553724409323)
,p_region_id=>wwv_flow_api.id(18122485278409323)
,p_chart_type=>'donut'
,p_height=>'600'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>.02
,p_pie_selection_effect=>'highlight'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function( options ){ ',
'',
'    this.pieSliceLabel = function(dataContext) {',
'        var series_name,',
'            percent = Math.round(dataContext.value/dataContext.totalValue*100);',
'        ',
'        if ( dataContext.seriesData ) {',
'            series_name = dataContext.seriesData.name;',
'        } else {',
'            series_name = ''Other'';',
'        }',
'        return series_name + " " + percent + "% ( " + dataContext.value + " )";',
'    }',
'    ',
'    // Set chart initialization options ',
'    options.dataLabel = pieSliceLabel; ',
'    return options; ',
'}'))
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(18130742710409352)
,p_chart_id=>wwv_flow_api.id(18122553724409323)
,p_seq=>10
,p_name=>'Top Users'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select userid_lc as userid,',
'    count(*) as page_views',
'from apex_activity_log',
'where flow_id = :app_id',
'    and time_stamp >= sysdate - ( 1/24/60/60 * :P10031_TIMEFRAME )',
'    and userid is not null',
'group by userid_lc',
'order by 2'))
,p_ajax_items_to_submit=>'P10031_TIMEFRAME'
,p_items_value_column_name=>'PAGE_VIEWS'
,p_items_label_column_name=>'USERID'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'LABEL'
,p_threshold_display=>'onIndicator'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18128022115409349)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18122122826409323)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18122608443409323)
,p_name=>'P10031_VIEW_AS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(18122221366409323)
,p_item_default=>'REPORT'
,p_prompt=>'View As'
,p_source=>'REPORT'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'VIEW_AS_REPORT_CHART'
,p_lov=>'.'||wwv_flow_api.id(18131268775409352)||'.'
,p_field_template=>wwv_flow_api.id(17740098066408952)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'2'
,p_attribute_02=>'SUBMIT'
,p_attribute_03=>'Y'
,p_attribute_04=>'VERTICAL'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18122820332409323)
,p_name=>'P10031_TIMEFRAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18122221366409323)
,p_item_default=>'900'
,p_prompt=>'Timeframe'
,p_source=>'900'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TIMEFRAME (4 WEEKS)'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'      val as seconds',
' from table( apex_util.get_timeframe_lov_data )',
'order by insert_order'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(17740152874408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18122347126409323)
,p_name=>'Refresh Report'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10031_TIMEFRAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18129347522409350)
,p_event_id=>wwv_flow_api.id(18122347126409323)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18122122826409323)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18132763085409353)
,p_event_id=>wwv_flow_api.id(18122347126409323)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18122122826409323)
);
end;
/
prompt --application/pages/page_10032
begin
wwv_flow_api.create_page(
 p_id=>10032
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Application Error Log'
,p_alias=>'APPLICATION-ERROR-LOG'
,p_page_mode=>'MODAL'
,p_step_title=>'Application Error Log'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765587082408970)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page provides an interactive report of all unexpected errors logged by this application.</p>',
'<p>Click on the column headings to sort and filter data, or click on the <strong>Actions</strong> button to customize column display and many additional advanced features. Click the <strong>Reset</strong> button to reset the interactive report back t'
||'o the default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18117253227409319)
,p_plug_name=>'Application Error Log'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'    step_id,',
'    userid,',
'    time_stamp err_time,',
'    sqlerrm,',
'    sqlerrm_component_type,',
'    sqlerrm_component_name',
'from apex_activity_log',
'where flow_id = :app_id',
'and sqlerrm is not null'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Application Error Log'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18118178994409319)
,p_name=>'Application Error Log'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>18118178994409319
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18118201173409320)
,p_db_column_name=>'STEP_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Page'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18118676493409320)
,p_db_column_name=>'USERID'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'User'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18119017031409321)
,p_db_column_name=>'ERR_TIME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Occurrence'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'since'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18119441431409321)
,p_db_column_name=>'SQLERRM'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Message'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18119813473409321)
,p_db_column_name=>'SQLERRM_COMPONENT_TYPE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Context'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18120232301409322)
,p_db_column_name=>'SQLERRM_COMPONENT_NAME'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Component Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18120914445409322)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'181210'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'STEP_ID:USERID:ERR_TIME:SQLERRM:SQLERRM_COMPONENT_TYPE:SQLERRM_COMPONENT_NAME:'
,p_sort_column_1=>'ERROR_TIME'
,p_sort_direction_1=>'DESC'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18121872221409323)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18117253227409319)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
end;
/
prompt --application/pages/page_10033
begin
wwv_flow_api.create_page(
 p_id=>10033
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Page Performance'
,p_alias=>'PAGE-PERFORMANCE'
,p_page_mode=>'MODAL'
,p_step_title=>'Page Performance'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765587082408970)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page provides an interactive report of the page performance and popularity. The report is ordered by <strong>Weighted Performance</strong> which is calculated by multiplying the Median Elapsed time and number of Page Views.</p>',
'<p>Select the reporting timeframe (Default = 1 day) at the top of the page as necessary.<br>',
'Click on the column headings to sort and filter data, or click on the <strong>Actions</strong> button to customize column display and many additional advanced features. Click the <strong>Reset</strong> button to reset the interactive report back to t'
||'he default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18107634932409299)
,p_plug_name=>'Page Performance'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select step_id page,',
'    (   select page_name',
'        from apex_application_pages p',
'        where p.page_id = l.step_id',
'            and p.application_id = :app_id ) page_name,',
'    median(elap)                   median_elapsed,',
'    count(*) * median(elap)        weighted_performance,',
'    sum(decode(sqlerrm,null,0,1))  errors,',
'    count(distinct userid)         distinct_users,',
'    count(distinct session_id)     application_sessions,',
'    count(*)                       page_views,',
'    max(elap)                      max_elapsed,',
'    sum(nvl(num_rows,0))           total_rows,',
'    sum(decode(page_mode,''P'',1,0)) partial_page_views,',
'    sum(decode(page_mode,''D'',1,0)) full_page_views,',
'    min(elap)                      min_elapsed,',
'    avg(elap)                      avg_elapsed',
'from apex_activity_log l',
'where flow_id = :app_id',
'    and time_stamp >= sysdate - ( 1/24/60/60 * :P10033_TIMEFRAME )',
'    and userid is not null',
'group by step_id'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10033_TIMEFRAME'
,p_prn_page_header=>'Page Performance'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18108566588409300)
,p_name=>'Page Performance'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>18108566588409300
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18108655940409300)
,p_db_column_name=>'PAGE'
,p_display_order=>15
,p_column_identifier=>'A'
,p_column_label=>'Page'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18109040758409309)
,p_db_column_name=>'PAGE_NAME'
,p_display_order=>25
,p_column_identifier=>'B'
,p_column_label=>'Page Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18109468945409310)
,p_db_column_name=>'MEDIAN_ELAPSED'
,p_display_order=>35
,p_column_identifier=>'C'
,p_column_label=>'Median Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D9999'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18109838480409310)
,p_db_column_name=>'WEIGHTED_PERFORMANCE'
,p_display_order=>45
,p_column_identifier=>'D'
,p_column_label=>'Weighted Performance'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D99'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18110256746409311)
,p_db_column_name=>'ERRORS'
,p_display_order=>55
,p_column_identifier=>'E'
,p_column_label=>'Action Processed.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18110623654409311)
,p_db_column_name=>'DISTINCT_USERS'
,p_display_order=>65
,p_column_identifier=>'F'
,p_column_label=>'Distinct Users'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18111029677409312)
,p_db_column_name=>'APPLICATION_SESSIONS'
,p_display_order=>75
,p_column_identifier=>'G'
,p_column_label=>'Application Sessions'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18111419228409312)
,p_db_column_name=>'PAGE_VIEWS'
,p_display_order=>85
,p_column_identifier=>'H'
,p_column_label=>'Page Views'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18111853971409313)
,p_db_column_name=>'MAX_ELAPSED'
,p_display_order=>95
,p_column_identifier=>'I'
,p_column_label=>'Max Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D9999'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18112289080409314)
,p_db_column_name=>'TOTAL_ROWS'
,p_display_order=>105
,p_column_identifier=>'J'
,p_column_label=>'Total Rows'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18112653470409314)
,p_db_column_name=>'PARTIAL_PAGE_VIEWS'
,p_display_order=>115
,p_column_identifier=>'K'
,p_column_label=>'Partial Page Views'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18113059491409315)
,p_db_column_name=>'FULL_PAGE_VIEWS'
,p_display_order=>125
,p_column_identifier=>'L'
,p_column_label=>'Full Page Views'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18113415576409315)
,p_db_column_name=>'MIN_ELAPSED'
,p_display_order=>135
,p_column_identifier=>'M'
,p_column_label=>'Min Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D9999'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18113862412409316)
,p_db_column_name=>'AVG_ELAPSED'
,p_display_order=>145
,p_column_identifier=>'N'
,p_column_label=>'Avg Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D9999'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18114538970409317)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'181146'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PAGE:PAGE_NAME:MEDIAN_ELAPSED:WEIGHTED_PERFORMANCE:ERRORS:DISTINCT_USERS:APPLICATION_SESSIONS:PAGE_VIEWS'
,p_sort_column_1=>'WEIGHTED_PERFORMANCE'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'PAGE_VIEWS'
,p_sort_direction_2=>'DESC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18107780848409299)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noUI:t-Form--large'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18115493773409317)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18107634932409299)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18107544346409299)
,p_name=>'P10033_TIMEFRAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18107780848409299)
,p_item_default=>'900'
,p_prompt=>'Timeframe'
,p_source=>'900'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TIMEFRAME (4 WEEKS)'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'      val as seconds',
' from table( apex_util.get_timeframe_lov_data )',
'order by insert_order'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(17740152874408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18107896915409299)
,p_name=>'Refresh Report'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10033_TIMEFRAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18116790307409319)
,p_event_id=>wwv_flow_api.id(18107896915409299)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18107634932409299)
);
end;
/
prompt --application/pages/page_10034
begin
wwv_flow_api.create_page(
 p_id=>10034
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Page Views'
,p_alias=>'PAGE-VIEWS'
,p_page_mode=>'MODAL'
,p_step_title=>'Page Views'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765587082408970)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page provides an interactive report of the most recent page views.</p>',
'<p>Select the reporting timeframe (Default = 1 day) at the top of the page as necessary.<br>',
'Click on the column headings to sort and filter data, or click on the <strong>Actions</strong> button to customize column display and many additional advanced features. Click the <strong>Reset</strong> button to reset the interactive report back to t'
||'he default settings.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18099605005409291)
,p_plug_name=>'Page Views'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    step_id||''. ''||(select page_name',
'                    from apex_application_pages p',
'                    where p.page_id = l.step_id',
'                        and p.application_id = :APP_ID) page_name,',
'    userid_lc     user_id,',
'    time_stamp    timestamp,',
'    elap          elapsed,',
'    step_id       page,',
'    decode(page_mode,''P'',''Partial'',''D'',''Full'',page_mode) page_mode,',
'    component_name,',
'    num_rows,',
'    ir_search,',
'    sqlerrm  error',
'from apex_activity_log l',
'where flow_id = :app_id',
'    and time_stamp >= sysdate - ( 1/24/60/60 * :P10034_TIMEFRAME )',
'    and userid is not null',
'    and step_id is not null',
'order by time_stamp desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10034_TIMEFRAME'
,p_prn_page_header=>'Page Views'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18100596164409291)
,p_name=>'Page Views'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>18100596164409291
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18100648869409292)
,p_db_column_name=>'PAGE_NAME'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Page Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18101032818409292)
,p_db_column_name=>'USER_ID'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'User'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18101475357409293)
,p_db_column_name=>'TIMESTAMP'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Timestamp'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'since'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18101896302409293)
,p_db_column_name=>'ELAPSED'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D0000'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18102219184409294)
,p_db_column_name=>'PAGE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Page'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18102617613409294)
,p_db_column_name=>'PAGE_MODE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Mode'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18103071571409295)
,p_db_column_name=>'COMPONENT_NAME'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Component Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18103458158409295)
,p_db_column_name=>'NUM_ROWS'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Num Rows'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18103848472409296)
,p_db_column_name=>'IR_SEARCH'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'IR Search'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G999G990'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18104286939409296)
,p_db_column_name=>'ERROR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Error'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18104921585409297)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'181050'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PAGE_NAME:USER_ID:TIMESTAMP:ELAPSED:PAGE_MODE'
,p_sort_column_1=>'TIMESTAMP'
,p_sort_direction_1=>'DESC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18099753877409291)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noUI:t-Form--large'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18105891774409298)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18099605005409291)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18099592763409291)
,p_name=>'P10034_TIMEFRAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18099753877409291)
,p_item_default=>'900'
,p_prompt=>'Timeframe'
,p_source=>'900'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TIMEFRAME (4 WEEKS)'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'      val as seconds',
' from table( apex_util.get_timeframe_lov_data )',
'order by insert_order'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(17740152874408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18099870297409291)
,p_name=>'Refresh Report'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10034_TIMEFRAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18107130618409299)
,p_event_id=>wwv_flow_api.id(18099870297409291)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18099605005409291)
);
end;
/
prompt --application/pages/page_10040
begin
wwv_flow_api.create_page(
 p_id=>10040
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Configure Access Control'
,p_alias=>'CONFIGURE-ACCESS-CONTROL'
,p_page_mode=>'MODAL'
,p_step_title=>'Configure Access Control'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765471426408970)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Select the appropriate choice for any authenticated users.<br> ',
'Selecting <strong>No</strong> makes the application more secure as only specified users can access the application. ',
'However, if your application has a large user community then maintaining users may be onerous, and you may prefer to choose <strong>Yes</strong> and only enter application Administrators, and possibly Contributors.<br>',
'If you select <strong>Yes</strong> then you must also select how users not included in the users list are treated.</p>',
'<p>Select between requiring email addresses and any alphanumeric value for Usernames.<br>',
'Generally, you should set this setting to <strong>E-mail Address</strong> if your application uses (or will be configured to use) a centralized authentication scheme such as Oracle Access Manager, or SSO.</p>',
'<p><em><strong>Note:</strong> This application supports the following 3 access levels: Reader, Contributor, and Administrator.',
'<ul>',
'  <li><strong>Readers</strong> have read-only access to all information and can also view reports.</li>',
'  <li><strong>Contributors</strong> can create, edit and delete information and view reports.</li>',
'  <li><strong>Administrators</strong>, in addition to Contributors capability, can also perform configuration of the application by accessing the Administration section of the application.</li>',
'</ul>',
'</em></p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18133197289409354)
,p_plug_name=>'Access Control Configuration'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18133247406409354)
,p_plug_name=>'Dialog Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18134654638409355)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18133247406409354)
,p_button_name=>'APPLY_CHANGES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18133384621409354)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18133247406409354)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(18135382579409355)
,p_branch_name=>'Go To Admin Page'
,p_branch_action=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18135675173409356)
,p_name=>'P10040_ALLOW_OTHER_USERS'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18133197289409354)
,p_prompt=>'Any authenticated user may access this application'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if apex_app_setting.get_value( p_name => ''ACCESS_CONTROL_SCOPE'' ) = ''ACL_ONLY'' then',
'    return ''N'';',
'else',
'    return ''Y'';',
'end if;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_YES_NO'
,p_cSize=>64
,p_cMaxlength=>4000
,p_cHeight=>4
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(17740152874408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_inline_help_text=>'Choose <strong>No</strong> if all users are defined in the access control list. Choose <strong>Yes</strong> if authenticated users not in the access control list may also use this application.'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18133427341409354)
,p_name=>'Cancel Modal'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18133384621409354)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18136356098409356)
,p_event_id=>wwv_flow_api.id(18133427341409354)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18136891911409356)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ACCESS CONTROL ENABLED'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P10040_ALLOW_OTHER_USERS = ''Y'' then',
'        apex_app_setting.set_value (',
'            p_name  => ''ACCESS_CONTROL_SCOPE'',',
'            p_value => ''ALL_USERS'');',
'    else',
'        apex_app_setting.set_value (',
'            p_name  => ''ACCESS_CONTROL_SCOPE'',',
'            p_value => ''ACL_ONLY'');',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Access Control settings saved.'
);
end;
/
prompt --application/pages/page_10041
begin
wwv_flow_api.create_page(
 p_id=>10041
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Manage User Access'
,p_alias=>'MANAGE-USER-ACCESS'
,p_page_mode=>'MODAL'
,p_step_title=>'Manage User Access'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765471426408970)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page shows a report of the application users and the access level granted.</p>',
'<p>Click on the column headings to sort and filter data, or click on the <strong>Actions</strong> button to customize column display and many additional advanced features.<br>',
'Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>',
'<p>Click the edit icon (yellow pencil) to edit the user details and access level, or to delete the user.</p>',
'<p>Click <strong>Add User</strong>, at the top of the report, to add a new user and their access level.</p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18137229189409357)
,p_plug_name=>'Manage User Access'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id,',
'   user_name_lc USERNAME,',
'   role_names ACCESS_ROLE',
'from APEX_APPL_ACL_USERS',
'where APPLICATION_ID = :APP_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Manage User Access'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18138349401409357)
,p_name=>'Manage User Access'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:10042:&APP_SESSION.::::P10042_ID:#ID#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>18138349401409357
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18138400461409357)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18138820443409358)
,p_db_column_name=>'USERNAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Username'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18139224718409358)
,p_db_column_name=>'ACCESS_ROLE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Roles'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18139987987409359)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'181400'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'USERNAME:ACCESS_ROLE'
,p_sort_column_2=>'USERNAME'
,p_sort_direction_2=>'ASC'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18140898846409360)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18137229189409357)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18141203038409360)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(18137229189409357)
,p_button_name=>'ADD_MULTIPLE_USERS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Add Multiple Users'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:10043:&SESSION.::&DEBUG.:10043::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18141653857409360)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(18137229189409357)
,p_button_name=>'ADD_USER'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add User'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:10042:&SESSION.::&DEBUG.:10042'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18137371379409357)
,p_name=>'Refresh on Dialog Close'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(18137229189409357)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18142255567409361)
,p_event_id=>wwv_flow_api.id(18137371379409357)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18137229189409357)
);
end;
/
prompt --application/pages/page_10042
begin
wwv_flow_api.create_page(
 p_id=>10042
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Manage User Access'
,p_alias=>'USER_ACCESS'
,p_page_mode=>'MODAL'
,p_step_title=>'Manage User Access'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765471426408970)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Use this form to enter users, their email address and set their access level. ',
'The settings defined under <em>Configure Access Control</em> will determine whether the username must be their email address or can be any alphanumeric entry.</p>',
'<p>This application supports the following 3 access levels: Reader, Contributor, and Administrator.</p>',
'<ul>',
'  <li><strong>Readers</strong> have read-only access to all information and can also view reports.</li>',
'  <li><strong>Contributors</strong> can create, edit and delete information and view reports.</li>',
'  <li><strong>Administrators</strong>, in addition to Contributors capability, can also perform configuration of the application by accessing the Administration section of the application.</li>',
'</ul>',
'<p>When editing an existing user you can lock their account which will prevent them from accessing the application.</p>',
'<p><em><strong>Note:</strong>   If using Oracle Application Express accounts then users entered here must also be defined as end users by a Workspace Administrator, who can also set their password.</em></p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18142716865409361)
,p_plug_name=>'Form Items Region'
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18142891239409361)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18142959418409361)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18142891239409361)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10042_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18143081124409361)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18142891239409361)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add User'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P10042_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18143124295409361)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18142891239409361)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18143287965409361)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(18142891239409361)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_condition=>'P10042_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18143461425409361)
,p_name=>'P10042_USERNAME'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(18142716865409361)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Username'
,p_source=>'USER_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>255
,p_read_only_when=>'P10042_ID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18145633331409363)
,p_name=>'P10042_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18142716865409361)
,p_use_cache_before_default=>'NO'
,p_source=>'ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18146022073409363)
,p_name=>'P10042_APPLICATION_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18142716865409361)
,p_use_cache_before_default=>'NO'
,p_item_default=>'&APP_ID.'
,p_source=>'APPLICATION_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18146757759409364)
,p_name=>'P10042_ROLE_ID'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(18142716865409361)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Role'
,p_source=>'ROLE_IDS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'ACCESS_ROLES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select role_name d, role_id r',
'from APEX_APPL_ACL_ROLES where application_id = :APP_ID ',
'order by 1'))
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>When Access Control is enabled, Administrators have the ability to restrict access to certain application features for authenticated users. This application supports the following 3 roles: Reader, Contributor, and Administrator.<p>',
'<ul>',
'  <li><strong>Readers</strong> have read-only access to all information and can also view reports.</li>',
'  <li><strong>Contributors</strong> can create,edit and delete information and view reports.</li>',
'  <li><strong>Administrators</strong>,in addition to Contributors capability,can also perform configuration of the application.</li>',
'</ul>'))
,p_attribute_01=>'1'
,p_attribute_02=>'VERTICAL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18143350837409361)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18143124295409361)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18148239108409365)
,p_event_id=>wwv_flow_api.id(18143350837409361)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18148714178409366)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row'
,p_attribute_02=>'APEX_APPL_ACL_USERS'
,p_attribute_03=>'P10042_ID'
,p_attribute_04=>'ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18149115204409366)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Save'
,p_attribute_02=>'APEX_APPL_ACL_USERS'
,p_attribute_03=>'P10042_ID'
,p_attribute_04=>'ID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18149523241409366)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Reset Page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(18143287965409361)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18149977639409366)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_10043
begin
wwv_flow_api.create_page(
 p_id=>10043
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Add Multiple Users - Step 1'
,p_alias=>'ADD-MULTIPLE-USERS-STEP-1'
,p_page_mode=>'MODAL'
,p_step_title=>'Add Multiple Users'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.helpText {',
'padding: 8px;',
'color: #707070;',
'}'))
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765471426408970)
,p_dialog_chained=>'N'
,p_deep_linking=>'N'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18150364131409367)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18150493153409367)
,p_plug_name=>'Wizard Container'
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayCurrentLabelOnly'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18150578997409367)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18150364131409367)
,p_button_name=>'NEXT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18150618830409367)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18150364131409367)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(18153272894409368)
,p_branch_name=>'Go To Next Step'
,p_branch_action=>'f?p=&APP_ID.:10044:&SESSION.::&DEBUG.:RP,10044::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(18150578997409367)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18153650561409368)
,p_name=>'P10043_ROLE'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(18150493153409367)
,p_item_default=>'2'
,p_prompt=>'Role'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'ACCESS_ROLES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select role_name d, role_id r',
'from APEX_APPL_ACL_ROLES where application_id = :APP_ID ',
'order by 1'))
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'3'
,p_attribute_02=>'VERTICAL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18154033831409369)
,p_name=>'P10043_PRELIM_USERS'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18150493153409367)
,p_prompt=>'Usernames'
,p_placeholder=>'Enter usernames here'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_inline_help_text=>'Enter usernames separated by commas, semicolons, or whitespace. Existing or duplicate usernames will automatically be ignored.'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18154420985409369)
,p_name=>'P10043_USERNAME_FORMAT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(18150493153409367)
,p_prompt=>'Username Format'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'EMAIL_USERNAME_FORMAT'
,p_lov=>'.'||wwv_flow_api.id(18154566139409369)||'.'
,p_field_template=>wwv_flow_api.id(17740632513408952)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'VERTICAL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18150761902409367)
,p_name=>'Cancel Modal'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18150618830409367)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18155857164409370)
,p_event_id=>wwv_flow_api.id(18150761902409367)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18156327172409370)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Collections'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_line      varchar2(32767);',
'    l_emails    apex_t_varchar2;',
'    l_username  varchar2(4000);',
'    l_at        number;',
'    l_dot       number;',
'    l_valid     boolean := true;',
'    l_domain    varchar2(4000);',
'begin',
'    ---------------------',
'    -- create collections',
'    --',
'    apex_collection.CREATE_OR_TRUNCATE_COLLECTION (''ACL_BULK_USER_INVALID'');',
'    apex_collection.CREATE_OR_TRUNCATE_COLLECTION (''ACL_BULK_USER_VALID'');',
'',
'    --------------------------------------------',
'    -- replace delimiting characters with commas',
'    --',
'    l_line := :P10043_PRELIM_USERS;',
'    l_line := replace(l_line,chr(10),'' '');',
'    l_line := replace(l_line,chr(13),'' '');',
'    l_line := replace(l_line,chr(9),'' '');',
'    l_line := replace(l_line,''<'','' '');',
'    l_line := replace(l_line,''>'','' '');',
'    l_line := replace(l_line,'';'','' '');',
'    l_line := replace(l_line,'':'','' '');',
'    l_line := replace(l_line,''('','' '');',
'    l_line := replace(l_line,'')'','' '');',
'    l_line := replace(l_line,'' '','','');',
'',
'    -----------------------------------------',
'    -- get one comma separated line of emails',
'    --',
'    for j in 1..1000 loop',
'        if instr(l_line,'',,'') > 0 then',
'           l_line := replace(l_line,'',,'','','');',
'        else',
'           exit;',
'        end if;',
'    end loop;',
'',
'    -------------------------',
'    -- get an array of emails',
'    --',
'    l_emails := apex_string.split(l_line,'','');',
'',
'    -----------------------------',
'    -- add emails to a collection',
'    --',
'    l_username := null;',
'    l_domain := null;',
'    l_at := 0;',
'    l_dot := 0;',
'    for j in 1..l_emails.count loop',
'        l_valid := true;',
'        l_username := upper(trim(l_emails(j)));',
'        l_username := trim(both ''.'' from l_username);',
'        l_username := replace(l_username,'' '',null);',
'        l_username := replace(l_username,chr(10),null);',
'        l_username := replace(l_username,chr(9),null);',
'        l_username := replace(l_username,chr(13),null);',
'        l_username := replace(l_username,chr(49824),null);',
'',
'        if l_username is not null then',
'            if NVL(:P10043_USERNAME_FORMAT,''x'') = ''EMAIL'' then',
'              -----------',
'              -- Validate',
'              --',
'              l_at := instr(nvl(l_username,''x''),''@'');',
'              l_domain := substr(l_username,l_at+1);',
'              l_dot := instr(l_domain,''.'');',
'              if l_at < 2 then',
'                  -- invalid email',
'                  apex_collection.add_member(',
'                      p_collection_name => ''ACL_BULK_USER_INVALID'',',
'                      p_c001            => l_username,',
'                      p_c002            => apex_lang.message(''APEX.FEATURE.ACL.BULK_USER.MISSING_AT_SIGN''));',
'                  commit;',
'                  l_valid := false;',
'              end if;',
'',
'              if l_dot = 0 and l_valid then',
'                  apex_collection.add_member(',
'                      p_collection_name => ''ACL_BULK_USER_INVALID'',',
'                      p_c001            => l_username,',
'                      p_c002            => apex_lang.message(''APEX.FEATURE.ACL.BULK_USER.MISSING_DOT''));',
'                  commit;',
'                  l_valid := false;',
'              end if;',
'            end if;',
'',
'            if l_valid and length(l_username) > 255 then',
'                apex_collection.add_member(',
'                    p_collection_name => ''ACL_BULK_USER_INVALID'',',
'                    p_c001            => l_username,',
'                    p_c002            => apex_lang.message(''APEX.FEATURE.ACL.BULK_USER.USERNAME_TOO_LONG''));',
'                commit;',
'                l_valid := false;',
'            end if;',
'',
'            if l_valid then',
'                for c1 in (select user_name username',
'                             from APEX_APPL_ACL_USERS',
'                            where user_name = l_username and application_id = :APP_ID)',
'                loop',
'                    apex_collection.add_member(',
'                        p_collection_name => ''ACL_BULK_USER_INVALID'',',
'                        p_c001            => l_username,',
'                        p_c002            => apex_lang.message(''APEX.FEATURE.ACL.BULK_USER.ALREADY_IN_ACL''));',
'                    commit;',
'                    l_valid := false;',
'                    exit;',
'                end loop;',
'            end if;',
'',
'            if l_valid then',
'                for c1 in (select c001',
'                             from apex_collections',
'                            where collection_name = ''ACL_BULK_USER_VALID''',
'                              and c001 = l_username)',
'                loop',
'                    apex_collection.add_member(',
'                        p_collection_name => ''ACL_BULK_USER_INVALID'',',
'                        p_c001            => l_username,',
'                        p_c002            => apex_lang.message(''APEX.FEATURE.ACL.BULK_USER.DUPLICATE_USER''));',
'                        commit;',
'                    l_valid := false;',
'                    exit;',
'                end loop;',
'            end if;',
'',
'            if l_valid then',
'                apex_collection.add_member(',
'                    p_collection_name => ''ACL_BULK_USER_VALID'',',
'                    p_c001            => l_username,',
'                    p_c002            => null,',
'                    p_c003            => :P10043_ROLE);',
'                    commit;',
'            end if;',
'',
'        end if;',
'        l_username := null;',
'    end loop;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(18150578997409367)
);
end;
/
prompt --application/pages/page_10044
begin
wwv_flow_api.create_page(
 p_id=>10044
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Add Multiple Users - Step 2'
,p_alias=>'ADD-MULTIPLE-USERS-STEP-2'
,p_page_mode=>'MODAL'
,p_step_title=>'Add Multiple Users'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.uReportList {',
'    margin: 0;',
'    list-style: none;',
'}',
'.uReportList li {',
'    margin: 0 0 4px 0;',
'}',
'.check_icon {',
'    display: inline-block;',
'    width: 16px;',
'    height: 16px;',
'    line-height: 16px;',
'    background: #69B86B;',
'    color: #FFF;',
'    text-align: center;',
'    border-radius: 12px;',
'    font-size: 15px;',
'    border: 1px solid green;',
'    text-shadow: 0 -1px 0 rgba(0,0,0,.15);',
'    vertical-align: top;',
'    margin-right: 4px;',
'}',
'.valid_user {',
'    display: inline-block;',
'    padding: 4px 8px 4px 4px;',
'    border: 1px solid #D0D0D0;',
'    border-radius: 3px;',
'    line-height: 20px;',
'    background-color: #F8F8F8;',
'    color: #404040;',
'}'))
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765471426408970)
,p_deep_linking=>'N'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054530'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18150841765409367)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18150911653409367)
,p_plug_name=>'Add Multiple Users - Step 2'
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayCurrentLabelOnly'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(18151369307409367)
,p_name=>'Exceptions'
,p_parent_plug_id=>wwv_flow_api.id(18150911653409367)
,p_template=>wwv_flow_api.id(17662386249408910)
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:is-collapsed:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlightOff'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c001 username, c002 reason',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_INVALID''',
'order by 1'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_INVALID'''))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(17708296566408934)
,p_query_num_rows=>10000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18158227521409373)
,p_query_column_id=>1
,p_column_alias=>'USERNAME'
,p_column_display_sequence=>1
,p_column_heading=>'Username'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(18158680735409373)
,p_query_column_id=>2
,p_column_alias=>'REASON'
,p_column_display_sequence=>2
,p_column_heading=>'Reason'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18151446283409367)
,p_plug_name=>'&P10044_VALID_COUNT. Users to Add'
,p_parent_plug_id=>wwv_flow_api.id(18150911653409367)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlightOff'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct lower(c001) username',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_VALID''',
'order by 1'))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_plug_query_num_rows=>10000
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_VALID'''))
,p_attribute_01=>'ADVANCED_FORMATTING'
,p_attribute_05=>'<span class="fa fa-check-circle u-success-text" aria-hidden="true"></span> <span style="line-height:36px;">&USERNAME.</span>'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18151516054409367)
,p_plug_name=>'Hidden Items'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18161745174409376)
,p_plug_name=>'Valid Users Exist - Page Info'
,p_region_template_options=>'#DEFAULT#:margin-bottom-sm'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sys.htp.prn(''<p>'');',
'sys.htp.prn(apex_lang.message(''APEX.FEATURE.ACL.BULK_USER.CREATE_CONFIRM'', :P10044_VALID_COUNT, :P10044_ROLE));',
'sys.htp.prn(''</p>'');'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_VALID'''))
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18162445013409377)
,p_plug_name=>'No Valid Users Exist - Page Info'
,p_region_template_options=>'#DEFAULT#:margin-bottom-sm'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>'<p>No valid new users found</p>'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'NOT_EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_VALID'''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18151618372409367)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18150841765409367)
,p_button_name=>'SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Users'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_VALID'''))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18163150258409378)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18150841765409367)
,p_button_name=>'PREVIOUS'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17740742065408952)
,p_button_image_alt=>'Previous'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'javascript:history.back();'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18151101599409367)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(18150841765409367)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18163896130409378)
,p_name=>'P10044_ROLE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18151516054409367)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select LISTAGG( role_name, '', '')',
'         WITHIN GROUP (ORDER BY role_name) role_name',
'from APEX_APPL_ACL_ROLES',
'where application_id = :APP_ID',
'and instr(:P10043_ROLE, role_id, 1) > 0'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18164221591409379)
,p_name=>'P10044_VALID_COUNT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(18151516054409367)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_VALID'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18164682366409379)
,p_name=>'P10044_INVALID_COUNT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18151516054409367)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from apex_collections',
' where collection_name = ''ACL_BULK_USER_VALID'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18151245443409367)
,p_name=>'Cancel Modal'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18151101599409367)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18165370173409379)
,p_event_id=>wwv_flow_api.id(18151245443409367)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18165827941409380)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Add Users to Access Control List'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_user_role_ids apex_application_global.vc_arr2;',
'begin',
'    for c in (  select distinct c001 as username, c003 as user_roles',
'                from   apex_collections',
'                where  collection_name = ''ACL_BULK_USER_VALID'' ) loop',
'         l_user_role_ids := apex_util.string_to_table(c.user_roles);',
'         for i in 1..l_user_role_ids.count loop',
'             apex_acl.add_user_role(p_application_id => :APP_ID, p_user_name => c.username, p_role_id => l_user_role_ids(i));',
'         end loop;',
'    end loop;',
'',
'    apex_collection.DELETE_COLLECTION(''ACL_BULK_USER_INVALID'');',
'    apex_collection.DELETE_COLLECTION(''ACL_BULK_USER_VALID'');',
'    :P10043_PRELIM_USERS := null;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(18151618372409367)
,p_process_success_message=>'User(s) added.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18166202419409380)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_10050
begin
wwv_flow_api.create_page(
 p_id=>10050
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Feedback'
,p_alias=>'FEEDBACK'
,p_page_mode=>'MODAL'
,p_step_title=>'Feedback'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.feedback-positive, .feedback-negative, .feedback-neutral { padding: 8px; border-radius: 100%; background-color: white; margin: 4px; }',
'.feedback-positive { color: #4caf50; }',
'.feedback-neutral { color: #eb9f41; }',
'.feedback-negative { color: #f44336; }'))
,p_required_patch=>wwv_flow_api.id(17765617625408970)
,p_dialog_width=>'480'
,p_dialog_chained=>'N'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054531'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18166687971409380)
,p_plug_name=>'Form Items Region'
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18166774627409380)
,p_plug_name=>'Buttons Region'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18166829300409380)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18166774627409380)
,p_button_name=>'SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit Feedback'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18166990009409380)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18166774627409380)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_EDIT'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(18175448259409385)
,p_branch_name=>'success'
,p_branch_action=>'f?p=&APP_ID.:10051:&SESSION.::&DEBUG.:RP::'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18170329041409382)
,p_name=>'P10050_APPLICATION_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18166687971409380)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18170779638409382)
,p_name=>'P10050_PAGE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(18166687971409380)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18171187648409382)
,p_name=>'P10050_USER_AGENT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18166687971409380)
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sys.owa_util.get_cgi_env(''user-agent'') x',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18171579973409382)
,p_name=>'P10050_RATING'
,p_item_sequence=>35
,p_item_plug_id=>wwv_flow_api.id(18166687971409380)
,p_prompt=>'Experience'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'FEEDBACK_RATING'
,p_lov=>'.'||wwv_flow_api.id(18171693153409382)||'.'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'3'
,p_attribute_02=>'NONE'
,p_attribute_03=>'Y'
,p_attribute_04=>'VERTICAL'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18173386003409384)
,p_name=>'P10050_FEEDBACK'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(18166687971409380)
,p_prompt=>'Feedback'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>64
,p_cMaxlength=>4000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(18175063905409385)
,p_validation_name=>'At least One Feedback Required'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P10050_FEEDBACK is null and :P10050_RATING is null then',
'    return false;',
'else',
'    return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please provide feedback or your experience.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18167092784409380)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18166990009409380)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18174112905409384)
,p_event_id=>wwv_flow_api.id(18167092784409380)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18174606180409385)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Submit Feedback'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'apex_util.submit_feedback (',
'    p_comment              => :P10050_FEEDBACK,',
'    p_application_id       => :APP_ID,',
'    p_page_id              => :P10050_PAGE_ID,',
'    p_rating               => :P10050_RATING',
'',
' );',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(18166829300409380)
,p_process_success_message=>'Feedback Submitted'
);
end;
/
prompt --application/pages/page_10051
begin
wwv_flow_api.create_page(
 p_id=>10051
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Feedback Submitted'
,p_alias=>'FEEDBACK-SUBMITTED'
,p_page_mode=>'MODAL'
,p_step_title=>'Feedback'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_required_patch=>wwv_flow_api.id(17765617625408970)
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054531'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18167261700409380)
,p_plug_name=>'Feedback Submitted'
,p_icon_css_classes=>'fa-check-circle'
,p_region_template_options=>'#DEFAULT#:t-Alert--wizard:t-Alert--customIcons:t-Alert--success'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17648207118408902)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18167171693409380)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18167261700409380)
,p_button_name=>'CLOSE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Close'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_css_classes=>'w40p'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18167370984409380)
,p_name=>'Close Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18167171693409380)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18177028901409386)
,p_event_id=>wwv_flow_api.id(18167370984409380)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
end;
/
prompt --application/pages/page_10053
begin
wwv_flow_api.create_page(
 p_id=>10053
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Manage Feedback'
,p_alias=>'MANAGE-FEEDBACK'
,p_page_mode=>'MODAL'
,p_step_title=>'Manage Feedback'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* Color feedback rating icons */',
'.feedback-positive { color: #4caf50; }',
'.feedback-neutral { color: #eb9f41; }',
'.feedback-negative { color: #f44336; }'))
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765617625408970)
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Feedback can be entered by end users from any normal page within the application.</p>',
'<p>This report shows the feedback entered, any response enter by administrators, and the status of the feedback.</p>',
'<p>Click the edit icon (yellow pencil) to enter a response or update the feedback status.</p>',
'<p><em><strong>Note:</strong> If feedback recipients have been defined then feedback submissions will also be emailed to the email addresses in the feedback recipients list.</em></p>'))
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054531'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18168731180409380)
,p_plug_name=>'Manage Feedback'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>wwv_flow_api.id(17677439644408917)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select feedback_id id,',
'    page_id||''. ''||page_name page_name,',
'    created_on created,',
'    lower(created_by) created_by,',
'    feedback,',
'    feedback_rating rating,',
'    case feedback_rating',
'      when 1 then ''fa-frown-o feedback-negative'' ',
'      when 2 then ''fa-emoji-neutral feedback-neutral''  ',
'      when 3 then ''fa-smile-o feedback-positive''',
'    end rating_icon,',
'    feedback_status status,',
'    public_response response,',
'    http_user_agent user_agent,',
'    updated_on updated,',
'    lower(updated_by) updated_by,',
'    page_id',
'',
'',
'',
'',
'from apex_team_feedback f',
'where application_id = :APP_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Manage Feedback'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18188052740409394)
,p_name=>'Manage Feedback'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:10054:&APP_SESSION.::::P10054_ID:#ID#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'WORKSHOPATP'
,p_internal_uid=>18188052740409394
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18188198242409394)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18188553949409395)
,p_db_column_name=>'PAGE_NAME'
,p_display_order=>11
,p_column_identifier=>'B'
,p_column_label=>'Application Page'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18188906707409395)
,p_db_column_name=>'CREATED'
,p_display_order=>21
,p_column_identifier=>'C'
,p_column_label=>'Filed'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'since'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18189396791409395)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>31
,p_column_identifier=>'D'
,p_column_label=>'Filed By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18189786399409396)
,p_db_column_name=>'FEEDBACK'
,p_display_order=>41
,p_column_identifier=>'E'
,p_column_label=>'Feedback'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18190139752409397)
,p_db_column_name=>'RATING'
,p_display_order=>51
,p_column_identifier=>'F'
,p_column_label=>'Rating'
,p_column_html_expression=>'<span class="fa #RATING_ICON#" aria-hidden="true" title="#RATING#"></span>'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(18171693153409382)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18190588893409397)
,p_db_column_name=>'RATING_ICON'
,p_display_order=>55
,p_column_identifier=>'G'
,p_column_label=>'RATING ICON'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18190987592409398)
,p_db_column_name=>'STATUS'
,p_display_order=>61
,p_column_identifier=>'H'
,p_column_label=>'Status'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_named_lov=>wwv_flow_api.id(18181743719409390)
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18191333122409398)
,p_db_column_name=>'RESPONSE'
,p_display_order=>71
,p_column_identifier=>'I'
,p_column_label=>'Response'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18191796442409399)
,p_db_column_name=>'USER_AGENT'
,p_display_order=>81
,p_column_identifier=>'J'
,p_column_label=>'User Agent'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18192157682409399)
,p_db_column_name=>'UPDATED'
,p_display_order=>91
,p_column_identifier=>'K'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'since'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18192522039409400)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>101
,p_column_identifier=>'L'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18192929075409400)
,p_db_column_name=>'PAGE_ID'
,p_display_order=>111
,p_column_identifier=>'M'
,p_column_label=>'Page'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18193652343409401)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'181937'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PAGE_NAME:CREATED:CREATED_BY:FEEDBACK:RATING:STATUS:RESPONSE:UPDATED:UPDATED_BY'
,p_sort_column_1=>'UPDATED'
,p_sort_direction_1=>'DESC'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18194520543409401)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18168731180409380)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(17741566209408953)
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18168689681409380)
,p_name=>'Refresh on Dialog Close'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(18168731180409380)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18195831276409403)
,p_event_id=>wwv_flow_api.id(18168689681409380)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18168731180409380)
);
end;
/
prompt --application/pages/page_10054
begin
wwv_flow_api.create_page(
 p_id=>10054
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Feedback'
,p_alias=>'FEEDBACK1'
,p_page_mode=>'MODAL'
,p_step_title=>'Feedback'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* Color feedback rating icons */',
'.feedback-positive { color: #4caf50; }',
'.feedback-neutral { color: #eb9f41; }',
'.feedback-negative { color: #f44336; }'))
,p_required_role=>wwv_flow_api.id(17768108323408972)
,p_required_patch=>wwv_flow_api.id(17765617625408970)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054531'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18168062859409380)
,p_plug_name=>'Form Items Region'
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18168179616409380)
,p_plug_name=>'Buttons Region'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17652975206408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18168285125409380)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18168179616409380)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18168321691409380)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18168179616409380)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_EDIT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18168427060409380)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(18168179616409380)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_api.id(17741443504408953)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_condition=>'P10054_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18179234363409388)
,p_name=>'P10054_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18168062859409380)
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18179679727409388)
,p_name=>'P10054_PAGE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(18168062859409380)
,p_prompt=>'Page'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18180012657409389)
,p_name=>'P10054_FILED'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18168062859409380)
,p_prompt=>'Filed'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18180496561409389)
,p_name=>'P10054_RATING_ICON'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(18168062859409380)
,p_prompt=>'Rating'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18180825898409389)
,p_name=>'P10054_FEEDBACK'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(18168062859409380)
,p_prompt=>'Feedback'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18181290004409389)
,p_name=>'P10054_RESPONSE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(18168062859409380)
,p_prompt=>'Response'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>64
,p_cMaxlength=>4000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18181652379409390)
,p_name=>'P10054_FEEDBACK_STATUS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(18168062859409380)
,p_prompt=>'Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'FEEDBACK_STATUS'
,p_lov=>'.'||wwv_flow_api.id(18181743719409390)||'.'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18183979009409391)
,p_name=>'P10054_USER_AGENT'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(18168062859409380)
,p_prompt=>'User Agent'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(17740369355408952)
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18168505287409380)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18168321691409380)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18184762961409392)
,p_event_id=>wwv_flow_api.id(18168505287409380)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18185257945409392)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in (',
'   select page_id,',
'          page_name,',
'          case feedback_rating',
'                when 1 then ''<span class="fa fa-frown-o feedback-negative" aria-hidden="true" title="Negative"></span>'' ',
'                when 2 then ''<span class="fa fa-emoji-neutral feedback-neutral" aria-hidden="true" title="Neutral"></span>''  ',
'                when 3 then ''<span class="fa fa-smile-o feedback-positive" aria-hidden="true" title="Positive"></span>'' ',
'                end rating_icon,',
'          lower(created_by) || '' - '' || apex_util.get_since(created_on) filed,',
'          feedback,',
'          public_response,',
'          feedback_status,',
'          http_user_agent',
'     from apex_team_feedback',
'    where feedback_id = :P10054_ID',
') loop',
'   :P10054_PAGE_ID := c1.page_id||''. ''||c1.page_name;',
'   :P10054_FILED := c1.filed;',
'   :P10054_RATING_ICON := c1.rating_icon;',
'   :P10054_FEEDBACK := c1.feedback;',
'   :P10054_RESPONSE := c1.public_response;',
'   :P10054_FEEDBACK_STATUS := c1.feedback_status;',
'   :P10054_USER_AGENT := c1.http_user_agent;',
'end loop;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18185616285409392)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_util.reply_to_feedback (',
'    p_feedback_id        => :P10054_ID,',
'    p_status             => :P10054_FEEDBACK_STATUS,',
'    p_public_response    => :P10054_RESPONSE );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(18168285125409380)
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18186067110409392)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_util.delete_feedback (',
'    p_feedback_id        => :P10054_ID );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(18168427060409380)
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18186433806409393)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'E.PROPERTY.BUTTON_ACTION.LOV.RESET.D'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(18168427060409380)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(18186897292409393)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_10060
begin
wwv_flow_api.create_page(
 p_id=>10060
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'About'
,p_alias=>'HELP'
,p_step_title=>'About'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(17770014052408975)
,p_required_patch=>wwv_flow_api.id(17766194438408970)
,p_help_text=>'All application help text can be accessed from this page. The links in the "Documentation" region give a much more in-depth explanation of the application''s features and functionality.'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054531'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18196753362409403)
,p_plug_name=>'About Page'
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--padded:t-ContentBlock--h1:t-ContentBlock--lightBG'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17667727194408912)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>'Text about this application can be placed here.'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
end;
/
prompt --application/pages/page_10061
begin
wwv_flow_api.create_page(
 p_id=>10061
,p_user_interface_id=>wwv_flow_api.id(17764051383408965)
,p_name=>'Help'
,p_alias=>'PAGE_HELP'
,p_page_mode=>'MODAL'
,p_step_title=>'Help'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_patch=>wwv_flow_api.id(17766194438408970)
,p_dialog_chained=>'N'
,p_last_updated_by=>'WORKSHOPATP'
,p_last_upd_yyyymmddhh24miss=>'20200812054531'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18197433892409404)
,p_plug_name=>'Search Dialog'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(17651912627408904)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for c1 in ',
'(',
'    select page_title, help_text ',
'      from apex_application_pages',
'     where page_id = :P10061_PAGE_ID ',
'       and application_id = :APP_ID',
')',
'loop',
'    if c1.help_text is null then',
'        sys.htp.p(''No help is available for this page.'');',
'    else',
'        if substr(c1.help_text, 1, 3) != ''<p>'' then',
'            sys.htp.p(''<p>'');',
'        end if;',
'',
'        sys.htp.p(apex_application.do_substitutions(c1.help_text));',
'',
'        if substr(trim(c1.help_text), -4) != ''</p>'' then',
'            sys.htp.p(''</p>'');',
'        end if;',
'    end if;',
'end loop;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18197898379409404)
,p_name=>'P10061_PAGE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18197433892409404)
,p_display_as=>'NATIVE_HIDDEN'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'Y'
);
end;
/
prompt --application/deployment/definition
begin
wwv_flow_api.create_install(
 p_id=>wwv_flow_api.id(18233484310574473)
);
end;
/
prompt --application/deployment/install/install_set_administrator_role
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(18233990426636715)
,p_install_id=>wwv_flow_api.id(18233484310574473)
,p_name=>'Set Administrator Role'
,p_sequence=>10
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    APEX_ACL.ADD_USER_ROLE (',
'        p_application_id => apex_application.g_flow_id,          ',
'        p_user_name      => apex_application.g_user ,',
'        p_role_static_id => ''ADMINISTRATOR'' );',
'end;'))
);
end;
/
prompt --application/deployment/install/install_hol_objects
begin
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(18234461899642387)
,p_install_id=>wwv_flow_api.id(18233484310574473)
,p_name=>'HOL Objects'
,p_sequence=>20
,p_script_type=>'INSTALL'
,p_condition_type=>'NOT_EXISTS'
,p_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from (',
'select 1 as counter  from user_objects where object_name in (''HOL_TEAM_MEMBERS'',''HOL_PROJECTS'',''HOL_MILESTONES'',''HOL_TASKS'',''HOL_TO_DOS'',''HOL_LINKS'',''HOL_PROJECT_TASKS'')',
'    ) group by counter having count(*) = 7;'))
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- create tables',
'create table hol_team_members (',
'    id                             number generated by default on null as identity  ',
'                                   constraint hol_team_members_id_pk primary key,',
'    row_version                    integer not null,',
'    username                       varchar2(255) not null,',
'    full_name                      varchar2(255),',
'    email                          varchar2(255) not null,',
'    phone_number                   number,',
'    profile                        varchar2(4000),',
'    photo                          blob,',
'    photo_filename                 varchar2(512),',
'    photo_mimetype                 varchar2(512),',
'    photo_charset                  varchar2(512),',
'    photo_lastupd                  timestamp with local time zone,',
'    created                        timestamp with local time zone not null,',
'    created_by                     varchar2(255) not null,',
'    updated                        timestamp with local time zone not null,',
'    updated_by                     varchar2(255) not null',
')',
';',
'',
'create table hol_projects (',
'    id                             number generated by default on null as identity  ',
'                                   constraint hol_projects_id_pk primary key,',
'    row_version                    integer not null,',
'    name                           varchar2(255) not null,',
'    project_lead                   number',
'                                   constraint hol_projects_project_lead_fk',
'                                   references hol_team_members not null,',
'    budget                         number,',
'    status                         varchar2(30) constraint hol_projects_status_cc',
'                                   check (status in (''ASSIGNED'',''IN-PROGRESS'',''COMPLETED'')) not null,',
'    completed_date                 timestamp with local time zone,',
'    description                    varchar2(4000),',
'    created                        timestamp with local time zone not null,',
'    created_by                     varchar2(255) not null,',
'    updated                        timestamp with local time zone not null,',
'    updated_by                     varchar2(255) not null',
')',
';',
'',
'create table hol_milestones (',
'    id                             number generated by default on null as identity  ',
'                                   constraint hol_milestones_id_pk primary key,',
'    project_id                     number',
'                                   constraint hol_milestones_project_id_fk',
'                                   references hol_projects,',
'    row_version                    integer not null,',
'    name                           varchar2(255) not null,',
'    due_date                       timestamp with local time zone not null,',
'    description                    varchar2(4000),',
'    created                        timestamp with local time zone not null,',
'    created_by                     varchar2(255) not null,',
'    updated                        timestamp with local time zone not null,',
'    updated_by                     varchar2(255) not null',
')',
';',
'',
'create table hol_tasks (',
'    id                             number generated by default on null as identity  ',
'                                   constraint hol_tasks_id_pk primary key,',
'    project_id                     number',
'                                   constraint hol_tasks_project_id_fk',
'                                   references hol_projects,',
'    milestone_id                   number',
'                                   constraint hol_tasks_milestone_id_fk',
'                                   references hol_milestones,',
'    row_version                    integer not null,',
'    name                           varchar2(255) not null,',
'    assignee                       number',
'                                   constraint hol_tasks_assignee_fk',
'                                   references hol_team_members,',
'    start_date                     timestamp with local time zone not null,',
'    end_date                       timestamp with local time zone,',
'    cost                           number,',
'    description                    varchar2(4000),',
'    is_complete_yn                 varchar2(1) constraint hol_tasks_is_complete_yn_cc',
'                                   check (is_complete_yn in (''Y'',''N'')),',
'    created                        timestamp with local time zone not null,',
'    created_by                     varchar2(255) not null,',
'    updated                        timestamp with local time zone not null,',
'    updated_by                     varchar2(255) not null',
')',
';',
'',
'create table hol_to_dos (',
'    id                             number generated by default on null as identity  ',
'                                   constraint hol_to_dos_id_pk primary key,',
'    task_id                        number',
'                                   constraint hol_to_dos_task_id_fk',
'                                   references hol_tasks,',
'    row_version                    integer not null,',
'    todo                           varchar2(255) not null,',
'    assingee                       number',
'                                   constraint hol_to_dos_assingee_fk',
'                                   references hol_team_members,',
'    due_date                       timestamp with local time zone,',
'    details                        varchar2(4000),',
'    created                        timestamp with local time zone not null,',
'    created_by                     varchar2(255) not null,',
'    updated                        timestamp with local time zone not null,',
'    updated_by                     varchar2(255) not null',
')',
';',
'',
'create table hol_links (',
'    id                             number generated by default on null as identity  ',
'                                   constraint hol_links_id_pk primary key,',
'    task_id                        number',
'                                   constraint hol_links_task_id_fk',
'                                   references hol_tasks,',
'    row_version                    integer not null,',
'    url                            varchar2(255) not null,',
'    name                           varchar2(255),',
'    description                    varchar2(4000),',
'    created                        timestamp with local time zone not null,',
'    created_by                     varchar2(255) not null,',
'    updated                        timestamp with local time zone not null,',
'    updated_by                     varchar2(255) not null',
')',
';',
'',
'',
'-- triggers',
'create or replace trigger hol_projects_biu',
'    before insert or update ',
'    on hol_projects',
'    for each row',
'begin',
'    if inserting then',
'        :new.row_version := 1;',
'    elsif updating then',
'        :new.row_version := nvl(:old.row_version,0) + 1;',
'    end if;',
'    if inserting then',
'        :new.created := localtimestamp;',
'        :new.created_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := localtimestamp;',
'    :new.updated_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end hol_projects_biu;',
'/',
'',
'create or replace trigger hol_team_members_biu',
'    before insert or update ',
'    on hol_team_members',
'    for each row',
'begin',
'    if inserting then',
'        :new.row_version := 1;',
'    elsif updating then',
'        :new.row_version := nvl(:old.row_version,0) + 1;',
'    end if;',
'    if inserting then',
'        :new.created := localtimestamp;',
'        :new.created_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := localtimestamp;',
'    :new.updated_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    :new.username := upper(:new.username);',
'end hol_team_members_biu;',
'/',
'',
'create or replace trigger hol_links_biu',
'    before insert or update ',
'    on hol_links',
'    for each row',
'begin',
'    if inserting then',
'        :new.row_version := 1;',
'    elsif updating then',
'        :new.row_version := nvl(:old.row_version,0) + 1;',
'    end if;',
'    if inserting then',
'        :new.created := localtimestamp;',
'        :new.created_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := localtimestamp;',
'    :new.updated_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    :new.url := lower(:new.url);',
'end hol_links_biu;',
'/',
'',
'create or replace trigger hol_milestones_biu',
'    before insert or update ',
'    on hol_milestones',
'    for each row',
'begin',
'    if inserting then',
'        :new.row_version := 1;',
'    elsif updating then',
'        :new.row_version := nvl(:old.row_version,0) + 1;',
'    end if;',
'    if inserting then',
'        :new.created := localtimestamp;',
'        :new.created_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := localtimestamp;',
'    :new.updated_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end hol_milestones_biu;',
'/',
'',
'create or replace trigger hol_to_dos_biu',
'    before insert or update ',
'    on hol_to_dos',
'    for each row',
'begin',
'    if inserting then',
'        :new.row_version := 1;',
'    elsif updating then',
'        :new.row_version := nvl(:old.row_version,0) + 1;',
'    end if;',
'    if inserting then',
'        :new.created := localtimestamp;',
'        :new.created_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := localtimestamp;',
'    :new.updated_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end hol_to_dos_biu;',
'/',
'',
'create or replace trigger hol_tasks_biu',
'    before insert or update ',
'    on hol_tasks',
'    for each row',
'begin',
'    if inserting then',
'        :new.row_version := 1;',
'    elsif updating then',
'        :new.row_version := nvl(:old.row_version,0) + 1;',
'    end if;',
'    if inserting then',
'        :new.created := localtimestamp;',
'        :new.created_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := localtimestamp;',
'    :new.updated_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end hol_tasks_biu;',
'/',
'',
'',
'-- indexes',
'create index hol_links_i1 on hol_links (task_id);',
'create index hol_milestones_i1 on hol_milestones (project_id);',
'create index hol_projects_i1 on hol_projects (project_lead);',
'create index hol_tasks_i1 on hol_tasks (assignee);',
'create index hol_tasks_i2 on hol_tasks (milestone_id);',
'create index hol_tasks_i3 on hol_tasks (project_id);',
'create index hol_to_dos_i1 on hol_to_dos (assingee);',
'create index hol_to_dos_i2 on hol_to_dos (task_id);',
'',
'-- create views',
'create or replace view hol_project_tasks as ',
'select ',
'    projects.id                                        project_id,',
'    projects.row_version                               project_row_version,',
'    projects.name                                      project_name,',
'    projects.project_lead                              project_lead,',
'    projects.budget                                    budget,',
'    projects.status                                    status,',
'    projects.completed_date                            completed_date,',
'    projects.description                               project_description,',
'    projects.created                                   project_created,',
'    projects.created_by                                project_created_by,',
'    projects.updated                                   project_updated,',
'    projects.updated_by                                project_updated_by,',
'    tasks.id                                           task_id,',
'    tasks.row_version                                  task_row_version,',
'    tasks.name                                         task_name,',
'    tasks.assignee                                     assignee,',
'    tasks.milestone_id                                 milestone_id,',
'    tasks.start_date                                   start_date,',
'    tasks.end_date                                     end_date,',
'    tasks.cost                                         cost,',
'    tasks.description                                  task_description,',
'    tasks.is_complete_yn                               is_complete_yn,',
'    tasks.created                                      task_created,',
'    tasks.created_by                                   task_created_by,',
'    tasks.updated                                      task_updated,',
'    tasks.updated_by                                   task_updated_by',
'from ',
'    hol_projects projects,',
'    hol_tasks tasks',
'where',
'    tasks.project_id(+) = projects.id',
'/',
'',
'-- load data',
' ',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    1,',
'    ''Expense Imaging Upgrade'',',
'    ''Gricelda Luebbers'',',
'    ''gricelda.luebbers@aaab.com'',',
'    13,',
'    ''Ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula'
||' commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere.'',',
'    null,',
'    ''Expense Imaging Upgrade'',',
'    ''Fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orc'
||'i luctus et ultrices posuere cubilia Curae; Proin vulputate.'',',
'    ''Risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam.'',',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    2,',
'    ''Platform Modernization'',',
'    ''Dean Bollich'',',
'    ''dean.bollich@aaac.com'',',
'    54,',
'    ''Mattis risus rhoncus.Cras vulputate porttitor ligula.'',',
'    null,',
'    ''Platform Modernization'',',
'    ''Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tin'
||'cidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque.'',',
'    ''Vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectu'
||'s, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus.'',',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    3,',
'    ''EMEA Sales Program'',',
'    ''Milo Manoni'',',
'    ''milo.manoni@aaad.com'',',
'    15,',
'    ''Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin.'',',
'    null,',
'    ''EMEA Sales Program'',',
'    ''Ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula'
||' commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in.'',',
'    ''Ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus.'',',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    4,',
'    ''System Breach Analysis'',',
'    ''Laurice Karl'',',
'    ''laurice.karl@aaae.com'',',
'    36,',
'    ''Faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget mal'
||'esuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis.'',',
'    null,',
'    ''System Breach Analysis'',',
'    ''Massa pharetra, id mattis.'',',
'    ''Ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec.'',',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    5,',
'    ''Supplier Caching'',',
'    ''August Rupel'',',
'    ''august.rupel@aaaf.com'',',
'    55,',
'    ''Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincid'
||'unt. Vestibulum ante ipsumprimis.'',',
'    null,',
'    ''Supplier Caching'',',
'    ''Imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus.'',',
'    ''Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel.'',',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    6,',
'    ''Dynamic Scaling Deployment'',',
'    ''Salome Guisti'',',
'    ''salome.guisti@aaag.com'',',
'    56,',
'    ''Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posu'
||'ere mi maximus vitae.'',',
'    null,',
'    ''Dynamic Scaling Deployment'',',
'    ''Faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere c'
||'ubilia Curae; Proin.'',',
'    ''Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus.'',',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    7,',
'    ''Micro Processor Upgrade'',',
'    ''Lovie Ritacco'',',
'    ''lovie.ritacco@aaah.com'',',
'    43,',
'    ''Id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae;'
||' Proin vulputate placerat pellentesque. Proin viverra.'',',
'    null,',
'    ''Micro Processor Upgrade'',',
'    ''Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretiu'
||'m ut.'',',
'    ''Sit amet.'',',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    8,',
'    ''Business Intelligence Module'',',
'    ''Chaya Greczkowski'',',
'    ''chaya.greczkowski@aaai.com'',',
'    24,',
'    ''Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum.'',',
'    null,',
'    ''Business Intelligence Module'',',
'    ''Et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.'',',
'    ''Vitae ligula commodo, dictum.'',',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    9,',
'    ''Mobile First Strategy'',',
'    ''Twila Coolbeth'',',
'    ''twila.coolbeth@aaaj.com'',',
'    93,',
'    ''Proin vulputate placerat pellentesque. Proin.'',',
'    null,',
'    ''Mobile First Strategy'',',
'    ''Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam.'',',
'    ''In faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec.'',',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone)',
');',
'',
'insert into hol_team_members (',
'    id,',
'    username,',
'    full_name,',
'    email,',
'    phone_number,',
'    profile,',
'    photo,',
'    photo_filename,',
'    photo_mimetype,',
'    photo_charset,',
'    photo_lastupd',
') values (',
'    10,',
'    ''EPA Impact Study'',',
'    ''Carlotta Achenbach'',',
'    ''carlotta.achenbach@aaak.com'',',
'    9,',
'    ''Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venena'
||'tis nec. Donec convallis sollicitudin elementum.'',',
'    null,',
'    ''EPA Impact Study'',',
'    ''Arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nu'
||'lla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex.'',',
'    ''Malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus.'',',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone)',
');',
'',
'commit;',
'-- load data',
'-- load data',
' ',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    1,',
'    ''Expense Imaging Upgrade'',',
'    1,',
'    55,',
'    ''ASSIGNED'',',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    ''Amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    2,',
'    ''Platform Modernization'',',
'    1,',
'    18,',
'    ''IN-PROGRESS'',',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    ''Placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fam'
||'es ac ante ipsum primis in faucibus. Ut id nulla ac sapien.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    3,',
'    ''EMEA Sales Program'',',
'    1,',
'    61,',
'    ''COMPLETED'',',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    ''Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    4,',
'    ''System Breach Analysis'',',
'    1,',
'    69,',
'    ''ASSIGNED'',',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone),',
'    ''Ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis s'
||'ollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    5,',
'    ''Supplier Caching'',',
'    1,',
'    62,',
'    ''IN-PROGRESS'',',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    ''Nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo ar'
||'cu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus '
||'vitae, pretium a ligula. Donec eget lectus malesuada, scelerisque lorem in,sollicitudin enim. Aenean non.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    6,',
'    ''Dynamic Scaling Deployment'',',
'    1,',
'    81,',
'    ''COMPLETED'',',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    ''Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincid'
||'unt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.'
||' In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    7,',
'    ''Micro Processor Upgrade'',',
'    1,',
'    54,',
'    ''ASSIGNED'',',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    ''Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in'
||' faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubil'
||'ia Curae; Proin.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    8,',
'    ''Business Intelligence Module'',',
'    1,',
'    42,',
'    ''IN-PROGRESS'',',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    ''Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in'
||' faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubil'
||'ia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    9,',
'    ''Mobile First Strategy'',',
'    1,',
'    71,',
'    ''COMPLETED'',',
'    cast(add_months(systimestamp,-19) as timestamp with local time zone),',
'    ''Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; P'))
);
end;
/
begin
wwv_flow_api.append_to_install_script(
 p_id=>wwv_flow_api.id(18234461899642387)
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'roin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    10,',
'    ''EPA Impact Study'',',
'    1,',
'    19,',
'    ''ASSIGNED'',',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    ''Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis solli'
||'citudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In so'
||'llicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    11,',
'    ''Employee Evaluation Reviews'',',
'    1,',
'    33,',
'    ''IN-PROGRESS'',',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    ''Semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, di'
||'ctum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    12,',
'    ''Bug Management System'',',
'    1,',
'    21,',
'    ''COMPLETED'',',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    ''Risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    13,',
'    ''Air Upgrade'',',
'    1,',
'    92,',
'    ''ASSIGNED'',',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    ''Ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luct'
||'us et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    14,',
'    ''P12W1 Regress'',',
'    1,',
'    96,',
'    ''IN-PROGRESS'',',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    ''Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi '
||'maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. '
||'Lorem ipsum dolor sit amet, consectetur.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    15,',
'    ''Identity Management Modernization'',',
'    1,',
'    32,',
'    ''COMPLETED'',',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    ''Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi'
||' venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    16,',
'    ''Night Monitoring'',',
'    1,',
'    33,',
'    ''ASSIGNED'',',
'    cast(add_months(systimestamp,-19) as timestamp with local time zone),',
'    ''Arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    17,',
'    ''Exadata Refresh'',',
'    1,',
'    63,',
'    ''IN-PROGRESS'',',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    ''Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    18,',
'    ''TOA Technologies Upgrade'',',
'    1,',
'    34,',
'    ''COMPLETED'',',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    ''Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    19,',
'    ''Accounts Payable API'',',
'    1,',
'    26,',
'    ''ASSIGNED'',',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    ''Sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis ne'
||'c. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat.''',
');',
'',
'insert into hol_projects (',
'    id,',
'    name,',
'    project_lead,',
'    budget,',
'    status,',
'    completed_date,',
'    description',
') values (',
'    20,',
'    ''Employee Baseline Assessment'',',
'    1,',
'    26,',
'    ''IN-PROGRESS'',',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    ''Mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tris'
||'tique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.''',
');',
'',
'commit;',
'-- load data',
' ',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    1,',
'    1,',
'    ''Expense Imaging Upgrade'',',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    ''Semper diam suscipit elementum sodales.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    2,',
'    16,',
'    ''Platform Modernization'',',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    ''Pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque to'
||'rtor odio, feugiat eget sagittisvel, pretium.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    3,',
'    2,',
'    ''EMEA Sales Program'',',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    ''In faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    4,',
'    16,',
'    ''System Breach Analysis'',',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    ''Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posu'
||'ere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae t'
||'urpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium a ligula. Donec eget.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    5,',
'    7,',
'    ''Supplier Caching'',',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    ''Commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. V'
||'estibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In po'
||'suere blandit leoeget malesuada.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    6,',
'    4,',
'    ''Dynamic Scaling Deployment'',',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    ''Ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis s'
||'ollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    7,',
'    9,',
'    ''Micro Processor Upgrade'',',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    ''Non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo u'
||'llamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante'
||'.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    8,',
'    13,',
'    ''Business Intelligence Module'',',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    ''Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et '
||'commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    9,',
'    13,',
'    ''Mobile First Strategy'',',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    ''Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.'
||' In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    10,',
'    13,',
'    ''EPA Impact Study'',',
'    cast(add_months(systimestamp,-19) as timestamp with local time zone),',
'    ''Ex. Etiam cursus porttitor tincidunt. Vestibulum.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    11,',
'    10,',
'    ''Employee Evaluation Reviews'',',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    ''Sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulpu'
||'tate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Q'
||'uisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    12,',
'    8,',
'    ''Bug Management System'',',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    ''Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    13,',
'    13,',
'    ''Air Upgrade'',',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    ''Et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus effic'
||'itur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    14,',
'    16,',
'    ''P12W1 Regress'',',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    ''Ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    15,',
'    19,',
'    ''Identity Management Modernization'',',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    ''Mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    16,',
'    9,',
'    ''Night Monitoring'',',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    ''Primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices'
||' posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellu'
||'s, quis posuere mi.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    17,',
'    4,',
'    ''Exadata Refresh'',',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    ''Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Cur'
||'ae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi m'
||'aximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget,.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    18,',
'    11,',
'    ''TOA Technologies Upgrade'',',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    ''Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesua'
||'da fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci '
||'luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    19,',
'    8,',
'    ''Accounts Payable API'',',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    ''Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. V'
||'ivamus efficitur ipsum.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    20,',
'    6,',
'    ''Employee Baseline Assessment'',',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    ''Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincid'
||'unt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.'
||' In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    21,',
'    18,',
'    ''DOS Standardization'',',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    ''Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in'
||' faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubil'
||'ia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    22,',
'    15,',
'    ''NASA Contract Proposal'',',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    ''Risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    23,',
'    19,',
'    ''Employee Certification Exams'',',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    ''Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Cur'
||'ae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    24,',
'    18,',
'    ''Datalogic CBA'',',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    ''Ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    25,',
'    3,',
'    ''Tekelec System'',',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    ''Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate pl'
||'acerat pellentesque. Proin viverra lacinialectus,.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    26,',
'    16,',
'    ''Tekelec Authentication'',',
'    cast(add_months(systimestamp,-11) as timestamp with local time zone),',
'    ''Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat e'
||'get sagittisvel, pretium ut metus. Duis et commodo arcu,.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    27,',
'    9,',
'    ''Add-4J Upgrade'',',
'    cast(add_months(systimestamp,-11) as timestamp with local time zone),',
'    ''Ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, qui'
||'s consectetur mi venenatis nec.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    28,',
'    4,',
'    ''Client Side Caching Optimization'',',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    ''Ipsumprimis in faucibus orci luctus et ultrices posuere cubilia.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    29,',
'    18,',
'    ''System Decommission'',',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    ''Nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo ar'
||'cu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus '
||'vitae, pretium a ligula. Donec eget lectus.''',
');',
'',
'insert into hol_milestones (',
'    id,',
'    project_id,',
'    name,',
'    due_date,',
'    description',
') values (',
'    30,',
'    4,',
'    ''Travel Expense System'',',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    ''Nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo ar'
||'cu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus '
||'vitae, pretium a ligula. Donec eget lectus malesuada, scelerisque lorem in,sollicitudin.''',
');',
'',
'commit;',
'-- load data',
' ',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    1,',
'    6,',
'    ''Expense Imaging Upgrade'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    68,',
'    ''Ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitu'
||'r ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis variu'
||'s eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium a.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    2,',
'    4,',
'    ''Platform Modernization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-19) as timestamp with local time zone),',
'    23,',
'    ''Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesua'
||'da fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci '
||'luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    3,',
'    17,',
'    ''EMEA Sales Program'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    47,',
'    ''Placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fam'
||'es ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    4,',
'    7,',
'    ''System Breach Analysis'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    79,',
'    ''Ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula'
||' commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectet'
||'ur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio,.'',',
'    ''N''',
');',
'',
'insert into hol_tasks ('))
);
null;
end;
/
begin
wwv_flow_api.append_to_install_script(
 p_id=>wwv_flow_api.id(18234461899642387)
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    5,',
'    14,',
'    ''Supplier Caching'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone),',
'    98,',
'    ''Ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus '
||'et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur '
||'ipsum tellus, quis posuere mi.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    6,',
'    11,',
'    ''Dynamic Scaling Deployment'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-11) as timestamp with local time zone),',
'    16,',
'    ''Vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Ph'
||'asellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    7,',
'    9,',
'    ''Micro Processor Upgrade'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    28,',
'    ''Non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo u'
||'llamcorper.Interdum et malesuada fames ac ante ipsum primis in.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    8,',
'    11,',
'    ''Business Intelligence Module'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    74,',
'    ''Ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luct'
||'us et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    9,',
'    19,',
'    ''Mobile First Strategy'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    65,',
'    ''Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.'
||' In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    10,',
'    18,',
'    ''EPA Impact Study'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone),',
'    93,',
'    ''Nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo ar'
||'cu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus '
||'vitae, pretium a ligula. Donec eget lectus malesuada,.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    11,',
'    20,',
'    ''Employee Evaluation Reviews'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    51,',
'    ''Tincidunt. Vestibulum.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    12,',
'    11,',
'    ''Bug Management System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    39,',
'    ''Lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    13,',
'    14,',
'    ''Air Upgrade'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    3,',
'    ''Porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vi'
||'tae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis'
||' consectetur mi venenatis nec. Donec.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    14,',
'    8,',
'    ''P12W1 Regress'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone),',
'    90,',
'    ''Pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    15,',
'    12,',
'    ''Identity Management Modernization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    50,',
'    ''Amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    16,',
'    5,',
'    ''Night Monitoring'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    69,',
'    ''Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    17,',
'    15,',
'    ''Exadata Refresh'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    73,',
'    ''Nulla placerat iaculis aliquam.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    18,',
'    16,',
'    ''TOA Technologies Upgrade'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    28,',
'    ''Faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget mal'
||'esuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    19,',
'    17,',
'    ''Accounts Payable API'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    4,',
'    ''Vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    20,',
'    6,',
'    ''Employee Baseline Assessment'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    63,',
'    ''Massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttit'
||'or tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla '
||'facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    21,',
'    9,',
'    ''DOS Standardization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    75,',
'    ''Nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Pr'
||'oin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    22,',
'    1,',
'    ''NASA Contract Proposal'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    11,',
'    ''Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    23,',
'    8,',
'    ''Employee Certification Exams'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    28,',
'    ''Mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tris'
||'tique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    24,',
'    12,',
'    ''Datalogic CBA'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    56,',
'    ''Aliquam. Vestibulum lacinia arcu in massa.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    25,',
'    19,',
'    ''Tekelec System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-19) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    51,',
'    ''Mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tris'
||'tique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    26,',
'    7,',
'    ''Tekelec Authentication'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-11) as timestamp with local time zone),',
'    61,',
'    ''Faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget mal'
||'esuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapi'
||'en, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    27,',
'    3,',
'    ''Add-4J Upgrade'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    93,',
'    ''Mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    28,',
'    10,',
'    ''Client Side Caching Optimization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    5,',
'    ''Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet '
||'massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor ti'
||'ncidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    29,',
'    8,',
'    ''System Decommission'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    34,',
'    ''Lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagi'
||'ttisvel,.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    30,',
'    20,',
'    ''Travel Expense System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    8,',
'    ''Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    31,',
'    13,',
'    ''ASH Upgrade'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    82,',
'    ''Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    32,',
'    1,',
'    ''Selection Of Construction Site'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    55,',
'    ''Risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    33,',
'    15,',
'    ''Developer Bug Performance Review'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    89,',
'    ''Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi '
||'maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. '
||'Lorem ipsum dolor sit amet, consectetur.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    34,',
'    10,',
'    ''Golden Gate Replication'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    17,',
'    ''Tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    35,',
'    11,',
'    ''Calculation of Debt to Profit'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    50,',
'    ''Ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ul'
||'trices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum'
||' tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel,.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    36,',
'    9,',
'    ''Project Blue Ball'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    47,',
'    ''Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. V'
||'ivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendr'
||'erit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    37,',
'    18,',
'    ''New Optimization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    86,',
'    ''Tristique ac volutpat risus.Phasellus vitae ligula commodo,.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    38,',
'    12,',
'    ''Customer Satisfaction Improvement'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    98,',
'    ''Sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet '
||'ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollic'
||'itudin.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    39,',
'    16,',
'    ''Penetration Security Testing'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    24,',
'    ''Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    40,',
'    13,',
'    ''Build Automation'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    100,',
'    ''Tincidunt. Vestibulum.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    41,',
'    6,',
'    ''eBook Standardization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    79,',
'    ''Elit, vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit'
||' amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus portti'
||'tor.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    42,',
'    9,',
'    ''Documentation System Analytics'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    14,',
'    ''Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi'
||' venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    43,',
'    19,',
'    ''Y2 Security Review'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    27,',
'    ''Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi '
||'maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. '
||'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium a ligula. Donec eget lectus malesuada, scelerisque lorem in,sollicitudin enim. Aenean non lacinia.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    44,',
'    11,',
'    ''Support Training Initiative'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-5) as timestamp wi'))
);
null;
end;
/
begin
wwv_flow_api.append_to_install_script(
 p_id=>wwv_flow_api.id(18234461899642387)
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'th local time zone),',
'    66,',
'    ''Rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem c'
||'ommodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet,.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    45,',
'    7,',
'    ''Stateless Change'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    56,',
'    ''Vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximu'
||'s vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem '
||'ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium a ligula. Donec eget lectus malesuada, scelerisque lorem in,sollicitudin enim.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    46,',
'    16,',
'    ''Fortnight Program Review'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    83,',
'    ''Ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitu'
||'r ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis variu'
||'s eget, malesuada vitae turpis. Lorem ipsum dolor sit.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    47,',
'    8,',
'    ''Database System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    91,',
'    ''Ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitu'
||'r ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis variu'
||'s eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium a ligula. Donec eget lectus.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    48,',
'    5,',
'    ''Wait Event Review'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    94,',
'    ''Vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximu'
||'s vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    49,',
'    1,',
'    ''Null Pointer Optimization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    16,',
'    ''Porttitor ligula.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    50,',
'    11,',
'    ''Angular Smart Table'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    51,',
'    ''Imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec c'
||'onvallis sollicitudin elementum. Nulla facilisi. In.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    51,',
'    9,',
'    ''Release Implementation'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-19) as timestamp with local time zone),',
'    23,',
'    ''Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.'
||' In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravi'
||'da ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    52,',
'    18,',
'    ''Fax System Retirement'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    28,',
'    ''Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet '
||'massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    53,',
'    18,',
'    ''Datalogic System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    72,',
'    ''Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.'
||' In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravi'
||'da ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    54,',
'    7,',
'    ''Speech to text module'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    98,',
'    ''Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    55,',
'    11,',
'    ''GDPR Conformance Review'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    47,',
'    ''Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincid'
||'unt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.'
||' In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    56,',
'    16,',
'    ''User Group Advertising'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    1,',
'    ''Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Cur'
||'ae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi m'
||'aximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    57,',
'    2,',
'    ''Manual Planning'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    63,',
'    ''Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, i'
||'n vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae'
||', pretium a ligula. Donec eget lectus malesuada, scelerisque lorem in,sollicitudin enim. Aenean non.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    58,',
'    12,',
'    ''Availability Centered Inventory'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    52,',
'    ''Placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fam'
||'es ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    59,',
'    15,',
'    ''Open Office Floor Plan Upgrade'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    80,',
'    ''Ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vu'
||'lputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae'
||'. Quisque tortor odio, feugiat.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    60,',
'    20,',
'    ''Artifact Management System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone),',
'    37,',
'    ''Tincidunt. Vestibulum.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    61,',
'    20,',
'    ''Plant Management'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    7,',
'    ''Semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, di'
||'ctum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    62,',
'    19,',
'    ''Lost Program'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    42,',
'    ''Consectetur mi venenatis nec. Donec convallis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    63,',
'    11,',
'    ''IOT Rebalance'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    11,',
'    ''Vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Ph'
||'asellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    64,',
'    5,',
'    ''Clinical Trial Test Review'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-11) as timestamp with local time zone),',
'    92,',
'    ''Diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lo'
||'rem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    65,',
'    14,',
'    ''Aircraft Safety Study'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    65,',
'    ''Porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    66,',
'    9,',
'    ''Platform Management'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    31,',
'    ''Et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus effic'
||'itur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    67,',
'    12,',
'    ''3D Printing System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    97,',
'    ''Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi'
||' venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    68,',
'    6,',
'    ''Checklist Management System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    99,',
'    ''Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    69,',
'    12,',
'    ''Medium-Haul Optimization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-11) as timestamp with local time zone),',
'    13,',
'    ''Pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    70,',
'    10,',
'    ''MOOC Optimization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    65,',
'    ''Commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis conse'
||'ctetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Dui'
||'s et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget,.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    71,',
'    1,',
'    ''Best Match Sub System Upgrade'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    52,',
'    ''Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    72,',
'    19,',
'    ''Digital Cartography System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    67,',
'    ''Sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet '
||'ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    73,',
'    18,',
'    ''Catering System Management'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    34,',
'    ''Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    74,',
'    15,',
'    ''Low Code Standardization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    14,',
'    ''Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Cur'
||'ae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi m'
||'aximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    75,',
'    15,',
'    ''Outage Modernization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    67,',
'    ''Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet '
||'massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    76,',
'    8,',
'    ''Remote Employee ISP Management'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    56,',
'    ''Id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet,.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    77,',
'    4,',
'    ''Project Infrastructure'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    83,',
'    ''Imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec c'
||'onvallis sollicitudin elementum. Nulla facilisi. In.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    78,',
'    14,',
'    ''Overseas Migration'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    98,',
'    ''Consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut '
||'metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien se'
||'m, volutpat vitae luctus vitae, pretium a ligula. Donec eget lectus.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    79,',
'    6,',
'    ''Accessibility Testing Automation'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    85,',
'    ''Placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Q'
||'uisque tortor odio, feugiat eget sagittisvel, pretium.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    80,',
'    12,',
'    ''New Hire Training'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    4,',
'    ''Mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et'))
);
null;
end;
/
begin
wwv_flow_api.append_to_install_script(
 p_id=>wwv_flow_api.id(18234461899642387)
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
' malesuada fames.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    81,',
'    7,',
'    ''Zero Acquisition'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    94,',
'    ''Elementum sodales. Proin sit amet massa eu lorem commodo.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    82,',
'    20,',
'    ''XLIF Translations'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    40,',
'    ''Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et '
||'commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    83,',
'    2,',
'    ''Employee Profile Management'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    41,',
'    ''In faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget '
||'malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh s'
||'apien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium a ligula. Donec eget lectus malesuada, scelerisque lorem.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    84,',
'    10,',
'    ''Maximum Availability Optimization'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-11) as timestamp with local time zone),',
'    61,',
'    ''Ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus '
||'et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur '
||'ipsum tellus, quis posuere mi.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    85,',
'    1,',
'    ''IOT Data Mart'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    23,',
'    ''Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate pl'
||'acerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    86,',
'    18,',
'    ''Continuous Delivery System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    68,',
'    ''Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi.'
||' In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravi'
||'da ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus vitae, pretium.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    87,',
'    16,',
'    ''Competitive Tracking'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    35,',
'    ''Diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lo'
||'rem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec'
||'. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    88,',
'    17,',
'    ''Social Consolidation'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-6) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    65,',
'    ''Risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin vive'
||'rra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagit'
||'tisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    89,',
'    20,',
'    ''CVE H12 System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    17,',
'    ''Porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin eleme'
||'ntum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    90,',
'    2,',
'    ''Blockchain System Rollout'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-14) as timestamp with local time zone),',
'    29,',
'    ''Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feu'
||'giat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    91,',
'    10,',
'    ''CMOS Training'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-17) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    49,',
'    ''Amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    92,',
'    3,',
'    ''Machine Translation Evaluation'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-3) as timestamp with local time zone),',
'    53,',
'    ''Elit, vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit'
||' amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus portti'
||'tor.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    93,',
'    1,',
'    ''Data Compression Cost Savings'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-21) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    67,',
'    ''Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    94,',
'    3,',
'    ''Microservices Deployment'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-11) as timestamp with local time zone),',
'    31,',
'    ''Vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Ph'
||'asellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra laciniale'
||'ctus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    95,',
'    19,',
'    ''Holiday Reporting System'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    81,',
'    ''Ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vu'
||'lputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae'
||'. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    96,',
'    13,',
'    ''G444F Database Consolidation'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    6,',
'    ''Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    97,',
'    12,',
'    ''Essential Systems Review'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    44,',
'    ''Massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    98,',
'    8,',
'    ''System Instrumentation'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-2) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    47,',
'    ''Amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus.'',',
'    ''N''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    99,',
'    16,',
'    ''Claim Fraud Management'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-8) as timestamp with local time zone),',
'    77,',
'    ''Mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis '
||'et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat '
||'vitae luctus vitae, pretium a ligula. Donec eget lectus malesuada, scelerisque lorem in,sollicitudin enim. Aenean.'',',
'    ''Y''',
');',
'',
'insert into hol_tasks (',
'    id,',
'    project_id,',
'    name,',
'    assignee,',
'    milestone_id,',
'    start_date,',
'    end_date,',
'    cost,',
'    description,',
'    is_complete_yn',
') values (',
'    100,',
'    2,',
'    ''Project Initiative'',',
'    1,',
'    1,',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    cast(add_months(systimestamp,-13) as timestamp with local time zone),',
'    55,',
'    ''Lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagi'
||'ttisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing el'
||'it.Vivamus sapien sem, volutpat vitae luctus vitae, pretium a ligula. Donec eget lectus malesuada, scelerisque lorem in,sollicitudin enim. Aenean.'',',
'    ''N''',
');',
'',
'commit;',
'-- load data',
' ',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    1,',
'    3,',
'    ''Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique.'',',
'    1,',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    ''Vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    2,',
'    19,',
'    ''Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor.'',',
'    1,',
'    cast(add_months(systimestamp,-1) as timestamp with local time zone),',
'    ''Et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus effic'
||'itur ipsum.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    3,',
'    27,',
'    ''Nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.'',',
'    1,',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    ''Massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    4,',
'    16,',
'    ''Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate pl'
||'acerat pel'',',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    ''Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    5,',
'    32,',
'    ''Porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac.'',',
'    1,',
'    cast(add_months(systimestamp,-7) as timestamp with local time zone),',
'    ''Commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    6,',
'    42,',
'    ''Risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales.'',',
'    1,',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    ''Ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    7,',
'    46,',
'    ''Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamu'
||'s efficitu'',',
'    1,',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    ''Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vest'
||'ibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    8,',
'    78,',
'    ''Vestibulum ante ipsumprimis in.'',',
'    1,',
'    cast(add_months(systimestamp,-10) as timestamp with local time zone),',
'    ''Vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectu'
||'s, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    9,',
'    58,',
'    ''Et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in'
||' faucibus '',',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    ''Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    10,',
'    96,',
'    ''Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec.'',',
'    1,',
'    cast(add_months(systimestamp,-5) as timestamp with local time zone),',
'    ''Vestibulum ante ipsumprimis in.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    11,',
'    62,',
'    ''Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.'',',
'    1,',
'    cast(add_months(systimestamp,-9) as timestamp with local time zone),',
'    ''Elementum sodales. Proin.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    12,',
'    48,',
'    ''Ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo.'',',
'    1,',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    ''Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    13,',
'    15,',
'    ''Tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pe'
||'llentesque'',',
'    1,',
'    cast(add_months(systimestamp,-15) as timestamp with local time zone),',
'    ''Aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    14,',
'    68,',
'    ''Volutpat risus.Phasellus vitae ligula commodo, dictum.'',',
'    1,',
'    cast(add_months(systimestamp,-18) as timestamp with local time zone),',
'    ''Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tel'
||'lus. In sollicitudin nisi.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    15,',
'    2,',
'    ''Vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.'',',
'    1,',
'    cast(add_months(systimestamp,-4) as timestamp with local time zone),',
'    ''Eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    16,',
'    36,',
'    ''Ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blan'
||'dit leoege'',',
'    1,',
'    cast(add_months(systimestamp,-12) as timestamp with local time zone),',
'    ''Vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximu'
||'s vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    17,',
'    10,',
'    ''In faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget '
||'malesuada.'',',
'    1,',
'    cast(add_months(systimestamp,-20) as timestamp with local time zone),',
'    ''Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vest'
||'ibulum tellus. In sollicitudin.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    18,',
'    34,',
'    ''Rhoncus non,molestie sit amet lectus.'',',
'    1,',
'    cast(add_months(systimestamp,-19) as timestamp with local time zone),',
'    ''Lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    19,',
'    86,',
'    ''Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. V'
||'ivamus eff'',',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    ''Eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lo'
||'rem commodo.''',
');',
'',
'insert into hol_to_dos (',
'    id,',
'    task_id,',
'    todo,',
'    assingee,',
'    due_date,',
'    details',
') values (',
'    20,',
'    86,',
'    ''Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin.'',',
'    1,',
'    cast(add_months(systimestamp,-16) as timestamp with local time zone),',
'    ''Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi '
||'maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi.''',
');',
'',
'commit;',
'-- load data',
' ',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    1,',
'    17,',
'    ''aaac.girard.com'',',
'    ''Expense Imaging Upgrade'',',
'    ''Semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante '))
);
null;
end;
/
begin
wwv_flow_api.append_to_install_script(
 p_id=>wwv_flow_api.id(18234461899642387)
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    2,',
'    35,',
'    ''aaaf.arrowpoint.gov'',',
'    ''Platform Modernization'',',
'    ''Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Cur'
||'ae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi m'
||'aximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    3,',
'    55,',
'    ''aaaf.mabel.gov'',',
'    ''EMEA Sales Program'',',
'    ''Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    4,',
'    73,',
'    ''aaag.campodonico.gov'',',
'    ''System Breach Analysis'',',
'    ''Amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interd'
||'um et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in f'
||'aucibus orci luctus et ultrices posuere cubilia Curae; Proin.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    5,',
'    21,',
'    ''aaab.bourideys.com'',',
'    ''Supplier Caching'',',
'    ''Porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vi'
||'tae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis'
||' consectetur mi venenatis nec. Donec.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    6,',
'    71,',
'    ''aaac.pachuca.com'',',
'    ''Dynamic Scaling Deployment'',',
'    ''Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem s'
||'it amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Don'
||'ec convallis sollicitudin.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    7,',
'    35,',
'    ''aaab.aberteifi.com'',',
'    ''Micro Processor Upgrade'',',
'    ''Porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin eleme'
||'ntum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    8,',
'    66,',
'    ''aaag.niaux.gov'',',
'    ''Business Intelligence Module'',',
'    ''Aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum '
||'primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posu'
||'ere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    9,',
'    75,',
'    ''aaad.anieves.com'',',
'    ''Mobile First Strategy'',',
'    ''Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tel'
||'lus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis.''',
');',
'',
'insert into hol_links (',
'    id,',
'    task_id,',
'    url,',
'    name,',
'    description',
') values (',
'    10,',
'    6,',
'    ''aaab.aniches.com'',',
'    ''EPA Impact Study'',',
'    ''Nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo ar'
||'cu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Vivamus sapien sem, volutpat vitae luctus '
||'vitae, pretium a ligula. Donec eget lectus malesuada,.''',
');',
'',
'commit;',
''))
);
null;
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, true));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
