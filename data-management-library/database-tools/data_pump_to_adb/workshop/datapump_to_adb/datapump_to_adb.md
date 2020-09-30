# Data Pump your data to the Oracle Autonomous Database

### Objectives

-   Migrate data from a source database to the Oracle Autonomous Database using SQL Developer

### Required Artifacts

-   The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

### Prerequisites
This lab assumes you have completed the following labs:
[Login to Oracle Cloud] (?lab=lab-1-login-oracle-cloud) and [Provision ADB] (?lab=lab-2-provision-adb)
* Lab: [Login to Oracle Cloud](https://oracle.github.io/learning-library/data-management-library/autonomous-database/shared/workshops/livelabs-overview/?lab=lab-1-login-oracle-cloud)
* Lab: [Provision an Autonomous Database](https://oracle.github.io/learning-library/data-management-library/autonomous-database/shared/workshops/livelabs-overview/?lab=lab-2-provision-adb)
* Lab: [Connect to ADB with SQL Dev Web](https://oracle.github.io/learning-library/developer-library/rest-services-for-adb/livelabs/?lab=lab-3-connect-to-adb-with-sql-dev-web)

A Source database is needed. You may already have Virtual Box on your laptop, a database in your data centre, a Docker container running Oracle, and so on.

If you need a simple database to act as a source you can follow the preliminary labs listed here to establish one.
* Lab: [Deploy a Compute Instance and create a database]
* Lab: [Install the sample schemas]
* Lab: [Establish VNC on a Compute Instance]

This lab will use SQL Developer to coordinate the migration. If you already have SQL Developer co-located with your source database then you are prepared. If you have built the environment described above, you can install SQL Developer on your Compute Instance. If you have not done so look at this lab on how to install SQL Developer
* Lab: [Install SQL Developer on a Compute Instance]

Privileges to run Data Pump are required.
At least one Credential defined to your Oracle Object Store ‘bucket’

In this lab you will use the SQL Developer tool, connect to your source database and use Data Pump to create an export of your schema. SQL Developer can then import that data directly in to the Autonomous Database via the Oracle Object Store.

## **Step 1:**Create a BUCKET in the Oracle Object Store
1. Open the Oracle Cloud console and log in as your registered user
2. From the hamburger menu on the left select "Object Storage"
![](../../images/create_object_storage_1.png)

3. Click *Create Bucket* to create a bucket in the Oracle Object Store
![](../../images/create_object_storage_2.png)

4. Give the bucket a name and click *Create Bucket*
![](../../images/create_object_storage_3.png)

5. Select the bucket you have just created
![](../../images/create_object_storage_4.png)

6. From the Bucket Information section *Copy* the Bucket OCID
![](../../images/create_object_storage_5.png)

````
OCID: ocid1.bucket.oc1.ap-myRegion-1.aaaaVeryLongStringOfCharactersmi5a
````
7. Store this information in a Notepad as you will need it during the export of your data

## **Step 2:**Generate an AUTH token
Before you can push and pull files to and from Oracle Cloud Infrastructure Registry, you must already have an Oracle Cloud Infrastructure username and an auth token. To generate an AUTH token follow these steps
1. From the top right hand of the console window, select the *Profile* icon and click on your username
![](../../images/create_auth_token_profile_1.png)

2. Click *Auth Tokens* in the Resources menu
![](../../images/create_auth_token_profile_2.png)

3. Click *Generate Token*
![](../../images/create_auth_token_profile_3.png)

4. Provide a Description for the auth token. Avoid entering confidential information.
![](../../images/create_auth_token_profile_4.png)

5. Copy the Generated Token information to a secure location from where you can retrieve it later. You won't see the auth token again in the Console.
4. Provide a Description for the auth token. Avoid entering confidential information.
![](../../images/create_auth_token_profile_5.png)

````
Auth token: )Abc123doremiU&Me:3.ixj0.
````
## **Step 3:**Connect to ADB instance and create a credential
1. Start SQLDeveloper on your Compute instance
Use the pull down menu to select SQL Developer (Applications -> Programming)
![](../../images/SQLDeveloper_start_menu.png)

or open a Terminal and enter:
````
<copy>
/usr/local/bin/sqldeveloper
</copy>
````
2. Create a new connection to your ADB database (atplab) as the *admin* user
![](../../images/SQLDeveloper_connect_ATP_1.png.png)
Provide the connection details
````
Name: atplab
Authentication Type: default
Username: admin
Password: MyPasswordDetails
Connection Type: Cloud Wallet
Configuration File: Path on compute instance to downloaded cloud wallet (/home/opc/Wallet_DBname.zip)
Service: atplab_high (dbname_high)
````
3. *Test* the connection to validate the entered information

4. Connect to the ADB Instance and enter the password (if you did not save it with the connection)
![](../../images/SQLDeveloper_connect_ATP_2.png.png)

5.

## **Step 1:**Connect SQL Developer to your local Instance
1. Start SQLDeveloper on your Compute Instance
Use the pull down menu to select SQL Developer (Applications -> Programming)
![](../../images/SQLDeveloper_start_menu.png)

or open a Terminal and enter:
````
<copy>
/usr/local/bin/sqldeveloper
</copy>
````
2. Create a new connection to your local database (orclpdb) as the SYSTEM user (password is *Ora_DB4U*)

![](../../images/SQLDeveloper_create_system_connection.png)

3. Open the DBA View (SQLDeveloper -> View -> DBA)
![](../../images/SQLDeveloper_view_DBA.png)

4. Add the SYSTEM connection to the DBA view - Enter the password when prompted
![](../../images/SQLDeveloper_DBA_system.png)

## **Step 2:**Extract data from your local database
1. Open the Data Pump Wizard
From the DBA views, select your SYSTEM connection, open Data Pump, select Export Jobs, then Actions and finally Data Pump Export Wizard
![](../../images/SQLDeveloper_data_pump_2.png)

2. In this lab we will export the Sales History (SH) schema. Select the Schemas radio button. Click Next
![](../../images/SQLDeveloper_data_pump_wizard_step_2.png)

3. Select the SH schema and select the add arrow (>). The SH schema will move to the *Selected* side. Click Next
![](../../images/SQLDeveloper_data_pump_wizard_step_3.png)

4. No need for a Filter. Click Next

5. Click More to show we will export ALL Objects. Click Next
![](../../images/SQLDeveloper_data_pump_wizard_step_5.png)

6. Accept the default DATA_PUMP_DIR and export log file name (EXPDAT.LOG). Click Next
![](../../images/SQLDeveloper_data_pump_wizard_step_6.png)

7. Click Yes to confirm that you are licensed for Advanced Compression
![](../../images/SQLDeveloper_data_pump_wizard_step_6a.png)

8. Accept the defaults for the data pump export file name (EXPDAT%U.DMP) and click Next
![](../../images/SQLDeveloper_data_pump_wizard_step_7.png)

9. CLick Next to indicate that job should be scheduled immediately
![](../../images/SQLDeveloper_data_pump_wizard_step_8.png)

10. Review the settings and click Finish to start the Data Pump Export
![](../../images/SQLDeveloper_data_pump_wizard_step_9.png)

11. Job will begin executing immediately
![](../../images/SQLDeveloper_data_pump_wizard_step_10.png)

12. Click Refresh symbol (2 blue arrows) to update job status (will eventually show NOT RUNNING)
or open a terminal and *tail -f* the expdmp log file in $ORACLE_BASE/admin/ORCL/dpdump/<Identifier>/EXPDAT<timestamp>.LOG, for example:
````
sudo su - oracle
cd $ORACLE_BASE
tail -f ./admin/ORCL/dpdump/A24A0F23F87C284FE0537F00000AFF5C/EXPDAT01-05_51_33.DMP
````
![](../../images/Datapump_export_log_tail.png)

![](../../images/SQLDeveloper_datapump_completed.png)

The Data pump export will be approximately 9.6 MB in size
````
ls -al ./admin/ORCL/dpdump/A24A0F23F87C284FE0537F00000AFF5C/EXPDAT01-05_51_33.DMP
-rw-r-----. 1 oracle dba 9650176 May 29 05:53 ./admin/ORCL/dpdump/A24A0F23F87C284FE0537F00000AFF5C/EXPDAT01-05_51_33.DMP
````

## **Step 3:**Create a BUCKET in the Oracle Object Store


## Acknowledgements

 - **Author** - Troy Anthony, Jeff Smith May 2020
 - **Last Updated By/Date** - Troy Anthony, May 28 2020

 ## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
