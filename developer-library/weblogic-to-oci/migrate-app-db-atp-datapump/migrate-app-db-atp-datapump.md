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
      <copy>
      ssh opc@<public-ip>
      </copy>
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


## **STEP 3:** Install the OCI CLI on the source database

This will be needed to get the wallet from the ATP database and put the DB dump file into object storage from the source DB.

*Note:* You could also do without the CLI by getting the wallet through the console and uploading the dump file through the console. This requires more manual steps.

1. Install the OCI CLI on the source Database

    ```bash
    <copy>
    bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
    </copy>
    ```

    Hit **enter** to use the defaults for all options.

2. Restart your shell
    ```
    <copy>
    exec -l $SHELL
    </copy>
    ```

3. Configure the OCI CLI

    ```
    <copy>
    oci setup config
    </copy>
    ```

    You will be prompted for:
    - Location of the config. Hit **Enter**
    - `user_ocid`: enter your user OCID (found under **User -> User Settings**)
    - `tenancy_ocid`: enter your tenancy OCID (found under **User -> Tenancy**)
    - `region`: enter your region from the list provided.
    - Generate a RSA key pair: hit **Enter** for Yes (default)
    - Directory for keys: hit **Enter** for the default
    - name for the key: hit **Enter** for the default
    - Passphrase: hit **Enter** for no passphrase


    You should see an output like:

    ```bash
    Private key written to: /home/oracle/.oci/oci_api_key.pem
    Fingerprint: 21:d4:f1:a0:55:a5:c2:ce:e2:c6:88:4f:bf:2f:f3:af
    Config written to /home/oracle/.oci/config
    ```


4. Upload the public key to your OCI account

    In order to use the CLI, you need to upload the public key generated to your user account

    Get the key content with 

    ```
    <copy>
    cat /home/oracle/.oci/oci_api_key_public.pem
    </copy>
    ```

    and copy the full printed output to clipboard

    In the OCI web console:

    - Under **User -> User Settings**
    - Click **API Keys**
    - Click **Add Public Key**
    - Click **Paste Public Key**
    - Paste the key copied above.
    - Click **Add**

    You can verify that the Fingerprint generated matches the fingerprint output of the config.

5. Test your CLI

    ```
    <copy>
    oci os ns get
    </copy>
    ```

    This command should output the namespace of your tenancy (usually the name of the tenancy)

    ```
    {
        "data": "your-tenancy-namespace"
    }
    ```

    Make a note of your **namespace** which will be needed later.

## **STEP 4:** Create an Object Storage Bucket

1. Go to **Core Infrastructure -> Object Storage**

    ![](./images/migrate-db-oss-1.png)

2. Make sure you are in the compartment where you deployed the resources

3. Click **Create Bucket**

4. Give the bucket the name **atp-upload**

5. Click **Create Bucket**

## **STEP 5:** Edit the `datapump_import_atp.sh` script


First, we'll need to edit the `datapump_import_atp.sh` script to target the OCI database found in the datapump folder.

1. Open the script in an editor. We'll use the popular `nano` editor:

      ```
      <copy>
      nano datapump_import_atp.sh
      </copy>
      ```

    You'll need to input the following variables (see instruction below to find the data):
    ```
    BASTION_IP=<IP of the Bastion Instance or Public IP of the Admin server, from WLS Admin URL>

    TARGET_DB_NAME=wlsatpdb
    TARGET_DB_OCID=<OCID of the ATP database>
    TARGET_DB_HOST=<Private Endpoint IP>

    BUCKET=atp-upload
    REGION=us-ashburn-1
    NAMESPACE=<Tenancy namespace>

    OCI_USER=<full username, usually email, sometimes prefixed with IDCS service name>
    OCI_TOKEN='<auth token>'

    TARGET_DB_PORT=1522
    TARGET_DB_USER=admin
    TARGET_DB_PWD=YpdCNR6nua4nahj8__
    ```

2. Enter the `BASTION_IP`

     The `BASTION_IP` is the **public IP** through which to reach the database subnet (either the WLS Admin server Public IP if you provisioned in a public subnet, or the Bastion Instance Public IP if you provisioned in a private subnet). Either are found in the **Output** of the WebLogic deployment stack.

3. Go to **Oracle Database -> Autonomous Transaction Processing**

4. Make sure you are in the right compartment and **click** the database you provisioned earlier to get to the details.

5. **Enter** the name of the Autonomous Database as the `TARGET_DB_NAME` in the script, making sure it is in *lowercase*

6. **Copy** the **OCID**, and enter it as the `TARGET_DB_OCID` in the script

7. **Copy** the **Private Endpoint IP address** and enter as the `TARGET_DB_HOST` in the script

    ![](./images/db-info.png)

8. **Enter** the name of the Object Storage bucket created earlier as `BUCKET` (`atp-upload`)

9. **Enter** the name of your region as `REGION` (for example `us-ashburn-1`)

10. **Enter** the name of your namespace as `NAMESPACE`. This was output when you tested the OCI CLI.

11. Go to **User -> Settings** and copy your *full username* (it usually consists of your email, sometimes prefixed with the ID service if your login is through Single Sign On). Enter it as the `OCI_USER` variable

12. In **User -> Settings** click **Auth Tokens**

    ![](./images/auth-token.png)

13. Click **Generate Token**

14. Give it a name

15. Click **Generate Token**

16. Copy the output of the token to the variable `OCI_TOKEN`. 

    *Make sure to use single quotes to delimitate the OCI_TOKEN as it may contain characters that would cause script errors.*

17. Save the file (with `CTRL+x` then `y`)

## **STEP 6:** Import the data into the target database on OCI

1. Run the `datapump_import_atp.sh` script you edited at the previous step

      ```bash
      <copy>
      ./datapump_import_atp.sh
      </copy>
      ```

2. You will be prompted to continue connection. Type `yes` to proceed.

The import script runs in 8 phases:

- It copies the dump file over to Object Storage
- It downloads the wallet for the ATP database locally, and unzips it.
- It creates a SSH tunnel to access the ATP database locally
- It sets up the `sqlnet.ora` file to point to the wallet
- It adds the hostname of the ATP DB into the `/etc/hosts` file to point to `localhost` so that connection attempts go through the tunnel we created.
- then it runs the `impdp` import command once.
You may notice this 1st try imports the schema but fails at importing the data, because the user `RIDERS` does not have a quota on the local `USERS` tablespace.
- the script then edits the `RIDERS` user tablespace quota
- and re-runs the `impdb` command that now succeeds at importing the data, but will show an error related to the user `RIDERS` already existing. This is normal.

The database is now migrated to OCI, but we also need to setup the wallet on the WLS servers

## **STEP 7:** Download the wallet on each WebLogic server

There are 2 ways to download the wallet on to the target WebLogic servers:

- We have downloaded the wallet locally already to migrate the database, and we can simply secure-copy that wallet to each server with `scp`. This is what we will do.

1. Gather the IP adresses of the WebLogic server:

    Go to **Core Infrastructure -> Compute -> Instances**

    View the list of WebLogic servers and gather the IP addresses

2. Run the following command, to copy the wallet on each server

    If you provisioned in a *Public Subnet*, set the variable:

    ```bash
    <copy>
    export TARGET_WLS_SERVER=<Public IP of a WLS server>
    </copy>
    ```

    Then 
    
    ```bash
    <copy>
    scp wallet.zip opc@${TARGET_WLS_SERVER}:~/
    </copy>
    ```
    ```bash
    <copy>
    ssh opc@${TARGET_WLS_SERVER} "sudo chown oracle:oracle wallet.zip"
    </copy>
    ```
    ```bash
    <copy>
    ssh opc@${TARGET_WLS_SERVER} "sudo unzip wallet.zip -d /u01/data/domains/nonjrf_domain/config/atp/"
    </copy>
    ```

    *make sure to specify the proper domain name (here `nonjrf_domain`)*

    If you provisioned in a *Private Subnet* set the variables:
    ```bash
    <copy>
    export TARGET_WLS_SERVER=<IP of a WLS server>
    </copy>
    ```
    ```bash
    <copy>
    export BASTION_IP=<Public IP of the Bastion Instance>
    </copy>
    ```

    Then 
    
    ```bash
    <copy>
    scp -o ProxyCommand="ssh opc@${BASTION_IP} -W %h:%p" wallet.zip opc@${TARGET_WLS_SERVER}:~/
    </copy>
    ```
    ```bash
    <copy>
    ssh -o ProxyCommand="ssh opc@${BASTION_IP} -W %h:%p" opc@${TARGET_WLS_SERVER} "sudo chown oracle:oracle wallet.zip"
    </copy>
    ```
    ```bash
    <copy>
    ssh -o ProxyCommand="ssh opc@${BASTION_IP} -W %h:%p" opc@${TARGET_WLS_SERVER} "sudo unzip wallet.zip -d /u01/data/domains/nonjrf_domain/config/atp/"
    
    </copy>
    ```

    *make sure to specify the proper domain name (here `nonjrf_domain`)*


3. Repeat for each WLS target server.

    Note: the destination path is important as this path is cloned when scaling WLS servers, insuring the wallet is also deployed on any new server instance.


- An alternative method (for info only, no need to apply these commands):

    There is also a helper script on each WebLogic server node to download the wallet. 

    For this script to work, you will need to add an extra policy on the **dynamic group** created by the WLS on OCI stack. 

    The policy is called `<PREFIX>-wlsc-principal-group`, which you can find under **Identity -> Dynamic Groups**. The Policy to edit will be on the *root* of the tenancy, so you need to be an administrator to edit it. It is called `<PREFIX>-service-policy`. It should contain an extra policy rule as follow:

    ```
    Allow dynamic-group nonjrf-wlsc-principal-group to use autonomous-transaction-processing-database-family in compartment id <your compartment>
    ```
    If you choose this method, you would use the following variables:

    ```bash
    <copy>
    export TARGET_WLS_SERVER=<Public IP>
    export ATP_OCID=<OCID of the ATP database>
    export WALLET_PASSWORD=<password of your choice>
    </copy>
    ```
    Note that the password needs to match what is in the `source.properties` file, so make sure to edit that file with your own password.
    
    Then run the command:
    
    ```bash
    <copy>
    ssh opc@${TARGET_WLS_SERVER} "sudo su -c \"/opt/scripts/utils/download_atp_wallet.sh ${ATP_OCID} ${WALLET_PASSWORD} /u01/data/domains/nonjrf_domain/config/atp\"" - oracle
    </copy>
    ```

    *make sure to specify the proper domain name (here `nonjrf_domain`)*

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
