#  One Way Oracle to MySql Replication

## Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ will
capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process
‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’

### Objectives
Replication from relational source to a relational target using GoldenGate

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

Time to Complete -

Approximately 60 minutes
 
## **Step 1:** GoldenGate for Oracle

Open a terminal session

![](./images/terminal3.png)

````
 <copy>ssh -i (sshkey) opc@xxx.xxx.xx.xxx</copy>
````
````
<copy>sudo su - oracle</copy>
````
1. Create the folder /u01/app/oracle/product/19.1.0/oggWallet
````
<copy>mkdir /u01/app/oracle/product/19.1.0/oggWallet</copy>
````

2. GLOBALS configuration

In each $OGG_HOME directory, edit the file GLOBALS

````
<copy>vi GLOBALS</copy>
````
````
<copy>Set the GGSCHEMA parameter
Oracle: ggschema pdbeast.ggadmin
MySQL: ggschema ggadmin
Set the CHECKPOINTTABLE parameter</copy>
````

## **Step 2:**- GoldenGate for non-Oracle (MySQL)

Open a terminal session
````
 <copy>ssh -i (sshkey) opc@xxx.xxx.xx.xxx</copy>
````
1. **Oracle:**
````
<copy>sudo su - oracle</copy>
````

````
<copy>sudo service mysqld start</copy>
````
````
<copy>export OGG_HOME=/u01/app/oracle/product/19.1.0/oggmysql</copy>
````

````
<copy>dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@</copy>
````

````
<copy>ADD CHECKPOINTTABLE ggadmin.ggchkpoint</copy>
````

2. **MySQL:** 

checkpointtable ggadmin.ggchkpoint

1. Set the WALLETLOCATION parameter to the disk location in step 1.

**For Oracle:**

````
<copy>WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet</copy>
````

**For MySQL:**

````
<copy>WALLETLOCATION /opt/app/oracle/product/19.1.0/oggWallet</copy>
````

2. Save and close the files.

3. Start the GoldenGate Software Command Interpreter in both windows.

````
<copy./ggsci</copy>
````
>
4. **OGG Credential Store**

In GGSCI, create the OGG Credential Store by executing the command: 
````
<copy>add credentialstore</copy>
````
5. Add OGG database user credentials into each credential store.

6. **Oracle**

````
    <copy>alter credentialstore add user c##ggadmin@orcl password Oracle1 alias oggcapture</copy>

````
````
    <copy>alter credentialstore add user ggadmin@pdbeast password Oracle1 alias ggapplyeast</copy>
````
````
<copy>alter credentialstore add user ggadmin@pdbwest password Oracle1 alias ggapplywest</copy>
````
       
7. **MySQL**
````
<copy>alter credentialstore add user ggadmin password @Oracle1@ alias oggcapture</copy>
````
````
<copy>alter credentialstore add user ggrep password @Oracle1@ alias ggapply</copy>
````


## **Step 3:**- OGG Master Key and Wallet

1. In the Oracle GGSCI, create the OGG Wallet.
Command: 

````
<copy>CREATE WALLET</copy>
```` 

2. Add the OGG Masterkey to the wallet.

**Oracle GG**

````
<copy>add masterkey</copy>
````
3.  Verify the Master Key and Wallet from the MySQL GGSCI instance.

````
<copy>dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@</copy>
````

4. **MySQL:** 

````
<copy>open wallet</copy>
````
````
<copy>info masterkey</copy>
````

5. **Oracle:** 

````
<copy>open wallet</copy>
````

````
<copy>info masterkey</copy>
````
6.  GGSCI (ogg-ggbd) 5> 

````
<copy>./ggsci</copy>
````

````
<copy>info masterkey</copy>
````
7. Masterkey Name: OGG_DEFAULT_MASTERKEY

Version         Creation Date                            Status
2020-09-10T15:22:28.000+00:00   Current
   
## **Step 4:**- GoldenGate Checkpoint Table

````
<copy>alter pluggable database PDBEAST open;
alter pluggable database PDBWEST open;</copy>
````

1.  In GGSCI, create the OGG Replicat Checkpoint Table by executing the commands:

2. **Oracle**

Connect to the target database: 
````
<copy>dblogin useridalias ggapplywest</copy>
````

3.  Create the table: 
````
<copy>add checkpointtable pdbwest.ggadmin.ggchkpoint</copy>
````

4. **Mysql**

5. Connect to the target database: 

````
<copy>dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias ggapply</copy>
````

6.  Create the table: 
````
<copy>add checkpointtable</copy>
````	

## **Step 5:**- GoldenGate Heartbeat

1.  OGG Heartbeat

In GGSCI, create and activate OGG Integrated Heartbeat

**Oracle**

2. Connect to the PDBEAST tenant: 
````
<copy>dblogin useridalias ggapplyeast</copy>
````

3. Create the heartbeat source: 

````
<copy>add heartbeattable</copy>
````		

4. Connect to the PDBWEST tenant: 

````
<copy>dblogin useridalias ggapplywest</copy>
````

5. Create the heartbeat target: 
````
<copy>add heartbeattable, targetonly</copy>
````

**MySQL**

6.  Connect to the ggadmin database: 
   
````
<copy>dblogin sourcedb ggadmin@db-ora19-mysql:3306, useridalias oggcapture</copy>
````

7.  Create the heartbeat target: 
````
<copy>add heartbeattable, targetonly</copy>
````
## **Step 6:**- GoldenGate Manager		  
**OGG Manager**

To configure the OGG Manager process in both the Oracle and MySQL OGG environments:

1.  Execute the GGSCI command: 

````
<copy>edit param mgr</copy>
````

2. For Oracle, enter the following settings:
````
	      <copy>port 15000
          dynamicportlist 15001-15025
          purgeoldextracts ./dirdat/*, usecheckpoints, minkeepdays 1
          accessrule, prog server, ipaddr *, deny
          accessrule, prog mgr, ipaddr 127.0.0.1, pri 1, allow
          lagreportminutes 30
          laginfominutes 10
          lagcriticalminutes 20
          autorestart er *, RETRIES 12, WAITMINUTES 5, RESETMINUTES 60
          startupvalidationdelay 2</copy>
````

3. For MySQL, enter the following settings:
````
<copy>edit param mgr</copy>
````
````	
	      <copy>port 16000
          dynamicportlist 16001-16025
          purgeoldextracts ./dirdat/*, usecheckpoints, minkeepdays 1
          accessrule, prog server, ipaddr 192.169.120.23, pri 1, allow
		  accessrule, prog replicat, ipaddr 127.0.0.1, pri 1, allow
          accessrule, prog mgr, ipaddr 127.0.0.1, pri 1, allow
          lagreportminutes 30
          laginfominutes 10
          lagcriticalminutes 20
          autorestart er *, RETRIES 12, WAITMINUTES 5, RESETMINUTES 60
          startupvalidationdelay 2</copy>
````

4. In each of the parameter files, add comments to describe each setting and what it does.

5. Save and close the file.

6. Start the OGG Manager
```
<copy>cd $OGG_HOME
./ggsci</copy>
```

## **Step 7:**- Startup GoldenGate

1. Oracle: 
````
<copy>start mgr</copy>
````
2. MySQL: 
````
<copy>start mgr</copy>
````

You may now *proceed to the next lab*.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration November 2020
* **Contributors** - Madhu Kumar
* **Last Updated By/Date** - Brian Elliott, November 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.


