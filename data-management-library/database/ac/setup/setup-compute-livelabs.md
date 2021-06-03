# Build a DB System

## Introduction
This lab will show you how to connect to your DB System.  

Estimated Lab Time:  5 minutes

Watch the video below for an overview of the Build a DB System lab
[](youtube:hTFSffquzCo)

### Objectives
-   Identify DB Instance Public IP Addresses
-   Connect to the each RAC instance:  Node 1 and Node 2

### Prerequisites
- An assigned Oracle LiveLabs Cloud account
- An assigned compartment
- An assigned Database Cluster Password
- The SSH Key you supplied when registering for LiveLabs

## **STEP 1**: Login to Oracle Cloud

1.  Login to Oracle Cloud
2.  Open up the hamburger menu in the left hand corner.  

3.  From the hamburger menu, select **Bare Metal, VM, and Exadata** in the Oracle Database category.

  ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-dbcs.png " ")

2.  Identify your database system from your My Reservations page in LiveLabs and click it.  (Note:  Remember to choose the compartment and region that you were assigned if running on LiveLabs)

  ![](./images/setup-compute-2.png " ")

3. Explore the DB Systems home page.  On the left hand side, scroll down to view the Resources section.  Click Nodes.

  ![](./images/setup-compute-3.png " ")

4. Locate your two nodes and jot down their public IP addresses.

  ![](./images/setup-compute-4.png " ")


5. Note the **Host domain name** which in the LiveLabs case will be *pub.racdblab.oraclevcn.com* .

    ![](./images/setup-compute-5.png " ")

6. Now that you have your IP address select the method of connecting. Choose the environment where you created your ssh-key in the previous lab (Generate SSH Keys) and select one of the following steps.  We recommend you choose Oracle Cloud Shell for this series of workshops.
- [Step 2: Oracle Cloud Shell (RECOMMENDED)](#STEP5:OracleCloudShell)
- [Step 3: MAC or Windows CYGWIN Emulator](#STEP6:MACorWindowsCYGWINEmulator)
- [Step 4: Putty](#STEP7:WindowsusingPutty)

## **STEP 2**: Oracle Cloud Shell

1.  To start the Oracle Cloud Shell, go to your Cloud console and click the Cloud Shell icon at the top right of the page.

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/images/cloudshellopen.png " ")

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/images/cloudshellsetup.png " ")

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/images/cloudshell.png " ")

2.  Click on the Cloud Shell hamburger icon and select **Upload** to upload your private key

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/images/upload-key.png " ")

3.  To connect to the compute instance that was created for you, you will need to load your private key.  This is the key that does *not* have a .pub file at the end.  Locate that file on your machine and click **Upload** to process it.

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/images/upload-key-select.png " ")

4. Be patient while the key file uploads to your Cloud Shell directory

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/images/upload-key-select-2.png " ")

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/images/upload-key-select-3.png " ")

5. Once finished run the command below to check to see if your ssh key was uploaded.  Move it into your .ssh directory

    ````
    <copy>
    ls
    </copy>
    ````
    ````
    mv <<keyname>> .ssh
    ls .ssh
    cd ~
    ````

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key-cloud-shell/images/upload-key-finished.png " ")


6.  Using one of the Public IP addresses, enter the command below to login as the *opc* user and verify connection to your nodes.    

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Public IP Address>
    ````
    ![](./images/em-cloudshell-ssh.png " ")

7.  When prompted, answer **yes** to continue connecting.
8.  Repeat step 2 for your 2nd node.
9.  You may now *proceed to the next lab*.  


## **STEP 3**: MAC or Windows CYGWIN Emulator
*NOTE:  If you have trouble connecting and are using your work laptop to connect, your corporate VPN may prevent you from logging in. Log out of your VPN before connecting. *
1.  Using one of the Public IP addresses, open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Public IP Address - node1>
    ````
    ![](./images/em-mac-linux-ssh-login.png " ")

2. You can also log in to the **Public IP Address of node2**

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Public IP Address - node2>
    ````
    ![](./images/em-mac-linux-ssh-login.png " ")

3. After successfully logging in, you may *proceed to the next lab*

## **STEP 4**: Windows using Putty
*NOTE:  If you have trouble connecting and are using your work laptop to connect, your corporate VPN may prevent you from logging in. Log out of your VPN before connecting. *

On Windows, you can use PuTTY as an SSH client. PuTTY enables Windows users to connect to remote systems over the internet using SSH and Telnet. SSH is supported in PuTTY, provides for a secure shell, and encrypts information before it's transferred.

1.  Download and install PuTTY. [http://www.putty.org](http://www.putty.org)
2.  Run the PuTTY program. On your computer, go to **All Programs > PuTTY > PuTTY**
3.  Select or enter the following information:
    - Category: _Session_
    - IP address: _Your service instance’s (node1) public IP address_
    - Port: _22_
    - Connection type: _SSH_

  ![](images/7c9e4d803ae849daa227b6684705964c.jpg " ")

### **Configuring Automatic Login**

1.  In the category section, **Click** Connection and then **Select** Data.

2.  Enter your auto-login username. Enter **opc**.

  ![](images/36164be0029033be6d65f883bbf31713.jpg " ")

### **Adding Your Private Key**

1.  In the category section, **Click** Auth.
2.  **Click** browse and find the private key file that matches your VM’s public key. This private key should have a .ppk extension for PuTTy to work.

  ![](images/df56bc989ad85f9bfad17ddb6ed6038e.jpg " ")

3.  To save all your settings, in the category section, **Click** session.
4.  In the saved sessions section, name your session, for example ( EM13C-ABC ) and **Click** Save.

### **Repeat Putty setup for the second node**

1. Repeat the steps above to create a login window for the second node - use the Public IP address of node2
3.  Select or enter the following information:
    - Category: _Session_
    - IP address: _Your service instance’s (node2) public IP address_
    - Port: _22_
    - Connection type: _SSH_

  ![](images/7c9e4d803ae849daa227b6684705964c.jpg " ")

You may now *proceed to the next lab*.  

## Appendix: Troubleshooting Tips

### Issue 1: Can't login to instance
Participant is unable to login to instance

#### Tips for fixing Issue #1
There may be several reasons why you can't login to the instance.  Here are some common ones we've seen from workshop participants
- Permissions are too open for the private key - be sure to chmod the file using `chmod 600 ~/.ssh/<yourprivatekeyname>`
- Incorrectly formatted ssh key (see above for fix)
- User chose to login from MAC Terminal, Putty, etc and the instance is being blocked by company VPN (shut down VPNs and try to access or use Cloud Shell)
- Incorrect name supplied for ssh key (Do not use sshkeyname, use the key name you provided)
- @ placed before opc user (Remove @ sign and login using the format above)
- Make sure you are the oracle user (type the command *whoami* to check, if not type *sudo su - oracle* to switch to the oracle user)
- Make sure the instance is running (type the command *ps -ef | grep oracle* to see if the oracle processes are running)


## Acknowledgements

* **Author** - Rene Fontcha, Master Principal Platform Specialist, NA Technology
* **Contributors** - Kay Malcolm, Product Manager, Database Product Management
* **Last Updated By/Date** - Kay Malcolm, October 2020
