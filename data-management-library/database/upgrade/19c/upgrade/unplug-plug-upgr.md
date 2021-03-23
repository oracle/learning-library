# Unplug - Plug - Upgrade

## Introduction

In this lab you will now unplug an Oracle 12.2.0.1 pluggable database (PDB) from CDB1 and plug it into 19c’s CDB2, including all the necessary steps.

Estimated Lab Time: n minutes

### About Unplug Plug Upgrade
You can upgrade PDBs by unplugging a PDB from an earlier release CDB, plugging it into a later release CDB, and then upgrading that PDB to the later release.

CDBs can contain zero, one, or more pluggable databases (PDBs). After you install a new Oracle Database release, or after you upgrade the CDB (CDB$ROOT), you can upgrade one or more PDB without upgrading all of the PDBs on the CDB.

![](./images/unplug-plug-upgrade.png " ")

1. Unplug PDBs from one source Oracle Database 12.2 CDB (CDB1, with pdba and pdbb) and plug them into a new release target CDB (CDB3).
2. Unplug PDBs from multiple source CDBs (Oracle Database 12.2 on CDB1, pdba and pdbb), and Oracle Database 18c, CDB2, pdbc and pdbd), and plug them into a new release target CDB (CDB3).


### Objectives
In this lab, you will:
* Preparation work in CDB1
* Preupgrade.jar and Unplug
* Plugin
* Upgrade

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
		- Lab: Initialize Environment

## **STEP 1**: Preparation work in CDB1

1. The PDB3 we will use in this part of the lab is created already in CDB1 – but you need to startup CDB1 and PDB3.

    ````
    <copy>
    . cdb1
    sqlplus / as sysdba
    </copy>
    ````
    ![](./images/unplug_1.png " ")

    ````
    <copy>
    startup
    alter pluggable database pdb3 open;
    show pdbs
    exit
    </copy>
    ````
    ![](./images/unplug_2.png " ")

## **STEP 2**: Preupgrade.jar and Unplug

2. Run the preupgrade.jar but only on container PDB3

    ````
    <copy>
    java -jar $OH19/rdbms/admin/preupgrade.jar -c 'pdb3' TERMINAL TEXT
    </copy>
    ````
    ![](./images/unplug_3.png " ")

3. This will execute preupgrade.jar only in container “PDB3”.  Follow the advice of preupgrade.jar‘s output. You can leave all underscore parameters in

4. Be aware: If you’d remove  for instance the \_fix\_control, you’d remove this setting for the entire CDB. This would affect other PDBs as well which may still remain in the 12.2.0.1 environment. That’s why we will leave all underscores as is.

5. Open a second terminal window (or a new tab in your existing one) and logon at first to CDB$ROOT. Then change to PDB3 to complete the steps recommended by preupgrade.jar.

    ````
    <copy>
    . cdb1
    sqlplus / as sysdba
    </copy>
    ````
    ![](./images/unplug_4.png " ")

    ````
    <copy>
    alter session set container=PDB3;
    @/u01/app/oracle/cfgtoollogs/CDB1/preupgrade/preupgrade_fixups.sql
    </copy>
    ````
    ![](./images/unplug_5.png " ")
    ![](./images/unplug_6.png " ")
    ![](./images/unplug_7.png " ")
    ````
    <copy>
    alter session set container=CDB$ROOT;
    alter pluggable database PDB3 close;
    alter pluggable database PDB3 unplug into '/home/oracle/pdb3.pdb';
    drop pluggable database PDB3 including datafiles;
    </copy>
    ````
    ![](./images/unplug_8.png " ")

6. Unplugging into a *.pdp does create a zip archive including all necessary files. It will take 30 seconds or more.

    ````
    <copy>
    shutdown immediate
    exit
    </copy>
    ````
    ![](./images/unplug_9.png " ")

## **STEP 3**: Plugin

1. In this step you’ll plugin PDB3 into CDB2.

    ````
    <copy>
    . cdb2
    sqlplus / as sysdba
    </copy>
    ````
    ![](./images/unplug_10.png " ")

2. At first, you’ll do a compatibility check and find out, why the action is classified as “not compatible”:

    ````
    <copy>
    SET SERVEROUTPUT ON
    DECLARE
    compatible CONSTANT VARCHAR2(3) := CASE DBMS_PDB.CHECK_PLUG_COMPATIBILITY(
    pdb_descr_file => '/home/oracle/pdb3.pdb',
    pdb_name => 'PDB3')
    WHEN TRUE THEN 'YES' ELSE 'NO'
    END;
    BEGIN
    DBMS_OUTPUT.PUT_LINE(compatible);
    END;
    /
    </copy>
    ````
    ![](./images/unplug_11.png " ")

3. If the result is “NO“, check PDB\_PLUG\_IN\_VIOLATIONS for the reason:
    
    ````
    <copy>
    select message from pdb_plug_in_violations where type like '%ERR%' and status <> 'RESOLVED';
    </copy>
    ````
    You receive two messages:
    ![](./images/unplug_12.png " ")

    <!-- ````
    SQL> select message from pdb_plug_in_violations where type like '%ERR%' and status <> 'RESOLVED';

    MESSAGE
    --------------------------------------------------------------------------------
    PDB's version does not match CDB's version: PDB's version 12.2.0.1.0. CDB's vers
    ion 19.0.0.0.0.

    DBRU bundle patch 200114 (DATABASE JAN 2020 RELEASE UPDATE 12.2.0.1.200114): Not
    installed in the CDB but installed in the PDB

    '19.6.0.0.0 Release_Update 1912171550' is installed in the CDB but no release up
    dates are installed in the PDB
    ```` -->

4. The first one is correct and makes sense. The second and third one can be ignored as it doesn’t matter if PDB3 has a different patch level in 12.2.0.1 – you will upgrade it to 19c anyway. You may read a bit more about PDB\_PLUG\_IN\_VIOLATIONS here.  Plugin the PDB3, the open it in UPGRADE mode:

    ````
    <copy>
    create pluggable database pdb3 using '/home/oracle/pdb3.pdb' file_name_convert=('/home/oracle', '/u02/oradata/CDB2/pdb3');
    alter pluggable database PDB3 open upgrade;
    exit
    </copy>
    ````
    ![](./images/unplug_13.png " ")
## **STEP 4**: Upgrade PDB3

1. As final action, as a PDB has its own data dictionary, you need to upgrade PDB3 now.

    ````
    <copy>
    . cdb2
    dbupgrade -c 'PDB3' -l /home/oracle/logs -n 2
    </copy>
    ````
    ![](./images/unplug_14.png " ")
    ![](./images/unplug_15.png " ")

2. Once the upgrade has been completed, you need to recompile and run the postupgrade_fixups.sql as usual:

    ````
    <copy>
    . cdb2
    sqlplus / as sysdba
    </copy>
    ````
    ![](./images/unplug_16.png " ")

    ````
    <copy>
    alter session set container=PDB3;
    startup
    </copy>
    ````
    ![](./images/unplug_17.png " ")
    ````
    <copy>
    @?/rdbms/admin/utlrp.sql
    </copy>
    ````
    ![](./images/unplug_18.png " ")
    ![](./images/unplug_19.png " ")
    ````
    <copy>
    @/u01/app/oracle/cfgtoollogs/CDB1/preupgrade/postupgrade_fixups.sql
    </copy>
    ````
    ![](./images/unplug_20.png " ")
    ![](./images/unplug_21.png " ")
    ````
    <copy>
    alter session set container=CDB$ROOT;
    show pdbs
    exit
    </copy>
    ````
    ![](./images/unplug_22.png " ")

3. If you’d like, you can now try some fallback exercises. For this part of the lab you should restore the initial snapshot again.

4. Mark the initial snapshot in the VirtualBox Manager with the mouse click

5. Then click on the Restore icon.

You may now [proceed to the next lab](#next).

## Learn More

* [Unplugging, Plugging and Upgrading a PDB to a new CDB](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiJsZX9yfPuAhWAGFkFHeisAIYQFjAAegQIARAD&url=https%3A%2F%2Fdocs.oracle.com%2Fen%2Fdatabase%2Foracle%2Foracle-database%2F19%2Fspupu%2Funplugging-plugging-and-upgrading-pdb-new-cdb.pdf&usg=AOvVaw1LWOFvD1Ma7o5gdt7k0kbw)
* [Upgrading Multitenant Using Unplug-Plug](https://docs.oracle.com/en/database/oracle/oracle-database/19/spupu/upgrade-multitenant-architecture-sequentially.html#GUID-8F9AAFA1-690D-4F70-8448-E66D765AF136)

## Acknowledgements
* **Author** - Mike Dietrich, Database Product Management
* **Contributors** -  Roy Swonger, Sanjay Rupprel, Cristian Speranta
* **Last Updated By/Date** - Kay Malcolm, February 2021
