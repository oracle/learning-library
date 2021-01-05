# Configuring and Observing Automatic In-Memory

## Introduction
This lab shows how to configure Automatic In-Memory and then observe how in-memory objects are automatically and dynamically populated in the IM column store without user intervention, and then possibly automatically evicted from the IM column store.

Estimated Lab Time: 25 minutes

### Objectives
In this lab, you will:
* Setup the In-Memory Column Store
* Configure In-Memory tables
* Configure Automatic In-Memory

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup

## **STEP 1:** Set up the environment with In-Memory Column Store

1. The shell script configures the IM column store to 110M, creates `NO
INMEMORY` tables in `HR` schema in `PDB21`, and finally inserts rows in `HR` tables.

    ```
    $ <copy>cd /home/oracle/labs/M104783GC10
    /home/oracle/labs/M104783GC10/AutoIM_setup.sh</copy>
    ```

    ```
    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER=ALL ;
    ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER=ALL
    *
    ERROR at line 1:
    ORA-28389: cannot close auto login wallet

    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE IDENTIFIED BY <i>WElcome123##</i> CONTAINER=ALL;
    keystore altered.

    SQL> ALTER SYSTEM SET sga_target=812M SCOPE=spfile;
    System altered.

    SQL> ALTER SYSTEM SET inmemory_size=110M SCOPE=SPFILE;
    System altered.

    SQL> ALTER SYSTEM SET query_rewrite_integrity=stale_tolerated SCOPE=SPFILE;
    System altered.

    SQL> SET ECHO OFF
    System altered.

    SQL> ALTER SYSTEM SET INMEMORY_AUTOMATIC_LEVEL=LOW SCOPE=SPFILE;
    System altered.
    ...
    SQL> CREATE TABLESPACE imtbs DATAFILE '/home/oracle/labs/imtbs1.dbf' SIZE 10G;
    Tablespace created.

    SQL> EXIT
    ...
    SQL> CREATE TABLE hr.emp INMEMORY AS SELECT * FROM hr.employees ;
    Table created.

    SQL> INSERT INTO hr.emp SELECT * FROM hr.emp;
    107 rows created.
    ...
    SQL> /
    1753088 rows created.

    SQL> COMMIT;
    Commit complete.

    SQL> EXIT
    $
    ```

## **STEP 2:** Configure in-memory tables

1. Query the data dictionary to determine whether `HR` tables are specified as `INMEMORY`.

    ```
    $ <copy>sqlplus sys@PDB21 AS SYSDBA</copy>
    Enter password: <b><i>WElcome123##</i></b>
    Connected to:
    ```
    ```
    SQL> <copy>COL table_name FORMAT A18</copy>

    SQL> <copy>SELECT table_name, inmemory, inmemory_compression
    FROM   dba_tables WHERE  owner='HR';</copy>
    TABLE_NAME         INMEMORY INMEMORY_COMPRESS
    ------------------ -------- -----------------
    REGIONS            DISABLED
    LOCATIONS          DISABLED
    DEPARTMENTS        DISABLED
    JOBS               DISABLED
    EMPLOYEES          DISABLED
    JOB_HISTORY        DISABLED
    EMP                ENABLED  FOR QUERY LOW
    COUNTRIES          DISABLED
    8 rows selected.
    SQL>

    ```

2. Apply the `INMEMORY` and `MEMCOMPRESS FOR CAPACITY LOW` attributes to the `HR.JOB_HISTORY` table.

    ```
    SQL> <copy>ALTER TABLE hr.job_history INMEMORY MEMCOMPRESS FOR CAPACITY LOW;</copy>
    Table altered.

    SQL> <copy>SELECT table_name, inmemory, inmemory_compression
    FROM   dba_tables WHERE  owner='HR';</copy>
    TABLE_NAME         INMEMORY INMEMORY_COMPRESS
    ------------------ -------- -----------------
    REGIONS            DISABLED
    LOCATIONS          DISABLED
    DEPARTMENTS        DISABLED
    JOBS               DISABLED
    EMPLOYEES          DISABLED
    JOB_HISTORY        ENABLED  FOR CAPACITY LOW
    EMP                ENABLED  FOR QUERY LOW
    COUNTRIES          DISABLED
    8 rows selected.
    SQL>
    ```

## **STEP 3:** Configure Automatic In-Memory

1. Connect to the CDB root, then set `INMEMORY_AUTOMATIC_LEVEL` to `HIGH`, and re-start the database instance.

    ```
    SQL> <copy>CONNECT / AS SYSDBA</copy>
    Connected.
    ```
    ```

    SQL> <copy>ALTER SYSTEM SET INMEMORY_AUTOMATIC_LEVEL=HIGH SCOPE=SPFILE;</copy>
    System altered.

    SQL> <copy>SHUTDOWN IMMEDIATE</copy>
    Database closed.
    Database dismounted.
    ORACLE instance shut down.

    SQL> <copy>STARTUP</copy>
    ORACLE instance started.

    Total System Global Area  851442944 bytes
    Fixed Size                  9571584 bytes
    Variable Size             440401920 bytes
    Database Buffers          276824064 bytes
    Redo Buffers                7204864 bytes
    In-Memory Area            117440512 bytes
    Database mounted.
    Database opened.
    ```
    ```
    <copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY WElcome123## container=all;</copy>
    ```
    ```

    SQL> <copy>ALTER PLUGGABLE DATABASE ALL OPEN;</copy>
    Pluggable database altered.

    SQL>
    ```

2. Query the data dictionary to determine whether `HR` tables are specified as `INMEMORY`.


    ```

    SQl> <copy>CONNECT sys@PDB21 AS SYSDBA</copy>

    Enter password: <b><i>WElcome123##</i></b>

    Connected.
    ```
    ```

    SQL> <copy>SELECT table_name, inmemory, inmemory_compression
    FROM   dba_tables WHERE  owner='HR';</copy>

    TABLE_NAME         INMEMORY INMEMORY_COMPRESS

    ------------------ -------- -----------------

    REGIONS            DISABLED

    LOCATIONS          DISABLED

    DEPARTMENTS        DISABLED

    JOBS               DISABLED

    EMPLOYEES          DISABLED

    JOB_HISTORY        ENABLED  FOR CAPACITY LOW

    EMP                ENABLED  FOR QUERY LOW

    COUNTRIES          DISABLED

    8 rows selected.

    SQL>

    ```

3. Why are the `HR` tables not enabled to `INMEMORY`, except those already manually set to `INMEMORY`? Display the `INMEMORY_AUTOMATIC_LEVEL` in the PDB.


    ```

    SQl> <copy>SHOW PARAMETER INMEMORY_AUTOMATIC_LEVEL</copy>

    NAME                                 TYPE        VALUE

    ------------------------------------ ----------- -------------

    inmemory_automatic_level             string      LOW

    SQL> <copy>SELECT ispdb_modifiable FROM v$parameter WHERE name='inmemory_automatic_level';</copy>

    ISPDB

    -----

    TRUE

    SQL>

    ```

4. Set `INMEMORY_AUTOMATIC_LEVEL` to `HIGH` at the PDB level, and re-start `PDB21`.


    ```

    SQl> <copy>ALTER SYSTEM SET INMEMORY_AUTOMATIC_LEVEL=HIGH SCOPE=SPFILE;</copy>

    System altered.

    SQL> <copy>SHUTDOWN IMMEDIATE</copy>

    Pluggable Database closed.

    SQL> <copy>STARTUP</copy>

    Pluggable Database opened.

    SQL>

    ```

## **STEP 4:** Test

1. Wait one minute to observe the `HR` tables to be automatically assigned the `INMEMORY` attribute.


    ```

    SQL> <copy>SELECT table_name, inmemory, inmemory_compression
    FROM   dba_tables WHERE  owner='HR';</copy>

    TABLE_NAME         INMEMORY INMEMORY_COMPRESS

    ------------------ -------- -----------------

    REGIONS            <b>ENABLED  AUTO</b>

    LOCATIONS          <b>ENABLED  AUTO</b>

    DEPARTMENTS        <b>ENABLED  AUTO</b>

    JOBS               <b>ENABLED  AUTO</b>

    EMPLOYEES          <b>ENABLED  AUTO</b>

    JOB_HISTORY        ENABLED  FOR CAPACITY LOW

    EMP                ENABLED  FOR QUERY LOW

    COUNTRIES          DISABLED

    8 rows selected.

    SQL>

    ```

2. *Observe that `HR.JOB_HISTORY` and `HR.JOB_EMP` which were manually specified as `INMEMORY`, retain their previous settings.*

3. Why is `HR.COUNTRIES` not automatically enabled?

    ```

    SQL> <copy>ALTER TABLE hr.countries INMEMORY;</copy>

    ALTER TABLE hr.countries INMEMORY

    *

    ERROR at line 1:

    ORA-64358: in-memory column store feature not supported for IOTs

    SQL>

    ```
4. Populate the in-memory tables into the IM Column Store.


    ```

    SQL> <copy>@/home/oracle/labs/M104783GC10/AutoIM_scan_AUTO.sql</copy>

    SQL> set echo on

    SQL> begin

      2  for i in (select constraint_name, table_name from dba_constraints where table_name='EMPLOYEES') LOOP

      3  execute immediate 'alter table hr.employees drop constraint '||i.constraint_name||' CASCADE';

      4  end loop;

      5  end;

      6  /

    PL/SQL procedure successfully completed.

    SQL> drop index hr.EMP_EMP_ID_PK;

    drop index hr.EMP_EMP_ID_PK

                  *

    ERROR at line 1:

    ORA-01418: specified index does not exist

    SQL>

    SQL> INSERT INTO hr.employees SELECT * FROM hr.employees;

    107 rows created.

    SQL> /

    214 rows created.

    ...

    SQL> /

    27392 rows created.

    SQL> COMMIT;

    Commit complete.

    SQL> /

    ...

    SQL> /

    Commit complete.

    SQL> COMMIT;

    Commit complete.

    SQL>

    ```

5. Why aren't the `ENABLED AUTO` tables not populated into the IM column store? The internal statistics are not sufficient yet to identify cold and hot data in the IM column store to consider which segments can be populated into the IM column store.

6. Execute the `/home/oracle/labs/M104783GC10/AutoIM_scan_AUTO.sql` SQL script to insert more rows into `HR.EMPLOYEES` table, query the `HR.EMPLOYEES` table and possibly then get the table automatically populated into the IM column store.


    ```

    SQL> <copy>@/home/oracle/labs/M104783GC10/AutoIM_scan.sql</copy>

    SQL> SELECT /*+ FULL(hr.employees) NO_PARALLEL(hr.employees) */ count(*) FROM hr.employees;

      COUNT(*)

    ----------

          107

    SQL> SELECT /*+ FULL(hr.departments) NO_PARALLEL(hr.departments) */ count(*) FROM hr.departments;

      COUNT(*)

    ----------

            27

    SQL> SELECT /*+ FULL(hr.locations) NO_PARALLEL(hr.locations) */ count(*) FROM hr.locations;

      COUNT(*)

    ----------

            23

    SQL> SELECT /*+ FULL(hr.jobs) NO_PARALLEL(hr.jobs) */ count(*) FROM hr.jobs;

      COUNT(*)

    ----------

            19

    SQL> SELECT /*+ FULL(hr.regions) NO_PARALLEL(hr.regions) */ count(*) FROM hr.regions;

      COUNT(*)

    ----------

            4

    SQL> SELECT /*+ FULL(hr.emp) NO_PARALLEL(hr.emp) */ count(*) FROM hr.emp;

      COUNT(*)

    ----------

      3506176

    SQL>

    ```

7. Display the population status of the `HR` tables into the IM Column Store. You may have to wait for a few minutes before the population of `EMPLOYEES` table starts.


    ```

    SQL> <copy>SELECT segment_name, inmemory_size, bytes_not_populated, inmemory_compression FROM v$im_segments;</copy>

    SEGMENT_NAME INMEMORY_SIZE BYTES_NOT_POPULATED INMEMORY_COMPRESS

    ------------ ------------- ------------------- -----------------

    EMP               44433408                   0 FOR QUERY LOW

    EMPLOYEES          1310720                   0 AUTO

    SQL> <copy>EXIT</copy>

    $

    ```


*Observe the `HR.EMPLOYEES` table is now populated with an `INMEMORY_COMPRESS` value set to `AUTO`. Compression used the automatic in-memory management based on internal statistics. After some time, the `HR.EMP` may be evicted according to the internal statistics. If you re-query the `HR.EMP` table, the statistics may decide to evict the `HR.EMPLOYEES` to let the `HR.EMP` populate back into the IM column store.*

You may now [proceed to the next lab](#next).

## Learn More

* [Oracle 21c Blog](http://docs.oracle.com)
* [Performance and HA - 21c](https://docs.us.oracle.com/en/database/oracle/oracle-database/21/nfcon/performance-and-high-availability-248721359.html)

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  Kay Malcolm, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
