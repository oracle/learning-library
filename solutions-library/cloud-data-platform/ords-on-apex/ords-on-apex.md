# Oracle Restful Data Services (ORDS) in APEX

<!-- Comment out table of contents
## Table of Contents
[Introduction](#introduction)
-->

## Introduction

This lab walks you through the steps to enabling Oracle Restful Data Services (ORDS) with APEX in order to call and create APIs.


*In addition to the workshop*, feel free to watch the walkthrough companion video by clicking on the following image:
[![Lab 300 Walkthrough Video](./images/lab300tn.png " ")](https://www.youtube.com/watch?v=Zq0qEgF0bMU "Lab 300 Walkthrough Video - Click to Watch!")


### Objectives
-   Learn how to enable Oracle Restful Data Services (ORDS) with APEX
-   Learn how to import SQL queries as APIs in APEX
-   Learn how to create a REST API using APEX

### Required Artifacts
-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
-   The estimated time to complete this lab is 20 minutes.

### Extra Resources
-   To learn more about Oracle REST Data Services (ORDS), feel free to explore the capabilities by clicking on this link: [ORDS Documentation](https://docs.oracle.com/en/database/oracle/oracle-rest-data-services/19.4/index.html)


## Part 1. Enable ORDS

### **STEP 1**: Access Your APEX App

1. Navigate to and click on **Oracle APEX** from the development page of your ADW instance service console.

    ![](./images/3.png " ")

2. Sign in as **developer** to the **developer** workspace with the appropriate browser.

    ![](./images/4.png " ")

### **STEP 2**: Enable Oracle Restful Data Services (ORDS)

1. Click on **SQL Workshop** and then on **RESTful Services**.

    ![](./images/5.png " ")

2. Then, click on **Register Schema with ORDS**.

    ![](./images/6.png " ")

3. A Schema attributes window will pop up. Click **Save Schema Attributes** to continue.

    ![](./images/7.png " ")

## Part 2. Import and Create APIs

### **STEP 1**: Import APIs

1. Click on **Import**. 

    ![](./images/8.png " ")

2. You will download a data file from this workshop for your APIs. You can download it by clicking on the following text link: [Download ORDS-REST-DEMO.sql here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/kKVRLnqKZkJCLhySyrSngqQ_5riJ8pGGmbepcgy0c8w/n/c4u03/b/solutions-library/o/ORDS-REST-DEMO.sql). Then, return back to your browser window.

3. Click on **Choose File** and select **ORDS-REST-DEMO.sql**, the file you just downloaded for this workshop.

4. Finish by clicking on **Import**.

    ![](./images/9new.png " ")

>    *Note: If you encounter the error **"Unable to Import. Insufficient Privileges"** when importing your .sql file, this means that there is a problem with your schema defined in the .sql file.  To solve this issue, you can go into the .sql file and alter the schema names to reflect whatever you named your workspace/username as in Lab 100.  In your .sql file, simply change 'DEVELOPER' to your workspace/username in the lines denoted by the arrows below. Once you have executed this change, save the file, and try again to import.*

>   ![](./images/9b.png " ")

5. The APIs have now been imported. You can view them by clicking the arrow button to expand **Modules** and then **warehouseAPI**. The APIs interface with the data that is on the Autonomous Data Warehouse that you have provisioned and APEX serves as the front end.

    ![](./images/10new.png " ")


### **STEP 2**: Create APIs

1. Click on **warehouseAPI** to show the API template list.

2. Then click on **Create Template** to construct your own custom API.

    ![](./images/11new.png " ")

3. We will construct a regions API that showcases all the store regions. Enter **regions** into the URI Template input field.

4. Finish by clicking on **Create Template**.

    ![](./images/12new.png " ")

5. We will now need to create a resource handler in order for the API to run a script. Click **Create Handler** to get started.

    ![](./images/13new.png " ")

6. The API will make a GET REST call to query the data from the ADW.

7. Change the **Source Type** to **Query**.

8. Then, input the following into the Source box:
> select * from OOW\_DEMO\_REGIONS

9. Finish by clicking on **Create Handler**.

    ![](./images/14new.png " ")

### **STEP 3**: Check and Test APIS

1. You have now imported and created various RESTful APIs with APEX. 

2. Grab the **Full URL** of the regions API you just created and paste it into your browser and press the enter button.

    ![](./images/15new.png " ")

3. You will see all the different regions from the data in your ADW. You can now utilize this data however you want.

    ![](./images/16.png " ")

4. Navigate to the **stores** API and copy and paste the Full URL into your browser (or another tool such as Postman) to see the different stores.

    ![](./images/17new.png " ")

5. Here is what your browser should look like if you copy the Full URL of the API and paste the link into your browser.

    ![](./images/18.png " ")

## Part 3. Use HTML Web Page to Consume APIs

### **STEP 1**: Copy API URLs

1. Under **warehouseAPI**, click on the **stores** API and copy the **Full URL** and paste it into a separate notes file (i.e. Notepad, Microsoft Word, Apple Notes, etc.) to be used later.

    ![](./images/17v1.png " ")

2. Next, do the same with the following 2 APIs, copying each **Full URL** and pasting each into that same separate notes file.  Be sure to label which URL is which so that you do not confuse them later.
> product/inventoryForecastingAPI/{store\_add\}
> product/trendingProductAPI/{store\_add\}

   ![](./images/17v2.png " ")

   ![](./images/17v3.png " ")

### **STEP 2**: Add API URLs to Web Page Code

1. You will download a data file from this workshop for your web page. You can download it by clicking on the following text link: [Download WebPage.zip here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/SM0gd1zQgGI-O7fL3k3fUTP2zjsH7L6AEjc0WS_ckDk/n/c4u03/b/solutions-library/o/WebPage.zip).

2. Then, go to your Downloads folder and unzip the .zip file.

3. Once this folder is unzipped, navigate to the Functions.js file and right-click to open it with any text editor or IDE you have available (i.e. TextEdit, Notepad, Script Editor, Visual Studio, etc.)

4. With the .js file open, notice the **DEFINE STORES API REQUEST URL** instructions and follow the steps to paste your ‘stores’ API URL, from your notes, into the "stores api url" variable in the code. (Note: Refer to the next image below.)

5. Next, copy your ‘Inventory Forecasting’ API URL, from your notes, into the "inventory forecast api url" variable in the code using the **DEFINE INVENTORY FORECAST API REQUEST URL** instructions provided in the code. (Note: Be sure to read the instructions carefully, as they are different than the instructions for the ‘stores’ API URL.)

-   **NOTE: When pasting the Inventory Forecasting API URL, erase everything after inventoryForecastingAPI/ . Make sure to keep the / character at the end**. Here is how your .js file should look:

    ![](./images/21version2.png " ")

6. Once you have replaced the two URLs, you must resave the file. (Note: Make sure that you keep the .js file type when you save the file in your text editor. Also, be sure that when you are saving the updated file, you are replacing the original file in the **WebPage** folder.)

### **STEP 3**: Test API Calls on Web Page

1. You have now implemented your API URLs from APEX into the code for the HTML Web Page, so your APIs are ready to be consumed!

2. Navigate again to the **WebPage** folder in your downloads.

3. To open the web page, right click on the **Layout.html** file, select **Open With**, and select the web browser of your choice (Google Chrome and Safari supported).

4. When the web page opens up, you can navigate to the **Select Store:** dropdown.  When you click on the dropdown, the list of stores is populated by the response data of your ‘stores’ REST API call using the URL you provided in the code from APEX.

    ![](./images/22new.png " ")

5. Once you select a store from the dropdown, you can click the **See Store Details** button to see the product details for the selected store.

    ![](./images/23new.png " ")

6. The store details table is populated with the response data from the ‘Inventory Forecast’ REST API call using the URL you provided in the code from APEX.

7. Now, you can use the dropdown to view any store’s inventory and inventory prediction details!  Each time you select a new store and click the **View Store Details** button, a new API call is made to get the products for that specific store in order to populate the table.

## Summary

-   In this lab, you enabled Oracle Restful Data Services (ORDS) with APEX, imported SQL queries as APIs in APEX, and created a REST API using APEX.

## Acknowledgements

- **Author** - NATD Cloud Engineering - Austin Hub (Khader Mohiuddin, Jess Rein, Philip Pavlov, Naresh Sanodariya, Parshwa Shah)
- **Last Updated By/Date** - Jess Rein, Cloud Engineer, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.    Please include the workshop name and lab in your request. 

