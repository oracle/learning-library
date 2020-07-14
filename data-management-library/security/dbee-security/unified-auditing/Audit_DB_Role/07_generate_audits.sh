#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

sqlplus -s sys/${DBUSR_PWD}@${PDB_NAME} as sysdba << EOF
prompt
show con_name
show user
--
prompt
prompt create tablespace test datafile '${DATA_DIR}/${PDB_NAME}/test01.dbf' size 10m;
create tablespace test datafile '${DATA_DIR}/${PDB_NAME}/test01.dbf' size 10m;
--
prompt drop tablespace test including contents and datafiles;
drop tablespace test including contents and datafiles;
--
prompt connect dba_junior/${DBUSR_PWD}@${PDB_NAME}
connect dba_junior/${DBUSR_PWD}@${PDB_NAME}
prompt alter system set job_queue_processes=200;
alter system set job_queue_processes=200;
--
alter system set job_queue_processes=100;
prompt alter system set job_queue_processes=100;
--
prompt connect sys/${DBUSR_PWD}@${PDB_NAME} as sysdba
connect sys/${DBUSR_PWD}@${PDB_NAME} as sysdba
--
prompt exec SYS.DBMS_AUDIT_MGMT.FLUSH_UNIFIED_AUDIT_TRAIL;
exec SYS.DBMS_AUDIT_MGMT.FLUSH_UNIFIED_AUDIT_TRAIL;
--
prompt
EOF
