![](images/200/lab200.png)

Update May 2, 2017

## Introduction

This is the second of five GoldenGate Cloud Service labs, and covers the first use case - zero downtime migration and replication of data from a 11g Database on-premise to DBCS 12c Pluggable Database.  

![](images/100/i2.png)

This workshop will walk you through a zero downtime use case that shows how you can use Oracle Datapump and Oracle GoldenGate to maintain an on-premise database that remains available while data is migrated and replicated to a remote instance with transactional consistency.

To log issues and view the lab guide source, go to the [github oracle](https://github.com/pcdavies/GoldenGateCloudService/issues) repository.

## Objectives

- Introduce you to an on-premise 11g Database environment that will be replicated to a DBCS 12c environment.  Note: this is set up as an image running in Oracle IAAS/compute, but process and configuration steps are the same as though the image was running outside the cloud.
- Configure SQLDeveloper to access the source and target databases.
- Use Oracle Datapump to migrate data from 11g on-premise to DBCS 12c.
- Configure an on-premise GoldenGate to extract data from a 11g Database.
- Configure GoldenGate Cloud Service to replicate data to a DBCS 12c Pluggable Database.
- Generate transactions to showcase real time data replication, while tracking data consistency between environments.

## Required Artifacts

- The following lab requires a [VNC Viewer](https://www.realvnc.com/download/viewer/) to connect to an Image running on Oracle's IaaS Compute Service.  If you do not have a VNC Viewer you can download and install from the [VNC Viewer Website](https://www.realvnc.com/download/viewer/).
- Access to your Oracle Cloud account (used in Lab 100) and services DBCS, GGCS, and Compute.

### **STEP 1**: Review Compute Image (On-premise OGG)

For the GoldenGate Cloud Service Workshop we will be using a compute Image that will represent your on-premises environment. In this image we have installed a 11g database that we will be migrating to our Oracle Public Cloud Database instance. The image also contains SQL Developer 4.1 that will be used to connect to both your local and cloud database.  

- Start your vnc viewer and enter the IP address of the Compute image noted above.  ***You will be specifying port 10 (eg: 129.156.124.185:**10**)***.
	- **VNC IP:** ***OG1*** in your handout
	- **VNC Password:** ***OG2*** in your handout

	![](images/100/i24.png)

- This is the 'On-premise' environment desktop.  All the lab material is in the `GGCS_Workshop_Material` folder on the desktop.  We have created a `cheat_sheet` folder and some shortcuts to simplify your navigation through the labs.

	![](images/100/i24.1.png)

 - Double click on the `GGCS_Workshop_Material` folder and review the contents.  Note:
	- This folder has scripts to start the SSH proxy and to start and stop the GoldenGate Cloud Control Agent.
	- The keys folder contains the private key (already downloaded for you) to access the GGCS and DBCS instances.
	- The SQL Files folder:  These scripts are used in SQLDeveloper to generate transactional data, do row counts, and re-set your data if necessary for the DW.

	![](images/100/i25.png)

- Select the File Browser off the desktop and navigate to /u01/app/oracle/product.  This location is where GoldenGate On-premise product is installed and configured.  We will review this in the next lab.  Note that Oracle Database 11g which is used in the following labs is installed in /opt/oracle.

	![](images/100/i27.png)

- There are many directories under the GoldenGate product homes.  One particularly important directory is dirprm.  The dirprm directory will contain all of the parameter (OGG process configuration) and obey (ggsci scripts) that will be used for the workshop. There is also a cleanup directory that contain obey files to clean up the processes if a lab needs to be restarted.

	![](images/100/i27.1.png)

### **STEP 2**: Configure Database Connections in SQL Developer

- Go to the On-Premise Compute image desktop (VNC) and double click on SQLDeveloper on the desktop.

	![](images/200/i2.png)

- Go to the top view menu and select SSH.  We need to update the IP address of the SSH tunnel that we use to connect to DBCS.  This tunnel encrypts database traffic and passes it through port 22.  Here we map local port 1521 through 22 to remote port 1521.

	![](images/200/i3.png)

- The next step requires you to right click on your mouse or touch pad.  On a MAC computer this is done as follows:

	![](images/200/i3.1.png)

- In the lower left region right click on the DBCSWS tunnel and update the IP address (field ***DB1***).  Note that in a new environment you would need to create a new tunnel yourself.

	![](images/200/i4.png)

- Update the IP address.

	![](images/200/i5.png)

- Then right click on the tunnel and select test.

	![](images/200/i5.1.png)

	![](images/200/i5.2.png)

- Next right click on the top connection `DBCS-Amer` and select Properties.  We need to set that to your assigned DBCS instance.  Set the Service Name.

	![](images/200/i6.png)

- Update the Service Name and enter the connection string you wrote down at the end of lab 100, and then select `Test` to test the connection.

	![](images/200/i6.1.png)

- Then save your connection update.

	![](images/200/i6.2.png)

- Do the same thing for the next `DBCS-DW` connection.  Right click on the `DBCS-DW` connection, select properties, and edit the Service Name, and then select `Test` to test the connection.

	![](images/200/i7.png)

- Then save your connection update.

	![](images/200/i7.1.png)

### **STEP 3**: Review Source Data in 11g Source Database (On-Premise/Compute image) and the DBCS 12c Target Database.

- In SQLDevelper select (expand) the On-Premise-EURO connection, and then expand the tables.  Select the ORDERS table, and then the data tab.  At this point we are just reviewing data in EURO on 11g Database that will be replicated to DBCS 12c.

	![](images/200/i8.png)

- To avoid confusion close the Orders tab that is showing EURO data.

	![](images/200/i8.2.png)

- Next close the SSH region (lower left) since we don't need that anymore.  

	![](images/200/i8.1.png)

- Then select (expand) the `DBCS-Amer` connection and then expand the tables. There are no tables in the target Schema at this point.

	![](images/200/i9.png)

- Lastly select (expand) the `DBCS-DW` connection and then expand the tables.  These are transformed (and empty) tables ready for populating in Lab 400.

	![](images/200/i9.1.png)

### **STEP 4**: Review GGCS

- We will use ssh on the OGG Compute image and log into GGCS from there. Double click on the `GGCS_SSH` shortcut on the desktop.  This is just a simple SSH command to connect to your GGCS instance.

	![](images/200/i9.2.png)

- The first time you connect to GGCS via SSH (and later to DBCS with SSH) you will be prompted for authenticity of the host - respond yes to connect.

	![](images/200/i9.3.png)

- Enter the following commands and then review the output:
	- **Switch to user oracle:** `sudo su - oracle`
	- **Display the oracle home directory:** `pwd`
	- **Switch to the GG Home directory:** `cd $GGHOME`
	- **Display the GG home directory:** `pwd` (/u01/app/oracle/gghome)
	- **Display the GG configuration directories:** `ls dir*`
	- **Log into ggsci (GoldenGate command shell):** `ggsci`
	- **Display status of services:** `info all`
	- **Delete the datastore:** `delete datastore` (the data store may or may not exist.  confirm y to delete if it does exist, otherwise ignore errors)
	- **Start the GGCS manager:** ***Start Mgr***
	- **Confirm manager is started:** `info all`
	- **Exit the command shell:** `exit`
	- **Switch to the network admin directory where connectivity to dbcs12c is configured:** `cd /u02/data/oci/network/admin`
	- **Review the tnsnames.ora file which has the connection to dbcs:** `cat tnsnames.ora`

	![](images/200/i9.4.png)

-	Update the tnsnames file.  Enter the following:
	- `sed -i 's/<your assigned domain name>/<the database connection string>/g' tnsnames.ora`

-	Display the tnsnames.ora file.  Enter the following:
	- `cat tnsnames.ora` (***Note*** this is where you configure GGCS sources and targets.  This has been done for you)

	![](images/200/i9.5.png)

- Close the connection. Enter `exit` and then `exit` again

### **STEP 5**: Configure OGG (On-premise/Source)

- Note this is:
	- Using our On-premise/Compute image through VNC
	- Our source data configuration for 11g Database (schema euro)
	- Uses OGG (not GGCS) with Classic Extract

- We are going to open a SOCKS5 Proxy Tunnel, which will encrypt data and send it through an SSH Tunnel.  First open the `GGCS_Workshop_Material` folder on the desktop.  Note that you get an authentication error if you did NOT first do step 4 above.  The first time you SSH into GGCS (or any Linux server) a file called `known_hosts` is created in the /home/oracle/.ssh directory and the GGCS key is put in that file.  For this proxy step the file and entry must first exist (created from step 4 above).  Right click on the `start_proxy.sh` and select `open`, and then `display`.

	![](images/200/i10.png)

	![](images/200/i10.1.png)

- Review the configuration.  A SOCKS 5 tunnel is a type of SSH tunnel in which specific applications (GoldenGate) forward their local traffic (on port 1080 in this case) down the tunnel to the server, and then on the server end, the proxy forwards the traffic out to the general Internet.  The traffic is encrypted, and uses open port 22 (SSH port) on GGCS to transport the data.  We will reference this port in OGG configuration in the following steps.

	![](images/200/i12.png)

- Close the edit window, and right click inside the folder to open a terminal window.

	![](images/200/i12.1.png)

- Execute the `start_proxy.sh` script.
	- **Enter the following:** `./start_proxy.sh`   **LEAVE THIS WINDOW OPEN - DO NOT CLOSE IT.  YOU CAN MINIMIZE IT**.

	![](images/200/i13.png)

- Review OGG parameters.  Start a GoldenGate command session, open a new terminal window (double click on the Local Terminal icon on the desktop),
	- **Switch to the GG home directory:** `cd $GGHOME`
	- **Start a gg command session:** `./ggsci`
	- **Start the manager:** `start mgr` (not shown in screenshot)

	![](images/200/i15.png)

- View the parameter CREDENTIALSTORE.oby.  The command view param is a shortcut way to view gg parameter files without having to navigate to the directory.  You could also go to the directory and open the file with a text editor such as gedit.
	- **Enter the following:** `view param dirprm/CREDENTIALSTORE.oby`

	![](images/200/i17.png)

 - In the screen above note that the this credential allow us to connect to the local 11g database with an alias without having to specify an OCI connection.  You will see reference to alias ogguser in other gg configuration files.

 - Run this set of gg commands using oby files.  
 	- **Enter the following:** `obey dirprm/CREDENTIALSTORE.oby`

	![](images/200/i18.png)

- View Extract EEURO.prm using ggsci:
	- **Enter the following:** `view param dirprm/EEURO.prm` (Note you do NOT need to enter the commands highlighted in the screenshots - it is just showing you what you will see)

	![](images/200/i17.3.png)

- Review extract configuration.  Note: if you go back and review the overview architecture diagram at the beginning if this lab you can identify these components (Extract, pump, trail file, etc.).  
	- **Enter the following:** `view param ./dirprm/ADD_EURO_EXTRACT.oby`

	![](images/200/i19.png)

- Execute commands to create a datastore and add the EURO extract:
	- **Enter the following:** `create datastore` (not included in the screenshot below)
	- **Enter the following:** `obey dirprm/ADD_EURO_EXTRACT.oby`

	![](images/200/i20.png)

- Scroll through the terminal window to view the results.

- Edit parameter PEURO and set the IP Address.  This uses the 'VI' editor.  Note you can also edit this with gedit (see following step).
	- **Enter the following:** `edit param PEURO`
	- **Use the arrows on your keyboard to navigate to the IP address**
	- **Use the `i` character to enter insert mode and the `[ESC]` key to exit insert mode**
	- **Enter your GGCS IP address (field ***GG1***):** see highlighted text below
	- **Use the `x` key to delete characters**
	- **To save enter `:` character and then `x` character**
	- **Optional - review the file to ensure you entered the changes correctly:** `view param PEURO` (not in screenshot)

	![](images/200/i21.png)

- Review processes that you have added:
	- **Enter the following:** `info all`

	![](images/200/i23.png)

-  Start new processes:
	- **Enter the following:** `start *`
	- **Wait a few seconds for the processes to start, and then enter:** `info all`.  

	![](images/200/i24.png)

- Note : If you find that PEURO fails (see image below) then follow the steps below :

	![](images/200/i44.png)

	- **Ensure that Manager is "Running" on GGCS :** `See commands above near the end of step 4`
	- **Restart PEURO by typing :** `start PEURO`
***Note : Does not auto start, need to manually restart PEURO***
	![](images/200/i46.png)


### **STEP 6**: Migrate Baseline Data with Datapump

- Export the 11g EURO schema data.  You can copy the command from the `cheat_sheet` folder on your on-premise desktop or enter it as follows below.  See field ***OG3*** from your handout for the password:
	- **Enter the following in a terminal window (or copy from the `cheat_sheet` folder):** `expdp euro/<password> schemas=euro dumpfile=export.dmp reuse_dumpfiles=yes directory=oracle`

	![](images/200/i25.png)

- Copy the export.dmp file to DBCS 12c.  You can copy the command from the `cheat_sheet` folder on your on-premise desktop or enter it as follows below.  Use field ***DB1*** for your DBCS IP address.
	- **Enter the following in a terminal window (or copy from the `cheat_sheet` folder):** `scp -i /home/oracle/Desktop/GGCS_Workshop_Material/keys/ggcs_key /home/oracle/export.dmp oracle@<your DBCS IP address>:.`

 	![](images/200/i26.png)

- Double click on the `DBCS_SSH` shortcut on the desktop and open a DBCS SSH terminal window:

 	![](images/200/i26.1.png)

- Import the data.  You can copy the command from the `cheat_sheet` folder on your on-premise desktop or enter it as follows below.
	- **Import the data:** `impdp amer/<password>@pdb1 SCHEMAS=euro REMAP_SCHEMA=euro:amer DIRECTORY=dmpdir DUMPFILE=export.dmp` field ***DB2*** for password

	![](images/200/i27.png)

- Compare row counts.  Open SQL Developer and then open file `get_count.sql` (upper left).

	![](images/200/i28.png)

- Disconnect from the EURO connection to avoid a potential read consistency error.

	![](images/200/i30.png)

- Select the EURO Connection:

	![](images/200/i29.png)

- Run the script.  Note the data is identical.  Your totals may differ from the screenshot, but the source and target should be the same.

	![](images/200/i31.png)

- Run simulated transactions.
	- **Open the gentrans.sql file**:

	![](images/200/i32.png)

- Be sure to select the ***EURO*** connection and then execute it.  

	![](images/200/i33.png)

- Enter 500 as the number of transactions to generate.

	![](images/200/i34.png)

	![](images/200/i35.png)

### **STEP 7**: Configure GGCS (Cloud/Target)

Note this is:
- Using our GGCS Service (which also runs on Compute) paired with a DBCS for both GGCS metadata and target data
- Our target data configuration for 12c Pluggable Database (schema amer)
- Uses GGCS (not on-premise OGG) with Integrated Replicat

- Double click on the `GGCS_SSH` shortcut on your dekstop and open a terminal window on the OGG Compute image and ssh to GGCS.
	- **Switch to user oracle:** `sudo su - oracle`
	- **Change to GGHOME:** `cd $GGHOME` (not shown below)
	- **Start a gg command shell:** `ggsci`

	![](images/200/i36.png)

- View parameter CREDENTIALSTORE.oby
	- **Enter the following:** `view param dirprm/CREDENTIALSTORE.oby` (note the addition of user and passwords for the admin schema and the amer and dw data schemas)

	![](images/200/i37.png)

- Add CREDENTIALSTORE
	- **Enter the following:** `obey dirprm/CREDENTIALSTORE.oby`

	![](images/200/i38.png)

- View Replicat	RAMER
	- **Enter the following:** `view param dirprm/RAMER.prm`

	![](images/200/i38.1.png)

- View add Replicat	configuration.
	- **Enter the following:** `view param dirprm/ADD_AMER_REPLICAT.oby`

	![](images/200/i39.png)

- Add Replicat:
	- **Enter the following:** `obey dirprm/ADD_AMER_REPLICAT.oby`

	![](images/200/i40.png)

- start Replicat:
	- **Enter the following:** `info all`
	- **Start replicat:** `start RAMER`
	- **Review processes:** `info all`

	![](images/200/i41.png)

- Compare data (remember that after we used datapump to migrate the base tables we generated an additional 500 transactions).  Go back to SQLDeveloper and open the `get_count.sql` script, select the EURO Connection, and then run the script:

	![](images/200/i42.png)

	![](images/200/i43.png)
