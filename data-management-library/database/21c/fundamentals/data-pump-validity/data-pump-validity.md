# Checking Oracle Data Pump Dump Files for Validity

## Introduction
This lab shows how to use the checksum to confirm that an Oracle Data Pump dump file is valid after a transfer to or from the object store and also after saving dump files on on-premises.The checksum ensures that no accidental or malicious changes occurred.

Estimated Lab Time: 10 minutes

### Objectives
In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Set up the environment

1. Execute the `/home/oracle/labs/M104786GC10/DP.sh` shell script. The shell script creates the table `HR.EMPLOYEES` to export in `PDB21`.


    ```

    $ <copy>cd /home/oracle/labs/M104786GC10</copy>

    $ <copy>/home/oracle/labs/M104786GC10/DP.sh</copy>

    SQL> host mkdir /u01/app/oracle/admin/CDB21/tde

    mkdir: cannot create directory '/u01/app/oracle/admin/CDB21/tde': File exists

    SQL>

    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER=ALL ;

    ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER=ALL

    *

    ERROR at line 1:

    ORA-28389: cannot close auto login wallet

    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE IDENTIFIED BY <i>WElcome123##</i> CONTAINER=ALL;

    keystore altered.

    ...

    specify password for HR as parameter 1:

    specify default tablespace for HR as parameter 2:

    specify temporary tablespace for HR as parameter 3:

    specify log path as parameter 4:

    PL/SQL procedure successfully completed.

    User created.

    ...

    ******  Creating EMPLOYEES table ....

    Table created.

    Index created.

    Table altered.

    Table altered.

    Sequence created.

    ...

    Commit complete.

    Session altered.

    ...

    ******  Populating EMPLOYEES table ....

    1 row created.

    ...

    Commit complete.

    Index created.

    ...

    Commit complete.

    Procedure created.

    Trigger created.

    Trigger altered.

    Procedure created.

    Trigger created.

    Commit complete.

    ...

    Directory created.

    Grant succeeded.

    $

    ```

## **STEP 2:** Export the table using the checksum

1. Export the table `HR.EMPLOYEES` and add a checksum to the dump file to be able to confirm that the dump file is still valid after the export and that the data is intact and has not been corrupted. An Oracle Data Pump export writes control information into the header block of a dump file: Oracle Database 21c extends the data integrity checks by adding an additional checksum for all the remaining blocks beyond the header within Oracle Data Pump and external table dump files. Use the `CHECKSUM` parameter during the export operation.


    ```

    $ <copy>expdp system@PDB21 TABLES=hr.employees DUMPFILE=dp_dir:emp.dmp CHECKSUM=yes REUSE_DUMPFILES=yes</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.

    Password: <b><i>WElcome123##</i></b>

    Starting "SYSTEM"."SYS_EXPORT_TABLE_01":  system/********@PDB21 TABLES=hr.employees dump file=dp_dir:emp.dmp CHECKSUM=YES

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

    Master table "SYSTEM"."SYS_EXPORT_TABLE_01" successfully loaded/unloaded

    Generating checksums for dump file set

    ******************************************************************************

    Dump file set for SYSTEM.SYS_EXPORT_TABLE_01 is:

      /home/oracle/labs/M104786GC10/emp.dmp

    Job "SYSTEM"."SYS_EXPORT_TABLE_01" successfully completed at Thu Feb 6 07:15:15 2020 elapsed 0 00:00:26

    $

    ```




  *The checksum algorithm defaults to `SHA256` 256-bit.*



3. If you want to use the `SHA384` 384-bit hash algorithm or `SHA512` 512-bit hash algorithm or the `CRC32` 32-bit checksum, use the `CHECKSUM_ALGORITHM` parameter and not the `CHECKSUM` parameter which uses the `SHA256` 256-bit hash algorithm.


    ```

    $ <copy>expdp system@PDB21 TABLES=hr.employees DUMPFILE=dp_dir:emp384.dmp CHECKSUM_ALGORITHM=SHA384 CHECKSUM=no REUSE_DUMPFILES=yes</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.

    Password: <b><i>WElcome123##</i></b>

    ORA-39002: invalid operation

    ORA-39050: parameter CHECKSUM=NO is incompatible with parameter CHECKSUM_ALGORITHM

    $

    ```

    ```

    $ <copy>expdp system@PDB21 TABLES=hr.employees DUMPFILE=dp_dir:emp512.dmp CHECKSUM_ALGORITHM=SHA512 REUSE_DUMPFILES=yes</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.

    Password: <b><i>WElcome123##</i></b>

    Starting "SYSTEM"."SYS_EXPORT_TABLE_01":  system/********@PDB21 TABLES=hr.employees dump file=dp_dir:emp512.dmp CHECKSUM_ALGORITHM=SHA512

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

    Master table "SYSTEM"."SYS_EXPORT_TABLE_01" successfully loaded/unloaded

    Generating checksums for dump file set

    ******************************************************************************

    Dump file set for SYSTEM.SYS_EXPORT_TABLE_01 is:

      /home/oracle/labs/M104786GC10/emp512.dmp

    Job "SYSTEM"."SYS_EXPORT_TABLE_01" successfully completed at Thu Feb 6 07:46:51 2020 elapsed 0 00:00:09

    $

    ```

## **STEP 3:** Import the table

1. Drop the table before importing it.


    ```

    $ <copy>sqlplus hr@PDB21</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: <b><i>WElcome123##</i></b>

    Connected to:
    ```
    ```

    SQL> <copy>DROP TABLE employees CASCADE CONSTRAINTS;</copy>

    Table dropped.

    SQL> <copy>EXIT</copy>

    $

    ```

2. Before importing the table, verify whether the dump files are corrupted or not.

    - Corrupt one of the dump files by executing the `/home/oracle/labs/M104786GC10/corrupt.sh` shell script.

    ```

    $ <copy>/home/oracle/labs/M104786GC10/corrupt.sh</copy>
    $

    ```

    - Find which of the two dump files is corrupted.

    ```

    $ <copy>impdp system@PDB21 FULL=yes DUMPFILE=dp_dir:emp512.dmp VERIFY_ONLY=YES</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.
    Password: <b><i>WElcome123##</i></b>

    Verifying dump file checksums
    Master table "SYSTEM"."SYS_IMPORT_FULL_01" successfully loaded/unloaded
    dump file set is complete
    <b>verified checksum for dump file</b> "/home/oracle/labs/M104786GC10/emp512.dmp"
    <b>dump file set is consistent</b>
    Job "SYSTEM"."SYS_IMPORT_FULL_01" successfully completed at Fri Feb 7 05:42:40 2020 elapsed 0 00:00:01
    $

    ```
    ```

    $ <copy>impdp system@PDB21 FULL=yes DUMPFILE=dp_dir:emp.dmp VERIFY_ONLY=YES</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.
    Password: <b><i>WElcome123##</i></b>

    ORA-39001: invalid argument value
    ORA-39000: bad dump file specification
    ORA-39411: header checksum error in dump file "/home/oracle/labs/M104786GC10/emp.dmp"
    ```
    ```
    $ <copy>oerr ora 39411</copy>
    39411, 00000, "header checksum error in dump file \"%s\""
    // *Cause:  <b>The header block for the Data Pump dump file contained a
    //          header checksum that did not match the value calculated from the
    //          header block as read from disk.</b> This indicates that the header
    //          was tampered with or otherwise corrupted due to transmission or
    //          media failure.
    // *Action: Contact Oracle Support Services.
    $

    ```




3. Import the table.


    - Import the table using the corrupted dump file. If checksums were generated when the export dump files were completed, the checksum is verified during the import.

    ```

    $ <copy>impdp system@PDB21 FULL=yes DUMPFILE=dp_dir:emp.dmp</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.
    Password: <b><i>WElcome123##</i></b>

    ORA-39001: invalid argument value
    ORA-39000: bad dump file specification
    ORA-39411: <b>header checksum error</b> in dump file "/home/oracle/labs/M104786GC10/emp.dmp"
    $

    ```

    - Import the table using the non-corrupted dump file. If checksums were generated when the export dump files were completed, the checksum is verified during the import if you mention the parameter `VERIFY_CHECKSUM`. Ignore the error messages related to indexes creation. The important in this practice is that the table can be reimported.

    ```

    $ <copy>impdp system@PDB21 FULL=yes DUMPFILE=dp_dir:emp512.dmp VERIFY_CHECKSUM=YES</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.
    Password: <b><i>WElcome123##</i></b>

    <b>Verifying dump file checksums</b>
    Master table "SYSTEM"."SYS_IMPORT_FULL_01" successfully loaded/unloaded
    Starting "SYSTEM"."SYS_IMPORT_FULL_01":  system/********@PDB21 FULL=yes DUMPFILE=dp_dir:emp512.dmp VERIFY_CHECKSUM=YES
    Processing object type TABLE_EXPORT/TABLE/TABLE
    Processing object type TABLE_EXPORT/TABLE/TABLE_DATA
    . . imported "HR"."EMPLOYEES"                            17.08 KB     107 rows
    Processing object type TABLE_EXPORT/TABLE/COMMENT
    Processing object type TABLE_EXPORT/TABLE/INDEX/INDEX
    Processing object type TABLE_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
    Processing object type TABLE_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS
    Processing object type TABLE_EXPORT/TABLE/CONSTRAINT/REF_CONSTRAINT
    Processing object type TABLE_EXPORT/TABLE/TRIGGER
    Processing object type TABLE_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
    Processing object type TABLE_EXPORT/TABLE/STATISTICS/MARKER
    Job "SYSTEM"."SYS_IMPORT_FULL_01" successfully completed at Tue Mar 17 07:20:29 2020 elapsed 0 00:00:20
    $

    ```

    - Import using the non-corrupted dumpfile avoiding the verification. Drop the table first.

    ```

    $ <copy>sqlplus hr@pdb21</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: <b><i>WElcome123##</i></b>

    Connected to:
    ```
    ```

    SQL> <copy>DROP TABLE employees CASCADE CONSTRAINTS;</copy>

    Table dropped.

    SQL> <copy>EXIT</copy>

    $ <copy>impdp hr@PDB21 FULL=yes DUMPFILE=dp_dir:emp512.dmp VERIFY_CHECKSUM=NO</copy>

    Copyright (c) 1982, 2020, Oracle and/or its affiliates.  All rights reserved.
    Password: <b><i>WElcome123##</i></b>
    Master table "HR"."SYS_IMPORT_FULL_01" successfully loaded/unloaded
    Connected to: Oracle Database 20c Enterprise Edition Release 20.0.0.0.0 - Production
    Warning: <b>dump file checksum verification is disabled</b>
    Master table "HR"."SYS_IMPORT_FULL_01" successfully loaded/unloaded
    Starting "HR"."SYS_IMPORT_FULL_01":  system/********@PDB21 FULL=yes DUMPFILE=dp_dir:emp512.dmp VERIFY_CHECKSUM=NO
    Processing object type TABLE_EXPORT/TABLE/TABLE
    Processing object type TABLE_EXPORT/TABLE/TABLE_DATA
    . . <b>imported "HR"."EMPLOYEES"</b>                          17.08 KB     107 rows
    Processing object type TABLE_EXPORT/TABLE/COMMENT
    Processing object type TABLE_EXPORT/TABLE/INDEX/INDEX
    Processing object type TABLE_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
    Processing object type TABLE_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS
    Processing object type TABLE_EXPORT/TABLE/CONSTRAINT/REF_CONSTRAINT
    Processing object type TABLE_EXPORT/TABLE/TRIGGER
    Processing object type TABLE_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
    Processing object type TABLE_EXPORT/TABLE/STATISTICS/MARKER
    Job "HR"."SYS_IMPORT_FULL_01" successfully completed at Tue Mar 17 07:22:04 2020 elapsed 0 00:00:20
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
