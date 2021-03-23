# Discover Sensitive Data with Oracle Data Safe

## Introduction
Using Oracle Data Safe, discover sensitive data in a target database with the Data Discovery wizard and identify dictionary-based and non-dictionary referential relationships, in a sensitive data model, to modify and analyze results and reports.

### Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

## Objectives
In this lab, you learn how to do the following:
- Discover sensitive data in a target database with the Data Discovery wizard.
- Identify dictionary-based and non-dictionary referential relationships in a sensitive data model.
- Modify a sensitive data model in the Data Discovery wizard and perform incremental updates.
- Analyze the data discovery results and report.
- View, download, and delete a sensitive data model from the Library.

## Challenge
Suppose that you want to share your database with the Research and Development (R&D) team for a project that they are working on. The database contains sensitive data, therefore, you first need to understand what sensitive data you have so that you can mask it before sharing it with the R&D team.

While you are working on the challenge, think about the following questions:
- What are the top-level categories of predefined sensitive types?
- What is the purpose of the "Non-dictionary referential relationships discovery" option?
- How many potential non-dictionary referential relationships did you discover?
- Do the majority of your sensitive columns fall under certain sensitive categories or is it fairly distributed?
- Did you find any false positives?
- Does your sensitive data model include any referential relationships? Can you remove them?
- How many sensitive columns and sensitive types did you discover?
- How many tables contain the discovered sensitive columns?

## Steps

### **Step 1:** Sign in to the Oracle Data Safe Console for your region

- From the navigation menu, click **Data Safe**

![](./images/dbsec/datasafe/login/navigation.png " ")

- You are taken to the **Registered Databases** Page.
- Click on **Service Console**

![](./images/dbsec/datasafe/login/service-console.png " ")

- You are taken to the Data Safe login page. Sign into Data Safe using your credentials.

![](./images/dbsec/datasafe/login/sign-in.png " ")

### **Step 2:** Use the Data Discovery wizard to discover sensitive data

- To access the Data Discovery wizard, click the **Home** tab, and then click **Data Discovery**.

![](./images/dbsec/datasafe/discovery/discovery-nav.png " ")

   - On the Select Target for Sensitive Data Discovery page, your target database is listed.
   - Often, you want to perform data discovery against a production database where you can get an accurate and up-to-date picture of your sensitive data. You can discover sensitive data in the source database (a production or copy) and mask the cloned copies of this source database. Or, you can simply run a data discovery job on the actual database that you want to mask.
   - Select your target database, and then click **Continue**.

![](./images/dbsec/datasafe/discovery/target.png " ")

  - Next, the **Select Sensitive Data Model** page is displayed. On this page, you can create a new sensitive data model, select an existing one from the Library, or import a file-based sensitive data model.

![](./images/dbsec/datasafe/discovery/sdm1.png " ")
- Leave **Create** selected.
- Name the sensitive data model as **<username>SDM1**.
- Enable **Show and save sample data** so that Data Discovery retrieves sample data for each sensitive column, if it's available.
- Select your resource group.
- Click **Continue**.
- On the **Select Schemas for Sensitive Data Discovery** page, select the schema that you want Data Discovery to search. In this case, select the **HCM1** schema, and click **Continue**.

![](./images/dbsec/datasafe/discovery/select-schema.png " ")

- On the **Select Sensitive Types for Sensitive Data Discovery** page, you select the sensitive types that you want to discover. Data Discovery categorizes its sensitive types as Identification Information, Biographic Information, IT Information, Financial Information, Healthcare Information, Employment Information, and Academic Information. Do the following:
- **Expand all** the categories by moving the Expand All slider to the right to view each sensitive type. Notice that you can select individual sensitive types, sensitive categories, and all sensitive types.
- Scroll down the list and review the sensitive types available.

![](./images/dbsec/datasafe/discovery/sensitive-types-un.png " ")

- Return to the top of the list and select the **Select All** check box.
- At the bottom of the page, select the **Non-Dictionary Relationship Discovery** check box.<br>
  Oracle Data Safe automatically discovers referential relationships defined in the data dictionary. The **Non-Dictionary Relationship Discovery** feature helps to identify application-level parent-child relationships that are not defined in the data dictionary. It helps discover application-level relationships so that data integrity is maintained during data masking.
- When you are ready to start the data discovery job, click **Continue**.
- Wait for the job to finish.

![](./images/dbsec/datasafe/discovery/discovery-finished.png " ")

- If the job is successful, the **Detail** column states Data discovery job finished successfully, and you can click **Continue**. Otherwise, you need to click **Back** or **Exit** and investigate the issue.

### **Step 3:** Review and fine tune your sensitive data model

- On the **Non-Dictionary Referential Relationships** page, you are presented with a list of potential non-dictionary (application level) referential relationships that Data Discovery found by using column name patterns and column data patterns. Do the following:
  - To view all of the columns, move the **Expand All** slider to the right. Data Discovery found some potentially sensitive columns (non-dictionary referential relationships) in the `HR` schema.

![](./images/dbsec/datasafe/discovery/non-dictionary.png " ")

  - Click **Save** and **Continue**.<br>
  The **Sensitive Data Discovery Result** page is displayed. On this page, you can view and manage the sensitive columns in your sensitive data model. Your sensitive data model is saved to the Library.

![](./images/dbsec/datasafe/discovery/sdd-results.png " ")

- Notice that Data Discovery found sensitive columns in all three sensitive categories that you selected. To view the sensitive columns, move the **Expand All** slider to the right. The list includes the following:
  - Sensitive columns discovered based on the sensitive types that you selected
  - Dictionary-based referential relationships
  - Non-dictionary referential relationships
- Take a look at how the sensitive columns are organized. Initially, they are grouped by sensitive categories and sensitive types.
- To list the sensitive columns by schema and table, select **Schema View** from the drop-down list next to the **Expand All Slider**. **Schema View** is useful for quickly finding a sensitive column in a table and for viewing the list of sensitive columns in a table. For example, in the `EMPLOYEES` table there are several sensitive columns listed.
- If needed, you can add and remove sensitive columns from your sensitive data model. Sensitive columns that have a check box are removable. To remove a sensitive column from your sensitive data model, you deselect its check box. You can use the **Add** button to add more sensitive columns.
- Notice that some of the sensitive columns do not have a check box. These are dependent columns. They have a relationship with their parent column. For example, in the `EMPLOYEES` table, `JOB_ID` is listed. It has a relationship defined in the Oracle data dictionary to the `JOBS.JOB_ID` sensitive column. If you remove a sensitive column that has a referential relationship, both the sensitive column and referential relationship are removed from the sensitive data model. Therefore, if you deselect `JOBS.JOB_ID`, then `EMPLOYEES.JOB_ID` is removed too.
- View the sample data for the `HCM1.SUPPLEMENTAL_DATA.LAST_INS_CLAIM` column.<br/>
The sensitive type is **Healthcare Provider** and the discovered sensitive column is `LAST_INS_CLAIM`, which has values such as `Cavity` and `Hair Loss`. Your value may be different. This column isn't a Healthcare Provider type of column and thus it is a false positive. You can deselect this column. Being able to remove a sensitive column is important when your sensitive data model includes false positives. To be able to recognize false positives, it helps to know your data well.

> **Tip:**<br>
To quickly locate a sensitive column, enter the name or part of the name in the search box.

### **Step 4:** Modify your search for sensitive data and re-run the data discovery job

Suppose that you're missing some sensitive columns in your sensitive data model. While working in the Data Discovery wizard, you can backtrack to reconfigure and rerun the data discovery job. You can repeat the process as many times as you need until you feel that your sensitive data model is accurate. Try the following:

- Click **Back** <br>
Now you are on the **Select Sensitive Types for Sensitive Data Discovery** page. Here you can change your sensitive type selections and choose whether to include non-dictionary referential relationships in the search.
- Select all of the sensitive categories.

![](./images/dbsec/datasafe/discovery/select-all.png " ")

- Deselect **Non-Dictionary Relationship Discovery**.

![](./images/dbsec/datasafe/discovery/deselect-non.png " ")

- To rerun the data discovery job, click **Continue**.
- When the job is finished, click **Continue**.
Because you chose to not discover non-dictionary referential relationships, the wizard takes you directly to the **Sensitive Data Discovery Result** page.
- Expand all of the sensitive columns and review the results.

![](./images/dbsec/datasafe/discovery/expand-all.png " ")

- To view the newly discovered sensitive columns, click **View newly discovered sensitive columns only**. Notice that Data Discovery found additional sensitive columns.

### **Step 5:** View the Sensitive Data Discovery report and analyze the report data

- Scroll down and click **Report** at the bottom right corner of the screen.<br>
The report shows you a chart that compares sensitive categories. You can also view totals of sensitive values, sensitive types, sensitive tables, and sensitive columns. The table at the bottom of the report displays individual sensitive column names, sample data for the sensitive columns, column counts based on sensitive categories, and estimated data counts.

![](./images/dbsec/datasafe/discovery/report.png " ")

- Analyze the data:
  - To drill-down into a sensitive category in the chart, position your mouse over the chart, and then click the **Expand** button.

![](./images/dbsec/datasafe/discovery/expand-all-2.png " ")

![](./images/dbsec/datasafe/discovery/expand-arrows.png " ")

  - To drill-up, position your mouse over an expanded sensitive category, and then click the **Collapse** button.
  - To enlarge the chart, click the **Expand** button (double-arrows) in the bottom right corner. View the chart and click **Close**.
  - Expand the list of sensitive columns and review the information.

![](./images/dbsec/datasafe/discovery/expand-list.png " ")
  - Click **Exit**.

![](./images/dbsec/datasafe/discovery/exit-sdm1.png " ")

- To access the report from the Reports tab, do the following:
  - Click the **Reports** tab.

![](./images/dbsec/datasafe/discovery/reports-tab.png " ")

  - Scroll down, and under **Discovery Reports**, click **Data Discovery**.
  - Click your sensitive data model to open the report.

### **Step 6:** View your sensitive data model in the Library
- Click the **Library** tab.
- Click **Sensitive Data Models**.<br>
The Sensitive Data Models page is displayed, listing the sensitive data models to which you have access.
For each sensitive data model, you can view information about when your sensitive data model was created, when it was last updated, and who owns it.

![](./images/dbsec/datasafe/discovery/library-page.png " ")

- Click the name of your sensitive data model to open it.

![](./images/dbsec/datasafe/discovery/ssd-model.png " ")

- To return to the **Sensitive Data Models** page, click the **Library** tab, and then click **Sensitive Data Models**.
- If you need to remove your sensitive data model from the Library, you can select the check box for it, and click **Delete**.

> **Note:**<br>
Keep your sensitive data model so that later you can use it for masking sensitive data in **Masking Lab 4 - Configure a Variety of Masking Formats with Oracle Data Safe**.

### **Step 7:** Download your sensitive data model
- Select the check box for your sensitive data model.
- Click **Download**.
Your sensitive data model is downloaded to your browser.
- Open the file, and review the XML code.
- Save the file to your desktop as **<username> SDM1.xml**, and then close the file.<br>
In **Masking Lab 4 - Configure a Variety of Masking Formats with Oracle Data Safe**, you import this file-based sensitive data model into the Data Masking wizard.

### All Done!
