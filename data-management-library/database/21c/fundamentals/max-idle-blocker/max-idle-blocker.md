# Using MAX\_IDLE\_BLOCKER\_TIME Parameter

## Introduction
This lab shows how to terminate a blocking session by using the new initialization parameter `MAX_IDLE_BLOCKER_TIME`.


Estimated Lab Time: 10 minutes

### Objectives
In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Set up the environment with two sessions

1. Prepare two terminal sessions, one logged in `PDB21` as `HR` and another one logged in `PDB21` as `SYSTEM`.


    ```

    $ <copy>sqlplus system@PDB21</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: <b><i>WElcome123##</i></b>

    Connected to:
    ```
    ```

    SQL> <copy>SET SQLPROMPT "SQL system> "</copy>

    SQL system>

    ```

2. Log in `PDB21` as `HR`.


    ```

    $ <copy>sqlplus hr@PDB21</copy>

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: <b><i>WElcome123##</i></b>

    Connected to:
    ```
    ```

    SQL> <copy>SET SQLPROMPT "SQL hr> "</copy>

    SQL hr>

    SQL>

    ```

## **STEP 2:** Set the initialization parameter `MAX_IDLE_BLOCKER_TIME` to two minutes

1. In the `SYSTEM` session, set the initialization parameter `MAX_IDLE_BLOCKER_TIME` to two minutes.

    ```

    SQL system> <copy>ALTER SYSTEM SET max_idle_blocker_time=2;</copy>

    System altered.

    SQL system> <copy>SHOW PARAMETER max_idle_blocker_time</copy>

    NAME                            TYPE        VALUE
    ------------------------------- ----------- ------------------------------
    max_idle_blocker_time           integer     2
    SQL system>

    ```

## **STEP 3:** Test

1. In the `HR` session, update the employees' salary.


    ```

    SQL hr> <copy>UPDATE hr.employees SET salary=salary*2;</copy>

    107 rows updated.

    SQL hr>

    ```

2. In the `SYSTEM` session, set all employees' commission percentage to 0. The statement waits for the lock resources held on the row by `HR` be released.


    ```

    SQL system> <copy>UPDATE hr.employees SET commission_pct=0;</copy>

    ```

  After two minutes, observe that the statement is executed.


    ```

    107 rows updated.

    SQL system>

    ```

3. Back in the `HR` session, query the result of the salaries update.


    ```

    SQL hr> <copy>SELECT salary FROM hr.employees;</copy>

    SELECT salary FROM hr.employees       *

    ERROR at line 1:

    ORA-03113: end-of-file on communication channel

    Process ID: 32314

    Session ID: 274 Serial number: 8179

    SQL hr> <copy>EXIT</copy>

    $

    ```

  *The session was automatically terminated because it held resource for a duration longer than two minutes.*



## **STEP 4:** Examine the DIAG trace files

1. Observe the DIAG trace file.


    ```

    $ <copy>cd /u01/app/oracle/diag/rdbms/cdb21/CDB21/trace</copy>

    $ <copy>ls -ltr</copy>

    ...

    -rw-r----- 1 oracle oinstall    4139 Mar 16 04:38 CDB21_dia0_30961_base_1.trm

    -rw-r----- 1 oracle oinstall   16101 Mar 16 04:38 CDB21_dia0_30961_base_1.trc

    -rw-r----- 1 oracle oinstall    1067 Mar 16 04:48 CDB21_mmon_31003.trm

    -rw-r----- 1 oracle oinstall    2614 Mar 16 04:48 CDB21_mmon_31003.trc

    -rw-r----- 1 oracle oinstall    1107 Mar 16 04:49 CDB21_dbrm_30949.trm

    -rw-r----- 1 oracle oinstall    3398 Mar 16 04:49 CDB21_dbrm_30949.trc

    ...
    ```
    Make sure to change the filename to your trace file.
    ```
    $ <copy>cat CDB21_dia0_30961_base_1.trc</copy>

    ...

    HM: <copy>Session with ID 274 serial # 8179 (U01I) on single instance 1 is hung</copy>

        and is waiting on 'SQL*Net message from client' for 96 seconds.

        Session was previously waiting on 'SQL*Net more data to client'.

        Session ID 274 is blocking 1 session

    ...

    HM: <copy>Session with ID 136 serial # 42403 (U011) on single instance 1 is hung</copy>

        and is waiting on 'enq: TX - row lock contention' for 96 seconds.

        Session was previously waiting on 'db file sequential read'.

        <copy>Final Blocker is Session ID 274 serial# 8179 on instance 1

        which is waiting on 'SQL*Net message from client' for 108 seconds

        p1: 'driver id'=0x54435000, p2: '#bytes'=0x1, p3: ''=0x0

    ...

    *** 2020-03-16T04:31:35.031598+00:00 (CDB$ROOT(1))

    All Current Hang Statistics

                          <b class="input">current number of hangs 1</copy>

        hangs:<copy>current number of impacted sessions 2</copy>

                      current number of deadlocks 0

    deadlocks:current number of impacted sessions 0

                    current number of singletons 0

          current number of local active sessions 2

            current number of local hung sessions 1

    Suspected Hangs in the System and possibly Rebuilt Hangs

                        Root       Chain Total               Hang

      Hang Hang          Inst Root  #hung #hung  Hang   Hang  Resolution

        ID Type Status   Num  Sess   Sess  Sess  Conf   Span  Action

    ----- ---- -------- ---- ----- ----- ----- ------ ------ -------------------

        1 HANG    VALID    1   274     2     2    LOW  LOCAL Terminate Process

      Inst  Sess   Ser             Proc  Wait    Wait

      Num    ID    Num      OSPID  Name Time(s) Event

      ----- ------ ----- --------- ----- ------- -----

            PDBID PDBNm

            ----- ---------------

          1    136 42403     32583  U011      97 enq: b class="input">TX - row lock contention</b>

                7 PDB20

          1    274  8179     32314  U01I     110 SQL*Net message from client

                7 PDB20

    ;..

    HM: current SQL: UPDATE hr.employees SET commission_pct=0

                                                        IO

    Total  Self-         Total  Total  Outlr  Outlr  Outlr

      Hung  Rslvd  Rslvd   Wait WaitTm   Wait WaitTm   Wait

      Sess  Hangs  Hangs  Count   Secs  Count   Secs  Count Wait Event

    ------ ------ ------ ------ ------ ------ ------ ------ -----------

        1      0      0      0      0      0      0      0 enq: TX - row lock contention

    ...

    HM: current SQL: UPDATE employees SET salary=salary*2

    ...

    HM: Session ID 274 serial# 8179 ospid 32314 on instance 1 in Hang ID 1

        was considered hung but is now no longer hung

    HM: Session with ID 274 with serial number 8179 is no longer hung

    $

    $

    ```

  You can also read the PMON trace file. Make sure to change the tracefile to your tracefile name.


    ```

    $ <copy>cat /u01/app/oracle/diag/rdbms/cdb21/CDB21/trace/CDB21_pmon_30913.trc</copy>

    ...

    Kill idle blocker, hang detected

    *** 2020-03-16T04:32:04.240685+00:00 ((7))

    Idle session sniped info:

    reason=max_idle_blocker_time parameter sess=0x86a06a20 sid=274 serial=8179 idle=2 limit=2 event=SQL*Net message from client

    client details:

      O/S info: user: oracle, term: pts/0, ospid: 32312

      machine: edcdr8p1 program: sqlplus@edcdr8p1 (TNS V1-V3)

      application name: SQL*Plus, hash value=3669949024

    ...

    $

    ```

2. In the `SYSTEM` session, query the employees' commission percentage.


    ```

    SQL system> <copy>SELECT DISTINCT commission_pct FROM hr.employees;</copy>

    COMMISSION_PCT

    --------------

                0

    SQL system> <copy>EXIT</copy>

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
