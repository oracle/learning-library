# OAS Data Visualization #

## Introduction ##

With Oracle Analytics Server, we can create visualizations and projects that reveal trends in your company’s data and help you answer questions and discover important insights about your business.
Creating visualizations and projects is easy, and your data analysis work is flexible and exploratory. Oracle Analytics helps you to understand your data from different perspectives and fully explore your data to find correlations, discover patterns, and see trends.

You can quickly upload data from a variety of sources (for example, spreadsheets, CSV files, Fusion Applications, and many databases) to your system and model it in a few easy steps. You can easily blend data sets together, too, so that you can analyze a larger set of data to reveal different patterns and information.

It provides several interactive visuals to sow the story in your data for example, trend lines, bar, Sankey graph, maps, etc.

[](youtube:yOYemBtdpnQ)

Oracle converged database has native support for all modern data types as JSON, XML, and Relational, Spatial etc. By integrating new data types, workloads, and paradigms as features within a converged database, you can support mixed workloads and data types in a much simpler way. You don't need to manage and maintain multiple systems or worry about having to provide unified security across them.

[](youtube:9d76-LhgMQs)



### Objectives ###

In this lab we will be using Oracle Analytics Server self-service capabilities on JSON , XML and Relational data of Converged Database ,  we will be creating compelling project with different types of visuals to show the important insights out of Sample data of a financial company.

Here, we have sample financial data, where data from ‘UK’ region is in JSON format, data from “Germany and France”  regions are in XML format and Data from “Italy and Spain” regions are in Relational Format. And this data is stored in Oracle Converged Database.

Using OAS “Data Flow” capability we will be generating a complete financial data after merging the data from  different geography. 

Then with OAS Data Preparation we will be making data set ready for visualization.

After that we will be building compelling visualizations in OAS.

This lab assumes you have completed the following labs:  
- Lab 1: Login to Oracle Cloud  
- Lab 2: Generate SSH Key  
- Lab 3: Create Compute Instance  
- Lab 4: Environment Setup   


The end result should look like below:
![](./images/oascdb1.png " ")

### Pre-requisites and Data Description ###
Below data objects with data present in Converged Database. And since OAS recognizes data in relational format , views have been created on the base tables of JSON and XML type.  
 

| ObjectName  | ObjectType  | DataType  | Description  |
| ------------- | ------------- | ------------- |
| FINANCIALS\_UK\_JSON | Table | JSON  | data from ‘UK’ Region in JSON format  |
| FINANCIALS\_XML\_GERMANY | Table | XML | data from ‘Germany’ Region in XML format  |
| FINANCIALS\_XML\_FRANCE | Table | XML | data from ‘France’ Region ‘in XML format  |
| FINANCIALS\_REL\_SPAIN | Table | Relational | data from ‘Spain’ Region in Relational Format  |
| FINANCIALS\_REL\_ITALY | Table | Relational | data from ‘Italy’ Region in Relational Format  |
| FINANCIAL\_JSON\_UK\_VIEW | View | Relational | this view has been created on FINANCIALS\_UK\_JSON table to view data in relational format  |
| FINANCIALS\_XML\_FRANCE\_VIEW | View | Relational | this view has been created on FINANCIALS\_XML\_FRANCE table to view data in relational format  |
| FINANCIALS\_XML\_GERMANY\_VIEW | View | Relational | this view has been created on FINANCIALS\_XML\_GERMANY table to view data in relational format  |

  
    
## Step 1: Create data set using Data Flow ##
  **Data Flow :** Data flows enable you to organize and integrate your data to produce a curated data set that your users can analyze.  
  To build a data flow, you add steps. Each step performs a specific function, for example, add data, join tables, merge columns, transform data, save your data. Use the data flow editor to add and configure your steps. Each step is validated when you add or change it. When you've configured your data flow, you execute it to produce a data set.
  
  In this step, we will merge the data from different data sources (json, xml and relational) utilizing **Data Flow** functionlaity of OAS.

### Step 1.1: Add **FINANCIALS\_JSON\_UK\_VIEW**  data set ###
1. Select "Create" and click on "data flow".
       ![](./images/oascdb5.png " ")

2. Click on "create dataset".
       ![](./images/oascdb6.png " ")

3. Select  the database connection.
       ![](./images/oascdb7.png " ")

4. Select the schema.
       ![](./images/oascdb65.4.png " ")

5. Now select the view **FINANCIALS\_JSON\_UK\_VIEW**, where we have JSON data from UK.
       ![](./images/oascdb9.png " ")

6. Click on "Add Columns".
       ![](./images/oascdb10.png " ")

7. Click on "Add".  Verify dataset name.
       ![](./images/oascdb11.png " ")



### Step1.2: Add **FINANCIALS\_XML\_GERMANY_VIEW**  data set ###

1. Click on “+” symbol and then “Add Data".
    ![](./images/oascdb12.png " ")

2. Click on "Create data set" and then "Add".
    ![](./images/oascdb13.png " ")

3. Now add data **FINANCIALS\_XML\_GERMANY_VIEW** similarly as we did for **FINANCIALS\_JSON\_UK\_VIEW**.

4. After adding **FINANCIALS\_XML\_GERMANY_VIEW**, Remove the “Join” step(click on ‘X’ mark).
    ![](./images/oascdb14.png " ")

5. Now add “Union Rows” step. 
    ![](./images/oascdb15.png " ")

6. Click on to “circle” as shown below to complete compete merging of **FINANCIALS\_JSON\_UK\_VIEW**  and **FINANCIALS\_XML\_GERMANY\_VIEW**.
    ![](./images/oascdb16.png " ")

7. Notice below:
    ![](./images/oascdb17.png " ")

### Step1.3: Add and merge **FINANCIALS\_XML\_FRANCE\_VIEW**  data set ###
   Repeat the similar process like we did for adding **FINANCIALS\_XML\_GERMANY\_VIEW**   
   Final result will be:  
        ![](./images/oascdb18.png " ")

### Step1.4: Add and merge **FINANCIALS\_REL\_ITALY** and **FINANCIALS\_REL\_SPAIN**   
   Repeat the similar process like we did for adding "FINANCIALS\_XML\_GERMANY_VIEW"  
   Final Result will be.
        ![](./images/oascdb19.png " ")

### Step1.5: Save and run data flow ###
 1. Save the complete data set: Click on “Save Data” step
    ![](./images/oascdb20.png " ")

    Now we have completed merging.  
    Name the data set **Financials Complete Data set**.
    ![](./images/oascdb21.png " ")

 2. Save the data Flow.
    ![](./images/oascdb22.png " ")

 3. Run the data flow to build complete data set ###
    ![](./images/oascdb23.png " ")
    ![](./images/oascdb24.png " ")

## Step 2: Data Preparation ##
In this step we will perform some data prepartion steps to make data set ready for visualizatuion.

1. Complete data set is created in previous step. Now on the left hand side, and click on "data".
    ![](./images/oascdb25.png " ")

2. Select the dataset **Financials Complete Data set** created in previous step.
    ![](./images/oascdb26.png " ")

3. Click on “Prepare” to perform some “Data Preparation” steps.
    ![](./images/oascdb27.png " ")

4. Change Datatype to **Date**

    Convert “year” to data datatype:
    Select the “Year” column and  click on "Convert to Date".
    ![](./images/oascdb28.png " ")

    Click on “Add Step” and verify data format.
    ![](./images/oascdb29.png " ")

    Follow the same process of date conversion  for MONTH, QUARTER. 

5. Change Dataype to **number**. And change attribute to **measure**.

    Convert NETINCOME to number.
    ![](./images/oascdb30.png " ")

    Change NETINCOME to “Measure” as shown below.
    ![](./images/oascdb21.png " ")

    Similarly we will convert below fields to “NUMBER” and change them to “Measure”  .
    - OPERATINGEXPENSES
    - PAYABLES
    - PREVIOUSYEARNETINCOME
    - PREVIOUSYEAROPERATINGEXPENSES
    - PREVIOUSYEARPAYABLES
    - PREVIOUSYEARRECEIVABLES
    - PREVIOUSYEARREVENUE
    - RECEIVABLES
    - REVENUE   

6. Rename columns  
   Right-Click on OPERATINGEXPENSES and click on "Rename".
    ![](./images/oascdb32.png " ")

    Click on Add step.
    ![](./images/oascdb33.png " ")

    Similarly rename below fields. 
    - PREVIOUSYEARNETINCOME to PREVIOUS YEAR NETINCOME  
    - PREVIOUSYEAROPERATINGEXPENSES to PREVIOUS YEAR OPERATING EXPENSES  
    - PREVIOUSYEARPAYABLES to PREVIOUS YEAR PAYABLES  
    - PREVIOUSYEARRECEIVABLES to PREVIOUS YEAR RECEIVABLES  
    - PREVIOUSYEARREVENUE to PREVIOUS YEAR REVENUE  

7. Now click on “Apply Script” to complete data preparation steps. And now dataset is ready for visualization.
    ![](./images/oascdb34.png " ")

## Step 3: Build Visualizations ##
Now let’s analyze the data to get some insights.  

### Step 3.1: Tile Visualization and Custom Calculation
To summarize some of the key numeric metrics, for example revenue we can use “Tile” visualization.    
1. Select the “Revenue”and Pick “Performance Tiles” for visualization as below.
    ![](./images/oascdb35.png " ")

2.  Now do some required changes using Left Bottom "properties" section.  
    For example :  background color, abbreviation, etc  
    Abbreviation:
    ![](./images/oascdb36.png " ")

    Background color:
    ![](./images/oascdb37.png " ")

3. In OAS, we can also do some calculations of KPI as per business requirement.     
    We will calculate “Profit” as below:  
    Right click on My calculation, then click on “Add Calculation” 
    ![](./images/oascdb38.png " ")

    Put this calculation to claculate profit:  **Profit = Revenue- Operating Expenses**
    ![](./images/oascdb39.png " ")

4. Build Tile Visualization for below KPIs  as we did for "revenue":  
    - Net Income
    - Operating Expenses
    - Payables
    - Receivables  
  
    Dashboard should be like below:
    ![](./images/oascdb40.png " ")

### Step 3.2: Map visualization 
1. Select Revenue and Region and pick “Map” as visualization.
    ![](./images/oascdb41.png " ")

2.  Verify Below:
    ![](./images/oascdb42.png " ")

3. We can also select desired and relevant map layers via properties(Left Bottom).
    ![](./images/oascdb43.png " ")

### Step 3.3: Combo Graph (combination of line, bar, area, etc)  
1. Comparing Revenue, Operating Expenses and Net Income quarterly.    
    Select Revenue, Operation Expenses, Net Income and Quarter. Pick Combo as Visualization.  
    ![](./images/oascdb44.png " ")

2. Let’s change graph type of Revenue Line.
    ![](./images/oascdb45.png " ")

3. We can change properties of graph as below, for example color assignments, graph type for each   KPI, title etc
    ![](./images/oascdb46.png " ")

4. We can change the color as below.
    ![](./images/oascdb47.png " ")

5. Rename the map visualization to  "Revenue by Graph".
    ![](./images/oascdb48.png " ")

6. Similarly rename the combo graph.

### Step 3.4 Rename Canvas
Rename individual Canvas: Financials Overview.
    ![](./images/oascdb49.png " ")

### Step 3.5 Analyzing Expenses  
We will repeat “Tile” Visualization for Operating Expenses and Previous Year Operating Expenses.
    ![](./images/oascdb50.png " ")

Result should look like below
    ![](./images/oascdb51.png " ")

### Step 3.6 “Sankey” graph Visualization  
We will see quartery expenses by account groups.    
Select  Operating Expenses, Quartr and Account Group. Pick Sanky graph: 
    ![](./images/oascdb52.png " ")

### Step 3.7 Stacked Bar   
We will analyze region wise expenses quarterly .  
Select Operating Expenses, Previous Year Expenses and Quarter. Pick Stacked Bar.  
    ![](./images/oascdb53.png " ")

### Step 3.8 Treemap  
We will analze Expenses by Cost Centre.    
Select Operating Expenses, Cost Center.  Pick Tree map  
    ![](./images/oascdb54.png " ")

### Step 3.9 Rename the reports and canvases
Rename individual visualizations and canvases.

### Step 3.10 More KPIs Analysis 
Please refer to previous steps for selecting the required fields and visualization type.   
1. Combo graph for comparing Payables and Receivables by month.
   ![](./images/oascdb56.png " ")

2. Simple Bar Graph
   Analyze current and previous year payables quarterly.
    ![](./images/oascdb57.png " ")

3. Analyze current and previous year receivables quarterly.
    ![](./images/oascdb58.png " ")

### Step 3.11 Let’s see Pivot table visual  
Analyzing KPIs by Cost Centre.  
Select Revenue, Operating Expenses, Net Income and Cost Center. Pick Pivot table. Change properties as shown below.
    ![](./images/oascdb59.png " ")

## Step 4: Data Action for drill down to detail report 

1. First we will build on tabular report with all the required columns (as shown below).  
    ![](./images/oascdb60.png " ")

2. Now click on Data Actions (Right up).
    ![](./images/oascdb61.png " ")

3. Fill the details as:  
    - **Name**:Detail Report  
    - **Type**: Analytics Link(because we are drilling down in OAS-DV canvas only)  
    - **Target**: This Project(because wi will be drilling down to the tabular report)  
    - **Canvas Link**: Detail Report  
    - **Data Values**: All  

    Click OK.
    ![](./images/oascdb62.png " ")

4. Now go to any report, right click and select Detail Report (we have created this in previous step).  
    ![](./images/oascdb63.png " ")

5. This will drill down to the filtered version of detail report. Filters will be attributes of selected main report.
    ![](./images/oascdb64.png " ")



## Step 5: Adding Filters ##

1. On to top screen and select the fields, here we have selected Year, Month. Account Group etc
    ![](./images/oascdb65.png " ")

2. The result canvas will look like below, and we can select filter values as required
    ![](./images/oascdb66.png " ")

With this lab, you have learned OAS self-service analytics with capabilities including data loading, data preparation, data mashups, designing canvas, different types of visualization graphs in simple easy to use interface.

## Acknowledgements

- **Authors** - Sudip Bandyopadhyay, Vishwanath Venkatachalaiah
- **Contributors** - Jyotsana Rawat, Satya Pranavi Manthena, Kowshik Nittala
- **Team** - North America Analytics Specialists
- **Last Updated By** - Vishwanath Venkatachalaiah

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
