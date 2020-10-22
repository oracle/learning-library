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

## Step 1: - GoldenGate GoldenGate for Oracle

1. Create the folder /u01/app/oracle/product/19.1.0/oggWallet
````
<copy>mkdir /u01/app/oracle/product/19.1.0/oggWallet</copy>
````

2. GLOBALS configuration
In each $OGG_HOME directory, edit the file GLOBALS

````
<copy>vi GLOBALS</copy>
````
Set the GGSCHEMA parameter
Oracle: ggschema pdbeast.ggadmin
MySQL: ggschema ggadmin
Set the CHECKPOINTTABLE parameter

## Step 2: - GoldenGate GoldenGate for non-Oracle (MySQL)

1. sudo service mysqld start

2. export OGG_HOME=/u01/app/oracle/product/19.1.0/oggmysql

3. dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@

4. ADD CHECKPOINTTABLE ggadmin.ggchkpoint
MySQL: checkpointtable ggadmin.ggchkpoint

5. Set the WALLETLOCATION parameter to the disk location in step 1.

**For Oracle:**

6.  WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet

**For MySQL:**

7. WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet

8. Save and close the files.

9. Start the GoldenGate Software Command Interpreter in both windows.

**OGG Credential Store**

In GGSCI, create the OGG Credential Store by executing the command: 
add credentialstore
Add OGG database user credentials into each credential store.

**Oracle**

10. alter credentialstore add user c##ggadmin@orcl password Oracle1 alias oggcapture
11. alter credentialstore add user ggadmin@pdbeast password Oracle1 alias ggapplyeast
12. alter credentialstore add user ggadmin@pdbwest password Oracle1 alias ggapplywest
       
**MySQL**
13. alter credentialstore add user ggadmin password @Oracle1@ alias oggcapture
14. alter credentialstore add user ggrep password @Oracle1@ alias ggapply

OGG Master Key and Wallet

In the Oracle GGSCI, create the OGG Wallet.
Command: CREATE WALLET 

15.  Add the OGG Masterkey to the wallet.

**Oracle GG**

Oracle: add masterkey
16. Verify the Master Key and Wallet from the MySQL GGSCI instance.

17. dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@

**MySQL:** open wallet

18. MySQL: info masterkey

**Oracle:** 

19. open wallet
20. Oracle: info masterkey

21. GGSCI (ogg-ggbd) 5> info masterkey
Masterkey Name: OGG_DEFAULT_MASTERKEY

Version         Creation Date                            Status
2020-09-10T15:22:28.000+00:00   Current
   
22. OGG Replicat Checkpoint Table
alter pluggable database PDBEAST open;
alter pluggable database PDBWEST open;

23. In GGSCI, create the OGG Replicat Checkpoint Table by executing the commands:

**Oracle**
24. Connect to the target database: dblogin useridalias ggapplywest

25. Create the table: add checkpointtable pdbwest.ggadmin.ggchkpoint

**Mysql**
26. Connect to the target database: dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias ggapply

27. Create the table: add checkpointtable	

28. OGG Heartbeat

In GGSCI, create and activate OGG Integrated Heartbeat
Oracle

29. Connect to the PDBEAST tenant: dblogin useridalias ggapplyeast

30. Create the heartbeat source: add heartbeattable		

31. Connect to the PDBWEST tenant: dblogin useridalias ggapplywest

32. Create the heartbeat target: add heartbeattable, targetonly

**MySQL**

33. Connect to the ggadmin database: dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias oggcapture

34. Create the heartbeat target: add heartbeattable, targetonly
		  
**OGG Manager**

To configure the OGG Manager process in both the Oracle and MySQL OGG environments:

35. Execute the GGSCI command: edit param mgr

36. For Oracle, enter the following settings:
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

37. For MySQL, enter the following settings:	
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
38. In each of the parameter files, add comments to describe each setting and what it does.

39. Save and close the file.

40. Start the OGG Manager
Oracle: start mgr
MySQL: start mgr

You may now *proceed to the next lab*.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Brian Elliott, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.


