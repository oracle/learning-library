# Analyze Audit Data with Reports and Alerts in Oracle Data Safe
## Introduction
Using Data Safe, access, interpret, and manipulate reports in Oracle Data Safe so that you can improve the overall security of your databases.

### Objectives
In this lab, you learn how to do the following:
1. View and close alerts
2. Analyze open alerts from the dashboard
3. View all audit records for the past week
4. View a summary of audit events collected and alerts raised
5. Create a failed logins report

### Requirements
To complete this lab, you need to have the following:
- Login credentials for your tenancy in Oracle Cloud Infrastructure
- An Oracle Data Safe service enabled in a region of your tenancy
- A registered target database in Oracle Data Safe with sample audit data
- An audit policy created on your target database, alerts configured, and an audit trail started. If not, see [Auditing Lab 1 - Provision Audit and Alert Policies and Configure an Audit Trail in Oracle Data Safe](https://github.com/labmaterial/adbguides-dev/blob/master/adb-datasafe/Auditing%20Lab%201.md).

### Challenge
Follow these general steps:
1. Sign in to the Oracle Data Safe Console for your region.
2. View the report that shows you all audited activities. Try to determine which statements are expected and which might be related to a breach. How many privilege changes have occurred? (Hint: **All Activity** report)
3. Find out who is causing alerts in your target database and what they are doing? Which alerts can you close and why? (Hint: **All Alerts** report).
4. Find out how many client hosts have connected to your target database in the last month (Hint: **Audit Summary** report).
5. Create a report named Failed Logins in PDF format for your auditors. Only show failed logins in the report (Hint: **Login Activity** report).
6. Create a report to see which client programs are using the HCM1 database account and understand the activities being performed (Hint: **All Activity** report).
7. Explore which user entitlements were changed (Hint: **User/Entitlement Changes** report).
8. Explore which audit policies were changed (Hint: **Audit Policy Changes** report).
9. View the report that shows you who viewed the EMPLOYEES table (Hint: **Data Access** report).
10. View the report that shows you who modified key tables, such as the EMPLOYEES table (Hint: **Data Modification** report).
11. View the report that shows you which schema objects were modified by the ADMIN user (Hint: **Database Schema** Changes report).

**Note:**
The totals and data in your reports will most likely be different than the reports shown here.

## STEP 1: Explore the All Activity report to view and analyze audit data

- In the Oracle Data Safe Console, click the **Reports** tab.
- On the left, click **Activity Auditing**.
1. You can open reports by clicking them in the left pane or by clicking their links in the content pane.
2. The content pane lists all of the reports available to you.
- Click the audit report named **All Activity**. This report shows all of your audit records

   ![](./images/Img127.png " ")
- Notice that the report is automatically filtered to show one week's worth of audit data.

   ![](./images/Img128.png " ")
- To change the columns that are displayed in the report, do the following:
1. Click the plus sign to the right of the column headings.
2. In the **Select Columns** dialog box, select and deselect columns.
3. Click Apply.

- In the report, identify the following activities. Try to determine which statements are expected and which might be related to a breach. Create filters to help you find the information. Click on the **+ Filter** button to add these filters.

   ![](./images/Img129.png " ")
Logins made by the HCM1 user. To do this, create two filters: <br>
1) **Event = LOGON** <br> 
2) **DB User = HCM1**.
- Let's take a look at a few of the other items:
   ![](./images/Img130.png " ")
1. **DDL statements**. To do this, at the top of the report, click **DDLs**.
2. **DML statements**. To do this, at the top of the report, click **DMLs**.
3. **User entitlement changes**. To do this, at the top of the report, click **Privilege Changes**.
4. **User changes**. To do this, at the top of the report, click **User Changes**.
- At the top of the report, view totals for targets, DB users, client hosts, login successes, login failures, user changes, privilege changes, DDLs, and DMLs. How many privilege changes do you see?

   ![](./images/Img131.png " ")

## STEP 2: Explore the All Alerts Report

Find out who is causing alerts in your target database and what they are doing. The alerts are generated based on the alert conditions configured and audit data retrieved from the audit trail.

   ![](./images/Img132.png " ")
- Click the **Alerts** tab.
- The **All Alerts** report is displayed by default.
- At the top of the **All Alerts** page, click **Summary**.
- View the total number of target databases, critical alerts, high risk alerts, medium risk alerts, and open alerts.
At a glance, you can better understand whether the security of your database is in jeopardy and how you should prioritize your work.
- The **DB User** column identifies who is doing the action.
- The **Operation** column identifies the action.
- The **Alert Severity** column indicates how serious the action is.
- You can manage alerts by changing their statuses to **Open** or **Closed**.

   ![](./images/Img133.png " ")
- Click an alert ID to view its details. The **Alert Details** dialog box is displayed.
- If you want to view all the fields, click **Show Fields With No Data**.

   ![](./images/Img134.png " ")
- Expand **Additional SQL**.
All the fields on this screen are retrieved from the target database audit trail.

   ![](./images/Img135.png " ")
   ![](./images/Img136.png " ")
- Close the dialog box.

   ![](./images/Img137.png " ")
- Click **Active Filters**.
- Filter by **Alert Severity = CRITICAL** or **Alert Severity = HIGH**, depending on whether there are CRITICAL alerts or not.
- Click the first alert ID to view its detail, and then close the dialog box.

   ![](./images/Img138.png " ")
- Set the status of the first alert to **Closed**. This is an action you can take after you review an alert and decide that the issue is resolved.
- To view open alerts only, move the slider at the top of the report to the right. The report, by default, is filtered this way.

## STEP 3: Explore the Audit Summary report

Find out how many client hosts have connected to your target database in the last week.
- Click the **Reports tab**.
- In the left pane, click **Summary Reports** and then on **Audit Summary**.

   ![](./images/Img139.png " ")
- This is a graphical report that shows you a summary of events collected and alerts raised. You can gain an understanding of the activity trends for one or more of your target databases. 
- To filter the time period for the report, at the top, select **Last 1 Week**, and then click **Apply**.

   ![](./images/Img140.png " ")
- To filter the target database for the report, do the following:

   ![](./images/Img141.png " ")
  - Click **All Targets**. The **Select Targets** dialog box is displayed.
  - Deselect the check box for **All Targets**.
  - Click the field and select your database.
  - Click **Done**.

   ![](./images/Img142.png " ")

- View the summary totals to learn how many target databases are represented in the charts, how many users have been audited, and how many client hosts have connected to your target databases.
How many client hosts have connected to your database?
- Take a close look at the graphs.
  1. The **Open Alerts** graph compares the number of critical, high, and medium open alerts over time.
  2. The **Admin Activity** graph compares the number of logins, database schema changes, audit setting changes, and entitlement changes over time.
  3. The **Login Activity** chart compares the number of failed and successful logins over time.
  4. The **All Activity** chart compares the total number of events over time.

## STEP 4: Create a failed logins report in PDF format

   ![](./images/Img143.png " ")
- Click the **Reports** tab.
- In the left pane, click **Activity Auditing**, and then click **Login Activity**.

   ![](./images/Img144.png " ")
- Set a filter by selecting **Operation Status= FAILURE**.
- Click **Apply**.
   ![](./images/Img145.png " ")
- Save the report:
1. From the **Report Definition** menu, select **Save As New**.
2. In the **Save As** dialog box, enter the report name **<user name> Failed Logins**, for example, and **Failed Logins Report** as a description.
3. Enter an optional description.
4. Select your resource group.
5. Click **Save As**. A confirmation message states "Successfully created the report.".
   
   ![](./images/Img146.png " ")
   ![](./images/Img147.png " ")

- Click the **Reports** tab.
At the top of the report list, under **Custom Reports**, click the name of your **failed logins** report.
(If your custom report is not listed, please refresh the browser window.)

   ![](./images/Img148.png " ")

   ![](./images/Img149.png " ")
- Click **Generate Report**. The Generate Report dialog box is displayed.
1. Leave **PDF** selected.
2. Select your resource group.
3. Click **Generate Report**.

   ![](./images/Img150.png " ")
- Wait for the report to generate. A confirmation message states that the report is generated successfully.

   ![](./images/Img151.png " ")
- Click **Download Report**. The report is downloaded to your browser.
- Click the **Failed Logins.pdf** file to open and view it.

   ![](./images/Img152.png " ")
- When you are finished, close the browser tab for the report.

## STEP 5: Explore the Data Access Report

View this report to find out who viewed the EMPLOYEES table.
- Click the **Reports** tab.
- In the left pane under **Activity Auditing**, click **Data Access**.
- Set a filter by selecting **OBJECT = EMPLOYEES**.

   ![](./images/Img153.png " ")
- Who saw this data?
- Click a row to see the SQL executed.

## STEP 6: Explore the Data Modification report

View this report to find out who modified key tables, such as the `EMPLOYEES` table. The `EMPLOYEES` table contains sensitive information.
- Click the **Reports** tab.
- In the left pane under **Activity Auditing**, click **Data Modification**.
- Set a filter by selecting **OBJECT = EMPLOYEES**.
- Click **Apply**.
- Examine the report.
- Notice that `ATILLA` tried to change some data and failed.
- Click any row and view the SQL text to note the type of change made.
- Notice that in some cases, `ATILLA` tried to update the `SALARY` data, but failed.

## STEP 7: Explore the Database Schema Changes report
View this report to identify which schema objects were modified by the ADMIN user.
- Click the **Reports** tab.
- In the left pane under **Activity Auditing**, click **Database Schema Changes**.
- Set a filter by selecting **DB User = SYS**.
- Click **Apply**.
- Examine the report to view the changes made by the **SYS** user.
- Click a row to view the details.

## Acknowledgements

*Great Work! You successfully completed the Data Safe Auditings Lab 2*

- **Author** - Jayshree Chatterjee
- **Last Updated By/Date** - Kris Bhanushali, September 2020


## See an issue or have feedback?  
Please submit feedback [here](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1).   Select 'Autonomous DB on Dedicated Exadata' as workshop name, include Lab name and issue / feedback details. Thank you!