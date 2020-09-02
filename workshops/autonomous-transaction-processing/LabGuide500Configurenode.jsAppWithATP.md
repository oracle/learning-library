<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

November 08, 2018
</td>
<td class="td-banner">
# Lab 5: Configure node.js app with ATP
</td></tr><table>

## Introduction

Autonomous Transaction Processing provides all of the performance of the market-leading Oracle Database in an environment that is tuned and optimized for transaction processing workloads. Oracle Autonomous Transaction Processing (or ATP) service provisions in a few minutes and requires very little manual ongoing administration.


ATP provides a TLS 1.2 encrypted secure connectivity for applications. In fact, using a secure encryption wallet is the only way to connect to an ATP service instance, ensuring every connection to your database is secure, regardless how it gets routed.

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

- Learn how to build a linux node.js application server and connect it to an Oracle ATP database service

## Required Artifacts

- The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

## Steps

### **STEP 1: Create a Virtual Cloud Network**

Virutal Cloud Network (VCN) is a private network that you set up in the Oracle data centers, with firewall rules and specific types of communication gateways that you can choose to use. A VCN covers a single, contiguous IPv4 CIDR block of your choice. See [Default Components that Come With Your VCN](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm#Default). The terms virtual cloud network, VCN, and cloud network are used interchangeably in this documentation. For more information, see [VCNs and Subnets](https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingVCNs.htm).

- Login to your Oracle Cloud Infrastructure and Click on **Menu** and select **Network** and **Virtual Cloud Networks**.

![](./images/500/Picture500-12.png)

In order to create a VCN we need to select a Compartment from the List Scope. For this lab we will be selecting **Demo** compartment.

![](./images/500/Picture500-13.png)

- After selecting **Demo** compartment click on Create Virtual Cloud Network to create VCN

![](./images/500/Picture500-14.png)

- This will bring Create Virtual CLoud Netowrk screen where you will specify the configurations.

![](./images/500/Picture500-15.png)

- Enter the following in Create Virtual Cloud Network window

**Create In Compartment**: Select the compartment, **Demo**. By default, this field displays your current compartment.

**Name**: Enter a name for your cloud network.

Check on **Create Virtual Cloud Network Plus Related Resources** option. By selecting this option, you will be creating a VCN with only public subnets. The dialog expands to list the items that will be created with your cloud network.

![](./images/500/Picture500-16.png)

- Click on Create Virtual Cloud Network.

A confirmation page displays the details of the cloud network that you just created. The cloud network has the following resources and characteristics (some of which are not listed in the confirmation dialog):
- CIDR block range of 10.0.0.0/16
- An internet gateway
- A route table with a default route rule to enable traffic to and from the internet gateway
- A [default security](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/securitylists.htm#Default) list
- A public subnet in each availability domain

![](./images/500/Picture500-17.png)


### **STEP 2: Provision a linux compute VM to serve as the app server**

- Provision a linux compute VM to serve as the app server. 

- Log into your Oracle Cloud Infrastructure and click on Menu and select Compute and Instances.

![](./images/500/Picture500-1.png)

- In order to create Compute Instance we need to select a Compartment. Select **Demo** Compartment which we created in Lab100

- Click on Create Instance

![](./images/500/Picture500-2.png)


Enter the following to Create Linux Instance

- **Name**: Enter a friendly name to identify your linux instance
- **Availability Domain**: Oracle Cloud Infrastructure is hosted in Regions, which are localized geographic areas. Each Region contains three Availability Domains which are isolated and fault-tolerant data centers that can be used to ensure high availability. In the Availability Domain field, select the Availability Domain in which you want to run the instance. For example, scul:PHX-AD-1.
- **Boot Volume**: Oracle-Provided OS Image
- **Image Operating System**: Oracle Linux 7.5
- **Shape Type**: Virtual Machine
- **Shape**: The shape of an instance determines the number of CPUs, the amount of memory, and how much local storage an instance will have. Shape types with names that start with VM are Virtual Machines, while shape types with names that start with BM are Bare Metal instances. Choose the appropriate shape for your Virtual Machine instance in the Shape field. For this lab we will be using, **VM.Standard2.1 (1 OCPU, 15GB RAM)**.
- **Image Version**: Please select the latest version, 2018.09.25-0(latest)
- **Boot Volume Configuration**: When you launch a virtual machine (VM) or bare metal instance based on an Oracle-provided image or custom image, a new boot volume for the instance is created in the same compartment. That boot volume is associated with that instance until you terminate the instance. When you terminate the instance, you can preserve the boot volume and its data, see Terminating an Instance. For this lab we will be using Selected image's default boot volume size: 46.6 GB only.
- **SSH Keys**: If the operating system image for your instance uses SSH keys for authentication (for example, Linux instances), then you must provide an SSH public key. To choose a public key file, ensure that Choose SSH Key Files is selected, then click Browse. 

![](./images/500/BrowseSSH.png)

- Choose the public key to upload (for example, id_rsa.pub), then click Open. Note: some operating systems may use a different interface for file selection.

![](./images/500/UploadSSH.png)

If you do not have ssh key pair you can create using command line.

- Open terminal for entering the commands
- At the prompt, enter the following:

```
ssh-keygen -t rsa -N "" -b "2048" -C "key comment" -f path/root_name
```

Where
- **-t rsa**: Use the RSA algorithm
- **-N "passphrase"**: Passphrase to protect the use of the key (like a password). If you don't want to set a passphrase, don't enter anything between the quotes.
- **-b "2048"**: Generate a 2048 bit key.
- **-C "key comment": A name to identify the key.
- **-f path/root_name**: The location where the key pair will be saved and the root name for the files. For example, if you give the root name as id_rsa, the name of the private key will be id_rsa and the public key will be id_rsa.pub.

![](./images/500/GenerateSSH.png)

#### For windows users:

- Download and run the [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) installer.

- Generate a private and public key pair:
    - Go to the Windows Start menu -> All Programs -> PuTTY and open PuTTYgen
    - Click the 'Generate' button and PuTTYgen will ask you to make some random movement with your mouse until it has enough random data to generate a secure key for you
    - Click the 'Save private key' button and save the resulting file somewhere safe and only accessible by you!

- **Virtual Cloud Network**: In the Virtual Cloud Network field, select the Virtual Cloud Network for the instance which we created earlier in this lab.
- **Subnet**: In the Subnet field, select the subnet to which to add the instance. For example, the public subnet scul:PHX-AD-1.

That is all you need to enter to create Linux instance on OCI. 

- Click on **Create Instance** at the bottom 

![](./images/500/CreateLinux1.png)
![](./images/500/CreateLinux2.png)
![](./images/500/CreateLinux3.png)

- While the instance is being created, its state is displayed as "PROVISIONING".

![](./images/500/ProvisioningLinux.png)

- The status changes to "RUNNING" when the instance is fully operational.

![](./images/500/RunningLinux.png)

- Note the public IP of the machine provisioned and ssh into this host and configure it to run node.js on ATP.

### **STEP 3: Install node.js, python 2.7 and required libaio libraries**

In order to install the required package on linux environment we need to ssh into our linux host machine.

- Open Terminal and ssh as user opc to your host machine. 

Change the below command to your ssh key path.

```
$ssh -i /Users/tejus/Desktop/sshkeys/id_rsa opc@ipaddress
```

![](./images/500/Picture500-4.png)

Once you have succesfully ssh into the host machine install the packages.

- Download and install node.js, python and git. We will need git to download instant client and sample app.

```
$curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
```

![](./images/500/Picture500-5.png)

- Install nodejs

```
sudo yum install nodejs
```

![](./images/500/Picture500-6.png)


- Install python 2.7 if it does not already exist on your machine.

#### Note: OEL 7.5 comes pre-installed with python 2.7

- You can check python version

```
python --version
```

![](./images/500/Picture500-7.png)

- Ensure libaio is installed and up to date

```
sudo yum install libaio
```

![](./images/500/Picture500-8.png)

- You can check your node, npm installs using
```
node --version
```
![](./images/500/Node_Version.png)

```
npm --version
```

![](./images/500/npm_version.png)


- Install git to your host machine.

```
sudo yum install git
```


### **STEP 4: Install and configure Oracle Instant Client**

- Download and install Oracle Instant Client software

#### Note: You can download it from OTN [here](https://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html)

Copy instant client from you local machine to linux host machine
```
scp -i ~/priv-ssh-keyfile /path_to/instantclient-basic-linux.x64-12.2.0.1.0.zip opc@ipaddress:/opt/oracle/instantclient_12_2
```

- Unzip the file and move the files to /opt/oracle/instantclient_12_2

```
cd instantclient_12_2_linux/

unzip instantclient-basiclite-linux.x64-12.2.0.1.0.zip

cd instantclient_12_2/

sudo mkdir /opt/oracle

sudo mv /home/opc/instantclient_12_2_linux/instantclient_12_2/ /opt/oracle/instantclient_12_2/
```

### **STEP 5: Clone Node application**

- Download a sample Node application in folder /home/opc

```
$ wget --no-check-certificate --content-disposition https://github.com/oracle/learning-library/blob/master/workshops/autonomous-transaction-processing/scripts/500/ATPnodeapp.zip?raw=true
```

- Unzip ATPnodeapp.zip

```
$ mkdir ATPnodeapp && cd ATPnodeapp

$ unzip /home/opc/ATPnodeapp.zip
```
Now that you have a sample application setup, lets get your database's secure wallet for connectivity

### **STEP 6: Upload connection wallet and run sample app**

- Upload the connection wallet and run sample app

- From your local machine copy the secured wallet file to host machine. 
The format of the below command is 

scp -i **"/path_to_private_key "** **"/path_to_wallet_dbname.zip"** opc@ipaddress:/home/opc/ATPnodeapp

```
scp -i ~/priv-ssh-keyfile wallet_RESTONHUBDB.zip opc@ipaddress:/home/opc/ATPnodeapp
```

- ssh back to your host machine and unzip the wallet file

```
cd /home/opc/ATPnodeapp

unzip wallet_RESTONHUBDB.zip -d wallet_RESTONHUBDB/
```

- Edit sqlnet.ora as follows

```
cd /home/opc/ATPnodeapp/wallet_RESTONHUBDB/

nano sqlnet.ora

WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY=$TNS_ADMIN)))
SSL_SERVER_DN_MATCH=yes
```

- Set LD_LIBRARY_PATH in your bash_profile as

```
export LD_LIBRARY_PATH=/opt/oracle/instantclient_12_2:$LD_LIBRARY_PATH
```

- Set env variables TNS_AMDIN to point to the wallet folder and edit sqlnet.ora file in wallet folder to point to the wallet.

```
export TNS_ADMIN=/home/opc/ATPnodeapp/wallet_RESTONHUBDB/
```

- We have now set up all the required packages and settings to run our server.js.

- Your sample application consists of 2 files, dbconfig.js and server.js. Set dbuser, dbpassword and connectString in dbconfig.js to point to your ATP database.

- **dbuser**: admin
- **dbpassword**: Admin passwrod, in our case it is 'WElcome_123#'
- **connectString**: 'yourdbname_high'

```
nano dbconfig.js

module.exports= {
dbuser: 'admin', 
dbpassword: 'WElcome_123#', 
connectString: 'atplab_high' 
}
```

- Run server.js

```
cd /home/opc/ATPnodeapp

node server.js
```

![](./images/500/Picture500-11.png)


- Once the server.js is running open up another terminal and ssh into the linux machine and get into your node app folder and run app in background and test with curl.

```
$ssh -i /path_to_private_key/sshkeys/id_rsa opc@ipaddress

cd /home/opc/ATPnodeapp/

curl http://localhost:3050
```

- The application confirms connectivity to your ATP instance.

![](./images/500/Picture500-10.png)

You have now successfully connected your node app to Autonomous Transaction Processing database.

-   You are now ready to move to the next lab.

<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
## Great Work - All Done!
</td>
</tr>
<table>