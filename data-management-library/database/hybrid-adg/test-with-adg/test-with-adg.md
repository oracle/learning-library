# Testing with Active Data Guard

## Introduction
Now we can run some testing with the ADG including DML redirection and switchover.

Estimated Lab Time: 30 minutes

### Objectives

-   Test transaction replication 
-    Check lag between the primary and standby
-   Test DML Redirection
-   Switchover to the Cloud

### Prerequisites

This lab assumes you have already completed the following labs:

- Deploy Active Data Guard with LVM or ASM

## **STEP 1:** Test Transaction Replication

1. From on-premise side, create a test user in orclpdb, and grant privileges to the user. You need  to check if the pdb is open.

    ```
    [oracle@primary ~]$ sqlplus / as sysdba

    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 06:52:50 2020
    Version 19.7.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    SQL> show pdbs

        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
      2 PDB$SEED			  READ ONLY  NO
      3 ORCLPDB			  MOUNTED
    SQL> alter pluggable database all open;

    Pluggable database altered.

    SQL> alter session set container=orclpdb;

    Session altered.

    SQL> create user testuser identified by testuser;

    User created.

    SQL> grant connect,resource to testuser;

    Grant succeeded.

    SQL> alter user testuser quota unlimited on users;

    User altered.

    SQL> exit;
    ```

2. Connect with testuser, create test table and insert a test record.

    ```
    [oracle@primary ~]$ sqlplus testuser/testuser@primary:1521/orclpdb

    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 06:59:56 2020
    Version 19.7.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    SQL> create table test(a number,b varchar2(20));

    Table created.
    SQL> insert into test values(1,'line1');

    1 row created.

    SQL> commit;

    Commit complete.

    SQL>  
    ```

3. From cloud side, open the standby database as read only.

    ```
    [oracle@dbstby ~]$ sqlplus / as sysdba

    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 07:04:39 2020
    Version 19.7.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    SQL> select open_mode,database_role from v$database;

    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    MOUNTED 	     PHYSICAL STANDBY

    SQL> alter database open;

    Database altered.

    SQL> alter pluggable database orclpdb open;

    Pluggable database altered.

    SQL> show pdbs

        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
      2 PDB$SEED			  READ ONLY  NO
      3 ORCLPDB			  READ ONLY  NO
      
    SQL> select open_mode,database_role from v$database;

    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ ONLY WITH APPLY PHYSICAL STANDBY

    SQL> exit
    Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0
    [oracle@dbstby ~]$ 
    ```
    If the `OPEN_MODE` is **READ ONLY**, you can run the following command in sqlplus as sysdba, then check the `open_mode` again, you can see the `OPEN_MODE` is **READ ONLY WITH APPLY** now.
    ```
    SQL> alter database recover managed standby database cancel;

    Database altered.

    SQL> alter database recover managed standby database using current logfile disconnect;

    Database altered.

    SQL> select open_mode,database_role from v$database;

    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ ONLY WITH APPLY PHYSICAL STANDBY
    ```

4. From cloud side, connect as testuser to orclpdb. Check if the test table and record has replicated to the standby.

    ```
    [oracle@dbstby ~]$ sqlplus testuser/testuser@dbstby:1521/orclpdb

    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 07:09:27 2020
    Version 19.7.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Last Successful login time: Sat Feb 01 2020 06:59:56 +00:00

    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    SQL> select * from test;

      A B
    ---------- --------------------
      1 line1

    SQL> 
    ```

## **STEP 2:** Check Lag between the Primary and Standby

There are several ways to check the lag between the primary and standby.

1. First let's prepare a sample workload in the primary side. Copy the following command:

    ```
    <copy>
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/6qb-tsAMHHM-iQhmVPifNoBazUUuKFjh6MN27xapzuTNcAHzoZTuZqnn1QgBgnaE/n/c4u03/b/data-management-library-files/o/workload.sh
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/PpXBKEofD92m-Q7jh-465U3FbCpvnysflKdk6ptRPRJzcKngSKcJU5l5iCWo4eN0/n/c4u03/b/data-management-library-files/o/scn.sql
    </copy>
    ```

   

2. From on-premise side, run as **oracle** user, download scripts using the command you copied.

    ```
    [oracle@primary ~]$ wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/6qb-tsAMHHM-iQhmVPifNoBazUUuKFjh6MN27xapzuTNcAHzoZTuZqnn1QgBgnaE/n/c4u03/b/data-management-library-files/o/workload.sh
    --2020-10-31 02:48:08--  https://objectstorage.us-ashburn-1.oraclecloud.com/p/6qb-tsAMHHM-iQhmVPifNoBazUUuKFjh6MN27xapzuTNcAHzoZTuZqnn1QgBgnaE/n/c4u03/b/data-management-library-files/o/workload.sh
    Resolving objectstorage.us-ashburn-1.oraclecloud.com (objectstorage.us-ashburn-1.oraclecloud.com)... 134.70.31.247, 134.70.27.247, 134.70.35.189
    Connecting to objectstorage.us-ashburn-1.oraclecloud.com (objectstorage.us-ashburn-1.oraclecloud.com)|134.70.31.247|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 1442 (1.4K) [text/x-sh]
    Saving to: ‘workload.sh’
    
    100%[==============================================>] 1,442       --.-K/s   in 0s      
    
    2020-10-31 02:48:09 (10.5 MB/s) - ‘workload.sh’ saved [1442/1442]
    
    [oracle@primary ~]$ wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/PpXBKEofD92m-Q7jh-465U3FbCpvnysflKdk6ptRPRJzcKngSKcJU5l5iCWo4eN0/n/c4u03/b/data-management-library-files/o/scn.sql
    --2020-10-31 02:48:29--  https://objectstorage.us-ashburn-1.oraclecloud.com/p/PpXBKEofD92m-Q7jh-465U3FbCpvnysflKdk6ptRPRJzcKngSKcJU5l5iCWo4eN0/n/c4u03/b/data-management-library-files/o/scn.sql
    Resolving objectstorage.us-ashburn-1.oraclecloud.com (objectstorage.us-ashburn-1.oraclecloud.com)... 134.70.35.189, 134.70.31.247, 134.70.27.247
    Connecting to objectstorage.us-ashburn-1.oraclecloud.com (objectstorage.us-ashburn-1.oraclecloud.com)|134.70.35.189|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 108 [application/octet-stream]
    Saving to: ‘scn.sql’
    
    100%[==============================================>] 108         --.-K/s   in 0s      
    
    2020-10-31 02:48:30 (8.08 MB/s) - ‘scn.sql’ saved [108/108]
    
    [oracle@primary ~]$ 
    ```
    
   
   
3. Change mode of the `workload.sh` file and run the workload. Ignore the error message of drop table. Keep this window open and running for the next few steps in this lab.

    ```
    [oracle@primary ~]$ chmod a+x workload.sh 
    [oracle@primary ~]$ . ./workload.sh 
    
      NOTE:
      To break out of this batch
      job, please issue CTL-C 
    
    ...sleeping 5 seconds
    
      drop table sale_orders
                  *
    ERROR at line 1:
    ORA-00942: table or view does not exist
    
    
    
    Table created.
    
    
    10 rows created.
    
    
    Commit complete.
    
    
      COUNT(*)
    ----------
      10
    
    
    CURRENT_SCN TIME
    ----------- ---------------
        2814533 20200905-092831
    
    
    10 rows created.
    
    
    Commit complete.
    
    
      COUNT(*)
    ----------
      20
    
    
    CURRENT_SCN TIME
    ----------- ---------------
        2814548 20200905-092833
        
    ```

   

4. From the standby side, connect as **testuser** to orclpdb,  count the records in the sample table several times. using the standby database hostname or public ip address. Compare the record number with the primary side.

    ```
    [oracle@dbstby ~]$ sqlplus testuser/testuser@dbstby:1521/orclpdb
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Sep 5 09:41:29 2020
    Version 19.7.0.0.0
    
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.
    
    Last Successful login time: Sat Sep 05 2020 02:09:45 +00:00
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0
    
    SQL> select count(*) from sale_orders;
    
      COUNT(*)
    ----------
      390
    
    SQL> 
    ```

      

5. From standby site, connect as sysdba. Check the Oracle System Change Number (SCN). Compare it with the primary side.

    ```
    SQL> connect / as sysdba
    Connected.
    SQL> SELECT current_scn FROM v$database;
    
    CURRENT_SCN
    -----------
        2784330
    ```
   
   
   
6. From standby site, query the `v$dataguard_stats` view to check the lag.

    ```
    SQL> set linesize 120;
    SQL> column name format a25;
    SQL> column value format a20;
    SQL> column time_computed format a20;
    SQL> column datum_time format a20;
    SQL> select name, value, time_computed, datum_time from v$dataguard_stats;
    
    NAME			                VALUE 	             TIME_COMPUTED	      DATUM_TIME
    ------------------------- -------------------- -------------------- --------------------
    transport lag		          +00 00:00:00	       09/05/2020 07:17:33  09/05/2020 07:17:30
    apply lag		              +00 00:00:00	       09/05/2020 07:17:33  09/05/2020 07:17:30
    apply finish time	        +00 00:00:00.000     09/05/2020 07:17:33
    estimated startup time	  9		                 09/05/2020 07:17:33
    
    SQL> 
    ```

   

7. Check lag using Data Guard Broker. Replace `ORCL_nrt1d4` with your standby database unique name.

    ```
    [oracle@dbstby ~]$ dgmgrl sys/Ora_DB4U@orcl
    DGMGRL for Linux: Release 19.0.0.0.0 - Production on Sat Sep 5 07:25:52 2020
    Version 19.7.0.0.0
    
    Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.
    
    Welcome to DGMGRL, type "help" for information.
    Connected to "ORCL"
    Connected as SYSDBA.
    DGMGRL> show database ORCL_nrt1d4
    
    Database - orcl_nrt1d4
    
      Role:               PHYSICAL STANDBY
      Intended State:     APPLY-ON
      Transport Lag:      0 seconds (computed 3 seconds ago)
      Apply Lag:          0 seconds (computed 3 seconds ago)
      Average Apply Rate: 6.00 KByte/s
      Real Time Query:    ON
      Instance(s):
        ORCL
    
    Database Status:
    SUCCESS
    
    DGMGRL> 
    ```

   

8. From the on-premise side, press `Ctrl-C` to terminate the running workload.

 

## **STEP 3:** Test DML Redirection

Starting  with Oracle DB 19c, we can run DML operations on Active Data Guard standby databases. This enables you to occasionally execute DMLs on read-mostly applications on the standby database.

Automatic redirection of DML operations to the primary can be configured at the system level or the session level. The session level setting overrides the system level

1. From the standby side, connect to orclpdb as **testuser**. Test the DML before and after the DML Redirection is enabled.

    ```
    [oracle@dbstby ~]$ sqlplus testuser/testuser@dbstby:1521/orclpdb

    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Sep 5 10:04:04 2020
    Version 19.7.0.0.0

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Last Successful login time: Sat Sep 05 2020 02:09:45 +00:00

    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    SQL> set timing on
    SQL> insert into test values(2,'line2');
    insert into test values(2,'line2')
    *
    ERROR at line 1:
    ORA-16000: database or pluggable database open for read-only access


    Elapsed: 00:00:00.58
    SQL> ALTER SESSION ENABLE ADG_REDIRECT_DML;

    Session altered.

    Elapsed: 00:00:00.00
    SQL> insert into test values(2,'line2');

    1 row created.

    Elapsed: 00:00:26.13
    SQL> commit;

    Commit complete.

    Elapsed: 00:00:21.12
    SQL> select * from test;

      A B
    ---------- --------------------
      2 line2
      1 line1

    Elapsed: 00:00:00.03
    SQL> 
    ```

    You may encounter the performance issue when using the DML redirection. This is because each of the DML is issued on a standby database will be passed to the primary database where it is executed. The default Data Guard protection mode is Maximum Performance and the redo transport mode is ASYNC. The session waits until the corresponding changes are shipped to and applied to the standby. In order to improve performance of the DML redirection, you need to switch the redo logfile more frequently on the primary side, or you can change the protection mode to Maximum Availability and the redo transport mode to SYNC - This protection mode provides the highest level of data protection, but it's need the high throughput and low latency network, you can use FastConnect or deploy the Data Guard in different ADs within the same region.

2. From the primary side, connect with Data Guard Broker, check the current protection mode and redo transport mode. Replace the `orcl_nrt1d4` to your standby db unique name.

    ```
    [oracle@primary ~]$ dgmgrl sys/Ora_DB4U@orcl
    DGMGRL for Linux: Release 19.0.0.0.0 - Production on Sun Sep 6 05:09:28 2020
    Version 19.7.0.0.0
    
    Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.
    
    Welcome to DGMGRL, type "help" for information.
    Connected to "ORCL"
    Connected as SYSDBA.
    DGMGRL> show configuration
    
    Configuration - adgconfig
    
      Protection Mode: MaxPerformance
      Members:
      orcl        - Primary database
        orcl_nrt1d4 - Physical standby database 
    
    Fast-Start Failover:  Disabled
    
    Configuration Status:
    SUCCESS   (status updated 20 seconds ago)
    DGMGRL> show database orcl LogXptMode
      LogXptMode = 'ASYNC'
    DGMGRL> show database orcl_nrt1d4 LogXptMode
      LogXptMode = 'ASYNC'
    ```

   

3. Switch the redo transport mode and protection mode. Replace the `orcl_nrt1d4` to your standby db unique name.

    ```
    DGMGRL> EDIT DATABASE orcl SET PROPERTY LogXptMode='SYNC';
    Property "logxptmode" updated
    DGMGRL> EDIT DATABASE orcl_nrt1d4 SET PROPERTY LogXptMode='SYNC';
    Property "logxptmode" updated
    DGMGRL> EDIT CONFIGURATION SET PROTECTION MODE AS MAXAVAILABILITY;
    Succeeded.
    DGMGRL> show configuration
    
    Configuration - adgconfig
    
      Protection Mode: MaxAvailability
      Members:
      orcl        - Primary database
        orcl_nrt1d4 - Physical standby database 
    
    Fast-Start Failover:  Disabled
    
    Configuration Status:
    SUCCESS   (status updated 42 seconds ago)
    
    DGMGRL>
    ```

    

4. From the standby side, test the DML redirection again. You can see the performance improved.

    ```
    SQL> insert into test values(3,'line3');
    
    1 row created.
    
    Elapsed: 00:00:00.25
    SQL> commit;
    
    Commit complete.
    
    Elapsed: 00:00:01.07
    SQL> select * from test;
    
          A B
    ---------- --------------------
          1 line1
          2 line2
          3 line3
    Elapsed: 00:00:00.03
    SQL> exit
    Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0
    [oracle@dbstby ~]$ 
    ```

   

5. From the primary side, in the Data Guard Broker, switch back the protection mode. Replace the `orcl_nrt1d4` to your standby db unique name.

    ```
    DGMGRL> EDIT CONFIGURATION SET PROTECTION MODE AS MAXPERFORMANCE;
    Succeeded.
    DGMGRL> EDIT DATABASE orcl_nrt1d4 SET PROPERTY LogXptMode='ASYNC';
    Property "logxptmode" updated
    DGMGRL> EDIT DATABASE orcl SET PROPERTY LogXptMode='ASYNC';
    Property "logxptmode" updated
    DGMGRL> show configuration
    
    Configuration - adgconfig
    
      Protection Mode: MaxPerformance
      Members:
      orcl        - Primary database
        orcl_nrt1d4 - Physical standby database 
    
    Fast-Start Failover:  Disabled
    
    Configuration Status:
    SUCCESS   (status updated 20 seconds ago)
    ```

   



## **STEP 4:** Switchover to the Cloud 

At any time, you can manually execute a Data Guard switchover (planned event) or failover (unplanned event). Customers may also choose to automate Data Guard failover by configuring Fast-Start failover. Switchover and failover reverse the roles of the databases in a Data Guard configuration – the standby in the cloud becomes primary and the original on-premise primary becomes a standby database. Refer to Oracle MAA Best Practices for additional information on Data Guard role transitions. 

Switchovers are always a planned event that guarantees no data is lost. To execute a switchover, perform the following in Data Guard Broker 

1. Connect DGMGRL from on-premise side, validate the standby database to see if Ready For Switchover is Yes. Replace `ORCL_nrt1d4` with your standby db unique name.

    ```
    [oracle@primary ~]$ dgmgrl sys/Ora_DB4U@orcl
    DGMGRL for Linux: Release 19.0.0.0.0 - Production on Sat Feb 1 07:21:55 2020
    Version 19.7.0.0.0

    Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

    Welcome to DGMGRL, type "help" for information.
    Connected to "ORCL"
    Connected as SYSDBA.
    DGMGRL> validate database ORCL_nrt1d4

      Database Role:     Physical standby database
      Primary Database:  orcl

      Ready for Switchover:  Yes
      Ready for Failover:    Yes (Primary Running)

      Flashback Database Status:
        orcl       :  On
        orcl_nrt1d4:  Off

      Managed by Clusterware:
        orcl       :  NO             
        orcl_nrt1d4:  YES            
        Validating static connect identifier for the primary database orcl...
        The static connect identifier allows for a connection to database "orcl".

    DGMGRL> 
    ```

2. Switch over to cloud standby database, replace `ORCL_nrt1d4` with your standby db unique name.

    ```
    DGMGRL> switchover to orcl_nrt1d4
    Performing switchover NOW, please wait...
    Operation requires a connection to database "orcl_nrt1d4"
    Connecting ...
    Connected to "ORCL_nrt1d4"
    Connected as SYSDBA.
    New primary database "orcl_nrt1d4" is opening...
    Operation requires start up of instance "ORCL" on database "orcl"
    Starting instance "ORCL"...
    Connected to an idle instance.
    ORACLE instance started.
    Connected to "ORCL"
    Database mounted.
    Database opened.
    Connected to "ORCL"
    Switchover succeeded, new primary is "orcl_nrt1d4"
    DGMGRL> show configuration

    Configuration - adgconfig

      Protection Mode: MaxPerformance
      Members:
      orcl_nrt1d4 - Primary database
        orcl        - Physical standby database 

    Fast-Start Failover:  Disabled

    Configuration Status:
    SUCCESS   (status updated 104 seconds ago)

    DGMGRL> 
    ```

3. Check from on-premise side. You can see the previous primary side becomes the new standby side.

    ```
    [oracle@primary ~]$ sqlplus / as sysdba

    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 10:16:54 2020
    Version 19.7.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    SQL> show pdbs

        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
      2 PDB$SEED			  READ ONLY  NO
      3 ORCLPDB			  READ ONLY  NO
    SQL> select open_mode,database_role from v$database;

    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ ONLY WITH APPLY PHYSICAL STANDBY

    SQL> 
    ```

4. Check from cloud side. You can see it's becomes the new primary side.

    ```
    [oracle@dbstby ~]$ sqlplus / as sysdba

    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 10:20:06 2020
    Version 19.7.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    SQL> show pdbs

        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
      2 PDB$SEED			  READ ONLY  NO
      3 ORCLPDB			  READ WRITE NO
    SQL> select open_mode,database_role from v$database;

    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ WRITE	     PRIMARY

    SQL> 
    ```

You may proceed to the next lab.

## Acknowledgements
* **Author** - Minqiao Wang, DB Product Management
* **Last Updated By/Date** - Minqiao Wang, October 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.