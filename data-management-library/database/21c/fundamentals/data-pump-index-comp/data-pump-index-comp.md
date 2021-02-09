# Using Index Compression on Import

## Introduction
This lab shows how to use index compression on import operations.


Estimated Lab Time: 20 minutes

### Objectives
In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Set up the environment

1. Create the `HR` schema. Change the string *password* in the command by your password.


    ```

    $ <copy>sqlplus "sys@PDB21 AS SYSDBA" @/home/oracle/labs/M104780GC10/hr_main.sql WElcome123## users temp /tmp</copy>

    ...

    Commit complete.

    PL/SQL procedure successfully completed.

    SQL> EXIT

    $

    ```

2. Verify that the `HR.EMPLOYEES` table is not using compression and does own indexes that are not using compression.


    ```

    $ <copy>sqlplus SYSTEM@PDB21</copy>

    Enter password: <b><i>WElcome123##</i></b>

    Connected to:
    ```
    ```

    SQL> <copy>SELECT compression, compress_for FROM DBA_TABLES WHERE table_name='EMPLOYEES';</copy>

    COMPRESS COMPRESS_FOR

    -------- ------------------------------

    DISABLED

    SQL> <copy>COL INDEX_NAME FORMAT A30</copy>

    SQL> <copy>SELECT index_name, compression FROM dba_indexes WHERE table_name='EMPLOYEES';</copy>

    INDEX_NAME                     COMPRESSION

    ------------------------------ -------------

    EMP_NAME_IX                    DISABLED

    EMP_EMAIL_UK                   DISABLED

    EMP_EMP_ID_PK                  DISABLED

    EMP_DEPARTMENT_IX              DISABLED

    EMP_JOB_IX                     DISABLED

    EMP_MANAGER_IX                 DISABLED

    6 rows selected.

    SQL>

    ```

3.  Create a directory for Oracle Data Pump dumpfiles.


    ```

    SQL> <copy>CREATE OR REPLACE DIRECTORY dp_dir AS '/home/oracle/labs';</copy>

    Directory created.

    SQL> <copy>GRANT read, write ON DIRECTORY dp_dir TO hr;</copy>

    Grant succeeded.

    SQL> <copy>EXIT</copy>

    $

    ```

## **STEP 2:** Export the table

Export the `HR.EMPLOYEES` table. Ignore any Database Vault warning.

  ```

  $ <copy>expdp hr@PDB21 DUMPFILE=PDB21.dmp DIRECTORY=dp_dir TABLES=EMPLOYEES REUSE_DUMPFILES=YES</copy>

  Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.
  Password: <b><i>WElcome123##</i></b>

  Starting "HR"."SYS_EXPORT_TABLE_01":  hr/********@PDB21 DUMPFILE=PDB21.dmp DIRECTORY=dp_dir TABLES=EMPLOYEES REUSE_DUMPFILES=YES
  Processing object type TABLE_EXPORT/TABLE/TABLE_DATA
  Processing object type TABLE_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS
  Processing object type TABLE_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
  Processing object type TABLE_EXPORT/TABLE/STATISTICS/MARKER
  Processing object type TABLE_EXPORT/TABLE/TABLE
  Processing object type TABLE_EXPORT/TABLE/COMMENT
  Processing object type TABLE_EXPORT/TABLE/INDEX/INDEX
  Processing object type TABLE_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
  Processing object type TABLE_EXPORT/TABLE/CONSTRAINT/REF_CONSTRAINT
  Processing object type TABLE_EXPORT/TABLE/TRIGGER
  . . exported "HR"."EMPLOYEES"                            17.08 KB     107 rows
  ORA-39173: Encrypted data has been stored unencrypted in dump file set.
  Master table "HR"."SYS_EXPORT_TABLE_01" successfully loaded/unloaded
  ******************************************************************************
  Dump file set for HR.SYS_EXPORT_TABLE_01 is:
    /home/oracle/labs/PDB21.dmp
  Job "HR"."SYS_EXPORT_TABLE_01" successfully completed at Wed Apr 8 16:27:55 2020 elapsed 0 00:00:29
  $

  ```

## **STEP 3:** Import the table using the compression parameters

1. Drop the table in `PDB21`.


    ```

    $ <copy>sqlplus SYSTEM@PDB21</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Last Successful login time: Wed Apr 08 2020 16:24:56 +00:00

    Connected to:
    ```
    ```

    SQL> <copy>DROP TABLE hr.employees CASCADE CONSTRAINTS;</copy>

    Table dropped.

    SQL> <copy>EXIT</copy>

    $

    ```

2. Import the table using the index compression and the table compression parameters.


    ```

    $ <copy>impdp hr@PDB21 FULL=Y DUMPFILE=PDB21.dmp DIRECTORY=dp_dir TRANSFORM=TABLE_COMPRESSION_CLAUSE:\"COMPRESS BASIC\" TRANSFORM=INDEX_COMPRESSION_CLAUSE:\"COMPRESS ADVANCED LOW\" EXCLUDE=CONSTRAINT</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.

    Password: <b><i>WElcome123##</i></b>

    Master table "HR"."SYS_IMPORT_FULL_01" successfully loaded/unloaded

    Starting "HR"."SYS_IMPORT_FULL_01":  hr/********@PDB21 FULL=Y DUMPFILE=PDB21.dmp DIRECTORY=dp_dir TRANSFORM=TABLE_COMPRESSION_CLAUSE:"COMPRESS BASIC" TRANSFORM=INDEX_COMPRESSION_CLAUSE:"COMPRESS ADVANCED LOW" EXCLUDE=CONSTRAINT

    Processing object type TABLE_EXPORT/TABLE/TABLE

    Processing object type TABLE_EXPORT/TABLE/TABLE_DATA

    . . imported "HR"."EMPLOYEES"                            17.08 KB     107 rows

    Processing object type TABLE_EXPORT/TABLE/COMMENT

    Processing object type TABLE_EXPORT/TABLE/INDEX/INDEX

    ORA-39083: Object type INDEX:"HR"."EMP_EMP_ID_PK" failed to create with error:

    ORA-25193: cannot use COMPRESS option for a single column key

    Failing sql is:

    CREATE UNIQUE INDEX "HR"."EMP_EMP_ID_PK" ON "HR"."EMPLOYEES" ("EMPLOYEE_ID") PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPRESS ADVANCED LOW  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "USERS"

    Processing object type TABLE_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS

    Processing object type TABLE_EXPORT/TABLE/TRIGGER

    Processing object type TABLE_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS

    Processing object type TABLE_EXPORT/TABLE/STATISTICS/MARKER

    Job "HR"."SYS_IMPORT_FULL_01" completed with 1 error(s) at Wed Apr 8 16:39:55 2020 elapsed 0 00:00:36

    $

    ```

  Ignore the errors.

3. Verify that the table imported is using compression and that its indexes use compression too.


    ```

    $ <copy>sqlplus SYSTEM@PDB21</copy>



    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Last Successful login time: Wed Apr 08 2020 16:38:57 +00:00

    Connected to:
    ```
    ```

    SQL> <copy>SELECT compression, compress_for FROM DBA_TABLES WHERE table_name='EMPLOYEES';</copy>

    COMPRESS COMPRESS_FOR

    -------- ------------------------------

    ENABLED  BASIC

    SQL> <copy>COL INDEX_NAME FORMAT A30</copy>

    SQL> <copy>SELECT index_name, compression FROM dba_indexes WHERE table_name='EMPLOYEES';</copy>

    INDEX_NAME                     COMPRESSION

    ------------------------------ -------------

    EMP_DEPARTMENT_IX              ADVANCED LOW

    EMP_JOB_IX                     ADVANCED LOW

    EMP_MANAGER_IX                 ADVANCED LOW

    EMP_NAME_IX                    ADVANCED LOW

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
