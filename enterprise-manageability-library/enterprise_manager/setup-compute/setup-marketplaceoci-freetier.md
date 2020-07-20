# Setup - FreeTier or Existing Cloud Account

## Introduction
This lab will show you how to setup an Oracle Cloud Network (VCN) and a compute instance running Oracle Linux 7 and preloaded with Enterprise Manager 13c and monitored database targets, using Oracle Resource Manager and Terraform.  

### About Terraform and Oracle Cloud Resource Manager
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.  Configuration files describe to Terraform the components needed to run a single application or your entire datacenter.  In this lab a configuration file has been created for you to build network and compute components.  The compute component you will build creates an image out of Oracle's Cloud Marketplace.  This image is running Oracle Linux 7.

Resource Manager is an Oracle Cloud Infrastructure service that allows you to automate the process of provisioning your Oracle Cloud Infrastructure resources. Using Terraform, Resource Manager helps you install, configure, and manage resources through the "infrastructure-as-code" model. To learn more about OCI Resource Manager, take a watch the video below.

[](youtube:udJdVCz5HYs)

### Oracle Cloud Marketplace
The Oracle Cloud Marketplace is a catalog of solutions that extends Oracle Cloud services.  It offers multiple consumption modes and deployment modes.  In this lab we will be deploying the free Oracle Enterprise Manager 13c Workshop marketplace image.

[Link to OCI Marketplace](https://www.oracle.com/cloud/marketplace/)

### Objectives
-   Setup a network and compute instance using the  Marketplace image specified in the Introduction
-   Use Terraform and Resource Manager to complete the setup

### Lab Prerequisites
This lab assumes you have already completed the following labs:
* [Lab 1: Login to Oracle Cloud](https://rfontcha.github.io/learning-library/enterprise-manageability-library/enterprise_manager/freetier/?lab=lab-1-login-oracle-cloud)
* [Lab 2: Generate SSH Key](https://rfontcha.github.io/learning-library/enterprise-manageability-library/enterprise_manager/freetier/?lab=lab-2-generate-ssh-key)

## Step 1: Login and Create Stack using Resource Manager

1.  Click on the link below to download the Resource Manager zip file you need to build your environment.  
    - [emcc-mkplc-v3-flex-shape.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/xAlfRIvOLUs4-8CghEQ982ySwiEMYOKtbFWD6ptNdsA/n/omcinternal/b/workshop-labs-files/o/emcc-mkplc-v3-flex-shape.zip) - Packaged terraform instance creation script for creating network and instance running the Oracle Marketplace Image

2.  Save in your downloads folder.

3.  Open up the hamburger menu in the left hand corner.  Choose the compartment in which you would like to install. In this example we choose *EmWorkshop*.  Choose **Resource Manager > Stacks**.  

![](./images/em-oci-landing.png " ")

![](./images/em-nav-to-orm.png " ")

![](./images/em-create-stack.png " ")

4.  Select **My Configuration**, Click the **Browse** link and select the zip file (emcc-mkplc-v3-flex-shape.zip) that you downloaded. Click **Select**.

![](./images/em-create-stack-1.png " ")

Enter the following information:

- **Name**:  Enter a name  or keep the prefilled default (*DO NOT ENTER ANY SPECIAL CHARACTERS HERE*, including periods, underscores, exclamation etc, it will mess up the configuration and you will get an error during the apply process)

- **Description**:  Same as above

- **Create in compartment**:  Select the correct compartment if not already selected


5.  Click **Next**.

![](./images/em-create-stack-2.png " ")

Enter the following information:

**(1) Instance Count:** Keep the default to **1** to create only one instance.

**(2) Instance OCPUS:** Keep the default to **3** to provision ***VM.Standard.E3.Flex*** shape with 3 OCPU's.

**(3) Select Availability Domain:** Select an availability domain from the dropdown list.

**(4) SSH Public Key**:  Paste the public key you created in the earlier lab *(Note: If you used the Oracle Cloud Shell to create your key, make sure you paste the pub file in a notepad, remove any hard returns.  The file should be one line or you will not be able to login to your compute instance)*

6. Review and click **Create**.

*Note: If you get an error about an invalid DNS label, go back to your Display Name, please do not enter ANY special characters or spaces.  It will fail.*

![](./images/em-create-stack-3.png " ")

7. Your stack has now been created!  

![](./images/em-stack-details.png " ")

## Step 2: Terraform Plan (OPTIONAL)
When using Resource Manager to deploy an environment, execute a terraform **plan** to verify the configuration. You may skip to Step 3.

1.  **[OPTIONAL]** Click **Terraform Actions** -> **Plan** to validate your configuration.  This takes about a minute, please be patient.

![](./images/em-stack-plan-1.png " ")

![](./images/em-stack-plan-2.png " ")

![](./images/em-stack-plan-results-1.png " ")

![](./images/em-stack-plan-results-2.png " ")

![](./images/em-stack-plan-results-3.png " ")

## Step 3: Terraform Apply
When using Resource Manager to deploy an environment, execute a terraform **plan** and **apply**.  Let's do that now.

1.  At the top of your page, click on **Stack Details**.  Click the button, **Terraform Actions** -> **Apply**.  This will create your network, instance and install Oracle 19c.

![](./images/em-stack-details-post-plan.png " ")

![](./images/em-stack-apply-1.png " ")

![](./images/em-stack-apply-2.png " ")

2.  Once this job succeeds, you will get an apply complete notification from Terraform.  Examine it closely, 7 resources have been added.  Congratulations, your environment is created!  Time to login to your instance to finish the configuration.

![](./images/em-stack-plan-results-1.png " ")

![](./images/em-stack-plan-results-2.png " ")

![](./images/em-stack-plan-results-3.png " ")

## Step 4: Connect to your instance

Choose the environment where you created your ssh-key in the previous lab (Generate SSH Keys)

*NOTE 1:  If you are using your laptop to connect your corporate VPN may prevent you from logging in.*

*NOTE 2: The ssh-daemon is disabled for the up to 5 minutes or so while the instance is processing.  If you are unable to connect and sure you have a valid key, wait a few minutes and try again.*

*NOTE 3: It takes about 30 minutes for all Enterprise Manager processes and monitored databases to fully start upon instance creation before you can access the EM console*

### Oracle Cloud Shell

1. To re-start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon to the right of the region.  *Note: Make sure you are in the region you were assigned*

![](./images/em-cloudshell.png " ")

2.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
3.  On the instance homepage, find the Public IP address for your instance.
4.  Enter the command below to login to your instance.    
````
ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
````

![](./images/em-cloudshell-ssh.png " ")

If you used the default RSA key name of **id_rsa** then use the following to connect as there's no need to explicitly specify the key.

````
ssh  opc@<Your Compute Instance Public IP Address>
````

5.  When prompted, answer **yes** to continue connecting.
6.  Continue to Step 5 on the left hand menu.

### MAC or Windows CYGWIN Emulator
1.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
2.  On the instance homepage, find the Public IP address for your instance.

3.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

````
ssh -i ~/.ssh/optionskey opc@<Your Compute Instance Public IP Address>
````
![](./images/em-mac-linux-ssh-login.png " ")

4.  After successfully logging in, proceed to Step 5.

### Windows using Putty

On Windows, you can use PuTTY as an SSH client. PuTTY enables Windows users to connect to remote systems over the internet using SSH and Telnet. SSH is supported in PuTTY, provides for a secure shell, and encrypts information before it's transferred.

1.  Download and install PuTTY. [http://www.putty.org](http://www.putty.org)

2.  Run the PuTTY program. On your computer, go to **All Programs > PuTTY > PuTTY**

3.  Select or enter the following information:

Category: _Session_

IP address: _Your service instance’s public IP address_

Port: _22_

Connection type: _SSH_

![](images/7c9e4d803ae849daa227b6684705964c.jpg " ")

#### **Configuring Automatic Login**

1.  In the category section, **Click** Connection and then **Select** Data.

2.  Enter your auto-login username. Enter **opc**.

![](images/36164be0029033be6d65f883bbf31713.jpg " ")

#### **Adding Your Private Key**

1.  In the category section, **Click** Auth.

2.  **Click** browse and find the private key file that matches your VM’s public
    key. This private key should have a .ppk extension for PuTTy to work.

![](images/df56bc989ad85f9bfad17ddb6ed6038e.jpg " ")

To save all your settings:

1.  In the category section, **Click** session.

2.  In the saved sessions section, name your session, for example ( EM13C-ABC )
    and **Click** Save.

You may now proceed to the next lab.  

## Acknowledgements

- **Authors/Contributors** - Kay Malcolm, Rene Fontcha
- **Last Updated By/Date** - Rene Fontcha, July 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.    Please include the workshop name and lab in your request.
