# Introduction

This workshop aims at providing hands-on lab in creating a complete solution platform to filter, correlate, and process events in real-time using GoldenGate for Big data and GoldenGate stream Analytics.  

*Estimated Lab Time*: 3 hours

## About GoldenGate Stream Analytics (GGSA)
Golden Gate Stream Analytics is an environment that originally began as a Complex Event Processing engine and evolved to run on top of runtime frameworks with Apache Spark and Apache Kafka.  The tool is designed to ingest a stream of data from any source such as a database, GoldenGate, kafka, JMS, REST, or even a file system file.  Once the data is in GGSA you can run analytics on live data in real-time using transformation and action functionality of Spark and send the data downstream to any target of your choice.  

**Architecture Overview**

In GoldenGate Stream Analytics we typically define sources and targets in a streaming workflow called a Pipeline.  Any type of analysis or transformation and action can then be done in the pipeline after the data has been ingested by the sources and before they are sent to the targets.  The sources into GGSA can be in a variety of formats.  Oracle and non-Oracle Databases, GoldenGate, Kafka, JMS or REST and even a file system.  The downstream targets can also be Oracle or non-Oracle databases, Kafka, REST, JMS or Data Lakes in Oracle and non-Oracle cloud.
In this workshop however, we will be reading streaming data from the file system, then enriching the stream using GeoSpatial, Contextual (database tables) and ML Models, run analysis on the data and finally send that data to Kafka topics.  We will be using MySQL database which contains user location, customer and product data that you can use to create stream analytics pipelines.  All the components in this workshop reside in a single node instance in Oracle Cloud.

![](./images/osaarchitecture.png " ")

### Objectives

In this workshop you will:
* Navigate Oracle GoldenGate Stream Analytics UI
* Walk-through an IoT Use Case
* Create a pipeline for a Retail Use Case
* Create dashboards and export artifacts

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

### Lab Overview

| Lab Title | Description | Approx. Time |
|--|------------------------------------------------------------|-------------|
| Login and Navigation | This lab is designed to get the user familiar with the navigation and resources in the the GGSA application  | 25 minutes  |
| Streaming IoT Data | This lab will walk the user through a sample IoT scenario and how a pipeline is created | 30minutes |
| Streaming Retail data | This lab will walk the user through a sample IoT scenario and how a pipeline is created | 70 minutes |
| Publishing – Dashboard – Import/Export | Publishing – Dashboard – Import/Export | 25 minutes |
| Appendix | This is intended to provide the user with screen shots of the lab exercises   | NA |


### Required Credentials for GoldenGate Stream Analytics

    ```
    MySQL root password: <copy>OSADemo1111!</copy>
    ```

    ```
    OSA_DEMO database password: <copy>Welcome123!</copy>
    ```

    ```
    osaadmin password: <copy>welcome1</copy>
    ```

    ```
    Spark Username: <copy>sparkadmin</copy>
    ```

    ```
    Spark Password: <copy>Sparkadmin#123</copy>
    ```

## Learn More

* [GoldenGate Stream Analytics](https://www.oracle.com/middleware/technologies)

## Acknowledgements

* **Author** - Hadi Javaherian, Solution Engineer
* **Contributors** - Shrinidhi Kulkarni, Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
