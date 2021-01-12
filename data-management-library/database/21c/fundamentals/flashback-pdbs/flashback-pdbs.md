# Flashbacking PDBs to Any Time in the Recent Past

## Introduction
This lab shows how to perform a PDB PITR (Point in Time Recovery)/Flashback to a specific time, then a PDB PITR/Flashback to a PDB time on an orphan PDB incarnation.

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

1. The shell script enables flashback in the CDB, creates `PDB21` and creates the HR schema in `PDB21`.


    ```

    $ <copy>cd /home/oracle/labs/M104782GC10</copy>

    $ <copy>/home/oracle/labs/M104782GC10/setup_Flashback.sh</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

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

    SQL> ALTER DATABASE FLASHBACK on;

    Database altered.

    ...

    SQL> DROP PLUGGABLE DATABASE pdb21 INCLUDING DATAFILES;

    Pluggable database dropped.

    SQL> CREATE PLUGGABLE DATABASE pdb21

      2      ADMIN USER pdb_admin IDENTIFIED BY password ROLES=(CONNECT)

      3      CREATE_FILE_DEST='/home/oracle/labs';

    Pluggable database created.

    SQL>

    SQL> ALTER PLUGGABLE DATABASE pdb21 OPEN;

    Pluggable database altered.

    SQL> exit

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Connected to:

    specify password for HR as parameter 1:

    specify default tablespeace for HR as parameter 2:

    specify temporary tablespace for HR as parameter 3:

    specify log path as parameter 4:

    PL/SQL procedure successfully completed.

    User created.

    ALTER USER hr DEFAULT TABLESPACE users

    ...

    Commit complete.

    PL/SQL procedure successfully completed.

    $

    ```

2. Connect to the CDB root and check that the CDB is open and enabled for flashback.


    ```

    $ <copy>sqlplus / AS SYSDBA</copy>

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to:
    ```
    ```

    SQL> <copy>SELECT open_mode, flashback_on FROM v$database;</copy>

    OPEN_MODE            FLASHBACK_ON

    -------------------- ------------------

    READ WRITE           YES

    SQL>

    ```

## **STEP 2:** Complete a human error on a table

1. Before any DDL or DML command is executed on `HR.EMPLOYEES` table in `PDB21`, display the current SCN, its associated timestamp and the incarnations of the PDB. **Make sure to take note of the SCN as you will use it in future steps**


    ```

    SQL> <copy>CONNECT sys@PDB21 AS SYSDBA</copy>

    Enter password: <b><i>WElcome123##</i></b>

    Connected.
    ```
    ```

    SQL> <copy>COL TIMESTAMP FORMAT A40</copy>

    SQL> <copy>SELECT CURRENT_SCN, SCN_TO_TIMESTAMP(CURRENT_SCN) "TIMESTAMP" from V$DATABASE;</copy>

    CURRENT_SCN SCN_TO_TIMESTAMP(CURRENT_SCN)

    ----------- --------------------------------------------------------------------

        3880324 13-MAR-20 07.12.24.000000000 AM

    SQL> <copy>SELECT con_id, status, pdb_incarnation# inc#, begin_resetlogs_scn, end_resetlogs_scn
            FROM   v$pdb_incarnation ORDER BY 3;</copy>

        CON_ID STATUS        INC# BEGIN_RESETLOGS_SCN END_RESETLOGS_SCN

    ---------- ------- ---------- ------------------- -----------------

            4 PARENT           0                   1                 1

            4 CURRENT          0             2667602           2667602

    SQL>

    ```

  Possible `ORPHAN` incarnations would come from previous PDB resetlogs.

2. Display the number of rows in `HR.EMPLOYEES` table.


    ```

    SQL> <copy>SELECT count(*) FROM hr.employees;</copy>

      COUNT(*)

    ----------

          107

    SQL>

    ```

3. A user makes an accidental removal of the `HR.EMPLOYEES` table in `PDB21`.


    ```

    SQL> <copy>DROP TABLE hr.employees CASCADE CONSTRAINTS;</copy>

    Table dropped.

    SQL>

    ```

## **STEP 3:** Restore the table

1. Flashback the PDB so as to restore the dropped table. Ensure that   `PDB21` is closed. Other PDBs can be open and operational.  


    ```

    SQL> <copy>ALTER PLUGGABLE DATABASE CLOSE;</copy>

    Pluggable database altered.

    SQL>

    ```

2. Flashback the data back to the point before the table was dropped. You need not set the orphan PDB incarnation if the flashback operation is to a specified time or restore point. Determine the desired SCN or point in time for the Flashback Database command. This point must be within the current CDB incarnation or an ancestor CDB incarnation. **You will need to change the SCN in the command below to the SCN from Step 2.**


    ```

    SQL> <copy>FLASHBACK PLUGGABLE DATABASE TO SCN 3880324;</copy>

    Flashback complete.

    SQL>

    ```

3. Open `PDB21` with `RESETLOGS`.


    ```

    SQL> <copy>ALTER PLUGGABLE DATABASE OPEN RESETLOGS;</copy>

    Pluggable database altered.

    SQL> <copy>SELECT count(*) FROM hr.employees;</copy>



      COUNT(*)

    ----------

          107

    SQL>

    ```

4. Display the incarnations of `PDB21`.


    ```

    SQL> <copy>SELECT con_id, pdb_incarnation# INC#, status, incarnation_scn, end_resetlogs_scn
                        FROM v$pdb_incarnation ORDER BY 1, 2;</copy>

       CON_ID       INC# STATUS  INCARNATION_SCN END_RESETLOGS_SCN

    ---------- ---------- ------- --------------- -----------------

            4          0 PARENT          2667602           2667602

            4          1 CURRENT         3880344           3881083

    SQL>

    ```

## **STEP 4:** Complete a second human error on a table

1. Increase the salary of the employees in `HR.EMPLOYEES` by 2 for some employees.


    ```

    SQL> <copy>SELECT min(salary), MAX(salary) FROM hr.employees;</copy>

    MIN(SALARY) MAX(SALARY)

    ----------- -----------

          2100       24000



    SQL> <copy>UPDATE hr.employees SET salary=salary*2 WHERE employee_id<200;</copy>

    100 rows updated.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL> <copy>SELECT CURRENT_SCN, SCN_TO_TIMESTAMP(CURRENT_SCN) "TIMESTAMP" from V$DATABASE;</copy>

    CURRENT_SCN TIMESTAMP

    ----------- ----------------------------------------

        3881391 13-MAR-20 07.16.33.000000000 AM

    SQL>

    ```

2. Two minutes later, you delete the employee 206.


    ```

    SQL> <copy>DELETE FROM hr.employees WHERE employee_id=206;</copy>

    1 rows deleted.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL> <copy>SELECT count(*) FROM hr.employees;</copy>

      COUNT(*)

    ----------

          106

    SQL> <copy>SELECT CURRENT_SCN, SCN_TO_TIMESTAMP(CURRENT_SCN) "TIMESTAMP" from V$DATABASE;</copy>

    CURRENT_SCN TIMESTAMP

    ----------- ----------------------------------------

        3882392 13-MAR-20 07.20.27.000000000 AM

    SQL> <copy>SELECT con_id, pdb_incarnation# INC#, status, incarnation_scn, end_resetlogs_scn
                        FROM v$pdb_incarnation ORDER BY 1, 2;</copy>



        CON_ID       INC# STATUS  INCARNATION_SCN END_RESETLOGS_SCN

    ---------- ---------- ------- --------------- -----------------

            4          0 PARENT          2667602           2667602

            4          1 CURRENT         3880344           3881083

    SQL>

    ```

## **STEP 5:** Restore the table back to the point before the table was dropped

1. You decide to flashback the data back to the point before the table was dropped. **You will need to change the SCN in the FLASHBACK command to the SCN you saved from before**  


    ```

    SQL> <copy>ALTER PLUGGABLE DATABASE CLOSE;</copy>

    Pluggable database altered.
    ```
    Before running this statement you need to change the SCN to the value you saved.
    ```

    SQL> <copy>FLASHBACK PLUGGABLE DATABASE TO SCN 3880324;</copy>

    Flashback complete.
    ```
    ```

    SQL> <copy>ALTER PLUGGABLE DATABASE OPEN RESETLOGS;</copy>

    Pluggable database altered.

    SQL> <copy>SELECT count(*) FROM hr.employees;</copy>

      COUNT(*)

    ----------

          107

    SQL> <copy>SELECT min(salary), MAX(salary) FROM hr.employees;</copy>

    MIN(SALARY) MAX(SALARY)

    ----------- -----------

          2100       24000

    SQL> <copy>SELECT con_id, pdb_incarnation# INC#, status, incarnation_scn, end_resetlogs_scn
            FROM v$pdb_incarnation ORDER BY 1, 2;</copy>

      2

        CON_ID       INC# STATUS  INCARNATION_SCN END_RESETLOGS_SCN

    ---------- ---------- ------- --------------- -----------------

            4          0 PARENT          2667602           2667602

            4          1 <b>ORPHAN</b>          3880344           3881083

            4          2 <b>CURRENT</b>         3880325           3882600

    SQL>

    ```

3. Users ask for resetting `PDB21` as it was after the salaries were updated and before the employee 206 was deleted. This state of `pdb21` belongs to incarnation 1 of `PDB21`. Set the orphan PDB incarnation to which the flashback PDB operation must be performed. This step is required because the flashback operation is to an SCN or specific time in an orphan PDB incarnation.


    ```

    SQL> <copy>RESET PLUGGABLE DATABASE TO INCARNATION 1;</copy>

    SP2-0734: unknown command beginning "RESET PLUG..." - rest of line ignored.

    SQL> <copy>EXIT</copy>

    $

    ```

  This command exists only in RMAN.


    ```

    $ <copy>rman TARGET sys@PDB21</copy>

    target database Password: <b><i>WElcome123##</i></b>

    connected to target database: CDB21:PDB21 (DBID=2289122758)
    ```
    ```

    RMAN> <copy>LIST INCARNATION OF PLUGGABLE DATABASE pdb21;</copy>

    using target database control file instead of recovery catalog

    List of Pluggable Database Incarnations

    DB Key  PDB Key <b>PDBInc</b> Key DBInc Key   PDB Name   Status     <b>Inc SCN</b>           Inc Time           Begin Reset SCN   Begin Reset Time

    ------- ------- --------   ---------   -------    --------  ---------------   ------------------  ---------------  ------------------

    2       4        2          2          PDB21      CURRENT    3880325          13-MAR-20            3882600          13-MAR-20

    End Reset SCN:3882600          End Reset Time:13-MAR-20        Guid:A0B8281946B32375E053424C960A082A

    2       4        <b>1</b>          2          PDB21      <b>ORPHAN     3880344</b>          13-MAR-20            3881083          13-MAR-20

    End Reset SCN:3881083          End Reset Time:13-MAR-20        Guid:A0B8281946B32375E053424C960A082A

    2       4        0          2          PDB21      PARENT     2667602          12-MAR-20            2667602          12-MAR-20

    End Reset SCN:2667602          End Reset Time:12-MAR-20        Guid:A0B8281946B32375E053424C960A082A

    RMAN> <copy>RESET PLUGGABLE DATABASE pdb21 TO INCARNATION 1;</copy>

    RMAN-00571: ===========================================================

    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============

    RMAN-00571: ===========================================================

    RMAN-03002: failure of reset database command at 03/13/2020 07:28:33

    RMAN-05625: command not allowed when connected to a pluggable database

    RMAN> <copy>exit</copy>

    Recovery Manager complete.

    $

    $ <copy>rman TARGET /</copy>

    Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

    connected to target database: CDB21 (DBID=2732805675)

    RMAN> <copy>ALTER PLUGGABLE DATABASE pdb21 CLOSE;</copy>

    using target database control file instead of recovery catalog

    Statement processed

    RMAN> <copy>RESET PLUGGABLE DATABASE pdb21 TO INCARNATION 1;</copy>

    pluggable database reset to incarnation 1
    ```

    **You will need to change the follow command and fill in the SCN you saved from previously.**
    ```
    RMAN> <copy>FLASHBACK PLUGGABLE DATABASE pdb21 TO SCN 3880344;</copy>
    ```
    ```

    Starting flashback at 13-JAN-20

    allocated channel: ORA_DISK_1

    channel ORA_DISK_1: SID=148 device type=DISK

    starting media recovery

    media recovery failed

    RMAN-00571: ===========================================================

    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============

    RMAN-00571: ===========================================================

    RMAN-03002: failure of flashback command at 03/13/2020 07:31:00

    ORA-39889: Specified System Change Number (SCN) or timestamp is in the middle of a previous PDB RESETLOGS operation.

    RMAN> <copy>exit</copy>

    $

    ```

  What does this error mean?


    ```

    $ <copy>oerr ora 39889</copy>

    39889, 00000, "Specified System Change Number (SCN) or timestamp is in the middle of a previous PDB RESETLOGS operation."

    // *Cause:  The specified System Change Number (SCN) or timestamp was in the

    //          middle of a previous PDB RESETLOGS operation. More specifically,

    //          each PDB RESETLOGS operation may create a PDB incarnation as shown

    //          in v$pdb_incarnation. Any SCN between INCARNATION_SCN and

    //          END_RESETLOGS_SCN or any timestamp between INCARNATION_TIME and

    //          END_RESETLOGS_TIME as shown in v$pdb_incarnation is considered in

    //          the middle of the PDB RESETLOGS operation.

    // *Action: Flashback the PDB to an SCN or timestamp that is not in the middle

    //          of a previous PDB RESETLOGS operation. If flashback to a SCN on the

    //          orphan PDB incarnation is required, then use

    //          "RESET PLUGGABLE DATABASE TO INCARNATION" RMAN command to specify

    //          the pluggable database incarnation along which flashback to the

    //          specified SCN must be performed. Also, ensure that the feature is

    //          enabled.</b>

    $

    ```

  Use the SCN displayed at the end of step when the user increased the salary of the employees.


    ```

    $ <copy>rman TARGET /</copy>

    Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

    connected to target database: CDB21 (DBID=2732805675)

    RMAN> <copy>RESET PLUGGABLE DATABASE pdb21 TO INCARNATION 1;</copy>

    pluggable database reset to incarnation 1
    ```
    ```

    RMAN> <copy>FLASHBACK PLUGGABLE DATABASE pdb21 TO SCN 3881391;</copy>

    Starting flashback at 13-MAR-20

    allocated channel: ORA_DISK_1

    channel ORA_DISK_1: SID=19 device type=DISK

    starting media recovery

    archived log for thread 1 with sequence 9 is already on disk as file /u03/app/oracle/fast_recovery_area/CDB21_IAD3CV/archivelog/2020_04_07/o1_mf_1_9_h8s80s3f_.arc

    archived log for thread 1 with sequence 10 is already on disk as file /u03/app/oracle/fast_recovery_area/CDB21_IAD3CV/archivelog/2020_04_07/o1_mf_1_10_h8s80t1w_.arc

    archived log for thread 1 with sequence 11 is already on disk as file /u03/app/oracle/fast_recovery_area/CDB21_IAD3CV/archivelog/2020_04_07/o1_mf_1_11_h8s80y54_.arc

    media recovery complete, elapsed time: 00:00:25

    Finished flashback at 13-MAR-20

    RMAN> <copy>EXIT</copy>

    Recovery Manager complete.

    $

    ```

3. Open the PDB and verify that the data is restored with the employees' salaries updated and the employee 206 restored too.


    ```

    $ <copy>sqlplus sys@PDB21 AS SYSDBA</copy>

    Enter password: <b><i>WElcome123##</i></b>

    Connected to:
    ```
    ```

    SQL> <copy>ALTER PLUGGABLE DATABASE pdb21 OPEN RESETLOGS;</copy>

    Pluggable database altered.

    SQL> <copy>CONNECT system@PDB21</copy>

    Enter password: <b><i>WElcome123##</i></b>

    Connected.
    ```
    ```

    SQL> <copy>SELECT count(*) FROM hr.employees;</copy>

    </b>

      COUNT(*)

    ----------

          107

    SQL> <copy>SELECT min(salary), MAX(salary) FROM hr.employees;</copy>

    MIN(SALARY) MAX(SALARY)

    ----------- -----------

          4200       48000

    SQL> <copy>SELECT con_id, pdb_incarnation# INC#, status, incarnation_scn, end_resetlogs_scn

            FROM v$pdb_incarnation ORDER BY 1, 2;</copy>

        CON_ID       INC# STATUS  INCARNATION_SCN END_RESETLOGS_SCN

    ---------- ---------- ------- --------------- -----------------

            4          0 PARENT          2667602           2667602

            4          1 PARENT          3880344           3881083

            4          2 <b>ORPHAN</b>         3880325           3882600

            4          3 <b>CURRENT</b>         3881392           3884391

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
