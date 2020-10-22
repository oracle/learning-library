# Create a Custom Masking Format in Data Safe
## Introduction
Using Data Safe, create a masking format and assign a default masking format to a user-defined sensitive type.

### Objectives
In this lab, you learn how to do the following:
- Create a masking format.
- Assign a default masking format to a user-defined sensitive type.

### Challenge
You have department IDs in your target database that you need to mask. You decide to create a masking format in Oracle Data Safe to mask the data.

Follow these general steps:
1. Sign in to your ATP-D database as the ADMIN user with SQL Developer Web.
2. In SQL Developer Web, research the `DEPARTMENT_ID` column in your target database to help you figure out how to create a masking format for it.
3. Sign in to the Oracle Data Safe Console for your region.
4. In the Oracle Data Safe Console, create a masking format to mask the `HCM1.DEPARTMENT_ID` column in your target database.
5. Select your masking format as the default masking format for the sensitive type that you created in [Discovery Lab 4 - Create a Sensitive Type and Sensitive Category with Oracle Data Safe](https://github.com/labmaterial/adbguides-dev/blob/master/adb-datasafe/Discovery%20Lab%204.md) (**Custom Department ID Number**).

## STEP 1: Create a custom masking format

Connect to ATP-D DB using SQL Developer Web

Refer Step 5 from [Lab - Assess Users with Oracle Data Safe](https://github.com/labmaterial/adbguides-dev/blob/master/adb-datasafe/Assessment%20Lab%202.md)

In SQL Developer Web, search the `DEPARTMENT_ID` column in your target database to help you figure out how to create a masking format for it.

- On the SQL Worksheet, run a select on the `DEPARTMENTS` table.
```
<copy>SELECT * FROM HCM1.DEPARTMENTS;</copy>
```
- Notice that the department ID values are 10, 20, 30, up to 270.
- Click the **Data Modeler** tab.

   ![](./images/Img86.png " ")
- In the first drop-down list, select `HCM1`.
- In the second drop-down list, select **Tables**.

   ![](./images/Img87.png " ")
- Drag the `DEPARTMENTS` table to the worksheet.
- Notice that the `DEPARTMENT_ID` column has the data-type `NUMBER(4)`, which means it can take up to four digits (no decimals). It is also a primary key column.

Sign in to the Oracle Data Safe Console in your region

Refer [Lab - Register a Target Database (ATP-D) with Oracle Data Safe](https://github.com/labmaterial/adbguides-dev/blob/master/adb-datasafe/Register%20a%20Target%20Database.md)

In the Oracle Data Safe Console, create a masking format to mask department IDs

- In the Oracle Data Safe Console, click the **Library** tab.
- Under **Data Masking**, click **Masking Formats**, and then click **Add**.

   ![](./images/Img88.png " ")
- The **Create Masking Format** dialog box is displayed.
- Leave the **Create Like** drop-down list as is.
- In the **Masking Format Name** field, enter **<username> Custom Department IDs**.
- In the **Masking Format Description** field, enter **Custom Department IDs**.
- Select your resource group.
- From the Format drop-down list, select **Random Number**.
- In the **Start Number** field, enter **10**.
- In the **End Number** field, enter **9990**.

   ![](./images/Img89.png " ")
- Click **Save**.<br>
A confirmation message states that you successfully created the masking format.
- Move the **Hide Oracle Predefined** slider to the right and verify that your masking format is listed.

   ![](./images/Img90.png " ")

## Acknowledgements

*Great Work! You successfully completed the Data Safe Masking Lab 3*

- **Author** - Jayshree Chatterjee
- **Last Updated By/Date** - Kris Bhanushali, September 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/autonomous-database-dedicated). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
