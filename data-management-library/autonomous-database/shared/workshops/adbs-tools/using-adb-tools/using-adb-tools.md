
# Using Autonomous Database Tools
## Introduction
This lab introduces the suite of data tools built into the Oracle Autonomous Data Warehouse.

Estimated Lab Time: 1 hour, 15 minutes

### Objectives
- Familiarize with the suite of built-in database tools of the Oracle Autonomous Data warehouse
- Load data
- Learn how to use the Data Transforms tool to correct data errors
- Create a business model
- Generate data insights
- Use the Catalog tool

### Prerequisites
- This lab requires completion of the previous labs in the Contents menu on the left.

## STEP 1 - Overview of Built-In Data Tools Suite

<p style="text-align: left;">**PREPARING QUARTERLY SALES ANALYSIS**

  ![ALT text is not available for this image](images/2879071283.png)

### MovieStream Critics Corner: Introduction

*Fans of the Space genre on MovieStream will be familiar with that spine-tingling feeling of excitement that comes with the count-down: “11, 10, 9, (ignition sequence starts), 6, 5, 4, 3, 2, 1, 0... Lift-off! We have a lift-off!” All the money you spent on that sub-woofer is justified by the rumble of those rocket motors driving out 7.8 million pounds of thrust. We’re at that stage of the workshop. This is the launch, so strap in, this is going to be an exciting journey!*

### Introduction

Autonomous Data Warehouse comes with a built-in suite of tools that can help you with many of the typical data warehouse tasks. This tool suite is complementary to various capabilities accessible via the SQL command line, which themselves are covered by other workshops.  To explore how these new built-in tools can make you work smarter and faster you will take on the role of a departmental analyst at MovieStream. As a **departmental analyst** you have been assigned the task of reviewing the sales data from Q2 of fiscal year 2020 and to make recommendations for a marketing campaign based on this analysis.

  **Note**: MovieStream's financial year is aligned with the calendar year, so FYQ2 is April-June.

In this section of the workshop, you are going to work through some common data warehouse requirements and scenarios that you will frequently run into when working on your own projects:

1. Loading and inspecting data to see if there are any obvious errors
2. Transforming data to correct errors in the original data set
3. Creating a business model (also known as a semantic model) over your data set
4. Running the Data Insights tool to identify anomalies and outliers in your data set
5. Using the built-in Catalog to understand the origins of the data within your data warehouse (this is called  ***Data Lineage*** )
6. Using the built-in Catalog to understand the impact of making changes to your data model (this is called  ***Impact Analysis*** )

**Let's get started!**

### Accessing Autonomous Database Built-In Tool Suite

In the previous lab, you created the database user **QTEAM** and you should still be connected as user QTEAM.

There are two ways to access the Autonomous Database built-in tool suite:

1. Via the Autonomous Database console page
2. Directly via URL

### Accessing Autonomous Database Tools via the ADW Console

On the Autonomous Data Warehouse console page, click the **Tools** tab, and in the **Database Actions** card, click the link to **Open Database Actions**:

  ![ALT text is not available for this image](images/2879072598.png)

### Accessing Autonomous Database Tools Directly via URI

When user QTEAM was created (in a previous step), a card appeared on the Database Users screen, similar to what is shown below. Notice the URI at the bottom of the card.

1. Click the **copy contents** icon to copy this to your clipboard. This URI may be used to access the Database Actions page of Autonomous Database Tools directly, without needing to use the OCI Console.
  ![ALT text is not available for this image](images/2879073226.png)
2. In the dialog that appears, sign in as user QTEAM, with the password assigned previously, and click **Sign In**.
  ![ALT text is not available for this image](images/2879073132.png)
3. This will take you to the Autonomous Data Warehouse **Database Actions** home page (shown below). This page has a card for each of the most common tasks that the data warehouse user would want to perform. The cards are grouped by theme. For example, here you see groups for Development and Data Tools. Each card has a title and description.  
  ![ALT text is not available for this image](images/2879071279.png)
4. If you want more information about each of the tasks related to each card then you can access the online help by clicking the **Question Mark** in the title bar, as indicated in the image below:
  ![ALT text is not available for this image](images/2879071281.png)
5. This will pop out a tray containing links to the relevant topics in the Autonomous Data Warehouse documentation. To close the help tray, simply click the  **X**.
  ![ALT text is not available for this image](images/2879071282.png)

### RECAP

In this section of the workshop you are playing the role of a different user of your Autonomous Data Warehouse; a departmental analyst whose database username is **QTEAM**. 

You have seen two different ways of navigating to the Database Actions home page, which is the launching pad for the various built-in tools:

- Navigating to **Database Actions** from the ADW console
- Using a URL (which can be copied from the ADW console) to access **Database Actions** directly

You've taken a brief tour of the **Database Actions** home page, with its card interface and ready access to documentation and other useful resources. The next step is to use the data loading tools to help you create your quarterly sales reports.

## STEP 2 - Loading Data

### MovieStream Critics Corner: Data Load

*In Analytics, just as in the streaming movie business, a good start is essential. The analysts at MovieStream pay careful attention to how commonly customers give up on a movie after just a few minutes; presumably because of a bad start. Similarly, we at Oracle Autonomous Database know that Data Load is the start of your Analytics work, and our Data Load tool is built to ensure you get off to a great start.*

### Overview

In this section you are going to explore how to load spreadsheets stored on your local computer and combine that data with another data set which is stored in the Oracle Object Store. As you load these various data files you are going to discover that some of your data is not correctly formatted. Sometimes it can be very hard to spot issues hidden within a data set but as you will see, Autonomous Data Warehouse has unique tools to help you spot the typical data errors you find in most data warehouse projects.

#### Video Preview

Watch a video demonstration of the Data Load tool of Autonomous Database:

[] (youtube:SJUw4wIvkS4)
*Note: Interfaces in this video may look different from the interfaces you will see.*

### Launching Your Data Load Workflow

Click the **Data Load** card on the **Database Actions** home page.

  ![ALT text is not available for this image](images/2879071271.png)

This will take you to the screen shown below which controls the data loading process - dividing it up in a series of simple questions:

  ![ALT text is not available for this image](images/2879071272.png)

The layout of the cards on the above page is organized into three rows:  

   **row 1** - identifies how you are going to get to your source data: load it, link to it, or use a trickle feed data

   **row 2** - covers where your data is stored: local file, another database or in a cloud object store

   **row 3** - allows you to explore your data and manage your connections to the various cloud objects stores such as Oracle Object Store, Amazon's S3, Microsoft's Azure Blob Storage and Google's Object Store. 

### About Data Loading In This Part Of The Workshop

The first step in data analysis is to load data, which may come from a wide variety of sources. Autonomous Data Warehouse supports data load from a very wide range of sources. In this workshop, you explore loading data from two prominent data sources–files on a local disk, and files in object store. All the files to be loaded into your ADW are in OCI Cloud Storage. The next section, *Loading Data from Local Files*, starts by having you download some of these files to your local disk. Of course, this simulates the real-world situation where some of the data you have to analyze might be downloaded from a website, or may have arrived via an email as an attachment. However, it may be that the environment you are using to run your workshop may not allow you to download files to your local computer. Therefore, these workshop notes include an alternative approach for loading the data you need, which is to use data files stored in the Oracle Object Store. This will all become clear as you go through the next series of steps in this workshop. 

  **Note:** This workshop focuses on just two ways to load data. Within this workshop it would be impractical and unrealistic to include data loading scenarios from all supported sources. Loading data from applications and databases are both supported by Autonomous Data Warehouse but are outside the scope of this workshop. For more information about data loading see the documentation,  **[click here](https://docs.oracle.com/en/database/oracle/sql-developer-web/sdwad/load-data.html#GUID-E810061A-42B3-485F-92B8-3B872D790D85)**.

### Loading Data from Local Files

   **Important: **  Your computer may not support downloading files to your local disk. If you are in this situation, please skip forward to next main section **Loading Data from Object Store.**

### Preparation

For these purposes you have been given an extract of data by your IT team and it has been delivered as a .CSV file. The file has been placed in a bucket in the Oracle Object Store. As part of this project you are going to also reuse some data files from previous assignments that you have done in the past for the same team in the marketing department. These additional data files need to be moved to your computer so you can load them into your data warehouse.

Below are the four files that you will be using during this part of the workshop. Before you can begin, you need to download three files to your local computer and make a note of where they are stored because you will be needing them to use them later in this section. Click each of the three links below to download the two spreadsheet files and the csv-text file.

- **Movie\_Sales\_2020.csv**  This CSV file is stored in an Object Storage public bucket. This will be loaded in a separate step.
- Click **[here](https://objectstorage.us-phoenix-1.oraclecloud.com/n/dwcsprod/b/MovieStream-QTEAM-Download/o/Days_Months.xlsx)** to download the **Days\_Months.xlsx** Excel file to your local computer.
- Click **[here](https://objectstorage.us-phoenix-1.oraclecloud.com/n/dwcsprod/b/MovieStream-QTEAM-Download/o/Devices.xlsx)** to download the **Devices.xlsx** Excel file to your local computer.
- Click **[here](https://objectstorage.us-phoenix-1.oraclecloud.com/n/dwcsprod/b/MovieStream-QTEAM-Download/o/Countries.csv)** to download the **Countries.csv** CSV file to your local computer.

    - *Note : This file might just appear as new tab in your browser rather than just simply downloading. Please use the Save or Save As feature in your browser's File menu to save the file as **Countries.csv** *and make a note of where you saved it!*

**Before you proceed -**  be sure to take note of the location of the three files that you downloaded earlier to your local computer.

1. To load the files from your local computer you need to click on the first card in each of the first two rows of cards (in row one - **LOAD DATA** and row two - **LOCAL FILE** ) which will mark each box with a blue tick in the bottom right corner.
  ![ALT text is not available for this image](images/2879071273.png)
2. To move forward to the next step in this process, simply click the blue **Next** button. This is where you need to locate the three files (Countries.csv, Days_Months.xlsx and Devices.xlsx) that you downloaded earlier! If they are easily accessible then you can simply drag **ALL THREE** files at one time, and drop them onto to canvas as stated in the text on the screen:!
  ![ALT text is not available for this image](images/2879071274.png)
3. An alternative approach is to click **Select Files** button in the middle of the screen which will open the file explorer on your local computer where you can locate your data files: Countries.csv, Days\_Months.xlsx and Devices.xlsx. **WARNING** - even though you only picked three files, four cards will appear for the data TARGETS to be loaded.
  ![ALT text is not available for this image](images/2879071275.png)
  Why do you have  ***four***  cards listed on the data loading screen? This is because your spreadsheet file **Days\_Months.xlsx** contains two worksheets: one for Days and one for Months. The data loading wizard automatically parsed your spreadsheet and created a separate data loading card for each worksheet. 
  ![ALT text is not available for this image](images/2879071187.png)
4. Before you load any data, let's review what the data loading wizard has discovered about the data within your data files. Let's focus on the **countries.csv** file. Click the **pencil icon** on the right side of the card to inspect the data loading properties:
  ![ALT text is not available for this image](images/2879071276.png)
5. The data load settings page will appear. Observe that this shows the structural information and intelligent default values that data wizard has created from simply looking at the file.
  ![ALT text is not available for this image](images/2879071277.png)
6. How does it do this? Most csv files contain structural information about the data within the file in the first row. Notice that there is a tick box selected, **Get from file header**. 
  ![ALT text is not available for this image](images/2879071260.png)
7. This has allowed the data loading wizard to discover that your data file contains two columns of data: **COUNTRY** and **CONTINENT**. The default table name has based derived from the filename. Click the drop-down menu under  **Options.**
  ![ALT text is not available for this image](images/2879071261.png)
8. Notice that various operations are supported. For this part of the lab, accept the default option,  **Create Table**. **Note**  - if you look back at the previous section where you loaded the movie sales data loading for 2020 you will remember that you had to create your movie\_sales\_fact table before you could load your data files. This wizard creates the table for you during the data load process! Notice also that the wizard has automatically mapped the columns. Column mapping looks sensible, both in terms of column names and data types.
9. Click **Close**  in the bottom right to return to the Data Load card and then click the **green button** in the menu panel to start the Data Load job.
  ![ALT text is not available for this image](images/2879071262.png)

  In the bar on the left there are links for Settings, Data Viewers for source and target, and an error log. This screenshot shows the **Settings** page.
  ![ALT text is not available for this image](images/2879071263.png)
  The time taken to load each file depends on factors including file size and network speed. The progress of the job can be monitored from the status bar and the ring to the left of each job card. When the ring is complete, the file has uploaded successfully. 

Now let's inspect the tables that were automatically created during the data load process.

### Inspecting Your New Data

1. To access the data explorer tool, click the **Data Load** breadcrumb at the upper left of your screen:
  ![ALT text is not available for this image](images/2879071264.png)
2. Then click the **EXPLORE** card on the main data loading page.
  ![ALT text is not available for this image](images/2879071265.png)
3. This brings up a list of the Tables and Views in this schema of the Autonomous Database. At this stage all you see are the four tables you just loaded.
  ![ALT text is not available for this image](images/2879071266.png)
4. Click the table **COUNTRIES** and a data preview panel will appear that will allow you to review the data you just loaded. Note that this is a relatively simple table containing a list countries and their continents. 
![ALT text is not available for this image](images/2879071267.png)
5. Click the **Close** button in the bottom right corner.

### RECAP: Loading Data from Local Files

In this part of the workshop you used the new data loading tool to quickly load data into your data warehouse from three local data files simply by dragging and dropping them onto the Data Load canvas. One file was in CSV format and the other two were Excel spreadsheets. One of the spreadsheets contained two worksheets and each one was loaded into its own table. The data loading process automatically created a target table containing the appropriate column structures based on the data within each file.

In a few clicks you were able to define and load data into four new tables without having to write any SQL code. It was all done with a few mouse clicks.

### Load Data from Object Store

In the previous exercise, you loaded data from files that you located on your local computer. In this part of the lab, you are going to load some more data but this time using a file which is in the Oracle Object Store. There are two parts to this process and the first part only needs to be performed once. The two parts are:

1. Set up connection to the Oracle Object Store.
2. Load the file.

### Setting Up Cloud Location

1. To begin this process you need to navigate back to the **Data Load** page. From the **Explore** page, click the **Data Load** breadcrumb at the top left corner of the page:
  ![ALT text is not available for this image](images/2879071268.png)
2. On the **Data Load** main page, click the **Cloud Locations** card so you can define a new connection to your object store.
  ![ALT text is not available for this image](images/2879071269.png)
3. Click the **Add Cloud Storage** button on the upper right and define a Cloud Storage location as follows:

<table class="wrapped relative-table confluenceTable" style="width: 100.0%;"><colgroup> <col style="width: 9.19509%;"/> <col style="width: 12.019421%;"/> <col style="width: 45.07344%;"/> <col style="width: 33.71451%;"/> </colgroup><tbody><tr><th colspan="1" class="confluenceTh">Field</th><th colspan="1" class="confluenceTh">Your Region</th><th colspan="1" class="confluenceTh">Value</th><th colspan="1" class="confluenceTh">Notes</th></tr><tr><td class="confluenceTd">Name</td><td colspan="1" class="confluenceTd"></td><td class="confluenceTd">MOVIE_SALES</td><td colspan="1" class="confluenceTd">Lower case names not currently supported</td></tr><tr><td class="confluenceTd">Description</td><td colspan="1" class="confluenceTd"></td><td class="confluenceTd">Movie Sales</td><td colspan="1" class="confluenceTd"></td></tr><tr><td rowspan="4" class="confluenceTd">URI + Bucket</td><td colspan="1" class="confluenceTd">Europe, Middle East, Africa</td><td class="confluenceTd">https://objectstorage.uk-london-1.oraclecloud.com/n/dwcsprod/b/MovieStream/o/</td><td rowspan="4" class="confluenceTd">Choose the closest location </td></tr><tr><td colspan="1" class="confluenceTd">Americas</td><td colspan="1" class="confluenceTd">https://objectstorage.us-phoenix-1.oraclecloud.com/n/dwcsprod/b/MovieStream/o/</td></tr><tr><td colspan="1" class="confluenceTd">Japan</td><td colspan="1" class="confluenceTd">https://objectstorage.ap-tokyo-1.oraclecloud.com/n/dwcsprod/b/MovieStream/o/</td></tr><tr><td colspan="1" class="confluenceTd">Asia &amp; Oceania</td><td colspan="1" class="confluenceTd">https://objectstorage.ap-mumbai-1.oraclecloud.com/n/dwcsprod/b/MovieStream/o/</td></tr><tr><td class="confluenceTd">Credential</td><td colspan="1" class="confluenceTd"></td><td class="confluenceTd">No credential</td><td colspan="1" class="confluenceTd">Make sure the radio button is switched on to indicate the no credential is needed</td></tr></tbody>
</table>

  ![ALT text is not available for this image](images/2879071270.png)

Your completed form should look like the one above. When you have completed these details, click **Create**.

### Loading Data Files from A Cloud Storage Location

1. Navigate back to the main Data Load page again using the breadcrumb link. Click the two cards for  **Load Data**  from  **Cloud Storage **and then click the blue **Next** button. 
  ![ALT text is not available for this image](images/2879071251.png)
2. Now you see a file browser-like view of your Object Store. Locate the file **Movie\_Sales\_2020.csv** in the left part of the screen. Click and drag this file onto the canvas on the right. 
  ![ALT text is not available for this image](images/2879071252.png)
3. As before, you can edit the properties of your new data load job by clicking the **pencil** button on the right-hand side of the card. 
  ![ALT text is not available for this image](images/2879071253.png)
4. You can use this page to quickly review the properties sheet and make any changes to column names or data types. As soon as you are satisfied with the format, you can close the form and then click the **green arrow** button to start your data load job. 
  ![ALT text is not available for this image](images/2879071254.png)

### Inspecting Data In Table MOVIE\_SALES\_2020

1. Navigate to the **Data Load** main page and click the **Explore** card. You'll now see table MOVIE\_SALES\_2020 has been loaded into your Autonomous Data Warehouse.
2. Click this table and then click **Statistics** on the panel to the left of the screen. Statistics help you quickly understand the structure and content of the table. In this case, this data presents a nice simple way to characterize the data you've just loaded. 
  ![ALT text is not available for this image](images/2879071255.png)

### Identifying Data Problems

1. Click on the word **DAY** in the first column. You can see that there are 14 distinct values - which looks odd. The low value is **FRIDAY** (i.e. it's all uppercase) and the high value is **Wednesday**, which is in title case. The distribution of these values is shown in the bar chart at the bottom of the form (see the image above). As you move your mouse across these bars you can see there are two separate bars for each day; one in uppercase and the other in title case.
2. You can also see that you have data for twelve months. This should not be a surprise since the data extract you loaded in the previous step was for 2020. However, for your quarterly reporting project it's obvious that you have too many months: your mission here is to analyze data only for Q2. 
3. Right now, simply take a note of these issues. You will address these issues in a later stage of the workshop. 

### Loading Reference Data from Object Store

 **Important**: If you succeeded in loading the four reference tables, COUNTRIES, DAYS, DEVICES and MONTHS from local disk, you should skip ahead to **RECAP**.

This section is provided in case your workshop environment does not allow you to download files to your local machine. If you're unable to do this, of course you will have been unable to complete the previous section, **Loading Data from Local Files**. You still need the reference data for subsequent steps of the lab, and if you are in this situation, you should complete the following steps.

1. To load the reference tables from object storage, navigate to the **Data Load** main page. Select the cards for **Load Data** from Object Storage and click **Next**.
  ![ALT text is not available for this image](images/2879071251.png)
2. Select the four files: **Countries.csv**, **Days.csv**, **Devices.csv** and **Months.csv**. Drag-and-drop them on the **Data Loading** area, as shown below.
  ![ALT text is not available for this image](images/2879071256.png)
3. Four cards will appear on the data loading area; one for each source file / target table combination. Click the green **Play** button. 
  ![ALT text is not available for this image](images/2879071257.png)
4. Then click **Run** in the dialog that appears.
  ![ALT text is not available for this image](images/2879071258.png)
5. When the job has completed, you'll see check marks on the left of each card to indicate that the data has loaded successfully.
  ![ALT text is not available for this image](images/2879071259.png)

### **Notes**:

1. Autonomous Database supports uploading of .xlsx files from local disk, but not from Object Stores. Only .csv files are currently supported.
2. Autonomous Database does not currently support loading files from sub-folders in Object Stores.

### Cleaning Up Data Load Log Tables

During data load from Object Storage, Autonomous Data Warehouse creates a number of ancillary tables for logging purposes.

1. Following data load from Object Storage, if you click the **Explore** card on the **Data Load** main page, it may look like this: 
  ![ALT text is not available for this image](images/2879071249.png)
2. Four such logging tables are highlighted above. There may be more than one table with names beginning with COPY$. Following the successful load operations, these tables are no longer required, and can safely be dropped. You'll do this using a SQL Worksheet. Navigate to this tool directly from the hamburger menu at the top left, open the Development menu if necessary, and press **SQL**.
3. Drop the tables as follows:

    a. Click the **refresh** button (circular arrows) to see the full list of tables in the schema and identify the logging tables.
    b. For each table type, drop table {TABLE NAME} in the SQL Worksheet.
    c. Click the green **Play** button.
    d. Confirm the successful deletion in the Script output pane.
  ![ALT text is not available for this image](images/2879071250.png)

### RECAP

In this section, you loaded data into your ADB from files both on your local computer and in the object store. In both cases this was simply a matter of dragging and dropping. Inspection of the data in table MOVIE\_SALES\_2020 identified two problems:

- You have too much data: Movie consumption for all of 2020, whereas you only want data for Q2.
- Column DAY contains values that are both in upper case and title case. 

You will correct these data problems in the next step of the workshop. 

## STEP 3 - Using Data Transforms

### MovieStream Critics Corner: Data Transforms

*Just as the good folks at MovieStream are very proud of the SciFi lineup, we in the Autonomous Database team are very proud of our Data Transforms tool. There’s an eponymous movie series in the SciFi genre and fans of that will truly appreciate the value of a tool that can transform, perhaps a third normal form application schema into a star schema suitable for analysis. Even if it’s only a quick clean up of source data, you’ll be glad to have the Data Transforms tool at your fingertips.*

### Overview

In this section of the lab, you'll correct the data errors identified in the previous section of the lab. In a future version of this lab, we’ll show you how to do this using drag-and-drop techniques via the Data Transforms Tool.

#### Video Preview

Watch a video demonstration of the Data Transforms tool of Autonomous Database:

[] (youtube:Xg5VK_R4-IM)
*Note: Interfaces in this video may look different from the interfaces you will see.*

That’s something to look forward to, but is not currently covered in this lab.

### Using SQL 

As an alternative to using the Data Transforms Tool, you can perform the necessary fixes to the data set using SQL. This is covered here. 

1. From the Autonomous Database **Tools** home page, access a SQL worksheet by clicking the **SQL** card on the **Database Actions** page. Cut and paste the following SQL statement into the Worksheet.

    ```
  create table MOVIE_SALES_2020Q2 as
  select COUNTRY
  , initcap(DAY) as DAY -- Use title case for days
  , MONTH
  , GENRE
  , CUSTOMER_SEGMENT
  , DEVICE
  , SALES
  , PURCHASES
  FROM MOVIE_SALES_2020
  where month in ('April','May','June'); -- only want data from Q2
  exec dbms_stats.gather_table_stats(user, 'MOVIE_SALES_2020Q2');
    ```

2. Select the entire text in the Worksheet and press the **green** button to run these two statements. You should see that both statements have executed successfully. Having completed this step you now have a table MOVIE\_SALES\_2020Q2, with data for just April, May and June. The days have all been changed to title case.

## STEP 4 - Creating a Business Model

### MovieStream Critics Corner: Business Model

*You know that frustrating feeling of joining your friends and family who are half way through watching a movie? Having missed out on the introduction, much of what you see makes no sense to you. Often that’s what it’s like looking at a bunch of data that does not have a good semantic model. That’s where Autonomous Database’s Business Model tool comes in. Hierarchies, dimensions and measures are automatically detected to give you a head start. The business model is built in to the database itself, so that it is accessible to all users of the database, regardless of which tool they use to access the data.*

### Overview

You can only go so far looking at raw data. Before long you want a semantic model on top of it. That's where our Business Model tool comes in. We've made it simple to build sophisticated models on your data, by identifying dimensions, hierarchies and measures - with a nice clean way of saying how to aggregate - sum, average or whatever. But wait, there's more. We make it fast, too! Simple SQL written against the business model is re-written to ensure optimal data access, and because we know about the hierarchical structure of the data, we can pre-aggregate the totals and sub-totals you want, before you've even told us you want them! 

#### Video Preview

Watch a video demonstration of the Business Model tool of Autonomous Database:

[] (youtube:i2na8dmE_Xc)
*Note: Interfaces in this video may look different from the interfaces you will see.*

In this section of the workshop, you'll create a Business Model over table MOVIE\_SALES\_2020Q2.

1. Start by clicking the **Business Model** card in the ADB **Database Actions** page. The page on which you'll land has some text explaining the Business Model utility in some detail, but let's dive straight in.
2. Press one of the **Create Model** buttons. If MOVIE\_SALES\_2020Q2 is not already identified as the Fact Table, select it from the pick list. (Be sure to select table MOVIE\_SALES\_2020**Q2**, which has just the data for April, May, June, and not table MOVIE\_SALES\_2020, which has data for the full year!)
  ![ALT text is not available for this image](images/2879071219.png)

### Generating A New Business Model

3. Now, press **Next** to start the Auto-Business Model utility. This will take several seconds to complete, after which you'll see a dialog such as this.
  ![ALT text is not available for this image](images/2879071220.png)

### Expand Data Sources

4. Press **Close** and select **Data Sources** from the panel at the left of the screen. You'll see that a star schema has been identified, based on the tables that you loaded in previous steps of this lab. All columns of the Fact Table, MOVIE\_SALES\_2020Q2, are  already shown.

5. Press the **three dots** to the right of table DAYS and select **Expand**. Repeat this for the other three dimension tables. You should see the star schema laid out as follows:
  ![ALT text is not available for this image](images/2879071210.png)

### Refining Your Hierarchies

6. Select **Hierarchies** from the list on the left of the screen and click the three dots to the right of the row for hierarchy **CONTINENT**.
  ![ALT text is not available for this image](images/2879071211.png)

7. Notice that the business model tool has detected a hierarchy of Countries within Continents, based on the structure and contents of the tables in the Autonomous Data Warehouse. 
  ![ALT text is not available for this image](images/2879071212.png)

8. This is a great head start, but a better term to use for this hierarchy would be geography. Override the default **Hierarchy Name, Caption and Description** for this hierarchy with the word **Geography** as shown below. Then click **Save**. 
  ![ALT text is not available for this image](images/2879071213.png)

9. Hierarchy DAY\_NUM\_USA looks a little odd. Let's clean that up:

    - Click the three dots to the right of that hierarchy and select **Edit**. 
    - Change *Hierarchy Name* to "DAY".
    - Change *Caption* and *Description* to "Day".
  ![ALT text is not available for this image](images/2879071214.png)

10. This is simply a day-of-week hierarchy, but now you'll see the value of the table that the sales analyst had set up in a previous analysis. Sorting days alphabetically is not particularly helpful. What's preferable is to sort by the day number of week. Conventions for day numbers vary across the world and the DAYS table supports both the European and the North American conventions. You'll use the North American convention for this exercise. 

    - Remove the DAY\_NUM\_USA *level* by selecting that level and pressing the minus button above the hierarchy list.
  ![ALT text is not available for this image](images/2879071215.png)

11. Next, change the Sort By to DAY\_NUM\_USA. Then click **Save**. 
  ![ALT text is not available for this image](images/2879071216.png)

12. Similarly, change the MONTH dimension as follows:
  ![ALT text is not available for this image](images/2879071217.png)

### Working With Measures

13. Now select **Measures**, the last item on the list on the left of the screen. Notice that Auto-Business Model has identified SALES and PURCHASES as candidate Measures from the Fact table (because these are numeric columns).

    a. Measure SALES is a dollar amount.

    b. Measure PURCHASES is a tally of the number of purchases made.

14. The default aggregation expression for the measures is SUM. Other expressions could be selected, but for the purposes of this workshop, SUM is the appropriate value to select in both cases.
  ![ALT text is not available for this image](images/2879071218.png)

15. Press **Create** and then **Yes** in the confirmation dialog. After a few seconds the Business Model is successfully created, and represented by a card at the bottom of the screen.

16. Press the three dots on the top right of the card and select **Show DDL** from the list that appears. 
  ![ALT text is not available for this image](images/2879071207.png)

17. Experienced users of Oracle Database will note that the Business Model is implemented in the database as an Analytic View. Experienced or not, it's nice to know that you didn't have to type any of that DDL! Click **Close** to return to the Business Model screen, click the **three dots** on the Business Model's card again and this time select **Analyze** from the list that appears. Notice that there are three tabs across the top of the Analyze Business Model screen.

18. In the Hierarchies tab:

    a. Change the layout for hierarchy Geography to be **All **by selecting that value from the pick list.

    b. Change the layout of CUSTOMER_SEGMENT to **Column**.

    c. Change the layout of FORM_FACTOR to **Row**.

19. In the Measures tab:

    a. Deselect measure **SALES**.

    b. Select measure **PURCHASES**.

20. Then click on the **Data** tab at the top of the dialog box. You should see a data summary similar to this. (It may be necessary to widen the dialog to see the full width of displayed data.)
  ![ALT text is not available for this image](images/2879071208.png)

21. Having completed this step, you now have a Business Model over table MOVIE\_SALES\_2020Q2. This features hierarchies, measures (including aggregation expressions), and provides a preview pane in which to view the data and do some rudimentary analysis. Press **OK** to return to the Business Model page. Shortly you'll return to the Autonomous Database Home Page, but first let's explore some of the various navigation techniques availably throughout the tool suite. 

22. From the three-dot menu of the Business Model card, there are options to navigate directly to Insights and Catalog for this Business Model. (You'll use these tools in subsequent sections of this workshop.)


    a. From the **hamburger menu** on the top left of the screen, you can navigate directly to any of the Built-In tools.

    b. Alternatively, from the hamburger menu, you can return to the Database Actions menu, also known as the home page of the Built-In Tool Suite.
      ![ALT text is not available for this image](images/2879071209.png)

    c. Here you'll take option 3: Select **Database Actions** from the list accessed via the hamburger menu. 

## STEP 5 - Generating Data Insights 

### MovieStream Critics Corner: Data Insights

*If Sherlock Holmes is your hero, MovieStream has hundreds of movies in the detective genre for you to enjoy. You’ll enjoy the Data Insights tool of Autonomous Database, too. Just as Dr. Watson marvels at Holmes’s perspicacity, you’ll marvel as Data Insights scours thoroughly through the data to find all the essential clues, as if to say, “It’s elementary, my dear Watson.”*

### Overview

If the sales analyst's job can be likened to looking for a needle in a haystack, the Data Insights tool can be thought of as an electromagnet. Swing it over the haystack and turn on the power. Anything made of ferrous metals will be pulled on to the electromagnet. There may be all sorts of junk here -  rusty old nails and screws and nuts and bolts - but there are going to be a few needles as well. It's far easier to pick the needles out of these few bits of metal than go rummaging around in all that hay - especially if you have hay fever! That's more or less how our Insights tool works, as you shall see in this section of the workshop.

#### Video Preview

Watch a video demonstration of the Data Insights tool of Autonomous Database:

[] (youtube:pLaZnCQk3Vs)
*Note: Interfaces in this video may look different from the interfaces you will see.*

### Generating New Insights

1. From the Autonomous Database **Tools** home page, click the **Insights** card. If this is the first time you've accessed this tool (or any other in the Built-In Tool Suite), you'll see a series of tool tips to show you how to use it.
  ![ALT text is not available for this image](images/2879071206.png)
2. If the tool tips do not appear, they can be accessed by Clicking the binoculars icon on the upper-right of the screen (under your username). Click **Next** repeatedly to browse through the tool tips for the Data Insights module. (To exit at any time, press X in the upper right of the tool tip.)
3. In this exercise you're going to follow a procedure exactly as laid out in these tool tips, thus:

    a. Under **Resource**, select Analytic View MOVIE\_SALES\_2020Q2\_MODEL (which is the basis for the Business Model you created in Step 3). 

    b. Under **Measure**, select PURCHASES.

    c. Press **Search**.

    The Data Insights tool is now scouring through the data in your business model, looking for hidden patterns, anomalies and outliers in the data set. You may be interested to know that these queries employ many of the built-in analytical capabilities of Oracle Database. A typical example is **Regression Slope**. Note that this process can take several minutes to complete, since a very large number of queries are being executed. This might be a good time to stretch, get a refreshment and let Autonomous Database do the hard work for you! You can monitor the progress bar towards the upper left of the screen. While it is processing the screen will refresh automatically as various insights appear on the screen. At any point it is possible to disable auto-refresh to freeze a particular set of "gauges on the dashboard". This technique allows you to drill into a specific insight, while processing continues. You'll notice that it's possible to toggle between these two modes of *Enable Auto Refresh* and *Disable Auto Refresh*. When the search has completed you'll see a dashboard with a bar chart (gauge) for each of the top twenty insights, as defined by the data patterns found to be most anomalous in the data set.
  ![ALT text is not available for this image](images/2879071203.png)



4. Scrolling down if necessary, click on one of these, such as the bar chart for "GENRE in June" (fourth item on the third row in this screenshot). This drills down into a detailed view of this Insight, similar to this:
  ![ALT text is not available for this image](images/2879071204.png)
  This chart shows actual purchases (blue bars) vs expected purchases (green lines) of various movie genres in the month of June. Three segments have bold black borders. These indicate the most anomalous values, showing that the consumption of:

    a. Comedies and Romances are higher than expected, and

    b. Sci-Fi is lower than expected.

5. The actual and expected values are shown for the highlighted bar (Romance in this screenshot). The way to read this is, "compared to the other months in the quarter–April and May–in June there was a lower than expected consumption of Sci-Fi movies, and a higher than expected consumption of Comedies and Romances." Perhaps what the data is showing you is that as we enter the summer months, people are feeling more light-hearted and romantic, and need correspondingly less escapism in their movie choices. **This is indeed quite an actionable insight, and it's far from an obvious one**. Based on this anomalous pattern, which Data Insights found in the data without the need for any painstaking slicing and dicing, the sales analyst may now be able to propose a marketing campaign for next Q2, making movie recommendations to customers based on a seasonal shift in taste for genres. 

6. Click the **Back** button on the top left of the screen to return to the **Insights** dashboard. You may wish to browse through some of the other Insights shown. Several of these represent other valuable information for your sales analyst. Others may be less interesting– at least for the current purposes of your sales analyst. Returning to the analogy of the needle in the haystack, these might be considered the rusty nails pulled out by the electromagnet. 

### Retrieving Insights

In this exercise you have run the Data Insights tool for what may be the first time. Over time it's likely that Data Insights will be run repeatedly over various data sets. You've also seen that, because of the vast number of queries that are involved in running the Data Insights tool, it can take some time to complete searching for Insights on a new data set. For these reasons it can be very useful to be able to retrieve insights that have already been run. You'll walk through this process now in the following steps:

1. Return to the home page, by clicking the hamburger menu on the upper left of your screen and selecting **Database Actions**.
2. Click the **Data Insights** card to return to the Data Insights screen. 
3. Click the three-bar menu to the upper right to open the list of **Recent Searches**. 
4. Select the appropriate search from the list that appears. (There's only one in this example.) The data for this search will be retrieved. 
  ![ALT text is not available for this image](images/2879071205.png)

### Running Insights against Tables

It's also worth noting that Data Insights can be run directly against a table, and it is certainly not wrong to do so. In many cases this can be a useful technique to use for data profiling. It can often identify data anomalies that represent data items that need to be addressed with further data preparation. (Typical examples include unwanted sub-totals, or perhaps multiple values for a single logical category - which suggest the need for filtering and data cleansing. The built-in Transforms tool is ideal for addressing these requirements.)

### RECAP

Historically, data analysts would pore over data sets, slicing and dicing, looking for hidden patterns or outliers in the data. With Autonomous Database the data analyst is now armed with the automatic Data Insights tool, which performs the same operations unattended. This gives the analyst a significant head start in understanding what's really important about their data set.

## STEP 6 - Using Autonomous Database Catalog

### MovieStream Critics Corner: Catalog

*True fans of period dramas on MovieStream study [Burke’s Peerage](https://www.burkespeerage.com/) in their spare time. They know that impeccable lineage is a non-negotiable quality in a suitable love-match for an aristocrat. They are just as keenly aware that a clear line of succession is an essential consideration. The untimely demise of a principal character could have profound implications for the continuity of a great family’s line. These people will have an instinctive appreciation for Autonomous Database’s Catalog tool, which shows both Lineage and Impact Analysis clearly for any entity in the system, be it a table, view, business model or whatever.*

#### Video Preview

Watch a video demonstration of the Catalog tool of Autonomous Database:

[] (youtube:qi7HxiVyfOc)
*Note: Interfaces in this video may look different from the interfaces you will see.*

Data is capital and the built-in Catalog tool allows you to maximize its value. Data Lineage and Impact Analysis are now at your fingertips in this integrated tool, which you explore in this part of the workshop.

1. From the **Database Actions** page, select the **Catalog** card. You'll land on a page looking like this. 
  ![ALT text is not available for this image](images/2879071201.png)
2. To understand this screen, glance at the upper left to notice that for the current schema, entities of type **TABLE** are currently shown, with a card for each. On the upper right, you'll notice that the third icon from the right (card view) is selected. Click the button to its right to show the information in grid view:
  ![ALT text is not available for this image](images/2879071202.png)
3. Click the icon on the far right for list view:
  ![ALT text is not available for this image](images/2879071194.png)
4. Personal preference and different use cases may dictate which viewing option is preferable. For the purposes of this section of the workshop, click the **Card View** icon to return to that layout.

### Searching The Catalog

1. The catalog has a browser-like search capability. In the search bar across the top, enter "**movie sales**" (no quotes) and click **Enter**.
2. Only entities matching these criteria will be displayed.
  ![ALT text is not available for this image](images/2879071195.png)

### Changing the Filter

1. On the upper left of the screen, just above the cards, is the **filter** icon. Click this.
2. Under Entity Type, click **More...** and check the boxes for Analytic View and Business Model. Then click **Apply**.
  ![ALT text is not available for this image](images/2879071196.png)
3. You now see that the Entity Type list at the top has been expanded correspondingly, and that four cards are displayed. Besides the two tables you saw initially, there are now cards for the Business Model and the Analytic View on which it's based. 
  ![ALT text is not available for this image](images/2879071197.png)
4. Clear the search by clicking **x** on the right end of the search bar. Now you see eight cards; six tables, a business model and an analytic view.
  ![ALT text is not available for this image](images/2879071198.png)

### Understanding Data Lineage

An important consideration in understanding the reliability of data is its source, or lineage. This capability is built into the Catalog.

1. Click the three dots on the upper right of the card for table **DEVICES**, and select **View Details**. On the left of the panel that appears you'll see tabs for *Preview, Lineage, Impact, Statistics* and *Data Definition*. Here you'll notice the consistency of the widgets used between the various tools that you've explored in this lab. Preview is the default selection. You've seen Statistics and Data Definition elsewhere in this workshop.
2. For this exercise, click **Lineage**. Various different levels of information are accessible by expanding the various cards as required. To do this, click the three dots to the right of the card and select **Expand***.* Even more information is visible by hovering the mouse pointer over specific areas of the screen. An example is shown below. 
  ![ALT text is not available for this image](images/2879071199.png)
3. Click **Close** in the lower right of the screen (or click the **Esc** button on your keyboard) to return to the main catalog view. 

### Impact Analysis

You may think of impact analysis as the inverse of lineage. It shows which other entities are dependent on a specific entity. In this exercise you'll look at the Impact Analysis for table MOVIE\_SALES\_2020Q2.

1. Click the three dots for that card, select **Expand** and then select the **Impact** tab on the left of the screen that appears. You should spend some time exploring the Impact Analysis for this table. Depending on how you drill down (Expand), you may see a screen like this.
  ![ALT text is not available for this image](images/2879071200.png)It's worth pausing here to reflect on quite how extensive the impact analysis is for this simple exercise. Here you have a single table, on which you built a business model. This is implemented as an analytic view, including a number of Attribute Dimensions. Against this you ran an Data Insights job, which resulted in a large number of Insights queries.
2. If you **Expand** on **REQUEST\_INSIGHT_1** (on the right of the screen) you'll see some of the many queries that were executed as part of the Data Insights job, perhaps while you were sipping your coffee! Tip: You can return to a lower-resolution of data by selecting *Collapse* for an entity that had previously been *Expand*ed. 
3. **RECAP** - This concludes the brief guided tour of the **Catalog** tool. In this section you have seen:

    a. How to view data in card view, grid view and list view

    b. How to use the browser-like search capability

    c. How to change the filter

    d. How to view Lineage

    e. How to view Impact Analysis

4. Feel free to explore more of its capabilities, or else click **Close** and return to the Autonomous Database Home Page from the hamburger menu at the top left of your screen.

## Want To Learn More

See the documentation on [Database Actions](https://docs.oracle.com/en/database/oracle/sql-developer-web/sdwad/about-sdw.html#GUID-AF7601F9-7713-4ECC-8EC9-FB0296002C69).

## Acknowledgements

- Created By/Date - Patrick Wheeler, Product Management, Autonomous Database, March 2021
- Contributors - Keith Laker, Rick Green, Nilay Panchal, Hermann Baer
- Last Updated By - Rick Green, March 2021
