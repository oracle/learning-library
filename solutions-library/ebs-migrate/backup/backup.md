# Create a Backup with the Oracle E-Business Suite Cloud Backup Module

## Introduction

In this section, you will run the Oracle E-Business Suite Cloud Backup Module, EBSCloudBackup.pl, to create a backup of your on-premises Oracle E-Business Suite environment on Oracle Cloud Infrastructure Backup Service.

**Estimated Lab Time:** 30 minutes (with about 2.5 hours of waiting during the backup)

### **Objectives**

In this lab, you will:

* Create a Backup of the source E-Business Suite Environment.
* Provision an EBS instance in Cloud Manager from the backup.

### **Prerequisites**

* Complete Lab 3: **Install the Oracle E-Business Suite Cloud Backup Module**.
* key-data.txt file documented with following information:

**From Provisioning your Cloud Manager Instance You Should have recorded:**

* `Oracle_Cloud_Region_Identifier`
* `Oracle_Cloud_Tenancy_Name`
* `Oracle_Cloud_Tenancy_OCID`
* `Cloud_Manager_Admin_User_OCID`
* `Cloud_Manager_Admin_Fingerprint`
* `Oracle_Cloud_Compartment_OCID`
* `Cloud_Manager_Instance_public_IP`

**From your source EBS Instance**

* `Source_EBS_Instance_public_IP`
* `Source_EBS_Instance_private_IP`
* `Fully_Qualified_Hostname` (In this Lab: apps.example.com)
* `apps_password` (In this Lab: apps)
* `weblogic_password` (In this Lab: welcome1)



## **STEP 1:** Create a Backup with the Oracle E-Business Suite Cloud Backup Module

**FOLLOW ALONG AND READ CLOSELY, THERE ARE MANY VALUES AND STEPS THAT MUST BE COMPLETED ACCURATELY TO CREATE THE BACKUP.**

The EBSCloudBackup.pl script validates key requirements before beginning the actual backup, including checking the available space, checking connections, verifying that archive logging is enabled, and verifying that mandatory patches have been applied. Check that these requirements are in place before you start running the script, so that the script can proceed with creating the backup after performing the validations.

To ensure a successful backup, avoid activities that could interfere with the backup process while EBSCloudBackup.pl is running.

  - Do not apply patches. Note that this restriction applies not only to   - Oracle E-Business Suite patches, but to application technology stack and database patches as well. If you are running Oracle E-Business Suite Release 12.2, you must complete any active patching cycle before you begin the backup process.
  - Do not remove or move archive logs.
  - Do not shut down application tier or database tier services.
  - Do not perform configuration updates.

1. Connect to the source EBS environment.

    SSH into the source EBS instance from your local machine by using the IP address and the SSH private key you used during the deployment of the source EBS instance . 

    ```
    <copy>
    ssh -i <private_ssh_key_filepath> opc@<Source_EBS__public_IP>
    </copy>
    ```

    Change to the Oracle user (if not already) and navigate to the Remote Clone directory

    ```
    <copy>
    sudo su - oracle
    cd /u01/install/APPS/stage/31254259/RemoteClone
    </copy>
    ```

1. Before you start running EBSCloudBackup.pl, inform users that a backup is being taken. Request that they do not perform any destructive operation on the file system, such as removing directories, until the backup is complete.

2. Temporarily stop any application tier or database backup cron jobs that are scheduled. If you have not already done so, change to the RemoteClone directory on the backup module server.

3. Run the EBSCloudBackup.pl script using the following command in the RemoteClone directory.

    **NOTE:** If you are using an Oracle E-Business Suite application tier node or database tier node as the backup module server, you should not source the Oracle E-Business Suite environment before running the Oracle E-Business Suite Cloud Backup Module.

    ```
    <copy>
    3pt/perl/bin/perl EBSCloudBackup.pl
    </copy>
    ```

    If you run into a symbol lookup error stating "undefined symbol: Perl\_xs\_handshake," run the following command and then rerun the above command.

    ```
    <copy>
    unset PERL5LIB
    </copy>
    ```

    ![](./images/25.png " ")

4. On the first screen, choose **Option 1**, "Create E-Business Suite Backup and Upload to Oracle Cloud Infrastructure".

    ![](./images/26.png " ")

5. Next, indicate whether communication between the source database server and Oracle Cloud Infrastructure Object Storage takes place through a proxy and you need to specify the proxy details.
    We are not going to use a proxy, choose **Option 2**.

    ![](./images/27.png " ")

6. Enter the details for the database tier of the source Oracle E-Business Suite environment.

    1. When entering the host name for the source database server, ensure that you enter the fully qualified domain name.

    2. Specify an operating system username to connect to the source database server using SSH. 
    
    3. You can choose to authenticate the OS user with either a password, a custom private SSH key and passphrase, or the default SSH key ($HOME/.ssh/id\_rsa) on the backup module server. 
    
        The prompts for the custom private key and passphrase appear only if you do not enter an OS user password. **Do not enter a password or a custom private key.** The script indicates that the default SSH key will be used and prompts you to confirm continuing with the SSH key at the indicated location.

    4. Enter the location of the context file on the database tier, including the complete file path.

    5. Specify whether Transparent Data Encryption (TDE) is enabled for the source database. If TDE is enabled, then you must also enter the password for the TDE wallet. **TDE is not enabled by default on the source EBS 12.2.10 image from the OCI Marketplace**

    6. Finally, specify the location of the stage area directory you prepared to hold the temporary files that will be created on the database tier during the backup creation process.

    In the entries below a value depicted with:
    * <> -- will be a variable that should be recorded in your ``key-data.txt``.
    * `** **` -- will be the value to enter
    * `Press Enter to skip` -- will be for hitting the Enter key.  

            Enter Fully Qualified Hostname (ex: **apps.example.com**) : <Fully_Qualified_Hostname> 
            OS User Name : **oracle**
            OS User Password [skip if not applicable] : Press Enter to skip
            OS User Custom Private Key [skip if not applicable] : Press Enter to skip     
            OS User Passphrase [skip if not applicable] : Press Enter to skip
        
            Context File : **/u01/install/APPS/19.0.0/appsutil/ebsdb_apps.xml**
        
            Database Transparent Data Encrypted ( TDE ): ( Yes | No ) : **No**

            You have not entered Password or Custom Private Key location
            We will be using default SSH key at /home/oracle/.ssh/id_rsa 	
            Do you want to continue (Yes | No) : **Yes**

            Validating the details...
            Stage Directory : **/u01/install/stage/dbStage**
        
        ![](./images/28.png " ")

7. Next, indicate whether communication between the source application tier and Oracle Cloud Infrastructure Object Storage takes place through a proxy and you need to specify the proxy details.
    We are not going to use a proxy, choose **Option 2**

    ![](./images/29.png " ")

8. When entering the host name for the source application tier server, ensure that you enter the fully qualified domain name.

    1. Specify an operating system user name with which to connect to the source application tier server using SSH.

    2. You can choose to authenticate the OS user with either a password, a custom private SSH key and passphrase, or the default SSH key ($HOME/.ssh/id_rsa) on the backup module server. 
    
        If you do not enter an OS user password, prompts for the custom private key and passphrase appear. **Do not enter a password or a custom private key.** The script indicates that the default SSH key will be used and prompts you to confirm that you want to continue with the SSH key at the indicated location.

    3. Specify the location of the context file on the application tier, including:
        * The complete file path
        * The password for the Oracle E-Business Suite APPS schema
        * The location of the stage area directory you created to hold the temporary files created on the application tier during the backup creation process.

    For Oracle E-Business Suite Release 12.2 only, you must also specify the Oracle WebLogic Server administrator password for the source environment.

        Enter Fully Qualified Hostname (ex: **apps.example.com**) : <Fully_Qualified_Hostname> 
        OS User Name : **oracle**
        OS User Password [skip if not applicable] : Press Enter to skip
        OS User Custom Private Key [skip if not applicable] : Press Enter to skip  
        OS User Passphrase [skip if not applicable] : Press Enter to skip

        Context File : **/u01/install/APPS/fs1/inst/apps/ebsdb_apps/appl/admin/ebsdb_apps.xml**

        APPS Password (example: **apps**) : <apps_password>
        
        You have not entered Password or Custom Private Key location
        We will be using default SSH key at /home/oracle/.ssh/id_rsa 	
        Do you want to continue (Yes | No) : **Yes**

        Validating the details... 
        Stage Directory : **/u01/install/stage/appsStage**

        WebLogic Server Admin Password (example: **welcome1**) : <weblogic_password>
        
    ![](./images/30.png " ")

9. Enter details to specify how you want to create the backup on Oracle Cloud Infrastructure Object Storage.

    - Backup Identifier Tag - Enter a name to uniquely identify your backup. The script adds this tag as a prefix when creating the containers to store objects in a compartment within an Oracle Cloud Infrastructure Object Storage namespace, known as buckets. The generic bucket for the application tier and database tier Oracle home backup is named ``<Backup_Identifier_Tag>Generic``. 
    - The database bucket for the database RMAN backup is named ``<Backup_Identifier_Tag>DB``.
    - Backup Thread Count - Specify the number of threads used to upload the application tier and database tier file system backups. The default value is 1. If your CPU count is less than 8, then the maximum value for the backup thread count is 2 times the CPU count. If your CPU count is 8 or more, then the maximum value for the backup thread count is 1.5 times the CPU count.
    - Backup Archive Type - Specify tgz to compress the backups before the upload, or tar if you do not want to compress the backups. We recommend that you specify tgz.
    - RMAN Advanced Configuration Parameter File Path - If you created an advanced configuration parameter file in Section 4, then specify the directory path and file name for the file in this parameter. Otherwise, leave this parameter blank.
    - Backup Encryption Password - Specify a password to encrypt the application tier file system and database tier file system. If Transparent Data Encryption (TDE) is not enabled in the source database, then this password is also used to encrypt the database RMAN backup.
    - Confirm Backup Encryption Password - Re-enter the same backup encryption password to confirm it.

            Backup Identifier Tag                           : **EBS1228COMPUTE**

            Backup Thread Count                             : **4**

            Backup Archive Type ( tar | tgz )               : **tgz**

            RMAN Advanced Configuration Parameter File Path : Press Enter to skip

            Backup Encryption Password                      : **password**

            Confirm Backup Encryption Password              : **password**

        ![](./images/31.png " ")

    - Note: Save your **BackupIdentifier Tag** and **Backup Encryption Password** to your ``key-data.txt`` file

10. Indicate whether you access the cloud service through a proxy and need to specify the proxy details.
    We are not going to use a proxy, choose **Option 2**

    ![](./images/32.png " ")

11. Enter your Oracle Cloud Infrastructure details.

    - The user who performs the backup must be a member of the Oracle E-Business Suite administrators group defined according to Lab 2: Oracle E-Business Suite Cloud Manager Deployment and Configuration.
    In this workshop this is your `Cloud Manager_Admin_Username` (i.e. ebscm.admin@example.com)
    - You can find the user's OCID and Fingerprint by Navigating to **Identity** > **Users** in Oracle Cloud Infrastructure and selecting the user.
    - Enter the OCID for your tenancy, the [region identifier](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm) of the region where you plan to provision an environment from this backup, your tenancy name, and the OCID of the compartment where the backup buckets should be created.
    - Your tenancy name and OCID can be found by clicked the profile icon in the top right of Oracle Cloud Infrastructure and selecting **Tenancy:** < tenancy_name >. 
    - The compartment OCID can be found by navigating to **Identity** > **Compartments** and selecting the compartment that contains the Cloud Manager (you may have to navigate through the parent compartments to reach the correct compartment). 

    For environments with Oracle Database Release 12.1.0.2 or Release 19c, you must also specify the Cloud database service on which you plan to provision the target environment based on this backup.

    - For a Compute VM, enter Compute.
    - For 1-Node VM DB System (Single Instance) or 2-Node VM DB System (Oracle RAC), enter VM DB System.
    - For Exadata DB System, enter Exadata DB System.

            Oracle Cloud User OCID : <Cloud_Manager_Admin_User_OCID>

            Oracle Cloud Fingerprint : <Cloud_Manager_Admin_FingerPrint>

            Oracle Cloud User Private Key Path on Database Tier : /u01/install/APPS/.oci/<Cloud_Manager_Sdmin_Username>.pem

            Oracle Cloud User Private Key Path on APPS Tier : /u01/install/APPS/.oci/<Cloud_Manager_Admin_Username>.pem

            Oracle Cloud Tenancy OCID : <Oracle_Cloud_Tenancy_OCID>

            Oracle Cloud Region : <Oracle_Cloud_Region_Identifier>

            Oracle Cloud Tenant Name : <Oracle_Cloud_Tenancy_Name>

            Oracle Cloud Compartment OCID : <EBSCM_Compartment_OCID>

            Target Database Type - (Compute | VM DB System | Exadata DB System ): **Compute**

        ![](./images/33.png " ")

12. Review the values specified for the backup creation. The mode is set automatically based on your database release and target database type.
    - BMCS - Environments with Oracle Database Release 11.2.0.4, or environments with Oracle Database Release 12.1.0.2 or 19c where the target database service is Compute
    - BMCS_CDB - Environments with Oracle Database Release 12.1.0.2 or 19c where the target database service is Virtual Machine DB System or Exadata DB System

    The custom private key locations for the source database tier and source application tier are shown only if you chose to authenticate the OS user on those tiers with a custom private SSH key.

    If you are satisfied with the values shown, enter **Option 1** to proceed.

    ![](./images/34.png " ")

    **Note:** Do not close the SSH connection until the backup is completed. Also, do not let your computer go to sleep as that will close the SSH connection. 

    The script performs the following tasks:

    - Validates OS level authentications.
    - Validates whether the Oracle Database version is certified.
    - Validates whether the database is archivelog enabled.
    - Validates whether mandatory patches are present.
    - Creates a database backup.
    - Executes remote calls to the application tier to create a tar package containing the application files. 
    For Oracle E-Business Suite Release 12.2, the tar package includes the contents of the EBSapps directory on the run file system, including the `APPL_TOP` directory, the `COMMON_TOP directory`, the OracleAS 10.1.2 directory, and a packaged version of the Oracle Fusion Middleware home. For Oracle E-Business Suite Release 12.1.3, the tar package includes the contents of the `APPL_TOP`, `COMMON_TOP`, OracleAS 10.1.2, and OracleAS 10.1.3 directories.
    - Transfers the application tier tar package and database backup to a new bucket in your Oracle Cloud Infrastructure Backup Service account associated with your Oracle Cloud Infrastructure tenancy.

    If the script indicates that a validation failed, you can review the log files in the RemoteClone/logs directory to help identify which value failed validation.

13. After the script finishes and the backup is complete, you should notify users that they can resume normal file system activities. You should also restart any application tier or database backup cron jobs that you stopped before you began running the script, and resume patching and maintenance activities as needed.

    ![](./images/35.png " ")

You may proceed to the next lab. 


## Learn More

* [Creating a Backup of an On-Premises Oracle E-Business Suite Instance on Oracle Cloud Infrastructure](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/creating_backup_of_ebs_instance_on_oci/101_backup_oci.html)
* [Requirements for Oracle E-Business Suite on Oracle Cloud Infrastructure (Doc ID 2438928.1)](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=97656525609392&id=2438928.1&_afrWindowMode=0&_adf.ctrl-state=1bsk4t5eng_4#S2)

## Acknowledgments

* **Author:** William Masdon, Cloud Engineering
* **Contributors:** 
    - Aurelian Baetu, Technology Engineering HUB - Cloud Infrastructure
    - Santiago Bastidas, Product Management Director
    - Quintin Hill, Cloud Engineering
* **Last Updated By/Date:** William Masdon, Cloud Engineering, May 2021


