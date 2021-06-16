# Modern Application Development with Oracle REST Data Services - Loading Data and Creating Business Objects

## Introduction

In this lab you will use the SQL Developer Web browser-based tool, connect to your Database, create and REST enable a table.

Estimated Lab Time: 10 minutes

### Objectives

- Load a CSV of over 2 million rows into the CSV_DATA table
- Create PL/SQL business objects in the database

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- Completed the [User Setups Lab](../user-setups/user_setups.md)
- Completed the [Create and auto-REST enable a table lab](../create_table/create_table.md)

## **STEP 1**: Load data into the Database

1. Start by again using the cURL slide out on our REST enabled table.

    ![right click the table name in the navigator, select REST, then cURL Command](./images/ld-1.png)

2. We now have the cURL for the table CSV_DATA slideout. 

    ![cURL for the table CSV_DATA slideout](./images/ld-2.png)

    Left click the **BATCH LOAD** side tab.

    ![left click the BATCH LOAD side tab](./images/ld-3.png)

3. Next, click the copy icon ![copy icon](./images/copy-copy.png) for the **BATCH LOAD** endpoint.

    ![left click the BATCH LOAD side tab](./images/ld-4.png)

    It should be similar to the following:

    ```
    curl --location --request POST \
    --data-binary @<FILE_NAME> \
    'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/' 
    ```

    **Save this code in a text editor or a notes application, we will be using it in just a bit.**

4.  We are going to alter this a bit for our data load. First, we need to be in either the **OCI Cloud Shell** or a local computer with cURL installed. Every OCI account has Cloud Shell so we would encourage using that. 

    To use the Cloud Shell, after logging into your OCI account, click the Cloud Shell icon in the upper right of the OCI banner:

    ![Cloud Shell on OCI Banner](./images/ld-5.png)

    The Cloud Shell will open on the lower part of the web browser:

    ![Cloud Shell on bottom of browser](./images/ld-6.png)

    We will be using the OCI Cloud Shell for examples in this lab going forward.

5. Time to get ready for the data load. To start, we need to download the csv file. Using the Cloud Shell, enter the following command:

    ````
    <copy>curl -o 2M.csv https://objectstorage.us-ashburn-1.oraclecloud.com/p/mkaVVqrFZ0ziKvP8zNUgIVgeDhC9AukEe-nRc5wbqMzJvWQ46x-ZgYLNDYqOrnGN/n/c4u03/b/developer-library/o/2M.csv</copy>
    ````

6. Now that we have the file local, we can load it into the database. Remember that cURL command we saved just a bit ago? Time to alter a few commands in there and run it via the Cloud Shell. 

    **Seeing we are going to be constructing a command, please use a text editor or notes application.**

    The cURL we had for **BATCH LOAD** was similar to the following:

    ```
    curl --location --request POST \
    --data-binary @<FILE_NAME> \
    'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/' 
    ```

    Let's add a few modifications. First, we can add **--write-out '%{time_total}'** so we can see exactly how long this data load took. 

    ```
    curl --write-out '%{time_total}'
    ```

    Now we need to tell the REST endpoint this is a POST operation with **-X POST**.

    ```
    curl --write-out '%{time_total}' -X POST
    ```

    File Time! We indicate that we have this csv file we want to use and the file name itself with the following addition to the command: **--data-binary "@2M.csv"**

    ```
    curl --write-out '%{time_total}' -X POST --data-binary "@2M.csv"
    ```

    Time to set the headers of this HTTP request. We are going to set the content type and tell it we are sending over a csv file. -H indicated we are setting header variables and we want to set the Content-Type one: **-H "Content-Type:text/csv"**

    ```
    curl --write-out '%{time_total}' -X POST --data-binary "@2M.csv" -H "Content-Type:text/csv"
    ```

    Next, we can add basic authentication by passing over the username and password of our database schema with the following: **--user "admin:PASSWORD"**. Remember to replace **PASSWORD** with your password you used when we first created the user in Lab 1.

    ```
    curl --write-out '%{time_total}' -X POST --data-binary "@2M.csv" \
    -H "Content-Type:text/csv" --user "admin:PASSWORD"
    ```

    Finally, we need to add the URL we copied previously. We will be appending **batchload?batchRows=5000&errorsMax=20** to indicate that this is a batch load, we want to load them in groups of 5000, and to stop running if we hit 20 errors:

    ```
    curl --write-out '%{time_total}' -X POST --data-binary "@2M.csv" \
    -H "Content-Type:text/csv" --user "admin:123456ZAQWSX!!" \
    "https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/batchload?batchRows=5000&errorsMax=20"
    ```

    There it is, the final cURL command we will use to load the data into the table. Remember to replace **PASSWORD** with your password you used when we first created the user in Lab 1.

7. Using the Cloud Console, paste your constructed cURL command at the prompt.

    ![running the command in cloud shell](./images/ld-7.png)

8. When the command is finished, you should see that all 2,097,148 records were inserted into the table.

    ```
    curl --write-out '%{time_total}' -X POST --data-binary "@2M.csv" \
    -H "Content-Type:text/csv" --user "admin:123456ZAQWSX!!" \
    "https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/csv_data/batchload?batchRows=5000&errorsMax=20"

    #INFO Number of rows processed: 2,097,148
    #INFO Number of rows in error: 0
    #INFO Last row processed in final committed batch: 2,097,148
    0 - SUCCESS: Load processed without errors
    29.447
    ```
        
    the 29.447 is the result of the **--write-out '%{time_total}'** command we added indicating it took about 30 seconds to load 2 million records.

9. Back in the SQL worksheet, we can verify the load by running the following SQL. In the worksheet, enter the following statement:

    ````
    <copy>select count(*) from csv_data;</copy>
    ````

    You can highlight the command with your mouse/point and click the green arrow **Run Statement** button in the tool bar or press ctrl-enter/return (Windows)/command-enter/return (MacOS) while on the same line as the statement in the worksheet.

    ![running a SQL command in the sql worksheet](./images/ld-8.png)

    Either method will give the following result:

    ![SQL results](./images/ld-9.png)

10. Business logic is up next. We will be adding a function to our database schema to simulate some business logic. 

    The following function returns a count of all the rows that match the input provided to col2 in the table:

    ````
    <copy>
    create or replace procedure return_count (p_input in varchar2, 
                                              p_output out number) 
    is
    begin

        select count(*) 
          into p_output
          from csv_data
         where col2 = p_input;

    end return_count;
    /
    </copy>
    ````

    Copy and paste this code into the SQL Worksheet and left click the **Run Script** button on the toolbar:

    ![compile the function in the sql worksheet](./images/ld-10.png)

1.  We can test this function with a quick PL/SQL procedure. Copy and paste the following into the SQL Worksheet and run the procedure with the **Run Script** button:

    ````
    <copy>
    declare
        l_output number;
    begin

        return_count(p_input => 'a1',
                     p_output => l_output);

    dbms_output.put_line(l_output);

    end;
    /
    </copy>
    ````

    ![SQL to try out the procedure](./images/ld-11.png)

## Conclusion

In this lab, you loaded over two million rows into a table with curl and REST as well as added business logic to the database.

You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - Brianna Ambler, June 2021
- **Workshop Expiry Date** - May 2022

