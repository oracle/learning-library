# Using Predefined Unified Audit Policies for STIG Compliance

## Introduction
This lab shows how to use predefined unified audit policies to implement Security Technical Implementation Guides (STIG) audit requirements.

### About Unified Audit Policies for STIG
Starting with this release, you can audit for Security Technical Implementation Guide (STIG) compliance by using new predefined unified audit policies.

These policies are as follows:
* ORA\_STIG\_RECOMMENDATIONS
* ORA\_ALL\_TOPLEVEL\_ACTIONS
* ORA\_LOGON\_LOGOFF

Estimated Lab Time: 15 minutes

### Objectives
In this lab, you will:
* Observe the predefined unified audit policies implemented
* Enable all three audit policies for all users

### Prerequisites
* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Observe the predefined unified audit policies implemented

1. Connect to `PDB21` as `SYSTEM`.  Enter the password you used to create your DB System, `WElcome123##`.

  
    ```
    $ <copy>sqlplus system@PDB21</copy>
    Enter password: <i><b>WElcome123##</b></i>
    Connected.
    SQL>
    ```

2. Verify which predefined unified audit policies are implemented. Observe the three new predefined unified audit policies implemented in Oracle Database 21c.

  
    ```
    SQL> <copy>SELECT DISTINCT policy_name FROM audit_unified_policies ORDER BY 1;</copy>
    POLICY_NAME  
    -------------------------------------
    ORA_ACCOUNT_MGMT
    ORA_ALL_TOPLEVEL_ACTIONS
    ORA_CIS_RECOMMENDATIONS
    ORA_DATABASE_PARAMETER
    ORA_DV_AUDPOL
    ORA_DV_AUDPOL2
    ORA_LOGON_FAILURES
    ORA_LOGON_LOGOFF
    ORA_RAS_POLICY_MGMT
    ORA_RAS_SESSION_MGMT
    ORA_SECURECONFIG
    ORA_STIG_RECOMMENDATIONS
    12 rows selected.
 
    SQL>
    ```

3. Are these policies enabled to satisfy STIG compliance?

    ```
    SQL> <copy>
    SELECT * FROM audit_unified_enabled_policies 
    WHERE policy_name IN ('ORA_ALL_TOPLEVEL_ACTIONS','ORA_LOGON_LOGOFF','ORA_STIG_RECOMMENDATIONS');</copy>
    
    no rows selected
    SQL>
    ```
  
  *None of these are enabled.*
  
  
4. Verify the actions audited by `ORA_STIG_RECOMMENDATIONS`. 

  
    ```
    SQL> 
    <copy>COL audit_option FORMAT A26
    COL AUDIT_OPTION_TYPE FORMAT A16
    COL OBJECT_SCHEMA FORMAT A4
    COL OBJECT_NAME FORMAT A22
    COL OBJECT_TYPE FORMAT A7
    SELECT audit_option, audit_option_type, object_schema, object_name, object_type FROM  audit_unified_policies WHERE policy_name = 'ORA_STIG_RECOMMENDATIONS';</copy>

     AUDIT_OPTION               AUDIT_OPTION_TYP OBJE OBJECT_NAME            OBJECT_
    -------------------------- ---------------- ---- ---------------------- -------
    ALTER SESSION              SYSTEM PRIVILEGE NONE NONE                   NONE
    CREATE TABLE               STANDARD ACTION  NONE NONE                   NONE
    DROP TABLE                 STANDARD ACTION  NONE NONE                   NONE
    ALTER TABLE                STANDARD ACTION  NONE NONE                   NONE
    CREATE SYNONYM             STANDARD ACTION  NONE NONE                   NONE
    DROP SYNONYM               STANDARD ACTION  NONE NONE                   NONE
    CREATE VIEW                STANDARD ACTION  NONE NONE                   NONE
    DROP VIEW                  STANDARD ACTION  NONE NONE                   NONE
    CREATE PROCEDURE           STANDARD ACTION  NONE NONE                   NONE
    ALTER PROCEDURE            STANDARD ACTION  NONE NONE                   NONE
    ALTER DATABASE             STANDARD ACTION  NONE NONE                   NONE
    ALTER USER                 STANDARD ACTION  NONE NONE                   NONE
    ALTER SYSTEM               STANDARD ACTION  NONE NONE                   NONE
    CREATE USER                STANDARD ACTION  NONE NONE                   NONE
    CREATE ROLE                STANDARD ACTION  NONE NONE                   NONE
    DROP USER                  STANDARD ACTION  NONE NONE                   NONE
    DROP ROLE                  STANDARD ACTION  NONE NONE                   NONE
    SET ROLE                   STANDARD ACTION  NONE NONE                   NONE
    CREATE TRIGGER             STANDARD ACTION  NONE NONE                   NONE
    ALTER TRIGGER              STANDARD ACTION  NONE NONE                   NONE
    DROP TRIGGER               STANDARD ACTION  NONE NONE                   NONE
    CREATE PROFILE             STANDARD ACTION  NONE NONE                   NONE
    DROP PROFILE               STANDARD ACTION  NONE NONE                   NONE
    ALTER PROFILE              STANDARD ACTION  NONE NONE                   NONE
    DROP PROCEDURE             STANDARD ACTION  NONE NONE                   NONE
    CREATE MATERIALIZED VIEW   STANDARD ACTION  NONE NONE                   NONE
    ALTER MATERIALIZED VIEW    STANDARD ACTION  NONE NONE                   NONE
    DROP MATERIALIZED VIEW     STANDARD ACTION  NONE NONE                   NONE
    CREATE TYPE                STANDARD ACTION  NONE NONE                   NONE
    DROP TYPE                  STANDARD ACTION  NONE NONE                   NONE
    ALTER ROLE                 STANDARD ACTION  NONE NONE                   NONE
    ALTER TYPE                 STANDARD ACTION  NONE NONE                   NONE
    CREATE TYPE BODY           STANDARD ACTION  NONE NONE                   NONE
    ALTER TYPE BODY            STANDARD ACTION  NONE NONE                   NONE
    DROP TYPE BODY             STANDARD ACTION  NONE NONE                   NONE
    DROP LIBRARY               STANDARD ACTION  NONE NONE                   NONE
    ALTER VIEW                 STANDARD ACTION  NONE NONE                   NONE
    CREATE FUNCTION            STANDARD ACTION  NONE NONE                   NONE
    ALTER FUNCTION             STANDARD ACTION  NONE NONE                   NONE
    DROP FUNCTION              STANDARD ACTION  NONE NONE                   NONE
    CREATE PACKAGE             STANDARD ACTION  NONE NONE                   NONE
    ALTER PACKAGE              STANDARD ACTION  NONE NONE                   NONE
    DROP PACKAGE               STANDARD ACTION  NONE NONE                   NONE
    CREATE PACKAGE BODY        STANDARD ACTION  NONE NONE                   NONE
    ALTER PACKAGE BODY         STANDARD ACTION  NONE NONE                   NONE
    DROP PACKAGE BODY          STANDARD ACTION  NONE NONE                   NONE
    CREATE LIBRARY             STANDARD ACTION  NONE NONE                   NONE
    CREATE JAVA                STANDARD ACTION  NONE NONE                   NONE
    ALTER JAVA                 STANDARD ACTION  NONE NONE                   NONE
    DROP JAVA                  STANDARD ACTION  NONE NONE                   NONE
    CREATE OPERATOR            STANDARD ACTION  NONE NONE                   NONE
    DROP OPERATOR              STANDARD ACTION  NONE NONE                   NONE
    ALTER OPERATOR             STANDARD ACTION  NONE NONE                   NONE
    CREATE SPFILE              STANDARD ACTION  NONE NONE                   NONE
    ALTER SYNONYM              STANDARD ACTION  NONE NONE                   NONE
    ALTER LIBRARY              STANDARD ACTION  NONE NONE                   NONE
    DROP ASSEMBLY              STANDARD ACTION  NONE NONE                   NONE
    CREATE ASSEMBLY            STANDARD ACTION  NONE NONE                   NONE
    ALTER ASSEMBLY             STANDARD ACTION  NONE NONE                   NONE
    ALTER PLUGGABLE DATABASE   STANDARD ACTION  NONE NONE                   NONE
    CREATE LOCKDOWN PROFILE    STANDARD ACTION  NONE NONE                   NONE
    DROP LOCKDOWN PROFILE      STANDARD ACTION  NONE NONE                   NONE
    ALTER LOCKDOWN PROFILE     STANDARD ACTION  NONE NONE                   NONE
    ADMINISTER KEY MANAGEMENT  STANDARD ACTION  NONE NONE                   NONE
    ALTER DATABASE DICTIONARY  STANDARD ACTION  NONE NONE                   NONE
    GRANT                      STANDARD ACTION  NONE NONE                   NONE
    REVOKE                     STANDARD ACTION  NONE NONE                   NONE
    ALL                        OLS ACTION       NONE NONE                   NONE
    EXECUTE                    OBJECT ACTION    SYS  DBMS_SCHEDULER         PACKAGE
    EXECUTE                    OBJECT ACTION    SYS  DBMS_JOB               PACKAGE
    EXECUTE                    OBJECT ACTION    SYS  DBMS_RLS               PACKAGE
    EXECUTE                    OBJECT ACTION    SYS  DBMS_REDACT            PACKAGE
    EXECUTE                    OBJECT ACTION    SYS  DBMS_TSDP_MANAGE       PACKAGE
    EXECUTE                    OBJECT ACTION    SYS  DBMS_TSDP_PROTECT      PACKAGE
    EXECUTE                    OBJECT ACTION    SYS  DBMS_NETWORK_ACL_ADMIN PACKAGE
    75 rows selected.
    SQL>
    ```
  
  *The policy once enabled audits all major actions that could damage the security and the smooth running of the database, and also all Oracle Label Security actions. This result shows that you should enable the policy for all users.*
  
  
5. Verify the actions audited by  `ORA_ALL_TOPLEVEL_ACTIONS`.  

    ```
    SQL> 
    <copy>COL audit_option FORMAT A6COL OBJECT_NAME FORMAT A11
    COL audit_only_toplevel FORMAT A22
    SELECT audit_option, audit_option_type, object_schema, object_name, 
    object_type, audit_only_toplevel
    FROM  audit_unified_policies
    WHERE policy_name = 'ORA_ALL_TOPLEVEL_ACTIONS';</copy>
    
    AUDIT_ AUDIT_OPTION_TYP OBJE OBJECT_NAME OBJECT_ AUDIT_ONLY_TOPLEVEL
    ------ ---------------- ---- ----------- ------- ---------------------
    ALL    STANDARD ACTION  NONE NONE        NONE    YES
    SQL>
    
    ```
  
  *The policy once enabled audits all top level actions of privileged users on any object that could damage the security of the database. This result shows that you should enable the policy for all users.*
  
  

6. Verify the actions audited by `ORA_LOGON_LOGOFF`.

    ```
    SQL> <copy>COL audit_option FORMAT A6
    COL OBJECT_NAME FORMAT A11
    COL audit_only_toplevel FORMAT A22
    SELECT audit_option, audit_option_type, object_schema, object_name, 
    object_type, audit_only_toplevel
    FROM  audit_unified_policies
    WHERE policy_name = 'ORA_LOGON_LOGOFF';</copy>
      
    AUDIT_ AUDIT_OPTION_TYP OBJE OBJECT_NAME OBJECT_ AUDIT_ONLY_TOPLEVEL
    ------ ---------------- ---- ----------- ------- ----------------------
    LOGON  STANDARD ACTION  NONE NONE        NONE    NO
    LOGOFF STANDARD ACTION  NONE NONE        NONE    NO
      
    SQL>
  
    ```
  
  *The policy once enabled audits all connection and disconnections that could display unsecure connections to the database. This policy is required for both the Center for Internet Security (CIS) and Security for Technical Implementation Guides (STIG) requirements.*
  
  

## **STEP 2:** Enable all three audit policies for all users

1.  Enter the commands below to enable the audit policies.
   
    ```
    SQL> <copy>AUDIT POLICY ORA_STIG_RECOMMENDATIONS;
    AUDIT POLICY ORA_ALL_TOPLEVEL_ACTIONS;
    AUDIT POLICY ORA_LOGON_LOGOFF;</copy>

    Audit succeeded.

    SQL> <copy>EXIT</copy>
    $

    ```

You may now [proceed to the next lab](#next).

## Learn More

* [Oracle Database 21c Blog](http://docs.oracle.com)
* [Documentation](https://docs.us.oracle.com/en/database/oracle/oracle-database/21/nfcon/predefined-unified-audit-policies-for-security-technical-implementation-guides-stig-compliance-268779503.html)

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  Kay Malcolm, Kamryn Vinson, Anoosha Pilli, Database Product Management
* **Last Updated By/Date** -  Kay Malcolm, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
