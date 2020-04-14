<!-- Updated March 24, 2020 -->

# Lab Setup

## Introduction
This lab will show you how to login to the cloud and setup your environment using Oracle Resource Manager.  Once the environment setup is complete, you will proceed to the Docker lab.

`PLEASE READ: If you already have a compute instance (running linux or DB 19c) configured, proceed to the next lab.`

## Objectives
- Create a compute instance in Oracle Cloud running Oracle Linux
  
## Required Artifacts
- The following lab requires an Oracle Cloud account provisioned by the SSWorkshop Platform.  You should have received two emails.  These emails contain the following information below.

### Lab Settings
- **Tenancy**:  c4u03
- **Username/Password**:  Sent via email
- **Compartment**: \<Provided by Oracle\>
- **VCN**: \<Provided by Oracle\>
- **Region**: \<Provided by Oracle\>
- **Subnet ID**: \<Provided by Oracle\>
- **Linux Image ID**: \<Provided by Oracle\>


## Step 1: Login to the Oracle Cloud

1.  You should have received two emails.  `Email 1:`  From noreply with the subject `Verify Email Request` (check your spam and junk folders).  This has the link that verifies your email.  Without clicking on this link you cannot login to the tenancy.  Open up this email.  Click on the **Sign In to Oracle Cloud** link.  

    ![](images/signin.png " ")


2.  You should have received a 2nd email with your temporary password.  Enter your username and your password (Email 2) in the box on the right hand side that says **Oracle Infrastructure** (Do not use SSO, SSO is not enabled for this tenancy).  

    ![](images/loginpage.png " ")
   
3. You will then be taken to a screen to change your password.  Choose a new password that you can remember and click **Sign In** (make sure you are using an approved browser.  IE is not supported)

    ![](images/changepwd.png " ")


4. Once you successfully login, you will be presented with the Oracle Cloud homepage. (NOTE: If you get an `Email Activation Unsuccessful` message, check to see if you can still access the cloud by looking for the hamburger menu to the left). 
  ![](images/cloud-homepage.png " ") 


5.  In Email 2, you were also assigned a region.  Click in the upper right hand corner and set your Region appropriately.   (NOTE:  Setting the region is important, your network is region specific.  If you choose a different region that does not match your subnet, you will get an error on environment creation) 

    ![](images/changeregion.png " ") 



## Step 2-Generate an SSH Key Pair

If you already have an ssh key pair, you may use that to connect to your environment.  Based on your laptop config, choose the appropriate step to connect to your instance.

`IMPORTANT:  If the ssh key is not created correct, you will not be able to connect to your environment and will get errors.  Please ensure you create your key properly. ` 

### For MAC Users ### 

1.  Open up a terminal and type the following commands.  When prompted for a passphrase click **enter**. *Do not enter a passphrase*.
     ````
    cd ~
    cd .ssh
    ssh-keygen -b 2048 -t rsa -f optionskey
    ````

    ![](images/sshkeygen.png " ") 
3.  Inspect your .ssh directory.  You should see two files.  optionskey and optionskey.pub.  Copy the contents of the pub file `optionskey.pub` into notepad.  Your key file should be one line. You will need this to access your instance later.  

    ````
    ls -l .ssh
    more optionskey.pub
    ````


### For Windows: Using GitBash or Windows Subsystem for Linux (WSL) ### 

1. Open the terminal tool of your choice
2. Type the following command at the prompt to generate keys for your instance.
    ````
    ssh-keygen -f optionskey
    ````
3. Press enter to accept the default values
4. Do not assign a password for this exercise. (note you should always assign an SSH key password in production)
5. Type the following to retrieve your public key.  You will need this to access your instance in Step 5.  
    ````
    cat ~/.ssh/optionskey.pub 
    ````



### For Windows: Using PuttyGen ### 

1. Open PuttyGen
2. Click the [Generate] button

    ![](images/puttygen-generate.jpg) 
3. Move your mouse around the screen randomly until the progress bar reaches 100%
4. Click the [Save private key] button. Name the file `optionskey`.  This file will not have an extension.

    ![](images/puttygen-saveprivatekey.jpg) 
5. Save the public key (displayed in the text field) by copying it to the clipboard and saving it manually to a new text file. Name the file `optionskey.pub`.   You will need this to access your instance in Step 5.  

6. Note: Sometimes PuttyGen does not save the public key in the correct format. The text string displayed in the window is correct so copy/paste to be sure.



## Step 3: Login and Create Stack using Resource Manager
You will be using Terraform to create your database environment.

1.  Click on the link below to download the zip file you need to build your enviornment.  
- [Linux Compute](https://objectstorage.us-ashburn-1.oraclecloud.com/p/fS44gtlzyF-xooB7BUCJc1YpkCQ-4tXmqAlU3_QQZPU/n/c4u03/b/labfiles/o/linux-compute.zip) - Packaged terraform instance creation script for Linux compute instance in London region.


2.  Save in your downloads folder.

3.  Open up the hamburger menu in the left hand corner.  Choose **Resource Manager > Stacks**.   Choose the compartment from your email, click the  **Create Stack** button

    ![](images/cloud-homepage.png " ") 

    ![](images/resource.png " ")

    ![](images/choosecompartment.png " ")

    ![](images/createstackpage.png " ")

6.  Click the **Browse** button and select the zip file (multitenant-terraform.zip) that you downloaded. Click **Select**.

    ![](images/createstack2.png " ")


    Enter the following information and accept all the defaults
    **Name**:  Enter your firstname and lastname and the day you were born (DO NOT ENTER ANY SPECIAL CHARACTERS HERE, including periods, underscores, exclamation etc, it will mess up the configuration and you will get an error during the apply process)
    **Description**:  Same as above
    **Compartment**:  Select Compartment from Email 2

7.  Click **Next**.

    ![](images/linux-compute-stack-1.png " ")

    **Make sure you have switched to the correct Region.**  Enter the following information. 


    **Choose a Name For Your Instance**
    
    - **Display Name:** Enter your firstname and lastname and the day you were born (do not enter any special characters here, including periods, it may mess up the configuration)

    **Enter Info from your SSWorkshop Email**
    - **Instance Image OCID**: Enter the Image ID you received in your SSWorkshop email

    - **Public Subnet ID**:  Enter the Subnet ID you received in your SSWorkshop email

    - **AD**: Enter 1, 2, or 3 based on your last name.  (A-J -> 1, K - M -> 2, N-Z -> 3)
    
    **Enter Your Public Key**

    - **SSH Public Key**:  Paste the public key you created in the earlier step (it should be one line)

8. Click **Next**.

    ![](images/createstack4.png " ")

9.  Your stack has now been created!  Now to create your environment.  If you get an error about an invalid DNS label, go back to your Display Name, please do not enter ANY special characters or spaces.  It will fail.

    ![](images/stackcreated.png " ")


## Step 4: Terraform Plan and Apply
When using Resource Manager to deploy an environment, execute a terraform **plan** and **apply**.  Let's do that now.

1.  [OPTIONAL]Click **Terraform Actions** -> **Plan** to validate your configuration.  This takes about a minute, please be patient.

    ![](images/terraformactions.png " ")

    ![](images/planjob.png " ")

    ![](images/planjob1.png " ")

2.  At the top of your page, click on **Stack Details**.  Click the button, **Terraform Actions** -> **Apply**.  This will create your instance and install Oracle 19c.
    ![](images/applyjob1.png " ")

    ![](images/applyjob2.png " ")

3.  Once this job succeeds, your environment is created!  Time to login to your instance to finish the configuration.




## Step 5-Connect to your instance

Based on your laptop config, choose the appropriate step to connect to your instance.  

NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).  Also, the ssh-daemon is disable for the first 5 minutes or so while the instance is processing.  If you are unable to connect and sure you have a valid key, wait a few minutes and try again.

### Connecting via MAC or Windows CYGWIN Emulator
1.  Go to Compute -> Instance and select the instance you created (make sure you choose the correct compartment)
2.  On the instance homepage, find the Public IP addresss for your instance.

1.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/optionskey opc@<Your Compute Instance Public IP Address>
    ````
    ![](images/ssh-first-time.png " ") 

3.  Continue to [Step 5b-Run the Setup Scripts](#section-5b-run-the-setup-scripts)

### Connecting via Windows

1.  Open up putty and create a new connection.

    ````
    ssh -i ~/.ssh/optionskey opc@<Your Compute Instance Public IP Address>
    ````
    ![](images/ssh-first-time.png " ") 

2.  Enter a name for the session and click **Save**.

    ![](images/putty-setup.png " ") 

3. Click **Connection** > **Data** in the left navigation pane and set the Auto-login username to root.

4. Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking Browse under Private key file for authentication.

5. Navigate to the location where you saved your SSH private key file, select the file, and click Open.  NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

    ![](images/putty-auth.png " ") 

6. The file path for the SSH private key file now displays in the Private key file for authentication field.

7. Click Session in the left navigation pane, then click Save in the Load, save or delete a stored session section.

8. Click Open to begin your session with the instance.
      
Congratulations!  Now you have the environment to run the Database on Docker lab.   You may proceed to the next lab. 

## Acknowledgements

- **Author** - Kay Malcolm, Director, DB Product Managemnt
- **Last Updated By/Date** - Kay Malcolm

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).

