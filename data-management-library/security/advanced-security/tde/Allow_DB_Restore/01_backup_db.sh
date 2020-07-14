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
BACKUP_FILE=/u01/${ORACLE_SID}_pre-tde.tar

if [[ -f "$BACKUP_FILE" ]]; then
   echo "$BACKUP_FILE exists. Will not backup again. "
   exit 1
fi

echo
echo "The easiest way to ensure we have a copy of the database is to make a cold backup."
echo "We do this because we aren't in archive log mode."
echo


echo "First, backup the spfile to a pfile..."

sqlplus -s / as sysdba <<EOF
--
create pfile='$ORACLE_HOME/dbs/pfile_pre-tde.ora' from spfile;
--
EOF


echo "Shutdown the DB..."

sqlplus -s / as sysdba <<EOF
shutdown immediate;
exit
EOF

echo 
echo "Create a copy of the data files directory..."
echo
tar cvf $BACKUP_FILE $DATA_DIR

echo
echo "Check the tar size..."
echo
du -sh $BACKUP_FILE

echo 
echo "Start the DB..."
echo
sqlplus -s / as sysdba <<EOF
startup;
exit
EOF

