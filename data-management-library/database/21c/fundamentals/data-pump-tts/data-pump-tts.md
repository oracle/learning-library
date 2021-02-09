# Data Pump Transportable Tbsp

## Introduction
This lab shows how to parallelize export and import operations for Transportable Tablespace (TTS) metadata.

Estimated Lab Time: 10 minutes

### Objectives
In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Prepare the tablespace to be exported

1. In `PDB21`, set the tablespace `USERS` to transport to read only. If the tablespace does not exist, create it. IF the master key is not set yet, set it.

    ```

    $ <copy>sqlplus / AS SYSDBA</copy>                   

    Connected to:
    ```
    ```

    SQL> <copy> ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY WElcome123## WITH BACKUP CONTAINER=ALL;</copy>
    ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY <i>WElcome123##</i> WITH BACKUP CONTAINER=ALL
    *
    ERROR at line 1:
    ORA-46663: master keys not created for all PDBs for REKEY
    ```
    ```

    SQL> <copy>CONNECT sys@PDB21 AS SYSDBA</copy>                   
    Enter password: <b><i>WElcome123##</i></b>
    Connected.
    ```
    ```
    SQL> <copy>CREATE TABLESPACE users DATAFILE '/u02/app/oracle/oradata/CDB21/users01.dbf' SIZE 50M;</copy>

    Tablespace created.

    SQL> <copy>ALTER TABLESPACE users READ ONLY;</copy>

    Tablespace altered.

    SQL> <copy>EXIT</copy>
    $

    ```

## **STEP 2:** Perform the TTS in parallel

1. Perform the TTS in parallel against `PDB21`.

    ```

    $ <copy>expdp \"sys@PDB21 AS SYSDBA\" dumpfile=PDB21.dmp TRANSPORT_TABLESPACES=users TRANSPORT_FULL_CHECK=YES LOGFILE=tts.log REUSE_DUMPFILES=YES PARALLEL=2</copy>

    Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.
    Password: <b><i>WElcome123##</i></b>

    Starting "SYS"."SYS_EXPORT_TRANSPORTABLE_02":  "sys/********@PDB21 AS SYSDBA" dumpfile=PDB21.dmp TRANSPORT_TABLESPACES=users TRANSPORT_FULL_CHECK=YES LOGFILE=tts.log REUSE_DUMPFILES=YES PARALLEL=2
    ORA-39396: Warning: exporting encrypted data using transportable option without password

    ORA-39396: Warning: exporting encrypted data using transportable option without password

    Processing object type TRANSPORTABLE_EXPORT/PLUGTS_BLK
    Processing object type TRANSPORTABLE_EXPORT/POST_INSTANCE/PLUGTS_BLK
    Master table "SYS"."SYS_EXPORT_TRANSPORTABLE_01" successfully loaded/unloaded
    ******************************************************************************
    Dump file set for SYS.SYS_EXPORT_TRANSPORTABLE_01 is:
      /u01/app/oracle/admin/CDB21/dpdump/B31CEA21AC8A70CAE0536067606430B7/PDB21.dmp
    ******************************************************************************
    Datafiles required for transportable tablespace USERS:
      /u02/app/oracle/oradata/CDB21/users01.dbf
    Job "SYS"."SYS_EXPORT_TRANSPORTABLE_01" completed with 2 error(s) at Mon Nov 2 18:00:37 2020 elapsed 0 00:00:21
    $

    ```

## **STEP 3:** Set the tablespace back to read write

1. Use the `ALTER TABLESPACE` command to set the tablespace back to read write.

    ```

    $ <copy>sqlplus sys@PDB21 AS SYSDBA</copy>                   

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password: <b><i>WElcome123##</i></b>

    Connected to:
    ```
    ```

    SQL> <copy>ALTER TABLESPACE users READ WRITE;</copy>

    Tablespace altered.

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
