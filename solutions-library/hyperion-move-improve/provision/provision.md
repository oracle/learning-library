# Provision an Instance

## Introduction

In this exercise, we are going to deploy Hyperion on Oracle Cloud Infrastructure account. 

Estimated Lab Time: 90 minutes

### About Product/Technology

### Objectives

*List objectives for the lab - if this is the intro lab, list objectives for the workshop*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

## Step 1 - Create OCI infrastructure using Terraform Configuration File

1.	Login to OCI

2.	Go to Menu -> Compute

3.	Go to Menu -> Resource Manager -> Stacks

4.	Click on Create Stack

5.	Browse or drop terraform configuration file created in section 1
 
Provide the name and description. Select a compartment.

6.	Click Next
 
Provide a public SSH key. Select the Availability Domain

7.	Select an EPM Application
 
In this case we have selected Financial Management
Select Number of Nodes for an application
Select Instance Shape, Volume Size and Volume performance.

8.	Select the Number of Instance shape Volume Size and Volume performance for the Foundation 

9.	Select Create EPM Database

Provide the required details

Select the DB Node, Shape and DB Size. 
 
10.	Select the Web Server Configuration

11.	Load Balance Configuration
 
12.	Click Next 
 
Go through the summary of the selection and confirm your selection
13.	Click on Create

14.	Click on Terraform Actions -> Plan
 
15.	Click on Plan
 

Notice that Plan is in progress.
Once the Plan Succeeded
 
16.	Go back to Stack Details
 
Notice that you plan is listed in succeeded status.
17.	Click on Terraform Actions -> Apply
 
18.	Click on Apply

Plan will be in Accepted state

Plan is in progress

19.	Once it completes, Apply state will be succeeded and all the instance will have assigned host, ips , user and password.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
