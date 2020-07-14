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

if [[ -z $WALLET_DIR ]]; then

 echo 
 echo 
 echo "The WALLET_DIR variable is empty. Your profile is not setup properly."
 echo "The easiest fix is to exit and execute 'sudo su - oracle' again to resource the environment variables."
 echo "Press return to exit."
 echo
 exit 1
fi

echo
echo "Use the latest TDE parameters instead of sqlnet.ora to locate the wallet directory..."
echo

HAS_WALLET_ENTRY=`grep ENCRYPTION_WALLET_LOCATION ${ORACLE_HOME}/network/admin/sqlnet.ora | wc -l`
if [ $HAS_WALLET_ENTRY -gt 0 ]; then
 echo
 echo "The sqlnet.ora has an old parameter in it. We are going to remove it first."
 echo
 cp ${ORACLE_HOME}/network/admin/sqlnet.ora ${ORACLE_HOME}/network/admin/sqlnet.ora.has_wallet_location

 # We need to delete these lines.
 # ENCRYPTION_WALLET_LOCATION=
 #  (SOURCE=(METHOD=FILE)(METHOD_DATA=
 #  (DIRECTORY=$ORACLE_BASE/admin/$ORACLE_SID/wallet/)))

 sed -i '/ENCRYPTION_WALLET_LOCATION/d' ${ORACLE_HOME}/network/admin/sqlnet.ora
 sed -i '/METHOD_DATA/d' ${ORACLE_HOME}/network/admin/sqlnet.ora
 sed -i '/\DIRECTORY\=/d' ${ORACLE_HOME}/network/admin/sqlnet.ora

 echo
 echo "Let's view the sqlnet.ora now..."
 echo
 cat ${ORACLE_HOME}/network/admin/sqlnet.ora

fi

echo "These parameters include setting:"
echo " wallet_root = ${WALLET_DIR}"
echo " tde_configuration = \"keystore_configuration=FILE\" "
echo


sqlplus -s / as sysdba <<EOF
--
alter system set wallet_root = '${WALLET_DIR}' scope= spfile;
--
shutdown immediate;
--
startup;
--
alter system set "_tablespace_encryption_default_algorithm" = 'AES256' scope = both;
alter system set tde_configuration = "keystore_configuration=FILE" scope=BOTH;
--
show parameter wallet_root;
show parameter tde_configuration;
EOF
