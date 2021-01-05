# Data Visualization

## Introduction

With Oracle Analytics Server, we can create visualizations and projects that reveal trends in your company's data and help you answer questions and discover important insights about your business.
Creating visualizations and projects is easy, and your data analysis work is flexible and exploratory. Oracle Analytics helps you to understand your data from different perspectives and fully explore your data to find correlations, discover patterns, and see trends.

You can quickly upload data from a variety of sources (for example, spreadsheets, CSV files, Fusion Applications, and many databases) to your system and model it in a few easy steps. You can easily blend data sets together too, so that you can analyze a larger set of data to reveal different patterns and information.

It provides several interactive visuals to show the story in your data for example, Trend Lines, Bar, Sankey Graph, Map, etc.

*Estimated Lab Time:* 40 Minutes.

Watch this below video to explore more on data visualization.

[](youtube:yOYemBtdpnQ)


### Objectives

In this lab we will be using Oracle Analytics Server self-service capabilities on JSON, XML and Relational data of Converged Database.  We will be creating compelling project with different types of visuals to show the important insights out of Sample data of a financial company.

- Here, we have sample financial data, where data from "UK" region is in JSON format, data from "Germany and France"  regions are in XML format and Data from "Italy and Spain" regions are in Relational Format. And this data is stored in Oracle Converged Database.

- Using OAS "Data Flow" capability we will be generating a complete financial data after merging the data from  different geography.

- Then with OAS Data Preparation we will be making data set ready for visualization.

- After that we will be building compelling visualizations in OAS.

The end result should look like below:

![](./images/oascdb1.png " ")

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup (Free Tier and Paid Tenants Only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

Below pre-loaded data objects are available in Converged Database. And since OAS recognizes data in relational format, views have been created on the base tables of JSON and XML type.  


| ObjectName  | ObjectType  | DataType  | Description  |
| ------------- | ------------- | ------------- |
| FINANCIALS\_UK\_JSON | Table | JSON  | data from "UK" Region in JSON format  |
| FINANCIALS\_XML\_GERMANY | Table | XML | data from "Germany" Region in XML format  |
| FINANCIALS\_XML\_FRANCE | Table | XML | data from "France" Region "in XML format  |
| FINANCIALS\_REL\_SPAIN\_ITALY | Table | Relational | data from "Spain" and "Italy" Region in Relational Format  |
| FINANCIAL\_JSON\_UK\_VIEW | View | Relational | this view has been created on FINANCIALS\_UK\_JSON table to view data in relational format  |
| FINANCIALS\_XML\_FRANCE\_GERMANY\_VIEW | View | Relational | this view has been created on FINANCIALS\_XML\_FRANCE  and FINANCIALS\_XML\_GERMANY table to view data in relational format  |

## **STEP 1**: Create Data Set

In this step, we will create individual data sets of different data types: json, xml and relational.

1. Create **FINANCIALS\_JSON\_UK\_VIEW**  data set   
   On the Home screen, select "Create" and click on "Data Set".
    ![](./images/oascdb1.1.png " ")

2. Select  the database connection.
    ![](./images/oascdb7.png " ")

3. Search and Select the schema **OASLABS**.
    ![](./images/oascdb65.4.png " ")

4. Now select the view **FINANCIALS\_JSON\_UK\_VIEW**, where we have JSON data from UK.
    ![](./images/oascdb9.png " ")

5. Click on "Add All" to select all the columns from table.
    ![](./images/oascdb10.png " ")

6. Click on "Add" and preview the sample records.  Verify dataset name as shown below.
    ![](./images/oascdb11.png " ")



7. Similarly create below datasets.
    - **FINANCIALS\_REL\_SPAIN\_ITALY**
    - **FINANCIALS\_XML\_FRANCE\_GERMANY\_VIEW**

## **STEP 2**: Merge Data Sets Using Data Flow
   **Data Flow :** Data flows enable you to organize and integrate your data to produce a curated data set that your users can analyze.  
   To build a data flow, you add steps. Each step performs a specific function, for example, add data, join tables, merge columns, transform data, save your data. Use the data flow editor to add and configure your steps. Each step is validated when you add or change it. When you've configured your data flow, you execute it to produce a data set.


Let's create a dataflow to merge all the different types of datasets created in STEP1.

1. On the home screen, select "Create" and click on "Data Flow".
    ![](./images/oascdb1.2.png " ")

2. Click on "+" and then "Add Data".
    ![](./images/oascdb1.3.png " ")

3. Select **FINANCIALS\_JSON\_UK\_VIEW** data set And click on "Add".
    ![](./images/oascdb1.4.png " ")

4. Now add data **FINANCIALS\_REL\_SPAIN\_ITALY** by clicking on "+".
    ![](./images/oascdb1.5.png " ")

5. Click on "Add Data".
    ![](./images/oascdb1.6.png " ")

6. Select **FINANCIALS\_REL\_SPAIN\_ITALY** dataset and click on "Add"
    ![](./images/oascdb1.7.png " ")

7. By default join operator will be selected. Since we have to merge different types of datasets, let us replace the "Join" step with "Union Rows" step.

   Remove the "Join" step by clicking on "X" as shown below.
    ![](./images/oascdb1.8.png " ")

8. Click on "+" and select "Union Rows" step.
    ![](./images/oascdb1.9.png " ")

9. Click on to "Circle" as shown below to complete compete merging of **FINANCIALS\_JSON\_UK\_VIEW**  and **FINANCIALS\_REL\_SPAIN\_ITALY**.
    ![](./images/oascdb1.10.png " ")

10. Similarly repeat the "Union Rows" step  to merge **FINANCIALS\_XML\_FRANCE\_GERMANY\_VIEW** dataset.
    ![](./images/oascdb1.11.png " ")

11. Final Result will be.
    ![](./images/oascdb1.12.png " ")


12. Save the complete data set:
   Click on "+" to add a step for saving data.
    ![](./images/oascdb1.13.png " ")

13. Select "Save Data".
    ![](./images/oascdb1.14.png " ")

14. Name the data set **Financials Complete Data set**.
    ![](./images/oascdb1.19.png " ")

15. Click on "Save" to save the data Flow.
    ![](./images/oascdb1.20.png " ")

16. Name the dataflow and click on "OK"
    ![](./images/oascdb1.15.png " ")

17. Data set successfully saved
    ![](./images/oascdb1.16.png " ")

18. Run Data Flow  
   Click on "Run Data Flow" to build complete data set.
    ![](./images/oascdb1.17.png " ")


## **STEP 3**: Data Preparation ##
In this step we will perform some data preparation steps to make data set ready for visualization.

1. Complete data set is created in STEP 1. Now on Home Screen, click on "Data".
    ![](./images/oascdb1.18.png " ")

2. Select the dataset **Financials Complete Data set** (created in STEP 1).
    ![](./images/oascdb26.png " ")

3. On the Visualization Screen, click on "Prepare" button at right top corner to perform data preparation steps.
    ![](./images/oascdb27.png " ")

4. Let us convert year textual values to date format
by providing relevant formats.

    Select the "Year" column and  click on "Convert to Date".
    ![](./images/oascdb28.png " ")

    Click on "Add Step" and verify the date format.
    ![](./images/oascdb29.png " ")

    Follow the same process of date conversion  for MONTH, QUARTER.

5. Change Dataype to **number**. And change attribute to **measure**.

    Convert NETINCOME to number.
    ![](./images/oascdb30.png " ")

    Change NETINCOME to "Measure" as shown below.
    ![](./images/oascdb31.png " ")

6. Similarly we will convert below fields to "NUMBER" and change them to "Measure"  .
    - OPERATINGEXPENSES
    - PAYABLES
    - PREVIOUSYEARNETINCOME
    - PREVIOUSYEAROPERATINGEXPENSES
    - PREVIOUSYEARPAYABLES
    - PREVIOUSYEARRECEIVABLES
    - PREVIOUSYEARREVENUE
    - RECEIVABLES
    - REVENUE   

7. Rename columns with titlecase names.  
   Right-Click on OPERATINGEXPENSES and click on "Rename".
    ![](./images/oascdb32.png " ")

    Put the name title case name: **OPERATING EXPENSES** and then Click on "Add Step".
    ![](./images/oascdb33.png " ")

8. Similarly rename below fields.
    - PREVIOUSYEARNETINCOME to PREVIOUS YEAR NETINCOME  
    - PREVIOUSYEAROPERATINGEXPENSES to PREVIOUS YEAR OPERATING EXPENSES  
    - PREVIOUSYEARPAYABLES to PREVIOUS YEAR PAYABLES  
    - PREVIOUSYEARRECEIVABLES to PREVIOUS YEAR RECEIVABLES  
    - PREVIOUSYEARREVENUE to PREVIOUS YEAR REVENUE  

9. Now click on "Apply Script" to complete data preparation steps. And now dataset is ready for visualization.
    ![](./images/oascdb34.png " ")

## **STEP 4**: Build Visualizations ##
Let us analyze the data to get some insights using different kind of visualizations.  

1. **Performance Tile**   
To summarize key metrics like Revenue, we can use  "Performance Tile" visualization.    
   Select  "REVENUE" from data pane(columns of the dataset) and Pick "Performance Tile" for visualization as below.
    ![](./images/oascdb35.png " ")

   Result will be:
    ![](./images/oascdb35.1.png " ")

   Now do some required changes using Left Bottom "Properties" section.  
    For example :  background color, abbreviation, etc  

    After doing changes for Abbreviation:
    ![](./images/oascdb36.png " ")

    After doing changes for Background color:
    ![](./images/oascdb37.png " ")

   Build Tile Visualization for below KPIs  as well.  
    - NETINCOME
    - OPERATING EXPENSES
    - PAYABLES
    - RECEIVABLES  

    Final canvas should be like below:
    ![](./images/oascdb40.png " ")


2. **Map** visualization  
   It works with geographic and measure columns.  

   In our data set select REGION and REVENUE columns and pick "Map" as visualization.
    ![](./images/oascdb41.png " ")

   Drag the "REGION" Column from data pane into the color section.  
   Verify Below:
    ![](./images/oascdb42.png " ")

   We can also select desired and relevant map layers via properties(Bottom Left).
    ![](./images/oascdb43.png " ")

3. **Combo Graph** : Overlapping of line, bar and area        
    Select REVENUE, OPERATING EXPENSES, NETINCOME and QUARTER. Pick Combo as Visualization.  
    ![](./images/oascdb1.21.png " ")

   Let's change "Line" graph type for REVENUE to "Bar".
    ![](./images/oascdb45.png " ")

   We can change properties of graph as below, for example color assignments, graph type for each   KPI, title etc.
    ![](./images/oascdb46.png " ")

   We can also manage colors as shown below.
    ![](./images/oascdb47.png " ")

   Rename the map visualization to  "Revenue by Graph".
    ![](./images/oascdb48.png " ")

   Similarly rename the combo graph.

4. Rename Canvas    
   Rename individual Canvas to "Financials Overview".
    ![](./images/oascdb49.png " ")

5. Analyzing Expenses    
    Select (+) symbol on the bottom to add another canvas, in this canvas we will add visulizations analysing expenses.  
    ![](./images/oascdb69.png " ")

    We will repeat "Tile" Visualization for **OPERATING EXPENSES** and **PREVIOUS YEAR OPERATING EXPENSES**.
    ![](./images/oascdb50.png " ")

    Result should look like below:
    ![](./images/oascdb51.png " ")

6. **Sankey Graph** Visualization    
   We will see quartery expenses by account groups.    
   Select  OPERATING EXPENSES, QUARTER and ACCOUNTGROUP. Pick **Sankey Graph**.
    ![](./images/oascdb52.png " ")

7. **Stacked Bar** visualization     
   We will analyze region wise expenses quarterly.  
   Select OPERATING EXPENSES, PREVIOUS YEAR OPERATING EXPENSES and QUARTER. Pick **Stacked Bar**.  
    ![](./images/oascdb53.png " ")

8. **Tree Map** visualization      
   We will analze Expenses by Cost Centre.    
   Select OPERATING EXPENSES, COSTCENTER.  Pick **Tree Map**.
    ![](./images/oascdb54.png " ")

9.  Rename canvas "Expenses" as in point 5.  
    Rename individual visualizations and canvases.

10.  More KPIs Analysis   
    Select (+) symbol on the bottom to add another canvas, in this canvas we will add some more visulizations.      ![](./images/oascdb70.png " ")

    Please refer to previous steps for selecting the required fields and visualization type.   

11. **Combo Graph** for comparing PAYABLES and RECEIVABLES by MONTH(similar to as we did in STEP 4- point 3).
     ![](./images/oascdb56.png " ")

12. **Simple Bar Graph**  
   Analyze PAYABLES and PREVIOUS YEAR PAYABLES quarterly.
    ![](./images/oascdb57.png " ")

   Analyze RECEIVABLES and PREVIOUS YEAR RECEIVABLES quarterly.
    ![](./images/oascdb58.png " ")

   Rename canvas "More Visuals" as in STEP 4 - point 5.

13. Let's see **Pivot Table** visual    
    Analyzing KPIs by Cost Centre.  
    Select REVENUE, OPERATING EXPENSES, NETINCOME and COSTCENTER. Pick Pivot table. Change properties as shown below.
    ![](./images/oascdb59.png " ")

14. **Custom Calculation**  
    In OAS, we can also do some calculations of Key Performance Metrics as per business requirement.     
    Let's calculate "Profit".
    Drag the scroller down as shown below. Right click on My calculation, then click on "Add Calculation".  
    ![](./images/oascdb1.22.png " ")

    Enter the profit formula in the expression builder. Then Click on "Validate" and then "Save".  
    **Profit = REVENUE-OPERATING EXPENSES**
    ![](./images/oascdb1.23.png " ")

    Verify the "Profit" column added by expanding "My Calculations" in data pane as shown below. This column can be used to show profit values.
    ![](./images/oascdb1.23.1.png " ")


## **STEP 5**: Data Action For Drill Down To Detail Report

1.   Select (+) symbol on the bottom to add another canvas (refer to STEP 4 - point 11), in this canvas we will build the tabular report.  
    Select all the required columns (as shown below) and pick table as visualization.
    ![](./images/oascdb60.png " ")

2. Now click on hamburger then select "Data Actions" (top Right corner).
    ![](./images/oascdb61.png " ")

3. Fill the details as:  
    - **Name**:Detail Report  
    - **Type**: Analytics Link(because we are drilling down in OAS-DV canvas only)  
    - **Target**: This Project(because we will be drilling down to the tabular report)  
    - **Canvas Link**: Detail Report  
    - **Data Values**: All  

    Click OK.
    ![](./images/oascdb62.png " ")

4. Now go to any report, right click and select Detail Report (created this report  in previous step).  
    ![](./images/oascdb63.png " ")

5. This will drill down to the filtered version of detail report. Filters will be applied as per the attributes of selected main report.
    ![](./images/oascdb64.png " ")


## **STEP 6**: Adding Filters ##
Filters are used to make canvas interactable for the users. Users can view desired data by adding filters to the canvas. In this way filters enable users to interact with canvas.

1. Click (+) symbol on the top screen as shown in below screenshot and select the fields as required. Here we have selected Year, Month, Account Group.
    ![](./images/oascdb65.png " ")

2. The resultant canvas will look like below.
    ![](./images/oascdb66.png " ")

3. We can select the filter attribute values as required. Here we have selected **YEAR=2015, ACCOUNTGROUP= Non-contingent Salaries and Supplies and MONTH = Apr-15,Aug-15,Jan-15 and May-15**.
     ![](./images/oascdb66.1.png " ")

With this lab, you have learned OAS self-service analytics with capabilities including data loading, data preparation, data mashups, designing canvas, different types of visualization graphs in simple easy to use interface.

You may now *proceed to the next lab*.

## Want To Learn More

- [Oracle Analytics Server - Data Visualization](https://docs.oracle.com/en/middleware/bi/analytics-server/visualize-data.html)  
- [blog](https://blogs.oracle.com/proactivesupportepm/oas_55)

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Sudip Bandyopadhyay, Vishwanath Venkatachalaiah
- **Contributors** - Jyotsana Rawat, Satya Pranavi Manthena, Kowshik Nittala, Rene Fontcha
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/converged-database). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
