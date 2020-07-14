#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1


# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null


#$DBSEC_HOME/workshops/dbsec/network_encryption

sqlnet_file=$ORACLE_HOME/network/admin/sqlnet.ora

cp ${sqlnet_file} ${sqlnet_file}.orig.noencrypt

if [ `grep ^WALLET_LOCATION ${sqlnet_file} | wc -l` -eq 0 ]; then

echo
echo "add the wallet location to the sqlnet.ora"
echo

echo "
WALLET_LOCATION =
   (SOURCE =
     (METHOD = FILE)
     (METHOD_DATA =
       (DIRECTORY = /home/oracle/DBSecLab/workshops/Database_Security_Labs/Network_Encryption/Advanced_Labs/CA)
     )
   )

SQLNET.AUTHENTICATION_SERVICES = (TCPS,NTS,BEQ)
SSL_CLIENT_AUTHENTICATION = FALSE
SSL_CIPHER_SUITES = (SSL_RSA_WITH_AES_256_CBC_SHA, SSL_RSA_WITH_3DES_EDE_CBC_SHA)" >> $ORACLE_HOME/network/admin/sqlnet.ora

echo 
echo "Here is what it looks like now:"
echo
cat ${sqlnet_file}

else

echo
echo "there is already a WALLET_LOCATION in the sqlnet.ora"
echo

fi
