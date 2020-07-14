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

lsnr_file=$ORACLE_HOME/network/admin/listener.ora

cp ${lsnr_file} ${lsnr_file}.orig.noencrypt

if [ `grep TCPS ${lsnr_file} | wc -l` -eq 0 ]; then

echo
echo "add the wallet location to the lsnr_file.ora"
echo

sed -i '/(PROTOCOL = TCP)/a      (ADDRESS = (PROTOCOL = TCPS)(HOST = dbsec-lab)(PORT = 1523))' ${lsnr_file}
#      (ADDRESS = (PROTOCOL = TCPS)(HOST = dbsec-lab)(PORT = 1523))

echo 
echo "Here is what it looks like now:"
echo
cat ${lsnr_file}

else

echo
echo "there is already a TCPS in the lsnr_file.ora"
echo

fi
