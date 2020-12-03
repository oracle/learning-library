# Introduction

This hands-on lab is designed to demonstrate how Oracle GoldenGate 19c Microservices can be used to setup a replication environment by a mix of web page, shell scripts and Rest API interfaces.  All labs will use shell scripts to facilitate the building of the environment, at the same time provide insight into how to use the web pages and AdminClient.

The labs will walk the end-user through how to add all components of Oracle GoldenGate replication.  To do the instantiation of the target database, the end-user will be performing a data pump export and import.  All replication process will be started as they are built.

## About Oracle GoldentGate Microservices
Oracle GoldenGate offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making. This workshop focuses on **GoldenGate Real Time Data Capture** demonstrating four scenarios that you can use (both on-premise and in the cloud) to capture real time data changes from your sources.

**Workshop Architecture**
    ![](./images/ggmicroservicesarchitecture.png " ")

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* A general understanding of database and data replication concepts using Oracle GoldenGate

### Lab Overview

TASK 1: CREATING DEPLOYMENTS
TASK 2: CONFIGURE REVERSE PROXY
TASK 3: CREATE CREDENTIALS
TASK 4: ADD EXTRACT AND DISTRIBUTION PATHS
TASK 5: INSTANTIATION
TASK 6: CREATE THE REPLICAT
TASK 7: GENERATE DATA LOAD
TASK 8: HA/DR using GG ACTIVE-ACTIVE
TASK 9: Transformations using GG

### Passwords

The passwords for all accounts are:

Database Accounts (sys/system, etc..): Welcome1
GoldenGate Users (c##ggate, ggate): ggate
GoldenGate Admin (oggadmin): Welcome_1
Unix Account (Oracle): ggDemo123#!


## Learn More

* [GoldenGate](https://www.oracle.com/middleware/data-integration/goldengate/")

* [GoldenGate Microservices](https://docs.oracle.com/goldengate/c1230/gg-winux/GGCON/getting-started-oracle-goldengate.htm#GGCON-GUID-5DB7A5A1-EF00-4709-A14E-FF0ADC18E842")

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, November 2020
* **Contributors** -Zia Khan
* **Last Updated By/Date** - Brian Elliott, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
