# Introduction

## About this Workshop

This lab will walk you through the process of migrating an existing 'on-premises' Tomcat application to Oracle Cloud Infrastructure. The Tomcat application we'll migrate is a Java application with a datasource connecting to a database that will be migrated to Autonomous Database on OCI alongside the application.

Estimated Lab Time: 80 min.

### About Product/Technology

- Apache Tomcat® is an open source Java application server
- Terraform is an open source engine to deploy "infrastructure-as-code" and is used to deploy the network, compute and database resources

The reference architecture looks like the following:

![](./images/architecture-deploy-tomcat.png)

### Objectives

*Perform the end-to-end migration of a Tomcat application to Oracle Cloud Infrastructure with an Autonomous Database, provisioning with terraform.*

In this lab, you will:
- Provision a demo environment to use as the 'on-premises' environment to be migrated
- Provision a Tomcat cluster on OCI, with an Autonomous Database with terraform
- Migrate the Application Database from the 'on-premises' environment to the Autonomous Database
- Migrate the Application to the Tomcat deployment on OCI
- Optionally learn to scale the Tomcat cluster
- Tear down the workshop

### Prerequisites

In order to run this workshop you need:

* A Mac OS X, Windows or Linux machine
* A private/public SSH key-pair
* Firefox browser
* A OCI account with a Compartment setup
* git installed
* Terraform 0.12 installed

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Subash Singh, Emmanuel Leroy, October 2020
 - **Last Updated By/Date** - Emmanuel Leroy, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
