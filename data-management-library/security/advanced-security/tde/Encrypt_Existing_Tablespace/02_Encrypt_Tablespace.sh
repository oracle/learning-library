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

echo
echo "This script will convert the existing EMPDATA_PROD tablespace"
echo "to an encrypted tablespace."
echo

WALLET_FILE=$WALLET_DIR/tde/ewallet.p12


if [ ! -f ${WALLET_FILE} ]; then

 echo "You do not have a software keystore."
 echo "This means one of the following have happened: "
 echo " * You did not follow the steps to create the keystore and master key."
 echo " * You have migrated to an Online Master Key and deleted the wallet, so these steps must be performed differently."
 echo " * You deleted the ewallet.p12 file and the DB no longer has access to it. "
 echo
 echo "Please make sure you follow the steps in the documentation, the README.md file"
 echo
 exit 1
fi

$ORACLE_HOME/bin/sqlplus -s '/ as sysdba'<<EOF

conn sys/Oracle123@pdb1 as sysdba

set lines 110
set pages 9999
column tablespace_name format a25
column encrypted format a10
column file_name format a45
column online_status format a15

select tablespace_name, encrypted from dba_tablespaces where tablespace_name = 'EMPDATA_PROD';


column pdb_name format a20
column tablespace_name format a30
column algorithm format a10
select a.name pdb_name, b.name tablespace_name, c.ENCRYPTIONALG algorithm
  from v\$pdbs a, v\$tablespace b, v\$encrypted_tablespaces c
  where a.con_id = b.con_id
    and b.con_id = c.con_id
    and b.ts# = c.ts#;

select file_name, online_status from dba_data_files where tablespace_name = 'EMPDATA_PROD';

--ALTER TABLESPACE EMPDATA_PROD ENCRYPTION ONLINE USING 'AES256' ENCRYPT FILE_NAME_CONVERT = ('empdata_prod','empdata_prod_enc');
ALTER TABLESPACE EMPDATA_PROD ENCRYPTION ONLINE USING 'AES256' ENCRYPT;

select tablespace_name, encrypted from dba_tablespaces where tablespace_name = 'EMPDATA_PROD';

column pdb_name format a20
column tablespace_name format a30
select a.name pdb_name, b.name tablespace_name, c.ENCRYPTIONALG algorithm
  from v\$pdbs a, v\$tablespace b, v\$encrypted_tablespaces c
  where a.con_id = b.con_id
    and b.con_id = c.con_id
    and b.ts# = c.ts#;


select file_name, online_status from dba_data_files where tablespace_name = 'EMPDATA_PROD';
exit;
EOF

#read -p "Press enter to close"

