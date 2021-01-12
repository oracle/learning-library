# Including and Excluding Objects from Export or Import

## Introduction
This lab shows how to export or import objects by including and excluding objects during the same operation.

Estimated Lab Time: 15 minutes

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Set up the environment

1. Use the `/home/oracle/labs/M104780GC10/create_PDB21_2.sh` shell script to create the `PDB21_2` PDB and the `HR` user in `PDB21_2`.


    ```

    $ <copy>cd /home/oracle/labs/M104780GC10</copy>

    $ <copy>/home/oracle/labs/M104780GC10/create_PDB21_2.sh</copy>

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to:

    SQL> ALTER SESSION SET db_create_file_dest='/home/oracle/labs';

    Session altered.

    SQL> ALTER PLUGGABLE DATABASE pdb20_2 CLOSE;

    Pluggable database altered.

    SQL> DROP PLUGGABLE DATABASE pdb20_2 INCLUDING DATAFILES;

    Pluggable database dropped.

    SQL>

    SQL> CREATE PLUGGABLE DATABASE pdb21_2

      2      ADMIN USER pdb_admin IDENTIFIED BY password ROLES=(CONNECT)

      3          DEFAULT TABLESPACE users DATAFILE SIZE 1M AUTOEXTEND ON NEXT 1M

      4      CREATE_FILE_DEST='/home/oracle/labs';

    Pluggable database created.

    SQL> ALTER PLUGGABLE DATABASE pdb21_2 OPEN;

    Pluggable database altered.

    SQL> exit

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to:

    SQL> DROP USER hr CASCADE;

    DROP USER hr CASCADE

              *

    ERROR at line 1:

    ORA-01918: user 'HR' does not exist

    SQL> CREATE USER hr IDENTIFIED BY password;

    User created.

    SQL> GRANT create session, create table, unlimited tablespace TO hr;

    Grant succeeded.

    SQL> CREATE DIRECTORY dp_dir AS '/home/oracle/labs';

    Directory created.

    SQL> GRANT read, write ON DIRECTORY dp_dir TO hr;

    Grant succeeded.

    SQL> EXIT

    $

    ```

2. Before exporting the two `HR` tables excluding their statistics, verify that the two `HR` tables have statistics collected, and create a directory for the export dumpfile.

    - Verify that the two `HR` tables have statistics collected.

    ```

    $ <copy>sqlplus system@PDB21</copy>

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Enter password: <b><i>WElcome123##</i></b>
    Last Successful login time: Tue Mar 17 2020 02:23:18 +00:00

    Connected to:
    ```
    ```

    SQL> <copy>SELECT num_rows FROM dba_tables WHERE table_name IN ('JOBS','DEPARTMENTS');</copy>

      NUM_ROWS
    ----------
            27
            19

    SQL>

    ```

    - Create a directory for the export dumpfile.

    ```

    SQL> <copy>CREATE OR REPLACE DIRECTORY dp_dir AS '/home/oracle/labs';</copy>

    Directory created.

    SQL> <copy>GRANT read, write ON DIRECTORY dp_dir TO hr;</copy>

    Grant succeeded.

    SQL> <copy>EXIT</copy>
    $

    ```




## **STEP 2:** Export tables excluding their statistics

Export from `PDB21` two `HR` tables, excluding their statistics.

```

$ <copy>expdp hr@PDB21 DUMPFILE=hr.dmp DIRECTORY=dp_dir INCLUDE=TABLE:\"IN \(\'JOBS\',\'DEPARTMENTS\'\)\" EXCLUDE=STATISTICS REUSE_DUMPFILES=YES</copy>

Password: <b><i>WElcome123##</i></b>

Starting "HR"."SYS_EXPORT_SCHEMA_01":  hr/********@PDB21 DUMPFILE=hr.dmp DIRECTORY=dp_dir INCLUDE=TABLE:"IN ('JOBS','DEPARTMENTS')" EXCLUDE=STATISTICS REUSE_DUMPFILES=YES
Processing object type SCHEMA_EXPORT/TABLE/TABLE_DATA
Processing object type SCHEMA_EXPORT/TABLE/TABLE
Processing object type SCHEMA_EXPORT/TABLE/COMMENT
Processing object type SCHEMA_EXPORT/TABLE/INDEX/INDEX
Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/REF_CONSTRAINT
. . exported "HR"."JOBS"                                 7.109 KB      19 rows
. . exported "HR"."DEPARTMENTS"                          7.125 KB      27 rows
Master table "HR"."SYS_EXPORT_SCHEMA_01" successfully loaded/unloaded
******************************************************************************
Dump file set for HR.SYS_EXPORT_SCHEMA_01 is:
  /home/oracle/labs/hr.dmp
Job "HR"."SYS_EXPORT_SCHEMA_01" successfully completed at Tue Mar 17 02:30:24 2020 elapsed 0 00:00:18
$

```

## **STEP 3:** Import tables

1. Create the data pump directory in the database.
```

$ <copy>sqlplus system@PDB21_2</copy>

Copyright (c) 1982, 2020, Oracle.  All rights reserved.

Enter password: <b><i>WElcome123##</i></b>
Last Successful login time: Tue Mar 17 2020 02:23:18 +00:00

Connected to:
```
```

SQL> <copy>CREATE OR REPLACE DIRECTORY dp_dir AS '/home/oracle/labs';</copy>

Directory created.

SQL> <copy>CREATE TABLESPACE users DATAFILE '/u02/app/oracle/oradata/pdb21/pdb21_2_users01.dbf' size 100M reuse;</copy>

SQL> <copy>EXIT</copy>
$

```


2. Import the dumpfile into another PDB, `PDB21_2` in `CDB21`.


    ```

    $ <copy>impdp system@PDB21_2 DUMPFILE=hr.dmp DIRECTORY=dp_dir FULL=Y</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.

    Password: <b><i>WElcome123##</i></b>

    Master table "SYSTEM"."SYS_IMPORT_FULL_01" successfully loaded/unloaded

    Starting "SYSTEM"."SYS_IMPORT_FULL_01":  system/********@PDB21_2 DUMPFILE=hr.dmp DIRECTORY=DP_DIR FULL=Y

    Processing object type SCHEMA_EXPORT/TABLE/TABLE

    Processing object type SCHEMA_EXPORT/TABLE/TABLE_DATA

    . . imported "HR"."JOBS"                                 7.109 KB      19 rows

    . . imported "HR"."DEPARTMENTS"                          7.125 KB      27 rows

    Processing object type SCHEMA_EXPORT/TABLE/COMMENT

    Processing object type SCHEMA_EXPORT/TABLE/INDEX/INDEX

    Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/CONSTRAINT

    Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/REF_CONSTRAINT

    ORA-39083: Object type REF_CONSTRAINT:"HR"."DEPT_LOC_FK" failed to create with error:

    ORA-00942: table or view does not exist

    Failing sql is:

    ALTER TABLE "HR"."DEPARTMENTS" ADD CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID") REFERENCES "HR"."LOCATIONS" ("LOCATION_ID") ENABLE

    ORA-39083: Object type REF_CONSTRAINT:"HR"."DEPT_MGR_FK" failed to create with error:

    ORA-00942: table or view does not exist

    Failing sql is:

    ALTER TABLE "HR"."DEPARTMENTS" ADD CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES "HR"."EMPLOYEES" ("EMPLOYEE_ID") ENABLE

    ...

    Job "SYSTEM"."SYS_IMPORT_FULL_01" completed with 19 error(s) at Tue Mar 17 04:03:37 2020 elapsed 0 00:00:05

    $

    ```

  The import completes with errors due to missing constraints for `HR.DEPARTMENTS` that requires constraints referring other `HR` tables.

3. Re-execute the export operation excluding statistics and constraints.


    ```

    $ <copy>expdp hr@PDB21 DUMPFILE=hr.dmp DIRECTORY=dp_dir INCLUDE=TABLE:\"IN \(\'JOBS\',\'DEPARTMENTS\'\)\" EXCLUDE=STATISTICS,CONSTRAINT REUSE_DUMPFILES=YES</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.

    Password: <b><i>WElcome123##</i></b>

    Starting "HR"."SYS_EXPORT_SCHEMA_01":  hr/********@PDB21 DUMPFILE=hr.dmp DIRECTORY=dp_dir INCLUDE=TABLE:"IN ('JOBS','DEPARTMENTS')" EXCLUDE=STATISTICS,CONSTRAINT REUSE_DUMPFILES=YES

    Processing object type SCHEMA_EXPORT/TABLE/TABLE_DATA

    Processing object type SCHEMA_EXPORT/TABLE/TABLE

    Processing object type SCHEMA_EXPORT/TABLE/COMMENT

    Processing object type SCHEMA_EXPORT/TABLE/INDEX/INDEX

    . . exported "HR"."JOBS"                                 7.109 KB      19 rows

    . . exported "HR"."DEPARTMENTS"                          7.125 KB      27 rows

    Master table "HR"."SYS_EXPORT_SCHEMA_01" successfully loaded/unloaded

    ******************************************************************************

    Dump file set for HR.SYS_EXPORT_SCHEMA_01 is:

      /home/oracle/labs/hr.dmp

    Job "HR"."SYS_EXPORT_SCHEMA_01" successfully completed at Tue Mar 17 04:06:15 2020 elapsed 0 00:00:14

    $

    ```

4. Reimport the dumpfile into `PDB21_2` in `CDB21` after dropping the tables `HR.JOBS` and `HR.DEPARTMENTS`.


    ```

    $ <copy>sqlplus system@PDB21_2</copy>

    Enter password: <b><i>WElcome123##</i></b>
    ```
    ```

    SQL> <copy>DROP TABLE hr.jobs CASCADE CONSTRAINTS;</copy>

    Table dropped.

    SQL> <copy>DROP TABLE hr.departments CASCADE CONSTRAINTS;</copy>

    Table dropped.

    SQL> <copy>EXIT</copy>
    ```
    ```
    $ <copy>impdp system@PDB21_2 DUMPFILE=hr.dmp DIRECTORY=DP_DIR FULL=Y</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.

    Password: <b><i>WElcome123##</i></b>

    Master table "SYSTEM"."SYS_IMPORT_FULL_01" successfully loaded/unloaded

    Starting "SYSTEM"."SYS_IMPORT_FULL_01":  system/********@PDB21_2 DUMPFILE=hr.dmp DIRECTORY=DP_DIR FULL=Y

    Processing object type SCHEMA_EXPORT/TABLE/TABLE

    Processing object type SCHEMA_EXPORT/TABLE/TABLE_DATA

    . . imported "HR"."JOBS"                                 7.109 KB      19 rows

    . . imported "HR"."DEPARTMENTS"                          7.125 KB      27 rows

    Processing object type SCHEMA_EXPORT/TABLE/COMMENT

    Processing object type SCHEMA_EXPORT/TABLE/INDEX/INDEX

    ...

    Job "SYSTEM"."SYS_IMPORT_FULL_01" successfully completed at Tue Mar 17 04:03:37 2020 elapsed 0 00:00:05

    $

    ```

  *Observe that the import does not issue errors related to constraints. Constraints that should have been added to the `HR.DEPARTMENTS` table were excluded.*



5. Verify that statistics for the `HR.JOBS` and `HR.DEPARTMENTS` tables were excluded too.


    ```

    $ <copy>sqlplus system@PDB21_2</copy>

    Enter password: <b><i>WElcome123##</i></b>
    ```
    ```

    SQL> <copy>SELECT num_rows FROM dba_tables WHERE table_name IN ('JOBS','DEPARTMENTS');</copy>

    no  rows selected

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
