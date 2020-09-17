# Essbase and ADW

## Introduction

In this lab, we will learn how to build an Essbase cube sourcing data from Autonomous Data Warehouse (ADW Database). We will build dimensions and load data using ADW data. We will use Essbase drill-through functionality to display additional detailed data that is retrieved from Autonomous Data Warehouse. Through Essbase Smart View for Office, we will interactively investigate the data in Essbase, slice and dice the data, and do ad hoc analysis on it.

Estimated Lab Time: 20 minutes.

### Objectives

* Procuring ADW instance
* Loading data to ADW instance
* Create a connection from Essbase 19c to ADW
* Build dimension using ADW data
* Load data from ADW to Essbase cube
* View / Analyze ADW data in Smart View
* Drill through to ADW data from Smart View

### Prerequisites

* The following lab requires an Oracle Public Cloud account with an Essbase 19c instance and corresponding access to create a new Autonomous Database.
*	Smart View plugin for Excel.


##  **Step 1:** Provisioning an ADW Instance

1. Go to [cloud.oracle.com](https://www.oracle.com/index.html), click on the **Person Icon**

    ![](./images/image16_1.png "")

2. Then click on **Sign in to Cloud** to sign in with your Oracle Cloud account.

    ![](./images/image16_2.png "")

3. Enter your **Cloud Account Name** and click **Next**.

    ![](./images/image16_3.png "")

4. Enter your Oracle Cloud **username** and **password**, and click **Sign In**.

    ![](./images/image16_4.png "")

5. If after logging in, you are taken to the screen below, click on **Infrastructure Dashboard**. If you do not see the screen below when you login, skip this step and move on to the next step below.

    ![](./images/image16_5.png "")

6. Once you are logged in, you are taken to the OCI Console. Click **Create a data warehouse**.

    ![](./images/image16_6.png "")

7. This will bring up the Create Autonomous Data Warehouse screen where you will specify the configurations of the instance. Compartments are used to organize resources in Oracle Cloud Infrastructure. Using the drop down, select **EssbaseSalesPlay** from the compartment list.

8. Specify a memorable display name for the instance and database's name, here **EssbaseADW**.

    ![](./images/image16_7.png "")

9. Then, scroll down and select the CPU core count and Storage (TB) size. Here, we use 1 CPU and 1 TB of storage.

    ![](./images/image16_8.png "")

10. Uncheck Auto scaling for the purposes of this workshop.

11. Then, specify an ADMIN password for the instance, and a confirmation of it. Make a note of this password.

    ![](./images/image16_9.png "")

12. For this lab, we will select **License Included** for the license type. If your organization owns Oracle Database licenses already, you may bring those licenses to your cloud service.

13. Make sure everything is filled out correctly, then proceed to click on **Create Autonomous Database**.

    ![](./images/image16_10.png "")

14. Your instance will begin provisioning. Once the state goes from Provisioning to Available, click on your ADW display name to see its details. Note: Here, the name is **EssbaseADW**.

15. You now have created your first Autonomous Data Warehouse instance. Have a look at your instance's details here including its name, database version, CPU count and storage size.

    ![](./images/image16_11.png "")

16. As ADW only accepts secure connections to the database, you need to download a wallet file containing your credentials. The wallet can be downloaded either from the instance's details page, or from the ADW service console. In this case, we will be showing you how to download the wallet file from the instance's details page. This wallet file can be used with a local version of software such as SQL Developer as well as others. It will also be used later in the lab so make note of where it is stored.

17. Go back to the Oracle Cloud Console and open the Instances screen. Find your database, click the action menu and select **DB Connection**.

    ![](./images/image16_13.png "")

18. Under Download Client Credentials (Wallet), click **Download Wallet**.

    ![](./images/image16_14.png "")

19. Specify a password of your choice for the wallet. You will need this password when connecting to the database via SQL Developer later, and is also used as the JKS keystore password for JDBC applications that use JKS for security. Click **Download** to download the wallet file to your client machine. Download the wallet to a location you can easily access, because we will be using it in the next step.

    **Note: If you are prevented from downloading your Connection Wallet, it may be due to your browser's pop-blocker. Please disable it or create an exception for Oracle Cloud domains.**

    ![](./images/image16_15.png "")

## **Step 2:** Uploading data file to ADW

This section demonstrates how to import a table to ADW instance.

1. Navigate to Autonomous Database section and select ADW instance created in previous step.

2. In Autonomous Database select **Service Console**.

    ![](./images/image16_16.png "")

3.	In the Development section of the Service console, click **SQL Developer Web**

    ![](./images/image16_17.png "")

4. Provide ADW instance username and password.

    ![](./images/image16_18.png "")

5. Import data file [Sample_Basic_Table.txt](https://objectstorage.us-ashburn-1.oraclecloud.com/p/z604rlGq_zp4JEA2uU3loO6DewbsS5R3z1by4Wq43Dg/n/natdsepltfrmanalyticshrd1/b/Essbase-Workshop/o/sample_basic_table.txt) containing data column to ADW instance.

    ![](./images/image16_19.png "")

6. Select horizontal ellipsis icon, then select **Data Loading** -> **Upload Data Into New Table**

    ![](./images/image16_20.png "")

7. Browse to file location and select ``Sample_Basic_Table.txt`` file.

    ![](./images/image16_21.png "")

8. In the Data preview screen, verify that columns are getting populated from the uploaded txt file.

    ![](./images/image16_22.png "")

9. Map the columns from text file to table.  

    ![](./images/image16_23.png "")

10. Verify data loaded into the table by executing a select query.

    ![](./images/image16_24.png "")

## **Step 3:** Create a Connection and Datasource for Oracle Autonomous Data Warehouse

For reference - [Click Here](https://docs.oracle.com/en/database/other-databases/essbase/19.3/ugess/create-connection-and-datasource-access-oracle-autonomous-data-warehouse.html)

1. In the Essbase web interface, click **Sources**.

    ![](./images/image16_25.png "")

2. Click **Create Connection** and select **Oracle Database**.

3. Select **Autonomous** using the toggle switch.

4. Enter a connection name: ``essbaseADW`` and a service name: ``essbaseADW_medium``

5. Drag and drop a wallet file or click to upload. Upload the wallet file downloaded in Step 1 procuring ADW.

6. Enter your Autonomous Data Warehouse username, password, and optionally, a description.

7. Click **Test** to validate the connection, and if successful, click Create.

    ![](./images/image16_26.png "")

8. Verify that the connection was created successfully and appears in the list of connections. Next, you will create a Datasource for the Autonomous Data Warehouse connection.

    ![](./images/image16_27.png "")

9. Click **Datasources** and click **Create Datasource**. In this step we will create two datasources which are required in next sections.

10. From the Connection drop-down box, select the name of the connection you just created - ``EssbaseADW``

11. Provide a name for the Datasource; for example, ``ADW_Datasource``

12. Optionally enter a description of the Datasource; for example, **Autonomous Data Warehouse Datasource**.

13. In the **Query** field, provide the SQL query as :

    ```
    <copy> Select distinct market, statename from SAMPLE_BASIC_TABLE </copy>
    ```

    ![](./images/image16_28.png "")

14. Click **Next**. If the SQL statement was correct to query an Autonomous Data Warehouse area, you should see the queried columns populated.

    ![](./images/image16_29.png "")

15. Leave parameters section as-is and click **Next**.

16. Review the preview panel. You should see the results of the SQL query fetching columns of data from Autonomous Data Warehouse.

    ![](./images/image16_30.png "")

17. If the preview looks correct, click **Create** to finish creating the Datasource.

18. Following similar steps create another datasource with name ``ADW_Dataload``

19. In the query section of ADW_Dataload Datasource use:

    ```
    <copy> Select Product, Scenario, Statename, months, Sales from SAMPLE_BASIC_TABLE </copy>
    ```

    ![](./images/image16_31.png "")

20.	The Preview tab for the ADW_ Datasource should look similar to the following:

    ![](./images/image16_32.png "")

## **Step 4:** Build Dimensions Using SQL Datasource with ADW

1. We will delete some members from Sample Basic, and then create a load rule to rebuild the Market dimension from the ADW table.

2. In the Essbase web interface, on the Applications page, expand the Sample application, and select the cube, Basic.

    ![](./images/image16_33.png "")

3. From the Actions menu to the right of Basic, select Outline.

    ![](./images/image16_34.png "")

4. Click the Market dimension, and then click member East.

    ![](./images/image16_35.png "")

5. Click Edit to lock the outline for editing.

6. Delete some of the states from the East market. For example, delete Connecticut, New Hampshire, and Massachusetts.

7. Click Save, and then verify that East now contains only the states Florida and New York. Next, you will create dimension build rules and repopulate the Market dimension, from the SQL table, with the states you have removed.

8. Close the Outline browser tab.

9. On the Applications page, from the Actions menu to the right of Basic, launch the inspector, click Scripts, then choose the Rules tab.

    ![](./images/image16_36.png "")

    ![](./images/image16_37.png "")

10. Click Create > Dimension Build (Regular) to begin defining new dimension build rules.

    ![](./images/image16_38.png "")

11. In the Name field, enter the name of the rules file as ``MarketSQLDimbuild``. In Datasource field select ADW_Datasource from dropdown.

    ![](./images/image16_39.png "")

12. Dimension columns should be automatically populated from the Datasource selected.

    ![](./images/image16_40.png "")

13. On the New Rule - ``MarketSQLDimbuild`` page, click the Dimension drop-down field and select Market.

14. Click the Type drop-down field and select Generation. Increment the generation number to 2.

15. Click the Generation Name field and type **REGION**.

    ![](./images/image16_41.png "")

16. Click **Create > Regular** to create a second dimension build rule field.

    ![](./images/image16_42.png "")

17. Name the field STATE and associate it with dimension Market, at generation 3.

    ![](./images/image16_43.png "")

    ![](./images/image16_44.png "")

18. Click the **Source** button to begin associating a data source with the dimension build rules.

19. Keep the fields in **General** tab as-is.

20. Back in the Edit Source dialog for your dimension build rule, in the SQL/Datasource Properties group select Datasource radio button. Select Datasource as ADW_Datasource from dropdown.

    ![](./images/image16_45.png "")

21. Click OK, then Verify, Save and Close, to save and close the ``MarketSQLDimbuild`` rule.

22. Refresh the list of rules in the Scripts list to ensure that ``MarketSQLDimbuild`` has been added to the list of rule files for the cube Sample Basic.

    ![](./images/image16_46.png "")

23. Click **Close**. Next, you will use this rule file to load the members back into the Market dimension.

24. Click Jobs, and click **New Job > Build Dimension**.

25. Enter **Sample** as the application name, and Basic as the database name.

26. For the script name, select the name of the dimension build rule file you created, ``MarketSQLDimbuild``

27. Select Datasource as the load type.

    ![](./images/image16_47.png "")

28. From the Restructure Options drop-down list, select Preserve All Data.

29. Click OK to begin the job. The dimension build begins. Click the Refresh symbol to watch the status, and when it completes, click Job Details from the Actions menu.

30. Inspect the outline to verify that your dimensions were built (verify that Connecticut, New Hampshire, and Massachusetts exist as children under East).

## **Step 5:** Load ADW Data to Essbase Using SQL Datasource

This task flow demonstrates how to clear data from a cube, create data load rules, load data (using SQL) from an ADW instance, and verify in Smart View that the data was loaded.

After building the dimensions, you will clear data from the cube, and then load the data again from a table. In Essbase, click **Jobs**, and click **New Job**.

1. Select **Clear Data** as the job type. Select application Sample and database Basic and click OK.

2. Click **OK** to confirm that you want to clear data. The job begins. Click the **Refresh** symbol to watch the status, and when it completes, click **Job Details** from the Actions menu.

3. Connect to the **Sample Basic cube** from Smart View and do an ad hoc analysis.

4. Notice that data was cleared. For example:

    ![](./images/image16_48.png "")

    *Note: Keep the worksheet open. Next, you will create load rules that use SQL to repopulate the Sales data from the table.*

5. On the Applications page, expand the Sample application, and select the cube, Basic.

6. From the **Actions** menu to the right of Basic, launch the inspector, click **Scripts**, then choose the **Rules** tab.

7. Click **Create > Data** Load to begin defining new load rules.

8. In the **Name** field, enter the name of the rule file as ``SalesSQLDataload``.

9. In the **Data Dimension** drop-down box, select the Measures dimension.

10. Leave the other options as-is and click **Proceed**.

    ![](./images/image16_49.png "")

11. In ADW instance write and test a SELECT statement selecting some columns from the table ``SAMPLE_BASIC_TABLE`` :

    ```
    <copy> Select Product, Scenario, Statename, months, Sales from SAMPLE_BASIC_TABLE; </copy>
    ```

12. Ensure that the SQL query is valid and returns a result in your SQL tool. If the SQL query is valid, it should return the requested table columns, PRODUCT, SCENARIO, STATENAME, MONTHS and SALES, from the database to which your SQL tool is connected.

13. In Essbase, in the **New Rule** browser tab for your ``SalesSQLDataload`` rule, select Sales from the Select drop-down box.

14.	Click **Create > Regular** to continue adding fields. Notice that the build rule has automatically picked fields from the Datasource.

15. Verify all the fields are properly mapped to columns in table.

16. From the third column **Select** drop-down box, select Market (which maps to Statename in your SQL query).

17. From the fourth column **Select** drop-down box, select Year (which maps to Months in your SQL query). Your load rule fields should now be arranged like this:

    ![](./images/image16_50.png "")

18. Click the **Source** button to begin associating a data source with the load rules.

19. In the **General** tab, leave fields empty. Navigate to SQL/Datasource Properties section and select Datasource radio button.

    ![](./images/image16_51.png "")

20. Verify, save, and close the ``SalesSQLDataload`` rule.

21. Refresh the list of rules in the Scripts list to ensure that ``SalesSQLDataload`` has been added to the list of rule files for the cube Sample Basic, and then close the database inspector.

22. Next, you will load the Jobs data. Click **Jobs**, and click **New Job > Load Data**.

23. Enter **Sample** as the application name, and **Basic** as the database name.

24. For the script name, select the name of the dimension build rule file you created, ``SalesSQLDataload``.

25. Select **Datasource** as the load type.

    ![](./images/image16_52.png "")

26. Click **OK** to begin the job.

The data load begins. Click the **Refresh** symbol to watch the status, and when it completes, click **Job Details** from the Actions menu.

27. Go back to the worksheet in Smart View, and refresh it to verify that the data was loaded from the table.

28. Run the calc script to perform data aggregation.

    ![](./images/image16_53.png "")

29. Verify data load in Smart View by performing data analysis.

    ![](./images/image16_54.png "")

## **Step 6:** Create Drill Through Reports with ADW data

When you want more information than what you can see in the Essbase cube, you can use drill through reports to access external data sources.

Drill through refers to linking the Essbase cube to further data, for example, transactional-level data stored in a relational database.

You can drill through to data from any other Oracle application, an external database, a file (delimited or Excel), or a URL-based target.

After defining the connection and data source, the next step to define the report.

1.	Open Database inspector for ‘Basic’ Database under Sample Application.

2.	Select the Scripts page.

3.	Select Drill Through Reports.

4.	Click Create.

    ![](./images/image16_55.png "")

5.	Select Datasource type drill through report:

    a.	Enter a name for the report.

    b.	Select the data source that we created earlier – ADW_Dataload.

    c.	Select the columns that you want in the report, map them to dimensions, and designate the appropriate generation or level.

    d.	Select PRODUCT, map it to Product, and select Level0. Repeat for more columns:

    ```
    <copy> MONTHS/Year/Months, SCENARIO/Scenario/Level0 </copy>
    ```

    e.  Select SALES and STATENAME but leave them mapped to None.

    ![](./images/image16_56.png "")

6.	Click Drillable Regions to define regions that should access ("drill through to") the ADW data source. Click + to add a region based on actual sales.

7.	Double click in the empty row, and add this Essbase calculation expression to define its area:

    ```
    <copy> Sales,Actual,Year,@DESCENDANTS(Year),Product </copy>
    ```

    ![](./images/image16_57.png "")

8.	When finished, click Save and Close.

9. Now that you have set up an application and cube for drill through, and created a report, you are ready to execute the report and analyze data.

10.	Use the Sample Smart View analysis file that you can download from [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/gE7tm__2qZ4Zkp8tDqloFKwAv9s-SOjzmfd0Uu6cnNE/n/natdsepltfrmanalyticshrd1/b/Essbase-Workshop/o/DT_Analysis_Sample_report.xlsx)

    ![](./images/image16_58.png "")

11.	Drill through one of the cells to see the data source for the cell, for example, select a cell D3 and click Drill Through. Select the drill-through you created.

    ![](./images/image16_59.png "")

12.	In the new sheet, examine the drill through report.

13.	You have drilled through to the ADW data source to see the next level data.

14.	You can verify numbers from new sheet. This number matches the value of the cell you drilled through from.

You may proceed to the next lab.

## Acknowledgements
* Author - NATD Cloud Engineering - Bangalore Analytics (Aparana Gupta, Sushil Mule, Sakethvishnu D, Mitsu Mehta, Fabian Reginold, Srikrishna Kambar)
* Reviewed by - Ashish Jain, Product Management
* Last Updated By/Date - Jess Rein, Cloud Engineer, Sept 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
