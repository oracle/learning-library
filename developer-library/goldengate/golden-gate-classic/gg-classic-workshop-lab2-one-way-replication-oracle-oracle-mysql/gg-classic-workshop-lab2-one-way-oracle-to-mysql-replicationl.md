#  Lab 2 -  OGG Environment Initial Setup

## Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ will
capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process
‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’

### Objectives
Replication from relational source to a relational target using GoldenGate


Time to Complete -
Approximately 60 minutes

## Done by Student:

Open a terminal session

![](./images/terminal2.png)

## STEPS-

1. Create the folder /u01/app/oracle/product/19.1.0/oggWallet
   a) > mkdir /u01/app/oracle/product/19.1.0/oggWallet

2. GLOBALS configuration
   a) In each $OGG_HOME directory, edit the file GLOBALS
      i. vi GLOBALS
   b) Set the GGSCHEMA parameter
      i. Oracle: ggschema pdbeast.ggadmin
	  ii. MySQL: ggschema ggadmin
   c) Set the CHECKPOINTTABLE parameter

MySQL

sudo service mysqld start

export OGG_HOME=/u01/app/oracle/product/19.1.0/oggmysql
dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@
ADD CHECKPOINTTABLE ggadmin.ggchkpoint
      i. MySQL: checkpointtable ggadmin.ggchkpoint
   d) Set the WALLETLOCATION parameter to the disk location in step 1.
      i. Oracle: WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet
	  ii. MySQL: WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet
   e)Save and close the files.

3. Start the GoldenGate Software Command Interpreter in both windows.

4. OGG Credential Store
   a) In GGSCI, create the OGG Credential Store by executing the command: 
      i. add credentialstore
   b) Add OGG database user credentials into each credential store.
      i. Oracle
	     1) alter credentialstore add user c##ggadmin@orcl password Oracle1 alias oggcapture
		 2) alter credentialstore add user ggadmin@pdbeast password Oracle1 alias ggapplyeast
		 3) alter credentialstore add user ggadmin@pdbwest password Oracle1 alias ggapplywest
       ii. MySQL
           1) alter credentialstore add user ggadmin password @Oracle1@ alias oggcapture
           2) alter credentialstore add user ggrep password @Oracle1@ alias ggapply

5. OGG Master Key and Wallet
   a) In the Oracle GGSCI, create the OGG Wallet.
      i. Command: CREATE WALLET 
 ____________________________________   
   b) Add the OGG Masterkey to the wallet.
      i. Oracle: add masterkey
   c) Verify the Master Key and Wallet from the MySQL GGSCI instance.
dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@
      i. MySQL: open wallet
	  ii. MySQL: info masterkey
      i. Oracle: open wallet
	  ii. Oracle: info masterkey

GGSCI (ogg-ggbd) 5> info masterkey
Masterkey Name: OGG_DEFAULT_MASTERKEY

Version         Creation Date                   Status
1               2020-09-10T15:22:28.000+00:00   Current
   
6. OGG Replicat Checkpoint Table
alter pluggable database PDBEAST open;
alter pluggable database PDBWEST open;

   a) In GGSCI, create the OGG Replicat Checkpoint Table by executing the commands:
      i. Oracle
	     1) Connect to the target database: dblogin useridalias ggapplywest
		 2) Create the table: add checkpointtable pdbwest.ggadmin.ggchkpoint
      ii. Mysql
	     1) Connect to the target database: dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias ggapply
		 2) Create the table: add checkpointtable	

7. OGG Heartbeat
   a) In GGSCI, create and activate OGG Integrated Heartbeat
      i. Oracle
         1) Connect to the PDBEAST tenant: dblogin useridalias ggapplyeast
         2) Create the heartbeat source: add heartbeattable		
         3) Connect to the PDBWEST tenant: dblogin useridalias ggapplywest
         4) Create the heartbeat target: add heartbeattable, targetonly
	  ii. MySQL
	      1) Connect to the ggadmin database: dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias oggcapture
          2) Create the heartbeat target: add heartbeattable, targetonly
		  
8. OGG Manager
   a) To configure the OGG Manager process in both the Oracle and MySQL OGG environments:
      i. Execute the GGSCI command: edit param mgr
	  ii. For Oracle, enter the following settings:
	      port 15000
          dynamicportlist 15001-15025
          purgeoldextracts ./dirdat/*, usecheckpoints, minkeepdays 1
          accessrule, prog server, ipaddr *, deny
          accessrule, prog mgr, ipaddr 127.0.0.1, pri 1, allow
          lagreportminutes 30
          laginfominutes 10
          lagcriticalminutes 20
          autorestart er *, RETRIES 12, WAITMINUTES 5, RESETMINUTES 60
          startupvalidationdelay 2
	  ii. For MySQL, enter the following settings:	
	      port 16000
          dynamicportlist 16001-16025
          purgeoldextracts ./dirdat/*, usecheckpoints, minkeepdays 1
          accessrule, prog server, ipaddr 192.169.120.23, pri 1, allow
		  accessrule, prog replicat, ipaddr 127.0.0.1, pri 1, allow
          accessrule, prog mgr, ipaddr 127.0.0.1, pri 1, allow
          lagreportminutes 30
          laginfominutes 10
          lagcriticalminutes 20
          autorestart er *, RETRIES 12, WAITMINUTES 5, RESETMINUTES 60
          startupvalidationdelay 2
   b) In each of the parameter files, add comments to describe each setting and what it does.
   c) Save and close the file.
   d) Start the OGG Manager
      i. Oracle: start mgr
	  ii. MySQL: start mgr

**End of Lab 2 - - You may proceed to the next Lab**

## Acknowledgements

  * Authors ** - Brian Elliott, Data Integration
  * Contributors ** - Brian Elliott
  * Team ** - Data Integration Team
  * Last Updated By/Data ** - Brian Elliott, August 2020

## See an issue?

Please submit feedback using this link: [issues](https://github.com/oracle/learning-library/issues) 
  

