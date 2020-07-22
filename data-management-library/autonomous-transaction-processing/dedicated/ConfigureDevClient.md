<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

June 13, 2019
</td>
<td class="td-banner">
# Lab 5: Configuring a development system for use with your dedicated autonomous database
</td></tr><table>

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Introduction
The Oracle Cloud Infrastructure marketplace provides a pre-built image with necessary client tools and drivers to build applications on autonomous databases. As an application developer you can now provision a developer image within minutes and connect it to your dedicated or serverless database deployment. 

 The image is pre-configured with tools and language drivers so that you can configure a secure connection using Oracle SQL Developer, SQLCL and SQL*Plus.
For a complete list of features, login to your OCI account, select 'Marketplace' from the top left menu and browse details on the 'Oracle Developer Cloud Image'

![](./images/500/marketplace.png)




## Objectives

As a database user, DBA or application developer,
- Configure a development system from a pre-built marketplace image
- Create an ssh tunnel from your local laptop into your development system
- Invoke SQL Developer on your development system over a VNC connection from your local laptop 
Configure a secure connection from your development system to your dedicated autonomous database using Oracle SQL Developer, SQLCL and SQL*Plus.

## Required Artifacts

- An Oracle Cloud Infrastructure account with IAM privileges to provision compute instances
- A pre-provisioned dedicated autonomous database instance. Refer [Lab 4](./ProvisionADB.md) on how provision an ATP database.
- VNC Viewer or other suitable VNC client on your local laptop



## Steps

### STEP 1: Provision a OCI Marketplace Developer Client image instance

We start with deploying a pre-configured client machine instance from the OCI marketplace

- Log into your cloud account using your tenant name, username and password
- Click Compute Instance in the left side menu under services 

![](./images/500/createcompute.png)

<br>

- Click create Instance

![](./images/500/createcomputebutton.png)

<br>

- Specify a name for compute instance

![](./images/500/computename.png)

<br>

- Choose Oracle Cloud Developer image from Oracle Image section

![](./images/500/computeimage.png)

<br>

- Choose instance type for Virtual Machine

![](./images/500/computeinstancetype.png)

<br>

<br>

- Choose VCN and subnet where you would like your client machine deployed. This would likely be the application subnet created in previous labs. 

**Note:**
**- Please ensure you have picked the right compartments where network resources exist.**
**- A network administrator needs to pre-provision a client network and setup access path to your autonomous database network. Please contact your cloud account / network / fleet administrator for application subnet information.**

![](./images/500/computenetwork.png)

<br>

Ensure the public IP address button is selected. You would need to ssh into this instance over public internet.

![](./images/500/public_ip.png)

<br>

- Add SSH key, you can choose to import ssh public key or paste ssh public key

![](./images/500/computekey.png)

- Within a few mins your developement instance will be available and a public IP address assigned (if it is provisioned in a public subnet)

![](./images/500/computewait.png)

<br>

- Once provisioned, you can click on the instance name to see details

![](./images/500/computeready.png)

<br>
<br>

### STEP 2: Download and transfer DB wallet to client machine


Let's first download the DB wallet to your local machine (laptop) and then scp / sftp it to the developer client machine.

 **Note: You may skip the download and secure copy steps below and download the wallet directly into your developer client machine once you connect to it via VNC**

- From your local browser, navigate to OCI console

- On the ATP console, select the dedicated ATP instance provisioned in [Lab 4](./ProvisionADB.md).

![](./images/500/doneprovision.png)

<br>

- Click on  **DB Connection** to open up Database Connection pop-up window

![](./images/500/dbconnection.png)

<br>

- Click on **Download** to supply a password for the wallet and download your client credentials.
    Please use below Keystore password to download the client credentials

```
WElcome#1234
```

![](./images/500/Picture200-3.png)

<br>

- The credentials zip file contains the encryption wallet, Java keystore and other relevant files to make a secure TLS 1.2 connection to your database from client applications. 



<br>


**Next we upload the wallet to the dev client**


*Mac users can scp the file using command below. Windows 10 users can use the same command from powershell.

Older versions of windows may need to install an SFTP client on their local machine to upload the wallet*


- secure copy the file using scp, sftp or a windows ftp client

    ```
        $ scp -i <path/to/keyfile> <wallet_filename.zip>  opc@<ipaddress-of-dev-client>:/home/opc

    ```

    example, for mac users with a private key file named id_rsa in their home directoy,

    ```
        $ scp -i ~/id_rsa My-ATPDB-wallet.zip  opc@129.162.23.12:/home/opc

    ```


### STEP 3: Connect to dev client desktop over VNC


First we shh into the dev client and invoke the VNC server that comes pre-installed.


- SSH into your dev client compute instance

    ```
    $ ssh -i <private-key> opc@PublicIP
    ```

- Change the password on the VNC server
    
    ```
    $ vncpasswd
    ```
- Once you update the password, start your VNC server with the following command,
    ```
    $ vncserver -geometry 1280x1024
    ```
- Your development system may now be ready for accepting VNC connections

**Mac Users**

On your local laptop,

- Open a terminal window and create an ssh tunnel using the following command,
    ```
    $ ssh -N -L 5901:127.0.0.1:5901 -i \<priv-key-file\> opc@<publicIP-of-your-devClient>
    ```

**Windows Users**
- Windows 10 users can use powershell to connect using command above.

- Alternatively, you may create and ssh tunnel using putty. Detailed instructions on using putty for ssh tunnels are provided in the [Appendix](./Appendix.md)


You now have a secure ssh tunnel from your local laptop to your developement system in OCI on VNC port 5901

**Note: As mentioned earlier, you need a VNC client installed on your laptop. This lab uses VNC Viewer**


Start VNC Viewer on your laptop and configure a client connection using the settings as shown

![](./images/500/vncViewer.png)

Note how the connect string for VNC Server is simply localhost:1  That is because the default port 5901 on your local machine is forwarded to 5901 on your OCI dev client over an ssh tunnel

Connect to your VNC desktop and provide the password you changed on the host earlier

If all goes well, you should now see a linux desktop in your VNC window.


### STEP 4: Connect to your autonomous DB using SQL Developer, SQLCL and SQL Plus

In your VNC session, invoke SQL Developer from the top left Applications menu as shown below

![](./images/500/sql-developer-vnc.png)



**Note: In the event you have issues launching SQL Developer and it prompts with a java classpath error, simply add the following line to ~/.sqldeveloper/19.1.0/product.conf and retry**
````
SetJavaHome /usr/java/jdk1.8.0_231-amd64
````

Create an new connection in sql*developer and provide the following information,

**Connection Name**: Name for your connection

**Username**: admin

**Password**: <password>

**Connection Type**: Cloud Wallet

**Role**: Default

**Configuration File**: Click on Browse and select the wallet file you downloaded

**Service**: 'databasename_high' Database name followed by suffix low, medium or high. These suffixes determine degree of parallelism used and are relevant for a DSS workload. For OLTP workloads it's safe to select any of them. Example: **atpd_high**

- Test your connection and save. The **Status** bar will show **Success** if it is a successful connection!

**Let's also test connectivity through some command line client tools such as SQLCL and SQL*Plus**


**Connect to ATP instance using Oracle SQLCL**

Assuming you are still connected to your OCI development system over VNC, simply open a terminal window and start command line sql as follows,

```
$ sql /nolog
```
Point to your database wallet folder,
```
SQL> set cloudconfig /home/opc/Wallet_ATPD.zip
```
Connect to your database,
![](./images/500/sqlclconfigure.png)

```
SQL> connect admin@atpd_high  (replace 'atpd_high' with an appropriate service for your instance)
```
Provide your admin password and you are in!


![](./images/500/sqlclsuccess.png)

<br>
<br>

**Connect to ATP instance using Oracle SQL Plus**

For SQL*Plus, you will need to unzip the wallet in your local folder and edit sqlnet.ora as follows-

- Edit the sqlnet.ora file in /home/opc/wallet and change the line ?/network/admin:

Before:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="?/network/admin")))
SSL_SERVER_DN_MATCH=yes
```

After:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="/home/opc/wallet")))
SSL_SERVER_DN_MATCH=yes
```

Set the TNS_ADMIN env variable to point to wallet folder

        $export TNS_ADMIN=/home/opc/wallet

- Now, run:

```
sqlplus admin@atpd_high
```

Provide your admin password when prompted and you should be in!




<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
### Great Work! You successfully created a client machine and connected to your autonomous database instance using SQL Developer and command line tools.
</td>
</tr>
<table>