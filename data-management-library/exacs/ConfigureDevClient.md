## Introduction
The Oracle Cloud Infrastructure marketplace provides a pre-built image with necessary client tools and drivers to build applications on Exadata Cloud Service databases. As an application developer you can now provision a developer image within minutes and connect it to your database deployment.

The image is pre-configured with tools and language drivers so that you can configure a secure connection using Oracle SQL Developer, SQLcl, and SQL*Plus.
For a complete list of features, login to your OCI account, select 'Marketplace' from the top left menu, and browse details on the 'Oracle Developer Cloud Image'

![](./images/Infra/ConfigureDevEnv/Marketplace.png " ")

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
Watch the video below for an overview on how to configure a Development System for use with your Exadata Cloud Service Database

<div style="max-width:768px"><div style="position:relative;padding-bottom:56.25%"><iframe id="kaltura_player" src="https://cdnapisec.kaltura.com/p/2171811/sp/217181100/embedIframeJs/uiconf_id/35965902/partner_id/2171811?iframeembed=true&playerId=kaltura_player&entry_id=1_ipbl7apx&flashvars[streamerType]=auto&amp;flashvars[localizationCode]=en&amp;flashvars[leadWithHTML5]=true&amp;flashvars[sideBarContainer.plugin]=true&amp;flashvars[sideBarContainer.position]=left&amp;flashvars[sideBarContainer.clickToClose]=true&amp;flashvars[chapters.plugin]=true&amp;flashvars[chapters.layout]=vertical&amp;flashvars[chapters.thumbnailRotator]=false&amp;flashvars[streamSelector.plugin]=true&amp;flashvars[EmbedPlayer.SpinnerTarget]=videoHolder&amp;flashvars[dualScreen.plugin]=true&amp;flashvars[hotspots.plugin]=1&amp;flashvars[Kaltura.addCrossoriginToIframe]=true&amp;&wid=1_fp1noq9a" width="768" height="432" allowfullscreen webkitallowfullscreen mozAllowFullScreen allow="autoplay *; fullscreen *; encrypted-media *" sandbox="allow-forms allow-same-origin allow-scripts allow-top-navigation allow-pointer-lock allow-popups allow-modals allow-orientation-lock allow-popups-to-escape-sandbox allow-presentation allow-top-navigation-by-user-activation" frameborder="0" title="Kaltura Player" style="position:absolute;top:0;left:0;width:100%;height:100%"></iframe></div></div>

## Objectives

As a database user, a DBA, or an application developer,
- Configure a development system from a pre-built marketplace image
- Create a ssh tunnel from your local laptop into your development system
- Invoke SQL Developer on your development system over a VNC connection from your local laptop 
- Configure a secure connection from your development system to your EXACS database using Oracle SQL Developer and SQL*Plus.


## Required Artifacts

- An Oracle Cloud Infrastructure account with IAM privileges to provision compute instances
- A pre-provisioned ExaCS database instance. Refer to [Lab 3](?lab=lab-3-provision-databases-on-exadata-cloud) on how to provision an EXACS database.
- VNC Viewer or other suitable VNC client on your local laptop

## Steps

### **Step 1:** Provision an OCI Marketplace Developer Client image instance

We start by deploying a pre-configured client machine instance from the OCI marketplace

- Login to your cloud account using your tenant name, username, and password
- Click 'Compute Instance' on the left side menu under 'Core Infrastructure'

![](./images/Infra/ConfigureDevEnv/createcompute.png " ")

<br>

- Click **Create Instance**.

![](./images/Infra/ConfigureDevEnv/createcomputebutton.png " ")

<br>

- Specify a name for the compute instance.

![](./images/Infra/ConfigureDevEnv/computename.png " ")

<br>

- Choose **Change Image** and a pop-up will appear. Select the **Oracle Images** tab and then select **Oracle Cloud Developer Image** from Oracle Image section.

![](./images/Infra/ConfigureDevEnv/changeimage.png " ")
![](./images/Infra/ConfigureDevEnv/oracleimagestab.png " ")
![](./images/Infra/ConfigureDevEnv/computeimage.png " ")

<br>

- Choose the instance type as **Virtual Machine**

![](./images/Infra/ConfigureDevEnv/computeinstancetype.png " ")

<br>

- Choose the VCN and subnet where you would like your client machine deployed. This would likely be the application subnet created in previous labs. 

**Note:**
**- Please ensure you have picked the right compartments where network resources exist.**

![](./images/Infra/ConfigureDevEnv/computenetwork.png " ")

<br>

Ensure that the **Assign A Public IP Address** button is selected. You will need to ssh into this instance over public internet.

![](./images/Infra/ConfigureDevEnv/public_ip.png " ")

<br>

- Add the SSH key. You can choose to import the ssh public key or paste the ssh public key.

![](./images/Infra/ConfigureDevEnv/computekey.png " ")

- Within a few minutes your development instance will be available and a public IP address will be assigned (if it is provisioned in a public subnet).


<br>

- Once provisioned, you can click on the instance name to see its details.

![](./images/Infra/ConfigureDevEnv/computeready.png " ")

<br>
<br>


### **Step 2:** Connect to dev client desktop over VNC


First we shh into the dev client and invoke the VNC server that comes pre-installed.


- SSH into your dev client compute instance

```
<copy>ssh -i <private-key> opc@PublicIP</copy>
```

- Change the password on the VNC server
   
```
<copy>vncpasswd</copy>
```
- Once you update the password, start your VNC server with the following command

 ```
 <copy>vncserver -geometry 1280x1024</copy>
 ```

- Your development system may now be ready for accepting VNC connections

**Mac Users**
On your local laptop

- Open a terminal window and create an ssh tunnel using the following command

```
<copy>ssh -N -L 5901:127.0.0.1:5901 -i \<priv-key-file\> opc@<publicIP-of-your-devClient></copy>
```

**Windows Users**
- Windows 10 users can use powershell to connect using the command above

- Alternatively, you may create an ssh tunnel using putty. Detailed instructions on using putty for ssh tunnels are provided in the [Appendix](?lab=appendix)


You now have a secure ssh tunnel from your local laptop to your development system in OCI on VNC port 5901.

**Note: As mentioned earlier, you need a VNC client installed on your laptop. This lab uses VNC Viewer.**


Start VNC Viewer on your laptop and configure a client connection using the settings as shown

![](./images/Infra/ConfigureDevEnv/vncViewer.png " ")

Note how the connect string for VNC Server is simply localhost:1 . That is because the default port 5901 on your local machine is forwarded to 5901 on your OCI dev client over an ssh tunnel.

Connect to your VNC desktop and provide the password you changed on the host earlier.

You should now see a linux desktop in your VNC window.


### **Step 3:** Connect to your database using SQL Developer and SQL Plus

In your VNC session, invoke SQL Developer from the top left Applications menu as shown below

![](./images/Infra/ConfigureDevEnv/sql-developer-vnc.png " ")

**Note: In the event you have issues launching SQL Developer and it prompts with a java classpath error, simply add the following line to ~/.sqldeveloper/19.1.0/product.conf and retry**

```
<copy>SetJavaHome /usr/java/jdk1.8.0_231-amd64</copy>
```

Create a new connection in SQL Developer and provide the following information

**Connection Name**: Name of your connection

**Username**: sys

**Password**: (choose a password)

**Connection Type**: Basic

**Role**: sysdba

**Hostname**: Private IP of the node in EXACS

**Port**: 1521

**Service name**: DatabaseUniqueName.HostDomainName (This can be found in the cloud console)

![](./images/Infra/ConfigureDevEnv/sql-developer-conn.png " ")

- Test your connection and save. The **Status** bar will show **Success** if it is a successful connection!

**Let's also test connectivity through some command line client tools like SQL*Plus**

**Connect to the database instance using Oracle SQL Plus**

For SQL*Plus, you will need to have tnsnames.ora to connect to your database from your Bastion Server

You can either ssh into your EXACS VM to get the connection string (tnsnames.ora), or you could ask you DBA to provide you with the necessary details. 

- Open Terminal from you Bastion Server

![](./images/Infra/ConfigureDevEnv/sqlplus-open-terminal.png " ")

- Type SQLPLUS and enter the required details to connect it to your database

```
<copy>sqlplus sys/DBpassword@"(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = 'EXACS_VM_IP')(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = databaseUniqueName.hostDomainName)(FAILOVER_MODE=(TYPE = select)(METHOD = basic))))" as sysdba</copy>
```

**Note: Please make sure to change you Database Password, Host, and Service_Name in the above command.**


- When succesfully connected, you should see the below image or something similar to it.

![](./images/Infra/ConfigureDevEnv/sqlplus-conn.png " ")

Great Work! You successfully created a client machine and connected to your EXACS database instance using SQL Developer and SQL*PLUS.
