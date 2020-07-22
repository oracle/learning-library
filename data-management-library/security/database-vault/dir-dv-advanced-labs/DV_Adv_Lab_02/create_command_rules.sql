set echo on
spool 02_Create_Command_Rules_and_Rule_Sets.out


exec dvsys.dbms_macadm.add_auth_to_realm(realm_name=>'EMPLOYEESEARCH_DATA',grantee=>'dba_debra');
exec dvsys.dbms_macadm.add_auth_to_realm(realm_name=>'EMPLOYEESEARCH_DATA',grantee=>'dba_nicole');

exec DVSYS.DBMS_MACADM.CREATE_RULE_SET(rule_set_name => 'Restrict_DBA_Users', description => 'Protects Senior and Junior DBA activities', enabled => 'Y', eval_options => 2, audit_options => 1, fail_options => 1, fail_message => 'SECURITY VIOLATION: adhoc access not allowed. Your manager will be notified', fail_code => '-20103', handler_options => 0, handler => '');

exec DVSYS.DBMS_MACADM.CREATE_RULE(rule_name => 'Restrict_DBA_JR_Only_Rule', rule_expr => 'dvf.f$session_user=''DBA_NICOLE'' and dvf.f$client_ip is null and to_char(sysdate,''HH24'') between ''08'' and ''16'' and to_char(sysdate,''d'') between ''2'' and ''6''');

exec DVSYS.DBMS_MACADM.CREATE_RULE(rule_name => 'Only_DBA_SR_Rule', rule_expr => 'dvf.f$session_user=''DBA_DEBRA''');

exec DVSYS.DBMS_MACADM.ADD_RULE_TO_RULE_SET(rule_set_name => 'Restrict_DBA_Users', rule_name => 'Restrict_DBA_JR_Only_Rule', rule_order => '1', enabled => 'Y');
exec DVSYS.DBMS_MACADM.ADD_RULE_TO_RULE_SET(rule_set_name => 'Restrict_DBA_Users', rule_name => 'Only_DBA_SR_Rule', rule_order => 2, enabled => 'Y');

exec DVSYS.DBMS_MACADM.CREATE_COMMAND_RULE(command=> 'TRUNCATE TABLE', rule_set_name => 'Restrict_DBA_Users', object_owner => 'EMPLOYEESEARCH_PROD', object_name => '%',enabled => 'Y');

exit;
