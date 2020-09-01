# How to Upgrade a Database 

[//]: # (Author: David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:

1.	An installed RDBMS workingcopy
2.	An existing running healthy DB

## Overview:

1.	Import new image
2.	Query new image
3.	Confirmation Checks
	- srvctl
	- SQL

### Step 1 – Pre-check for Upgrade
	$ rhpctl upgrade database -sourcewc DB12102_191015_pq2_WC_WC_fppc2 -destwc DB194_190716_WC_WC_fppc2 -dbname db4ug2 -eval

### Step 2 – Upgrade Database
	$ rhpctl upgrade database -sourcewc DB12102_191015_pq2_WC_WC_fppc2 -destwc DB194_190716_WC_WC_fppc2 -dbname db4ug2

### Step 3 – Checks
	srvctl status database -d db4ug2 -verbose
	
	srvctl config database -db db4ug2 -verbose
	
	select instance_name, version, status from v$instance;

## Example output:

This example will upgrade the previously created 12.1 database to 19.4 on the same cluster.  And as a the best practice, we start with an `-eval` review before starting.

	[exagrid@fpp-server-n01 ~]$ rhpctl upgrade database -sourcewc DB12102_191015_pq2_WC_WC_fppc2 -destwc DB194_190716_WC_WC_fppc2 -dbname db4ug2 -eval
	Sun May 10 00:49:05 PDT 2020
	fpp-server-n01: Audit ID: 186
	fpp-server-n01: Evaluation in progress for "upgrade database" ...
	fpp-server-n01: verifying versions of Oracle homes ...
	fpp-server-n01: verifying owners of Oracle homes ...
	fpp-server-n01: verifying groups of Oracle homes ...
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: initiating check for the upgrade database operation on client cluster
	fpp-server-n01: completed the check for the source and destination Oracle Homes on client cluster
	fpp-server-n01: Processing arguments file /opt/oracrs/gridbase/crsdata/fpp-server-n01/rhp/conf/rhp.pref
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: Starting to upgrade database from "/u01/app/oracle/product/12.1.0.2/racdb12.1.0.2.191015_pq2" to "/u01/app/oracle/product/19.4/racdb194.190716" on client cluster
	fpp-server-n01: Evaluation finished successfully for "upgrade database". 

Looks good, now to actually complete the upgrade.

	[exagrid@fpp-server-n01 ~]$ rhpctl upgrade database -sourcewc DB12102_191015_pq2_WC_WC_fppc2 -destwc DB194_190716_WC_WC_fppc2 -dbname db4ug2
	fpp-server-n01: Audit ID: 188
	fpp-server-n01: verifying versions of Oracle homes ...
	fpp-server-n01: verifying owners of Oracle homes ...
	fpp-server-n01: verifying groups of Oracle homes ...
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: initiating check for the upgrade database operation on client cluster
	fpp-server-n01: completed the check for the source and destination Oracle Homes on client cluster
	fpp-server-n01: Processing arguments file /opt/oracrs/gridbase/crsdata/fpp-server-n01/rhp/conf/rhp.pref
	fpp-server-n01: Connecting to RHPC...
	fpp-server-n01: Starting to upgrade database from "/u01/app/oracle/product/12.1.0.2/racdb12.1.0.2.191015_pq2" to "/u01/app/oracle/product/19.4/racdb194.190716" on client cluster
	fpp-client2-n01: Starting database upgrade on node fpp-client2-n01 ...
	========================================
	fpp-client2-n01:
	Logs directory:  /u01/app/oracle/cfgtoollogs/dbua/upgrade2020-05-11_01-31-16AM
	Performing Pre-Upgrade Checks...
	============================
	PRE- and POST- FIXUP ACTIONS
	=============================
	/u01/app/oracle/cfgtoollogs/dbua/upgrade2020-05-11_01-31-16AM/db4ug2/upgrade.xml
	/u01/app/oracle/cfgtoollogs/dbua/upgrade2020-05-11_01-31-16AM/db4ug2/preupgrade_fixups.sql
	/u01/app/oracle/cfgtoollogs/dbua/upgrade2020-05-11_01-31-16AM/db4ug2/postupgrade_fixups.sql
	Performing Pre-Upgrade Checks...
	============================
	PRE- and POST- FIXUP ACTIONS
	=============================
	/u01/app/oracle/cfgtoollogs/dbua/upgrade2020-05-11_01-31-16AM/db4ug2/upgrade.xml
	/u01/app/oracle/cfgtoollogs/dbua/upgrade2020-05-11_01-31-16AM/db4ug2/preupgrade_fixups.sql
	/u01/app/oracle/cfgtoollogs/dbua/upgrade2020-05-11_01-31-16AM/db4ug2/postupgrade_fixups.sql
	[WARNING] [DBT-20060] One or more of the pre-upgrade checks on the database have resulted into warning conditions that require manual intervention. It is recommended that you address these warnings as suggested before proceeding.
	   ACTION: Refer to the pre-upgrade results location for details: /u01/app/oracle/cfgtoollogs/dbua/upgrade2020-05-11_01-31-16AM/db4ug2
	2% complete
	14% complete
	<snip>
	74% complete
	85% complete
	100% complete
	Database upgrade has been completed successfully, and the database is ready to use.

Check if srvctl sees the database up and open.

	[oracle@fpp-client2-n01 db4ug2]$ srvctl status database -d db4ug2 -verbose
	Instance db4ug21 is running on node fpp-client2-n01. Instance status: Open.
	Instance db4ug22 is running on node fpp-client2-n02. Instance status: Open.

Check if it's running from the new destination home/workingcopy.

	[oracle@fpp-client2-n01 db4ug2]$ srvctl config database -d db4ug2 -verbose
	Database unique name: db4ug2
	Database name: db4ug2
	Oracle home: /u01/app/oracle/product/19.4/racdb194.190716
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

And a last sanity check by logging in via sqlplus and checking the status. 

These are intended as a brief example of some of the checks and validations possible as the FPP post upgrade procedure.  Please continue to follow your own standards for validation also.

	[oracle@fpp-client2-n01 db4ug2]$ sqlplus / as sysdba
	
	SQL*Plus: Release 19.0.0.0.0 - Production on Mon May 11 03:33:02 2020
	Version 19.4.0.0.0
	
	Copyright (c) 1982, 2019, Oracle.  All rights reserved.
	
	
	Connected to:
	Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
	Version 19.4.0.0.0
	
	
	SQL> select instance_name, version, status from v$instance;
	
	INSTANCE_NAME	 VERSION	   STATUS
	---------------- ----------------- ------------
	db4ug21 	 19.0.0.0.0	   OPEN




[//]: # (Author:David LaPoint david.lapoint@oracle.com)
