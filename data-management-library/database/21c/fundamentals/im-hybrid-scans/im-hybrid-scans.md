# Using In-Memory Hybrid Scans in Queries

## Introduction
This lab shows how queries referencing both `INMEMORY` and `NO INMEMORY` columns can access columnar data. This optimizer access method called IM hybrid scan can improve performance by orders of magnitude. If the optimizer chooses a table scan, the storage engine automatically determines whether an IM hybrid scan performs better than a regular row store scan from the buffer cache.

Estimated Lab Time: 15 minutes

### Objectives
In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Set up the environment with In-Memory Column Store

The `IM_Hybrid_setup.sh` shell script configures the IM column store to 110M, creates an in-memory table `IMU.IMTAB` containing two `INMEMORY` columns and one `NO INMEMORY` column, and finally inserts rows in the table. The shell script executes the same operations in an Oracle Database 19c and Oracle Database 21c.

1. Run the `IM_Hybrid_setup.sh` script.

    ```

    $ <copy>cd /home/oracle/labs/M104783GC10</copy>
    $ <copy>/home/oracle/labs/M104783GC10/IM_Hybrid_setup.sh</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Connected to:

    SQL> SHUTDOWN ABORT
    ORACLE instance shut down.
    SQL> STARTUP MOUNT
    ORACLE instance started.

    Total System Global Area  851442944 bytes
    Fixed Size                  9571584 bytes
    Variable Size             331350016 bytes
    Database Buffers          385875968 bytes
    Redo Buffers                7204864 bytes
    In-Memory Area            117440512 bytes
    Database mounted.
    SQL> ALTER SYSTEM SET sga_target=5G SCOPE=spfile;

    System altered.

    SQL> ALTER SYSTEM SET inmemory_size=110M SCOPE=SPFILE;

    System altered.

    SQL> SHUTDOWN IMMEDIATE
    ORA-01109: database not open

    Database dismounted.
    ORACLE instance shut down.
    SQL> STARTUP
    ORACLE instance started.
    ...
    SQL> CREATE TABLESPACE imtbs DATAFILE '/u02/app/oracle/oradata/pdb21/imtbs1.dbf' SIZE 500M;

    Tablespace created.

    SQL> CREATE USER imu IDENTIFIED BY password DEFAULT TABLESPACE imtbs;

    User created.

    SQL> GRANT create session, create table, unlimited tablespace TO imu;

    Grant succeeded.

    SQL>
    SQL> CREATE TABLE imu.imtab (c1_noinmem NUMBER, c2_inmem NUMBER, c3_inmem VARCHAR2(4000))
      2         INMEMORY PRIORITY high MEMCOMPRESS for capacity low NO INMEMORY(c1_noinmem);

    Table created.

    SQL> INSERT INTO imu.imtab VALUES (3,4,'Test20c');

    1 row created.

    SQL> INSERT INTO imu.imtab SELECT c1_noinmem + (select max(c1_noinmem) from imu.imtab),
      2                               c2_inmem + (select max(c2_inmem) from imu.imtab),
      3                               c3_inmem|| (select max(c2_inmem) from imu.imtab) FROM imu.imtab;

    1 row created.
    ...
    131072 rows created.

    SQL> COMMIT;

    Commit complete.

    SQL> exit
    $

    ```

## **Step 2:**  Populate the  in-memory table

1. Connect to `PDB21` as `SYSTEM` and set formats for the queried columns.


    ```

    $ <copy>sqlplus system@PDB21</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: <b><i>WElcome123##</i></b>

    Last Successful login time: Wed Jan 08 2020 12:03:56 +00:00

    Connected to:

    SQL> <copy>COL table_name FORMAT A10</copy>

    SQL> <copy>COL inmemory_compression FORMAT A11</copy>

    SQL> <copy>COL COL_NO_INMEM FORMAT 9999999999999999999999</copy>

    SQL> <copy>COL COL_INMEM FORMAT 9999999999999999999999</copy>

    SQL> <copy>COL segment_name FORMAT A12</copy>

    SQL>

    ```

2. Display the in-memory attributes of the `IMU.IMTAB` table and of all columns of the table.


    ```

    SQL> <copy>SELECT table_name, inmemory_compression "COMPRESSION", inmemory_priority "PRIORITY"

    FROM   dba_tables WHERE owner='IMU';</copy>

    TABLE_NAME COMPRESSION       PRIORITY

    ---------- ----------------- --------

    IMTAB      FOR CAPACITY LOW  HIGH



    SQL> <copy>SELECT obj_num, segment_column_id, inmemory_compression FROM v$im_column_level im, dba_objects o

    WHERE  im.obj_num = o.object_id

    AND    o.object_name='IMTAB';</copy>

      OBJ_NUM SEGMENT_COLUMN_ID INMEMORY_CO

    ---------- ----------------- -----------

        74869                 1 NO INMEMORY

        74869                 2 DEFAULT

        74869                 3 DEFAULT

    SQL>

    ```

3. Execute a full scan on the `IMU.IMTAB` table so as to populate the table into the IM Column Store.


    ```

    SQL> <copy>SELECT /*+ FULL(imu.imtab) NO_PARALLEL(imu.imtab) */ COUNT(*) FROM imu.imtab;</copy>

      COUNT(*)

    ----------

        262144

    SQL>

    ```

4. Verify that the `IMU.IMTAB` table is populated into the IM Column Store.


    ```

    SQL> <copy>COL segment_name FORMAT A12</copy>

    SQL> <copy>SELECT segment_name, bytes, inmemory_size, bytes_not_populated

    FROM   v$im_segments;</copy>

    SEGMENT_NAME      BYTES INMEMORY_SIZE BYTES_NOT_POPULATED

    ------------ ---------- ------------- -------------------

    IMTAB          17481728       4456448                   0

    SQL>

    ```

## **STEP 3:** Complete In-Memory Scans

1. Execute a first query on the `IMU.IMTAB` table. The SELECT list contains the `NO INMEMORY` column and the predicate contains only the `NO INMEMORY` columns. Then examine the execution plan.


    ```

    SQL> <copy>SELECT sum(c1_noinmem) AS COL_NO_INMEM FROM imu.imtab

    WHERE  c1_noinmem BETWEEN 5 AND 1258291;</copy>

              COL_NO_INMEM

    -----------------------

              103079608317

    SQL> <copy>SELECT * FROM table(dbms_xplan.display_cursor());</copy>

    PLAN_TABLE_OUTPUT

    --------------------------------------------------------------------

    SQL_ID  1dpya5ws8gbvx, child number 0

    -------------------------------------

    SELECT sum(c1_noinmem) AS COL_NO_INMEM FROM imu.imtab WHERE  c1_noin

    mem BETWEEN 5 AND 1258291

    Plan hash value: 360700294

    ----------------------------------------------------------------------------

    | Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |

    ----------------------------------------------------------------------------

    |   0 | SELECT STATEMENT   |       |       |       |   547 (100)|       |

    |   1 |  SORT AGGREGATE    |       |     1 |    13 |            |       |

    |*  2 |   <b>TABLE ACCESS FULL</b>| IMTAB |   292K|  3712K|   547   (1)| 00 :00:01 |

    ----------------------------------------------------------------------------

    Predicate Information (identified by operation id):

    ---------------------------------------------------

      2 - filter(("C1_NOINMEM">=5 AND "C1_NOINMEM"<=1258291))

    Note

    -----

      - dynamic statistics used: dynamic sampling (level=2)

    24 rows selected.

    SQL>

    ```

  The optimizer in both sessions choose the `TABLE ACCESS FULL` method because the predicate does not contain only `INMEMORY` columns.

2. Execute a second query on the `IMU.IMTAB` table. The SELECT list contains the `NO INMEMORY` column and the predicate contains both a `NO INMEMORY` column and an `INMEMORY` column. Then examine the execution plan.


    ```

    SQL> <copy>SELECT sum(c1_noinmem) AS COL_NO_INMEM FROM imu.imtab

    WHERE  c1_noinmem BETWEEN 5 AND 1258291 AND c3_inmem LIKE 'Test20c%';</copy>

              COL_NO_INMEM

    -----------------------

              103079608317

    SQL> <copy>SELECT * FROM table(dbms_xplan.display_cursor());</copy>

    PLAN_TABLE_OUTPUT

    --------------------------------------------------------------------

    SQL_ID  afz9bm3rscr3y, child number 0

    -------------------------------------

    SELECT sum(c1_noinmem) AS COL_NO_INMEM FROM imu.imtab WHERE  c1_noinmem

    BETWEEN 5 AND 1258291 AND c3_inmem LIKE 'Test20c%'

    Plan hash value: 360700294

    ----------------------------------------------------------------------------

    | Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |

    ----------------------------------------------------------------------------

    |   0 | SELECT STATEMENT   |       |       |       |   582 (100)|       |

    |   1 |  SORT AGGREGATE    |       |     1 |  2015 |            |       |

    |*  2 |   <b>TABLE ACCESS FULL</b>| IMTAB |   230K|   443M|   582   (1)| 00:00:01 |

    ----------------------------------------------------------------------------

    Predicate Information (identified by operation id):

    ---------------------------------------------------

      2 - filter(("C1_NOINMEM">=5 AND "C1_NOINMEM"<=1258291 AND "C3_INMEM" LIKE 'Test20c%'))

    Note

    -----

      - dynamic statistics used: dynamic sampling (level=2)

    25 rows selected.

    SQL>

    ```

  The optimizer in both sessions choose the `TABLE ACCESS FULL` access method because the predicate does not contain only `INMEMORY` columns. It contains a `INMEMORY` column and an `NO INMEMORY` columns.

3. Execute a third query on the `IMU.IMTAB` table. The SELECT list contains the `NO INMEMORY` column and the predicate contains only `INMEMORY` columns. Then examine the execution plan.


    ```

    SQL> <copy>SELECT sum(c1_noinmem) AS COL_NO_INMEM FROM imu.imtab

    WHERE  c2_inmem BETWEEN 5 AND 1258291 AND c3_inmem LIKE 'Test20c%';</copy>

              COL_NO_INMEM

    -----------------------

              103079608317

    SQL> <copy>SELECT * FROM table(dbms_xplan.display_cursor());</copy>

    PLAN_TABLE_OUTPUT

    --------------------------------------------------------------------

    SQL_ID  f07n4gc330rhz, child number 0

    -------------------------------------

    SELECT sum(c1_noinmem) AS COL_NO_INMEM FROM imu.imtab WHERE  c2_inmem

    BETWEEN 5 AND 1258291 AND c3_inmem LIKE 'Test20c%'

    Plan hash value: 360700294

    -----------------------------------------------------------------------------------

    | Id  | Operation                            | Name  | Rows  | Bytes | Cost (%CPU)| Time     |

    -----------------------------------------------------------------------------------

    |   0 | SELECT STATEMENT                     |       |       | |   582 (100)|          |

    |   1 |  SORT AGGREGATE                      |       |     1 |  2028 |            |          |

    |*  2 |   <b>TABLE ACCESS INMEMORY FULL (HYBRID)</b>| IMTAB |   230K|   445M|   582   (1)| 00:00:01 |

    -----------------------------------------------------------------------------

    Predicate Information (identified by operation id):

    ---------------------------------------------------

      2 - filter(("C2_INMEM">=5 AND "C2_INMEM"<=1258291 AND "C3_INMEM"

    LIKE 'Test20c%'))

    Note

    -----

      - dynamic statistics used: dynamic sampling (level=2)

    24 rows selected.

    SQL>

    ```

  The optimizer in both sessions choose different access methods. In 20c, the `TABLE ACCESS INMEMORY FULL (HYBRID)` access method is chosen because the predicate contains only `INMEMORY` columns and the SELECT list a `NO INMEMORY` column.

## **STEP 4:** Drop the user

1. Drop the `imu` user.

    ```

    SQL> <copy>DROP USER imu CASCADE;</copy>

    User dropped.

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
