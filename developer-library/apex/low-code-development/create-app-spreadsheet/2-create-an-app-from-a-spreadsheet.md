# Create an APEX App from a Spreadsheet

## Introduction

After you have logged into your workspace, you can start creating APEX applications. In this lab, you will build a simple application based on a spreadsheet. Keep in mind that APEX is great for a variety of apps, from simple ones like this to large, sophisticated apps based on local database objects, REST enabled SQL objects, and even REST APIs.

While APEX developers spend the majority of their time in the App Builder, you should also investigate the SQL Workshop, where you can create and maintain database objects, Team Development, where you can track large APEX development projects, and the App Gallery, which contains numerous productivity and sample apps that can be installed within minutes.

Estimated Time: 15 minutes

### Objectives

- Load project and tasks data
- Create and run an application

## **Step 1**: Loading project and tasks data  

1.  From your APEX workspace home page, click **App Builder**.
2.  Click **Create a New App**.

    ![](images/create-a-new-app.png " ")

3.  Click **From a File**.

    ![](images/from-a-file.png " ")

    When creating an application from a file, APEX allows you to upload CSV, XLSX, XML, or JSON files and then build apps based on their data. Alternatively, you can also copy and paste CSV data or load sample data.

4.  Within the Load Data wizard, click the **Copy and Paste** option at the top.

    ![](images/copy-paste.png " ")

5. Select **Project and Tasks** from the sample data set list and then click **Next**.

    ![](images/copy-paste-projects-tasks.png " ")

5.  Review the parsed data. Set Table Name to **PROJECT_TASKS** and click **Load Data**. Note that the Error Table Name defaults to the Table Name with a postfix of \_ERR$.

    ![](images/new-table-name.png " ")

    After clicking **Load Data** you will see a spinner until the wizard finishes loading the data.

## **Step 2**: Creating an application

The Data Load wizard has created a new table and populated that table with the records from the sample data. Now you can create an app based on this new table.

1.  In the Load Data dialog, verify that 73 rows have been loaded into the **PROJECT_TASKS** table, then click **View Table**.

    ![](images/continue-to-view-object.png " ")

[//]: # (click **Create Application**. )
[//]: # (images/continue-to-create-application-wizard.png " ")

[//]: # (Remove Steps 2 and 3)
2. In the Object Browser, review the table structure.   
    In the Table toolbar, click **Create App**.

    ![](images/object-browser.png " ")

3. On the Create an Application page, click **Create App**.

4. In the Create an Application page, review the pages listed. Click the **Edit** button for a page to review more details.

    Scroll down then click **Check All** for Features, and then click **Create Application**.

    ![](images/name-for-application.png " ")
    ![](images/create-application.png " ")

    When the wizard finishes creating the application, you will be redirected to the application's home page in the App Builder.

## **Step 3**: Running and exploring the new app

1.  Click **Run Application**. This will open the runtime application in a new browser tab, allowing you to see how end users will view the app.

    ![](images/run-application.png " ")

2.  Enter your user credentials and click **Sign In**.

    *Note: Use the same Username and Password you used to sign into the APEX Workspace. For this workshop your username should be DEMO and your password should be SecretPassw0rd.*

    ![](images/sign-in.png " ")

3.  Explore the application a little. Click **Dashboard** (in the home menu or the navigation menu) to view the charts created. Click **Project Tasks Search**, in the navigation menu, to play with the faceted search. Click **Project Tasks Report** to view an interactive report, then click the edit icon for a record to display the details in an editable "form" page. Next, navigate to the **Calendar** page and review the data displayed (*Note: You may need to scroll forward several months to see data*). Finally, review the options available under **Administration**.

    ![](images/new-app.png " ")

## Summary

This completes this lab. You now know how to create an application from a spreadsheet by either dragging and dropping a file or loading sample data for training purposes. Click on **Lab 3: Build Database Objects in Autonomous Database** to generate database objects using Quick SQL.

## Acknowledgements
* **Author** - David Peake, Senior Principal Product Manager, Oracle Application Express
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
- **Last Updated By/Date** - Tom McGinn, Database Innovations Architect, Product Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
