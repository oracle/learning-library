# Goldegate for Big Data Hands-On-Lab  #

## Workshop Overview ##
# Goldegate Classic Hands-On-Lab  #

## Workshop Overview ##

**GoldenGate ** Oracle GoldenGate Classic offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform Classic environments. It easily extends customers’ real-time data integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making. This hands-on workshop focuses on **GoldenGate Real Time Data Capture** demonstrating 4 scenarios that you can use (both on-premise and in the cloud) to capture real time data changes from your sources.

## Workshop Requirements

- Access to Live Labs
  
- Access to a laptop or a desktop
    - To log into Live Labs

## Agenda

- **Lab 1 :** Installation Of GoldenGate Classic

In this lab we will install GoldenGate Classic in the GG Target Home. Follow the steps below to install GG, or optionally you can select “I” from the Lab Menu below to auto-install GG.

- **Lab 2 :** Replication from Relational Database mySQL to Relational Database Oracle using GoldenGate

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.

- **Lab 3 :** Replication from Relational Database Oracle to Relational Database mySQL using GoldenGate

This lab is intended to give you familiarity with how to configure GG for database to database replication. If you are already familiar with GG, you can choose to skip this lab.

- **Lab 4 :** Replication Using Active - Active for HA


In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and wrote them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhive’ will read the trail file, create the Hive tables, write the data and the schema files (avsc) to the HDFS target directory for Hive: /user/ggtarget/hive/data/* and /user/ggtarget/hive/schema/*

- **Lab 5 :** Replication and Coulmn Conversions

In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhbase’ will read the remote trail files, create the HBase tables and write the data to those tables.

- **Lab 6 :** Replication from Relational to Kafka

In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rkafka’ will read the remote trail files, act as a producer and write the messages to an auto- created topic for each table in the source database.

- **Lab 7 :** Replication from Relational to Cassandra

In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rcass’ will read the remote trail files, create the Cassandra tables and write the data to those tables.

## Access the labs

- Use **Lab Contents** menu on your right to access the labs.
    - If the menu is not displayed, click the menu button ![](./images/menu-button.png) on the top right  make it visible.

Below is an architectural diagram of our labs

![](./images/image110_1.png)

- You may close the menu by clicking ![](./images/menu-close.png "")

- **Author** - Brian Elliott - August 2020

## Access the labs

- Use **Lab Contents** menu on your right to access the labs.
    - If the menu is not displayed, click the menu button ![](./images/menu-button.png) on the top right  make it visible.

Below is an architectural diagram of our labs

![](./images/image110_1.png)

- You may close the menu by clicking ![](./images/menu-close.png "")

- **Author** - Brian Elliott - August 2020