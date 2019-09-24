
![](./media/labs.jpg)

## Who Should Complete This Lab: All Participants

# Using Oracle Machine Learning

## Table of Contents

- [Module 1: Sign-In to Autonomous Database Service Console](#module-1--sign-in-to-autonomous-database-service-console)
- [Module 2: Sign-In and Explore the OML Home Page](#module-2--sign-in-and-explore-the-oml-home-page)
- [Module 3: Running a SQL Statement](#module-3--running-a-sql-statement)
- [Module 4: Saving the SQL as a New Notebook](#module-4--saving-the-sql-as-a-new-notebook)
- [Module 5: Creating and Running SQL scripts](#module-5--creating-and-running-sql-scripts)

****

Using Oracle Machine Learning
-----------------------------

Oracle Autonomous Database includes a built-in, browser-based SQL notebook tool
called **Oracle Machine Learning**. It provides an interactive data analysis
environment where teams can work together to build shared, sophisticated reports
and dashboards. It is perfect for data scientists, SQL report builders and SQL
developers and business analysts.

In this lab you will be using the **Oracle Machine Learning** notebook
application provided with autonomous database.



## Module 1:  Sign-In to Autonomous Database Service Console


If you received an email with a link to the Oracle Machine Learning Login Page when your account was created in the previous lab (like the one in the picture below), you can click on the link and proceed directly to Module 2. 

![](media/64d3a0bce2f100135038be0bbd2ddcec.png)
  <p align="center">Figure 1-1</p>

Otherwise review the steps to connect to OML in Lab 4 - Module 4. A brief review follows. 
1. Log into your Oracle Cloud Account and navigate to the Autonomous Database Service Console.

2. Browse to your **Autonomous Database** page for the appropriate database you created in the earlier lab.


3. . From the **Autonomous Data Warehouse Details** (in this case) page, click on **Service
    Console** to sign in to the service console.

![](media/b9224ddf217a80c337073994086fce71.png)
<p align="center">Figure 1-4</p>

4. From the Service Console select **Manage Oracle OML Users**

![](media/manageoml.jpg)

[Back to Top](#table-of-contents)



## Module 2:  Sign-In and Explore the OML Home Page

After selecting Manage Oracle ML Users you will be placed in the OML Administration page.

1. Sign-in to OML using the link from the welcome email, or by clicking
    the **Home** button on the top right of **Oracle Machine Learning** User Administration**.

     ![](media/omladmin.jpg)
       <p align="center">Figure 2-1</p>

2. Sign-in using your **OML** user created in the earlier lab.

    ![](media/login.jpg)
           <p align="center">Figure 2-2</p>

3. Once you have successfully signed-in to OML the **Oracle Machine Learning**
    home page will be displayed.

    ![](media/8dbbc1cbe21bbd97a1811c93863c739b.png)
           <p align="center">Figure 2-3</p>

4. The grey menu bar at the top of the screen provides links to the main OML
    menus for the application (left corner) and the workspace/project and user
    maintenance on the right-hand side.

    ![](media/e43c07023ad086f650b32d276c4133f0.png)
           <p align="center">Figure 2-4</p>

5. On the home page the main focus is the **Quick Actions** panel. The icons in
    this panel provide shortcuts to the OML pages for running queries and
    managing your saved queries.

    ![](media/6a36f48868d8bdba32223b3b7526c5db.png)
           <p align="center">Figure 2-5</p>

>   **Key OML Concepts**

>   **What is a Workspace?** A workspace is an area where you can store your
>   projects. Each workspace can be shared with other users so they can
>   collaborate with you. For collaborating with other users, you can provide
>   different levels of permission such as Viewer, Developer and Manager – these
>   will be covered in more detail later in this workshop. You can create
>   multiple workspaces.

>   **What is a Project?** A project is a container for organizing your
>   notebooks. You can create multiple projects.

>   **What is a Notebook?** A notebook is a web-based interface for building
>   reports and dashboards using a series of pre-built data visualizations which
>   can then be shared with other OML users. Each notebook can contain one or
>   SQL queries and/or SQL scripts. Additional non-query information can be
>   displayed using special markdown tags (an example of these tags will be
>   shown later).

>   **Note:** All your work is automatically saved – i.e. there is no **Save**
>   button when you are writing scripts and/or queries.

[Back to Top](#table-of-contents)

## Module 3:  Running a SQL Statement

1. From the home page click on **Run SQL Statement** in the **Quick Actions**
    panel to open a new SQL query scratchpad.

    ![](media/f00aab3893c91e21290292f728153f38.png)
           <p align="center">Figure 3-1</p>

-   If this is your first time exploring this link, the notebook server will
    startup.

    ![](media/4a729c8a095d3b3ad0680b7cf5a7c070.png)
               <p align="center">Figure 3-2</p>

-   You will be presented the **SQL Query Scratchpad**.

    ![](media/c0590d30b7aced20ea6891e932a1c5bc.png)
               <p align="center">Figure 3-3</p>

-   The white panel below the title **SQL Query Scratchpad** is an area known as
    **Paragraph**. Within a scratchpad you can have multiple paragraphs. Each
    paragraph can contain one SQL statement or a SQL script.

2. You need to enter the SQL in **SQL Paragraph**. 

***
    SELECT

    p.prod_category_desc,

    t.calendar_year as year,
    t.calendar_month_desc as Month,

    TRUNC(SUM(amount_sold)) as revenue,

    TRUNC(AVG(SUM(amount_sold)) over (PARTITION BY t.calendar_year ORDER BY
    p.prod_category_desc, t.calendar_month_desc ROWS 2 PRECEDING)) as
    avg_3M_revenue,

    TRUNC(AVG(SUM(amount_sold)) over (ORDER BY p.prod_category_desc,

    t.calendar_month_desc ROWS 5 PRECEDING)) as avg_6M_revenue,
    TRUNC(AVG(SUM(amount_sold)) over (ORDER BY p.prod_category_desc,

    t.calendar_month_desc ROWS 11 PRECEDING)) as avg_12M_revenue
    FROM sh.sales s, sh.times t, sh.products p

    WHERE s.time_id = t.time_id

    AND s.prod_id = p.prod_id

    AND prod_category_desc = 'Electronics'

    GROUP BY p.prod_category_desc, t.calendar_year, calendar_month_desc

    ORDER BY p.prod_category_desc, t.calendar_year, calendar_month_desc;

***

-   Your screen should now look like this:

    ![](media/1b67442b28bc88c2782c1244a646f9c9.png)
               <p align="center">Figure 3-4</p>

3. On the top-right, click (**Run this Paragraph)** to execute the SQL statement.

    ![](media/3400580e62272da01ed063f943ee1f29.png)
               <p align="center">Figure 3-5</p>

-   The results will be displayed in a tabular format as follows:

    ![](media/fa643297ef36b61df258b2ec7b92d406.png)
               <p align="center">Figure 3-6</p>

#### Changing the Report Type

-   Using the report menu, you can change the table to a graph and/or export the
    result set to a CSV or TSV file.

    ![](media/8eb7e2a03ca5ee98714e27cf3501f766.png)
               <p align="center">Figure 3-7</p>

-   When you change the report type to one of the graphs, then a Settings link
    will appear to the right of the menu which allows you to control the layout
    of columns within the graph.

4. Click on the **Bar Chart** icon to change the output to a bar graph (see
    below)

    ![](media/f75e19dd8619370a7c6cd5066187297e.png)
               <p align="center">Figure 3-8</p>

5. Click on Settings to unfold the settings panel for the graph.

   ![](media/493c9fd64fea10f90425b330e477da4e.png)
              <p align="center">Figure 3-9</p>


6. To add a column to one of the **Keys**, **Groups** of **Values** panels just
    drag and drop the column name into the required panel.

7. To remove a column from the **Keys**, **Groups** of **Values** panel just
    click on the “x” next to the column name displayed in the relevant panel.

#### Changing the Graph Layout

-   With the graph settings panel visible:

8. Remove all columns from the both the **Keys** and **Values** panels.

9. Drag and drop **MONTH** into the **Keys** panel

10. Drag and drop **REVENUE** into the **Values** panel

11. Drag and drop **AVG_12M_REVENUE** into the **Values** panel

-   The report should now look like the one shown below.

    ![](media/8f6e257e114e449ee033f9aa87d22225.png)
               <p align="center">Figure 3-10</p>

#### Cleanup the Report

12. Click on the Settings link to hide the layout controls.

13. Click on **Hide editor** button which is to the right of the “Run this
    paragraph” button.

    ![](media/d17190badcbfa377762102168f0b0ad7.png)
               <p align="center">Figure 3-11</p>

-   Now only the output is visible.

    ![](media/fbb629bfdee6f0379c582f19e70a49ca.png)
               <p align="center">Figure 3-12</p>

 [Back to Top](#table-of-contents)

## Module 4:  Saving the SQL as a New Notebook

-   The SQL Scratchpad in the previous section is simply a default type notebook
    with a system generated name. But we can change the name of the scratchpad
    we have just created SQL Query Scratchpad.

1. Click on the hamburger menu on top left and then click on **Menu** to return to the OML home page.

    ![](media/e4dd1fca2a21d8f0ad3c454c7ca87435.png)
               <p align="center">Figure 4-1</p>

-   Notice that in the **Recent Activities** panel there is a potted history of
    what has happened to your SQL scratchpad Notebook.

    ![](media/a7733c3545416a08172f4b8d5e2178f6.png)
                   <p align="center">Figure 4-2</p>

2. Click on **Notebooks** in the **Quick Actions** panel.

    ![](media/09e9f6473988fec7cac8c15b8cc0d4b2.png)
                   <p align="center">Figure 4-3</p>

-   The **Notebooks** page will be displayed:

    ![](media/dc7ae09c02d83351a861d3ecb6be4e14.png)
                   <p align="center">Figure 4-4</p>

-   Let’s rename our **SQL Query Scratchpad** notebook to something more
    informative.

3. Click on the row **Notebook** so it gets highlighted and the menu buttons
    above will activate.

     ![](media/a0f18fe8345262e283a5822b92c00c5c.png)
                    <p align="center">Figure 4-5</p>

4. Click on the **Edit** button to pop-up the settings dialog for this
    notebook.

    ![](media/af020abf3cd15d2b891a113c4c14b3ea.png)
                   <p align="center">Figure 4-6</p>

5. Enter the information as shown in the image below (note that the connection
    information is read-only because this is managed by the autonomous
    database). Click **OK** to save your notebook.

    ![](media/e8c9e62ffd7bc1a8c34c66825b6503c6.png)
                   <p align="center">Figure 4-7</p>

-   You will see that your SQL Query Scratchpad notebook is now renamed to the
    new name you specified.

    ![](media/d53a157f67b2c99fd2eb0bf0cfa672e1.png)
                   <p align="center">Figure 4-8</p>

[Back to Top](#table-of-contents)


## Module 5:  Creating and Running SQL scripts


1. The **Run SQL Statement** link on the home page allows you to run a single
    query in a paragraph. To be able to run scripts you can use the **Create a
    SQL Script** link on the home page.

    ![](media/790660df07633ab99dd8e7564f1cb035.png)
                       <p align="center">Figure 5-1</p>

2. A new SQL scratchpad will be created with the **%script** identifier already
    selected; this identifier allows you to run multiple SQL statements.

    ![](media/42f55993f4e76ef7608e17616ceed5ac.png)
                           <p align="center">Figure 5-2</p>

3. Next, we are going to use a script shows how to use the SQL pattern matching
    MATCH_RECOGNIZE feature for sessionization analysis based on JSON web log
    files.

4. [Download](https://www.dropbox.com/s/wjzixmv2xzihg1i/oml_sql2.sql?dl=0) the
    OML Script, open the script in your favorite editor and **Copy** the
    contents.

5. Paste the script to the **%script** paragraph:

    ![](media/783b4c6da518d4994e5c40e6e4495278.png)
                           <p align="center">Figure 5-3</p>

6. You can then run the script/paragraph and the output will appear below the
    code that makes up the script.

    ![](media/0663fa174c7a781626c9953d45b5a4a0.png)
                           <p align="center">Figure 5-4</p>
-   The result should look something like this:

    ![](media/6aefdec154d0014ec221bb6c0f6875b0.png)
                           <p align="center">Figure 5-5</p>

**You have successfully completed the Oracle Machine Learning Lab.**

***END OF LAB***

[Back to Top](#table-of-contents)  
