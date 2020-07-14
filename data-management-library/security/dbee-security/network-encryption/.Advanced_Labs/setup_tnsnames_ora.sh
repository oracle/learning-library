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

tns_file=$ORACLE_HOME/network/admin/tnsnames.ora

cp ${tns_file} ${tns_file}.orig.noencrypt

if [ `grep PDB1.TLS ${tns_file} | wc -l` -eq 0 ]; then

echo
echo "add the PDB1.TLS to the tnsnames.ora"
echo

echo "
PDB1.TLS =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = dbsec-lab)(PORT = 1523))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = pdb1)
    )
  ) " >> ${tns_file}


echo 
echo "Here is what it looks like now:"
echo
cat ${tns_file}

else

echo
echo "there is already a PDB1.TLS entry in the tnsnames.ora"
echo

fi
