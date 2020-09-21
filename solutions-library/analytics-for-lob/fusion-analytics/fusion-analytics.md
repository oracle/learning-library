# Oracle Fusion ERP Analytics

## Introduction

In this lab, you will learn about how a finance team can address analytics questions through Oracle Fusion ERP Analytics.

This lab is designed to give you a hands-on experience with both the pre-built elements of Oracle Fusion ERP Analytics – with a focus on KPIs and dashboards – as well as the intuitive self-service capabilities delivered by the underlying Oracle Analytics Cloud platform.

Estimated Lab Time: 40 minutes.


### Objectives

-   Learn how to use the Oracle Fusion ERP Analytics interface through KPI Cards, Decks, Alerts, and Analysis
-   Learn how to perform a Custom Analysis on a Pre-Built Profitability Subject Area
-   Learn how to explore a Balance Sheet Subject Area and create a Trial Balance
-   Learn how to explore an Account Payables Project and create new reports

### Prerequisites

-   The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
-   *To access the workshop environment*, you will need internet access and a modern web browser. Your instructor will provide you with a URL for the Oracle Fusion ERP Analytics instance and you will be assigned a username and password. Please refer to your instructor's confluence page for details.

## **Step 1:** Explore the Interface and Pre-Built Content: KPI Cards, Decks, Alerts, and Analysis

We’ll start our experience with Oracle Fusion ERP Analytics by getting a good understanding of the out-of-the-box KPIs that finance executives and management can use to stay on top of the business.

The product contains a library of 50+ pre-built Key Performance Indicators (KPIs) around profit and loss, balance sheets, financial ratios, receivables, and payables. You will learn to read the KPIs, leverage pre-built Decks or create simple customized decks, set alerts, and perform some additional analysis.

**Note**: when going through this lab, your visualizations may looks slightly different from what is seen in the lab guide. This is okay- the data on the backend instance is updated regularly so the visualizations may look differently for you.

1. Enter the credentials you were given and click the **Sign In** button.

    ![](./images/1.png " ")

2. We start at the homepage, where contains KPIs and Decks that you have marked as favorites. Since this is the first time you have logged in, the screen will be blank. Let’s explore how to navigate within the application.

    ![](./images/2a.png " ")

3. Click on the upper left **hamburger menu** icon to see the following:
    a. **Decks** are how KPIs are presented and organized.
    b. **KPIs** is where you can create and edit the Key Performance Indicators library.
    c. **Projects** is where you can create and edit analysis and reports.
    d. **Data** is where you manage data access and workflows.

4. Click on **Decks**.

    ![](./images/2b.png " ")

5. Now, take a moment to review a few of the pre-built decks. From left to right, click on the following:
    a. **Profit and Loss**
    b. **Payables**
    c. **Balance Sheet**
    d. **Financial Ratios**

6. Take a moment to look at the pre- built KPIs on each deck.

    ![](./images/3.png " ")

7. From the **Financial Ratios** deck, click the **filter icon** on the top right. **Note** that the current deck is filtered by Current Quarter by default. You can easily change the filter here to focus on a different context, such as business unit, cost center, time, etc. For instance, feel free to click on the **Time** field to change it to **Previous** and **Year** and then click on **Apply**. Feel free to try this on the other pre-built decks to see how the data and according visualizations change.

8. Click the **filter icon** again to make it disappear.

    ![](./images/4.png " ")

9. Click on **My P&L** – a custom deck that we have created and shared with you. Every user can easily create their own custom decks with the top KPIs they want to monitor. **Note** that a deck contains one or more KPI “cards.”

10. Each KPI card can be customized in numerous ways. In addition to the visualization, observe that the Revenue KPI Card contains the following:
    a. An **Alert** (the top line is green – as Revenue is above target)
    b. A Comparison to **Target**
    c. A Comparison to **Previous Time Period**

    ![](./images/5.png " ")

11. On this deck, we notice that although Revenue is above target, Operating Expenses are trending up. From each KPI, it’s very easy to drill into deeper insights about your finance data. Let’s drill in to OPEX to explore further.

12. Click on the **OPEX** KPI card **hamburger menu icon**. Select **Operating Expense Analysis PL**.

    ![](./images/6.png " ")

13. This pre-built analysis provides additional visualizations to highlight and accelerate further analysis. Observe the following:
    a. Trailing 12 months and quarterly operating expenses are increasing.
    b. The tree map visualization shows that the Call Center is the top area for expense.
    c. In the bottom bar chart, we see a spike in payroll cost.

14. Finally, click on the **back arrow** at the upper left of the screen to return to the deck.

    ![](./images/7.png " ")

15. We’re now back on the My P&L deck, which was shared with you with “view only” access. We want to dig deeper into payroll cost, so we’ll create a new custom deck that we can customize to meet our needs. Click the **hamburger menu icon** on the top right. Select **Add Deck**.

    ![](./images/8.png " ")

16. Name your deck **Payroll Deck ~InsertYourInitialsHere~**. Click the **Save** button.

    ![](./images/9.png " ")

17. First, let’s add the **Payroll Cost KPI** to this new deck. Click the **+ icon**.

    ![](./images/10.png " ")

18. **Scroll** through the KPI library so you can see all of the out of the box KPIs. Select **Payroll Cost PL** KPI. **Note**: You see two Payroll Cost KPIs with very similar names, because one of them is a custom KPI. Be sure to select **Payroll Cost PL**. You will see a Preview of the card, but we want to customize it before we add it to the deck.

    ![](./images/11a.png " ")

19. Click the **Customize Card** button.

    ![](./images/11b.png " ")

20. Note that by default, this KPI is configured as follows:
    a. Target: compares against the payroll cost budget.
    b. Target Value: set to % Variance from Target.

21. Now we’ll customize the KPI. Click **Show Change** checkbox.

    ![](./images/12a.png " ")

22. By default, Last Period is set to display a Qtr over Qtr comparison. Click the **Last Period** value.

    ![](./images/12b.png " ")

23. Select **Same Period Last year**. The Preview updates, and we now see a new +% YoY.

    ![](./images/12c.png " ")

24. We can also customize the visualization itself in this KPI Card. We’ll now do so by adding budget to the visualization. In the **Detail Visualization** section, click **More Options** to expand it.

    ![](./images/13a.png " ")

25. **Scroll down** and under **Additional Data**, look for **Values**. In the Values drop-down, select **Payroll Cost Budget**. We now see the budget in the visualization.

    ![](./images/13b.png " ")

26. To make the visualization easier to read,  go to the **Visualization** box and select **Line Bar Combo**.

    ![](./images/13c.png " ")

27. Observe how we now see actuals (blue bar) trending over budget (green line).

    ![](./images/14.png " ")

28. Now, click the **Status and Notifications** tab. The colored line (in this case, red) at the top of the KPI Card is an alert. The default rule is that Payroll Cost >110% is set to red (“Critical”). Let’s customize the alert status. Change the 110% value to 130% by typing in **130**%. Click the **Add Card** button.

    ![](./images/15new.png " ")

29. The KPI is now added to the deck. Payroll Cost is trending up plus over budgets. And the alert bar is showing up as yellow (“Warning”). Click the **star icon** to mark as a favorite to put it on our home page.

30. Click the **maximize icon** so we can navigate to a larger card to see more information.

    ![](./images/16.png " ")

31. KPI Cards are designed to enable fast, immediate collaboration. Click **Enter message** to create a note to the finance analyst to investigate payroll cost.

    ![](./images/17a.png " ")

32. Type the following: **Lizzy – please investigate why Payroll Cost is trending up and over budget.**. Click **Add Note**.

33. Notice that at the bottom of the popup window that the system recommends related metrics. In this case, the system recommends Payroll Cost Budget, Sales and Marketing, and Other Operating Expenses.

    ![](./images/17b.png " ")

34. Let's continue with our collaboration example. Click the **camera icon** to attach a snapshot image of the KPI card to the note you sent to Lizzy. Click the **back arrow** next to the Notes title.

    ![](./images/18.png " ")

35. Now let’s fast forward. Our business analyst, Lizzy, has completed additional analysis on this issue. She can easily share it back with us by attaching it right to the KPI. Let’s take a look at her analysis. Click on the **HR Payroll and Attrition Analysis** link.

    ![](./images/19.png " ")

36. Our financial analyst created a detailed analysis based on both financial as well as HR workforce attrition data. Review the analyst’s note: Lizzy observes that overtime pay started to increase in July, which was the same time the Call Center had a spike in attrition. You can see the spike in the lower left visualization. Next, you can click on the **Attrition Analysis** to see an additional dashboard.

37. Two additional items stand out on the Attrition dashboard:
    a. Statistical trending and forecasting capabilities enhance several visualizations, including the projected attrition trend as well as the future impact of overtime.
    b. Observe the Turnover narrative on the right was created using point and click natural language generation capabilities applied to the “Turnover by Department” visualization.

    ![](./images/20.png " ")

38. Let's return to the home page. Click the **Back arrow** in the upper left.

    ![](./images/21a.png " ")

39. Click **My P&L** deck.

    ![](./images/21b.png " ")

40. Congratulations on completing this section! Please delete the deck with the cards you have made, which you named **Payroll Deck ~InsertYourInitialsHere~**, during this workshop by clicking on the decks' **menu bar** and selecting **Delete** for the Deck

41. Additionally, please go back to the console section where you left a **note** in Step 32 for a financial analyst to check out, and **delete** the note similarly.

    ![](./images/22new.png " ")

42. To recap, in this section, you:
    a. Monitored business performance with pre-built KPIs and pre-built Decks
    b. Drilled into deeper analysis, which is available through pre-built reports
    c. Collaborated with the team – within the platform – to answer questions
    d. Observed how an analyst can easily bring additional data sets – like HR data – into the platform to perform cross- functional analysis.


## **Step 2:** Create a KPI with the Prebuilt ERP Data Model and External Data

Next, let's use the Financials-AP Invoice prebuilt subject area to create a KPI for Outstanding Invoice Amounts.  We will be also using an excel file that holds the target value the company set for Outstanding Invoices

1. From the browser console, click on the upper left **hamburger menu icon** and then click on **KPIs**.

    ![](./images/2-1.png " ")

2. Click the **Create** button.

    ![](./images/2-2.png " ")

3. A "Add Data Set" window will pop-up. Select the **Financials-AP Invoice** Subject Area and then click on the **Add to KPI** button.

    ![](./images/2-3.png " ")

4. A data pane window will appear in the left area of your screen. Click on the **+ icon** next to "Data Elements".

    ![](./images/2-4-1.png " ")

5.  Then, click on the **Data Sets** tab.

    ![](./images/2-4-2.png " ")

6. Select the **Invoice Targets** Data Set and then click on the **Add to KPI** button.

    ![](./images/2-4-3.png " ")

7. You should now see the Overview page of your KPI. Enter the Name of the KPI as **AP Invoices XX** where XX are your initials.

8. Then, in the Tags field, type **invoice**.

9. Proceed to the next step by clicking the **AP Invoices XX** name in the Data Elements pane on the left.

    ![](./images/2-5.png " ")

10. In the bottom left settings pane, click the **gear icon**. Then, select **Stay Below Target** for the Target Goal

    ![](./images/2-6-1.png " ")

11. Select **Decrease over time** for Trends Goal

    ![](./images/2-6-2.png " ")

12. Expand the **Financials – AP Invoices** folder by clicking on it. Then, expand the **Facts – Ledger Currency** folder (You will need to scroll to see this folder at the bottom of the data pane) and then drag **Invoices Amount** to the Measurement box in the Data section.

    ![](./images/2-7.png " ")

13. Expand the **Invoice Targets** folder in the data pane window on the left. Then, drag **Invoice Target** to the Target box.

    ![](./images/2-8.png " ")

14. Scroll back to the **Facts – Ledger Currency** folder and drag **Invoice Count** to the Related Measurement box.

    ![](./images/2-9.png " ")

15. Proceed to do the same for a few elements from the **Time** folder by clicking to expanding the folder.

16. Then, drag **Fiscal Year** to the Year box.

17. Drag **Fiscal Quarter** to the Quarter box.

18. Drag **Fiscal Period** to the Month box.

    ![](./images/2-10.png " ")

19. Click to open the the **Ledger** folder

20. Drag **Ledger** to the Related Grouping Categories box

    ![](./images/2-11-1.png " ")

21. Click to open the **Payables Invoicing Business Unit** folder

22. Drag Payables Invoicing Business Unit Name to Related Grouping Categories

    ![](./images/2-11-2.png " ")

23. Let's observe some conditions. Scroll down to the bottom of the screen. Notice the **Conditions** and **Links** options. This is where you can specify the target ranges as well as link to other analysis such as a Project, Dashboard or Analyses. We will leave these as the are today.

    ![](./images/2-12.png " ")

24.  Click the **Save** button at the top.

    ![](./images/2-13.png " ")

25. Let's go back to view the decks. Click on the upper left **hamburger menu icon** and then click on **Decks**.

    ![](./images/2-14.png " ")

26. Select the **Payroll Deck**.

    ![](./images/2-15.png " ")

27. First, let’s add the **AP Invoices XX** KPI to this new deck by clicking the **+ icon**.

    ![](./images/2-16.png " ")

28. Select your **AP Invoices XX** KPI.

    ![](./images/2-17-1.png " ")

29. Then, click the **Add Card** button.

    ![](./images/2-17-2.png " ")

30. Congratulations, your new KPI for AP Invoices is now added to your Payroll Deck and is available for viewing and use!

    ![](./images/2-18.png " ")


## **Step 3:** Create an Analysis with the Pre-Built ERP Data Model

1. Now, let's take a look at the out of the box GL profitability analysis and subject area and see how to customize and extend them to create new analysis and reports. Starting from the **My P&L** deck, we’re going to drill into the out of the box Net Income Analysis. Click the **Net Income PL** card **hamburger menu icon**.

    ![](./images/3-1a.png " ")

2. Select **Income Analysis**.

    ![](./images/3-1b.png " ")

3. Observe the following:
    a. Net Income for the current quarter in a waterfall viz
    b. A quarterly trend for net Income, Revenue and Net Income Margin %
    c. Net income details.

4. Click the **Edit button** so we can customize this analysis. **Note**: this may take some time. If the linked page does not load in a minute, please try using a different browser.

    ![](./images/3-2.png " ")

5. First, begin by clicking on the **small down arrow icon** of the canvas and then **Duplicate Canvas**

    ![](./images/part2-1.png " ")

6. Rename the canvas by clicking on the **small down arrow icon** of the canvas and then **Rename**. Input as the name the following, making sure to input your initials **Overview ~InsertYourInitialsHere~**

    ![](./images/part2-2.png " ")

7. Let’s take a moment to tour the self-service project. On the canvas are our four familiar visualizations. **Click** to highlight one.

    a. Observe the grammar pane on the immediate left – it is the control panel for each visualization, allowing you to modify the visualization as needed.
    b. Observe the data pane on the far left. Oracle Analytics for Fusion ERP contains a pre-built data pipeline that directly imports your ERP Cloud data, as well as a pre-built data model.
    c. From this data pane, you can see views of your finance data organized into constructs called subject areas. Here, we see the Financial – GL Profitability subject area. It is organized into folders containing attributes and metrics.
    d. Observe at the bottom left, you see the setting pane for whatever object we select.

    ![](./images/3-3.png " ")

8. Now we’ll build a few visualizations with the pre-built data in this subject area. Click the **+ icon** at the bottom of the screen to create a new canvas. Rename the canvas by clicking on the **small down arrow icon** of the canvas and then **Rename**. Input as the name **Fiscal ~InsertYourInitialsHere~**

    ![](./images/part2-2.png " ")

9. To build our first visualization, let's make a simple pivot table. In the **Data pane**, do the following:
    a. Click to open the **Time** folder in the **Financials - GL Profitability** folder
    b. Right Click **Fiscal Quarter**
    c. Select **Pick Visualization** from the popup window
    d. Select the **Pivot icon**

    ![](./images/3-4a.png " ")

10. **Drag** the **Data pane** wider so you can see better. Click the **Balancing Segment Hierarchy** folder to open.

11. Double Click **Balancing Segment Level 30 Description**. Scroll down the **data pane**.

    ![](./images/3-4b.png " ")

12. Click **Facts – Ledger Currency folder** to open. Click **Profit and Loss (LC)** subfolder to open. Double Click **Net Income**.

13. And it’s as simple as that to create your first visualization – slicing and dicing net income by different dimensions.

14. Let's finish by enabling a filter for two fiscal years by clicking on the **Fiscal Year (2)** filter's **hamburger menu icon** and then on **Enable Filter**

    ![](./images/3-4d.png " ")

15. Your visualizations should now look similar to the following:

    ![](./images/3-4c.png " ")

16. We’ll create a second visualization by duplicating this pivot table. On the upper right of the pivot table visualization, click the hamburger menu icon. Hover over **Edit**. Click on Duplicate Visualization to add a duplicate to the canvas.

  ![](./images/3-5.png " ")

17. Select the right pivot table visualization if not selected already. Click the **Visualization Type icon**. Select **Area icon** from the dropdown list.

    ![](./images/3-6.png " ")

18. Your new “Area” visualization will now look like this. You can see that the combination of the table and the visualization helps tell the story more clearly. **Note**: If your new visualization looks different from what is shown, double-check the fields on the grammar pane and adjust it as necessary.

    ![](./images/3-7.png " ")

19. We’ll now further customize this visualization by adding data labels. With **# Net Income** selected, scroll down to the bottom left settings panel.

20. Click on the **#** menu, and make the following modifications:
    a. Data Label: Select **Auto**
    b. Font: Select **Auto** and click the **bold icon**
    c. Number Format: Select **Number**
    d. Decimal: Select **None**
    e. Abbreviate: Select **On**

    ![](./images/3-8.png " ")

21. Now your visualization is much more readable with the data values. Let’s create another visualization. On the upper right of the area visualization, click the **hamburger menu icon**. Hover over **Edit**, and click on **Duplicate Visualization**

    ![](./images/3-9.png " ")

22. Let's reorganize the visualizations on the canvas. Click on one of the area visualizations and drag it above the pivot table. Watch for the blue bar to show before releasing your mouse.

    ![](./images/3-10.png " ")

23. Select the visualization you just dragged to the top (the visualization will be outlined in blue when it is selected). In the grammar pane on the left, remove **Fiscal Quarter** by clicking the **x**.

    ![](./images/3-11.png " ")

24. Let's change the visualization type. In the grammar pane on the left, click **Area**. Select **Donut** from the dropdown list.

    ![](./images/3-12.png " ")

25. Scroll up the Data pane. Open the **Time** folder. Click and drag **Fiscal Year** to the **Trellis Columns** area in the grammar pane.

    ![](./images/3-13.png " ")

26. The visualization now compares net income by regional segments across fiscal years.

    ![](./images/3-14.png " ")

27. We’ll next create a text narrative description of the area visualization. First let’s duplicate the area visualization. On the Upper right of the Area visualization, click the **hamburger menu icon**. Hover over **Edit**. Click **Duplicate Visualization** to add a duplicate to the canvas.

    ![](./images/3-15.png " ")

28. Select the new duplicate Area visualization if not selected already. Click the **Visualization Type** icon. Select **Language Narrative icon** from the dropdown list.

    ![](./images/3-16.png " ")

29. A generated narrative describing the Area visualization will appear on the left.

    ![](./images/3-17.png " ")

## **Step 4:** Blend ERP data with External Data

-    Let's now go through how to extend your analysis by blending in an external data source that provides additional insight to your ERP data.

-    **Note**: when going through this lab, your visualizations may looks slightly different from what is seen in the lab guide. This is okay- the data on the backend instance is updated regularly so the visualizations may look differently for you.

1. Let’s navigate to the Home page.

2. Select the **hamburger menu icon** on the top left.

3. Click **Home**.

    ![](./images/4-1.png " ")

4. Below the Get Started banner, you will see shortcuts to pre-built analyses.

5. Click **Projects and Reports**

    ![](./images/4-2.png " ")

6. In the search bar, input **AP Analysis Lab Demo** and click on the **AP Analysis Lab Demo** project.

    ![](./images/step4-project.png " ")

7. This project contains analyses across two subject areas, AP Invoices and AP Balances. Visualizations include:
    a. AP Balances with a quarterly trend.
    b. Top 10 suppliers with AP Balances.
    c. Top Invoice Amounts by Payment Terms and Supplier Names.

8. Click the **+ icon** at the bottom of the screen to create a new canvas.

    ![](./images/part4-1new2.png " ")

9. Please rename this new canvas to **Analysis ~InsertYourInitialsHere~** by clicking on the **small down arrow icon** of the canvas and then **Rename**

    ![](./images/part4-1new3.png " ")

10.  Let's download an excel dataset file from this workshop to load into your instance. You can download it by clicking on the following text link: [Download supplier\_risk\_ratings.xlsx here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/vq-e_pds9JCsEbPmtqIxazJWvGepb0qV6vYyCCa2qis/n/orasenatdpltoci01/b/cloud-data-platform-workshop-files/o/supplier_risk_ratings.xlsx). Then, return back to Fusion ERP Analytics in your browser window.

11. In the data pane, click on the **+ icon** at the top and then select **Add Data Set** in the popup window.

    ![](./images/4-5-2.png " ")

12. Click **Create Data Set** button.

    ![](./images/4-5-3.png " ")

13. Click **Drop data file here or click to browse**.

    ![](./images/4-5-4.png " ")

14. Select the **supplier\_risk\_ratings.xlsx** excel file you downloaded previously and then click on the **Open** button.

15. Observe the following column definitions in the supplier credit ratings file:
    a. The Credit Risk score measures a business’s past payment performance.  
    b. The Ability to Pay rating helps predict the chance a supplier will become inactive or shut down in the next 12 months.

16. Continue by clicking the **Add** button.

    ![](./images/4-6.png " ")

17. Click the **Data Diagram** tab at the bottom of the window.

    ![](./images/4-7.png " ")

18. The system automatically joins fields with the same name. Click the **blue bubble 1** on the join line to examine how the new spreadsheet is joined to the pre-built subject area data. Observe that it matched on supplier name. If there was no automatic match then you could add the match manually. Proceed by clicking the **OK** button.

    ![](./images/4-8-1.png " ")

19. Then, in the upper right of the screen, click the **Visualize** link.

    ![](./images/4-8-2.png " ")

20. Let’s create a visualization that uses data from both the subject area and the excel file. In the data pane, confirm that you are in the **Financial - AP Invoices Subject Area** and click the **Supplier** folder to expand it and then double click on **Supplier Name**.

    ![](./images/4-9-1.png " ")

21. Now, click on the **Facts – Ledger Currency** folder to expand it and then double click on **Invoice Amount**.

    ![](./images/4-9-2.png " ")

22. Then, click on the **supplier\_credit\_ratings** folder to expand it and double click on **Credit Risk**.

    ![](./images/4-9-3.png " ")

23. The system automatically creates a scatter chart in which each bubble represents a supplier. A Credit Rating of closer to 10 indicates high risk. Let’s add Ability to Pay into the scatter. In the data pane, double click on **Ability to Pay** from the **supplier\_credit\_ratings** folder. Ability to Pay will then be added to the visualization as the bubble color.

    ![](./images/4-10.png " ")

24. Let’s add Invoice count into the scatter. In the data pane, double click on **Invoices Count** from the **Facts – Ledger Currency** folder. Invoices Count is then added to the visualization as the bubble size.

    ![](./images/4-11.png " ")

25. Let’s filter for just the top 10 suppliers. In the grammar pane, click on **# Invoices Amount** and drag it to the **Filters** section. Disregard the popup window.

    ![](./images/4-12-1.png " ")

26. In the **Filters** section of the grammar pane, do the following:
    a. Click on **Invoice Amount** in the filter.
    b. Hover over or click on **Filter Type**.
    c. Select **Top Bottom N**.

    ![](./images/4-12-2.png " ")

27. A popup window will appear. The default is 10, which we will accept. Click anywhere on the visualization to close the popup window. Your visualization should look similar to this:

    ![](./images/4-13.png " ")

28. Let’s add data labels to the visualization. At the bottom left settings panel, click on the **#** icon to access its menu. Then, click on the **Data Label** option and click on  **Auto**.

    ![](./images/4-14.png " ")

29. The visualization helps to identify a supplier that we may introduce some risk, and may require deeper analysis. For now, let's go ahead and save your work.

    ![](./images/4-15.png " ")

30. First, click **Save As** at the top. Then, name your project **Net Income Analysis XX** where XX are your initials. Proceed by clicking on the **Save** button. Note: you may see a generating thumbnail message. If you do, click on **Skip** to ignore it.

31. Nice work on making these canvases and visualizations! Please go ahead and delete the canvases with your initials at this time by clicking on the canvas **down arrow icon** and selecting **Delete Canvas**. There should be one canvas you need to delete in this project, **Analysis ~InsertYourInitialsHere~**. Please do the same for your **Net Income Analysis XX** project.

    ![](./images/part2-3.png " ")

32. When exiting the instance, make sure you don't save any changes made during the workshop by clicking on **Don't Save** when any **Save Changes?** text boxes pop up.

You may proceed to the next lab.

## Summary

-   In this lab, you explored Oracle Fusion ERP Analytics. You navigated the Interface and pre-built content through KPI Cards, Decks, Alerts, and Analysis. You also created a KPI with an ERP Data Model and External Data, constructed an Analysis with an ERP Data Model, and blended ERP data with External Data

## Learn More
-   To learn more about Oracle Fusion ERP Analytics, feel free to explore the capabilities by clicking on this link: [Oracle Fusion ERP Analytics Getting Started Documentation](https://docs.oracle.com/en/cloud/saas/analytics/fawag/get-started-oracle-analytics-applications.html#GUID-66FF30CB-C4C4-4184-9223-DE5AE3E83C80)

## Acknowledgements

- **Author** - NA Cloud Engineering - Austin (Khader Mohiuddin, Philip Pavlov, Jess Rein, Naresh Sanodariya, Parshwa Shah)
- **Last Updated By/Date** - Jess Rein, Philip Pavlov - Cloud Engineer, Sept 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
