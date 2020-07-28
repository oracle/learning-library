# Getting Started with Oracle Analytics Cloud (OAC)

![](images/300/Picture300-lab.png)  
Updated: January 4, 2019

## Introduction

This lab walks you through the steps to provision an Oracle Analytics Cloud (OAC) instance and connect it to your Autonomous Data Warehouse (ADW) instance.


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives
-   Learn how to provision a new Oracle Analytics Cloud Instance
-   Learn how to connect the OAC instance to your to the ADW

## Required Artifacts
-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.



# Provision Oracle Analytics Cloud (OAC) and Connect to Autonomous Data Warehouse (ADW)

## Part 1. Create an OAC Instance
In this section you will create an OAC instance.


### **STEP 1: Sign in to Oracle Cloud**

-   Go to [cloud.oracle.com](https://cloud.oracle.com), click **Sign In** to sign in with your Oracle Cloud account.

![](./images/300/Picture300-2.png)

-   Enter your **Cloud Account Name** and click **My Services**.

![](./images/300/Picture300-3.jpg)

-   Enter your Oracle Cloud **username** and **password**, and click **Sign In**.

![](./images/300/Picture300-4.png)



### **STEP 2: Create an OAC Instance**

-   Go to your **Dashboard** page by clicking **Platform Services** from the OCI Console navigation menu then select **Analytics**.

![](images/LabGuide300-029b17f5_v2.png)

- Click on **Create Instance**.

![](./images/300/Picture300-21.png)

-   Under **All Services**, find **Analytics** and click on **Create**.

![](./images/300/analyticsDash.png)

-   On the **Analytics** page, click on **Create Instance**.

![](./images/300/AnalyticsInstance.png)

-   Provide all the required information (fields specified by \*) and then click on **Next**.

![](./images/300/Picture300-24.png)

-   After validating your configuration, click on **Create**.

![](./images/300/Picture300-25.png)

-   It will take a few minutes until your instance is fully provisioned and ready to use. Note the Status and the sign which indicate that the service is being creating. Wait until this process is fully completed.

![](./images/300/OACprovision.png)

-   After a few minutes refresh your page and you will see the status and the sign are disappeared. Now your OAC instance is ready. In order to access your instance, click on the hamburger icon on the right side of your instance.

![](./images/300/expand.png)

-   Now click on Analytics URL which redirects you to a new page.

![](./images/300/OACURL.png)


-   Welcome to the Oracle Analytic Cloud! Enjoy exploring it!

![](./images/300/Picture300-29.png)




## Part 2. Connect OAC to ADW

### **STEP 3: Connect OAC to ADW**

-   In the Oracle Analytics Cloud Homepage, click on the **Create** button on the top-right and then click on **Connection** in the popped menu.

![](./images/300/Picture300-31.png)

-   Select the **Oracle Autonomous Data Warehouse Cloud** from the existing connection types.

![](./images/300/Picture300-32.png)

-   Complete all the required fields in the wizard as described in the table below and Save the connection. Note that you need the ADW instance **Wallet** in order to be able to complete these fields (similar to connecting the SQL Developer to the ADW instance). Please refer to the instruction in **Lab100** for accessing the **Wallet**.


-   You should fill the following connection fields, then click **Save**:

-   **Connection Name:** Type a name for this connection (e.g. ADWDBBIKESHARE)

-   **Client Credentials:** Click on **‘Select’** and select the zipped **Wallet** file (The **cwallet.sso** file will be automatically extracted from the **Wallet** file)

-   **Username:** Admin (the username you created during the ADW provisioning)

-   **Password:** The password you specified during provision of your ADW instance

-   **Service Name:** Select your database name and desired service level (low, medium, high) from the drop down list. (e.g.  dbbikeshare_high)

![](images/300/Picture300-33-updated.png)



-   You can see your connection listed under the Connections tab in the Data page.

![](./images/300/Picture300-34.png)



## Part 3. Import Datasets from ADW to OAC

### **STEP 4: Import the Training Datasets for the ML Model to OAC**

-   In the Oracle Analytics Cloud Homepage, click on the **Create** button on the top-right and then click on **Data Set** in the popped menu.

![](./images/300/Picture300-41.png)

-   Select the connection that you have created in previous step.

![](./images/300/Picture300-42.png)

-   Select the **ADMIN** user from the list of users to import the datasets prepared in the SQL Developer.

![](./images/300/Picture300-43.png)


Now we should import the **STATION_INFO** and **STATION_ST_WTH_TRAINING** tables prepared in the SQL Developer to our OAC instance. We need the **STATION_INFO** table for creating the graphs and the **STATION_ST_WTH_TRAINING** table for training the ML model in OAC. In next steps, we show you how to import the **STATION_ST_WTH_TRAINING** table. You can repeat the same steps to import the **STATION_INFO** table.


-   Select the desired table (**STATION_ST_WTH_TRAINING**) from the list.

![](./images/300/Picture300-44.png)

-   Add all columns to your selection.

![](./images/300/Picture300-45.png)

-   Give a name to the table (**STATION_ST_WTH_TRAINING**) and add it to your data set.

![](./images/300/Picture300-46.png)

-   When the data set is loaded, change the **STATIONID** column from **Measure** type to **Attribute** type. In order to do so, click on the # sign next to the column name and select **Attribute** from the drop-down menu.

![](./images/300/Picture300-47.png)


-    Then click on **Apply Script**.

![](./images/300/Picture300-48.png)


-   After importing all tables, you can see them under the **Data Set** tab in the **Data** section.

![](./images/300/Picture300-45.png)


## Great Work - All Done with Lab300!
**You are ready to move on to the next lab. You may now close this tab.**
