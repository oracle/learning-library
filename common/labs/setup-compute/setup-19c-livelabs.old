# Setup - LiveLabs

## Introduction
This lab will show you how to setup a Oracle Cloud network (VCN) and a compute instance running a pre-configured Oracle Database 19c install using Oracle Resource Manager and Terraform.  

### About Terraform and Oracle Cloud Resource Manager
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.  Configuration files describe to Terraform the components needed to run a single application or your entire datacenter.  In this lab a configuration file has been created for you to build network and compute components.  The compute component you will build creates an image out of Oracle's Cloud Marketplace.  This image is running Oracle Database 19c.

Resource Manager is an Oracle Cloud Infrastructure service that allows you to automate the process of provisioning your Oracle Cloud Infrastructure resources. Using Terraform, Resource Manager helps you install, configure, and manage resources through the "infrastructure-as-code" model. To learn more about OCI Resource Manager, take a watch the video below.

[](youtube:udJdVCz5HYs)

### Oracle Cloud Marketplace

The Oracle Cloud Marketplace is a catalog of solutions that extends Oracle Cloud services.  It offers multiple consumption modes and deployment modes.  In this lab we will be deploying the free Oracle Database 19c marketplace image.

Link to Marketplace - https://www.oracle.com/cloud/marketplace/

### Objectives

-   Setup a network and compute instance using the DB19c Marketplace image
-   Use Terraform and Resource Manager to complete the setup

### Lab Prerequisites

This lab assumes you have already completed the following labs:
- Register for Free Tier
- Create SSH Keys

### Estimated Time

This lab takes approximately 10 minutes to complete.


## Step 1: Login and Create Stack using Resource Manager

1.  Click on the link below to download the Resource Manager zip file you need to build your enviornment.  
    - [db19c-compute-19.7.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/k52Q1PBzZUsUlTUEKwdfN63LY9naMuiOA9QaK5naUHE/n/c4u03/b/labfiles/o/db19c-compute-v19-7.zip) - Packaged terraform instance creation script

2.  Save in your downloads folder.

3.  Open up the hamburger menu in the left hand corner.  Choose **Resource Manager > Stacks**.   Choose the compartment from your email, click the  **Create Stack** button.  *Note:  If you are in a workshop, double check your region to ensure you are on the assigned region*

    ![](./images/cloud-homepage.png " ") 

    ![](./images/resource.png " ")

    ![](./images/choosecompartment.png " ")

    ![](./images/step1.3-createstackpage.png " ")

4.  Click the **Browse** link and select the zip file (db19c-compute.zip) that you downloaded. Click **Select**.

    ![](./images/step1.4-create-stack-orig.png " ")

    Enter the following information and accept all the defaults

    - **Name**:  Enter your firstname and lastname and the day you were born (DO NOT ENTER ANY SPECIAL CHARACTERS HERE, including periods, underscores, exclamation etc, it will mess up the configuration and you will get an error during the apply process)
    
    - **Description**:  Same as above
    
    - **Compartment**:  Select Compartment from Email 2

5.  Click **Next**.

    ![](./images/step1.5-createstack3.png " ")

    Enter the following information. You will be updating Public Subnet, Display Name and SSH Key.

    **Display Name:** Enter your firstname and lastname and the day you were born (do not enter any special characters here, including periods, it may mess up the configuration)
    
    **SSH Public Key**:  Paste the public key you created in the earlier step *(Note: If you used the Oracle Cloud Shell to create your key, make sure you paste the pub file in a notepad, remove any hard returns.  The file should be one line or you will not be able to login to your compute instance)*

    **Public Subnet ID**:  Enter the subnet ID based on your region.   The subnets are provided in Email 2

6. Click **Next**.

    ![](./images/step1.6-create-db19c-stack-3.png " ")

7.  Your stack has now been created!  Now to create your environment.  *Note: If you get an error about an invalid DNS label, go back to your Display Name, please do not enter ANY special characters or spaces.  It will fail.*

    ![](./images/step1.7-stackcreated.png " ")



## Step 2: Terraform Plan (OPTIONAL)
When using Resource Manager to deploy an environment, execute a terraform **plan** to verify the configuration.  This is an optional step in this lab.  

1.  [OPTIONAL]Click **Terraform Actions** -> **Plan** to validate your configuration.  Click **Plan**. This takes about a minute, please be patient.

    ![](./images/terraformactions.png " ")

    ![](./images/step2.1-terraformclickplan.png " ")

    ![](./images/planjob.png " ")

    ![](./images/planjob1.png " ")


## Step 3: Terraform Apply
When using Resource Manager to deploy an environment, execute a terraform **plan** and **apply**.  Let's do that now.

1.  At the top of your page, click on **Stack Details**.  Click the button, **Terraform Actions** -> **Apply**. Click **Apply**. This will create your instance and install Oracle 19c. This takes about a minute, please be patient.

    ![](./images/applyjob1.png " ")

    ![](./images/step3.1-terraformclickapply.png " ")

    ![](./images/applyjob2.png " ")

    ![](./images/step3.1-applyjob3.png " ")

2.  Once this job succeeds, you will get an apply complete notification from Terraform.  Examine it closely, 1 resource has been added.  Congratulations, your environment is created!  Time to login to your instance to finish the configuration.

    ![](./images/applycomplete.png " ")



## Step 4: Connect to your instance

Choose the environment where you created your ssh-key in the previous lab (Generate SSH Keys)

*NOTE 1:  If you are using your laptop to connect, you cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).  This does not apply to the Oracle Cloud Shell.*

*NOTE 2: The ssh-daemon is disable for the first 5 minutes or so while the instance is processing.  If you are unable to connect and sure you have a valid key, wait a few minutes and try again.*

### Oracle Cloud Shell

1. To re-start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon to the right of the region.  *Note: Make sure you are in the region you were assigned*

    ![](./images/cloudshell.png " ") 

2.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)

    ![](./images/step4.1.2-computeinstance.png " ")

3.  On the instance homepage, find the Public IP addresss for your instance.

    ![](./images/step4.1.3-instancehomepage.png " ")

4.  Enter the command below to login to your instance.    
    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
5.  When prompted, answer **yes** to continue connecting.

    ![](./images/step4.1.5-instancelogin.png " ")

6.  Continue to Step 5 on the left hand menu.

### MAC or Windows CYGWIN Emulator
1.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
2.  On the instance homepage, find the Public IP addresss for your instance.

3.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/optionskey opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/cloudshellssh.png " ") 

    ![](./images/cloudshelllogin.png " ") 

4.  After successfully logging in, proceed to Step 5.

### Windows using Putty

1.  Open up putty and create a new connection.

    ````
    ssh -i ~/.ssh/optionskey opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/ssh-first-time.png " ") 

2.  Enter a name for the session and click **Save**.

    ![](./images/putty-setup.png " ") 

3. Click **Connection** > **Data** in the left navigation pane and set the Auto-login username to root.

4. Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking Browse under Private key file for authentication.

5. Navigate to the location where you saved your SSH private key file, select the file, and click Open.  NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

    ![](./images/putty-auth.png " ") 

6. The file path for the SSH private key file now displays in the Private key file for authentication field.

7. Click Session in the left navigation pane, then click Save in the Load, save or delete a stored session Step.

8. Click Open to begin your session with the instance.

## Step 5: Run the DB19c Setup Scripts

1.  Copy the following commands into your terminal to configure DB19c on your image.  This script takes approximately 30 minutes to run.  It runs in the background so you should be able to exit out while it's running.  

    Note: If you are running in windows using putty, ensure your Session Timeout is set to greater than 0

    ````
    <copy>
    nohup /home/opc/setupdb.sh &> setupdb.out&
    </copy>
    ````

    ![](./images/runscript-1.png " ")     
2.  To check the status of the script above run the command below.  *This script takes about 30 minutes to complete and runs in the background*.  You can also use the unix **jobs** command to see if the script is still running if you are still in the same terminal session.  Do not proceed until you see 100% complete.

    ````
    <copy>
    tail -f /home/opc/setupdb.out
    </copy>
    ````

    ![](./images/tailscript.png " ") 

    ![](./images/script.png " ") 

3.  Once the script is complete, you should expect to see this message.  Note the script here took 24 minutes to complete.

    ![](./images/scriptcomplete.png " ") 

You may now proceed to the next lab.  

## Acknowledgements

- **Author** - Kay Malcolm, Director, DB Product Management
- **Contributors** - Quintin Hill, Brian McGraw, Oracle North America Technology
- **Last Updated By/Date** - Kay Malcolm, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.    Please include the workshop name and lab in your request. 
