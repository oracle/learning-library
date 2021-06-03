# Introduction

## About this workshop

This workshop is an extension of a previous workshop. It showcases the use of enabling an OCI service, DataSafe, to extend your EBS environment. 

Data Safe is a cloud-based monitoring tool that allows users to assess, monitor, audit, and mask data and activity from on-premises or cloud-native databases. Database Administrators, or others whose concern includes database security, can use Data Safe to monitor and manage sensitive data on multiple environments and keeps tabs on the accessibility and activities of the database. 

This workshop walks you through the setup of Data Safe on a private database system. You will be configuring network settings and creating a user on the database with the appropriate permissions to setup a connection to Data Safe. Then the workshop provides a short walkthrough of the features of Data Safe. 

In order to complete this lab you will need a Virtual Machine DB System provisioned on OCI. 

Estimated Workshop Time: 1 hour

### **Background**

* The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
* IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs as these are dynamically generated.
* For security purposes, some sensitive text (such as IP addresses) may be redacted in the screenshots in this workbook.

    Note: Please be aware that the screenshots in this lab follow the enabling of Data Safe for an EBS instance. This is not required and simply provides the walkthrough of a typical "installment" of Data Safe on a database. 

### Workshop Overview

* We will first enable OCI Data Safe and configure the private endpoint for connection to our database. 

* Next, we will configure a database user as the Data Safe Admin.

* Lastly, we will add the database as a target on the Data Safe console and begin using Data Safe.

This workshop uses the following components: 

* Data Safe Service from OCI

* Virtual Cloud Network and related resources.
    - User-generated using Resource Manager and provided Terraform script.

* Virtual Machine Database System

### **Prerequisites**

* This workshop requires a private Virtual Machine Database System provisioned on OCI. You will need:
    - Access to the VCN on which the VM DB resides
    - The Database Node's private IP address
    - Access to the database as a sysdba (depending on your configuration, you may be able to simply run a single command to achieve this.)

## Acknowledgements

* **Author:** Quintin Hill, William Masdon, Cloud Engineering
* **Contributors:** Santiago Bastidas, Product Management Director
* **Last Updated By/Date:** William Masdon, Cloud Engineering, Mar 2021

### Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/ebs-on-oci-automation). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 
