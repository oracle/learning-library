# Introduction

## About This Workshop

This lab will serve as a foundation for the rest of the workshop and provide you with the tools necessary to complete the steps required to migrate JDE to OCI.

The workshop will also demonstrate how to deploy JD Edwards EnterpriseOne Release 9.2 Trial Edition to Oracle Cloud Infrastructure (OCI).

Upon completion of this lab, you will have a working deployment of JD Edwards EnterpriseOne Trial Edition with Tools Release 9.2 and Applications Release 9.2 on a fully functional suite of interconnected virtual machine.You can use it to verify functionality and to investigate proofs of concept.

Estimated Lab Time: 2 hours (additional time may be needed for first-time users)

### About the Product/Technology

Trial Edition is for training and demonstration purposes only. It can be used to verify functionality and to investigate proofs of concept (POCs). The Trial Edition on OCI Compute contains only the Pristine (PS920) environment, which is one of the four standard JD Edwards EnterpriseOne environments.  

This single image is built using an Oracle Linux VM instance containing these JD Edwards EnterpriseOne servers:

* Enterprise ServerDatabase Server

* HTML Web ServerBI Publisher (BIP) Server 

* Application Interface Services (AIS) Server

* Application Development Framework (ADF) Server
  

### Objectives

In this lab, you will:
* Request and Obtain a Trial OCI Subscription
* Generate SSH Key for OCI Connection
* Deploy the JDE Trial Edition to OCI
* Configure JDE Trial Edition
* Sign in to JDE Trial Edition


### Prerequisites

* Oracle Cloud Infrastructure supports the latest versions of **Google Chrome** and **Firefox**  Firefox is preferred
* Valid email address
* Credit Card. YOU WILL NOT BE CHARGED
* Mobile Phone. Oracle will send you an SMS based text message for verification purposes
* ***For Windows users only:***  A Windows SSH utility is required to generate SSH key pairs on the client machine and to connect to the Linux based server using Secure Shell (SSH). We suggest either you either download and install the PuTTY tool (http://www.putty.org), or Git BASH (https://gitforwindows.org/).  Installation instructions are included in this document.

## Summary

### JDE Trial Edition on Oracle Cloud Infrastructure Overview

JD Edwards EnterpriseOne is a comprehensive suite of integrated global business applications. The machine image provided by Oracle allows organizations to create a trial instance of JD Edwards EnterpriseOne Release 9.2 in the Oracle Compute Cloud. This 'All-in-One' Demo/Sandbox image enables customers to explore new functionality in JD Edwards EnterpriseOne Applications Release 9.2, Update 4 & Tools Release 9.2.5.0 without installing JD Edwards EnterpriseOne in their data centers. New functionality may include:

* New industry modules
* One View Financial Statements
* Internet of Things Orchestrator
* UX One Content and Foundation 

### Mobile and other latest application enhancements Before You Begin

* It is desirable to have a fundamental understanding of the Oracle Cloud Infrastructure.
* It is highly recommended that you review the extensive collateral information, including training, at these sites:
    * [Oracle Cloud Infrastructure](https://www.oracle.com/cloud/)
    * [LearnJDE](https://docs.oracle.com/cd/E84502_01/learnjde/cloud_overview.html)

* You must have sufficient resources in Oracle Cloud Infrastructure to install and run JD Edwards EnterpriseOne Trial Edition. 
* Minimum Shape: VMStandard2.2 (2 OCPUs and 30 GB memory)
  Recommended Shape: VMStandard2.4 (4 OCPUs and 30 GB memory)
* Boot Volume Storage of 120 GB

At this point, you are ready to start creating instances in Oracle Cloud Infrastructure.

You may now proceed to the next lab.

## Acknowledgements

* **Author:** AJ Kurzman, Cloud Engineering
* **Contributors:**
    * Jeff Kalowes, Principal JDE Specialist
    * Mani Julakanti, Principal JDE Specialist
    * Marc-Eddy Paul, Cloud Engineering
    * William Masdon, Cloud Engineering
    * Chris Wegenek, Cloud Engineering 
* **Last Updated By/Date:** AJ Kurzman, Cloud Engineering, 11/18/2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/migrate-saas-to-oci). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.




