# Getting Started with Oracle Analytics Cloud (OAC)

<!-- Comment out table of contents
## Table of Contents
[Introduction](#introduction)
-->

## Introduction

This lab walks you through the steps to use an existing Oracle Analytics Cloud (OAC) instance to connect to your Autonomous Data Warehouse (ADW) instance.


*In addition to the workshop*, feel free to watch the walkthrough companion video by clicking on the following image:
[![Lab 400 Walkthrough Video](./images/lab400tn.png " ")](https://www.youtube.com/watch?v=H_SGzbIW3DA "Lab 400 Walkthrough Video - Click to Watch!")


### Objectives
-   Learn how to navigate to an Oracle Analytics Cloud instance
-   Learn how to connect the OAC instance to your ADW instance

### Required Artifacts
-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
-   The estimated time to complete this lab is 40 minutes.

### Extra Resources
-   To learn more about Oracle Analytics Cloud (OAC), feel free to explore the capabilities by clicking on this link: [OAC Overview](https://www.oracle.com/business-analytics/analytics-cloud.html)

## Part 0. Create an OAC Instance (*ONLY* if you do not already have one)

-   *Note*: If you already have an OAC instance provisioned, please skip "Part 0" and proceed to "Part 1" of this lab guide.

1.   To begin, make sure to already be signed in to cloud.oracle.com with your account credentials as done before in the previous labs.

2.   Then, in the Oracle Cloud console, click on the **Hamburger menu** icon. Then, scroll down to the **Solutions and Platform** section, hover over **Analytics** and then click on **Analytics Cloud**. 

   ![](./images/0a.png " ")

3.   Make sure you are in the correct compartment by selecting your compartment from the dropdown on the lefthand side (hint: use the same compartment as your ADW instance).  Then, cllick on **Create Instance**.

   ![](./images/ob.png " ")

4.   Provide all the required information. For the **Instance Name**, input a name such as **OACDEMO**.  Make sure that you have the correct compartment selected (use the same one that you have your ADW instance in).  Leave the rest of the selections as the default selections, as shown in the image below.  When you are finished, click **Create**.

   ![](./images/0c.png " ")

7.   It will take a few minutes (could be up to 10 minutes) until your instance is fully provisioned and ready to use. Note the Status 'CREATING' shows that the service is being created. Wait until this process is fully completed, then the status will change.

   ![](./images/0d.png " ")

8.   After a few minutes refresh your page to see if your instance is available. Once your instance is green and in the 'ACTIVE' state, now your OAC instance is ready. In order to access your instance, click  **Open URL**. This will redirect you to a new page to the OAC home console. Save this web page link for future use.

   ![](./images/0e.png " ")

9.   Welcome to the Oracle Analytics Cloud! Enjoy exploring it! If you are on the OAC home console page, as shown below, please skip "Part 1" as you already successfully created and navigated to your OAC instance.

   ![](./images/0g.png " ")

## Part 1. Navigate to an OAC Instance

### **STEP 1**: Go to the Analytics Cloud Instance Page

1. If you are not already signed in, sign in to cloud.oracle.com with your account credentials as done in the previous labs.

2. Click on the **Hamburger menu** icon. Then, scroll down to the **Solutions and Platform** section, hover over **Analytics** and then click on **Analytics Cloud**. 

    ![](./images/0a.png " ")

3. Make sure that you are in the correct compartment by using the dropdown menu on the lefthand side of your screen.  Then, find your OAC instance that you will be using. For example, we are using the OAC instance **OACDEMO** shown below.  In order to access your instance, click on the **menu icon**, denoted by triple dots, on the right side of your instance. Then, click on **Open URL** which redirects you to a new page. Save this web page link for future use.

    ![](./images/0a2.png " ")

5. Welcome to the Oracle Analytics Cloud! Enjoy exploring it!

    ![](./images/0g.png " ")


## Part 2. Connect OAC to ADW

### **STEP 1**: Connect OAC to ADW

1. In the Oracle Analytics Cloud Homepage, click on the **Create** button on the top-right and then click on **Connection** in the popped menu.

    ![](./images/0h.png " ")

2. Select the **Oracle Autonomous Data Warehouse Cloud** from the existing connection types.

    ![](./images/0i.png " ")

3. Complete all the required fields in the wizard as described in the steps below and Save the connection. Note that you need the ADW instance **Wallet** file in order to be able to complete these fields (this step is similar to connecting  SQL Developer to the ADW instance). Please refer to previous labs for a refresher on how to access a Wallet file if needed.

4. You should fill the following connection fields, then click **Save**:

-   **Connection Name:** Type a name for this connection. For this, use the name you specified for your ADW: **ADW\_FIRSTNAME\_LASTNAME**. Note: In the screenshot below, it is shown as simply "ADWDEMO".

-   **Client Credentials:** Click on **‘Select’** and select the zipped **Wallet** file (The **cwallet.sso** file will be automatically extracted from the **Wallet** file)

-   **Username:** Admin (the username you created during the ADW provisioning).

-   **Password:** The password you specified during the provisioning of your ADW instance.

-   **Service Name:** Select your database name and desired service level (low, medium, high) from the drop down list. For this lab, select your instance service named **ADW\_FIRSTNAME\_LASTNAME\_high**.

    ![](./images/0j.png " ")

5. You can now see your connection listed under the Connections tab in the Data page.

    ![](./images/0k.png " ")


## Part 3. Import Datasets from ADW to OAC

### **STEP 1**: Configure a Database Connection

1. In the Oracle Analytics Cloud Homepage, click on the **Create** button on the top-right and then click on **Data Set** in the popped menu.

    ![](./images/1.png " ")

2. Select the connection that you have created in previous step.

    ![](./images/2.png " ")

3. Select the **DEVELOPER** user from the list of users to import the datasets prepared in SQL Developer.

    ![](./images/3.png " ")

### **STEP 2**: Import the Datasets to OAC

Now we will import the following tables to OAC: 
> OOW\_DEMO\_STORES, OOW\_DEMO\_REGIONS, OOW\_DEMO\_ITEMS, and OOW\_DEMO\_SALES_HISTORY

In the next steps, we show you how to import the **OOW\_DEMO\_STORES** table. You can repeat the same steps to import the other three tables.

1. Select the desired table (*OOW\_DEMO\_STORES* is the first one to import) from the list.

    ![](./images/4.png " ")

2. Add all columns to your selection by clicking on **Add All**. The auto-generated name for the new table will work fine. 

    ![](./images/5.png " ")

3. Finish by clicking on **Add**. 

    ![](./images/6.png " ")

4. When the data set is loaded, change columns containing **ID** (such as *ID*, *REGION\_ID*, *STORE\_ID*, *PRODUCT\_ID*, etc.) from **Measure** type to **Attribute** type. In order to do so, click on the # sign next to the column name and select **Attribute** from the drop-down menu. Each data set will have a varying amount of columns containing **ID**. Make sure to check through all columns. The reason for changing the type is because we will not be performing any math operations on the IDs and hence we should treat the IDs as attributes.

    ![](./images/7.png " ")

5. Then click on **Apply Script**.

    ![](./images/8.png " ")

6. You are done with adding the first table. 

### **STEP 3**: Add Additional Datasets

1. Repeat "Part 3 STEP 1" and "Part 3 STEP 2" for the remaining 3 tables mentioned above
> (OOW\_DEMO\_REGIONS, OOW\_DEMO\_ITEMS, and OOW\_DEMO\_SALES\_HISTORY tables ).

2. After importing all the tables, you can see them by first clicking the **Hamburger menu** icon and then click on the **Data** section which should default to the **Data Sets** tab. 

    ![](./images/9.png " ")

3. Confirm that you have imported 4 tables.

    ![](./images/10.png " ")

## Part 4. Create a Data Flow

### **STEP 1**: Add and Join the Datasets

1. First, navigate back to the Oracle Analytics Cloud home page. Once you are back on the home page, click on **Create**, then on **Data Flow** to create a new data flow. 

    ![](./images/11.png " ")

2. A window will pop up asking for data sets to be selected. Continue by clicking on the *OOW\_DEMO\_REGIONS* Data Set and then clicking on **Add**.

    ![](./images/12.png " ")

3. Click on the **Circled Plus** button and then on **Add Data**.

    ![](./images/13.png " ")

4. Add the next data set *OOW\_DEMO\_STORES* by clicking on it and then clicking on **Add**.

    ![](./images/14.png " ")

5. This will generate a Join step in the Data Flow Diagram. Modify it by selecting **All rows** in the drop down box for **Input 2** in the **Keep Rows** section.

    ![](./images/15.png " ")

6. Then, scroll down and under the **Match Columns** section, click on **ID** and then change it to **REGION_ID** from the drop down box for **Input 2**.

    ![](./images/16.png " ")

7. After configuring this Join step, click on the **Circled Plus** button again and then on **Add Data**.

    ![](./images/17.png " ")

8. Then add the next data set *OOW\_DEMO\_SALES\_HISTORY* by clicking on it and then clicking on **Add**.

    ![](./images/18.png " ")

9. This will generate another Join step in the Data Flow Diagram. Modify it by selecting **All rows** in the drop down box for **Input 2** in the **Keep Rows** section.

    ![](./images/19.png " ")

10. Then, scroll down and under the **Match Columns** section, click on **ID** for **Input 1** and change it to **ID\_1** and click on **ID** for **Input 2** and change it to **STORE\_ID**.

    ![](./images/20.png " ")

11. After configuring this second Join step, click on the **Circled Plus** button again and then on **Add Data**.

    ![](./images/21.png " ")

12. Then add the next data set *OOW\_DEMO\_ITEMS* by clicking on it and then clicking on **Add**.

    ![](./images/22.png " ")

13. This will generate the third Join step in the Data Flow Diagram. Modify it by selecting **All rows** in the drop down box for **Input 1** in the **Keep Rows** section. Keep **Input 2** as **Matching rows**.

    ![](./images/23.png " ")

14. Then, scroll down and under the **Match Columns** section, click on **ID** for **Input 1** and change it to **PRODUCT_ID**.

    ![](./images/24.png " ")

15. Now the 4 Data Sets have been joined.

### **STEP 2**: Select Columns

1. Since we are done adding the Join steps, click on the **Circled Plus** button again and then on **Select Columns** to help finalize the columns we want to keep.

![](./images/25.png " ")

2. All the columns will be selected. Let's select some columns we want to remove from this list by holding the ctrl button(Windows) or the command button(MacOS) and left clicking on the columns. Select the following:
> *IS\_DEFAULT\_YN*, *REGION\_COLOR*, *REGION\_ZOOM*, *ROW\_VERSION\_NUMBER*, *N1*, *N2*, *N3*, *N4*, *REGION\_ID*, *ROW\_VERSION\_NUMBER\_1*, *ID\_2*, *CREATED\_ON*, *DATE\_OF\_SALE*, *PRODUCT\_ID*, *STORE\_ID*, and *ROW\_VERSION\_NUMBER\_2*.

3. Having selected all the above columns, click **Remove selected**.

    ![](./images/26.png " ")

4. We are done with selecting our columns. 

### **STEP 3**: Rename Columns

1. Let's rename some columns. Click on the **Circled Plus** button again and then on **Rename Columns** to help finalize the columns we want.

    ![](./images/27.png " ")

2. Under the **Source** column, find **ID** and change the value in the **Rename** column to **REGION_ID**.

    ![](./images/28.png " ")

3. Next, keep scrolling down and under the **Source** column, find *ID_1* and change the value in the **Rename** column to *STORE_ID*.

4. Then, find *ID_3* and change the value in the **Rename** column to *ITEM_ID*.

5. Finally, find **MSRP** and change the value in the **Rename** column to **SALE_PRICE**.

6. We are done renaming columns. 

### **STEP 2**: Add Columns

1. Let's finish constructing our master table by adding columns. Do this by clicking on the **Circled Plus** button again and then on **Add Columns** to help finalize the columns.

    ![](./images/29.png " ")

2. In the **Name** box, input **SALES**.

    ![](./images/30.png " ")

3. In the code calculation box, type in (without the quotes): "QUANTITY"

4. Wait a few seconds as the search query goes through and then click on the **# QUANTITY** popup.

    ![](./images/31.png " ")

5. Afterwards, continue typing the following (without the quotes): " * SALE_PRICE"

6. Wait a few seconds as the search query goes through and then click on the **# SALE_PRICE** popup.

    ![](./images/32.png " ")

7. Scroll down and click **Validate**.

    ![](./images/33.png " ")

8. After the calculation is validated, finish by clicking **Apply**.

    ![](./images/34.png " ")

9. Click on the **Gray Circled Plus** icon to add more columns. In the **Name** box, input **Discount**.

    ![](./images/35.png " ")

10. In the code calculation box, type in (without the quotes): "(ITEM_PRICE"

11. Wait a few seconds as the search query goes through and then click on the **A ITEM_PRICE** popup.

    ![](./images/36.png " ")

12. Afterwards, continue typing the following (without the quotes): "- SALE_PRICE)"

13. Wait a few seconds as the search query goes through and then click on the **# SALE_PRICE** popup.

14. Then, continue typing the following (without the quotes): "/ ITEM_PRICE"

15. Wait a few seconds as the search query goes through and then click on the **# ITEM_PRICE** popup.

    ![](./images/37.png " ")

16. Scroll down and click **Validate**. After the calculation is validated, finish by clicking **Apply**.

    ![](./images/38.png " ")

17. Click on the **Gray Circled Plus** icon to add more columns. In the **Name** box, input **TRANSACTIONS**.

18. In the code calculation box, type in (without the quotes): "1"

    ![](./images/39.png " ")

19. Scroll down and click **Validate**. After the calculation is validated, finish by clicking **Apply**.

20. Now, click the **Circled Plus** icon to make a **Branch**. 

    ![](./images/40.png " ")

21. Click the first **Save Data** in the data flow.  

    ![](./images/41.png " ")

22. Make the name **Master_Table**.

    ![](./images/42.png " ")

23. Click the second **Save Data** in the data flow.  Make the name *Master\_Table\_ADW*. 

    ![](./images/43.png " ")

24. Change the **Save data to** dropdown box option to **Database Connection**. 

    ![](./images/44.png " ")

25. Click **Select connection**.

    ![](./images/45.png " ")

26. Select the connection.

    ![](./images/46.png " ")

27. Save the entire Data Flow by clicking the top right **Save** button.

    ![](./images/47.png " ")

28. Name it **Demo Data Flow**.

    ![](./images/48.png " ")

29. After it's saved, click **Run Data Flow**.

    ![](./images/49.png " ")

30. You are done creating the data flows for OAC. With this initial setup, your data flow now lets you take one or more data sources and organize and integrate them to produce a curated set of data that you can use to easily create effective visualizations. Time for visualizations!


## Summary

-   In this lab, you provisioned a new Oracle Analytics Cloud (OAC) instance and connected your OAC instance to your Autonomouse Data Warehouse (ADW) instance.

-   **You are ready to move on to the next lab!**

## Acknowledgements

- **Author** - NATD Cloud Engineering - Austin Hub (Khader Mohiuddin, Jess Rein, Philip Pavlov, Naresh Sanodariya, Parshwa Shah)
- **Last Updated By/Date** - Jess Rein, Cloud Engineer, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request. 
