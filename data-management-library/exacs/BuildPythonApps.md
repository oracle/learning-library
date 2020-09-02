## Introduction

The Oracle Cloud Infrastructure marketplace provides a pre-built image with necessary client tools and drivers to build applications on Exadata Cloud Service databases. As an application developer you can now provision a developer image within minutes and connect it to your database deployment.

The image is pre-configured with tools and language drivers to help you build applications written in node.js, python, java and golang.
For a complete list of features, login to your OCI account, select 'Marketplace' from the top left menu and browse details on the 'Oracle Developer Cloud Image'

**In this lab we will configure and deploy a python application in a developer client VM and connect it to an Exadata Cloud Service database.**

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

As an application developer,
- Learn how to deploy a python application and connect it to your EXACS database instance

## Required Artifacts

- An Oracle Cloud Infrastructure account

- A pre-provisioned instance of Oracle Developer Client image in an application subnet. Refer to [Lab 4](?lab=lab-4-configure-development-system-for-use)

- A pre-provisioned Exadata Cloud Service database instance. Refer to [Lab 3](?lab=lab-3-provision-databases-on-exadata-cloud)

- A network that provides connectivity between the application and database subnets. Refer to [Lab 1](?lab=lab-1-preparing-private-data-center-o)

## Steps

### **Step 1:** Download sample python application

- Login to your Oracle Cloud Infrastructure account and select **Compute** —> **Instances** from top left menu

![](./images/pythonApp/Compute1.png " ")

- Select the right Oracle Developer Cloud image you created in [Lab 4](?lab=lab-4-configure-development-system-for-use)

- Copy the public IP address of the instance in a note pad. 

![](./images/pythonApp/Compute2.png " ")


**Mac / Linux users**

- Open Terminal and SSH into linux host machine

```
<copy>sudo ssh -i /path_to/sshkeys/id_rsa opc@publicIP</copy>
```

![](./images/pythonApp/SSH1.png " ")

**Windows users**

- You can connect to and manage linux host machine using SSH client. Recent versions of Windows 10 provide OpenSSH client commands to create and manage SSH keys and make SSH connections from a command prompt.

- Other common Windows SSH clients you can install locally is PuTTY. Click [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows) to follow the steps to connect to linux host machine from you windows using PuTTY.

**Download sample python Application**

In your developer client ssh session,

```
<copy>cd /home/opc/</copy>
```

Lets download a sample python application for the purpose of this lab,


```
<copy>wget -O EXACSPython.zip https://objectstorage.us-ashburn-1.oraclecloud.com/p/qvAWQt4VJBTU25lXtqKk3MzmRZ4vE-XJli9g0MhgWfQ/n/orasenatdpltintegration02/b/ExaCSScripts/o/EXACSPython.zip</copy>
```
- Unzip the application 

```
<copy>unzip EXACSPython.zip</copy>
```

### **Step 2:** Run your python application**


- Open terminal on your laptop and SSH into linux host machine. Windows users follows instructions provided above to ssh using Putty.

```
<copy>ssh -i /path/to/your/private_ssh_key opc@PublicIP</copy>
```

- Navigate to EXACSPython folder

```
<copy>cd /home/opc/EXACSPython</copy>
```

- Edit the dns_tns connection in the sample python application.

```
<copy>vi pythonapp.py</copy>
```

![](./images/pythonApp/editpythonapp.png " ")

- Change the following parameters

1. dsn_tns = cx_Oracle.makedsn('Hostname', '1521', service_name='DBServiceName')
```
Hostname: DBUniqueName.DBHostname
Port: 1521
Service_name: Can be found in tnsnames.ora file
```

2. conn = cx_Oracle.connect(user='system', password='DBPassword', dsn=dsn_tns)

```
user: system
password: Database password
dns: dsn_tns
```

- That's all! Lets fire up our python app and see if it makes a connection to the database.

- In connection execute this application displays all the users in the database.

```
<copy>python pythonapp.py</copy>
```

![](./images/pythonApp/pythonSuccess.png " ")
