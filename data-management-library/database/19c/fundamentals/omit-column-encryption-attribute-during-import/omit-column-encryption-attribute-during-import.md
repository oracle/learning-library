---
duration: PT0H05M0S
description: Omit column encryption attribute during import.
level: Beginner
roles: Application Developer;Developer;Technology Manager
lab-id:
products: en/database/oracle/oracle-database/19
keywords: Database
inject-note: true
---
# Omit the Column Encryption Attribute During Import

## Introduction
In the Oracle Public Cloud environment, data is encrypted by default using Transparent Data Encryption (TDE) and the encrypted tablespace feature, but not the encrypted column feature. If an exported table holds encrypted columns, there must be a method to import the table and suppress the encryption clause associated with the table creation during the import operation.

Estimated Lab Time: 5 minutes

### Objectives

Learn how to do the following:

- Display the table column **ENCRYPT** attribute before import
- Import the table without the **ENCRYPT** Attribute



### Prerequisites

Be sure that the following tasks are completed before you start:

- Lab 4 completed.
- Oracle Database 19c installed
- A database, either non-CDB or CDB with a PDB.


## **STEP 1**: Display the table column **ENCRYPT** attribute before import

1. First, switch to the **oracle** user.
   
    ```
    $ sudo su - oracle
    ```

2. Switch to the **/home/oracle/labs** directory.

    ````
    $ cd /home/oracle/labs
    ````

3. Download the **tab.dmp** file onto your compute instance.
   
    ```
    $ wget https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-dp-import-column-encryption-attribute/files/tab.dmp
    ```

4. Before importing the table without its **ENCRYPT** column attribute, verify that the table exported in the **/home/oracle/labs/tab.dmp** dump file has an encrypted column.

5. Log in to a test non-CDB as the **system** user.

    ```
    $ sqlplus system/oracle
    ```
>**Note**: **oracle** is the default password for the **system** user.

6. Create the directory to point to the location of the dump file.

    ```
    SQL> CREATE DIRECTORY dp AS '/home/oracle/labs';

    SQL> EXIT; 
    ```
7. Generate the SQL file from the Data Pump export **/home/oracle/labs/tab.dmp** dump file by simulating an import into the non-CDB.

    ```
    $ impdp system DIRECTORY=dp DUMPFILE=tab.dmp SQLFILE=tabenc1 LOGFILE=enc.log
    ```
>**Note**: You will be prompted to enter your password.

8. Verify the ouput

    ```
    $ cat tabenc1.sql
    ```
    ```
    ...
    CREATE TABLE "TEST"."TABENC" 
    (    "C1" NUMBER, 
    "LABEL" VARCHAR2(50 BYTE) ENCRYPT USING 'AES192' 'SHA-1'
    ) SEGMENT CREATION IMMEDIATE 
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
    NOCOMPRESS LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
    TABLESPACE "SYSTEM" ;
    ...
    ```
>**Note**: Notice the **ENCRYPT USING 'AES192' 'SHA-1'** in the **LABEL** column definition.
<!--
5. If you have substeps, still use numbered steps:

    1. Substep 1.

    2. Substep 2.

6. If you have a graphic, please include the ALT info in the square brackets and the title info in the double-quotes.

  ![Stack Information](images/stack-information-page.png "Stack Information page")


5. If you have a note, please use this format:

    > **Note**: This is a note.

6. If you have code, please use this format without any copy tags or highlightjs info. You can include prompts.

    ```
    $ Code line 1
    # Code line 2
    ```
-->


## **STEP 2**: Import the table without the **ENCRYPT** Attribute

1. Generate the SQL file from the Data Pump export **/home/oracle/labs/tab.dmp** dump file by simulating an import into the non-CDB omitting the **ENCRYPT** attribute of the LABEL column of the **TEST.TABENC** table into an encrypted tablespace such as **TEST**.

    ```
    $ impdp DIRECTORY=dp DUMPFILE=tab.dmp SQLFILE=tabenc2 TRANSFORM=OMIT_ENCRYPTION_CLAUSE:Y REMAP_TABLESPACE=system:test LOGFILE=enc2.log
    ```

2. Verify

    ```
    $ cat tabenc2.sql
    ```

    ```
    ...
    CREATE TABLE "TEST"."TABENC" 
    (    "C1" NUMBER, 
        "LABEL" VARCHAR2(50 BYTE)
     ) SEGMENT CREATION IMMEDIATE 
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
    NOCOMPRESS LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
    TABLESPACE "TEST" ;
    ...
    ```
    >**Note**: The **ENCRYPT** attribute of the **LABEL** column in the **TEST.TABENC** table is not set.
3. Clean the environment.

    ```
    $ rm tab.dmp tabenc*.sql enc*.sql
    ```
## Learn More

- [New Features in Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)

## Acknowledgements

* **Author**- Dominique Jeunot, tbd, tbd
* **Last Updated By/Date** - Matthew McDaniel, Austin Specialists Hub, June 2021
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in
