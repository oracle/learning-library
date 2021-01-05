<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

August 4, 2019
</td>
<td class="td-banner">
# Lab 13: Migrating to Dedicated ATP using Data Pump
</td></tr><table>

### Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
## Introduction

Oracle Data Pump offers very fast bulk data and metadata movement between user managed Oracle databases and Autonomous Transaction Processing.

Data Pump Import lets you import data from Data Pump files residing on the Oracle Cloud Infrastructure Object Storage. You can save your data to your Cloud Object Store and use Oracle Data Pump to load data to dedicated ATP database.

This lab walks you through the steps to migrate a sample application schema using datapump import into your dedicated ATP database.


## Objectives

As a database admin or user,

1. Download a sample datapump export dump file from Oracle Learning Library github reposiory.
2. Upload .dmp file to OCI Object storage bucket.
3. Setup cloud credentials and use data pump import to move data to your ATP database.



## Required Artifacts
- An Oracle Cloud Infrastructure account with privileges to create object storage buckets and dedicated autonomous databases.
- Access to a pre-provisioned dedicated ATP instance. Refer to [Lab 4](./ProvisionADB.md)
- A pre-provisioned instance of Oracle Developer Client image in an application subnet. Refer to [Lab 6](./ConfigureDevClient.md)

## Steps

### **Step 1:** Download sample data pump export file from Oracle Learning Library github repo

Use the following command from your mac / PC to download a sample schema dump from OLL

    wget --no-check-certificate --content-disposition https://github.com/oracle/learning-library/blob/master/data-management-library/autonomous-transaction-processing/dedicated/scripts/datapump/nodeapp.dmp?raw=true

​
### **Step 2:** Create an object storage bucket and upload dump

- Login to your OCI account with your user credentials

- Naviage to Object Storage from top left hamburger menu

![nav-to-obj-store](./images/HOL-DataPump/nav-to-obj-store.png)

- Pick a compartment you have priviledge to,

![pick-compartment](./images/HOL-DataPump/pick-compartment.png)

- Create a bucket and lets call it nodeAppBucket. Leave the encryption options to default and hit **Create Bucket**



![nodeapp_bucket](./images/HOL-DataPump/nodeapp-bucket.png)

- Upload nodeapp.dmp downloaded from OLL

![upload-dmp](./images/HOL-DataPump/upload-dmp.png)


### **Step 3:** General an authentication token for your user account

- Assuming you are logged into your OCI account, navigate to the user details page from the top right menu item as shown below

![get-token1](./images/HOL-DataPump/get-token1.png)

- Next on the user details page, scroll down to see  **Resources** on the left and generate an **Auth Token** as shown below.

![get-token2](./images/HOL-DataPump/get-token2.png)


- Provide any desired name and copy the generated token string some place in a text editor. You will need this token while configuring cloud credentials on your  target database.

![get-token3](./images/HOL-DataPump/get-token3.png)


### **Step 4:** Setup Object Store user credentials in your target autonomous database

Now that we have the credentials token, lets setup the target database to read from object store and import data.

- Log into your dedicated autonomous database as admin using either SQL Developer or SQLCL client.

Note: There are two ways to do this - 

1. If you connected to your OCI VPN you provisioned earlier, you may directly launch SQL*Developer on your local machine and connect to your dedicated ATP as discussed in [Lab 6](./ConfigureVPN.md)

2. You may ssh to a developer client image provisioned in a public subnet as discussed in [Lab 5](./ConfigureDevClient.md). Once logged into your dev client, you may then launch SQL*Plus as discussed in Lab 6.  It is recommended you launch a dev client to use the command line import utility impdp later in this lab. Alternatively, you may also connect to your dev client over VNC and launch SQL Developer from there.

Here, we will use a local SQL Developer to demonstate the steps needed to setup object store credentials

Once connected to your autonomous database as user 'admin', run the following pl/sql procedure, replacing username and password with your own cloud credentials.

    BEGIN
     DBMS_CREDENTIAL.CREATE_CREDENTIAL(
     credential_name => 'userXX_cred',
     username => ‘OCI-Username',
     password => 'Your-Auth-Token-Here'
     );
     END;
    /


Here's a screen shot of the above command run from a SQL Developer Client

![credentials](./images/HOL-DataPump/credentials.png)

Ensure the pl/sql procedure executed successfully from the log message

### **Step 5:** Import data from object store using impdp utility

- If all went well so far, proceed to ssh into your developer client machine and run the data pump import command.

**Windows users may connect to the dev client using Putty**       

        $ ssh -i <private-key-file> opc@<IPAddress-of-Dev-Client>


You will also need to download your target database wallet file so impdp can make a secure connection to your target database

Besides, ensure TNS_ADMIN environment variable points to the location where you downloaded and unzipped your wallet. For eg. in this case we created a folder wallet under /home/opc, download **and unzipped** the wallet in there

    $ export TNS_ADMIN=/home/opc/wallet


**Finally, the stage is set to run the import command from your dev client bash prompt**

    $ impdp admin/password@connect_string \
    REMAP_TABLESPACE=USERS:DATA \
     directory=data_pump_dir \
     credential=userXX_cred \
     dumpfile= https://swiftobjectstorage.us-ashburn-1.oraclecloud.com/v1/Tenancy-Name/Bucket-Name/nodeapp.dmp \
     parallel=16 \
     partition_options=merge \
     exclude=index,cluster,indextype,materialized_view,materialized_view_log,materialized_zonemap,db_link \
     nologfile=yes


In the above command, replace - 

**password** - Admin password for your autonomous DB
**connect_string** - connect string obtained from database console, it would be something like myDatabase_high
**directory** - leave as shown above
**dumpfile** - Use swift URL. If your .dmp file is in Ashburn, simply replace tenancy and bucket name

**Ensure nologfile=yes, else the command fails**
![import1](./images/HOL-DataPump/import1.png)

If all goes well, your import will complete in a minute as shown below. Ignore the statement,

 Failing sql is:
 GRANT "DBA" TO "NODEAPP"

It indicates that while the user 'NODEAPP' had the DBA role assigned in the source database, that role is not available in the ATP instance due to security lockdowns. More details on ATP security lockdowns can be found [here](https://docs.oracle.com/en/cloud/paas/atp-cloud/atpdg/experienced-database-users.html#GUID-11ABDC70-C99F-48E4-933B-C7D588E4320A)

![import2](./images/HOL-DataPump/import2.png)


All Done! Your application schema was successfully imported. Note that once uploaded to object store, the dump file was in a private bucket with no visibility outside of your tenancy namespace. This is important so your data file is not accessible from anyone on the internet.

You may now connect to your autonomous database using a SQL client and validate import.




<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
### Congratulations! You have successfully completed migration of an Oracle database to the dedicated Autonomous service.
</td>
</tr>
<table>
