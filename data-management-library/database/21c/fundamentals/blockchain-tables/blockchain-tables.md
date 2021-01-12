# Managing Blockchain Tables and Rows

## Introduction

Blockchain tables are append-only tables in which only insert operations are allowed. Deleting rows is either prohibited or restricted based on time. Rows in a blockchain table are made tamper-resistant by special sequencing & chaining algorithms. Users can verify that rows have not been tampered. A hash value that is part of the row metadata is used to chain and validate rows.

Blockchain tables enable you to implement a centralized ledger model where all participants in the blockchain network have access to the same tamper-resistant ledger.

A centralized ledger model reduces administrative overheads of setting a up a decentralized ledger network, leads to a relatively lower latency compared to decentralized ledgers, enhances developer productivity, reduces the time to market, and leads to significant savings for the organization. Database users can continue to use the same tools and practices that they would use for other database application development.

Estimated Lab Time: 30 minutes

### Objectives
In this lab, you will:
* Create the blockchain table
* Insert and delete rows
* Drop the blockchain table
* Check the validity of rows in the blockchain table

### Prerequisites
* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Create the blockchain table

1. Create the AUDITOR user, owner of the blockchain table.

    ```

    $ <copy>cd /home/oracle/labs/M104781GC10</copy>

    $ <copy>/home/oracle/labs/M104781GC10/setup_user.sh</copy>

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

    ...

    specify password for HR as parameter 1:

    specify default tablespeace for HR as parameter 2:

    specify temporary tablespace for HR as parameter 3:

    specify log path as parameter 4:

    PL/SQL procedure successfully completed.

    ...

    SQL> Disconnected from Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production

    Version 21.2.0.0.0

    SQL*Plus: Release 21.0.0.0.0 - Production on Mon Mar 9 05:34:16 2020

    Version 21.2.0.0.0

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Connected to:

    Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production

    Version 21.2.0.0.0

    SQL> DROP USER auditor CASCADE;

    DROP USER auditor CASCADE

              *

    ERROR at line 1:

    ORA-01918: user 'AUDITOR' does not exist

    SQL> ALTER SYSTEM SET db_create_file_dest='/home/oracle/labs';

    System altered.

    SQL>

    SQL> DROP TABLESPACE ledgertbs INCLUDING CONTENTS AND DATAFILES cascade constraints;

    DROP TABLESPACE ledgertbs INCLUDING CONTENTS AND DATAFILES cascade constraints

    *

    ERROR at line 1:

    ORA-00959: tablespace 'LEDGERTBS' does not exist

    SQL> CREATE TABLESPACE ledgertbs;

    Tablespace created.

    SQL> CREATE USER auditor identified by password DEFAULT TABLESPACE ledgertbs;

    User created.

    SQL> GRANT create session, create table, unlimited tablespace TO auditor;

    Grant succeeded.

    SQL> GRANT execute ON sys.dbms_blockchain_table TO auditor;

    Grant succeeded.

    SQL> GRANT select ON hr.employees TO auditor;

    Grant succeeded.

    SQL>

    SQL> exit

    $

    ```

2. Create the blockchain table named `AUDITOR.LEDGER_EMP` that will maintain a tamper-resistant ledger of current and historical transactions about `HR.EMPLOYEES` in `PDB21`. Rows can never be deleted in the blockchain table `AUDITOR.LEDGER_EMP`. Moreover the blockchain table can be dropped only after 31 days of inactivity.


    ```

    $ <copy>sqlplus auditor@PDB21</copy>

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    Enter password:
    ```
    ```

    SQL> <copy>CREATE BLOCKCHAIN TABLE ledger_emp (employee_id NUMBER, salary NUMBER);</copy>

    CREATE BLOCKCHAIN TABLE ledger_emp (employee_id NUMBER, salary NUMBER)

                                                          *

    ERROR at line 1:

    ORA-00905: missing keyword

    SQL>

    ```

    - *Observe that the `CREATE BLOCKCHAIN TABLE` statement requires additional attributes. The `NO DROP`, `NO DELETE`, `HASHING USING`, and `VERSION` clauses are mandatory.*

    ```

    SQL> <copy>CREATE BLOCKCHAIN TABLE ledger_emp (employee_id NUMBER, salary NUMBER)
                        NO DROP UNTIL 31 DAYS IDLE
                        NO DELETE LOCKED
                        HASHING USING "SHA2_512" VERSION "v1";</copy>

    Table created.

    SQL>

    ```

3. Verify the attributes set for the blockchain table in the appropriate data dictionary view.


    ```

    SQL> <copy>SELECT row_retention, row_retention_locked,
                        table_inactivity_retention, hash_algorithm  
                  FROM   user_blockchain_tables
                  WHERE  table_name='LEDGER_EMP';</copy>

    ROW_RETENTION ROW TABLE_INACTIVITY_RETENTION HASH_ALG

    ------------- --- -------------------------- --------

                  YES                         31 SHA2_512

    SQL>

    ```

4. Show the description of the table.


    ```

    SQL> <copy>DESC ledger_emp</copy>

    Name                                      Null?    Type

    ----------------------------------------- -------- ----------------------------

    EMPLOYEE_ID                                        NUMBER

    SALARY                                             NUMBER

    SQL>

    ```

*Observe that the description displays only the visible columns.*



5. Use the `USER_TAB_COLS` view to display all internal column names used to store internal information like the users number, the users signature.


    ```

    SQL> <copy>COL "Data Length" FORMAT 9999</copy>

    SQL> <copy>COL "Column Name" FORMAT A24</copy>

    SQL> <copy>COL "Data Type" FORMAT A28</copy>

    SQL> <copy>SELECT internal_column_id "Col ID", SUBSTR(column_name,1,30) "Column Name",
                        SUBSTR(data_type,1,30) "Data Type", data_length "Data Length"
                  FROM   user_tab_cols       
                  WHERE  table_name = 'LEDGER_EMP' ORDER BY internal_column_id;</copy>

        Col ID Column Name              Data Type                    Data Length

    ---------- ------------------------ ---------------------------- -----------

            1 EMPLOYEE_ID              NUMBER                                22

            2 SALARY                   NUMBER                                22

            3 ORABCTAB_INST_ID$        NUMBER                                22

            4 ORABCTAB_CHAIN_ID$       NUMBER                                22

            5 ORABCTAB_SEQ_NUM$        NUMBER                                22

            6 ORABCTAB_CREATION_TIME$  TIMESTAMP(6) WITH TIME ZONE           13

            7 ORABCTAB_USER_NUMBER$    NUMBER                                22

            8 ORABCTAB_HASH$           RAW                                 2000

            9 ORABCTAB_SIGNATURE$      RAW                                 2000

            10 ORABCTAB_SIGNATURE_ALG$  NUMBER                                22

            11 ORABCTAB_SIGNATURE_CERT$ RAW                                   16

            12 ORABCTAB_SPARE$          RAW                                 2000

    12 rows selected.

    SQL>

    ```

## **STEP 2:** Insert rows into the blockchain table

1. Insert a first row into the blockchain table.


    ```

    SQL> <copy>INSERT INTO ledger_emp VALUES (106,12000);</copy>

    1 row created.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL>

    ```

2.  Display the internal values of the first row of the chain.


    ```

    SQL> <copy>COL "Chain date" FORMAT A17</copy>

    SQL> <copy>COL "Chain ID" FORMAT 99999999</copy>

    SQL> <copy>COL "Seq Num" FORMAT 99999999</copy>

    SQL> <copy>COL "User Num" FORMAT 9999999</copy>

    SQL> <copy>COL "Chain HASH" FORMAT 99999999999999</copy>

    SQL> <copy>SELECT ORABCTAB_CHAIN_ID$ "Chain ID", ORABCTAB_SEQ_NUM$ "Seq Num",
                to_char(ORABCTAB_CREATION_TIME$,'dd-Mon-YYYY hh-mi') "Chain date",
                ORABCTAB_USER_NUMBER$ "User Num", ORABCTAB_HASH$ "Chain HASH"
        FROM   ledger_emp;</copy>

    Chain ID   Seq Num Chain date        User Num

    --------- --------- ----------------- --------

    Chain HASH

    --------------------------------------------------------------------------------

          14         1 06-Apr-2020 12-26      119

    5812238B734B019EE553FF8A7FF573A14CFA1076AB312517047368D600984CFAB001FA1FF2C98B13

    9AB03DDCCF8F6C14ADF16FFD678756572F102D43420E69B3

    SQL>

    ```

3. Connect as `HR` and insert a row into the blockchain table as if your auditing application would do it. First grant the `INSERT` privilege on the table to `HR`.


    ```

    SQL> <copy>GRANT insert ON ledger_emp TO hr;</copy>

    Grant succeeded.

    SQL>

    ```

4. Connect as `HR` and insert a new row.


    ```

    SQL> <copy>CONNECT hr@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>INSERT INTO  auditor.ledger_emp VALUES (106,24000);</copy>

    1 row created.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL>

    ```

4. Connect as `AUDITOR` and display the internal and external values of the blockchain table rows.


    ```

    SQL> <copy>CONNECT auditor@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SELECT ORABCTAB_CHAIN_ID$ "Chain ID", ORABCTAB_SEQ_NUM$ "Seq Num",
                  to_char(ORABCTAB_CREATION_TIME$,'dd-Mon-YYYY hh-mi') "Chain date",
                  ORABCTAB_USER_NUMBER$ "User Num", ORABCTAB_HASH$ "Chain HASH",
                  employee_id, salary
            FROM   ledger_emp;</copy>

    Chain ID   Seq Num Chain date        User Num

    --------- --------- ----------------- --------

    Chain HASH

    --------------------------------------------------------------------------------

    EMPLOYEE_ID     SALARY

    ----------- ----------

          14         1 06-Apr-2020 12-26      119

    5812238B734B019EE553FF8A7FF573A14CFA1076AB312517047368D600984CFAB001FA1FF2C98B13

    9AB03DDCCF8F6C14ADF16FFD678756572F102D43420E69B3

            106      12000

          14         2 06-Apr-2020 12-28      118

    BBCDACC41B489DFBD8E28244841411937BD716F987BE750146572C555311E377D6DBA28D392C61E7

    D75BA47BFCB3A2F4920A2C149409E89FBA63E10549DF4F47

            106      24000

    SQL>

    ```

  *Observe that the user number is different. This value is the same value as `V$SESSION.USER#` column.*



## **STEP 3:** Delete rows from the blockchain table

1. Delete the row inserted by `HR`.


    ```

    SQL> <copy>DELETE FROM ledger_emp WHERE ORABCTAB_USER_NUMBER$ = 119;</copy>

    DELETE FROM ledger_emp WHERE ORABCTAB_USER_NUMBER$ = 106

              *

    ERROR at line 1:

    ORA-05715:operation not allowed on the blockchain table

    SQL>

    ```

  *You cannot delete rows in a blockchain table with the DML `DELETE` command. You must use the `DBMS_BLOCKCHAIN_TABLE` package.*

    ```

    SQL> <copy>SET SERVEROUTPUT ON</copy>

    SQL> <copy>DECLARE
      NUMBER_ROWS NUMBER;
    BEGIN
      DBMS_BLOCKCHAIN_TABLE.DELETE_EXPIRED_ROWS('AUDITOR','LEDGER_EMP', null, NUMBER_ROWS);
      DBMS_OUTPUT.PUT_LINE('Number of rows deleted=' || NUMBER_ROWS);
    END;
    /</copy>    2    3    4    5    6    7

    Number of rows deleted=0

    PL/SQL procedure successfully completed.

    SQL>

    ```

  *You can delete rows in a blockchain table only by using the `DBMS_BLOCKCHAIN_TABLE` package, and only rows that are outside the retention period. This is the reason why the procedure successfully completes without deleting any row.


  If the Oracle Database release installed is 20.0.0, then the procedure to use is `DBMS_BLOCKCHAIN_TABLE.DELETE_ROWS` and not `DBMS_BLOCKCHAIN_TABLE.DELETE_EXPIRED_ROWS`.*



2. Truncate the table.


    ```

    SQL> <copy>TRUNCATE TABLE ledger_emp;</copy>

    TRUNCATE TABLE ledger_emp

                  *

    ERROR at line 1:

    ORA-05715: operation not allowed on the blockchain table

    SQL>

    ```

3. Specify now that rows cannot be deleted until 15 days after they were created.


    ```

    SQL> <copy>ALTER TABLE ledger_emp NO DELETE UNTIL 15 DAYS AFTER INSERT;</copy>

    ALTER TABLE ledger_emp NO DELETE UNTIL 15 DAYS AFTER INSERT

    *

    ERROR at line 1:

    ORA-05731: blockchain table LEDGER_EMP cannot be altered

    SQL>

    ```

*Why cannot you change this attribute? You created the table with the `NO DELETE LOCKED` attribute. The `LOCKED` clause indicates that you can never subsequently modify the row retention.*



## **STEP 4:** Drop the blockchain table

1. Drop the table.


    ```

    SQL> <copy>DROP TABLE ledger_emp;</copy>

    DROP TABLE ledger_emp

              *

    ERROR at line 1:

    ORA-05723: drop blockchain table LEDGER_EMP not allowed

    SQL>

    ```

  *Observe that the error message is slightly different. The error message from the `TRUNCATE TABLE` command explained that the operation was not possible on a blockchain table. The current error message explains that the `DROP TABLE` is not possible but on this `LEDGER_EMP` table.


  The blockchain table was created so that it cannot be dropped before 31 days of inactivity.*



2. Change the behavior of the table to allow a lower retention.


    ```

    SQL> <copy>ALTER TABLE ledger_emp NO DROP UNTIL 1 DAYS IDLE;</copy>

    ALTER TABLE auditor.ledger_emp NO DROP UNTIL 1 DAYS IDLE

    *

    ERROR at line 1:

    ORA-05732: retention value cannot be lowered

    SQL> <copy>ALTER TABLE ledger_emp NO DROP UNTIL 40 DAYS IDLE;</copy>

    Table altered.

    SQL>

    ```

  *You can only increase the retention value. This prohibits the possibility to drop and remove any historical information that needs to be kept for security purposes.*



## **STEP 5:** Check the validity of rows in the blockchain table

1. Create another blockchain table `AUDITOR.LEDGER_TEST`. Rows cannot be deleted until 5 days after they were inserted, allowing rows to be deleted. Moreover the blockchain table can be dropped only after 1 day of inactivity.


    ```

    SQL> <copy>CREATE BLOCKCHAIN TABLE auditor.ledger_test (id NUMBER, label VARCHAR2(2))
          NO DROP UNTIL 1 DAYS IDLE
          NO DELETE UNTIL 5 DAYS AFTER INSERT
          HASHING USING "SHA2_512" VERSION "v1";</copy>

    2    3    4  CREATE BLOCKCHAIN TABLE auditor.ledger_test (id NUMBER, label VARCHAR2(2))

    *

    ERROR at line 1:

    ORA-05741: minimum retention time too low, should be at least 16 days

    SQL> <copy>CREATE BLOCKCHAIN TABLE auditor.ledger_test (id NUMBER, label VARCHAR2(2))
          NO DROP UNTIL 16 DAYS IDLE
          NO DELETE UNTIL 16 DAYS AFTER INSERT
          HASHING USING "SHA2_512" VERSION "v1";</copy>

    Table created.

    SQL>

    ```

2. Connect as `HR` and insert a row into the blockchain table as if your auditing application would do it. First grant the `INSERT` privilege on the table to `HR`


    ```

    SQL> <copy>GRANT insert ON auditor.ledger_test TO hr;</copy>

    Grant succeeded.

    SQL>

    ```

3. Connect as `HR` and insert a new row.


    ```

    SQL> <copy>CONNECT hr@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>INSERT INTO auditor.ledger_test VALUES (1,'A1');</copy>

    1 row created.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL>

    ```

4. Connect as `AUDITOR` and display the row inserted.


    ```

    SQL> <copy>CONNECT auditor@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SELECT * FROM auditor.ledger_test;</copy>

            ID LA

    ---------- --

            1 A1

    SQL>

    ```

5. Verify that the content of the rows are still valid. Use the `DBMS_BLOCKCHAIN_TABLE.VERIFY_ROWS`.


    ```

    SQL> <copy>CONNECT auditor@PDB21</copy>

    Enter password: <i>WElcome123##</i>

    Connected.
    ```
    ```

    SQL> <copy>SET SERVEROUTPUT ON</copy>

    SQL> <copy>DECLARE
      row_count NUMBER;
      verify_rows NUMBER;
      instance_id NUMBER;
    BEGIN
      FOR instance_id IN 1 .. 2 LOOP
        SELECT COUNT(*) INTO row_count FROM auditor.ledger_test WHERE ORABCTAB_INST_ID$=instance_id;
        DBMS_BLOCKCHAIN_TABLE.VERIFY_ROWS('AUDITOR','LEDGER_TEST', NULL, NULL, instance_id, NULL, verify_rows);
        DBMS_OUTPUT.PUT_LINE('Number of rows verified in instance Id '|| instance_id || ' = '|| row_count);
      END LOOP;
    END;
    /</copy>

    Number of rows verified in instance Id 1 = 1

    Number of rows verified in instance Id 2 = 0

    PL/SQL procedure successfully completed.

    SQL> <copy>EXIT</copy>

    $

    ```

You may now [proceed to the next lab](#next).


## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
