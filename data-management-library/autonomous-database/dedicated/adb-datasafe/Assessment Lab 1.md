# Assess Database Configurations with Oracle Data Safe
## Introduction
Using Oracle Data Safe you can assess the security of a database by using the Security Assessment feature and fix issues.

### Objectives

In this lab, you learn how to do the following:

- Assess the security of a database by using the Security Assessment feature in Oracle Data Safe
- Fix some of the security issues based on the assessment findings

*Note: Suppose that you are notified by the “Audit and Compliance” department that due to the General Data Protection Regulation (GDPR) compliance efforts, you need to quickly report on the current security posture of your database. Your current understanding is unknown. You currently have auditing enabled and are aware of the following database users:*

- PU_PETE (Power User)
- APP_USER
- DBA_DEBRA (Company DBA)
- DBA_HARVEY (Company Junior DBA)
- EVIL_RICH
- SECURE_STEVE 

## STEP 1: Register your target Database - ATP-D for Data Safe Console

Refer [Register Your ATP-D](https://github.com/labmaterial/adbguides-dev/blob/master/adb-datasafe/Register%20a%20Target%20Database.md)

## STEP 2: In the Oracle Data Safe Console, generate a Comprehensive Assessment report

- Return to the Oracle Data Safe Console.
- Click the **Home tab** and then **Security Assessment**.
- On the Security Assessment page, select the check box for your target database, and click **Assess Now**.

   ![](./images/Img4.png " ") 
*Note : Wait a moment for the report to generate.*
- When the report is generated, review the high risk, medium risk, and low risk values.
- In the Last Generated Report column, click View Report.

   ![](./images/Img5.png " ")
- The Comprehensive Assessment report is displayed on the Reports tab.
- In the upper right corner, view the target name, when the database was assessed, and the database version.
- View the values for the different risk levels. These values give you an idea of how secure your database is.

   ![](./images/Img6.png " ")
- View the values for security controls, user security, and security configurations. These totals show you the number of findings for each level category.

*Note: Browse the report by scrolling down and expanding and collapsing categories. Each category lists related findings about your database and how you can make changes to improve its security.*
*View the Summary table. This table compares the number of findings for each category and counts the number of findings per risk level. It helps you to identify the areas that need attention on your database.*

## STEP 3: Review the Medium Risk, Low Risk, and Advisory findings

- At the top of the report, click **Medium Risk** to filter the report to show only the medium risk findings.
- Deselect all other risk levels.
- Scroll through the report to view the medium risk findings.
- At the top of the report, click **Low Risk** to filter the report to show only the low risk findings.
- Deselect all other risk levels.
- Review the low risk findings.
- At the top of the report, click **Advisory** to filter the report to show only the advisory findings.
- Deselect all other risk levels.
- Review the advisory findings.

## STEP 4: Review the Evaluate findings and fix some of them, if possible

- At the top of the report, click **Evaluate** to filter the report to show only the Evaluate findings.

   ![](./images/Img7.png " ")
- Scroll through the report to view the findings.
- Focus on **System Privilege Grants** under Privileges and Roles:
  1. System privileges `(ALTER USER, CREATE USER, DROP USER)` can be used to create and modify other user accounts, including the ability to change passwords. This ability can be abused to gain access to another user's account, which may have greater privileges. The Privilege Analysis feature may be helpful to determine whether or not a user or role has used account management privileges.
  2. Security Assessment found 474 grants of system privilege grants on your target database.
  
   ![](./images/Img8.png " ")
   
    iii. Fix: In SQL Developer, run the following query on your database to find out who has the `PDB_DBA` role. Sort the results by `GRANTED_ROLE` to make it easy to identify the users with the role. Then, revoke the `PDB_DBA` role from the `EVIL_RICH` user account.  

    ```
    <copy>
    select * from dba_role_privs;
    </copy>
    ```   
   ![](./images/Img9.jpg " ")    
   
     ```
    <copy>
    revoke pdb_dba from EVIL_RICH;
    </copy>
    ```     
- Focus on **Audit Records**:

  1. Auditing is an essential component for securing any system. The audit trail lets you monitor the activities of highly privileged users. Even though auditing cannot prevent attacks that exploit gaps in other security policies, it does act as a critical last line of defense by detecting malicious activity. Enable unified auditing policies on the database and ensure that audit records exist. This is a STIG, GDPR, and CIS recommended policy.
  
   ![](./images/Img10.jpg " ")
   
  2. Review the Details section in this finding and answer these questions: How many audit trails exist in your database and how many of those trails contain audit records? The report states that Security Assessment examined two audit trails and found records in one audit trail. There's only one audit trail because Autonomous Transaction Processing databases are in pure unified audit mode.
  
    iii. Fix: You do not need to do anything on your database because your database already has unified auditing policies enabled.
  
- Focus on **Unified Audit**:

   ![](./images/Img11.jpg " ")

*Note: Unified Auditing is the recommended audit method and is available in Oracle Database 12.1 and later releases. Not using Unified Auditing or disabling unified auditing policies is a risk. Verify that unified audit policies are enabled on the database. Audit all sensitive operations, including privileged user activities. Also audit access to application data that bypasses the application. How many unified audit policies are on your target database and how many of them are enabled?*

## STEP 5: Review the Pass findings

- At the top of the report, click **Advisory** to filter the report to show only the Advisory findings.

   ![](./images/Img12.png " ")
- Scroll through the report to review the findings. For example, the following findings have a **Pass status**.

   ![](./images/Img13.png " ")

## Step 6: Rerun Security Assessment and compare the results to the first assessment

- In the Oracle Data Safe Console, click the **Home** tab, and then click **Security Assessment**.
- On the **Security Assessment** page, select the check box for your target database, and then click **Assess**.
- In the **Last Generated Report** column, click the **View Report** link. The **Comprehensive Assessment** report is displayed.
- View the totals for the risk levels.
If you fixed any of the previous risks, then the totals will be lower than in the first assessment.
- Check the **Account Management Privileges** entry in the Evaluate category. Notice that `EVIL_RICH` is no longer listed.
- To compare the results with the first assessment, do the following:
 - Click the **Reports** tab.
 - Click **Security Assessment**.
 - Click **Comprehensive Assessments**.
 - Click the previous assessment report to open it.

> **Note:**
Currently, there's no compare functionality in the product so to compare assessment results, you need to view both reports and manually compare

## Acknowledgements

*Great Work! You successfully completed the Data Safe Assessment Lab 1*

- **Author** - Jayshree Chatterjee
- **Last Updated By/Date** - Kris Bhanushali, September 2020


## See an issue or have feedback?  
Please submit feedback [here](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1).   Select 'Autonomous DB on Dedicated Exadata' as workshop name, include Lab name and issue / feedback details. Thank you!