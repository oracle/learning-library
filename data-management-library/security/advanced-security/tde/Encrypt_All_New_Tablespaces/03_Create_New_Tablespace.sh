#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo "Create a new tablespace to show it was encrypted..."
echo

sqlplus -s / as sysdba <<EOF

alter session set container=pdb1;

set lines 140
set pages 9999

column pdb_name format a12
column tablespace_name format a25
column algorithm format a10
column encrypted format a10
select a.name pdb_name, b.name tablespace_name, c.ENCRYPTIONALG algorithm 
  from v\$containers a, v\$tablespace b, v\$encrypted_tablespaces c
  where a.con_id = b.con_id
    and b.con_id = c.con_id
    and b.ts# = c.ts#;

prompt create tablespace TEST datafile '${DATA_DIR}/test.dbf' size 15m;
create tablespace TEST datafile '${DATA_DIR}/test.dbf' size 15m;
--
prompt create table test_objects tablespace TEST as select * from dba_objects;
create table test_objects tablespace TEST as select * from dba_objects;
--
prompt select tablespace_name, encrypted from dba_tablespaces where tablespace_name = 'TEST';
select tablespace_name, encrypted from dba_tablespaces where tablespace_name = 'TEST';

select a.name pdb_name, b.name tablespace_name, c.ENCRYPTIONALG algorithm 
  from v\$containers a, v\$tablespace b, v\$encrypted_tablespaces c
  where a.con_id = b.con_id
    and b.con_id = c.con_id
    and b.ts# = c.ts#;

column key_id format a35
column pdb_name format a12
column CREATION_TIME format a29
column tag format a45
select a.name pdb_name, b.key_id, substr(b.CREATION_TIME,1,29) creation_time, b.tag
  from v\$containers a, v\$encryption_keys b
  where a.con_id = b.con_id;

prompt
prompt View the output of strings against test.dbf data file
!ls -al ${DATA_DIR}/test.dbf
!strings ${DATA_DIR}/test.dbf | head -30

prompt
prompt drop tablespace TEST including contents and datafiles;
drop tablespace TEST including contents and datafiles;
EOF
