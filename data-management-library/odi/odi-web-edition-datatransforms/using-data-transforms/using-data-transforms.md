
# Using Data Transforms

## Introduction

Data Transforms tool provides a simple drag and drop low-code environment for creating data integration projects. It is powered by **Oracle Data Integrator**. Oracle Data Integrator (ODI) is Oracle's industry-leading, enterprise-class data integration tool. It features an extract-load-transform (ELT) architecture, which delivers very high performance, scalability and reliability because it uses the target database to execute transformations. Why do an &quot;E&quot; and an &quot;L&quot; if all you want to do is a &quot;T&quot;? That's the problem with legacy ETL tools with server-based architectures that require data to be extracted for processing (transformation) and reloaded afterwards.

Data Transforms tool uses Autonomous Database as the data transformation engine and leverages database features for complex transformation processing. At the same time, it has hybrid connectivity to many sources and targets from which data can be extracted and loaded to. 

This lab shows you how to use Data Transforms using a simple data source that has been loaded earlier. After this users can explore other connectivity options and more complex transformations as needed.

Estimated Lab Time: 60 minutes

### Objectives

In this lab, you will:

- Learn basic navigation in Data Transforms

- Connect to Autonomous Database and import definitions of tables

- Create a simple data flow and execute the flow

- Inspect the executed job

- Create a workflow and schedule the job

### Prerequisites

To complete this lab, you need to have the following:

- Autonomous Database with source data already loaded

- Oracle Data Integrator Web Edition deployed 

- Familiarity with Database concepts

## **STEP 1:** Launch Data Transforms and Connect to Autonomous Database

1. Launch **Data Transforms** from either direct URL or from the Data Transforms card in Autonomous Database. Specify username **SUPERVISOR** and the password that you provided in the ODI installation. Click **Connect**.

    ![ALT text is not available for this image](images/3019662951.png)

2. In the Data Transforms main page, click on **Connections** on the left of the screen. You'll see that a default connection has already been configured. It may look similar to the screenshot below (possibly with a somewhat obscure name). Click on the card for this connection. 

    **NOTE:** If you don't see your Autonomous Database here then it means the ODI deployment script could not scan your database due to some privilege or policy issues. In that case, we will manually add a new connection to your database. Skip to step 5.

    ![ALT text is not available for this image](images/3019662952.png)

3. Override the default values of the fields indicated below with the following values:

    - Name - MovieStream

    - User - QTEAM

    - Password - (the password you specified for user QTEAM)

    ![ALT text is not available for this image](images/3019662953.png)

4. Review the connection details in the panel to the right, and press **Test Connection**.

    All being well, you'll get a message to confirm that the connection test has succeeded, similar to this. If not, verify and correct your entries and try again.

    ![ALT text is not available for this image](images/3019662954.png)

5. **NOTE:** Skip to step 8 if your Autonomous Database connection was automatically created in previous steps. We will manually create a connection to your Autonomous Database if it was not there. **You need to download wallet file for you autonomous Database to your local laptop. Come back to this step after you have downloaded the wallet file.**

    Click on **Create Connection**.

    ![ALT text is not available for this image](images/3024272093.jpg)

6. Enter the name for the connection &quot;MovieStream&quot;, click on Oracle in **Connection Type** and click **Next**.

    ![ALT text is not available for this image](images/3024272103.jpg)

7. Enable **Use Credential File**. Drag and drop the **Wallet File**. Select a **Service** (```your_db_name```_low) and enter your **user** and **password**.

    Click **Test** and after successful connection click **Create** to create the connection to your Autonomous Database.

    ![ALT text is not available for this image](images/3024272116.jpg)

8. Notifications for many important operations are logged while you use Data Transforms. To view these notifications, click on the bell at the top of the screen, and you'll see a summary of these, which may look like this.

    ![ALT text is not available for this image](images/3019662955.png)

9. Now we need to import the definitions of the tables in QTEAM's schema. Click on **Data Entities** (on the left of the screen) and then **Import Data Entities**. 

    ![ALT text is not available for this image](images/3019662841.png)

10. The following dialog appears. Identify the connection and schema from which to load metadata and press **Start**. You will get the notification for the import job. It will take few minutes for the job to finish.

    ![ALT text is not available for this image](images/3019662842.png)

11. You'll see a list of all five tables imported so far (wait for few minutes for the import job to finish and refresh if you don't see it). Type **movie** into the filter on the left of the screen to reduce the list of tables displayed to just one table: `MOVIE_SALES_2020`. Click the three dots to the right of the table's entry on the list and select **Preview**. 

    ![ALT text is not available for this image](images/3019662843.png)

12. As expected, we see again here the data errors that we identified at the end of the Data Load section of the workshop: We have data for all of 2020, whereas the the task assigned to the departmental analyst is to analyze only the data from Q2. We see that some of the values for DAY are upper case, while others are in title case. (This is not an uncommon situation where there are incremental loads of data into source systems, and is likely what has happened here. In general we need to be able to accommodate and correct these data errors, which is why it's invaluable to have a Data Transform capability built into Autonomous Data Warehouse.) Again, our mission here is to correct these errors.

    ![ALT text is not available for this image](images/3019662869.png)

You may already have noticed that the look-and-feel of the data previewer is consistent both here in the Data Transforms tool and in the Data Load tool that we used in the previous section of the workshop. Autonomous Database tools are integrated across the suite, with consistent user experience to minimize learning curve.

Close the preview pane by pressing the **X** on the upper right of the screen.

## **STEP 2:** Create Data Flow

1. Click **Projects** (on the left of the screen, and then click **Create Data Flow.**

    ![ALT text is not available for this image](images/3019662870.png) 

2. In the Data Transforms tool, Data Flows are organized within projects. As we have neither yet, the dialog that appears allows us to define both in a single step. Specify the following values in the dialog, as shown below, and click **Create**.

    - **Name:** MovieStream_Q2FY2020
    - **Create new Project:** Radio button selected
    - **Project Name:** MovieStream
    - **Description: **Extract & fix data for Q2 FY2020

    ![ALT text is not available for this image](images/3019662871.png)

3. This will open the Data Flow Details screen, which looks like this:

    ![ALT text is not available for this image](images/3019662872.png)

4. This screen is divided into four sections, as shown in the annotations here:

    ![ALT text is not available for this image](images/3019662873.png)

    In the next few steps, we're going to define a data flow as follows:

      - Apply a filter to table `MOVIE_SALES_2020` to remove data for the months outside Q2.

      - Fix the inconsistencies in the case of the DAY column.

      - Push the resulting data to a new table MOVIE\_SALES\_2020**Q2**. 

      Here goes!


5. We'll begin to build our first Data Flow with the following steps:

    - In the **Data Entities** pane, click the refresh button (circular arrows) at the top.

    - Expand the QTEAM schema to see the list of tables.

    - From the list that appears, click on table `MOVIE_SALES_2020`.

    - Drag `MOVIE_SALES_2020` to the **canvas**. (Pro tip: select the table name in one click-and-release, and drag it to the canvas in a second mouse gesture.)

    - From the **Tool Palette**, click on the **DATA TRANSFORM** tab if it is not already highlighted.

    - Drag the **Filter** tool to the canvas.

    - Click on the bubble for the Filter tool to select it.

    - In the **Properties** pane, specify a name for the filter: **Q2_Only**

    - On the **Canvas**, click on the bubble for the table `MOVIE_SALES_2020`.

    - Notice that the stub of an arrow appears to the right of `MOVIE_SALES_2020`. Grab this with your mouse and drag-and-drop it to connect it to the filter. 

    ![ALT text is not available for this image](images/3019662874.png)

6. After completing these steps, select the filter bubble on the canvas. The screen should look like this:

    ![ALT text is not available for this image](images/3019662875.png)

7. Now we need to define the properties of the filter. With the filter bubble selected, click the filter condition (circle) and then click the edit button (pencil), as shown below.

     ![ALT text is not available for this image](images/3019662876.png)

8. In the expression editor that appears, complete the filter conditions. As shown below, with the drag-and-drop editor:

    - Expand the table definition

    - Drag column `MONTH` to the Expression canvas

    - Add the expression:

    `in ('April','May','June')`

    ![ALT text is not available for this image](images/3019662839.png)

9. The next step is to fix the data problem with column `MOVIE_SALES_2020.DAY`. Do this as follows, as illustrated below:

    - In the **Tools Palette**, click on the **DATA PREPARATION** tab. 

    - Drag the **Data Cleanse** tool on to the **Canvas**.

    - Click on the `Q2_Only` filter bubble on the canvas and drag the arrow stub from that to the Data Cleanse tool.

    - Click on the Data Cleanse tool on the Canvas to select it.

    - Specify a meaningful name (&quot;Fix\_AllCap\_Days&quot;) and description (&quot;Convert all values in column DAY to Title Case.&quot;)

    ![ALT text is not available for this image](images/3019662899.png)

10. Press the expand button to the upper right

    ![ALT text is not available for this image](images/3019662861.png)

11. Click the **Attributes** tab towards the center of the Properties pane that appears. 

    ![ALT text is not available for this image](images/3019662862.png)

12. We need to cleanse the data in column MOVIE\_SALES\_2020.DAY, by removing leading and trailing white space, and converting to title case. Select the appropriate options as shown below. 

    ![ALT text is not available for this image](images/3019662863.png)

13. When you've finished, press the collapse button (opposing diagonal arrows) in the upper right. 

    ![ALT text is not available for this image](images/3019662864.png)

14. Finally, we create a table into which to load the data after it has been filtered and cleansed. 

    Select the Data Cleanse bubble *Fix\_AllCap\_Days*, and then click the grid-like table icon to the upper right of the bubble.

    ![ALT text is not available for this image](images/3019662865.png)

15. The **create table** dialog that appears, as shown below. Specify the table name as MOVIE\_SALES\_2020**Q2**. (Note the suffix **Q2**.) Accept the default alias, and press **Save**. 

    ![ALT text is not available for this image](images/3019662866.png)

16. Drag the `MOVIE_SALES_2020Q2` bubble a little to the right, as shown, and in the properties pane press the Expand button as shown below.

    ![ALT text is not available for this image](images/3019662867.png)

17. There are various tabs in the expanded properties pane. This is the Attributes view.

    ![ALT text is not available for this image](images/3019662868.png)

18. Click on the Column Mapping tab, which looks like this:

    ![ALT text is not available for this image](images/3019662892.png)

19. Since we haven't run this Data Flow yet, the table doesn't exist, so there is nothing to see in Preview. We'll return to this a little later in this exercise. 

    For now, press **Options**, which brings up the following dialog. Be sure that **Create target table** is set to **True**, because the table doesn't exist yet. 

    ![ALT text is not available for this image](images/3019662893.png)

20. Press contract (two diagonally opposing arrows in the upper right of the Properties pane)

    ![ALT text is not available for this image](images/3019662894.png)

This takes us back to the main Data Flow screen, in which we can see our completed Data Flow.

21. Run the Data Flow

What remains to be done is:

- Press Save (floppy disk icon).

- Press Run (green play icon).

     ![ALT text is not available for this image](images/3019662896.png)

**RECAP – Basic Steps**

In the previous steps we have:

- Imported Data Entities

- Defined a Data Flow, including:

    - Filtered out months not in Q2

    - Converted all values for column MOVIE\_SALES\_2020.DAY to Title Case

    - Created table MOVIE\_SALES\_2020**Q2** for the now-corrected data set

- Run the Data Flow

Having completed these steps we now have a table MOVIE\_SALES\_2020**Q2**, with data for just April, May &amp; June. The days have all be changed to title case.

## **STEP 3:** Inspect Job Details

#### Driver or Mechanic?
*We love thrilling car races. Fans can often be sorted into two groups: the drivers and the mechanics. The drivers want to strap in behind the wheel, rev the engine and burn some rubber. The mechanics want to get under the hood and tinker with the gears and the carburetor. Here's the point at which you can self-select as a driver or a mechanic.*

  ![ALT text is not available for this image](images/3019662956.png)


##### **Driver**

The next several steps in this section are optional, and explore the Data Transforms tool in more depth. If you are not interested in these topics at this stage, Press **OK**. Table MOVIE\_STREAM\_2020Q2 will have been successfully created, with just the data you need, nicely cleansed. Who cares what code got executed to achieve this? The whole point of Data Transforms is for it to be easy to use by people who don't need to be developers! If that's how you feel about life, we applaud your serenity and sense of priorities. you now skip ahead to the **RECAP** section at the end. Varroooommmm!

##### **Mechanic**

Hello! If you've read this far, you've self-identified as curious (at best), or, perhaps even a skeptic! We have a &quot;big tent&quot; philosophy and that's just fine with us, too. Actually, we're quite keen to show off all the stuff that's going on behind the scenes while the user is enjoying playing with a nice drag-and-drop UI. The next few sections go into some depth on these topics. If you're mechanically-minded, roll up the sleeves of your overalls and press the link to the Job that was just created, as indicated above. 

1. Going A Little Deeper Into The Transformation Process

To click on the link to the Job is take the *red pill*: We're well and truly on our way to the Oracle, where we'll learn what's really happening behind the scenes. 

You'll have landed on a page that looks like this. Notice that the job has been implemented in this instance as two steps:

- Create target table

- Insert new rows

Click on the link for step 2, as shown below.

![ALT text is not available for this image](images/3019662930.png)

2. A panel will pop up on the right of the screen with details for this step. Click on the **Target Connection** tab at the top to see the execution details for *Step 2*. You'll notice how the individual steps of the Data Flow were implemented:

    - Filter Q2_2020 is implemented by a predicate in the WHERE clause:MONTH IN ('April','May','June')

    - Data Cleanse operation Fix\_AllCap\_Days is implemented with the string operation INITCAP(TRIM(MOVIE\_SALES\_2020.DAY))

  ![ALT text is not available for this image](images/3019662929.png)

3. Now, for those *Blue Pill* types, these are pearls before swine, but we *Red Pillers* can spend a moment to admire how these operations are implemented in SQL in Autonomous Database.

When you're satisfied, press **Close**. Then, press **Jobs** in the breadcrumb at the upper left of the screen to return to the Data Transforms main page. 

  ![ALT text is not available for this image](images/3019662928.png)

## **STEP 4:** Create Workflow

Good engineering practice is to build and thoroughly test (with both positive and negative cases) components of functionality. These components can then be combined into larger modules. The Data Transforms tool supports this best practice, with Data Flows representing the elemental components, and Workflows the assembly of these components into larger modules. In this exercise we'll simulate this approach. We begin by creating two additional Data Flows in project *MovieStream*:

  - Error_Handling – a unified error handling module

  - Nightly_Batch – an incremental load of data from the last day of operations

1. Following the procedures we've already covered (under *Lab 5 - Using Data Transforms / Create Data Flow*) create the definition for these two Data Flows. Note that for the purposes of this workshop it is sufficient merely to create the Data Flow headers. These additional flows are only for illustrations and don't do anything. In practice there will be real data flows that you may want to include in a workflow.

  ![ALT text is not available for this image](images/3019662927.png)

2. Having defined these two new Data Flows, click the Workflows tab on the left of the screen, then press **Create Workflow**.

  ![ALT text is not available for this image](images/3019662926.png)

3. Give the Workflow the name &quot;*MovieStream_Incremental&quot;* , and press  **Create** . 

  Note: Workflow names must be single words, so the underscore between *MovieStream* and *Incremental* is very important here. 

  ![ALT text is not available for this image](images/3019662950.png)

4. We now arrive at the Workflow page. This has a similar layout to the Data Flow page, with Resources to the left, a Tool Palette at the top, Properties pane to the right and a Canvas in the middle. 

  Expand the DefaultFolder on the left and drag the three Data Flows on to the canvas as shown below:

  ![ALT text is not available for this image](images/3019662949.png)

  In this workflow we're going to define the processing logic as follows:

    - Data Flow *Nightly\_Batch* executes first

    - If *Nightly\_Batch* succeeds, execute *Movie\_Stream\_Q2FY2020*

    - If *Nightly\_Batch* fails, execute *Error\_Handling*

    - If *Movie\_Stream\_Q2FY2020* fails, execute *Error\_Handling*

  It's actually easier to see it on the screen than it is to type it out in prose!

5. Create success condition

    - Click on the green **ok** arrow in the tool palette. (This is for the success condition.)

    - Click on the bubble for Data Flow *Nightly\_Batch*.

    - Drag the arrow stub from *Nightly\_Batch* to *Movie\_Stream\_Q2FY2020*.

  ![ALT text is not available for this image](images/3019662948.png)

6. Create failure condition

    - Click on the red **nok** arrow in the tool palette. (This is for the failure condition.)

    - Click on the bubble for Data Flow *Nightly\_Batch*.

    - Drag the arrow stub from *Nightly\_Batch* to *Error\_Handling*.

  ![ALT text is not available for this image](images/3019662947.png)

7. Complete the Workflows

    Repeat these steps to complete the workflow as follows, being sure to press the **Save** button (disk image) when you're finished:

    ![ALT text is not available for this image](images/3019662946.png)

    After completing the definition of the Workflow, navigate back to the Data Transforms main page by pressing **Projects** in the breadcrumb at the upper left of the screen.

## **STEP 5:** Create Schedules

The typical process for development with Data Transforms will be first to develop and test Data Flows individually. These will then be assembled into Workflows, which are then tested in turn. During development and testing, the validation of these Data Flows and Workflows will initially by executed on demand. As they move into production, they typically transition to &quot;lights out&quot; operations, being executed automatically against a schedule. The definition of these schedules is the topic of this section. 

1. Press the **Schedules** tab to the left of the screen, then press Create Schedule.

    ![ALT text is not available for this image](images/3019662924.png)

2. From the pick list next to Resource, you'll notice that schedules can be defined either for Data Flows or Workflows. The procedure is very similar for both cases. In this workflow, we'll define a schedule for a Workflow, so select that.

    ![ALT text is not available for this image](images/3019662923.png)

3. In the pick list for Resource Name, select the Workflow we just created *MovieStream_Incremental*

    ![ALT text is not available for this image](images/3019662921.png)

4. Specify the regular day and time at which this Workflow is to be executed. In the screenshot below, we're scheduling it for 2am on Wednesday mornings.

    ![ALT text is not available for this image](images/3019662920.png)

5. Press **Save** and return to the **Schedules** main page.

    ![ALT text is not available for this image](images/3019662919.png)

## Conclusion

In this lab we’ve covered simple to some relatively advanced features of the Data Load tool, but we have to be honest: it’s all still pretty easy. These topics were:

<ul style="text-decoration: none;">

- Data flow - A data flow is process of transforming data from various sources and loading into target tables

- Jobs – Each time a Data Flow or a Workflow executes, it is recorded as a Job

- Workflows – A workflow is an assembly of a number of Data Flows

- Schedules – Data Flows and Workflows can either be executed on demand, or on automated schedule

## Acknowledgements

- **Authors** - Jayant Mahto, ADB Product Management
- **Contributors** - Patrick Wheeler, Mike Matthews, ADB Product Management
- **Last Updated By/Date** - Jayant Mahto, Brianna Ambler, June 2021
