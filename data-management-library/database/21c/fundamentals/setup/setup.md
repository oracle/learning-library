# Setup 21C Environment

## Introduction
In this lab, you will run the scripts to setup the environment for the Oracle Database 21c workshop.

Estimated Lab Time: 15 minute

### Objectives

In this lab, you will:
* Define and test the connections
* Download scripts
* Update scripts

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Working knowledge of vi
* Lab: SSH Keys
* Lab: Create a VCN
* Lab: Create an OCI VM Database

## **STEP 1**: Define and test the connections

1. Verify that your Oracle Database 21c `CDB21` and `PDB21` are created.

```
ps -ef|grep smon
sqlplus / as sysdba
```
```
show pdbs
```

2. Ensure that the TNS alias have been created for both cdb21 and pdb21 in the tnsnames.ora file. If they are not there then you will need to add them. The file is located in `/u01/app/oracle/homes/OraDB21000_home1/network/admin/tnsnames.ora`

	```
	<copy>
	cat /u01/app/oracle/homes/OraDB21000_home1/network/admin/tnsnames.ora
	</copy>
	```

4. Create an alias entry by copying the CDB alias entry, replace the CDB alias name with your PDB name, and the CDB service name with your PDB service name.  Use vi to do this.

	````
	<copy>
	vi cat /u01/app/oracle/homes/OraDB21000_home1/network/admin/tnsnames.ora
	</copy>
	````

5. Test the connection to CDB21.  Connect to CDB21 with SQL*Plus.

	````
	<copy>
	sqlplus sys@CDB21_iad1bw AS SYSDBA
	</copy>
	````

6. Verify that the container name is CDB$ROOT.

	````
	<copy>
	SHOW CON_NAME;
	</copy>
	````

7. Test the connection to PDB21

	````
	<copy>
	CONNECT sys@PDB21 AS SYSDBA
	</copy>
	````

8.  Show the container name

	````
	<copy>
	SHOW CON_NAME;
	</copy>
	````

9. Exit SQL*Plus

	````
	<copy>
	exit
	</copy>
	````

## **STEP 2**: Download scripts

Download the Cloud\_21c\_labs.zip file to the /home/oracle directory from Oracle Cloud object storage and unzip the file.

1.  Change to the oracle user home directory

	````
	<copy>
	cd /home/oracle
	wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/cM3vILBs5jcFJ0f8F6DSYAJGvEIlg7tl-8KFhXWCdlcWMPSsiLuoMN7fwApUteG1/n/c4u03/b/data-management-library-files/o/Cloud_21c_labs.zip
	</copy>
	````

2.  Unzip Cloud\_21c\_labs.zip

	```
	<copy>
	unzip Cloud_21c_labs.zip
	</copy>
	```

## **STEP 3**: Update the scripts to the current environment

Execute the /home/oracle/labs/update\_pass.sh shell script. The shell script prompts you to enter the password\_defined\_during\_DBSystem\_creation and sets it in all shell scripts and SQL scripts that will be used in the practices.

1. Make the script readable, writable, and executable by everyone.

	```
	<copy>
	chmod 777 /home/oracle/labs/update_pass.sh
	</copy>
	```

2. Run the script.

	```
	<copy>
	/home/oracle/labs/update_pass.sh
	</copy>
	```

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  Kay Malcolm, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
