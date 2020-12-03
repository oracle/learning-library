# Load ADB Database

## Introduction
In the previous lab you created a compute instance (running the eShop application on docker), and an AJD instance to run your application on.  In this lab you will run a script to import data from Object Store into your Autonomous JSON Database (AJD) using Oracle Data Pump.  Your data was previously in various other types of databases.  In this lab we will show you how to centralize your data onto one database that your application can read from.

*Estimated time:* 40 Minutes

### Objectives
- Load AJD Instance with eShop data
- Connect application to AJD

### Prerequisites
- Lab: Generate SSH Keys
- Lab: Setup Compute and ADB

## **STEP 1:**  Load AJD Instance
1. If you aren't already logged into Oracle Cloud please do so and restart Oracle Cloud Shell
2. In the cloud shell prompt execute the wget command to download the load script and execute it.  
3. Substitute yourinstance name with *your adb instance name* and append _high to the name (e.g convgdb_high)
   
      ````
      cd $HOME
      pwd
      wget load-ajd.sh
      load-ajd.sh yourinstancename_high
      ````
4.  Test to ensure that your data has loaded by logging into SQL Developer Web and issuing the command below. *Note* The Username and Password for SQL Developer Web are admin/WElcome123##. You should get 1950 rows.

      ````
      select count(*) from orders;
      ````


## **STEP 2:**  Connect Docker Instance to AJD

1.  Run the script env\_setup\_script.sh, this will start the database, listener, oracle rest data service and our eshop application. This script could take 2-5 minutes to run.

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
* **Last Updated By/Date** - Kay Malcolm, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/converged-database). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
