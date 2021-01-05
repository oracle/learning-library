# Synchronizing Multiple Applications In Application PDBs

## Introduction

This lab shows how to reduce the number of synchronization statements when you have to synchronize multiple applications in application PDBs. In previous Oracle Database versions, you had to execute as many synchronization statements as applications.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Set up the environment

1. Install the `TOYS_APP` and the `SALES_TOYS_APP` applications in the `TOYS_ROOT` application container for both `ROBOTS` and `DOLLS` application PDBs. The script defines the application container, installs the two applications in the application container, and finally creates the two application PDBs in the application container.

2. To be able to connect during the shell script execution to `TOYS_ROOT`, `ROBOTS` and `DOLLS`, create the entries in the `tnsnames.ora` file as explained in [practices environment](https://docs-uat.us.oracle.com/en/database/oracle/oracle-database/21/ftnew/practices-environment1.html#GUID-467FB8FF-C8CC-48A0-B39A-5F7E7B9A9CF8__GUID-08108F3C-C78A-45B7-8452-6985DF9EF1DD).

3. Execute the shell script.

    ```

    $ <copy>cd /home/oracle/labs/M104780GC10</copy>
    $ <copy>/home/oracle/labs/M104780GC10/setup_apps.sh</copy>
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
    SQL> ALTER PLUGGABLE DATABASE toys_root CLOSE IMMEDIATE;

    Pluggable database altered.

    SQL> DROP PLUGGABLE DATABASE robots INCLUDING DATAFILES;

    Pluggable database dropped.

    SQL> DROP PLUGGABLE DATABASE dolls INCLUDING DATAFILES;

    Pluggable database dropped.

    SQL> DROP PLUGGABLE DATABASE toys_root INCLUDING DATAFILES;

    Pluggable database dropped.

    SQL> ALTER SESSION SET db_create_file_dest='/home/oracle/labs/toys_root';

    Session altered.

    SQL> CREATE PLUGGABLE DATABASE toys_root AS APPLICATION CONTAINER
      2    ADMIN USER admin IDENTIFIED BY <i>WElcome123##</i> ROLES=(CONNECT);

    Pluggable database created.

    ...

    SQL> alter pluggable database dolls open;

    Pluggable database altered.

    SQL>
    SQL> exit
    $

    ```

## **STEP 2:** Display the applications installed

1. Display the applications installed

	  ```

	$ <copy>sqlplus / AS SYSDBA</copy>

	Connected to:

	SQL> <copy>COL app_name FORMAT A16</copy>
	SQL> <copy>COL app_version FORMAT A12</copy>
	SQL> <copy>COL pdb_name FORMAT A10</copy>
	SQL> <copy>SELECT app_name, app_version, app_status, p.pdb_name
		FROM   cdb_applications a, cdb_pdbs p
		WHERE  a.con_id = p.pdb_id
		AND    app_name NOT LIKE '%APP$%'
		ORDER BY 1;</copy>

	APP_NAME         APP_VERSION  APP_STATUS   PDB_NAME
	---------------- ------------ ------------ ----------
	SALES_TOYS_APP   1.0          NORMAL       TOYS_ROOT
	TOYS_APP         1.0          NORMAL       TOYS_ROOT

	SQL> <copy>exit;</copy>

	  ```

  Observe that the applications are installed in the application container at version 1.0.

## **STEP 3:** Synchronize the application PDBs

1. Synchronize the application PDBs with the new applications.

    ```
	  <copy>sqlplus sys@localhost:1521/robots AS SYSDBA</copy>

	  Enter password: WElcome123##
    ```
    ```

	  SQL> <copy>ALTER PLUGGABLE DATABASE APPLICATION toys_app, sales_toys_app SYNC;</copy>

	  Pluggable database altered.

	  SQL>

  	```

2. Display the applications installed in the application container.


	  ```

	  SQL> <copy>SELECT app_name, app_version, app_status, p.pdb_name
		FROM   cdb_applications a, cdb_pdbs p
		WHERE  a.con_id = p.pdb_id
		AND    app_name NOT LIKE '%APP$%'
		ORDER BY 1;</copy>

	APP_NAME         APP_VERSION  APP_STATUS   PDB_NAME

	---------------- ------------ ------------ ----------

	SALES_TOYS_APP   1.0          NORMAL       ROBOTS

	TOYS_APP         1.0          NORMAL       ROBOTS

  SQL><copy>exit;</copy>
    ```
    ```

	<copy>sqlplus sys@localhost:1521/dolls AS SYSDBA</copy>

	Enter password: <b><i>WElcome123##</i></b>
    ```
    ```

	SQL> <copy>ALTER PLUGGABLE DATABASE APPLICATION toys_app, sales_toys_app SYNC;</copy>

	Pluggable database altered.

	SQL> <copy>SELECT app_name, app_version, app_status, p.pdb_name
		FROM   cdb_applications a, cdb_pdbs p
		WHERE  a.con_id = p.pdb_id
		AND    app_name NOT LIKE '%APP$%'
		ORDER BY 1;</copy>

	APP_NAME         APP_VERSION  APP_STATUS   PDB_NAME

	---------------- ------------ ------------ ----------

	SALES_TOYS_APP   1.0          NORMAL       DOLLS

	TOYS_APP         1.0          NORMAL       DOLLS

	SQL> <copy>CONNECT / AS SYSDBA</copy>

	Connected.

	SQL> <copy>SELECT app_name, app_version, app_status, p.pdb_name
		FROM   cdb_applications a, cdb_pdbs p
		WHERE  a.con_id = p.pdb_id
		AND    app_name NOT LIKE '%APP$%'
		ORDER BY 1;</copy>  

	APP_NAME         APP_VERSION  APP_STATUS   PDB_NAME

	---------------- ------------ ------------ ----------

	SALES_TOYS_APP   1.0          NORMAL       DOLLS

	SALES_TOYS_APP   1.0          NORMAL       ROBOTS

	SALES_TOYS_APP   1.0          NORMAL       TOYS_ROOT

	TOYS_APP         1.0          NORMAL       DOLLS

	TOYS_APP         1.0          NORMAL       TOYS_ROOT

	TOYS_APP         1.0          NORMAL       ROBOTS

	6 rows selected.

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
