# Upgrading Databases Using AutoUpgrade

## Introduction
This lab shows how to upgrade one or many databases using the AutoUpgrade tool without human intervention, all with one command and a single configuration file. Since Oracle Database 19c (19.3) and later target Oracle homes, the `autoupgrade.jar` file exists by default under `$ORACLE_HOME/rdbms/admin`. Oracle strongly recommends that you always download the latest `autoupgrade.jar` from MOS (doc ID 2485457.1) and replace it with the version in `$ORACLE_HOME/rdbms/admin`. Since Oracle Database 19c (19.3) and later target Oracle homes, the `autoupgrade.jar` file exists by default under `$ORACLE_HOME/rdbms/admin`.

Estimated Lab Time: 45 minutes

### Objectives
In this lab, you will:
* Prepare the AutoUpgrade File
* Launch the utility in analysis mode
* Launch the utility in deploy mode
* Diagnose and troubleshoot operations
* Abort and restart upgrade operations
* Clean up directories

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Prepare the AutoUpgrade configuration file

Before upgrading the Oracle Database 19c `CDB19` and `ORCL` to Oracle Database 21c, prepare the AutoUpgrade configuration file. The name of the AutoUpgrade configuration file is `/home/oracle/labs/M103786GC10/config.txt`.   

1. Define the local parameters in the AutoUpgrade configuration file because they are all required except where indicated with (Optional). Set the prefix `CDB19` for all parameters that need to identify the `CDB19` CDB or upgrade. Set the prefix `ORCL` for all parameters that need to identify the `ORCL` non-CDB or upgrade. The prefix identifies the specific upgrade job to which the parameter applies in the configuration file.    

  
    ```
    
    $ <copy>vi /home/oracle/labs/M103786GC10/config.txt</copy>
    
    #
    
    # Database CDB19
    
    #
    
    CDB19.source_home=/u01/app/oracle/product/19.3.0/dbhome_1
    
    CDB19.target_home=/u01/app/oracle/product/21.0.0/dbhome_1
    
    CDB19.sid=CDB19
    
    CDB19.log_dir=/u01/app/oracle/upgrade-jobs
    
    CDB19.pdbs=PDB19
    
    CDB19.restoration=yes
    
    $ 
    
    ```
  
  *The `log_dir` parameter sets the location of log files that are generated for database upgrades that are in the set of databases included in the upgrade job identified by the prefix for the parameter. AutoUpgrade creates a hierarchical directory based on the local log file path specified.*
  
  *The `restoration` parameter generates a Guaranteed Restore Point (GRP) for database restoration. If you set it to `no`, then both the database backup and restoration must be performed manually. Use this option for databases that operate in `NOARCHIVELOG` mode, and for Standard Edition and SE2 databases, which do not support the Oracle Flashback technology feature Flashback Database. The default value is `yes`.*
  
  

2. Append the same parameters in the AutoUpgrade configuration file for the `ORCL` non-CDB, except the `pdbs` parameter because `ORCL` is a non-CDB.

  
    ```
    
    $ <copy>vi /home/oracle/labs/M103786GC10/config.txt</copy>
    
    ...
    
    #
    
    # Database ORCL
    
    #
    
    ORCL.source_home=/u01/app/oracle/product/19.3.0/dbhome_1
    
    ORCL.target_home=/u01/app/oracle/product/21.0.0/dbhome_1
    
    ORCL.sid=ORCL
    
    ORCL.log_dir=/u01/app/oracle/upgrade-jobs
    
    ORCL.restoration=yes
    
    $ 
    
    ```

*The `run_utlrp` utility recompiles all Data Dictionary objects that become invalid during a database upgrade. Oracle recommends that you run this utility after every Oracle Database upgrade. The default is enabled (`yes`).*
  
  

## **STEP 2:** Launch the AutoUpgrade in analysis mode

Before upgrading the CDB and non-CDB, run the AutoUpgrade utility in Analyze mode, using the configuration file.

1. Run the `autoupgrade.jar` with the config file created in Analyze mode. The AutoUpgrade parameter `console` turns on the AutoUpgrade Console, and provides a set of commands to monitor the progress of AutoUpgrade jobs. Set the environment variables to `CDB21` so that the `ORACLE_HOME` is set to Oracle Database 21c.

  
    ```
    
    $ <copy>. oraenv</copy>
    
    ORACLE_SID = [CDB21] ? <b>CDB21</b>
    
    The Oracle base remains unchanged with value /u01/app/oracle
    
    $ <copy>cd $ORACLE_HOME/rdbms/admin</copy>
    
    $ <copy>java -jar autoupgrade.jar -config /home/oracle/labs/M103786GC10/config.txt -mode analyze -console</copy>
    
    AutoUpgrade tool launched with default options
    
    Processing config file ...
    
    ------------ ERROR ------------
    
    Error Cause: Database ORCL shutdown or open with incorrect binaries for ANALYZE. Ensure it is open with /u01/app/oracle/product/19.3.0/dbhome_1
    
    ------------ ERROR ------------
    
    Error Cause: <b>Database ORCL open with status CLOSED.  For ANALYZE mode, open it with one of the following: [OPEN, MOUNTED].</b>
    
    Unable to connect to database ORCL for entry orcl
    
    $ 
    
    ```

2.  According to the message, open the non-CDB.

  
    ```
    
    $ <copy>. oraenv</copy>
    
    ORACLE_SID = [CDB21] ? <b>ORCL</b>
    
    The Oracle base remains unchanged with value /u01/app/oracle
    
    $ <copy>sqlplus / AS SYSDBA</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Wed Sep 9 00:30:10 2020
    
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to an idle instance.
    
    SQL> <copy>STARTUP</copy>
    
    ORACLE instance started.
    
    Total System Global Area 5033163616 bytes
    
    Fixed Size                  9145184 bytes
    
    Variable Size             905969664 bytes
    
    Database Buffers         4110317920 bytes
    
    Redo Buffers                7630848 bytes
    
    Database mounted.
    
    Database opened.
    
    SQL> <copy>EXIT</copy>
    
    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    
    Version 19.3.0.0.0
    
    $ 
    
    ```

3.  Relaunch the autoupgrade utility.

  
    ```
    
    $ <copy>java -jar autoupgrade.jar -config /home/oracle/labs/M103786GC10/config.txt -mode analyze -console</copy>
    
    AutoUpgrade tool launched with default options
    
    Processing config file ...
    
    +--------------------------------+
    
    | Starting AutoUpgrade execution |
    
    +--------------------------------+
    
    <b>2 databases will be analyzed</b>
    
    Type 'help' to list console commands
    
    upg> 
    
    ```

4. Find the list of possible commands.

    
    ```
    
    upg> <copy>help</copy>
    
    exit                          // To close and exit
    
    help                         // Displays help
    
    lsj [(-r|-f|-p|-e) | -n <number>]  // list jobs by status up to n elements.
    
            -f Filter by finished jobs.
    
            -r Filter by running jobs.
    
            -e Filter by jobs with errors.
    
            -p Filter by jobs being prepared.
    
            -n <number> Display up to n jobs.
    
    lsr                           // Displays the restoration queue
    
    lsa                           // Displays the abort queue
    
    tasks                         // Displays the tasks running
    
    clear                         // Clears the terminal
    
    resume -job <number>          // Restarts a previous job that was running
    
    status [-job <number> [-long]]// Lists all the jobs or a specific job
    
    restore -job <number>         // Restores the database to its state prior to the upgrade
    
    restore all_failed            // Restores all failed jobs to their previous states prior to the upgrade
    
    logs                          // Displays all the log locations
    
    abort -job <number>           // Aborts the specified job
    
    h[ist]                        // Displays the command line history
    
    /[<number>]                   // Executes the command specified from the history. 
    
    The default is the last command
    
    upg> 
    
    ```

5. List the jobs running.

  
    ```
    
    upg> <copy>lsj</copy>
    
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|          MESSAGE|
    
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    
    | 100|   ORCL|PRECHECKS|PREPARING|RUNNING|20/09/09 00:43|     N/A|00:49:21|  Remaining 3/197|
    
    | 101|  CDB19|PRECHECKS|PREPARING|RUNNING|20/09/09 00:43|     N/A|00:43:19|LOW RECOVERY_AREA|
    
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    
    Total jobs 2
    
    upg> 
    
    ```

6. Wait until the AutoUpgrade returns information.

  
    ```
    
    upg> <copy>lsj</copy>
    
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|          MESSAGE|
    
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    
    | 100|   ORCL|PRECHECKS|PREPARING|RUNNING|20/09/09 00:43|     N/A|00:49:21|  Remaining 3/197|
    
    | 101|  CDB19|PRECHECKS|PREPARING|RUNNING|20/09/09 00:43|     N/A|00:43:19|LOW RECOVERY_AREA|
    
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    
    Total jobs 2
    
    upg> <b>Job 100 completed</b>
    
    upg> 
    
    ```

7. 
  
    ```
    
    upg> <copy>lsj</copy>
    
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    
    |Job#|DB_NAME|    STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|             MESSAGE|
    
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    
    | 100|   ORCL|PRECHECKS|  <b>STOPPED|FINISHED</b>|20/09/09 00:43|20/09/09 00:52|00:52:51|<b>Ended database check</b>|
    
    | 101|  CDB19|PRECHECKS|PREPARING| RUNNING|20/09/09 00:43|           N/A|00:43:19|   LOW RECOVERY_AREA|
    
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    
    Total jobs 2
    
    upg> 
    
    ```

8. Wait until the AutoUpgrade returns new information.

    
    ```
    
    upg>-------------------------------------------------
    
    job 101 has not shown progress in last 25 minutes
    
    database [CDB19]
    
    Stage    [PRECHECKS]
    
    Operation[PREPARING]
    
    Status   [RUNNING]
    
    Info     <b>[LOW RECOVERY_AREA]</b>
    
    [Review log files for further information]
    
    -----------------------------------------------
    
    Logs: /u01/app/oracle/upgrade-jobs/CDB19/101
    
    -----------------------------------------------
    
    upg> 
    
    ```

9. From another terminal session that we will name *Session2*, logged in as oracle user, increase the fast recovery area for `CDB19`.

  
    ```
    
    $ <copy>. oraenv</copy>
    
    ORACLE_SID = [oracle] ? <b>CDB19</b>
    
    The Oracle base has been set to /u01/app/oracle
    
    $ <copy>sqlplus / AS SYSDBA</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Wed Jan 22 05:05:23 2020
    
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to:
    
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    
    Version 19.3.0.0.0
    
    SQL> <copy>SHOW PARAMETER db_recovery_file_dest_size</copy>
    
    NAME                                 TYPE        VALUE
    
    ------------------------------------ ----------- ------------------------------
    
    db_recovery_file_dest_size           big integer 15000M
    
    SQL> <copy>ALTER SYSTEM SET db_recovery_file_dest_size=200000M SCOPE=BOTH;</copy>
    
    System altered.
    
    SQL> <copy>EXIT</copy>
    
    $
    
    ```

10. Back to the initial session, check the status of job 101.

  
    ```
    
    upg> <copy>lsj</copy>
    
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    
    |Job#|DB_NAME|    STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|             MESSAGE|
    
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    
    | 100|   ORCL|PRECHECKS|  STOPPED|FINISHED|20/09/09 00:43|20/09/09 00:52|00:52:51|Ended database check|
    
    | 101|  CDB19|PRECHECKS|PREPARING| RUNNING|20/09/09 00:43|           N/A|00:43:19|                    |
    
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    
    Total jobs 2
    
    upg> 
    
    ```

11. Wait until the AutoUpgrade returns new information.

  
    ```
    
    upg> <b>Job 101 completed</b>
    
    ------------------- Final Summary --------------------
    
    Number of databases            [ 2 ]
    
    Jobs finished successfully     [2]
    
    Jobs failed                    [0]
    
    Jobs pending                   [0]
    
    ------------- JOBS FINISHED SUCCESSFULLY -------------
    
    Job 100 for ORCL
    
    Job 101 for CDB19
    
    $
    
    ```
  
  The analysis for the upgrade of the two databases is completed. You can now deploy the databases upgrade.

## **STEP 3:** Launch the AutoUpgrade in deploy mode

1. Upgrade both `CDB19` and `ORCL` using the AutoUpgrade utility with the `deploy` mode, using the configuration file. 

    
2. The operation runs and displays the ongoing status of the jobs. Use the list jobs `lsj` command to get the ongoing progress of the upgrade deployment.

    ```
    
    $ <copy>java -jar autoupgrade.jar -config /home/oracle/labs/M103786GC10/config.txt -mode deploy
    </copy>
    Processing config file ...
    +--------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    2 databases will be processed
    Type 'help' to list console commands
    upg> <copy>lsj</copy>
    The jobs are still being prepared, try again in a few seconds
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+--------+--------------+--------+--------+---------------+
    |Job#|DB_NAME|    STAGE|OPERATION|  STATUS|    START_TIME|END_TIME| UPDATED|        MESSAGE|
    +----+-------+---------+---------+--------+--------------+--------+--------+---------------+
    | 103|  CDB19|<b>PRECHECKS</b>|PREPARING| RUNNING|20/01/24 04:53|     N/A|04:53:13|<b>Loading DB info</b>|
    | 102|   ORCL|    <b>SETUP</b>|PREPARING|<b>FINISHED</b>|20/01/24 04:54|     N/A|04:53:12|      Scheduled|
    +----+-------+---------+---------+--------+--------------+--------+--------+---------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|        MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    | 103|  CDB19|PRECHECKS|PREPARING|RUNNING|20/01/24 04:53|     N/A|04:54:59|Remaining 1/176|
    | 102|   ORCL|<b>PRECHECKS</b>|PREPARING|RUNNING|20/01/24 04:54|     N/A|04:54:33|<b>Loading DB info</b>|
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|        MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    | 103|  CDB19|      <b>GRP</b>|EXECUTING|RUNNING|20/01/24 11:13|     N/A|11:15:43|               |
    | 102|   ORCL|PRECHECKS|<b>PREPARING</b>|RUNNING|20/01/24 11:14|     N/A|11:14:50|Loading DB info|
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+--------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|       MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+--------------+
    | 103|  CDB19|<b>PREFIXUPS</b>|EXECUTING|RUNNING|20/03/17 08:36|     N/A|08:42:58|Remaining 7/12|
    | 102|   ORCL|PREFIXUPS|EXECUTING|RUNNING|20/03/17 08:37|     N/A|08:42:33| Remaining 4/5|
    +----+-------+---------+---------+-------+--------------+--------+--------+--------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------------+
    |Job#|DB_NAME|STAGE    |OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|             MESSAGE   |
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------------+
    | 103|  CDB19|<b>DRAIN</b>    |EXECUTING|RUNNING|20/03/17 08:36|     N/A|08:50:46|<b>Shutting down databa</b>||
    | 102|   ORCL|PREFIXUPS|EXECUTING|RUNNING|20/03/17 08:37|     N/A|08:45:22|Remaining 4/5          |
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+-------------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|            MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+-------------------+
    | 103|  CDB19|<b>DBUPGRADE</b>|EXECUTING|RUNNING|20/03/17 08:36|     N/A|08:59:19|<b>1%Upgraded CDB$ROOT</b>|
    | 102|   ORCL|    DRAIN|EXECUTING|RUNNING|20/03/17 08:37|     N/A|09:01:10| <b>Executing describe</b>|
    +----+-------+---------+---------+-------+--------------+--------+--------+-------------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|        MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    | 102|   ORCL|<b>PREFIXUPS</b>|EXECUTING|RUNNING|20/09/09 01:41|     N/A|01:44:12|Remaining 10/10|
    | 103|  CDB19|PREFIXUPS|EXECUTING|RUNNING|20/09/09 01:42|     N/A|01:47:06|<b>Remaining 10/12</b>|
    +----+-------+---------+---------+-------+--------------+--------+--------+---------------+
    Total jobs 2
    upg>
    
    ```
    *You may see the `GRP` stage. This means that the upgrade creates a Guaranteed Restore Point in case a restoration would be required.*
    
    *The `Executing describe` step tells you that the non-CDB `ORCL` is being tested for the compatibility after being unplugged and then plugged into `CDB20` as a new PDB, just as you would run the `DBMS_PDB.DESCRIBE` procedure and `DBMS_PDB.CHECK_PLUG_COMPATIBILITY`function.*
    

3.  Regularly check the progress of the upgrade.

    ```
    
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+-------------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|            MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+-------------------+
    | 103|  CDB19|<b>DBUPGRADE</b>|EXECUTING|RUNNING|20/03/17 08:36|     N/A|09:02:21|4%Upgraded CDB$ROOT|
    | 102|   ORCL|DBUPGRADE|EXECUTING|RUNNING|20/03/17 08:37|     N/A|09:03:47|    <b>0%Upgraded ORCL</b>|
    +----+-------+---------+---------+-------+--------------+--------+--------+-------------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+--------------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|             MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+--------------------+
    | 102|  CDB19|DBUPGRADE|EXECUTING|RUNNING|20/03/17 08:36|     N/A|09:26:38|<b>91%Upgraded CDB$ROOT</b>|
    | 103|   ORCL|DBUPGRADE|EXECUTING|RUNNING|20/03/17 08:37|     N/A|09:28:07|     <b>98%Upgraded ORCL</b>|
    +----+-------+---------+---------+-------+--------------+--------+--------+--------------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+------------+---------+-------+--------------+--------+--------+--------------------+
    |Job#|DB_NAME|       STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|             MESSAGE|
    +----+-------+------------+---------+-------+--------------+--------+--------+--------------------+
    | 103|  CDB19|   DBUPGRADE|EXECUTING|RUNNING|20/03/18 03:38|     N/A|06:34:09| <b>0%Compiled CDB$ROOT</b>|
    | 102|   ORCL|<b>NONCDBTOPDB</b>|EXECUTING|RUNNING|20/03/18 03:39|     N/A|06:37:23|   <b>noncdb_to_pdb.sql</b>|
    +----+-------+------------+---------+-------+--------------+--------+--------+--------------------+Total jobs 2
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|             MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    | 103|  CDB19|  DBUPGRADE|EXECUTING|FINISHED|20/01/24 11:50|20/01/24 15:14|15:14:59| <b>0%Upgraded PDB$SEED</b>|
    | 102|   ORCL|NONCDBTOPDB|  STOPPED|FINISHED|20/03/18 03:39|           N/A|06:37:23|   noncdb_to_pdb.sql|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|          MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    | 103|  CDB19| <b>POSTFIXUPS</b>|EXECUTING| RUNNING|20/03/18 03:38|           N/A|09:14:18|    <b>Remaining 5/9</b>|
    | 102|   ORCL|<b>NONCDBTOPDB</b>|  STOPPED|<b>FINISHED</b>|20/03/18 03:39|20/03/18 07:42|07:42:40|<b>Completed job</b> 103|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|             MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    | 103|  CDB19|<b>POSTUPGRADE</b>|EXECUTING| RUNNING|20/03/18 03:38|           N/A|09:25:37|<b>Creating final SPFIL</b>|
    | 102|   ORCL|NONCDBTOPDB|  STOPPED|FINISHED|20/03/18 03:39|20/03/18 07:42|07:42:40|   Completed job 103|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|          MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    | 103|  CDB19|POSTUPGRADE|EXECUTING| RUNNING|20/03/18 03:38|           N/A|09:26:11|       Restarting|
    | 102|   ORCL|NONCDBTOPDB|  STOPPED|FINISHED|20/03/18 03:39|20/03/18 07:42|07:42:40|Completed job 103|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    Total jobs 2
    
    upg>
    
    ```

    - If you find that the progress is slow, you can request the status of the upgrade.

    ```
    
    upg> <copy>status</copy>
    ---------------- Config -------------------
    User configuration file    [/home/oracle/labs/M103786GC10/config.txt]
    General logs location      [/home/oracle/labs/AutoUpgrade/cfgtoollogs/upgrade/auto]
    Mode                       <b>[DEPLOY]</b>
    DB upg fatal errors        ORA-00600,ORA-07445
    DB Post upgrade abort time [60] minutes
    DB upg abort time          [1440] minutes
    DB restore abort time      [120] minutes
    DB GRP abort time          [3] minutes
    ------------------------ Jobs ------------------------
    Total databases in configuration file [2]
    Total Non-CDB being processed         [0]
    Total CDB being processed             [2]
    Jobs finished successfully            [0]
    Jobs finished/aborted                 [0]
    <b>Jobs in progress                      [2]</b>
    Jobs stage summary
        Job ID: 102
        DB name: <b>ORCL</b>
            SETUP             <1 min
            GRP               <1 min
            PREUPGRADE        <1 min
            PRECHECKS         2 min
            PREFIXUPS         17 min (IN PROGRESS)    
        Job ID: 103
        DB name: <b>CDB19</b>
            SETUP             <1 min
            GRP               <1 min
            PREUPGRADE        <1 min
            PRECHECKS         2 min
            PREFIXUPS         15 min (IN PROGRESS)
    ------------ Resources ----------------
    Threads in use                        [51]
    JVM used memory                       [34] MB
    CPU in use                            [13%]
    Processes in use                      [33]
    
    upg>
    
    ```

  
  

    - After some time, any of the jobs completes.

  
    ```
    
    upg> Job 103 completed
    
    upg> lsj
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|          MESSAGE|
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    
    | 103|  CDB19|POSTUPGRADE|  STOPPED|FINISHED|20/01/22 05:34|20/01/22 08:44|08:44:20|Completed job 103|
    
    | 102|   ORCL|      DRAIN|EXECUTING| RUNNING|20/01/24 11:18|           N/A|11:17:04|Creating pluggable d|
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    
    Total jobs 2
    
    upg>
    
    ```
    
    or

    
    ```
    
    upg> Job 102 completed
    
    upg> lsj
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-------------------+
    
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|            MESSAGE|
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-------------------+
    
    | 103|  CDB19|  DBUPGRADE|EXECUTING| RUNNING|20/03/18 03:38|           N/A|07:43:54|0%Upgraded PDB$SEED|
    
    | 102|   ORCL|NONCDBTOPDB|  STOPPED|FINISHED|20/03/18 03:39|20/03/18 07:42|07:42:40|  Completed job 102|
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-------------------+
    
    Total jobs 2
    
    upg>
    
    ```

4. Quit the AutoUpgrade session.

  
    ```
    
    upg> <copy>exit</copy>
    
    There is 1 job in progress. if you exit it will stop
    
    Are you sure you wish to leave? [y|N] <b>y</b>
    
    ------------------- Final Summary --------------------
    
    Number of databases            [ 2 ]
    
    Jobs finished successfully     [1]
    
    Jobs failed                    [0]
    
    Jobs pending                   [1]
    
    ------------- JOBS FINISHED SUCCESSFULLY -------------
    
    <b>Job 103 FOR CDB19</b>
    
    -------------------- JOBS PENDING ---------------------
    
    Job 102 FOR ORCL
    
    ---- Drop GRP at your convenience once you consider it is no longer needed ----
    
    <b>Drop GRP from CDB19: drop restore point autoupgrade_9212_CDB19193000</b>
    
    Exiting
    
    upg>
    
    ```
  
  The AutoUpgrade created a guaranteed restore point (GRP) during Deploy processing mode because the `CDB19.restoration` parameter was set to `yes`. You do not need to have a previously defined GRP. This requires a lot of space in the FRA and this is the reason why you had to set the `DB_RECOVERY_FILE_DEST_SIZE` to a high value. However, if the parameter was set, you must drop the GRP. “Guaranteed” means that if FRA runs out of space, the database will come to a complete halt.

5. Drop the guaranteed restore point created for the sake of a possible restoration if the upgrade had failed.

  
    ```
    
    $ <copy>export ORACLE_HOME=/u01/app/oracle/product/21.0.0/dbhome_1</copy>
    
    ORACLE_SID = [oracle] ? <b>CDB19</b>
    
    The Oracle base has been set to /u01/app/oracle
    
    $ <copy>sqlplus / AS SYSDBA</copy>
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to:
    
    SQL> <copy>DROP RESTORE POINT autoupgrade_9212_CDB19193000;</copy>
    
    Restore point dropped.
    
    SQL>
    
    ```

6. Check that `CDB19` is now an Oracle Database 21c database.

  
    ```
    
    SQL> <copy>SELECT version, version_legacy, version_full FROM v$instance;</copy>
    
    VERSION           VERSION_LEGACY    VERSION_FULL
    
    ----------------- ----------------- -----------------
    
    21.0.0.0.0        21.0.0.0.0        21.1.0.0.0
    
    SQL> <copy>SHOW PDBS</copy>
    
        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    
    ---------- ------------------------------ ---------- ----------
    
            2 PDB$SEED                       READ ONLY  NO
    
             3 PDB19                          READ WRITE NO
    
    SQL> <copy>EXIT</copy>
    
    $
    
    ```

7. If there is still a pending job, restart the pending AutoUpgrade job. The job is not stopped, therefore you do not have to resume it.
    
    - Re-run the AutoUpgrade job in the `deploy` mode.

    ```
    
    $ <copy>java -jar autoupgrade.jar -config /home/oracle/labs/M104786GC10/config.txt -mode deploy</copy>
    Previous execution found loading latest data
    Total jobs recovered: 2
    +--------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    Type 'help' to list console commands
    upg> <copy>resume -job 102</copy>
    The command cannot be executed because job 102 is not in a stopped state
    upg>
    upg> <copy>lsj</copy>
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|          MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    | 103|  CDB19|POSTUPGRADE|  STOPPED|FINISHED|20/01/28 11:34|20/01/28 18:59|18:59:20|Completed job 103|
    | 102|   ORCL|NONCDBTOPDB|EXECUTING| RUNNING|20/01/28 11:55|           N/A|11:55:47| noncdb_to_pdb.sql|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    Total jobs 2
    upg> <copy>lsj</copy>
    +----+-------+-----------+---------+--------+--------------+--------------+--------+------------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|           MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+------------------+
    | 103|  CDB19|POSTUPGRADE|  STOPPED|FINISHED|20/01/28 11:34|20/01/28 18:59|18:59:20| Completed job 103|
    | 102|   ORCL|NONCDBTOPDB|  STOPPED|FINISHED|20/01/28 11:50|20/01/28 16:04|16:04:07| Completed job 102|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+------------------+
    Total jobs 2
    upg>  <copy>exit</copy>
    ------------------- Final Summary --------------------
    Number of databases            [ 2 ]
    
    Jobs finished successfully     [2]
    Jobs failed                    [0]
    Jobs pending                   [0]
    ------------- JOBS FINISHED SUCCESSFULLY -------------
    Job 103 for CDB19
    Job 102 for ORCL
    
    $
    
    ```

8. Check that the non-CDB `ORCL` is now the Oracle Database 21c `ORCL` PDB in `CDB21`. In another terminal session, set the environment variables to `CDB21`.

    ```
    
    $ <copy>. oraenv</copy>
    ORACLE_SID = [CDB21] ? <b>CDB21</b>
    The Oracle base remains unchanged with value /u01/app/oracle
    $ <copy>sqlplus / AS SYSDBA</copy>
    SQL> <copy>SELECT version, version_legacy, version_full FROM v$instance;</copy>
    
    VERSION           VERSION_LEGACY    VERSION_FULL
    ----------------- ----------------- -----------------
    21.0.0.0.0        21.0.0.0.0        21.1.0.0.0
    
    SQL> <copy>SHOW PDBS</copy>
    
        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 PDB21                          READ WRITE NO
             4 ORCL                           READ WRITE NO 
    SQL> <copy>EXIT</copy>
    $
    
    ```

  
  

## **STEP 4:** Diagnose and troubleshoot AutoUpgrade operations

Let's handle possible errors while analyzing or upgrading databases. The cases below show different situations and therefore different job number and dates.

1. Use different vays to examine the ongoing status of the upgrade operation.
    
2. Use the `status` command in AutoUpgrade.

    ```
    
    upg> <copy>status</copy>
    ---------------- Config -------------------
    User configuration file    [/home/oracle/labs/M104786GC10/config.txt]
    General logs location      [/home/oracle/labs/AutoUpgrade/cfgtoollogs/upgrade/auto]
    Mode                       [DEPLOY]
    DB upg fatal errors        ORA-00600,ORA-07445
    DB Post upgrade abort time [60] minutes
    DB upg abort time          [1440] minutes
    DB restore abort time      [120] minutes
    DB GRP abort time          [3] minutes
    ------------------------ Jobs ------------------------
    Total databases in configuration file [2]
    Total Non-CDB being processed         [0]
    Total CDB being processed             [2]
    Jobs finished successfully            [0]
    Jobs <b>finished/aborted                 [1]</b>
    Jobs <b>in progress                      [1]</b>
    Jobs stage summary
        Job ID: 102
        DB name: CDB19
            SETUP             <1 min
            PREUPGRADE        <1 min
            PRECHECKS         1 min
            GRP               <1 min     Job ID: 103
        DB name: ORCL
            SETUP             <1 min
            PREUPGRADE        <1 min
            PRECHECKS         1 min
            GRP               <1 min
            PREFIXUPS         4 min
            DRAIN             8 min
            <b>DBUPGRADE         59 min (IN PROGRESS)</b>
    ------------ Resources ----------------
    Threads in use                        [43]
    JVM used memory                       [60] MB
    CPU in use                            [13%]
    Processes in use                      [20]
    upg>
    
    ```

3. List the directories of the log files for alld and each of the databases being upgraded.

    ```
    
    upg> <copy>logs</copy>
    AutoUpgrade logs folder [/home/oracle/labs/AutoUpgrade/cfgtoollogs/upgrade/auto]
    logs folder [CDB19][/u01/app/oracle/upgrade-jobs/CDB19]
    logs folder [ORCL][/u01/app/oracle/upgrade-jobs/ORCL]
    upg>
    
    ```

4. You can view the status and all operations completed or in progress during the upgrade of `CDB19` in the `/u01/app/oracle/upgrade-jobs/CDB19/102/autoupgrade_20200122_user.log` log file.

    ```
    
    $ <copy>cat /u01/app/oracle/upgrade-jobs/CDB19/102/autoupgrade_20200122_user.log</copy>
    ...
    2020-01-22 05:36:04.836 INFO Analyzing CDB19, 176 checks will run using 8 threads
    2020-01-22 05:36:46.007 INFO Guarantee Restore Point (GRP) successfully removed [CDB$ROOT][AUTOUPGRADE_221145114461854_CDB19]
    2020-01-22 05:36:51.030 INFO Guarantee Restore Point (GRP) successfully created [CDB$ROOT][AUTOUPGRADE_221145114461854_CDB19]
    2020-01-22 05:37:04.130 INFO Using /u01/app/oracle/upgrade-jobs/CDB19/102/prechecks/cdb19_checklist.cfg as reference to determine the fixups which will be executed
    2020-01-22 05:37:04.178 INFO PURGE_RECYCLEBIN
    2020-01-22 05:37:04.181 INFO PURGE_RECYCLEBIN
    2020-01-22 05:37:04.182 INFO PURGE_RECYCLEBIN
    2020-01-22 05:37:07.316 INFO Updating parameter *.sga_target=851443712 to *.sga_target=1226833920 in /u01/app/oracle/upgrade-jobs/CDB19/temp/during_upgrade_pfile_CDB19.ora
    2020-01-22 05:37:07.317 INFO Updating parameter *.sga_target=851443712 to *.sga_target=1226833920 in /u01/app/oracle/upgrade-jobs/CDB19/temp/after_upgrade_pfile_CDB19.ora
    2020-01-22 05:37:07.343 INFO Deleting parameter *.local_listener='' in /u01/app/oracle/upgrade-jobs/CDB19/temp/during_upgrade_pfile_CDB19.ora
    2020-01-22 05:37:07.383 INFO Adding parameter cluster_database='FALSE' to /u01/app/oracle/upgrade-jobs/CDB19/temp/during_upgrade_pfile_CDB19.ora
    2020-01-22 05:37:07.408 INFO Adding parameter job_queue_processes='0' to /u01/app/oracle/upgrade-jobs/CDB19/temp/during_upgrade_pfile_CDB19.ora
    2020-01-22 05:38:35.585 INFO Analyzing CDB19, 176 checks will run using 8 threads
    2020-01-22 05:40:13.547 INFO Copying password file from /u01/app/oracle/product/19.3.0/dbhome_1/dbs/orapwCDB19 to /u01/app/oracle/dbs/orapwCDB19
    2020-01-22 05:40:13.573 INFO Copying password file completed with success
    2020-01-22 05:41:09.915 INFO Total Number of upgrade phases is 107
    2020-01-22 05:41:09.919 INFO Begin Upgrade on Database [cdb19-cdb$root]
    2020-01-22 05:41:18.997 INFO [Upgrading] is [0%] completed for [cdb19-cdb$root]
    +---------+---------------+
    |CONTAINER|     PERCENTAGE|
    +---------+---------------+
    | CDB$ROOT|   UPGRADE [0%]|
    | PDB$SEED|UPGRADE PENDING|
    |    PDB19|UPGRADE PENDING|
    +---------+---------------+
    2020-01-22 05:44:21.043 INFO [Upgrading] is [1%] completed for [cdb19-cdb$root]
    +---------+---------------+
    |CONTAINER|     PERCENTAGE|
    +---------+---------------+
    | CDB$ROOT|   UPGRADE [1%]|
    | PDB$SEED|UPGRADE PENDING|
    |    PDB19|UPGRADE PENDING|
    +---------+---------------+
    2020-01-22 05:47:23.108 INFO [Upgrading] is [1%] completed for [cdb19-cdb$root]
    +---------+---------------+
    |CONTAINER|     PERCENTAGE|
    +---------+---------------+
    | CDB$ROOT|   UPGRADE [1%]|
    | PDB$SEED|UPGRADE PENDING|
    |    PDB19|UPGRADE PENDING|
    +---------+---------------+
    2020-01-22 05:50:25.157 INFO [Upgrading] is [5%] completed for [cdb19-cdb$root]
    +---------+---------------+
    |CONTAINER|     PERCENTAGE|
    +---------+---------------+
    | CDB$ROOT|   UPGRADE [5%]|
    | PDB$SEED|UPGRADE PENDING|
    |    PDB19|UPGRADE PENDING|
    +---------+---------------+
    2020-01-22 05:53:27.220 INFO [Upgrading] is [8%] completed for [cdb19-cdb$root]
    +---------+---------------+
    |CONTAINER|     PERCENTAGE|
    +---------+---------------+
    | CDB$ROOT|   UPGRADE [8%]|
    | PDB$SEED|UPGRADE PENDING|
    |    PDB19|UPGRADE PENDING|
    +---------+---------------+
    2020-01-22 05:56:29.265 INFO [Upgrading] is [10%] completed for [cdb19-cdb$root]
    +---------+---------------+
    |CONTAINER|     PERCENTAGE|
    +---------+---------------+
    | CDB$ROOT|  UPGRADE [10%]|
    | PDB$SEED|UPGRADE PENDING|
    |    PDB19|UPGRADE PENDING|
    +---------+---------------+
    2020-01-22 05:59:31.324 INFO [Upgrading] is [12%] completed for [cdb19-cdb$root]
    +---------+---------------+
    |CONTAINER|     PERCENTAGE|
    +---------+---------------+
    | CDB$ROOT|  UPGRADE [12%]|
    | PDB$SEED|UPGRADE PENDING|
    |    PDB19|UPGRADE PENDING|
    +---------+---------------+
    2020-01-22 06:02:33.373 INFO [Upgrading] is [18%] completed for [cdb19-cdb$root]
    +---------+---------------+
    |CONTAINER|     PERCENTAGE|
    +---------+---------------+
    | CDB$ROOT|  UPGRADE [18%]|
    | PDB$SEED|UPGRADE PENDING|
    |    PDB19|UPGRADE PENDING|
    +---------+---------------+
    ...
    +---------+--------------------------------------+
    |CONTAINER|                            PERCENTAGE|
    +---------+--------------------------------------+
    | CDB$ROOT|SUCCESSFULLY UPGRADED [cdb19-cdb$root]|
    | PDB$SEED|                          COMPILE [0%]|
    |    PDB19|   SUCCESSFULLY UPGRADED [cdb19-pdb19]|
    +---------+--------------------------------------+
    2020-01-22 08:21:09.692 INFO [Upgrading] is [100%] completed for [cdb19-pdb$seed]
    +---------+--------------------------------------+
    |CONTAINER|                            PERCENTAGE|
    +---------+--------------------------------------+
    | <b>CDB$ROOT|SUCCESSFULLY UPGRADED</b> [cdb19-cdb$root]|
    | <b>PDB$SEED|SUCCESSFULLY UPGRADED</b> [cdb19-pdb$seed]|
    |    <b>PDB19|   SUCCESSFULLY UPGRADED</b> [cdb19-pdb19]|
    +---------+--------------------------------------+
    2020-01-22 08:21:19.875 INFO SUCCESSFULLY UPGRADED [cdb19]
    2020-01-22 08:21:19.875 INFO End Upgrade on Database [cdb19]
    2020-01-22 08:21:19.876 INFO SUCCESSFULLY UPGRADED [cdb19]
    2020-01-22 08:21:19.914 INFO cdb19 Return status is SUCCESS
    2020-01-22 08:23:50.226 INFO Analyzing CDB19, 31 checks will run using 8 threads
    ...
    $
    
    ```

5. You can view the status and all operations completed or in progress during the upgrade of `ORCL` in the `/u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200128_user.log` log file.

    ```
    
    $ <copy>cat /u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200128_user.log</copy>
    ...2020-01-28 03:43:22.101 INFO [Upgrading] is [93%] completed for [orcl-orcl]
    +---------+-------------+
    |CONTAINER|   PERCENTAGE|
    +---------+-------------+
    |     ORCL|UPGRADE [93%]|
    +---------+-------------+
    2020-01-28 03:44:57.898 ERROR
    DATABASE NAME: ORCL-ORCL
             CAUSE: ERROR at Line 771792 in [/u01/app/oracle/upgrade-jobs/ORCL/103/dbupgrade/catupgrd20200128014926orcl0.log]
            REASON: ORA-04031: unable to allocate 41000 bytes of shared memory ("shared
            ACTION: [MANUAL]
            DETAILS: 04031, 00000, "unable to allocate %s bytes of shared memory (\"%s\",\"%s\",\"%s\",\"%s\")"
    // *Cause:  More shared memory is needed than was allocated in the shared
    //          pool or Streams pool.
    // *Action: If the shared pool is out of memory, either use the
    //          DBMS_SHARED_POOL package to pin large packages,
    //          reduce your use of shared memory, or increase the amount of
    //          available shared memory by increasing the value of the
    //          initialization parameters SHARED_POOL_RESERVED_SIZE and
    //          SHARED_POOL_SIZE.
    //          If the large pool is out of memory, increase the initialization
    //          parameter LARGE_POOL_SIZE.
    //          If the error is issued from an Oracle Streams or XStream process,
    //          increase the initialization parameter STREAMS_POOL_SIZE or increase
    //          the capture or apply parameter MAX_SGA_SIZE.
    ...
    $
    
    ```

6. More detailed information is visible in the `/u01/app/oracle/upgrade-jobs/CDB19/102/autoupgrade_20200122.log` log file.

    ```
    
    $ <copy>cat /u01/app/oracle/upgrade-jobs/CDB19/102/autoupgrade_20200122.log</copy>
    ...
    <b> - Utilities.printBuildInfo</b>
    2020-01-22 05:34:40.217 INFO Starting - DbUpgrade.initGlobals
    2020-01-22 05:34:40.217 INFO Begin Getting Database Configuration - DbUpgrade.initGlobals
    2020-01-22 05:34:40.218 INFO
    DataBase Name:cdb19
    Sid Name     :CDB19
    PDBS         :PDB$SEED,PDB19
    Source Home  :/u01/app/oracle/product/19.3.0/dbhome_1
    Target Home  :/u01/app/oracle/product/20.2.0/dbhome_1
    Log Directory:/u01/app/oracle/upgrade-jobs/CDB19
    Node Name    :localhost
    Log File     :/u01/app/oracle/upgrade-jobs/CDB19/102/dbupgrade/autoupgrade20200122053440cdb19.log
    <b> - DbUpgrade.initGlobals</b>
    2020-01-22 05:34:40.218 INFO End Getting Database Configuration - DbUpgrade.initGlobals
    2020-01-22 05:34:40.218 INFO Finished - DbUpgrade.initGlobals
    2020-01-22 05:34:41.269 INFO Starting dispatcher instance for CDB19 in DEPLOY mode - AutoUpgDispatcher.run
    2020-01-22 05:34:41.275 INFO The original stage queue is: [PREUPGRADE, PRECHECKS, GRP, PREFIXUPS, DRAIN, DBUPGRADE, POSTCHECKS, POSTFIXUPS, POSTUPGRADE] - DeployExecuteHelper.<init>
    2020-01-22 05:34:41.276 INFO Executing deploy of CDB19 - DispatcherExecuteContext.callExecuteContext
    ...
    2020-01-22 05:40:15.712 INFO Begin Oracle Home=/u01/app/oracle/product/20.1.0/dbhome_1 Oracle Sid=CDB19 Sql*Plus Command=shutdown immediate; Container Name = None Filename=None Echo=true - ExecuteSql.doSqlCmds
    2020-01-22 05:40:15.712 INFO Begin Starting Sql*Plus - ExecuteSql.doSqlCmds
    2020-01-22 05:40:15.712 INFO Starting - ExecuteProcess.startProcess
    2020-01-22 05:40:15.712 INFO Begin /u01/app/oracle/product/20.2.0/dbhome_1/bin/sqlplus - ExecuteProcess.startProcess
    ...
    2020-01-22 05:40:17.741 INFO Begin Oracle Home=/u01/app/oracle/product/20.1.0/dbhome_1 Oracle Sid=CDB19 Sql*Plus Command=startup upgrade pfile='/u01/app/oracle/upgrade-jobs/CDB19/temp/during_upgrade_pfile_CDB19.ora'; Container Name = None Filename=None Echo=true - ExecuteSql.doSqlCmds
    2020-01-22 05:40:17.741 INFO Begin Starting Sql*Plus - ExecuteSql.doSqlCmds
    ...
    $
    
    ```

  
  

7. During the analyzing phase, you may have to interpret the suggestions so as to correct the config file.

    
8. A first information may mention that the parameter `global.autoupg_log_dir` is not found in the config file. It is a global required parameter that sets the location of the log files, and temporary files that belong to global modules, which AutoUpgrade uses. If you do not use this parameter to set a path, then the log files are placed in the current location where you run AutoUpgrade. This is the reason why the AutoUpgrade tool uses the session working directory `/u01/app/oracle/product/21.0.0/dbhome_1/rdbms/admin/`. Add the parameter `global.autoupg_log_dir` to the config file.

    ```
    
    $ <copy>vi /home/oracle/labs/M103786GC10/config.txt</copy>
    #
    # Global parameters
    #
    <b>global.autoupg_log_dir=/home/oracle/labs/AutoUpgrade</b>
    #
    # Database CDB19
    #
    CDB19.source_home=/u01/app/oracle/product/19.3.0/dbhome_1
    CDB19.target_home=/u01/app/oracle/product/21.0.0/dbhome_1
    CDB19.sid=CDB19
    CDB19.log_dir=/u01/app/oracle/upgrade-jobs
    CDB19.pdbs=PDB19
    CDB19.restoration=yes
    CDB19.run_utlrp=yes
    #
    # Database ORCL
    #
    ORCL.source_home=/u01/app/oracle/product/19.3.0/dbhome_1
    ORCL.target_home=/u01/app/oracle/product/21.0.0/dbhome_1
    ORCL.sid=ORCL
    ORCL.log_dir=/u01/app/oracle/upgrade-jobs
    ORCL.restoration=yes
    $ 
    
    ```

9. A second information may mention that `ORCL Missing parameter for
                                    db ORCL, you need to specify a target cdb`. The reason for this information is that non-CDBs are no longer supported in Oracle Database 21c. Add the parameter `target_cdb` to the config file to specify that the `ORCL` non-CDB will be upgraded as a PDB in `CDB21`.

    ```
    
    <b>ORCL.target_cdb=CDB21</b>
    $ 
    
    ```

  
  

10. In *Session2*, you made an error by dropping the directory where the upgrade log files are created for `ORCL`.

  
    ```
    
    $ <copy>cd /u01/app/oracle/upgrade-jobs/ORCL</copy>
    
    $ <copy>rm -rf 102</copy>
    
    $ 
    
    ```
    
    

    
11. The AutoUpgrade job stops.

    ```
    
    upg> -------------------------------------------------
    Errors in database [ORCL]
    Stage     [PREFIXUPS]
    Operation [STOPPED]
    Status    [ERROR]
    Info    [
    <b>Error: UPG-1312
    [Unexpected exception error]
    Cause: A failed check has an ERROR severity but the fixup is unavailable or failed to correct the problem. Manually fix the problem and rerun AutoUpgrade</b>
    For further details, see the log file located at /u01/app/oracle/upgrade-jobs/ORCL/102/autoupgrade_20200909_user.log]
    
    -------------------------------------------------
    Logs: [/u01/app/oracle/upgrade-jobs/ORCL/102/autoupgrade_20200909_user.log]
    -------------------------------------------------
    upg> 
    
    ```

12. In *Session2*, you recreate the directory for the upgrade log files for `ORCL`.

    ```
    
    $ <copy>mkdir -p /u01/app/oracle/upgrade-jobs/ORCL/102</copy>
    $ 
    
    ```

13. Resume the job, from the initial session.

    ```
    
    upg> <copy>resume -job 102</copy>
    Resuming job: [102][ORCL]
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+--------+--------------+--------+--------+---------------+
    |Job#|DB_NAME|    STAGE|OPERATION|  STATUS|    START_TIME|END_TIME| UPDATED|        MESSAGE|
    +----+-------+---------+---------+--------+--------------+--------+--------+---------------+
    | 102|   ORCL|PREFIXUPS|PREPARING|FINISHED|20/09/09 01:41|     N/A|02:20:10|               |
    | 103|  CDB19|PREFIXUPS|EXECUTING| RUNNING|20/09/09 01:42|     N/A|01:47:06|Remaining 10/12|
    +----+-------+---------+---------+--------+--------------+--------+--------+---------------+
    Total jobs 2
    
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------------+--------+---------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|      END_TIME| UPDATED|        MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------------+--------+---------------+
    | 102|   ORCL|PREFIXUPS|  <b>STOPPED</b>|RUNNING|20/09/09 01:41|20/09/09 02:20|02:20:14|               |
    | 103|  CDB19|PREFIXUPS|EXECUTING|RUNNING|20/09/09 01:42|           N/A|01:47:06|Remaining 10/12|
    +----+-------+---------+---------+-------+--------------+--------------+--------+---------------+
    Total jobs 2
    upg> 
    
    ```
    *The `resume` command restarts a previous job that was running.*
    

14. As the job stops again, restore the database to its previous state.

    ```
    
    upg> <copy>restore -job 102</copy>
    Job 102[ORCL] in stage [PREFIXUPS] has the status [RUNNING]
    Are you sure you want to restore? All progress will be lost [y/N] <b>y</b>
    upg> <copy>lsj</copy>
    +----+-------+----------+---------+-------+--------------+--------------+--------+---------------+
    |Job#|DB_NAME|     STAGE|OPERATION| STATUS|    START_TIME|      END_TIME| UPDATED|        MESSAGE|
    +----+-------+----------+---------+-------+--------------+--------------+--------+---------------+
    | 102|   ORCL|<b>GRPRESTORE</b>|EXECUTING|RUNNING|20/09/09 01:41|20/09/09 02:20|02:23:03|      Preparing|
    | 103|  CDB19| PREFIXUPS|EXECUTING|RUNNING|20/09/09 01:42|           N/A|01:47:06|Remaining 10/12|
    +----+-------+----------+---------+-------+--------------+--------------+--------+---------------+
    Total jobs 2
    
    upg> 
    upg> <copy>lsj</copy>
    +----+-------+----------+---------+-------+--------------+--------------+--------+------------------+
    |Job#|DB_NAME|     STAGE|OPERATION| STATUS|    START_TIME|      END_TIME| UPDATED|           MESSAGE|
    +----+-------+----------+---------+-------+--------------+--------------+--------+------------------+
    | 102|   ORCL|GRPRESTORE|EXECUTING|RUNNING|20/09/09 01:41|20/09/09 02:20|02:38:10|<b>Restore phase[5/6]</b>|
    | 103|  CDB19| PREFIXUPS|EXECUTING|RUNNING|20/09/09 01:42|           N/A|01:47:06|   Remaining 10/12|
    +----+-------+----------+---------+-------+--------------+--------------+--------+------------------+
    Total jobs 2
    
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+--------+--------------+--------+--------+-----------------+
    |Job#|DB_NAME|    STAGE|OPERATION|  STATUS|    START_TIME|END_TIME| UPDATED|          MESSAGE|
    +----+-------+---------+---------+--------+--------------+--------+--------+-----------------+
    | 102|   ORCL|    SETUP|  STOPPED|FINISHED|20/09/09 01:41|     N/A|02:50:35|<b>Database Restored</b>|
    | 103|  CDB19|PREFIXUPS|EXECUTING| RUNNING|20/09/09 01:42|     N/A|03:06:39|   Remaining 6/12|
    +----+-------+---------+---------+--------+--------------+--------+--------+-----------------+
    Total jobs 2
    
    upg>
    
    ```
    *The `restore``-job` command restores the database to its state prior to the upgrade.*
    

15. After the restoration, resume the job so as to restart the job.

    ```
    
    upg> <copy>resume -job 102</copy>
    Resuming job: [102][ORCL]
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+-------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+-------+
    | 102|   ORCL|      GRP|EXECUTING|RUNNING|20/09/09 01:41|     N/A|03:20:38|       |
    | 103|  CDB19|DBUPGRADE|EXECUTING|RUNNING|20/09/09 01:42|     N/A|03:18:52|Running|
    +----+-------+---------+---------+-------+--------------+--------+--------+-------+
    Total jobs 2
    
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|          MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    | 102|   ORCL|PRECHECKS|PREPARING|RUNNING|20/09/09 01:41|     N/A|03:23:35|Remaining 132/197|
    | 103|  CDB19|DBUPGRADE|EXECUTING|RUNNING|20/09/09 01:42|     N/A|03:18:52|          Running|
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    Total jobs 2
    
    upg>
    
    ```
    The job now proceeds correctly.

  
  

16. Suddenly, the AutoUpgrade in deploy mode displays an error while upgrading `CDB19`.

  
    ```
    
    upg> -------------------------------------------------
    
    job 104 has not shown progress in last 10 minutes
    
    Errors in database [CDB19]
    
    Stage    [PREFIXUPS]
    
    Operation<b>[STOPPED]</b>
    
    Status   <b>[ERROR]</b>
    
    Info     <b>[Error: UPG-1312</b>
    
    [Unexpected Exception Error]
    
    Cause: One of the checks present in the database has an ERROR severity but its fixup is not available.
    
    This will require a manual fix to the database.
    
    For further details, see the log file located at /u01/app/oracle/upgrade-jobs/CDB19/104/autoupgrade_20200121_user.log]
    
    ------------------------------------------------
    
    Logs: [/u01/app/oracle/upgrade-jobs/CDB19/104/autoupgrade_20200121_user.log]
    
    -----------------------------------------------
    
    upg>
    
    ```
    
    

17. In *Session2*, read the log file to examine the root cause of the error for `CDB19`.

    ```
    
    $ <copy>cat /u01/app/oracle/upgrade-jobs/CDB19/104/autoupgrade_20200121_user.log</copy>
    2020-01-21 11:06:03.663 INFO <b>Analyzing CDB19</b>, 176 checks will run using 8 threads
    2020-01-21 11:06:41.363 ERROR The following checks have ERROR severity and no fixup is available or
    the fixup failed to resolve the issue. Please <b>fix them manually before continuing:
    CDB19 MIN_RECOVERY_AREA_SIZE</b>
    2020-01-21 11:06:43.503 INFO Starting error management routine
    2020-01-21 11:06:43.504 INFO Ended error management routine
    2020-01-21 11:06:43.555 ERROR Error occurred while running the dispatcher for job 104
    Cause: One of the checks present in the database has an ERROR severity but its fixup is not available. This will require a manual fix to the database.
    </b>
    $
    
    ```

18. Still from *Session2*, increase the fast recovery area for `CDB19`.

    ```
    
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? <b>CDB19</b>
    The Oracle base has been set to /u01/app/oracle
    $ <copy>sqlplus / AS SYSDBA</copy>
    SQL*Plus: Release 19.0.0.0.0 - Production on Wed Jan 22 05:05:23 2020
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0
    
    SQL> <copy>SHOW PARAMETER db_recovery_file_dest_size</copy>
    
    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    db_recovery_file_dest_size           big integer 15000M
    SQL> <copy>ALTER SYSTEM SET db_recovery_file_dest_size=200000M SCOPE=BOTH;</copy>
    
    System altered.
    
    SQL> <copy>EXIT</copy>
    $
    
    ```

19. After fixing the issue, resume the job in the AutoUpgrade session.

    ```
    
    upg> <copy>resume -job 104</copy>
    Resuming job: [104][CDB19]
    upg> <copy>lsj</copy>
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    |Job#|DB_NAME|    STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|             MESSAGE|
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    | 100|   ORCL|PRECHECKS|  STOPPED|FINISHED|20/09/09 00:43|20/09/09 00:52|00:52:51|Ended database check|
    | 104|  CDB19|PRECHECKS|PREPARING| RUNNING|20/09/09 00:43|           N/A|00:43:19|                    |
    +----+-------+---------+---------+--------+--------------+--------------+--------+--------------------+
    Total jobs 2
    
    upg> 
    
    ```

  
  

  20. The AutoUpgrade may display another error while upgrading `CDB19`.

  
    ```
    
    upg> -------------------------------------------------
    
    Errors in database [CDB19]
    
    Stage     <b>[GRP]</b>
    
    Operation <b>[STOPPED]</b>
    
    Status    <b>[ERROR]</b>
    
    Info    [
    
    Error: UPG-2000
    
    [Unexpected exception error]
    
    Cause: Creation of GRP failed
    
    For further details, see the log file located at /u01/app/oracle/upgrade-jobs/CDB19/102/autoupgrade_20200128_user.log]
    
    -------------------------------------------------
    
    Logs: [/u01/app/oracle/upgrade-jobs/CDB19/102/autoupgrade_20200128_user.log]
    
    -------------------------------------------------
    
    upg>
    
    ```
    
    

    
21. In *Session2*, read the log file to examine the root cause of the error for `CDB19`.

    ```
    
    $ <copy>cat /u01/app/oracle/upgrade-jobs/CDB19/104/autoupgrade_20200121_user.log</copy>
    2020-01-28 01:49:26.416 INFO
    build.hash:b56ee62
    build.version:20.3.0
    build.date:2020/01/24 16:22:25
    build.max_target_version:20
    build.type:production
    build.label:HEAD
    
    2020-01-28 01:50:47.487 INFO Analyzing CDB19, 186 checks will run using 8 threads
    2020-01-28 01:51:30.133 INFO Guarantee Restore Point (GRP) successfully removed [CDB$ROOT][AUTOUPGRADE_221145114461854_CDB19]
    2020-01-28 01:51:41.153 ERROR There was a problem creating the GRP for CDB$ROOT
    2020-01-28 01:51:41.226 INFO Starting error management routine
    2020-01-28 01:51:41.226 INFO Ended error management routine
    2020-01-28 01:51:41.227 ERROR Error running dispatcher for job 102
    Cause: Creation of GRP failed
    $
    
    ```

22. Change the fast recovery area for `CDB21`. It was set to a non-writeable directory.

    ```
    
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? <b>CDB21</b>
    The Oracle base has been set to /u01/app/oracle
    $ <copy>sqlplus / AS SYSDBA</copy>
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to:
    
    SQL> <copy>SHOW PARAMETER db_recovery_file_dest</copy>
    
    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    db_recovery_file_dest                string      $HOME
    SQL> <copy>ALTER SYSTEM SET db_recovery_file_dest='/u03/app/oracle/fast_recovery_area' SCOPE=both;</copy>
    
    System altered.
    
    SQL> <copy>EXIT</copy>
    $
    
    ```

23. After fixing the issue, resume the job in the AutoUpgrade session.

  
  

24.  Suddenly, the AutoUpgrade displays an error while upgrading `ORCL`.

  
    ```
    
    upg> --------------------------------------------------------------------------------------------------
    
    Errors in database [ORCL]
    
    Stage     [DRAIN]
    
    Operation [STOPPED]
    
    Status    [ERROR]
    
    Info    [
    
    Error: UPG-3001
    
    java.sql.SQLException: Errors executing <b>[exec dbms_pdb.describe(pdb_descr_file => '/u01/app/oracle/upgrade-jobs/ORCL/103/drain/ORCL.xml');</b>
    
    Cause: <b>Could not describe the specified database</b>
    
    For further details, see the log file located at /u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200317_user.log]
    
    -------------------------------------------------
    
    Logs: [/u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200317_user.log]
    
    -------------------------------------------------
    
    upg>
    
    ```
    
    

    
25.  In Session2, test the command.

    ```
    
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? <b>ORCL</b>
    The Oracle base has been set to /u01/app/oracle
    $ <copy>sqlplus / AS SYSDBA</copy>
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to:
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Tue Mar 17 08:56:56 2020
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0
    
    SQL> <copy>exec dbms_pdb.describe(pdb_descr_file => '/u01/app/oracle/upgrade-jobs/ORCL/103/drain/ORCL.xml')</copy>
    
    PL/SQL procedure successfully completed.
    
    SQL> <copy>SHOW PARAMETER LOCAL</copy>
    
    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    local_listener                       string      LISTENER_ORCL
    parallel_force_local                 boolean     FALSE
    $
    
    ```

26. Set the `LOCAL_LISTENER` parameter to NULL.

    ```
    
    SQL> <copy>ALTER SYSTEM SET local_listener='' SCOPE=BOTH;</copy>
    
    System altered.
    
    SQL> <copy>EXIT</copy>
    $
    
    ```

27.  After fixing the issue, resume the job in the AutoUpgrade session.

  
  

28. Suddenly, the AutoUpgrade displays an error while upgrading `ORCL`.

  
    ```
    
    upg> -------------------------------------------------
    
    Errors in database [ORCL]</b>
    
    Stage     <b>[POSTCHECKS]</b>
    
    Operation <b>[STOPPED]</b>
    
    Status    [ERROR]
    
    Info    [
    
    Error: <b>UPG-1319</b>
    
    [Unexpected exception error]
    
    Cause: Loading the current state of the database failed
    
    For further details, see the log file located at /u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200317_user.log]
    
    -------------------------------------------------
    
    upg>
    
    ```
    
    

29.  In *Session2*, read the log file to examine the root cause of the error for `ORCL`.

    ```
    
    $ <copy>cat /u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200317_user.log</copy>
    ...
    $
    
    ```
    You don't find any informative details.

    - Check the state of the PDB `ORCL` in `CDB21`.

    ```
    
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? <b>CDB21</b>
    The Oracle base has been set to /u01/app/oracle
    $ <copy>sqlplus / AS SYSDBA</copy>
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to an idle instance.
    
    SQL> <copy>STARTUP</copy>
    ORACLE instance started.
    
    Total System Global Area 1426062784 bytes
    Fixed Size                  9567680 bytes
    Variable Size             553648128 bytes
    Database Buffers          855638016 bytes
    Redo Buffers                7208960 bytes
    Database mounted.
    Database opened.
    SQL> <copy>SHOW PDBS</copy>
    
        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 PDB20                          MOUNTED
             4 ORCL                           MOUNTED
    SQL> <copy>EXIT</copy>
    $
    
    ```
    The target database instance was shut down. The upgrade operation could not continue.

  
  

30.  The AutoUpgrade displays the following error.

  
    ```
    
    upg> -------------------------------------------------
    
    Errors in database [ORCL]
    
    Stage     <b>[NONCDBTOPDB]</b>
    
    Operation <b>[STOPPED]</b>
    
    Status    <b>[ERROR]</b>
    
    Info    [
    
    Error: UPG-3005
    
    <b>ORA-04031: unable to allocate  bytes of shared memory ("","","","")</b>
    
    Cause: Error running noncdb_to_pdb.sql script
    
    For further details, see the log file located at /u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200128_user.log]
    
    -------------------------------------------------
    
    Logs: [/u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200128_user.log]
    
    -------------------------------------------------
    
    upg>
    
    ```
    
    

    
31. In *Session2*, examine the log file.

    ```
    
    $ <copy>cat /u01/app/oracle/upgrade-jobs/ORCL/103/autoupgrade_20200128_user.log</copy>
    ...2020-01-28 03:43:22.101 INFO [Upgrading] is [93%] completed for [orcl-orcl]
    +---------+-------------+
    |CONTAINER|   PERCENTAGE|
    +---------+-------------+
    |     ORCL|UPGRADE [93%]|
    +---------+-------------+
    2020-01-28 03:44:57.898 ERROR
    DATABASE NAME: ORCL-ORCL
             CAUSE: ERROR at Line 771792 in [/u01/app/oracle/upgrade-jobs/ORCL/103/dbupgrade/catupgrd20200128014926orcl0.log]
            REASON: <b>ORA-04031: unable to allocate 41000 bytes of shared memory ("shared</b>
            ACTION: [MANUAL]
            DETAILS: <b>04031, 00000, "unable to allocate %s bytes of shared memory (\"%s\",\"%s\",\"%s\",\"%s\")"</b>
    // *Cause:  More shared memory is needed than was allocated in the shared
    //          pool or Streams pool.
    // *Action: If the shared pool is out of memory, either use the
    //          DBMS_SHARED_POOL package to pin large packages,
    //          reduce your use of shared memory, or <b>increase the amount of
    //          available shared memory by increasing the value of the
    //          initialization parameters SHARED_POOL_RESERVED_SIZE and
    //          SHARED_POOL_SIZE.</b>
    //          If the large pool is out of memory, <b>increase the initialization
    //          parameter LARGE_POOL_SIZE.</b>
    //          If the error is issued from an Oracle Streams or XStream process,
    //          increase the initialization parameter STREAMS_POOL_SIZE or increase
    //          the capture or apply parameter MAX_SGA_SIZE.
    ...
    $
    
    ```

32. Increase the `SGA_TARGET`.

    ```
    
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? <b>CDB21</b>
    The Oracle base has been set to /u01/app/oracle
    $ <copy>sqlplus / AS SYSDBA</copy>
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to:
    
    SQL> <copy>SHOW PARAMETER large_pool_size</copy>
    
    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    large_pool_size                      big integer 0
    SQL> <copy>SHOW PARAMETER shared_pool_size</copy>
    
    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    shared_pool_size                     big integer 0
    SQL> <copy>SHOW PARAMETER sga</copy>
    
    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    allow_group_access_to_sga            boolean     FALSE
    lock_sga                             boolean     FALSE
    pre_page_sga                         boolean     TRUE
    sga_max_size                         big integer 1088M
    sga_min_size                         big integer 0
    sga_target                           big integer 896M
    SQL> <copy>ALTER SYSTEM SET sga_max_size=3G SCOPE=spfile;</copy>
    
    System altered.
    
    SQL> <copy>ALTER SYSTEM SET sga_target='sga_max_size*80/100' SCOPE=spfile;</copy>
    
    System altered.
    
    SQL> <copy>SHUTDOWN IMMEDIATE</copy>
    Database closed.
    Database dismounted.
    ORACLE instance shut down.
    SQL> <copy>STARTUP</copy>
    ORACLE instance started.
    
    Total System Global Area 3221221472 bytes
    Fixed Size                  9572448 bytes
    Variable Size            1476395008 bytes
    Database Buffers         1728053248 bytes
    Redo Buffers                7200768 bytes
    Database mounted.
    Database opened.
    SQL> <copy>SHOW PDBS</copy>
    
        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 PDB20                          MOUNTED
             4 ORCL                           MOUNTED
    SQL> <copy>EXIT</copy>
    $
    
    ```

33. After fixing the issue, resume the job in the AutoUpgrade session.

  
  

34. The AutoUpgrade displays the following error.

  
    ```
    
    upg> "Database check with running exception"  (conName="CDB$ROOT",stage="PRECHECKS",checkName="UNIAUD_RECORDS_IN_FILE")
    
    -------------------------------------------------
    
    Errors in database [CDB19]
    
    Stage     [PRECHECKS]
    
    Operation [STOPPED]
    
    Status    [ERROR]
    
    Info    [
    
    Error: UPG-1316
    
    [Unexpected exception error]
    
    Cause: Error running database checks or fixups
    
    For further details, see the log file located at /u01/app/oracle/upgrade-jobs/CDB19/100/autoupgrade_20200318_user.log]
    
    -------------------------------------------------
    
    Logs: [/u01/app/oracle/upgrade-jobs/CDB19/100/autoupgrade_20200318_user.log]
    
    -------------------------------------------------
    
    upg>
    
    ```
    
    

    
    - Remove all audit OS files from `CDB19`.

    ```
    
    $ <copy>cd /u01/app/oracle/admin/CDB19/adump</copy>
    $ <copy>rm -rf *</copy>
    $ <copy>cd /u01/app/oracle/audit/CDB19</copy>
    $ <copy>rm -rf *</copy>
    $
    
    ```

35. After fixing the issue, resume the job in the AutoUpgrade session.

  
  

36. The AutoUpgrade displays the following error.

  
    ```
    
    upg> <copy>lsj</copy>
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|          MESSAGE|
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    
    | 110|   orcl| <b>POSTFIXUPS|  STOPPED|   ERROR</b>|20/09/10 04:14|           N/A|12:09:00|         UPG-1316|
    
    | 111|  CDB19|POSTUPGRADE|  STOPPED|FINISHED|20/09/10 04:15|20/09/10 14:56|14:56:20|Completed job 111|
    
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    
    Total jobs 2
    
    upg>
    
    ```
    
37. Find the error in the autoupgrade log for `ORCL`.

    ```
    
    $ <copy>cd /u01/app/oracle/upgrade-jobs/orcl/110</copy>
    $ <copy>vi autoupgrade_20200910_user.log</copy>
    ...
    2020-09-10 11:58:35.207 <b>ERROR There was a problem  executing TimeZone Upgrade [ORCL]</b>
    2020-09-10 11:58:35.208 <b>ERROR ExecutionException while running a TimeZone upgrade on a PDB {0}</b>
    2020-09-10 12:08:55.945 WARNING 1 fixups ran with errors, review the logs for further input, summary report available at <b>/u01/app/oracle/upgrade-jobs/orcl/110/postfixups/failed_postfixups.log</b>
    ...
    $
    
    ```
    ```
    
    $ <copy>vi /u01/app/oracle/upgrade-jobs/orcl/110/postfixups/failed_postfixups.log</copy>
    ORCL,OLD_TIME_ZONES_EXIST
    Check [/u01/app/oracle/upgrade-jobs/orcl/110/postfixups/postfixups_***.log] for more information
    $
    
    ```
    ```
    
    $ <copy>cd /u01/app/oracle/upgrade-jobs/orcl/temp</copy>
    $ <copy>ls -ltr</copy>
    ...
    -rwx------ 1 oracle oinstall   878 Sep 10 04:11 before_upgrade_pfile_orcl.ora
    -rwx------ 1 oracle oinstall   878 Sep 10 04:11 after_upgrade_pfile_orcl.ora
    -rwx------ 1 oracle oinstall   904 Sep 10 04:18 during_upgrade_pfile_orcl.ora
    -rwx------ 1 oracle oinstall  6275 Sep 10 04:20 ctx_move_text_file_list_orcl
    -rwx------ 1 oracle oinstall   554 Sep 10 04:30 createpdb_orcl_ORCL.sql
    -rwx------ 1 oracle oinstall     0 Sep 10 04:43 orcl_orcl.restart
    -rwx------ 1 oracle oinstall   883 Sep 10 10:57 orcl_objcompare.sql
    -rwx------ 1 oracle oinstall  2240 Sep 10 10:57 orcl_autocompile.sql
    -rwx------ 1 oracle oinstall   214 Sep 10 11:08 sqlsessstart.sql
    -rwx------ 1 oracle oinstall 33800 Sep 10 11:08 <b>orcl_utltz_upg_check.sql</b>
    -rwx------ 1 oracle oinstall   213 Sep 10 11:08 sqlsessend.sql
    -rwx------ 1 oracle oinstall 21307 Sep 10 11:08 <b>orcl_utltz_upg_apply.sql</b>
    ...
    $
    
    ```

38. Connect to `ORCL` in `CDB21` and execute the `orcl_utltz_upg_check.sql` SQL script.

    ```
    
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? <b>CDB21</b>
    The Oracle base has been set to /u01/app/oracle
    $ <copy>sqlplus sys@ORCL AS SYSDBA</copy>
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to:
    
    SQL> <copy>@orcl_utltz_upg_check.sql</copy>
    
    Session altered.
    
    INFO: If an ERROR occurs, the script will EXIT SQL*Plus.
    INFO: The database RDBMS DST version will be updated to DSTv35 .
    INFO: This database is a Multitenant database.
    INFO: This database is a PDB.
    INFO: Current PDB is ORCL .
    WARNING: This script will restart the database 2 times
    WARNING: WITHOUT asking ANY confirmation.
    WARNING: Hit control-c NOW if this is not intended.
    INFO: Restarting the database in UPGRADE mode to start the DST upgrade.
    Pluggable Database closed.
    Pluggable Database opened.
    INFO: Starting the RDBMS DST upgrade.
    INFO: Upgrading all SYS owned TSTZ data.
    INFO: It might take time before any further output is seen ...
    An upgrade window has been successfully started.
    INFO: Restarting the database in NORMAL mode to upgrade non-SYS TSTZ data.
    Pluggable Database closed.
    ORA-44787: Service cannot be switched into.
    
    
    INFO: Upgrading all non-SYS TSTZ data.
    INFO: It might take time before any further output is seen ...
    INFO: Do NOT start any application yet that uses TSTZ data!
    INFO: Next is a list of all upgraded tables:
    Table list: "GSMADMIN_INTERNAL"."AQ$_CHANGE_LOG_QUEUE_TABLE_S"
    Number of failures: 0
    Table list: "GSMADMIN_INTERNAL"."AQ$_CHANGE_LOG_QUEUE_TABLE_L"
    Number of failures: 0
    Table list: "MDSYS"."SDO_DIAG_MESSAGES_TABLE"
    Number of failures: 0
    Table list: "DVSYS"."AUDIT_TRAIL$"
    Number of failures: 0
    Table list: "DVSYS"."SIMULATION_LOG$"
    Number of failures: 0
    INFO: Total failures during update of TSTZ data: 0 .
    An upgrade window has been successfully ended.
    INFO: Your new Server RDBMS DST version is DSTv35 .
    INFO: The RDBMS DST update is successfully finished.
    INFO: Make sure to exit this SQL*Plus session.
    INFO: Do not use it for timezone related selects.
    
    Session altered.
    
    SQL> <copy>EXIT</copy>
    $
    
    ```

39. Execute the `orcl_utltz_upg_apply.sql` SQL script.

    ```
    
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? <b>CDB21</b>
    The Oracle base has been set to /u01/app/oracle
    $ <copy>sqlplus sys@ORCL AS SYSDBA</copy>
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Connected to:
    
    SQL> <copy>@orcl_utltz_upg_apply.sql</copy>
    
    Session altered.
    
    INFO: Starting with RDBMS DST update preparation.
    INFO: NO actual RDBMS DST update will be done by this script.
    INFO: If an ERROR occurs the script will EXIT sqlplus.
    INFO: Doing checks for known issues ...
    INFO: Database version is 21.0.0.0 .
    INFO: This database is a Multitenant database.
    INFO: This database is a PDB.
    INFO: Current PDB is ORCL .
    INFO: Database RDBMS DST version is DSTv32 .
    INFO: No known issues detected.
    INFO: Now detecting new RDBMS DST version.
    A prepare window has been successfully started.
    INFO: Newest RDBMS DST version detected is DSTv35 .
    INFO: Next step is checking all TSTZ data.
    INFO: It might take a while before any further output is seen ...
    A prepare window has been successfully ended.
    INFO: A newer RDBMS DST version than the one currently used is found.
    INFO: Note that NO DST update was yet done.
    INFO: Now run utltz_upg_apply.sql to do the actual RDBMS DST update.
    INFO: Note that the utltz_upg_apply.sql script will
    INFO: restart the database 2 times WITHOUT any confirmation or prompt.
    
    Session altered.
    
    SQL> <copy>EXIT</copy>
    $
    
    ```

  40. After fixing the issue, resume the job in the AutoUpgrade session. The execution of the failed postfixups scripts helps the next operation to execute and finally complete the job successfully.

    ```
    
    upg> <copy>resume -job 110</copy>
    Resuming job: [110][orcl]
    upg> <copy>lsj</copy>
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|             MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    | 110|   orcl| POSTFIXUPS|EXECUTING| RUNNING|20/09/10 04:14|           N/A|04:18:48|Loading database inf|
    | 111|  CDB19|POSTUPGRADE|  STOPPED|FINISHED|20/09/10 04:15|20/09/10 14:56|14:56:20|   Completed job 111|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+--------------------+
    Total jobs 2
    
    upg> <copy>lsj</copy>
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|          MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    | 110|   orcl|<b>NONCDBTOPDB|EXECUTING| RUNNING</b>|20/09/10 04:14|           N/A|04:27:04|noncdb_to_pdb.sql|
    | 111|  CDB19|POSTUPGRADE|  STOPPED|FINISHED|20/09/10 04:15|20/09/10 14:56|14:56:20|Completed job 111|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    Total jobs 2
    
    upg> Job 110 completed
    lsj
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    |Job#|DB_NAME|      STAGE|OPERATION|  STATUS|    START_TIME|      END_TIME| UPDATED|          MESSAGE|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    | 110|   orcl|NONCDBTOPDB|  STOPPED|FINISHED|20/09/10 04:14|20/09/11 04:44|04:44:34|<b>Completed job 110</b>|
    | 111|  CDB19|POSTUPGRADE|  STOPPED|FINISHED|20/09/10 04:15|20/09/10 14:56|14:56:20|Completed job 111|
    +----+-------+-----------+---------+--------+--------------+--------------+--------+-----------------+
    Total jobs 2
    
    upg> ------------------- Final Summary --------------------
    Number of databases            [ 2 ]
    
    Jobs finished successfully     [2]
    Jobs failed                    [0]
    Jobs pending                   [0]
    ------------- JOBS FINISHED SUCCESSFULLY -------------
    Job 110 for orcl
    Job 111 for CDB19
    
    ---- Drop GRP at your convenience once you consider it is no longer needed ----
    Drop GRP from CDB19: drop restore point AUTOUPGRADE_9212_CDB19193000
    
    upg>
    
    ```

  
  

## **STEP 5:** Abort and restart upgrade operations

You may have to abort a running AutoUpgrade operation to restart a new upgrade operation. For example, you tested non-CDB and CDBs upgrade, but after too numerous errors, you decided to re-create the test non-CDB and CDBs and start a new upgrade operation.

1. Launch the AutoUpgrade.

  
    ```
    
    $ <copy>cd $ORACLE_HOME/rdbms/admin</copy>
    
    $ <copy>java -jar autoupgrade.jar -config /home/oracle/labs/M104786GC10/config.txt -mode analyze -console</copy>
    
    Previous execution found loading latest data
    
    Total jobs recovered: 2
    
    +--------------------------------+
    
    | Starting AutoUpgrade execution |
    
    +--------------------------------+
    
    Type 'help' to list console commands
    
    -------------------------------------------------
    
    Errors in database <b>[CDB19]</b>
    
    Stage     <b>[DBUPGRADE]</b>
    
    Operation [STOPPED]
    
    Status    <b>[ERROR]</b>
    
    Info    [
    
    Error: UPG-1401
    
    Opening Database CDB19 in upgrade mode failed
    
    Cause: Opening database for upgrade in the target home failed
    
    For further details, see the log file located at /u01/app/oracle/upgrade-jobs/CDB19/102/autoupgrade_20200317_user.log]
    
    -------------------------------------------------
    
    Logs: [/u01/app/oracle/upgrade-jobs/CDB19/102/autoupgrade_20200317_user.log]
    
    -------------------------------------------------
    
    upg> lsj
    
    +----+-------+----------+---------+-------+--------------+--------+--------+--------------------+
    
    |Job#|DB_NAME|     STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|             MESSAGE|
    
    +----+-------+----------+---------+-------+--------------+--------+--------+--------------------+
    
    | 102|  CDB19| DBUPGRADE|  <b>STOPPED|  ERROR</b>|20/03/17 08:36|     N/A|02:14:41|            UPG-1401|
    
    | 103|   ORCL|POSTCHECKS|PREPARING|RUNNING|20/03/17 08:37|     N/A|02:14:13|Loading database inf|
    
    +----+-------+----------+---------+-------+--------------+--------+--------+--------------------+
    
    Total jobs 2
    
    upg> <copy>abort -job 102</copy>
    
    The command cannot be executed because job 102 is already in a stopped state
    
    upg> <copy>abort -job 103</copy>
    
    Are you sure you want to abort job [103] ? [y|N] <b>y</b>
    
    Abort job: [103][ORCL]
    
    upg>
    
    ```

2. Display the abort queue.

  
    ```
    
    upg> <copy>lsa</copy>
    
    +----+--------+
    
    |Job#|  STATUS|
    
    +----+--------+
    
    | 103|FINISHED|
    
    +----+--------+
    
    Total 1
    
    upg> <copy>lsj</copy>
    
    +----+-------+----------+---------+-------+--------------+--------------+--------+--------+
    
    |Job#|DB_NAME|     STAGE|OPERATION| STATUS|    START_TIME|      END_TIME| UPDATED| MESSAGE|
    
    +----+-------+----------+---------+-------+--------------+--------------+--------+--------+
    
    | 102|  CDB19| DBUPGRADE|  STOPPED|  ERROR|20/03/17 08:36|           N/A|02:16:20|UPG-1401|
    
    | 103|   ORCL|POSTFIXUPS|  STOPPED|ABORTED|20/03/17 08:37|20/03/18 02:32|02:32:09|        |
    
    +----+-------+----------+---------+-------+--------------+--------------+--------+--------+
    
    Total jobs 2
    
    upg>
    
    ```

3. Displays the running jobs only.

    
    ```
    
    upg> <copy>lsj -r</copy>
    
    +----+-------+-----+---------+------+----------+--------+-------+-------+
    
    |Job#|DB_NAME|STAGE|OPERATION|STATUS|START_TIME|END_TIME|UPDATED|MESSAGE|
    
    +----+-------+-----+---------+------+----------+--------+-------+-------+
    
    +----+-------+-----+---------+------+----------+--------+-------+-------+
    
    Total jobs 0
    
    upg> <copy>exit</copy>
    
    There is 1 job in progress. if you exit it will stop
    
    Are you sure you wish to leave? [y|N] <b>y</b>
    
    ------------------- Final Summary --------------------
    
    Number of databases            [ 2 ]
    
    Jobs finished successfully     [0]
    
    Jobs failed                    [1]
    
    Jobs pending                   [0]
    
    -------------------- JOBS FAILED ---------------------
    
    Job 102 for CDB19
    
    Exiting
    
    $
    
    ```

## **STEP 6:** Clean up directories

1.  If you plan to use the same log directories, clean up the log files in the directories defined in the configuration file.

  
    ```
    
    $ <copy>cat /home/oracle/labs/M104786GC10/config.txt</copy>
    
    #
    
    # Global parameters
    
    #
    
    global.autoupg_log_dir=/home/oracle/labs/AutoUpgrade
    
    #
    
    # Database CDB19
    
    #
    
    CDB19.source_home=/u01/app/oracle/product/19.3.0/dbhome_1
    
    CDB19.target_home=/u01/app/oracle/product/20.2.0/dbhome_1
    
    CDB19.sid=CDB19
    
    CDB19.log_dir=/u01/app/oracle/upgrade-jobs
    
    CDB19.pdbs=PDB19
    
    CDB19.restoration=yes
    
    #
    
    # Database ORCL
    
    #
    
    ORCL.source_home=/u01/app/oracle/product/19.3.0/dbhome_1
    
    ORCL.target_home=/u01/app/oracle/product/20.2.0/dbhome_1
    
    ORCL.sid=ORCL
    
    ORCL.target_cdb=CDB21
    
    ORCL.log_dir=/u01/app/oracle/upgrade-jobs
    
    ORCL.restoration=yes
    
    $ <copy>cd /home/oracle/labs/AutoUpgrade</copy>
    
    $ <copy>rm -rf *</copy>
    
    $ <copy>cd /u01/app/oracle/upgrade-jobs</copy>
    
    $ <copy>ls</copy>
    
    CDB19  ORCL
    
    $ <copy>rm -rf *</copy>
    
    $
    
    ```

You may now [proceed to the next lab](#next).


## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  Kay Malcolm, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
