# Migrating the Application Database

## Introduction

This lab walks you through the steps to migrate the 'on-premises' application database to the database provisioned on OCI using Datapump.

Estimated Lab Time: 10 min

### About Product/Technology

- DataPump is a tool that is part of the oracle Database set of utilities.
- DataPump export function creates a DDL + data dump of the user schema.
- DataPump import function imports the data into the database.

In this workshop we will be using wrapper scripts to export, move the data to the destination and import to complete a full migration.

### Objectives

In this lab you will:

- Get shell access to the 'on-premises' database
- Use a datapump script to export the database schema to migrate
- Edit the datapump import script with the information collected in the DB provisioning lab
- Run a datapump import script to migrate the database schema to OCI

### Prerequisites

To run this lab you need:

- To have provisioned the on-premises demo environment that includes the source database to migrate
- To have provisioned the target database on OCI
- To have gathered information about the passthrough-server to the DB, and the DB node IP and domain name which is part of the connection string.

## **STEP 1:** Get a shell inside the 'on-premises' database instance

### If you used the Docker environment:

1. You should already be inside the DB container from the SSH key creation step. If not, use: 

      ```
      <copy>
      docker exec -it weblogic-to-oci_oracledb_1 /bin/bash
      </copy>
      ```

2. Get into the `/datapump` folder:

      ```
      <copy>
      cd ~/datapump
      </copy>
      ```


### If you used the Workshop image:

1. You should already be logged into the instance and switched to the `oracle` user. If not use:

      ```bash
      ssh opc@<public-ip>
      ```
      then 
      ```bash
      sudo su - oracle
      ```

2. Get into the `/datapump` folder:

      ```
      <copy>
      cd ~/datapump
      </copy>
      ```

      The script itself is commented to explain what it does.

      It sets up the directory to backup to, and uses datapump `expdp` export command to dump the `RIDERS` schema, which is the schema the application depends on.

<details><summary>View the <code>datapump_export.sh</code> script</summary>

```bash
EXPORT_DB_DIRNAME=export

# all other variables are from the local environment

# clear the folder and recreate
rm -rf ~/datapump/export && mkdir -p ~/datapump/export

# drop directory if it exists
echo "DROP DIRECTORY ${EXPORT_DB_DIRNAME};" | sqlplus system/${DB_PWD}@${DB_HOST}:${DB_PORT}/${DB_PDB}.${DB_DOMAIN}

# create a directory object in the DB for export with datapump, pointing to the folder created above
echo "CREATE DIRECTORY ${EXPORT_DB_DIRNAME} AS '/home/oracle/datapump/export/';" | sqlplus system/${DB_PWD}@${DB_HOST}:${DB_PORT}/${DB_PDB}.${DB_DOMAIN}

# export the schema 'RIDERS' with datapump, which is our user schema with the Tour de France Riders data
expdp system/${DB_PWD}@${DB_HOST}:${DB_PORT}/${DB_PDB}.${DB_DOMAIN} schemas=RIDERS DIRECTORY=${EXPORT_DB_DIRNAME}
```
</details>

## **STEP 3:** Export the Source Database

1. Run the `datapump_export.sh` script:

      ```
      <copy>
      ./datapump_export.sh
      </copy>
      ```

      The output will look like
        [](./images/migrate-db-1.png)
        <img src="./images/migrate-db-1.png" width="100%">



## **STEP 2:** Edit the `datapump_import.sh` script

Once the schema and data was exported, we'll import it into the OCI DBaaS database.

First, we'll need to edit the `datapump_import.sh` script to target the OCI database.

<details><summary>View the <code>datapump_import.sh</code> script</summary>

```bash
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
```
</details>

1. Open the script in an editor. We'll use the popular `nano` editor:

      ```
      <copy>
      nano datapump_import.sh
      </copy>
      ```

2. Enter the `BASTION_IP`

     The `BASTION_IP` is the **public IP** of the WebLogic Admin Server that can be found in the output of the job that deployed the WebLogic stack, as part of the WebLogic Admin Server console URL.

     Find it in **Resource Manager -> Stack -> stack details -> job details -> Outputs**

       <img src="./images/migrate-db-2.png" width="100%">


3. Enter the `TARGET_DB_HOST` **private IP address**
 
     This IP address was gathered from the Database System details, under **Database System -> details -> Nodes**

       <img src="./images/provision-db-26-nodeip.png" width="100%">


4. Enter the `TARGET_DB_DOMAIN` name, from the DB connection string. 

      If you followed the name conventions, it should be `nonjrfdbsubnet.nonjrfvcn.oraclevcn.com` if you followed the defaults in this lab.

      <img src="./images/provision-db-27-connection2.png" width="70%">


## **STEP 4:** Import the data into the target database on OCI

1. Run the `datapump_import.sh` script you edited at the previous step

      ```bash
      <copy>
      ./datapump_import.sh
      </copy>
      ```

2. You will be prompted to continue connection twice. Type `yes` each time to proceed.

The import script runs in 4 phases:

- It copies the files over to the OCI DB node
- then runs the `impdp` import command once. 
You may notice this 1st try imports the schema but fails at importing the data, because the user `RIDERS` does not have a quota on the local `USERS` tablespace. 
- the script then edits the `RIDERS` user tablespace quota
- and re-runs the `impdb` command that now succeeds at importing the data, but will show an error related to the user `RIDERS` already existing. This is normal.

The database is now migrated to OCI.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
