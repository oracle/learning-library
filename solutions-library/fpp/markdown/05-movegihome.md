# How to patch your GI to use your new GI home (Move GIHome)

[//]: # (Author: David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:

1.	An already installed GI workingcopy of the desired configuration

## Overview:

1.	Test GI patching (move) with rhpctl -eval
2.	Move from old GI home to new GI workingcopy
3.	Validate move

### Step 1 – Evaluate GI Move

	$ rhpctl move gihome -sourcehome /u01/app/19.4.0/grid -destwc GI195_191015_WC_fppc4 -eval

Please note the use of `-eval` to test or evaluate the GI home patching.  It is appended to the command expected to be used.  Another note is the use of `-sourcehome` in this case.  `-soucehome` is used when moving from a what is termed an “unmanagged” home, in other words a non-FPP workingcopy home.  With a managed home or workingcopy, `-sourcewc` would be used.  

	$ rhpctl move gihome -sourcehome /u01/app/19.4.0/grid -destwc GI195_191015_WC_fppc4 -ignorewcpatches -eval

In this example we will also be using `-ignorewcpatches` as will be explained in the example output.  The use of a new/different parameter should always be tested with `-eval` too.

### Step 2 – Move GI to New Patched Home/Workingcopy

	$ rhpctl move gihome -sourcehome /u01/app/19.4.0/grid -destwc GI195_191015_WC_fppc4 -ignorewcpatches 

### Step 3 – Validate GI Move

	$ rhpctl query workingcopy -workingcopy GI195_191015_WC_fppc4 

Query the destination workingcopy to confirm that the move is complete – “Software only: false”. Incomplete moves or inactive GI workingcopies will show the workingcopy as “Software only: true”.

## Example output:

This example is non-typical, but it is used to show two different potential states and their resolutions.  The first is the ‘failure’ of the `-eval` requiring the use of a new parameter in the RHPCTL command and the subsequent re-evaluation.  

During the first evaluation it was discovered that the destination workingcopy had one bug fix less than the source home.  In this case, the bug fix was determined to be a regression and needed to be removed.  To override the missing bug fix, `-ignorewcpatches` is used along with a new evaluation to confirm.

The second state is an environment failure which is uncatchable outside of runtime execution.  In this scenario it was a password failure in the CHA SQL patching step.  After the issue was fixed, the move is restarted/resumed by running the same RHPCTL command again.  FPP is resumable and will pick up where the process last stopped.  

 
####  First move attempt and `-eval` example

Query working copy shows *'Software only:'* as true, meaning that the home is not an active GI.

	[exagrid@fpp-server-n01 ~]$ rhpctl query workingcopy -workingcopy GI195_191015_WC_fppc4
	fpp-server-n01: Audit ID: 226
	Working copy name: GI195_191015_WC_fppc4
	Image name: GI195_191015
	Groups configured in the working copy: OSDBA=asmdba,OSOPER=asmoper,OSASM=asmadmin
	Owner: grid@fpp-client1-cluster
	Site: fpp-client1-cluster
	Access control: USER:grid@fpp-client1-cluster
	Access control: USER:exagrid@fpp-server-cluster
	Access control: ROLE:GH_WC_ADMIN
	Software home path: /u01/app/19.5.0/grid
	Storage type: LOCAL
	Image Type: ORACLEGISOFTWARE
	Software only: true
	Gold image path:
	Work path:
	Cluster Name: fpp-client1-cluster
	Cluster Type:
	Cluster Mode:
	Cluster Class:
	Cluster Nodes: fpp-client1-n01,fpp-client1-n02
	All patches available in this home: 30368482,30363621,30585645,30312546,30125133,30122149,29401763
	Additional patches compared to the image:
	Additional bug fixes that are not in the image:
	Complete: TRUE

The first move attempt showing that the pre-checks found an issue.
	
	[exagrid@fpp-server-n01 ~]$ rhpctl move gihome -sourcehome /u01/app/19.4.0/grid -destwc GI195_191015_WC_fppc4 
	Wed May 13 16:34:15 PDT 2020
	fpp-server-n01: Audit ID: 227
	fpp-server-n01: Evaluation in progress for "move gihome" ...
	fpp-server-n01: verifying versions of Oracle homes ...
	fpp-server-n01: verifying owners of Oracle homes ...
	fpp-server-n01: verifying groups of Oracle homes ...
	fpp-server-n01: PRGO-1774 : The evaluation revealed potential failure for command "move gihome".
	PRGO-1691 : The move operation was rejected because the patched working copy "GI195_191015_WC_fppc4" is missing the patches for bug number "29437379" which are present in the source Oracle home "/u01/app/19.4.0/grid". 

Adding `ignorewcpatches` and running again, but this time with `-eval` to confirm no further issues.  It is a best practice to use `-eval` for all patch and upgrade operations before actual runtime.
	
	[exagrid@fpp-server-n01 ~]$ rhpctl move gihome -sourcehome /u01/app/19.4.0/grid -destwc GI195_191015_WC_fppc4 -ignorewcpatches -eval 
	Wed May 13 17:07:35 PDT 2020
	fpp-server-n01: Audit ID: 228
	fpp-server-n01: Evaluation in progress for "move gihome" ...
	fpp-server-n01: verifying versions of Oracle homes ...
	fpp-server-n01: verifying owners of Oracle homes ...
	fpp-server-n01: verifying groups of Oracle homes ...
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: initiating sharedness check for the 'move gihome' operation on client cluster
	fpp-server-n01: completed the sharedness check for the source and destination Oracle home on client cluster
	fpp-server-n01: Evaluation finished successfully for "move gihome".
	
#### Actual move operation	using `-ignorewcpatches`
	
	[exagrid@fpp-server-n01 ~]$ rhpctl move gihome -sourcehome /u01/app/19.4.0/grid -destwc GI195_191015_WC_fppc4 -ignorewcpatches 
	fpp-server-n01: Audit ID: 229
	fpp-server-n01: verifying versions of Oracle homes ...
	fpp-server-n01: verifying owners of Oracle homes ...
	fpp-server-n01: verifying groups of Oracle homes ...
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: initiating sharedness check for the 'move gihome' operation on client cluster
	fpp-server-n01: completed the sharedness check for the source and destination Oracle home on client cluster
	fpp-server-n01: Connecting to RHPC...
	fpp-client1-n02: retrieving status of databases ...
	fpp-client1-n02: retrieving status of services of databases ...
	fpp-client1-n02: relocating services of databases ...
	fpp-client1-n02: stopping services of databases ...
	fpp-client1-n02: stopping instances of databases ...
	fpp-client1-n02: Executing prepatch and postpatch on nodes: "fpp-client1-n02".
	fpp-client1-n02: Executing root script on nodes [fpp-client1-n02].
	fpp-client1-n02: Successfully executed root script on nodes [fpp-client1-n02].
	fpp-client1-n02: Executing root script on nodes [fpp-client1-n02].
	Using configuration parameter file: /u01/app/19.5.0/grid/crs/install/crsconfig_params
	The log of current session can be found at:
	  /u01/app/grid/crsdata/fpp-client1-n02/crsconfig/crs_postpatch_fpp-client1-n02_2020-05-13_05-17-18PM.log
	Oracle Clusterware active version on the cluster is [19.0.0.0.0]. The cluster upgrade state is [NORMAL]. The cluster active patch level is [3529020505].
	2020/05/13 17:18:37 CLSRSC-329: Replacing Clusterware entries in file 'oracle-ohasd.service'
	Oracle Clusterware active version on the cluster is [19.0.0.0.0]. The cluster upgrade state is [ROLLING PATCH]. The cluster active patch level is [3529020505].
	2020/05/13 17:21:12 CLSRSC-4015: Performing install or upgrade action for Oracle Trace File Analyzer (TFA) Collector.
	2020/05/13 17:21:13 CLSRSC-672: Post-patch steps for patching GI home successfully completed.
	2020/05/13 17:21:54 CLSRSC-4003: Successfully patched Oracle Trace File Analyzer (TFA) Collector.
	fpp-client1-n02: Updating inventory on nodes: fpp-client1-n02.
	========================================
	fpp-client1-n02:
	Starting Oracle Universal Installer...
	
	Checking swap space: must be greater than 500 MB.   Actual 24575 MB    Passed
	The inventory pointer is located at /etc/oraInst.loc
	You can find the log of this install session at:
	 /u01/app/oraInventory/logs/UpdateNodeList2020-05-13_05-23-45PM.log
	'UpdateNodeList' was successful.
	fpp-client1-n02: Updated inventory on nodes: fpp-client1-n02.
	fpp-client1-n02: Updating inventory on nodes: fpp-client1-n02.
	========================================
	fpp-client1-n02:
	Starting Oracle Universal Installer...
	
	Checking swap space: must be greater than 500 MB.   Actual 24575 MB    Passed
	The inventory pointer is located at /etc/oraInst.loc
	You can find the log of this install session at:
	 /u01/app/oraInventory/logs/UpdateNodeList2020-05-13_05-23-50PM.log
	'UpdateNodeList' was successful.
	fpp-client1-n02: Updated inventory on nodes: fpp-client1-n02.
	fpp-client1-n02: retrieving status of databases ...
	fpp-client1-n02: retrieving status of services of databases ...
	fpp-client1-n02: relocating services of databases ...
	fpp-client1-n02: stopping services of databases ...
	fpp-client1-n02: stopping instances of databases ...
	fpp-client1-n02: Executing prepatch and postpatch on nodes: "fpp-client1-n01".
	fpp-client1-n02: Executing root script on nodes [fpp-client1-n01].
	fpp-client1-n02: Successfully executed root script on nodes [fpp-client1-n01].
	fpp-client1-n02: Executing root script on nodes [fpp-client1-n01].
	Using configuration parameter file: /u01/app/19.5.0/grid/crs/install/crsconfig_params
	The log of current session can be found at:
	  /u01/app/grid/crsdata/fpp-client1-n01/crsconfig/crs_postpatch_fpp-client1-n01_2020-05-13_05-25-58PM.log
	Oracle Clusterware active version on the cluster is [19.0.0.0.0]. The cluster upgrade state is [ROLLING PATCH]. The cluster active patch level is [3529020505].
	2020/05/13 17:31:17 CLSRSC-329: Replacing Clusterware entries in file 'oracle-ohasd.service'
	Oracle Clusterware active version on the cluster is [19.0.0.0.0]. The cluster upgrade state is [NORMAL]. The cluster active patch level is [299791917].
	SQL Patching tool version 19.5.0.0.0 Production on Wed May 13 17:41:29 2020
	Copyright (c) 2012, 2019, Oracle.  All rights reserved.
	
	Log file for this invocation: /u01/app/grid/cfgtoollogs/sqlpatch/sqlpatch_84932_2020_05_13_17_41_29/sqlpatch_invocation.log
	
	Connecting to database...OK
	Gathering database info...done
	
	Note:  Datapatch will only apply or rollback SQL fixes for PDBs
	       that are in an open state, no patches will be applied to closed PDBs.
	       Please refer to Note: Datapatch: Database 12c Post Patch SQL Automation
	       (Doc ID 1585822.1)
	
	Bootstrapping registry and package to current versions...done
	Determining current state...done
	
	Current state of interim SQL patches:
	Interim patch 29774421 (OJVM RELEASE UPDATE: 19.4.0.0.190716 (29774421)):
	  Binary registry: Not installed
	  PDB CDB$ROOT: Applied successfully on 26-OCT-19 09.47.02.309321 AM
	  PDB GIMR_DSCREP_10: Applied successfully on 26-OCT-19 09.54.59.999643 AM
	  PDB PDB$SEED: Applied successfully on 26-OCT-19 09.54.59.999643 AM
	
	Current state of release update SQL patches:
	  Binary registry:
	    19.5.0.0.0 Release_Update 190909180549: Installed
	  PDB CDB$ROOT:
	    Applied 19.4.0.0.0 Release_Update 190626171128 successfully on 26-OCT-19 09.47.02.305924 AM
	  PDB GIMR_DSCREP_10:
	    Applied 19.4.0.0.0 Release_Update 190626171128 successfully on 26-OCT-19 09.54.59.996573 AM
	  PDB PDB$SEED:
	    Applied 19.4.0.0.0 Release_Update 190626171128 successfully on 26-OCT-19 09.54.59.996573 AM
	
	Adding patches to installation queue and performing prereq checks...done
	Installation queue:
	  For the following PDBs: CDB$ROOT PDB$SEED GIMR_DSCREP_10
	    The following interim patches will be rolled back:
	      29774421 (OJVM RELEASE UPDATE: 19.4.0.0.190716 (29774421))
	    Patch 30125133 (Database Release Update : 19.5.0.0.191015 (30125133)):
	      Apply from 19.4.0.0.0 Release_Update 190626171128 to 19.5.0.0.0 Release_Update 190909180549
	    No interim patches need to be applied
	
	Installing patches...
	Patch installation complete.  Total patches installed: 6
	
	Validating logfiles...done
	Patch 29774421 rollback (pdb CDB$ROOT): SUCCESS
	  logfile: /u01/app/grid/cfgtoollogs/sqlpatch/29774421/22965160/29774421_rollback__MGMTDB_CDBROOT_2020May13_17_42_19.log (no errors)
	Patch 30125133 apply (pdb CDB$ROOT): SUCCESS
	  logfile: /u01/app/grid/cfgtoollogs/sqlpatch/30125133/23151502/30125133_apply__MGMTDB_CDBROOT_2020May13_17_42_19.log (no errors)
	Patch 29774421 rollback (pdb PDB$SEED): SUCCESS
	  logfile: /u01/app/grid/cfgtoollogs/sqlpatch/29774421/22965160/29774421_rollback__MGMTDB_PDBSEED_2020May13_17_42_39.log (no errors)
	Patch 30125133 apply (pdb PDB$SEED): SUCCESS
	  logfile: /u01/app/grid/cfgtoollogs/sqlpatch/30125133/23151502/30125133_apply__MGMTDB_PDBSEED_2020May13_17_42_39.log (no errors)
	Patch 29774421 rollback (pdb GIMR_DSCREP_10): SUCCESS
	  logfile: /u01/app/grid/cfgtoollogs/sqlpatch/29774421/22965160/29774421_rollback__MGMTDB_GIMR_DSCREP_10_2020May13_17_42_38.log (no errors)
	Patch 30125133 apply (pdb GIMR_DSCREP_10): SUCCESS
	  logfile: /u01/app/grid/cfgtoollogs/sqlpatch/30125133/23151502/30125133_apply__MGMTDB_GIMR_DSCREP_10_2020May13_17_42_38.log (no errors)
	SQL Patching tool complete on Wed May 13 17:43:13 2020
	Calling datapatch
	
	SQL Patching tool version 19.5.0.0.0 Production on Wed May 13 17:43:22 2020
	
	Copyright (c) 2012, 2019, Oracle.  All rights reserved.
	
	
	
	Log file for this invocation: /u01/app/grid/cfgtoollogs/sqlpatch/sqlpatch_102989_2020_05_13_17_43_22/sqlpatch_invocation.log
	
	
	
	Connecting to database...OK
	
	Gathering database info...done
	
	
	
	Note:  Datapatch will only apply or rollback SQL fixes for PDBs
	
	       that are in an open state, no patches will be applied to closed PDBs.
	
	       Please refer to Note: Datapatch: Database 12c Post Patch SQL Automation
	
	       (Doc ID 1585822.1)
	
	
	
	Bootstrapping registry and package to current versions...done
	
	Determining current state...done
	
	
	
	Current state of interim SQL patches:
	
	  No interim patches found
	
	
	
	Current state of release update SQL patches:
	
	  Binary registry:
	
	    19.5.0.0.0 Release_Update 190909180549: Installed
	
	  PDB GIMR_DSCREP_10:
	
	    Applied 19.5.0.0.0 Release_Update 190909180549 successfully on 13-MAY-20 05.43.03.428712 PM
	
	
	
	Adding patches to installation queue and performing prereq checks...done
	
	Installation queue:
	
	  For the following PDBs: GIMR_DSCREP_10
	
	    No interim patches need to be rolled back
	
	    No release update patches need to be installed
	
	    No interim patches need to be applied
	
	
	
	SQL Patching tool complete on Wed May 13 17:43:55 2020
	
	Datapatch exits with code 0
	
	MGTCA-1173 : failed to deploy CHA models for the cluster with error
	
	CLSCH-3610 : An unexpected error occurred in Cluster Health Advisor control utility.
	
	2020/05/13 17:44:03 CLSRSC-180: An error occurred while executing the command '/u01/app/19.5.0/grid/bin/mgmtca applysql'
	Died at /u01/app/19.5.0/grid/crs/install/crspatch.pm line 2103.
	PRGH-1057 : failure during move of an Oracle Grid Infrastructure home
	PRCR-1200 : failed to execute the detached process

As can be seen above, there was an environmental failure.  Once it was corrected, and because FPP is designed to be resumable after interuptions, executing the move command again continued the operation until it successfully completed.
	
	[exagrid@fpp-server-n01 ~]$ rhpctl move gihome -sourcehome /u01/app/19.4.0/grid -destwc GI195_191015_WC_fppc4 -ignorewcpatches
	Thu May 14 17:55:15 PDT 2020
	fpp-server-n01: Audit ID: 234
	fpp-server-n01: Connecting to RHPC...
	fpp-client1-n02: Executing root script on nodes [fpp-client1-n01].
	Using configuration parameter file: /u01/app/19.5.0/grid/crs/install/crsconfig_params
	The log of current session can be found at:
	  /u01/app/grid/crsdata/fpp-client1-n01/crsconfig/crs_postpatch_fpp-client1-n01_2020-05-14_05-56-41PM.log
	Oracle Clusterware active version on the cluster is [19.0.0.0.0]. The cluster upgrade state is [NORMAL]. The cluster active patch level is [299791917].
	SQL Patching tool version 19.5.0.0.0 Production on Thu May 14 18:01:34 2020
	Copyright (c) 2012, 2019, Oracle.  All rights reserved.
	
	Log file for this invocation: /u01/app/grid/cfgtoollogs/sqlpatch/sqlpatch_343014_2020_05_14_18_01_34/sqlpatch_invocation.log
	
	Connecting to database...OK
	Gathering database info...done
	
	Note:  Datapatch will only apply or rollback SQL fixes for PDBs
	       that are in an open state, no patches will be applied to closed PDBs.
	       Please refer to Note: Datapatch: Database 12c Post Patch SQL Automation
	       (Doc ID 1585822.1)
	
	Bootstrapping registry and package to current versions...done
	Determining current state...done
	
	Current state of interim SQL patches:
	Interim patch 29774421 (OJVM RELEASE UPDATE: 19.4.0.0.190716 (29774421)):
	  Binary registry: Not installed
	  PDB CDB$ROOT: Rolled back successfully on 13-MAY-20 05.43.01.596843 PM
	  PDB GIMR_DSCREP_10: Rolled back successfully on 13-MAY-20 05.43.02.851295 PM
	  PDB PDB$SEED: Rolled back successfully on 13-MAY-20 05.43.02.213432 PM
	
	Current state of release update SQL patches:
	  Binary registry:
	    19.5.0.0.0 Release_Update 190909180549: Installed
	  PDB CDB$ROOT:
	    Applied 19.5.0.0.0 Release_Update 190909180549 successfully on 13-MAY-20 05.43.02.193373 PM
	  PDB GIMR_DSCREP_10:
	    Applied 19.5.0.0.0 Release_Update 190909180549 successfully on 13-MAY-20 05.43.03.428712 PM
	  PDB PDB$SEED:
	    Applied 19.5.0.0.0 Release_Update 190909180549 successfully on 13-MAY-20 05.43.02.834441 PM
	
	Adding patches to installation queue and performing prereq checks...done
	Installation queue:
	  For the following PDBs: CDB$ROOT PDB$SEED GIMR_DSCREP_10
	    No release update patches need to be installed
	    No interim patches need to be rolled back
	    No interim patches need to be applied
	SQL Patching tool complete on Thu May 14 18:02:19 2020
	
	2020/05/14 18:03:21 CLSRSC-4015: Performing install or upgrade action for Oracle Trace File Analyzer (TFA) Collector.
	2020/05/14 18:03:33 CLSRSC-672: Post-patch steps for patching GI home successfully completed.
	2020/05/14 18:04:03 CLSRSC-4003: Successfully patched Oracle Trace File Analyzer (TFA) Collector.
	fpp-client1-n02: Successfully executed root script on nodes [fpp-client1-n01].
	fpp-client1-n02: starting instances of databases "dbm01_standby_fppc2,dbm02" ...
	fpp-client1-n02: Updating inventory on nodes: fpp-client1-n01.
	========================================
	fpp-client1-n02:
	Starting Oracle Universal Installer...
	
	Checking swap space: must be greater than 500 MB.   Actual 24575 MB    Passed
	The inventory pointer is located at /etc/oraInst.loc
	You can find the log of this install session at:
	 /u01/app/oraInventory/logs/UpdateNodeList2020-05-14_06-04-56PM.log
	'UpdateNodeList' was successful.
	fpp-client1-n02: Updated inventory on nodes: fpp-client1-n01.
	fpp-client1-n02: Updating inventory on nodes: fpp-client1-n01.
	fpp-client1-n02:
	========================================
	Starting Oracle Universal Installer...
	
	Checking swap space: must be greater than 500 MB.   Actual 24575 MB    Passed
	The inventory pointer is located at /etc/oraInst.loc
	You can find the log of this install session at:
	 /u01/app/oraInventory/logs/UpdateNodeList2020-05-14_06-05-02PM.log
	'UpdateNodeList' was successful.
	fpp-client1-n02: Updated inventory on nodes: fpp-client1-n01.
	fpp-client1-n02: completed the move of Oracle Grid Infrastructure home on client cluster "fpp-client1-cluster"
	fpp-client1-n02: Completed the 'move gihome' operation on cluster fpp-client1-cluster.
	
Another check of the workingcopy to see that *'Software only'* shows as 'false'.

	[exagrid@fpp-server-n01 ~]$ rhpctl query workingcopy -workingcopy GI195_191015_WC_fppc4
	fpp-server-n01: Audit ID: 235
	Working copy name: GI195_191015_WC_fppc4
	Image name: GI195_191015
	Groups configured in the working copy: OSDBA=asmdba,OSOPER=asmoper,OSASM=asmadmin
	Owner: grid@fpp-client1-cluster
	Site: fpp-client1-cluster
	Access control: USER:grid@fpp-client1-cluster
	Access control: USER:exagrid@fpp-server-cluster
	Access control: ROLE:GH_WC_ADMIN
	Software home path: /u01/app/19.5.0/grid
	Storage type: LOCAL
	Image Type: ORACLEGISOFTWARE
	Software only: false
	Gold image path:
	Work path:
	Cluster Name: fpp-client1-cluster
	Cluster Type: FLEX
	Cluster Mode: FLEX
	Cluster Class: STANDALONE
	Cluster Nodes: fpp-client1-n02,fpp-client1-n01
	All patches available in this home: 30368482,30363621,30585645,30312546,30125133,30122149,29401763
	Additional patches compared to the image:
	Additional bug fixes that are not in the image:
	Complete: TRUE
	


[//]: # (Author:David LaPoint david.lapoint@oracle.com)

