# Oracle REST Data Services in Oracle Cloud Infrastructure

## Introduction

Like a swiss army knife or that as-seen-on-tv multi-tool you got from your grandmother on your birthday, Oracle REST Data Services can work with more than just the Oracle Database. This Lab will walk you through using ORDS to expose the database to multiple other OCI services and products. Services we will look at in this lab are Resource Manager, Functions, the API Gateway and the Service Connector Hub.

### About Oracle REST Data Services

Oracle REST Data Services (ORDS) bridges HTTPS and your Oracle Database. A mid-tier Java application, ORDS provides a Database Management REST API, a web based SQL, JSON and REST workshops, a PL/SQL Gateway, SODA for REST, and the ability to publish RESTful Web Services for interacting with the data and stored procedures in your Oracle Database.

The Java EE implementation offers increased functionality including a command line based configuration, enhanced security, file caching, and RESTful web services. Oracle REST Data Services also provides increased flexibility by supporting deployments using Oracle WebLogic Server, Apache Tomcat, and a standalone mode. Oracle REST Data Services further simplifies the deployment process because there is no Oracle home required, as connectivity is provided using an embedded JDBC driver.

### Resource Manager

Resource Manager is an Oracle Cloud Infrastructure service that allows you to automate the process of provisioning your Oracle Cloud Infrastructure resources. Using Terraform, Resource Manager helps you install, configure, and manage resources through the "infrastructure-as-code" model.

A Terraform configuration codifies your infrastructure in declarative configuration files. Resource Manager allows you to share and manage infrastructure configurations and state files across multiple teams and platforms. This infrastructure management can't be done with local Terraform installations and Oracle Terraform modules alone.

More about Resource Manager can be found [here](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm)

### Functions

Oracle Functions is a fully managed, multi-tenant, highly scalable, on-demand, Functions-as-a-Service platform. It is built on enterprise-grade Oracle Cloud Infrastructure and powered by the Fn Project open source engine. Use Oracle Functions (sometimes abbreviated to just Functions) when you want to focus on writing code to meet business needs.

The serverless and elastic architecture of Oracle Functions means there's no infrastructure administration or software administration for you to perform. You don't provision or maintain compute instances, and operating system software patches and upgrades are applied automatically. Oracle Functions simply ensures your app is highly-available, scalable, secure, and monitored. With Oracle Functions, you can write code in Java, Python, Node, Go, and Ruby (and for advanced use cases, bring your own Dockerfile, and Graal VM). You can then deploy your code, call it directly or trigger it in response to events, and get billed only for the resources consumed during the execution.

More about Functions can be found [here](https://docs.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)

### API Gateway

The API Gateway service enables you to publish APIs with private endpoints that are accessible from within your network, and which you can expose with public IP addresses if you want them to accept internet traffic. The endpoints support API validation, request and response transformation, CORS, authentication and authorization, and request limiting.

Using the API Gateway service, you create one or more API gateways in a regional subnet to process traffic from API clients and route it to back-end services. You can use a single API gateway to link multiple back-end services (such as load balancers, compute instances, and Oracle Functions) into a single consolidated API endpoint.

More about the API Gateway can be found [here](https://docs.oracle.com/en-us/iaas/Content/APIGateway/Concepts/apigatewayoverview.htm)

### Service Connector Hub

Service Connector Hub is a cloud message bus platform that offers a single pane of glass for describing, executing, and monitoring movement of data between services in Oracle Cloud Infrastructure. Data is moved using service connectors. A service connector specifies the source service that contains the data to be moved, optional tasks, and the target service for delivery of data when tasks are complete. An optional task might be a function task to process data from the source or a log filter task to filter log data from the source.

More about the Service Connector Hub can be found [here](https://docs.oracle.com/en-us/iaas/Content/service-connector-hub/overview.htm)

### Objectives

-   Load JSON into the Oracle Database
-   Work with JSON in the Oracle Database with relational tables
-   Work with JSON in the Oracle Database as JSON documents
-   Provide developer endpoints for relation or schemaless application development

### Prerequisites
This lab assumes you have completed the following labs:
* Lab: [Login to Oracle Cloud](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/pre-register-free-tier-account.md)
* Lab: [Provision an Autonomous Database](https://raw.githubusercontent.com/oracle/learning-library/master/data-management-library/autonomous-database/shared/adb-provision/adb-provision.md)

## Oracle REST Data Services in Oracle Cloud Infrastructure

In this lab you will XXXXX

### **STEP 1:** Connect to your Database using SQL Developer Web

### **STEP 2:** Create a user for working with JSON in the Oracle Database

### **STEP 3:** Load JSON into the database and work with relational tables

### **STEP 4:** Load JSON into the database and work with JSON documents and collections

### **STEP 5:** Exposing the Data for Applications

## Acknowledgements

- **Authors** - Jeff Smith and Brian Spendolini
- **Last Updated By/Date** - Brian Spendolini/June 2021
