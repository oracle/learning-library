# Application Continuity

## Introduction
Applications achieve continuous availability when planned maintenance, unplanned outages, and load imbalances of the databasetier are hidden.  Oracle provides a set of features that you can choose from to keep your application available duringplanned events, unplanned outages and load imbalances.  You can think of these features as an insurance policy protecting your applications from service interruptions.  The best features are those that are fully transparent to your application so your application developers can focus on building functionality, not infrastructure, and that continue to protect the application when it changes in the future.  We call this future-proofing.

Watch this video and read on to learn more.

[](youtube:dIMgaujSydQ)

**Application Continuity (AC)**
Application Continuity hides outages starting with Oracle database 12.1 for thin Java-based applications and Oracle Database 12.2.0.1 for OCI and ODP.NET based applications. Application Continuity rebuilds the session by recovering the session from a known point which includes session states and transactional states. Application Continuity rebuilds all in-flight work. The application continues as it was, seeing a slightly delayed execution time when a failover occurs. The standard mode for Application Continuity is for OLTP-style pooled applications.

**Transparent Application Continuity (TAC)**
Starting with Oracle Database18c, Transparent Application Continuity (TAC) transparently tracks and records session and transactional state so the database session can be recovered following recoverable outages. This is done with no reliance on application knowledge or application code changes, allowing Transparent Application Continuity to be enabled for your applications.  Application transparency and failover are achieved by consuming the state-tracking information that captures and categorizes the session state usage as the application issues user calls.

### Objectives

-   Enable Application Continuity in the Oracle Database
-   Discover how Application Continuity protects applications
-   See how application draining enables you to hide maintenance activities

### Prerequisites

This lab assumes you have completed the following labs:
* Lab: Login to Oracle Cloud
* Lab: Generate SSH Key
* Lab: Environment Setup
* Lab: Sample Schema Setup

## **Step 1:** The Beginning

Lab under construction. Please come back soon!

## Conclusion

In this lab you had an opportunity to examine Application Continuity.

You will have learned that Application Continuity improves the user experience for both unplanned outages and planned maintenance. Application Continuity enhances the fault tolerance of systems and applications that use an Oracle database.

Transparent Application Continuity is enabled by default in the Oracle Autonomous Database. No application knowledge is needed for you to use TAC.

## Acknowledgements

- **Author** - Troy Anthony, Database Product Manager
- **Last Updated By/Date** - Troy Anthony, DB Product Management, April 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 
