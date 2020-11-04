# Adding a Chart

## Introduction

In this lab, you will learn how to add a chart page to the application.

### Background Information
The Big Mac Index includes data for countries over the last 20 years. Therefore, to better visualize trends in a country's exchange rate over time it would be highly beneficial to create a chart that is country specific.

Initially you will create a chart that displays the Dollar Exchange Rate for Australia (ISO = 'AUS'). Then you will add additional data series.

## **STEP 1** – Create a New Page

1. From the runtime environment, in The Developer Toolbar (bottom of the screen), click **Application xxxxx**. When prompted click **OK**.

2. From the Application Home Page, click **Create Page**.

    In the Create a Page dialog, for Page Type, click **Chart**.

    ![](images/set-page-type.png " ")

3. In the Create Chart dialog, for Chart Type, click **Line**.

    ![](images/set-chart-type.png " ")

4. In the Page and Region Attributes dialog, enter the following:
    - Page Name - enter **Country Chart**
    - Breadcrumb - select **Breadcrumb**

    Click **Next**.

    ![](images/set-name.png " ")

5. In the Navigation Menu dialog, for Navigation Preference, click **Create a new navigation entry**.

    Click **Next**.

    ![](images/set-navigation.png " ")

6. In the Source dialog, enter the following:
    - Source Type - click **SQL Query**
    - SQL Query - cut and paste the following:

        ```
        <copy>select entry_date
        , dollar_exchange_rate
        from big_mac_index l
        where iso = 'AUS'
        order by entry_date</copy>
        ```
    Click **Next**.

    ![](images/set-source.png " ")

7. In the Column Mapping dialog, enter the following:
    - Label Column - select **ENTRY\_DATE**
    - Value Column - select **DOLLAR\_EXCHANGE\_RATE**

    Click **Create**.

    ![](images/set-columns.png " ")

8. In the Page Designer toolbar, click **Save and Run**.

    ![](images/save-and-run.png " ")

    ![](images/runtime.png " ")

## **STEP 2** – Adjust the Chart Attributes
As can be seen by the appearance of the first cut of the chart, there is work to be done. Updating some attributes will help.

1. From the runtime environment, in the Developer Toolbar(bottom of the screen), click **Quick Edit**.
    Hover over the chart region until it is surrounded by a blue box.
    Click the Chart.  

    ![](images/quick-edit.png " ")

    Alternatively, navigate back to the APEX Application Builder tab or window, and then navigate to Page 7.

2. Within Page Designer, in the Rendering tree (left pane), under **Chart**, click **Attributes**.

    In the Property Editor (right pane), enter the following. You may need to scroll down to find these sections:

    - Settings > Time Axis Type - select **Mixed Frequency**
    - Legend > Show - click **Yes**  

    ![](images/set-attributes.png " ")

## **STEP 3** – Update the Chart Series
Time to update the existing chart line (series), and add a few more data series.

1. Within Page Designer, in the Rendering tree (left pane), under **Chart**, click **Series 1**.

    In the Property Editor (right pane), enter the following:

    - Identification > Name - enter **Dollar Exchange Rate**
    - Label > Show - click **No**  

    ![](images/set-series1.png " ")

2. The next two series are very similar to the first, so it is easiest to just duplicate the existing series.

    In the Rendering tree (left pane), under **Chart**, right-click **Dollar Exchange Rate**, click **Duplicate**.

    ![](images/duplicate-series.png " ")

3. Repeat the step above to create a third series.
    *Note: You should now have Dollar Exchange Rate, Dollar Exchange Rate\_1, and Dollar Exchange Rate\_2 or Dollar Exchange Rate\_1\_1, depending on which series you duplicated to create the third series.*

4. The second chart line (series) is going to display the Relative Exchange Rate.

    In the Rendering tree (left pane), under **Chart**, click the second series. The name should be **Dollar Exchange Rate_1**    
    In the Property Editor (right pane), enter the following:

    - Identification > Name - enter **Relative Exchange Rate**
    - Source > SQL Query, copy and paste the following:

        ```
        <copy>select entry_date
        , (local_price / (select local_price from big_mac_index u
                          where u.entry_date = l.entry_date
                          and u.iso = 'USA'
                         )
          ) relative_exchange_rate
        from BIG_MAC_INDEX l
        where iso = 'AUS'
        order by entry_date</copy>
        ```
    - Column Mapping > Value - select **RELATIVE\_EXCHANGE_RATE**  

    ![](images/set-series2.png " ")

4. The third chart line (series) is going to display the Percentage Difference between the currency and the US currency.

    In the Rendering tree (left pane), under **Chart**, click the third series.    
    In the Property Editor (right pane), enter the following:

    - Identification > Name - enter **Percentage Difference (Y2)**
    - Source > SQL Query, cut and paste the following:

        ```
        <copy>select entry_date
        , ((  local_price / (select local_price from big_mac_index u
                             where u.entry_date = l.entry_date
                             and u.iso = 'USA'
                            )
            - dollar_exchange_rate
           ) * 100 / dollar_exchange_rate
          ) percentage_difference
        from BIG_MAC_INDEX l
        where iso = 'AUS'
        order by entry_date</copy>
        ```

    - Column Mapping > Value - select **PERCENTAGE_DIFFERENCE**
    - Appearance > Assigned To Y2 Axis, check **Yes**  

    ![](images/set-series3.png " ")

    *Note: If you do not check ‘Assigned to Y2 Axis’ then the chart will not display well, and not look like the following page.*

5. In Page Designer, within the Toolbar, click **Save and Run**.

    ![](images/save-and-run.png " ")

    ![](images/final-runtime.png " ")

## **Summary**
This completes Lab 5. In this lab you learnt how to create and modify a chart adding multiple series. [Click here to navigate to Lab 6](?lab=lab-6-adding-chart-criteria).

## **Acknowledgements**

 - **Author** -  David Peake, Consulting Member of Technical Staff
 - **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
 - **Last Updated By/Date** - Tom McGinn, Database Cloud Services, Product Management, June 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

