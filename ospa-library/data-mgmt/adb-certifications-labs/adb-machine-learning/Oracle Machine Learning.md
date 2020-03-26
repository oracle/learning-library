
![](./media/adbtitle.png)
# Using Oracle Machine Learning

## Table of Contents

- [Module 1: Sign-In to Autonomous Database Service Console](#module-1--sign-in-to-autonomous-database-service-console)
- [Module 2: Creating OML Users](#module-2--creating-oml-users)
- [Module 3: Sign-In and Explore the OML Home Page](#module-3--sign-in-and-explore-the-oml-home-page)
- [Module 4: Running a SQL Statement](#module-4--running-a-sql-statement)
- [Module 5: Saving the SQL as a New Notebook](#module-5--saving-the-sql-as-a-new-notebook)
- [Module 6: Sharing Notebooks](#module-6--sharing-notebooks)
- [Module 7: Creating and Running SQL scripts](#module-7--creating-and-running-sql-scripts)

***** 

Using Oracle Machine Learning
-----------------------------

Oracle Autonomous Database includes a built-in, browser-based SQL notebook tool
called **Oracle Machine Learning**. It provides an interactive data analysis
environment where teams can work together to build shared, sophisticated reports
and dashboards. It is perfect for data scientists, SQL report builders and SQL
developers and business analysts.

In this lab you will be using the **Oracle Machine Learning** notebook
application provided with autonomous database.

### Objectives

-   Create OML Users

-   Exploring OML Home Page

-   Run a SQL Statement

-   Sharing Notebooks

### Required Artifacts

-   Please ensure you have provisioned an Oracle **Autonomous Data Warehouse**
    or an **Autonomous Transaction Processing** database.

## Module 1:  Sign-In to Autonomous Database Service Console


1. Sign in to **Oracle Cloud Infrastructure Home Page** using the credentials
    provided and the instructions from an earlier lab.

2. Browse to your **Autonomous Data Warehouse Home** page.

![](media/39ecc425e64de2537f82b2456028df77.png)
<p align="center">Figure 1-1</p>

3. From the **Autonomous Data Warehouse Home** page, click on the instance name
    to open the **Autonomous Data Warehouse Details** page.

![](media/6e7a7f9c4822fc78854905f6928a35cd.png)
<p align="center">Figure 1-2</p>

4. From the **Autonomous Data Warehouse Details** page, click on **Service
    Console** to sign in to the service console.

![](media/b9224ddf217a80c337073994086fce71.png)
<p align="center">Figure 1-3</p>

5. If prompted to **Sign In**, fill in the following **User** and **Password**
    and click **Sign In**:

    -   Username: **ADMIN**

    -   Password: **\<Password\>** specified during provisioning (e.g.
        Welcome_123\#)

![](media/be583405ef7f35967ea587b76e2b8a87.png)
<p align="center">Figure 1-4</p>

-   You will be placed in the **Overview** page.

![](media/9eb48ed2bfdf0548c12694fe771d7ed8.png)
<p align="center">Figure 1-5</p>

[Back to Top](#table-of-contents)

## Module 2:  Creating OML Users

1. From the **Autonomous Data Warehouse Service Console**, click on
    **Administration** link in the left menu.

  ![](media/dfdd9ad037004f637c8c2bacbcfe24ff.png)
  <p align="center">Figure 2-1</p>

2. On the service **Administration** page, click **Manage Oracle ML Users**.

    ![](media/85db707b4f76b233fb02bf4b8592a06c.png)
      <p align="center">Figure 2-2</p>

3. You will be presented the **Machine Learning User Administration** page.
    This page allows you to manage OML user accounts, i.e. the users that can
    login and use OML notebook application. Click the **Create** button to
    create a new OML user.

>   **Note:** Do not login as the **ADMIN** user for OML as Administrative users
>   cannot login to OML.

![](media/7ee731aa3c0f37410a9b0b0a4ce2e6c2.png)
  <p align="center">Figure 2-3</p>

4. On the **Create User** page, enter the following information and click
    **Create**:

    -   User Name : **omluser1**

    -   First Name : (Optional) \<First Name\>

    -   Last Name : (Optional) \<Last Name\>

    -   Email Address : **\<Your Email\>**

    -   Generate password and email details to the user : **Unchecked** (This
        will allow you to enter a password on this screen, otherwise you will
        get an email with a link to set your password)

    -   Password : **\<Password for OML User\>**

![](media/66a494878f9a790625abd6678af767ec.png)
  <p align="center">Figure 2-4</p>

-   Observe the **User Created** message. You should see that user
    **omluser1** is listed in the **Users** section.

 ![](media/d0cd8ddefdeb2d385585ee13282def3d.png)
   <p align="center">Figure 2-5</p>

-   If you supplied a valid email address and **Checked** the **Generate
    password and email details to the user** option, a welcome email should
    arrive within a few minutes in your **Inbox**.

    -   Below is the email which each user receives welcoming them to the OML
        application. It includes a direct link to the OML application for that
        user which they can bookmark.

![](media/64d3a0bce2f100135038be0bbd2ddcec.png)
  <p align="center">Figure 2-6</p>


    -   When you click on the link **Access Oracle ML SQL notebook** above, you
        will be asked to set a password for the OML user.

5. Using the same steps, create another user named **omluser2**. 

![](media/7573fdebbfa0714d589419a2940f7131.png)
  <p align="center">Figure 2-7</p>

-   You will use these two users later in this lab.

[Back to Top](#table-of-contents)

## Module 3:  Sign-In and Explore the OML Home Page

1. Sign-in to OML using the link from the welcome email, or by clicking
    the **Home** button on the top right of Oracle Machine Learning** User Administration**.

     ![](media/1cef6df53751373ee167e82404d5135d.png)
       <p align="center">Figure 3-1</p>

2. Sign-in using the **omluser1** user.

    ![](media/b5522914dd1d88ff2b51fcef607b19e9.png)
           <p align="center">Figure 3-2</p>

3. Once you have successfully signed-in to OML the **Oracle Machine Learning**
    home page will be displayed.

    ![](media/8dbbc1cbe21bbd97a1811c93863c739b.png)
           <p align="center">Figure 3-3</p>

4. The grey menu bar at the top of the screen provides links to the main OML
    menus for the application (left corner) and the workspace/project and user
    maintenance on the right-hand side.

    ![](media/e43c07023ad086f650b32d276c4133f0.png)
           <p align="center">Figure 3-4</p>

5. On the home page the main focus is the **Quick Actions** panel. The icons in
    this panel provide shortcuts to the OML pages for running queries and
    managing your saved queries.

    ![](media/6a36f48868d8bdba32223b3b7526c5db.png)
           <p align="center">Figure 3-5</p>

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

## Module 4:  Running a SQL Statement

1. From the home page click on **Run SQL Statement** in the **Quick Actions**
    panel to open a new SQL query scratchpad.

    ![](media/f00aab3893c91e21290292f728153f38.png)
           <p align="center">Figure 4-1</p>

-   If this is your first time exploring this link, the notebook server will
    startup.

    ![](media/4a729c8a095d3b3ad0680b7cf5a7c070.png)
               <p align="center">Figure 4-2</p>

-   You will be presented the **SQL Query Scratchpad**.

    ![](media/c0590d30b7aced20ea6891e932a1c5bc.png)
               <p align="center">Figure 4-3</p>

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
               <p align="center">Figure 4-4</p>

3. On the top-right, click (**Run this Paragraph)** to execute the SQL statement.

    ![](media/3400580e62272da01ed063f943ee1f29.png)
               <p align="center">Figure 4-5</p>

-   The results will be displayed in a tabular format as follows:

    ![](media/fa643297ef36b61df258b2ec7b92d406.png)
               <p align="center">Figure 4-6</p>

#### Changing the Report Type

-   Using the report menu, you can change the table to a graph and/or export the
    result set to a CSV or TSV file.

    ![](media/8eb7e2a03ca5ee98714e27cf3501f766.png)
               <p align="center">Figure 4-7</p>

-   When you change the report type to one of the graphs, then a Settings link
    will appear to the right of the menu which allows you to control the layout
    of columns within the graph.

4. Click on the **Bar Chart** icon to change the output to a bar graph (see
    below)

    ![](media/f75e19dd8619370a7c6cd5066187297e.png)
               <p align="center">Figure 4-8</p>

-   Click on Settings to unfold the settings panel for the graph.

   ![](media/493c9fd64fea10f90425b330e477da4e.png)
              <p align="center">Figure 4-9</p>

    to unfold the settings panel for the graph.



5. To add a column to one of the **Keys**, **Groups** of **Values** panels just
    drag and drop the column name into the required panel.

6. To remove a column from the **Keys**, **Groups** of **Values** panel just
    click on the “x” next to the column name displayed in the relevant panel.

#### Changing the Graph Layout

-   With the graph settings panel visible:

7. Remove all columns from the both the **Keys** and **Values** panels.

8. Drag and drop **MONTH** into the **Keys** panel

9. Drag and drop **REVENUE** into the **Values** panel

10. Drag and drop **AVG_12M_REVENUE** into the **Values** panel

-   The report should now look like the one shown below.

    ![](media/8f6e257e114e449ee033f9aa87d22225.png)
               <p align="center">Figure 4-6</p>

#### Cleanup the Report

11. Click on the Settings link to hide the layout controls.

12. Click on **Hide editor** button which is to the right of the “Run this
    paragraph” button.

    ![](media/d17190badcbfa377762102168f0b0ad7.png)
               <p align="center">Figure 4-7</p>

-   Now only the output is visible.

    ![](media/fbb629bfdee6f0379c582f19e70a49ca.png)
               <p align="center">Figure 4-8</p>

 [Back to Top](#table-of-contents)

## Module 5:  Saving the SQL as a New Notebook

-   The SQL Scratchpad in the previous section is simply a default type notebook
    with a system generated name. But we can change the name of the scratchpad
    we have just created SQL Query Scratchpad.

1. Click on the hamburger menu on top left and then click on **Menu** to return to the OML home page.

    ![](media/e4dd1fca2a21d8f0ad3c454c7ca87435.png)
               <p align="center">Figure 5-1</p>

-   Notice that in the **Recent Activities** panel there is a potted history of
    what has happened to your SQL scratchpad Notebook.

    ![](media/a7733c3545416a08172f4b8d5e2178f6.png)
                   <p align="center">Figure 5-2</p>

2. Click on **Notebooks** in the **Quick Actions** panel.

    ![](media/09e9f6473988fec7cac8c15b8cc0d4b2.png)
                   <p align="center">Figure 5-3</p>

-   The **Notebooks** page will be displayed:

    ![](media/dc7ae09c02d83351a861d3ecb6be4e14.png)
                   <p align="center">Figure 5-4</p>

-   Let’s rename our **SQL Query Scratchpad** notebook to something more
    informative.

3. Click on the row **Notebook** so it gets highlighted and the menu buttons
    above will activate.

     ![](media/a0f18fe8345262e283a5822b92c00c5c.png)
                    <p align="center">Figure 5-5</p>

4. Click on the **Edit** button to pop-up the settings dialog for this
    notebook.

    ![](media/af020abf3cd15d2b891a113c4c14b3ea.png)
                   <p align="center">Figure 5-6</p>

5. Enter the information as shown in the image below (note that the connection
    information is read-only because this is managed by the autonomous
    database). Click **OK** to save your notebook.

    ![](media/e8c9e62ffd7bc1a8c34c66825b6503c6.png)
                   <p align="center">Figure 5-7</p>

-   You will see that your SQL Query Scratchpad notebook is now renamed to the
    new name you specified.

    ![](media/d53a157f67b2c99fd2eb0bf0cfa672e1.png)
                   <p align="center">Figure 5-8</p>

[Back to Top](#table-of-contents)

## Module 6:  Sharing Notebooks

-   By default, when you create a notebook it’s only visible to you. To make it
    available to other users you need to share the workspace containing the
    notebook. You can create new workspaces and projects to organize your
    notebooks for ease of use and to share with other users.

-   To demonstrate the sharing process let’s begin by logging in to OML as our
    second OML (**omluser2**) user and checking if any notebooks are available.

1. Click on your user name in the top right corner (**omluser1**) and select
    **Sign Out**.

    ![](media/783b416309453c6dcdba84833eb39fe4.png)
                   <p align="center">Figure 6-1</p>

2. Now sign-in as OML user **omluser2** using the password you entered at the
    beginning of this workshop:

    ![](media/68fe685e417da6b29fc7e714a281c888.png)
                       <p align="center">Figure 6-2</p>

-   Notice that you have no activity listed in the **Recent Activities** panel
    on your OML home page and you don’t have any notebooks.

    ![](media/e9ab448c2a1af8366906fd1603669771.png)
                       <p align="center">Figure 6-3</p>

-   **Hint**: Click on the Notebooks link in the Quick Actions panel:


3. Logout of OML and sign in back OML as **omluser1**.

    ![](media/5f47e6b740e5343749f77d7896ce787b.png)
                       <p align="center">Figure 6-4</p>


#### Change Workspace Permissions

1. From the OML home page, click on **OML Project (OML Workspace)** link in the
    top right corner on the OML home page to display the workspace-project menu.
    Select **Workspace Permissions**.

    ![](media/75eba3fa4de958690880cdefe85eebfd.png)
                       <p align="center">Figure 6-5</p>

2. The permissions dialog box will appear. In the dialog box next to **Add
    Permissions** text type **OMLUSER2** (use uppercase). Set the permission
    type to **Viewer** (this means read-only access to the workspace, project
    and notebook).

    ![](media/f56bf40c18e87ffadb8d0880e20668aa.png)
                       <p align="center">Figure 6-6</p>

3. Click the Add button to add the user omluser2 as a read-only viewer of the
    workspace.

-   Your form should look like this:

    ![](media/7263893f9cd7fa740038fe467166034f.png)
                       <p align="center">Figure 6-7</p>

4. Finally, click the **OK** button.

#### Accessing shared notebooks

5. Now repeat the process you followed at the start of this section and
    sign-out of OML and sign-in to OML again as user omluser2.

-   First thing to note is that the Recent Activities panel below the Quick
    Links panel now shows all the changes user omluser1 made within the
    workspace OML-Workspace.

    ![](media/f16d3fa5b6eebcccaaf1444e50ef059a.png)
                       <p align="center">Figure 6-8</p>

6. As user omluser2 you can now run the Sales Analysis Over Time notebook by
    clicking on the blue-linked text in the Recent Activities panel (note that
    your recent activity will be logged under the banner labelled "Today").

    ![](media/51a35437498c5be43c130f37d6f64eeb.png)
                       <p align="center">Figure 6-9</p>

-   The notebook will now open:

    ![](media/c601b9c178927454f7ea5897cfaef1aa.png)
                       <p align="center">Figure 6-10</p>

[Back to Top](#table-of-contents)

## Module 7:  Creating and Running SQL scripts

1. Log out from user OMLUSER2 and log in as OMLUSER1.

2. The **Run SQL Statement** link on the home page allows you to run a single
    query in a paragraph. To be able to run scripts you can use the **Create a
    SQL Script** link on the home page.

    ![](media/790660df07633ab99dd8e7564f1cb035.png)
                       <p align="center">Figure 7-1</p>

3. A new SQL scratchpad will be created with the **%script** identifier already
    selected, this identifier allows you to run multiple SQL statements.

    ![](media/42f55993f4e76ef7608e17616ceed5ac.png)
                           <p align="center">Figure 7-2</p>

4. Next, we are going to use a script shows how to use the SQL pattern matching
    MATCH_RECOGNIZE feature for sessionization analysis based on JSON web log
    files.

5. [Download](https://www.dropbox.com/s/wjzixmv2xzihg1i/oml_sql2.sql?dl=0) the
    OML Script, open the script in your favorite editor and **Copy** the
    contents.

6. Paste the script to the **%script** paragraph:

    ![](media/783b4c6da518d4994e5c40e6e4495278.png)
                           <p align="center">Figure 7-3</p>

7. You can then run the script/paragraph and the output will appear below the
    code that makes up the script.

    ![](media/0663fa174c7a781626c9953d45b5a4a0.png)
                           <p align="center">Figure 7-4</p>
-   The result should look something like this:

    ![](media/6aefdec154d0014ec221bb6c0f6875b0.png)
                           <p align="center">Figure 7-5</p>

**You have successfully completed the Oracle Machine Learning Lab.**

***END OF LAB***

[Back to Top](#table-of-contents)  