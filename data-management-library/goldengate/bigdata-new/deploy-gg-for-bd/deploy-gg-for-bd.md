# Deploy GoldenGate for Big Data

## Introduction

In this lab you will install GoldenGate for Big Data in the GG Target Home.

*Estimated Lab Time*:  30 minutes

  ![](./images/image110_1.png " ")

### Objectives
- Deploy GoldenGate for Big Data

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup

## **STEP 0:** Running your Lab
### Login to Host using SSH Key based authentication
Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
  - Authentication OS User - “*opc*”
  - Authentication method - *SSH RSA Key*
  - OS User – “*ggadmin*”.

1. First login as “*opc*” using your SSH Private Key

2. Then sudo to “*ggadmin*”. E.g.

    ```
    <copy>sudo su - ggadmin</copy>
    ```
Follow the steps below to install GoldenGate, or optionally you can select “I” from the Lab Menu below to auto-install GG.

3. Review the labmenu, then Select **Q** to quit to install GoldenGate Big Data Adapter Handlers

  The following Lab Menu will be displayed

    ![](./images/labmenu_opt1.png " ")

## **STEP 1**: Performing the Install

1.  **Select Option 1**

  Review the overview notes on the following screen, Select **Q** to quit.
      ![](./images/labmenu_opt1.png " ")

  These online notes have been provided so you can cut/paste file names to another session, to avoid typos.

2. To install and configure GoldenGate, we have extracted the GG binaries from a tar file prior to the labs – this file has been copied to /u01 as part of the setup. We will connect to the GoldenGate command line interface (ggsci) and run CREATE SUBDIRS to create the subdirectories in the GoldenGate home.

    ```
    <copy>cd /u01/gg4hadoop123010
    tar -xvf  /u01/gg_binaries/gg4hadoop123010/ggs_Adapters_Linux_x64.tar </copy>
    ```
    **type**

    ```
    <copy>./ggsci</copy>

    <copy>info all</copy>

    <copy>exit</copy>
    ```
    **type**
    ```
    <copy>labmenu</copy>
    ```

**Optional**  (Do not select Auto-install if you already installed GG manually)

If you would like to auto-install GoldenGate for Big Data, you can select option **I**. To access the Lab Menu, type the alias `labmenu`, then select **I**.

***Congratulations!***, GoldenGate for Big Data is now installed. You can proceed to the next lab, or to any other lab. Each lab can be run independently.

## About Oracle GoldenGate for Big Data

### KEY FEATURES

  - Non-invasive, real-time transactional data streaming
  - Secured, reliable and fault-tolerant data delivery
  - Easy to install, configure and maintain
  - Streams real-time changed data
  - Easily extensible and flexible to stream changed data to other big data targets and message queues

### KEY BENEFITS

  - Improve IT productivity in integrating with big data systems
  - Use real-time data in big data analytics for more timely and reliable insight
  - Improve operations and customer experience with enhanced business insight
  - Minimize overhead on source systems to maintain high performance

Oracle GoldenGate for Big Data provides optimized and high performance delivery to Flume, HDFS, Hive, HBase, Kafka and Cassandra to support customers with their real-time big data analytics initiatives.

Oracle GoldenGate for Big Data includes Oracle GoldenGate for Java, which enables customers to easily integrate to additional big data systems, such as Apache Storm, Apache Spark, Oracle NoSQL, MongoDB, SAP HANA, IBM PureData System for Analytics and many others.

Oracle GoldenGate for Big Data’s real-time data streaming platform also allows customers to keep their big data reservoirs, or big data lakes, up to date with their production systems.

## Summary

Oracle GoldenGate for Big Data offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data
integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making.

You may now *proceed to the next lab*.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, October 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
