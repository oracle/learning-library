# Leveraging OAC Data Flow with ADW

## Introduction

In this lab, you will learn about OAC Data Flow, the use case, benefits and how to use it to save your curated data in ADW.  
Data Flow is a lightweight, simple and easy to use tool for business users to combine, organize and integrate data-sets and produce a curated data set (or data sets) that your users can analyze.
Data Flow, is an important enabler of self – service, analytics environment.
You can curate data from data sets, subject areas, or database connections.
Curated data can also be send back to a relational database or Essbase for any downstream processing.

_Estimated Lab Time_: 20 minutes

![Data Flow](../data-flows/images/data-flows.png)

### Objectives

* OAC **Data Flow**

### Prerequisites

* An Oracle Cloud Free Tier or Paid account
* You should have completed  
    * Lab 1: Provisioning your Autonomous Database instance
    * Lab 2: Provisioning your Oracle Analytics Cloud instance
    * Lab 3: Connecting OAC to ADW and adjusting Data Set properties
    * Lab 5: Gaining Insights with Visual Data Dialog
    * Lab 6: Monitoring and Ad-hoc scaling up ADW activity for optimal OAC experience
    * Lab 7: Building simple Interactive Analysis
    * Lab 8: Mashing up additional Data Sets, Contextual Data Preparation
    * Lab 10: Geo Maps and Custom Binning

## **STEP 1**: Data Flow

Data Flow enables training of Machine Learning models and application models for scoring of data and detects sentiment from a text column allowing for Sentiment Analysis.
To build a Data Flow, you add steps. Each step performs a specific function, for example, add data, join tables, merge columns, transform data, save your data. Use the Data Flow Editor to add and configure your steps.  
Lets create a Data Flow by leveraging the mashup data set we used in the earlier sections

1.  Create Data Flow.  
On the **Home** or Data **page**, click **Create** and select **Data Flow**

    ![Create DF](../data-flows/images/createdfsmall.png)

2.  Add Data Set.  
You can select an existing Data Set or click Create Data Set to create a new one based on a file, local subject area, or database connection.  
In the **Add Data Set** dialog, Select **customers** Data Set and Click **Add**.

    ![Add Data Set](../data-flows/images/createdf2small.png)


3.  You can see the Data Flow Editor with the Data Flow Steps. Lets start working by converting the data type of CUST\_ID column.  
It's going to add a transform column step to the data flow.  
Select **CUST\_ID** > Options select **Convert to Text**

    ![Convert To Text](../data-flows/images/custidtotext2.png)

4.  Notice a new step has been added.  
Click **Validate** to check that the syntax is correct.

    ![Validate](../data-flows/images/custidtotext3.png)

5.  There are various transformation options available like Merge, Rename, Split etc. Let's remove unwanted columns using the **Select Columns** step.  
Click **Add a Step(+)** and Click **Select Columns**.

    ![Select Columns](../data-flows/images/addstep-selectcolumns.png)

6.  **Remove** **CITY\_Population**, **CREDIT\_LIMIT** columns.  
Select CITY\_Population, CREDIT\_LIMIT and Click **Remove selected** button.

    ![Remove Columns](../data-flows/images/selectcolumnremoveselected.png)

7.  Lets **filter** our Data Set to retain only few States.  
Click **Add a Step(+)** and Click **Filter**.

    ![Filter](../data-flows/images/addfilter.png)
    * Click **Add Filter**

     ![Filter](../data-flows/images/addfilter2.png)

    * Select **STATE** from the available data

     ![Filter](../data-flows/images/addfilter3.png)

    * Select **AK, AL, AR, CA, CO**

     ![Filter](../data-flows/images/addfilter4.png)

8.  Lets now **merge** the first name and last name as a single column and call it **Customer Name**.  
Click **Add a Step(+)** and Click **Merge Column**.

    ![Merge Column](../data-flows/images/mergecolumn.png)

9.  New column **Customer Name**.  
Type in **New column name**: 'Customer Name', **Merge column** select 'FIRST\_NAME', **With**: select 'LAST\_NAME' and **Delimiter**: Space ( ).

    ![Customer Name](../data-flows/images/customername.png)

10.  Notice the new column created.

     ![Customer Name](../data-flows/images/mergecolumncustomername2.png)

11.  Renaming columns can be achieved by using Rename column step.  
Click **Add a Step(+)** and Click **Rename**.

     ![Rename Column](../data-flows/images/renamecolumn.png)

12.  Type in the **Rename** column change INCOME\_LEVEL to **Income Level** and MARITAL\_STATUS to **Marital Status**.  

     ![Rename Column](../data-flows/images/renamecolumn2.png)

13. Lets now **save** the **output** as a table in our **ADW** connection.  
Click **Add a Step(+)** and Click **Save**.

     ![Save Data](../data-flows/images/savedata.png)

14. Type in the following:  
**Data Set**: DCA\_CUST\_DATA  
**Save data to**: select **Database Connection**  
**Connection**: ADWH (that's the connection you setup in "**_Lab 3: Connecting OAC to ADW and adjusting Data Set properties_**", **_Step 4_**)  
**When run**: select **Replace existing data**

     ![Save](../data-flows/images/savedata2small.png)
     ![Save](../data-flows/images/savedata3small.png)

15.  Column property can be changed at the time of saving the data to attribute/metric if needed.

     ![Column Property](../data-flows/images/savedata4small.png)

16.  Lets save and execute the Data Flow.  
Click **Save icon**, type in the **Name**: 'Training DF' and Click **OK** button.

     ![Save DF](../data-flows/images/savedataflowsmall.png)
     ![Save DF](../data-flows/images/savedataflow2small.png)

17.  Click **Run** icon and check the _complete_ message.

     ![Run](../data-flows/images/rundataflowsmall.png)  
     ![Run](../data-flows/images/rundataflow2.png)

18.  Go to the OAC Home page.  
Click on **Go Back** icon.

     ![Go Back](../data-flows/images/gobacksmall.png)

## **STEP 2**: Connect to SQL Developer Web tool to check your data

**Oracle SQL Developer Web (Database Actions)** is the web-based version of Oracle SQL Developer that enables you to execute queries and scripts, create database objects, load data, build data models, and monitor database performance.  
To connect to Oracle SQL Developer Web you have at least a couple of options.

1.  First option: you can replicate the steps from ""**Lab 3: Connecting OAC to ADW and adjusting Data Set properties**"", "**STEP 1: Load data to your Autonomous Database**".  
Essentially from your **Autonomous Database Details** page, click the **Tools** tab. Click **Open SQL Developer Web**..

2.  Second option: you can directly connect to the SQL Developer Web page URL. The URL should be similar to  
<https://dbname.adb.us-ashburn-1.example.com/ords/schema-alias/_sdw/?nav=worksheet>  
In the SQL Developer Web Sign in page, enter your **Username** and **Password**...
    > For more details please check [Connect with Built-in Oracle Database Actions](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/sql-developer-web.html#GUID-102845D9-6855-4944-8937-5C688939610F)

3.  Go to the **Worksheet** pane and **Run** a basic Select statement (SELECT * FROM ADMIN.DCA\_CUST\_DATA;)

    ![Sql Dev Web](../data-flows/images/sqldev-web.png)


You have just finished learning about the Data Flow feature of OAC.

You may now [proceed to the next lab](#next)

## Want to Learn More?

* Free [Udemy: Augmented Data Visualization with Machine Learning](https://www.udemy.com/machinelearning-analytics/), Section 3: Data Flow Deep-Dive with Oracle Analytics  
* [Curate Your Data Using Data Flows](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/curate-your-data-using-data-flows.html)
* [Where is the Log for My Data-Flow In Oracle Analytics?](https://blogs.oracle.com/analytics/where-is-the-log-for-my-data-flow-in-oracle-analytics)
* [Merge Data Easily Using Oracle Analytics Data Flow Feature](https://blogs.oracle.com/analytics/merge-data-easily-using-oracle-analytics-data-flow-feature)
* [How to Create Data Flow Sequences in Oracle Analytics Cloud](https://blogs.oracle.com/cloud-platform/how-to-create-data-flow-sequences-in-oracle-analytics-cloud)
* [Perform Incremental Data Loads in Oracle Analytics Cloud](https://blogs.oracle.com/analytics/perform-incremental-data-loads-in-oracle-analytics-cloud)
* [Smarter and More Efficient Dataflows in Oracle Analytics](https://blogs.oracle.com/analytics/smarter-and-more-efficient-dataflows-in-oracle-analytics)

## **Acknowledgements**

- **Author** - Lucian Dinescu, Product Strategy, Analytics
- **Contributors** -
- **Reviewed by** - Shiva Oleti, Product Strategy, Analytics
- **Last Updated By/Date** - Lucian Dinescu, April 2021