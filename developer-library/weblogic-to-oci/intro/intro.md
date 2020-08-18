# Migrate WebLogic to Oracle Cloud Infrastructure

## Introduction

This lab will walk you through the process of migrating an existing 'on-premises' WebLogic domain to WebLogic for Oracle Cloud Infrastructure. The WebLogic domain we'll migrate contains a couple Java applications and a datasource connecting to a database that will be migrated along the WebLogic domain. 

Attached below is a sample architecture of the final solution:
![](./images/architecture.png)

Estimated Lab Time: 80min to 120min depending on the path chosen.

### Objectives

*Perform the end-to-end migration of a local WebLogic domain to Oracle Cloud Infrastructure, provisioning WebLogic on OCI with the Marketplace.*

In this lab, you will:
- Provision a demo environment to use as the 'on-premises' environment to be migrated
- Prepare the OCI tenancy to provision WebLogic Server from the Marketplace
- Provision a new empty WebLogic domain on OCI with the Marketplace
- Provision the Application Database on OCI
- Migrate the Application Database from the 'on-premises' environment to the OCI DBaaS
- Migrate the WebLogic domain using Weblogic Deploy Tooling (WDT)
- Optionally learn to scale the provisioned domain
- Tear down the workshop

### Prerequisites

*In order to run this workshop you need:*

* A Mac OS X, Windows or Linux machine
* A private/public SSH key-pair
* Firefox browser
* A OCI account with a Compartment setup

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
