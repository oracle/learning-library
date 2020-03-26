# Object Practice - Object Storage Service
  
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Practice 1: Sign in to OCI Console and Create Object Storage Bucket ](#practice-1-sign-in-to-oci-console-and-create-object-storage-bucket)

[Practice 2: Upload Object and create pre authenticated link](#practice-2-upload-object-and-create-pre-authenticated-link)


## Overview

Oracle Cloud Infrastructure Object Storage service is an internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. The Object Storage service can store an unlimited amount of unstructured data of any content type, including analytic data and rich content, like images and videos.

With Object Storage, you can safely and securely store or retrieve data directly from the internet or from within the cloud platform. Object Storage offers multiple management interfaces that let you easily manage storage at scale.

Object Storage is a regional service and is not tied to any specific compute instance. You can access data from anywhere inside or outside the context of the Oracle Cloud Infrastructure

**Object storage offers 2 tiers:**

1- Use Standard for data to which you need fast, immediate, and frequent access. Data accessibility and performance justifies a higher price point to store data in the Object Storage

2- Use Archive for data to which you seldom or rarely access, but that must be retained and preserved for long periods of time. The cost efficiency of the Archive Storagetier offsets the long lead time required to access the data

The purpose of this lab is to give you an overview of the Object Service and an example scenario to help you understand how the service works.

## Pre-Requisites

- Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

**Before You Begin**

- We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

## Practice-1: Sign in to OCI Console and Create Object Storage Bucket

1. Sign in using your tenant name, user name and password.

2. Once signed in select the compartment assigned to you from drop down menu on left part of the screen

3. From the OCI Services menu,click **Object Storage** then **Create Bucket**

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list
![]( img/OBJECT-STORAGE001.PNG)

4. Fill out the dialog box:

- Bucket Name: Provide a name (Test-Bucket in this lab)
- Storage Tier: STANDARD 

5.  Click **Create Bucket**
![]( img/OBJECT-STORAGE002.PNG)

## Practice-2: Upload Object and create pre authenticated link

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

![]( img/OBJECT-STORAGE004.PNG)

2. Change directory to the Downloads folder Enter command:
```
$ cd /c/Users/PhotonUser/Downloads/**
```
![]( img/OBJECT-STORAGE005.PNG)

3. Create a sample file, Enter command:
```
touch samplefile
```
This should create a file by the name"samplefile" in the Downloads folder

4. Switch to OCI window and click the Bucket Name.

**HINT:** You can swap between OCI window and any other application(git-bash etc) by clicking switch window
![]( img/OBJECT-STORAGE006.PNG)

5. Bucket detail window should be visible. Click **Upload Object**
![]( img/OBJECT-STORAGE007.PNG)

6. Click on Upload Object > Browse > This PC > Downloads. You should see the sample file created earlier

7. Select the file, then click **Upload Object** in the Dialog box.

8. File should be visible under Objects. Click 
Action icon and click **Create Pre-
Authenticated Request**. This will create a web
link that can be used to access the object 
Without requiring any additional authentication.

![]( img/OBJECT-STORAGE008.PNG)

9. Fill out the dialog box:

- NAME: Use an easy to remember name.

- PRE AUTHENTICATION REQUEST TARGET: OBJECT

- ACCESS TYPE: PERMIT READS ON THE OBJECT

- EXPIRATION DATE/TIME: Specify link expiration date

10. Click **Create Pre-Authenticated Request**

![]( img/OBJECT-STORAGE009.PNG)

11. Click **Copy** to copy the link

**NOTE:** The link must be copied and saved once the window is closed the link can not be retrieved again. 

12. Click **Close**
![]( img/OBJECT-STORAGE010.PNG)

13. Open a new browser window and paste Pre-Authenticated link. 
![]( img/OBJECT-STORAGE011.PNG)

14.  An option to download the file will appear.

**NOTE:** Do NOT download the file as due to space restrictions it is not allowed for the purpose of this lab.

***You have uploaded an object to Object Storage bucket, created a pre-authenticated link and successfully accessed the object. The Pre-Authenticated link can be shared with 
other users to provide them access to the object.
Multiple objects of any size can be uploaded to the bucket and shared across teams/users.***