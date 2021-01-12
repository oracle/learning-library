# Create Pages for a Business Object in an Oracle Visual Builder Mobile Application

## Introduction

This tutorial shows you how to create pages to display data from the business object you created in the previous tutorial and to create new instances of the business object.

### Estimated Lab Time:  10 minutes

### Background

In Oracle Visual Builder, you create pages in your mobile application by dragging and dropping components. You can use Quick Starts to quickly create pages to display, create, edit, and delete data.


## **STEP 1**: Use the main-start Page to Display Departments

These steps assume that you are already logged in to Oracle Visual Builder and are viewing the HR Application you created in the previous tutorial.

1.  Click the **Mobile Applications** ![](images/vbcscp_mob_mob_icon.png "Mobile Applications icon") tab.
2.  Expand the **hrmobileapp**, **Flows**, and **main** nodes, then click **main-start**.

    ![](./images/vbcscp_mob_dd_s2.png)

    You're viewing the Page Designer, showing the Components palette. You can click the **Mobile Applications** tab to hide the Mobile Apps pane and create more room for the Page Designer. You may also want to widen your browser window.

3.  In the Components palette, scroll down to Collection and drag a **List View** component onto the Content Placeholder section in the page.
4.  In the Property Inspector, click **Add Data** to open the Add Data Quick Start.

    ![](./images/vbcscp_mob_dd_s4.png)

5.  On the Locate Data page of the Quick Start, select the **Department** business object, then click **Next**. (Depending on your Visual Builder instance, you may or may not see Process Objects.)

    ![](./images/vbcscp_mob_dd_s5.png)

6.  On the Select Template page, select the label - value pairs template, and click **Next**.

    ![](./images/vbcscp_mob_dd_s6.png)

7.  On the Bind Data page, under **item\[i\]**, select the **id**, **name**, and **location** items. The columns appear in the order selected; if you want to change the order, drag a **Handle** ![](./images/vbcscp_handle_icon.png) to reorder the columns as desired. Click ** Next**.

    ![](./images/vbcscp_mob_dd_s7.png)

8.  On the Define Query page, click **Finish**.  

    The empty list view component is displayed with a message that there are no items to display.


## **STEP 2**: Add a Create Page for the Department Business Object

A Create page allows you to create data instances.

1.  If necessary, click the **List View** component on the page, then click **Quick Start** to display the Quick Start menu again.
2.  Click **Add Create Page**.
3.  On the Select Endpoint page, select the **Department** business object if necessary, then click **Next**.

    ![](./images/vbcscp_mob_cpd_s3.png)

4.  On the Page Detail page, under Endpoint Structure, select the **location** check box. The **name** check box is already selected, because **name** is a required field. These are the only fields the user needs to specify.
5.  Change the value in the **Button label** field to `Create`. Leave the other values set to their defaults. Click **Finish**.

    ![](./images/vbcscp_mob_cpd_s5.png)

    A **+** button appears on the main-start page. Click the **Mobile Applications** tab to view the main-create-department page created in the **main** page flow. You may want to click the **Components** tab to close the components palette and make room for your view.

    ![](./images/vbcscp_mob_cpd_s5_result.png)

6.  Click the **main-create-department** page to open it in the Page Designer.
7.  In the Page Designer toolbar, click **Live** to make the form active.
8.  Enter `Administration` in the **Name** field, and enter `Floor 1` in the **Location** field. Click **Save**.

    ![](./images/vbcscp_mob_cpd_s8.png)

    Oracle Visual Builder places you in the **main** page flow of your application, where you can see that the main-start page points to the main-create-department page.

    ![](./images/vbcscp_mob_cpd_s8_result.png)

9.  Open the **main-start** page either by clicking the page name in the Navigator or by clicking the tab above the canvas area to see the List View component with the list view item you created. If you don't see it, click **Reload page** ![](images/vbcscp_mob_reload_icon.png).

    ![](./images/vbcscp_mob_cpd_s9.png)

10.  Click **Design** to return to Design view.

## **STEP 3**: Change the Name of the main-start Page

It makes sense at this point to change the name of the main-start page to main-departments.

1.  In the Navigator, right-click the **main-start** page and select **Rename**.

    ![](./images/vbcscp_mob_cpn_s1.png)

2.  In the Rename dialog box, change `start` to `departments` in the **ID** field and click **Rename**. 
3.  In the Navigator, click the **main-departments** page to go to that page again.
4.  Although you have changed its name, the main-departments page continues to be the page where your application starts when you run it. To find out why, click the **Source View** ![](./images/vbcscp_mob_sourceview_icon.png) tab and expand the **mobileApps**, **hrmobileapp**, **flows**, and **main** nodes. Then click **main-flow.json** to open it.

    ![](./images/vbcscp_mob_cpn_s4.png)

    You can see that the `defaultPage` property has been set to the value `main-departments`, making it the starting page for the mobile application flow.

## Acknowledgements
**Author** - Sheryl Manoharan

**Last Updated** - December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
