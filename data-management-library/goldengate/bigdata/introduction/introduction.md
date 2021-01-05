# Introduction

## About Oracle GoldenGate for Big Data
Oracle GoldenGate for Big Data offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making. This workshop focuses on **GoldenGate Real Time Data Capture** demonstrating four scenarios that you can use (both on-premise and in the cloud) to capture real time data changes from your sources.

**Workshop Architecture**
    ![](./images/image110_1.png " ")

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

### Lab Overview

- **Lab: Installation Of GoldenGate for Big Data** -
    In this lab we will install GoldenGate for Big Data in the GG Target Home. Follow the steps below to install GG, or optionally you can select “I” from the Lab Menu below to auto-install GG.

- **Lab: Replication from Relational Database to Relational Database using GoldenGate** -
    This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.

- **Lab: Replication from Relational to HDFS** -
    This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.

- **Lab: Replication from Relational to Hive** -
    In this lab we will load data in MySQL database `ggsource`, GG extract process `extmysql` will capture the changes from MySQL's binary logs and wrote them to the local trail file. The pump process `pmphadop` will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
    process `rhive` will read the trail file, create the Hive tables, write the data and the schema files (avsc) to the HDFS target directory for Hive:` /user/ggtarget/hive/data/*` and `/user/ggtarget/hive/schema/*`

- **Lab: Replication from Relational to HBase** -
    In this lab we will load data in MySQL database `ggsource`, GG extract process `extmysql` will In this lab we will load data in MySQL database `ggsource`, GG extract process `extmysql` will capture the changes from MySQL's binary logs and write them to the local trail file. The pump process `pmphadop` will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process `rhbase` will read the remote trail files, create the HBase tables and write the data to those tables.

- **Lab: Replication from Relational to Kafka** -
    In this lab we will load data in MySQL database `ggsource`, GG extract process `extmysql` will capture the changes from MySQL's binary logs and write them to the local trail file. The pump process `pmphadop` will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process `rkafka` will read the remote trail files, act as a producer and write the messages to an auto- created topic for each table in the source database.

- **Lab: Replication from Relational to Cassandra** -  
    In this lab we will load data in MySQL database `ggsource`, GG extract process `extmysql` will capture the changes from MySQL's binary logs and write them to the local trail file. The pump process `pmphadop` will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process `rcass` will read the remote trail files, create the Cassandra tables and write the data to those tables.


## Learn More

* [GoldenGate](https://www.oracle.com/middleware/data-integration/goldengate/")
* [GoldenGate for Big Data](https://www.oracle.com/middleware/data-integration/goldengate/big-data/")

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
