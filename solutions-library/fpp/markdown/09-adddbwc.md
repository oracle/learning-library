# How to Create (Add) Your First RDBMS Working Copy 

[//]: # (Author:David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:

1.	A saved RDBMS image of the already desired configuration

## Overview:

1.	Complete a pre-test eval of the add workingcopy
2.	Add the workingcopy of the RDBMS image
3.	Query new workingcopy

### Step 1 – Complete an eval
	$ rhpctl add workingcopy -workingcopy DB194_190716_WC_fppc2 -image DB194_190716 -client fpp-client2-cluster -path /u01/app/oracle/product/19.4/racdb194.190716 -oraclebase /u01/app/oracle -user oracle -groups "OSDBA=dba,OSOPER=racoper,OSBACKUP=dba,OSDG=dba,OSKM=dba" -eval

Please note here the usage of `-client`.  Remote operations against FPP clients generally use the same command as against the FPP server.  Only `-client` is needed to denote the remote target.   This command syntax with -eval is the same as the one that will be used to add the workingcopy.  Only `-eval` is needed be added to FPP commands to complete a pre-operation test of both the command syntax and the planned operation itself.  It is a best practice preform an eval in cases where significant operations are to be completed, for example add workingcopy, patching, upgrades, etc.

### Step 2 – Add RDBMS Workingcopy

	$ rhpctl add workingcopy -workingcopy DB194_190716_WC_fppc2 -image DB194_190716 -client fpp-client2-cluster -path /u01/app/oracle/product/19.4/racdb194.190716 -oraclebase /u01/app/oracle -user oracle -groups "OSDBA=dba,OSOPER=racoper,OSBACKUP=dba,OSDG=dba,OSKM=dba"

Please note here the command is the same as above with the exception of no -eval.  

### Step 3 – Query Your Workingcopy

Confirm *‘Complete:* TRUE’

	$ rhpctl query workingcopy -workingcopy DB194_190716_WC_fppc2

## Example output:

Do the eval first

	[exagrid@fpp-server-n01 ~]$ rhpctl add workingcopy -workingcopy DB194_190716_WC_fppc2 -image DB194_190716 -client fpp-client2-cluster -path /u01/app/oracle/product/19.4/racdb194.190716 -oraclebase /u01/app/oracle -user oracle -groups "OSDBA=dba,OSOPER=racoper,OSBACKUP=dba,OSDG=dba,OSKM=dba" -eval 
	fpp-server-n01: Audit ID: 108
	fpp-server-n01: Evaluation in progress for "add workingcopy" ...
	fpp-server-n01: Option storagetype is set to the following default value: LOCAL.
	fpp-server-n01: Adding storage for working copy ...
	fpp-server-n01: Evaluation finished successfully for "add workingcopy".

Actual add workingcopy operation
 
	[exagrid@fpp-server-n01 ~]$ rhpctl add workingcopy -workingcopy DB194_190716_WC_fppc2 -image DB194_190716 -client fpp-client2-cluster -path /u01/app/oracle/product/19.4/racdb194.190716 -oraclebase /u01/app/oracle -user oracle -groups "OSDBA=dba,OSOPER=racoper,OSBACKUP=dba,OSDG=dba,OSKM=dba"
	fpp-server-n01: Audit ID: 109
	fpp-server-n01: Option storagetype is set to the following default value: LOCAL.
	fpp-server-n01: Adding storage for working copy ...
	fpp-server-n01: Storing metadata in repository for working copy "DB194_190716_WC_fppc2" ...
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: Starting client-side action for 'add workingcopy'...
	fpp-client2-n01: Starting transfer for remote copy ...
	fpp-client2-n01: Provisioning Oracle home...
	fpp-client2-n01: Changing the home ownership to user oracle and group oinstall...
	fpp-client2-n01: Starting clone operation...
	fpp-client2-n01: [INFO] [INS-32183] Use of clone.pl is deprecated in this release. Clone operation is equivalent to performing a Software Only installation from the image.
	You must use /u01/app/oracle/product/19.4/racdb194.190716/runInstaller script available to perform the Software Only install. For more details on image based installation, refer to help documentation.
	fpp-client2-n01: [INFO] [INS-32183] Use of clone.pl is deprecated in this release. Clone operation is equivalent to performing a Software Only installation from the image.
	You must use /u01/app/oracle/product/19.4/racdb194.190716/runInstaller script available to perform the Software Only install. For more details on image based installation, refer to help documentation.
	
	Starting Oracle Universal Installer...
	fpp-client2-n01: Starting Oracle Universal Installer...
	fpp-client2-n01: You can find the log of this install session at:
	 /u01/app/oraInventory/logs/cloneActions2020-05-06_02-02-01AM.log
	fpp-client2-n01: You can find the log of this install session at:
	 /u01/app/oraInventory/logs/cloneActions2020-05-06_02-02-01AM.log
	fpp-client2-n01: ..................................................   5% Done.
	..................................................   10% Done.
	..................................................   15% Done.
	..................................................   20% Done.
	..................................................   25% Done.
	..................................................   30% Done.
	..................................................   35% Done.
	..................................................   40% Done.
	..................................................   45% Done.
	..................................................   50% Done.
	..................................................   55% Done.
	..................................................   60% Done.
	..................................................   65% Done.
	..................................................   70% Done.
	..................................................   75% Done.
	..................................................   80% Done.
	fpp-client2-n01: ..................................................   85% Done.
	fpp-client2-n01: ..........
	Copy files in progress.
	fpp-client2-n01: ..................................................   5% Done.
	..................................................   10% Done.
	..................................................   15% Done.
	..................................................   20% Done.
	..................................................   25% Done.
	..................................................   30% Done.
	..................................................   35% Done.
	..................................................   40% Done.
	..................................................   45% Done.
	..................................................   50% Done.
	..................................................   55% Done.
	..................................................   60% Done.
	..................................................   65% Done.
	..................................................   70% Done.
	..................................................   75% Done.
	..................................................   80% Done.
	fpp-client2-n01: ..................................................   85% Done.
	fpp-client2-n01: ..........
	Copy files in progress.
	fpp-client2-n01: Copy files successful.
	
	Link binaries in progress.
	fpp-client2-n01: Copy files successful.
	
	Link binaries in progress.
	fpp-client2-n01: ..........
	Link binaries successful.
	
	Setup files in progress.
	..........
	Setup files successful.
	
	Setup Inventory in progress.
	fpp-client2-n01: Setup Inventory successful.
	fpp-client2-n01: ..........
	Finish Setup successful.
	The cloning of DB194_190716_WC_fppc2 was successful.
	Please check '/u01/app/oraInventory/logs/cloneActions2020-05-06_02-02-01AM.log' for more details.
	
	Setup Oracle Base in progress.
	
	Setup Oracle Base successful.
	..................................................   95% Done.
	
	As a root user, execute the following script(s):
		1. /u01/app/oracle/product/19.4/racdb194.190716/root.sh
	
	Execute /u01/app/oracle/product/19.4/racdb194.190716/root.sh on the following nodes:
	[fpp-client2-n01]
	
	
	..................................................   100% Done.
	fpp-client2-n01: ..........
	Link binaries successful.
	
	Setup files in progress.
	fpp-client2-n01: ..........
	Setup files successful.
	
	Setup Inventory in progress.
	fpp-client2-n01: Setup Inventory successful.
	..........
	Finish Setup successful.
	The cloning of DB194_190716_WC_fppc2 was successful.
	Please check '/u01/app/oraInventory/logs/cloneActions2020-05-06_02-02-01AM.log' for more details.
	
	Setup Oracle Base in progress.
	
	Setup Oracle Base successful.
	..................................................   95% Done.
	
	As a root user, execute the following script(s):
		1. /u01/app/oracle/product/19.4/racdb194.190716/root.sh
	
	Execute /u01/app/oracle/product/19.4/racdb194.190716/root.sh on the following nodes:
	[fpp-client2-n02]
	
	
	..................................................   100% Done.
	fpp-client2-n01: Successfully executed clone operation.
	fpp-client2-n01: Executing root script on nodes fpp-client2-n01,fpp-client2-n02.
	fpp-client2-n01: Successfully executed root script on nodes fpp-client2-n01,fpp-client2-n02.
	fpp-client2-n01: Working copy creation completed.
	fpp-client2-n01: Oracle home provisioned.
	fpp-server-n01: Client-side action completed.

See if the workingcopy exists

	[exagrid@fpp-server-n01 ~]$ rhpctl query workingcopy
	fpp-server-n01: Audit ID: 110
	Working copy name: GI195_191015_WC_fpps
	Working copy name: GI193tmp
	Working copy name: DB194_190716_WC_fppc2
	Working copy name: DB194_190716_WC_fpps
	Working copy name: DB12102_191015_WC_fpps

Check the configuration of the workingcopy and make sure *Complete* is 'TRUE'

	[exagrid@fpp-server-n01 ~]$ rhpctl query workingcopy -workingcopy DB194_190716_WC_fppc2
	fpp-server-n01: Audit ID: 111
	Working copy name: DB194_190716_WC_fppc2
	Image name: DB194_190716
	Groups configured in the working copy: OSDBA=dba,OSOPER=racoper,OSBACKUP=dba,OSDG=dba,OSKM=dba,OSRAC=dba
	Owner: oracle@fpp-client2-cluster
	Site: fpp-client2-cluster
	Access control: USER:oracle@fpp-client2-cluster
	Access control: USER:exagrid@fpp-server-cluster
	Access control: ROLE:GH_WC_ADMIN
	Software home path: /u01/app/oracle/product/19.4/racdb194.190716
	Storage type: LOCAL
	Image Type: ORACLEDBSOFTWARE
	Gold image path:
	Work path:
	Oracle base: /u01/app/oracle
	Configured databases:
	All patches available in this home: 29834717,29850993
	Additional patches compared to the image:
	Additional bug fixes that are not in the image:
	Complete: TRUE



[//]: # (Author: David LaPoint david.lapoint@oracle.com)

