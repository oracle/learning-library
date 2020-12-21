# Regenerating the App

## Introduction
In the runtime environment, if you navigate to Milestones, and then from the report page, click the edit icon, the form page for maintaining milestones will be displayed. You will notice that there are only a few fields. Therefore, it may be better to utilize an Interactive Grid, which is similar to a spreadsheet, where several records can be maintained directly within the grid.

![](images/milestone-form.png " ")

*Note: See how to go to your runtime environment from the previous lab.*

## **STEP 1** - Delete Generated App
Given you are going to regenerate the app from the Create Application Wizard, it is best to delete the app you just generated to avoid confusion.

1. In the runtime environment, within the develop toolbar, click **Application xxxxx**.  

    ![](images/dev-toolbar.png " ")  

    *Note: The Developer Toolbar is only shown to developers who run the application from the App Builder. End users will never be shown the Developer Toolbar*

2. From the App Home Page, under Tasks, click **Delete this Application**.  

    ![](images/delete-app.png " ")  

3. On the Confirm Delete page, click **Permanently Delete Now**.

## **STEP 2** - Reload the Projects App
The Create Application Wizard includes the ability to reload apps that you previously generated, making it easy to make some changes and generate a new and improved version of the initial app.

1. From the App Builder Home Page, click **Create**.

    ![](images/create-app.png " ")

2. Click **New Application**.

3. Click **Load Blueprint**.    
    On Load Blueprint, for the latest app generated, click **Load**.  

    ![](images/load-blueprint.png " ")  

    The previously defined app blueprint will be displayed.

## **STEP 3** - Replacing the Milestone Pages
Rather than having two ways to maintain milestone records, you will delete the original report and form pages, and then add a new page, and reposition it in the list of pages.

1. In the list of pages, for Milestones, click **Edit**.
2. Click **Delete**.  

    ![](images/delete-old-page.png " ")

3. In the Create Application Wizard, click **Add Page**.
4. Click **Interactive Grid**.
5. On the Add Interactive Grid Page, enter the following:
    - Page Name - enter **Milestones**
    - Table or View - select **EBA\_PROJECT\_MILESTONES**

    - Click **Add Page**  

    ![](images/set-milestones.png " ")

6. Now to reorder the new page.

    In the list of Pages, for the Milestones page, select the hamburger.    
    Drag the page up until it is under the Projects page and drop.

    ![](images/move-milestones.png " ")


## **STEP 4** - Add the Status Page
The **EBA\_PROJECT\_STATUS** table is used to maintain project statuses. This table should be maintainable; however, only application administrators should be able to modify records. As such, adding the Status page under Administration is the optimal solution.

1. In the Create Application Wizard, click **Add Page**.
2. Click **Interactive Grid**.
3. On the Add Interactive Grid Page, enter the following:
    - Page Name - enter **Statuses**
    - Table or View - select **EBA\_PROJECT\_STATUS**
    - Expand **Advanced**
        - Click **Set as Administration Page**

    - Click **Add Page**  

    ![](images/set-status.png " ")


## **STEP 5** - Completing the App
The Create Application Wizard also has the ability to add various features to your app, such as Access Control, Activity Reporting, Feedback, and more, to make your app more functionally complete and "production-ready".

1. In the Create Application Wizard, for Features, click **Check All**
2. Click **Create Application**

    ![](images/check-features.png " ")
    *Note: Your new application will generally have a new Application Id*

    Your new application will be displayed in the App Builder.

3. Click **Run Application**.
4. Enter your user credentials.
5. Navigate to **Milestones**.
6. Double-click in any column to see how you can enter data directly into the grid.

    ![](images/view-milestones.png " ")

    *Note: Project column will display a list of projects, Name and Description columns will be text areas, and Due Date column will be a date picker, based on the different data types.*

7. Click the navigation button at the top-left of the page, and navigate to **Administration** to review the capabilities provided.

    ![](images/view-admin.png " ")

## **Summary**

This completes Lab 3. You now know how to regenerate an application and add additional features. [Click here to navigate to Lab 4](?lab=lab-4-improving-dashboard)

## **Acknowledgements**

 - **Author** -  Salim Hlayel, Principle Product Manager
 - **Contributors** - Arabella Yao, Product Manager Intern, DB Product Management
 - **Last Updated By/Date** - Tom McGinn, Database Innovations Architect, Product Management, July 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
