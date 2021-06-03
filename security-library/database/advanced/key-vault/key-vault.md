# Oracle Key Vault (OKV)

## Introduction
This workshop introduces the various features and functionality of Oracle Key Vault (OKV). It gives the user an opportunity to learn how to configure this appliance to manage keys.

*Estimated Lab Time:* 55 minutes

*Version tested in this lab:* Oracle OKV 21.1

### Video Preview
Watch a preview of "*Introducing Oracle Key Vault 21 (January 2021)*" [](youtube:SfXQEwziyw4)

### Objectives
- Connect an Oracle DB (encrypted by TDE) to OKV
- Manage with OKV the existing DB Wallet
- Migrate the DB Wallet and manage the Online Keys by OKV

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

### Lab Timing (estimated)

| Step No. | Feature | Approx. Time | Details |
|--|------------------------------------------------------------|-------------|--------------------|
| 1| (Mandatory) TDE Prerequisites | <10 minutes||
| 2| Add an Endpoint | <10 minutes||
| 3| View the Contents of the OKV Virtual Wallet | <5 minutes||
| 4| Upload the TDE Wallet | 5 minutes | To backup the Oracle Wallet into Oracle Key Vault |
| 5| Migrate to Online Master Key | 5 minutes | To re-configure the database to communicate directly with Oracle Key Vault |
| 6| Create the OKV SEPS Wallet | <5 minutes||
| 7| Perform a ReKey Operation | 5 minutes||
| 8| (Optional) Reset the OKV Lab Config | <10 minutes||

<!-- Other OKV Labs
| 8a| Secret Password Management | 5 minutes||
| 8b| Perform Wallet_Download | 5 minutes | To return master keys to an Oracle Wallet |
| 8c| (Optional) Create a 2-node Multi-Master Cluster | 5 minutes||
-->

## **STEP 1**: (Mandatory) TDE Prerequisites

**Before beginning this lab**, make sure you have performed steps 1 to 4 of the Transparent Data Encryption (TDE) Livelabs!

If you didn't execute them yet, do it right now by following the instructions below:

1. Open a SSH session on your **DBSec-Lab VM as *oracle* user**

      ````
      <copy>sudo su - oracle</copy>
      ````

2. Go to the TDE scripts directory

      ````
      <copy>cd $DBSEC_LABS/tde</copy>
      ````

3. Make sure you have a cold-backup of your database (**the DB will reboot!**)

      ````
      <copy>./tde_backup_db.sh</copy>
      ````

   ![](../advanced-security/tde/images/tde-001.png " ")

4. Create the Keystore directories on the Operating System

      ````
      <copy>./tde_create_os_directory.sh</copy>
      ````

   ![](../advanced-security/tde/images/tde-002.png " ")

5. Use the database parameters to manage TDE (**the DB will reboot!**)

      ````
      <copy>./tde_set_tde_parameters.sh</copy>
      ````

   ![](../advanced-security/tde/images/tde-003.png " ")

6. Create the **Oracle Wallet** for the container database

      ````
      <copy>./tde_create_wallet.sh</copy>
      ````

   ![](../advanced-security/tde/images/tde-004.png " ")

7. Create the container database TDE Master Key (**MEK**)

      ````
      <copy>./tde_create_mek_cdb.sh</copy>
      ````

   ![](../advanced-security/tde/images/tde-005.png " ")

8. Create the pluggable database **pdb1** Master Key (MEK)

      ````
      <copy>./tde_create_mek_pdb.sh pdb1</copy>
      ````

   ![](../advanced-security/tde/images/tde-006.png " ")

9. Ceate the **Autologin** Oracle Wallet

      ````
      <copy>./tde_create_autologin_wallet.sh</copy>
      ````

   ![](../advanced-security/tde/images/tde-007.png " ")

10. You should now see all these file, including the **cwallet.sso** file

      ````
      <copy>./tde_view_wallet_on_os.sh</copy>
      ````   

   ![](./images/okv-201.png " ")

11. And the wallet in the database as to be set and available like this

      ````
      <copy>./tde_view_wallet_in_db.sh</copy>
      ````

   ![](./images/okv-202.png " ")

12. Now, your database is ready for the OKV labs!

## **STEP 2**: Add an Endpoint
First of all, we need Oracle Key Vault to know about our database server. We do this by creating it as an endpoint in OKV

1. Open a Web Browser at the URL *`https://<OKV-VM_@IP-Public>`*

2. Login to Oracle Key Vault Web Console as *`KVRESTADMIN`* with the password "*`T06tron.`*"

      ````
      <copy>KVRESTADMIN</copy>
      ````

      ````
      <copy>T06tron.</copy>
      ````

   ![](./images/okv-001.png " ")

3. Click [**Endpoints**]

   ![](./images/okv-002.png " ")

4. You will see that there are no endpoints available

   ![](./images/okv-003.png " ")

5. You will use the **OKVdeploy.tgz** file to deploy the utiliy to automate the processes

    - Open a SSH session on your DBSec-Lab VM as Oracle User

          ````
        <copy>sudo su - oracle</copy>
          ````

    - Go to the scripts directory

          ````
        <copy>cd $DBSEC_LABS/okv</copy>
          ````

    - Unpack the binary (we have already downloaded the file for you into the DBSecLab VM)

          ````
        <copy>./okv_unpack_restservice.sh</copy>
          ````

       ![](./images/okv-004.png " ")

    - Create the OKV utility config
        - Look at the current OKV config file **okvrestcli.ini**
        - Create the automated script **okv-ep.sh**
        - Add the OKV Admin user **KVRESTADMIN** (Password: "*`T06tron.`*")

          ````
        <copy>./okv_crea_config_script.sh</copy>
          ````

          ````
        <copy>T06tron.</copy>
          ````

       ![](./images/okv-005a.png " ")
       ![](./images/okv-005b.png " ")
       ![](./images/okv-005c.png " ")

        **Note**: This script okv-ep.sh will automate the process to create the Endpoint, the Oracle Wallet and deploy the OKV software

    - Add your **cdb1** database on DBSec-Lab VM as Endpoint

          ````
        <copy>./okv_add_endpoint.sh</copy>
          ````

       ![](./images/okv-006.png " ")

    - Before finishing, we have to change the Endpoint password

       - This is the password the OKV endpoint client software uses to communicate with the Key Vault Server
       - Modify the default Wallet password "*`change-on-install`*" by the new one "*`Oracle123`*"

          ````
        <copy>./okv_change_endpoint_pwd.sh</copy>
          ````

          ````
        <copy>change-on-install</copy>
          ````

          ````
        <copy>Oracle123</copy>
          ````

       ![](./images/okv-007.png " ")

6. Go back to your OKV Console, refresh screen and now you should see the Endpoint just added

   ![](./images/okv-008.png " ")

7. Click on the Endpoint name (here *`CDB1_ON_DBSECLAB`*)

8. In the **Default Wallet** section, confirm that the Wallet created in OKV is the default Wallet for this Endpoint

   ![](./images/okv-009.png " ")

9. Your Endpoint is now added!

## **STEP 3**: View the Contents of the OKV Virtual Wallet
Any time after adding the Endpoint to this host, you can run this script to view the contents of the Virtual Wallet in Oracle Key Vault

1. Go back to your SSH session and view the Wallet contents on the **Operating System**

      ````
    <copy>./okv_view_wallet_on_os.sh</copy>
      ````

   ![](./images/okv-010.png " ")

2. ... within the **database**  (in `V$ENCRYPTION_WALLET`)

      ````
    <copy>./okv_view_wallet_in_db.sh</copy>
      ````

   ![](./images/okv-011.png " ")

3. ... and finally in **Key Vault**

      ````
    <copy>./okv_view_wallet_in_kv.sh</copy>
      ````

   ![](./images/okv-012.png " ")

## **STEP 4**: Upload the TDE Wallet

Typically, the first thing that users will do is upload their existing Oracle Wallets (**ewallet.p12** files) to Oracle Key Vault

1. Upload the Wallet to Oracle Key Vault (as reminder, the password is "*`Oracle123`*")

      ````
    <copy>./okv_upload_wallet.sh</copy>
      ````

      ````
    <copy>Oracle123</copy>
      ````

   ![](./images/okv-013.png " ")

2. Now, view the new contents of the virtual Wallet in the database

      ````
    <copy>./okv_view_wallet_in_db.sh</copy>
      ````

   ![](./images/okv-014.png " ")

3. ... and in Key Vault

      ````
    <copy>./okv_view_wallet_in_kv.sh</copy>
      ````

   ![](./images/okv-015.png " ")

4. Go back to the OKV Web Console as *`KVRESTADMIN`* to have a look of these information

   ![](./images/okv-001.png " ")

5. Click [**Keys & Wallets**]

   ![](./images/okv-016.png " ")

6. Click on *`CDB1`*

   ![](./images/okv-017.png " ")

7. In the section **Wallet Contents** you can **see all your Wallet contents just uploaded**

   ![](./images/okv-018.png " ")

    **Note:** It's exactly the same as what you can see from the script `okv_view_wallet_in_kv.sh`

## **STEP 5**: Migrate to Online Master Key

Once you have uploaded the Oracle Wallet files into OKV Server, you can migrate from storing our Master Keys in Wallet files to querying them from Oracle Key Vault

1. Go back to your SSH session and migrate the virtual Wallet to Online Master Key. In this step, we set the `TDE_CONFIGURATION` initialization parameters from `KEYSTORE_CONFIGURATION=FILE` to `KEYSTORE_CONFIGURATION=OKV|FILE`. This is a dynamic parameter so we do not need to restart the database.

      ````
    <copy>./okv_migrate_wallet_to_kv.sh</copy>
      ````

   ![](./images/okv-019.png " ")

2. Now, view the contents of the Wallet
    - ... in the database

          ````
        <copy>./okv_view_wallet_in_db.sh</copy>
          ````

           ![](./images/okv-020.png " ")

      **Note:** You will now see rows for OKV!

    - ... and in Key Vault

          ````
        <copy>./okv_view_wallet_in_kv.sh</copy>
          ````

           ![](./images/okv-021.png " ")

      **Note:** You will now see rows for TDE MEK migrated!

3. Once you are comfortable, you can delete the existing Wallet files in `$TDE_HOME`. To be safe, we will make a temporary backup directory into `$TDE_HOME/backup` and move the wallet-related files to it. If you want to actually delete it after you have verified everything was successful you can.

      ````
    <copy>./okv_delete_wallet_files.sh</copy>
      ````

   ![](./images/okv-022.png " ")

4. Go back to the OKV Web Console as *`KVRESTADMIN`* to have a look of these information

   ![](./images/okv-001.png " ")

5. Click [**Keys & Wallets**]

   ![](./images/okv-016.png " ")

6. Click on *`CDB1`*

   ![](./images/okv-017.png " ")

7. In the section **Wallet Contents** you can **see all your Wallet contents just migrated**

   ![](./images/okv-023.png " ")
   ![](./images/okv-024.png " ")

    **Note:**
    - On the right-bottom corner, click on the 'Next' button to see the 2nd page of results
    - It's exactly the same as what you can see from the script `okv_view_wallet_in_kv.sh`

## **STEP 6**: Create the OKV SEPS Wallet

It is often necessary to make connections to the database from shell scripts held on the filesystem. This can be a major security issue if these scripts contain the database connection details. One solution is to use OS Authentication, and Oracle gives you the option of using a **Secure External Password Store (SEPS)** where the Oracle login credentials are stored in a client-side Oracle Wallet. Here, this will enable seperation of duties between DBAs who no longer need to know the OKV password and the OKV administrators!

1. Put the OKV Endpoint password into the SEPS Wallet

      ````
    <copy>./okv_add_kv_pwd_to_seps.sh</copy>
      ````

   ![](./images/okv-025.png " ")

    **Note:** Now, the SEPS Wallet (`${SEPS_WALLET_DIR}/cwallet.sso`) has stored the OKV Password

2. Finish to set the SEPS Wallet in the database by adding secret for OKV autologin keystore

      ````
    <copy>./okv_setup_external_store.sh</copy>
      ````

   ![](./images/okv-026.png " ")

    **Note:** See the date of the TDE Wallet auto_login (`${TDE_HOME}/cwallet.sso`), now it has stored the OKV password!

3. Now you can manage the keystore by logging in via the external store and without disclosing the password

## **STEP 7**: Perform a Rekey Operation

You must create a Master Key for the container database before continuing. Each pluggable database must have their own master key as well (except for `PDB$SEED`)

1. Go back to your SSH session and rekey the **container database** TDE Master Key

      ````
    <copy>./okv_online_cdb_rekey.sh</copy>
      ````

   ![](./images/okv-027.png " ")

    **Note:**
    - After creating the SEPS Wallet in the previous Lab, now you can log in via the "External Store" command
    - Don't forget to put an explicit Tag to find your rekey more easily

2. Now, rekey a Master Key for the pluggable database **pdb1**

      ````
    <copy>./okv_online_pdb_rekey.sh pdb1</copy>
      ````

   ![](./images/okv-028.png " ")

3. If you want, you can do the same for **pdb2**. This is not a requirement and it might be helpful to show some databases with TDE and some without!

      ````
    <copy>./okv_online_pdb_rekey.sh pdb2</copy>
      ````

4. Now, view the new contents of the virtual Wallet in Key Vault

      ````
    <copy>./okv_view_wallet_in_kv.sh</copy>
      ````

   ![](./images/okv-029.png " ")

5. Go back to the OKV Web Console as *`KVRESTADMIN`* to have a look of these information

   ![](./images/okv-001.png " ")

6. Click [**Keys & Wallets**]

   ![](./images/okv-016.png " ")

7. Click on *`CDB1`*

   ![](./images/okv-017.png " ")

8. In the section **Wallet Contents**, on the right-bottom corner, click on the 'Next' button

   ![](./images/okv-030.png " ")

9. On the 2nd page of results, you can see at the bottom your rekeyed Master Keys for **cdb1** and **pdb1** (and pdb2 if you did it)

   ![](./images/okv-031.png " ")

10. Now you have rekeyed the Master Key for the container and pluggable database(s)!

## **STEP 8**: (Optional) Reset the OKV Lab Config

1. Drop the Endpoint and Wallet created in OKV during this lab

      ````
    <copy>./okv_reset_config.sh</copy>
      ````

   ![](./images/okv-050.png " ")

2. Reset OKV binaries

      ````
    <copy>
   rm -Rf $OKV_HOME
   rm -Rf $OKV_RESTHOME/!(*.tgz)
   ll $OKV_RESTHOME
    </copy>
      ````

   ![](./images/okv-051.png " ")

    **Note:** Now you can perform again this lab **from Step 2**

3. Only if you want to clean TDE also, so you can restore the DB like before-TDE

   - Go to the TDE scripts directory

      ````
      <copy>cd $DBSEC_LABS/tde</copy>
      ````

   - First, execute this script to restore the pfile

      ````
      <copy>./tde_restore_init_parameters.sh</copy>
      ````

    ![](../advanced-security/tde/images/tde-025.png " ")


   - Second, restore the database (this may take some time)

      ````
      <copy>./tde_restore_db.sh</copy>
      ````

    ![](../advanced-security/tde/images/tde-026.png " ")

   - Third, delete the associated Oracle Wallet files

      ````
      <copy>./tde_delete_wallet_files.sh</copy>
      ````

    ![](../advanced-security/tde/images/tde-027.png " ")

   - Fourth, start the container and pluggable databases

      ````
      <copy>./tde_start_db.sh</copy>
      ````

    ![](../advanced-security/tde/images/tde-028.png " ")

       **Note**: This should have restored your database to it's pre-TDE state!

   - Finally, verify the initialization parameters don't say anything about TDE

      ````
      <copy>./tde_check_init_params.sh</copy>
      ````

    ![](../advanced-security/tde/images/tde-029.png " ")

   - Go back to OKV scripts directory and view the Wallet contents on the **database**

      ````
    <copy>
    cd $DBSEC_LABS/okv
    ./okv_view_wallet_in_db.sh</copy>
      ````

   ![](./images/okv-052.png " ")


- Now, your database is restored to the point in time prior to enabling TDE and you can perform again this lab **from Step 1** if you want!

<!-- Other OPTIONAL OKV Labs

**STEP 8a**: Perform  Wallet Download
To return master keys to an Oracle Wallet... This does not disable the Online Master Key mode

**STEP 8b**: (Optional) Create a 2-node Multi-Master Cluster
Oracle provides deployment recommendations for deployments that have two or more nodes.

- **2-Node Deployment Recommendations**

    - Use a 2-node deployments for the following situations
        - Non-critical environments, such as test and development
        - Simple deployment of read-write pairs with both nodes active, replacing classic primary-standby
        - Single data center environments

    - Considerations for a two-node deployment
        - Availability is provided by multiple nodes
        - Maintenance will require down time
        - Good network connectivity between data centers is mandatory

- **3-Node Deployment Recommendations**

    - Use a 3-node deployment for the following situations
        - Single data center environments with minimal downtime requirement
        - Single read-write pair with additional read-only node to handle load
        - One read-only node is available for zero downtime during maintenance

    - Considerations for a three-node deployment
        - Take regular backups to remove destinations for disaster recovery

- **4 or More Node Deployment Recommendations**

    - Use a deployment of four or more nodes for the the following situations
        - Large data centers distributed across geographical locations
        - Deployment of read-write pairs with pair members spanning geography

    - Considerations for a large deployment
        - Availability is provided by multiple nodes
        - Additional read-only nodes can be used to handle load
        - Good network connectivity between data centers is mandatory

-->

You may now [proceed to the next lab](#next)..

## **Appendix**: About the Product
### **Overview**

Oracle Key Vault is a full-stack, security-hardened software appliance built to centralize the management of keys and security objects within the enterprise.

Oracle Key Vault is a robust, secure, and standards-compliant key management platform, where you can store, manage, and share your security objects.

   ![](./images/okv-concept.png " ")

Security objects that you can manage with Oracle Key Vault include as encryption keys, Oracle wallets, Java keystores (JKS), Java Cryptography Extension keystores (JCEKS), and credential files.

Oracle Key Vault centralizes encryption key storage across your organization quickly and efficiently. Built on Oracle Linux, Oracle Database, Oracle Database security features like Oracle Transparent Data Encryption, Oracle Database Vault, Oracle Virtual Private Database, and Oracle GoldenGate technology, Oracle Key Vault's centralized, highly available, and scalable security solution helps to overcome the biggest key-management challenges facing organizations today. With Oracle Key Vault you can retain, back up, and restore your security objects, prevent their accidental loss, and manage their lifecycle in a protected environment.

Oracle Key Vault is optimized for the Oracle Stack (database, middleware, systems), and Advanced Security Transparent Data Encryption (TDE). In addition, it complies with the industry standard OASIS Key Management Interoperability Protocol (KMIP) for compatibility with KMIP-based clients.

You can use Oracle Key Vault to manage a variety of other endpoints, such as MySQL TDE encryption keys.

Starting with Oracle Key Vault release 18.1, a new multi-master cluster mode of operation is available to provide increased availability and support geographic distribution.

The multi-master cluster nodes provide high availability, disaster recovery, load distribution, and geographic distribution to an Oracle Key Vault environment.

An Oracle Key Vault multi-master cluster provides a mechanism to create pairs of Oracle Key Vault nodes for maximum availability and reliability.

   ![](./images/okv-cluster-concept.png " ")

Oracle Key Vault supports two types of mode for cluster nodes: read-only restricted mode or read-write mode.

- **Read-only restricted mode**

  In this mode, only non-critical data can be updated or added to the node. Critical data can be updated or added only through replication in this mode. There are two situations in which a node is in read-only restricted mode:
    - A node is read-only and does not yet have a read-write peer.
    - A node is part of a read-write pair but there has been a breakdown in communication with its read-write peer or if there is a node failure. When one of the two nodes is non-operational, then the remaining node is set to be in the read-only restricted mode. When a read-write node is again able to communicate with its read-write peer, then the node reverts back to read-write mode from read-only restricted mode.

- **Read-write mode**

This mode enables both critical and non-critical information to be written to a node. A read-write node should always operate in the read-write mode.

You can add read-only Oracle Key Vault nodes to the cluster to provide even greater availability to endpoints that need Oracle wallets, encryption keys, Java keystores, certificates, credential files, and other objects.

An Oracle Key Vault multi-master cluster is an interconnected group of Oracle Key Vault nodes. Each node in the cluster is automatically configured to connect with all the other nodes, in a fully connected network. The nodes can be geographically distributed and Oracle Key Vault endpoints interact with any node in the cluster.

This configuration replicates data to all other nodes, reducing risk of data loss. To prevent data loss, you must configure pairs of nodes called read-write pairs to enable bi-directional synchronous replication. This configuration enables an update to one node to be replicated to the other node, and verifies this on the other node, before the update is considered successful. Critical data can only be added or updated within the read-write pairs. All added or updated data is asynchronously replicated to the rest of the cluster.

After you have completed the upgrade process, every node in the Oracle Key Vault cluster must be at Oracle Key Vault release 18.1 or later, and within one release update of all other nodes. Any new Oracle Key Vault server that is to join the cluster must be at the same release level as the cluster.

The clocks on all the nodes of the cluster must be synchronized. Consequently, all nodes of the cluster must have the Network Time Protocol (NTP) settings enabled.

Every node in the cluster can serve endpoints actively and independently while maintaining an identical dataset through continuous replication across the cluster. The smallest possible configuration is a 2-node cluster, and the largest configuration can have up to 16 nodes with several pairs spread across several data centers.

### **Benefits of Using Oracle Key Vault**
- Oracle Key Vault helps you to fight security threats, centralize key storage, and centralize key lifecycle management
- Deploying Oracle Key Vault in your organization will help you accomplish the following:
- Manage the lifecycle for endpoint security objects and keys, which includes key creation, rotation, deactivation, and removal
- Prevent the loss of keys and wallets due to forgotten passwords or accidental deletion
- Share keys securely between authorized endpoints across the organization
- Enroll and provision endpoints easily using a single software package that contains all the necessary binaries, configuration files, and endpoint certificates for mutually authenticated connections between endpoints and Oracle Key Vault
- Work with other Oracle products and features in addition to Transparent Data Encryption (TDE), such as Oracle Real Application Clusters (Oracle RAC), Oracle Data Guard, pluggable databases, and Oracle GoldenGate. Oracle Key Vault facilitates the movement of encrypted data using Oracle Data Pump and transportable tablespaces, a key feature of Oracle Database
- Oracle Key Vault multi-master cluster provides additional benefits, such as:
- Maximum key availability by providing multiple Oracle Key Vault nodes from which data may be retrived
- Zero endpoint downtime during Oracle Key Vault multi-master cluster maintenance

## Want to Learn More?
Technical Documentation:
- [Oracle Key Vault 21](https://docs.oracle.com/en/database/oracle/key-vault/21.1/index.html)
- [Oracle Key Vault 21 - Multimaster](https://docs.oracle.com/en/database/oracle/key-vault/21.1/okvag/multimaster_concepts.html#GUID-E1A92D83-760F-470F-877F-D769169C6ABC)

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Peter Wahl, Rene Fontcha
- **Last Updated By/Date** - Hakim Loumi, Database Security PM - May 2021
