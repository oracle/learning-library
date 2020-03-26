Oracle Data Visualization Tutorial  
================

![](https://cdn.app.compendium.com/uploads/user/e7c690e8-6ff9-102a-ac6d-e4aebca50425/f4a5b21d-66fa-4885-92bf-c4e81c06d916/Image/55d948c4e07007e169299a02b4dfe6db/construction.png) -- This lab (Data Visualization Desktop) is under construction and a new version is in the works.  The instructions currently listed below may be **inaccurate** or **incomplete**.


Before You Begin
================

Purpose
-------

In this tutorial you learn how to use Oracle Data Visualization to
create visualizations to explore and analyze the data.

There are four sections in this tutorial:-

1.  [Creating a Data Visualization with Sample
    Data](#section-1-creating-a-data-visualization-with-sample-data)

2.  [Adding Data Sources from Comma Separated Value
    Files](#section-2-adding-data-sources-from-comma-separated-value-files)

3.  [Creating a Data Flow](#section-3-creating-a-data-flow)

4.  [Adding a Data Source from Oracle
    Database](#section-4-adding-a-data-source-from-oracle-database)

Time to Complete
----------------

40 minutes

Background
----------

Oracle Data Visualization makes rich, powerful visual analytics
accessible to every business user. People at all levels of an
organization can blend and analyze data in just a few clicks,
effectively sifting through data clutter to quickly uncover and share
hidden patterns and actionable insights.

You begin by creating a project in Oracle Data Visualization with sample
data sources. Then you create visualization, modify the visualization by
moving data elements into and out of the canvas, manually change the
visualization type, and apply filters. You also learn how to navigate
and adjust the canvas layout, and how to find, organize, and manage
content.

What Do You Need?
-----------------

Before starting this tutorial, you should:

-   Download Oracle Data Visualization Desktop from
    [here](http://www.oracle.com/technetwork/middleware/oracle-data-visualization/index.html)
    and install it on your computer. Select the Deploy Samples default
    option during the installation process. We use Oracle Data
    Visualization 12c 12.2.2.2.0 in this tutorial

-   Download the sample data files,
    [People.csv](https://oracle.github.io/learning-library/workshops/journey1-self-service-bi/DVData/People.csv)
    and
    [Income.csv](https://oracle.github.io/learning-library/workshops/journey1-self-service-bi/DVData/Income.csv)

Section 1: Creating a Data Visualization with Sample Data
==============================================

1. Double click the Oracle Data Visualization Desktop 12c icon on your
desktop to start the application.   

    ![](./images/400/Picture400-1.png)  

2. It takes a few seconds to initialize the application.  

    ![](./images/400/Picture400-2.png)  

3. The Home page gives you a look inside your folder which contains the
visualization projects you created and a sample project created during
the process of installation of Oracle Data Visualization.

    Before you can begin to explore data in a new project, you must select a
data source for that information. Click **Data Sources** to display the
existing data sources.  

    ![](./images/400/Picture400-3.png)  

4. You can select Oracle Applications, databases, or uploaded data files as
your data sources. We use the sample data source provided to discover
the capabilities of Oracle Data Visualization Desktop in this step. The
sample data set is based on Sales Orders data and contains meaningful
measures and attributes.

    Double click **Sample Order Lines**. It brings you into the Data
Elements pane with all the data elements in the sample data available.  

    ![](./images/400/Picture400-4.png)  

5. After you select the data sources for your project, you can begin to add
data elements such as measures and attributes to visualizations. You can
see the list of data elements on the left.  

    ![](./images/400/Picture400-5.png)  

6. Select both **Product Category** and **\# of Orders** and then right
click to show the right-click menu. Select **Pick Visualization…** on
the pop-up menu.  

    ![](./images/400/Picture400-6.png)  

7. In the View Select dialog, select the **Treemap** visualization type.  

    ![](./images/400/Picture400-7.png)  

8. A tree map of \# of Orders by Product Category is generated. You can see
the largest one is Office Supplies with 3949 orders followed by
Technology and then Furniture.  

    ![](./images/400/Picture400-8.png)  

9. You can work with color to make visualizations more attractive, dynamic,
and informative. The Visualize canvas has a Color drop target where you
can put a measure column, attribute column, or set of attributes
columns.

    Select **Product Category** on the left, drag and drop it into the Color
drop target.  

    ![](./images/400/Picture400-9.png)  
 
10. The blocks in the tree map are colored in different colors. It is easier
to distinguish the differences among the product categories.  

    ![](./images/400/Picture400-10.png) 
 
11. You might want to add Product Sub Category information to the tree map
as well. It might help you understand the sales better.

    Select **Product Sub Category** on the left, drag and drop it **under**
the Product Category in the **Category** drop target.  

    ![](./images/400/Picture400-11.png) 

12. You can see there is a sub tree map in each product category block for
you to drill down into each sub product category.  

    ![](./images/400/Picture400-12.png)  

13. Now let’s add a new visualization – a map of sales by states. Right click in the blank area of Data Elements pane on the left, select
**Add Data Source** in the pop-up menu.  

    ![](./images/400/Picture400-13.png)  

14. Select **Sample States**, click **Add to Project** in the Add Data
Source dialog.

    ![](./images/400/Picture400-14.png)  

15. You can see the elements in the Sample States data source are expended
in the Data Elements pane. Right click in the blank area of Data Elements pane, select **Source
Diagram…** in the pop-up menu.

    ![](./images/400/Picture400-15.png)  

16. You can see that the Sample Order Lines and the Sample States are
connected by City, which is an element in common in both of the data
sources.

    ![](./images/400/Picture400-16.png)  

17. Select both **Sales** in the Sample Order Line and **State** in the
Sample States, right click and select **Pick Visualization…** on the
pop-up menu.

    ![](./images/400/Picture400-17.png)  

18. In the View Select dialog, select the **Map** visualization type.

    ![](./images/400/Picture400-18.png)  

19. A map of sales by states is added to the right of tree map.

    ![](./images/400/Picture400-19.png)  

20. To make the map more interactive, we are going to do a couple of things.
First, select **Country** in the Sample States on the left and drag and
drop it to the filter bar area on the top.

    ![](./images/400/Picture400-20.png)  

21. In the pop-up country list, select **United States**.

    ![](./images/400/Picture400-21.png)  

22. The map is focused on United States area. Click the **Maximize the
View** icon on the top-right corner of the map.

    ![](./images/400/Picture400-22.png)  

23. You can get a better view of sales by state in the United States. The
revenue in the states range from 13K to 403K, colored from light green
to deep green. Obviously California has the largest revenue. The grey
color indicates where there is no revenue.

    ![](./images/400/Picture400-23.png)  

24. Select **\# of Customers** on the left and drag and drop it to the
**Color (Bubble)** drop target and **Size (Bubble)** drop target
respectively.

    ![](./images/400/Picture400-24.png)  

25. The more customers a state has, the deeper color and larger bubble it
has. Click the **Close Maximized Visualization** icon in the top-right corner
of the map.
    ![](./images/400/Picture400-25.png)  

26. Select **Sales** in the Sample Order Line list on the left, right click
it and select **Pick Visualization…** on the pop-up menu.

    ![](./images/400/Picture400-26.png)  

27. In the View Select dialog, select the **Tile** visualization type.

    ![](./images/400/Picture400-27.png)  

28. Drag and drop the Profit tile to the top after it is displayed at the
bottom. Create the **Sales** tile and **Quantity Ordered** tile respectively in
the same way. You can adjust the positions of the tiles by drag and drop.

    ![](./images/400/Picture400-28.png)  

29. Right click the **Sales** tile and select **Properties** on the pop-up
menu.

    ![](./images/400/Picture400-29.png)  

30. Select **\#** in the Properties dialog, and click **Auto** in the Number
format line, and then select **Currency**. The property items changes
accordingly after the Currency item is selected.

    ![](./images/400/Picture400-30.png)  

31. Click **0.01** at the right of Decimal, select **None** in the pop-up
menu.

    Change the properties of **Profit** tile in the same way.

    ![](./images/400/Picture400-31.png)  

32. Now you get a nice visualization. You can save and share. You can see
the tiles of Sales, Profits, and Quantity Ordered on the top. Down below
you can see the tree map by product category and sub product category.
You can also see the geographic distribution of sales and \# of
customers by states US.

    ![](./images/400/Picture400-32.png)  

Section 2: Adding Data Sources from Comma Separated Value files
====================================================

In this section you add two data sources from Comma Separated Value
files with the .CSV extension to your project. You can also add
Microsoft Excel spreadsheet file. Data source files from a Microsoft
Excel spreadsheet file must have the XLSX extension (signifying a
Microsoft Office Open XML Workbook file).

1. Return to the Home page, and click **Data Sources** on the top and click
**Data Source** on the left.

    ![](./images/400/Picture400-33.png)  

2. In the Create New Data Source dialog, click **Add Connection** to view
different types of data sources Oracle Data Visualization supports.

    ![](./images/400/Picture400-34.png)  

3. Oracle Data Visualization can connect many types of data sources like
Oracle Applications, databases, Salesforce, Spark.

    Because you will upload Comma Separated Value files as the data sources
in this section, click the **left arrow** icon to go back to the Create New
Data Source dialog.

    ![](./images/400/Picture400-35.png)  

4. In the Create New Data Source dialog, click **File**.

    ![](./images/400/Picture400-36.png)  

5. In the Select File dialog, select the **People.csv** file, which should
be downloaded at the beginning of this tutorial.

    ![](./images/400/Picture400-37.png)  

6. The column names and data from People.csv are listed. Note, only part of
the records in the data source is displayed.

    ![](./images/400/Picture400-38.png)  

7. You can modify the uploaded data to help you further curate (organize
and integrate from various sources) data in projects. This is also
sometimes referred to as data wrangling.

    Click the **A** icon on the column TotalPopEst2015, select the option
**\# Measure**. The data type of TotalPopEst2015 is changed from
attribute to measure.

    Do the same thing for **TotalPopEst2014** column.

    A data source can contain any of the following:

    • Match columns: These contain values that are found in the match column
of another source, which relates this source to the other (for example,
Customer ID or Product ID).

    • Attribute columns: These contain text, dates, or numbers that are
required individually and aren’t aggregated (for example, Year, Category
Country, Type, or Name).

    • Measure columns: These contain values that should be aggregated (for
example, Revenue or Miles driven).

    ![](./images/400/Picture400-39.png)  

8. Click the **gear icon** alongside PopChangeRate1415, click **Sum** and
select **Average** as the aggregation type instead in the pop-up menu.

    Do the same thing for **PopChangeRate1015** column.

    Click **OK**.

    ![](./images/400/Picture400-40.png)  

9. The People data source is created as shown above. Click **People** to
view its elements.

    ![](./images/400/Picture400-41.png)  

10. Select all of the data elements in the People data source, right click
them, and click **Pick Visualization…** in the pop-up menu.

    ![](./images/400/Picture400-42.png)  

11. In the View Select dialog, select the **Table** visualization type.

    ![](./images/400/Picture400-43.png)  

12. The columns and rows of data in the People data source are listed in
table.

    Create the **Income** data source from the **Income.csv** file in the same
way as we create the People data source in the previous steps.

    ![](./images/400/Picture400-44.png)  

Section 3: Creating a Data Flow
====================

In this section we create a data flow from the People and Income data
sources created in the previous section. Data flows are a way to produce
a curated data source that you can use to easily and efficiently create
meaningful visualizations. You can create a data flow from one or more
data sources.

1. Return to the Home page, and click **Data Sources** on the top and click
**Data Flow** on the left.

    ![](./images/400/Picture400-45.png)  

2. In the Add Data Source dialog, select the **People** data source that we
want to base the data flow on. You can select only one data source in
this dialog; if needed, you can add additional data sources later. Click
**Add**.

    ![](./images/400/Picture400-46.png)  

3. The Data Flow editor is displayed and the columns from the selected data
source are displayed in the Data Elements pane. The data source
**People** is displayed as the first step in the workflow diagram pane.

    ![](./images/400/Picture400-47.png)  

4. In the Data Flow editor, go to the workflow diagram pane and right click
the **People** icon. Select **Add Step**.

    ![](./images/400/Picture400-48.png)  

5. From the Add Step window, click **Add Data** to add the Income data
source.

    ![](./images/400/Picture400-49.png)  

6. In the Add Data Source dialog, select **Income**. Click **Add**.

    ![](./images/400/Picture400-50.png)  

7. The Income data source is also added to the workflow diagram pane.

    Click the save data flow icon in the top left corner and select
**Save**. Although you have not completed the data flow, it’s always a
good habit of saving it in time.

    ![](./images/400/Picture400-51.png)  

8. In the Save Data Flow As dialog, input **People and Income DF** as the
name of the data flow you are working on. Click **OK**.

    ![](./images/400/Picture400-52.png)  

9. You can see that the data flow is saved and named People and Income DF.

    ![](./images/400/Picture400-53.png)  

10. Let’s continue to create the data flow after saving it.

    In the workflow diagram pane, select both the **People** and the
**Income** icons and right click them. Select **Join**.

    ![](./images/400/Picture400-54.png)  

11. In the Step Details pane, you can see the two data sources are joined by
the match column FIPS.

    You can analyze a data source on its own, or you can analyze two or more
data sources together, depending on what the data source contains. If
you use multiple sources together, then at least one match column must
exist in each source. The requirements for matching are:

    • The sources contain common values (for example, Customer ID or Product
ID)

    • The match must be of the same data type (for example, number with
number, date with date, or text with text)

    ![](./images/400/Picture400-55.png)  

12. Click **Preview**, you can preview the joint data. Notice that the
columns of FIPS, State, and County exist in both People and Income data
sources, so the duplicate columns are renamed as FIPS\_1, State\_1,
County\_1 automatically.

    ![](./images/400/Picture400-56.png)  

13. In the workflow diagram pane, right click the **Join** icon. Select
**Add step**.

    ![](./images/400/Picture400-57.png)  

14. From the Add Step window, click **Select Columns**.

    ![](./images/400/Picture400-58.png)  

15. In the Step Details pane, select the duplicate columns of FIPS\_1,
State\_1, and County\_1. Click **Remove selected**.

    ![](./images/400/Picture400-59.png)  

16. The duplicate columns are removed to the left. Click **Preview**.

    ![](./images/400/Picture400-60.png)  

17. Now there is no duplicate column in the joint data set.

    However, if you look into the top five rows, you can find that:

    • In the first row, the United States should be a country rather than a
county. The FIPS is 0.

    • In the second row, Alabama should be a state rather than a county in the
United States. The FIPS is 1000.

    • Autauga, Baldwin, and Barbour and so on are counties in Alabama, the
FIPS’ are 1001, 1003, and 1005 an so on respectively.

    • The country, state, and county level rows are mixed together in this
data source. We need to remove the rows of the United States and the
states from the table, and leave only the county rows in the table for
further analysis and visualization.

    In the workflow diagram pane, right click the **Select Column** icon. Select **Add step**.

    ![](./images/400/Picture400-61.png)  

18. From the Add Step window, click **Add Columns**.

    ![](./images/400/Picture400-62.png)  

19. In the Step Details pane, click **Math** to expend the list of math
functions.

    ![](./images/400/Picture400-63.png)  

20. Scroll down the list and double click the **Mod** function.

    ![](./images/400/Picture400-64.png)  

21. The MOD function is selected in the edit box. Input **FIPS** as the
first parameter and **1000** as the second parameter for the MOD
function. Input **LOCATE\_STATE** as the new column name. Click
**Validate** and **Apply**. Then click **Preview**.

    ![](./images/400/Picture400-65.png)  

22. You can see that a column named LOCATE\_STATE is added on the right. The
values of LOCATE\_STATE of the country and state level rows are zero,
and the values of the county level rows are non-zero.

    In the workflow diagram pane, right click the **Add Columns** icon. Select **Add step**.

    ![](./images/400/Picture400-66.png)  

22. From the Add Step window, click **Filter** to filter the country and
state level rows out.

    ![](./images/400/Picture400-67.png)  

23. Select **LOCATE\_STATE** in the data element list on the left, drag and
drop it to the Expression edit box. Input **&lt;&gt;0**, click
**Validate** and **Apply**. Click **Preview**.

    ![](./images/400/Picture400-68.png)  

24. You can see that only the rows with the non-zero values of LOCATE\_STATE
are kept in the table for further analysis.

    In the workflow diagram pane, right click the **Filter** icon. Select
**Add step**.

    ![](./images/400/Picture400-69.png)  

25. From the Add Step window, click **Rename Columns**.

    ![](./images/400/Picture400-70.png)  

26. In the Step Details pane, rename the following columns.

    PopChangeRate1415 -&gt; Pop Change Rate 1415

    PopChangeRate1015 -&gt; Pop Change Rate 1015

    TotalPopEst2015 -&gt; Total Pop Est 2015

    TotalPopEst2014 -&gt; Total Pop Est 2014

    MedHHInc2014 -&gt; Med HH Inc 2014

    PerCapitaInc -&gt;Per Capita Inc 2014

    PovertyUnder18Pct2014 -&gt; % Poverty Under 18 2014

    PovertyAllAgesPct2014 -&gt; % Poverty All Ages 2014

    Click **Review**.

    ![](./images/400/Picture400-71.png)  

27. You can see the renamed columns in the table.

    In the workflow diagram pane, right click the **Rename Columns** icon. Select **Add step**.

    ![](./images/400/Picture400-72.png)  

28. From the Add Step window, click **Aggregate**.

    ![](./images/400/Picture400-73.png)  

29. The aggregate function for each data element should be shown as that in
the screenshot. If not, change the functions to Average or Sum
accordingly. The function is **Sum** for **Total Pop Est 2015** and
**Total Pop Est 2014**, and **Average** for the rest of data elements.

    In the workflow diagram pane, right click the **Aggregate** icon. Select
**Add step**.

    ![](./images/400/Picture400-74.png)  

30. From the Add Step window, click **Save Data**.

    ![](./images/400/Picture400-75.png)  

31. In the Step Details pane, input **People and Income** as the output data
source name.

    Click the **right arrow icon** at the top right corner to execute the
data flow.

    ![](./images/400/Picture400-76.png)  

32. Return to the Home page, and click **Data Sources** on the top and click
the newly created **People and Income** data source.

    ![](./images/400/Picture400-77.png)  

33. In the date element list, select both **State** and **Total Pop Est
2014**, right click them, and select **Pick Visualization…** on the
pop-up menu.

    ![](./images/400/Picture400-78.png)  

34. In the View Select dialog, select the **Map** visualization type.

    ![](./images/400/Picture400-79.png)  

35. You can see that states are colored in blue. The darker the color is,
the higher value of Total Pop Est 2014 is.

    Right click **My Calculations** on the left, select **Add
Calculations…**.

    ![](./images/400/Picture400-80.png)  

36. Drag and drop **Total Pop Est 2015** and **Total Pop Est 2014** from the
date element list to the edit box in the New Calculation dialog, add an
minus ( **-** ) symbol between them. Name it as **Pop Change 1415**. Click **Validation**. Click **Save**.

    ![](./images/400/Picture400-81.png)  

37. The newly created Pop Change 1415 calculation is listed under the My
Calculations folder on the left. Select both **State** and **Pop Change
1415**, right click them, and select **Create Best Visualization** in
the pop-up menu.

    ![](./images/400/Picture400-82.png)  

38. Oracle Visualization allows even nontechnical users to select a few data
elements and generate what the software thinks is the best visualization
for the relationships between those items. It helps business users
uncover patterns and understand their data better. In this example, it
creates a bar chart for the estimated population change between year
2015 and year 2014. From the bar chart, we can easily see the states
with big positive or negative changes.

    Click the **Share Project icon** in the top right corner, save the
project as **People and Income Viz**.

    ![](./images/400/Picture400-83.png)  

Section 4: Adding a Data Source from Oracle Database 
==========================================

1. In the **Data Sources** page, go to the **Create pane**, and click
**Connection**.

    ![](./images/400/Picture400-84.png)  

2. In the Create New Connection dialog, click the **Oracle Database** icon.

    ![](./images/400/Picture400-85.png)  

3. In the Add a New Connection dialog, enter **BDJOURNEY** as the
**Connection Name**, and then enter the required connection information,
such as **Host**, **Port**, **Password**, and **Service Name**. Note
that your connection information might be different from that shown in
the screenshot.

    Click **Save**. You can now begin creating data sources from the
connection.

    ![](./images/400/Picture400-86.png)  

4. In the Data Sources page, go to the Create pane, and click **Data
Source**.

    ![](./images/400/Picture400-33.png)  

5. In the Create New Data Sources page, click **BDJOURNEY** connection
created just now.

    ![](./images/400/Picture400-87.png)  

6. In the Create Source dialog, double click **BDJOURNEY**, the table list
is displayed.

    ![](./images/400/Picture400-88.png)  

7. In the Create Source dialog, browse or search for and double-click the
**TWITTER\_FINAL** table where you store the twitter data generated from
previous tutorials. Your table name might be different.

    ![](./images/400/Picture400-89.png)  

8. Select both **RETWEET\_COUNT** and **RETWEET\_STATE** from the column
list. Click **Add Selected**.

    Click Enter SQL in the top right corner to display the SQL Statement
field.

    ![](./images/400/Picture400-90.png)  

9. In the SQL Statement field, add aliases, **Count** and **State,** to
make column names more readable.

    Click **Refresh Data** to view a snapshot of the data in the columns
that you selected. Click **OK**.

    ![](./images/400/Picture400-91.png)  

10. The new data source named TWITTER\_FINAL is created and is included in
the Databases section of the Display pane. The data source contains a
cached copy of the data, and you can refresh the data and metadata from
that data source, as needed.

    Click the **TWITTER\_FINAL** data source.

    ![](./images/400/Picture400-92.png)  

11. Click **Data Elements** icon at the top left corner to display the
columns. Select both **COUNT** and **STATE**, right click, and select **Pick
Visualization…** in the pop-up menu.

    ![](./images/400/Picture400-93.png)  

12. In the View Select dialog, select the **Table** visualization type.

    ![](./images/400/Picture400-94.png)  

13. Drag and drop **STATE** to the top of **COUNT** in the Rows drop target
to adjust the display order of the columns in the table. There are 4,608
tweets in Indiana and 301,824 tweets in New York. The blank ones are
tweet counts outside of the US.

    ![](./images/400/Picture400-95.png)  

14. Go back to the Home page, Click the project **People and Income Viz**
you saved in the previous section.

    ![](./images/400/Picture400-96.png)  

15. Right click in the blank area of Data Elements pane on the left, select
**Add Data Source** in the pop-up menu.

    ![](./images/400/Picture400-97.png)  

16. Select **TWITTER\_FINAL** in the Add Data Source window.

    ![](./images/400/Picture400-98.png)  

17. Drag and drop **COUNT** from the data element list on the left to the
**Size (Bubble)** drop target. Two bubbles are displayed in the map.

    ![](./images/400/Picture400-99.png)  
 
19. The larger size bubble represents the tweet count in New York. Save the project.

    ![](./images/400/Picture400-100.png) 

Want to Learn More?
===================

-   [Oracle Data Visualization Cloud Service - Overview and Pricing](https://cloud.oracle.com/en_US/data_visualization)

-   [Oracle Data Visualization Cloud Service - Help Center](http://docs.oracle.com/cloud/latest/data-visualization-cloud/index.html)

-   [Oracle Cloud White Papers](https://cloud.oracle.com/whitepapers)

-   [Oracle EPM & BI Tutorials YouTube Channel](http://www.youtube.com/OracleEpmBiTutorials)


