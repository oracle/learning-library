# Connecting to Autonomous Transaction Processing Dedicated from Oracle Enterprise Manager

## Introduction
The Oracle Cloud Infrastructure marketplace provides a pre-built image with necessary client tools and drivers to deploy compute instances and connect to Autonomous Transaction Processing Dedicated . A database administrator can now connect to ATPD from Oracle Enterprise Manager and monitor the performance. 

The image is pre-configured and installed with Oracle Enterprise manager.
For a complete list of features, login to your OCI account, select 'Marketplace' from the top left menu and browse details on the 'Enterprise Manager 13c Workshop v3.0'.

*In this lab we will configure and access Autonomous dedicated Transaction Processing database from Oracle Enterprise Manager.*

### Objectives

As a Database Administrator,

1. Learn how to connect to Autonomous Dedicated Transaction Processing Database from Oracle Enterprise Manager.
   

### Required Artifacts

   - An Oracle Cloud Infrastructure account.
   - A pre-provisioned dedicated autonomous database instance. Refer to [Lab 7](?lab=lab-7-provisioning-databases).
   - A pre-provisioned compute instace of Image type "Enterprise Manager 13c Workshop v3.0"


## STEP 1: Create a Compute Instance with OEM installed in it

- Login to your Oracle Cloud Infrastructure account and select *Compute* —> *Instances* from top left menu.
    ![](./images/Compute1.png " ")

- Click on "Create Instance"
    ![](./images/Compute3.png " ")

- A popup will open, in that select the compartment in which you create compute and click on "Change Image"
    ![](./images/Compute4.png " ")
	
- Select "Enterprise Manager 13c Workshop v3.0" under "Oracle images"
	![](./images/Compute5.png " ")
	
- Select VCN compaertment and VCN, subnet compartment and subnet and then click on "create" which will create compute with EM installed"
	![](./images/Compute6.png " ")
	
- Copy the public IP address of the instance in a note pad. 
    ![](./images/Compute2.png " ")

**Mac / Linux users**

- Open Terminal and SSH into linux host machine.

    ```
    <copy>
    sudo ssh -i /path_to/sshkeys/id_rsa opc@publicIP
    </copy>
    ```

    ![](./images/SSH1.png " ")

**Windows users**

- You can connect to and manage linux host mahine using SSH client. Recent versions of Windows 10 provide OpenSSH client commands to create and manage SSH keys and make SSH connections from a command prompt.

- Other common Windows SSH clients you can install locally is PuTTY. Click [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows) to follow the steps to connect to linux host machine from you windows using PuTTY.

## STEP 2: Connect to Oracle Enterprise Manager from web browser

- In your browser type the URL as "https://publicipaddress_of_oem_compute:7803/em"

## STEP 3: Transfer database wallet to developer client

- Login to Oracle Cloud Infrastructure account and select *Autonomous Transaction Processing* from menu.
    ![](./images/atpd1.png " ")

- Click on Autonomous Database and select your previously created database.
    ![](./images/atpd2.png " ")

- Click on DB Connection and under Download Client Credential(Wallet) click *Download*.
    ![](./images/atpd3.png " ")

- Provide a password and download the wallet to a local folder. 
    ![](./images/atpd4.png " ")

    The credentials zip file contains the encryption wallet, Java keystore and other relevant files to make a secure TLS 1.2 connection to your database from client applications. Store this file in a secure location.
	
## STEP 4: Add Autonomous Transaction Processing Database dedicated as Target in OEM

- Click "Setup" and select "Add Target" and click on "Add Targets Manually".
    ![](./images/atpd5.png " ")

- Click on "Add Target Declaratively".
    ![](./images/atpd6.png " ")

- Search the host name and select as "emcc.marketplace.com".
    ![](./images/atpd7.png " ")
    
    ![](./images/atpd8.png " ")

- Select Target Type as "Autonomous Transaction Processing" and click on "Add..". 
    ![](./images/atpd9.png " ")

- Give the Target Name as "ADBEM" (Target name can be anything of your desire)

- Select "OCI Client Credential (Wallet)" as ATPD instance wallet downloaded from console   

- Select "Service Name" as "<ATPD_Name>_low"

- Give the "Monitoring Username" as "ADMIN"

- Give "Monitoring Password" as wallet (.zip file) download password
	![](./images/atpd10.png " ")

- Click on "Test Connection" 
	![](./images/atpd11.png " ")

- Once the connection test is successful, click "Next" and Click on "Submit". 
	![](./images/atpd12.png " ")
	
	![](./images/atpd13.png " ")
	
	![](./images/atpd14.png " ")
	
	![](./images/atpd15.png " ")
	
## STEP 5: Test the Connection

- Click on "Targets" select "All Targets"
	![](./images/atpd16.png " ")
	
- Under Databases select "Autonomous Transaction Processing" 
	![](./images/atpd17.png " ")
	
	![](./images/atpd18.png " ")
	
- Under Target Name select "ADBEM" 

## STEP 6: Unlock "ADBSNMP" user.

- Select "Users" under "Security"
	![](./images/upd_01.png " ")

- The default user for OEM "ADBSNMP" will be locked by default, click on the user "ADBSNMP".
	![](./images/upd_02.png " ")

- Click on "Edit".
	![](./images/upd_03.png " ")

- Select "Unlocked" radio button and give the new password for "ADBSNMP" user and click on "Apply".
	![](./images/upd_04.png " ")

- Once the change is saved check under "Users" in "Security". The user "ADBSNMP" will be "Open"
	![](./images/upd_05.png " ")

## STEP 7: Establish Connection with ATP as "ADBSNMP" user.

- Repeat STEP 4 with the below changes:

- Give the Target Name as "ADBEM2" (Target name can be anything of your desire)

- Select "OCI Client Credential (Wallet)" as ATPD instance wallet downloaded from console   

- Select "Service Name" as "<ATPD_Name>_low"

- Give the "Monitoring Username" as "ADBSNMP"

- Give "Monitoring Password" as ADBSNMP user password and click on "Test Connection"
	![](./images/upd_07.png " ")

- Once the connection test is successful, Click "OK" and click "Next" 
	![](./images/upd_08.png " ")

- Click on "Submit" to establish the connection	
	![](./images/upd_09.png " ")
	![](./images/upd_10.png " ")

## Acknowledgements

*Congratulations! You have successfully established connection to Autonomous Transaction Processing Dedicated Database from OEM .*

- **Authors** - Navya M S & Padma Priya Natarajan


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/autonomous-database-dedicated). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
