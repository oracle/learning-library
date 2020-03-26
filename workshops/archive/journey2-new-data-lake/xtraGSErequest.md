![](images/100GSE/100GSE.JPG) 

Updated: August 13, 2017

## Introduction

Oracle offers a set of Big Data Journeys to help users get started using Oracle Cloud services with a purpose.  These journeys are available to everyone at `http://www.oracle.com/bigdatajourney`

Oracle Solution Engineers may use these journeys to build hands-on technical skills with Oracle Big Data Cloud Services.  Additionally, Solution Engineers may use the journeys to work collaboratively with customers.
Demo Central – powered by Oracle Global Solution Engineering (GSE) - offers a MetCS (Metered Cloud Service) Stack of preconfigured cloud services in the Oracle Public Cloud for Solutions Engineers to use for workshops, demonstrations and proof of concepts.
As of the date of this publication, a GSE engineer must manually configure a demo environment that has all cloud services necessary to run Big Data Journeys

This guide is intended to help Oracle Solution Engineers set up an Oracle Big Data Cloud Service – Compute Edition environment in Demo Central so they may run through the Big Data Journeys available for clients and prospects

# Steps
- Review important information at [http://bdcoe.us.oracle.com/wordpress/pilot-to-production/journeys/journey-via-the-gse/](http://bdcoe.us.oracle.com/wordpress/pilot-to-production/journeys/journey-via-the-gse/)
- Register a Demo with Demo Central
- Launch the Demo Environment
- Customize Your Dashboard to Display Additional Services
- Review the Storage Cloud Service 
- Review the Big Data Cloud Service – Compute Edition Service 
- Begin Your Big Data Journey

## Review important information at [http://bdcoe.us.oracle.com/wordpress/pilot-to-production/journeys/journey-via-the-gse/](http://bdcoe.us.oracle.com/wordpress/pilot-to-production/journeys/journey-via-the-gse/)

1)  Navigate to [http://bdcoe.us.oracle.com/wordpress/pilot-to-production/journeys/journey-via-the-gse/](http://bdcoe.us.oracle.com/wordpress/pilot-to-production/journeys/journey-via-the-gse/)
2)  Review the webpage for any last-minute updates or critical announcements
3)  Watch the short [video](https://oradocs-corp.documents.us2.oraclecloud.com/documents/link/LF16817FBC1D054667CD932FF6C3FF17C1177A968060/fileview/DF784173A97E3D87E97BC836F6C3FF17C1177A968060/_How_To_Register_a_Demo_Training.mp4)

## Register a Demo with Demo Central
1)	Visit Demo Central at `http://demo.oracle.com`
2)	Click “Demos” tab
3)	Click “Register a Demo” button
4)	Search for “Big Data Cloud Service Compute Edition (BDCS CE) with Zeppelin”
5)	Complete the Demo Registration form using the following values:
-	Demo Purpose: “Oracle or Partner Training”
-	Description/Comments: “Walk through Big Data Journeys”
-   Choose a New Deal Server Environment
-   Choose PAASMETCSPC01 - PaaS - Metered Cloud Service Plus
-	Demo Resource Request Type: “A new Deal Server Environment”	
-	Activity Start Date:  <your start date>
-	Activity End Date:  <your end date>
-	Demo Date(s):  <your demo date>

![](images/100GSE/snap0012224.png)  

6)	Click “Next” button
7)	Select “Horizontal (NOT Industry-Specific)”
8)	Check the “Big Data - Compute Edition” checkbox

![](images/100GSE/picture-02.png)  

9)	Click “Next” button
10)	Click “Submit” button
11)	You will automatically receive an email notification like the one below:

![](images/100GSE/picture-03.png)  

**Please note:  Your demo instance is NOT automatically provisioned at this point!!**!  You will be notified when your environment is ready – typically 2-4 hours after your demo registration - when you receive an email like the following:
![](images/100GSE/picture-04.png)  

## Launch the Demo Environment
1)	Visit Demo Central at `http://demo.oracle.com`
2)	Click “Demos” tab
3)	Click “Launch Demo” link next to the registration that id that was provisioned for you.  (Note: your environment name will be unique to your demo registration)
![](images/100GSE/picture-05.png)  

4)	Note the usernames and passwords assigned to your environment
![](images/100GSE/picture-06.png)  

5)	Click “Login in to Cloud Service Dashboard” link
6)	Login using the following credentials:
-	User: cloud.admin
-	Password: <your cloud.admin user password>


## Customize Your Dashboard to Display Additional Services
The “Big Data – Compute Edition” and “Event Hub – Dedicated Cloud Services” are NOT displayed by default on your Services Dashboard.  Follow these steps to display these services on your dashboard
![](images/100GSE/picture-07.png)  

Scroll down and click “Show” for both “Event Hub – Dedicated” and “Big Data – Compute Edition” Services
![](images/100GSE/picture-08.png) 

## Verify the Storage Cloud Service and Storage Container are Created
After logging in, you are directed to the My Services Dashboard.  

Click the “Storage” link to get to the Service Details for Oracle Storage Cloud Service
![](images/100GSE/picture-09.png) 

Note your Identity Domain

Click on the “Open Service Console” button
![](images/100GSE/picture-10.png) 

Note that there may already be some containers created.  That is OK- we won't use them but you can leave them as-is. 

Also note in the upper left it says something like “Storage-gse0002004”.  You will use info this when you provision BDCS-CE.
![](images/100GSE/picture-11.png)

Click “My Services” to go back to your Cloud Services Dashboard

## Verify the Big Data Cloud Service – Compute Edition Service is Created
Click the “Big Data – Compute Edition” link to get to the Service Details for Oracle Big Data Cloud Service – Compute Edition
![](images/100GSE/picture-12.png)

Note your Identity Domain

Click on the “Open Service Console”
![](images/100GSE/picture-13.png)

Note that a “myBDCSCE” service has already been created for you.  We will not use this instance.  You can delete it (and probably should delete it to free up quota in your environment)

Click on the ![](images/100GSE/picture-15.png)  icon next the myBDCSCE service, then choose Delete to delete the myBDCSCE instance.

![](images/100GSE/picture-16.png)


## Begin Your Big Data Journey

Follow the instructions in [Lab100 StartHere](LabGuide100StartHere.md) and create a new BDCSCE instance on your own. 
