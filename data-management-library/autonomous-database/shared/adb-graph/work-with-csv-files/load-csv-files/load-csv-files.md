# Graph Studio: Load data from CSV files into tables

## Introduction

In this lab you will load two CSV files into corresponding tables using the Database Actions SQL (aka SQLDeveloperWeb) interface of your 
Autonomous Data Warehouse - Shared Infrastructure (ADW) or Autonomous Transaction Processing - Shared Infrastructure (ATP) instance.

The following video shows the steps you will execute in this lab.

[](youtube:F_3xe18kWoo) Graph Studio: Load CSV Files.



Estimated Lab Time: 10 minutes. 

### Objectives

Learn how to
- load CSV files into an Autonomous Database using Database Actions SQL (aka SQLDeveloperWeb)


### Prerequisites

- The following lab requires an ADB-Shared (ADW/ATP) account. 
- A Graph-enabled and REST-enabled user has been created. That is, a database user with the correct roles and privileges exists and that user can log into Database Actions (aka SqlDeveloperWeb).


## **STEP 1**: Connect to the Database Actions (aka SQL Developer Web) for your ADB instance

1. Open the service detail page for your ADB instance in the OCI console. 

2. Click on the Tools tab and then the Database Actions link to open it. Or click on the Service Console link and then the Development link and open Database Actions (or SQL  Developer Web).
   ![](./images/01-launch-SDW-tools-page.png " ")

## **STEP 2**: Login as the graph-enabled user

1. Login as the graph user (e.g. AGDLATEST) for your ADB instance. 

    ![](./images/02-SDW-login.png " ")  

    **Note:** If necessary, do the following to create the user with the right roles and privileges:
    - Log in to Database Actions (SQL Developer Web) as the ADMIN user for your ADB.
    - Select Administration and then Database Users from the navigation menu
    - Click on Create User
    - Turn on the REST-enable and Graph-enable buttons

## **STEP 3**: Download the sample datasets from the ObjectStore

1. Use `wget` or `curl` to download the sample data, i.e. CSV files, to you computer. Or copy and paste the url in your browser for the zip archive, i.e.  

    ```
    https://objectstorage.us-ashburn-1.oraclecloud.com/p/2Z71OXMvPLSZcYliEoe49EVCvcjcW_FlXmqAR2JCdZ49cIecbP1e3gtMB-4Z68cN/n/c4u03/b/data-management-library-files/o/random-acct-txn-data.zip
    ```

    A sample `curl` request is:
    ```
    curl -G -o acct-txn-data.zip https://objectstorage.us-ashburn-1.oraclecloud.com/p/2Z71OXMvPLSZcYliEoe49EVCvcjcW_FlXmqAR2JCdZ49cIecbP1e3gtMB-4Z68cN/n/c4u03/b/data-management-library-files/o/random-acct-txn-data.zip
    ```

2. Unzip the archive into a local directory such as ~/downloads.

## **STEP 4**: Upload using SQLDeveloperWeb

1. Click on the Data tab in the SQLDeveloperWeb worksheet. Then click on `Select Files`.

   ![](./images/03-upload-first-file.png)

2. Navigate to the correct folder (e.g. ~/downloads) and select the bank_account.csv file.
![](./images/04-choose-accts-file.png)

3. Preview the data then click `Next`.
![](./images/05-preview-accts-file.png)

4. Modify the properties as follows:
    - Change the column type for `ACCT_ID` to `NUMBER`.
    - Click the PK checkbox to indicate that it is a primary key.

   ![](./images/06-accts-edit-properties.png)

5. Click `Next` to view the generated DDL. Then click `Finish` to create the table and load the data. 
   ![](./images/07-accts-view-ddl.png)
   
   Note: If you see an error message that the SDW$ERR$_BANK_ACCOUNTS$ table could not be created then check that the user has adequate quota for the tablespace name `DATA` or whichever tablesapce the user has privileges on.

6. Once the file is loaded you should see the table in the list on the left.
   ![](./images/08-accts-loaded.png)

7. Now repeat the process for the second file, i.e. bank_txns.csv. 
   
   ![](./images/09-upload-second-file.png)

8. Navigate to the correct folder (e.g. ~/downloads) and select the bank_txns.csv file.  
   ![](./images/10-choose-txns-file.png)

9. Edit the proeprties as follows:
    - Change the data type for `FROM_ACCT_ID`, `TO_ACCT_ID`, and `AMOUNT` to `NUMBER`.
    - Change the length for `DESCRIPTION` to 128.
    - Check the `PK` checkbox for each of `FROM_ACCT_ID`, `TO_ACCT_ID`, and `AMOUNT` to indicate that these columns form the composite primary key.  
   
   ![](./images/11-txns-edit-properties.png)
  
10. Click `Next` to view the generated DDL. Then click `Finish` to create the table and load the data.  
   ![](./images/12-txns-ddl.png)

11. Once the file is loaded you should see the table in the list on the left.  
   ![](./images/13-txns-loaded.png)


Please **proceed to the next lab** to create a graph from these tables.

## Acknowledgements
* **Author** - Jayant Sharma, Product Management
* **Contributors** -  Jayant Sharma, Product Management
* **Last Updated By/Date** - Jayant Sharma, Jan 2021
  
## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-graph). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
