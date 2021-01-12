# Enforcing a Minimum Password Length on All PDBs

## Introduction
This lab shows how to enforce CDB-wide the minimum password length for the database user accounts without restricting access to the database user profiles.

Estimated Lab Time: 15 minutes

### Objectives
In this lab, you will:
* Setup the environment

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

2. Create the mandatory root profile. The mandatory root profile acts as an always-on user profile. Mandatory profile limits are enforced in addition to the existing limits from the profile which the user is assigned to. This creates a union effect in the sense that the password complexity verification script of the mandatory profile will be executed before the password complexity script from the profile of the user account if any.


    ```
    SQL> <copy>COL resource_name FORMAT A30</copy>

    SQL> <copy>COL limit FORMAT A30</copy>

    SQL> <copy>CREATE MANDATORY PROFILE c##prof_min_pass_len
                          LIMIT PASSWORD_VERIFY_FUNCTION ora12c_stig_verify_function
                          CONTAINER=ALL;</copy>

    Profile created.

    SQL> <copy>SELECT resource_name, limit, mandatory FROM cdb_profiles
                WHERE profile='C##PROF_MIN_PASS_LEN' AND resource_type='PASSWORD';</copy>

    RESOURCE_NAME                  LIMIT                          MAN

    ------------------------------ ------------------------------ ---

    PASSWORD_VERIFY_FUNCTION       FROM ROOT                      YES

    FAILED_LOGIN_ATTEMPTS                                         YES

    PASSWORD_LIFE_TIME                                            YES

    PASSWORD_REUSE_TIME                                           YES

    PASSWORD_REUSE_MAX                                            YES

    PASSWORD_LOCK_TIME                                            YES

    PASSWORD_GRACE_TIME                                           YES

    INACTIVE_ACCOUNT_TIME                                         YES

    PASSWORD_ROLLOVER_TIME                                        YES

    PASSWORD_VERIFY_FUNCTION       ORA12C_STIG_VERIFY_FUNCTION    YES

    FAILED_LOGIN_ATTEMPTS                                         YES

    PASSWORD_LIFE_TIME                                            YES

    PASSWORD_REUSE_TIME                                           YES

    PASSWORD_REUSE_MAX                                            YES

    PASSWORD_LOCK_TIME                                            YES

    PASSWORD_GRACE_TIME                                           YES

    INACTIVE_ACCOUNT_TIME                                         YES

    PASSWORD_ROLLOVER_TIME                                        YES

    18 rows selected.

    SQL>
    ```

## **STEP 2:** Set the `MANDATORY_USER_PROFILE` initialization parameter  

1. Set the initialization parameter
    ```
    SQL> <copy>ALTER SYSTEM SET mandatory_user_profile=C##PROF_MIN_PASS_LEN;</copy>

    System altered.

    SQL> <copy>SHOW PARAMETER mandatory_user_profile</copy>

    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    mandatory_user_profile               string      C##PROF_MIN_PASS_LEN
    SQL>

    ```
    *The password verify function of the mandatory profile is envisioned to be always enforced from the `CDB$ROOT` which means that the password resource limit is always fetched and executed from the `CDB$ROOT` and enforced on the PDBs in the entire CDB depending on the `MANDATORY_USER_PROFILE` initialization parameter.*

## **STEP 3:** Replace the password verification functio`n` to enforce the minimum password length.

1. Replace the verification function
    ```
    SQL> <copy>CREATE OR REPLACE FUNCTION ora12c_stig_verify_function
              ( username VARCHAR2, password VARCHAR2, old_password VARCHAR2)
              RETURN BOOLEAN
              IS
              BEGIN   
               -- mandatory verify function will always be evaluated regardless of the  
               -- password verify function that is associated to a particular profile/user
               -- requires the minimum password length to be 10 characters
               IF NOT ora_complexity_check(password, chars => 10) THEN return(false);   
               END IF;
               RETURN(true);
               END;
               /</copy>

    Function created.

    SQL>

    ```

## **STEP 4:** Test

1. Create a new user `JOHN` in `PDB21`.

    ```
    SQL> <copy>CONNECT system@PDB21</copy>

    Enter password: <i>Welcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>CREATE USER john IDENTIFIED BY pass;</copy>

    CREATE USER john IDENTIFIED BY pass

    *

    ERROR at line 1:

    ORA-28219: password verification failed for mandatory profile

    ORA-20000: password length less than 10 characters
    ```
    ```

    SQL> <copy>CREATE USER john IDENTIFIED BY password123;</copy>

    User created.
    ```
    ```

    SQL> <copy>DROP USER john CASCADE;</copy>

    User dropped.

    SQL>

    ```

## **STEP 5:** Reset the configuration

1. Drop the mandatory profile in the root.

    ```
    SQL> <copy>CONNECT sys@cdb21 AS SYSDBA</copy>

    Connected.
    ```
    ```

    SQL> <copy>DROP PROFILE c##prof_min_pass_len;</copy>

    DROP PROFILE c##prof_min_pass_len

    *

    ERROR at line 1:

    ORA-02381: cannot drop C##PROF_MIN_PASS_LEN profile
    ```
    ```

    SQL> <copy>!oerr ora 2381</copy>

    02381, 00000, "cannot drop %s profile"

    //  *Cause:  An attempt was made to drop PUBLIC_DEFAULT or a mandatory profile,

    //           which is not allowed due to following restrictions:

    //             * PUBLIC_DEFAULT profile can be dropped only when the database

    //               is in migration mode.

    //             * A mandatory profile can be dropped only if it is not set as a

    //               mandatory profile in root container (CDB$ROOT) of a multitenant

    //               container database (CDB) or in a Pluggable Database (PDB).

    //  *Action: If you are trying to drop the PUBLIC_DEFAULT profile, try dropping

    //           it during migration mode. If you are trying to drop a mandatory

    //           profile, check the MANDATORY_USER_PROFILE system parameter setting

    //           in the root container (CDB$ROOT) or in a Pluggable Database (PDB)

    //           and retry the operation after resetting the MANDATORY_USER_PROFILE

    //           system parameter by executing ALTER SYSTEM RESET DDL statement.

    SQL>
    ```

2. Reset the `MANDATORY_USER_PROFILE` initialization parameter first.

    ```
    SQL> <copy>ALTER SYSTEM RESET mandatory_user_profile;</copy>

    System altered.
    ```
    ```

    SQL> <copy>SHOW PARAMETER mandatory_user_profile</copy>

    NAME                                 TYPE        VALUE

    ------------------------------------ ----------- ------------------------------

    mandatory_user_profile               string      C##PROF_MIN_PASS_LEN
    ```
    ```

    SQL> <copy>DROP PROFILE c##prof_min_pass_len;</copy>

    DROP PROFILE c##prof_min_pass_len

    *

    ERROR at line 1:

    ORA-02381: cannot drop C##PROF_MIN_PASS_LEN profile

    SQL><copy>exit;</copy>
    ```

3. Restart the instance.

    ```
    <copy>/home/oracle/labs/M104784GC10/wallet.sh</copy>
    ```

4. Connect to the instance and remove the profile
    ```
    SQL> <copy>sqlplus sys@cdb21 AS SYSDBA</copy>

    Connected.
    ```
    ```
    SQL> <copy>SHOW PARAMETER mandatory_user_profile</copy>

    NAME                                 TYPE        VALUE

    ------------------------------------ ----------- ------------------------------

    mandatory_user_profile               string
    ```
    ```

    SQL> <copy>DROP PROFILE c##prof_min_pass_len;</copy>

    Profile dropped.

    SQL> <copy>EXIT</copy>

    $

    ```

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
