echo $ORACLE_HOME
cd $ORACLE_HOME/bin
./lsnrctl start
./sqlplus -silent / as sysdba <<EOF
startup
alter pluggable database all open read write;
select open_mode from v\$database;
exit
EOF
./lsnrctl status


