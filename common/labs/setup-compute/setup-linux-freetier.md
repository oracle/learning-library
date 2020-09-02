# Setup Oracle Linux Compute Image

## Introduction
This lab will show you how to setup a Oracle Cloud network (VCN) and a compute instance running Oracle Linux using Oracle Resource Manager.  

Estimated Lab Time:  15 minutes

### About Terraform and Oracle Cloud Resource Manager
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.  Oracle offers sample solutions to help you quickly create common Oracle cloud components.

Resource Manager is an Oracle Cloud Infrastructure service that allows you to automate the process of provisioning your Oracle Cloud Infrastructure resources. Using Terraform, Resource Manager helps you install, configure, and manage resources through the "infrastructure-as-code" model. To learn more about OCI Resource Manager, preview the video below.

[](youtube:udJdVCz5HYs)

### Objectives
In this lab, you will:
* Setup a VCN (Virtual Compute Network) using Resource Manager
* Setup a compute instance using Resource Manager
* Login to your compute instance

### Prerequisites

This lab assumes you hav!e:
- An Oracle Free Tier or Paid Cloud account
- Lab:  Generate SSH Keys

## **STEP 1**: Setup VCN Stack
If you already have a VCN created, skip this step and proceed to *STEP 3*.

1.  Login to your Oracle Cloud account
2.  Click the **Create a Stack** tile on the homepage.  You may also get to Resource Manager by clicking on the Hamburger **Menu** -> **Solutions and Platform** -> **Resource Manager**
![Create a stack](images/db19c-freetier-step1.png " ")
3.  In the Browse Solutions window, select **Default VCN**.
    ![Image alt text](images/db19c-freetier-step1-2.png " ")

4. Click the **Select Solution** button.
   ![Image alt text](images/db19c-freetier-step1-3.png " ")
5.  Enter the name for your VCN:  **livelabsvcn**.  Click **next**.
   ![Image alt text](images/db19c-freetier-step1-4.png " ")
6. Inspect and then accept all default values in the Configure Variables screen and click **Next**. 
   ![Image alt text](images/db19c-freetier-step1-5.png " ")
7.  Review your selections and click **Next**
   ![Image alt text](images/db19c-freetier-step1-6.png " ")

## **STEP 2**: Run VCN Stack Apply Job
Now that your stack has been created, you will run an *apply* job to create the actual VCN
1. Click on **Terraform Actions** to expose the drop down menu
![Image alt text](images/db19c-freetier-step1-7.png " ")
2. Select **Apply**
![Image alt text](images/db19c-freetier-step1-8.png " ")
3. Insepct the apply job, accept all defaults and click **Apply**
![Image alt text](images/db19c-freetier-step1-9.png " ")
4. The VCN will immediately begin creation.
![Image alt text](images/db19c-freetier-step1-10.png " ")
5. Once the apply job is complete, inspect the results.  
![Image alt text](images/db19c-freetier-step1-11.png " ")
6. Scroll down the log.  You will notice that 6 objects were created:  A VCN, subnet, internet gateway, default security list, route table and dhcp options, each with their own Oracle Cloud ID (ocid).  We will focus on the subnet.  You will need this subnet information to create your compute instance
![Image alt text](images/db19c-freetier-step1-12.png " ")
7. Copy the first subnet id to a notepad and save for the next step.  If you would like to further inspect the VCN, complete #s 8-12.  Otherwise skip to the next section.
![Image alt text](images/db19c-freetier-step1-13.png " ")
8.  Click on the hamburger menu in the upper left corner of your browser.  Select **Networking**->**Virtual Cloud Networks**. ![Image alt text](images/db19c-freetier-step1-14.png " ")
9.  The VCN you created should be listed.  Click on the VCN you just created.
![Image alt text](images/db19c-freetier-step1-15.png " ")  
10.  On the VCN homepage notice the 3 subnets that were created.  Each subnet is tied to an Availability Domain.  Click on the first subnet that matches AD-1.
![Image alt text](images/db19c-freetier-step1-16.png " ")  
11.  Inspect the subnet homepage, find the OCID (Oracle Cloud ID).  Click **Copy**
![Image alt text](images/db19c-freetier-step1-17.png " ")  
12. Copy the subnet ID to a notepad.
![Image alt text](images/db19c-freetier-step1-18.png " ")        
   
## **STEP 3**: Setup Compute Stack
1.  Click the **Create a Stack** tile on the homepage.  You may also get to Resource Manager by clicking on the Hamburger **Menu** -> **Solutions and Platform** -> **Resource Manager**
![Create a stack](images/db19c-freetier-step1.png " ")
3.  In the Browse Solutions window, select **Compute**. Click the **Select Solution** button.
    ![Image alt text](images/linux-compute-step3-1.png " ")

4.  Enter the name for your Compute Stack:  **livelabslinux**.  Click **next**.
   ![Image alt text](images/linux-compute-step3-2.png " ")
5. Fill in the following values for your new compute instance. 
   - Compute Instance Display Name: Choose a name for your instance
   - Choose the VCN you created in the previous step
   - Choose a subnet from the drop down
  
   ![Image alt text](images/linux-compute-step3-3.png " ")
6.  Scroll down. 
   - Check the Assign Public IP *(Note: This is VERY IMPORTANT, you will not be able to login to your instance without this)
   - Paste the public key you created in the earlier lab
   ![Image alt text](images/linux-compute-step3-4.png " ")

7.   Review your selections and click **Next**
   ![Image alt text](images/linux-compute-step3-5.png " ")

## **STEP 4**: Run Compute Stack Apply Job
Now that your stack has been created, you will run an *apply* job to create the actual compute instance
1. Click on **Terraform Actions** to expose the drop down menu
![Image alt text](images/db19c-freetier-step1-7.png " ")
2. Select **Apply**
![Image alt text](images/db19c-freetier-step1-8.png " ")
3. Insepct the apply job, accept all defaults and click **Apply**
![Image alt text](images/db19c-freetier-step1-9.png " ")
4. The VCN will immediately begin creation.
![Image alt text](images/db19c-freetier-step1-10.png " ")
5. Once the apply job is complete, inspect the results.  
![Image alt text](images/linux-compute-step3-9.png " ")
1. You will notice that 3 objects were created.  Your instance has a private IP address and a public IP address.  Copy the public IP address, you will need it to connect to your instance.
![Image alt text](images/db19c-freetier-step1-12.png " ")
1.  Click on the hamburger menu in the upper left corner of your browser.  Select **Compute**->**Instance**. ![Image alt text](images/linux-compute-step-3-10.png " ")
2.  The compute instance you created should be listed. Note the public IP address.
![Image alt text](images/linux-compute-step-3-11.png " ")     

## **STEP 5**: Connect to your instance

There are multiple ways to connect to your cloud instance.  Choose the way to connect to your cloud instance that matches the SSH Key you generated.  *(i.e If you created your SSH Keys in cloud shell, choose cloud shell)*

- Oracle Cloud Shell
- MAC or Windows CYCGWIN Emulator
- Windows Using Putty
  
### Oracle Cloud Shell

1. To re-start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon to the right of the region.  *Note: Make sure you are in the region you were assigned*

    ![](./images/cloudshell.png " ")

2.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
3.  On the instance homepage, find the Public IP addresss for your instance.

    ![](./images/linux-compute-step3-11.png " ")
4.  Enter the command below to login to your instance.    
    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````

    *Note: The angle brackets <> should not appear in your code.*
    ![](./images/linux-compute-step3-12.png " ")
5.  When prompted, answer **yes** to continue connecting.
6.  Continue to STEP 5 on the left hand menu.

### MAC or Windows CYGWIN Emulator
1.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
2.  On the instance homepage, find the Public IP addresss for your instance.

3.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/cloudshellssh.png " ")

    ![](./images/cloudshelllogin.png " ")

    *Note: The angle brackets <> should not appear in your code.*

4.  After successfully logging in, proceed to STEP 5.

### Windows using Putty

1.  Open up putty and create a new connection.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/ssh-first-time.png " ")

    *Note: The angle brackets <> should not appear in your code.*

2.  Enter a name for the session and click **Save**.

    ![](./images/putty-setup.png " ")

3. Click **Connection** > **Data** in the left navigation pane and set the Auto-login username to root.

4. Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking Browse under Private key file for authentication.

5. Navigate to the location where you saved your SSH private key file, select the file, and click Open.  NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

    ![](./images/putty-auth.png " ")

6. The file path for the SSH private key file now displays in the Private key file for authentication field.

7. Click Session in the left navigation pane, then click Save in the Load, save or delete a stored session STEP.

8. Click Open to begin your session with the instance.

Congratulations!  You now have a fully functional Linux instance running on Oracle Cloud Compute.  

You may now *proceed to the next lab*. 

## Acknowledgements
- **Author** - Kay Malcolm, Director, DB Product Management
- **Contributors** - Jaden McElvey, Anoosha Pilli, Sanjay Narvekar, David Start, Arabella Yao
- **Last Updated By/Date** - Kay Malcolm, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *STEP* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request.
