# Discover and Mask Sensitive Data

## Introduction
This lab shows you how to discover and mask sensitive data in your Autonomous Database by using the Data Discovery and Data Masking features in Oracle Data Safe.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you'll:

- View sensitive data in your database
- Discover sensitive data in your database by using the Data Discovery feature
- Mask sensitive data in your database by using the Data Masking feature
- Create a PDF of the Data Masking report
- Validate the masked data in your database


### Prerequisites

To complete this lab, you need to have the following:

- An Oracle Cloud account
- Access to an Autonomous Database as the `ADMIN` user, sample data for Oracle Data Safe loaded into the database, and the Discovery and Masking features enabled on your database
- Access to an Oracle Data Safe service
- Privileges to use the Discovery and Masking features on your database

### Assumptions

- You have a browser tab signed in to the Oracle Cloud Infrastructure Console. If not, please refer to the [Prerequisites](?lab=prerequisites) for this workshop.
- You completed the [Provision and Register and Autonomous Database](?lab=lab-1-provision-register-autonomous) lab in this workshop.
- Your data values will be different than those shown in the screenshots in this lab.



## **STEP 1**: View sensitive data in your database

In this step, you use SQL Developer Web to query sensitive data in your database. You can access SQL Developer Web from your database's Console.

1. Select the browser tab that is signed in to the Oracle Cloud Infrastructure Console. If needed, sign in again.

2. In the Oracle Cloud Infrastructure Console, make sure the correct region is selected in your tenancy.

3. From the navigation menu, select **Autonomous Transaction Processing**.

4. Under **COMPARTMENT**, make sure that your compartment is selected.

5. Click the name of your database.

6. On the **Autonomous Database Details** page, click the **Tools** tab.

7. In the **SQL Developer Web** section, click **Open SQL Developer Web**. The **Oracle Database Actions | Sign in** page is opened.

8. In the **Username** field, enter `ADMIN`. In the **Password** field, enter the password that you created for the `ADMIN` user when you provisioned the database. Click **Sign In**.

9. If a help note is displayed, click the **X** button to close it.

10. On the **Navigator** tab, select the `HCM1` schema from the first drop-down list. In the second drop-down list, leave **Tables** selected.

  ![Navigator tab in SQL Web Developer](images/select-hcm1.png)

11. Drag the `EMPLOYEES` table to the worksheet.

  ![EMPLOYEES table](images/drag-employees-table-to-worksheet.png)

12. When prompted to choose an insertion type, click **Select**, and then click **Apply**.

   ![Choose the type of insertion dialog box](images/insertion-type-select.png)

13. View the SQL query on the worksheet.

   ![Worksheet tab showing EMPLOYEES table](images/query-employees-table.png)

14. On the toolbar, click the **Run Statement** button (green circle with a white arrow) to execute the query.

 ![Run Statement button on toolbar](images/run-statement-button.png)

15. Review the query results. If needed, click the **Query Result** tab.

    - Data such as `employee_id`, `first_name`, `last_name`, `email`, `phone_number`, and `hire_date`, are considered sensitive data and should be masked if shared for non-production use, such as development and analytics.

    - Keep this tab open so that you can return to it later. In step 4, you compare the original query results with the masked data.

  ![Query results](images/original-query-results.png)





## **STEP 2**: Discover sensitive data by using Data Discovery

The Data Discovery wizard generates a sensitive data model that contains sensitive columns in your target database. When working in the wizard, you select the sensitive types that you want to discover in your target database.


1. Return to the browser tab for the Oracle Cloud Infrastructure Console. If needed, sign in again.

2. From the navigation menu, select **Data Safe**. The **Overview** page for the Oracle Data Safe service is displayed.

3. Click **Service Console**. The **Home** page in the Oracle Data Safe Console is displayed.


4. To access the Data Discovery wizard, click the **Data Discovery** tab.


5. On the **Select Target for Sensitive Data Discovery** page, select your target database, and then click **Continue**.

 ![Select Target for Sensitive Data Discovery page](images/select-target-for-sensitive-data-discovery.png)


6. On the **Select Sensitive Data Model** page, leave **Create** selected, enter **SDM1** for the name, enable **Show and save sample data**, select your compartment, and then click **Continue**.


7. On the **Select Schemas for Sensitive Data Discovery** page, scroll down and select the **HCM1** schema, and then click **Continue**.

  ![Select Schemas for Sensitive Data Discovery page](images/select-schemas-for-sensitive-data-discovery.png)


8. On the **Select Sensitive Types for Sensitive Data Discovery** page, expand all of the categories by moving the slider to the right, and then scroll down the page and review the sensitive types. Notice that you can select individual sensitive types, sensitive categories, and all sensitive types.

  ![Select Sensitive Types for Sensitive Data Discovery page](images/select-sensitive-types-expand-all.png)


9. At the top of the page, select the **Select All** check box, and then click **Continue** to start the data discovery job.

  ![Select All check box selected](images/select-sensitive-types-select-all.png)


10. When the job is completed, ensure that the **Detail** column states **Data discovery job finished successfully**, and then click **Continue**.

  ![Detail column](images/sensitive-data-discovery-complete.png)


11. On the **Sensitive Data Discovery Result** page, examine the sensitive data model created by the Data Discovery wizard. Oracle Data Safe automatically saves your sensitive data model to the Oracle Data Safe Library.

12. To view all of the sensitive columns, move the **Expand All** slider to the right.

    ![Sensitive Data Discovery Result page](images/sensitive-data-discovery-result.png)

13. From the drop-down list, select **Schema View** to sort the sensitive columns by table name.

    ![Schema View circled](images/schema-view.png)

14. Scroll down the page to view the sensitive columns.

    - You can view sample data (if it's available for a sensitive column) and estimated data counts.

    - In particular, take a look at the sensitive columns that Data Discovery found in the `EMPLOYEES` table. Columns that do not have a check mark, such as `MANAGER_ID`, are called referential relationships. They are included because they have a relationship to another sensitive column and that relationship is defined in the database's data dictionary.

    - Review the sample data provided to get an idea of what the sensitive data looks like.

    ![Sensitive columns list](images/employees-table-sample-data.png)


15. To generate the **Data Discovery** report, scroll to the bottom of the page, and then click **Report**.


16. Review the **Data Discovery** report.

    - The chart compares sensitive categories. You can view totals of sensitive values, sensitive types, sensitive tables, and sensitive columns.

    - The table displays individual sensitive column names, sample data for the sensitive columns, column counts based on sensitive categories, and estimated data counts.

      ![Sensitive columns table](images/data-discovery-report.png)


17. Click the chart's **Expand** button.

    ![Chart's Expand button circled](images/chart-expand-button.png)


18. Position your mouse over **Identification Info** to view statistics.

  ![Statistics](images/identification-info.png)


19. With your mouse still over **Identification Info**, click the **Expand** button to drill down.

  ![Expand button over Identification Info](images/identification-info-expand-button.png)


20. Notice that the **Identification Info** category is divided into two smaller categories (**Personal IDs** and **Public IDs**). To drill-up, position your mouse over an expanded sensitive category (for example, **Identification Info**), and then click the **Collapse** button.

  ![Collapse button over Identification Info](images/identification-info-collapse-button.png)


21. Click the **Close** button (**X**) to close the expanded chart. Continue to work in the wizard.



## **STEP 3**: Mask sensitive data by using Data Masking

The Data Masking wizard generates a masking policy for your target database based on a sensitive data model. In the wizard, you select the sensitive columns that you want to mask and the masking formats to use.

1. At the bottom of the Data Discovery report, click **Continue to mask the data**. The Data Masking wizard is displayed.


2. On the **Select Target for Data Masking** page, leave your target database selected, and click **Continue**.

   ![Select Target for Data Masking page](images/select-target-for-data-masking.png)


3. On the **Masking Policy** page, move the **Expand All** slider to the right to view all of the sensitive columns. Scroll down the page and review the default masking format selected for each sensitive column.

 ![Masking Policy page](images/masking-policy-page.png)


4. For the `HCM1.LOCATIONS.STREET_ADDRESS` column, click the arrow to the right of the masking format to view other masking formats.

  **Tip:** To quickly find a column on the page, you can enter its name in the **Search** field at the top of the page.

 ![HCM1.LOCATIONS.STREET_ADDRESS circled and masking formats drop-down list](images/view-masking-formats.png)


5. Next to the arrow, click the **Edit Format** button (pencil icon).

 ![Edit Format button](images/edit-format-button.png)


6. In the **Edit Format** dialog box, review the details for the masking format, including the datatype, description, examples, and default configuration. This is where you can modify a masking format, if needed. Click **Cancel**.

   ![Edit Format dialog box](images/edit-format-dialog-box.png)


7. At the bottom of the page, click **Confirm Policy**.

8. Wait a moment while Data Masking creates the masking policy.


9. On the **Schedule the Masking Job** page, leave **Right Now** selected, and click **Review**.

  ![Schedule the Masking Job page](images/schedule-the-masking-job-page.png)


10. On the **Review and Submit** page, review the information, and then click **Submit** to start the data masking job.

  ![Review and Submit page](images/review-and-submit-page.png)


11. Wait for the data masking job to finish. It takes a couple of minutes. You can follow the status of the job on the **Masking Jobs** page.


12. When the job is finished, click **Report**.

  ![Masking Jobs page](images/masking-jobs-page.png)


13. Examine the **Data Masking** report.

    - At the top of the report, you can view the number of masked values, masked sensitive types, masked tables, and masked columns.

    - The table shows you column counts for the sensitive categories and types. For each sensitive column, you can view the masking format used and the number of rows masked.

    ![Data Masking report](images/data-masking-report.png)


## **STEP 4**: Create a PDF of the Data Masking report

1. At the top of the report, click **Generate Report**. The **Generate Report** dialog box is displayed.

2. Leave **PDF** selected.

3. Enter **Mask1_HCM1** for the description.

4. Select your compartment.

5. Click **Generate Report** and wait for the report to generate.

6. When a confirmation message states that the **Report was generated successfully**, click **Download Report**.

7. Save the report and then open it in Adobe Acrobat.

8. Review the data, and then close the report.

 ![Data Masking report in PDF format](images/data-masking-report-pdf.png)



## **STEP 5**: Validate the masked data in your database

1. Return to SQL Developer Web. You should have a browser tab named **Oracle Database Actions | SQL Worksheet** opened from STEP 1 in this lab.

2. Take a moment to review the original data.

    ![Query results before masking](images/original-query-results.png)


3. On the toolbar, click the **Run Statement** button (green circle with a white arrow) to execute the query.

4. If you receive a message stating that your session has expired, click **OK**, sign in again, and then click the **Run Statement** button.


5. Review the masked data. You can resize the panel to view more data, and you can scroll down and to the right.

  ![Masked EMPLOYEE data](images/masked-query-results.png)





## Learn More

* [Data Discovery](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/data-discovery.html)
* [Data Masking](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/data-masking.html)

## Acknowledgements
* **Author** - Jody Glover, Principal User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, October 15, 2020


## See an issue?
  Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
