#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

sqlplus -s sys/Oracle123@pdb1 as sysdba << EOF
create tablespace test datafile '/tmp/test01.dbf' size 10m;
drop tablespace test including contents and datafiles;

connect dba_junior/Oracle123@pdb1
alter system set job_queue_processes=200;
alter system set job_queue_processes=100;

connect sys/Oracle123@pdb1 as sysdba
exec SYS.DBMS_AUDIT_MGMT.FLUSH_UNIFIED_AUDIT_TRAIL;

EOF
