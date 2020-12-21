# Lab  -  Configure Database and GoldenGate Users 

![](./images/ggmicroservicesarchitecture.png)

## Want to learn more:
* [GoldenGate Microservices](https://docs.oracle.com/goldengate/c1230/gg-winux/GGCON/getting-started-oracle-goldengate.htm#GGCON-GUID-5DB7A5A1-EF00-4709-A14E-FF0ADC18E842")

## Introduction
Contents

Introduction
 Disclaimer
  Oracle GoldenGate for Microservices Workshop Architecture 

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


### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

In this lab we will setup GoldenGate Microservices


## **Step 1:** Configure Database 

1. Open a terminal session

![](./images/terminal3.png)

````
<copy>sudo su - oracle</copy>
````

2. In the open Terminal Window, start SQL*Plus.

```
<copy>lsnrctl start</copy>
```

```
<copy>sqlplus /as sysdba</copy>
```

```
<copy>startup</copy>
```



![](./images/z1.png)


3. Enable the database for GoldenGate replication

```
<copy>alter system set enable_goldengate_replication=true scope=both;</copy>
```

![](./images/z2.png)

4.	Enable Archive Log on the database.  This will require you to shut down the database and restart it.

5. Shutdown the database

```
<copy>shutdown immediate;</copy>
```
![](./images/z3.png)

6. Start the database up in mount mode

```
<copy>startup mount;</copy>
```

![](./images/z4.png)

7. Change database into Archive Log mode

```
<copy>alter database archivelog;</copy>
```
![](./images/z5.png)

8. Open the database

```
<copy>alter database open;</copy>
```

![](./images/z6.png)

9.	Open the Pluggable Database
```
<copy>alter pluggable database all open read write;</copy>
```
10. Enable Minimal Supplemental Logging for the database.  Additionally, enable Force Logging then switch the log file.

```
<copy>alter database add supplemental log data;
alter database force logging;
alter system switch logfile;</copy>
```

## **Step 2:** Create the GoldenGate users needed at the Container Database and Pluggable Database Layers


1. From SQL*Plus run the following SQL statements to create thcreate e Common User within the Container Database (CDB).

```
<copy> create user c##ggate identified by ggate quota unlimited on USERS account unlock;
grant connect, dba, resource to c##ggate;</copy>
```
```
<copy>begin
SYS.DBMS_GOLDENGATE_AUTH.GRANT_ADMIN_PRIVILEGE('C##GGATE', container=>'ALL');
end;
/</copy>
```

2. From SQL*Plus, run the following SQL statements to create the GoldenGate users for the Pluggable database (PDB)
```
<copy>alter session set container = oggoow19;
grant connect, dba to c##ggate;
create user GGATE identified by ggate quota unlimited on USERS account unlock;
grant connect, dba to ggate;
alter session set container = oggoow191;
grant connect, dba to c##ggate;
create user GGATE identified by ggate quota unlimited on USERS account unlock;
grant connect, dba to ggate;
exit</copy>
```
You may now *proceed to the next lab*.

## Learn More

* [GoldenGate Microservices](https://docs.oracle.com/goldengate/c1230/gg-winux/GGCON/getting-started-oracle-goldengate.htm#GGCON-GUID-5DB7A5A1-EF00-4709-A14E-FF0ADC18E842")

## Acknowledgements
* **Author** - Brian Elliott, Data Integration, November 2020
* **Contributors** - Zia Khan
* **Last Updated By/Date** - Brian Elliott, November 2020

## See an issue?
>>>>>>> 404665e4b3cb8e5d65d5cd99304cb927a2920840
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.