# SYSLOG Destination for Common Unified Audit Policies

## Introduction
This lab shows how to enable all audit records from common unified audit policies to be consolidated into a single destination. The new initialization parameter used for the configuration is supported only on UNIX platforms and NOT available on Windows.

Estimated Lab Time: 20 minutes

### Objectives
In this lab, you will:
* Create a common user
* Create a common and local audit policy
* Configure the SYSLOG destination
* Define the OS directories
* Test and Cleanup

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Create a common user

1. Before configuring the `SYSLOG` destination for common unified audit policies to be consolidated into a single destination, execute the `/home/oracle/labs/M104781GC10/setup_SYSLOG_audit.sh` shell script against `CDB21`. The shell script creates a common user `C##TEST` and commonly grants the common user the `CREATE SESSION` and `CREATE TABLE` privileges..  

  
    ```
    
    $ <copy>cd /home/oracle/labs/M104781GC10</copy>
    
    $ <copy>/home/oracle/labs/M104781GC10/setup_SYSLOG_audit.sh</copy>
    
    Connected to:
    
    Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production
    
    Version 21.2.0.0.0
    
    SQL> shutdown abort
    
    ORACLE instance shut down.
    
    SQL> exit
    
    ...
  
    /usr/bin/ar cr /u01/app/oracle/product/21.2.0/dbhome_1/rdbms/lib/libknlopt.a /u01/app/oracle/product/21.2.0/dbhome_1/rdbms/lib/kzaiang.o
    
    chmod 755 /u01/app/oracle/product/21.2.0/dbhome_1/bin
    
    - Linking Oracle
    
    rm -f /u01/app/oracle/product/21.2.0/dbhome_1/rdbms/lib/oracle
    
    ...
    
    SQL> STARTUP
    
    ...
    
    SQL> CREATE USER c##test IDENTIFIED BY <i>WElcome123##</i> CONTAINER=ALL;
    
    User created.
    
    SQL> GRANT CREATE SESSION, CREATE TABLE, UNLIMITED TABLESPACE TO c##test CONTAINER=ALL;
    
    Grant succeeded.
    
    SQL> EXIT
    
    $
    
    ```

## **STEP 2:** Create a common and local audit policy

1. Create the common audit policy at the CDB root in `CDB21`.

  
    ```
    
    $ <copy>sqlplus / AS SYSDBA</copy>
    
    Connected.
    
    SQL> <copy>CREATE AUDIT POLICY pol_common ACTIONS create table CONTAINER=ALL;</copy>
    
    Audit policy created.
    
    SQL> <copy>AUDIT POLICY pol_common;</copy>
    
    Audit succeeded.
    
    SQL> <copy>CREATE AUDIT POLICY pol_root ACTIONS insert;</copy>
    
    Audit policy created.
    
    SQL> <copy>AUDIT POLICY pol_root;</copy>
    
    Audit succeeded.
    
    SQL> <copy>COL policy_name FORMAT A18</copy>
    
    SQL> <copy>COL audit_option FORMAT A18</copy>
    
    SQL> <copy>SELECT policy_name, audit_option, common
    
          FROM AUDIT_UNIFIED_POLICIES  
    
          WHERE policy_name like 'POL%'; </copy>
    
    POLICY_NAME        AUDIT_OPTION       COM
    
    ------------------ ------------------ ---
    
    POL_COMMON         CREATE TABLE       YES
    
    POL_ROOT           INSERT             NO
    
    SQL>
    
    ```

2. Create the local audit policy at the PDB level in `PDB21`.

  
    ```
    
    SQL> <copy>CONNECT system@PDB21</copy>
    
    Enter password: <i><copy>password</copy></i>
    
    Connected.
    
    SQL> <copy>CREATE AUDIT POLICY pol_pdb21 ACTIONS select;</copy>
    
    Audit policy created.
    
    SQL> <copy>AUDIT POLICY pol_pdb21;</copy>
    
    Audit succeeded.
    
    SQL>
    
    ```

3. Display the policy names, their actions and commonality.

  
    ```
    
    SQL> <copy>COL policy_name FORMAT A18</copy>
    
    SQL> <copy>COL audit_option FORMAT A18</copy>
    
    SQL> <copy>SELECT policy_name, audit_option, common
    
          FROM AUDIT_UNIFIED_POLICIES  
    
          WHERE policy_name like 'POL%';</copy> 
    
    POLICY_NAME        AUDIT_OPTION       COM
    
    ------------------ ------------------ ---
    
    POL_COMMON         CREATE TABLE       YES
    
    POL_PDB21          SELECT             NO
    
    SQL>
    
    ```

## **STEP 3:** Configure the SYSLOG destination for common and local audit policies

1. Configure the `SYSLOG` destination for common unified audit policies to be consolidated into a single destination. The `facility_clause` refers to the facility to which you will write the audit trail records. Valid choices are `USER` and `LOCAL`. If you enter `LOCAL`, then optionally append 0–7 to designate a local custom facility for the `SYSLOG` records. `priority_clause` refers to the type of warning in which to categorize the record. Valid choices are `NOTICE`, `INFO`, `DEBUG`, `WARNING`, `ERR`,`CRIT` , `ALERT`, and `EMERG`. 

  
    ```
    
    SQL> <copy>CONNECT / AS SYSDBA</copy>
    
    Connected.
    
    SQL> <copy>ALTER SYSTEM SET UNIFIED_AUDIT_COMMON_SYSTEMLOG='local0.info' SCOPE=SPFILE;</copy>
    
    System altered.
    
    SQL>
    
    ```

2. Configure the `SYSLOG` destination for local unified audit policies to be consolidated into a single destination.

  
    ```
    
    SQL> <copy>CONNECT sys@PDB21 AS SYSDBA</copy>
    
    Enter password: <i><copy>password</copy></i>
    
    Connected.
    
    SQL> <copy>ALTER SYSTEM SET UNIFIED_AUDIT_COMMON_SYSTEMLOG='local1.warning' SCOPE=SPFILE;</copy>
    
    ALTER SYSTEM SET UNIFIED_AUDIT_COMMON_SYSTEMLOG='local1.warning'  SCOPE=SPFILE
    
    *
    
    ERROR at line 1:
    
    ORA-65040: operation not allowed from within a pluggable database
    
    SQL> <copy>CONNECT / AS SYSDBA</copy>
    
    Connected.
    
    SQL> <copy>ALTER SYSTEM SET UNIFIED_AUDIT_SYSTEMLOG='local1.warning' SCOPE=SPFILE;</copy>
    
    System altered.
    
    SQL> <copy>EXIT</copy>
    
    $
    
    ```
  
  *Observe that the `UNIFIED_AUDIT_COMMON_SYSTEMLOG` is a CDB level init.ora parameter.*
  
  

3.  Restart the database instance because the initialization parameter `UNIFIED_AUDIT_COMMON_SYSTEMLOG` has been set at the `SPFILE` scope. Execute the `/home/oracle/labs/M104781GC10/wallet.sh` to restart the instance and also open the wallet.

  
    ```
    
    $ <copy>/home/oracle/labs/M104781GC10/wallet.sh</copy>
    
    ...
    
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
    
    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY <i>WElcome123##</i> container=all;
    
    keystore altered.
    
    SQL> ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY <i>WElcome123##</i> WITH BACKUP CONTAINER=ALL;
    
    ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY <i>WElcome123##</i> WITH BACKUP CONTAINER=ALL
    
    *
    
    ERROR at line 1:
    
    ORA-46663: master keys not created for all PDBs for REKEY
    
    SQL> 
    
    ```

## **STEP 4:** Define the OS directories for the SYSLOG files

1. Before audited actions are recorded by the SYSLOG system, define the OS directories for the SYSLOG files to store the audited records. Open another terminal session as `root`. 

    
    ```
    
    $ <copy>exit</copy>
    
    exit
    
    #
    
    ```

2. Edit the `/etc/rsyslog.conf` configuration file and under the `RULES` section, add as many lines as different values defined in the CDB for SYSTEMLOG to specify related OS directories.

  
    ```
    
    # <copy>vi /etc/rsyslog.conf</copy>
    
    ...
    
    #### RULES ####
    
    ...
    
    # Save boot messages also to boot.log
    
    local7.*                                                /var/log/boot.log
    
    <copy># Unified Audit Rules
    
    local0.info            /var/log/root_common_audit_records.log
    
    local1.warning         /var/log/root_audit_records.log</copy>
    
    ...
    
    # 
    
    ```

3. Restart the SYSLOG daemon.

  
    ```
    
    # <copy>cd /etc/init.d</copy>
    
    # <copy>service rsyslog restart</copy>
    
    Redirecting to /bin/systemctl restart  rsyslog.service
    
    ...
    
    # 
    
    ```

## **STEP 5:** Test

1. In the `oracle` UNIX session, log on as the common user `C##TEST` to the CDB root and perform a `CREATE TABLE` operation followed by `INSERT` operation on the table created.  

  
    ```
    
    SQL> <copy>CONNECT c##test</copy>
    
    Enter password: <i><copy>password</copy></i>
    
    SQL> <copy>ALTER SESSION SET default_sharing = 'EXTENDED DATA';</copy>
    
    Session altered.
    
    SQL> <copy>CREATE TABLE test (id NUMBER, label VARCHAR2(10));</copy>
    
    Table created.
    
    SQL> <copy>INSERT INTO test VALUES (1,'A');</copy>
    
    1 row created.
    
    SQL> <copy>INSERT INTO test VALUES (2,'B');</copy>
    
    1 row created.
    
    SQL> <copy>COMMIT;</copy>
    
    Commit complete.
    
    SQL>
    
    ```

2. Back in the `root` UNIX session, check that a syslog entry is created in `/var/log/root_common_audit_records.log` file because an audit record for CREATE TABLE got generated due to the common audit policy `POL_COMMON`.

  
    ```
    
    # <copy>grep -i  'Oracle Unified Audit'  /var/log/root_common_audit_records.log</copy>
    
    Nov 13 15:52:56 db21si journal: Oracle Unified Audit[23128]: LENGTH: '215' TYPE:"4" DBID:"2809789491" SESID:"2759083216" CLIENTID:"" ENTRYID:"1" STMTID:"9" DBUSER:"C##TEST" CURUSER:"C##TEST" <b>ACTION:"1"</b> RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TEST" <b>PDB_GUID:"B3316DF8AB281563E053E704F40AD8A9"</b>
    
    #
    
    ```
    
  *If you query the view `AUDIT_ACTIONS`, you observe that the `ACTION` number 1 is `CREATE TABLE`.*
  
  *If you query the view `V$CONTAINERS`, you observe that the `GUID` value corresponds to the CDB root.*
  
  *The single entry corresponds to the `CREATE TABLE` action audited commonly because the `POL_COMMON` audit policy audits all `CREATE TABLE` statements in all containers. The `INSERT` action (`ACTION` number 2 in `AUDIT_ACTIONS` view) is not recorded in this log file because the audit policy that audits `INSERT` statements, `POL_ROOT` is enabled only locally in the CDB root.*
  
  

3. Check that syslog entries are created in `/var/log/root_audit_records.log` file because audit records for `INSERT` got generated due to the local root audit policy `POL_ROOT`.

  
    ```
    
    # <copy>grep -i  'Oracle Unified Audit' /var/log/root_audit_records.log | grep TEST</copy>
    
    Nov 13 15:52:56 db21si journal: Oracle Unified Audit[23128]: LENGTH: '215' TYPE:"4" DBID:"2809789491" SESID:"2759083216" CLIENTID:"" ENTRYD:"1" STMTID:"9" DBUSER:"C##TEST" CURUSER:"C##TEST" <b>ACTION:"1"</b> RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TEST" <b>PDB_GUID:"B3316DF8AB281563E053E04F40AD8A9"</b>
    
    Nov 13 15:53:02 db21si journal: Oracle Unified Audit[23128]: LENGTH: '216' TYPE:"4" DBID:"2809789491" SESID:"2759083216" CLIENTID:"" ENTRYD:"2" STMTID:"10" DBUSER:"C##TEST" CURUSER:"C##TEST" <b>ACTION:"2"</b> RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TEST" <b>PDB_GUID:"B3316DF8AB281563E053704F40AD8A9"</b>
    
    Nov 13 15:53:05 db21si journal: Oracle Unified Audit[23128]: LENGTH: '216' TYPE:"4" DBID:"2809789491" SESID:"2759083216" CLIENTID:"" ENTRYD:"3" STMTID:"11" DBUSER:"C##TEST" CURUSER:"C##TEST" <b>ACTION:"2"</b> RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TEST" <b>PDB_GUID:"B3316DF8AB281563E053704F40AD8A9"</b>
    
    #
    
    ```
    
  *The first entry corresponds to the `CREATE TABLE` action audited commonly and thus also locally in the CDB root. The second and third entries correspond to the two `INSERT` actions recorded in this log file because the audit policy `POL_ROOT` that audits `INSERT` statements is enabled locally in the CDB root.*
  
  *If you query the view `V$CONTAINERS`, you observe that the `GUID` value corresponds to `PDB21`.*
  
  

4. Back in the `oracle` UNIX session, log on as the common user `C##TEST` to the PDB `PDB21` and perform a `CREATE TABLE` operation followed by `INSERT` operation on the table created.

    
    ```
    
    SQL> <copy>CONNECT c##test@PDB21</copy>
    
    Enter password: <i><copy>password</copy></i>
    
    Connected.
    
    SQL> <copy>CREATE TABLE testpdb21 (id NUMBER, label VARCHAR2(10));</copy>
    
    Table created.
    
    SQL> <copy>INSERT INTO testpdb21 VALUES (1,'A');</copy>
    
    1 row created.
    
    SQL> <copy>INSERT INTO testpdb21 VALUES (2,'B');</copy>
    
    1 row created.
    
    SQL> <copy>COMMIT;</copy>
    
    Commit complete. 
    
    SQL> <copy>EXIT</copy>
    
    $
    
    ```

5. Back in the `root` UNIX session, check whether a syslog entry is created in `/var/log/root_common_audit_records.log` file.

  
    ```
    
    # <copy>grep -i  'Oracle Unified Audit'  /var/log/root_common_audit_records.log</copy>
    
    Nov 13 15:52:56 db21si journal: Oracle Unified Audit[23128]: LENGTH: '215' TYPE:"4" DBID:"2809789491" SESID:"2759083216" CLIENTID:"" ENTRYID:"1" STMTID:"9" DBUSER:"C##TEST" CURUSER:"C##TEST" <b>ACTION:"1"</b> RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TEST" <b>PDB_GUID:"B3316DF8AB281563E053E704F40AD8A9"</b>
    
    Nov 13 16:01:47 db21si journal: Oracle Unified Audit[51696]: LENGTH: '219' TYPE:"4" DBID:"3207694222" SESID:"502695322" CLIENTID:"" ENTRYID:"6" STMTID:"7" DBUSER:"C##TEST" CURUSER:"C##TEST" <b>ACTION:"1"</b> RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TESTPDB21" <b>PDB_GUID:"B3C43A538FDE55BEE0537167606449A3"</b>
    
    #
    
    ```
  
  *The second entry corresponds to the `CREATE TABLE` action audited commonly because the common audit policy `POL_COMMON` audits all `CREATE TABLE` statements in all containers and thus in `PDB21` too. No `INSERT` action is recorded in this log file because the audit policy `POL_ROOT` that audits `INSERT` statements is created only locally in the CDB root and not commonly in all containers.*
  
  

6. Check whether syslog entries are created in `/var/log/root_audit_records.log` file.

    
    ```
    
    # <copy>grep -i  'Oracle Unified Audit'  /var/log/root_audit_records.log | grep TEST</copy>
    
    Nov 13 15:52:56 db21si journal: Oracle Unified Audit[23128]: LENGTH: '215' TYPE:"4" DBID:"2809789491" SESID:"2759083216" CLIENTID:"" ENTRYID:"1" STMTID:"9" DBUSER:"C##TEST" CURUSER:"C##TEST" ACTION:"1" RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TEST" <b>PDB_GUID:"B3316DF8AB281563E053E704F40AD8A9"</b>
    
    Nov 13 15:53:02 db21si journal: Oracle Unified Audit[23128]: LENGTH: '216' TYPE:"4" DBID:"2809789491" SESID:"2759083216" CLIENTID:"" ENTRYID:"2" STMTID:"10" DBUSER:"C##TEST" CURUSER:"C##TEST" <b>ACTION:"2"</b> RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TEST" <b>PDB_GUID:"B3316DF8AB281563E053E704F40AD8A9"</b>
    
    Nov 13 15:53:05 db21si journal: Oracle Unified Audit[23128]: LENGTH: '216' TYPE:"4" DBID:"2809789491" SESID:"2759083216" CLIENTID:"" ENTRYID:"3" STMTID:"11" DBUSER:"C##TEST" CURUSER:"C##TEST" <b>ACTION:"2"</b> RETCODE:"0" SCHEMA:"C##TEST" OBJNAME:"TEST" <b>PDB_GUID:"B3316DF8AB281563E053E704F40AD8A9"</b>
    
    # <copy>exit</copy>
    
    logout
    
    $ 
    
    ```
    
  *Although a local audit policy `POL_PDB21` in `PDB21` audits `INSERT` actions, no audit record is written in the SYSLOG file because SYSLOG records only actions executed at the CDB level.*
  
  

## **Step 6:** Cleanup

1. Back in the `oracle` UNIX session, execute the `/home/oracle/labs/M104781GC10/cleanup.sh` shell script to reset the `SYSLOG` destinations for both common and local unified audit policies, and dropping the policies int he CDB root and `PDB21`.

  
    ```
    
    $ <copy>/home/oracle/labs/M104781GC10/cleanup.sh</copy>
    
    ...
    
    SQL> ALTER SYSTEM SET UNIFIED_AUDIT_COMMON_SYSTEMLOG='' SCOPE=SPFILE;
    
    System altered.
    
    SQL> ALTER SYSTEM SET UNIFIED_AUDIT_SYSTEMLOG='' SCOPE=SPFILE;
    
    System altered.
    
    SQL> noaudit POLICY pol_common;
    
    Noaudit succeeded.
    
    SQL> drop AUDIT POLICY pol_common;
    
    Audit Policy dropped.
    
    SQL> exit
    
    ...
    
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
    
    SQL> ALTER SYSTEM SET wallet_root = '/u01/app/oracle/admin/CDB21/tde'
    
      2         SCOPE=SPFILE;
    
    System altered.
    
    SQL>
    
    SQL> exit
    
    ...
    
    SQL> shutdown abort
    
    ORACLE instance shut down.
    
    SQL> exit
    
    ...
    
    Connected to an idle instance.
    
    SQL> STARTUP
    
    ORACLE instance started.
    
    Total System Global Area  851440088 bytes
    
    Fixed Size                  9691608 bytes
    
    Variable Size             570425344 bytes
    
    Database Buffers          134217728 bytes
    
    Redo Buffers               19664896 bytes
    
    In-Memory Area            117440512 bytes
    
    Database mounted.
    
    Database opened.
    
    SQL> ALTER PLUGGABLE DATABASE all OPEN;
    
    Pluggable database altered.
    
    SQL> exit
    
    ...
    
    SQL> ALTER SYSTEM SET tde_configuration =
    
      2                       'KEYSTORE_CONFIGURATION=FILE'
    
      3                        SCOPE=BOTH;
    
    System altered.
    
    SQL> ADMINISTER KEY MANAGEMENT CREATE KEYSTORE IDENTIFIED BY <i>WElcome123##</i> ;
    
    ADMINISTER KEY MANAGEMENT CREATE KEYSTORE IDENTIFIED BY <i>WElcome123##</i> 
    
    *
    
    ERROR at line 1:
    
    ORA-46630: keystore cannot be created at the specified location
    
    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY <i>WElcome123##</i> container=all;
    
    keystore altered.
    
    SQL> ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY <i>WElcome123##</i> WITH BACKUP CONTAINER=ALL;
    
    keystore altered.
    
    ...
    
    SQL> noAUDIT POLICY pol_pdb21;
    
    Noaudit succeeded.
    
    SQL> drop AUDIT POLICY pol_pdb21;
    
    Audit Policy dropped.
    
    SQL> EXIT
    
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
