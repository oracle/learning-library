
BASTION_IP=
TARGET_DB_HOST=
TARGET_DB_PORT=1521
TARGET_DB_PDB=pdb
TARGET_DB_DOMAIN=nonjrfdbsubnet.nonjrfvcn.oraclevcn.com
TARGET_DB_USER=system
TARGET_DB_PWD=YpdCNR6nua4nahj8__
DB_LOCAL_PORT=1523

echo "Removing old files if they exist..."
ssh -J opc@${BASTION_IP} opc@${TARGET_DB_HOST} "[[ -d '/home/opc/export' ]] && sudo rm -rf /home/opc/export"

echo "Move the export files over to the DB HOST..."
scp -o ProxyCommand="ssh -W %h:%p opc@${BASTION_IP}" -r ~/datapump/export opc@${TARGET_DB_HOST}:/home/opc/export

echo "Changing ownership of the files..."
ssh -J opc@${BASTION_IP} opc@${TARGET_DB_HOST} "sudo chown -R oracle:oinstall /home/opc/export && sudo rm -rf /home/oracle/export && sudo mv /home/opc/export /home/oracle/"

# create ssh tunnel to DB port to talk to the DB from local
ssh -M -S sql-socket -fnNT -L ${DB_LOCAL_PORT}:${TARGET_DB_HOST}:${TARGET_DB_PORT} opc@${BASTION_IP} cat -
ssh -S sql-socket -O check opc@${BASTION_IP}

echo "Creating import dir on OCI DB host..."
IMPORT_DIRNAME=import
echo "DROP DIRECTORY ${IMPORT_DIRNAME};" | sqlplus system/${TARGET_DB_PWD}@localhost:${DB_LOCAL_PORT}/${TARGET_DB_PDB}.${TARGET_DB_DOMAIN}
echo "CREATE DIRECTORY ${IMPORT_DIRNAME} AS '/home/oracle/export/';" | sqlplus system/${TARGET_DB_PWD}@localhost:${DB_LOCAL_PORT}/${TARGET_DB_PDB}.${TARGET_DB_DOMAIN}

echo "Import Datapump dump..."
impdp system/${TARGET_DB_PWD}@localhost:${DB_LOCAL_PORT}/${TARGET_DB_PDB}.${TARGET_DB_DOMAIN} DIRECTORY=${IMPORT_DIRNAME} schemas=RIDERS
# note: this first attempt will fail because the user doesn't have quota on the tablespace USERS 

# alter the user RIDERS to give it quota on USERS tablespace
echo "ALTER USER RIDERS QUOTA 100M ON USERS;" | sqlplus system/${TARGET_DB_PWD}@localhost:${DB_LOCAL_PORT}/${TARGET_DB_PDB}.${TARGET_DB_DOMAIN}

# then run the import again
echo "Import Datapump dump..."
impdp system/${TARGET_DB_PWD}@localhost:${DB_LOCAL_PORT}/${TARGET_DB_PDB}.${TARGET_DB_DOMAIN} DIRECTORY=${IMPORT_DIRNAME} schemas=RIDERS

echo "Closing ssh tunnel..."
# force kill the tunnel as the exit function doesn't always clean it up properly
ps aux | grep ssh | grep -v "grep" | awk '{print $2}' | xargs kill -9
rm sql-socket

echo "Done!"
