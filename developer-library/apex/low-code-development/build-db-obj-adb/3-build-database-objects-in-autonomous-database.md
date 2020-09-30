# Build Database Objects in Autonomous Database

## Introduction

Memorizing the SQL to create and maintain database objects can be difficult. However, there are tools that can generate the code for you based on a shorthand syntax or a graphical user interface. In this lab, you will create database objects using Quick SQL and then view the objects in SQL Developer Web. Then you will then use SQL Developer Web to create an additional table and view all the database objects as a data model.

Estimated Time: 45 minutes

### Objectives

- Create database objects using Quick SQL
- View database objects in SQL Developer Web
- View database objects as a data model
- Create a new table and add it to the data model

### Problem Definition
Within most organizations, the use of spreadsheets is prolific. Spreadsheets are excellent for doing simple data review and tracking personal data. However, they are ill suited to gathering data among team members.

A common use case is when a manager needs to track different projects his team is working on. The manager built a spreadsheet with the critical data elements. However, now that the team is growing, trying to manage the spreadsheet updates is becoming unmanageable, and it is near impossible to get a single source of truth.

Below is an excerpt from the spreadsheet the manager has been sending out to the team:

![](images/spreadsheet.png " ")

### Napkin Design - Improved data model for Projects
Rather than creating a single Project Tasks table based on the spreadsheet, as you did in the previous lab, you can define a collection of data structures to better model the relationships, and collect additional information that would be valuable.

Below is a napkin design for collecting project information:

![](images/napkin.png " ")

You should notice that the new model allows the assignment of Team Members to Projects, as well as optionally to Tasks, and To Dos. The concept of a Project having Milestones has been introduced, however, it is optional that Tasks are associated with a Milestone. Further, To Dos and Links have been added to Tasks.

## **Step 1:** Create database objects using Quick SQL

1. Return to your APEX Workspace and click the down arrow in the **SQL Workshop** tab, then select **SQL Scripts**.

   ![](images/navigate-to-sql-scripts.png " ")

2. Quick SQL is a tool for creating database objects and data using a SQL shorthand syntax.

    In the SQL Scripts toolbar, click **Quick SQL**.

   ![](images/sql-scripts-quick-sql.png " ")

3. Copy the following SQL shorthand code and paste it into the left pane in Quick SQL.

    ```
    <copy>team_members /insert 10
      username /nn /upper
      full name
      email /nn
      phone_number
      profile
      photo file
    projects /insert 20
      name /nn
      project_lead /nn /references team_members
      budget num
      status vc30 /nn /check ASSIGNED, IN-PROGRESS, COMPLETED
      completed_date
      description
      milestones /insert 30
        name /nn
        due_date /nn
        description
      tasks /insert 100
        name /nn
        assignee /nn /references team_members
        milestone_id /references milestones
        start_date /nn
        end_date
        cost num
        description
        is_complete_yn /check Y, N
    view project_tasks projects tasks</copy>
    ```

    *Note: This shorthand does not include the To DOs and Links tables from the napkin design. You will add the To Dos table using SQL Developer Web later in this lab.*

4. Review the shorthand code. How many tables will be created and how are they related? What types of columns and constraints will be created for the tables? Note that the **Help** button provides details on the shorthand syntax along with several examples of its usage.

    When ready, in the Quick SQL (left pane) toolbar, click **Generate SQL**.

   ![](images/generate-sql.png " ")

5. Review the SQL that is generated in the right-hand pane, then click **Settings** to make some changes to the resulting code.

   ![](images/sql-settings.png " ")

6. Change the following settings and click **Save Changes**.

   | Property | Value |
   | --- | --- |
   | Object Prefix | **HOL** |
   | On Delete | **Restrict** |
   | Primary Keys | **12c Identity Data Types** |
   | Date Data Type | **TIMESTAMP WITH LOCAL TIME ZONE** |
   | Include | Select **Audit Columns** & **Row Version Number** |

   ![](images/settings-1.png " ")
   ![](images/settings-2.png " ")

   After clicking **Save Changes** the SQL will be regenerated taking the new settings into account.

7. It is important to save the SQL Shorthand as a script so that it can be run in your database.

    In the SQL (right pane) toolbar, click **Save SQL Script**.     
    In the Save Script dialog, for Script Name enter **HOL**, and click **Save Script**.

    ![](images/script-name.png " ")

9. Now that you saved the script you can run it to create the specified database objects.

    In the SQL (right pane) toolbar, click **Review and Run**.

    ![](images/review-and-run.png " ")

10. In the Script Editor page toolbar, click **Run**.

    ![](images/run.png " ")

11. On the Run Script page, click **Run Now**.

    ![](images/run-now.png " ")

12. The Results page shows the results of running the script. Scroll to the bottom to see a summary. You should not see any errors.

    ![](images/results.png " ")

13. To view the database objects that were created, click the arrow in the **SQL Workshop** tab and then select **Object Browser**.

    ![](images/navigate-to-object-browser.png " ")

14. Select the **HOL_PROJECTS** table and review its columns.

    ![](images/hol-projects.png " ")

15. Click the **Data** tab to see the data that was loaded.

    ![](images/hol-projects-data.png " ")

## **Step 2:** View database objects in SQL Developer Web

In this step, you will learn how to access SQL Developer Web and then use it to review the current database objects and make some modifications to the data model.

1. Switch to the ATP Console in your browser. It should still be displaying the **Tools** tab.

    Within the Tools tab, click **Open SQL Developer Web**.

   ![](images/navigate-to-sql-dev-web.png " ")

2. On the SQL Developer Web log-in page, for Username enter **admin** and for Password enter **`SecretPassw0rd`**, and then click **Sign In**.

   ![](images/login-as-admin.png " ")

3. You created your database objects in the DEMO schema so you will need to enable SQL Developer Web access for that schema. Close the help popup, then copy and paste the following code into the Worksheet.

    ```
    <copy>begin    
      ords_admin.enable_schema(
        p_enabled => true,
        p_schema => 'DEMO', -- Actual name of the schema
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'demo', -- Alias used in the URL for access
        p_auto_rest_auth => true
      );

      commit;

    end;</copy>
    ```

4. In the Worksheet toolbar, click **Run Script** to execute the code in the Worksheet. When the script finishes executing, you should see a success message under the **Script Output** tab at the bottom.

   ![](images/enable-schema.png " ")

5. In the browser address bar, change the URL by replacing `admin` with `demo` (the value passed to the p\_url\_mapping\_pattern parameter in the script above). Then press enter to go to the new URL.

   ![](images/url-before.png " ")

6. In the SQL Developer log-in page, set Username to **demo** and Password to **`SecretPassw0rd`**, then click **Sign In**.

   ![](images/url-after.png " ")

7. The Worksheet tab is displayed by default. Close the help popup and look under the **Navigator** tab to see the tables you created previously.

   ![](images/worksheet-tab.png " ")

8. Expand the **HOL_PROJECTS** table to see the columns.

   ![](images/hol-projects-columns.png " ")

9. In the Worksheet (right pane), cut and paste the following SQL query:

    ```
    <copy>select * from hol_projects;</copy>
    ```

    In the Worksheet toolbar, click **Run Script** to see the data in the table.
   The data should be displayed in the Script Output tab at the bottom.
   *Note: The table you see may contain different values.*

   ![](images/query-results.png " ")

## **Step 3:** View database objects as a data model

In this step, you will learn how to create an Entity Relationship Diagram (ERD) using SQL Developer Web.

1. Click the **Data Modeler** tab and dismiss the Help popup.

2. Drag the **HOL_MILESTONES** table from the Navigator tab on the left to the diagram in the middle of the window. You may need to adjust your browser to accommodate the ERD.

   ![](images/drop-hol-milestones.png " ")

3. Drag the other three **HOL_** tables to the right. Use the diagram controls to adjust the zoom level and layout of the objects. Note that the foreign keys are detected and drawn on the diagram.

   ![](images/drop-remaining-tables.png " ")

4. Click the **HOL_PROJECTS** table in the diagram. Note that the detail is displayed in the right navigator.

   ![](images/hol-projects-details.png " ")

## **Step 4:** Create a new table and add it to the data model

In this step, you will use SQL Developer Web to create a new table. Then you will learn how to edit an existing table and add it to the ERD created in the previous step.

In the original napkin design, there was a table called To Dos. However, the Quick SQL script (used in step 1) did not include this table. Below you will recreate the TO Dos table with a relationship to Team Members, and Tasks.

1. In the Navigator (left pane), click the **...** button and select **Create Object**.

   ![](images/create-new-table.png " ")

2. In the Table Properties dialog, enter **HOL_TODOS** in the Name field. and click "**+**" to create a new column.

   ![](images/table-properties.png " ")

3. Select the new column **NEW\_COLUMN_1** and select the checkbox for **PK** to make it the primary key for this new table. Click in the Name field and enter **ID**. Click in the Data Type and select **NUMBER** from the drop down list.

   ![](images/new-column-1.png " ")

4. Press "**+**" to add three additional columns to the table with the following properties:

    | # | Name | Data Type |
    | --- | --- | --- |
    | 1 | **NAME** | **VARCHAR2(50)** <br />*(just change the number 20 to 50)* |
    | 2 | **STATUS** | **VARCHAR2(20)** |
    | 3 | **DUE_DATE** | **TIMESTAMP WITH LOCAL TIME ZONE** <br />*(just type the full data type name)* |

    Click **Create**.

    ![](images/additional-new-columns.png " ")

5. This will generate a SQL script and run it to create the table.      
    When ready, click **Close**.

   ![](images/new-table-ddl.png " ")

6. In the Navigator, click the Refresh icon to see the new **HOL_TODOS** table.

    Right-click on the **HOL_TODOS** table and select **Edit...**.

    ![](images/edit-hol-todos.png " ")

7. Add a new column.        
    Set Name to **TEAM\_MEMBER\_ID** and Data Type to **NUMBER**, then click **Apply**.

   ![](images/add-column-to-hol-todos.png " ")

   You should see the following output which indicates the new column was added successfully.

   ![](images/add-team-member-id-results.png " ")

8. Click the **Foreign Key** option on the left side of the dialog, then click "**+**" to create a new foreign key.

    Select the new foreign key and configure it with the following settings:

    | Property | Value |
    | --- | --- |
    | Name | **TODOS\_TEAM\_MEMBERS_FK** |
    | Table | **HOL\_TEAM_MEMBERS** |
    | Constraint | **HOL\_TEAM_MEMBERS\_ID\_PK** |
    | Local Column | **TEAM\_MEMBER_ID** |

    *Note: If when selecting the Local Column, you see NEW\_COLUMN\_5 instead of TEAM\_MEMBER\_ID then close the dialog, refresh the Navigator and then edit the table again.*

    Click **Apply**.

    ![](images/hol-todos-new-fk.png " ")

    You should see the following output which indicates the new foreign key was added successfully.

    ![](images/hol-todos-new-fk-results.png " ")

    Click **Close** to dismiss the dialog.

9. Repeat the steps above to create a new column to link to the Tasks table.

    Right-click on the **HOL_TODOS** table and select **Edit...**.

    Click "**+**" to create a new column.
    Set Name to **TASK_ID** and Data Type to **NUMBER**, then click **Apply**.

    ![](images/add-task-id.png " ")

10. Click the **Foreign Key** option on the left side of the dialog, then click "**+**" to create a new foreign key.

    Select the new foreign key and configure it with the following settings:

    | Property | Value |
    | --- | --- |
    | Name | **TODOS\_TASKS\_FK** |
    | Table | **HOL\_TASKS** |
    | Constraint | **HOL\_TASKS\_ID\_PK** |
    | Local Column | **TASK_ID** |

    *Note: If when selecting the Local Column, you see _NEW\_COLUMN\_6_ instead of _TASK\_ID_ then close the dialog, refresh the Navigator and then edit the table again.*

    Click **Apply**.

    ![](images/add-tasks-fk.png " ")

    You should see the following output which indicates the new foreign key was added successfully.

    ![](images/add-tasks-fk-results.png " ")

    Click **Close** to dismiss the dialog.

11. Drag the new **HOL\_TODOS** table from the Navigator to the diagram. Notice that the new foreign keys are displayed from **HOL\_TODOS** to **HOL\_TEAM\_MEMBERS** and **HOL\_TASKS**.

    Rearrange the diagram to clearly display the tables and their foreign key relationships.

    ![](images/final-erd.png " ")

## Summary

This completes this workshop. At this point you know how to use Quick SQL to generate database objects using a SQL shorthand. You also know how to use SQL Developer Web to maintain database objects and generate ERDs. Click on ***Lab 3: Create and Modify an APEX Application*** to create a new APEX application that will utilize the database objects you created.

## Acknowledgements
* **Author** - Salim Hlayel, Principle Product Manager
* **Contributors** - Oracle LiveLabs QA Team (Jaden McElvey, Technical Lead, Kamryn Vinson, QA Intern, Arabella Yao, Product Manager Intern, DB Product Management)
- **Last Updated By/Date** - Tom McGinn, Database Innovations Architect, Product Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
