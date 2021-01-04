# GoldenGate Microservices Transformations 
Jan 4 2021
## Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication transformations. GoldenGate is Non-invasive, real-time transactional data streaming
Secured, reliable and fault-tolerant data delivery. It is easy to install, configure and maintain real-time changed data
Easily extensible and flexible to stream transformed data to other relational targets

### Lab Architecture

![](./images/ggmicroservicesarchitecture.png " ")


Lab  – Create GoldenGate Microservices Replication

Lab  – Active - Active Replication

Lab  – High Availability / Disaster Recovery

Lab  - Transformations using GoldenGate Microservices

*Estimated Lab Time*:  60 minutes

### Objectives

To use GoldegGate to perform transformations on the data during the replication process. Even though GoldenGate is primarily a real time data replication tool, it does have the ability to create data transformations. In this lab we will create sample transformations to showcase this feature of GoldenGate.


### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

In this lab we will setup GoldenGate Microservices Transformations

## **STEP 1:** Configuration for Microservices Lab

Open a terminal session

![](./images/terminal3.png " ")

````
<copy>sudo su - oracle</copy>
````

![](./images/c1.png " ")

UPDATE Data: 

```
<copy>sqlplus ggate/ggate@oggoow191</copy>
```
1.	Alter Customer Table: 

```
<copy>ALTER TABLE SOE.CUSTOMERS  ADD (CUSTOMER_NAME VARCHAR2(40) );</copy>
```
2.	Create Table 

```
<copy>CREATE TABLE "SOE"."LOGON_AUDIT" 
       (    "LOGON_ID" NUMBER , 
            "CUSTOMER_ID" NUMBER, 
            "LOGON_DATE" DATE, 
         "HOST" VARCHAR2(40), 
         "GG_GROUP" VARCHAR2(40), 
         "OSUSER" VARCHAR2(40), 
             "DOMAIN" VARCHAR2(40), 
             "BA_IND" VARCHAR2(40), 
             "COMMIT" VARCHAR2(40), 
          "POS" VARCHAR2(40), 
          "RBA" VARCHAR2(40), 
          "TABLENAME" VARCHAR2(40), 
          "OPTYPE" VARCHAR2(40) 
       ) ;</copy>
```
## **STEP 2:** Concatenating the source ‘m‘ columns into target single ‘n’ columns


![](./images/c1.png " ")


1.	Go to Admin Server console for deployment Boston (http://<your ip address>:17001) and edit the parameter of the REPLICAT REP1 with the attributes to pass customer email to SQLEXEC() for execution of stored procedure and mapping it back to the target table. Add the following, after commenting the already existing map statement for CUSTOMERS table with ”–“. 

![](./images/c2.png " ")

```
<copy>MAP OGGOOW19.SOE.CUSTOMERS, TARGET OGGOOW191.SOE.CUSTOMERS, KEYCOLS(cust_id), COLMAP (USEDEFAULTS,CUSTOMER_NAME =@(STRCAT(CUST_FIRST_NAME,’ ‘ ,CUST_LAST_NAME));</copy>
```
![](./images/c2.png " ")

2.	Open the Administration Server of the Target deployment i.e. Boston at http://<your ip address>:17001. When the page is completely open, you should be at a page where you can see Replicat IREP. Please stop and start the IREP process.

![](./images/c3.png " ")

3. Open a terminal window and execute insert_customer below in SQLPLUS to insert data into customer table.


```
<copy>sqlplus ggate/ggate@oggoow19</copy>
```


4.	Execute for insert 

```
<copy>INSERT INTO soe.customers VALUES('12345678','Larry','Ellison','NY','New York','5000','LARYY@ORACLE.COM','365','15-Oct-11','Business','Music','4-Jan-61','Y','N','2767122','126219999');
commit;</copy>
```
**1 row copied**

5. After the insert transaction on the source table, query target **CUSTOMER** 

```
<copy>sqlplus ggate/ggate@oggoow191</copy>
```

```
<copy>select CUST_FIRST_NAME,CUST_LAST_NAME,CUSTOMER_NAME from SOE.CUSTOMERS where customer_id=12345678;</copy>
```

![](./images/c5.png " ")

exit

## **STEP 3:** Masking the Source Crucial email-id’s into a dummy email in the target

![](./images/c6.png " ")

1. Go to Admin Server console for deployment Boston `http://<your ip address>:17001` and edit the parameter of the REPLICAT IREP with the attributes to pass customer email to SQLEXEC() for execution of stored procedure and mapping it back to the target table.Add the following, after commenting the already existing map statement for CUSTOMERS table with ”–“.

**Replicat Definition**

2. edit the REPLICAT **IREP** and add the following lines

```
<copy>MAP OGGOOW19.SOE.CUSTOMERS, TARGET OGGOOW191.SOE.CUSTOMERS,& keycols(customer_id),&
SQLEXEC (SPNAME P_MAIL, PARAMS (code_param = CUST_EMAIL)),&
COLMAP (USEDEFAULTS, CUST_EMAIL=P_MAIL.desc_param,CUSTOMER_NAME=@STRCAT(CUST_FIRST_NAME,&CUST_LAST_NAME));</copy>
```
![](./images/c7.png " ")


3. Open Terminal and SQLPLUS into Target Database (OGGOOW191).Create a required stored procedure under GGATE users. This will be used in the SQLEXEC call in the mapping statement

```
<copy>sqlplus ggate/ggate@oggoow191</copy>
```

```
<copy>CREATE OR REPLACE FUNCTION F_MAIL(CODE_PARAM IN VARCHAR2) RETURN VARCHAR2 IS DESC_PARAM VARCHAR2(100); BEGIN RETURN 'XXXXXXXXX@dummy.com'; END; /;</copy>
```

**Press Enter**

**Function created**

![](./images/c8.png " ")

4. Select F_MAIL and verify results

![](./images/c9.png " ")

```
<copy>select F_MAIL('MADHU') from dual;</copy>
```

```
<copy>exit</copy>
```

1. Open the Administration Server of the Target deployment i.e. Boston at http://<your ip address>:17001. When the page is completely open, you should be at a page where you can see Replicat 6. • Open Terminal and SQLPLUS into Source Database (OGGOOW19) and do the transcation on the table CUSTOMER by executing following
   
   ![](./images/c11.png " ")

```
<copy>sqlplus ggate/ggate@oggoow19</copy>
```

6. Open the Terminal and SQLPLUS into Source Database (OGGOOW19) and do the transcation on the table CUSTOMER by executing update_email below


7.	Run the following Query for update

```
<copy>update soe.customers  set CUST_EMAIL='madhu.kumar.s@yahoo.com' where CUSTOMER_ID=12345678;
commit;</copy>
```
8.	Check the Target tables is stored procedure was executed for static masking of the emails. Open Terminal and SQLPLUS into Target Database (OGGOOW191). Excute “select CUST_EMAIL from soe.customers where customer_ID between 562 and 570;” in SQLPLUS

```
<copy>sqlplus ggate/ggate@oggoow191</copy>
```
```
<copy>select CUST_EMAIL from soe.customers where customer_ID between 562 and 570;</copy>
```
   ![](./images/c12.png " ")


## **STEP 4:** Using Environment Variables/Tokens

   ![](./images/c13.png " ")


1.	Go to Admin Server console for deployment Baston (http://localhost:17001) and edit the parameter of the REPLICAT IREP with the attributes to map the Environment Variables to the audit table. Add the following after *useridalias command

2. edit Relicat Settings REPLICAT IREP and add the following lines
   
```
<copy>MAP OGGOOW19.SOE.LOGON, TARGET OGGOOW191.SOE.LOGON_AUDIT, KEYCOLS(LOGON_ID), &
 COLMAP (USEDEFAULTS,&
 host=@GETENV('GGENVIRONMENT','HOSTNAME'),&
 gg_group=@GETENV ('GGENVIRONMENT','GROUPNAME')&
 osuser=@GETENV ('GGENVIRONMENT','OSUSERNAME'),&
 domain=@GETENV ('GGENVIRONMENT','DOMAINNAME'),&
 ba_ind=@GETENV ('GGHEADER','BEFOREAFTERINDICATOR'),&
 commit=@GETENV ('GGHEADER','COMMITTIMESTAMP'),&
 pos=@GETENV ('GGHEADER','LOGPOSITION'),&
 rba=@GETENV ('GGHEADER','LOGRBA'),&
 tablename=@GETENV ('GGHEADER','TABLENAME'),&
 optype=@GETENV ('GGHEADER','OPTYPE'));</copy>
 ```

![](./images/c14.png " ")

3. REPLICAT IREP param file will look like
   
![](./images/c15.png " ")

4. Open the Administration Server of the Target deployment i.e. Boston at http://<your ip address>:17001. When the page is completely open, you should be at a page where you can see **Replicat IREP**. 
   
5. Please stop and start the IREP process

![](./images/c16.png " ")

6. Open the terminal and log into SQLPLUS to do transaction on source DB (OGGOOW19) in table LOGON

```
<copy>sqlplus ggate/ggate@oggoow19</copy>
```


```
<copy>insert into soe.customers values('12345678','Larry','Ellison','NY','New York','5000','LARYY@ORACLE.COM','365','15-Oct-11','Business','Music','4-Jan-61','Y','N','2767122','126219999')</copy>
```
```
<copy>Commit;</copy>
```

**1 row copied**

7. After the insert transaction on the source table, query target **CUSTOMER** 


```
<copy>select CUST_FIRST_NAME,CUST_LAST_NAME,CUSTOMER_NAME from SOE.CUSTOMERS where customer_id=12345678;</copy>
```

8. After the insert transaction on the source table, query target **CUSTOMER** table as below in the terminal.

```
<copy>sqlplus ggate/ggate@oggoow191</copy>
```
```
<copy>select CUST_FIRST_NAME,CUST_LAST_NAME,CUSTOMER_NAME from SOE.CUSTOMERS where customer_id=12345678;</copy>
```


### Summary

Oracle GoldenGate offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform. It easily extends customers’ real-time data
integration architectures without impacting the performance of the source systems and enables timely business insight for better decision making.

You may now *proceed to the next lab*.

## Learn More

* [GoldenGate Microservices](https://docs.oracle.com/en/middleware/goldengate/core/19.1/understanding/getting-started-oracle-goldengate.html#GUID-F317FD3B-5078-47BA-A4EC-8A138C36BD59)

## Acknowledgements
* **Author** - Brian Elliott Data Integration, December 2020
* **Contributors** - Madhu Kumar S.
* **Last Updated By/Date** - Brian Elliott December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.