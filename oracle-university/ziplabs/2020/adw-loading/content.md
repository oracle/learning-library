# Loading Data into ADW #

## Before You Begin ##
This 20-minute lab walks you through the steps to get data from external databases and load it into the Oracle Autonomous Data Warehouse (ADW) on Oracle Cloud Infrastructure (OCI). This lab assumes you have already provisioned an ADW instance.

### Background ###
You can load data into Autonomous Database using Oracle Database tools and 3rd party data integration tools. Data can be loaded:
* from files local to your client computer, or
* from files stored in a cloud-based object store

For the fastest data loading experience Oracle recommends uploading the source
files to a cloud-based object store before loading the data into your Autonomous Database.

Today we will use the PL/SQL package **DBMS\_CLOUD**. The DBMS_CLOUD package supports loading
data files from the following Cloud sources:
1. Oracle Cloud Infrastructure Object Storage (OCI Object Storage)
2. Oracle Cloud Infrastructure Object Storage Classic
3. Amazon AWS S3

This tutorial shows how to load data from OCI Object
Storage using two of the procedures in the DBMS_CLOUD package:
* `create_credential`: Stores the object store credentials in your Autonomous Database schema.
* `copy_data`: Loads the specified source file to a table.


### What Do You Need? ###
* Access to an instance of Oracle Autonomous Data Warehouse (ADW)
* Have completed the previous lab **Provisioning Autonomous Data Warehouse**.


## STEP 1: Load a data file to your Object Store ##
Oracle Cloud Infrastructure offers two distinct storage class tiers.  Object Storage, for data which you need fast, immediate and frequent access and Archive Storage, for data which you seldom or rarely access.  In this ziplab you will stage data into an object store in the Oracle Cloud Infrastructure Object Storage service.

1. Login to your Oracle Cloud Infrastructure Console
2. Select **Object Storage** -> **Object Storage** from the drop down menu on the top left of the Oracle Cloud Infrastructure console.

    ![Autonomous Data Warehouse object storage](images/adw-loading-object-storage2.png " ")

3. Select **Create Bucket** to create a bucket to load your data in.  This will be your staging area.  Later in this lab you will move the data from this staging area to your ADW instance.
For this lab, we'll use the `root` compartment.

   ![Autonomous Data Warehouse loading create bucket screen](images/adw-loading-create-bucket-screen.png " ")

4. Enter the following information:
    * **Bucket Name**:  `bucket-<city you were born in>-<your initials>`  (example: *bucket-london-kam*)
    * **Storage Tier**:  `Standard`
    * **Encryption**: `Encrypt using Oracle Managed Keys`

    ![Autonomous Data Warehouse loading create bucket](images/adw-loading-create-bucket.png " ")

5. Click **Create Bucket**.
6. Click on the bucket name you just created.  

    ![Autonomous Data Warehouse loading buckets](images/adw-loading-buckets.png " ")

7. Review the screen. Note you have created an empty bucket with no objects in it and the visibility is set to private.

    ![Autonomous Data Warehouse loading bucket screen](images/adw-loading-bucket-screen.png " ")

8. Click **[here](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/adwc/OBE_Loading%20Your%20Data/files/datafiles_for_sh_tables.zip)** to download the zip file with the objects you will be importing into cloud storage.  The file will download to your desktop.  
9. Double click and **extract** the folder to your desktop.

9. Click the **Upload Object** button at the bottom of the page to begin selecting the data files to upload to the bucket.  

10. Choose all the files you just extracted, drag and drop them into the upload objects window.

    ![Autonomous Data Warehouse loading view objects](images/adw-loading-view-objects-4.png " ")

10. Select the ten data files and click **Open**.  Once the files are finished loading, click **Upload Objects** to load.

    ![Autonomous Data Warehouse loading select files](images/adw-loading-select-files.png " ")

11. Once complete, verify **all** *.dat files have a status of `Finished` and click **Close**.
12. Your bucket should have 10 objects loaded.  If this were a true data load, you may be loading *hundreds* of large files here.
12. The final step will be to change the visibility of your bucket. Click the **Edit Visibility** button at the top of your Bucket Details screen.

    ![Autonomous Data Warehouse loading edit visibility](images/adw-loading-edit-visibility.png " ")

13. Change the visibility to **Public**, accept all other defaults.  Click **Save Changes**.

    ![](images/adw-loading-update-visibility.png " ")

14. Your bucket should now be visible and public.  Verify and proceed to setting up your Auth token.

    ![](images/adw-loading-bucket-info.png " ")



## STEP 2: Create an Object Store Auth Token ##

To load data from the OCI object store, you need to create an Auth Token for your object store account. The
communication between your Autonomous Database and the object store relies on this Auth Token and username/password authentication.

1. If you have logged out of Oracle Cloud Infrastructure Object Storage, please log back in.
2. From the menu on the top left select **Identity->Users**. Once on the Users Page click on your username

    ![](images/adw-loading-identity-users.png " ")

3. Select your username.  Click **Auth Tokens** under **Resources** on the left of the console. _Note: This will be the the username you created when you launched your trial NOT ziplab\_user_.

    ![](images/adw-loading-user-screen.png " ")

4. Click **Generate Token**.

    ![](images/adw-loading-user-token.png " ")

5. A pop-up dialog appears. Set the Auth Token by performing the following steps:
    * In the pop-up dialog, enter a description.  Click the **Generate Token** button.

    ![](images/adw-loading-token-description.png " ")

    * Copy the generated token to notepad located on your desktop. The token does not appear again and you WILL NEED this token to load your data into ADW.

    ![](images/adw-loading-generated-token.png " ")

    * Click **Close**.



## STEP 3: Create Object Store Credentials in your Autonomous Database ##

Now that you have created an object store Auth Token, its time to store the credentials of the object store in ADW instance.

1. Let's navigate to SQL Developer web to prepare your ADW instance for the staged data.  
Go back to your ADW instance via the menu.

    ![](images/adw-loading-view-dbs.png " ")

2. Click on the ADW instance you created in a previous exercise and verify it is still running.

    ![](images/adw-finance-mart.png " ")

3. Click on **Service Console**.  If the service console does not open a new tab, ensure pop up blocker is turned off for your browser.  Click on **Development** to access the developer tools for ADB.

    ![](images/adw-loading-service-console.png " ")

4. Click on **SQL Developer Web**.

    ![](images/adw-loading-navigate-sql-dev.png " ")

5. Enter your database admin username from the previous exercise and login to your ADW instance.

    _Note:  When you provisioned your ADW instance you wrote down an admin password for your new database.  Use this to log in to SQL Developer web.  You can go back to your ADW instance and reset your admin password via the menu._

    ![](images/adw-loading-sql-dev-logging-in.png " ")

6. SQL Developer Web has an interface similar to the installed client.  Note where the Worksheet is and the Query Results.
7. Copy the PL/SQL procedure into SQL Developer Web. Fill in the username and password using the Oracle Cloud username you signed up with and the auth token you saved earlier. The create\_credential procedure of the DBMS\_CLOUD package stores the object store credentials in your database. This PL/SQL procedure takes in the following arguments:
    * Credential name
    * Oracle Cloud username
    * Authorization token created earlier

    ```SQL
    begin  
    DBMS_CLOUD.create_credential (  
    credential_name => 'OBJ\_STORE\_CRED',  
    username => '\<enter your username\>',  
    password => '\<enter your savedAuth Token\>'  
    ) ;  
    end;  
    /
    ```

    ![](images/adw-loading-create-credential.png " ")

8. Press the green arrow to run the worksheet.  Once the correct information is entered, you should get a message that the ``PL/SQL procedure completed``
9. Your object store's credentials are stored in
your ADW instance now.  


## STEP 4: Copy Data from Object Store to Autonomous Database Tables ##
Before data is copied, the tables and objects need to be created in ADW.  In this lab you will create the target objects.

1. Download the SQL script to create the tables for your ADB instance **[here](files/adw-loading.sql)**.  Open up the file in notepad from your desktop.   _(Remember to click the back button to return to this window)_ This script will be used to create the tables and constraints.

2. Copy and paste the commands in your SQL Developer Web worksheet area overwriting any existing commands.

    ![](images/adw-loading-paste-sql.png " ")

3. Select the entire script and press the green play button.

    ![](images/adw-loading-green-play.png " ")

4. Once the script has run review the output to ensure the tables and constraints have been created successfully.  

    ![](images/adw-loading-create-tables-3.png " ")

5. Now you have empty tables and staged data in the OCI Object store. To get the data from the object store to your ADB instance, you need to get some information about the object. To move the data we will be using the dbms\_cloud.copy\_data procedure.  The procedure takes information about the location of the data you staged in your object store.  Review the procedure.

    ````SQL    
    begin
    dbms_cloud.copy_data(
        table_name =>'<ENTER_TABLE_NAME>',
        credential_name =>'OBJ\_STORE\_CRED',
        file_uri_list =>'\<entertenancy-bucket-address\>/chan_v3.dat',
        format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
    );
    end;
    /
    ````

5. Leave SQL Developer Web open in a tab and go back to your tenancy and select **Object Storage->Object Storage** from the menu. Select your bucket.
6. In the objects section, locate one of the data files.  Click on the three dots on the right.

    ![](images/adw-loading-view-bucket-objects.png " ")

7. Click **View Object Details**.  

    ![](images/adw-loading-view-object-details-3.png " ")

8. Right click on the URI Path and select Copy Link Location. Paste the URI into a notepad. In the script that will be provided the file and table names are already there. You are going to remove the file name from the end and that is the URI you will use in the following steps.

    ![](images/adw-view-object-details-customers.png " ")

9. Download this [SQL script](files/adw-loading-copy-data.sql)  to load your tables. _(Remember to click the back button to return)_.  Replace the file\_uri\_list with the string you saved in notepad. The script already has the correct table names, just replace the tenancy address.

    ````SQL
    begin
        dbms_cloud.copy_data(
            table_name =>'<ENTER_TABLE_NAME>',
            credential_name =>'OBJ_STORE_CRED',
            file_uri_list =>'<replace this urlpart>'/chan_v3.dat,
            format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
        );
    end;
    /
    ````

10. Paste the SQL script into SQL Worksheet.
11. For each of the URI in the script you will need to replace only the first portion of the file\_uri\_list leaving the file name as is. Leave the table names intact as they are preset for you in the SQL script.

    ![](images/adw-loading-copy-data-2.png " ")

12. This time click the run script button.

    ![](images/adw_sql_dev_web_script_button.png " ")

13. In the Script Output, once you see the message `PL/SQL procedure successfully completed.`, Query a few of the tables to see the rows that were inserted.  
    ````SQL
    select * from sales;
    select * from customers;
    ````

Success! Notice that the data has been copied from the object store to the tables in your ADW instance.

This can be done for multiple tables providing an easy migration path from your existing databaset to Autonomous Database.

## Want to Learn More? ##
* [Autonomous Database Cloud Certification](https://education.oracle.com/en/data-management/autonomous-database/product_817?certPage=true) from Oracle University
* [Data Management Cloud Courses](https://learn.oracle.com/pls/web_prod-plq-dad/dl4_pages.getpage?page=dl4homepage&get_params=offering:35573#filtersGroup1=&filtersGroup2=.f667&filtersGroup3=&filtersGroup4=&filtersGroup5=&filtersSearch=) from Oracle University
