## Populating the Table

## Introduction

In this module, you will learn how to insert data into a table from a REST API.

### Background Information

The **apex\_data_parser** is a PL/SQL package which provides an easy interface to parse files from various file formats, including comma-delimited (.csv). The parser is implemented as a table function - so the developer accesses parser results like a table. Therefore, the parser can utilize INSERT ... SELECT statements to insert rows directly into a table from the specified file.

The **apex\_web\_service.make\_rest\_request\_b** is a PL/SQL function which invokes a RESTful style Web service and returns the results in a BLOB. Utilizing this function within apex_data_parser will allow you to load data from a REST API directly into your table.

## **STEP 1** - Create a Script
Rather than running a one-off SQL statement to load the data, writing a SQL Script enables the SQL statement to be run repeatedly.

The Big Mac Data is refreshed every 6 months. Therefore, this script can be used twice a year to keep the data current.

1. From the runtime environment, in the Developer Toolbar (bottom of screen), click **Home**

    ![](images/go-home.png " ")

2. Click **SQL Workshop**, and then select **SQL Scripts**

    ![](images/go-sql-scripts.png " ")

3. In the SQL Script page toolbar, click **Create**.

4. In the Script Editor page, enter the following:
    - Script Name - enter **Populate BIG\_MAC\_INDEX**
    -  Copy and paste the following:

        ```
        <copy>-- Remove current data
        delete big_mac_index;

        -- Load data from The Economist (csv) REST API
        insert into big_mac_index
        (country_name, iso, currency_code, local_price, dollar_exchange_rate, gdp_dollar, entry_date)  
        select col001, col002, col003, col004, col005, col006, to_date(col007,'YYYY-MM-DD')  
        from table(apex_data_parser.parse  
          (  p_content => apex_web_service.make_rest_request_b
                ('https://raw.githubusercontent.com/TheEconomist/big-mac-data/master/source-data/big-mac-source-data.csv', 'GET')  
           , p_file_name => 'big-mac-source-data.csv'  
           , p_skip_rows => 1  
          )  
        );

        -- Delete bad data (rows with no price)
        delete big_mac_index  
        where local_price = 0;</copy>
        ```
    Click **Run**

    ![](images/set-script.png " ")

5. On the Run Script page, click **Run Now**.

6. The Script Results page will be displayed listing the statements processed, successful, and with errors.     
    In February 2020, Results should show **1586 row(s) inserted** and **1 row(s) deleted**.

    ![](images/script-results.png " ")

    *{Note: If you do not see 3 statements processed successfully then double check your table definition and the script to populate the table.}*

## **STEP 2** - Review the Data
There are several ways to review the data.

1. Navigate to the runtime environment tab or window.

2. In the application menu click **Mac Index**.
    On the report, click **Entry Date**, and click **Sort Ascending**, to see the latest data.

    ![](images/runtime.png " ")

    *{Note: Many of the Dollar Exchange Rate values simply show 1.}*

3. In the APEX Builder tab or window, click **SQL Workshop**, and then select **Object Browser**.

    ![](images/go-object-browser.png " ")

4. In Object Browser, within the list of Tables, click **BIG\_MAC_INDEX**.  
    In the middle pane, click **Data**.

    ![](images/review-data.png " ")

    *{Note: Review the decimal places on the _DOLLAR\_EXCHANGE\_RATE_ column. In the next module you will ensure the data displays properly.}*

## **Summary**
This completes Module 3. You now know how to utilize **apex\_data\_parser** and **apex\_web\_service.make\_rest\_request\_b** to populate a table in the Oracle database based on a REST endpoint. [Click here to navigate to Module 4](?lab=lab-4-improving-report)

## **Acknowledgements**

 - **Author/Contributors** -  David Peake, Consulting Member of Technical Staff
 - **Last Updated By/Date** - Tom McGinn, Database Cloud Services, Product Management, June 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

