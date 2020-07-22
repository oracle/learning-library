# Migrate Workloads to ATP-D using MV2ADB
## Introduction
Data Replication is an essential part of your efforts and tasks when you are migrating your Oracle databases on OCI. Move to Autonomous Database (MV2ADB) is a tool, permitting the data loading and migration from “on premises” to Autonomous Database Cloud leveraging Oracle Data Pump and with one command. Data Pump Import lets you import data from Data Pump files residing on the Oracle Cloud Infrastructure Object Storage. You can save your data to your Cloud Object Store and load them to Autonomous Database Cloud using “mv2adb”. 

This lab is a 3 step process – take export from source, upload the dumpfiles on object storage and import files into ATP-D. However, we would be performing all the 3 steps using a single command. In this lab we will use a 12c DBCS instance as source and an ATP-D instance as our target.

*Note: For using mv2adb for migration from source DB to ATPD, the source DB should be at lower version than ATP-D Database.*

### Objectives

As a LOB user
1. Establish connectivity from Source instance to Target instance.
2. Install and Configure MV2ADB tool on Source.
3. Run the MV2ADB config script to migrate workloads from Source to Target.

### Required Artifacts

- A pre-provisioned dedicated autonomous database instance. Refer to [Lab 7](?lab=lab-7-provisioning-databases).
- A pre-provisioned Source with connectivity to target ATP-D. We are using DBCS as Source here. 
- Download and transfer ATP-D Wallet to Source Machine. Refer to [Lab 8](?lab=lab-8-configuring-development-system) Step 2.
- A pre-generated Auth Token from the console. (Menu==>Identity==>Users==>User Details==>Auth Tokens==>Generate Tokens)

## STEP 1: Create a Bucket

- Login to the OCI tenancy. Goto Menu => Core Infrastructure => Oject Storage => Object Storage
   ![](./Images/Img13.png " ") 
   
- Ensure you are in the right compartment and Click on Create Bucket.
   ![](./Images/Img14.png " ") 

## STEP 2: Install Instant Client on the Source DBCS instance

- ssh into the Source DBCS instance

    ```
    <copy>
    ssh -i <private-key> opc@PublicIP
    </copy>
    ```
    
- Download the Instant Client RPM [here](https://www.oracle.com/database/technologies/instant-client/downloads.html). We used [Version 18.5.0.0.0 Basic Package ZIP](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html)
*Note: It is preferred to do this installation from root user.*

    ```
    <copy>
    sudo su - root
    scp -i <private key path> <full path of downloaded zip file> opc@<publicIP>:/home/opc/
    mv /home/opc/clientrpms.zip /root/
    unzip clientrpms.zip
    rpm -ivh clientrpms/oracle-instantclient18.5-basic-18.5.0.0.0-3.x86_64.rpm clientrpms/oracle-instantclient18.5-sqlplus-18.5.0.0.0-3.x86_64.rpm clientrpms/oracle-instantclient18.5-tools-18.5.0.0.0-3.x86_64.rpm
    </copy>
    ``` 
   ![](./Images/Img2.png " ")

The instant cient package containing Basic Package, SQLPlus Package and Tools Package is now installed.

## STEP 2: Check connectivity to the Target ATP-D instance from Source

- Download and transfer ATP-D DB Wallet to Source Machine (DBCS instance).  
*Note: We have downloaded the DB Wallet onto our local machine and uploaded it to object storage. We then used scp to transfer it to DBCS. Refer to [Lab 5](?lab=lab-5-configuring-development-system) Step 2.*

    ```
    <copy>
    mkdir -p /root/wallet
    scp -i <private key path> <full path of downloaded DB Wallet file> opc@<publicIP>:/home/opc/
    mv /home/opc/Wallet.zip /root/wallet/
    </copy>
    ```
   ![](./Images/Img3.png " ")
    
- Edit the sqlnet file to change the wallet directory to the new location of /root/wallet and export the following paths:

    ```
    <copy>
    export TNS_ADMIN=/root/wallet
    export LD_LIBRARY_PATH=/usr/lib/oracle/18.5/client64/lib:$LD_LIBRARY_PATH
    export PATH=/usr/lib/oracle/18.5/client64/bin:$PATH
    </copy>
    ```
 *Note: These paths may vary on your system. Pls check prior to performing export.*

   ![](./Images/Img4.jpg " ")

- Copy the connect string from tnsnames.ora file existing in the Wallet folder to connect to ATP-D instance.

    ```
    <copy>
    sqlplus ADMIN/<password of ATPD>@<connect string>
    SQL> exit
    </copy>
    ```

## STEP 3: Download and Install MV2ADB on Source DBCS instance.

- Download the MV2ADB rpm file [here](https://support.oracle.com/epmos/faces/DocContentDisplay?_afrLoop=291097898074822&id=2463574.1&_afrWindowMode=0&_adf.ctrl-state=v0102jx12_4). Platform specific rpm can be downloaded under the History Tab. 

- Transfer this file to your Source DBCS using scp.

    ```
    <copy>
    scp -i <private key path> <full path of downloaded RPM file> opc@<publicIP>:/home/opc/
    mv /home/opc/<RPM file> /root/<RPM file>
    </copy>
    ```
    
- Install the rpm using the given command from the directory where the rpm exists.

    ```
    <copy>
    sudo su -
    rpm -i <name of the rpm file downloaded>
    </copy>
    ```
   ![](./Images/Img5.jpg " ")

- Validate the installation. 

    ```
    <copy>
    sudo yum install tree (Optional Step - Do only if your Source is a Compute Instance)
    tree /opt/mv2adb/
    </copy>
    ```
   ![](./Images/Img6.jpg " ")

*Note: The cfg file created here will be used as a reference for our configuration file.*

## STEP 4: Encrypt Passwords

Generate encrypted passwords using the “mv2adb encpass” command for system password, Admin password and auth token (OCI Password) and copy the values to a safe location (Eg: Notepad).

    ```
    <copy>
    cd /opt/mv2adb
    ./mv2adb encpass
    </copy>
    ```
   ![](./Images/Img7.jpg " ")

## STEP 5: Run the Migration Script

- Take a backup of the existing configuration file and edit the DBNAME.mv2adb.cfg file.

    ```
    <copy>
    cd /opt/mv2adb/conf/
    cp DBNAME.mv2adb.cfg DBNAME.mv2adb.cfg_bkp
    vi DBNAME.mv2adb.cfg
    </copy>
    ```
#### Note: Edit the following parameters

    ```
    DB_CONSTRING =//<hostname>:1521/<servicename of DB>
    SYSTEM_DB_PASSWORD=<enc_password>
    SCHEMAS=<schemas to be migrated>
    REMAP=<Source tablespace>:<Target tablespace>
    DUMP_NAME=<name for your dump file>
    DUMP_PATH=<path to store your dump file>
    DUMP_FILES=<full path of dump file>
    OHOME=<Oracle Home Path>
    ICHOME=<Instant Client Path>
    ADB_NAME=<Name of Target>
    ADB_Password=<Encrypted Value>
    ADB_TARGET=ATPD
    ADB_CFILE=<location of ATPD Wallet file>
    ```
*Note: Click [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/ccTZey-FamcBZ02nCaU7J9yzy20c0a5UxCQf-3IciWE/n/atpdpreview11/b/mv2adb/o/samplesource.mv2adbfinal.cfg) to download a sample config file for reference.*
    
   ![](./Images/Img8.jpg " ")

Navigate to your console and get the OCI Details. 

   ![](./Images/Img15.jpg " ")
   
   ![](./Images/Img9.jpg " ")

- Run the migration script in auto mode.

    ```
    <copy>
    cd /opt/mv2adb
    ./mv2adb auto -conf /opt/mv2adb/conf/DBNAME.mv2adb.cfg
    </copy>
    ```
    
   ![](./Images/Img10.jpg " ")
   ![](./Images/Img11.jpg " ")

*Note: Migration of schema from source machine to Autonomous Database is complete*

## STEP 6: Validate the Data Migration

We had migrated a sample HR schema in this lab. Let's connect to the ATPD (Target) and validate the migration of data.

    ```
    <copy>
    echo "WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="/root/wallet")))" > /root/wallet/sqlnet.ora
    export TNS_ADMIN=/root/wallet
    export LD_LIBRARY_PATH=/usr/lib/oracle/18.5/client64/lib:$LD_LIBRARY_PATH
    export PATH=/usr/lib/oracle/18.5/client64/bin:$PATH
    sqlplus ADMIN/Password@<ATPD Connect String>
    SQL> select * from hr.sourcetable;
    </copy>
    ```
   
   ![](./Images/Img12.jpg " ")

## Acknowledgements

*Great Work! You have successfully migrated HR schema from source database to ATP-D. You can do the same and more by making appropriate changes to the cfg file for various parameters.*

- **Author** - Padma Priya Rajan, Navya M S & Jayshree Chatterjee
- **Last Updated By/Date** - Jayshree Chatterjee, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 
