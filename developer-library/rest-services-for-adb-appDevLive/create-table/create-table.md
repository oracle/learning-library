# Modern Application Development with Oracle REST Data Services - Creating and auto-REST enable a Table

## Introduction

In this lab you will use the SQL Developer Web browser-based tool, connect to your Database, create and REST enable a table.

Estimated Lab Time: 15 minutes

### Objectives

- Create and Auto-REST enable a table

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- Completed the [User Setups Lab](../user-setups/user_setups.md)

## **STEP 1**: Load data into the Database

1. After signing in as **admin** from the previous lab (connecting to Database Actions/SQL Developer Web), we end up on the overview page. Click the SQL tile.

    ![Database Actions Home Page, Click SQL tile](./images/sdw-15.png)

**If this is your first time accessing the SQL Worksheet, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

2. We are now ready to load data into the database. For this task, we will use the Data Loading tab in the SQL Worksheet.

    ![Click Data Loading Tab on SQL Worksheet](./images/sdw-16.png)

3. Start by clicking the Data Loading area; the center of the gray dotted-line box.

    ![Click the Center of the Data Loading Tab Area](./images/sdw-17.png)

4. The Upload Data into New Table model will appear.

    ![To upload a file, Drag into the File Load Modal or Click Select File and use the OS File Browser](./images/sdw-18.png)

5. We are going to use some sample data to load data into the database and create a table at the same time. Start by downloading this file

    **(right-click and download the file with the following link)**

    [csv data](https://objectstorage.us-ashburn-1.oraclecloud.com/p/pp_oz_4cJpg26fUsPQYshv6G--X4TmAkpRKeFdZWzQ_XuG-eVCo3Ea3Mz1u4RxKI/n/c4u03/b/developer-library/o/csv_data.csv)

6. Once on your desktop, drag the file into the Upload Data into New Table model. You can also click the Select Files button and find where you downloaded it via your operating system's file browser.

    ![Click the Next Button](./images/sdw-19.png)

7. The modal will then give you a preview of what the data will look like in an Oracle table. Go ahead and click the Next button on the bottom right of the modal.

    ![View Data Preview and then Click Next Button](./images/sdw-20.png)

8. On the following step of the data loading modal, we can see the name of the table we are going to create (CSV_DATA) as well as the column and data types for the table.

    ![Data Column Layout from uploaded file](./images/sdw-21.png)

    Click Next on the bottom right of the modal when done looking at this step.

    ![Check out data then Click Next Button](./images/sdw-22.png)

9. On the last step of the modal, we can see a review of the table name and source file

    ![Review of Table Name and Surce File](./images/sdw-23.png)

    the DDL (Data Definition Language) for creating the table

    ![The Data Definition Language preview for the table and data](./images/sdw-24.png)

    and if you scroll down, the column mappings.

    ![Check out data then Click Next Button](./images/sdw-25.png)

10. When you are done taking a look, click the Finish button in the lower right of the modal.

    ![Click Finish in the Data Loading Modal](./images/sdw-27.png)

    The Data Loader will now process the file by creating a table and loading the CSV file data into that table. 

    ![Data Will Load Into the Database indicated by the Uploading Data Modal](./images/sdw-28.png)

    Once its done, you will see a row in the Data Loading tab that indicates how many rows were uploaded, if any failed and the table name.

    ![Row indicating data load is finished in the Data Loading Tab of the SQL Worksheet](./images/sdw-29.png)

11. We can take a look at our newly created table and the data in it by using the navigator on the left of the SQL Worksheet. Just right click the table name and select Open from the pop up menu.

    ![Using the navigator on the left of the SQL Worksheet, we can see out new table](./images/sdw-30.png)

    In the slider that has come out from the right of the page, we can look at the data definition, triggers, constraints and even the data itself.

    ![Click the Data option to view the table data](./images/sdw-31.png)

## **STEP 2:** Auto-REST Enable a Table

1. REST enabling a table couldn't be easier. To do this, find the table we just created named **CSV_DATA** in the navigator on the left of the SQL Worksheet.

    ![Using the navigator on the left of the SQL Worksheet, find the CSV_DATA Table](./images/sdw-32.png)

2. Right click on the table name and select **REST** in the pop up menu then **Enable**.

    ![Right click on the table name and select REST in the pop up menu then Enable](./images/sdw-33.png)

3. The REST Enable Object slider will appear from the right side of the page. Keep the default values and when ready, click the **Enable** button in the lower right of the slider.

    ![The REST Enable Object Slider, view the Preview URL](./images/sdw-34.png)

4. Thats it! Your table is REST enabled. We can work with the REST endpoints by using cURL commands that the SQL Worksheet can provide to us. To get to these endpoints, again right click the table name as we did in the previous step, select **REST**, then **cURL Command**.

    ![right click the table name in the navigator, select REST, then cURL Command](./images/sdw-37.png)

    On the right of the page, we see the cURL for the table CSV_DATA side out panel.

    ![the cURL for the table CSV_DATA side out panel](./images/sdw-38.png)

5. Here we can work with the various REST endpoints. To try one, click the copy icon ![copy icon](./images/copy-copy.png) for the **GET ALL** endpoint.

    ![Click the copy icon for GET ALL](./images/sdw-39.png)

6. You can use this cURL command we just copied in the OCI Cloud Shell or on your local compute if cURL is installed. Here is the command running:

    ```
    >curl --location \
    'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/'

    {"items":[{"col1":"e40a9db6","col2":"1b","col3":"27531","links":[{"rel":"self","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/
    ords/admin/csv_data/AAAYuOAAAAAAF3%2FAAA"}]},{"col1":"6182c817","col2":"73","col3":"5355332","links":[{"rel":"self","href":"https://coolrestlab-adb21.adb.
    eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/AAAYuOAAAAAAF3%2FAAB"}]},{"col1":"5ed9e437","col2":"d2","col3":"4834758","links":[{"rel":"self",
    "href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/AAAYuOAAAAAAF3%2FAAC"}]},{"col1":"d77868a1","col2":"64",
    "col3":"2129797","links":[{"rel":"self","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/
    AAAYuOAAAAAAF3%2FAAD"}]},{"col1":"09bfaa73","col2":"89","col3":"3294896","links":[{"rel":"self","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.
    oraclecloudapps.com/ords/admin/csv_data/AAAYuOAAAAAAF3%2FAAE"}]},{"col1":"5054cca2","col2":"97","col3":"3474577","links":[{"rel":"self","href":"https://
    coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/AAAYuOAAAAAAF3%2FAAF"}]},{"col1":"d20e9eb4","col2":"7c","col3":"2728720",
    "links":[{"rel":"self","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/AAAYuOAAAAAAF3%2FAAG"}]}],
    "hasMore":false,"limit":25,"offset":0,"count":7,"links":[{"rel":"self","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/
    admin/csv_data/"},{"rel":"edit","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/"},{"rel":"describedby",
    "href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/metadata-catalog/csv_data/"},{"rel":"first","href":"https://
    coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/"}]}% 
    ```

The next lab will go over using the **BATCH LOAD** endpoint.

## Conclusion

In this lab, you created a table from a csv file and REST enabled it with auto-REST.

You may now [proceed to the next lab](#next).


## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - Brianna Ambler, June 2021
- **Workshop Expiry Date** - May 2022
