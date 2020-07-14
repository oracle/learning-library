# Discover and Mask Sensitive Data on Oracle Data Safe

## Before You Begin
### Objectives

- View sensitive data in your Autonomous Transaction Processing (ATP) database
- Discover sensitive data by using Data Discovery
- Mask sensitive data by using Data Masking
- Validate the masked data in your ATP database

### Requirements
The following items are provided to you during the lab:
- Login credentials and a tenancy name for the Oracle Cloud Infrastructure Console
- Oracle Data Safe enabled in a region of your tenancy
- An Autonomous Transaction Processing (ATP) database and the password for the `ADMIN` user account

## **STEP 1**: View sensitive data in your ATP database

In this step, you use SQL Developer Web to query sensitive data in your ATP database. You can access SQL Developer Web in the ATP Console.

- From any browser, enter the following url:

  [https://console.us-ashburn-1.oraclecloud.com/a/tenancy](https://console.us-ashburn-1.oraclecloud.com/a/tenancy)

- If prompted, enter the tenancy name provided to you during the lab, and then click **Continue**.

  Note: If you are signed in to Oracle Cloud Infrastructure on another tab, then you are not prompted to enter a tenancy name and can continue to the next step.

    ![](./images/2019-08-13%2013_59_08-Oracle%20Cloud%20Infrastructure%20_%20Sign%20In.png " ")

- Under **Oracle Cloud Infrastructure**, enter your **username** and **password**, and then click **Sign In**.

  Be sure to use the correct user name, which is similar to `dsu01`.

  Please do not change your password.

  ![](./images/oci-sign-in.png " ")


- From the navigation menu, select **Autonomous Transaction Processing**.

    ![](./images/2019-08-13%2014_00_26-Oracle%20Cloud%20Infrastructure.png " ")

- Under **COMPARTMENT**, select the **hol2019datasafe** compartment.

    ![](./images/select-compartment.png " ")

- In the list of databases, click the name of your database, for example, **dsatp01**.

    ![](./images/click-atp-database.png " ")

- Click **Service Console** to navigate to the **Autonomous Transaction Processing Console**.

  A new browser tab is opened called **Autonomous Transaction Processing | Development**.

  ![](./images/click-service-console-atp.png " ")


- If the browser prevents you from opening a pop-up window, click **Options**, and then select **Allow pop-ups for console.us-ashburn-1.oraclecloud.com**.

  ![](./images/allow-popups.png " ")


- On the **SIGN IN** page for your ATP database, enter the database credentials for the `ADMIN` user, and then click **Sign In**.

  You are provided the password during the lab.

    ![](./images/sign-in-to-ATP-ADMIN.png " ")

- On the left, click **Development**, and then on the right, click **SQL Developer Web**.

  A new browser tab named **SDW Sign in** is opened.

    ![](./images/2019-08-13%2014_03_37-Autonomous%20Transaction%20Processing%20_%20Development.png " ")


- On the **Oracle SQL Developer Web** sign in page, enter the credentials for the `ADMIN` user again, and then click **Sign in**.

    ![](./images/sign-in-to-Oracle-SDW.png " ")

- If a help note is displayed, you can click the **X** to close it.

    ![](./images/close-button-object-browser-note.png " ")


- On the **Navigator** tab, select the `HCM1` schema from the first drop-down menu. In the second drop-down menu, ensure that **Tables** is selected.

  ![](./images/2019-08-13%2014_11_21-SQL%20Developer%20_%20Worksheet.png " ")


- Drag the `EMPLOYEES` table to the worksheet. When prompted to choose an insertion type, click **Select**, and then click **Apply**.

    ![](./images/insertion-type.png " ")


- View the SQL query on the worksheet.

    ![](./images/sql-query-worksheet.png " ")


- On the toolbar, click the **Run Statement** button (green circle with a white arrow) to execute the query.

    ![](./images/run-statement-button.png " ")


- Review the query results.

  Data such as `employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_date`, `job_id`, `salary`, and `manager_id` are considered sensitive data and should be masked if shared with developers and testers.

  Keep this tab open so that you can return to it later in step 4 when you view the masked data.

     ![](./images/query-results.png " ")



## **STEP 2**: Discover sensitive data by using Data Discovery

The Data Discovery wizard generates a sensitive data model that contains sensitive columns in your target database. When working in the wizard, you select sensitive types that you want to discover in your target database.

- Open a new tab in your browser, and enter the following url. Because you signed in to Oracle Cloud Infrastructure in part 1, you should automatically sign in. If not, sign in with your your tenancy name (if needed) and user credentials.

  [https://console.us-ashburn-1.oraclecloud.com/a/tenancy](https://console.us-ashburn-1.oraclecloud.com/a/tenancy)

- From the navigation menu, select **Data Safe**.

    ![](./images/select-data-safe-in-oci.png " ")

- Click **Service Console**.

    ![](./images/click-service-console.png " ")

- If needed, sign in to Oracle Data Safe using your Oracle Cloud Infrastructure credentials.

  Be sure to use the correct user name, which is similar to `dsu01`.

  The **Home** tab is displayed when you first sign in to Oracle Data Safe.

  ![](./images/oci-sign-in.png " ")


- Access the Data Discovery wizard by clicking the **Data Discovery** tab.

  ![](./images/click-data-discovery-tab.png " ")


- On the **Select Target for Sensitive Data Discovery** page, select your target database, and then click **Continue**.

  ![](./images/select-target-for-data-discovery.png " ")


- On the **Select Sensitive Data Model** page, leave **Create** selected, enter **SDM1** for the name, enable **Show and save sample data**, select your resource group, and then click **Continue**.

  ![](./images/select-sensitive-data-model.png " ")


- On the **Select Schemas for Sensitive Data Discovery** page, scroll down and select the **HCM1** schema, and then click **Continue**.

  ![](./images/select-schemas-for-sensitive-data-discovery.png " ")

- On the **Select Sensitive Types for Sensitive Data Discovery** page, expand all of the categories by moving the slider to the right, and then scroll down the page and review the sensitive types. Notice that you can select individual sensitive types, sensitive categories, and all sensitive types.

  ![](./images/select-sensitive-types.png " ")


- At the top of the page, select the **Select All** check box, and then click **Continue** to start the data discovery job.

  ![](./images/start-discovery-job.png " ")


- When the job is completed, ensure that the **Detail** column states `Data discovery job finished successfully`, and then click **Continue**.

  ![](./images/data-discovery-job-completed.png " ")


- On the **Sensitive Data Discovery Result** page, examine the sensitive data model created by the Data Discovery wizard. To view all of the sensitive columns, move the **Expand All** slider to the right.

  Oracle Data Safe automatically saves your sensitive data model to the Oracle Data Safe Library.

  ![](./images/sensitive-data-discovery-result.png " ")


- From the drop-down list, select **Schema View** to sort the sensitive columns by table.

  ![](./images/sort-by-schema-view.png " ")


- Scroll down the page to view the sensitive columns.

    You can view sample data (if it's available for a sensitive column), column counts, and estimated data counts.

    In particular, take a look at the sensitive columns that Data Discovery found in the `EMPLOYEES` table. Columns that do not have a check mark are called referential relationships. They are included because they have a relationship to another sensitive column and that relationship is defined in the database's data dictionary.

    Also view the sample data provided to get an idea of what the sensitive data looks like.

   ![](./images/sensitive-data-employees-table.png " ")


- Scroll to the bottom of the page, and then click **Report** to view the Data Discovery report.

   The chart compares sensitive categories. You can view totals of sensitive values, sensitive types, sensitive tables, and sensitive columns.

  The table displays individual sensitive column names, sample data for the sensitive columns, column counts based on sensitive categories, and estimated data counts.

  ![](./images/data-discovery-report.png " ")


- Click the chart's **Expand** button.

  ![](./images/click-expand-chart-button.png " ")


- Position your mouse over **Identification Info** to view statistics.

  ![](./images/data-discovery-chart-stats.png " ")



- With your mouse still over **Identification Info**, click the **Expand** button to drill down.

    ![](./images/drill-down-into-chart.png " ")


- Notice that the **Identification Info** category is divided into two smaller categories (**Personal IDs** and **Public IDs**). To drill-up, position your mouse over an expanded sensitive category, and then click the **Collapse** button.

  ![](./images/drill-up-chart.png " ")

- Click the **Close** button (**X**) to close the expanded chart. Do not exit the wizard.

  ![](./images/close-chart.png " ")



## **STEP 3**: Mask sensitive data by using Data Masking
The Data Masking wizard generates a masking policy for your target database based on a sensitive data model. In the wizard, you select the sensitive columns that you want to mask and the masking formats to use.

- Click **Continue to mask the data**. The Data Masking wizard is displayed.

  ![](./images/continue-to-mask-the-data.png " ")


- On the **Select Target for Data Masking** page, your target database is selected. Click **Continue**.

  ![](./images/select-target-for-data-masking.png " ")


- On the **Masking Policy** page, move the **Expand All** slider to the right to view all of the sensitive columns. Scroll down the page to view the default masking format selected for each sensitive column.

  ![](./images/masking-policy-page.png " ")


-  For the `HCM1.LOCATIONS.STREET_ADDRESS` column, click the arrow to the right of the masking format to view other masking formats.

   ![](./images/masking-formats-dropdown.png " ")


- Next to the arrow, click the **Edit Format** button (pencil icon).

  ![](./images/edit-masking-format-pencil.png " ")


- In the **Edit Format** dialog box, view the description, examples, and default configuration for the masking format.

  This is where you can modify a masking format. Click **Cancel**.

  ![](./images/edit-masking-format-dialog-box.png " ")



- At the bottom of the page, click **Confirm Policy**, and then wait a moment while Data Masking creates the masking policy.

  ![](./images/confirm-masking-policy.png " ")



- On the **Schedule the Masking Job** page, leave **Right Now** selected, and then click **Review**.

  ![](./images/schedule-masking-job.png " ")



- On the **Review and Submit** page, review the information, and then click **Submit** to start the data masking job.

  ![](./images/review-and-submit.png " ")

- Wait for the data masking job to finish. It takes a couple of minutes. You can follow the status of the job on the **Masking Jobs** page. When the job is completed successfully, click **Report**.

  ![](./images/masking-complete.png " ")


- Examine the **Data Masking** report.

  The report shows you how many values, sensitive types, tables, and columns were masked.

  For each sensitive column, the report shows you a sample masked value (if available), the masking format used, and the number of rows masked.

  The table also shows you column counts for the sensitive categories and types.

  ![](./images/data-masking-report.png " ")


- Click **Generate Report**.

  ![](./images/generate-report.png " ")


- In the **Generate Report** dialog box, leave **PDF** selected, enter **Mask1_HCM1** for the description, ensure your resource group is selected, and then click **Generate Report**.

  ![](./images/generate-masking-report.png " ")



- Wait for the report to generate. When it's generated, click **Download Report**.

  ![](./images/download-masking-report.png " ")


- In the **Opening Data Masking.pdf** dialog box, leave **Save File** selected, and click **OK**. The report is downloaded to the browser as `Data Masking.pdf`.

  ![](./images/opening-data-masking-pdf-dialog-box.png " ")


- Access the browser's downloads and open the report in Adobe Acrobat.

  ![](./images/data-masking-pdf.png " ")


- Review the report, and then close it.

  ![](./images/data-masking-report-pdf.png " ")



## **STEP 4**: Validate the masked data in your ATP database

- Return to the browser tab for **SQL Developer Web**. You should still have your query results from step 1 in this lab. Take a moment to review the data.

   ![](./images/sql-developer-old-query-results.png " ")



- On the toolbar, click the **Run Statement** button (green circle with a white arrow) to execute the query.

  ![](./images/run-statement-button.png " ")


- If a dialog box is displayed stating that your session has expired, click **OK**, sign in again, and then click the **Run Statement** button.

  ![](./images/session-expired.png " ")


- Review the masked data.

  You can resize the panel to view more data, and you can scroll down and to the right.

  ![](./images/masked-data.png " ")

## Conclusion
Congratulations! You have completed this workshop.
