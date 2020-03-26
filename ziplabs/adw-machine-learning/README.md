---
layout: ziplab
description: Examine Machine Learning Notebooks through Oracle Autonomous Data Warehouse Cloud.
tags: Oracle Cloud, Autonomous Data Warehouse, ADW, Oracle Cloud Infrastructure, OCI, Machine Learning, ML
permalink: /ziplabs/adw-machine-learning/index.html
---
# Getting Started With Oracle Machine Learning Notebooks #

## Before You Begin ##
In this 15-minute lab you will get started with the Oracle Machine Learning (OML) notebook application provided through ADWC. This browser-based application provides a web interface to run SQL queries and scripts, which can be grouped together within a notebook. Notebooks can be used to build single reports, collections of reports, and dashboards.

### Background ###
Oracle Machine Learning is a SQL notebook interface for data scientists to perform machine learning in the Oracle Autonomous Data Warehouse Cloud (ADWC). Notebook technologies support the creation of scripts while supporting the documentation of assumptions, approaches and rationale to increase data science team productivity. Oracle Machine Learning SQL notebooks, based on Apache Zeppelin technology, enable teams to collaborate to build, evaluate and deploy predictive models and analytical methodologies in the Oracle ADWC. Multi-user collaboration enables the same notebook to be opened simultaneously by different users. Changes made by one user are immediately updated for other team members.

Oracle Machine Learning SQL notebooks provide easy access to Oracle's parallelized, scalable in-database implementations of a library of Oracle Advanced Analytics' machine learning algorithms (classification, regression, anomaly detection, clustering, associations, attribute importance, feature extraction, times series, etc.), SQL, PL/SQL and Oracle's statistical and analytical SQL functions. Oracle Machine Learning SQL notebooks and Oracle Advanced Analytics' library of machine learning SQL functions combined with PL/SQL allow companies to automate their discovery of new insights, generate predictions and add "AI" to data viz dashboards and enterprise applications.


### What Do You Need? ###
* Access to an instance of Oracle Autonomous Data Warehouse Cloud
* You must have completed the previous lab **Provisioning Autonomous Data Warehouse Cloud and Connecting with SQL Developer**.


## Create an OML User ##
1. Sign in to the Oracle Cloud Platform. 
2. Click the menu icon to expand the menu on the left edge of the screen.
3. Click **Services**.
4. Click **Autonomous Date Warehouse**.

    ![](img/MyServicesMenu.png)

    [Description of the illustration MyServicesMenu.png](files/MyServicesMenu.txt) 

5. In the menu across from the name of your data warehouse, select **Service Console**.

    ![](img/open_service_console.png)

    [Description of the illustration open_service_console.png](files/open_service_console.txt)

6. Depending on your browser settings, you may need to give permission for the Service Console to open in a new tab.
7. The service console opens in the **Overview** mode. Click **Administration** in the left navigation pane.
8. Click **Manage Oracle ML Users**.
9. Sign in using the same information as before:
     * **Username**: `admin`
     * **Password**: Enter the administrator password you specified when you created your service instance.
10. Click the **Create** button to create a new OML user. This will also create a new database user with the same name. The newly created user will be able to use the OML notebook application.

    ![](img/CreateUser.png)

    [Description of the illustration CreateUser.png](files/CreateUser.txt)

11. You're taken to the Create Users page. Enter the following information:
     * **Username**: `omluser1`
     * **First Name**: `OML`
     * **Last Name**: `User1`
     * **Email Address**: For easy access, enter the same email address you used to login to your cloud account.
     * **Password:** Uncheck the box to auto generate a password. Instead create a new password yourself.
12. You're taken back to the Users page where the new user is now listed.
13. You'll also recieve a confirmation email that your OML has been created. This email contains a direct link to the OML application sign in, and your password if you chose to auto-generate one.


## Sign in to OML ##
1. Go to the OML sign in page. You have two options to navigate there:
     * Click the link included in your confirmation, or... 
     * Click the **Home** button on the Users page.

    ![](img/CreateUser2.png)

    [Description of the illustration CreateUser2.png](files/CreateUser2.txt)

2. Sign in using the credentials you just created.
     * **Username**: `omluser1`
     * **Password**: Use the password you just created
3. You're taken to the OML home page.
    

## Open a New SQL Query Scratchpad ##
1. Click **Run SQL Statement** in the Quick Actions window.

    ![](img/QuickActions.png)

    [Description of the illustration QuickActions.png](files/QuickActions.txt)

2. You're taken to a SQL Query Scratchpad. You'll notice a white panel below the title. This area is known as “paragraph”. Within a scratchpad you can have multiple paragraphs. Each paragraph can contain one SQL statement or a SQL script.
    
    ![](img/SQLParagraph.png)

    [Description of the illustration SQLParagraph.png](files/SQLParagraph.txt)

3. Copy and paste this code into the SQL paragraph area: 
   ````SQL
    SELECT 
     p.prod_category_desc,
     t.calendar_year as year,
     t.calendar_month_desc as Month,
     TRUNC(SUM(amount_sold)) as revenue,
     TRUNC(AVG(SUM(amount_sold)) over (PARTITION BY t.calendar_year ORDER BY p.prod_category_desc, t.calendar_month_desc ROWS 2 PRECEDING)) as avg_3M_revenue,
     TRUNC(AVG(SUM(amount_sold)) over (ORDER BY p.prod_category_desc, t.calendar_month_desc ROWS 5 PRECEDING)) as avg_6M_revenue,
     TRUNC(AVG(SUM(amount_sold)) over (ORDER BY p.prod_category_desc, t.calendar_month_desc ROWS 11 PRECEDING)) as avg_12M_revenue 
    FROM sh.sales s, sh.times t, sh.products p
    WHERE s.time_id = t.time_id
    AND s.prod_id = p.prod_id
    AND prod_category_desc = 'Electronics'
    GROUP BY p.prod_category_desc, t.calendar_year, calendar_month_desc
    ORDER BY p.prod_category_desc, t.calendar_year, calendar_month_desc;
   ````
4. Press the button to run the paragraph. It's located in the top right corner of the SQL paragraph area.

    ![](img/RunParagraph.png)

    [Description of the illustration RunParagraph.png](files/RunParagraph.txt)

5. Observe the results. You'll need this output to answer a Zip Lab quiz question.

    ![](img/SQLOutput.png)

    [Description of the illustration SQLOutput.png](files/SQLOutput.txt)


## Change the Report Type ##
The report menu bar lets you change the table to a graph and/or export the result set to a CSV or TSV file. When you change the report type to one of the graphs, a Settings link appears to the right of the menu. Settings
allows you to control the layout of columns within the graph.

   ![](img/ReportMenuBar.png)

   [Description of the illustration ReportMenuBar.png](files/ReportMenuBar.txt)

1. Change the report type to a bar chart.
2. Click **Settings** to unfold the settings panel.

    ![](img/BarChart1.png)

    [Description of the illustration BarChart1.png](files/BarChart1.txt)


## Change the Layout of the Graph ##
Now that we're showing a bar graph, let's see how the output can be customized. To add a column to one of the Keys, Groups of Values panels just drag and drop the column name into the required panel. To remove a column from the Keys, Groups of Values panel just click on the **x** next to the column name displayed in the relevant
panel.

1. Remove all columns from the both the Keys and Values panels.
2. Drag and drop **MONTH** into the **Keys** panel.
3. Drag and drop **REVENUE** into the **Values** panel.
4. Drag and drop **AVG_12M_REVENUE** into the **Values** panel.

    ![](img/BarChart2.png)

    [Description of the illustration BarChart2.png](files/BarChart2.txt)


## Tidy up the Report ##
1. Click **Settings** to hide the layout controls.
2. Click the **Hide editor** button which is to the right of the "Run this paragraph" button.

    ![](img/HideEditor.png)

    [Description of the illustration HideEditor.png](files/HideEditor.txt)

3. Now only the output is visible.

    ![](img/BarChart3.png)

    [Description of the illustration BarChart3.png](files/BarChart3.txt)


## Save the Scratchpad as a New Notebook ##
The SQL Scratchpad we're using is simply a default type notebook with a system generated name. You can change the name of the scratchpad and save it for later use by your team.

1. Click on the Back link in the top left corner of the Scratchpad window to return to the OML home page.
2. Notice that in the Recent Activities panel there is a potted history of what has happened to your SQL scratchpad “notebook”.
3. Click **Notebooks** in the Quick Actions panel.
4. Click the text in the comments column to select
the scratchpad. After you click, the item becomes selected and the menu buttons above will activate.
5. Click the **Edit** button to pop-up the settings dialog for this notebook.
6. Modify the details for this notebook to something more informative:
     * **Name**: `Sales Analysis Over Time`
     * **Comment**: `Sales analysis bar graph`
     * **Connection**: `Global` 
        Note: Connection information is read-only. It's managed by Autonomous Data Warehouse Cloud.
7. Click **OK** to save your notebook. You will see that your SQL Query Scratchpad notebook is now renamed to the new name you specified.

    ![](img/Notebooks.png)

    [Description of the illustration Notebooks.png](files/Notebooks.txt)


## Want to Learn More? ##
* [Autonomous Cloud Platform Courses](https://learn.oracle.com/pls/web_prod-plq-dad/dl4_pages.getpage?page=dl4homepage&get_params=offering:35573#filtersGroup1=&filtersGroup2=.f667&filtersGroup3=&filtersGroup4=&filtersGroup5=&filtersSearch=) from Oracle University 
* [Autonomous Data Warehouse Cloud Certification](https://education.oracle.com/es/data-management/autonomous-data-warehouse-cloud/product_807?certPage=true) from Oracle University
* [ADWC Test Drive Workshop](https://oracle.github.io/learning-library/workshops/journey4-adwc/?page=README.md)
