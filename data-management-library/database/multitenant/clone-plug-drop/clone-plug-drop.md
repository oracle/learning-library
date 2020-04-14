
# Multitenant Basics  

## Introduction
In this lab you will perform many multitenant basic tasks.  You will create a pluggable database (PDB), make a copy of this pluggable database, or clone it, explore the concepts of "plugging" and unplugging a PDB and finally drop it.  You will then explore the concepts of cloning unplugged databases and databases that are hot or active. 

[](youtube:kzTQGs75IjA)

## Step 1: Create PDB
This section looks at how to create a new PDB.

The tasks you will accomplish in this lab are:
- Create a pluggable database **PDB2** in the container database **CDB1**  

1. Connect to **CDB1**  

    ````
    <copy>
    sqlplus /nolog
    connect sys/oracle@localhost:1523/cdb1 as sysdba
    </copy>
    ````

2. Check to see who you are connected as. At any point in the lab you can run this script to see who or where you are connected.  

    ````
    <copy>
    select
      'DB Name: '  ||Sys_Context('Userenv', 'DB_Name')||
      ' / CDB?: '     ||case
        when Sys_Context('Userenv', 'CDB_Name') is not null then 'YES'
          else  'NO'
          end||
      ' / Auth-ID: '   ||Sys_Context('Userenv', 'Authenticated_Identity')||
      ' / Sessn-User: '||Sys_Context('Userenv', 'Session_User')||
      ' / Container: ' ||Nvl(Sys_Context('Userenv', 'Con_Name'), 'n/a')
      "Who am I?"
      from Dual
      /
      </copy>
    ````

    ![](./images/whoisconnected.png " ")

3. Create a pluggable database **PDB2**.  

    ````
    <copy>
    show  pdbs;
    create pluggable database PDB2 admin user PDB_Admin identified by oracle;
    alter pluggable database PDB2 open;
    show pdbs;
    </copy>
    ````
    ![](./images/showpdbsbefore.png " ")

    ![](./images/createpdb.png " ")

    ![](./images/showpdbsafter.png " ")

4. Change the session to point to **PDB2**.  

    ````
    alter session set container = PDB2;
    ````
   ![](./images/altersession.png " ")

5. Grant **PDB_ADMIN** the necessary privileges and create the **USERS** tablespace for **PDB2**.  

    ````
    <copy>
    grant sysdba to pdb_admin;
    create tablespace users datafile size 20M autoextend on next 1M maxsize unlimited segment space management auto;
    alter database default tablespace Users;
    grant create table, unlimited tablespace to pdb_admin;
    </copy>
    ````

   ![](./images/grantsysdba.png " ")

6. Connect as **PDB_ADMIN** to **PDB2**.  

    ````
    connect pdb_admin/oracle@localhost:1523/pdb2
    ````

7. Create a table **MY_TAB** in **PDB2**.  

    ````
    <copy>
    create table my_tab(my_col number);
    insert into my_tab values (1);
    commit;
    </copy>
    ````

   ![](./images/createtable.png " ")

8. Change back to **SYS** in the container database **CDB1** and show the tablespaces and datafiles created.  

    ````
    <copy>
    connect sys/oracle@localhost:1523/cdb1 as sysdba

    COLUMN "Con_Name" FORMAT A10
    COLUMN "T'space_Name" FORMAT A12
    COLUMN "File_Name" FORMAT A120
    SET LINESIZE 220
    SET PAGES 9999

    with Containers as (
      select PDB_ID Con_ID, PDB_Name Con_Name from DBA_PDBs
      union
      select 1 Con_ID, 'CDB$ROOT' Con_Name from Dual)
    select
      Con_ID,
      Con_Name "Con_Name",
      Tablespace_Name "T'space_Name",
      File_Name "File_Name"
    from CDB_Data_Files inner join Containers using (Con_ID)
    union
    select
      Con_ID,
      Con_Name "Con_Name",
      Tablespace_Name "T'space_Name",
      File_Name "File_Name"
    from CDB_Temp_Files inner join Containers using (Con_ID)
    order by 1, 3
    /
    </copy>
    ````
   ![](./images/containers.png " ")


## Step 2: Clone a PDB
This section looks at how to clone a PDB

The tasks you will accomplish in this lab are:
- Clone a pluggable database **PDB2** into **PDB3**


1. Connect to **CDB1**.  

    ````
    sqlplus /nolog
    connect sys/oracle@localhost:1523/cdb1 as sysdba
    ````

2. Change **PDB2** to read only.  

    ````
    alter pluggable database PDB2 open read only force;
    show pdbs
    ````

   ![](./images/alterplug.png " ")

   ![](./images/showpdbs.png " ")
   
3. Create a pluggable database **PDB3** from the read only database **PDB2**.  

    ````
    create pluggable database PDB3 from PDB2;
    alter pluggable database PDB3 open force;
    show pdbs
    ````
   ![](./images/createpdb3.png " ")

4. Change **PDB2** back to read write.  

    ````
    alter pluggable database PDB2 open read write force;
    show pdbs
    ````
   ![](./images/pdb2write.png " ")

5. Connect to **PDB2** and show the table **MY_TAB**.  

    ````
    connect pdb_admin/oracle@localhost:1523/pdb2
    select * from my_tab;
    ````
 
   ![](./images/pdb2mytab.png " ")

6. Connect to **PDB3** and show the table **MY_TAB**.  

    ````
    connect pdb_admin/oracle@localhost:1523/pdb3
    select * from my_tab;
    ````
   ![](./images/pdb3mytab.png " ")

## Step 3: Unplug a PDB
This section looks at how to unplug a PDB

The tasks you will accomplish in this lab are:
- Unplug **PDB3** from **CDB1**

1. Connect to **CDB1**.  

    ````
    sqlplus /nolog
    connect sys/oracle@localhost:1523/cdb1 as sysdba
    ````

2. Unplug **PDB3** from **CDB1**.  

    ````
    show pdbs
    alter pluggable database PDB3 close immediate;

    alter pluggable database PDB3
    unplug into
    '/u01/app/oracle/oradata/CDB1/pdb3.xml';

    show pdbs
    ````

   ![](./images/unplugpdb3.png " ")

3. Remove **PDB3** from **CDB1**.  

    ````
    drop pluggable database PDB3 keep datafiles;

    show pdbs
    ````

   ![](./images/droppdb3.png " ")

4. Show the datafiles in **CDB1**.  

    ````
    <copy>
    COLUMN "Con_Name" FORMAT A10
    COLUMN "T'space_Name" FORMAT A12
    COLUMN "File_Name" FORMAT A120
    SET LINESIZE 220
    SET PAGES 9999

    with Containers as (
      select PDB_ID Con_ID, PDB_Name Con_Name from DBA_PDBs
      union
      select 1 Con_ID, 'CDB$ROOT' Con_Name from Dual)
    select
      Con_ID,
      Con_Name "Con_Name",
      Tablespace_Name "T'space_Name",
      File_Name "File_Name"
    from CDB_Data_Files inner join Containers using (Con_ID)
    union
    select
      Con_ID,
      Con_Name "Con_Name",
      Tablespace_Name "T'space_Name",
      File_Name "File_Name"
    from CDB_Temp_Files inner join Containers using (Con_ID)
    order by 1, 3
    /
    </copy>
    ````

    ![](./images/cdb1data.png " ")

5. Look at the XML file for the pluggable database **PDB3**.  

    ````
    host cat /u01/app/oracle/oradata/CDB1/pdb3.xml
    ````
    ![](./images/xmlfile.png " ")


## Step 4: Plug in a PDB
This section looks at how to plug in a PDB

The tasks you will accomplish in this lab are:
- Plug **PDB3** into **CDB2**

1. Connect to **CDB2**  

    ````
    sqlplus /nolog
    connect sys/oracle@localhost:1524/cdb2 as sysdba

    COLUMN "Who am I?" FORMAT A120
    select
      'DB Name: '  ||Sys_Context('Userenv', 'DB_Name')||
      ' / CDB?: '     ||case
        when Sys_Context('Userenv', 'CDB_Name') is not null then 'YES'
        else 'NO'
        end||
      ' / Auth-ID: '   ||Sys_Context('Userenv', 'Authenticated_Identity')||
      ' / Sessn-User: '||Sys_Context('Userenv', 'Session_User')||
      ' / Container: ' ||Nvl(Sys_Context('Userenv', 'Con_Name'), 'n/a')
      "Who am I?"
    from Dual
    /

    show pdbs
    ````
    ![](./images/whoamicdb2.png " ")

2. Check the compatibility of **PDB3** with **CDB2**  

    ````
    begin
      if not
        Sys.DBMS_PDB.Check_Plug_Compatibility
        ('/u01/app/oracle/oradata/CDB1/pdb3.xml')
      then
        Raise_Application_Error(-20000, 'Incompatible');
      end if;
    end;
    /
    ````


3. Plug **PDB3** into **CDB2**  

    ````
    create pluggable database PDB3
    using '/u01/app/oracle/oradata/CDB1/pdb3.xml'
    move;

    show pdbs
    alter pluggable database PDB3 open;
    show pdbs
    ````

    ![](./images/createwithxml.png " ")

4. Review the datafiles in **CDB2**  

    ````
    COLUMN "Con_Name" FORMAT A10
    COLUMN "T'space_Name" FORMAT A12
    COLUMN "File_Name" FORMAT A120
    SET LINESIZE 220
    SET PAGES 9999


    with Containers as (
      select PDB_ID Con_ID, PDB_Name Con_Name from DBA_PDBs
      union
      select 1 Con_ID, 'CDB$ROOT' Con_Name from Dual)
    select
      Con_ID,
      Con_Name "Con_Name",
      Tablespace_Name "T'space_Name",
      File_Name "File_Name"
    from CDB_Data_Files inner join Containers using (Con_ID)
    union
    select
      Con_ID,
      Con_Name "Con_Name",
      Tablespace_Name "T'space_Name",
      File_Name "File_Name"
    from CDB_Temp_Files inner join Containers using (Con_ID)
    order by 1, 3
    /
    ````

    ![](./images/mtdbfcdb2.png " ")

5. Connect as **PDB_ADMIN** to **PDB3** and look at **MY_TAB**;  

    ````
    connect pdb_admin/oracle@localhost:1524/pdb3

    select * from my_tab;
    ````

    ![](./images/pdb3mytab2.png " ")

## Step 5: Drop a PDB
This section looks at how to drop a pluggable database.

The tasks you will accomplish in this lab are:
- Drop **PDB3** from **CDB2**

1. Connect to **CDB2**  

    ````
    sqlplus /nolog
    connect sys/oracle@localhost:1524/cdb2 as sysdba
    ````

2. Drop **PDB3** from **CDB2**  

    ````
    show pdbs

    alter pluggable database PDB3 close immediate;

    drop pluggable database PDB3 including datafiles;

    show pdbs
    ````

    ![](./images/droppdb.png " ")


## Step 6: Clone an Unplugged PDB
This section looks at how to create a gold copy of a PDB and clone it into another container.

The tasks you will accomplish in this lab are:
- Create a gold copy of **PDB2** in **CDB1** as **GOLDPDB**
- Clone **GOLDPDB** into **COPYPDB1** and **COPYPDB2** in **CDB2**

1. Connect to **CDB1**  

    ````
    sqlplus /nolog
    connect sys/oracle@localhost:1523/cdb1 as sysdba
    ````

2. Change **PDB2** to read only  

    ````
    alter pluggable database PDB2 open read only force;
    show pdbs
    ````

3. Create a pluggable database **GOLDPDB** from the read only database **PDB2**  

    ````
    create pluggable database GOLDPDB from PDB2;
    alter pluggable database GOLDPDB open force;
    show pdbs
    ````

    ![](./images/goldpdb.png " ")

4. Change **PDB2** back to read write  

    ````
    <copy> 
    alter pluggable database PDB2 open read write force;
    show pdbs
    </copy>
    ````

    ![](./images/mountgoldpdb.png " ")

5. Unplug **GOLDPDB** from **CDB1**  

    ````
    <copy>
    show pdbs
    alter pluggable database GOLDPDB close immediate;

    alter pluggable database GOLDPDB
    unplug into '/u01/app/oracle/oradata/CDB1/goldpdb.xml';

    show pdbs
    </copy>
    ````

    ![](./images/unpluggold.png " ")

6. Remove **GOLDPDB** from **CDB1**  

    ````
    drop pluggable database GOLDPDB keep datafiles;

    show pdbs
    ````

7. Connect to **CDB2**  

    ````
    connect sys/oracle@localhost:1524/cdb2 as sysdba
    ````

8. Validate **GOLDPDB** is compatibile with **CDB2**  

    ````
    <copy>
    begin
      if not
        Sys.DBMS_PDB.Check_Plug_Compatibility
    ('/u01/app/oracle/oradata/CDB1/goldpdb.xml')
      then
        Raise_Application_Error(-20000, 'Incompatible');
      end if;
    end;
    /
    </copy>
    ````

9. Create a clone of **GOLDPDB** as **COPYPDB1**  

    ````
    <copy>
    create pluggable database COPYPDB1 as clone
    using '/u01/app/oracle/oradata/CDB1/goldpdb.xml'
    storage (maxsize unlimited max_shared_temp_size unlimited)
    copy;
    show pdbs
    </copy>
    ````

    ![](./images/clonegold1.png " ")

10. Create another clone of **GOLDPDB** as **COPYPDB2**  

    ````
    <copy>
    create pluggable database COPYPDB2 as clone
    using '/u01/app/oracle/oradata/CDB1/goldpdb.xml'
    storage (maxsize unlimited max_shared_temp_size unlimited)
    copy;
    show pdbs
    </copy>
    ````

    ![](./images/clonegold.png " ")

11. Open all of the pluggable databases  

    ````
    alter pluggable database all open;

    show pdbs
    ````
    ![](./images/allopen.png " ")

12. Look at the GUID for the two cloned databases  

    ````
    <copy>
    COLUMN "PDB Name" FORMAT A20
    select PDB_Name "PDB Name", GUID
    from DBA_PDBs
    order by Creation_Scn
    /
    </copy>
    ````
    ![](./images/guid.png " ")

## Step 7: PDB Hot Clones
This section looks at how to hot clone a pluggable database.

The tasks you will accomplish in this lab are:
- Create a pluggable database **OE** in the container database **CDB1**
- Create a load against the pluggable database **OE**
- Create a hot clone **OE_DEV** in the container database **CDB2** from the pluggable database **OE**

[](youtube:djp-ogM71oE)

1. Connect to **CDB1**  

    ````
    sqlplus /nolog
    connect sys/oracle@localhost:1523/cdb1 as sysdba
    ````

2. Create a pluggable database **OE** with an admin user of **SOE**  

    ````
    <copy>
    create pluggable database oe admin user soe identified by soe roles=(dba);
    alter pluggable database oe open;
    alter session set container = oe;
    grant create session, create table to soe;
    alter user soe quota unlimited on system;
     </copy>
   ````

    ![](./images/oe.png " ")

3. Connect as **SOE** and create the **sale_orders** table  

    ````
    <copy>
    connect soe/soe@localhost:1523/oe
    CREATE TABLE sale_orders 
    (ORDER_ID      number, 
    ORDER_DATE    date, 
    CUSTOMER_ID   number);
    </copy>
    ````
 
 4. Open a new terminal window, sudo to the oracle user and execute write-load.sh. Leave this window open and running throughout the rest of the multitenant labs.  

     ````
    <copy>
    sudo su - oracle
    cd /home/oracle/labs/multitenant
    ./write-load.sh
    </copy>
    ````
    Leave this window open and running for the next few labs.

5. Go back to your original terminal window.  Connect to **CDB2** and create the pluggable **OE_DEV** from the database link **oe@cdb1_link**  

    ````
    <copy>
    connect sys/oracle@localhost:1524/cdb2 as sysdba
    create pluggable database oe_dev from oe@cdb1_link;
    alter pluggable database oe_dev open;
    </copy>
    ````

6. Connect as **SOE** to **OE_DEV** and check the number of records in the **sale_orders** table  

    ````
    <copy>
    connect soe/soe@localhost:1524/oe_dev
    select count(*) from sale_orders;
    </copy>
    ````

7. Connect as **SOE** to **OE** and check the number of records in the **sale_orders** table  

    ````
    <copy>
    connect soe/soe@localhost:1523/oe
    select count(*) from sale_orders;
    </copy>
    ````

8. Close and remove the **OE_DEV** pluggable database  

    ````
    <copy>
    connect sys/oracle@localhost:1524/cdb2 as sysdba
    alter pluggable database oe_dev close;
    drop pluggable database oe_dev including datafiles;
    </copy>
    ````

9. Leave the **OE** pluggable database open with the load running against it for the rest of the labs.

You can see that the clone of the pluggable database worked without having to stop the load on the source database. In the next lab you will look at how to refresh a clone.

## Step 8: PDB Refresh
This section looks at how to hot clone a pluggable database, open it for read only and then refresh the database.

[](youtube:L9l7v6dH-e8)

The tasks you will accomplish in this lab are:
- Leverage the **OE** pluggable database from the previous lab with the load still running against it.
- Create a hot clone **OE_REFRESH**` in the container database **CDB2** from the pluggable database **OE**
- Refresh the **OE_REFRESH**` pluggable database.

1. Connect to **CDB2**  

    ````
    <copy>
    sqlplus /nolog
    connect sys/oracle@localhost:1524/cdb2 as sysdba
    </copy>
    ````

2. Create a pluggable database **OE_REFRESH**` with manual refresh mode from the database link **oe@cdb1_link**  

    ````
    <copy>
    create pluggable database oe_refresh from oe@cdb1_link refresh mode manual;
    alter pluggable database oe_refresh open read only;
    </copy>
    ````

3. Connect as **SOE** to the pluggable database **OE_REFRESH**` and count the number of records in the sale_orders table  

    ````
    <copy>
    conn soe/soe@localhost:1524/oe_refresh
    select count(*) from sale_orders;
    </copy>
    ````

4. Close the pluggable database **OE_REFRESH**` and refresh it from the **OE** pluggable database  

    ````
    <copy>
    conn sys/oracle@localhost:1524/oe_refresh as sysdba

    alter pluggable database oe_refresh close;

    alter session set container=oe_refresh;
    alter pluggable database oe_refresh refresh;
    alter pluggable database oe_refresh open read only;
    </copy>
    ````

5. Connect as **SOE** to the pluggable dataabse **OE_REFRESH**` and count the number of records in the **sale_orders** table. You should see the number of records change.  

    ````
    <copy>
    conn soe/soe@localhost:1524/oe_refresh
    select count(*) from sale_orders;
    </copy>
    ````

6. Close and remove the **OE_DEV** pluggable database  

    ````
    <copy>
    conn sys/oracle@localhost:1524/cdb2 as sysdba

    alter pluggable database oe_refresh close;
    drop pluggable database oe_refresh including datafiles;
    </copy>
    ````

7. Leave the **OE** pluggable database open with the load running against it for the rest of the labs.


## Step 9: PDB Relocation

This section looks at how to relocate a pluggable database from one container database to another. One important note, either both container databases need to be using the same listener in order for sessions to keep connecting or local and remote listeners need to be setup correctly. For this lab we will change **CDB2** to use the same listener as **CDB1**.

The tasks you will accomplish in this lab are:
- Change **CDB2** to use the same listener as **CDB1**
- Relocate the pluggable database **OE** from **CDB1** to **CDB2** with the load still running
- Once **OE** is open the load should continue working.

1. Change **CDB2** to use the listener **LISTCDB1**  

    ````
    <copy>
    sqlplus /nolog
    conn sys/oracle@localhost:1524/cdb2 as sysdba;
    alter system set local_listener='LISTCDB1' scope=both;
    </copy>
    ````

2. Connect to **CDB2** and relocate **OE** using the database link **oe@cdb1_link**  

    ````
    <copy>
    conn sys/oracle@localhost:1523/cdb2 as sysdba;
    create pluggable database oe from oe@cdb1_link relocate;
    alter pluggable database oe open;
    show pdbs
    </copy>
    ````

3. Connect to **CDB1** and see what pluggable databases exist there  

    ````
    <copy>
    conn sys/oracle@localhost:1523/cdb1 as sysdba
    show pdbs
    </copy>

    ````

4. Close and remove the **OE** pluggable database  

    ````
    <copy>
    conn sys/oracle@localhost:1523/cdb2 as sysdba

    alter pluggable database oe close;
    drop pluggable database oe including datafiles;
    </copy>
    ````

5. The load program isn't needed anymore and that window can be closed.

6. If you are going to continue to use this environment you will need to change **CDB2** back to use **LISTCDB2**

    ````
    <copy>
    sqlplus /nolog
    conn sys/oracle@localhost:1523/cdb2 as sysdba;
    alter system set local_listener='LISTCDB2' scope=both;
    </copy>
    ````

## Lab Cleanup

1. Reset the container databases back to their original ports. If any errors about dropping databases appear they can be ignored.

    ````
    ./resetCDB.sh
    ````

Now you've had a chance to try out the Multitenant option. You were able to create, clone, plug and unplug a pluggable database. You were then able to accomplish some advanced tasks that you could leverage when maintaining a large multitenant environment. 

## Acknowledgements

- **Author** - Patrick Wheeler, VP, Multitenant Product Management
- **Adapted to Cloud by** -  David Start, OSPA
- **Last Updated By/Date** - Kay Malcolm, Director, DB Product Management, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).