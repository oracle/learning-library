# Load ADB and Start Application

## Introduction
In the previous lab you created a compute instance (running the eShop application on docker), and an AJD instance to run your application on.  In this lab you will run a script to import data from Object Store into your Autonomous JSON Database (AJD) using Oracle Data Pump.  Your data was previously in various other types of databases.  In this lab we will show you how to centralize your data onto one database that your application can read from.

*Estimated time:* 40 Minutes

### Objectives
- Create auth token and Oracle Wallet 
- Login to SQL Developer
- Load AJD Instance with eShop data
- Connect application to ADB

### Prerequisites
- Lab: Generate SSH Keys
- Lab: Setup Compute and ADB

## **STEP 1:** Create Oracle Wallet
There are multiple ways to create an Oracle Wallet for ADB.  We will be using Oracle Cloud Shell as this is not the focus of this workshop.  To learn more about Oracle Wallets and use the interface to create one, please refer to the lab in this workshop: [Analyzing Your Data with ADB - Lab 6](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?p180_id=553)

1.  Before starting this section make sure you have exited out of your compute instance and are back in your cloudshell home.  
2.  With the autononous\_database\_ocid that is listed in your apply results, create the Oracle Wallet. You will be setting the wallet password to a generic value:  *WElcome123##*.  
   
      ````
      <copy>
      oci db autonomous-database generate-wallet --password WElcome123## --file converged-wallet.zip --autonomous-database-id </copy> ocid1.autonomousdatabase.oc1.iad.xxxxxxxxxxxxxxxxxxxxxx
      ````
3.  The wallet file will be downloaded to your cloud shell file system in /home/yourtenancyname
4.  Click the list command below to verify the *converged-wallet.zip* was created
   
      ````
      ls
      ````
5.  Transfer this wallet file to your application compute instance.  Replace the instance below with your instance 

    ````
    sftp -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address> <<< $'mput converged-wallet*' 
    ````


## **STEP 2:** Create Auth Token
There are multiple ways to create an Oracle Wallet for ADB.  We will be using Oracle Cloud Shell as this is not the focus of this workshop.  To learn more about Oracle Wallets and use the interface to create one, please refer to the lab in this workshop: [Analyzing Your Data with ADB - Lab 6](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?p180_id=553)

1.  Click on the person icon in the upper right corner.
2.  Select **User Settings**
3.  Under the **User Information** tab, click the **Copy** button to copy your User OCID.
4.  Create your auth token using the command below substituting your actual *user id* for the userid below.
   
      ````
      <copy>
       oci iam auth-token create --description ConvergedDB --user-id </copy> ocid1.user.oc1..axxxxxxxxxxxxxxxxxxxxxx
      ````
5.  Copy the token somewhere safe, you will need it for the next step.


## **STEP 3:** Connect to SQL Developer and Create Credentials
1.  Go back to your ATP screen by clicking on the Hamburger Menu -> **Autonomous JSON Database**
2.  Click on the **Display Name**, *cvgadbnn*
3.  Click on the **Tools** tab, select **SQL Developer Web**, a new browser will open up
4.  Login with the *admin* user and the password that you wrote down in the previous lab.  (*Note*: the admin password can also be changed in the **More Actions** drop down)
5.  In the worksheet, enter the following command to create your credentials.  Replace the password below with your token. Make sure you do *not* copy the quotes.
   
    ````
    <copy>
    begin
      DBMS_CLOUD.create_credential(
        credential_name => 'DEF_CRED_NAME',
        username => 'admin',
        password => '************REPLACE THIS*****************'
      );
    end;
    /
    </copy>
    ````

## **STEP 4:**  Load AJD Instance
1. If you aren't already logged into Oracle Cloud please do so and restart Oracle Cloud Shell
2. In the cloud shell prompt execute the wget command to download the load script and execute it.  
3. Substitute yourinstance name with *your adb instance name* (e.g convgdb_high) and the password you used
*NOTE: The load-ajd.sh script is in the setup directory, it will be loaded to object store when in production.  Still being tested - Kay*
      ````
      <copy>
      cd $HOME
      pwd
      wget load-ajd.sh
      load-ajd.sh</copy> <<yourinstancename>> WElcome123##
      ````
4.  Test to ensure that your data has loaded by logging into SQL Developer Web and issuing the command below. *Note* The Username and Password for SQL Developer Web are admin/WElcome123##. You should get 1950 rows.

      ````
      <copy>
      select count(*) from orders;
      /copy>
      ````


## **STEP 5:**  Connect Docker Instance to AJD

1.  Run the script env\_setup\_script\_adb.sh, this will download the docker application from OKE (Oracle Kubernetes engine) start the eshop application. This script could take 2-5 minutes to run.

      ````
      <copy>cd /u01/script
      wget env_setup_script_adb.sh
      ./env_setup_script_adb.sh</copy>
      ````
   ![](./images/setup-script.png " ")

You now have a docker container running the eShop application and all the data across multiple modalities, JSON, Analytical data, XML, Spatial and Graph.  A true converged database.

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** - Kay Malcolm, Ashish Kumar
* **Contributors** - Ashish Kumar, Yaisah Granillo
* **Last Updated By/Date** - Kay Malcolm, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/converged-database). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
