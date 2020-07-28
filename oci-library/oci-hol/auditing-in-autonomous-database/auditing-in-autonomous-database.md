#  Auditing in an Autonomous Database

## Introduction
Auditing is the monitoring and recording of configured database actions, from both database users and nondatabase users.
You can base auditing on individual actions, such as the type of SQL statement executed, or on combinations of data that can include the user name, application, time, and so on.

Unified Auditing is enabled by default. You can audit the several types of activities, using unified audit policies and the AUDIT SQL statement. All audit records are written to the unified audit trail in a uniform format and are made available through the UNIFIED\_AUDIT\_TRAIL view. The unified audit trail captures audit information from many types of object, from SQL statements to other Oracle Database Components, such as Recovery Manager, Oracle Data Pump, SQL*Loader.
    ![](./../auditing-in-autonomous-database/images/Audit_arch.png " ")

### Objectives
The objective of this lab is to create an audit policy for the update done on CUSTOMERS table and then to query UNIFIED\_AUDIT\_TRAIL to view the generated audit records.

We will do the following:

* Create an audit policy
* Enable the policy and apply audit settings to one or more users
* View the generated audit records

### Pre-Requisites

* The lab requires an Oracle Public Cloud account with Autonomous Transaction Processing Cloud Service.


### Benefits of the Unified Audit Trail

* The audit records are placed in one location and in one format, rather than your having to look in different places to find audit trails in varying formats.
* This consolidated view enables auditors to co-relate audit information from different components.
* The management and security of the audit trail is also improved by having it in single audit trail.
* Overall auditing performance is greatly improved. By default, the audit records are automatically written to an internal relational table.
* You can create named audit policies that enable you to audit the supported components. Furthermore, you can build conditions and exclusions into your policies.

## Step 1: Sign in to OCI Console

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:** {{Compartment}}
* **Database Name:** {{Database Name}}
* **Database Password:** {{Database Password}}

1. In Oracle Cloud, click Sign In. Sign in using your tenant name. Then click Continue.

2. Enter your user name and password.

    ![](./../auditing-in-autonomous-database/images/Cloud.png " ")

3. Click the hamburger menu at the upper right, and select Autonomous Transaction Processing.

4. Change the compartment to the one listed above.

5. Select the database that is named above from the list of databases displayed.

## Step 2: Start using SQL Developer Web

1. Click the Service Console tab.

       ![](./../auditing-in-autonomous-database/images/Service_console.png" ")  
 
      Note: You have to disable the pop-up blocker. Click on the Popup-blocker icon and select *Always allow popups ...*. Then click the Service Console tab again.

2. Click the Development tab. Then click the SQL Developer Web.
       ![](./../auditing-in-autonomous-database/images/Devt.png " ")
   
3. In SQL Developer Web, sign in with the ADMIN user and the password provided above. Then click Sign In.
       ![](./../auditing-in-autonomous-database/images/SQLDevWeb_login.png " ")
   
4. Before starting auditing data, you create a new user and a table with sensitive data. Use the following commands in the Worksheet:
   
   Note: Replace *your_password* with a password of your choice. The password must be at least 12 characters long, with upper and lower case letters, numbers, and a special character. It must start with a letter.

      ```
      <copy>
      DROP USER test CASCADE;
      CREATE USER test IDENTIFIED BY *your_password*;
      ALTER USER test QUOTA UNLIMITED ON DATA;  
      GRANT create session, create table TO test;
  
      CREATE TABLE test.customers AS SELECT * FROM sh.customers;
      </copy>
      ```
      
       ![](./../auditing-in-autonomous-database/images/Create_User_Test.png " ")

       ![](./../auditing-in-autonomous-database/images/Create_table.png " ")
   
5. Display the data from the TEST.CUSTOMERS table, by copying, pasting, and executing the query in the Worksheet.
      ```
      <copy>
      SELECT cust_first_name, cust_last_name, cust_main_phone_number FROM test.customers;
      </copy>
      ``` 
      
      ![](./../auditing-in-autonomous-database/images/Query_not_redacted.png " ")
 
## Step 3: Audit Data

1. The table TEST.CUSTOMERS holds columns whose data is sensitive. You want to audit the UPDATE actions on the table. 

   Before you start auditing any operations on table TEST.CUSTOMERS, verify that the auditing is enabled in the database.

      ```
      <copy>
      SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Unified Auditing';
      </copy>
      ```

      The result should be TRUE. This shows that the unified auditing is enabled by default in your database.
      ![](./../auditing-in-autonomous-database/images/TRUE.png " ")

2. Create an audit policy on the table and then enable the audit policy for all users who could update values in the table TEST.CUSTOMERS.
   
      ``` 
      <copy>
      CREATE AUDIT POLICY audit_update_customers ACTIONS update ON test.customers;
      
      AUDIT POLICY audit_update_customers;
      </copy>
      ```

      ![](./../auditing-in-autonomous-database/images/Create_enable_policy.png " ")

   Note: When unified auditing is enabled in Oracle Database, the audit records are populated in this new audit trail. This view displays audit records in tabular form by retrieving the audit records from the audit trail. Be aware that if the audit trail mode is QUEUED, then audit records are not written to disk until the in-memory queues are full. 

   The following procedure explicitly flushes the queues to disk, so that you can see the audit trail records in the UNIFIED\_AUDIT\_TRAIL view:

      ```
      <copy>
      EXEC SYS.DBMS_AUDIT_MGMT.FLUSH_UNIFIED_AUDIT_TRAIL
      </copy>
      ```

3. Verify that the audit policy is created and enabled for all users.
   
      ```
      <copy> 
      SELECT policy_name, enabled_opt, user_name FROM audit_unified_enabled_policies 
      WHERE policy_name = 'AUDIT_UPDATE_CUSTOMERS' 
      ORDER BY user_name;
      </copy>
      ```

       ![](./../auditing-in-autonomous-database/images/Policy.png " ")

4. Execute an UPDATE operation on table TEST.CUSTOMERS.
      ```
      <copy>
      UPDATE TEST.CUSTOMERS SET cust_main_phone_number='XXX-XXX-1234';
      COMMIT;
      </copy>   
      ```

5. View the audit records.

      ``` 
      <copy>
      SELECT dbusername, event_timestamp, sql_text FROM unified_audit_trail 
      WHERE  unified_audit_policies = 'AUDIT_UPDATE_CUSTOMERS';
      </copy>
      ```

       ![](./../auditing-in-autonomous-database/images/Audit_record.png " ")

6. The ENABLED_OPT shows if a user can access the policy. Exclude the user ADMIN from unified policy. You must first disable the policy for all users and then re-enable the policy for all users except ADMIN:
      
      ```
      <copy>
      NOAUDIT POLICY audit_update_customers;
      AUDIT POLICY audit_update_customers EXCEPT admin;
      </copy>
      ```

       ![](./../auditing-in-autonomous-database/images/Users_except.png " ")

7. Re-execute an UPDATE operation on table TEST.CUSTOMERS. First delete the commands from the Worksheet and reload the UPDATE from the SQL History by clicking twice on the command and change the value for the phone number.

      ```
      <copy>
      UPDATE TEST.CUSTOMERS SET cust_main_phone_number='XXX-YYY-5678';
      COMMIT;
      </copy> 
      ```

       ![](./../auditing-in-autonomous-database/images/Update2.png " ")
  
8. View the audit records.

      ``` 
      <copy>
      SELECT dbusername, event_timestamp, sql_text FROM unified_audit_trail 
      WHERE  unified_audit_policies = 'AUDIT_UPDATE_CUSTOMERS';
      </copy>
      ```

       ![](./../auditing-in-autonomous-database/images/Audit_record.png " ")
   
   You can observe that the second UPDATE completed by ADMIN is not audited.
   
## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 