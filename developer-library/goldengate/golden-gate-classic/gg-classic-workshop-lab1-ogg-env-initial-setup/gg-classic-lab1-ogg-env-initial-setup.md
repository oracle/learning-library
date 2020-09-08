# Lab 1 -  GG initial setp 

![](./images/image110_1.png)

## Want to learn more:

  [Oracle GoldenGate | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/)

## Introduction
Contents

Introduction
 Disclaimer
  Oracle GoldenGate for Big Data Workshop Architecture 
  Setup the QuickStart VM for GoldenGate for Big Data Workshop

Lab 1 – Install GoldenGate binaries for Big Data 

Optional step (Do not select Auto-install if you already installed GG manually) 
 
Lab 2 – MySQL ->  MySQL unidirectional replication
  
Lab 3 – MySQL --> HDFS (delimited text format) 

Lab 4 – MySQL --> Hive (Avro format) 

Lab 5 – MySQL --> HBase 38 

Lab 6 – MySQL --> Kafka (Json format) 

Lab 7 – MySQL --> Cassandra 

Appendix A – Handler Configuration Properties 

Appendix B – Command Reference List

### Objectives

KEY FEATURES

Non-invasive, real-time transactional data streaming

Secured, reliable and fault-tolerant data delivery 
Easy to install, configure and maintain 
Streams real-time changed data 
Easily extensible and flexible to stream changed data to other big data targets and message queues

KEY BENEFITS

Improve IT productivity in integrating with big data systems 
Use real-time data in big data analytics for more timely and reliable insight 
Improve operations and customer experience with enhanced business insight • Minimize overhead on source systems to maintain high performance

Oracle GoldenGate for Big Data provides optimized and high performance delivery to Flume, HDFS, Hive, HBase, Kafka and Cassandra to support customers with their real-time big data analytics initiatives.

Oracle GoldenGate for Big Data includes Oracle GoldenGate for Java, which enables customers to easily integrate to additional big data systems, such as Apache Storm, Apache Spark, Oracle NoSQL, MongoDB, SAP HANA, IBM PureData System for Analytics and many others.

Oracle GoldenGate for Big Data’s real-time data streaming platform also allows customers to keep their big data reservoirs, or big data lakes, up to date with their production systems.

Time to complete - 15 mins

### Summary

Oracle GoldenGate for Big Data offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data
integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making.

### Disclaimer

This workshop is only for learning and testing purposes. None of the files from the labs should be used in a production environment. 

Time to Complete -
Approximately 30 min

## Steps

In this lab we will install GoldenGate for Big Data in the GG Target Home. Follow the steps below to install GG, or optionally you can select “I” from the Lab Menu below to auto-install GG.

**Step1:** Open terminal from desktop by double clicking on the icon

![](./images/terminal2.png)

**Step2:** Change to ggadmin

'>su – ggadmin
Password = oracle


PLEASE USE ‘ggadmin’ USER FOR ALL THE LABS 

The following Lab Menu will be displayed

Follow these instructions to install GoldenGate for Big Data

**Step3:** Install GoldenGate using option 1

![](./images/labmenu_opt1.png)

Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.

To install and configure  GoldenGate, we have extracted the GG binaries from a tar file prior to the labs – this file has been copied to /u01 as part of the setup. We will connect to the GoldenGate command line interface (ggsci) and run CREATE SUBDIRS to create the subdirectories in the GoldenGate home.


**Optional**  (Do not select Auto-install if you already installed GG manually)

If you would like to auto-install GoldenGate for Big Data, you can select option "I". To access the Lab Menu, type the alias ‘labmenu’, then select I.

Congratulations, GoldenGate for Big Data is now installed. You can proceed to the next lab, or to any other lab. Each lab can be run independently.

**You have completed Lab 1 - You may proceed to the next Lab**

## Acknowledgements

  * Authors ** - Brian Elliott
  * Contributors ** - Brian Elliott
  * Team ** - Data Integration Team
  * Last Updated By - Brian Elliott, August 2020


## Please submit an issue on our issues page:
[issues](https://github.com/oracle/learning-library/issues) 

 We review it regularly.

