# Introduction

This is the second of several labs that are part of the **Oracle Autonomous Data Warehouse Cloud Workshop**. This workshop will walk you through several use cases of using an autonomous data warehouse.

This lab walks you through some examples using the Oracle
Autonomous Data Warehouse Cloud with Object Storage. You will create and Object Storage bucket, upload data files, and use SQL developer to query those data files.


## Objectives

- Learn how to use OCI Object Storage
    - Create buckets
    - Upload Files
- Learn how to use SQL Developer with ADWC and Object Storage
    - Copy object storage file data to internal tables in Autonomous Data Warehouse Cloud using SQL Developer
    - Create external tables that reference files in object storage


## Required Artifacts

- The following lab requires an Oracle Public Cloud trial account.


# Oracle Cloud Infrastructure (OCI) Object Storage

Oracle Object Storage is a web-based interface that provides the ability to accelerate a broad range of high performance applications with your choice of high IO block storage, and durable, high-throughput object storage.

Key features of OCI Object Storage:
- Persistent IO-intensive block storage and high-throughput object storage options to handle multiple application types, and data at different lifecycle stages.
- Each is manageable through the console and by CLI.

## Creation and Upload

### **STEP 1**: Access Oracle Cloud Infrastructure

- Log into your Oracle cloud account

- Click on the hamburger menu icon on the top left of the dashboard screen

- Expand **Services** and click on **Compute**

    ![](./images/200/14.png)


### **STEP 2**: Access the Object Storage Console.

- Select the **Storage** tab in the navigation bar

    ![](./images/200/2.png)

- Select **Object Storage** in the side menu

    ![](./images/200/3.png)

### **STEP 3**: Create Object Storage Bucket

- Select **Create Bucket**

    ![](./images/200/4.png)

- Enter the following information:

  -   **Bucket Name** - &lt;yourname&gt;OS. &lt;&lt; Prefix your storage bucket name with a unique name (you can use your name, for example), e.g. JackOS. Since all users will be using the same cloud account, it is important that you use a unique bucket name.

  -   **Storage Tier** - Standard &lt;&lt; Do not select Archive as this tier will store its data differently.

Select **Create Bucket**.

    ![](./images/200/5.png)

### **STEP 4**:  Upload files to your storage bucket.

- Here we will download two files. One CSV and one JSON file. In later steps, we will use SQL Developer to query the data inside these files.

- Download Insurance.csv from github repository:
    - Open the following link in a new tab: https://raw.githubusercontent.com/unofficialoraclecloudhub/autonomous-campaign/master/workshops/adwc-trialcampaigns/objectstorage/Insurance.csv
    - Right Click anywhere on browser page and select **Save as...**
    - Save file

- Download colors.json from github repository:
  - Open the following link in a new tab: https://raw.githubusercontent.com/unofficialoraclecloudhub/autonomous-campaign/master/workshops/adwc-trialcampaigns/objectstorage/colors.json
  - Right Click anywhere on browser page and select **Save as...**


- Go back to OCI Object Storage Console

- Select your bucket name in the list of buckets. i.e. &lt;yourname&gt;OS

    ![](./images/200/6.png)

- Let's upload the CSV file.

  - Select **Upload Object**

    ![](./images/200/7.png)

  - Select **Browse** and select your recently saved csv file.

    ![](./images/200/8.png)

  - Select **Upload Object** and the popup will disappear.

- Now lets upload the Json file.

  - Select **Upload Object**

    ![](./images/200/7.png)

  - Select **Browse** and select your recently saved json file.

    ![](./images/200/8.png)

  - Select **Upload Object** and the popup will disappear.


### **STEP 5**: Retrieve swift password.

 - Click the drop down with username logged in, and select **User Settings**.

    ![](./images/200/9.png)

 - Select **Swift Passwords**.

    ![](./images/200/10.png)

 - Select **Generate Password**.

    ![](./images/200/11.png)

 - Give a brief description, i.e. "dbms cloud api credential" and Select **Generate Password**

    ![](./images/200/12.png)

 - Record / Copy the newly generated password for the next step.

Next, we are going to use our Autonomous Data Warehouse Cloud instance connected with SQL Developer to interact with the data files residing in our recently create Object Storage bucket.

## Querying Data Files in Object Storage

### **STEP 6**:  Connect Autonomous Data Warehouse Cloud instance to data in Object Storage

- Go to the SQL Developer console that you connected in a previous lab. Here's a reference to that lab section: https://github.com/unofficialoraclecloudhub/autonomous-campaign/blob/master/workshops/adwc-trialcampaigns/LabGuide100.md#connecting-to-the-database-using-sql-developer


- Use DBMS_CLOUD API to create credentials. For more information about DBMS_CLOUD, please refer to this: https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/dbmscloud-reference.html#GUID-52C9974C-D95E-4E41-AFBD-0FC4065C029A

As the user you created, run the following command, replacing **oci-username** with your OCI username, and **swift-password** with the swift password you generated in step 6

```

set define off
begin
  DBMS_CLOUD.create_credential(
    credential_name => 'OBJ_STORE_CRED',
    username => '<oci-username>',
    password => '<swift-password>'
  );
end;
/

```

This commands utilizes DBMS Cloud API to store your swift password as a credential when your Autonomous Data Warehouse Cloud / SQL Developer tries to connect to Object Storage.


### **STEP 7**:  Create an internal table for CSV file

Now that we have set up an Object Storage bucket and connected SQL Developer to our Autonomous Data Warehouse Cloud, we can start interacting with the data files that we uploaded. It is possible to copy file data to internal tables or connect to the file through an external table. In this lab we will do both.

- Create the schema for your internal table.

```

CREATE TABLE INSURANCE (policyID NUMBER(20), statecode VARCHAR(20), county VARCHAR(20));

```

- Use DBMS_CLOUD PL/SQL procedure to copy the data into the new tables. **Note:** you will need to replace **region** , **tenant** , and **bucket** in the file_uri_list parameter. You can find tenancy and region here:

    ![](./images/200/13.png)

Use this information for the **file_uri_list** parameter in the DBMS_CLOUD function.

```

begin
 dbms_cloud.copy_data(
    table_name =>'INSURANCE',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'https://swiftobjectstorage.<region>.oraclecloud.com/v1/<tenant>/<bucket>/Insurance.csv',
    format => json_object('delimiter' VALUE ',')
 );
end;
/

```

Now you can query this table and retrieve data that previously only existed in Object Storage.


### **STEP 8**:  Create an external table for CSV file

If for whatever reason you'd like to keep your data in Object Storage, you can create external tables. Instead of storing the data, it will store the connection to Object Storage so that it can quickly retrieve the data.

**Note:** you will need to replace **region**, **tenant** , and **bucket** in the file_uri_list parameter.

Go back to Oracle Cloud Infrastructure Console to get the information about tenancy and region

![](./images/200/13.png)

Then in SQL Developer, run the following PL/SQL scripts.

```

begin
 dbms_cloud.create_external_table(
    table_name =>'INSURANCE_EXT_CSV',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'https://swiftobjectstorage.<region>.oraclecloud.com/v1/<tenant>/<bucket>/Insurance.csv',
    format => json_object('delimiter' VALUE ','),
    column_list => 'policyID NUMBER(20), statecode VARCHAR(20), county VARCHAR(20)'
 );
end;
/

```

  ![](./images/200/15.png)

Now you can query this external table the same way you would query an internal table.


### **BONUS STEP**: Query JSON data

One of the benefits of the Oracle Database 18c that powers Autonomous Data Warehouse Cloud is the ability to natively query JSON data. With Object Storage and the DBMS_CLOUD API in SQL Developer, you can query external JSON files.


- Create external table for JSON file

```

begin
 dbms_cloud.create_external_table(
    table_name =>'COLORS_EXT_JSON',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'https://swiftobjectstorage.<region>.oraclecloud.com/v1/<tenant>/<bucket>/colors.json',
    column_list => 'co_document VARCHAR(32767)'
 );
end;
/

```

Notice that there's only one column for the json document. To query this data, use the following syntax:

```
select co.co_document from COLORS_EXT_JSON co;
```
```
select co.co_document.colors.color from COLORS_EXT_JSON co;
```
For more information about JSON querying, please refer to this: https://docs.oracle.com/database/121/ADXDB/json.htm

This is the end of Lab 200. You can proceed with [Lab 300: Creating Visulization using ADWC](LabGuide300.md). 
