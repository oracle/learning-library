# Automated Database Upgrade at Scale with Fleet Maintenance
## Introduction

### Objectives

Database Fleet Maintenance is an end-to-end automated solution for patching and upgrade of Oracle Database. Fleet Maintenance enables DBAs to automate patching of wide range of DB Configurations including Oracle RAC environments with Data Guard Standby.

Benefits with Fleet Maintenance:
- Minimum Downtime with Out of Place patching
- Enterprise Scale with Enterprise Manger Deployment Procedures Framework
- Single pane of glass for monitoring and managing entire patching and upgrade operations
- Ability to schedule/retry/suspend/resume.
- Database patching across different infrastructure including engineered systems like Exadata

![](images/em-fleet-maintenance-overview-1.png)

### Background
The estimated time to complete the workshop is 75 minutes as further detailed below.

| Step No. | Feature                                                   | Approx. Time | Details                                                                                                              | Value Proposition |
|----------------------|-----------------------------------------------------------|-------------|----------------------------------------------------------------------------------------------------------------------|-------------------|
| 1                    | Detect Configuration Pollution                            | 10 minutes  | Analyze the database estate using Software Standardization.                                                          |                   |
| 2                    | Oracle Database Upgrade with Fleet Maintenance | 1hr 5 min   | Upgrade your Oracle DB Software at scale with minimal downtime using Oracle Enterprise Manager 13c Fleet Maintenance |                   |

### Prerequisites

This lab assumes you have completed the following labs:
* [Lab 1: Login to Oracle Cloud](https://rfontcha.github.io/learning-library/enterprise-manageability-library/enterprise_manager/freetier/?lab=lab-1-login-oracle-cloud)
* [Lab 2: Generate SSH Key](https://rfontcha.github.io/learning-library/enterprise-manageability-library/enterprise_manager/freetier/?lab=lab-2-generate-ssh-key)
* [Lab 3: Environment Setup](https://rfontcha.github.io/learning-library/enterprise-manageability-library/enterprise_manager/freetier/?lab=lab-3-environment-setup)

This lab environment is setup with Enterprise Manager Cloud Control Release 13.3 and Database 19.3 as Oracle Management Repository. Workshop activities included in this lab will be executed both locally on the instance using Enterprise Manager Command Line Interface (EMCLI) or Rest APIs, and the Enterprise Manager console (browser)

Prior to starting, you will need:
- EM Instance Public IP address
- SSH Private Key to access the host via SSH
- OMS Console URL: http://\{EM Instance Public IP\}:7803/em
- OMS super-user Credentials:
    - Username: **sysman**
    - password: **welcome1**

#### Login to Host using SSH Key based authentication
Refer to [Frequently Asked Questions](https://github.com/oracle/learning-library/blob/master/enterprise-manageability-library/enterprise_manager/OCIMarketplaceEM-FAQ.md) doc for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
  - Authentication OS User - “opc”
  - Authentication method - SSH RSA Key
  - Oracle EM and DB Software OS User – “oracle”. First login as “opc”, then sudo to “oracle”. E.g. “sudo su - oracle"

#### Login to OMS Console
Log into your Enterprise Manager VM using the Public IP of your EM instance and the super-user credentials as indicated above”

You may see an error on the browser while accessing the Web Console - “*Your connection is not secure*”. Ignore and add the exception to proceed. Access this URL and ensure that you are able to access Enterprise Manager Web Console.

## Step 0: Running your lab

1. Update the Named Credentials with your SSH Key

Navigate to "***Setup menu >> Security>> Named Credential***" and Select ROOT credential; Click Edit. Replace the existing entry with your SSH Private Key and Click on Test and Save.

![](images/5429da7dcd00ecc7da6e779ed699c45e.jpg)

2. Fleet Maintenance Login to EMCLI

Upon login as user “oracle” via sudo from user “opc”, the following are performed automatically for your convenience:

  - OMS environment variables set
  - emcli session is established

While connected as “oracle” your emcli session may expire at some point due to inactivity. Should that occur login again as sysman

````
 <copy>emcli login -username=sysman -password=welcome1</copy>
````

**OR** Simply exit from terminal session as "oracle" and login again to reestablish a new session.

````
<copy>exit
sudo su - oracle</copy>
````

3. Steps Completed in Advance

In the interest of simplifying the setup and save time, the following steps were completed in advance and covered in this lab:

  - We have created and pre-patched an Oracle Home with 18.10 release using which will be use to create the gold image [/u01/app/oracle/product/18/db\_home\_src, Orasidb18c\_home1\_2020\_05\_13\_04\_10\_9\_emcc.marketplace.com\_3192]
  - We have created a pre-patched Oracle Home with 19.7 release using which we will create the gold image [/u01/app/oracle/product/19/db\_home\_src, Orasidb19c\_home1\_2020\_05\_13\_04\_24\_10\_emcc.marketplace.com\_2953]
  - Creation of the first version of “Tier\#1” Gold Image
  - Subscription of “finance.subnet.vcn.oraclevcn.com” Database to above image
  - Patching of “finance.subnet.vcn.oraclevcn.com” Database from 18.8 to 18.10 using Fleet Maintenance

We recommend that you read through each of the steps, review the emcli command, its verbs and deployment procedures to get an understanding of what it takes to do it from scratch. For a full end-to-end hands-on execution of “patching” lab, we highly recommend part \#1

To ensure smooth execution of the intended use cases, we have pre-hosted the scripts to be used later at /home/oracle/fleet

## Step 1: Detect Configuration Pollution

This exercise enables us to analyze the database estate using Software Standardization.

### Software Standardization Advisor

Software Standardization Advisor enables administrators to understand various database configurations prevailing in their environment. Each deployment with a unique platform, release and patch level is identified as a distinct configuration. This provides the administrators a view of the configuration pollution in their estate. It also analyzes and provides a recommendation to standardize the environment and reduce the number of configurations required for managing the database estate.

![](images/em-fleet-maintenance-overview-2.png)

1.  Log on to Enterprise Manager Console as sysman

2.  Click on ***Targets >> Databases***.

![](images/038585c9308635261ae7e4aa956525af.png)

3.  In the Databases targets page, click on ***Administration >> Software Standardization Advisor***

![](images/6198ae4976d5ddad0fde0432c472e9e8.jpg)

4.  Software Standardization Advisor shows two graphs depicting current configuration and recommended configuration.

![](images/em-pollution-detection-1.png)

A Software Configuration is identified by Database Release, Platform and set of Patches installed on the target.

The Software Configuration Advisor run shows that there are 5 Unique Software Configurations in the environment as shown in the pie chart labelled as “Current Unique Software Configurations” and recommendation is to maintain 2 Software Configurations as shown in the pie chart labelled as “Recommended Software Configurations”.

Let us see details of the reports in next steps.

5.  Click on Generate Report.

6.  Click on Current Configurations to open the Excel report

![](images/em-pollution-detection-2.png)

When opening the downloaded Excel Spreadsheet report, a warning on XLS format and file extension mismatch may pop up (see below). Simply click on “Yes” to
ignore the warning and open the file.

![](images/d9ea997d07c30f80083e097f6b578200.png)

Current Configuration shows five different Oracle home software versions

![](images/84e0ac92b29e45e91b9d17a8e0b3a2da.jpg)

7.  Next, click on Recommended Configurations to open the Excel Report

![](images/em-pollution-detection-3.png)

The EM Recommended Configuration report recommends reducing 5 configurations and standardizing the database estate on 2 configurations, one based on 18c and the other based on 19c. This means All Oracle Homes of Release 18c should uptake the corresponding 18c configuration and the 19c homes will use the one based on Release 19c

![](images/06ff90fdba8aa5abebd066086e33f700.jpg)

Recommendation is based on union of all bugs included in the Patches in all OHs and based on configuration type.

### Summary
This completes Step 1. In this section, you learned how to perform the following:

  - Access the Database Software Standardization Advisor
  - View Configuration summary
  - Generate and download current and recommended configuration reports

In the next section we will follow these recommendations to perform the following using Enterprise Manager 13c Fleet Maintenance.

  - Patch database “finance.subnet.vcn.oraclevcn.com” from 18.8 to 18.10 [READ-ONLY– This step has already been implemented]
  - Upgrade “finance.subnet.vcn.oraclevcn.com” from 18.10 to 19.7

## Step 2: Oracle Database Upgrade with Fleet Maintenance

### Database Fleet Maintenance

Enterprise Manager Database Fleet Maintenance is a Gold Image Target subscription based out of place patching solution. Gold Image(s) are software library entities storing archive of an upgraded software home. Targets, to be upgraded, subscribe to a relevant Gold Image. Target subscription persists through the lifecycle of the Target or Gold Image unless modified by an administrator. We will go through the following steps for this Fleet Maintenance Exercise.

![](images/DB_Fleet_Upgrade.png)

### Upgrading with Fleet Maintenance

We will go through steps for upgrading database target ***finance.subnet.vcn.oraclevcn.com***, a Single Instance Database currently at 18.10.0.0.0 version that was previously patched from 18.8.0.0.0 using Fleet Maintenance. The goal is to upgrade this target to 19.7.0.0.0.

1.  Log on to Enterprise Manager Console and review the status and version of DB Target.

![](images/ec0b6926d4f65b52a771483ace24055c.png)

![](images/05ab9d53e622fe6b226647d67750c1dd.jpg)

You will see finance.subnet.vcn.oraclevcn.com. If target status is ‘DOWN’, start the target (using /home/oracle/start\_db\_finance.sh).

The next **[READ ONLY]** blocks are fully covered by the [Patching lab](../em_fleet_maintenance_patching/em_fleet_maintenance_patching.md) and are listed here for your information only.

#### Create Gold Image [READ-ONLY– This step has already been implemented]

2.  Review as prescribed

Gold Image represents a software end state. An Enterprise Manager Software Library Gold Image is a software archive created from a patched oracle home
uploaded to EM Software Library. Steps in this section are already implemented and are available here for review.

* Reference Home Setup

In order to create a Gold Image of the ‘recommended patch configuration’, you need to manually create such an Oracle Home as a pre-requisite step.

As the goal of this lab is to upgrade Database target from 18.10 to 19.7, a reference Oracle home fully patched to 18.10 [Orasidb18c\_home1\_2020\_05\_13\_04\_10\_9\_emcc.marketplace.com\_3192, /u01/app/oracle/product/18/db\_home\_src] was created and used to create the initial version of the Gold Image as further described in the next steps.

This reference Oracle Home is discovered in Enterprise Manager as shown below and will be used for Gold Image Creation.

Navigate to “***Targets >> All Targets***” and type in “Orasidb18c\_home1\_2020\_05\_13\_04\_10\_9\_emcc.marketplace.com\_3192” in the “Search Target Name” box.

![](images/ea2416958193764cc47426f0ad8a0a67.jpg)

* Review “Create New Gold Image” from ssh terminal using the following emcli command

````
<copy>cd fleet
cat create_image_Tier1_sidb_x64.sh</copy>
````
![](images/e4a3896e00184146230d4d974e64a528.png)

3.  List Available Gold Images

Execute the following commands in ssh terminal to see the list of Gold Images available for deployment, locate ‘Tier \#1 SI DB Linux64*’* in the emcli command output:

````
<copy>emcli db_software_maintenance -getImages</copy>
````

![](images/81fa9422f35c2dadac8595ef44a5f772.png)

IMAGE ID retrieved from the output of above command is used in further operations like Target Subscription. After retrieving a list of the available images, one can view a list of versions available for a specific image with the following command:

````
<copy>emcli db_software_maintenance -getVersions -image_id=A5F3D8523BDF635BE0531A00000AA55B</copy>
````

![](images/8c48a86f30874b71459424dc8f69e05f.png)

When a Gold Image is created for the first time, its first version is created as per the input and marked as current. Whenever we run a DEPLOY operation for a target, Gold Image version marked as CURRENT is used to deploy the new Oracle Home.

4.  Verify if Gold Image is Applicable

This step verifies if the image can be used to patch a specified database target. This is done by comparing the bug fixes available in the current Oracle home of the database target and the image. In effect this check is run to identify patch conflicts.

* Review and execute below emcli command:  
````
<copy>emcli db_software_maintenance -checkApplicability -image_id="A5F3D8523BDF635BE0531A00000AA55B" -target_list=finance.subnet.vcn.oraclevcn.com -target_type=oracle_database</copy>
````

![](images/a7ef76d93e9ee75da1a6a16a7f7620d4.png)

This command can show one of the following results:

  - **Applicable**: The image and database target contain the same set of bug fixes. The image can be applied on the specified target.
  - **Applicable and Image has more bug fixes**: The image contains more bug fixes than those applied on the database. The list of extra bugs is displayed. The image can be applied on the specified target.
  - **Not Applicable**: The database contains more bug fixes than those included in the image. The list of missing bugs is displayed. The administrator has to create a new version of the image that includes the missing bugs before the database can uptake the same.

#### Subscribe Database - [READ ONLY – This step has already been implemented]

5.  Review steps

* Run emcli command:

````
<copy>emcli db_software_maintenance -subscribeTarget -target_name=finance.subnet.vcn.oraclevcn.com -target_type=oracle_database -image_id="A5F3D8523BDF635BE0531A00000AA55B"</copy>
````

![](images/95439c2138aabd69382c9b0489f14c3b.png)

 Where:
    - target\_name – Name of the Database target which needs to be patched
    - target\_type – type of target to be patched. This should be oracle\_database in this case
    - image\_id – ID of the Gold Image to which the target should be patched

#### Deploy Image - [READ ONLY – This step has already been implemented]

6.  Review steps

* Review emcli command encapsulated in shell script

````
<copy>cat deploy1810_finance.sh</copy>
````

![](images/81d4a98e953a1d2ee999a1b718fd825b.png)

#### Migrate Listener - [READ ONLY – This step has already been implemented]

7.  Review steps

* Review emcli command encapsulated in shell script

````
<copy>cat migrate_listener_finance_update.sh</copy>
````

![](images/17322b2523052b40c7d105c51b6a2967.png)

### Update Database – Patch to 18.10 - [READ ONLY – This step has already been implemented]

8.  Review steps

* Review emcli command encapsulated in shell script

````
<copy>cat update_finance.sh</copy>
````

![](images/ed90e634e7779548a6f7aebecec5e189.png)

#### Create New Image Version

9.  Add Image version 19.7 to Gold Image Tier1 SIDB Linux-x64

* Reference Home Setup [READ-ONLY– This step has already been implemented]

Just as it was done for the first version of this image, a reference 19.7 Oracle Home is needed to create a new version of the image and was setup in advance. [/u01/app/oracle/product/19/db\_home\_src]. This reference Oracle Home is discovered in Enterprise Manager as shown below and will be used to create and new version of the Gold Image.

Navigate to “***Targets >> All Targets***” and type in “Orasidb19c\_home1\_2020\_05\_13\_04\_24\_10\_emcc.marketplace.com\_2953” in the “*Search Target Name*” box.

![](images/a3ba55228f1e4a239c81bd01ed86c299.png)

* Review and execute the following command to add Image version 19.7 to "*Tier1 SIDB Linux-x64*"

````
<copy>emcli db_software_maintenance -createSoftwareImage -input_file="data:/home/oracle/fleet/sidb19c_tier1.inp"</copy>
````

**OR**  
````
<copy>sh add_image_version197_tier1_sidb_x64.sh</copy>
````

![](images/d3f1d7ec4ab73bd6e50aab47fbf3ffca.png)

* Navigate to ***Enterprise >> Provisioning and Patching >> Procedure Activity*** to Review Execution Details of this operation via Enterprise Manager Console. Click on ‘CreateGoldImage\*’ run

![](images/98008aab963de3d4439767ccab3fbba0.png)

* Review the Procedure Activity steps performed.

![](images/0dedb16ddd453f5fa9d312229e9bd072.png)

10. Set Version 19.7 to Status Current

* View a list of versions available for a specific image with the following command:

````
<copy>emcli db_software_maintenance -getVersions -image_id=A5F3D8523BDF635BE0531A00000AA55B</copy>
````

![](images/9bba5ae0276141179ba6b22e984ba3f7.png)

* Using the VERSION ID from Step above, review and execute the following command to set Version Name 19.7 to Status Current

````
<copy>emcli db_software_maintenance -updateVersionStatus -status=CURRENT -version_id=A79931EC777968D6E0532A00000A806B</copy>
````

![](images/7796c07b2b8273dc93221a84b784dc63.png)

#### Deploy New Image Version

11. Gold Image Deployment

* A new Oracle Home is deployed on the host where DB target is running with the below commands.

````
<copy>emcli db_software_maintenance -performOperation -name="deploy197" -purpose=DEPLOY_DB_SOFTWARE -target_type=oracle_database -target_list=finance.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -input_file="data:/home/oracle/fleet/deploy197_finance.inp" -procedure_name_prefix="DEPLOY"</copy>
````  

**OR**  

````
<copy>sh deploy197_finance.sh</copy>
````  

Where:
  - NEW\_ORACLE\_HOME\_LIST = Absolute path to the File System location where new Oracle Home will be deployed.
  - procedure\_name\_prefix = optional, prefix for the deployment procedure instance name
  - name = Name of the operation. This is a logical name and should be kept unique
  - purpose = There are standard purposes defined which can be performed by Fleet Operations. “DEPLOY\_DB\_SOFTWARE” is one of them. These are predefined and should not be changed. Admin shall select one of the below mentioned purposes as and when needed.
  - target\_type = The type of target being provided in this operation.
  - target\_list =
     1. This is a comma separated list of targets which need to be patched.
     2. Targets of homogenous types are supported in a single fleet operation.
     3. The system will calculate the unique list of hosts based on this target list and start stage of Oracle home software on those hosts.
     4. If targets running from same Oracle home are provided in this list, the stage and deploy operation will be triggered only once and not for all targets.

  - normal\_credential = This should be provided in the format \{Named Credential: Credential Owner\}.
  - privilege\_credential = This should be provided in the format \{Named Credential: Credential Owner\}
  - start\_schedule = Schedule when the stage and deploy should start if that needs to be done in future. Format: “start\_time:yyyy/mm/dd HH:mm”. It is an optional parameter, if not provided, operation will start immediately

![](images/75e3dbfe7a2cfe2a8a6fc286d3f5caa2.png)

* Navigate to ***Enterprise >> Provisioning and Patching >> Procedure Activity*** to Review Execution Details of this operation via Enterprise Manager Console. Click on ‘DEPLOY\_SYSMAN\_\*’ run

![](images/aa899356fbcdb73732d72b507bc6a7df.png)

* Review the Procedure Activity steps performed.

![](images/2db6aa6336c6d7b6d846a90fad68f5c7.png)

#### Migrate Listener to New Upgraded Home

12. Migrate Listener

* Review and execute the following command to Migrate the Listener

````
<copy>emcli db_software_maintenance -performOperation -name="Migrate Listener" -purpose=migrate_listener -target_type=oracle_database -target_list="finance.subnet.vcn.oraclevcn.com" -normal_credential="ORACLE:SYSMAN" -privilege_credential="ROOT:SYSMAN"</copy>
````

**OR**

````
<copy>sh migrate_listener_finance_update.sh</copy>
````

![](images/bc197f2a6ee3475949e203a1a250352d.png)

* Navigate to ***Enterprise >> Provisioning and Patching >> Procedure Activity*** to Review Execution Details of this operation via Enterprise Manager Console. Click on ‘Fleet\_migrate\_\*’ run

![](images/7d1f66b6cf7dcc1ef60ae87ae4a1f176.png)

* Review the Procedure Activity steps performed.

![](images/5b63a9af8400bf71eb838f3a00cc2667.png)

#### Update Database – Upgrade to 19.7

13. Database Update

Once the deploy operation completes successfully. We are ready to run the final UPDATE operation which upgrades the database by switching it to the newly deployed home.

* Review and execute below command to update DB Target *finance.subnet.vcn.oraclevcn.com*

````
<copy>emcli db_software_maintenance -performOperation -name="Update DB" -purpose=UPDATE_DB -target_type=oracle_database -target_list=finance.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN
-database_credential=sales_SYS:SYSMAN</copy>
````

**OR**

````
<copy>sh update_finance.sh</copy>
````

Where:
  - Name – Name of the operation. This is a logical name and should be kept unique  
  - Purpose – There are standard purposes defined which can be performed by Fleet Operations. “UPDATE\_DB” is one of them.

![](images/c1eb432957066af8ddc4062159d28f47.png)

* Navigate to the Procedure Activity Page and monitor the progress of this operation with ‘Fleet\_UPDATE\_...’ deployment procedure instance.

![](images/5f7ea1d549b6bb5edf2cfadcc0fad0bc.png)

* Review the Procedure Activity steps performed

![](images/fa46b7e21ac3396ec567446a8a12a6d2.png)

* Verify the Upgraded target by going to ***Targets >> Databases*** as shown below. Operation above will take \~40 minutes to complete.

![](images/0dd5dbdbd9c2f2eac424cf9cf976aa34.png)

#### Cleanup Old Homes

14. Clean up Database Finance

* Review and execute the following command to cleanup finance in reportOnly mode  

````
<copy>emcli db_software_maintenance -performOperation -name="Cleanup old oracle homes" -purpose=CLEANUP_SOFTWARE -target_type=oracle_database -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -target_list=finance.subnet.vcn.oraclevcn.com -workDir=/tmp -reportOnly=true</copy>
````

**OR**

````
<copy>sh cleanup_finance_report.sh</copy>
````

![](images/228ae0280ff2878bb4902cb263529bb9.png)

* Review and execute the following command to cleanup finance  

````
<copy>emcli db_software_maintenance -performOperation -name="Cleanup old oracle homes" -purpose=CLEANUP_SOFTWARE -target_type=oracle_database -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -target_list=finance.subnet.vcn.oraclevcn.com -workDir=/tmp</copy>
````

**OR**

````
<copy>sh cleanup_finance.sh</copy>
````

![](images/3f41abadf32e4b8d4900467985a093ef.png)

* Navigate to the Procedure Activity Page and monitor the progress of this operation with ‘CLEANUP\_SOFTWARE\_...’ deployment procedure instance.

![](images/94954554c777d24280599507c28a75d3.png)

* Review the Procedure Activity steps performed

![](images/777053c04e0851859856c8d32b9d94c2.png)

* Verify to confirm that the two old Oracle Homes reported have been removed

````
<copy>ls -l /u01/app/18c/sales188 /u01/app/oracle/product/18/db_home1</copy>
````

![](images/58ba7d42eb61331e3d0bec6588086b47.png)

* As part of the cleanup operation, LISTENER\_1525 which support *“finance.subnet.oraclevcn.com”* is shutdown. Set your environment by passing *“finance”* to *“oraenv”* when prompted.

````
<copy>. oraenv</copy>
````
* start listener LISTENER\_1525 back up

````
<copy>lsnrctl start LISTENER_1525</copy>
````

![](images/b3d1a555c6eeb3d0d899da4291a6441c.png)

* Force Listener registration and confirm that it is now servicing “*finance.subnet.vcn.oraclevcn.com*”

````
<copy>sqlplus '/as sysdba'
alter system register;
exit</copy>
````
* Check status of LISTENER\_1525

````
<copy>lsnrctl status LISTENER_1525</copy>
````

![](images/7626fd3264e4a514fde576ecd9369456.png)

### Summary

This completes Step 2. In this section, you learned how to perform the following:

  - Create Oracle Database Software Gold Image
  - Subscribe Database to Gold Image
  - Deploy Gold Image to Database Host
  - Migrate Oracle Database Listener from old Oracle Home to newly Deployed Oracle Home
  - Update (Patch) Database from 18.8 to 18.10
  - Add new Version to an Existing Oracle Database Software Gold Image
  - Deploy new Gold Image Version to Database Host
  - Update (Upgrade) Database from 18.10 to 19.7
  - Clean up old Oracle Homes

Thank you!

## Want to Learn More?

  - [Oracle Enterprise Manager](https://www.oracle.com/enterprise-manager/)
  - [Oracle Enterprise Manager Fleet Maintenance](https://www.oracle.com/manageability/enterprise-manager/technologies/fleet-maintenance.html)
  - [Enterprise Manager Documentation Library](https://docs.oracle.com/en/enterprise-manager/index.html)
  - [Database Lifecycle Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/lifecycle.html)
  - [Database Cloud Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/cloud.html)

## Acknowledgements
* **Author** - Shefali Bhargava, Oracle Enterprise Manager Product Management
* **Adapted for Cloud by** -  Rene Fontcha, Oracle Enterprise Manager Sales Engineering
* **Last Updated By/Date** - Rene Fontcha, July 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
