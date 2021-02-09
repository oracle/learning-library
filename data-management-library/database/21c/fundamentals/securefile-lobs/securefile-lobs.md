# Shrinking SecureFile LOBs

## Introduction

This lab shows how to reclaim space and improve performance with SecureFile LOBs.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Create a table with a SecureFile LOB

1. Execute a shell script that creates a tablespace with sufficient space to let the LOB grow and be candidate for shrinking.


    ```

    $ <copy>cd /home/oracle/labs/M104780GC10</copy>

    $ <copy>/home/oracle/labs/M104780GC10/setup_LOB.sh</copy>

    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER=ALL ;

    ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER=ALL

    *

    ERROR at line 1:

    ORA-28389: cannot close auto login wallet

    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE IDENTIFIED BY <i>WElcome123##</i> CONTAINER=ALL;

    keystore altered.

    ...

    SQL> DROP TABLESPACE users INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

    Tablespace dropped.

    SQL> CREATE TABLESPACE users DATAFILE '/u02/app/oracle/oradata/pdb21/users01.dbf' SIZE 500M;

    Tablespace created.

    SQL> create user hr identified by password default tablespace users;

    User created.

    SQL> grant dba to hr;

    Grant succeeded.

    SQL> exit

    $

    ```

2. Create a table with a CLOB column in `PDB21`.


    ```

    $ <copy>sqlplus system@PDB21</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: <i>WElcome123##</i>

    Last Successful login time: Fri Dec 13 2019 10:42:50 +00:00

    Connected to:
    ```
    ```

    SQL> <copy>CREATE TABLE hr.t1 ( a CLOB) LOB(a) STORE AS SECUREFILE TABLESPACE users;</copy>

    Table created.

    SQL> <copy>alter database datafile '/u02/app/oracle/oradata/pdb21/users01.dbf' autoextend on;</copy>

    ```

## **STEP 2:** Shrink the SecureFile LOB after rows inserted and updated

1. Insert rows, update the CLOB data and commit.


    ```

    SQL> <copy>INSERT INTO hr.t1 values ('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');</copy>

    1 row created.

    SQL> <copy>INSERT INTO hr.t1 Select * from hr.t1;</copy>

    1 row created.

    SQL> <copy>INSERT INTO hr.t1 Select * from hr.t1;</copy>

    2 rows created.

    SQL> <copy>INSERT INTO hr.t1 Select * from hr.t1;</copy>

    4 rows created.

    SQL> <copy>UPDATE hr.t1 SET a=a||a||a||a||a||a||a;</copy>

    8 rows updated.

    SQL> <copy>UPDATE hr.t1 SET a=a||a||a||a||a||a||a;</copy>

    8 rows updated.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL>

    ```

2. Shrink the LOB segment.


    ```

    SQL> <copy>ALTER TABLE hr.t1 MODIFY LOB(a) (SHRINK SPACE);</copy>

    Table altered.

    SQL>

    ```

3. Display the number of extents or blocks freed. **Make note of the LOB_OBJD for use in later commands**


    ```

    SQL> <copy>SET PAGES 100</copy>

    SQL> <copy>SELECT * FROM v$securefile_shrink;</copy>

      LOB_OBJD SHRINK_STATUS

    ---------- ----------------------------------------

    START_TIME

    ---------------------------------------------------------------------------

    END_TIME

    ---------------------------------------------------------------------------

    BLOCKS_MOVED BLOCKS_FREED BLOCKS_ALLOCATED EXTENTS_ALLOCATED EXTENTS_FREED

    ------------ ------------ ---------------- ----------------- -------------

    EXTENTS_SEALED     CON_ID

    -------------- ----------

        76063 COMPLETE

    10-NOV-20 11.30.55.545 AM +00:00

    10-NOV-20 11.30.55.917 AM +00:00

              2            2                2                 1             1

                1          3

    SQL>

    ```

  As a result, two blocks are freed.

## **STEP 3:** Shrink the SecureFile LOB after rows updated

1. Update the CLOB.


    ```

    SQL> <copy>UPDATE hr.t1 SET a=a||a||a||a||a||a||a;</copy>

    8 rows updated.

    SQL> <copy>UPDATE hr.t1 SET a=a||a||a||a||a||a||a;</copy>

    8 rows updated.

    SQL> <copy>UPDATE hr.t1 SET a=a||a||a||a||a||a||a;</copy>

    8 rows updated.

    SQL> <copy>UPDATE hr.t1 SET a=a||a||a||a||a||a||a;</copy>

    8 rows updated.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL>

    ```

2. Shrink the LOB segment.


    ```

    SQL> <copy>ALTER TABLE hr.t1 MODIFY LOB(a) (SHRINK SPACE);</copy>

    Table altered.

    SQL>

    ```

3. Display the number of extents or blocks freed. **Put the LOB_OBJD you saved from previous in and run the command**


    ```

    SQL> SELECT * FROM v$securefile_shrink WHERE LOB_OBJD=76063;

      LOB_OBJD SHRINK_STATUS

    ---------- ----------------------------------------

    START_TIME

    ---------------------------------------------------------------------------

    END_TIME

    ---------------------------------------------------------------------------

    BLOCKS_MOVED BLOCKS_FREED BLOCKS_ALLOCATED EXTENTS_ALLOCATED EXTENTS_FREED

    ------------ ------------ ---------------- ----------------- -------------

    EXTENTS_SEALED     CON_ID

    -------------- ----------

        76063 COMPLETE

    10-NOV-20 11.32.57.963 AM +00:00

    10-NOV-20 11.33.01.828 AM +00:00

            2648         2648             2648                 1            11

                11          3

        76063 COMPLETE

    10-NOV-20 11.30.55.545 AM +00:00

    10-NOV-20 11.30.55.917 AM +00:00

              2            2                2                 1             1

                1          3

    SQL>

    ```

  As a result, 2648 blocks are freed. Observe that the first row remains static.

4. Update the CLOB.


    ```

    SQL> <copy>UPDATE hr.t1 SET a=a||a;</copy>

    8 rows updated.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL>

    ```

5. Shrink the LOB segment.


    ```

    SQL> <copy>ALTER TABLE hr.t1 MODIFY LOB(a) (SHRINK SPACE);</copy>

    Table altered.

    SQL>

    ```

6. Display the number of extents or blocks freed. **Put the LOB_OBJD you saved from previous in and run the command**


    ```

    SQL> SELECT * FROM v$securefile_shrink WHERE LOB_OBJD=76063;

      LOB_OBJD SHRINK_STATUS

    ---------- ----------------------------------------

    START_TIME

    ---------------------------------------------------------------------------

    END_TIME

    ---------------------------------------------------------------------------

    BLOCKS_MOVED BLOCKS_FREED BLOCKS_ALLOCATED EXTENTS_ALLOCATED EXTENTS_FREED

    ------------ ------------ ---------------- ----------------- -------------

    EXTENTS_SEALED     CON_ID

    -------------- ----------

        76063 COMPLETE

    10-NOV-20 11.32.57.963 AM +00:00

    10-NOV-20 11.33.01.828 AM +00:00

            2648         2648             2648                 1            11

                11          3

        76063 COMPLETE

    10-NOV-20 11.39.53.565 AM +00:00

    10-NOV-20 11.39.57.271 AM +00:00

            2552         2552             2552                 1            16

                16          3
    ```
    ```

    SQL> <copy>EXIT</copy>

    $

    ```

  As a result, 2552 blocks are freed. Observe that only the row of the previous shrinking operation is kept.

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
