# How to Patch (Move) DB to the Next RU (Release Update) 

[//]: # (Author: David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:

In this case we will patching a 19.4 database to the 19.5 RU and using the optional manual node order (batches) the automatic rolling patching node sequence.

1.	A deployed RDBMS workingcopy (home) of the desired target patch level.  Must be the same major release as source home/database.

## Overview:

1.	Run a pre-check (-eval) of the patching (move database) operation.
2.	Move (patch) your database using the -batches option
a.	Move. Use the -continue option to continue the batch operation 
3.	Post checks
a.	Srvctl checks of database
b.	Query destination workingcopy to confirm

### Step 1 – Pre-check of the DB move

	$ rhpctl move database -dbname db4ug2 -sourcewc DB194_190716_WC_WC_fppc2 -patchedwc DB195_191015_base_WC_WC_fppc2 -batches '(fpp-client2-n01),(fpp-client2-n02)' -eval 

Note the optional use of the -batches parameter to directly manage rolling patch order.  In this case, two batches of a single node each are used.  Any number of nodes can be included in a batch, as long as all nodes are accounted for.

### Step 2 – Move (patch) your database
	$ rhpctl move database -dbname db4ug2 -sourcewc DB194_190716_WC_WC_fppc2 -patchedwc DB195_191015_base_WC_WC_fppc2 -batches '(fpp-client2-n01),(fpp-client2-n02)'

	$ rhpctl move database -patchedwc DB195_191015_base_WC_WC_fppc2 -continue 

Note that when `-batches` is used, a `-continue` is required to move to the next set of nodes.

### Step 3 – Query workingcopy

	$ srvctl status database -d db4ug2 -verbose

	$ srvctl config database -d db4ug2

	$ rhpctl query workingcopy -workingcopy DB195_191015_base_WC_WC_fppc2

Confirm value of *‘Configured databases:’*.  Other checks can be performed as required. 

## Example output:

	[exagrid@fpp-server-n01 ~]$ rhpctl move database -dbname db4ug2 -sourcewc DB194_190716_WC_WC_fppc2 -patchedwc DB195_191015_base_WC_WC_fppc2  -batches '(fpp-client2-n01),(fpp-client2-n02)'
	Mon May 11 23:19:03 PDT 2020
	fpp-server-n01: Audit ID: 209
	fpp-server-n01: verifying versions of Oracle homes ...
	fpp-server-n01: verifying owners of Oracle homes ...
	fpp-server-n01: verifying groups of Oracle homes ...
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: initiating check for whether the source and destination Oracle Homes are both shared or both non-shared for the 'move database' operation on client cluster
	fpp-server-n01: completed the check for the source and destination Oracle Homes on client cluster
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: Starting to move database from "/u01/app/oracle/product/19.4/racdb194.190716" to "/u01/app/oracle/product/19.4/racdb195.191015_base" on client cluster
	fpp-client2-n02: moving databases: "db4ug2" on nodes: "fpp-client2-n01"
	fpp-client2-n02: retrieving status of databases "db4ug2"...
	fpp-client2-n02: copying database configuration files from Oracle home "/u01/app/oracle/product/19.4/racdb194.190716" to Oracle home "/u01/app/oracle/product/19.4/racdb195.191015_base" ...
	fpp-client2-n02: retrieving status of services of databases "db4ug2" ...
	fpp-client2-n02: relocating services of databases "db4ug2" ...
	fpp-client2-n02: stopping services of databases "db4ug2" ...
	fpp-client2-n02: stopping instances of databases "db4ug2" ...
	fpp-client2-n02: starting instances of databases "db4ug2" ...
	fpp-client2-n02: Continue by running 'rhpctl move database -patchedwc DB195_191015_base_WC_WC_fppc2 -continue'
	fpp-server-n01: Completed the 'move database' operation on client cluster
	Databases moved from Oracle home "/u01/app/oracle/product/19.4/racdb194.190716" to Oracle home "/u01/app/oracle/product/19.4/racdb195.191015_base" : "db4ug2"

And here is where `-continue` is used to move to the next batch.

	[exagrid@fpp-server-n01 ~]$ rhpctl move database -patchedwc DB195_191015_base_WC_WC_fppc2 -continue
	fpp-server-n01: Audit ID: 210
	fpp-server-n01: Connecting to RHPC...
	fpp-client2-n02: moving databases: "db4ug2" on nodes: "fpp-client2-n02"
	fpp-client2-n02: retrieving status of databases "db4ug2"...
	fpp-client2-n02: copying database configuration files from Oracle home "/u01/app/oracle/product/19.4/racdb194.190716" to Oracle home "/u01/app/oracle/product/19.4/racdb195.191015_base" ...
	fpp-client2-n02: retrieving status of services of databases "db4ug2" ...
	fpp-client2-n02: relocating services of databases "db4ug2" ...
	fpp-client2-n02: stopping services of databases "db4ug2" ...
	fpp-client2-n02: stopping instances of databases "db4ug2" ...
	fpp-client2-n02: starting instances of databases "db4ug2" ...
	========================================
	fpp-client2-n02:
	CRS-5051: Executing script rhpmovedb
	/u01/app/oracle/product/19.4/racdb195.191015_base
	
	db4ug21
	SQL Patching tool version 19.5.0.0.0 Production on Tue May 12 01:33:29 2020
	Copyright (c) 2012, 2019, Oracle.  All rights reserved.
	
	Log file for this invocation: /u01/app/oracle/cfgtoollogs/sqlpatch/sqlpatch_363746_2020_05_12_01_33_29/sqlpatch_invocation.log
	
	Connecting to database...OK
	Gathering database info...done
	Bootstrapping registry and package to current versions...done
	Determining current state...done
	
	Current state of interim SQL patches:
	  No interim patches found
	
	Current state of release update SQL patches:
	  Binary registry:
	    19.5.0.0.0 Release_Update 190909180549: Installed
	  SQL registry:
	    Applied 19.4.0.0.0 Release_Update 190626171128 successfully on 11-MAY-20 02.45.47.386627 AM
	
	Adding patches to installation queue and performing prereq checks...done
	Installation queue:
	  No interim patches need to be rolled back
	  Patch 30125133 (Database Release Update : 19.5.0.0.191015 (30125133)):
	    Apply from 19.4.0.0.0 Release_Update 190626171128 to 19.5.0.0.0 Release_Update 190909180549
	No interim patches need to be applied
	
	Installing patches...
	Patch installation complete.  Total patches installed: 1
	
	Validating logfiles...done
	Patch 30125133 apply: SUCCESS
	  logfile: /u01/app/oracle/cfgtoollogs/sqlpatch/30125133/23151502/30125133_apply_DB4UG2_2020May12_01_33_57.log (no errors)
	SQL Patching tool complete on Tue May 12 01:36:26 2020
	fpp-client2-n02: Completed the 'move database' operation on client cluster
	Databases moved from Oracle home "/u01/app/oracle/product/19.4/racdb194.190716" to Oracle home "/u01/app/oracle/product/19.4/racdb195.191015_base" : "db4ug2"

And a couple of validation checks.  You can include your own, these are intended to be more specific to FPP.

First, is the moved database running and open on all nodes.

	[oracle@fpp-client2-n01 ~]$ srvctl status database -d db4ug2 -verbose
	Instance db4ug21 is running on node fpp-client2-n01. Instance status: Open.
	Instance db4ug22 is running on node fpp-client2-n02. Instance status: Open.
	
Does the srvctl configure database show the new correct home.
	
	[oracle@fpp-client2-n01 ~]$ srvctl config database -d db4ug2
	Database unique name: db4ug2
	Database name: db4ug2
	Oracle home: /u01/app/oracle/product/19.4/racdb195.191015_base
	Oracle user: oracle
	Spfile: +DATAC1/DB4UG2/PARAMETERFILE/spfiledb4ug2.ora
	Password file: +DATAC1/DB4UG2/PASSWORD/pwddb4ug2.799.1039915097
	Domain:
	Start options: open
	Stop options: immediate
	Database role: PRIMARY
	Management policy: AUTOMATIC
	Server pools:
	Disk Groups: DATAC1
	Mount point paths:
	Services:
	Type: RAC
	Start concurrency:
	Stop concurrency:
	OSDBA group: dba
	OSOPER group: racoper
	Database instances: db4ug21,db4ug22
	Configured nodes: fpp-client2-n01,fpp-client2-n02
	CSS critical: no
	CPU count: 0
	Memory target: 0
	Maximum memory: 0
	Default network number for database services:
	Database is administrator managed	
	
Does the patched/moved database show up in the destination workingcopy - *'Configured databases'*.
	
	[exagrid@fpp-server-n01 ~]$ rhpctl query workingcopy -workingcopy DB195_191015_base_WC_WC_fppc2
	fpp-server-n01: Audit ID: 211
	Working copy name: DB195_191015_base_WC_WC_fppc2
	Image name: DB195_191015_base
	Groups configured in the working copy: OSDBA=dba,OSOPER=racoper,OSBACKUP=dba,OSDG=dba,OSKM=dba,OSRAC=dba
	Owner: oracle@fpp-client2-cluster
	Site: fpp-client2-cluster
	Access control: USER:oracle@fpp-client2-cluster
	Access control: USER:exagrid@fpp-server-cluster
	Access control: ROLE:GH_WC_ADMIN
	Software home path: /u01/app/oracle/product/19.4/racdb195.191015_base
	Storage type: LOCAL
	Image Type: ORACLEDBSOFTWARE
	Gold image path:
	Work path:
	Oracle base: /u01/app/oracle
	Configured databases: db4ug2
	All patches available in this home: 30125133,30122149
	Additional patches compared to the image:
	Additional bug fixes that are not in the image:
	Complete: TRUE

[//]: # (Author:David LaPoint david.lapoint@oracle.com)


