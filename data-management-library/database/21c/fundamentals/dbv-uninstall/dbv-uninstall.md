# Uninstalling Oracle Database Vault

## Introduction
This lab shows how to uninstall Oracle Database Vault from an Oracle Database installation, for PDBs (but not the CDB root) and Oracle RAC installations.

The uninstallation process does not affect the initialization parameter settings, even those settings that were modified during the installation process, nor does it affect Oracle Label Security.

Estimated Lab Time: 15 minutes

### Objectives
In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:**  Ensure Database Vault is enabled before uninstalling

1. Execute the shell script to configure Database Vault at the CDB level.


    ```

    $ <copy>cd /home/oracle/labs/M104781GC10</copy>

    $ <copy>/home/oracle/labs/M104781GC10/setup_DV.sh</copy>


    SQL> INSERT INTO l_tab values(2);

    1 row created.

    SQL> COMMIT;

    Commit complete.

    SQL> EXIT

    $

    ```

2.  Connect to the CDB root as `C##SEC_ADMIN` to verify the status of Database Vault.


    ```

    $ <copy>sqlplus c##sec_admin</copy>

    Enter password: <i>WElcome123##</i>
    ```
    ```

    SQL> <copy>SELECT * FROM DVSYS.DBA_DV_STATUS;</copy>

    NAME                STATUS

    ------------------- --------------

    DV_CONFIGURE_STATUS TRUE

    DV_ENABLE_STATUS    TRUE

    DV_APP_PROTECTION   NOT CONFIGURED

    SQL>

    ```

3. Log into `PDB21` as user `SYS` with the `SYSDBA` administrative privilege.


    ```

    SQL> <copy>CONNECT sys@PDB21 AS SYSDBA</copy>

    Enter password:  <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SELECT * FROM DVSYS.DBA_DV_STATUS;</copy>

    NAME                STATUS

    ------------------- --------------

    DV_CONFIGURE_STATUS TRUE

    DV_ENABLE_STATUS    TRUE

    DV_APP_PROTECTION   NOT CONFIGURED

    SQL> <copy>SELECT * FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';</copy>

    PARAMETER                 VALUE   CON_ID

    ------------------------- ------- ------

    Oracle Database Vault     TRUE         0

    SQL>

    ```

4. Log into the CDB root to ensure that the recycle bin is disabled.


    ```

    SQL> <copy>CONNECT / AS SYSDBA</copy>

    Connected.
    ```
    ```

    SQL> <copy>SHOW PARAMETER recyclebin</copy>

    NAME                                 TYPE        VALUE

    ------------------------------------ ----------- ------------------------------

    recyclebin                           string      on

    SQL>

    ```

  If the recycle bin is on, then disable it.


    ```

    SQL> <copy>ALTER SYSTEM SET RECYCLEBIN = OFF SCOPE=SPFILE;</copy>

    System altered.

    SQL>

    ```

## **STEP 2:** Disable Database Vault at the PDB and CDB levels

1. Connect to `PDB21` as a user who has been granted the `DV_OWNER` or `DV_ADMIN` role, such as `C##SEC_ADMIN`.


    ```

    SQL> <copy>CONNECT c##sec_admin@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.

    SQL>

    ```

2. Disable Oracle Database Vault at the PDB level.


    ```

    SQL> <copy>EXEC DBMS_MACADM.DISABLE_DV</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

3. Close and reopen `PDB21`.


    ```

    SQL> <copy>CONNECT sys@PDB21 AS SYSDBA</copy>

    Enter password:<i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SHUTDOWN</copy>

    Pluggable Database closed.

    SQL> <copy>STARTUP</copy>

    Pluggable Database opened.

    SQL> <copy>SELECT * FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';</copy>

    PARAMETER                 VALUE   CON_ID

    ------------------------- ------- ------

    Oracle Database Vault     FALSE        0

    SQL>

    ```

  *Even if the `CON_ID `displays 0, the value for the Database Vault refers to the PDB you are connected to.*



4. What is the status of Database Vault in the CDB root?


    ```

    SQL> <copy>CONNECT / AS SYSDBA</copy>

    Connected.
    ```
    ```

    SQL> <copy>SELECT * FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';</copy>

    PARAMETER                 VALUE   CON_ID

    ------------------------- ------- ------

    Oracle Database Vault     TRUE         0

    SQL>

    ```

5. Disable Oracle Database Vault at the CDB level.  


    ```

    SQL> <copy>CONNECT c##sec_admin</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>EXEC DBMS_MACADM.DISABLE_DV</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```



6. Restart the CDB instance.


    ```

    SQL> <copy>CONNECT / AS SYSDBA</copy>

    Connected.
    ```
    ```

    SQL> <copy>SHUTDOWN IMMEDIATE</copy>

    Database closed.

    Database dismounted.

    ORACLE instance shut down.

    SQL> <copy>STARTUP</copy>

    ORACLE instance started.

    Total System Global Area 1426060208 bytes

    Fixed Size                  9687984 bytes

    Variable Size             436207616 bytes

    Database Buffers          973078528 bytes

    Redo Buffers                7086080 bytes

    Database mounted.

    Database opened.

    SQL> <copy>SELECT * FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';</copy>

    PARAMETER                 VALUE   CON_ID

    ------------------------- ------- ------

    Oracle Database Vault     FALSE        0

    SQL>

    ```

## **STEP 3:** Remove Database Vault metadata at the PDB and CDB levels

1. Run the `dvremov.sql` script to remove Oracle Database Vault related metadata.


    ```

    SQL> <copy>@$ORACLE_HOME/rdbms/admin/dvremov.sql</copy>

    Session altered.

    DECLARE

    *

    ERROR at line 1:

    ORA-48000: Cannot run dvremov.sql from CDB root when one or more PDBs are

    closed.

    ORA-06512: at line 17

    Disconnected from Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Development

    Version 21.1.0.0.0

    $

    ```

2. Reopen `PDB21` before removing Database Vault from the CDB root.


    ```

    $ <copy>sqlplus / AS SYSDBA</copy>

    Connected to:

    Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production

    Version 21.1.0.0.0
    ```
    ```

    SQL> <copy>ALTER PLUGGABLE DATABASE ALL OPEN;</copy>

    Pluggable database altered.

    SQL> <copy>@$ORACLE_HOME/rdbms/admin/dvremov.sql</copy>

    Session altered.

    DECLARE

    *

    ERROR at line 1:

    ORA-47993: Cannot run dvremov.sql from CDB root when DV is installed in one or

    more PDBs.

    ORA-06512: at line 32

    Disconnected from Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Development

    Version 21.1.0.0.0

    $ <copy>oerr ORA 47993</copy>

    47993, 00000, "Cannot run dvremov.sql from CDB root when DV is installed in one or more PDBs."

    // *Cause: The Database Vault (DV) removal script was not allowed to be run from the multitenant

    //         container database (CDB) root when DV is installed in one or more of the underlying

    //         pluggable databases (PDBs).

    // *Action: <copy>Run dvremov.sql on all PDBs before running it from CDB root.</copy>

    $

    SQL>

    ```

3. Run the `dvremov.sql` script to remove Oracle Database Vault related metadata from `PDB21`.


    ```

    $ <copy>sqlplus sys@PDB21 AS SYSDBA</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>@$ORACLE_HOME/rdbms/admin/dvremov.sql</copy>

    Session altered.

    PL/SQL procedure successfully completed.

    ...

    User dropped.

    ...

    Role dropped.

    PL/SQL procedure successfully completed.

    ...

    Grant succeeded.

    PL/SQL procedure successfully completed.

    Noaudit succeeded.

    ...

    Commit complete.

    PL/SQL procedure successfully completed.

    Session altered.

    SQL>

    ```

4. Now remove Oracle Database Vault related metadata from the CDB root.


    ```

    SQL> <copy>CONNECT / AS SYSDBA</copy>

    Connected.
    ```
    ```

    SQL> <copy>@$ORACLE_HOME/rdbms/admin/dvremov.sql</copy>

    Session altered.

    PL/SQL procedure successfully completed.

    ...

    Commit complete.

    PL/SQL procedure successfully completed.

    ...

    Noaudit succeeded.

    Commit complete.

    PL/SQL procedure successfully completed.

    Session altered.

    SQL> <copy> EXIT</copy>

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
