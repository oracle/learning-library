# Workshop Introduction and Overview #

## GoldenGate Stream Analytics (GGSA) Workshop
# Introduction

This workshop aims at providing hands-on lab in creating a complete solution platform to filter, correlate, and process events in real-time using GoldenGate for Big data and GoldenGate stream Analytics.  

## About Product/Technology
Golden Gate Stream Analytics is an environment that originally began as a Complex Event Processing engine and evolved to run on top of runtime frameworks with Apache Spark and Apache Kafka.  The tool is designed to ingest a stream of data from any source such as a database, GoldenGate, kafka, JMS, REST, or even a file system file.  Once the data is in GGSA you can run analytics on live data in real-time using transformation and action functionality of Spark and send the data downstream to any target of your choice.  

## Objectives

In this workshop you will:
* Navigate Oracle GoldenGate Stream Analytics UI
* Walk-through an IoT Use Case
* Create a pipeleine for a Retail Use Case
* Create dashboards and export artifacts

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account


**Architecture Overview**

In GoldenGate Stream Analytics we typically define sources and targets in a streaming workflow called a Pipeline.  Any type of analysis or transformation and action can then be done in the pipeline after the data has been ingested by the sources and before they are sent to the targets.  The sources into GGSA can be in a variety of formats.  Oracle and non-Oracle Databases, GoldenGate, Kafka, JMS or REST and even a file system.  The downstream targets can also be Oracle or non-Oracle databases, Kafka, REST, JMS or Data Lakes in Oracle and non-Oracle cloud.
In this workshop however, we will be reading streaming data from the file system, then enriching the stream using GeoSpatial, Contextual (database tables) and ML Models, run analysis on the data and finally send that data to Kafka topics.  We will be using MySQL database which contains user location, customer and product data that you can use to create stream analytics pipelines.  All the components in this workshop reside in a single node instance in Oracle Cloud.

![](./images/osaarchitecture.png " ")


**Labs**

GoldenGate Stream Analytics workshop consists of 4 separate labs.  The labs should be followed in order from Lab1-Lab4.  There are also screen shots available throughout the labs to guide you through the exercises.  Additional screen shots have been provided in the Appendix section of the workshop to help guide through the lab exercies.

Estimated Lab Time:  25 minutes

* **Lab 1:** Login and Navigation

This lab is designed to get the user familiar with the navigation and resources in the the GGSA application

Estimated Lab Time:  30 minutes

* **Lab 2:** Streaming IoT Data

This lab will walk the user through a sample IoT scenario and how a pipleline is created

Estimated Lab Time:  70 minutes

* **Lab 3:** Streaming Retail data 

The user in this lab is rquired to create a pipeline for the Retail promotion scenario

Estimated Lab Time:  25 minutes

* **Lab 4:** Publishing – Dashboard – Import/Export


The user will learn how to publish a pipeline, create dashboards and perform Import/Export of artifacts

* **Appendix:**

This is intended to provid the user with screen shots of the lab exercises 


### Required Credentials for GoldenGate Stream Analytics

**MySQL root password:** OSADemo1111!

**OSA_DEMO database password:** Welcome123!

**osaadmin password:** welcome1

**Spark Username:** sparkadmin

**Spark Password:** Sparkadmin#123

## Learn More

* [GoldenGate Stream Analytics](https://www.oracle.com/middleware/technologies)


## Acknowledgements

* **Author** - Hadi Javaherian, Solution Engineer
* **Contributors** - Shrinidhi Kulkarni, Solution Engineer
* **Last Updated By/Date** - Hadi Javaherian, Septembe 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
