# Upgrade to 19c using unplug and plug of Pluggable Databases #

In this lab will be show the how easy it is to unplug an existing Pluggable Database and plug it into an Oracle Home that has either been patched or upgraded to a new version.

## Disclaimer ##
The following is intended to outline our general product direction. It is intended for information purposes only, and may not be incorporated into any contract. It is not a commitment to deliver any material, code, or functionality, and should not be relied upon in making purchasing decisions. The development, release, and timing of any features or functionality described for Oracle’s products remains at the sole discretion of Oracle.

## Prerequisites ##

- You have access to the Upgrade to a 19c Hands-on-Lab client image
- A new 19c database has been created in this image
- All databases in the image are running

When in doubt or need to start the databases, please login as **oracle** user and execute the following command:

````
$ <copy>. oraenv</copy>
````
Please enter the SID of the 19c database that you have created in the first lab. In this example, the SID is **`19C`**
````
ORACLE_SID = [oracle] ? <copy>DB19C</copy>
The Oracle base has been set to /u01/app/oracle
````
Now execute the command to start all databases listed in the `/etc/oratab` file:

````
$ <copy>dbstart $ORACLE_HOME</copy>
````

The output should be similar to this:
````
Processing Database instance "DB112": log file /u01/app/oracle/product/11.2.0/dbhome_112/rdbms/log/startup.log
Processing Database instance "DB121C": log file /u01/app/oracle/product/12.1.0/dbhome_121/rdbms/log/startup.log
Processing Database instance "DB122": log file /u01/app/oracle/product/12.2.0/dbhome_122/rdbms/log/startup.log
Processing Database instance "DB18C": log file /u01/app/oracle/product/18.1.0/dbhome_18c/rdbms/log/startup.log
Processing Database instance "DB19C": log file /u01/app/oracle/product/19.3.0/dbhome_19c/rdbms/log/startup.log
````

## Check the current status of the source PDBs ##

Please log in as the Oracle user to check the status of the source database and pluggable databases.

### Set the environment for the 18c database ###

````
$ <copy>. oraenv</copy>
````
Enter the database 18c SID when requested:

````
ORACLE_SID = [oracle] ? <copy>DB18C</copy>
The Oracle base remains unchanged with value /u01/app/oracle
````

Now we can login as sysdba and check the status of the database

````
$ <copy>sqlplus / as sysdba</copy>

SQL*Plus: Release 18.0.0.0.0 - Production on Fri Mar 22 16:45:06 2019
Version 18.3.0.0.0

Copyright (c) 1982, 2018, Oracle.  All rights reserved.

Connected to:
Oracle Database 18c Enterprise Edition Release 18.0.0.0.0 - Production
Version 18.3.0.0.0
````

We can check the status of the PDBs in this container database using the command `show pdbs`:

````
SQL> <copy>show pdbs</copy>

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB18C01                       MOUNTED
````

So we have 1 PDB running in this environment in MOUNTED mode. In this lab we will migrate this PDB from the DB18C environment to the new 19c environment.
 
## Unplugging the source pluggable database ##

There are many ways to migrate a PDB to a new CDB. Some will keep the datafiles in place, other options will recreate the datafiles (double your storage size). If you are moving the datafiles to another storage system, you can for example use the Pluggable Archive option (all files will be put into 1 'ziptfile' with .pdb extension).

In the following lab, we will keep the datafiles on the same system but move them to another location. This can be done in a single command from SQL*Plus. After the migration to the new location, we can upgrade the PDB.

### UNPLUG THE PDB ###
In the next example we assume you are already connected as sysdba to the DB18C database as described in the previous chapter.

Execute the following command to unplug the PDB and write an .xml descriptor file to a filesystem location. 

````
SQL> <copy>alter pluggable database PDB18C01 unplug into '/u01/PDB18C01.xml';</copy>

Pluggable database altered.
````

We will now disconnect from the source database so we can continue with the import of the PDB.

````
SQL> <copy>exit</copy>

Disconnected from Oracle Database 18c Enterprise Edition Release 18.0.0.0.0 - Production
Version 18.3.0.0.0
````

## Plug the PDB into the target 19c environment ##

First, we need to change the environment settings to the 19c environment:

````
$ <copy>. oraenv</copy>
````

Please enter the SID of the 19c database when asked:

````
ORACLE_SID = [DB18C] ? <copy>DB19C</copy>
The Oracle base remains unchanged with value /u01/app/oracle
````

We can now login with SQL*Plus as sysdba to execute the import of the PDB:

````
$ <copy>sqlplus / as sysdba</copy>

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Mar 25 13:48:55 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
````

After connecting as sysdba to the target database, we can plug in the PDB. As part of the plug-in process, we can also move (or copy) the datafiles if needed. In our example, we want the database files to move from the old 18c datafiles location to the new 19c datafile location:

````
SQL> <copy>create pluggable database PDB18C01 using '/u01/PDB18C01.xml'
     move
     file_name_convert = ('/DB18C/','/DB19C/');</copy>

Pluggable database created.
````

The `move` clause means that all relevant files should be moved to the new location. Using the `file_name_convert`, you can determine what the new location should be.

Check that our datafiles are stored in the 19c datafile location:

````
SQL> <copy>select name from v$datafile
     where name like '%18C01%';</copy>

NAME
-------------------------------------------
/u01/oradata/DB19C/PDB18C01/system01.dbf
/u01/oradata/DB19C/PDB18C01/sysaux01.dbf
/u01/oradata/DB19C/PDB18C01/undotbs01.dbf
/u01/oradata/DB19C/PDB18C01/users01.dbf
````

The above example also shows that it is a **bad** custom to put the version name of the PDB in the name of the PDB. As displayed, it looks really strange to have a `PDB18C01` in the CDB19 location.

## Upgrade the imported Pluggable Database ##

We cannot just open the PDB in the new 19c Oracle Home. If you would try to open it, it would fail since it does not have the correct 19c objects in its schema.

To upgrade the PDB, first open it in upgrade mode:

````
SQL> <copy>alter pluggable database PDB18C01 open upgrade;</copy>

Pluggable database altered.
````

We now need to upgrade the pluggable database as the PDB also contains a data dictionary and objects (which are still of the old version). When you upgrade a PDB, you use the commands you normally use with the Parallel Upgrade Utility. However, you also add the option **`-c PDBname`** to specify which PDB you are upgrading. 

Make sure to capitalize the name of your PDB while using this option.

Exit SQL*Plus and upgrade the PDB using `catctl.pl`:

````
SQL> <copy>exit</copy>
````
````
$ <copy>$ORACLE_HOME/perl/bin/perl $ORACLE_HOME/rdbms/admin/catctl.pl \
  -d $ORACLE_HOME/rdbms/admin \
  -c 'PDB18C01' \
  -l $ORACLE_BASE catupgrd.sql</copy>
````

A similar output should be visible:

````
Argument list for [/u01/app/oracle/product/19.0.0/dbhome_193/rdbms/admin/catctl.pl]
For Oracle internal use only A = 0
Run in                       c = PDB18C01
Do not run in                C = 0
Input Directory              d = /u01/app/oracle/product/19.0.0/dbhome_193/rdbms/admin
...
````
After about 30 minutes the upgrade will be done (longer if you have other upgrades running in parallel):
````
...
Serial   Phase #:105  [PDB18C01] Files:1    Time: 1s
Serial   Phase #:106  [PDB18C01] Files:1    Time: 1s
Serial   Phase #:107  [PDB18C01] Files:1     Time: 0s

------------------------------------------------------
Phases [0-107]         End Time:[2019_03_25 15:36:25]
Container Lists Inclusion:[PDB18C01] Exclusion:[NONE]
------------------------------------------------------

Grand Total Time: 1839s [PDB18C01]

 LOG FILES: (/u01/app/oracle/catupgrdpdb18c01*.log)

Upgrade Summary Report Located in:
/u01/app/oracle/upg_summary.log

     Time: 1846s For PDB(s)

Grand Total Time: 1846s

 LOG FILES: (/u01/app/oracle/catupgrd*.log)


Grand Total Upgrade Time:    [0d:0h:30m:46s]
````

After the upgrade, the PDB will be left in a `CLOSED` or `MOUNT` state. Before we can work with the PDB we need to open it in normal read/write mode

````
$ <copy>sqlplus / as sysdba</copy>

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Mar 25 13:48:55 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
````

After logging in, we can change the pluggable database to normal `open` mode:

````
SQL> <copy>alter pluggable database PDB18C01 open;</copy>

Pluggable database altered.
````

If no errors occur, we can login with SQL*Plus and check the invalid objects in the database:

````
SQL> <copy>alter session set container=PDB18C01;</copy>

Session altered.
````

````
SQL> <copy>select COUNT(*) FROM obj$ WHERE status IN (4, 5, 6);</copy>

  COUNT(*)
----------
      1467
````

If there are any invalid objects, you can recompile them using the `utlrp.sql` script:

````
SQL> <copy>@$ORACLE_HOME/rdbms/admin/utlrp.sql</copy>

Session altered.


TIMESTAMP
--------------------------------------------------------------------------------
COMP_TIMESTAMP UTLRP_BGN              2019-03-25 15:59:31

DOC>   The following PL/SQL block invokes UTL_RECOMP to recompile invalid
DOC>   objects in the database. Recompilation time is proportional to the
DOC>   number of invalid objects in the database, so this command may take

<....>

DOC> fixed before objects can compile successfully.
DOC> Note: Typical compilation errors (due to coding errors) are not
DOC>       logged into this table: they go into DBA_ERRORS instead.
DOC>#

ERRORS DURING RECOMPILATION
---------------------------
                          0

Function created.

PL/SQL procedure successfully completed.

Function dropped.

PL/SQL procedure successfully completed.
````

Your database is now migrated to a new $ORACLE_HOME and upgraded.

## Acknowledgements ##

- Author - Robert Pastijn, DB Dev Product Management, PTS EMEA - March 2020
