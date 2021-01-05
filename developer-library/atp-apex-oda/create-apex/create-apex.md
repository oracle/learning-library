# Create Application and REST API

![APEX](./images/apex.png)

## Introduction

As part of **Autonomous Database** you have **Oracle Application Express (APEX)** available.

APEX is a low-code development platform that enables you to build scalable, secure enterprise apps, with world-class features, that can be deployed anywhere.

Using APEX, developers can quickly develop and deploy compelling apps that solve real problems and provide immediate value. You won't need to be an expert in a vast array of technologies to deliver sophisticated solutions. Focus on solving the problem and let APEX take care of the rest.

Each Autonomous Database instance includes **Oracle REST Data Services (ORDS)** and **Simple Object Data Access (SODA)** that provides HTTPS interfaces for working with the contents of your Oracle Database in REST enabled schemas.

![ORDS](./images/ords.png)

In this workshop you will create a `tasks` table, REST enabling it, and make the service available for the Custom Component. Normally, you would REST enable database objects in a remote database schema, and then utilize those REST endpoints to define Web Source modules in an application, where APEX is installed, within the local database, as outlined below.

![ORDS and APEX](./images/rest_arch.png)

Estimated Lab Time: 15 minutes

## **STEP 1**: Create APEX Workspace

In this part of the workshop we are creating an APEX workspace. From the Autonomous Database Home page go to **Tools** section and select **Oracle Application Express** area.

![ORDS](./images/apex_workspace1.png)

This will open a new browser tab for Application Express Administration.
Login as the Admin user, with the **Admin** password you specified at Autonomous Database creation time.

![ORDS](./images/apex_workspace2.png)

1. Create the workshop Workspace on the Welcome to "Oracle Application Express" page, select **Create Workspace**.

    ![ORDS](./images/apex_workspace3.png)

    Use the following information to fill out the form:

    - **Database User**: ATP&#95;ODA
    - **Password**: Any password that meets the Oracle Cloud requirements.
    - **Workspace Name**: ATP&#95;ODA

2. Select **Create Workspace**.

    ![ORDS](./images/apex_workspace4.png)

    You will be returned to the Oracle APEX administration page, and a message will be displayed "**Workspace Created**".

3. Sign in as the **ATP&#95;ODA** user by selecting the icon on the centre of the screen where you can see the name of the user, **ATP&#95;ODA**.

    ![ORDS](./images/apex_workspace5.png)

4. Add the **name of the workspace**, **user name** and **password**: **ATP&#95;ODA** and click **Sign in**.

    ![ORDS](./images/apex_workspace7.png)

    Now we are ready to create your APEX application on this workspace.

    You can check that you are correctly signed in with the **ATP&#95;ODA** user in the right top corner.

    ![ORDS](./images/apex_workspace8.png)

## **STEP 2**: Create a Table with Quick SQL

Quick SQL reduces the time and effort required to create SQL tables, triggers, and index structures.

It is not designed to be a replacement for data modeling. Quick SQL is simply a quick way to develop a script for simple tables and views.

Once the SQL is generated it can be tweaked and expanded upon.

Quick SQL provides a quick way to generate the SQL required to create a relational data model from an indented text document.

Use Cases:

- Quickly create robust data models
- Easily generate random data
- Learn SQL create table, select, insert, index, trigger, PL/SQL package, and view syntax using provided examples

1. Go to Quick SQL.

    ![Quick SQL](./images/apex_quick_sql_menu.png)

2. Write on the left panel the following table definition:

    ```bash
    tasks
        text
    ```
    
3. Click **Generate SQL**.

    ![Generate SQL](./images/apex_generate_sql.png)

4. Click **Save SQL Script**.

    ![Save SQL Script](./images/apex_save_sql_script.png)

5. Set the name of the script to `tasks` and confirm **Save Script**.

    ![Save SQL Script Confirm](./images/apex_save_sql_script_confirm.png)

6. Click **Review and Run**.

    ![Save SQL Script](./images/apex_quick_sql_review.png)

7. Click **Run**.

    ![Save SQL Script](./images/apex_quick_sql_run.png)

8. Click **Run Now**.

    ![Save SQL Script](./images/apex_quick_sql_run_now.png)

    Make sure all statements are successfully run and there are no errors.

    ![Save SQL Script](./images/apex_quick_sql_run_success.png)

## **STEP 3**: Insert rows in the table

We are going to mock some data to use it later with your Custom Component.

1. Go to the Top Menu on **SQL Workshop**, click **Object Browser**.

    ![](./images/apex_object_browser_menu.png)

2. Select **TASKS** table on the left and click the tab **Data**, then click **Insert Row**:

    ![Object Browser Data](./images/apex_object_data.png)

3. Leave `Id` empty and fill the field `Text` with a task description you like.

    When you are happy with your new task, click **Create and Create Another** and do the same with another task.

    To follow the same example we have created:

    ```
    Get concert tickets
    ```

    ![Object Browser Data](./images/apex_object_insert_row_1.png)

1. Do the same with the second task entry.

    To follow the same example we have created:

    ```
    Buy bread
    ```

    ![Object Browser Data](./images/apex_object_insert_row_2.png)

5. Finally, click **Create** and check the two rows are as expected:

    ![Object Browser Data](./images/apex_object_new_rows.png)

## **STEP 4**: REST Enabling the Database Object

In the main menu, select **SQL Workshop**, click **RESTful Services**.

![REST Enable Menu](./images/apex_rest_services_menu.png)

1. Register your APEX schema with ORDS so we can offer a REST API of our tables, click **Register Schema with ORDS**:

    ![REST Enable Register](./images/apex_rest_enable_register.png)

1. Set the **Schema Alias** name to `tasks` and click **Save Schema Attributes** to confirm:

    ![REST Enable Save](./images/apex_rest_enable_save2.png)

    You will see that the Schema is now enabled.

    ![REST Enable Success](./images/apex_rest_enable_register_success.png)

    We need to create a Module with the base path for your API, a Template and a Handler to resolve the request of a specific method (GET, PUT, DELETE, etc).

3. Select **Modules** on the left and click **Create Module**:

    ![](./images/apex_rest_module.png)

4. Fill **Module Name** and **Base Path** fields with the following data and click **Create Module**:

     - **Module Name**: `com.example.oda`
     - **Base Path**: `/oda/`

    ![](./images/apex_rest_module_create.png)

5. Confirm the module has been created.

    ![](./images/apex_rest_module_create_success.png)

6. Scroll down and click **Create Template**:

    ![](./images/apex_rest_module_create_template.png)

1. Fill **URI Template** with `tasks/` and click **Create Template**:

    ![](./images/apex_rest_template_create.png)

8. Confirm the Template has been created and click **Create Handler**:

    ![](./images/apex_rest_handler_create.png)

9. Make sure the fields for the Handler are as follows:

    - **Method**: `GET`
    - **Source Type**: `Collection Query`
    - **Format**: `JSON`

    ![](./images/apex_rest_handler_create_get.png)

10. On the **Source** area we are going to run the SQL select to fetch the data form the schema:

    ```sql
    select * from tasks
    ```

    > NOTE: please, don't use "`;`" at the end of the SQL statement.

    ![](./images/apex_rest_handler_source_query.png)

11. Click **Create Handler** to save the changes on the GET handler:

    ![](./images/apex_rest_handler_create_confirm.png)

12. Confirm the Handler has been created and copy the **Full URL**:

    ![](./images/apex_rest_handler_create_success.png)


## It works

We will use the full URL for testing on the browser to verify the GET Handler works. Go to your favorite browser and paste the URL you copied.

If you use **Google Chrome** you will see the image like that:

![](./images/apex_rest_browser_test1.png)

If you use **Mozilla Firefox** you will see the image like that:

![](./images/apex_rest_browser_test0.png)

If you have a **browser extension to visualize JSON** you will see the information like this:

![](./images/apex_rest_browser_test.png)

You should see the items with `id` and `text` and other fields and references in JSON format.

How many items do you see? You should have as many tasks as you created before in the table.

*Congratulations! You are ready to go to the next workshop!*

## **Acknowledgements**

- **Author** - Victor Martin - Principal Cloud Engineer | Priscila Iruela - Database Business Development
- **Contributors** - Melanie Ashworth-March
- **Last Updated By/Date** - Kamryn Vinson, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.