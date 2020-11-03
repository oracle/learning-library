# Lab 1 -  Setup of Golden Gate Classic Workshop 

![](./images/image200_1.png)

## Want to learn more:
"https://www.oracle.com/middleware/data-integration/goldengate/"

## Introduction
Contents

Introduction
 Disclaimer
  Oracle GoldenGate for Big Data Workshop Architecture 
  Setup the QuickStart VM for GoldenGate for Big Data Workshop

Lab 1 – Setup GoldenGate Classic


Lab 2 – MySQL ->  Oracle  unidirectional replication
  
Lab 3 – Oracle ->  mySQL  unidirectional replication

Lab 4 – Classic Active-Active Replication 

Lab 5 – Classic Column Conversions 

### Objectives

KEY FEATURES

Non-invasive, real-time transactional data streaming

Secured, reliable and fault-tolerant data delivery 
Easy to install, configure and maintain 
Streams real-time changed data 
Easily extensible and flexible to stream changed data to other relational targets

KEY BENEFITS

Improve IT productivity in integrating with data management systems 
Use real-time data in big data analytics for more timely and reliable insight 
Improve operations and customer experience with enhanced business insight • Minimize overhead on source systems to maintain high performance

Oracle GoldenGate Classic provides optimized and high performance delivery.

Oracle GoldenGate Classic real-time data streaming platform also allows customers to keep their data reservoirs up to date with their production systems.

Time to complete - 15 mins

### Summary

Oracle GoldenGate offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data
integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making.

### Disclaimer

This workshop is only for learning and testing purposes. None of the files from the labs should be used in a production environment. 

Time to Complete -
Approximately 30 min

## Steps

**Prereqs (Completed by Oracle Team prior to Labs)**

In this lab we will setup GoldenGate Classic


**Step 1:** PreLab Configuration for Classic Lab

1. mkdir /opt/Test_Software
2. Downloaded the following software zip files to the "Software" folder:
   		OGG Classic v19.1.0.0.3 for MySQL on Linux x64
   		OGG Classic v19.1.0.0.4 for Oracle on Linux x64
   		Oracle Database v19.3.0.0.0 for Linux x64
   		Oracle Instant Client Basic v19.3.0.0.0 for Linux x64

**ORACLE**

3. Create pdbs

PDBEAST

Source pdb
   cd /u02/oradata/ORCL/
mkdir PDBEAST
alter system set db_create_file_dest='/u02/oradata/ORCL//PDBEAST';
sqlplus / as sysdba
alter pluggable database oggoow19 close immediate;
alter pluggable database oggoow19 open read only;
create pluggable database PDBEAST from oggoow19;
alter pluggable database PDBEAST open;
exit

PDBWEST

Source pdb
   cd /u02/oradata/ORCL/
mkdir PDBWEST
sqlplus / as sysdba
alter system set db_create_file_dest='/u02/oradata/ORCL//PDBWEST';
alter pluggable database oggoow191 close immediate;
alter pluggable database oggoow191 open read only;
create pluggable database PDBWEST from oggoow191;
alter pluggable database PDBWEST open;
exit

4. Install Mysql Workbench
sudo yum install mysql-workbench-community
Start Mysql Workbench to test
/usr/bin/mysql-workbench –help

Change to the “/opt/TestSoftware/Oracle" directory.

5. Run the setup_database_for_ogg.sql script.
create user c##ggadmin identified by Oracle1 default tablespace oggtbls_pdbwest quota unlimited on oggtbls_pdbwest profile ogg_profile;

sqlplus / as sysdba @setup_database_for_ogg.sql
The database will now contain two PDBs, PDBEAST and PDBWEST, and is configured for OGG replication.
The common database user C##GGADMIN will be created, and the container user C##GGADMIN in PDBEAST and PDBWEST.

**Step 2:** 

**mySQL**

1. CREATE USER 'ggadmin'@'localhost' IDENTIFIED BY '@Oracle1@';
GRANT ALL PRIVILEGES ON * . * TO 'ggadmin'@'localhost';


**Step 3:** Change to ggadmin

'````
<copy>sudo su – ggadmin</copy>
````

**PLEASE USE ‘ggadmin’ USER FOR ALL THE LABS** 

**Step 4:** Student Configuration for Classic Lab

Open a terminal session

![](./images/terminal2.png)

## STEPS -  Done by Student

**Step1:**  Test connectivity for the OGG users:

1. sqlplus c##ggadmin
When prompted enter the password: Oracle1
2. sqlplus c##ggadmin@pdbeast
When prompted enter the password: Oracle1	
3. sqlplus ggadmin@pdbwest
When prompted enter the password: Oracle1
		   
4. Change to the "/opt/Test_Software/Scripts/Oracle/orderentry" directory
su – oracle
Password = Data1Integration!

Run the following commands:

5. sqlplus / as sysdba
6. alter session set container=pdbeast;
7. sqlplus / as sysdba @create_user.sql

edit and chg to c##tpc

8. grant all priviledges to c##tpc;

9. @create_user.sql

sqlplus / as sysdba
alter session set container=pdbwest;
@create_user.sql

10. sqlplus c##tpc@pdbeast
When prompted enter the password: Oracle1
@database.sql
11. sqlplus c##tpc@pdbwest
When prompted enter the password: Oracle1
@database.sql

Each PDB in the database (pdbeast and pdbwest) will now contain a TPC schema with seeded tables.

12. Enter "exit" to logout as the "oracle" user.


## Step 3: - Conenctivity to Oracle environment using ggadmin

Test connectivity to MySQL by executing the commands:

1. sudo service mysqld start

2. sudo mysql -u ggadmin -p@Oracle1@

3. create database tpc;

4.create database ggadmin;
use tpc

5. show tables;

There should be 14 tables in the tpc database.

5. exit;

## Step 3: - Conenctivity to MySQL environment using ggrep

1. sudo mysql -u ggrep -p@Oracle1@
use tpc
2. show tables;
There should be 14 tables in the tpc database.
 exit;

## Step 4: - GoldenGate GoldenGate for Oracle setup and configuration
	
1. start a second session

2. Switch to the "oracle" user.
sudo su – oracle
export OGG_HOME=/u01/app/oracle/product/19.1.0/gg

3. Go to the $OGG_HOME location
cd $OGG_HOME

4. Start ggsci and execute the following commands:

./ggsci
create subdirs
dblogin userid c##ggadmin@orcl, password Oracle1
This validates remote connectivity to the Oracle Database.
exit

## Step 5: - GoldenGate GoldenGate for MySQL setup and configuration

1. Mysql -uroot -pData1Integration!
CREATE USER 'ggrep'@'localhost' IDENTIFIED BY '@Oracle1@';
GRANT ALL PRIVILEGES ON * . * TO 'ggrep'@'localhost';

````
<copy>mysql\q</copy>
````

2. Go to the "oggmysql" directory.
cd /u01/app/oracle/product/19.1.0/oggmysql

3. Set the environment variable OGG_HOME to this directory.
export OGG_HOME=/u01/app/oracle/product/19.1.0/oggmysql

4. Start GGSCI and execute the following commands:

5. create subdirs
6. dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@

This validates remote connectivity to the MySQL Database for capture.
7. dblogin sourcedb tpc@localhost:3306, userid ggrep, password @Oracle1@
This validates remote connectivity to the MySQL Database for apply.
exit
	
8.  Enter "exit" twice to close the connection to the database machine.

9.  Shutdown the MySQL database.

10. sudo su -
    a) sudo service mysqld stop

11. Shutdown the Oracle database.

12. Switch to the oracle user.
    a) sudo su – oracle / Data1Integration!

13. Shutdown the Oracle database and listener.
    sqlplus / as sysdba
	  shutdown immediate
	  exit

14. Enter "exit" twice to close the connection to the database machine.

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

