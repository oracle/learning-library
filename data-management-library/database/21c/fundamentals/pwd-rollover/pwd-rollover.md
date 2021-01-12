# Gradual Database Password Rollover for Applications

## Introduction
This lab shows how to enable gradual database password rollover for applications using profiles within the database.

Estimated Lab Time: 15 minutes

### Objectives
In this lab, you will:
* Setup the environment
* Test rollover passwords

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Create a mandatory profile in the CDB root

1. Connect to the CDB root in `CDB21`.

    ```

    $ <copy>sqlplus sys@CDB21 AS SYSDBA</copy>

    SQL*Plus: Release 21.0.0.0.0 - Production on Wed Aug 12 09:45:45 2020

    Version 21.1.0.0.0

    Enter password: <i>WElcome123##</i>

    Connected to:

    Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Development

    Version 21.1.0.0.0

    SQL>
    ```

2. Create the profile pw\_limit with a password\_rollover\_time of 1 day.

    ```
    <copy>create profile c##pw_limit limit password_rollover_time 1;</copy>
    ```
    ```

    <copy>
    col profile format a20
    col resource_name format a30
    col limit format a20

    select profile, resource_name, limit from dba_profiles where resource_name = 'PASSWORD_ROLLOVER_TIME';
    </copy>
    ```

## **STEP 2:** Create the user  

1. Connect to PDB21
    ```

    SQL> <copy>connect sys@PDB21 AS SYSDBA</copy>

    Enter password: <i>WElcome123##</i>
    ```

2. Create the user profile\_test using the profile pw\_limit.

    ```
    SQL> <copy>create user profile_test profile c##pw_limit identified by TheOldPassword123##;</copy>
    SQL> <copy>grant create session to profile_test;</copy>

    <copy>
    col username format a15
    col account_status format a20
    col profile format a20
    SELECT USERNAME, PROFILE, ACCOUNT_STATUS FROM DBA_USERS WHERE USERNAME = 'PROFILE_TEST';
    </copy>
    ```

## **STEP 3:** Test

1. Connect to profile\_test.

    ```
    <copy>connect profile_test/TheOldPassword123##@PDB21;</copy>
    ```

2. Change the password for profile\_test.

    ```
    SQL> <copy>connect sys@PDB21 AS SYSDBA;</copy>
    Enter password: <i>WElcome123##</i>
    ```
    ```
    SQL> <copy>ALTER USER profile_test identified by TheNewPassword123##;</copy>
    ```

3. Check the status of profile\_test.

    ```
    <copy>
    col username format a15
    col account_status format a20
    col profile format a20
    SELECT USERNAME, PROFILE, ACCOUNT_STATUS FROM DBA_USERS WHERE USERNAME = 'PROFILE_TEST';
    </copy>
    ```

4. Connect to profile\_test using the old password.

    ```
    SQL> <copy>connect profile_test/TheOldPassword123##@PDB21;</copy>
    ```

5. Connect to profile\_test using the new password.

    ```
    SQL> <copy>connect profile_test/TheNewPassword123##@PDB21;</copy>
    ```


You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - David Start, Database Product Management
* **Contributors** -  David Start, Database Product Management
* **Last Updated By/Date** -  David Start, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
