### WebLogic Migration to Oracle Cloud Infrastructure 

## Objective
Perform the end-to-end migration of a local WebLogic domain to Oracle Cloud Infrastructure using provisioning with the OCI Marketplace.

- We'll start with a local WebLogic domain with an application backed by a local database, provisioned using Docker/docker-compose
- We'll prepare the OCI tenancy to provision WebLogic Server from the Marketplace, and perform the migration.
- We'll provision a new empty WebLogic domain on OCI with the Marketplace.
- We'll provision a database using the OCI DB as a service as the taregt to migrate the local application database.
- We'll migrate the local application database to the OCI DB as a service using DataPump, by backing up the local database schema, moving the files over to the DB provisioned on OCI and importing into it.
- Finally, we'll migrate the WebLogic domain using Weblogic Deploy Tooling (WDT). We'll discover the local domain, and after editing the model file to target the new domain, we'll update the new domain on OCI.


**The entire process may take 3 hours to complete, including provisioning time.**

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

## Requirements

### 1) Software, credentials and accounts

- Docker installed locally to run the 'on-prems' environment.</br>
  Get Docker here: <a href="https://docs.docker.com/get-docker/" target="_blank">https://docs.docker.com/get-docker/</a>

- Docker Hub Account, to download necessary Docker images</br>
  Sign up here: <a href="https://hub.docker.com/signup" target="_blank">https://hub.docker.com/signup</a>

- Oracle Container Registry account</br>
  <a href="https://container-registry.oracle.com" target="_blank">https://container-registry.oracle.com</a>

- Oracle Cloud Infrastructure account, with proper credentials to create resources</br>
  <a href="https://www.oracle.com/cloud/free/" target="_blank">https://www.oracle.com/cloud/free/</a>

### 2) Get the code

**Download the source code required for this lab from** <a href="./weblogic-to-oci.zip" target="_blank">here</a></br>
or at <a href="https://github.com/oracle/learning-library/raw/master/developer-library/weblogic-to-oci/workshop/weblogic-to-oci.zip" target="_blank">https://github.com/oracle/learning-library/raw/master/developer-library/weblogic-to-oci/workshop/weblogic-to-oci.zip</a>

<!-- Or alternatively use the `git clone` command or the `Download` option to fetch the whole `learning-library` repository locally (~7GB)

<img src="./images/requirements-clone-or-download.png" width="100%"> -->

### 3) Fetch the private docker images:

This repository makes use of Oracle docker images which are licensed and need to be pulled after acknowledging the terms of the license.

- Sign in to Docker Hub and go to the Weblogic image area at:</br>
  <a href="https://hub.docker.com/_/oracle-weblogic-server-12c" target="_blank">https://hub.docker.com/_/oracle-weblogic-server-12c</a>
  
  - Click **Proceed to Checkout**
    then fill in your information, accept the terms of license, and click **Get Content**.

  - Then fetch the image: 

    ```bash
    <copy>
    docker pull store/oracle/weblogic:12.2.1.4
    </copy>
    ```

- Sign in to the **Oracle Container Registry** and accept the license terms for the Database image at:</br>
  <a href="https://container-registry.oracle.com/pls/apex/f?p=113:4:102331870967997::NO:::" target="_blank">https://container-registry.oracle.com/pls/apex/f?p=113:4:102331870967997::NO:::</a>

  - Then fetch the image:

    ```bash
    <copy>
    docker pull container-registry.oracle.com/database/enterprise:12.2.0.1
    </copy>
    ``` 

- Go to the **Instant Client** page and accept the license terms for the SQL Plus client at:</br>
  <a href="https://container-registry.oracle.com/pls/apex/f?p=113:4:103193800236962" target="_blank">https://container-registry.oracle.com/pls/apex/f?p=113:4:103193800236962</a>

  - Then fetch the image:

    ```bash
    <copy>
    docker pull store/oracle/database-instantclient:12.2.0.1
    </copy>
    ```

# WebLogic Migration Lab steps

## Step 1: Setup the local ('on-premises') environment

See Requirements to get the code and the required Docker images.

### 1.1) Start the Local environment

To startup the local environment stack that will simulate our 'on-premises' environment, run:
```
<copy>
cd on-prems-setup
docker-compose up -d
</copy>
```
This step can take several minutes because some images need to be built. 

If you get an error message like:
```
pull access denied for store/oracle/database-instantclient, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
```
This means you have not accepted the *Terms and Condition* for the specific image.

Go to the appropriate registry and image page, and go through the acknowledgement steps, and/or pull the image as indicated above.

### 1.2) Check the local environment is up and running

**It may take several minutes for the domain to be up and running**, because the weblogic container waits for the database to be ready, and the schemas to be created. Be patient.

The console will be available at <a href="http://localhost:7001/console" target="_blank">http://localhost:7001/console</a> and the WebLogic admin user is `weblogic` with password `welcome1`

To check status of the initialization, you can check if the `on-prems-setup_oracledbinit_1` container has finished running by running:

```
<copy>
docker ps
</copy>
```
The following output shows the init container has terminated and the system should be ready:
```
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS                PORTS                                                                          NAMES
bf43e3bd5a78        on-prems-setup_oracledb    "/bin/sh -c '/bin/ba…"   7 days ago          Up 7 days (healthy)   127.0.0.1:1521->1521/tcp, 127.0.0.1:5000->5000/tcp, 5500/tcp                   on-prems-setup_oracledb_1
38bcbb1555b8        on-prems-setup_wls_admin   "/u01/oracle/startNM…"   7 days ago          Up 7 days             127.0.0.1:7001->7001/tcp, 127.0.0.1:7003->7003/tcp, 127.0.0.1:7005->7005/tcp   on-prems-setup_wls_admin_1
```

If you see a container called `on-prems-setup_oracledbinit`, this means the initialization is still ongoing.

To troubleshoot problems in the setup, check the logs in the docker containers with:

```bash
<copy>
docker logs -t on-prems-setup_wls_admin_1
</copy>
```
or
```bash
<copy>
docker logs -t on-prems-setup_oracledb_1
</copy>
```

Before proceeding, make sure the local environment has been deployed properly and is running. 

<img src="./images/localhost-admin-console.png"  width="100%">


The **SimpleDB** application should be running at <a href="http://localhost:7003/SimpleDB/" target="_blank">http://localhost:7003/SimpleDB/</a> or <a href="http://localhost:7005/SimpleDB/" target="_blank">http://localhost:7005/SimpleDB/</a>

It shows statistics of riders of the Tour de France stored in the database, and looks like this:

<img src="./images/localhost-simpledb-app.png" width="100%">

### 1.3) Create a SSH key

We'll need a SSH key pair to communicate with the WebLogic servers and the database on OCI. The public key will need to be provided when provisioning those resources. 

Since we'll be running all our commands from docker containers, a folder has been mounted on the `~/.ssh/` folder inside both containers, so that it is shared and also accessible from the outside.

We'll create a SSH key pair in this folder

- Get inside the Oracle Database container:

```bash
<copy>
docker exec -it on-prems-setup_oracledb_1 /bin/bash
</copy>
```

- Create the SSH keypair

```bash
<copy>
ssh-keygen
</copy>
```
and just hit `Enter` (default) for all the prompts

- You should find two files `id_rsa` and `id_rsa.pub` inside the folder `./on-prems-setup/common/`

   `id_rsa` is the private key, which should never be shared, and will be required to connect to any OCI resource provisioned with the corresponding public key `id_rsa.pub`

   Note this key will be the default SSH key from within either docker container used for the on-premises environment. If you wanted to SSH to the OCI resources from outside the container, you will need to supply the private key as the identity file in the ssh command, with the `-i <path-to-id_rsa>/id_rsa`

**Note:** This is only to be done once. If you run it again, a new key will overwrite the previous one and you will lose access to any resource provisioned with that key.

## Step 2: Prepare the OCI account

These prerequisites only need to be done once to deploy WebLogic stacks. 

Login to your OCI account
### 2.1) Create a **Vault**

- Go to **Security -> Vault**

   <img src="./images/prereq-vault1.png" width="50%">

- Make sure you are in the compartment where you want to deploy WebLogic

- Click **Create Vault**

   <img src="./images/prereq-vault2.png"  width="100%">

- Name the vault `WebLogic Vault` or a name of your choosing. Make sure the `private` option is **not checked** and click **Create Vault**

   <img src="./images/prereq-vault3.png" width="80%">

### 2.2. Create a **Key** in the vault

- Once the vault is provisioned, click the vault

   <img src="./images/prereq-vault4.png" width="100%">

- then click **Create Key**

   <img src="./images/prereq-key1.png" width="100%">

- name the key `WebLogicKey` or a name of your choosing and click **Create Key**

   <img src="./images/prereq-key2.png" width="80%">

### 2.3) Create a **Secret** for the WebLogic admin password

- Once the key is provisioned, click **Secrets**

   <img src="./images/prereq-secret1.png" width="60%">

- then **Create Secret**

  <img src="./images/prereq-secret2.png" width="80%">

- Name the **Secret** as `WebLogicAdminPassword`, select the `WebLogicKey` created at the previous step as the **Encryption Key**, keep the default `plaintext` option and type `welcome1` or any WebLogic compliant password (at least 8 chars and 1 uppercase or number) in the **Secret Content** text field, and click **Create Secret**

  <img src="./images/prereq-secret3.png" width="100%">

- Click the `WebLogicAdminPassword` **Secret** you just created and make a note of its **OCID**

   <img src="./images/prereq-secret4.png" width="100%">

That is all that's needed to get started.

**Note:**
If we were migrating a JRF domain (which is not the case here), the Virtual Cloud Network as well as subnets and Security Lists and an Operational Database would need to be provisioned before attempting to provision the WebLogic domain with the Marketplace.

## Step 3: Provision the WebLogic infrastructure

### 3.1) Provision the stack through the Marketplace

- Go to **Solutions and Platforms** 

  <img src="./images/provision-1.png" width="50%">

- In the search input, type "`weblogic`". For this lab, we'll use the **WebLogic Enterprise Edition UCM**

   <img src="./images/provision-2.png" width="100%">

- Make sure you are in the **Compartment** you want to use, use the **default WebLogic version** available, accept the License agreement and click **Launch the Stack**

   <img src="./images/provision-3.png" width="100%">

- **Name** the stack and click **Next**

   <img src="./images/provision-4.png" width="100%">

   <img src="./images/provision-5.png" width="100%">

- **Enter** a **Resource Name Prefix**.

  It will be used to prefix the name of all the resources (domain, managed servers, admin server, cluster, machines...)

  The next steps in this workshop assumes the resource name prefix is `nonjrf`, so it is highly recommended to use this name.

  <img src="./images/provision-6-prefix.png" width="70%">

- **Select** a **Shape**.

   In a real world situation, choose a shape appropriate to handle the load of a single managed server. Since we're using a trial account, choose the **VM.Standard.1** shape or a shape that is available in your tenancy.

  <img src="./images/provision-7-shape.png" width="70%">

   To check shape availability, you can go to **Governance -> Limits and Quotas** in another tab, and verify you have a specific shape available

- **SSH key**

   To connect to the WebLogic servers via SSH, you need to provide a public key the server will use to identify your computer. Since the various commands will be ran from inside the docker containers, you'll need to provide the key generated in the container.

  <img src="./images/provision-8-sshkey.png" width="70%">

   To output the public key information, use the following command from inside the docker container
   ```
   <copy>
   cat ~/.ssh/id_rsa.pub
   </copy>
   ```
   Copy the output of the command (the whole multi-line output) and paste it in the form field for SSH key in the form

   the output will look something like this:

   ```bash
   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlkF23qLyfimJ9Vp4D9psp7bDOB8JvtY/pfYzFxIA2E4v6or+XhvMW5RDhX9Ba54zQNNDLvwUhStdXKkiMXJtEQJarFn45pGy/lyUQKFJolAdHBrXJsg5XWn4DxCFeQUQe1szVfmwDLAktAS14r5g76h3CcA8Kk/cNVqevxVChyejuuOdtAMoriIC8uKV+535qPs/GMiu0zR9aW4w1VodL5eHnXjqdgp8Fr21dVUVQ6of+s/ws0zlQUwghrNguDUqlggzG2mpLBHExypxCrJYmsb05uYjjqVlC3YCatj4nJTIHKLCFiYVY/b8AFkqwXV9EYlja5bjTmunM847dcR8H oracle@ad753161734c
   ```
   **Note:** Do not use the example above as the key: it is a different public key which is useless without the corresponding private key, and you will not be able to access your resources on OCI)

- **Select** an **Availability Domain**

  <img src="./images/provision-9-ad.png" width="70%">

- **Select** a **Node count**. In this lab, we'll provision 2 nodes.

  <img src="./images/provision-10-nodes.png" width="70%">

- We'll keep the WebLogic Administrator Name as the default of `weblogic`

  <img src="./images/provision-11-admin-name.png" width="70%">

- **Paste** the **OCID** of the **Secret** generated in step 2.3) for the **Secret OCID for WebLogic Admin Password**

  <img src="./images/provision-12-secret.png" width="70%">

- **Check** the checkbox for **WebLogic Server Advanced Server Configuration**
   Here you can see all the default ports, which we will keep as-is.

  <img src="./images/provision-13-advanced.png" width="70%">

- in this same **Advanced** section, **uncheck** the checkbox to **Provision the Sample Application**: since we will migrate our domain, we want a clean domain to start from.

  <img src="./images/provision-14-no-app.png" width="70%">

- In the **WebLogic Network** section, make sure you are in the proper compartment

  <img src="./images/provision-15-net.png" width="70%">

- Select **Create New VCN**

  <img src="./images/provision-16-create-vcn.png" width="70%">

- **Name** the VCN `wls`

  <img src="./images/provision-17-vcn-name.png" width="70%">

- **Keep the default** VCN CIDR block as-is.
   
  <img src="./images/provision-18-vcn-cidr.png" width="70%">

   Note: If you were to migrate from an on-premises domain connected via VPN or FastConnect, you would want to make sure the CIDR block does not conflict with the local network.

- **Keep the defaults for subnets** as-is: 

   The stack will create the subnets for us.

  <img src="./images/provision-19-subnets.png" width="70%">

- **Check** the **Provision Load Balancer** checkbox and keep the defaults

  <img src="./images/provision-20-lb.png" width="70%">

- Keep IDCS **unchecked**

  <img src="./images/provision-21-idcs.png" width="70%">

- Make sure **No Database** is selected

  <img src="./images/provision-22-nodb.png" width="70%">

- Optionally add Tags

  <img src="./images/provision-23-tags.png" width="70%">

- Click **Next**

  <img src="./images/provision-24.png" width="100%">

- and then click **Create**

  <img src="./images/provision-25.png" width="100%">

- The stack will get provisioned using the **Resource Manager**. This may take 7-15min.

  <img src="./images/provision-26.png" width="100%">


Once the stack is provisioned, you can find the information regarding the URL and IP of the WebLogic Admin server in the logs, or in the **Outputs** left-side menu. 

### 3.2) Gather the necessary WebLogic stack information

  <img src="./images/provision-27.png" width="100%">

- Make a note of the **WebLogic Admin Server public IP address** from the **WebLogic Admin Server Console URL** for later use.

- Make a note of the **Load Balancer IP** for later use.

You can copy/paste the **WebLogic Admin Console URL** in your browser and explore the provisioned WebLogic domain. You should find that there are no applications in **deployments** and no data sources in the **service->datasources** menu


## Step 4: Provision the Database on OCI

While the WebLogic instances are provisioning, it's possible to move forward with the Application Database provisioning as soon as the VCN is provisioned.

Before we can provision the Application Database, we need to provision a **private subnet** for the **Database System** with appropriate **Security Lists** to open up the required ports: 
- port 1521 for the database, 
- port 22 for SSH.

### 4.1) Create a Security List for the database subnet

In this section we will create a Security List for the WebLogic subnet to be able to reach the Database subnet on port 1521 (the Oracle Database default port)

- Go to **Networking -> Virtual CLoud Network** in the compartment where WebLogic was provisioned.

  <img src="./images/provision-db-1.png" width="50%">

- Click the VCN that was created by the stack, which would be called `nonjrf-wls` if you used the same naming conventions.

  <img src="./images/provision-db-2.png" width="100%">

  You should find 2 subnets: a `nonjrf-lb-subnet` and a `nonjrf-wls-subnet`, both public subnets since the WebLogic server instances were provisioned in a public subnet.

- Copy the CIDR block of the `nonjrf-wls-subnet` (which should be 10.0.3.0/24) and click **Security Lists** on the left-side menu

  <img src="./images/provision-db-3-seclists.png" width="100%">

- Click **Create Security List**

  <img src="./images/provision-db-4.png" width="100%">

- **Name** the security list `nonjrf-db-security-list`

  <img src="./images/provision-db-5-dbseclist.png" width="70%">

- Click **Additional Ingress Rule**

  <img src="./images/provision-db-5-ingress1521.png" width="70%">

- For **Source CIDR**, paste the CIDR block of the `nonjrf-wls-subnet` copied earlier (`10.0.3.0/24`) and for **Destination Port Range** enter **1521**

  <img src="./images/provision-db-5-ingress1521.png" width="70%">

- Click **Additional Ingress Rule** and enter `0.0.0.0/0` for the **Source CIDR** and enter `22` for the **Destination Port Range** to authorize SSH from outside (through the bastion host) 

  <img src="./images/provision-db-6-ingress22.png" width="70%">

### 4.2) Create the database subnet

- Click **Subnets** on the left-side menu

  <img src="./images/provision-db-7-subnet.png" width="100%">

- Click **Create Subnet**

  <img src="./images/provision-db-8-subnet.png" width="100%">

- **Name** the subnet `nonjrf-db-subnet`

  <img src="./images/provision-db-9-subnet1.png" width="70%">

- Keep the defaults for the **Subnet Type** and enter a CIDR block of `10.0.5.0/24`

  <img src="./images/provision-db-9-subnet2.png" width="70%">

- **Select** the `Default Routing Table for nonjrf-wls` for the **Routing Table**

  <img src="./images/provision-db-9-subnet3.png" width="70%">

- Select **Private Subnet**

  <img src="./images/provision-db-9-subnet4.png" width="70%">

- Keep the defaults for the DNS resolution and label and select `Default DHCP Options for nonjrf-wls` for **DHCP Options**

  <img src="./images/provision-db-9-subnet5.png" width="70%">

- **Select** the `nonjrf-db-security-list` created earlier for the **Security List**

  <img src="./images/provision-db-9-subnet6.png" width="70%">

- and click **Create Subnet**

  <img src="./images/provision-db-9-subnet7.png" width="70%">

### 4.3) Provision the Database System

- Go to **Database -> Bare Metal, VM and Exadata**

  <img src="./images/provision-db-10.png" width="40%">

- Click **Create DB System**

  <img src="./images/provision-db-11.png" width="100%">

- Make sure you are in the **Compartment** where you created the DB subnet, and name your **Database System**

  <img src="./images/provision-db-12.png" width="100%">

- Select an Availability Domain or keep the default, keep the default **Virtual Machine** and select a **Shape** that is available.

  <img src="./images/provision-db-13-ad-shape.png" width="70%">

- Keep the defaults for **Total node count** and **Database Edition**

  <img src="./images/provision-db-14.png" width="70%">

- Select **Logical Volume Manager** 

  <img src="./images/provision-db-15-lvm.png" width="70%">

- Keep defaults for **Storage**

  <img src="./images/provision-db-16-storage.png" width="70%">

- **Upload** the **SSH public key** created earlier, and if you have another, upload it as well for safety.
  The key created in the container can be found in the folder `./on-prems-setup/common`

  <img src="./images/provision-db-17-ssh.png" width="70%">

- Keep the default **License Included**

  <img src="./images/provision-db-18-license.png" width="70%">

- Select the **Virtual cloud network** `nonjrf-wls`, the **Client subnet** `nonjrf-db-subnet` and set a **Hostname prefix** of `db`

  <img src="./images/provision-db-19-net.png" width="70%">

- Click **Next**

- Name the Database `RIDERS` like the database on-premises (required for proper migration)

  <img src="./images/provision-db-20-dbname.png" width="70%">

- Keep the default **Database version** 19c

  <img src="./images/provision-db-21-version.png" width="70%">

- Name the **PDB** `pdb` as it is on premises

  <img src="./images/provision-db-22-pdb.png" width="70%">

- Enter and confirm the **SYS Database password** as it is on-premises: `YpdCNR6nua4nahj8__`
This is found in the `env` file under `DB_PWD` in the `on-prems-setup/weblogic` folder

  <img src="./images/provision-db-23-creds.png" width="70%">

- Keep the default of **Transaction Processing** for **Workload type** and **Backup**, and click **Create DB System**

  <img src="./images/provision-db-24.png" width="100%">

This will take 20 to 40 minutes to provision.

  <img src="./images/provision-db-25.png" width="100%">

### 4.4) Gather the OCI database information

Once the database system is provisioned

- Go to the `nodes` left-side menu and note the **private IP address** of the node provisioned for later use

  <img src="./images/provision-db-26-nodeip.png" width="100%">

- Go to **DB Connection** 

  <img src="./images/provision-db-27-connection.png" width="100%">

- Copy the **DB connection string** for later use

  <img src="./images/provision-db-27-connection2.png" width="70%">

## Step 5: Migrate the Application Database

DataPump will be used to migrate the database from on-premises to OCI.

DataPump export function creates a DDL + data dump of the user schema, which is then transfered over to the target database where the DataPump import function is used to create the schema and import the data.

### 5.1) Get a shell inside the database container with:


```
<copy>
docker exec -it on-prems-setup_oracledb_1 /bin/bash
</copy>
```
Note: you should already be inside the DB container from the SSH key creation step, so you can skip the above step unless you exited the container

Then get into the `/datapump` folder
```
<copy>
cd ~/datapump
</copy>
```

### 5.2) `datapump_export.sh` script

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

### 5.2.1) run the `datapump_export.sh` script

```
<copy>
./datapump_export.sh
</copy>
```

The output will look like

  <img src="./images/migrate-db-1.png" width="100%">


### 5.3) `datapump_import.sh` script

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

### 5.3.1) Edit the script

   - Enter the `BASTION_IP`

     The `BASTION_IP` is the **public IP** of the WebLogic Admin Server that can be found in the output of the job that deployed the stack seen at step [3.2) Gather information](#3-2-gather-the-necessary-weblogic-stack-information)

  - Enter the `TARGET_DB_HOST` **private IP address**
    This IP address was gathered from the Database System details at step [4.4) Gather the OCI database information](#4-4-gather-the-oci-database-information)

  - Enter the `TARGET_DB_DOMAIN` name, from the DB connection string. If you followed the name conventions, it should be `nonjrfdbsubnet.nonjrfvcn.oraclevcn.com`

### 5.3.2) run the `datapump_import.sh` script

```bash
<copy>
./datapump_import.sh
</copy>
```

The import script runs in 4 phases: 

1) It copies the files over to the OCI DB node, 

2) then runs the `impdp` import command once. You may notice this 1st try imports the schema but fails at importing the data, because the user `RIDERS` does not have a quota on the local `USERS` tablespace. 

3) the script then edits the `RIDERS` user tablespace quota

4) and re-runs the `impdb` command that now succeeds at importing the data, but will show an error related to the user `RIDERS` already existing. This is normal.

The database is now migrated to OCI.

## Step 6: Migrate the WebLogic domain

Migrating a WebLogic domain is equivalent to re-deploying the applications and resources to a new domain and infrastructure.

We'll use WebLogic Deploy Tooling to migrate the domain from on-premises and re-deploy it on OCI.

**WebLogic Deploy Tooling** is an open source tool found on Github at <a href="https://github.com/oracle/weblogic-deploy-tooling" target="_blank">https://github.com/oracle/weblogic-deploy-tooling</a>

Migration with WebLogic Deploy Tooling (WDT) consists in 3 steps:

- Discover the source domain, and generate a **model** file of the topology, resources and applications, a **variable** file with required credentials, and an **archive** file with the application binaries.

- Edit the the **model** file and **variable** file to target the new infrastructure on OCI.

- Copy the files to the target Admin Server, and **update** the clean domain on OCI with the applications and resources discovered on-premises.

### 6.1) Installing WebLogic Deploy Tooling

- If you were in the Database container to perform the previous steps of database migration, exit the database container with 

   ```bash
   <copy>
   exit
   </copy>
   ```
   You should be back on your local computer shell prompt

- Get into the **WebLogic** docker container with the following command:

  ```bash
  <copy>
  docker exec -it on-prems-setup_wls_admin_1 /bin/bash
  </copy>
  ```

- run the `install_wdt.sh` script

  ```bash
  <copy>
  cd ~/wdt
  ./install_wdt.sh
  </copy>
  ```

  This will install WebLogic Deploy Tooling locally in a folder `weblogic-deploy`

  <details><summary>View the <code>install_wdt.sh</code> script</summary>

  ```bash
  WLSDT_VERSION=1.7.3
  # download the zip archive of the tool from Github
  curl -LO https://github.com/oracle/weblogic-deploy-tooling/releases/download/weblogic-deploy-tooling-${WLSDT_VERSION}/weblogic-deploy.zip 
  
  # unzip and cleanup
  unzip weblogic-deploy.zip
  rm weblogic-deploy.zip

  # make the scripts executable
  chmod +x weblogic-deploy/bin/*.sh
  ```
  </details>

### 6.2) Discover the on-premises domain

<details><summary>View the <code>discover_domain.sh</code> script</summary>

```bash
# default to JRF domain which filters out JRF libraries and applications
# If the domain is not JRF, the content would not be present so filterign it out will not make a difference
DOMAIN_TYPE=JRF

# clean up before starting
rm source.* || echo "clean startup"

echo "Discovering the source domain..."
weblogic-deploy/bin/discoverDomain.sh \
    -oracle_home $MW_HOME \
    -domain_home $DOMAIN_HOME \
    -archive_file source.zip \
    -model_file source.yaml \
    -variable_file source.properties \
    -domain_type $DOMAIN_TYPE

# This part insures that applications that are under the ORACLE_HOME are also extracted.
# by default WDT does not extract applications under the ORACLE_HOME as it is not following current best practices. However in older versions of WLS, this was common.

if [[ "$(cat source.yaml | grep '@@ORACLE_HOME@@' | wc -l)" != "0" ]]; then
    echo "Some of the application files are located within the ORACLE_HOME and won't be extracted by WDT"
    echo "Extracting those files and updating paths in the model file..."
    rm -rf ./wlsdeploy/
    mkdir -p ./wlsdeploy/applications;
    cp $(cat source.yaml | grep '@@ORACLE_HOME@@' | sed "s|.*: '@@ORACLE_HOME@@\(.*\)'|${ORACLE_HOME}\1|") ./wlsdeploy/applications/;
    zip -r source.zip ./wlsdeploy;
    rm -rf ./wlsdeploy/
    sed -i "s|@@ORACLE_HOME@@|wlsdeploy\/applications|g;" source.yaml
fi
```

</details>

The `discover_domain.sh` script wraps the WebLogic Deploy Tooling `discoverDomain` script to generate 3 files:

- `source.yaml`: the model file
- `source.properties`: the variables file
- `source.zip`: the archive file

It also takes care of the manual extraction of applications that may be present under the `ORACLE_HOME`

Applications found under `ORACLE_HOME` will have a path that includes `@@ORACLE_HOME@@` and **will not be included in the archive file**. They need to be extracted manually. The script takes care of this and injects those applications in the `source.zip` file while replacing the path in the `source.yaml` file.

- run the `discover_domain.sh` script

  ```bash
  <copy>
  ./discover_domain.sh
  </copy>
  ```

the output should look like:

<details><summary>output of the <code>discover_domain.sh</code> script</summary>

```bash
rm: cannot remove ‘source.*’: No such file or directory
clean startup
Discovering the source domain...
set JVM version to minor  8
JDK version is 1.8.0_241-b07
JAVA_HOME = /u01/jdk
WLST_EXT_CLASSPATH = /home/oracle/wdt/weblogic-deploy/lib/weblogic-deploy-core.jar
CLASSPATH = /home/oracle/wdt/weblogic-deploy/lib/weblogic-deploy-core.jar
WLST_PROPERTIES = -Djava.util.logging.config.class=oracle.weblogic.deploy.logging.WLSDeployCustomizeLoggingConfig -Dcom.oracle.cie.script.throwException=true 
/u01/oracle/oracle_common/common/bin/wlst.sh /home/oracle/wdt/weblogic-deploy/lib/python/discover.py -oracle_home /u01/oracle -domain_home /u01/oracle/user_projects/domains/base_domain -archive_file source.zip -model_file source.yaml -variable_file source.properties -domain_type JRF

Initializing WebLogic Scripting Tool (WLST) ...

Welcome to WebLogic Server Administration Scripting Shell

Type help() for help on available commands

####<May 28, 2020 6:00:28 PM> <INFO> <WebLogicDeployToolingVersion> <logVersionInfo> <WLSDPLY-01750> <The WebLogic Deploy Tooling discoverDomain version is 1.7.3:master.4f1ebfc:Apr 03, 2020 18:05 UTC>
####<May 28, 2020 6:00:28 PM> <INFO> <discover> <main> <WLSDPLY-06025> <Variable file was provided. Model password attributes will be replaced with tokens and corresponding values put into the variable file.>
####<May 28, 2020 6:00:33 PM> <INFO> <discover> <_get_domain_name> <WLSDPLY-06022> <Discover domain base_domain>
####<May 28, 2020 6:00:33 PM> <INFO> <TopologyDiscoverer> <discover> <WLSDPLY-06600> <Discovering domain model topology>
####<May 28, 2020 6:00:34 PM> <INFO> <TopologyDiscoverer> <_get_nm_properties> <WLSDPLY-06627> <Discovering NM Properties>
####<May 28, 2020 6:00:35 PM> <INFO> <Discoverer> <_get_additional_parameters> <WLSDPLY-06150> <Unable to determine if additional attributes are available for NMProperties at location /NMProperties : Unable to find a valid MBean Interface in the Class list array(java.lang.Class,[])  of the MBean instance com.oracle.cie.domain.nodemanager.NMPropertiesConfigProxyBase@4d96b968>
####<May 28, 2020 6:00:35 PM> <INFO> <TopologyDiscoverer> <get_clusters> <WLSDPLY-06601> <Discovering 1 clusters>
####<May 28, 2020 6:00:35 PM> <INFO> <TopologyDiscoverer> <get_clusters> <WLSDPLY-06602> <Adding Cluster cluster>
####<May 28, 2020 6:00:35 PM> <INFO> <TopologyDiscoverer> <get_servers> <WLSDPLY-06603> <Discovering 3 servers>
####<May 28, 2020 6:00:35 PM> <INFO> <TopologyDiscoverer> <get_servers> <WLSDPLY-06604> <Adding Server AdminServer>
####<May 28, 2020 6:00:37 PM> <INFO> <TopologyDiscoverer> <get_servers> <WLSDPLY-06604> <Adding Server server_0>
####<May 28, 2020 6:00:38 PM> <INFO> <TopologyDiscoverer> <get_servers> <WLSDPLY-06604> <Adding Server server_1>
####<May 28, 2020 6:00:38 PM> <INFO> <TopologyDiscoverer> <get_migratable_targets> <WLSDPLY-06607> <Discovering 2 Migratable Targets>
####<May 28, 2020 6:00:38 PM> <INFO> <TopologyDiscoverer> <get_migratable_targets> <WLSDPLY-06608> <Adding Migratable Target server_0 (migratable)>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <get_migratable_targets> <WLSDPLY-06608> <Adding Migratable Target server_1 (migratable)>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <get_unix_machines> <WLSDPLY-06609> <Discovering 1 Unix machines>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <get_unix_machines> <WLSDPLY-06610> <Adding Unix Machine machine_0>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <get_machines> <WLSDPLY-06611> <Discovering 0 machines>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <discover_security_configuration> <WLSDPLY-06622> <Adding Security Configuration>
####<May 28, 2020 6:00:39 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/Adjudicator/DefaultAdjudicator is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/AuthenticationProvider/DefaultAuthenticator is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/AuthenticationProvider/DefaultIdentityAsserter is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/Authorizer/XACMLAuthorizer is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/CertPathProvider/WebLogicCertPathProvider is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/CredentialMapper/DefaultCredentialMapper is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/PasswordValidator/SystemPasswordValidator is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/RoleMapper/XACMLRoleMapper is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <TopologyDiscoverer> <get_embedded_ldap_configuration> <WLSDPLY-06639> <Skipping Embedded LDAP Server Configuration>
####<May 28, 2020 6:00:40 PM> <INFO> <ResourcesDiscoverer> <discover> <WLSDPLY-06300> <Discovering domain model resources>
####<May 28, 2020 6:00:40 PM> <INFO> <CommonResourcesDiscoverer> <get_datasources> <WLSDPLY-06340> <Discovering 1 JDBC System Resources>
####<May 28, 2020 6:00:40 PM> <INFO> <CommonResourcesDiscoverer> <get_datasources> <WLSDPLY-06341> <Adding JDBC System Resource JDBCConnection>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <discover> <WLSDPLY-06380> <Discovering domain model deployments>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <get_applications> <WLSDPLY-06391> <Discovering 2 Applications>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <get_applications> <WLSDPLY-06392> <Adding Application SimpleDB>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <add_application_to_archive> <WLSDPLY-06393> <Will not add application SimpleDB from Oracle installation directory to archive>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <get_applications> <WLSDPLY-06392> <Adding Application SimpleHTML>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <add_application_to_archive> <WLSDPLY-06393> <Will not add application SimpleHTML from Oracle installation directory to archive>
####<May 28, 2020 6:00:41 PM> <INFO> <MultiTenantDiscoverer> <discover> <WLSDPLY-06700> <Discover Multi-tenant>
####<May 28, 2020 6:00:41 PM> <INFO> <MultiTenantTopologyDiscoverer> <discover> <WLSDPLY-06709> <Discover Multi-tenant Topology>
####<May 28, 2020 6:00:41 PM> <INFO> <MultiTenantResourcesDiscoverer> <discover> <WLSDPLY-06707> <Discover Multi-tenant Resources>
####<May 28, 2020 6:00:42 PM> <INFO> <filter_helper> <apply_filters> <WLSDPLY-20017> <No filter configuration file /home/oracle/wdt/weblogic-deploy/lib/model_filters.json>
####<May 28, 2020 6:00:42 PM> <INFO> <variable_injector> <inject_variables_keyword_file> <WLSDPLY-19518> <Variables were inserted into the model and written to the variables file source.properties>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <load_variables> <WLSDPLY-05004> <Performing variable validation on the source.properties variable file>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05002> <Performing validation in TOOL mode for WebLogic Server version 12.2.1.4.0 and WLST OFFLINE mode>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05003> <Performing model validation on the /home/oracle/wdt/source.yaml model file>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05005> <Performing archive validation on the /home/oracle/wdt/source.zip archive file>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the domainInfo section of the model file>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the topology section of the model file>
####<May 28, 2020 6:00:43 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the resources section of the model file>
####<May 28, 2020 6:00:43 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the appDeployments section of the model file>
####<May 28, 2020 6:00:43 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the kubernetes section of the model file>
####<May 28, 2020 6:00:43 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05009> <Model file /home/oracle/wdt/source.yaml does not contain a kubernetes section, validation of kubernetes was skipped.>

Issue Log for discoverDomain version 1.7.3 running WebLogic version 12.2.1.4.0 offline mode:

Total:       WARNING :     0    SEVERE :     0

discoverDomain.sh completed successfully (exit code = 0)
Some of the application files are located within the ORACLE_HOME and won't be extracted by WDT
Extracting those files and updating paths in the model file...
  adding: wlsdeploy/ (stored 0%)
  adding: wlsdeploy/applications/ (stored 0%)
  adding: wlsdeploy/applications/SimpleHTML.ear (deflated 72%)
  adding: wlsdeploy/applications/SimpleDB.ear (deflated 62%)
```

</details>

### 6.3) Edit the `source.yaml` file

The extracted `source.yaml` file looks like the following

```yaml
domainInfo:
    AdminUserName: '@@PROP:AdminUserName@@'
    AdminPassword: '@@PROP:AdminPassword@@'
topology:
    Name: base_domain
    ProductionModeEnabled: true
    NMProperties:
        CrashRecoveryEnabled: true
        LogLevel: FINEST
        JavaHome: /u01/jdk
        ListenAddress: 0.0.0.0
        PropertiesVersion: 12.2.1.4.0
        SecureListener: false
        weblogic.StartScriptName: startWebLogic.sh
    Cluster:
        cluster:
            MulticastPort: 5555
            MulticastAddress: 237.0.0.101
            WeblogicPluginEnabled: true
            ClusterMessagingMode: multicast
    Server:
        AdminServer:
            Machine: machine_0
            ListenAddress: 0.0.0.0
        server_0:
            ListenPort: 7003
            Machine: machine_0
            Cluster: cluster
            ListenAddress: 0.0.0.0
            JTAMigratableTarget:
                Cluster: cluster
                UserPreferredServer: server_0
        server_1:
            ListenPort: 7005
            Machine: machine_0
            Cluster: cluster
            ListenAddress: 0.0.0.0
            JTAMigratableTarget:
                Cluster: cluster
                UserPreferredServer: server_1
    MigratableTarget:
        server_0 (migratable):
            Cluster: cluster
            MigrationPolicy: manual
            UserPreferredServer: server_0
            Notes: This is a system generated default migratable target for a server. Do not delete manually.
        server_1 (migratable):
            Cluster: cluster
            MigrationPolicy: manual
            UserPreferredServer: server_1
            Notes: This is a system generated default migratable target for a server. Do not delete manually.
    UnixMachine:
        machine_0:
            NodeManager:
                DebugEnabled: true
                NMType: Plain
                ListenAddress: 0.0.0.0
    SecurityConfiguration:
        NodeManagerPasswordEncrypted: '@@PROP:SecurityConfig.NodeManagerPasswordEncrypted@@'
        CredentialEncrypted: '@@PROP:SecurityConfig.CredentialEncrypted@@'
        Realm:
            myrealm:
                Adjudicator:
                    DefaultAdjudicator:
                        DefaultAdjudicator:
                AuthenticationProvider:
                    DefaultAuthenticator:
                        DefaultAuthenticator:
                    DefaultIdentityAsserter:
                        DefaultIdentityAsserter:
                            ActiveType: [ AuthenticatedUser, 'weblogic-jwt-token' ]
                Authorizer:
                    XACMLAuthorizer:
                        XACMLAuthorizer:
                            PolicyDeploymentEnabled: true
                CertPathProvider:
                    WebLogicCertPathProvider:
                        WebLogicCertPathProvider:
                CredentialMapper:
                    DefaultCredentialMapper:
                        DefaultCredentialMapper:
                PasswordValidator:
                    SystemPasswordValidator:
                        SystemPasswordValidator:
                RoleMapper:
                    XACMLRoleMapper:
                        XACMLRoleMapper:
resources:
    JDBCSystemResource:
        JDBCConnection:
            Target: cluster
            JdbcResource:
                JDBCConnectionPoolParams:
                    InitialCapacity: 0
                    TestTableName: SQL SELECT 1 FROM DUAL
                JDBCDataSourceParams:
                    GlobalTransactionsProtocol: TwoPhaseCommit
                    JNDIName: jdbc.JDBCConnectionDS
                JDBCDriverParams:
                    URL: 'jdbc:oracle:thin:@//oracledb:1521/PDB.us.oracle.com'
                    PasswordEncrypted: '@@PROP:JDBC.JDBCConnection.PasswordEncrypted@@'
                    DriverName: oracle.jdbc.xa.client.OracleXADataSource
                    Properties:
                        user:
                            Value: riders
appDeployments:
    Application:
        SimpleDB:
            SourcePath: 'wlsdeploy/applications/SimpleDB.ear'
            ModuleType: ear
            StagingMode: stage
            Target: cluster
        SimpleHTML:
            SourcePath: 'wlsdeploy/applications/SimpleHTML.ear'
            ModuleType: ear
            StagingMode: stage
            Target: cluster

```

- Edit the `source.yaml` file to remove the entire `domainInfo` section and the `topology` section.

  ```bash
  <copy>
  nano source.yaml
  </copy>
  ```

  The `domainInfo` includes basic domain infromation which we will not change.

  The `topology` section includes the definition of the managed servers, admin server, machines and clusters. The domain is already provisioned on OCI so this will not change.

  The content now looks like:

  ```yaml
  resources:
      JDBCSystemResource:
          JDBCConnection:
              Target: cluster
              JdbcResource:
                  JDBCConnectionPoolParams:
                      InitialCapacity: 0
                      TestTableName: SQL SELECT 1 FROM DUAL
                  JDBCDataSourceParams:
                      GlobalTransactionsProtocol: TwoPhaseCommit
                      JNDIName: jdbc.JDBCConnectionDS
                  JDBCDriverParams:
                      URL: 'jdbc:oracle:thin:@//oracledb:1521/PDB.us.oracle.com'
                      PasswordEncrypted: '@@PROP:JDBC.JDBCConnection.PasswordEncrypted@@'
                      DriverName: oracle.jdbc.xa.client.OracleXADataSource
                      Properties:
                          user:
                              Value: riders
  appDeployments:
      Application:
          SimpleDB:
              SourcePath: 'wlsdeploy/applications/SimpleDB.ear'
              ModuleType: ear
              StagingMode: stage
              Target: cluster
          SimpleHTML:
              SourcePath: 'wlsdeploy/applications/SimpleHTML.ear'
              ModuleType: ear
              StagingMode: stage
              Target: cluster

  ```

- Edit each of the 3 `Target` names for `resources` and `appDeployments` from `cluster` (the name of the cluster on-premises) to `nonjrf_cluster` (the name of the cluster on the OCI domain):

  * `resources->JDBCSystemResource->JDBCConnection->Target`
  * `appDeployments->Application->SimpleDB->Target`
  * `appDeployments->Application->SimpleHTML->Target`

  ```yaml
  resources:
      JDBCSystemResource:
          JDBCConnection:
              Target: nonjrf_cluster # <---
              JdbcResource:
                  JDBCConnectionPoolParams:
                      InitialCapacity: 0
                      TestTableName: SQL SELECT 1 FROM DUAL
                  JDBCDataSourceParams:
                      GlobalTransactionsProtocol: TwoPhaseCommit
                      JNDIName: jdbc.JDBCConnectionDS
                  JDBCDriverParams:
                      URL: 'jdbc:oracle:thin:@//oracledb:1521/PDB.us.oracle.com'
                      PasswordEncrypted: '@@PROP:JDBC.JDBCConnection.PasswordEncrypted@@'
                      DriverName: oracle.jdbc.xa.client.OracleXADataSource
                      Properties:
                          user:
                              Value: riders
  appDeployments:
      Application:
          SimpleDB:
              SourcePath: 'wlsdeploy/applications/SimpleDB.ear'
              ModuleType: ear
              StagingMode: stage
              Target: nonjrf_cluster # <---
          SimpleHTML:
              SourcePath: 'wlsdeploy/applications/SimpleHTML.ear'
              ModuleType: ear
              StagingMode: stage
              Target: nonjrf_cluster # <---
  ```

  - finally, edit the `resources->JDBCSystemResource->JDBCConnection->JdbcResource->JDBCDriverParams->URL` to match the JDBC connection string of the database on OCI.

  The new JDBC connection string should be:
  
   `jdbc:oracle:thin:@//db.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com:1521/pdb.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com`

   Which is the connection string gathered in step [4.4) Gather the OCI database information](#4-4-gather-the-oci-database-information) but making sure the **service** name is changed to `pdb`, the name of the `pdb` where the `RIDERS.RIDERS` table needed by the **SimpleDB** application resides.

   The resulting `source.yaml` file should be like:

  ```yaml
  resources:
      JDBCSystemResource:
          JDBCConnection:
              Target: nonjrf_cluster
              JdbcResource:
                  JDBCConnectionPoolParams:
                      InitialCapacity: 0
                      TestTableName: SQL SELECT 1 FROM DUAL
                  JDBCDataSourceParams:
                      GlobalTransactionsProtocol: TwoPhaseCommit
                      JNDIName: jdbc.JDBCConnectionDS
                  JDBCDriverParams:
                      URL: 'jdbc:oracle:thin:@//db.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com:1521/pdb.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com'
                      PasswordEncrypted: '@@PROP:JDBC.JDBCConnection.PasswordEncrypted@@'
                      DriverName: oracle.jdbc.xa.client.OracleXADataSource
                      Properties:
                          user:
                              Value: riders
  appDeployments:
      Application:
          SimpleDB:
              SourcePath: 'wlsdeploy/applications/SimpleDB.ear'
              ModuleType: ear
              StagingMode: stage
              Target: nonjrf_cluster
          SimpleHTML:
              SourcePath: 'wlsdeploy/applications/SimpleHTML.ear'
              ModuleType: ear
              StagingMode: stage
              Target: nonjrf_cluster
  ```

  **Important Note**: if when migrating a different domain the `StagingMode: stage` key was not present in the `Application` section, **make sure to add it** as shown so the applications are distributed and started on all managed servers

- Save the `source.yaml` file by typing `CTRL+x` then `y`

### 6.4) Edit the `source.properties` file

  ```bash
  <copy>
  nano source.properties
  </copy>
  ```

  It looks like:

  ```yaml
  AdminPassword=
  AdminUserName=
  JDBC.JDBCConnection.PasswordEncrypted=
  SecurityConfig.CredentialEncrypted=
  SecurityConfig.NodeManagerPasswordEncrypted=
  ```

- Delete all lines except for the `JDBC.JDBCConnection.PasswordEncrypted=` line, as these pertain to the `domainInfo` and `topology` sections we deleted from the `source.yaml`

- Enter the JDBC Connection password for the `RIDERS` user pdb (this is can be found in the `./on-prems-setup/weblogic/env` file under `DS_PASSWORD`).

  Although the name is `PasswordEncrypted`, enter the plaintext password and WebLogic will encrypt it when updating the domain.

  the resulting file should look like:

  ```yaml
  JDBC.JDBCConnection.PasswordEncrypted=Nge29v2rv#1YtSIS#
  ```

- Save the file with `CTRL+x` and `y`

### 6.4) Update the WebLogic domain on OCI

The `update_domain.sh` script updates the target domain.

- It copies the `source.yaml` model file, `source.properties` variable file and the `source.zip` archive fileas well as the `install_wdt.sh` script and the `update_domain_as_oracle_user.sh` script to the target WebLogic Admin Server host

- It makes sure the files are owned by the `oracle` user and moved to the `oracle` user home.

- It runs the `install_wdt.sh` script through SSH

- and finally runs the `update_domain_as_oracle_user.sh` through SSH to update the WebLogic domain on OCI with the edited source files.

`update_domain_as_oracle_user.sh` script:
```bash
weblogic-deploy/bin/updateDomain.sh \
-oracle_home $MW_HOME \
-domain_home $DOMAIN_HOME \
-model_file source.yaml \
-variable_file source.properties \
-archive_file source.zip \
-admin_user weblogic \
-admin_url t3://$(hostname -i):9071
```

The `update_domain_as_oracle_user.sh` script runs the **WebLogic Deploy Tooling** script `updateDomain.sh` online, by providing the `-admin_url` flag.

**Note:** the url uses the `t3` protocol which is only accessible through the internal admin server port, which is `9071` on the latest WebLogic Marketplace stack, for older provisioning of the stack, the port may be `7001`

- Edit the `update_domain.sh` script to provide the `TARGET_WLS_ADMIN` **WebLogic Admin Server public IP**

  ```bash
  <copy>
  nano update_domain.sh
  </copy>
  ```
  Edit and then save with `CTRL+x` and `y`

- Run the `update_domain.sh` script

  You will be prompted to provide the `weblogic admin password` which is `welcome1`

<details><summary>View the output of the <code>update_domain.sh</code> script</summary>

```bash
Copying files over to the WLS admin server...
source.properties                                                           100%   56     0.7KB/s   00:00    
source.yaml                                                                 100% 1233    14.4KB/s   00:00    
source.zip                                                                  100% 8066    83.5KB/s   00:00    
install_wdt.sh                                                              100%  273     3.2KB/s   00:00    
update_domain_as_oracle_user.sh                                             100%  238     2.9KB/s   00:00    
Changing ownership of files to oracle user...
Installing WebLogic Deploy Tooling...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   632  100   632    0     0   2283      0 --:--:-- --:--:-- --:--:--  2289
100 1034k  100 1034k    0     0  2547k      0 --:--:-- --:--:-- --:--:-- 2547k
Archive:  weblogic-deploy.zip
   creating: weblogic-deploy/
   creating: weblogic-deploy/etc/
   creating: weblogic-deploy/lib/
   creating: weblogic-deploy/lib/python/
   creating: weblogic-deploy/lib/python/wlsdeploy/
   creating: weblogic-deploy/lib/python/wlsdeploy/util/
   creating: weblogic-deploy/lib/python/wlsdeploy/json/
   creating: weblogic-deploy/lib/python/wlsdeploy/yaml/
   creating: weblogic-deploy/lib/python/wlsdeploy/aliases/
   creating: weblogic-deploy/lib/python/wlsdeploy/exception/
   creating: weblogic-deploy/lib/python/wlsdeploy/logging/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/util/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/extract/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/encrypt/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/create/
   creating: weblogic-deploy/lib/typedefs/
   creating: weblogic-deploy/bin/
   creating: weblogic-deploy/lib/injectors/
   creating: weblogic-deploy/samples/
  inflating: weblogic-deploy/etc/logging.properties  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/model_context.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/cla_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/alias_entries.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/multi_tenant_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/custom_folder_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/topology_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/alias_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/wldf_resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/wlsroles_helper.py  
  inflating: weblogic-deploy/lib/python/validate.py  
  inflating: weblogic-deploy/bin/injectVariables.cmd  
  inflating: weblogic-deploy/bin/deployApps.sh  
  inflating: weblogic-deploy/lib/injectors/target.json  
  inflating: weblogic-deploy/lib/weblogic-deploy-core.jar  
  inflating: weblogic-deploy/lib/python/encrypt.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/weblogic_roles_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/yaml/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/alias_constants.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/custom_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/deployments_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/attribute_setter.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/rcu_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/library_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/model_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/encrypt/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/security_provider_creator.py  
  inflating: weblogic-deploy/lib/typedefs/RestrictedJRF.json  
  inflating: weblogic-deploy/bin/createDomain.cmd  
  inflating: weblogic-deploy/bin/encryptModel.cmd  
  inflating: weblogic-deploy/lib/injectors/port.json  
  inflating: weblogic-deploy/lib/injectors/credentials.json  
  inflating: weblogic-deploy/lib/python/update.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/getcreds.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/cla_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/enum.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/path_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/yaml/yaml_translator.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/alias_jvmargs.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/exception/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/logging/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/logging/log_collector.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/validator.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/topology_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/archive_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/jms_resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/log_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/topology_updater.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/atp_helper.py  
  inflating: weblogic-deploy/bin/extractDomainResource.cmd  
  inflating: weblogic-deploy/bin/discoverDomain.sh  
  inflating: weblogic-deploy/lib/python/deploy.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/string_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/model_translator.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/json/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/validation_codes.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/model_constants.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/exception/exception_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/coherence_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/multi_tenant_topology_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/common_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/mbean_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/variable_injector.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/applications_deployer.py  
  inflating: weblogic-deploy/lib/typedefs/JRF.json  
  inflating: weblogic-deploy/bin/shared.cmd  
  inflating: weblogic-deploy/bin/injectVariables.sh  
  inflating: weblogic-deploy/bin/updateDomain.sh  
  inflating: weblogic-deploy/lib/injectors/topology.json  
  inflating: weblogic-deploy/lib/python/create.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/model.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/weblogic_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/location_context.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/exception/expection_types.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/validation_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/global_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/beaninfo_constants.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/model_context_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/datasource_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/common_resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/encrypt/encryption_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/custom_folder_helper.py  
  inflating: weblogic-deploy/lib/typedefs/WLS.json  
  inflating: weblogic-deploy/bin/validateModel.cmd  
  inflating: weblogic-deploy/bin/createDomain.sh  
  inflating: weblogic-deploy/lib/injectors/url.json  
  inflating: weblogic-deploy/lib/antlr4-runtime-4.7.1.jar  
  inflating: weblogic-deploy/lib/python/extract_resource.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/variables.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/tool_exit.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/yaml/dictionary_list.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/aliases.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/usage_printer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/jms_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/targeting_types.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/filter_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/deployer_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/odl_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/extract/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/extract/domain_resource_extractor.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/domain_creator.py  
  inflating: weblogic-deploy/bin/extractDomainResource.sh  
  inflating: weblogic-deploy/bin/validateModel.sh  
  inflating: weblogic-deploy/samples/model_variable_injector.json  
  inflating: weblogic-deploy/lib/python/discover.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/dictionary_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/wlst_modes.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/password_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/logging/platform_logger.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/domain_info_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/string_output_stream.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/wlst_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/rcudbinfo_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/creator.py  
  inflating: weblogic-deploy/bin/deployApps.cmd  
  inflating: weblogic-deploy/bin/updateDomain.cmd  
  inflating: weblogic-deploy/bin/encryptModel.sh  
  inflating: weblogic-deploy/samples/custom_injector.json  
  inflating: weblogic-deploy/lib/python/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/model_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/json/json_translator.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/alias_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/multi_tenant_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/target_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/variable_injector_functions.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/multi_tenant_resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/domain_typedef.py  
  inflating: weblogic-deploy/lib/python/variable_inject.py  
  inflating: weblogic-deploy/bin/discoverDomain.cmd  
  inflating: weblogic-deploy/bin/shared.sh  
  inflating: weblogic-deploy/lib/variable_keywords.json  
  inflating: weblogic-deploy/lib/injectors/host.json  
  inflating: weblogic-deploy/LICENSE.txt  
Updating the domain...
JDK version is 1.8.0_251-b08
JAVA_HOME = /u01/jdk
WLST_EXT_CLASSPATH = /home/oracle/weblogic-deploy/lib/weblogic-deploy-core.jar
CLASSPATH = /home/oracle/weblogic-deploy/lib/weblogic-deploy-core.jar
WLST_PROPERTIES = -Djava.util.logging.config.class=oracle.weblogic.deploy.logging.WLSDeployCustomizeLoggingConfig -Dcom.oracle.cie.script.throwException=true 
/u01/app/oracle/middleware/oracle_common/common/bin/wlst.sh /home/oracle/weblogic-deploy/lib/python/update.py -oracle_home /u01/app/oracle/middleware -domain_home /u01/data/domains/nonjrf_domain -model_file source.yaml -variable_file source.properties -archive_file source.zip -admin_user weblogic -admin_url t3://10.0.3.3:9071 -domain_type WLS

Initializing WebLogic Scripting Tool (WLST) ...

Welcome to WebLogic Server Administration Scripting Shell

Type help() for help on available commands

####<May 25, 2020 1:55:47 AM> <INFO> <WebLogicDeployToolingVersion> <logVersionInfo> <WLSDPLY-01750> <The WebLogic Deploy Tooling updateDomain version is 1.7.3:master.4f1ebfc:Apr 03, 2020 18:05 UTC>
Please enter the WebLogic administrator password: welcome1
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05002> <Performing validation in TOOL mode for WebLogic Server version 12.2.1.4.0 and WLST ONLINE mode>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05003> <Performing model validation on the /home/oracle/source.yaml model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05005> <Performing archive validation on the /home/oracle/source.zip archive file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the domainInfo section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05009> <Model file /home/oracle/source.yaml does not contain a domainInfo section, validation of domainInfo was skipped.>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the topology section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05009> <Model file /home/oracle/source.yaml does not contain a topology section, validation of topology was skipped.>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the resources section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the appDeployments section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the kubernetes section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05009> <Model file /home/oracle/source.yaml does not contain a kubernetes section, validation of kubernetes was skipped.>
####<May 25, 2020 1:56:04 AM> <INFO> <filter_helper> <apply_filters> <WLSDPLY-20017> <No filter configuration file /home/oracle/weblogic-deploy/lib/model_filters.json>
####<May 25, 2020 1:56:04 AM> <INFO> <update> <__update_online> <WLSDPLY-09005> <Connecting to domain at t3://10.0.3.3:9071...>

####<May 25, 2020 1:56:06 AM> <INFO> <update> <__update_online> <WLSDPLY-09007> <Connected to domain at t3://10.0.3.3:9071>
####<May 25, 2020 1:56:07 AM> <INFO> <LibraryHelper> <install_domain_libraries> <WLSDPLY-12213> <The model did not specify any domain libraries to install>
####<May 25, 2020 1:56:07 AM> <INFO> <LibraryHelper> <extract_classpath_libraries> <WLSDPLY-12218> <The archive file /home/oracle/source.zip contains no classpath libraries to install>
####<May 25, 2020 1:56:07 AM> <INFO> <LibraryHelper> <install_domain_scripts> <WLSDPLY-12241> <The model did not specify any domain scripts to install>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_named_elements> <WLSDPLY-09608> <Updating JDBCSystemResource JDBCConnection>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_model_elements> <WLSDPLY-09604> <Updating JdbcResource for JDBCSystemResource JDBCConnection>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_model_elements> <WLSDPLY-09603> <Updating JDBCConnectionPoolParams for JdbcResource>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_model_elements> <WLSDPLY-09603> <Updating JDBCDataSourceParams for JdbcResource>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_model_elements> <WLSDPLY-09603> <Updating JDBCDriverParams for JdbcResource>
####<May 25, 2020 1:56:08 AM> <INFO> <DatasourceDeployer> <_add_named_elements> <WLSDPLY-09609> <Updating Properties user in JDBCDriverParams>
####<May 25, 2020 1:56:10 AM> <INFO> <ApplicationDeployer> <__deploy_app_online> <WLSDPLY-09316> <Deploying application SimpleDB>
####<May 25, 2020 1:56:14 AM> <INFO> <ApplicationDeployer> <__deploy_app_online> <WLSDPLY-09316> <Deploying application SimpleHTML>
####<May 25, 2020 1:56:17 AM> <INFO> <ApplicationDeployer> <__start_app> <WLSDPLY-09313> <Starting application SimpleDB>
####<May 25, 2020 1:56:21 AM> <INFO> <ApplicationDeployer> <__start_app> <WLSDPLY-09313> <Starting application SimpleHTML>

Issue Log for updateDomain version 1.7.3 running WebLogic version 12.2.1.4.0 online mode:

Total:       WARNING :     0    SEVERE :     0

updateDomain.sh completed successfully (exit code = 0)
```
</details>

### You're done!

### We can go check that the app deployed properly

- Go to the WebLogi Admin console at https://`ADMIN_SERVER_PUBLIC_IP`:7002/console

- Go to `deployments`: you should see the 2 applications deployed, and in the **active** state

  <img src="./images/oci-deployments.png" width="100%">

- Go to the SimpleDB application URL, which is the Load Balancer IP gathered on step [3.2) Gather the necessary WebLogic stack information](#3-2-gather-the-necessary-weblogic-stack-information) with the route `/SimpleDB/` like:
https://`LOAD_BALANCER_IP`/SimpleDB/

  <img src="./images/oci-simpledb-app.png" width="100%">


## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, June 04 2020


***To log issues***, submit an Github [issue](https://github.com/oracle/learning-library/issues/new?title=Weblogic%20to%20OCI%20livelab&body=Issue%20with%20Weblogic%20to%20OCI%20livelab%0A@streamnsight%0A).  Please provide the name of the workshop, the link, and the step along with details of the issue.
