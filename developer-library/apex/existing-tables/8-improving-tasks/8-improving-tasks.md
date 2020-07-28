# Improving Tasks

## Introduction
In this lab, you will learn how to define a shared *List of Values* and use it to improve the Faceted Searches and Interactive Report pages for Tasks. You will also learn how easy it is to link the Calendar to the Tasks Form page.

## **STEP 1** - Defining a Shared List of Values
In the Runtime environment, navigate to **Tasks Search** and review the page. Notice that Is Complete column simply displays "Y" or "N". Now navigate to **Tasks Report**, and you will notice the same issue. It would be far better to display "Yes" or "No". This can readily be achieved by defining a *List of Values (LOV)*

You can define a LOV directly on a page. However, if you require the same LOV on multiple pages, as you do here, it is far better to define it once as a *Shared Component*.

1. Navigate back to the App Builder browser tab, click your application.
2. On the application home page, click **Shared Components**.

    ![](images/app-home.png " ")

    Alternatively, if in Page Designer, within the toolbar, click the **Shared Components** icon.

    ![](images/pd.png " ")

3. On Shared Components, under **Other Components**, click **List of Values**.

    ![](images/go-lov.png " ")

4. You will notice there are already several LOVs listed.   
    To create a new LOV click **Create**.

    ![](images/create-lov.png " ")

5. On the Create List of Values dialog, for Source, keep the default selection ("From Scratch").
    Click **Next**
6. On the Name and Type dialog, enter the following:
      - Name - enter **YES_NO**
      - Type - select **Static**

6. Click **Next**

    ![](images/lov-name.png " ")

7. On the Static Values dialog, enter the following:
    - Sequence 1
        - Display Value - enter **Yes**
        - Return Value - enter **Y**
    - Sequence 2
        - Display Value - enter **No**
        - Return Value - enter **N**  

    - Click **Create List of Values**

    ![](images/lov-values.png " ")

## **STEP 2** - Updating the Faceted Search
Now that you have defined the shared component, you need to utilize it on the Faceted Search page.

1. In the breadcrumbs, click **Application xxxxx**

    ![](images/go-home.png " ")

2. From the application home page, click **3 - Tasks Search**

    ![](images/go-page3.png " ")

3. You first want to update the entries in the *Search*.  
    - Within Page Designer, in the Rendering tree (left pane), under Search, click **P3\_IS\_COMPLETE\_YN**.   

4. In the Property Editor (right pane), select the following:
    - List of Values > Type - select **Shared Component**
    - List of Values > List of Values - select **YES_NO**

    ![](images/set-facet.png " ")

4. Next you also want to update the displayed value in the *Report*.  
    - In the Rendering tree (left pane), under **Project Tasks**, expand **Columns**.  
    - Within the list of columns, click **IS\_COMPLETE\_YN**.

5. In the Property Editor (right pane), enter the following:
    - Identification > Type - select **Plain Text (based on List of Values)**
    - List of Values > Type - select **Shared Component**
    - List of Values > List of Values - select **YES_NO**

    ![](images/set-report.png " ")

6. The report has many columns. The Description column takes up too much real estate, so should be hidden.  
    - In the Rendering tree (left pane), under **Project Tasks**, within the list of columns, click **DESCRIPTION**.   
    - In the Property Editor (right pane), for Identification > Type select **Hidden Column**.

    ![](images/hide-desc.png " ")

7. While we are on the page, we can quickly change the order of the search columns.  
    - In the Rendering tree (left pane), under **Search**, click **P3\_MILESTONE\_ID**   
    - In the Property Editor (right pane), for Layout > Sequence enter **25**     
    *Note: This will position P3\_MILESTONE\_ID after P3\_PROJECT\_ID (Sequence 20)*

    - In the Rendering tree (left pane), click **P3\_IS\_COMPLETE\_YN**    
    - In the Property Editor (right pane), for Layout > Sequence enter **35**     
    *Note: This will position P3\_IS\_COMPLETE\_YN after P3\_ASSIGNEE (Sequence 30)*

    ![](images/order-facet.png " ")

8. Let’s review that the Faceted Search is complete.  
    - In the Page Designer toolbar, click **Save and Run Page**.

    ![](images/facet-complete.png " ")

## **STEP 3** - Updating the Interactive Report
The Tasks Report also needs the Is Complete column updated.

1. In the Runtime environment, click **Tasks Report** in the menu.  
    - In the Developer Toolbar (bottom of page), click **Edit Page 6**.    
    *Note: You can also navigate back to your application home page in the App Builder browser tab and manually navigate to Page 6*

2. In Page Designer, with **Page 6: Tasks Report** selected, in the Rendering tree (left pane), under **Project Tasks** region, expand **Columns**.    
    - In the list of columns, click **IS\_COMPLETE_YN**.

3. In the Property Editor (right pane), enter the following:
    - Identification > Type - select **Plain Text (based on List of Values)**
    - List of Values > List of Values - select **YES_NO**

    ![](images/set-ir.png " ")

3. Run the application.     
    In the Page Designer toolbar, click **Save and Run Page**.

    ![](images/ir-complete.png " ")

4. Click on the edit icon for a record.     
    Notice that Is Complete uses a Switch so no need to modify the Form page.   
    *Note: The Form page is Page 7 which we will need in the next part*

## **STEP 4** - Linking the Calendar
The Tasks Calendar page shows numerous tasks; however, there is no way to directly modify a record. Therefore, you should add a link to the existing Project Task Form page.

1. In the runtime environment, within the Navigation Menu, click **Tasks Calendar**
2. Click on any entry to confirm it simply displays the event details

    ![](images/initial-cal.png " ")

3. In the Developer Toolbar (bottom of page), click **Edit Page 8**
4. In Page Designer, within the Rendering tree (left pane), under **Tasks Calendar**  region, click **Attributes**.  
    - In the Property Editor (right pane), for Settings > View / Edit Link, click **No Link Defined**

5. In the Link Builder dialog, enter the following:
    - Target > Page - select **7**
    - Set Items > Name - select **P7_ID**
    - Set Items > Value - select **ID** (Returns **&ID**)
    - Clear / Reset > Clear Cache - enter **7**

6. Click **OK**

    ![](images/set-link.png " ")

7. It is important that the calendar is updated if the Task Name, Start Date, or End Date are updated when the Project Task Form page is called from the calendar.    
    - In the Rendering tree (left pane), _right-click_ **Tasks Calendar**.    
    - Select **Create Dynamic Actions**.

    ![](images/go-da.png " ")

8. With **New** under Dynamic Actions selected, in the Property Editor (right pane), enter the following:
    - Identification > Name - enter **Refresh Calendar**
    - When > Event - select **Dialog Closed** (under **Framework Events**)
    
    *Note: The Refresh Calendar event will fire when the Project Task Form page is closed as it is a modal page*

    ![](images/name-da.png " ")

9. In the Rendering tree (left pane), under the True action, click **Show**.    
    In the Property Editor (right pane), select the following:
    - Identification > Action - select **Refresh** (under **Component**)
    - Affected Elements > Selection Type - select **Region**
    - Affected Elements > Region - select **Tasks Calendar**

    Click **Save**

    ![](images/set-true.png " ")

10. Navigate back to the runtime environment, and refresh the browser.   
    - Click a calendar entry

    ![](images/final-cal.png " ")

    If you update the Name, Start Date, or End Date, and click **Apply Changes** on the Project Task Form page, the changes will be reflected immediately in the calendar.

## **Summary**

This completes Lab 7 and the workshop. You now know how to create a Shared Component, use it to improve Faceted Search page and Interactive Report, and link a Calendar page that refreshes after a record is updated.

## Learn More 

- [APEX on Autonomous Database](https://apex.oracle.com/autonomous)
- [APEX Collateral](https://apex.oracle.com)
- [APEX Tutorials](https://apex.oracle.com/en/learn/tutorials)
- [APEX Community](https://apex.oracle.com/community)
- [APEX External Site + Slack](http://apex.world)

## Acknowledgements

 - **Author** -  David Peake, Consulting Member of Technical Staff
 - **Contributors** - Arabella Yao, Product Manager Intern, DB Product Management
 - **Last Updated By/Date** - Tom McGinn, Database Innovations Architect, Product Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
