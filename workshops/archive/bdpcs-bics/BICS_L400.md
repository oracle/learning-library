
![](images/L400/BDPCS-BICS_L400_Title.png)

Updated: February 1, 2017

# Introduction
This is the fourth lab that is part of the Oracle Public Cloud Big Data Preparation and Business Intelligence workshop. These labs will give you a basic understanding of the Oracle Big Data Preparation and BI Cloud Services, and how those in a non-technical line of business role can quickly access, cleanse, validate, explore, and analyze their business information without needing IT support.

This lab will walk you through creating how to create dashboards and analytic workbooks on your curated data after you have first prepared in Lab one and two. You will first create an ‘Analysis’ workbook for publishing into a dashboard, and then you will create a new dashboard and dashboard prompt, and then add your workbook to the dashboard.

The following shows the self service flow of information, as business users take prepared data, explore it, and create dashboards off the curated data.

![](images/L400/p1.png)

** Please direct comments to: derrick.cameron@oracle.com **

## Objectives
- Understand how to create analytics workbooks and various types of interactive visualizations.
- Understand how to create dashboards and dashboard prompts.
- How to publish content into dashboards and share with others.

# Answers
While Visual Analyzer is used to explore your data and discover patterns and analmalies, Answers and Dashboards provide an environment for building richly visual reports and dashboards for curated data.  You first create one or more analysis (Answers workbooks) and dashboard prompts, and then assemble them on interactive dashboards.

Note:  There are several views that are part of this workbook – save frequently to avoid losing work.

### **Step 1:** Create new analysis
- Select Analysis from the main BICS page.

    ![](images/L400/p2.png)

    ![](images/L400/p3.png)

    ![](images/L400/p4.png)

### **Step 2:** Expand and drag the following items to the ‘Selected Columns’ area.  Use the <CTRL\> key to multi-select items, folder by folder.
- Select and drag and drop items to selected columns region from left to right.

    ![](images/L400/p5.png)

- Include only the past four quarters.

    ![](images/L400/p6.png)

    ![](images/L400/p7.png)

- Calculate sales returns as a percentage of sales (rather than dollar value amount).  Enter this calculation:  "Measures"."Sales Returns"/"Measures"."Sales"

    ![](images/L400/p8.png)

    ![](images/L400/p9.png)

- Highlight return percentages that are high.

    ![](images/L400/p10.png)

    ![](images/L400/p11.png)

    ![](images/L400/p12.png)

    ![](images/L400/p13.png)

- Next format the Sales Return Pcnt value.  Select Data Format.

    ![](images/L400/p14.png)

    ![](images/L400/p15.png)

### **Step 3:** Create a Pivot Table  
- Click on the Results tab and then (lower left) create new View and select Pivot Table.

    ![](images/L400/p16.png)

- Drag year and quarter to the Columns Region.

    ![](images/L400/p17.png)

- We’ll add a total.

    ![](images/L400/p18.png)

- We’ll also have this view communicate context for other views in the workbook.  Select Sales Returns Pcnt column properties.

    ![](images/L400/p19.png)

- Select Interaction tab and create ‘channel’ C1.  Click OK when finished.

    ![](images/L400/p20.png)

- Now graph the results to enhance the visual information.

    ![](images/L400/p22.png)

    ![](images/L400/p23.png)

    ![](images/L400/p24.png)

- Then ‘done’

    ![](images/L400/p25.png)

- Drag and drop the Pivot Table between the Title and the Table views.

    ![](images/L400/p26.png)

### **Step 4:** Complete Table View
- Edit the table view.

    ![](images/L400/p27.png)

- Drag and drop the following items to the table view.  Be sure to place items between existing columns.

    ![](images/L400/p28.png)

    ![](images/L400/p29.png)

- Edit Table View to format results.

    ![](images/L400/p30.png)

- Drag and drop year, quarter, and brand category to the Table Prompts region.

    ![](images/L400/p31.png)

    ![](images/L400/p32.png)

- One last thing – edit properties and specify channel C1 whereby the table view will respond to Pivot Table selections.

    ![](images/L400/p33.png)

    ![](images/L400/p34.png)

- Now when you highlight/select an item in the Pivot Table other views listening on channel C1 will respond.  Select the highlighted item below to observe the behavior.

    ![](images/L400/p35.png)

- Select the `Save Analysis` icon upper left.  Enter `Customer Analysis`

    ![](images/L400/p36.png)
    
    ![](images/L400/p36.1.png)

# Dashboards
### **Step 1:**  Create Dashboard prompts
- Return to the main Cloud Service tab and select `Catalog`.

    ![](images/L400/p37.png)

- On the left select ‘new’ icon and select Dashboard Prompt.

    ![](images/L400/p38.png)

- Select Customer Activity Subject Area.

    ![](images/L400/p39.png)

- Select create new column prompt.

    ![](images/L400/p40.png)

- Choose year.

    ![](images/L400/p41.png)

- Accept defaults.

    ![](images/L400/p42.png)

- Add a second column prompt for quarter.  Set defaults to 2015 Q3 and Q4, and 2016 Q1 and Q2.  Note these can be dynamic and relative to the current month (or any other variable).

    ![](images/L400/p43.png)

    ![](images/L400/p44.png)

    ![](images/L400/p45.png)

    ![](images/L400/p46.png)

- Save Prompt.

    ![](images/L400/p47.png)

- Call it `Time Prompt`.

    ![](images/L400/p48.png)

### **Step 2:**  Create Dashboard
- Go back to Catalog and select new Dashboard.

    ![](images/L400/p49.png)

    ![](images/L400/p50.png)

    ![](images/L400/p50.1.png)

- Ignore this error.

    ![](images/L400/p50.2.png)

- Expand the catalog and drag the Time Prompt and the Customer Activity Dashboard on to the Dashboard Page at the top.  Then drag your saved analysis workbook on to the dashboard just below the dashboard prompt.

    ![](images/L400/p52.png)

- After saving, run the Dashboard.

    ![](images/L400/p53.png)

    ![](images/L400/p54.png)

# Optional - Analytics for Mobile Devices
Any and all content created in BICS is automatically available on your smart phone or tablet.  The content you created in this lab can be accessed as follows:

### **Step 1:**  Install the Oracle BI Mobile Application from the play store
- Go to the Play Store and search for Oracle.  Install App.
- Start the Oracle BI Mobile Application and select Connections.  Enter the following:
- Host:  **businessintelltrial1147-gse00001082.analytics.us2.oraclecloud.com** (see below for where to get this URL)
- Port:  **443**
- SSL/TLS:  **on**
- Userid / Password:  Use the userid/pw you have been using in this lab.  In this case the user is lisa.jones.

    ![](images/L400/p55.png)

# Optional - Review SampleApp content
- Go back to the Catalog and select SampleApp.

    ![](images/L400/p56.png)

    ![](images/L400/p57.png)
    
