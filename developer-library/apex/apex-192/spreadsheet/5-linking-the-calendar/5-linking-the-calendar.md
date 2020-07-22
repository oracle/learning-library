# Improve the Calendar

## **Introduction**
In this lab, you will learn how to improve a Calendar and link an existing page (Calendar) to a modal form page.

## **STEP 1** - Improving the Calendar
The **Calendar** page currently displays the project, rather than the task name, and only shows the start date, instead of displaying duration-based events.

1. In the runtime environment, click **Calendar**.

    ![](images/show-initial.png " ")

    *Note - You may have to use the arrows at the top of the calendar to navigate backward or forward months to see data displayed.*

2. In the Developer Toolbar, click **Edit Page 6**. Alternatively, navigate back to the APEX App Builder browser tab and manually navigate to Page 6.

3. You can change the displayed column and make the events duration based by updating the calendar attributes.

    In Page Designer, within the Rendering tree (left pane), find Calendar, and then click **Attributes** directly below that.
    Within the Property Editor (right pane), for Settings > Display Column select **TASK\_NAME**, and for End Date Column select **END\_DATE**. Click **Save and Run** to review your changes

    ![](images/update-attributes.png " ")

4. Reviewing the revised calendar changing to duration-based events is not optimal. Therefore, you should remove the End Date Column added above.

    ![](images/upd-calendar.png " ")

5. Navigate back to the APEX App Builder, in Page Designer, with Page 6 selected, within the Rendering tree (left pane), find Calendar, and then click **Attributes** directly below that.
    Within the Property Editor (right pane), for Settings > End Date Column select **- Select -** to clear the **END_DATE** entry.

    ![](images/remove-end-date.png " ")

6. In Page Designer, click **Save and Run** to see the improved calendar.

    ![](images/upd-calendar2.png " ")

## **STEP 2:** Linking the Calendar
When you click on a calendar entry, it shows event details. It would be far better to link to the Project Task form page and allow end users to update the details.

1. Navigate to the APEX App Builder, and ensure Page Designer is displayed with Page 6 selected.

2. Define a *View / Edit Link* from the **Calendar** region to **Page 5**, the Project Tasks form page you modified in the previous lab.

    In Page Designer, within the Rendering tree (left pane), find Calendar, and then click **Attributes** directly below that.
    Within the Property Editor (right pane), for Settings > View / Edit Link, click **No Link Defined**.

    In the Link Builder page, enter the following and click **Ok**.

    | Property | Value |
    | --- | --- |
    | Page | **5** |
    | Set Items > Name | **P5_ID** |
    | Set Items > Value | **&ID.** |
    | Clear Cache | **5** |

    ![](images/set-link.png " ")

3. It is important that the calendar is updated whenever the Task Name or Start Date is changed using the new link. To ensure the page is updated appropriately you need to define a Dynamic Action to refresh the calendar region when the dialog (modal page) is closed.

    A Dynamic Action is a declarative way to define client-side interactivity. Developers specify when an event fires, what actions are to be taken, and on what components the action is to be performed.

    In Page Designer, within the Rendering tree (left pane), _right-click_ on the Calendar region. Click **Create Dynamic Action**.

    ![](images/create-dynamic-action.png " ")

4. With the Dynamic Action selected, within the Property Editor (right pane), enter the following.

    | Group | Property | Value |
    | --- | --- | --- |
    | Identification | Name | **Refresh Calendar** |
    | When | Event | **Dialog Closed** (under **Framework Events**)|
    | | Selection Type | **Region** |
    | | Region | **Calendar** |

    ![](images/name-dynamic-action.png " ")

5. Within the Rendering tree (left pane), under the True action for the Dynamic Action, select **Show**. In the Property Editor (right pane), select the following. Click **Save and Run** to review the completed application

    | Group | Property | Value |
    | --- | --- | --- |
    | Identification | Action | **Refresh** (under **Component**)|
    | Affected Elements | Selection Type | **Region** |
    | | Region | **Calendar** |

    ![](images/define-action.png " ")

6. In the runtime environment, from the Calendar, select an event. In the Project Task form page, update the Task Name and Start Date. Click **Apply Changes**.

    ![](images/edit-final.png " ")

    Confirm that the Calendar refreshes to show the updated details.

    ![](images/updated-final.png " ")


## **Summary**

This completes Lab 5. You now know how to create an application by uploading a file, enhancing the page using runtime environment and Page Designer, and also linking pages to enhance the application.

## **Learn More** - *Useful Links*

- [APEX on Autonomous](https://apex.oracle.com/autonomous)
- [APEX Collateral](https://apex.oracle.com)
- [APEX Tutorials](https://apex.oracle.com/en/learn/tutorials)
- [APEX Community](https://apex.oracle.com/community)
- [APEX External Site + Slack](http://apex.world)

## **Acknowledgements**

 - **Author** -  David Peake, Consulting Member of Technical Staff
 - **Contributors** - Tom McGinn, Database Cloud Services, Product Management
 - **Last Updated By/Date** - Arabella Yao, Product Manager Intern, Database Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
