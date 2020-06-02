#!/bin/bash

echo "waiting for DB to be ready..."
cat << EOF > connect.sql
whenever sqlerror exit;
conn sys/Oradoc_db1@${DB_HOST}:1521/${DB_SID}.${DB_DOMAIN} AS SYSDBA;
EOF

count=200;
while [[ "$(echo @connect.sql | sqlplus /nolog | grep ERROR | wc -l)" != "0" ]]; do
    printf '.';
    sleep 2;
    (( count-=1 ))
done

cat << EOF > /home/oracle/sql/changePassword.sql
alter session set container=CDB$ROOT;
alter user system identified by ${DB_PWD} container=all;
quit;
EOF

sqlplus sys/Oradoc_db1@${DB_HOST}:1521/${DB_SID}.${DB_DOMAIN} AS SYSDBA @/home/oracle/sql/changePassword.sql
sqlplus system/${DB_PWD}@${DB_HOST}:1521/${DB_PDB}.${DB_DOMAIN} @/home/oracle/sql/createSchema.sql
