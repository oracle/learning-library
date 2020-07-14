# OCI Audit Service
  
## Table of Content


[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Practice-1: Sign in to OCI Console and Create Object Storage Bucket](#practice-1-sign-in-to-oci-console-and-create-object-storage-bucket)

[Practice-2: Upload Object and Check Audit logs](#practice-2-upload-object-and-check-audit-logs)

## Overview

The Oracle Cloud Infrastructure Audit service automatically records calls to all supported Oracle Cloud Infrastructure public application programming interface (API) endpoints as log events. Currently, all services support logging by Audit. Object Storage service supports logging for bucket-related events, but not for object-related events. Log events recorded by the Audit service include API calls made by the Oracle Cloud Infrastructure Console, Command Line Interface (CLI), Software Development Kits (SDK), your own custom clients, or other Oracle Cloud Infrastructure services

Each log event includes a header ID, target resource(s), time stamp of the recorded event, request parameters, and response parameters. You can view events logged by the Auditservice by using the Console,API, or the Java SDK. You can view events, copy the details of individual events, as well as analyze events or store them separately. Data from events can be used to perform diagnostics, track resource usage, monitor compliance, and collect security-related events.

The purpose of this lab is to give you an overview of the Audit Service and an example scenario to help you understand how the service works.

**Some Key points;**

**We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%**


- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

- Do NOT use compartment name and other data from screen shots. Only use  data(including compartment name) provided in the content section of the lab

- Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the OCI Console

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

**Cloud Tenant Name**
**User Name**
**Password**
**Compartment Name (Provided Later)**

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI


## Pre-Requisites

- Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

## Practice-1: Sign in to OCI Console and Create Object Storage Bucket

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}

1. Sign in using your tenant name, user name and password.

2. Once signed in select the compartment assigned to you from drop down menu on left part of the screen

3. From the OCI Services menu,click **Object Storage** then **Create Bucket**

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

4. Fill out the dialog box:
- **Bucket Name:** Provide a name (Test-Bucket in this lab)
- **Storage Tier:**  STANDARD 

5. Click **Create Bucket**

## Practice-2: Upload Object and Check Audit logs

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.
![]( img/AUDIT004.PNG)

2. Change directory to the Downloads folder Enter command: 
```
cd /c/Users/PhotonUser/Downloads/**
```
![]( img/AUDIT005.PNG)

3. Create a sample file, Enter command:
```
touch samplefile
```
This should create a file by the name"samplefile" in the Downloads folder

4. Switch to OCI window and click the Bucket Name.

**HINT:** You can swap between OCI window and any other application(git-bash etc) by clicking switch window

![]( img/AUDIT006.PNG)

5. Bucket detail window should be visible. Click **Upload Object**

6. Click on Upload Object > Browse > This PC > Downloads. You should see the sample file created earlier

7. Select the file, then click **Upload Object** in the Dialog box.

8. In OCI services menu, Click **Audit** under Governance. Scroll down or type the bucket name in 
Keyword section. You can choose other options
such as dates and Request Action Type. For this 
lab we will leave them as default. Audit logs for the Storage bucket should be visible

***You have utilized OCI’s Audit service to extract events specific to Storage bucket created. Audit service can be used to monitor operations performed on OCI resources and can assist in trouble 
shooting your OCI environment***
