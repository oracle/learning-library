# Oracle Unified Auditing

## Introduction
This workshop introduces the functionality of Oracle Unified Auditing. It gives the user an opportunity to learn how to configure this feature to audit the database activity.

*Estimated Lab Time:* 35 minutes

*Version tested in this lab:* Oracle DB 19.10
### Video Preview
Watch a preview of "*Understanding Unified Auditing (February 2019)*" [](youtube:8spLhyj3iC0)

**Note**:
- Mixed mode auditing is the default auditing in a newly installed database. Mixed mode auditing enables both traditional (that is, the audit facility from releases earlier than release 12c) and the new audit facilities (unified auditing).
- Mixed mode is intended to introduce unified auditing, so that you can have a feel of how it works and what its nuances and benefits are. Mixed mode enables you to migrate your existing applications and scripts to use unified auditing. Once you have decided to use pure unified auditing, you can relink the oracle binary with the unified audit option turned on and thereby enable it as the one and only audit facility the Oracle database runs. If you decide to revert back to mixed mode, you can.
- In this environment, we have already migrated this Oracle Database to pure unified auditing mode.

### Objectives
- Enable/Disable Unified Auditing on your database
- See different auditing use cases

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

### Lab Timing (estimated)
| Step No. | Feature | Approx. Time |
|--|------------------------------------------------------------|-------------|
| 1 | Display the current audit settings | 5 minutes |
| 2 | Audit Non App Usage | 10 minutes |
| 3 | Audit Database Role Usage | <10 minutes |
| 4 | Audit Data Pump Usage | <10 minutes |
| 5 | Cleanup the Unified Auditing configuration | <5 minutes |

## **STEP 1**: Display the current audit settings

1. Open a SSH session on your **DBSec-Lab VM as *oracle* user**

      ````
      <copy>sudo su - oracle</copy>
      ````

2. Go to the scripts directory

      ````
      <copy>cd $DBSEC_LABS/unified-auditing</copy>
      ````

3. Display the audit settings

      ````
      <copy>./ua_current_audit_settings.sh</copy>
      ````

    - We have already set the environment for you in pure Unified Auditing mode, hence you should see that Unified Audit is set to **TRUE**

      ![](./images/ua-001.png " ")

      **Note**: This means our database is in "pure" unified auditing mode and you are no longer utilize the traditional auditing capabilities

    - The 2nd query shows you how many Unified Audit Policies exist and how many audit-related attributes are associated with each policy

      ![](./images/ua-002.png " ")

    - The 3rd query of this script shows you which Unified Audit policies are **enabled**

      ![](./images/ua-003.png " ")

      **Note**:
      - Just because the policy exists in the previous query does not mean it's enabled
      - It is a two-step process to using a Unified Audit policy:
            - create the policy: create audit policy <policy_name> ...
            - enable the policy: audit policy <policy_name>

    - The 4th query shows you auditing based on context

      ![](./images/ua-004.png " ")

        **Note**:
        - We have one policy called `TICKETINFO` that captures an attribute named `TICKET_ID`
        - This information will be viewable in the `APPLICATION_CONTEXTS` column of the `UNIFIED_AUDIT_TRAIL` view

4. Display who has the `AUDIT_ADMIN` and `AUDIT_VIEWER` roles

      ````
      <copy>./ua_who_audit_roles.sh</copy>
      ````

   ![](./images/ua-005.png " ")

5. Display the existing audit records for the database you connect to (by default, the script will choose **pdb1** as the database to query)

      ````
      <copy>./ua_query_existing_audit_records.sh</copy>
      ````

   ![](./images/ua-006.png " ")

6. Finally, shows some of the details of the `DBMS_AUDIT_MGMT` package

      ````
      <copy>./ua_dbms_audit_mgmt_settings.sh</copy>
      ````

   ![](./images/ua-026.png " ")

    **Note**:
    - The function, `DBMS_AUDIT_MGMT.GET_AUDIT_COMMIT_DELAY`, returns the audit commit delay time as the number of seconds
    - Audit commit delay time is the maximum time that it takes to COMMIT an audit record to the database audit trail
    - If it takes more time to COMMIT an audit record than defined by the audit commit delay time, then a copy of the audit record is written to the operating system (OS) audit trail

## **STEP 2**: Audit Non App Usage
In this lab, you will audit who is using the `EMPLOYEESEARCH_PROD` objects outside of the application

1. Identify the connections we trust. We will generate some activity from the Glassfish application and view the session-related information

      ````
      <copy>./ua_query_employeesearch_usage.sh</copy>
      ````

   ![](./images/ua-007.png " ")

    **Note**: When prompted, **DO NOT press [return]** before executing a research in Glassfish as mentioned below!

2. On your Glassfish App, perform the the following steps:

    - Open a web browser window to *`http://<YOUR_DBSEC-LAB_VM_PUBLIC_IP>:8080/hr_prod_pdb1`*
    - Login to the HR Application as *`hradmin`* with the password "*`Oracle123`*"

      ````
      <copy>hradmin</copy>
      ````

      ````
      <copy>Oracle123</copy>
      ````

      ![](./images/ua-008.png " ")

      ![](./images/ua-009.png " ")

    - Click on **Search Employees**

      ![](./images/ua-010.png " ")

    - Click [**Search**]

      ![](./images/ua-011.png " ")

    - Change some of the criteria and Search again
    - **Repeat 2-3 times** to ensure you have enough traffic

3. Go back to your terminal session and **press [return]** when you are ready to see the results

   ![](./images/ua-012.png " ")

4.  Then, run a query to generate traffic from **SQL*Plus** on the host OS

      ````
      <copy>./ua_query_employeesearch.sh</copy>
      ````

   ![](./images/ua-013.png " ")

5. Now, create the **Unified Audit Policy**

      ````
      <copy>./ua_create_audit_policy.sh</copy>
      ````

   ![](./images/ua-014.png " ")

    **Note**: The Unified Audit Policy will capture your machine-related details to create the  **WHEN** clause

6. After creating the Unified Audit Policy you must enable it!

      ````
      <copy>./ua_enable_audit_policy.sh</copy>
      ````

   ![](./images/ua-015.png " ")

7. Run additional queries to generate traffic and to see if Audit records are generated

      - Execute

          ````
            <copy>./ua_query_employeesearch_usage.sh</copy>
          ````

         ![](./images/ua-007.png " ")

          **Note**: When prompted, **DO NOT press [return]** before executing a research in Glassfish as mentioned below!

      - Open our Glassfish App and perform again a random research as previously

      - Then, go back to your terminal session an press **[return]**

         ![](./images/ua-016.png " ")

          **Note**: They should not be generated based on this Unified Audit Policy because we are **excluding** application audit data

8. Query the `EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES` table again using SQL*Plus to generate audit data

      ````
      <copy>./ua_query_employeesearch.sh</copy>
      ````

   ![](./images/ua-013.png " ")

9. View the results of the audit output

      ````
      <copy>./ua_query_audit_records.sh</copy>
      ````

   ![](./images/ua-017.png " ")

    **Note**:
    - You can see we have an entry that corresponds with our use of SQL*Plus while not capturing queries from the Glassfish application
    - We trust the application to execute queries as `EMPLOYEESEARCH_PROD` but we do not trust anyone else
    - We want to audit everyone else

10. When you have completed this lab, you can remove the Unified Audit Policy

      ````
      <copy>./ua_delete_audit_policy.sh</copy>
      ````

   ![](./images/ua-027.png " ")

## **STEP 3**: Audit Database Role Usage
When you audit a role, Oracle Database audits all system privileges that are directly granted to the role. You can audit any role, including user-defined roles. If you create a common unified audit policy for roles with the ROLES audit option, then you must specify only common roles in the role list.

When such a policy is enabled, Oracle Database audits all system privileges that are commonly and directly granted to the common role. The system privileges that are locally granted to the common role will not be audited. To find if a role was commonly granted, query the `DBA_ROLES` data dictionary view. To find if the privileges granted to the role were commonly granted, query the `ROLE_SYS_PRIVS` view.

1. Create the role `MGR_ROLE` and grant it the `CREATE TABLESPACE` system privilege. Then it will grant the role to the database user `DBA_NICOLE`

      ````
      <copy>./ua_create_role.sh</copy>
      ````

   ![](./images/ua-018.png " ")

2. Create the audit policy to audit the use of the role `MGR_ROLE`

      ````
      <copy>./ua_create_role_audit_policy.sh</copy>
      ````

   ![](./images/ua-019.png " ")

3. Next, create the `DBA_JUNIOR` user who will be granted the `DBA` role

      ````
      <copy>./ua_create_junior_dba.sh</copy>
      ````

   ![](./images/ua-020.png " ")

4. Create the policy associated with auditing the use of the `DBA` role

      ````
      <copy>./ua_create_dba_audit_policy.sh</copy>
      ````

   ![](./images/ua-021.png " ")

5. Enable the audit policies for `MGR_ROLE` and `DBA` role usage

      ````
      <copy>./ua_enable_audit_policies.sh</copy>
      ````

   ![](./images/ua-022.png " ")

6. View the audit policies that are enabled

      ````
      <copy>./ua_view_audit_policies.sh</copy>
      ````

   ![](./images/ua-023.png " ")

7. Execute SQL statements that will show up in the Unified Audit Trail

      ````
      <copy>./ua_generate_audits.sh</copy>
      ````

   ![](./images/ua-024.png " ")

8. View the Unified Audit Trail output associated with the two audit policies

      ````
      <copy>./ua_review_generated_audits.sh</copy>
      ````

   ![](./images/ua-025.png " ")


## **STEP 4**: Audit Data Pump Usage

In this lab you will configure the Unified Audit Trail and review an audit of Oracle Data Pump export. This is a feature of Unified Audit that is not available in traditional auditing.

1. Create a Unified Audit policy to audit Data Pump activities

      ````
      <copy>./ua_audit_datapump_export.sh</copy>
      ````

   ![](./images/ua-028.png " ")

2. Perform 2 Data Pump exports of the table `EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES`...

      ````
      <copy>./ua_datapump_export_hr_table.sh</copy>
      ````

    ...as a user authorized (`SYSTEM`): **Successfully!**

    ![](./images/ua-029a.png " ")

     ...and as a user who is not authorized (`DBSAT_ADMIN`): **In Failure!**

    ![](./images/ua-029b.png " ")

    **Note**: Only the successfull export is available!

3. Review the Unified Audit Trail for the Data Pump activity

      ````
      <copy>./ua_review_datapump_audit_events.sh</copy>
      ````

   ![](./images/ua-030.png " ")

## **STEP 5**: Cleanup the Unified Auditing Configuration

1. When you have completed the lab, you can run the cleanup script

      ````
      <copy>./ua_cleanup.sh</copy>
      ````

   ![](./images/ua-031.png " ")

You may now [proceed to the next lab](#next)..

## **Appendix**: About the Product
### **Overview**

In unified auditing, the unified audit trail captures audit information from a variety of sources.

Unified auditing enables you to capture audit records from the following sources:
- Audit records (including SYS audit records) from unified audit policies and AUDIT settings
- Fine-grained audit records from the `DBMS_FGA` PL/SQL package
- Oracle Database Real Application Security audit records
- Oracle Recovery Manager audit records
- Oracle Database Vault audit records
- Oracle Label Security audit records
- Oracle Data Mining records
- Oracle Data Pump
- Oracle SQL*Loader Direct Load

The unified audit trail, which resides in a read-only table in the AUDSYS schema in the SYSAUX tablespace, makes this information available in a uniform format in the `UNIFIED_AUDIT_TRAIL` data dictionary view, and is available in both single-instance and Oracle Database Real Application Clusters environments. In addition to the user SYS, users who have been granted the `AUDIT_ADMIN` and `AUDIT_VIEWER` roles can query these views. If your users only need to query the views but not create audit policies, then grant them the `AUDIT_VIEWER` role.

When the database is writeable, audit records are written to the unified audit trail. If the database is not writable, then audit records are written to new format operating system files in the `$ORACLE_BASE/audit/$ORACLE_SID` directory.

### **Benefits of the Unified Audit Trail**
- After unified auditing is enabled, it does not depend on the initialization parameters that were used in previous releases.
- The audit records, including records from the SYS audit trail, for all the audited components of your Oracle Database installation are placed in one location and in one format, rather than your having to look in different places to find audit trails in varying formats.
- The management and security of the audit trail is also improved by having it in single audit trail.
- Overall auditing performance is greatly improved. By default, the audit records are automatically written to an internal relational table in the AUDSYS schema.
- You can create named audit policies that enable you to audit the supported components listed at the beginning of this section, as well as SYS administrative users. Furthermore, you can build conditions and exclusions into your policies.
- If you are using an Oracle Audit Vault and Database Firewall environment, then the unified audit trail greatly facilitates the collection of audit data, because all of this data will come from one location.

## Want to Learn More?
Technical Documentation:
- [Introduction to Auditing](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/introduction-to-auditing.html)  
- [Monitoring Database Activity with Auditing](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/part_6.html)

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Angeline Dhanarani, Gian Sartor, Rene Fontcha
- **Last Updated By/Date** - Hakim Loumi, Database Security PM - May 2021
