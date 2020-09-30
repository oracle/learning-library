# Improving the Dashboard

## Introduction

In this lab, you will learn how to manipulate regions in Page Designer to improve your Dashboard.

## **STEP 1** - Removing Chart 4
Looking at the Dashboard, you will see that Chart 4 is based on demo data and should be removed.

1. In the runtime environment, click **Dashboard**.
2. In the Developer Toolbar (at the bottom of the runtime page), click **Edit Page 2**.

    ![](images/go-page2.png " ")

    You should now be in *Page Designer*. Page Designer is where you will spend the majority of your time improving your application. There are three panes within Page Designer. The left pane initially displays the Rendering tree, with a list of page components. The middle pane displays the Layout, a representation of the page, and Gallery (in the bottom), from which you can drag and drop new components into the Layout. The right pane is the Property Editor, where you can change attributes for the selected component.

    *Note: If you don't see the Developer Toolbar at the bottom of your page, try closing the current runtime environment and reaccessing it from the App Builder.*

3. Within Page Designer, in the Rendering tree (left pane), scroll down and _right-click_ **Chart 4** and select **Delete**.

    ![](images/delete-chart.png " ")

4. Let’s review the dashboard again.   
    In the Page Designer toolbar (at the top of your screen), click **Save and Run Page** button.

    ![](images/run-dash.png " ")

    The revised layout will be displayed.

    ![](images/view-dash.png " ")

## **STEP 2** - Move Regions
Looking at the revised Dashboard page, it would look better to have the Budget versus Cost chart on a line by itself.

1. From the runtime environment, navigate back to the App Builder by clicking **Edit Page 2** in the Developer Toolbar, or by navigating back to the App Builder browser tab manually.
2. Within Page Designer, in the Rendering tree (left pane), click **Project Status**.   
    In the Property Editor (right pane), **_check_** **Layout > Start New Row**.  
    *Note: Within Layout (middle pane), the Project Status region will move onto a row by itself*

    ![](images/set-status.png " ")

3. Now to move the Project Leads chart up on to the same line as the Project Status chart.  
    In the Rendering tree (left pane), click **Project Leads**.     
    In the Property Editor (right pane), **_uncheck_** **Layout > Start New Row**.  
    *Note: Within Layout (middle pane), the Project Leads region will move up to be on the same row as Project Status*

    ![](images/set-leads.png " ")

5. Now to review the page!     
    Click **Save and Run Page** button.

    ![](images/final-dash.png " ")

## **Summary**

This completes Lab 4. You now know how to remove and reposition regions. [Click here to navigate to Lab 5](?lab=lab-5-improving-projects)

## **Acknowledgements**

 - **Author** -  Salim Hlayel, Principle Product Manager
 - **Contributors** - Arabella Yao, Product Manager Intern, DB Product Management
 - **Last Updated By/Date** - Tom McGinn, Database Innovations Architect, Product Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
