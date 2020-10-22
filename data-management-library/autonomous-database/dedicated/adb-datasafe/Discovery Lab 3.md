# Update a Sensitive Data Model with Oracle Data Safe
## Introduction
Using Oracle Data Safe, perform an incremental update to a sensitive data model by using the Data Discovery wizard.

### Objectives
In this lab, you learn how to do the following:
- Perform an incremental update to a sensitive data model by using the Data Discovery wizard

### Challenge
Suppose your ATP-D database has a new column added to it and you want to update your sensitive data model to include that column.

Follow these general steps:
1. Connect to your ATP-D database as the ADMIN user with SQL Developer Web.
2. In SQL Developer Web, add an AGE column to the HCM1.EMPLOYEES table in your ATP-D database. Gather schema statistics on your database.
3. Sign in to the Oracle Data Safe Console in your region.
4. In the Oracle Data Safe Console, update your sensitive data model against your target database by using the update option in the Data Discovery wizard. What does the update test find?

## STEP 1: Add a sensitive column to a table

Connect to ATP-D DB using SQL Developer Web

Refer Step 5 from [Lab - Assess Users with Oracle Data Safe](https://github.com/labmaterial/adbguides-dev/blob/master/adb-datasafe/Assessment%20Lab%202.md)

In SQL Developer Web, add an `AGE` column to the `HCM1.EMPLOYEES` table in your ATP-D database.

- On the SQL Worksheet, run the following commands to add an `AGE` column to the `EMPLOYEES` table.
```
<copy>ALTER TABLE HCM1.EMPLOYEES ADD AGE NUMBER;</copy>
```
- On the Navigator tab, click the Refresh button.<br>
`AGE` is added to the bottom of the list in the `EMPLOYEES` table.
- Run the following command to gather schema statistics.
```
<copy>EXEC DBMS_STATS.GATHER_SCHEMA_STATS('HCM1');</copy>
```
- Keep this tab open to be returned to later.

## STEP 2: Update your sensitive data model

Sign in to the Oracle Data Safe Console in your region

Refer [Lab - Register a Target Database (ATP-D) with Oracle Data Safe](https://github.com/labmaterial/adbguides-dev/blob/master/adb-datasafe/Register%20a%20Target%20Database.md)

Update your sensitive data model against your database by using the update option in the Data Masking wizard

- In the Oracle Data Safe Console, click the **Home** tab, and then click Data Discovery. The Select Target for **Data Discovery** page is displayed.
   ![](./images/Img25.png " ")
- Select your target database, and then click **Continue**. The **Select Sensitive Data Model** page is displayed.
- For Sensitive Data Model, click **Pick from Library**.
   ![](./images/Img51.png " ")
- Click **Continue**. The **Select Sensitive Data Model** page is displayed.
- Select your sensitive data model (**SDM1**).
   ![](./images/Img54.png " ")
- Leave **Update the SDM with the target** selected.
- Click **Continue**. The wizard launches a data discovery job.
- When the job is finished, notice that the **Detail** column reads **Data discovery job finished successfully**.
- Click **Continue**. The **Sensitive Data Model: <username> SDM1** page is displayed.
- Notice that you have the newly discovered sensitive column, `AGE`. Only newly discovered columns are displayed at the moment.
- **Expand all** of the nodes.
- To view all of the sensitive columns in the sensitive data model, click **View all sensitive columns**.
- You can toggle the view back and forth between displaying all of the sensitive columns or just the newly discovered ones.
- Click **Exit**.

## Acknowledgements

*Great Work! You successfully completed the Data Safe Discovery Lab 3*

- **Author** - Jayshree Chatterjee
- **Last Updated By/Date** - Kris Bhanushali, September 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/autonomous-database-dedicated). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.




