# Explore Automatic Deletion of Flashback Logs

## Introduction

Estimated Lab Time: x minutes

### Objectives

Learn how to do the following:

- Verify that **CDB1** is in **FLASHBACK** mode.
- Increase **FRA** size
- Generate flashback logs



### Prerequisites

Be sure that the following tasks are completed before you start:

- Lab 4 completed.
- Oracle Database 19c installed
- A database, either non-CDB or CDB with a PDB.


## **STEP 1**: Verify that **CDB1** is in **FLASHBACK** mode

1. Berify that **CDB1** is in **FLASHBACK** mode and display the flashback retention period. If the database is not in flashback mode, execute the **/home/oracle/labs/admin/flashback.sql** script.

    ```
    $ sqlplus / AS SYSDBA
    ```

    ```
    SQL> SELECT flashback_on FROM v$database;

    FLASHBACK_ON
    ------------------
    NO
    ```

    ```
    SQL> @/home/oracle/labs/admin/flashback_on.sql
    ```

    ```
    SQL> SELECT flashback_on FROM v$database;

    FLASHBACK_ON
    ------------------
    YES 
    ```

    ```
    SQL> SHOW PARAMETER db_flashback_retention_target

    NAME                             TYPE        VALUE
    -------------------------------- ----------- ------------------
    db_flashback_retention_target    integer     70
    ```
    >**NOTE**: The flashback retention period is set to 70 minutes.
## **STEP 2**: Increase **FRA** size

1. Increase FRA size to ensure that there will be no space pressure that would automatically delete flashback logs.
    
    ```
    SQL> ALTER SYSTEM SET db_recovery_file_dest_dize=100G;

    System altered;
    ```
    >**NOTE**: Flashback logs beyond the retention period are proactively deleted without degrading the flashback performance and before there is space pressure. The number of flashback logs remains the same after decreasing the flashback retention.

    ```
    SQL> HOST

    $ cd /u01/app/oracle/fast_recovery_area/CDB1/flashback

    $ls -l
    ```

2. In another terminal window, execute **/home/oracle/labs/HA/workload.sh** to generate flashback logs. This script takes a long time to complete.

    ```
    $ /home/oracle/labs/HA/workload.sh
    ```
## **STEP 3**: View flashback logs
1. Back in the initial terminal session, check the flashback logs in the FRA after 30 min`utes. 
    ```
    $ ls -ltr /u01/app/oracle/fast_recovery_area/CDB1/

    -rw-r-----. 1 oracle dba  209723392 Jun 10 14:52 o1_mf_jd49pwwp_.flb
    -rw-r-----. 1 oracle dba  209723392 Jun 10 14:52 o1_mf_jd49q0q4_.flb
    -rw-r-----. 1 oracle dba  209723392 Jun 10 14:53 o1_mf_jd49t04k_.flb
    -rw-r-----. 1 oracle dba  209723392 Jun 10 14:53 o1_mf_jd49tbw2_.flb
    -rw-r-----. 1 oracle dba  209723392 Jun 10 14:53 o1_mf_jd49top4_.flb
    -rw-r-----. 1 oracle dba  209723392 Jun 10 14:53 o1_mf_jd49v0tw_.flb
    -rw-r-----. 1 oracle dba  209723392 Jun 10 14:53 o1_mf_jd49vgjy_.flb
    -rw-r-----. 1 oracle dba  209723392 Jun 10 14:54 o1_mf_jd49vvrr_.flb
    -rw-r-----. 1 oracle dba  419438592 Jun 10 14:54 o1_mf_jd49w4mm_.flb
    -rw-r-----. 1 oracle dba  838868992 Jun 10 14:56 o1_mf_jd49wq1o_.flb
    -rw-r-----. 1 oracle dba 1894842368 Jun 10 14:57 o1_mf_jd4b1qpp_.flb
    -rw-r-----. 1 oracle dba 1677729792 Jun 10 15:01 o1_mf_jd49xlhh_.flb
    ```

2. Decrease the flashback retention period to 60 minutes. From the time you decrease the flashback retention period, you will observe that the list of flashback logs will remain stable and not increase any more. 

    ```
    SQL> ALTER SYSTEM SET DB_FLASHBACK_RETENTION_TARGET=60;

    System altered.

    SQL> EXIT;
    ```
3. When you are done viewing the flashback logs and the script hasn't completed, run the following command.

    ```
    $ pgrep -lf workload
    <pid> workload.sh

    $ kill -9 <pid>
    ```



## Learn More

- [Text](link)
- [Text](link)


## Acknowledgements

- **Author**- Your Name, Your Title
- **Last Updated By/Date** - Your Name, Team name, Month Day 2021
