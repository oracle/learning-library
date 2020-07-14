# Object Practice - Object Storage Service.
  
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and Create Object Storage Bucket ](#sign-in-to-oci-console-and-create-object-storage-bucket)

[Upload Object and create pre authenticated link](#upload-object-and-create-pre-authenticated-link)

[Delete the Reources](#delete-the-resources)


## Overview

Oracle Cloud Infrastructure Object Storage service is an internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. The Object Storage service can store an unlimited amount of unstructured data of any content type, including analytic data and rich content, like images and videos.

With Object Storage, you can safely and securely store or retrieve data directly from the internet or from within the cloud platform. Object Storage offers multiple management interfaces that let you easily manage storage at scale.

Object Storage is a regional service and is not tied to any specific compute instance. You can access data from anywhere inside or outside the context of the Oracle Cloud Infrastructure

**Some Key points;**

**We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%**


- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

- Do NOT use compartment name and other data from screen shots.Only use  data(including compartment name) provided in the content section of the lab

- Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the OCI Console

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

**Cloud Tenant Name**
**User Name**
**Password**
**Compartment Name (Provided Later)**

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

## Pre-Requisites

1. Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

2. OCI Training : https://cloud.oracle.com/en_US/iaas/training

3. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

4. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

5. Familiarity with Compartment: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

6. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm


## Sign in to OCI Console and Create Object Storage Bucket

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="image-alt-text">


2. From the OCI Services menu,Click **Object Storage** under **Object Storage**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Object_Storage/img/OBJECT-STORAGE001.PNG" alt="image-alt-text">

3. Ensure compartment assigned to you is selected. Click **Create Bucket**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Object_Storage/img/OBJECT-STORAGE002.PNG" alt="image-alt-text">

4. Fill out the dialog box:


- BUCKET NAME: Provide a name (Test-Bucket in this lab)
- Storage Tier: STANDARD 

5.  Click **Create Bucket**

## Upload Object and create pre authenticated link

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Object_Storage/img/OBJECT-STORAGE004.PNG" alt="image-alt-text">

2. Change directory to the Downloads folder Enter command:
```
$ cd /c/Users/PhotonUser/Downloads/
```
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Object_Storage/img/OBJECT-STORAGE005.PNG" alt="image-alt-text">

3. Create a sample file, Enter command:
```
touch samplefile
```

This should create a file by the name"samplefile" in the Downloads folder

4. Switch to OCI window and Click the Bucket Name.

**HINT:** You can swap between OCI window and any other application(git-bash etc) by Clicking switch window

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Object_Storage/img/OBJECT-STORAGE006.PNG" alt="image-alt-text">

5. Bucket detail window should be visible. Click **Upload Object**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Object_Storage/img/OBJECT-STORAGE007.PNG" alt="image-alt-text">

6. Click on Upload Object > Browse > This PC > Downloads. You should see the sample file created earlier

7. Select the file, then Click **Upload Object** in the Dialog box.

8. File should be visible under Objects. Click Action icon and Click **Create Pre-Authenticated Request**. This will create a web link that can be used to access the object Without requiring any additional authentication.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Object_Storage/img/OBJECT-STORAGE008.PNG" alt="image-alt-text">

9. Fill out the dialog box:


- NAME: Use an easy to remember name.
- PRE AUTHENTICATION REQUEST TARGET: OBJECT
- ACCESS TYPE: PERMIT READS ON THE OBJECT
- EXPIRATION DATE/TIME: Specify link expiration date

10. Click **Create Pre-Authenticated Request**

11. Click Copy Icon to copy the link

**NOTE:** The link must be copied and saved once the window is closed the link can not be retrieved again. 

12. Click **Close**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Object_Storage/img/OBJECT-STORAGE010.PNG" alt="image-alt-text">

13. Open a new browser window and paste Pre-Authenticated link. 

14.  An option to download the file will appear.

**NOTE:** Do NOT download the file as due to space restrictions it is not allowed for the purpose of this lab.

***You have uploaded an object to Object Storage bucket, created a pre-authenticated link and successfully accessed the object. The Pre-Authenticated link can be shared with other users to provide them access to the object. Multiple objects of any size can be uploaded to the bucket and shared across teams/users.**

## Delete the resources

1. From the Object Storage detail window, Click **Pre-Authenticated Requests**, Click **Delete**, then Click **OK** in Confirm window.

2. From OCI services menu navigate to **OBject Storage**. Click your bucket name. Under **Objects** your file should be visible. Click the Action icon (3 vertical dots) and click **Delete** to delete the object

3. Once the Object is deleted, click **Delete** to delete the bucket


**Congratulations! You have successfully completed the Lab** 