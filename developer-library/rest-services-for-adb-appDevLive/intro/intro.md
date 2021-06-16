# Modern Application Development with Oracle REST Data Services

## Introduction
Oracle REST Data Services (ORDS) bridges HTTPS and your Oracle Database. A mid-tier Java application, ORDS provides a Database Management REST API, SQL Developer Web, a PL/SQL Gateway, SODA for REST, and the ability to publish RESTful Web Services for interacting with the data and stored procedures in your Oracle Database. 

The Java EE implementation offers increased functionality including a command line based configuration, enhanced security, file caching, and RESTful web services. Oracle REST Data Services also provides increased flexibility by supporting deployments using Oracle WebLogic Server, Apache Tomcat, and a standalone mode. Oracle REST Data Services further simplifies the deployment process because there is no Oracle home required, as connectivity is provided using an embedded JDBC driver.


Watch the video below for a comprehensive overview of REST and how ORDS provides what you need to deliver RESTful Services for your Oracle Database.

[](https://youtu.be/rvxTbTuUm5k)

### About this Workshop

This lab will walk you through creating a REST service using Oracle REST Data Services (ORDS) on an Autonomous Database. You will start by creating an application user whom you will use throughout all the lab steps. Once created, we will load data and create a table in our database. Using the same UI, we will REST enable that table so that endpoints created for all major operations (create, update, query, delete). Lastly, we will use OAuth to secure the REST service endpoints. This lab will be done entirely from the Database Actions UI that is provided with all Oracle REST Data Services (ORDS) installs and with the Autonomous Database in Oracle Cloud Infrastructure.

Estimated Workshop Time: 30-45 minutes

### Objectives

- Connect to your Autonomous Database using SQL Developer Web
- Create a user for application development
- Auto-REST enable a table
- Load data into the database
- Publish a RESTful service for various database objects
- Securing the REST endpoints

### Prerequisites
This lab assumes you have completed the following labs:
* Lab: [Login to Oracle Cloud](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/pre-register-free-tier-account.md)
* Lab: [Provision an Autonomous Database](https://raw.githubusercontent.com/oracle/learning-library/master/data-management-library/autonomous-database/shared/adb-provision/adb-provision.md)

## Developing RESTful Services in Autonomous Database

In this lab you will use the browser-based SQL and REST workshop tools, connect to your Autonomous Database and REST enable a table. You will then secure that REST endpoint all within a single UI.

### **Lab 1:** Create your Autonomous Database

### **Lab 2:** Connect to your Autonomous Database using SQL Developer Web

### **Lab 3:** Create and Auto-REST enable a table

### **Lab 4:** Load data and create business logic in the database

### **Lab 5:** REST enable tables and business logic

### **Lab 6:** Securing the REST endpoints

## Acknowledgements

 - **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Product Manager
 - **Last Updated By/Date** - Anoosha Pilli, Brianna Ambler, June 2021
