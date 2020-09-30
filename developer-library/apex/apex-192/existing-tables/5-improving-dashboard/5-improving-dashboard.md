# Improving the Dashboard

## Introduction
In this lab, you will learn how to manipulate regions in Dashboard using Page Designer.

## **STEP 1** - Removing Chart 4
Looking at the Dashboard you will see that Chart 4 is based on demo data and should be removed.

1. In the runtime environment, click **Dashboard** (See how to access runtime environment in Lab 3, Step 7, Step 8).
2. In the Developer Toolbar (at the bottom of the runtime page), click **Edit Page 2**.

    ![](images/go-page2.png " ")

    You should now be in *Page Designer*. Page Designer is where you will spend the majority of your time improving your application.

    There are three panes within Page Designer. The left pane initially displays the Rendering tree, with a list of page components. The middle pane displays the Layout, a representation of the page, and Gallery (at bottom), from which you can drag and drop new components into the Layout. The right pane is the Property Editor, where you can change attributes for the selected component.

3. Within Page Designer, in the Rendering tree (left pane), _right-click_ **Chart 4** and select **Delete**.

    ![](images/delete-chart.png " ")

4. Let’s review the dashboard again.   
    In the Page Designer toolbar at the top of page, click **Save and Run**. Make sure you browser allows pop-ups.

    ![](images/run-dash.png " ")

    The revised layout will be displayed.

    ![](images/view-dash.png " ")

## **STEP 2** - Move Regions
Looking at the revised Dashboard page, it would look better to have the Budget versus Cost chart on a line by itself.

1. From the runtime environment, navigate back to the Page Designer in App Builder by clicking **Edit Page 2** in the Developer Toolbar, or by navigating back to the App Builder browser tab manually.
2. Within Page Designer, in the Rendering tree (left pane), click **Project Status**.   
    In the Property Editor (right pane), **_check_** Layout > Start New Row.  
    *Note: Within Layout (middle pane), the Project Status region will move onto a row by itself.*

    ![](images/set-status.png " ")

3. Now to move the Project Leads chart up onto the same line as the Project Status chart.  
    In the Rendering tree (left pane), click **Project Leads**.     
    In the Property Editor (right pane), **_uncheck_** Layout > Start New Row.  
    *Note: Within Layout (middle pane), the Project Leads region will move up to be on the same row as Project Status.*

    ![](images/set-leads.png " ")

5. Now to review the page!     
    Click **Save and Run**.

    ![](images/final-dash.png " ")

## **Summary**

This completes Lab 5. You now know how to remove and reposition regions. [Click here to navigate to Lab 6](?lab=lab-6-improving-projects)

## **Acknowledgements**

 - **Author** -  David Peake, Consulting Member of Technical Staff
 - **Contributors** - Tom McGinn, Database Cloud Services, Product Management
 - **Last Updated By/Date** - Arabella Yao, Product Manager Intern, Database Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
