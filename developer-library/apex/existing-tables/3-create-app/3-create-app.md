# Building your app - Using the Create Application Wizard

## Introduction
In this lab, you will learn how to create the initial app based on existing tables in your Oracle database. In practice, you will generally only start with one or two pages, and then use the Create Page Wizard to add additional pages to your app.

## **STEP 1** - Creating an App

1. In the App Builder menu, click **App Builder**.
2. Click **Create**.

    ![](images/go-create-app.png " ")

3. Click **New Application**.

    ![](images/new-app.png " ")

## **STEP 2** - Naming the App
1. In the Create Application wizard, for Name enter **Projects**.
2. Click **Appearance**.  

    ![](images/go-appearance.png " ")

3. On the Appearance dialog, for Theme Style select **Vita – Slate**.
4. Click **Choose New Icon**.

    ![](images/go-icon.png " ")

5. On the Choose Application icon dialog, select any icon color and an icon of your choosing.

    Click **Set Application Item**.

    ![](images/set-icon.png " ")

7. Click **Save Changes**.

    ![](images/save-appearance.png " ")

## **STEP 3** – Add the Dashboard Page

A dashboard page is a great way to show important information using various charts. When you created the Sample Dataset it also created a view **EBA\_PROJECTS\_V**, which joins data from various tables. This view is ideal as the basis for the dashboard charts.

1. In the Create Application wizard, click **Add Page**.
2. Click **Dashboard**.

    ![](images/add-dashboard.png " ")

3. For Chart 1, enter the following:
     - Chart Type – select **Bar**
     - Chart Name – enter **Budget versus Cost**
     - Table or View – select **EBA\_PROJECTS_V**
     - Label Column – select **NAME**
     - Value Column – select **BUDGET\_V_COST**

    ![](images/chart1.png " ")

4. Click **Chart 2**, and enter the following:
     - Chart Type – select **Pie**
     - Chart Name – enter **Project Status**
     - Table or View – select **EBA\_PROJECTS\_V**
     - Label Column – select **Status**
     - Type – select **Count**  

    ![](images/chart2.png " ")  

5. Click **Chart 3**, and enter the following:
     - Chart Type – select **Bar**
     - Chart Name – enter **Project Leads**
     - Table or View – select **EBA\_PROJECTS\_V**
     - Label Column – select **PROJECT\_LEAD**
     - Type – select **Count**

6. Click **Add Page**  

    ![](images/chart3.png " ")  

    *{Note: You have not set any values for _Chart 4_, therefore, it will be generated with a chart based on demo data. In a later lab we will remove the additional chart.}*

## **STEP 5** – Add the Project Page
Card pages are especially good when there is not a huge number of records, and you only want to display a few details. The **EBA_PROJECTS** table only has 12 records and would work well as a card page.

1. In the Create Application wizard, click **Add Page**.
2. Click **Cards**.

    ![](images/go-cards.png " ")

3. On the Add Cards Page, enter the following:
     - Page Name - enter **Projects**
     - Table - select **EBA_PROJECTS**
     - Card Title - select **NAME**
     - Description - select **Description**
     - Additional Text - select **PROJECT_LEAD**

4. Click **Add Page**

    ![](images/set-cards.png " ")

## **STEP 6** - Add the Milestone Pages
There are 30 records within **EBA\_MILESTONES**, therefore, you will add a report page and an associated form page.

1. In the Create Application wizard, click **Add Page**.
2. Click **Interactive Report**.

    ![](images/go-ir.png " ")

3. On the Add Report Page, enter the following:
      - Page Name - enter **Milestones**
      - Table - select **EBA\_PROJECT\_MILESTONES**
      - Check **Include Form**

  Expand Lookup Columns:
      - Lookup Key 1 - select **PROJECT_ID**
      - Display Col 1 - select **EBA_PROJECTS.NAME**

4. Click **Add Page**  

    ![](images/set-milestones.png " ")

## **STEP 7** - Add the Task Pages
The **EBA\_PROJECT\_TASKS** table is the primary table, where records will be reviewed and updated the most. Therefore, you will add a Faceted Search page, Report and Form pages, and a Calendar page on this table.

1. In the Create Application wizard, click **Add Page**.
2. Click **Faceted Search**.

    ![](images/go-faceted.png " ")

3. On the Add Faceted Search Page, enter the following:
    - Page Name - enter **Tasks Search**
    - Table - select **EBA\_PROJECT\_TASKS**

4. Click **Add Page**  

    ![](images/set-faceted.png " ")

5. It would be better to place the **Tasks Search** page up under the **Dashboard** page.

    For **Tasks Search**  click and hold the hamburger (four parallel bars), after the Edit button.     
    Drag the page up until it displays between the **Dashboard** page and the **Projects** page.    
    Release the mouse.

    ![](images/move-faceted.png " ")

6. Now to add the Report and Form pages.    
    In the Create Application wizard, click **Add Page**.
7. Click **Interactive Report**.
8. On the Add Report Page, enter the following:
      - Page Name - enter **Tasks**
      - Table - select **EBA\_PROJECT\_TASKS**
      - Check **Include Form**

   Expand Lookup Columns
      - Lookup Key 1 - select **PROJECT\_ID**
      - Display Col 1 - select **EBA\_PROJECTS.NAME**
      - Lookup Key 2 - select **MILESTONE\_ID**
      - Display Col 2 - select **EBA\_PROJECT\_MILESTONES.NAME**

9. Click **Add Page**  

    ![](images/set-tasks.png " ")

8. Last we will add a Calendar.  
    In the Create Application wizard, click **Add Page**
9. Click **Calendar**.
10. On the Add Calendar Page, enter the following:
      - Page Name - enter **Tasks Calendar**
      - Table - select **EBA_PROJECT_TASKS**
      - Display Column - select **NAME**
      - Start Date Column - select **START_DATE**
      - End Date Column - select **END_DATE**

11. Click **Add Page**  

    ![](images/set-calendar.png " ")

*{Note: If you go to SQL Workshop > Object Browser, select the _EBA_PROJECT\_TASKS_ table and then click _Create App_ then it will create an app with a Dashboard page, Faceted Search page, Report and Form pages, and a Calendar page (if appropriate) all based on the selected table. This technique provides a great starting point for creating your apps, especially if you are not sure what pages you want up front.}*

![](images/object-browser-create-app.png " ")

## **STEP 8** – Generate the App

Now that you have added all the pages, it is time to generate the app and review it.

1. Scroll to the bottom of the page, and click **Create Application**.

    ![](images/create-app.png " ")

2. Once the application has been generated, your new app will be displayed in the application home page.

    Click **Run Application**.

    ![](images/run-app.png " ")

## **STEP 9** – Runtime App

1. Enter your user credentials. Click **Sign In**.

    ![](images/enter-credentials.png " ")

2. Play around with your new application!

    ![](images/runtime-app.png " ")

## **Summary**

This completes Lab 2. You now know how to create an application, with numerous different page types, based on existing database objects. [Click here to navigate to Lab 3](?lab=lab-3-regenerating-app)

## **Acknowledgements**

 - **Author** -  David Peake, Consulting Member of Technical Staff
 - **Contributors** - Arabella Yao, Product Manager Intern, Database Management
 - **Last Updated By/Date** - Tom McGinn, Database Innovations Architect, Product Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
