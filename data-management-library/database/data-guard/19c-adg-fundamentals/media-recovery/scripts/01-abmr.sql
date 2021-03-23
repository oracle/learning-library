set pages 999 lines 200;
set echo on;
set feed on;
Col owner format a20;
var rid varchar2(25);
col segment_name format a20;

drop tablespace corruptiontest including contents and datafiles;
create tablespace corruptiontest datafile '/home/oracle/corruptiontest01.dbf' size 1m;
create table will_be_corrupted(myfield varchar2(50)) tablespace corruptiontest;
insert into will_be_corrupted(myfield) values ('This will have a problem') returning rowid into :rid;
print
Commit;
Alter system checkpoint;
select * from will_be_corrupted;
--select owner, segment_name,tablespace_name,file_id,block_id from dba_extents where segment_name='WILL_BE_CORRUPTED'; -- will be segment id
select dbms_rowid.ROWID_BLOCK_NUMBER(ROWID, 'SMALLFILE') FROM will_be_corrupted where myfield='This will have a problem';

