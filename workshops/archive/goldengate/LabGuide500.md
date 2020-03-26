![](images/500/lab500.png)

Update May 2, 2017

## Introduction

This is the fifth of five GoldenGate Cloud Service labs, and covers the second use case: Replication of data from a DBCS 12c multi-tenant Pluggable Database back to an on-premise 11g Database.  Note this lab is optional and can be skipped.

![](images/100/i3.png)

This workshop will walk you through replication of data from a DBCS 12c Pluggable database back to an 11g On-premise Database.  Note that the 11g Database used in this Workshop is running on compute and does not require a VPN (or dedicated) network, but in practice you would need a VPN (Corente or other) network connection to replicate data from the cloud to a customer database.

To log issues and view the lab guide source, go to the [github oracle](https://github.com/pcdavies/GoldenGateCloudService/issues) repository.

## Objectives

- Configure GGCS extract processes for data replication to 11g Database on-premise.
- Configure OGG replicat processes for data replication from DBCS 12c in the Cloud.
- Generate Transactions and view data movement statistics to monitor activity.

## Required Artifacts

- Access to your Oracle Cloud account (used in Lab 100 and Lab 200) and services DBCS, GGCS, and Compute.

### **STEP 1**: Reset Data from previous labs

- Open SQLDeveloper on the on-premise compute image and then open reset_data.sql file from the `\home\oracle\Desktop\GGCS_Workshop_Material\sql_scripts` folder:

	![](images/500/i1.2.png)
	
- Run the script.  Be sure to use the EURO connection:

	![](images/500/i1.3.png)

### **STEP 2**: Configure GoldenGate Cloud Service (GGCS)

- Double click on the GGCS_SSH shortcut on the OGG Compute image to ssh to GGCS and enter the following commands:
	- **Switch to user oracle:** `sudo su - oracle`
    - **Switch to GGHOME:** `cd $GGHOME`
	- **Start a gg command shell:** `ggsci`

	    ![](images/500/i1.png)

- Review AMER extract configuration:
    - **Enter the following:** `view param EAMER`  Read comments

	![](images/500/i1.1.png)

- Review add AMER extract configuration:
    - **Enter the following:** `view param dirprm/ADD_AMER_EXTRACT.oby`  Read comments

	![](images/500/i2.png)

- Add amer extract:
    - **Enter the following:** `obey dirprm/ADD_AMER_EXTRACT.oby`

	![](images/500/i3.png)

- Review the processes:
	- **Enter the following:** `info all`

	![](images/500/i4.png)

- Edit pump parameters and update the target IP address (field ***OG1***).  Also note/read other highlighted parameters.  **Note the use of linux 'vi' editor to update, which requires specific keys to navigate:**
	- **Enter the following:** `edit param PAMER`
	- **Use the arrow keys on your keyboard to navigate**
	- **To set insert mode:** `i to insert IP address (above keys no longer navigate), [ESC] to get out of insert mode`
	- **To delete characters:** `x`
	- **To save and exit:** `first :, then x`
	- **Optional - confirm your changes were made correctly:** `view param PAMER`

	![](images/500/i6.png)

- Start new extract process and confirm process are running. 
	- **Enter the following:** `start *`  This starts all processes
	- **Enter the following:** `info all` note you may need to wait a few seconds
	- **Confirm status:** `info all`
	- **! will repeat last command**

	![](images/500/i7.png)

### **STEP 3**: Configure Oracle GoldenGate (OGG) On-Premise (11g Database)

- Exit out of the current terminal window.  Enter exit at least twice to ensure you are NOT still in GGCS.  Open a NEW terminal window:
	- **Enter the following:** `cd $GGHOME`
	- **Start a new GG Command shell:** `./ggsci`

	![](images/500/i8.png)

- View pre-configured REPLICAT:
	- **Enter the following:** `view param dirprm/ADD_EURO_REPLICAT.oby`  Read comments.

	![](images/500/i9.png)

- Add new REPLICAT:
	- **Enter the following:** `obey ./dirprm/ADD_EURO_REPLICAT.oby`

	![](images/500/i10.png)

- Review processes, start manager, and start replicat, and confirm processes are running:
	- **Enter the following:** `info all`
	- **IF the manager is not running enter the following:** `start mgr`
	- **Start new Replicat REURO:** `start REURO`
	- **Confirm Lab 300 services are running:** `info all`

	![](images/500/i11.png)

### **STEP 4**: Generate Transactions and Review Results

- Open SQLDeveloper and open the sql file gentrans.sql using the amer connection:

	![](images/500/i12.png)

- Execute the script, enter 500 for the number of transactions:

	![](images/500/i13.png)

- Double click on the shortcut `GGCS_SSH` on the Desktop and position it on the left.
	- **Switch to user oracle:** `sudo su - oracle`
    - **Switch to GGHOME:** `cd $GGHOME`
	- **Start a gg command shell:** `ggsci`
	- **Enter:** `stats eamer total`

	![](images/500/i14.png)

- Double Click on the shortcut `Local Terminal` on your desktop for OGG (11g On Prem) and position it on the right.
	- **Change to gg home:** `cd $GGHOME`
	- **Start ggsci:** `ggsci`
	- **Enterz;z** `stats reuro total`

	![](images/500/i15.png)

- Compare stats for GGCS and OGG:

	![](images/500/i16.png)

- **LEAVE THESE TWO WINDOWS OPEN AND Return to SQLDeveloper and run get_count.sql

	![](images/500/i17.png)

- Execute script against EURO.  Note the row counts match proving replication.  Your totals may be different from the screenshots, but the source and target should match.

	![](images/500/i18.png)

- We will now replicate DDL (table definition changes and other SQL that creates objects, not just data inserts/updates/deletes).  Open file ddl.sql

	![](images/500/i19.png)

- Note the following and then run the script:
	- Note the tables do not yet exist in connection AMER.
	- Select AMER connection on the left.
	- Execute the script.

	![](images/500/i20.png)

- Note table CURRENCY has been created in AMER and user CURRENCY_ADMIN has also been created.

	![](images/500/i21.png)

	![](images/500/i22.png)

	![](images/500/i23.png)

- Compare with OGG/11g.  Note the new tables have been replicated (created) by GGCS:

	![](images/500/i24.png)

- Return to your OGG terminal window on the right and review stats:
	- **Enter the following:** `stats reuro` scroll back up after the command

	![](images/500/i25.png)

- Show DDL report	
	- **Enter the following:** `view report REURO001`.  Scroll up and down to view the entire report.

	![](images/500/i26.png)
