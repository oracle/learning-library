# Oracle Transparent Data Encryption (TDE)

## Introduction
This workshop introduces the various features and functionality of Oracle Transparent Data Encryption (TDE). It gives the user an opportunity to learn how to configure those features in order to encrypt sensitive data.

*Estimated Lab Time:* 45 minutes

*Version tested in this lab:* Oracle DB 19.8

### Video Preview
Watch a preview of "*Understanding Oracle Transparent Data Encryption (TDE) - Part1 (January 2020)*" [](youtube:avNWykLpic4)

### Objectives
- Take a cold backup of the database to enable db restore if needed
- Enable Transparent Data Encryption in the database
- Encrypt data using Transparent Data Encryption

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup (Free Tier and Paid Oracle Cloud Accounts Only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

### Lab Timing (estimated)
| Step No. | Feature | Approx. Time |
|--|------------------------------------------------------------|-------------|
| 1 | Allow DB Restore | 5 minutes  |
| 2 | Create Keystore | 5 minutes |
| 3 | Create Master Key | 5 minutes |
| 4 | Create Auto-login Wallet | 5 minutes |
| 5 | Encrypt Existing Tablespace | 5 minutes |
| 6 | Encyrpt All New Tablespaces | 5 minutes |
| 7 | Rekey Master Key | 5 minutes |
| 8 | View Keystore Details | 5 minutes |
| 9 | (Optional) Restore Before TDE | 5 minutes |

## **STEP 1**: Allow DB Restore

1. Open a SSH session on your DBSec-Lab VM as Oracle User

      ````
      <copy>sudo su - oracle</copy>
      ````

2. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Allow_DB_Restore</copy>
      ````

3. Run the backup command:

      ````
      <copy>./01_backup_db.sh</copy>
      ````

   ![](./images/tde-001.png " ")

4. Once it has completed, it will automatically restart the container and pluggable databases

       **Note**:
       - If you have executed this script before and there is an existing backup file, the script will not complete
       - You must manually manage the existing backup (delete or move) before running this script again

## **STEP 2**: Create Keystore

1. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Create_Software_Keystore</copy>
      ````

2. Run this script to create the directory on the operating system:

      ````
      <copy>./01_create_os_directory.sh</copy>
      ````

   ![](./images/tde-002.png " ")

3. Use the database parameters to manage TDE. This will require a database restart for one of the parameters to take effect. The script will perform the reboot for you.

      ````
      <copy>./02_set_tde_parameters.sh</copy>
      ````

   ![](./images/tde-003.png " ")

4. Create the software keystore (Oracle Wallet) for the container database. You will see the status result goes from `NOT_AVAILABLE` to `OPEN_NO_MASTER_KEY`.

      ````
      <copy>./03_create_wallet.sh</copy>
      ````

   ![](./images/tde-004.png " ")

5. Now, your wallet has been created!

## **STEP 3**: Create Master Key

1. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Create_Master_Key</copy>
      ````

2. To create the container database TDE master key, run the following command:

      ````
      <copy>./01_create_cdb_mkey.sh</copy>
      ````

   ![](./images/tde-005.png " ")

3. To create a master key for the pluggable database `PDB1`, run the following command:

      ````
      <copy>./02_create_pdb_mkey.sh pdb1</copy>
      ````

   ![](./images/tde-006.png " ")

4. If you want, you can do the same for `PDB2`. This is not a requirement though. It might be helpful to show some databases with TDE and some without.

      ````
      <copy>./02_create_pdb_mkey.sh pdb2</copy>
      ````

   ![](./images/tde-007.png " ")

5. Now, you have a master key and you can begin encrypting tablespaces or column!

## **STEP 4**: Create Auto-login Wallet

1. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Create_Autologin_Wallet</copy>
      ````

2. Then run the script to view the wallet on the operating system. Notice there is no `cwallet.sso`, there will be when we create the auto login wallet.

      ````
      <copy>./01_view_wallet_on_os.sh</copy>
      ````

   ![](./images/tde-010.png " ")

3. You can view what the wallet looks like in the database

      ````
      <copy>./02_view_wallet_in_db.sh</copy>
      ````

   ![](./images/tde-011.png " ")

5. Now, create the autologin wallet

      ````
      <copy>./03_create_autologin_wallet.sh</copy>
      ````

   ![](./images/tde-012.png " ")

6. Run the same queries... You should now see the `cwallet.sso` file:

      ````
      <copy>./04_view_wallet_on_os.sh</copy>
      ````   

   ![](./images/tde-013.png " ")

       **Note**: Now you should see the `*.sso` file

7. And no changes to the wallet in the database

      ````
      <copy>./05_view_wallet_in_db.sh</copy>
      ````

   ![](./images/tde-014.png " ")

8. Now your Autologin is created!

## **STEP 5**: Encrypt Existing Tablespace

1. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Encrypt_Existing_Tablespace</copy>
      ````

2. Use the Linux command, strings, to view the data in the data file, `empdata_prod.dbf` that is associated with the `EMPDATA_PROD` tablespace. This is an operating system command that bypasses the database to view the data. This is called a 'side-channel attack' because the database is unaware of it.

      ````
      <copy>./01_Search_Strings_Plain_Text.sh</copy>
      ````

   ![](./images/tde-015.png " ")

3. Next, encrypt the data by encrypting the entire tablespace:

      ````
      <copy>./02_Encrypt_Tablespace.sh</copy>
      ````

   ![](./images/tde-016.png " ")

4. And finally, try the side-channel attack again

      ````
      <copy>./03_Search_Strings_Encrypted.sh</copy>
      ````

   ![](./images/tde-017.png " ")

5. You will see that all of the data is now encrypted!

## **STEP 6**: Encyrpt All New Tablespaces

1. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Encrypt_All_New_Tablespaces</copy>
      ````

2. First, check the existing initialization parameters

      ````
      <copy>./01_Check_Init_Params.sh</copy>
      ````

   ![](./images/tde-018.png " ")

3. Next, change the init parameter `encrypt_new_tablespaces` to be `ALWAYS` so all new tablespaces are encrypted.

      ````
      <copy>./02_Encrypt_All_New_Tablespaces.sh</copy>
      ````

   ![](./images/tde-019.png " ")

4. Finally, create a tablespace to test it. The tablespace `TEST` will be created without specifying the encryption parameters (the default encryption is `AES128`) and will be dropped after.

      ````
      <copy>./03_Create_New_Tablespace.sh</copy>
      ````

   ![](./images/tde-020.png " ")

5. Now, your new Tablespaces will be encrypted by default!

## **STEP 7**: Rekey Master Key

1. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Rekey_Master_Key</copy>
      ````

2. To rekey the container database TDE master key, run the following command:

      ````
      <copy>./01_rekey_cdb_mkey.sh</copy>
      ````

3. To rekey a master key for the pluggable database `PDB1`, run the following command:

      ````
      <copy>./02_rekey_pdb_mkey.sh pdb1</copy>
      ````

4. If you want, you can do the same for `PDB2`

      ````
      <copy>./02_rekey_pdb_mkey.sh pdb2</copy>
      ````

       **Note**:
       - This is not a requirement though
       - It might be helpful to show some databases with TDE and some without

5. Now that you have a master key, you can begin encrypting tablespaces or column!

## **STEP 8**: View Keystore Details

1. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/View_Software_Keystore</copy>
      ````

2. Once you have a keystore, you can run either of these scripts. You will notice there are multiple copies of the `ewallet.p12` file. Every time you make a change, including create or rekey, the `ewallet.p12` file is backed up. You will also see the contents of the wallet file by using `orapki`

   - View the OS files related to the keystore

      ````
      <copy>./01_view_wallet_on_os.sh</copy>
      ````

   ![](./images/tde-008.png " ")

   - View the keystore data in the database

      ````
      <copy>./02_view_wallet_in_db.sh</copy>
      ````

   ![](./images/tde-009.png " ")

## **STEP 9**: (Optional) Restore Before TDE
**Attention: DO NOT run this lab if you want perfoming Oracle Key Vault labs later!**

1. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Restore_Before_TDE</copy>
      ````

2. First, execute this script to restore the pfile

      ````
      <copy>./01_restore_init_parameters.sh</copy>
      ````

3. Second, restore the database (this may take some time)

      ````
      <copy>./02_restore_db.sh</copy>
      ````

4. Third, delete the associated wallet files

      ````
      <copy>./03_delete_wallet_files.sh</copy>
      ````

5. Finally, start the container and pluggable databases

      ````
      <copy>./04_start_db.sh</copy>
      ````

6. This should have restored your database to it's pre-TDE state

7. Verify the initialization parameters don't say anything about TDE

      ````
      <copy>./05_check_init_params.sh</copy>
      ````
8. Now, your database is restored to the point in time prior to enabling TDE!

You may now proceed to the next lab.

## **Appendix**: About the Product
### **Overview**

Hard-coded within the Oracle Database core product, this features is part of the *Advanced Security Option (ASO)*

TDE Enables you to encrypt data so that only an authorized recipient can read it.

Use encryption to protect sensitive data in a potentially unprotected environment, such as data you placed on backup media that is sent to an off-site storage location. You can encrypt individual columns in a database table, or you can encrypt an entire tablespace.

After the data is encrypted, this data is transparently decrypted for authorized users or applications when they access this data. TDE helps protect data stored on media (also called data at rest) in the event that the storage media or data file is stolen.

Oracle Database uses authentication, authorization, and auditing mechanisms to secure data in the database, but not in the operating system data files where data is stored. To protect these data files, Oracle Database provides Transparent Data Encryption (TDE). TDE encrypts sensitive data stored in data files. To prevent unauthorized decryption, TDE stores the encryption keys in a security module external to the database, called a keystore.

You can configure Oracle Key Vault as part of the TDE implementation. This enables you to centrally manage TDE keystores (called TDE wallets in Oracle Key Vault) in your enterprise. For example, you can upload a software keystore to Oracle Key Vault and then make the contents of this keystore available to other TDE-enabled databases.

   ![](./images/aso-concept-tde.png " ")

### **Benefits of Using Transparent Data Encryption**
- As a security administrator, you can be sure that sensitive data is encrypted and therefore safe in the event that the storage media or data file is stolen
- Using TDE helps you address security-related regulatory compliance issues
- You do not need to create auxiliary tables, triggers, or views to decrypt data for the authorized user or application. Data from tables is transparently decrypted for the database user and application. An application that processes sensitive data can use TDE to provide strong data encryption with little or no change to the application
- Data is transparently decrypted for database users and applications that access this data. Database users and applications do not need to be aware that the data they are accessing is stored in encrypted form
- You can encrypt data with zero downtime on production systems by using `Online Table Redefinition` or you can encrypt it offline during maintenance periods (see `Oracle Database Administrator’s Guide` for more information about `Online Table Redefinition`)
- You do not need to modify your applications to handle the encrypted data. The database manages the data encryption and decryption
- Oracle Database automates TDE master encryption key and keystore management operations. The user or application does not need to manage TDE master encryption keys

## Want to Learn More?
Technical Documentation
  - [Transparent Data Encryption (TDE) 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/asoag/asopart2.html)

Video
  - *Understanding Oracle Transparent Data Encryption (TDE) - Part2 (February 2020)* [](youtube:aUfwG5MIMNU)

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Gian Sartor, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
