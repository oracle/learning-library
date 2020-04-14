# Setup - SSWorkshop #

## Introduction
This lab will show you how to setup your environment using Oracle Resource Manager.  

### Objectives

-   Setup a compute instance using the DB19c Marketplace image
-   Install the SSB schema needed for future In-Memory labs
-   Use Terraform and Resource Manager to complete the setup

### Required Artifacts

The following lab requires an Oracle Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, a FreeTier account, or a training account whose details were given to you by an Oracle instructor.

### Lab Prerequisites

This lab assumes you have already completed the Login to Oracle Cloud lab.  

## Step 1: Login and Create Stack using Resource Manager

To learn more about OCI Resource Manager, take a look at the video below.

[](youtube:udJdVCz5HYs)

You will be using Terraform zipped into a Resource Manager zipfile to create your database environment.

1.  Click on the link below to download the Resource Manager zip file you need to build your enviornment.  
    - [db19c-terraform.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/poImQ8CxHXLJ_ejOQ0GbO9kZyL6gwR1BV6WRS1Snz8M/n/c4u03/b/labfiles/o/db19c-terraform.zip) - Packaged terraform instance creation script

2.  Save in your downloads folder.

3.  Open up the hamburger menu in the left hand corner.  Choose **Resource Manager > Stacks**.   Choose the compartment from your email, click the  **Create Stack** button.  *Note:  If you are in a workshop, double check your region to ensure you are on the assigned region*

    ![](./images/cloud-homepage.png " ") 

    ![](./images/resource.png " ")

    ![](./images/choosecompartment.png " ")

    ![](./images/createstackpage.png " ")

6.  Click the **Browse** button and select the zip file (db19c-terraform.zip) that you downloaded. Click **Select**.

    ![](./images/createstack2.png " ")


    Enter the following information and accept all the defaults

    - **Name**:  Enter your firstname and lastname and the day you were born (DO NOT ENTER ANY SPECIAL CHARACTERS HERE, including periods, underscores, exclamation etc, it will mess up the configuration and you will get an error during the apply process)
    
    - **Description**:  Same as above
    
    - **Compartment**:  Select Compartment from Email 2

7.  Click **Next**.

    ![](./images/createstack3.png " ")

    Enter the following information. Some information may already be pre-populated.  Do not change the pre-populated info.  You will be updating Public Subnet, Display Name, AD (Availbility Domain) and SSH Key.

    **Public Subnet ID**:  Enter the subnet ID based on your region.   The subnets are provided in Email 2

    **Display Name:** Enter your firstname and lastname and the day you were born (do not enter any special characters here, including periods, it may mess up the configuration)
    
    **AD**: Enter 1, 2, or 3 based on your last name.  (A-J -> 1, K - M -> 2, N-Z -> 3)
    
    **SSH Public Key**:  Paste the public key you created in the earlier step *(Note: If you used the Oracle Cloud Shell to create your key, make sure you paste the pub file in a notepad, remove any hard returns.  The file should be one line or you will not be able to login to your compute instance)*

8. Click **Next**.

    ![](./images/createstack4.png " ")

9.  Your stack has now been created!  Now to create your environment.  *Note: If you get an error about an invalid DNS label, go back to your Display Name, please do not enter ANY special characters or spaces.  It will fail.*

    ![](./images/stackcreated.png " ")



## Step 2: Terraform Plan (OPTIONAL)
When using Resource Manager to deploy an environment, execute a terraform **plan** to verify the configuration.  This is an optional step in this lab.  

1.  [OPTIONAL]Click **Terraform Actions** -> **Plan** to validate your configuration.  This takes about a minute, please be patient.

    ![](./images/terraformactions.png " ")

    ![](./images/planjob.png " ")

    ![](./images/planjob1.png " ")


## Step 3: Terraform Apply
When using Resource Manager to deploy an environment, execute a terraform **plan** and **apply**.  Let's do that now.

1.  At the top of your page, click on **Stack Details**.  Click the button, **Terraform Actions** -> **Apply**.  This will create your instance and install Oracle 19c.
    ![](./images/applyjob1.png " ")

    ![](./images/applyjob2.png " ")

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
3.  On the instance homepage, find the Public IP addresss for your instance.
4.  Enter the command below to login to your instance.    
    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
5.  When prompted, answer **yes** to continue connecting.
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



## Step 5: Download the Setup Scripts

1.  Copy the following commands into your terminal.  These commands download the files needed to run the lab.

    Note: If you are running in windows using putty, ensure your Session Timeout is set to greater than 0

    ````
    <copy>
    cd /home/opc/
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/CQFai9l6Lt2m9g6X3mYnfTJTWrv2Qh62-kPcw2GyRZw/n/c4u03/b/labfiles/o/multiscripts.zip
    unzip multiscripts.zip; chmod +x *.sh
    /home/opc/setupenv.sh
    </copy>
    ````
    ![](./images/step5.png " ")   

## Step 6: Run the DB19c Setup Scripts

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

## Step 7: Run the In-Memory Setup Scripts
1.  Run this command to setup the schema for In-Memory.   This script takes about 15 minutes to complete.   It downloads the ssb.dmp file and then imports it.
    ````
    <copy>
    cd /home/opc/
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/axp5T8m0cF0_p1N832Qo6ImwczP_V6bSQi9ABLti6Ug/n/c4u03/b/labfiles/o/inmemoryscript.sh
    chmod +x /home/opc/inmemoryscript.sh
    nohup /home/opc/inmemoryscript.sh &> setupinmem.out&
    </copy>
    ````
    ![](./images/ssbexists.png " ") 

2.  To check the status of the script above run the command below.   You can also use the unix **jobs** command to see if the script is still running.  *Note:  Ignore the error that the SSB User exists, that is expeted.  The script should finish with 1 error*

    ````
    <copy>
    tail -f /home/opc/setupinmem.out
    </copy>
    ````
    ![](./images/inmemcomplete.png " ") 

You may now proceed to the next lab.  

## Acknowledgements

- **Author** - Kay Malcolm, Director, DB Product Management
- **Last Updated By/Date** - Kay Malcolm, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
