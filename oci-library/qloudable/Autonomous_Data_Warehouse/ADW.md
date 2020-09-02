# Deploying and configuring Autonomous Data Warehouse.

## Table of Contents

[Overview](#overview)

[Prerequisites](#Prerequisites)

[Sign in to OCI Console and create ADW instance](#sign-in-to-oci-console-and-create-adw-instance)

[Create Auth token for the user connect to ADW and load data](#create-auth-token-for-the-user-connect-to-adw-and-load-data)

[Delete the resources](#delete-the-resources)

## Overview

Oracle Autonomous Data Warehouse Cloud provides an easy-to-use, fully autonomous database that scales elastically, delivers fast query performance and requires no database administration. In this hands on lab, we will walk through deploying an Autonomous Data Warehouse database and loading a table using a text file that is stored in object storage. The purpose of this lab is to get familiar with Oracle Autonomous Data Warehouse primitives. At the end of this lab, you will be familiar with launching an Autonomous Data Warehouse database, creating an object storage bucket and loading a table using a text file stored in object storage

**Some Key points;**

**We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%**


- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

- Do NOT use compartment name and other data from screen shots.Only use  data(including compartment name) provided in the content section of the lab

- Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the OCI Console

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

**Cloud Tenant Name**
**User Name**
**Password**
**Compartment Name (Provided Later)**

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

## Prerequisites

1. OCI Training : https://cloud.oracle.com/en_US/iaas/training

2. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

3. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

4. Familiarity with Compartment: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

5. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm


## Sign in to OCI Console and create ADW instance


* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}


1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="image-alt-text">


2. From the OCI Services menu,Click **Autonomous Data Warehouse** under **Database** and then **Create Autonomous Database**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_001.PNG" alt="image-alt-text">

3. Fill out the dialog box:

- COMPARTMENT: Choose your compartment
- DISPLAY NAME: Provide a name
- DATABASE NAME: Provide a name
- Choose a Workload type: Data Warehouse
- Choose a Deployment type: Shared Infrastructure

Under **Configure the database**

- Always Free: Leave Default
- Choose database version: Leave Default
- OCPU count: 1
- Auto Sclaing: Make sure flag is Un-checked

Under **Create administrator credentials**

- Username: Provide a username 
- Password: Provide a password (example Oracle123!!!!)
- Confirm Password: Confirm the password provided

Under **Choose network access**

- Allow secure accces from anywhere: Make sure this option is checked
- Confifure access conrol rules: Leave default (unchecked)

Under **Choose a license type**

- License Included: Check this option

4. Click **Create Autonomous Database**

5. Click Autonomous Data Warehouse Database instance name that you created to bring up Database details page. Click **DB Connection**

6. In the pop up window Click **Download** under **Download Client Credentials (Wallet)**. Provide a password, Click **Download** and save the zip file (Note down zip file location)

**HINT:** You can use the same password that was used to create the instance or choose a new password. Note down the password

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_004.PNG" alt="image-alt-text">

**We now have a Autonomous Data Warehouse instance created. We have also downloaded the Client Credentials file. We will use this file when connecting to the database instance  using Sql Developer. Next we will create a Data file and use Object stroage to upload it to Database instance.**
              
## Create Auth token for the user connect to ADW and load data

In this section we will generate auth token for the user of this lab. An Auth token is an Oracle-generated token that you can use to authenticate with third-party APIs and Autonomous Database instance.

1. In OCI console Click the user icon (top right)  then **User settings**. Under Resrouces Click **Auth Token**, then **Generate Token**. In pop up window provide a description then Click **Generate Token**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_005.PNG" alt="image-alt-text">
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_006.PNG" alt="image-alt-text">

2.  Click **Copy** and save the token in Notepad.**Do not close the window without saving the token as it can not be retrieved later**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_007.PNG" alt="image-alt-text">

3. Note down your user name

**Next we will connect to this ADW instane using SQL developer.**

**Screen shots for SQL developer are from 18.1.0 version**

4. Launch SQL devleoper using Apps icon and Click **+** to create a new connection

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_008.PNG" alt="image-alt-text">
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_009.PNG" alt="image-alt-text">

5. Fill out the diaog box:


- Connection Name: Provide a name
- Username: admin
- Password: Password used at ADW instance creation
- Save Password: Check the flag
- Connection Type: Cloud PDB
- Configuration file: File that was dowloaded from ADW service console (Client credenitla zip file)
- Keystore password: Password you provided when downloading the client credentials file 

**NOTE:** If using SQL devleoper 18.2.0 or higher this field is not available and not required


- Service: YOUR_ADW_INSTANCE_NAME_medium 
- Click **Save**
- Click **Connect** and verify Successful connection

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_010.PNG" alt="image-alt-text">

6. Create a new user called ocitest and grant the DWROLE to ocitest user. . Also grant this user table space quota to upload the data later on. Enter commands:
```
create user ocitest identified by P#ssw0rd12##;
```

```
Grant dwrole to ocitest;
```

```
Grant UNLIMITED TABLESPACE TO ocitest;
```

7. Verify the user was created

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_011.PNG" alt="image-alt-text">

8. Create another connection in SQL Developer (same steps as above), use following values:


- Connection Name: Provide a name
- Username: OCITEST
- Password:  P#ssw0rd12## 
- Save Password: Check the flag
- Connection Type: Cloud PDB
- Configuration file: File that was dowloaded from ADW service console (Client credenitla zip file)
- Keystore password: Password you provided when downloading the client credentials file (NOTE:If using SQL devleoper 18.2.0 or higher this field is not available and not required)
- Service: YOUR_ADW_INSTANCE_NAME_medium 
- Click **Save**
- Click **Connect** and verify Successful connection


<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_012.PNG" alt="image-alt-text">

9. We will now download a text file from OCI Object storage. This file has commands that will be used to upload data into ADW and retrieve it. Open a new browser tab and copy/paste or Enter URL;

**https://objectstorage.us-ashburn-1.oraclecloud.com/n/us_training/b/Lab-images/o/ADW-File.txt**

**NOTE:** No spaces in URL

10. Using OCITEST user store your Object Storage credenitals. From the ADW-File.txt content copy and paste the commands under  
/**** Set Definitions ****/ section. The commands will look like below

**Begin**

**DBMS_CLOUD.create_credential (**

**credential_name => 'OCI_CRED_NAME',**

**username => '<YOUR_USER_NAME>',**

**password => '<AUTH_TOKEN>'**

**) ;**

**end;**

**NOTE:** user name should be your user name and password should be the Auth Token generated earlier.

11. Verify **PL/SQL Procedure successfully completed** message is displayed.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_013.PNG" alt="image-alt-text">

12. Create a new table (We will load data from file in Object Storage to this table). From the ADW-File.txt content copy and paste the commands undrer /**** Create Table ****/ section. The commands will look like below

**CREATE TABLE CHANNELS (**

**NAME VARCHAR2(20) NOT NULL ,**

**gender VARCHAR2(20) NOT NULL ,**

**NAME_total NUMBER NOT NULL );**

13. Verify **Table CHANNELS created** message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_014.PNG" alt="image-alt-text">

14. Load data from file in Object Storage to newly created table.

**NOTE:** A data file with 1000s of records exists in OCI Object storage and we will use this file records to populate ADW From the ADW-File.txt content copy and paste the commands undrer  /**** DBMS ****/ section. The commands will look like below

**begin**

**dbms_cloud.copy_data(**

**table_name =>'CHANNELS',**

**credential_name =>'OCI_CRED_NAME',**

**file_uri_list =>'https://swiftobjectstorage.us-ashburn-1.oraclecloud.com/v1/us_training/Lab-images/century_names_new.txt',format => json_object('delimiter' value ',', 'trimspaces' value 'lrtrim')**

**);**

**end;**

15. Verify **PL/SQL Procedure successfully completed** message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_015.PNG" alt="image-alt-text">

16. We will now query the table and veirfy the data Enter command:
```
select * from channels;
```

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_016.PNG" alt="image-alt-text">

**We have successfully deployed a Autonomous Data Warehouse instance,populated a table using a file stored in Object storage and successfully run a query against the table.**

## Delete the resources

**Delete Auth Token and Autonomous Data Warehouse**

1. Navigate to User Settings ,Click **Auth Token** and Click **Delete** for your Auth Token by Hovering your mouse over action icon (Three Dots)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_017.PNG" alt="image-alt-text">

2. Navigate to Autonomoud Data Warehouse menu, Hover over the action icon(Three dots) and Click **Terminate**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_018.PNG" alt="image-alt-text">

**Congratulations! You have successfully completed the lab.**

