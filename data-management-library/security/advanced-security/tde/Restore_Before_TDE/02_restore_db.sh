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

# this is the file we are going to create
RESTORE_FILE=/u01/${ORACLE_SID}_pre-tde.tar

if [[ ! -f "$RESTORE_FILE" ]]; then
   echo "$RESTORE_FILE does not exist. cannot restore."
   exit 1
fi

echo
echo "Because we have a \"cold backup\" of the database we will restore from it."
echo

echo "Shutdown the DB..."
echo
sqlplus -s / as sysdba <<EOF
shutdown immediate;
exit;
EOF

echo
echo "Restore the data files directory..."
echo
mv $DATA_DIR ${DATA_DIR}_post-tde
mkdir $DATA_DIR
tar xvf $RESTORE_FILE --directory /

echo 
echo "Verify the files exist..."
echo
find $DATA_DIR

