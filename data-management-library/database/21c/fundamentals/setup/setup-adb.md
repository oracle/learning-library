# Setup

## Introduction
In the previous lab you created an ADB instance.  In this lab you will connect to the ADB instance from Oracle Cloud Shell.

*This lab is under construction*

*Estimated time:* 20 Minutes

### Objectives
- Create auth token and Oracle Wallet 
- Load ADB instance

### Prerequisites
- Lab: Provision ADB

## **STEP 1:** Create Oracle Wallet in Cloud Shell
There are multiple ways to create an Oracle Wallet for ADB.  We will be using Oracle Cloud Shell as this is not the focus of this workshop.  To learn more about Oracle Wallets and use the interface to create one, please refer to the lab in this workshop: [Analyzing Your Data with ADB - Lab 6](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?p180_id=553)

1.  Login to the Oracle Cloud if you aren't logged in
2.  Click the Cloud Shell icon to start up Cloud Shell
      ![](./images/cloud-shell.png " ")
3.  While your Cloud Shell is starting up, click on the Hamburger Menu -> **Autonomous Transaction Processing** 
      ![](./images/select-atp.png " ")

4.  Click on the **Display Name** to go to your ADB main page.
   
5.  Locate the **OCID** (Oracle Cloud ID) you will need that in a few minutes. 

      ![](./images/locate-ocid.png " ")

6.  Use your autonomous\_database\_ocid to create the Oracle Wallet. You will be setting the wallet password to the same value as the ADB admin password for ease of use: *WElcome123##* Note: This is not a recommended practice and just used for the purposes of this lab. 
7.  Copy the command below and paste it into Cloud Shell.  Do not hit enter yet.  

      ````
      <copy>
      cd ~
      oci db autonomous-database generate-wallet --password WElcome123## --file 21c-wallet.zip --autonomous-database-id  </copy> ocid1.autonomousdatabase.oc1.iad.xxxxxxxxxxxxxxxxxxxxxx
      ````

      ![](./images/wallet.png " ")

8.  Press copy to copy the OCID from Step 5 and fill in the autonomous database ocid that is listed in the output section of your terraform.  Click enter

9.  The wallet file will be downloaded to your cloud shell file system in /home/yourtenancyname

10. Enter the list command in your cloud shell below to verify the *21c-wallet.zip* was created
   
      ````
      ls
      ````
      ![](./images/21cwallet.png " ")

## **STEP 2:** Create Auth Token

1.  Click on the person icon in the upper right corner.
2.  Select **User Settings**
      ![](./images/select-user.png " ")

3.  Under the **User Information** tab, click the **Copy** button to copy your User OCID.
      ![](./images/copy-user-ocid.png " ")

4.  Create your auth token using the command below substituting your actual *user id* for the userid below.  *Note: If you already have an auth token, you may get an error if you try to create more than 2 per user*
   
      ````
      <copy>
       oci iam auth-token create --description adb1 --user-id </copy> ocid1.user.oc1..axxxxxxxxxxxxxxxxxxxxxx
      ````
      ![](./images/token.png " ")

5.  Identify the line in the output that starts with "token".
6.  Copy the value for the token somewhere safe, you will need it for the next step.


## **STEP 3:**  Load ADB Instance with Application Schemas
1. Go back to your cloud shell and start the cloud shell if it isn't already running
   
2. Run the wget command to download the load_21c.sh script from object storage.

      ````
      <copy>
      cd $HOME
      pwd
      wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/G-3O894R-xUdJ9uf-keoHUZ3YTaNWIuhPry9sRKFmvEhhf503MbRXAxlA3-bSMxQ/n/idma9bvgdlpn/b/adb1-adb/o/load-21c.sh
      chmod +x load-21c.sh
      </copy>
      ````

3.   Run the load script passing in the arguments from your notepad.  two arguments, your admin password and the name of your ATP instance.  This script will import all the data into your ATP instance for your application and set up SQL Developer Web for each schema.  This script runs as the opc user.  Your ATP name should be the name of your ADB instance.  In the example below we used *adb1*.  This load script takes approximately 3 minutes to run.  *Note : If you use a different ADB name, replace adb1 with your adb instance name*

      ``` 
      <copy> 
      ./load-21c.sh WElcome123## adb1 2>&1 > load-21c.out</copy>
      ```

      ![](./images/load21c-1.png " ")

4.  As the script is running, you will note failures on the DBA role. The DBA role is not available in Autonomous Database, the DWROLE is used instead. This error is expected. 

      ![](./images/load21c-2.png " ")   
5.  Test to ensure that your data has loaded by logging into SQL Developer Web and issuing the command below. *Note* The Username and Password for SQL Developer Web are admin/WElcome123##. There should be 665 items.

      ````
      <copy>
      sqlplus admin/WElcome123##@adb1_high
      select count(*) from oe.order_items;
      </copy>
      ````

*Note: If you are unable to login, set your TNS_ADMIN variable to your home directory/wallet*

6. Exit the sql prompt

    ````
    exit
    ````
    ![](./images/exit.png " ")

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** - Kay Malcolm
* **Last Updated By/Date** - Kay Malcolm, March 2021

