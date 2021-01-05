# Using Automatic Zone Maps

## Introduction
This lab shows how to enable automatic zone maps and how automatic zone maps are created and maintained for any user table without your intervention.

Estimated Lab Time: 25 minutes

### Objectives
In this lab, you will:
* Show how zone maps are not created without DBA intervention
* Enable automatic zone maps
* Show how automatic zone maps are created without DBA intervention
* Drop the table

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Show how zone maps are not created without DBA intervention

1. Create the `SALES.ZM_TABLE` table in `PDB21`.  


    ```

    $ <copy>cd /home/oracle/labs/M104784GC10</copy>

    $ <copy>/home/oracle/labs/M104784GC10/setup_zonemap.sh</copy>

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to:

    System altered.

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to:

    SQL> shutdown immediate

    Database closed.

    Database dismounted.

    ORACLE instance shut down.

    SQL> exit

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to an idle instance.

    SQL> STARTUP

    ORACLE instance started.

    Total System Global Area 1426062424 bytes

    Fixed Size                  9567320 bytes

    Variable Size             855638016 bytes

    Database Buffers          553648128 bytes

    Redo Buffers                7208960 bytes

    Database mounted.

    Database opened.

    SQL> ALTER PLUGGABLE DATABASE all OPEN;

    Pluggable database altered.

    ...

    SQL> drop user sales cascade;

    drop user sales cascade

              *

    ERROR at line 1:

    ORA-01918: user 'SALES' does not exist

    SQL> create user sales identified by password;

    User created.

    SQL> grant create session, create table, unlimited tablespace to sales;

    Grant succeeded.

    SQL> EXIT

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to:

    SQL> CREATE TABLE sales_zm (sale_id NUMBER(10), customer_id NUMBER(10));

    Table created.

    SQL>

    SQL>  DECLARE

      2    i NUMBER(10);

      3  BEGIN

      4    FOR i IN 1..80

      5    LOOP

      6      INSERT INTO sales_zm

      7      SELECT ROWNUM, MOD(ROWNUM,1000)

      8      FROM   dual

      9      CONNECT BY LEVEL <= 100000;

    10      COMMIT;

    11    END LOOP;

    12  END;

    13  /

    PL/SQL procedure successfully completed.

    SQL>

    SQL> EXEC dbms_stats.gather_table_stats(ownname=>NULL, tabname=>'SALES_ZM')

    PL/SQL procedure successfully completed.

    SQL> EXIT

    $

    ```

2. Log in `PDB21` as `SALES`, set your session in statistic trace, and query the `SALES_ZM` table a few times to see the “consistent gets” value. Enter the password you used to create your DB System, `WElcome123##`.


    ```

    $ <copy>sqlplus sales@PDB21</copy>

    Enter password: <i>WElcome123##</i>
    ```
    ```

    SQL> <copy>SET AUTOTRACE ON STATISTIC</copy>

    SQL> <copy>SELECT COUNT(DISTINCT sale_id) FROM sales_zm WHERE customer_id = 50; </copy>

    COUNT(DISTINCTSALE_ID)

    ----------------------

                      100

    Statistics

    ----------------------------------------------------------

            44  recursive calls

            12  db block gets

          <copy>15248  consistent gets</copy>

              4  physical reads

          2084  redo size

            582  bytes sent via SQL*Net to client

            432  bytes received via SQL*Net from client

              2  SQL*Net roundtrips to/from client

              2  sorts (memory)

              0  sorts (disk)

              1  rows processed

    SQL>

    ```

3. Create a zone map. Since attribute clustering is a property of the table, any existing rows are not re-ordered. Therefore move the table to cluster the rows together.


    ```

    SQL> <copy>ALTER TABLE sales_zm ADD CLUSTERING BY LINEAR ORDER (customer_id) WITH MATERIALIZED ZONEMAP;</copy>

    Table altered.

    SQL> <copy>ALTER TABLE sales_zm MOVE;</copy>

    Table altered.

    SQL>

    ```

4. Re-run the query to see the “consistent gets” value.

    ```

    SQL> <copy>SELECT COUNT(DISTINCT sale_id) FROM sales_zm WHERE customer_id = 50; </copy>

    COUNT(DISTINCTSALE_ID)

    ----------------------

                      100

    Statistics

    ----------------------------------------------------------

            67  recursive calls

              8  db block gets

            <copy>900  consistent gets</copy>

              0  physical reads

          1464  redo size

            582  bytes sent via SQL*Net to client

            432  bytes received via SQL*Net from client

              2  SQL*Net roundtrips to/from client

              0  sorts (memory)

              0  sorts (disk)

              1  rows processed

    SQL>

    ```

  4. Display the status of the zone map created for this table.


    ```

    SQL> <copy>SET AUTOTRACE OFF</copy>

    SQL> <copy>COL zonemap_name FORMAT A20</copy>

    SQL> <copy>SELECT zonemap_name,automatic,partly_stale, incomplete
          FROM   dba_zonemaps;</copy>

    ZONEMAP_NAME         AUTOMATIC PARTLY_STALE INCOMPLETE

    -------------------- --------- ------------ ------------

    ZMAP$_SALES_ZM       NO        NO           NO

    SQL>

    ```

  *The new column `AUTOMATIC`, added to the existing view `DBA_ZONEMAPS` shows that the zone map is not created automatically.*



## **STEP 2:** Enable automatic zone maps

1. Drop the table.


    ```

    SQL> <copy>DROP TABLE sales_zm PURGE;</copy>

    Table dropped.

    SQL> <copy>SELECT zonemap_name, automatic, partly_stale, incomplete
        FROM   dba_zonemaps;</copy>

    no rows selected

    SQL>

    ```

2. Enable automatic zone map creation.


    ```

    SQL> <copy>EXEC DBMS_AUTO_ZONEMAP.CONFIGURE('AUTO_ZONEMAP_MODE','ON')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

## **STEP 3:** Show how automatic zone maps are created without DBA intervention

1. Re-create the table, insert rows with direct load, and gather table statistics.


    ```

    SQL> <copy>CREATE TABLE sales_zm (sale_id NUMBER(10), customer_id NUMBER(10));</copy>

    Table created.

    SQL> <copy>DECLARE
      i NUMBER(10);
    BEGIN
      FOR i IN 1..80
      LOOP
        INSERT /*+ APPEND */ INTO sales_zm
        SELECT ROWNUM, MOD(ROWNUM,1000)
        FROM   dual
        CONNECT BY LEVEL <= 100000;
        COMMIT;
      END LOOP;
    END;
    /</copy>  2    3    4    5    6    7    8    9   10   11   12   13

    PL/SQL procedure successfully completed.

    SQL> <copy>EXEC dbms_stats.gather_table_stats(ownname=>NULL, tabname=>'SALES_ZM')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

2. Query the `SALES_ZM` table at least twenty times to see the “consistent gets” value.


    ```

    SQL> <copy>SET AUTOTRACE ON STATISTIC</copy>

    SQL> <copy>SELECT COUNT(DISTINCT sale_id) FROM sales_zm WHERE customer_id = 50;</copy>  

    COUNT(DISTINCTSALE_ID)

    ----------------------

                      100

    Statistics

    ----------------------------------------------------------

            44  recursive calls

            12  db block gets

          </b>15248  consistent gets</b>

              4  physical reads

          2084  redo size

            582  bytes sent via SQL*Net to client

            432  bytes received via SQL*Net from client

              2  SQL*Net roundtrips to/from client

              2  sorts (memory)

              0  sorts (disk)

              1  rows processed

    SQL> <copy>/</copy>

    COUNT(DISTINCTSALE_ID)

    ----------------------

                      100

    Statistics

    ----------------------------------------------------------

            44  recursive calls

            12  db block gets

          <copy>15248  consistent gets</copy>

              4  physical reads

          2084  redo size

            582  bytes sent via SQL*Net to client

            432  bytes received via SQL*Net from client

              2  SQL*Net roundtrips to/from client

              2  sorts (memory)

              0  sorts (disk)

              1  rows processed

    SQL> <copy>/</copy>

    COUNT(DISTINCTSALE_ID)

    ----------------------

                      100

    Statistics

    ----------------------------------------------------------

            44  recursive calls

            12  db block gets

          <copy>15248  consistent gets</copy>

              4  physical reads

          2084  redo size

            582  bytes sent via SQL*Net to client

            432  bytes received via SQL*Net from client

              2  SQL*Net roundtrips to/from client

              2  sorts (memory)

              0  sorts (disk)

              1  rows processed

    SQL>

    ```

3. Because the background process responsible for the zone maps creation will wake up late, use the `/home/oracle/labs/M104784GC10/zonemap_exec.sql` SQL script to wake it up sooner.


    ```

    SQL> <copy>@/home/oracle/labs/M104784GC10/zonemap_exec.sql</copy>

    Connected.

    PL/SQL procedure successfully completed.

    Connected.

    SQL>

    ```

4. Display the status of the zone map created.


    ```

    SQL> <copy>SELECT zonemap_name, automatic, partly_stale, incomplete
        FROM   dba_zonemaps;</copy>

    ZONEMAP_NAME         AUTOMATIC PARTLY_STALE INCOMPLETE

    -------------------- --------- ------------ ------------

    ZMAP$_SALES_ZM       YES       NO           NO

    SQL>

    ```

5. Display the automatic zone map task actions. Query the `DBA_ZONEMAP_AUTO_ACTIONS` view several times until you see that an automatic zone map is created.


    ```

    SQL> <copy>SELECT task_id, msg_id, action_msg  FROM dba_zonemap_auto_actions;</copy>

      TASK_ID     MSG_ID

    ---------- ----------

    ACTION_MSG

    --------------------------------------------------------------------------------

            7         21

    BS:Current execution task id: 7 Execution name: SYS_ZMAP_2020-11-12/16:37:49 Tas

    k Name: ZMAP_TASK1

            7         22

    BS:******** Zonemap Background Action Report for Task ID: 7 ****************

            7         23

    TP:Trying to create zonemap on table: SALES_ZM owner:SALES

            7         24

    AL:Block count : 15280, sample percent is : 3.272251

            7         25

    TP:col name:CUSTOMER_ID: clustering ratio: .98

            7         26

    TP:col name:SALE_ID: clustering ratio: .04

            7         27

    TP:Candidate column list:SALE_ID

            7         28

    TP:New zonemap name: ZMAP$_SALES_ZM

            7         29

    TP:Creating new zonemap ZMAP$_SALES_ZM on table SALES_ZM owner SALEStable space

    SYSTEM

            7         30

    BS:successfully created zonemap: ZN:ZMAP$_SALES_ZM BT:SALES_ZM SN:SALES CL:SALE_I

    D CT:+00 00:00:02.830222 TS:2020-11-12/16:37:54 DP:8

            7         31

    BS:****** End of Zonemap Background Action Report for Task ID: 7 **********

    11 rows selected.

    SQL>

    ```

6. Another way to show the activity report of the auto task run is to use the `DBMS_AUTO_ZONEMAP.ACTIVITY_REPORT` function.


    ```

    SQL> <copy>SELECT dbms_auto_zonemap.activity_report(systimestamp-2, systimestamp, 'TEXT') FROM dual;</copy>

    DBMS_AUTO_ZONEMAP.ACTIVITY_REPORT(SYSTIMESTAMP-2,SYSTIMESTAMP,'TEXT')

    --------------------------------------------------------------------------------

    /orarep/autozonemap/main%3flevel%3d GENERAL SUMMARY

    -------------------------------------------------------------------------------

    Activity Start    10-NOV-2020 16:39:46.000000000 +00:00

    Activity End      12-NOV-2020 16:39:46.604816000 +00:00

    Total Executions  1

    -------------------------------------------------------------------------------

    EXECUTION SUMMARY

    -------------------------------------------------------------------------------

    <b>zonemaps created                      1</b>

    zonemaps compiled                     0

    zonemaps dropped                      0

    Stale zonemaps complete refreshed     0

    Partly stale zonemaps fast refreshed  0

    Incomplete zonemaps fast refreshed    0

    -------------------------------------------------------------------------------

    NEW ZONEMAPS DETAILS

    -------------------------------------------------------------------------------

    Zonemap         Base Table  Schema  Operation time  Date created         DOP  C

    olumn list

    <b>ZMAP$_SALES_ZM  SALES_ZM    SALES   00:00:02.83     2020-11-12/16:37:54  8    S

    ALE_ID</b>

    -------------------------------------------------------------------------------

    ZONEMAPS MAINTENANCE DETAILS

    -------------------------------------------------------------------------------

    Zonemap  Previous State  Current State  Refresh Type  Operation Time  Dop  Date

    Maintained

    -------------------------------------------------------------------------------

    FINDINGS

    -------------------------------------------------------------------------------

    Execution Name  Finding Name  Finding Reason  Finding Type  Message

    SQL>

    ```

  If you want to know how many zone maps were created across all executions, run the following query:


    ```

    SQL> <copy>SELECT * FROM dba_zonemap_auto_actions
    WHERE action_msg LIKE '%succesfully created zonemap:%' ORDER BY TIME_STAMP;</copy>

      TASK_ID     MSG_ID

    ---------- ----------

    EXEC_NAME

    --------------------------------------------------------------------------------

    ACTION_MSG

    --------------------------------------------------------------------------------

    TIME_STAMP

    ---------------------------------------------------------------------------

            7         30

    SYS_ZMAP_2020-11-12/16:37:49

    BS:successfully created zonemap: ZN:ZMAP$_SALES_ZM BT:SALES_ZM SN:SALES CL:SALE_I

    D CT:+00 00:00:02.830222 TS:2020-11-12/16:37:54 DP:8

    12-NOV-20 04.37.54.000000000 PM

    SQL>

    ```
7. Update the `SALE_ID` column vales in `SALES_ZM` table.


    ```

    SQL> <copy>@/home/oracle/labs/M104784GC10/zonemap_update.sql</copy>

    8000 rows updated.

    8000 rows updated.

    8000 rows updated.

    8000 rows updated.

    Commit complete.

    SQL>

    ```

8. Display the status of the zone map maintenance.


    ```

    SQL> <copy>SELECT zonemap_name, automatic, partly_stale, incomplete
        FROM   dba_zonemaps;</copy>

    ZONEMAP_NAME         AUTOMATIC PARTLY_STALE INCOMPLETE

    -------------------- --------- ------------ ------------

    ZMAP$_SALES_ZM       YES       YES         NO

    SQL>

    ```

9. Display the activity report until you see actions to automatic zone map maintenance.


    ```

    SQL> <copy>SELECT dbms_auto_zonemap.activity_report(systimestamp-2, systimestamp, 'TEXT') FROM dual;</copy>

    DBMS_AUTO_ZONEMAP.ACTIVITY_REPORT(SYSTIMESTAMP-2,SYSTIMESTAMP,'TEXT')

    --------------------------------------------------------------------------------

    /orarep/autozonemap/main%3flevel%3d GENERAL SUMMARY

    -------------------------------------------------------------------------------

    Activity Start    10-NOV-2020 16:42:32.000000000 +00:00

    Activity End      12-NOV-2020 16:42:32.611856000 +00:00

    Total Executions  2

    -------------------------------------------------------------------------------

    EXECUTION SUMMARY

    -------------------------------------------------------------------------------

    zonemaps created                      1

    zonemaps compiled                     0

    zonemaps dropped                      0

    Stale zonemaps complete refreshed     0

    Partly stale zonemaps fast refreshed  1

    Incomplete zonemaps fast refreshed    0

    -------------------------------------------------------------------------------

    NEW ZONEMAPS DETAILS

    -------------------------------------------------------------------------------

    Zonemap         Base Table  Schema  Operation time  Date created         DOP  C

    olumn list

    ZMAP$_SALES_ZM  SALES_ZM    SALES   00:00:01.60     2020-11-12/16:37:54  4    S

    ALE_ID

    -------------------------------------------------------------------------------

    ZONEMAPS MAINTENANCE DETAILS

    -------------------------------------------------------------------------------

    Zonemap         Previous State  Current State  Refresh Type  Operation Time  Do

    p  Date Maintained

    ZMAP$_SALES_ZM  PARTLY_STALE    VALID          REBUILD       00:00:01.77     0

      2020-04-06/08:41:24

    -------------------------------------------------------------------------------

    FINDINGS

    -------------------------------------------------------------------------------

    Execution Name  Finding Name  Finding Reason  Finding Type  Message

    SQL>

    ```

  *It is possible that the background process responsible for the zone maps maintenance woke up very quickly and already rebuilt the zonemap. In this case, no information in &quot;`ZONEMAPS

                                      MAINTENANCE DETAILS`&quot; would be displayed.*



10. Display the activity report.


    ```

    SQL> <copy>SELECT zonemap_name, automatic, partly_stale, incomplete
        FROM   dba_zonemaps;</copy>

    ZONEMAP_NAME         AUTOMATIC PARTLY_STALE INCOMPLETE

    -------------------- --------- ------------ ------------

    ZMAP$_SALES_ZM       YES       NO           NO

    SQL> <copy>SELECT dbms_auto_zonemap.activity_report(systimestamp-2, systimestamp, 'TEXT') FROM dual;</copy>

    DBMS_AUTO_ZONEMAP.ACTIVITY_REPORT(SYSTIMESTAMP-2,SYSTIMESTAMP,'TEXT')

    --------------------------------------------------------------------------------

    /orarep/autozonemap/main%3flevel%3d GENERAL SUMMARY

    -------------------------------------------------------------------------------

    Activity Start    10-NOV-2020 16:53:20.000000000 +00:00

    Activity End      12-NOV-2020 16:53:20.883606000 +00:00

    Total Executions  2

    -------------------------------------------------------------------------------

    EXECUTION SUMMARY

    -------------------------------------------------------------------------------

    zonemaps created                      1

    zonemaps compiled                     0

    zonemaps dropped                      0

    Stale zonemaps complete refreshed     0

    Partly stale zonemaps fast refreshed  1

    Incomplete zonemaps fast refreshed    0

    -------------------------------------------------------------------------------

    NEW ZONEMAPS DETAILS

    -------------------------------------------------------------------------------

    Zonemap         Base Table  Schema  Operation time  Date created         DOP  C

    olumn list

    ZMAP$_SALES_ZM  SALES_ZM    SALES   00:00:01.68     2020-04-06/16:45:04  2    S

    ALE_ID

    -------------------------------------------------------------------------------

    ZONEMAPS MAINTENANCE DETAILS

    -------------------------------------------------------------------------------

    Zonemap         Previous State  Current State  Refresh Type  Operation Time  Do

    p  Date Maintained

    ZMAP$_SALES_ZM  PARTLY_STALE    VALID          REBUILD       00:00:05.25     0

      2020-04-06/16:48:30

    -------------------------------------------------------------------------------

    FINDINGS

    -------------------------------------------------------------------------------

    Execution Name  Finding Name  Finding Reason  Finding Type  Message

    SQL>

    ```

## **STEP 4:** Drop the table

1.  Execute the commands to drop the table.
    ```

    SQL> <copy>DROP TABLE sales_zm PURGE;</copy>

    Table dropped.

    SQL> <copy>SELECT zonemap_name, automatic, partly_stale, incomplete
        FROM   dba_zonemaps;</copy>

    no rows selected

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
