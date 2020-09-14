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
> mkdir /u01/app/oracle/product/19.1.0/oggWallet

2. GLOBALS configuration
In each $OGG_HOME directory, edit the file GLOBALS
vi GLOBALS
Set the GGSCHEMA parameter
Oracle: ggschema pdbeast.ggadmin
MySQL: ggschema ggadmin
Set the CHECKPOINTTABLE parameter

## MySQL

sudo service mysqld start

export OGG_HOME=/u01/app/oracle/product/19.1.0/oggmysql
dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@
ADD CHECKPOINTTABLE ggadmin.ggchkpoint
MySQL: checkpointtable ggadmin.ggchkpoint
Set the WALLETLOCATION parameter to the disk location in step 1.
Oracle: WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet
MySQL: WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet
Save and close the files.

3. Start the GoldenGate Software Command Interpreter in both windows.

4. OGG Credential Store
In GGSCI, create the OGG Credential Store by executing the command: 
add credentialstore
Add OGG database user credentials into each credential store.

Oracle
alter credentialstore add user c##ggadmin@orcl password Oracle1 alias oggcapture
alter credentialstore add user ggadmin@pdbeast password Oracle1 alias ggapplyeast
alter credentialstore add user ggadmin@pdbwest password Oracle1 alias ggapplywest
       
MySQL
alter credentialstore add user ggadmin password @Oracle1@ alias oggcapture
alter credentialstore add user ggrep password @Oracle1@ alias ggapply

1. OGG Master Key and Wallet
In the Oracle GGSCI, create the OGG Wallet.
Command: CREATE WALLET 
 ____________________________________   
Add the OGG Masterkey to the wallet.
Oracle: add masterkey
Verify the Master Key and Wallet from the MySQL GGSCI instance.
dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@
MySQL: open wallet
MySQL: info masterkey
Oracle: open wallet
Oracle: info masterkey

GGSCI (ogg-ggbd) 5> info masterkey
Masterkey Name: OGG_DEFAULT_MASTERKEY

Version         Creation Date                   Status
1.               2020-09-10T15:22:28.000+00:00   Current
   
6. OGG Replicat Checkpoint Table
alter pluggable database PDBEAST open;
alter pluggable database PDBWEST open;

In GGSCI, create the OGG Replicat Checkpoint Table by executing the commands:
Oracle
Connect to the target database: dblogin useridalias ggapplywest
Create the table: add checkpointtable pdbwest.ggadmin.ggchkpoint

Mysql
Connect to the target database: dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias ggapply
Create the table: add checkpointtable	

1. OGG Heartbeat
In GGSCI, create and activate OGG Integrated Heartbeat
Oracle
Connect to the PDBEAST tenant: dblogin useridalias ggapplyeast
Create the heartbeat source: add heartbeattable		
Connect to the PDBWEST tenant: dblogin useridalias ggapplywest
Create the heartbeat target: add heartbeattable, targetonly

MySQL
Connect to the ggadmin database: dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias oggcapture
Create the heartbeat target: add heartbeattable, targetonly
		  
1. OGG Manager
To configure the OGG Manager process in both the Oracle and MySQL OGG environments:
Execute the GGSCI command: edit param mgr
For Oracle, enter the following settings:
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

For MySQL, enter the following settings:	
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
In each of the parameter files, add comments to describe each setting and what it does.
Save and close the file.
Start the OGG Manager
Oracle: start mgr
MySQL: start mgr

**End of Lab 2 - - You may proceed to the next Lab**

## Acknowledgements

  * Authors ** - Brian Elliott,Zia Khan Data Integration
  * Contributors ** - Brian Elliott, Zia Khan
  * Team ** - Data Integration Team
  * Last Updated By/Data ** - Brian Elliott, September 2020

## See an issue?

Please submit feedback using this link: [issues](https://github.com/oracle/learning-library/issues) 
  

