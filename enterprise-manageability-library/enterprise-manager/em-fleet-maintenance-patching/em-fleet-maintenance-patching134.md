# Automated Database Patching at Scale with Fleet Maintenance
## Introduction
### About Database Fleet Maintenance

Database Fleet Maintenance is an end-to-end automated solution for patching and upgrade of Oracle Database. Fleet Maintenance enables DBAs to automate patching of wide range of DB Configurations including Oracle RAC environments with Data Guard Standby.

Benefits with Fleet Maintenance:
- Minimum Downtime with Out of Place patching
- Enterprise Scale with Enterprise Manger Deployment Procedures Framework
- Single pane of glass for monitoring and managing entire patching and upgrade operations
- Ability to schedule/retry/suspend/resume.
- Database patching across different infrastructure including engineered systems like Exadata

![](images/em-fleet-maintenance-overview-1.png " ")

*Estimated Lab Time*: 60 minutes

### Objectives

The objective of this workshop is to explore end-to-end automated patching and upgrades of the Oracle Database using Enterprise Manager.

### Prerequisites
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Environment Setup
- SSH Private Key to access the host via SSH
- OMS super-user Credentials:
    - Username: **sysman**
    - password: **welcome1**
- EM13c Host Public IP address
- OMS Console URL:
````
<copy>https://<EM13c Host Public IP address>:7803/em</copy>
e.g: https://111.888.111.888:7803/em
````

*Note*: This lab environment is setup with Enterprise Manager Cloud Control Release 13.4 Release Update 5 and Database 19.3 as Oracle Management Repository. Workshop activities included in this lab will be executed both locally on the instance using Enterprise Manager Command Line Interface (EMCLI) or Rest APIs, and the Enterprise Manager console (browser)

### Video Preview
Watch a preview of database patching using Oracle Enterprise Manager Fleet Maintenance:

[](youtube:JlspEvqebHE)

*Note: Interfaces in this video may look different from the interfaces you will see. For updated information, please see steps below.*

### Lab Timing (Estimated)

| Step No. | Feature                                                    | Approx. Time | Details                                                                                                                                                                    | Value Proposition |
|----------------------|------------------------------------------------------------|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|
| 1                    | Detect Configuration Pollution                             | 10 minutes  | Analyze the database estate using Software Standardization.                                                                                                                |                   |
| 2                    | Oracle Database Patching with Fleet Maintenance | 50 minutes  | Patch a Database target using a Gold Image. As part of patching the Container Database, all Pluggable Databases in that Container Database will automatically get patched. |                   |

## **STEP 0:** Running your Workload
### Login to Host using SSH Key based authentication
1. Refer to *Lab 2* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
    - Authentication OS User - “*opc*”
    - Authentication method - *SSH RSA Key*
    - Oracle EM and DB Software OS User – “*oracle*”. First login as “*opc*”, then sudo to “*oracle*”. E.g.
      ````
      <copy>sudo su - oracle</copy>
      ````

### Login to OMS Console
1. Login to your Enterprise Manager console using the OMS URL and the super-user credentials as indicated above

  You may see an error on the browser while accessing the Web Console - “*Your connection is not secure*”. Ignore and add the exception to proceed. Access this URL and ensure that you are able to access Enterprise Manager Web Console.

### Update the Named Credentials with your SSH Key

1. Navigate to "***Setup menu >> Security>> Named Credential***" and Select ROOT credential and Click Edit. Replace the existing entry with your SSH Private Key and Click on Test and Save.

    ![](images/update_ssh_creds.jpg " ")

2. Setup oracle Named Credentials using Job System

    This will set up the user oracle password on the host and update the Named Credentials used in this workshop.
  Navigate to "***Enterprise >> Job >> Library***" and **select** "SETUP ORACLE CREDENTIALS"; **Click** Submit.

    ![](images/named_creds_job.jpg " ")


3.  Click **Submit** again on the Job submission Page

    ![](images/named_creds_job_submit.jpg " ")

4. The Job will be submitted successfully. **Click** on SETUP ORACLE CREDENTIALS Job link to view the Job

    ![](images/submitted.jpg " ")

5. The Job should show Status **Succeeded**

    ![](images/named_creds_job_succeeded.jpg " ")


### Fleet Maintenance Login to EMCLI

  1.  Upon login as user “oracle” via sudo from user “opc”, the following are performed automatically for your convenience:

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

### Steps Completed in Advance

In the interest of simplifying the setup and save time, the following steps were completed in advance:

  - We have created and pre-patched an Oracle Home with 18.10 release using which will be use to create the gold image [/u01/app/oracle/product/18/db\_home\_src, Orasidb18c\_home1\_2020\_05\_13\_04\_10\_9\_emcc.marketplace.com\_3192]

  To ensure smooth execution of the intended use cases, we have pre-hosted the scripts to be used later at /home/oracle/fleet

## **STEP 1:** Detect Configuration Pollution

This exercise enables us to analyze the database estate using Software Standardization.

### Software Standardization Advisor

  Software Standardization Advisor enables administrators to understand various database configurations prevailing in their environment. Each deployment with a unique platform, release and patch level is identified as a distinct configuration. This provides the administrators a view of the configuration pollution in their estate. It also analyzes and provides a recommendation to standardize the environment and reduce the number of configurations required for managing the database estate.

  ![](images/em-fleet-maintenance-overview-2.png " ")

1.  Log on to Enterprise Manager Console as sysman

2.  Click on ***Targets >> Databases***.

    ![](images/038585c9308635261ae7e4aa956525af.png " ")

3.  In the Databases targets page, click on ***Administration >> Software Standardization Advisor***

    ![](images/6198ae4976d5ddad0fde0432c472e9e8.jpg " ")

4.  Software Standardization Advisor shows two graphs depicting current configuration and recommended configuration.

    ![](images/em-pollution-detection-1.png " ")

    A Software Configuration is identified by Database Release, Platform and set of Patches installed on the target.

    The Software Configuration Advisor run shows that there are 5 Unique Software Configurations in the environment as shown in the pie chart labelled as “Current Unique Software Configurations” and recommendation is to maintain 2 Software Configurations as shown in the pie chart labelled as “Recommended Software Configurations”.

    Let us see details of the reports in next steps.

5.  Click on Generate Report.

6.  Click on Current Configurations to open the Excel report

    ![](images/em-pollution-detection-2.png " ")

    When opening the downloaded Excel Spreadsheet report, a warning on XLS format and file extension mismatch may pop up (see below). Simply click on “Yes” to
    ignore the warning and open the file.

    ![](images/d9ea997d07c30f80083e097f6b578200.png " ")

    Current Configuration shows five different Oracle home software versions

    ![](images/84e0ac92b29e45e91b9d17a8e0b3a2da.jpg " ")

7.  Next, click on Recommended Configurations to open the Excel Report

    ![](images/em-pollution-detection-3.png " ")

    The EM Recommended Configuration report recommends reducing 5 configurations and standardizing the database estate on 2 configurations, one based on 18c and the other based on 19c. This means All Oracle Homes of Release 18c should uptake the corresponding 18c configuration and the 19c homes will use the one based on Release 19c

    ![](images/06ff90fdba8aa5abebd066086e33f700.jpg " ")

    Recommendation is based on union of all bugs included in the Patches in all OHs and based on configuration type.

### Summary
This completes Step 1. In this section, you learned how to perform the following:

  - Access the Database Software Standardization Advisor
  - View Configuration summary
  - Generate and download current and recommended configuration reports

In the next section we will follow these recommendations to perform the following using Enterprise Manager 13c Fleet Maintenance.

  - Patch database “hr.subnet.vcn.oraclevcn.com” from 18.3 to 18.10

## **STEP 2:** Database Server patching with Fleet maintenance

### Database Fleet Maintenance

Enterprise Manager Database Fleet Maintenance is a Gold Image Target subscription based out of place patching solution. Gold Image(s) are software library entities storing archive of a patched software home. Targets, to be patched, subscribe to a relevant Gold Image. Target subscription persists through the lifecycle of the Target or Gold Image unless modified by an administrator. We will go through the following steps for this Fleet Maintenance Exercise.

  ![](images/DB_Fleet_Patching.png " ")

### Patching with Fleet Maintenance

We will go through steps for patching database target ***hr.subnet.vcn.oraclevcn.com***, a Container Database that is currently at 18.3.0.0.0 version. The goal is to patch this target to 18.10.0.0.0. As part of patching exercise this Container Database and all Pluggable Databases in that Container Database will automatically get patched.

1.  Log on to Enterprise Manager Console and review the status and version of DB Target.

    ![](images/ec0b6926d4f65b52a771483ace24055c.png " ")

    ![](images/c064eebf1a17dfd14d9c5921a88f93cb.jpg " ")

    You will see ***hr.subnet.vcn.oraclevcn.com*** Container Database has a pluggable database ‘HRPDB’. Both the Container Database and Pluggable database targets have status ‘UP’ and version 18.3.0.0.0. If target status is ‘DOWN’, start the target (using /home/oracle/start\_db\_hr.sh).

#### Create Gold Image

2.  Gold Image Creation

    Gold Image represents a software end state. An Enterprise Manager Software Library Gold Image is a software archive created from a patched oracle home uploaded to EM Software Library.

    * Reference Home Setup [READ-ONLY– This step has already been implemented]

        In order to create a Gold Image of the ‘recommended patch configuration’, you need to manually create such an Oracle Home as a pre-requisite step. As the goal is to patch Database 18.3 targets with Database 18.10 RU, a reference Oracle home fully patched to 18.10 [ /u01/app/oracle/product/18/db\_home\_src] was created and used to create the initial version of the Gold Image as further described in the next steps..

        This patched reference Oracle Home is discovered in Enterprise Manager as shown below and will be used for Gold Image Creation.

    * Navigate to “***Targets >> All Targets***” and type in “Orasidb18c\_home1\_2020\_05\_13\_04\_10\_9\_emcc.marketplace.com\_3192” in the “Search Target Name” box.

        ![](images/ea2416958193764cc47426f0ad8a0a67.jpg " ")

    * Create New Gold Image from ssh terminal using the following emcli command

          ````
          <copy>cd fleet
          cat create_image_Tier2_sidb_x64.sh</copy>
          ````

          **OR**

          ````
          <copy>sh create_image_Tier2_sidb_x64.sh</copy>
          ````
          ![](images/1791b5df10396b908e81340d2c6abed4.png " ")

    * Click on ***Enterprise >> Provisioning and Patching >> Procedure Activity*** to review Execution details of this operation via Enterprise Manager Console

        ![](images/e9091a9e1e04a1a988cb61d9171a483d.png " ")

    * Click on ‘CreateGoldImageProfile\_...’ run and review the steps performed.  

        ![](images/f30e3920a7a7e18e4bdfffa328e9d483.png " ")

    * Use ‘Show’ filter ‘Steps Not Skipped’ ; View:‘Expand All’ for detailed view of all the steps performed to complete an operation.

      ![](images/c3d174049d514ac6c22ce65167d55776.png " ")
3.  List Available Gold Images

    * Execute the following commands in ssh terminal to see the list of Gold Images available for deployment, locate ‘Tier \#2 SI DB Linux64*’* in the emcli command output:

        ````
        <copy>emcli db_software_maintenance -getImages</copy>
        ````

        ![](images/979c7a2ab44a65b0a6faf911cac1b64a.png " ")

      IMAGE ID retrieved from the output of above command is used in further operations like Target Subscription.

    * After retrieving a list of the available images, one can view a list of versions available for a specific image with the following command:

        ````
        <copy>emcli db_software_maintenance -getVersions -image_id={Insert IMAGE ID from List available gold images}</copy>
        ````

        This command lists Gold Image versions with their VERSION ID and STATUS.

        ![](images/a9b1233fb416f91b34518744dc0d7e9a.png " ")

        When a Gold Image is created for the first time, its first version is created as per the input and marked as current. Whenever we run a DEPLOY operation for a target, Gold Image version marked
        as CURRENT is used to deploy the new Oracle Home.

4.  Verify if Gold Image is Applicable

    This step verifies if the image can be used to patch a specified database target. This is done by comparing the bug fixes available in the current Oracle home of the database target and the image. In effect this check is run to identify patch conflicts.

* Review and execute below emcli command:  
    ````
    <copy>emcli db_software_maintenance -checkApplicability -image_id={Insert IMAGE ID from List available gold images} -target_list=hr.subnet.vcn.oraclevcn.com -target_type=oracle_database > /home/oracle/applicability.out</copy>
    ````

    ````
    <copy>cat /home/oracle/applicability.out</copy>
    ````

    Output of above command is redirected to a file. You may review the output using any standard editor or tool of your choice.

    ![](images/5f050173735f58aabd279987996192ea.png " ")

    This command can show one of the following results:

    -   Applicable: The image and database target contain the same set of bug fixes. The image can be applied on the specified target.
    -   Applicable and Image has more bug fixes: The image contains more bug fixes than those applied on the database. The list of extra bugs is displayed. The image can be applied on the specified target.
    -   Not Applicable: The database contains more bug fixes than those included in the image. The list of missing bugs is displayed. The administrator has to create a new version of the image that includes the missing bugs before the database can uptake the same.

#### Subscribe Database

5.  Subscribing Targets to the Selected Gold Image

    ![](images/1168b19325ea9b9c0624cf404d0cb689.jpg " ")

  *  Execute below command to subscribe the target hr.subnet.vcn.oraclevcn.com to Gold Image

      ````
      <copy>emcli db_software_maintenance -subscribeTarget -target_name=hr.subnet.vcn.oraclevcn.com -target_type=oracle_database -image_id={Insert IMAGE ID from List available gold images}</copy>
      ````

      Where:
        -   target\_name – Name of the Database target which needs to be patched
        -   target\_type – type of target to be patched. This should be oracle\_database in this case
        -   image\_id – ID of the Gold Image to which the target should be patched

            ![](images/ca94c4b76f9c24eee24f4d06b35c6764.png " ")

#### Deploy Image

6.  Gold Image Deployment

    ![](images/dadf62c68bd6d2180a20b977086a26a1.jpg " ")

* A new Oracle Home is deployed on the host where DB target is running with the below commands:

    ````
    <copy>emcli db_software_maintenance -performOperation -name="deploy1810" -purpose=DEPLOY_DB_SOFTWARE -target_type=oracle_database -target_list=hr.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -input_file="data:/home/oracle/fleet/deploy1810_hr.inp" -procedure_name_prefix="DEPLOY"</copy>
    ````

    **OR**  

    ````
    <copy>sh deploy1810_hr.sh</copy>
    ````

  Where:
    -  NEW\_ORACLE\_HOME\_LIST = Absolute path to the File System location where new Oracle Home will be deployed.
    -  procedure\_name\_prefix = optional, prefix for the deployment procedure instance name
    -  name = Name of the operation. This is a logical name and should be kept unique
    -  purpose = There are standard purposes defined which can be performed by Fleet Operations. “DEPLOY\_DB\_SOFTWARE” is one of them. These are predefined and should not be changed. Admin shall select one of the below mentioned purposes as and when needed.
    -  target\_type = The type of target being provided in this operation.
    -  target\_list =

         1.  This is a comma separated list of targets which need to be patched.
         2.  Targets of homogenous types are supported in a single fleet operation.
         3.  The system will calculate the unique list of hosts based on this target list and start stage of Oracle home software on those hosts.
         4.  If targets running from same Oracle home are provided in this list, the stage and deploy operation will be triggered only once and not for all targets.

    -  normal\_credential = This should be provided in the format \{ Named Credential: Credential Owner\} .
    -  privilege\_credential = This should be provided in the format \{ Named Credential: Credential Owner\}
    -  start\_schedule = Schedule when the stage and deploy should start if that needs to be done in future. Format: “start\_time:yyyy/mm/dd HH:mm”. It’s an optional parameter, if not provided, operation will start immediately

        ![](images/af4139d4bf2fd69f82fa8903e6520833.png " ")

* Navigate to Enterprise ***>> Provisioning and Patching >> Procedure Activity*** to Review Execution Details of this operation via Enterprise Manager Console. Click on ‘DEPLOY\_SYSMAN\_\*’ run

  ![](images/e3002b6d99e5a3654676f41911a3766d.png " ")

* Review the Procedure Activity steps performed.

  ![](images/68541ee5acf4db8b4f26a5a794b1c15c.png " ")

#### Migrate Listener

7.  Migrate Listener

* Review and execute the following command to Migrate the Listener

    ````
    <copy>emcli db_software_maintenance -performOperation -name="Migrate Listener" -purpose=migrate_listener -target_type=oracle_database -target_list="hr.subnet.vcn.oraclevcn.com" -normal_credential="ORACLE:SYSMAN" -privilege_credential="ROOT:SYSMAN"</copy>
    ````  

    **OR**  

    ````
    <copy>sh migrate_listener_hr_update.sh</copy>
    ````

    ![](images/3b1e1e85cf38e639a314570bc212a3ac.png " ")

* Navigate to ***Enterprise >> Provisioning and Patching >> Procedure Activity*** to Review Execution Details of this operation via Enterprise Manager Console. Click on ‘Fleet\_migrate\_\*’ run

  ![](images/c90e201dd7b74e1dbe0cab82acafe6fa.png " ")

* Review the Procedure Activity steps performed.  

  ![](images/91d2873ae19a8b7b53a5d31c842b5b9f.png " ")

### Update Database – Patch 18.3 to 18.10

8.  Database Update

    Once the deploy operation completes successfully. We are ready to run the final UPDATE operation which patches the database by switching it to the newly deployed home.

    ![](images/427b340f11443b09283ed979935fe1fc.jpg " ")

* Review and execute below command to update DB Target hr.subnet.vcn.oraclevcn.com

    ````
    <copy>emcli db_software_maintenance -performOperation -name="Update DB" -purpose=UPDATE_DB -target_type=oracle_database -target_list=hr.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -database_credential=sales_SYS:SYSMAN</copy>
    ````

    **OR**

    ````
    <copy>sh update_hr.sh</copy>
    ````

    Where:
      - Name – Name of the operation. This is a logical name and should be kept unique  
      - Purpose – There are standard purposes defined which can be performed by Fleet Operations. “UPDATE\_DB” is one of them.

      ![](images/8ddbd68dee0300c0223d11cc9407c08a.png " ")

* Navigate to the Procedure Activity Page and monitor the progress of this operation with ‘Fleet\_UPDATE\_...’ deployment procedure instance.

  ![](images/7a784412472d166c3eb16a775dea578e.png " ")

* Review the Procedure Activity steps performed  

  ![](images/b47cafe1b4d1342e408c52e86f3102ce.png " ")

* Verify the patched target by going to ***Targets >> Databases*** as shown below. Operation above will take 10-15 minutes to complete.

  ![](images/425da84e806d9024383be869fda527d4.png " ")

### Rollback Database – Reversed Patch 18.10 to 18.3

9.  Database Rollback

    Once the database is updated, we will perform a rollback to 18.3

* Review and execute below command to rollback DB Target ***hr.subnet.vcn.oraclevcn.com***

    ````
    <copy>curl -i -X POST https://emcc.marketplace.com:7803/em/websvcs/restful/emws/db/fleetmaintenance/performOperation/rollback -H "Content-Type:application/json" -u sysman:welcome1 --data-binary "@/home/oracle/fleet/rollback_hr_payload.json" --insecure</copy>
    ````

    **OR**

    ````
    <copy>sh rollback_hr.sh</copy>
    ````

    ![](images/acb8ad0f4fb9ad39503081f5cdfb9e79.png " ")

* Navigate to the Procedure Activity Page and monitor the progress of this operation with ‘Fleet\_ROLLBACK\_...’ deployment procedure instance.

  ![](images/6999f44a0845085f3660f365bb24d7d3.png " ")

* Review the Procedure Activity steps performed         

  ![](images/6a12674bdf0e9535535b90cf043a1605.png " ")

* Verify the rolled back target by going to ***Targets >> Databases*** as shown
below.

  ![](images/7afa56b6cb5fee053c57b141a5c08245.png " ")

### Cleanup Old Homes

10. Clean up Database HR
In order to have an old empty home previously used by “***hr.subnet.vcn.oraclevcn.com***” at our disposal to demonstrate a cleanup operation, we will now re-update the database by running the commands from Step 8.

* Review and execute below command to update DB Target ***hr.subnet.vcn.oraclevcn.com*** again to 18.10 version

    ````
    <copy>emcli db_software_maintenance -performOperation -name="Update DB" -purpose=UPDATE_DB -target_type=oracle_database -target_list=hr.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -database_credential=sales_SYS:SYSMAN</copy>
    ````

    **OR**

    ````
    <copy>sh update_hr.sh</copy>
    ````

    Where:
      -  Name – Name of the operation. This is a logical name and should be kept unique Purpose – There are standard purposes defined which can be performed by Fleet Operations. “UPDATE\_DB” is one of them.

      ![](images/05dc434c461c068b157f9dd7cd6b10ce.png " ")

* Verify that the update has been completed successfully before proceeding with any cleanup action, Same as done in step \#8, this should complete within 10\~15 minutes.

  ![](images/444749cbf21602a501446fe9c14b1949.png " ")

* Verify and confirm that the target has been re-patched to 18.10 by going to Targets Databases as shown below

  ![](images/05d8c8153c8c990ac80810fef434baa3.png " ")

* Review and execute the following command to cleanup hr in reportOnly mode  
    ````
    <copy>emcli db_software_maintenance -performOperation -name="Cleanup old oracle homes" -purpose=CLEANUP_SOFTWARE -target_type=oracle_database -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -target_list=hr.subnet.vcn.oraclevcn.com -workDir=/tmp -reportOnly=true</copy>
    ````

    **OR**

    ````
    <copy>sh cleanup_hr_report.sh</copy>
    ````

    ![](images/9b5d405577571043afe9ead1fc723392.png " ")

* Review and execute the following command to cleanup hr  
    ````
    <copy>emcli db_software_maintenance -performOperation -name="Cleanup old oracle homes" -purpose=CLEANUP_SOFTWARE -target_type=oracle_database -normal_credential=ORACLE:SYSMAN -privilege_credential=ROOT:SYSMAN -target_list=hr.subnet.vcn.oraclevcn.com -workDir=/tmp</copy>
    ````

    **OR**

    ````
    <copy>sh cleanup_hr.sh</copy>
    ````

    ![](images/f0443cb23cec56d4d3c3818720c73c80.png " ")

* Navigate to the Procedure Activity Page and monitor the progress of this operation with ‘CLEANUP\_SOFTWARE\_...’ deployment procedure instance.

  ![](images/1ffb1bc964b9ca980d6f6034d4882156.png " ")

* Review the Procedure Activity steps performed        

  ![](images/c2062c09719c5c4b41ceff3138b3d44e.png " ")

* Verify to confirm the old Oracle Home has been removed

    ````
    <copy>ls -l /u01/app/1806/hr</copy>
    ````

    ![](images/31324fdd072b03be848fa9362de9ae7b.png " ")

*  As part of the cleanup operation, LISTENER\_1522 which support “***hr.subnet.oraclevcn.com***” is shutdown. Set your environment by passing “***hr***” to “***oraenv***” when prompted and start the listener back up.

    ````
    <copy>. oraenv </copy>
    ````

* Start LISTENER\_1522 back up

      ````
      <copy>lsnrctl start LISTENER_1522</copy>
      ````

  ![](images/465b2cea9ae4e176c314eff253ef4b68.png " ")

* Force Listener registration and confirm that it is now servicing “***hr.subnet.vcn.oraclevcn.com***”

    ````
    <copy>sqlplus '/as sysdba'<<EOF
    alter system register;
    EOF
    </copy>
    ````

* Check status of LISTENER\_1522

    ````
    <copy>lsnrctl status LISTENER_1522</copy>
    ````

    ![](images/b95a982c86b233dfa1af34d29c03aa6e.png " ")

### Summary
This completes Step 2. In this section, you learned how to perform the following:
  -   Create Oracle Database Software Gold Image
  -   Subscribe Database to Gold Image
  -   Deploy Gold Image to Database Host
  -   Migrate Oracle Database Listener from old Oracle Home to newly Deployed Oracle Home
  -   Update (Patch) Database from 18.3 to 18.10
  -   Rollback (Un-patch) Database from 18.10 to 18.3
  -   Clean up old Oracle Homes

Thank you!

## Want to Learn More?
  - [Oracle Enterprise Manager](https://www.oracle.com/enterprise-manager/)
  - [Oracle Enterprise Manager Fleet Maintenance](https://www.oracle.com/manageability/enterprise-manager/technologies/fleet-maintenance.html)
  - [Enterprise Manager Documentation Library](https://docs.oracle.com/en/enterprise-manager/index.html)
  - [Database Lifecycle Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/lifecycle.html)
  - [Database Cloud Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/cloud.html)

## Acknowledgements
  - **Authors**
      - Rene Fontcha, Master Principal Solutions Architect, NA Technology
      - Shefali Bhargava, Oracle Enterprise Manager Product Management
  - **Adapted for Cloud by** - Rene Fontcha, Master Principal Solutions Architect, NA Technology
  - **Last Updated By/Date** - Shefali Bhargava - Enterprise Manager Product Management, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the Log In button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*. Please include your workshop name and lab name. You can also include screenshots and attach files. Engage directly with the author of the workshop.
If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
