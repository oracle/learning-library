![](media/rdwd-emheader.png)

Purpose
=======

Database Fleet Maintenance is an end-to-end automated solution for patching and
upgrade of Oracle Database. Fleet Maintenance enables DBAs to automate patching
of wide range of DB Configurations including Oracle RAC environments with Data
Guard Standby.

This document provides an overview of features and enhancements included in
release . It is intended solely to help you assess the business benefits of
upgrading to and to plan your I.T. projects.

### Contents
**Workshop Activity 1:** Detect Configuration Pollution

**Workshop Activity 2:** Oracle Database Patching with Fleet Maintenance

The estimated time to complete the workshop is 60 minutes

| Workshop Activity No | Feature                                                    | Approx Time | Details                                                                                                                                                                    | Value Proposition |
|----------------------|------------------------------------------------------------|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|
| 1                    | Detect Configuration Pollution                             | 10 minutes  | Analyze the database estate using Software Standardization.                                                                                                                |                   |
| 2                    | Oracle Database Patching with Fleet Maintenance | 50 minutes  | Patch a Database target using a Gold Image. As part of patching the Container Database, all Pluggable Databases in that Container Database will automatically get patched. |                   |

# Introduction

Database Fleet Maintenance is an end-to-end automated solution for patching and
upgrade of Oracle Database. Fleet Maintenance enables DBAs to automate patching
of wide range of DB Configurations including Oracle RAC environments with Data
Guard Standby.

Benefits with Fleet Maintenance:

-   Minimum Downtime with Out of Place patching

-   Enterprise Scale with Enterprise Manger Deployment Procedures Framework

-   Single pane of glass for monitoring and managing entire patching and upgrade
    operations

-   Ability to schedule/retry/suspend/resume.

-   Database patching across different infrastructure including engineered
    systems like Exadata

![](media/a5e5d36c2da3bb5669a7a6c79e46a555.png)

For more details refer to [Fleet Maintenance](https://www.oracle.com/manageability/enterprise-manager/technologies/fleet-maintenance.html) documentation

# Know Your Environment

## Environment Details

This lab environment is setup with Enterprise Manager Cloud Control Release 13.3
and Database 19.3 as Oracle Management Repository.

Workshop activities included in this lab will be executed both locally on the
instance using Enterprise Manager Command Line Interface (EMCLI) or Rest APIs,
and the Enterprise Manager console (browser)

## Prerequisites

Prior to starting, you will need:

-   SSH Private Key to access the host via SSH

-   Instance Public IP address

# Getting started 

## Access

1.  Login to Host using SSH Key based authentication

    Refer to [Frequently Asked Questions](https://github.com/oracle/learning-library/blob/master/enterprise-manageability-library/enterprise_manager/OCIMarketplaceEM-FAQ.md) 
    doc for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):

    -   Authentication OS User - “opc”

    -   Authentication method - SSH RSA Key

    -   Oracle EM and DB Software OS User – “oracle”.

    First login as “opc”, then sudo to “oracle”. E.g. “sudo su - oracle"
    
2.  OMS URL: and Credentials:

    -   Username: **sysman**

    -   password: **welcome1**

    You may see an error on the browser while accessing the Web Console - “*Your
    connection is not secure*”, add exception and proceed. Access this URL and
    ensure that you are able to access Enterprise Manager Web Console.

## Update the Named Credentials with your SSH Key

1.  Log into your Enterprise Manager VM using the Public IP of your EM instance.
    The Enterprise Manager credentials are “**sysman/welcome1**”.

2.  Navigate to “Setup menu (gear) \> Security\> Named Credential and Select
    ROOT credential; Click Edit. Replace the existing entry with your SSH
    Private Key and Click on Test and Save.

    ![](media/5429da7dcd00ecc7da6e779ed699c45e.jpg)

# Fleet Maintenance Login to EMCLI 

Upon login as user “oracle” via sudo from user “opc”, the following are
performed automatically for your convenience:

-   OMS environment variables set

-   emcli session is established

While connected as “oracle” your emcli session may expire at some point due to
inactivity. Should that occur run “**emcli login -username=sysman
-password=welcome1**” or simply exit and login again to reestablish a new
session.

1.  Exit terminal session as “oracle” back to “opc”  
    [oracle\@emcc \~]\$ exit

2.  Sudo to oracle  
    [opc\@emcc \~]\$ sudo su - oracle

# Steps Completed in Advance

In the interest of simplifying the setup and save time, the following steps were
completed in advance:

-   We have created a pre-patched Oracle Home with 18.10 release using which we will create the gold image
    [/u01/app/oracle/product/18/db_home_src,
    Orasidb18c_home1_2020_05_13_04_10_9_emcc.marketplace.com_3192]

To ensure smooth execution of the intended use cases, we have pre-hosted the
scripts to be used later at /home/oracle/fleet

# Workshop Activity 1: Detect Configuration Pollution

This exercise enables us to analyze the database estate using Software
Standardization.

## Software Standardization Advisor

Software Standardization Advisor enables administrators to understand various
database configurations prevailing in their environment. Each deployment with a
unique platform, release and patch level is identified as a distinct
configuration. This provides the administrators a view of the configuration
pollution in their estate. It also analyzes and provides a recommendation to
standardize the environment and reduce the number of configurations required for
managing the database estate.

![](media/2de751b1331829d53a7b96f6feca6c60.png)

1.  Log on to Enterprise Manager Console as sysman

2.  Click on Targets \> Databases.

    ![](media/038585c9308635261ae7e4aa956525af.png)

3.  In the Databases targets page, click on Administration \> Click Software
    Standardization Advisor

    ![](media/6198ae4976d5ddad0fde0432c472e9e8.jpg)

4.  Software Standardization Advisor shows two graphs depicting current
    configuration and recommended configuration.

    ![](media/47b4e9b7912393c2a93a283db42e61a1.jpg)

    A Software Configuration is identified by Database Release, Platform and set of
    Patches installed on the target.

    The Software Configuration Advisor run shows that there are 5 Unique Software
    Configurations in the environment as shown in the pie chart labelled as “Current
    Unique Software Configurations” and recommendation is to maintain 2 Software
    Configurations as shown in the pie chart labelled as “Recommended Software
    Configurations”.

    Let us see details of the reports in next steps.

5.  Click on Generate Report.

6.  Click on Current Configurations to open the Excel report

    ![](media/0e038f3bcf66c76ae804361dad21ffa2.jpg)

    When opening the downloaded Excel Spreadsheet report, a warning on XLS format
    and file extension mismatch may pop up (see below). Simply click on “Yes” to
    ignore the warning and open the file.

    ![](media/d9ea997d07c30f80083e097f6b578200.png)

    Current Configuration shows five different Oracle home software versions
    
    ![](media/84e0ac92b29e45e91b9d17a8e0b3a2da.jpg)

7.  Next, click on Recommended Configurations to open the Excel Report

    ![](media/02a39c45b351146bec1e94859830a0ea.jpg)

    The EM Recommended Configuration report recommends reducing 5 configurations and
    standardizing the database estate on 2 configurations, one based on 18c and the
    other based on 19c. This means All Oracle Homes of Release 18c should uptake the
    corresponding 18c configuration and the 19c homes will use the one based on
    Release 19c

    ![](media/06ff90fdba8aa5abebd066086e33f700.jpg)

    Recommendation is based on union of all bugs included in the Patches in all OHs
    and based on configuration type.

## Summary

This completes the “Detect Configuration Pollution” exercise. In summary, you
learned how to perform the following:

-   Access the Database Software Standardization Advisor

-   View Configuration summary

-   Generate and download current and recommended configuration reports

In the next section we will follow these recommendations to perform the
following using Enterprise Manager 13c Fleet Maintenance.

-   Patch database “hr.subnet.vcn.oraclevcn.com” from 18.3 to 18.10

# Workshop Activity 2: Database Server patching with Fleet maintenance

## Database Fleet Maintenance 

Enterprise Manager Database Fleet Maintenance is a Gold Image Target
subscription based out of place patching solution. Gold Image(s) are software
library entities storing archive of a patched software home. Targets, to be
patched, subscribe to a relevant Gold Image. Target subscription persists
through the lifecycle of the Target or Gold Image unless modified by an
administrator. We will go through the following steps for this Fleet Maintenance Exercise.

![](media/DB_Fleet_Patching.png)

## Patching with Fleet Maintenance

We will go through steps for patching database target
**hr.subnet.vcn.oraclevcn.com**, a Container Database that is currently at
18.3.0.0.0 version. The goal is to patch this target to 18.10.0.0.0. As part of
patching exercise this Container Database and all Pluggable Databases in that
Container Database will automatically get patched.

1.  Log on to Enterprise Manager Console and review the status and version of DB
    Target.

    ![](media/ec0b6926d4f65b52a771483ace24055c.png)

    ![](media/c064eebf1a17dfd14d9c5921a88f93cb.jpg)

    You will see **hr.subnet.vcn.oraclevcn.com** Container Database has a pluggable
    database ‘HRPDB’. Both the Container Database and Pluggable database targets
    have status ‘UP’ and version 18.3.0.0.0. If target status is ‘DOWN’, start the
    target (using /home/oracle/start_db_hr.sh).

### Create Gold Image

2.  Gold Image Creation

    Gold Image represents a software end state. An Enterprise Manager Software
    Library Gold Image is a software archive created from a patched oracle home
    uploaded to EM Software Library.

    a)  Reference Home Setup [READ-ONLY– This step has already been implemented]

    In order to create a Gold Image of the ‘recommended patch configuration’, you
    need to manually create such an Oracle Home as a pre-requisite step. As the goal
    is to patch Database 18.3 targets with Database 18.10 RU, a reference Oracle
    home fully patched to 18.10 [ /u01/app/oracle/product/18/db_home_src] was
    created and used to create the initial version of the Gold Image as further
    described in the next steps..

    This patched reference Oracle Home is discovered in Enterprise Manager as shown
    below and will be used for Gold Image Creation.

    Navigate to “Targets \> All Targets” and type in
    “Orasidb18c_home1_2020_05_13_04_10_9_emcc.marketplace.com_3192” in the “Search
    Target Name” box.

    ![](media/ea2416958193764cc47426f0ad8a0a67.jpg)

    b) Create New Gold Image from ssh terminal using the following emcli command

    [oracle\@emcc \~]\$ cd \~/fleet

    [oracle\@emcc \~]\$ emcli db_software_maintenance -createSoftwareImage
    -input_file="data:/home/oracle/fleet/sidb18c_tier2.inp"

    **OR**

    [oracle\@emcc \~]\$ sh create_image_Tier2_sidb_x64.sh  
  


    ![](media/1791b5df10396b908e81340d2c6abed4.png)

    c) Click on Enterprise \> Provisioning and Patching \> Procedure Activity to
        review Execution details of this operation via Enterprise Manager Console

    ![](media/e9091a9e1e04a1a988cb61d9171a483d.png)

    d) Click on ‘CreateGoldImageProfile_...’ run and review the steps performed.  

    ![](media/f30e3920a7a7e18e4bdfffa328e9d483.png)

    e) Use ‘Show’ filter ‘Steps Not Skipped’ ; View:‘Expand All’ for detailed view
    of all the steps performed to complete an operation.

    ![](media/c3d174049d514ac6c22ce65167d55776.png)

3.  List Available Gold Images

    a) Execute the following commands in ssh terminal to see the list of Gold
       Images available for deployment, locate ‘Tier \#2 SI DB Linux64*’* in the
       emcli command output:
       [oracle\@emcc \~]\$ emcli db_software_maintenance -getImages

       ![](media/979c7a2ab44a65b0a6faf911cac1b64a.png)
       IMAGE ID retrieved from the output of above command is used in further operations like Target Subscription.

    b) After retrieving a list of the available images, one can view a list of
       versions available for a specific image with the following command:

       [oracle\@emcc \~]\$ emcli db_software_maintenance -getVersions
       -image_id=\<*IMAGE ID from List available gold images*\>

       This command lists Gold Image versions with their VERSION ID and STATUS.

       ![](media/a9b1233fb416f91b34518744dc0d7e9a.png)

       When a Gold Image is created for the first time, its first version is
       created as per the input and marked as current

       Whenever we run a DEPLOY operation for a target, Gold Image version marked
       as CURRENT is used to deploy the new Oracle Home.

4.  Verify if Gold Image is Applicable

    This step verifies if the image can be used to patch a specified database
    target. This is done by comparing the bug fixes available in the current Oracle
    home of the database target and the image. In effect this check is run to
    identify patch conflicts.

    a) Review and execute below emcli command:  
       [oracle\@emcc \~]\$ emcli db_software_maintenance -checkApplicability
       -image_id=\<*IMAGE ID from List available gold images\>*
       -target_list=hr.subnet.vcn.oraclevcn.com -target_type=oracle_database \>
       /home/oracle/applicability.out

       [oracle\@emcc \~]\$ cat /home/oracle/applicability.out

       Output of above command is redirected to a file. You may review the output
       using any standard editor or tool of your choice.

       ![](media/5f050173735f58aabd279987996192ea.png)

       This command can show one of the following results:

       -   Applicable: The image and database target contain the same set of bug fixes.
           The image can be applied on the specified target.

       -   Applicable and Image has more bug fixes: The image contains more bug fixes
           than those applied on the database. The list of extra bugs is displayed. The
           image can be applied on the specified target.

       -   Not Applicable: The database contains more bug fixes than those included in
           the image. The list of missing bugs is displayed. The administrator has to
           create a new version of the image that includes the missing bugs before the
           database can uptake the same.

### Subscribe Database 

5.  Subscribing Targets to the Selected Gold Image

    ![](media/1168b19325ea9b9c0624cf404d0cb689.jpg)

    a)  Execute below command to subscribe the target hr.subnet.vcn.oraclevcn.com to
    Gold Image

    [oracle\@emcc \~]\$ emcli db_software_maintenance -subscribeTarget
    -target_name=hr.subnet.vcn.oraclevcn.com -target_type=oracle_database
    -image_id=*\<IMAGE ID from List available gold images\>*

    Where:

    -   target_name – Name of the Database target which needs to be patched

    -   target_type – type of target to be patched. This should be oracle_database
    in this case

    -   image_id – ID of the Gold Image to which the target should be patched

    ![](media/ca94c4b76f9c24eee24f4d06b35c6764.png)

### Deploy Image 

6.  Gold Image Deployment

    ![](media/dadf62c68bd6d2180a20b977086a26a1.jpg)

    a) A new Oracle Home is deployed on the host where DB target is running with
    the below commands:

    [oracle\@emcc \~]\$ emcli db_software_maintenance -performOperation
    -name="deploy1810" -purpose=DEPLOY_DB_SOFTWARE -target_type=oracle_database
    -target_list=hr.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN
    -privilege_credential=ROOT:SYSMAN
    -input_file="data:/home/oracle/fleet/deploy1810_hr.inp"
    -procedure_name_prefix="DEPLOY"

    **OR**  
    [oracle\@emcc \~]\$ sh deploy1810_hr.sh

    Where:

    NEW_ORACLE_HOME_LIST = Absolute path to the File System location where new
    Oracle Home will be deployed.

    procedure_name_prefix = optional, prefix for the deployment procedure instance
    name

    name = Name of the operation. This is a logical name and should be kept unique

    purpose = There are standard purposes defined which can be performed by Fleet
    Operations. “DEPLOY_DB_SOFTWARE” is one of them. These are predefined and should
    not be changed. Admin shall select one of the below mentioned purposes as and
    when needed.

    target_type = The type of target being provided in this operation.

    target_list =

       1.  This is a comma separated list of targets which need to be patched.

       2.  Targets of homogenous types are supported in a single fleet operation.

       3.  The system will calculate the unique list of hosts based on this target list
           and start stage of Oracle home software on those hosts.

       4.  If targets running from same Oracle home are provided in this list, the
           stage and deploy operation will be triggered only once and not for all
           targets.

    normal_credential = This should be provided in the format \<Named
    Credential: Credential Owner\>.

    privilege_credential = This should be provided in the format \<Named
    Credential: Credential Owner\>

    start_schedule = Schedule when the stage and deploy should start if that
    needs to be done in future. Format: “start_time:yyyy/mm/dd HH:mm”. It’s an
    optional parameter, if not provided, operation will start immediately

    ![](media/af4139d4bf2fd69f82fa8903e6520833.png)

    b) Navigate to Enterprise \> Provisioning and Patching \> Procedure Activity to
       Review Execution Details of this operation via Enterprise Manager Console.
       Click on ‘DEPLOY_SYSMAN_\*’ run

    ![](media/e3002b6d99e5a3654676f41911a3766d.png)

    c) Review the Procedure Activity steps performed.

    ![](media/68541ee5acf4db8b4f26a5a794b1c15c.png)

### Migrate Listener

7.  Migrate Listener

    a) Review and execute the following command to Migrate the Listener

    [oracle\@emcc \~]\$ emcli db_software_maintenance -performOperation
    -name="Migrate Listener" -purpose=migrate_listener
    -target_type=oracle_database -target_list="hr.subnet.vcn.oraclevcn.com"
    -normal_credential="ORACLE:SYSMAN" -privilege_credential="ROOT:SYSMAN"  
    **OR**  
    [oracle\@emcc \~]\$ sh migrate_listener_hr_update.sh

    ![](media/3b1e1e85cf38e639a314570bc212a3ac.png)

    b) Navigate to Enterprise \> Provisioning and Patching \> Procedure Activity to
    Review Execution Details of this operation via Enterprise Manager Console.
    Click on ‘Fleet_migrate_\*’ run

    ![](media/c90e201dd7b74e1dbe0cab82acafe6fa.png)

    c) Review the Procedure Activity steps performed.  
    
    ![](media/91d2873ae19a8b7b53a5d31c842b5b9f.png)

### Update Database – Patch 18.3 to 18.10 

8.  Database Update

    Once the deploy operation completes successfully. We are ready to run the
    final UPDATE operation which patches the database by switching it to the
    newly deployed home.

    ![](media/427b340f11443b09283ed979935fe1fc.jpg)

    a) Review and execute below command to update DB Target
    hr.subnet.vcn.oraclevcn.com

    [oracle\@emcc \~]\$ emcli db_software_maintenance -performOperation
    -name="Update DB" -purpose=UPDATE_DB -target_type=oracle_database
    -target_list=hr.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN
    -privilege_credential=ROOT:SYSMAN -database_credential=sales_SYS:SYSMAN  
    **OR**

    [oracle\@emcc \~]\$ sh update_hr.sh

    Where:

    Name – Name of the operation. This is a logical name and should be kept
    unique  
    Purpose – There are standard purposes defined which can be performed by
    Fleet Operations. “UPDATE_DB” is one of them.

    ![](media/8ddbd68dee0300c0223d11cc9407c08a.png)

    b) Navigate to the Procedure Activity Page and monitor the progress of this
    operation with ‘Fleet_UPDATE_...’ deployment procedure instance.

    ![](media/7a784412472d166c3eb16a775dea578e.png)

    c) Review the Procedure Activity steps performed  

    ![](media/b47cafe1b4d1342e408c52e86f3102ce.png)

    d) Verify the patched target by going to Targets-\>Databases as shown below.
    Operation above will take 10-15 minutes to complete.

    ![](media/425da84e806d9024383be869fda527d4.png)

### Rollback Database – Reversed Patch 18.10 to 18.3 

9.  Database Rollback

    Once the database is updated, we will perform a rollback to 18.3

    a) Review and execute below command to rollback DB Target
    hr.subnet.vcn.oraclevcn.com  
    [oracle\@emcc \~]\$ curl -i -X POST
    https://emcc.marketplace.com:7803/em/websvcs/restful/emws/db/fleetmaintenance/performOperation/rollback
    -H "Content-Type:application/json" -u sysman:welcome1 --data-binary
    "\@/home/oracle/fleet/rollback_hr_payload.json" --insecure

    **OR**

    [oracle\@emcc \~]\$ sh rollback_hr.sh  

    ![](media/acb8ad0f4fb9ad39503081f5cdfb9e79.png)

    b) Navigate to the Procedure Activity Page and monitor the progress of this
    operation with ‘Fleet_ROLLBACK_...’ deployment procedure instance.

    ![](media/6999f44a0845085f3660f365bb24d7d3.png)

    c) Review the Procedure Activity steps performed         

    ![](media/6a12674bdf0e9535535b90cf043a1605.png)

    d) Verify the rolled back target by going to Targets-\>Databases as shown
    below.

    ![](media/7afa56b6cb5fee053c57b141a5c08245.png)

### Cleanup Old Homes

10. Clean up Database HR
    In order to have an old empty home previously used by
    “**hr.subnet.vcn.oraclevcn.com**” at our disposal to demonstrate a cleanup
    operation, we will now re-update the database by running the commands from
    Step 8.

    a) Review and execute below command to update DB Target
    hr.subnet.vcn.oraclevcn.com again to 18.10 version

    [oracle\@emcc \~]\$ emcli db_software_maintenance -performOperation
    -name="Update DB" -purpose=UPDATE_DB -target_type=oracle_database
    -target_list=hr.subnet.vcn.oraclevcn.com -normal_credential=ORACLE:SYSMAN
    -privilege_credential=ROOT:SYSMAN -database_credential=sales_SYS:SYSMAN  
    **OR**
    [oracle\@emcc \~]\$ sh update_hr.sh

    Where:

    Name – Name of the operation. This is a logical name and should be kept
    unique  
    Purpose – There are standard purposes defined which can be performed by
    Fleet Operations. “UPDATE_DB” is one of them.

    ![](media/05dc434c461c068b157f9dd7cd6b10ce.png)

    b) Verify that the update has been completed successfully before proceeding
    with any cleanup action, Same as done in step \#8, this should complete
    within 10\~15 minutes.

    ![](media/444749cbf21602a501446fe9c14b1949.png)

    c) Verify and confirm that the target has been re-patched to 18.10 by going to
    Targets Databases as shown below

    ![](media/05d8c8153c8c990ac80810fef434baa3.png)

    d) Review and execute the following command to cleanup hr in reportOnly mode  
    [oracle\@emcc \~]\$ emcli db_software_maintenance -performOperation
    -name="Cleanup old oracle homes" -purpose=CLEANUP_SOFTWARE
    -target_type=oracle_database -normal_credential=ORACLE:SYSMAN
    -privilege_credential=ROOT:SYSMAN -target_list=hr.subnet.vcn.oraclevcn.com
    -workDir=/tmp -reportOnly=true  
    **OR**

    [oracle\@emcc \~]\$ sh cleanup_hr_report.sh

    ![](media/9b5d405577571043afe9ead1fc723392.png)

    e) Review and execute the following command to cleanup hr  
    [oracle\@emcc \~]\$ emcli db_software_maintenance -performOperation
    -name="Cleanup old oracle homes" -purpose=CLEANUP_SOFTWARE
    -target_type=oracle_database -normal_credential=ORACLE:SYSMAN
    -privilege_credential=ROOT:SYSMAN -target_list=hr.subnet.vcn.oraclevcn.com
    -workDir=/tmp  
    **OR**

    [oracle\@emcc \~]\$ sh cleanup_hr.sh

    ![](media/f0443cb23cec56d4d3c3818720c73c80.png)

    f) Navigate to the Procedure Activity Page and monitor the progress of this
    operation with ‘CLEANUP_SOFTWARE_...’ deployment procedure instance.

    ![](media/1ffb1bc964b9ca980d6f6034d4882156.png)

    g) Review the Procedure Activity steps performed        

    ![](media/c2062c09719c5c4b41ceff3138b3d44e.png)

    h) Verify to confirm the old Oracle Home has been removed

    [oracle\@emcc \~]\$ ls -l /u01/app/1806/hr

    ![](media/31324fdd072b03be848fa9362de9ae7b.png)

    i)  As part of the cleanup operation, LISTENER_1522 which support
    “hr.subnet.oraclevcn.com” is shutdown. Set your environment by passing “hr”
    to “oraenv” when prompted and start the listener back up.

    [oracle\@emcc \~]\$ . oraenv \# Type in “hr” when prompted for the SID

    [oracle\@emcc \~]\$ lsnrctl start LISTENER_1522

    ![](media/465b2cea9ae4e176c314eff253ef4b68.png)

    j) Force Listener registration and confirm that it is now servicing
    “**hr.subnet.vcn.oraclevcn.com**”

    [oracle\@emcc \~]\$ sqlplus '/as sysdba'

    SQL\> alter system register;

    SQL\> exit

    [oracle\@emcc \~]\$ lsnrctl status LISTENER_1522

    ![](media/b95a982c86b233dfa1af34d29c03aa6e.png)

## Summary

This completes the “[Standalone Database Server patching with Fleet
maintenance](#workshop-activity-2-standalone-database-server-patching-with-fleet-maintenance)”
exercise. In this section, you learned how to perform the following:

-   Create Oracle Database Software Gold Image

-   Subscribe Database to Gold Image

-   Deploy Gold Image to Database Host

-   Migrate Oracle Database Listener from old Oracle Home to newly Deployed
    Oracle Home

-   Update (Patch) Database from 18.3 to 18.10

-   Rollback (Un-patch) Database from 18.10 to 18.3

-   Clean up old Oracle Homes

Thank you!
