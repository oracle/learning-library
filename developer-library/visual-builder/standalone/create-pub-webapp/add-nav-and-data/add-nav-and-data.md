# Add Navigation and Data to Your Web App

## Introduction

This lab shows you how to create navigation buttons in a web application, and how to add data to your application.

Estimated Lab Time: 10 minutes

### Background

In Oracle Visual Builder, you can create buttons for a web page, then specify the actions that are performed when you click the buttons. An *action chain* is a sequence of actions. You can use and customize predefined actions or define your own. Here, you'll create buttons that navigate between the Departments page and the Employees page in your application.

You can also populate your business objects by importing data from a file. You did this for the Location business object in the first tutorial, and you'll do the same for the Department and Employee business objects here.

## **STEP 1**: Create an Action Chain to Navigate from the Departments Page to the Employees Page

1.  In the HR Application, click the **Web Applications** ![Web Applications icon](./images/vbcsnd_webapp_icon.png) tab in the Navigator, and click **main-departments** under the **Flows** and **main** nodes. If necessary, click the **Page Designer** tab.
2.  If necessary, click **Components** in the Page Designer to open the Components palette. Then, drag a **Button** from the **Common** components to the **Toolbar**, to the right of the **Create** button.

    ![](./images/vbcsnd_cse_s2.png)

3.  Click **Properties**, then in the **General** tab of the button's Property Inspector, change the **Text** field to `Display Employees`.
4.  Click the **Events** tab for the button, then click the **\+ New Event** button. From the menu, select **Quick Start: 'ojAction'**, the default action for a button click.

    ![](./images/vbcsnd_cse_s4.png)

    An action chain with the ID **ButtonActionChain** is created. It contains only the **Start** action.

5.  Drag the **Navigate** action from the **Navigation** section of the Actions palette to the **+** sign pointed to by the **Start** action.
6.  In the **Navigate** Property Inspector, select **main-employees** from the **Target** drop-down list.

    ![](./images/vbcsnd_cse_s6.png)

    The action now has the label `Navigate main-employees`.

7.  Click **Preview** ![Preview icon](./images/vbcsnd_run_icon.png) in the header to test the pages and navigation. The application opens in another browser tab. Click **Create** and add another department (`IT` on `Floor 2`, for example), then click **Save**. A success message is displayed briefly.
8.  Click **Display Employees Page**, then click **Create**. Add another employee, specifying the new department, and click **Save**. You'll notice there's no way to get back to the main-departments page from the main-employees page. Close the browser tab.

## **STEP 2**: Create an Action Chain to Navigate from the Employees Page to the Departments Page

1.  In the Web Apps pane of the Navigator, click **main-employees** under the **Flows** and **main** nodes. If necessary, click **Reload page** ![Reload page icon](./images/vbcsnd_refresh_icon.png) to display the new employee you created.
2.  In the Components palette, locate the **Common** components and drag a **Button** component into the **Toolbar**, to the right of the **Create** button.
3.  In the Property Inspector, change the **Text** field to `Display Departments`.
4.  Click the **Events** tab for the button, then click the **+ New Event** button and select **Quick Start: 'ojAction'**.

    Another empty action chain with the ID **ButtonActionChain** is created. Because this action chain is for a different page, it doesn't matter that it has the same name as the one for the main-departments page.

5.  Move the **Navigate** action from the **Navigation** section of the Actions palette to the **+** sign pointed to by the **Start** action.
6.  In the **Navigate** Property Inspector, select **main-departments** from the **Target** drop-down list.

    The action now has the label `Navigate main-departments`.

7.  Click **Preview** ![Preview icon](./images/vbcsnd_run_icon.png) to test the pages and navigation. The application opens in another browser tab. Make sure you can get to the main-departments page from the main-employees page. Close the browser tab.
8.  Click **main**, and then click the **Page Flow** tab to view the modified page flow for the web application. You can now navigate between the main-departments and main-employees pages.

    ![](./images/vbcsnd_cpc_s9.png)


## **STEP 3**: Import Data for the Business Objects

Instead of using the Data Manager to import data, this time you'll use each business object's **Data** tab to do the same thing.

1.  Click [this link](https://objectstorage.us-ashburn-1.oraclecloud.com/p/lhJcJDCHfpvqrjLICvPbQMojBuo2NshPYvF26nE7vLnsHfqs_UFGV1pt8gVM96DY/n/c4u03/b/solutions-library/o/Department.csv) and save the `Department.csv` file. The file contains six departments for the application.
2.  Click [this link](https://objectstorage.us-ashburn-1.oraclecloud.com/p/97_FG5dsJaRTB_FwNYUg_lHokXY4r2IgQgDhiDOARX62krgriYcsFcDL25q1NSbV/n/c4u03/b/solutions-library/o/Employee.csv) and save the `Employee.csv` file. The file contains nine employees for the application.
3.  In the Navigator, click the **Business Objects** ![Business Objects icon](./images/vbcsnd_bo_icon.png) tab, then click the **Objects** tab.
4.  Click **Department**, then click the **Data** tab. The business objects you created are displayed.
5.  Click **Import from File** ![Import from File icon](./images/vbcsnd_import_icon_transp.png).
6.  In the Import Data dialog box, select the **Replace** option for **Row Handling** if it's not already selected. Then click the upload box, browse, select the `Department.csv` file, and click **Import**.
7.  Click **Close** after the file has been successfully imported. Six departments are displayed in the table.

    ![](./images/vbcsnd_imp_s7.png)

8.  Click **Employee** under Business Objects, then click the **Data** tab.
9.  Click **Import from File** ![Import from File icon](./images/vbcsnd_import_icon_transp.png).
10.  In the Import Data dialog box, select the **Replace** option for **Row Handling** if it's not already selected. Then click the upload box, browse, select the `Employee.csv` file, and click **Import**.
11.  Click **Close** after the file has been successfully imported. Nine employees are displayed in the table.

    ![](./images/vbcsnd_imp_s11.png)

## Acknowledgements
* **Author** - Sheryl Manoharan, Visual Builder User Assistance
* **Last Updated By** - December 2020

## Need Help?
Submit feedback or ask for help using our [Visual Builder Support Forum](https://cloudcustomerconnect.oracle.com/resources/e610f4723c/summary). Click the **Log In** button and login using your Oracle Account. Click the **Post a new topic** button to start a new discussion, or search for an answer using keywords.  Please include your workshop name and lab name, and include screenshots and attach files if needed. Here's your chance to engage directly with the author of the workshop!

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
