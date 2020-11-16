# Introduction

## About this Workshop

In this workshop you will learn about Always Free tables in Oracle NoSQL Database Cloud Service. You will create an API signing key for an Oracle Cloud user account. You will then connect to an Oracle NoSQL Database Cloud Service and create an Always Free table. You will then update parameters in the Always Free table.

This lab walks you through the steps to create and modify Always Free tables in Oracle NoSQL Database Cloud Service.

Estimated Lab Time: 25 Minutes

### Objectives
In this workshop you will:
* Create an API Signing Key
* Create an Always Free NoSQL table
* Modify parameters of an Always Free NoSQL table

### Prerequisites
*  An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## About NoSQL Database

Modern application developers have many choices when faced with deciding when and how to persist a piece of data. In recent years, NoSQL databases have become increasingly popular and are now seen as one of the necessary tools in the toolbox that every application developer must have at their disposal. While tried and true relational databases are great at solving classic application problems like data normalization, strictly consistent data, and arbitrarily complex queries to access that data, NoSQL databases take a different approach.

Many of the more recent applications have been designed to personalize the user experience to the individual, ingest huge volumes of machine generated data, deliver blazingly fast, crisp user interface experiences, and deliver these experiences to large populations of concurrent users. In addition, these applications must always be operational, with zero down-time, and with zero tolerance for failure. The approach taken by Oracle NoSQL Database is to provide extreme availability and exceptionally predictable, single digit millisecond response times to simple queries at scale. The Oracle NoSQL Database Cloud Service is designed from the ground up for high availability, predictably fast responses, resiliency to failure, all while operating at extreme scale. Largely, this is due to Oracle NoSQL Database’s shared nothing, replicated, horizontal scale-out architecture and by using the Oracle NoSQL Database Cloud Service, Oracle manages the scale out, monitoring, tuning, and hardware/software maintenance, all while providing your application with predictable behavior.

## Always Free NoSQL Database Service
As part of the Oracle Cloud Free Tier, the Oracle NoSQL Database Cloud Service participates as an Always Free service.
###Features of Always Free NoSQL Database Service###
  * You may have up to three Always Free NoSQL tables in your tenancy.
  * You can have both Always Free and regular tables in the same tenancy.
  * The Always Free NoSQL tables are displayed in the console with an “Always Free” label next to the table name.
  * An Always Free NoSQL table cannot be changed to a regular table or vice versa.

###Resource Restrictions for Always Free NoSQL tables###
  * You may have a maximum of three Always Free NoSQL tables at any time. If you have three Always Free NoSQL tables , the toggle button to create an Always Free NoSQL table is disabled. If you delete one or more of those tables, then the toggle button will be re-enabled.
  * Read Capacity (Read Units) is 50 and cannot be changed.
  * Write Capacity (Write Units) is 50 and cannot be changed.
  * Disk Storage is 25GB and cannot be changed.

The Oracle NoSQL Database Cloud Service is a server-less, fully managed data store that delivers predictable single digit response times and allows application to scale on demand via Oracle Cloud Infrastructure (OCI) console.

You may proceed to the next lab.

## Learn More

* [About Oracle NoSQL Database Cloud Service](https://docs.oracle.com/pls/topic/lookup?ctx=cloud&id=CSNSD-GUID-88373C12-018E-4628-B241-2DFCB7B16DE8)
* [Oracle NoSQL Database Cloud Service page](https://cloud.oracle.com/en_US/nosql)


## Acknowledgements
* **Author** - Vandanadevi Rajamani, Principal User Assistance Developer, Database User Assistance
* **Last Updated By/Date** - Vandanadevi Rajamani, Principal User Assistance Developer, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
