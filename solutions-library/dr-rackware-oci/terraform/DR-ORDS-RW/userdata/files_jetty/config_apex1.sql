set ver off
alter user apex_public_user identified by "&1" account unlock;
begin
    apex_util.set_security_group_id( 10 );
    apex_util.create_user(
        p_user_name => 'ADMIN',
        p_email_address => 'change@later',
        p_web_password => '&1',
        p_developer_privs => 'ADMIN' );
    apex_util.set_security_group_id( null );
    commit;
end;
/
exit
