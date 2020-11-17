# Setup of GoldenGate Classic Workshop 

![](./images/image200_1.png)

## Want to learn more:
"https://www.oracle.com/middleware/data-integration/goldengate/"

## Introduction
Contents

Introduction
 Disclaimer
  Oracle GoldenGate for Big Data Workshop Architecture 
  Setup the QuickStart VM for GoldenGate for Big Data Workshop

Lab  – Setup GoldenGate Classic

Lab  – MySQL ->  Oracle  unidirectional replication
  
Lab  – Oracle ->  mySQL  unidirectional replication

Lab  – Classic Active-Active Replication 

Lab  – Classic Column Conversions 

Lab  - Replication to PostgreSQL

Lab  - Replication from PostgreSQL

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

Time to complete - 60 mins

### Summary

Oracle GoldenGate offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data
integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making.

### Disclaimer

This workshop is only for learning and testing purposes. None of the files from the labs should be used in a production environment. 

Time to Complete -
Approximately 30 min

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

In this lab we will setup GoldenGate Classic


## **Step 1:** Configuration for Classic Lab

Open a terminal session

![](./images/terminal3.png)

````
<copy>sudo su - oracle</copy>
````

## **Step 2:**  Test connectivity for the OGG users: (Completed prior to the Lab)

1. sqlplus c##ggadmin

When prompted enter the password: Oracle1
````
<copy>sqlplus c##ggadmin@pdbeast</copy>
````
When prompted enter the password: Oracle1	

2. open a secong session

````
<copy>sqlplus ggadmin@pdbwest</copy>
````
When prompted enter the password: Oracle1
		   
1. Change to the "/opt/Test_Software/Scripts/Oracle/orderentry" directory

````
<copy>/opt/Test_Software/Scripts/Oracle/orderentry</copy>
````
````
<copy>sudo su – oracle</copy>
````
Password = Data1Integration!

Run the following commands:

````
<copy>sqlplus / as sysdba</copy>
````

````
<copy>alter session set container=pdbeast;</copy>
````

````
<copy>sqlplus / as sysdba @create_user.sql</copy>
````

edit and chg to c##tpc

````
<copy>grant all priviledges to c##tpc;</copy>
````

````
<copy>@create_user.sql</copy>
````

````
<copy>sqlplus / as sysdba</copy>
````
````
<copy>alter session set container=pdbwest;</copy>
````
````
<copy>@create_user.sql</copy>
````
````
<copy>sqlplus c##tpc@pdbeast</copy>
````

When prompted enter the password: Oracle1

````
<copy>@database.sql</copy>
````

````
<copy>sqlplus c##tpc@pdbwest</copy>
````

When prompted enter the password: Oracle1

````
<copy>@database.sql</copy>
````

Each PDB in the database (pdbeast and pdbwest) will now contain a TPC schema with seeded tables.

1.  Enter "exit" to logout as the "oracle" user.

````
<copy>exit</copy>

````


## **Step 3:** - Conenctivity to Oracle environment using ggadmin

Test connectivity to **MySQL** by executing the commands:

````
<copy>sudo service mysqld start</copy>
````

````
<copy>sudo mysql -u ggadmin -p@Oracle1@</copy>
````
````
<copy>create database tpc;</copy>
````

````
<copy>create database ggadmin;</copy>
````
````
<copy>use tpc</copy>
````

````
<copy>show tables;</copy>
````

There should be 14 tables in the tpc database.

````
<copy>exit;</copy>
````

## **Step 4:**  - Conenctivity to MySQL environment using ggrep

````
<copy>sudo mysql -u ggrep -p@Oracle1@</copy>
````
````
<copy>use tpc</copy>
````

````
<copy>show tables;</copy>
````

There should be 14 tables in the tpc database.

````
<copy>exit;</copy>
````

## **Step 5:**  - GoldenGate GoldenGate for Oracle setup and configuration
	
1. start a second session

2. Switch to the "oracle" user.

````
<copy>sudo su – oracle</copy>
````

````
<copy>export OGG_HOME=/u01/app/oracle/product/19.1.0/gg</copy>
````

3. Go to the $OGG_HOME location

````
<copy>cd $OGG_HOME</copy>
````

4. Start ggsci and execute the following commands:

````
<copy>./ggsci
create subdirs
dblogin userid c##ggadmin@orcl, password Oracle1</copy>
````

This validates remote connectivity to the Oracle Database.

````
<copy>exit</copy>
````

## **Step 6:**  - GoldenGate GoldenGate for MySQL setup and configuration

````
<copy>mysql -uroot -pData1Integration!
CREATE USER 'ggrep'@'localhost' IDENTIFIED BY '@Oracle1@';
GRANT ALL PRIVILEGES ON * . * TO 'ggrep'@'localhost';</copy>
````

````
<copy>mysql\q</copy>
````

Open another ssh session
````
s<copy>udo su - oracle</copy>
````
1. Go to the "oggmysql" directory.

````   
<copy>cd /u01/app/oracle/product/19.1.0/oggmysql</copy>
````

1. Set the environment variable OGG_HOME to this directory.

````
<copy>export OGG_HOME=/u01/app/oracle/product/19.1.0/oggmysql</copy>
````

4. Start GGSCI and execute the following commands:

````
<copy>create subdirs</copy>
````
````
<copy>dblogin sourcedb tpc@localhost:3306, userid ggadmin, password @Oracle1@</copy>

````

This validates remote connectivity to the MySQL Database for capture.

````
<copy>dblogin sourcedb tpc@localhost:3306, userid ggrep, password @Oracle1@</copy>
````

This validates remote connectivity to the MySQL Database for apply.

````
<copy>exit</copy>
````
	
1.  Enter "exit" twice to close the connection to the database machine.

2.  Shutdown the MySQL database.

````
<copy>sudo su -
````
````
<copy>sudo service mysqld stop</copy>
````

3.  Shutdown the Oracle database.

4.  Switch to the oracle user.
````
<copy>sudo su – oracle / Data1Integration!</copy>
````

5.  Shutdown the Oracle database and listener.
    
````
<copy>sqlplus / as sysdba
	  shutdown immediate
	  exit</copy>
````

14. Enter "exit" twice to close the connection to the database machine.

You may now *proceed to the next lab*.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration, November 2020
* **Contributors** - Madhu Kumar
* **Last Updated By/Date** - Brian Elliott, November 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

