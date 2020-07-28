<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

June 13, 2019
</td>
<td class="td-banner">
# Lab 8: Building and deploying Python application stacks on dedicated autonomous infrastructure
</td></tr><table>

## Introduction

The Oracle Cloud Infrastructure marketplace provides a pre-built image with necessary client tools and drivers to build applications on autonomous databases. As an application developer you can now provision a developer image within minutes and connect it to your dedicated or serverless database deployment. 

 The image is pre-configured with tools and language drivers to help you build applications written in node.js, python, java and golang.
For a complete list of features, login to your OCI account, select 'Marketplace' from the top left menu and browse details on the 'Oracle Developer Cloud Image'

**In this lab we will configure and deploy a python application in a developer client VM and connect it to an autonomous database.**



### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

As an application developer,
- Learn how to deploy a python application and connect it to your dedicated autonomous database instance

## Required Artifacts

- An Oracle Cloud Infrastructure account

- A pre-provisioned instance of Oracle Developer Client image in an application subnet. Refer to [Lab 6](ConfigureDevClient.md)

- A pre-provisioned dedicated autonomous database instance. Refer to [Lab 4](./LabGuide400ProvisioningdatabasesonyourdedicatedAutonomousInfrastructure.md)

- A network that provides connectivity between the application and database subnets. Refer to [Lab 1](./ATPD-Networking.md)

## Steps

### STEP 1: Download sample python application

- Login to your Oracle Cloud Infrastructure account and select **Compute** —> **Instances** from top left menu

![](./images/800/Compute1.png)

- Select the right Oracle Developer Cloud image you created in [Lab5](LabGuide500ConfigureADevelopmentSystemForUseWithYourDedicatedAutonomousDatabase.md) 

- Copy the public IP address of the instance in a note pad. 

![](./images/800/Compute2.png)


**Mac / Linux users**

- Open Terminal and SSH into linux host machine

```
sudo ssh -i /path_to/sshkeys/id_rsa opc@publicIP
```

![](./images/800/SSH1.png)

**Windows users**

- You can connect to and manage linux host mahine using SSH client. Recent versions of Windows 10 provide OpenSSH client commands to create and manage SSH keys and make SSH connections from a command prompt.

- Other common Windows SSH clients you can install locally is PuTTY. Click [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows) to follow the steps to connect to linux host machine from you windows using PuTTY.

**Download sample python Application**

In your developer client ssh session,

```
cd /home/opc/
```

Lets download a sample python application for the purpose of this lab,

```
wget --no-check-certificate --content-disposition https://github.com/oracle/learning-library/blob/master/data-management-library/autonomous-transaction-processing/dedicated/scripts/700/ATPDpython.zip?raw=true
```

- Unzip the application 

```
unzip ATPDpython.zip
```


### STEP 2: Transfer database wallet to developer client

- Login to Oracle Cloud Infrastructure account and select **Autonomous Transaction Processing** from menu
![](./images/800/atpd1.png)

- Click on Autonomous Database and select your previously created database

![](./images/800/atpd2.png)

- Click on DB Connection and under Download Client Credential(Wallet) click **Download**

![](./images/800/atpd3.png)



- Provide a password and download the wallet to a local folder. 

  

![](./images/800/atpd4.png)

The credentials zip file contains the encryption wallet, Java keystore and other relevant files to make a secure TLS 1.2 connection to your database from client applications. Store this file in a secure location.

Let us now secure copy the downloaded wallet to developer client machine.

- Open Terminal in your laptop and type in the following commands

#### Note: Please change path and name of your private ssh keyhole,   wallet and the ip address of your developer client in the command below.

```
sudo scp -i /Path/to/your/private_ssh_key /Path/to/your/downloaded_wallet opc@publicIP:/home/opc/
```
![](./images/800/atpd5.png)



### STEP 3: Run your python application**

Now that you have successfully SCP'd the encryption to your client machine, let's connect to our linux host, unzip the wallet and update sqlnet.ora file to point to the wallet folde

- Open terminal on your laptop and SSH into linux host machine. Windows users follows instructions provided above to ssh using Putty.

```
ssh -i /path/to/your/private_ssh_key opc@PublicIP
```

- Create a new directory for wallet and unzip the wallet

```
cd /home/opc/ATPDpython/

mkdir wallet

unzip Wallet_ATPDedicatedDB.zip -d /home/opc/ATPDpython/wallet/
```

- The sqlnet.ora file in the wallet folder needs to be edited to point to the location of the wallet as shown below

```
vi /home/opc/ATPDpython/wallet/sqlnet.ora
```

- Change **DIRECTORY** path to /home/opc/ATPDpython/wallet/ and save the file

![](./images/700/walletPython.png)

- Export TNS_ADMIN

```
export TNS_ADMIN=/home/opc/ATPDpython/wallet/
```

- Verify TNS_ADMIN points to the wallet folder

```
echo $TNS_ADMIN
```
![](./images/700/TNSadmin.png)

- That's all! Lets fire up our python app and see if it makes a connection to the database.

```
 python exampleConnection.py ADMIN PASSWORD dbname_tp
```
![](./images/700/pythonSuccess.png)


<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
### Congratulations! You successfully deployed and connected a python app to your autonomous database.
</td>
</tr>
<table>