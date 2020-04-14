
# Lab 5: Creating Rich Data Visualizations

### Introduction

This lab will walk you through the steps to connect Oracle Analytics Desktop (formerly Oracle Data Visualization Desktop) to an Oracle autonomous database, either in Autonomous Data Warehouse (ADW) or Autonomous Transaction Processing (ATP), and create data visualizations.  Unlimited Oracle Analytics Desktop licenses are included when connecting to an ADW  or ATP data source.  Instructions will be provided to connect your previously created autonomous database instance (using sample data loaded into the database) to Oracle Oracle Analytics Desktop.  We will demonstrate how you can immediately gain insights and create beautiful data visualizations.

At this point, you should have performed the following:

1. Obtained an Oracle Cloud account
2. Created a new autonomous database instance in ADW or ATP

### Objectives
- Learn how to connect a desktop analytics tool to the powerful autonomous database
- Learn how to connect to the database using SQL Developer Web
- Learn how to create a simple data visualization project with Oracle Analytics Desktop
- Learn how to access and gain insights from data in the autonomous database


### Required Artifacts
- Installation of Oracle Analytics Desktop (free with Autonomous Data Warehouse). If you already have Oracle Analytics Desktop installed, please check the version. The recommended version is 5.5.0 or greater, to connect to your Oracle autonomous database.
- Access to an existing Autonomous Data Warehouse instance.

## <!--buggy, did this so Part 1 would collapse-->

## Step 1: Installing Oracle Analytics Desktop on a Windows Desktop

  - Download the latest version of Oracle Analytics Desktop (formerly Data Visualization Desktop) from <a href="http://www.oracle.com/technetwork/middleware/oracle-data-visualization/downloads/oracle-data-visualization-desktop-2938957.html" target="\_blank"> here</a>.

- After saving the installer executable file, click on the installer and follow the guided steps.

   ![](./images/500/install_oad_4.jpg " ")

   ![](./images/500/install_oad_5.jpg " ")


## Step 2: Create a View by Executing the Provided Script in SQL Developer Web

For simplicity's sake, in this exercise we will use the SH schema provided to create a simple view.

### Accessing SQL Developer Web


Although you can connect to your autonomous database from local PC desktop tools like Oracle SQL Developer, you can conveniently access the browser-based SQL Developer Web directly from your ADW or ATP console.

-   In your database's details page, click the **Tools** tab.

![](./images/500/Picture100-34.png " ")

-  The Tools page provides you access to SQL Developer Web, Oracle Application Express, and Oracle ML User Administration. In the SQL Developer Web box, click **Open SQL Developer Web**.

![](./images/500/Picture100-15.png " ")

-   A sign in page opens for SQL Developer Web. For this lab, simply use your database instance's default administrator account, ADMIN, with the admin password you specified when creating the database. Click **Sign in**.

![](./images/500/Picture100-16.png " ")

-   SQL Developer Web opens on a worksheet tab. The first time you open SQL Developer Web, a series of pop-up informational boxes introduce the main features.

![](./images/500/Picture100-16b.png " ")


- In a SQL Developer Web worksheet, copy and execute the following script.  

   ```
   drop view DV_SH_VIEW;

   create or replace view DV_SH_VIEW as select
   P.PROD_NAME,
   P.PROD_DESC,
   P.PROD_CATEGORY,
   P.PROD_SUBCATEGORY,
   P.PROD_LIST_PRICE,
   S.QUANTITY_SOLD,
   S.AMOUNT_SOLD,
   X.CUST_GENDER,
   X.CUST_YEAR_OF_BIRTH,
   X.CUST_MARITAL_STATUS,
   X.CUST_INCOME_LEVEL,
   R.COUNTRY_NAME,
   R.COUNTRY_SUBREGION,
   R.COUNTRY_REGION,
   T.TIME_ID,
   T.DAY_NAME,
   T.CALENDAR_MONTH_NAME,
   T.CALENDAR_YEAR from
   SH.PRODUCTS P,
   SH.SALES S,
   SH.CUSTOMERS X,
   SH.COUNTRIES R,
   SH.TIMES T where
   S.PROD_ID=P.PROD_ID and
   S.CUST_ID=X.CUST_ID and
   S.TIME_ID=T.TIME_ID and
   X.COUNTRY_ID=R.COUNTRY_ID;
   ```

   ![](./images/500/execute_script_in_sql_dev_web_to_create_view.jpg " ")

## Step 3: Create a Connection to Your Autonomous Database from Oracle Analytics Desktop

- Start Oracle Analytics Desktop. When Oracle Analytics Desktop opens, click the __‘Connect to Oracle Autonomous Data Warehouse’__ button.

   ![](./images/500/click_connect_to_oracle_autonomous_data_warehouse.jpg " ")

-   In the **Create Connection** dialog, enter the following information:


   | Connection Info       | Entry                                             |  
   | --------------------- | :--------------------------------------------- |
   | Connection Name:      | Type in 'SALES_HISTORY'                             |
   | Client Credentials:   | Click 'Select' and select the zip file that you noted in Step 2. A file with .sso extension will appear in the field.   |
   | Username:             | Insert username created in previous labs; likely **admin**.  Same as SQL Developer Web and SQL Developer credentials. |                                            
   | Password              | Insert password created in previous labs.  Same as SQL Developer Web and SQL Developer credentials. |
   | Service Name:         | Scroll the drop-down field and select **adwfinance_high**, or the **high** service level of the database name you specified in the first lab. |

  - After completing the fields, click __‘Save’__.

   ![](./images/500/create_connection_dialog.jpg " ")

  - Upon success of creating a new connection to the Autonomous Data Warehouse, click __Create__ and click __Data Set__.  

    ![](./images/500/click_create_data_set.jpg " ")

  - We will now choose the sales data we want to analyze and visualize in our first project.  Select the connection we just created named __SALES_HISTORY__.

   ![](./images/500/choose_sales_history_connection.jpg " ")

  - Click the __ADMIN__ schema in the data warehouse.

    **Note:** If you do not see schemas because you are behind a firewall or on a VPN, you may need to use an alias or shut down the VPN to connect to your ADW database.

   ![](./images/500/select_admin_schema.jpg " ")

  - Find and click the __DV\_SH\_VIEW__ view table from the ADMIN schema.

   ![](./images/500/select_dv_sh_view_from_admin.jpg " ")

  - First click the __Add All__ label in the left column, and type a new Name for the Data Set, naming it __SALES_HISTORY__. You may click __Get Preview Data__ at the bottom to see some example records. Click the __Add__ button to add the Data Set.

  **NOTE**: It is important to use the new name of __SALES_HISTORY__ as the rest of the lab steps will reference that name.  

   ![](./images/500/add_all_data_to_data_set.jpg " ")

  - Once the __SALES_HISTORY__ Data Set has successfully been created, click on the main menu on the top left.

   ![](./images/500/data_set_results_click_menu.jpg " ")

  - Select the __Data__ menu option on the left.  This should reveal your new __SALES_HISTORY__ Data Set you created.  Click it to open it up as a **Project**.

   ![](./images/500/click_sales_history_data_set_to_open_as_project.jpg " ")

 - We are going to override the data types for two columns recognized as measures (ie. numeric), and correct them to be treated as attributes -- __CALENDAR\_YEAR__ and __CUST\_YEAR\_OF\_BIRTH__.  Click the __CALENDAR\_YEAR__ column name under Data Elements, and change the __‘Treat As’__ field to an __‘Attribute’__.  Repeat for the field, __CUST\_YEAR\_OF\_BIRTH__.

   ![](./images/500/change_treat_as_from_measure_to_attribute.jpg " ")

## Step 4: Explore the Data in your New Project in Oracle Analytics Desktop

### **Project Introduction**

No matter what your role is in the organization, access to timely data can provide greater insights to improve the performance of your business.  Whether you’re creating a data warehouse or data mart for yourself or others, Autonomous Data Warehouse is making it far simpler than ever before.  Easy, fast and elastic.   This small project demonstrates this.  This is how business users would interact with the Autonomous Data Warehouse.

**SCENARIO:** You work at an electronics reseller company. The founder started his business by selling camera and photography equipment.  He’s already diversified his business portfolio as he already owns many 1-hour photo processing and video rental stores.  Over the last few years, his computer reselling business has grown, but he’s not convinced that the PC/server business will last.  His instincts tell him to continue to focus on growing his photography equipment and supplies business rather than PCs.  If you had access to this Oracle technology and solution, what would this data tell him?  What insights could you share?  How could this data help him focus on the right investments, grow his business and better target his existing and potential customers?

  - We will first start by browsing the data that’s available in our Data Set. Click the highlighted __Prepare__ button.  

   Notice how easy it is to browse the data elements to see what is available for you to further explore.  After scrolling through the data, click back on the highlighted __Visualize__ option to bring up the blank canvas.

   ![](./images/500/browse_and_explore_data.jpg " ")

## Step 5: Create Your First Data Visualization

  - We will now create a very simple visualization project to finish this part of the lab.  Multi-select (ctrl+click) the 5 Data Elements within __SALES\_HISTORY__ including __PROD\_NAME__, __AMOUNT\_SOLD__, __CALENDAR\_YEAR__, __PROD\_CATEGORY__, and __QUANTITY\_SOLD__.  

- Drag the five selected columns to the middle of the screen.
   ![](./images/500/drag_five_columns_to_middle.jpg " ")

- Based upon this data, Oracle Data Visualization Desktop will choose a default visualization.  If not, choose the __Scatter__ chart so it matches the view below.   

   ![](./images/500/first_visualization_scatter_chart.jpg " ")

 You may **Save** this project if you need. At this point, with very few steps, you now have something that can further bring your data to life and you can begin to make some data-driven decisions.  As you share this with others, more people will want to gain access to and benefit from the data. To enable this, the Oracle autonomous database in ADW or ATP is easy to use, fast, elastic, and will be able to quickly scale to meet your growing data and user base.

## Optional Step 6: Exporting your DVA (project) File

This step enables you to share your project file with colleagues.

- Click the menu at the top left corner of the screen, and select __Home__.

- Your new project (DVA) will appear on the Home page, under __Projects__.  Click the menu at the bottom right corner of your project tile and choose __Export__.

   ![](./images/500/export_dva_project_file.jpg " ")  

  - Choose to export as a __File__.  Email may work if Oracle Analytics Desktop is able to interact with your local email client.  Cloud provides the mechanism to upload and share your project to <a href="https://cloud.oracle.com/en_US/oac" target="\_blank">Oracle Analytics Cloud</a>.

- Choose the export option as shown below and save the DVA file to your desktop.

   ![](./images/500/export_project_dva_to_file.jpg " ")  

## Conclusion
You have completed all steps in this lab.

<table>
<tr><td class="td-logo">[![](images/hands_on_labs_tag.png " ")](#)</td>
<td class="td-banner">
## Great Work - All Done!
**You are ready to move on to the next lab. You may now close this tab.**
</td>
</tr>
<table>
