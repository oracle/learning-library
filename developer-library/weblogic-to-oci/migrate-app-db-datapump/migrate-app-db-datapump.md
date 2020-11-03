# Migrating the Application Database

## Introduction

This lab walks you through the steps to migrate the 'on-premises' application database to the database provisioned on OCI using Datapump.

Estimated Lab Time: 10 minutes

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

## **STEP 2:** Export the Source Database

1. Run the `datapump_export.sh` script:

      ```
      <copy>
      ./datapump_export.sh
      </copy>
      ```

      The output will look like
        ![](./images/migrate-db-1.png)



## **STEP 3:** Edit the `datapump_import.sh` script

Once the schema and data are exported, we'll import it into the OCI DBaaS database.

First, we'll need to edit the `datapump_import.sh` script to target the OCI database found in the datapump folder.

1. Open the script in an editor. We'll use the popular `nano` editor:

      ```
      <copy>
      nano datapump_import.sh
      </copy>
      ```

2. Enter the `BASTION_IP`

     If you provisioned in a *Private Subnet* the `BASTION_IP` is the **public IP** of the Bastion Instance.
     
     If you provisioned in a *Public Subnet* the `BASTION_IP` is the **public IP** of the WebLogic Admin Server that can be found in the output of the job that deployed the WebLogic stack, as part of the WebLogic Admin Server console URL.

     Find it in **Resource Manager -> Stack -> stack details -> job details -> Outputs**

       ![](./images/migrate-db-2.png)


3. Enter the `TARGET_DB_HOST` **private IP address**
 
     This IP address was gathered from the Database System details, under **Database System -> details -> Nodes**

       ![](./images/provision-db-26-nodeip.png)


4. Enter the `TARGET_DB_DOMAIN` name, from the DB connection string. 

      If you followed the name convention defaults in the lab, it should be `nonjrfdbsubnet.nonjrfvcn.oraclevcn.com`.

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

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
