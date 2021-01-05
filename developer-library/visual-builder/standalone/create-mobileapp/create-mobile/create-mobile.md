# Create a Mobile Application in Oracle Visual Builder

## Introduction

This tutorial shows you how to create a basic mobile application in Oracle Visual Builder and populate it with data from a business object.
### Estimated Lab Time:  10 minutes

### Background

Oracle Visual Builder is a development tool for creating web and mobile applications that lets you create an application by dragging and dropping components onto a page. It also allows you to manipulate the application and your business objects through the underlying source code, to create types and variables, to access REST endpoints, and to create action chains.

You’ll create a business object and a mobile application that you'll later use to display, edit, and delete data about departments. You’ll also create build configurations that enable Oracle Visual Builder to build mobile applications for Android and iOS.

![](./images/vbmca_dbdiagram.png)

## **STEP 1:** Create a Mobile Application

1.  In the web browser, sign in to Oracle Visual Builder.

-   If you have no current applications, the landing page appears. Click **\+ New  Application.**
-   If you have one or more current applications, the Visual Applications page appears. Click **New.**

3.  In the Create Application dialog box, enter `HR Application` in the **Application Name** field and `Tutorial application` in the **Description** field. 

    The **Application ID** text field is automatically populated based on the value that you enter in the **Application Name** field.

4.  Make sure the **Empty Application** template is selected in the Application template list, and click **Finish**.

    The new application opens in the Welcome screen. The `DEV` and `1.0` tags next to the application name indicate the status (development) and the version.

    ![](./images/vbmca_cra_04.png)

5.  Click **Mobile Apps** and click **\+ Mobile Application** in the Mobile Apps tab that opens.
6.  In the General Information screen of the Create Mobile Application wizard, enter `hrmobileapp` in the **Application Name** field, select **None** as the navigation style, and click **Next.**

    ![](./images/vbmca_cra_05.png)

7.  In the Page Template – main page of the Create Mobile Application wizard, select **Custom** and click **Create**.

    Oracle Visual Builder creates the mobile application and opens the main-start page in the Page Designer.

8.  Click **Page Title**, then click the **Properties** tab and enter `Departments` as the page title in the Mobile Page Template's Property Inspector.

    ![](./images/vbmca_cra_07.png)


## **STEP 2**: Create a Department Business Object

1.  Click the **Business Objects** ![](./images/vbmca_bo_icon.png) tab.
2.  Click **\+ Business Object**.
3.  In the New Business Object window, enter `Department` in the **Label** field and click **Create**.

    The **Name** field is automatically populated based on the value that you enter in the **Label** field. When you create a business object label, use the singular form of the name.

    ![](./images/vbmca_cdb_03.png)

4.  Click the **Fields** tab, then click **\+ Field.**

    ![](./images/vbmca_cdb_04.png)

5.  In the New Field window, enter `Name` in the **Label** field, and click **Create Field**.

    The **name** value is automatically populated in the **Field Name** field, and **String** ![](./images/vbmca_textfield_icon.png) is selected by default in the **Type** field.

    ![](./images/vbmca_cdb_05.png)

6.  In the Property Inspector for the **Name** field, select the **Required** check box under **Constraints.**

    ![](./images/vbmca_cdb_06.png)

7.  Click **\+ Field** again. In the New Field window, enter `Location` in the **Label** field, and click **Create Field**.

    The **location** value is automatically populated in the **Field Name** field, and **String** ![](./images/vbmca_textfield_icon.png) is selected by default in the **Type** field.

8.  Click the **Endpoints** tab and view the REST endpoints created for the Department business object.

    ![](./images/vbmca_cde_s9.png)

## Acknowledgements
**Author** - Sheryl Manoharan

**Last Updated** - December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
