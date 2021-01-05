# Preventing Local Users from Blocking Common Operations - Realms

## Introduction
This lab shows how to prevent local users from creating Oracle Database Vault controls on common users objects which would prevent common users from accessing local data in their own schema in PDBs. A PDB local Database Vault Owner can create a realm around common Oracle schemas like `DVSYS` or `CTXSYS` and prevent it functioning correctly. For the purposes of this practice, the `C##TEST1` custom schema is created in CDB root to show this feature.

Estimated Lab Time: 40 minutes

### Objectives

In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup

## **STEP 1:** Configure and enable Database Vault at the CDB and PDB levels

1. Configure and enable Database Vault at the CDB root level and at the PDB level. The script creates the `HR.G_EMP` table in the root container and also the `HR.L_EMP` table in `PDB21`.


    ```

    $ <copy>cd /home/oracle/labs/M104781GC10</copy>

    $ <copy>/home/oracle/labs/M104781GC10/setup_DV.sh</copy>

    $ ./setup_DV_CDB.sh

    ...

    SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY <i>WElcome123##</i> container=all;

    keystore altered.

    ...

    SQL> create user c##sec_admin identified by <i>WElcome123##</i> container=ALL;

    User created.

    SQL> grant create session, set container, restricted session, DV_OWNER to c##sec_admin container=ALL;

    Grant succeeded.

    SQL> drop user c##accts_admin cascade;

    drop user c##accts_admin cascade

              *

    ERROR at line 1:

    ORA-01918: user 'C##ACCTS_ADMIN' does not exist

    SQL> create user c##accts_admin identified by <i>WElcome123##</i> container=ALL;

    User created.

    SQL> grant create session, set container, DV_ACCTMGR to c##accts_admin container=ALL;

    Grant succeeded.

    SQL> grant select on sys.dba_dv_status to c##accts_admin container=ALL;

    Grant succeeded.

    SQL> EXIT

    ...

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Last Successful login time: Tue Feb 18 2020 08:26:21 +00:00

    SQL> DROP TABLE g_emp;

    Table dropped.

    SQL> CREATE TABLE g_emp(name CHAR(10), salary NUMBER) ;

    Table created.

    SQL> INSERT INTO g_emp values('EMP_GLOBAL',1000);

    1 row created.

    SQL> COMMIT;

    Commit complete.

    SQL> EXIT

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Last Successful login time: Tue Feb 18 2020 08:27:54 +00:00

    Connected to:

    SQL> DROP TABLE l_emp;

    Table dropped.

    SQL> CREATE TABLE l_emp(name CHAR(10), salary NUMBER);

    Table created.

    SQL> INSERT INTO l_emp values('EMP_LOCAL',2000);

    1 row created.

    SQL> COMMIT;

    Commit complete.

    SQL> EXIT

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Last Successful login time: Tue Feb 18 2020 08:27:54 +00:00

    Connected to:

    SQL> DROP TABLE l_tab;

    Table dropped.

    SQL> CREATE TABLE l_tab(code NUMBER);

    Table created.

    SQL> INSERT INTO l_tab values(1);

    1 row created.

    SQL> INSERT INTO l_tab values(2);

    1 row created.

    SQL> COMMIT;

    Commit complete.

    SQL> EXIT

    $

    ```

## **STEP 2:** Test table data accessibility with no realm on common objects

1. Connect to the CDB root as `C##SEC_ADMIN` to verify the status of `DV_ALLOW_COMMON_OPERATION`. This is the default behavior: it allows local users to create Database Vault controls on common users objects.


    ```

    $ <copy>sqlplus c##sec_admin</copy>

    Enter password: <i>WElcome123##</i>
    ```
    ```

    SQL> <copy>SELECT * FROM DVSYS.DBA_DV_COMMON_OPERATION_STATUS;</copy>

    NAME                      STATU

    ------------------------- -----

    DV_ALLOW_COMMON_OPERATION FALSE

    SQL>

    ```

2. Connect to the CDB root as `C##TEST1`, the table common owner.


    ```

    SQL> <copy>CONNECT c##test1</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY

    ---------- ----------

    EMP_GLOBAL       1000

    SQL>

    ```

3. Connect to the CDB root as `C##TEST2`, another common user.


    ```

    SQL> <copy>CONNECT c##test2</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY

    ---------- ----------

    EMP_GLOBAL       1000

    SQL>

    ```

4. Connect to `PDB21` as `C##TEST1`, the table common owner.


    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY

    ---------- ----------

    EMP_LOCAL        2000

    SQL>

    ```

5. Connect to `PDB21` as `C##TEST2`, another common user.


    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY

    ---------- ----------

    EMP_LOCAL        2000

    SQL>

    ```

## **STEP 3:** Test table data accessibility with a common regular or mandatory realm on common objects

1. Create a common regular realm on `C##TEST1` tables in the CDB root.


    ```

    SQL> <copy>CONNECT c##sec_admin</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.CREATE_REALM(
      realm_name    => 'Root Test Realm',
      description   => 'Test Realm description',
      enabled       => DBMS_MACUTL.G_YES,
      audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL,
      realm_type    => 0);
    END;
    /</copy>  2    3    4    5    6    7    8    9

    PL/SQL procedure successfully completed.

    SQL> <copy>BEGIN
    DBMS_MACADM.ADD_OBJECT_TO_REALM(
      realm_name   => 'Root Test Realm',
      object_owner => 'C##TEST1',
      object_name  => '%',
      object_type  => '%');
    END;
    /</copy>  2    3    4    5    6    7    8

    PL/SQL procedure successfully completed.

    SQL>

    ```

2. Connect to the CDB root as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

3. Connect to the CDB root as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>
    SELECT * FROM c##test1.g_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges

    SQL>

    ```

4. Connect to `PDB21` as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

5. Connect to `PDB21` as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

6. Drop the realm.

    ```

    SQL> <copy>CONNECT c##sec_admin</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>EXEC DBMS_MACADM.DELETE_REALM_CASCADE('Root Test Realm')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

7. Create a common mandatory realm on `C##TEST1` tables in the CDB root.


    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.CREATE_REALM(
    realm_name    => 'Root Test Realm',
    description   => 'Test Realm description',
    enabled       => DBMS_MACUTL.G_YES,
    audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL,
    realm_type    => 1);
    END;
    /</copy>  2    3    4    5    6    7    8    9

    PL/SQL procedure successfully completed.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.ADD_OBJECT_TO_REALM(
    realm_name   => 'Root Test Realm',
    object_owner => 'C##TEST1',
    object_name  => '%',
    object_type  => '%');
    END;
    /</copy>  2    3    4    5    6    7    8

    PL/SQL procedure successfully completed.

    SQL>

    ```

8. Connect to the CDB root as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>
    SELECT * FROM c##test1.g_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges


    SQL>

    ```

9. Connect to the CDB root as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>
    SELECT * FROM c##test1.g_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges


    SQL>

    ```

10. Connect to `PDB21` as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

11. Connect to `PDB21` as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

12. Drop the realm.

    ```

    SQL> <copy>CONNECT c##sec_admin</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>EXEC DBMS_MACADM.DELETE_REALM_CASCADE('Root Test Realm')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

## **STEP 4:** Test table data accessibility on common objects with a PDB regular or mandatory realm

1. Create a PDB regular realm on `C##TEST1` tables in `PDB21`.


    ```

    SQL> <copy>CONNECT sec_admin@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.CREATE_REALM(
      realm_name    => 'Test Realm',
      description   => 'Test Realm description',
      enabled       => DBMS_MACUTL.G_YES,
      audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL,
      realm_type    => 0);
    END;
    /</copy>  2    3    4    5    6    7    8    9

    PL/SQL procedure successfully completed.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.ADD_OBJECT_TO_REALM(
      realm_name   => 'Test Realm',
      object_owner => 'C##TEST1',
      object_name  => '%',
      object_type  => '%');
    END;
    /</copy>  2    3    4    5    6    7    8

    PL/SQL procedure successfully completed.

    SQL>

    ```

2. Connect to the CDB root as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

3. Connect to the CDB root as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

4. Connect to `PDB21` as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

5. Connect to `PDB21` as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>
    SELECT * FROM c##test1.l_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges

    SQL>

    ```

6. Drop the realm.

    ```

    SQL> <copy>CONNECT c##sec_admin@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>EXEC DBMS_MACADM.DELETE_REALM_CASCADE('Test Realm')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

7. Create a PDB mandatory realm on `C##TEST1` tables in `PDB21`.


    ```

    SQL> <copy>CONNECT sec_admin@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.CREATE_REALM(
      realm_name    => 'Test Realm',
      description   => 'Test Realm description',
      enabled       => DBMS_MACUTL.G_YES,
      audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL,
      realm_type    => 1);
    END;
    /</copy>  2    3    4    5    6    7    8    9

    PL/SQL procedure successfully completed.
    ```
    ```
    SQL> <copy>BEGIN
    DBMS_MACADM.ADD_OBJECT_TO_REALM(
      realm_name   => 'Test Realm',
      object_owner => 'C##TEST1',
      object_name  => '%',
      object_type  => '%');
    END;
    /</copy>  2    3    4    5    6    7    8

    PL/SQL procedure successfully completed.

    SQL>

    ```

8. Connect to the CDB root as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

9. Connect to the CDB root as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

10. Connect to `PDB21` as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>
    SELECT * FROM c##test1.l_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges

    SQL>

    ```

11. Connect to `PDB21` as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>
    SELECT * FROM c##test1.l_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges

    SQL>

    ```

12. Drop the realm.

    ```

    SQL> <copy>CONNECT c##sec_admin@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>EXEC DBMS_MACADM.DELETE_REALM_CASCADE('Test Realm')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

## **STEP 5:** Restrict local users from creating Oracle Database Vault controls on common objects

1. Restrict the local users from creating Oracle Database Vault controls on common objects.

    ```

    SQL> <copy>CONNECT c##sec_admin</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM DVSYS.DBA_DV_COMMON_OPERATION_STATUS;</copy>

    NAME                      STATU
    ------------------------- -----
    DV_ALLOW_COMMON_OPERATION FALSE

    SQL> <copy>EXEC DBMS_MACADM.ALLOW_COMMON_OPERATION</copy>

    PL/SQL procedure successfully completed.

    SQL> <copy>SELECT * FROM DVSYS.DBA_DV_COMMON_OPERATION_STATUS;</copy>

    NAME                      STATU
    ------------------------- -----
    DV_ALLOW_COMMON_OPERATION TRUE

    SQL>

    ```

## **STEP 6:** Test table data accessibility with a common regular or mandatory realm on common objects

1. Create a common regular realm on `C##TEST1` tables in the CDB root.


    ```

    SQL> <copy>CONNECT c##sec_admin</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.CREATE_REALM(
      realm_name    => 'Root Test Realm',
      description   => 'Test Realm description',
      enabled       => DBMS_MACUTL.G_YES,
      audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL,
      realm_type    => 0);
    END;
    /</copy>  2    3    4    5    6    7    8    9

    PL/SQL procedure successfully completed.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.ADD_OBJECT_TO_REALM(
      realm_name   => 'Root Test Realm',
      object_owner => 'C##TEST1',
      object_name  => '%',
      object_type  => '%');
    END;
    /</copy>  2    3    4    5    6    7    8

    PL/SQL procedure successfully completed.

    SQL>

    ```

2. Connect to the CDB root as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

3. Connect to the CDB root as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>
    SELECT * FROM c##test1.g_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges

    SQL>

    ```

4. Connect to `PDB21` as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

5. Connect to `PDB21` as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

6. Drop the realm.

    ```

    SQL> <copy>CONNECT c##sec_admin</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>EXEC DBMS_MACADM.DELETE_REALM_CASCADE('Root Test Realm')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

7. Create a common mandatory realm on `C##TEST1` tables in the CDB root.


    ```

    SQL> <copy>BEGIN
   DBMS_MACADM.CREATE_REALM(
    realm_name    => 'Root Test Realm',
    description   => 'Test Realm description',
    enabled       => DBMS_MACUTL.G_YES,
    audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL,
    realm_type    => 1);
  END;
  /</copy>  2    3    4    5    6    7    8    9

  PL/SQL procedure successfully completed.
  ```
  ```

  SQL> <copy>BEGIN
   DBMS_MACADM.ADD_OBJECT_TO_REALM(
    realm_name   => 'Root Test Realm',
    object_owner => 'C##TEST1',
    object_name  => '%',
    object_type  => '%');
    END;
    /</copy>  2    3    4    5    6    7    8

    PL/SQL procedure successfully completed.

    SQL>

    ```




8. Connect to the CDB root as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>
    SELECT * FROM c##test1.g_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges


    SQL>

    ```

9. Connect to the CDB root as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>
    SELECT * FROM c##test1.g_emp
                           *
    ERROR at line 1:
    ORA-01031: insufficient privileges


    SQL>

    ```

10. Connect to `PDB21` as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

11. Connect to `PDB21` as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

12. Drop the realm.

    ```

    SQL> <copy>CONNECT c##sec_admin</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>EXEC DBMS_MACADM.DELETE_REALM_CASCADE('Root Test Realm')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

## **STEP 7:** Test table data accessibility on common objects with a PDB regular or mandatory realm

1. Create a PDB regular realm on `C##TEST1` tables in `PDB21`.


    ```

    SQL> <copy>CONNECT sec_admin@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.CREATE_REALM(
    realm_name    => 'Test Realm1',
    description   => 'Test Realm description',
    enabled       => DBMS_MACUTL.G_YES,
    audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL,
    realm_type    => 0);
    END;
    /</copy>  2    3    4    5    6    7    8    9

    PL/SQL procedure successfully completed.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.ADD_OBJECT_TO_REALM(
    realm_name   => 'Test Realm1',
    object_owner => 'C##TEST1',
    object_name  => '%',
    object_type  => '%');
    END;
    /</copy>  2    3    4    5    6    7    8

    BEGIN

    *

    ERROR at line 1:

    ORA-47286: cannot add %, C##TEST1.%  to a realm

    ORA-06512: at "DVSYS.DBMS_MACADM", line 1059

    ORA-06512: at line 2

    SQL> <copy>!oerr ora 47286</copy>

    47286, 00000, "cannot add %s, %s.%s  to a realm"

    // *Cause: When ALLOW COMMON OPERATION was set to TRUE, a smaller scope user was not allowed to add a larger scope user's object or a larger scope role to a realm.

    // *Action: When ALLOW COMMON OPERATION is TRUE, do not add a larger scope user's object or a larger scope role to a realm.

    SQL>

    ```

2. Connect to the CDB root as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

3. Connect to the CDB root as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

4. Connect to `PDB21` as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

5. Connect to `PDB21` as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

6. Drop the realm.

    ```

    SQL> <copy>CONNECT c##sec_admin@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>EXEC DBMS_MACADM.DELETE_REALM_CASCADE('Test Realm1')</copy>

    PL/SQL procedure successfully completed.

    SQL>

    ```

7. Create a PDB mandatory realm on `C##TEST1` tables in `PDB21`.


    ```

    SQL> <copy>CONNECT sec_admin@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.CREATE_REALM(
      realm_name    => 'Test Realm1',
      description   => 'Test Realm description',
      enabled       => DBMS_MACUTL.G_YES,
      audit_options => DBMS_MACUTL.G_REALM_AUDIT_FAIL,
      realm_type    => 1);
    END;
    /</copy>  2    3    4    5    6    7    8    9

    PL/SQL procedure successfully completed.
    ```
    ```

    SQL> <copy>BEGIN
    DBMS_MACADM.ADD_OBJECT_TO_REALM(
      realm_name   => 'Test Realm1',
      object_owner => 'C##TEST1',
      object_name  => '%',
      object_type  => '%');
    END;
    /</copy>  2    3    4    5    6    7    8

    BEGIN

    *

    ERROR at line 1:

    ORA-47286: cannot add %, C##TEST1.%  to a realm

    ORA-06512: at "DVSYS.DBMS_MACADM", line 1059

    ORA-06512: at line 2

    SQL>

    ```

8. Connect to the CDB root as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

9. Connect to the CDB root as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.g_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_GLOBAL       1000

    SQL>

    ```

10. Connect to `PDB21` as `C##TEST1`, the table common owner.

    ```

    SQL> <copy>CONNECT c##test1@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

11. Connect to `PDB21` as `C##TEST2`, another common user.

    ```

    SQL> <copy>CONNECT c##test2@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>SELECT * FROM c##test1.l_emp;</copy>

    NAME           SALARY
    ---------- ----------
    EMP_LOCAL        2000

    SQL>

    ```

12. Drop the realm.

    ```

    SQL> <copy>CONNECT sec_admin@PDB21</copy>
    Enter password: <i>WElcome123##</i>
    Connected.
    ```
    ```
    SQL> <copy>EXEC DBMS_MACADM.DELETE_REALM_CASCADE('Test Realm1')</copy>

    PL/SQL procedure successfully completed.

    SQL> <copy>EXIT</copy>
    $

    ```

## **STEP 8:** Summary

Let's summarize the behavior of data access on common users objects in PDBs when you switch the `DV_ALLOW_COMMON_OPERATION` value.

<table class="wrapped confluenceTable" style="margin-left: 30.0px;"><colgroup> <col/> <col/> <col/> <col/> <col/> <col/> <col/> </colgroup><tbody><tr><th class="confluenceTh"></th><th class="confluenceTh">`FALSE`</th><th class="confluenceTh"></th><th class="confluenceTh"></th><th class="confluenceTh">`TRUE`</th><th class="confluenceTh"></th><th class="confluenceTh"></th></tr><tr><td class="confluenceTd"></td><td class="confluenceTd"></td><td class="confluenceTd">`C##TEST1`</td><td class="confluenceTd">`C##TEST2`</td><td class="confluenceTd"></td><td class="confluenceTd">`C##TEST1`</td><td class="confluenceTd">`C##TEST2`</td></tr><tr><td class="confluenceTd">Common Regular or Mandatory Realm in CDB root</td><td class="confluenceTd"></td><td class="confluenceTd">No change</td><td class="confluenceTd">No change</td><td class="confluenceTd"></td><td class="confluenceTd">No change</td><td class="confluenceTd">No change</td></tr><tr><td class="confluenceTd">PDB Regular Realm</td><td class="confluenceTd"></td><td class="confluenceTd">Access</td><td class="confluenceTd">Blocked</td><td class="confluenceTd"></td><td class="confluenceTd">Access</td><td class="confluenceTd">**Access**</td></tr><tr><td class="confluenceTd">PDB Mandatory Realm</td><td class="confluenceTd"></td><td class="confluenceTd">Blocked</td><td class="confluenceTd">Blocked</td><td class="confluenceTd"></td><td class="confluenceTd">**Access**</td><td class="confluenceTd">**Access**</td></tr></tbody>
</table>

- If you create a regular or mandatory realm in the CDB root and a regular or mandatory PDB realm, and if `DV_ALLOW_COMMON_OPERATION` is `TRUE`, then data of common users objects is accessible.

- If local realms had been created when `DV_ALLOW_COMMON_OPERATION` was set to `FALSE`, they would still exist after the new control but enforcement would be ignored.

## **STEP 9:** Disable Database Vault in both the PDB and the CDB root

1. Run the `disable_DV.sh` script to disable Database Vault in both the PDB and the CDB root.


    ```

    $ <copy>/home/oracle/labs/M104781GC10/disable_DV.sh</copy>

    ...

    SQL> ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY <i>WElcome123##</i> WITH BACKUP CONTAINER=CURRENT;

    keystore altered.

    SQL> exit

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
