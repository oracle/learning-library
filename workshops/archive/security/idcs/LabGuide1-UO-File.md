# User On-boarding - File Upload

![](images/1/header.png)

## Introduction

In IDCS, you can batch import user accounts, groups and application roles using comma-separated values (CSV) files. In this exercise, you will import a set of users, groups and group memberships into IDCS using sample CSV files provided.

## Persona

Administrators, End-Users

## Objectives

**Onboard users using file upload**

- Import File in IDCS
- End-user verfication

## Import File in IDCS

### **STEP 1**: Obtain Upload CSV files

- Download the CSV file for [Users](resources/Users.csv) and [Groups](resources/Groups.csv). Inspect the content of the files from your favorite editor.
	
	![](images/1/UO-File-1.png)	

### **STEP 2**: Import File

- Go to IDCS Admin console using your Administrator Account credentials as described [here](#adminconsole). Ensure that you are on the **Users** tab

- Click on the **Import** button. 

	![](images/1/UO-File-2.png)
	
- Select the **CSV** file. Click on **Import**

    ![](images/1/UO-File-3.png)

- Go to the **Jobs** tab in Admin Console. Verify that the Import Job finished successfully. Click on **View**

    ![](images/1/UO-File-4.png)
    
- Click on **View Details** button. This will show the detailed information on the ***Import** job. Inspect the details.

    ![](images/1/UO-File-5.png) 

### **STEP 3**: Verify User Creation

- Go to the **Users** tab in Admin Console. Verify that the new users are visible on the console.

    ![](images/1/UO-File-6.png)

- Click on your target End-User and verify User's detailed attribute information

    ![](images/1/UO-File-7.png)