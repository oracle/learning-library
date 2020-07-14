show parameter max_string_size
alter system set max_string_size=extended scope=spfile;
shutdown immediate
startup upgrade
@?/rdbms/admin/utl32k.sql
shutdown immediate
startup
show parameter max_string_size
exit
