# Searching Text

## Introduction
This lab shows how applying the `INMEMORY TEXT` clause to non-scalar columns of an in-memory table enables fast in-memory searching of text, XML, or JSON documents using the `CONTAINS()` or `JSON_TEXTCONTAINS()` operators. When the IM column store contains both scalar and non-scalar columns, OLAP applications that access both types of data can avoid accessing row-based storage, thereby improving performance. The `PRIORITY` clause has the same effect on population of IM full text columns as standard in-memory columns. The default priority is `NONE`. The `MEMCOMPRESS` clause is not valid with `INMEMORY TEXT`.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup

## **STEP 1:**  Enable the In-Memory column store in the CDB and set up the Oracle Text user in the PDB

1. Run the `setup_Text21c.sh` script.

    ```

    $ <copy>cd /home/oracle/labs/M104784GC10</copy>
    $ <copy>/home/oracle/labs/M104784GC10/setup_Text21c.sh</copy>
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
    SQL> ALTER SYSTEM SET sga_target=812M SCOPE=spfile;

    System altered.

    SQL> ALTER SYSTEM SET inmemory_size=110M SCOPE=SPFILE;

    System altered.

    SQL> ALTER SYSTEM SET inmemory_expressions_usage=STATIC_ONLY SCOPE=SPFILE;

    System altered.

    SQL> ALTER SYSTEM SET inmemory_virtual_columns = ENABLE SCOPE=SPFILE;

    System altered.
    ...
    DOC>
    DOC>   Perform a "SHUTDOWN ABORT"  and
    DOC>   restart using UPGRADE.
    DOC>#######################################################################
    DOC>#######################################################################
    DOC>#
    ...
    SQL> DROP USER textuser CASCADE;

    User dropped.

    SQL> ALTER SESSION SET db_create_file_dest='';

    Session altered.

    SQL> DROP TABLESPACE tbs_text INCLUDING CONTENTS AND DATAFILES cascade constraints;

    Tablespace dropped.

    SQL> CREATE TABLESPACE tbs_text DATAFILE '/u02/app/oracle/oradata/pdb21/tbstext01.dbf' SIZE 500M segment space management auto;

    Tablespace created.

    SQL>
    SQL> CREATE USER textuser IDENTIFIED BY <i>WElcome123##</i> default tablespace tbs_text;

    User created.

    SQL> GRANT RESOURCE, CONNECT, CTXAPP, unlimited tablespace, select any dictionary TO textuser;

    Grant succeeded.

    SQL> exit
    $

    ```

## **STEP 2:** Create a table, a `CONTEXT` index, and a `JSON` search index

1.  Connect in `PDB21` as `TEXTUSER`, create a table and insert rows.


    ```

    $ <copy>sqlplus textuser@PDB21</copy>

    Connected to:

    SQL> <copy>CREATE TABLE docs (id NUMBER PRIMARY KEY, text VARCHAR2(200), json_text JSON);</copy>

    Table created.

    SQL> <copy>INSERT INTO docs VALUES(4, 'Lyon is a city in France.', '{"country": "France", "city" : "Lyon"}');</copy>

    1 row created.

    SQL> <copy>INSERT INTO docs VALUES(5, 'Barcelone is a city in Spain.', '{"country": "Spain", "city" : "Barcelona"}');</copy>

    1 row created.

    SQL> <copy>INSERT INTO docs VALUES(3, 'France is in Europe.', '{"continent": "Europe", "country" : "France"}');</copy>

    1 row created.

    SQL> <copy>COMMIT;</copy>

    Commit complete.

    SQL>

    ```

2. Create a `CONTEXT` index on the `TEXT` column and a `JSON` search index on the `JSON_TEXT` column of the `DOCS` table.


    ```

    SQL> <copy>CREATE INDEX idx_docs_text ON docs(text) INDEXTYPE IS CTXSYS.CONTEXT;</copy>

    Index created.

    SQL> <copy>CREATE SEARCH INDEX idx_docs_json ON docs(json_text) FOR JSON;</copy>

    Index created.

    SQL>

    ```

3. Query the table to retrieve the documents that contain the word `France`, using the `CONTEXT` index.


    ```

    SQL> <copy>COLUMN id FORMAT 99</copy>

    SQL> <copy>COLUMN text FORMAT a29</copy>

    SQL> <copy>SELECT id, text FROM docs WHERE CONTAINS(text, 'France', 1) > 0;</copy>

    ID TEXT

    -- -----------------------------

    4 Lyon is a city in France.

    3 France is in Europe.

    SQL>

    ```

4. Query the table to retrieve the documents that contain the word `France`, using the JSON search index.


    ```

    SQL> <copy>COL json_text FORMAT A41</copy>

    SQL> <copy>SELECT id, json_text FROM docs
                      WHERE JSON_TEXTCONTAINS(json_text, '$.country', 'France');</copy>

    ID JSON_TEXT

    --- -----------------------------------------

      4 {"country":"France","city":"Lyon"}

      3 {"continent":"Europe","country":"France"}

    SQL>`</pre
    ```

## **STEP 3:** Populate the table and its text columns into the In-Memory Column Store

1. Enable IM Full Text Columns on the table.


    ```

    SQL> <copy>ALTER TABLE docs INMEMORY INMEMORY TEXT(text, json_text);</copy>

    Table altered.

    SQL>

    ```

  The first `INMEMORY` keyword indicates that the table is to be loaded into the IM Column Store and `INMEMORY TEXT` is a separate clause indicating you want to be able to search using text and json queries on the `TEXT` and `JSON_TEXT` columns.

2. Load the table into the IM Column Store by querying the table.


    ```

    SQL> <copy>SELECT * FROM docs;</copy>

    ID TEXT                          JSON_TEXT

    --- ----------------------------- -----------------------------------------

      4 Lyon is a city in France.     {"country":"France","city":"Lyon"}

      5 Barcelone is a city in Spain. {"country":"Spain","city":"Barcelona"}

      3 France is in Europe.          {"continent":"Europe","country":"France"}

    SQL> <copy>SELECT * FROM table(dbms_xplan.display_cursor());</copy>

    PLAN_TABLE_OUTPUT

    -----------------------------------------------------------------------------

    SQL_ID  6dthd7dtuh58t, child number 0

    -------------------------------------

    select * from docs

    Plan hash value: 1540662602

    -----------------------------------------------------------------------------

    | Id  | Operation                  | Name | Rows  | Bytes | Cost (%CPU)| Time   |

    PLAN_TABLE_OUTPUT

    -----------------------------------------------------------------------------

    |   0 | SELECT STATEMENT           |      |       |       |     3 (100)|        |

    |   1 |  <b>TABLE ACCESS INMEMORY FULL</b>| DOCS |     3 | 12351 |     3   (0)|00:00:01|

    -----------------------------------------------------------------------------

    PLAN_TABLE_OUTPUT

    -----------------------------------------------------------------------------

    Note

    -----

      - dynamic statistics used: dynamic sampling (level=2)

    SQL>

    ```

3. Retrieve the In-Memory expressions created on the in-memory columns.


    ```

    SQL> <copy>SELECT column_name, sql_expression FROM dba_im_expressions
                      WHERE table_name='DOCS';</copy>

    COLUMN_NAME

    -----------------------------------------------------------------------------

    SQL_EXPRESSION

    -----------------------------------------------------------------------------

    SYS_IME_IVDX_2C08A74E2BF04F99BFF4480F794661D0

    SYS_CTX_MKIVIDX("TEXT" RETURNING RAW(32767))

    SYS_IME_IVDX_65232FABEDB64F37BF6FF91B94EE81B0

    SYS_CTX_MKIVIDX("JSON_TEXT" RETURNING RAW(32767))

    SQL>

    ```

## **STEP 4:** Query the data from the In-Memory Column Store

1. Before dropping the indexes, observe whether the queries use the indexes or the data from the In-Memory column store.


2. Query the table to retrieve the documents that contain the word `France`, restricting on the `TEXT` column.

    ```

    SQL> <copy>SELECT id, json_text FROM docs
                  WHERE JSON_TEXTCONTAINS(json_text, '$.country', 'France');</copy>

     ID JSON_TEXT
    --- -----------------------------------------
      4 {"country":"France","city":"Lyon"}
      3 {"continent":"Europe","country":"France"}

    SQL> <copy>SELECT * FROM table(dbms_xplan.display_cursor());</copy>

    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------
    SQL_ID  3dcmjjz8nwwgk, child number 1
    -------------------------------------
    SELECT id, json_text FROM docs               WHERE
    JSON_TEXTCONTAINS(json_text, '$.country', 'France')

    Plan hash value: 960871976
    ------------------------------------------------------------------------
    | Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU
    |   0 | SELECT STATEMENT            |               |       |       |    4 (100)
    |   1 |  <b>TABLE ACCESS BY INDEX ROWID</b>| DOCS          |     1 | 20412 |    4   (0)
    |*  2 |   <b>DOMAIN INDEX</b>              | IDX_DOCS_JSON |       |       |    4   (0)
    ------------------------------------------------------------------------

    Predicate Information (identified by operation id):
    ---------------------------------------------------
       2 - access("CTXSYS"."CONTAINS"("DOCS"."JSON_TEXT",'(France) INPATH (/country)')>0)

    Note
    -----
       - dynamic statistics used: dynamic sampling (level=2)

    24 rows selected.

    SQL>

    ```

3. Query the table to retrieve the documents that contain the word France, restricting on the `JSON_TEXT` column.

    ```

    SQL> <copy>SELECT id, text FROM docs WHERE CONTAINS(text, 'France', 1) > 0;</copy>

    ID TEXT
    -- -----------------------------
     4 Lyon is a city in France.
     3 France is in Europe.

    SQL> <copy>SELECT * FROM table(dbms_xplan.display_cursor());</copy>

    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------
    SQL_ID  7fb38jwxjy8mm, child number 0
    -------------------------------------
    SELECT id, text FROM docs WHERE CONTAINS(text, 'France', 1) > 0

    Plan hash value: 1365989615
    ------------------------------------------------------------------------
    | Id  | Operation                   | Name          | Rows | Bytes|Cost (%CPU) |
    ------------------------------------------------------------------------
    |   0 | SELECT STATEMENT            |               |      |      |    4 (100) |
    |   1 |  <b>TABLE ACCESS BY INDEX ROWID</b>| DOCS          |     1|   127|    4   (0)|
    |*  2 |   <b>DOMAIN INDEX</b>              | IDX_DOCS_TEXT |      |      |    4   (0)|
    ------------------------------------------------------------------------
    Predicate Information (identified by operation id):
    ---------------------------------------------------
       2 - access("CTXSYS"."CONTAINS"("TEXT",'France',1)>0)

    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------
    Note
    -----
       - dynamic statistics used: dynamic sampling (level=2)

    23 rows selected.

    SQL>

    ```

4. Drop the indexes before re-querying the table to show that the queries use the data from the IM column store and no longer the indexes.


5. Drop the indexes.

    ```

    SQL> <copy>DROP INDEX idx_docs_text;</copy>

    Index dropped.

    SQL> <copy>DROP INDEX idx_docs_json;</copy>

    Index dropped.

    SQL>

    ```

6. Query the table to retrieve the documents that contain the word `France`, restricting on the `TEXT` column.

    ```

    SQL> <copy>SELECT id, text FROM docs WHERE CONTAINS(text, 'France', 1) > 0;</copy>

    ID TEXT
    -- -----------------------------
     4 Lyon is a city in France.
     3 France is in Europe.

    SQL> <copy>SELECT * FROM table(dbms_xplan.display_cursor());</copy>

    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------
    SQL_ID  7fb38jwxjy8mm, child number 0
    -------------------------------------
    SELECT id, text FROM docs WHERE CONTAINS(text, 'France', 1) > 0

    Plan hash value: 1540662602
    -------------------------------------------------------------------------
    | Id  | Operation                  | Name | Rows  | Bytes | Cost (%CPU)| Time   |
    |   0 | SELECT STATEMENT           |      |       |       |     3 (100)|        |
    |*  1 |  <b>TABLE ACCESS INMEMORY FULL</b>| DOCS |     2 | 33000 |     3   (0)|00:00:01|
    -------------------------------------------------------------------------

    PLAN_TABLE_OUTPUT
    -------------------------------------------------------------------------
    Predicate Information (identified by operation id):
    -------------------------------------------------
       1 - <b>inmemory</b>(SYS_CTX_CONTAINS2("TEXT" , 'France' ,
                  SYS_CTX_MKIVIDX("TEXT" RETURNING RAW(32767)))>0)
           filter(SYS_CTX_CONTAINS2("TEXT" , 'France' , SYS_CTX_MKIVIDX("TEXT"
                  RETURNING RAW(32767)))>0)

    Note
    -----
       - dynamic statistics used: dynamic sampling (level=2)

    25 rows selected.

    SQL>

    ```

7. Query the table to retrieve the documents that contain the word `France`, restricting on the `JSON_TEXT` column.

    ```

    SQL> <copy>SELECT id, json_text FROM docs
                  WHERE JSON_TEXTCONTAINS(json_text, '$.country', 'France');</copy>

     ID JSON_TEXT
    --- -----------------------------------------
      4 {"country":"France","city":"Lyon"}
      3 {"continent":"Europe","country":"France"}

    SQL> <copy>SELECT * FROM table(dbms_xplan.display_cursor());</copy>

    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------
    SQL_ID  3dcmjjz8nwwgk, child number 0
    -------------------------------------
    SELECT id, json_text FROM docs               WHERE
    JSON_TEXTCONTAINS(json_text, '$.country', 'France')

    Plan hash value: 1540662602
    -------------------------------------------------------------------------
    | Id  | Operation                  | Name | Rows  | Bytes | Cost (%CPU)| Time   |
    |   0 | SELECT STATEMENT           |      |       |       |     3 (100)|        |
    |*  1 |  <b>TABLE ACCESS INMEMORY FULL</b>| DOCS |     2 | 40800 |     3   (0)|00:00:01|
    -------------------------------------------------------------------------

    Predicate Information (identified by operation id):
    ---------------------------------------------------
       1 - <b>inmemory</b>(SYS_CTX_CONTAINS2("DOCS"."JSON_TEXT" /*+ LOB_BY_VALUE */
                  , '(France) INPATH (/country)' , SYS_CTX_MKIVIDX("JSON_TEXT" /*+
                  LOB_BY_VALUE */  RETURNING RAW(32767)))>0)
           filter(SYS_CTX_CONTAINS2("DOCS"."JSON_TEXT" /*+ LOB_BY_VALUE */  ,

    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------
                  '(France) INPATH (/country)' , SYS_CTX_MKIVIDX("JSON_TEXT" /*+
                  LOB_BY_VALUE */  RETURNING RAW(32767)))>0)

    Note
    -----
       - dynamic statistics used: dynamic sampling (level=2)

    28 rows selected.

    SQL> <copy>EXIT</copy>

    ```

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
