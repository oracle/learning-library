# Oracle Label Security (OLS)

## Introduction
This workshop introduces the various features and functionality of Oracle Label Security (OLS).<br>
It gives the user an opportunity to learn how to configure those features to secure their sensitive data, to help tracking consent, and to enforce restriction of processing under regulation requirements such as the General Data Protection Regulation.

- Version tested in this lab: *Oracle DB 19.8*
- Estimated Workshop Time: *30 minutes*

### About the Product
- **Overview**<br>
OLS works by comparing the row label with a user's label authorizations to enable you to easily restrict sensitive information to only authorized users.<br>
This way, users with different authorization levels (for example, managers and sales representatives) can have access to specific rows of data in a table.<br>
You can apply OLS policies to one or more application tables. The design of OLS is similar to Oracle Virtual Private Database (VPD).<br>
However, unlike VPD, OLS provides the access mediation functions, data dictionary tables, and policy-based architecture out of the box, eliminating customized coding and providing a consistent label based access control model that can be used by multiple applications.

    ![](./images/ols-concept.png)

    OLS is based on multi-level security (MLS) requirements that are found in government and defense organizations.

    OLS software is installed by default, but not automatically enabled. You can enable OLS in either SQL*Plus or by using the Oracle Database Configuration Assistant (DBCA). The default administrator for OLS is the user `LBACSYS`. To manage OLS, you can use either a set of PL/SQL packages and standalone functions at the command-line level or Oracle Enterprise Manager Cloud Control. To find information about OLS policies, you can query `ALL_SA_*`, `DBA_SA_*`, or `USER_SA_*` data dictionary views.

    An OLS policy has a standard set of components as follows:
    - **Labels:** Labels for data and users, along with authorizations for users and program units, govern access to specified protected objects. Labels are composed of the following:
         - **Levels:** Levels indicate the type of sensitivity that you want to assign to the row (for example, `SENSITIVE` or `HIGHLY SENSITIVE`). Levels are mandatory.
         - **Compartments (Optional):** Data can have the same level (for example, `PUBLIC`, `CONFIDENTIAL` and `SECRET`), but can belong to different projects inside a company (for example, `ACME Merger` and `IT Security`). Compartments represent the projects in this example that help define more precise access controls. They are most often used in government environments.
         - **Groups (Optional):** Groups identify organizations owning or accessing the data (for example, `UK`, `US`, `Asia`, `Europe`). Groups are used both in commercial and government environments, and frequently used in place of compartments due to their flexibility.
    - **Policy:** A policy is a name associated with these labels, rules, authorizations, and protected tables.

- **Benefits of using OLS**
   OLS provides several benefits for controlling row level management:
    - It enables row level data classification and provides out-of-the-box access mediation based on the data classification and the user label authorization or security clearance.
    - It enables you to assign label authorizations or security clearances to both database users and application users.
    - It provides both APIs and a graphical user interface for defining and storing data classification labels and user label authorizations.
    - It integrates with Oracle Database Vault and Oracle Advanced Security Data Redaction, enabling security clearances to be use in both Database Vault command rules and Data Redaction policy definitions.

### Prerequisites
This lab assumes you have completed:
   - Lab: Generate SSH Keys
   - Lab: Prepare Setup
   - Lab: Environment Setup
   - Lab: Oracle Database Vault

### Video Preview

- Watch a preview of "*Understanding Oracle Label Security (April 2020)*" [](youtube:o4-XpUQWfaM)

### Lab Timing (estimated)

| Step No. | Feature                                                    | Approx. Time | Details                                                                                                                                                                    | Value Proposition |
|----------------------|------------------------------------------------------------|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|
| 1                    | Simple CRM Application                             | 10 minutes  |                                                                                                                 |                   |
| 2                    | Protect Glassfish Application | 20 minutes  |  |                   |

## **STEP 1**: Simple CRM Application

### Different applications have different purposes:

**User App**<br>
Application where users sets their preferences for consent to marketing, processing data or asks to be forgotten.<br>
Runs with User Label: `NCNST::DP` and uses Database user: `APPPREFERENCE`

**Email Marketing**<br>
 Application that can only access users that have consented to process their data and specifically for email marketing.<br>
 Runs with User Label: `CONS::EMAIL` and uses Database user: `APPMKT`

**Business Intelligence**<br>
Application that can access all users who have consented to process their data.<br>
Runs with User Label: `CONS::DP` and uses Database user: `APPBI`

**Anonymizer**<br>
Batch process to anonmyize user records and set the data label to `ANON::`.<br>
Runs with User Label: `FORGET::` and uses Database user: `APPFORGET`

### How to walk through the lab

While we provide scripts to execute the whole lab from start to finish in an automated fashion, it is strongly recommended that you open one by one and copy/execute the code blocks one by one.<br>
This way you’ll get a better understanding of the building blocks of this exercise.<br>
In case you decide to execute script by script, you can always review the log files (.out) for the details.

1. Open a SSH session on your DBSec-Lab VM as Oracle User

      ````
      <copy>sudo su - oracle</copy>
      ````

2. Go to the scripts directory

      ````
      <copy>cd $DBSEC_HOME/workshops/Database_Security_Labs/Label_Security/Simple_CRM_App</copy>
      ````

3. First, you must setup the Label Security environment

      ````
      <copy>./01_setup_ols_environment.sh</copy>
      ````

   ![](./images/ols-001.PNG)

      ---
      **Note:**
      - This script creates `C##OSCAR_OLS` user, creates a table, loads data, creates users that will be used to showcase difference scenarios and it also configures, and enables OLS
      - This sql script invoke `load_crm_customer_data.sql` script to create the table `CRM_CUSTOMER` in `APPCRM` schema and inserts 389 rows
      - For each step, you can review the output of the script that you executed (example: `more 01_setup_ols_environment.out`)

      ---

4. Next, you create the Label Security policy.
   A policy consists of  levels, groups and/or compartments. The only mandatory component of a policy is at least one level

      ````
      <copy>./02_create_ols_policy.sh</copy>
      ````

   ![](./images/ols-002.PNG)
    
      ---
      **Note:** This script will create Policy (Levels, Groups, and Labels), set Levels and Groups for Users, and apply the Policy to the `APPCRM.CRM_CUSTOMER` table

      ---

 5. Then, we must label the data... We use the policy we created and apply one level and optionally, one or more compartments and, optionally, one or more groups
 
      ````
      <copy>./03_label_data.sh</copy>
      ````
    
   ![](./images/ols-003.PNG)
   
      ---
      **Note:** This script update data labels to create some diversity of labels that will be used in the scenarios. In real world scenarios would be advisable to create a labeling function that would assign labels based on other existing table data (other columns).

      ---

6. Then we will see the label security in action

      ````
      <copy>./04_label_sec_in_action.sh</copy>
      ````

   ![](./images/ols-004.PNG)

      ---
      **Note:** This script connects as different apps would be connecting. Each App would only see records that they would be able to process. E.g. AppMKT (app that is used for emailing customers) would only be able to see records labeled as `CNST::EMAIL`; `AppBI` would be able to see records labeled as `ANON`, and `CNST::ANALYTICS` (rows labeled with level `CNST`, and part of Group Analytics – would work for `CNST::ANALYTICS,EMAIL` as well.)

      ---

7. Now, we change users status to be forgotten

      ````
      <copy>./05_to_be_forgotten.sh</copy>
      ````

   ![](./images/ols-005.PNG)
   
      ---
      **Note:** This script simulates an app that would process records marked to be forgotten. It creates a stored procedure to show records marked to be Forgotten (labeled `FRGT::`). It also creates a procedure under an AppPreference app schema that would serve the purpose of forgetting a certain customer. AppPreference can access all data and `forget_me(p_id)` procedure will label a certain customerid row `FRGT::` “moving” a record from Consent to Forgotten.

      ---

8. Finally, we can clean up the environment (drops the OLS policy and users)

      ````
      <copy>./06_clean_env.sh</copy>
      ````

   ![](./images/ols-006.PNG)

## **STEP 2**: Protect Glassfish Application

1. Go to the scripts directory

      ````
      <copy>cd $DBSEC_HOME/workshops/Database_Security_Labs/Label_Security/Protect_Glassfish_App</copy>
      ````

2. First, starts the infrastructure and makes sure you don't already have the OLS changes deployed to the application

      ````
      <copy>./00_start_infrastructure.sh</copy>
      ````

   ![](./images/ols-007.PNG)

3. Press [**Enter**] to close

4. Next, setup the OLS environment

      ````
      <copy>./01_setup_ols_environment.sh</copy>
      ````

   ![](./images/ols-008.PNG)

      ---
      **Note:** This script creates the OLS policy named `OLS_DEMO_HR_APP` as well as the levels (`PUBLIC`, `CONFIDENTIAL`, `HIGHLY CONFIDENTIAL`), compartments (`HR`, `FIN`, `IP`, `IT`) and the OLS groups (`GLOBAL`, `USA`, `CANADA`, `EU`, `GERMAN`, `LATAM`).  This script also generates the data labels that will be used. This allows us to assign the numbers to our `label_tag` we want to have.

      ---

5. Create `EMPLOYEESEARCH_APP`

      ````
      <copy>./02_configure_employeesearch_app.sh</copy>
      ````

   ![](./images/ols-009.PNG)

      ---
      **Note:** This script will create a custom table for the Application User Labels, `EMPLOYEESEARCH_PROD.DEMO_HR_USER_LABELS`, and populate it with all of the rows from `EMPLOYEESEARCH_PROD.DEMO_HR_USERS`.  The script will also create a few additional users we will use in this exercise, such as `CAN_CANDY`, `EU_EVAN`, and then grant the appropriate OLS User Labels to all of the Application Users.

      ---

6. Open a web browser and launch the Glassfish app by navigating to this URL:

   `http://<YOUR_DBSEC-LAB_VM_PUBLIC_IP>:8080/hr_prod_pdb1`
    
7. Login to the application as `can_candy` / `Oracle123`
	
8. Select "**Search Employees**" and click [**Search**]
   See the result before enabling OLS policy

   ![](./images/ols-017.PNG)

9. Logout and do the same thing as `eu_evan/Oracle123`

   ![](./images/ols-018.PNG)

      ---
      **Note:** You can see all employees data with no geographic restriction

      ---

10. Go back to your terminal session and apply the OLS policy to the `EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES` table

      ````
      <copy>./03_apply_ols_policy.sh</copy>
      ````

	![](./images/ols-010.PNG)

	---
	**Note:** Once an OLS policy is applied to a table, only users with authorized labels, or OLS privileges, can see data

	---
	
11. Now, update `EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES` table to populate the `OLSLABEL` column with the appropriate OLS numeric label

      ````
      <copy>./04_set_row_labels.sh</copy>
      ````

	![](./images/ols-011.PNG)

      ---
      **Note:** We will dot his based on the `location` column in the table. For example, 'German' or 'Berlin' will receive an OLS label of `P::GER` because they belong to the GERMANY group

      ---

12. See what policy output looks like:

      ````
      <copy>./05_verify_our_policy.sh</copy>
      ````

   ![](./images/ols-012.PNG)

   ...and go through the data to demonstrate the different data labels and how they are displayed based on the "application user" that is accessing it:

       - for the DB USer, and schema owner `EMPLOYEESEARCH_PROD`
	
   ![](./images/ols-013.PNG)

       - for the App User `HRADMIN`
	
   ![](./images/ols-014.PNG)

       - for the App User `EU_EVAN`

   ![](./images/ols-015.PNG)

       - for the App User `CAN_CANDY`

    ![](./images/ols-016.PNG)
	
13. Finally, we make changes to the Glassfish JSP files... This script will step you through all of the additions we need to make

      ````
      <copy>./06_Update_Glassfish_app.sh</copy>
      ````

    ![](./images/ols-019.PNG)
	
    ![](./images/ols-020.PNG)

14. Go back to your web browser and launch the Glassfish app by navigating to this URL:

    `http://<YOUR_DBSEC-LAB_VM_PUBLIC_IP>:8080/hr_prod_pdb1`
    
15. Login to the application as `can_candy` / `Oracle123`
	
    - Select "**Search Employees**" and click [**Search**]
	
	 - See the result after enabling OLS policy

         ![](./images/ols-021.PNG)

    - Logout and do the same thing as `eu_evan` / `Oracle123`

         ![](./images/ols-022.PNG)

      ---
      **Note:** Now, you will see there is a difference from before. `CAN_CANDY` can only see Canadian-labeled users and `EU_EVAN` can only see EU-labeled users!

      ---

16. When you have completed the lab, you can remove the policies and restore the Glassfish JSP files to their original state

      ````
      <copy>./09_Remove_Policies_and_Restore.sh</copy>
      ````

    ![](./images/ols-023.PNG)

You may proceed to the next lab.

## Want to Learn More?
Technical Documentation: [Oracle Label Security 20c](https://docs.oracle.com/en/database/oracle/oracle-database/20/olsag/introduction-to-oracle-label-security.html#GUID-C20C62AE-2A30-45F9-AEEA-52A0D3286FBA)

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Gian Sartor, Principal Solution Engineer, Database Security
- **Last Updated By/Date** - Hakim Loumi, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
