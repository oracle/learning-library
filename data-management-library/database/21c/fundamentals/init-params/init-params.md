# Using Expressions in Initialization Parameters

## Introduction
This lab shows how to optimize the values set in initialization parameters when they depend on environmental characteristics, such as system configurations, run-time decisions, or the values of other parameters by using expressions.

Estimated Lab Time: 10 minutes

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Set the parameters

1. Log in to `CDB1` as `SYSTEM.`


    ```

    $ <copy>sqlplus system@cdb21</copy>    
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.
    Enter password: <b><i>WElcome123##</i></b>
    Last Successful login time: Mon Mar 16 2020 08:49:41 +00:00    
    Connected to:

    SQL>

    ```

2. Set the `sga_target` to `2G`.


    ```

    SQL> <copy>ALTER SYSTEM SET sga_target = 100G;</copy>
    ALTER SYSTEM SET sga_target = 100G
    *
    ERROR at line 1:
    ORA-02097: parameter cannot be modified because specified value is invalid  
    ORA-00823: Specified value of sga_target greater than sga_max_size

    SQL>

    ```

3. As it fails, set it to 80 % of the SGA\_MAX\_SIZE.


    ```

    SQL> <copy>ALTER SYSTEM SET sga_target = 'sga_max_size*80/100';</copy>

    System altered.

    SQL> <copy>SHOW PARAMETER sga</copy>

    NAME                                 TYPE        VALUE

    ------------------------------------ ----------- ----------------------------

    allow_group_access_to_sga            boolean     FALSE

    lock_sga                             boolean     FALSE

    pre_page_sga                         boolean     TRUE

    <b>sga_max_size</b>                         big integer <b>5632M</b>

    sga_min_size                         big integer 0

    <b>sga_target</b>                           big integer <b>4512M</b>

    SQL>

    ```
3. Set the `job_queue_processes` to the 10% of the processes value.


    ```

    SQL> <copy>ALTER SYSTEM SET job_queue_processes='processes*10/100' SCOPE=BOTH;</copy>

    System altered.

    SQL> <copy>SHOW PARAMETER processes</copy>

    NAME                                 TYPE        VALUE

    ------------------------------------ ----------- ----------------------------

    aq_tm_processes                      integer     1

    db_writer_processes                  integer     1

    gcs_server_processes                 integer     0

    global_txn_processes                 integer     1

    <b>job_queue_processes</b>                  integer     <b>40</b>

    log_archive_max_processes            integer     4

    <b>processes</b>                            integer     <b>400</b>

    SQL>

    ```

4. Set the `aq_tm_processes` to the minimum value between 40 and 10% of processes.


    ```

    SQL> <copy>ALTER SYSTEM SET AQ_TM_PROCESSES = 'MIN(40, PROCESSES * .1)' SCOPE=BOTH;</copy>

    System altered.

    SQL> <copy>SHOW PARAMETER processes</copy>

    NAME                                 TYPE        VALUE

    ------------------------------------ ----------- ----------------------------

    <b>aq_tm_processes</b>                      integer     <b>40</b>

    db_writer_processes                  integer     1

    gcs_server_processes                 integer     0

    global_txn_processes                 integer     1

    job_queue_processes                  integer     40

    log_archive_max_processes            integer     4

    <b>processes</b>                            integer     <b>400</b>

    SQL>

    ```

5. What happens if you change the value of `processes`?

6. Set the `processes` value to 500 in SPFILE.

      ```

      SQL> <copy>ALTER SYSTEM SET PROCESSES = 500 SCOPE=SPFILE;</copy>

      System altered.

      SQL> <copy>exit;</copy>

      ```

## **STEP 2:** Restart the CDB

1. Restart the CDB instance.

      ```
      <copy>
      cd /home/oracle/labs/M104780GC10
      /home/oracle/labs/M104780GC10/wallet.sh
      </copy>
      ```

2.  Display the values for `processes` and `aq_tm_processes`.

      ```
      <copy>sqlplus / as sysdba</copy>
      ```
      ```

      SQL> <copy>SHOW PARAMETER processes</copy>

      NAME                                 TYPE        VALUE
      ------------------------------------ ----------- ----------------------------
      <b>aq_tm_processes</b>                      integer     <b>40</b>
      db_writer_processes                  integer     1
      gcs_server_processes                 integer     0
      global_txn_processes                 integer     1
      job_queue_processes                  integer     50
      log_archive_max_processes            integer     4
      <b>processes</b>                            integer     <b>500</b>
      SQL>

      ```
 The minimum value between 40 and 10% of `processes` is now 40 (because 10% of 500 is 50). The expression used for setting the `aq_tm_processes` parameter is kept throughout the database instance restarts.




3. Set the `db_recovery_file_dest` to the same value as `$HOME`, in `CDB21`.


    ```

    SQL> <copy>ALTER SYSTEM SET db_recovery_file_dest='$HOME' SCOPE=BOTH;</copy>

    System altered.

    SQL> <copy>SHOW PARAMETER db_recovery_file_dest</copy>

    NAME                                 TYPE        VALUE

    ------------------------------------ ----------- ----------------------------

    db_recovery_file_dest                string      $HOME

    db_recovery_file_dest_size           big integer 15000M

    SQL> <copy>ALTER SYSTEM SWITCH LOGFILE;</copy>

    System altered.

    SQL> <copy>ALTER SYSTEM SWITCH LOGFILE;</copy>

    System altered.

    SQL> <copy>ALTER SYSTEM SWITCH LOGFILE;</copy>

    SQL> <copy>HOST</copy>

    $ <copy>cd $HOME</copy>

    $ <copy>ls -ltR | more</copy>

    .:

    total 20

    drwxr-x--- 3 oracle oinstall 4096 Apr  8 11:49 CDB20_IAD3CV

    drwxrwxrwx 9 oracle oinstall 4096 Apr  8 10:11 labs

    drwxrwxrwx 2 oracle oinstall 4096 Apr  3 13:06 foo

    -rwxrwxrwx 1 oracle oinstall  590 Apr  3 10:27 database2007112852029

    274968.rsp

    -rwxrwxrwx 1 oracle oinstall  668 Apr  3 10:27 initparam728549400967

    7521997.rsp

    ./CDB20_IAD3CV:

    total 4

    drwxr-x--- 3 oracle oinstall 4096 Apr  8 11:49 <b>archivelog</b>

    ./CDB20_IAD3CV/archivelog:

    total 4

    drwxr-x--- 2 oracle oinstall 4096 Apr  8 11:50 2020_04_08

    ./CDB20_IAD3CV/archivelog/2020_04_08:

    total 391288

    -rw-r----- 1 oracle oinstall      7168 Apr  8 11:50 o1_mf_1_16_h8vgm

    8xs_.arc

    -rw-r----- 1 oracle oinstall      2560 Apr  8 11:50 o1_mf_1_15_h8vgm

    2op_.arc

    -rw-r----- 1 oracle oinstall 400666624 Apr  8 11:49 o1_mf_1_14_h8vgm

    1st_.arc

    ./labs:

    total 36

    -rw-r--r-- 1 oracle oinstall 6075 Apr  8 10:11 hr_main.log

    ...

    $ <copy>exit</copy>

    SQL> <copy>EXIT</copy>

    $

    ```

4. Set the SGA back.

    ```
    $ <copy>sqlplus sys@cdb21 as sysdba</copy>    
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.
    Enter password: <b><i>WElcome123##</i></b>
    Last Successful login time: Mon Mar 16 2020 08:49:41 +00:00    
    Connected to:

    SQL>
    ```
    ```
    <copy>
    ALTER SYSTEM SET sga_target = 5G scope=spfile;
    exit;
    </copy>
    ```
    ```
    <copy>
    cd /home/oracle/labs/M104780GC10
    /home/oracle/labs/M104780GC10/wallet.sh
    </copy>
    ```



You may now [proceed to the next lab](#next).


## Acknowledgements

* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
