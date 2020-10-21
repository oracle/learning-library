declare
    l_acl_path varchar2(4000);
    l_apex_schema varchar2(100);
begin
    for c1 in (select schema
                 from sys.dba_registry
                where comp_id = 'APEX') loop
        l_apex_schema := c1.schema;
    end loop;
    sys.dbms_network_acl_admin.append_host_ace(
        host => '*',
        ace => xs$ace_type(privilege_list => xs$name_list('connect'),
        principal_name => l_apex_schema,
        principal_type => xs_acl.ptype_db));
    commit;
end;
/
exit
