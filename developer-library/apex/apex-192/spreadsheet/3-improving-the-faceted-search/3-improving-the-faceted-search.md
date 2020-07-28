# Improve the Faceted Search

## **Introduction**

In this lab, you will get first-hand experience with enhancing the application by improving the faceted search page for better clarity and improved usability. The search page includes facets on the left which can readily be used to limit the data shown in the report on the right.

If you review the **Project Tasks Search** page you can check and uncheck various facets. When you check a facet, the counts on all of the remaining facets will be updated to show the number of records that meet the new criteria.

## **STEP 1**: Enhancing the Status Facet
Reviewing the facets, you will notice that Status is down the page and you can choose multiple values.

1. From the runtime application, go to the search page by clicking **Project Tasks Search**. Given you ran this app from the APEX App Builder, a Developer Toolbar is displayed at the bottom of the screen. *Note - End users who log directly into the app will not see this toolbar.*

    In the Developer Toolbar click **Edit Page 3**.

    ![](images/dev-toolbar.png " ")

    Alternatively, you can also navigate back to the APEX App Builder tab in your browser manually by selecting the appropriate browser tab or window. Once in the App Builder click **3 - Project Tasks Search**.

    ![](images/alt-app-builder.png " ")

    You should now be in Page Designer. Page Designer is where you will spend the majority of your time improving your application. There are three panes within Page Designer. The left pane initially displays the Rendering tree, with a list of page components. The middle pane displays the Layout, a representation of the page, and Gallery, from which you can drag and drop new components into the Layout. The right pane is the Property Editor, where you can change attributes for the selected component.

2. Status is a very common search criteria, so you want to reorder the facets such that Status is between Project and Assigned To.

    In the Rendering tree (left pane), under **Search**, within **Facets**, click and hold **P3_STATUS** and drag it up until it is under **P3_PROJECT** then release the mouse.

    ![](images/drag-status.png " ")   

3. Currently the Status facet is a series of checkboxes. However, it is unlikely that users will want to select more than one at a time, so you will convert it to a radio group.

    Continuing with **P3_STATUS** selected, within the Property Editor (right pane), for Identification > Type, select **Radio Group**. Scroll down the properties in the Property Editor, and for List Entries > Zero Count Entries select **Show Last**.

    ![](images/set-status.png " ")   

4. At the top right of the page click **Save and Run Page** to save the changes made to the facets and review the app.

    ![](images/run-app.png " ")   

5. In the runtime environment, click one of the statuses. Review how the counts on the other facets are updated based on your selection. Also notice how you can still select one of the other statuses or click **Clear**, within the Status facet, to clear your selection and again show all the counts for statuses.

    ![](images/runtime-status.png " ")   

## **STEP 2**: Collapsing Facets
1. You may have noticed that the facets go off the bottom of the page. Therefore, it would be preferable to collapse the last three facets, making it easier to see all available facets.

    Navigate back to the development environment (APEX App Builder) by using the edit link in the Developer toolbar, or manually navigating to the appropriate browser tab.

    In the Rendering tree (left pane), under **Search**, within **Facets**, click **P3\_ASSIGNED\_TO**, hold down the *Control* key and then click **P3_COST**, such that three facets are selected. In the Property Editor (right pane), within the filter at the top, enter **collap**, so that only two attributes are displayed. For Advanced > Initially Collapsed, change the switch to selected.

    ![](images/set-collapsed.png " ")   

    *Note - Rather than entering a filter you can also scroll down the properties until you find the correct attribute to update.*

7. Click **Save and Run Page** to see the improved search page.   

    ![](images/finished-search.png " ")   

## **Summary**

This completes Lab 3. You now know how to enhance a faceted search page and have been introduced to Page Designer. [Click here to navigate to Lab 4](?lab=lab-4-improve-report-form)

## **Acknowledgements**

 - **Author/Contributors** -  David Peake, Consulting Member of Technical Staff
 - **Last Updated By/Date** - Tom McGinn, Database Cloud Services, Product Management, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
