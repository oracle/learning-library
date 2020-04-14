# Getting Started with Autonomous Data Warehouse (ADW)

![](images/100/Picture100-lab.png)  
Updated: January 4, 2019

## **Introduction**

This is the first of several labs that are part of the **Predicting Flight Delays with Oracle Machine Learning & Autonomous Data Warehouse Cloud Service** workshop. This lab walks you through the steps to get started using the Oracle Autonomous Data Warehouse (ADW) on Oracle Infrastructure Cloud (OCI). You will provision a new ADW instance during this lab. 

**_To log issues_**, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Objectives
-   Learn how to provision a new Autonomous Data Warehouse (ADW) 
-   Learn how to creae Oracle Machine Leaning (OML) Notebook Users

## Required Artifacts
-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

# Provision Autonomous Data Warehouse (ADW)

## Part 1. Provisioning an ADW Instance

In this section, you will be provisioning an ADW instance using the cloud console.

### **STEP 1: Sign in to Oracle Cloud**

-   Go to [cloud.oracle.com](https://cloud.oracle.com), click **Sign In** to sign in with your Oracle Cloud account.

![](./images/100/Picture100-2.png)

-   Enter your **Cloud Account Name** and click **My Services**.

![](./images/100/Picture100-3.jpg)

-   Enter your Oracle Cloud **username** and **password**, and click **Sign In**.

![](./images/100/Picture100-4.png)

### **STEP 2: Create an ADW Instance**

-   Once you are logged in, you are taken to the OCI Console. Click **Create a data warehouse**

![](./images/100/Picture100-25.png) 

-  This will bring up the **Create Autonomous Data Warehouse** screen where you will specify the configurations of the instance. Select the root compartment, or another compartment of your choice.

![](./images/100/Picture100-26.jpg)

-  Specify a memorable display name for the instance. Also specify your database's name (e.g. **ADW_FlightDelay**).

![](./images/100/Picture100-27.jpeg)

-  Next, select the number of CPUs and storage size. Here, we will use **1 CPU** and **1 TB of storage**.

![](./images/100/Picture100-28.jpeg)

-  Then, specify an **ADMIN password** for the instance.

![](./images/100/Picture100-29.jpeg)

-  For this lab, we will select **Subscribe To A New Database License**. If your organization owns Oracle Database licenses already, you may bring those license to your cloud service.

![](./images/100/Picture100-37.JPG)

-  Make sure everything is filled out correctly, then proceed to click on **Create Autonomous Data Warehouse**.

![](./images/100/Picture100-31.jpeg)

-  Your instance will begin provisioning. Once the state goes from Provisioning to Available, click on your display name to see its details.

![](./images/100/Picture100-32.jpeg)

-  You now have created your first Autonomous Data Warehouse instance. Have a look at your instance's details here including its name, database version, CPU count and storage size.

![](./images/100/Picture100-33.jpeg)


## Part 2. Creating OML Users
### **STEP 3: Creating OML Users**

- Click the **Service Console** button on your Autonomous Data Warehouse details page.

![](./images/100/Picture100-34.jpeg)

- Click the **Administration** tab and click **Manage Oracle ML Users** to go to the OML user management page.

![](./images/100/Picture100-35.jpeg)

This will open OML user Administration page as a new tab within your browser. 

-   Click **Create** button to create a new OML user. Note that this will also create a new database user with the same name. This newly created user will be able to use the OML notebook application. Note that you can also enter an email address to send an email confirmation to your user (*for this lab you can use your own personal email address*) when creating the user.

![](./images/100/Picture700-5.png)

-   Enter the required information for new user (Username:**omluser1** and Password). If you supplied a valid **email address**, a welcome email should arrive within a few minutes to your Inbox. Click the **Create** button, in the top-right corner of the page, to create the user.

![](./images/100/Picture700-7.png)

-   Below is a welcome email. It includes a direct link to the OML application for the user. 

![](./images/100/Picture700-8.png)

-   After you click **Create**, you can find the user on the list of Users. 

![](./images/100/Picture700-9.png)

-   Using the same steps, create another user named **omluser2**.

![](./images/100/Picture700-10.png)

You will use **omluser1** later in this workshop. 


## Great Work - All Done with Lab100!
**You are ready to move on to the next lab. You may now close this tab.**
