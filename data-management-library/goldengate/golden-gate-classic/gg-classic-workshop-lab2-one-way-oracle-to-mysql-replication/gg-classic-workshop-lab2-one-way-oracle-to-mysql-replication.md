#  Lab 2 -  one-way-oracle-to-mysql-replication

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

**MySQL**

4. sudo service mysqld start

5. export OGG_HOME=/u01/app/oracle/product/19.1.0/oggmysql
6. dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@
7. ADD CHECKPOINTTABLE ggadmin.ggchkpoint
MySQL: checkpointtable ggadmin.ggchkpoint
8. Set the WALLETLOCATION parameter to the disk location in step 1.

**Oracle:**

9.  WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet

**MySQL:**
10. WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet
11. Save and close the files.

12. Start the GoldenGate Software Command Interpreter in both windows.

13. OGG Credential Store

In GGSCI, create the OGG Credential Store by executing the command: 
add credentialstore
Add OGG database user credentials into each credential store.

**Oracle**

14. alter credentialstore add user c##ggadmin@orcl password Oracle1 alias oggcapture
15. alter credentialstore add user ggadmin@pdbeast password Oracle1 alias ggapplyeast
16. alter credentialstore add user ggadmin@pdbwest password Oracle1 alias ggapplywest
       
**MySQL**
17. alter credentialstore add user ggadmin password @Oracle1@ alias oggcapture
18. alter credentialstore add user ggrep password @Oracle1@ alias ggapply

19. OGG Master Key and Wallet

In the Oracle GGSCI, create the OGG Wallet.
Command: CREATE WALLET 

20. Add the OGG Masterkey to the wallet.
Oracle: add masterkey
21. Verify the Master Key and Wallet from the MySQL GGSCI instance.
22. dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@
**MySQL:** open wallet
23. MySQL: info masterkey
**Oracle:** 
24. open wallet
25. Oracle: info masterkey

26. GGSCI (ogg-ggbd) 5> info masterkey
Masterkey Name: OGG_DEFAULT_MASTERKEY

Version         Creation Date                            Status
2020-09-10T15:22:28.000+00:00   Current
   
27. OGG Replicat Checkpoint Table
alter pluggable database PDBEAST open;
alter pluggable database PDBWEST open;

28. In GGSCI, create the OGG Replicat Checkpoint Table by executing the commands:

**Oracle**
29. Connect to the target database: dblogin useridalias ggapplywest
30. Create the table: add checkpointtable pdbwest.ggadmin.ggchkpoint

**Mysql**
31. Connect to the target database: dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias ggapply
32. Create the table: add checkpointtable	

33. OGG Heartbeat
In GGSCI, create and activate OGG Integrated Heartbeat
Oracle
34. Connect to the PDBEAST tenant: dblogin useridalias ggapplyeast
35. Create the heartbeat source: add heartbeattable		
36. Connect to the PDBWEST tenant: dblogin useridalias ggapplywest
37. Create the heartbeat target: add heartbeattable, targetonly

**MySQL**
38. Connect to the ggadmin database: dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias oggcapture
39. Create the heartbeat target: add heartbeattable, targetonly
		  
OGG Manager
To configure the OGG Manager process in both the Oracle and MySQL OGG environments:

40. Execute the GGSCI command: edit param mgr

41. For Oracle, enter the following settings:
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

42. For MySQL, enter the following settings:	
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
43. In each of the parameter files, add comments to describe each setting and what it does.
44. Save and close the file.
45. Start the OGG Manager
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
  

