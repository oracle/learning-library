# Introduction

This hands-on lab is designed to demonstrate how Oracle GoldenGate 19c Microservices can be used to setup a replication environment by a mix of web page, shell scripts and Rest API interfaces.  All labs will use shell scripts to facilitate the building of the environment, at the same time provide insight into how to use the web pages and AdminClient.

The labs will walk the end-user through how to add all components of Oracle GoldenGate replication.  To do the instantiation of the target database, the end-user will be performing a data pump export and import.  All replication process will be started as they are built.

### About Oracle GoldentGate Microservices
Oracle GoldenGate offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making. This workshop focuses on **GoldenGate Real Time Data Capture** demonstrating four scenarios that you can use (both on-premise and in the cloud) to capture real time data changes from your sources.

### Lab Architecture
![](./images/ggmicroservicesarchitecture.png " ")

KEY FEATURES

Non-invasive, real-time transactional data streaming while applying target transformations

KEY BENEFITS

- Improve IT productivity in integrating with data management systems.
- Use real-time data in big data analytics for more timely and reliable insight
- Improve operations and customer experience with enhanced business insight
- Minimize overhead on source systems to maintain high performance

Oracle GoldenGate Microservices provides optimized and high performance delivery.Designed to demonstrate how Oracle GoldenGate 19c Microservices can be used to setup a replication environment by a mix of web page, shell scripts and Rest API interfaces.  All labs will use shell scripts to facilitate the building of the environment, at the same time provide insight into how to use the web pages and AdminClient.  

Oracle GoldenGate Microservices real-time data streaming platform also allows customers to keep their data reservoirs up to date with their production systems.

### Objectives
The objectives of the labs is to familiarize you with the process to create data repication objects that will allow you to replicate data realtime using GoldenGate Microservices while levergaring RestfulAPIs.

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* A general understanding of database and data replication concepts using Oracle GoldenGate

### Lab Overview

LAB: CREATING DEPLOYMENTS  
LAB: CONFIGURE REVERSE PROXY  
LAB: CREATE CREDENTIALS  
LAB: ADD EXTRACT AND DISTRIBUTION PATHS  
LAB: INSTANTIATION  
LAB: CREATE THE REPLICAT  
LAB: GENERATE DATA LOAD  
LAB: HA/DR USING GG ACTIVE-ACTIVE  
LAB: TRANSFORMATIONS USING MICROSERVICES  

### Passwords

The passwords for all accounts are:

```Database Accounts (sys/system, etc..): Welcome1```  
```GoldenGate Users (c##ggate, ggate): ggate```  
```GoldenGate Admin(oggadmin): Welcome_1```  
```Unix Account (Oracle): ggDemo123#!```  


## Learn More

* [GoldenGate Microservices](https://docs.oracle.com/en/middleware/goldengate/core/19.1/understanding/getting-started-oracle-goldengate.html#GUID-F317FD3B-5078-47BA-A4EC-8A138C36BD59)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, November 2020
* **Contributors** -Zia Khan
* **Last Updated By/Date** - Brian Elliott, November 2020
\
You may now *proceed to the next lab*.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.