# Use Recovery Manager (RMAN) to Connect to a PDB to Use the Recovery Catalog

## Introduction

Estimated Lab Time: 15 minutes

### Objectives

Learn how to do the following:

- Use RMAN to connect to `PDB1` and `PDB2` to make use of the recovery catalog to backup `PDB19`.
- Create catalog owner and grant privileges.
- Backup PDB1.
- Revoke privileges and drop the catalog.


### Prerequisites

Be sure that the following tasks are completed before you start:

- Lab 4 completed.
- Oracle Database 19c installed.
- A database, either non-CDB or CDB with a PDB.
- If not downloaded, download 19cNewFeatures.zip 



## **STEP 1**: Prepare environment
1. Execute the **/home/oracle/labs/admin/cleanup_PDBs.sh** shell script. The shell script drops all PDBs that may have been created by any of the practices in **CDB1**, and finally re-creates **PDB1**.
   
    ```
    $ /home/oracle/labs/admin/cleanup_PDBs.sh
    ``` 

2. Execute the **/home/oracle/labs/HA/create_PDB2.sh** shell script, this will create **PDB2** in the **CDB1** container. **PDB2** will be the database we are backing up.
   
    ```
    $/home/oracle/labs/HA/create_PDB2.sh
    ```

3.  Execute the **/home/oracle/labs/HA/create_PDB19.sh** shell script. this will create **PDB19** in the **CDB1** container. **PDB19** will be the recovery catalog PDB.
   
    ```
    $ /home/oracle/labsHA/create_PDB19.sh
    ```
4. Execute the **/home/oracle/labs/HA/glogin.sh** shell script. This will set the formatting for all columns selected in queries.

    ```
    $ /home/oracle/labs/HA/glogin.sh
    ```

## **STEP 2**: Create catalog owner and grant privileges 
1. To be able to connect to the recovery catalog and to PDB1 as the target database, create a virtual private RMAN catalog (VPC) in PDB19 for groups of databases and users of **CDB1**, **PDB1**, and **PDB2**.
 
2. Create the catalog owner in **PDB19**. 
    ```
    $ sqlplus system@PDB19

    Enter password : <password>
    ```

    ```
    SQL> CREATE USER catowner IDENTIFIED BY <password>;

    user created.
    ```

    ```
    SQL> GRANT create session, recovery_catalog_owner, unlimited tablespace TO catowner; 

    Grant succeeded.
    ```

    ```
    SQL> EXIT
    ```
2. Create the RMAN base catalog catowner@PDB19.
    ```
    $ rman

    RMAN> CONNECT CATALOG catowner@PDB19

    recovery catalog database Password: <password>
    connected to recovery catalog database
    ```

    ```
    RMAN> CREATE CATALOG;

    recovery catalog created
    ```

    ```
    RMAN> EXIT;
    ```
3. Register **CDB1** in the catalog.
    ```
    $ rman target / catalog catowner@PDB19

    connected to target database: CDB1 (DBID=1042926509)
    recovery catalog database Password: <password>
    connected to recovery catalog database
    ```

    ```
    RMAN> REGISTER DATABASE;

    database registered in recovery catalog
    starting full resync of recovery catalog
    full resync complete
    ```

    ```
    RMAN> EXIT
    ```
4. Execute **$ORACLE_HOME/rdms/admin/dbmsrmanvpc.sql** after connecting to the catalog as **SYS** to grant VPD-required privileges to the base catalog owner.
    ```
    $ sqlplus sys@PDB19 AS SYSDBA

    Enter password: oracle
    ```

    ```
    SQL> @$ORACLE_HOME/rdms/admin/dbmsrmanvpc.sql -vpd catowner

    checking the operating user... Passed

    Granting VPD privileges to the owner of the base catalog schema CATOWNER

    ==============================
    VPD SETUP STATUS:
    VPD privileges granted successfully!
    Connect to RMAN base catalog and perform UPGRADE CATALOG.
    ```
5. Reconnect to the RMAN base catalog and perform **UPGRADE CATALOG**.
    ```
    $ rman

    RMAN> CONNECT CATALOG catowner@PDB19

    recovery catalog database Password: password
    connected to recovery catalog database
    ```
    
    ```
    RMAN> UPGRADE CATALOG

    recovery catalog owner is CATOWNER
    enter UPGRADE CATALOG command again to confirm catalog upgrade
    ```

    ```
    RMAN> UPGRADE CATALOG;

    recovery catalog upgraded to version 19.10.00.00.00
    DBMS_RCVMAN package upgraded to version 19.10.00.00
    DBMS_RCVCAT package upgraded to version 19.10.00.00.
    ```

        
## **STEP 3**: Create VPC users
1. Create the VPC users, **vpc\_pdb1** and **vpc\_pdb2**, in the catalog. They will be given access to the metadata of **PDB1** and **PDB2**, respectively.
    ```
    $ sqlplus system@PDB19
    Enter password: oracle
    ```

    ```
    SQL> CREATE USER vpc_pdb1 IDENTIFIED BY <password>;

    User created.
    ```

    ```
    SQL> CREATE USER vpc_pdb2 IDENTIFIED BY <password>;

    User created.
    ```

    ```
    GRANT create session TO vpc_pdb1, vpc_pdb2;

    Grant succeeded.
    ```

    ```
    SQL> EXIT
    ```
2. As the base catalog owner, give the VPC users access to the metadata of **PDB1** and **PDB2**, respectively.
    ```
    $rman 

    RMAN> CONNECT CATALOG catowner@PDB19

    recovery catalog database Password: <password>
    connected to recovery catalog database
    ```

    ```
    RMAN> GRANT CATALOG FOR PLUGGABLE DATABASE pdb1 TO vpc_pdb1;

    Grant succeeded.
    ```

    ```
    RMAN> GRANT CATALOG FOR PLUGGABLE DATABASE pdb2 TO vpc_pdb2;

    Grant succeeded.
    ```

    ```
    RMAN> EXIT
    ```
## **STEP 4**: Backup **PDB1**
1. Connect to the **PDB1** target PDB and to the recovery catalog as the **VPC_PDB1** user to back up and restore the **PDB1** target PDB.

    ```
    $rman TARGET sys@PDB1 CATALOG vpc_pdb1@PDB19

    target database Password: <password>
    connected to target database: ORCL:PDB1 (DBID=4095280305)
    recovery catalog database Password: <password>
    connected to recovery catalog database
    ```

    ```
    RMAN> BACKUP DATABASE;

    Starting backup at 03-JUN-21
    allocated channel: ORA_DISK_1
    channel ORA_DISK_1: SID=144 device type=DISK
    channel ORA_DISK_1: starting full datafile backup set
    channel ORA_DISK_1: specifying datafile(s) in backup set
    input datafile file number=00017 name=/u01/app/oracle/oradata/CDB1/pdb1/CDB1/C3BA5E8EA41E0AAEE0530C00000A17E8/datafile/o1_mf_sysaux_jcf2oz64_.dbf
    input datafile file number=00016 name=/u01/app/oracle/oradata/CDB1/pdb1/CDB1/C3BA5E8EA41E0AAEE0530C00000A17E8/datafile/o1_mf_system_jcf2oz5v_.dbf
    input datafile file number=00018 name=/u01/app/oracle/oradata/CDB1/pdb1/CDB1/C3BA5E8EA41E0AAEE0530C00000A17E8/datafile/o1_mf_undotbs1_jcf2oz68_.dbf
    channel ORA_DISK_1: starting piece 1 at 03-JUN-21
    channel ORA_DISK_1: finished piece 1 at 03-JUN-21
    piece handle=/u01/app/oracle/oradata/CDB1/pdb1/0200gce1_2_1_1 tag=TAG20210603T184728 comment=NONE
    channel ORA_DISK_1: backup set complete, elapsed time: 00:00:15
    Finished backup at 03-JUN-21
    ```
    
    ```
    RMAN> EXIT
    ```

2. Backups can only be performed by users with sufficient privileges, as an excercise, try to backup **PDB1** as user **vpc_pdb2**.
    ```
    $ rman TARGET sys@PDB1 CATALOG vpc_pdb2@PDB19

    target database Password: <password>
    connected to target database: CDB1:PDB1 (DBID=690853089)
    recovery catalog database Password: <password>
    connected to recovery catalog database
    ```

    ```
    RMAN> BACKUP DATABASE;

    Starting backup at 03-JUN-21
    RMAN-00571: ===========================================================
    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
    RMAN-00571: ===========================================================
    RMAN-03002: failure of backup command at 06/03/2021 19:21:08
    RMAN-03014: implicit resync of recovery catalog failed
    RMAN-06428: recovery catalog is not installed
    ```
3. Retrieve the tag value from the **BACKUP DATABASE;** from **#1's** output and insert it into the following query.
    ```
    $ sqlplus catowner@PDB19
    Enter password: <password>
    ```

    ```
    SQL> SELECT handle FROM rc_backup_piece WHERE tag = '<insert tag number>';
    ```
4. Once the handle value has been retrieved, exit **SQL*Plus**
   
    ```
    SQL> EXIT
    ```

## **STEP 5**: Revoke privileges and drop the catalog
1. Connect as the catalog owner and revoke the **CATALOG FOR PLUGGABLE DATABASE** privilege on **PDB1** and **PDB2** from the VPC Users.
    ```
    $ rman CATALOG catowner@PDB19

    recovery catalog database Password: <password>
    connected to recovery catalog database
    ```

    ```
    RMAN> REVOKE CATALOG FOR PLUGGABLE DATABASE pdb1 FROM vpc_pdb1;

    Revoke succeeded.
    ```

    ```
    RMAN> REVOKE CATALOG FOR PLUGGABLE DATABASE pdb2  FROM vpc_pdb2;

    Revoke succeeded.

    ```
    RMAN> EXIT
    ```
2. Verify that the **VPC_PDB1** user cannot back up the **PDB1** target PDB via the recovery catalog.
    ```
    $rman TARGET sys@PDB1 CATALOG vpc_pdb1@PDB19

    target database Password: 
    connected to target database: CDB1:PDB1 (DBID=690853089)
    recovery catalog database Password: 
    connected to recovery catalog database
    ```

    ```
    RMAN> backup database;

    Starting backup at 03-JUN-21
    RMAN-00571: ===========================================================
    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
    RMAN-00571: ===========================================================
    RMAN-03002: failure of backup command at 06/03/2021 20:31:37
    RMAN-03014: implicit resync of recovery catalog failed
    RMAN-06428: recovery catalog is not installed
    ```

    ```
    RMAN> EXIT
    ```
3. Drop the recovery catalog in **PDB19**
    ```
    $ rman CATALOG catowner@PDB19

    recovery catalog database Password: password
    connected to recovery catalog database
    ```

    ```
    RMAN> DROP CATALOG;

    recovery catalog owner is CATOWNER
    enter DROP CATALOG command again to confirm catalog removal

    ```
    RMAN> DROP CATALOG;

    recovery catalog dropped

    ```
    RMAN> EXIT
    ```


## Learn More

- [New Features in Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)

## Acknowledgements

* **Author**- Dominique Jeunot, Consulting User Assistance Developer
* **Last Updated By/Date** - Matthew McDaniel, Austin Specialists Hub, June 2021
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in
