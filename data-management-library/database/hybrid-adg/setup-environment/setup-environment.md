# Setup Primary Environment

## Introduction

In this lab you will setup an Oracle Cloud network (VCNs) and a compute instance with a pre-configured Oracle Database 19c using Oracle Resource Manager and Terraform. It's use to simulate the primary site.

Estimated Lab Time: 30 minutes

### Objectives

-   Use Terraform and Resource Manager to setup the on-premise primary environment.

### Prerequisites

This lab assumes you have already completed the following:
- An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
- Create a SSH Keys pair

Click on the link below to download the Resource Manager zip files you need to build your environment.

- [db19c-primary-num.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/hjoSts4QD56z3RLS-gl3RuyiPESRs9bSxfsKzdIYFAJ339ZgG-EXarwIiQM5xF5T/n/c4u03/b/data-management-library-files/o/db19c-primary-num.zip) - Packaged terraform primary database instance creation script.


## **STEP 1:** Prepare the Primary Database

1. Login to the Oracle Cloud Console, open the hamburger menu in the left hand corner. Choose **Resource Manager > Stacks**. Choose the **Compartment** that you want to use, click the  **Create Stack** button. *Note: If you are in a workshop, double check your region to ensure you are on the assigned region.*

     ![](./images/cloud-homepage.png " ")
      
     ![](./images/resource.png " ")
      
          
     
     ![](./images/step1.3-createstackpage.png " ")

2. Check the **.ZIP FILE**, Click the **Browse** link and select the primary database setup zip file (`db19c-primary-num.zip`) that you downloaded. Click **Select** to upload the zip file.

     ![](images/image-20201030094139692.png)

     Accept all the defaults and click **Next**.

3. Accept the default value of the `Instance_Shape`. Paste the content of the public key you create before to the `SSH_PUBLIC_KEY`,  and click **Next**. 

     ![](images/image-20201030094440068.png)

    

4. Click **Create**.

     ![](images/image-20201030094944273.png)

5. Your stack has now been created!  Now to create your environment. *Note: If you get an error about an invalid DNS label, go back to your Display Name, please do not enter ANY special characters or spaces. It will fail.*

     ![](./images/step1.7-stackcreated.png " ")

## **STEP 2:** Terraform Plan (OPTIONAL)

When using Resource Manager to deploy an environment, execute a terraform **Plan** to verify the configuration. This is an optional step in this lab.

1.  [OPTIONAL] Click **Terraform Actions** -> **Plan** to validate your configuration. Click **Plan**. This takes about a minute, please be patient.

     ![](./images/terraformactions.png " ")
      
     ![](images/image-20201030095622286.png)
      
     ![](./images/planjob.png " ")
     
     ![](./images/planjob1.png " ")

## **STEP 3:** Terraform Apply

When using Resource Manager to deploy an environment, execute a terraform **Plan** and **Apply**. Let's do that now.

1.  At the top of your page, click on **Stack Details**.  Click the button, **Terraform Actions** -> **Apply**. Click **Apply**. This will create your instance and install Oracle 19c. This takes about a minute, please be patient.

     ![](./images/applyjob1.png " ")

     ![](images/image-20201030095534379.png)

     ![](./images/applyjob2.png " ")

     ![](./images/step3.1-applyjob3.png " ")

2.  Once this job succeeds, you will get an apply complete notification from Terraform. In the end of the apply log,  you can get the **public ip address** of the primary instance. Congratulations, your environment is created! Time to login to your instance to finish the configuration.

     ![](images/image-20201030100144873.png)

## **STEP 4:** Connect to your Instance

### MAC or Windows CYGWIN Emulator

1.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

     ````
     ssh -i ~/.ssh/optionskey opc@<Your Compute Instance Public IP Address>
     ````

2. After successfully logging in, proceed to Step 5.

     ```
     ssh -i labkey opc@xxx.xxx.xxx.xxx
     The authenticity of host 'xxx.xxx.xxx.xxx (xxx.xxx.xxx.xxx)' can't be established.
     ECDSA key fingerprint is SHA256:Wq+YNHzgc1JUySBJuTRO0T4NKpeRz5Udw82Mn5RCe6c.
     Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
     Warning: Permanently added 'xxx.xxx.xxx.xxx' (ECDSA) to the list of known hosts.
     -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or  directory
     [opc@primary ~]$ 
     ```

    

### Windows using Putty

1.  Open up putty and create a new connection.

2.  Enter a name for the session and click **Save**.

     ![](./images/putty-setup.png " ")

3.  Click **Connection** > **Data** in the left navigation pane and set the Auto-login username to root.

4.  Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking Browse under Private key file for authentication.

5.  Navigate to the location where you saved your SSH private key file, select the file, and click Open.  NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

     ![](./images/putty-auth.png " ")

6.  The file path for the SSH private key file now displays in the Private key file for authentication field.

7.  Click Session in the left navigation pane, then click Save in the Load, save or delete a stored session Step.

8.  Click Open to begin your session with the instance.

## **STEP 5:** Verify the Database is Up

1.  From your connected session of choice **tail** the `buildsingle.log`, This file has the configures log of the database.

     ````
     <copy>
     tail -f /u01/ocidb/buildsingle.log
     </copy>
     ````
     ![](./images/tailOfBuildDBInstanceLog.png " ")

2.  When you see the following message, the database setup is complete - **Completed successfully in XXXX seconds** (this may take up to 30 minutes).

     ![](./images/tailOfBuildDBInstanceLog_finished.png " ")

3.  Run the following command to verify the database with the SID **ORCL** is up and running.

     ````
     <copy>
     ps -ef | grep ORCL
     </copy>
     ````
 
     ![](./images/pseforcl.png " ")

4. Verify the listener is running:

     ````
     <copy>
     ps -ef | grep tns
     </copy>
     ````

     ![](./images/pseftns.png " ")

5.  Connect to the Database using SQL*Plus as the **oracle** user.

     ````
     <copy>
     sudo su - oracle
     sqlplus system/Ora_DB4U@localhost:1521/orclpdb
     </copy>
     ````
    

     ![](./images/sqlplus_login_orclpdb.png " ")
    
6.  To leave `sqlplus` you need to use the exit command. Copy and paste the text below into your terminal to exit sqlplus.

     ````
     <copy>
     exit
     </copy>
     ````

7.  Copy and paste the below command to exit from oracle user and become an **opc** user.

     ````
     <copy>
     exit
     </copy>
     ````

You now have a fully functional Oracle Database 19c instance **ORCL** running on Oracle Cloud Compute, the default pdb name is **orclpdb**. This instance is your primary DB.


You may proceed to the next lab.

## Acknowledgements
* **Author** - Minqiao Wang, DB Product Management
* **Last Updated By/Date** - Minqiao Wang, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.