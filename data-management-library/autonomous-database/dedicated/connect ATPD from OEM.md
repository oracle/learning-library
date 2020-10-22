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


## STEP 1: Instance Details

- Login to your Oracle Cloud Infrastructure account and select *Compute* —> *Instances* from top left menu.
    ![](./images/Compute1.png " ")

- Select the compute deployed in lab?

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

- In your browser type the URL as "https://<public ip address of oem compute>:7803/em"

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
    ![](./images/atpd1.png " ")

- Click on "Add Target Declaratively".
    ![](./images/atpd2.png " ")

- Search the host name and select as "emcc.marketplace.com".
    ![](./images/atpd3.png " ")

- Select Target Type as "Autonomous Transaction Processing" and click on "Add..". 
    ![](./images/atpd4.png " ")

- Give the Target Name as "ADBEM" (Target name can be anything of your desire)

- Select "OCI Client Credential (Wallet)" as ATPD instance wallet downloaded from console   

- Select "Service Name" as "<ATPD_Name>_low"

- Give the "Monitoring Username" as "ADMIN"

- Give "Monitoring Password" as wallet (.zip file) download password
	![](./images/atpd5.png " ")

- Click on "Test Connection" 
	![](./images/atpd6.png " ")

- Once the connection test is successful save the connect and click on connect 
	![](./images/atpd7.png " ")
	
	![](./images/atpd8.png " ")
	
## STEP 5: Test the Connection

- Click on "Targets" select "All Targets"
	![](./images/atpd9.png " ")
	
- Under Databases select "Autonomous Transaction Processing" 
	![](./images/atpd10.png " ")
	
- ADBEM will be present under Target Name

## Acknowledgements

*Congratulations! You have successfully established connection to Autonomous Transaction Processing Dedicated Database from OEM .*

- **Authors** - Navya M S & Padma Priya Natarajan
