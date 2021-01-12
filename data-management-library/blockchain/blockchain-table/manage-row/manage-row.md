# Manage Rows in Blockchain Table

## Introduction

Rows in a blockchain table are tamper-proof. Each row contains a cryptographic hash value which is based on the data in that row and the hash value of the previous row in the chain. If a row is tampered with, the hash value of the row changes and this causes the hash value of the next row in the chain to change. An optional user signature can be added to a row for enhanced fraud detection.

Estimated Lab Time: 10 minutes


### Objectives

In this lab, you will:
* Insert rows
* Query rows
* Verify rows without signature

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a VCN
* Lab: Provision a 20c instance

## **STEP 1**: Insert Rows

1. Insert rows into the blockchain table:

    ```
    <copy>
      INSERT INTO bank_ledger  VALUES ('account01',to_date(sysdate,'dd-mm-yyyy'),100);
      INSERT INTO bank_ledger  VALUES ('account01',to_date(sysdate,'dd-mm-yyyy'),200);
      INSERT INTO bank_ledger  VALUES ('account02',to_date(sysdate,'dd-mm-yyyy'),500);
      INSERT INTO bank_ledger  VALUES ('account02',to_date(sysdate,'dd-mm-yyyy'),-200);
      INSERT INTO bank_ledger  VALUES ('account01',to_date(sysdate,'dd-mm-yyyy'),100);
      INSERT INTO bank_ledger  VALUES ('account02',to_date(sysdate,'dd-mm-yyyy'),200);
      INSERT INTO bank_ledger  VALUES ('account03',to_date(sysdate,'dd-mm-yyyy'),500);
      INSERT INTO bank_ledger  VALUES ('account03',to_date(sysdate,'dd-mm-yyyy'),-200);
      commit;
    ```

2. After inserting rows, see what happens when you try to update your row:

    ```
    <copy>
    UPDATE bank_ledger SET deposit_amount=0 WHERE bank='account01’;
    ```
    ```
    ORA-05715: operation not allowed on the blockchain table
    ```
  
  When you try to update a row in the blockchain table, you get an operation not allowed on the blockchain table error.

3. See what happens when you try to delete a row from the blockchain table:

    ```
    <copy>
    DELETE FROM bank_ledger WHERE bank='account01';
    ```
    ```
    ORA-05715: operation not allowed on the blockchain table
    ```

  When you try to delete a row in the blockchain table you get the same error because this is an insert only database table.

## **STEP 2:** Query Rows

1. Query rows:

    ```
    <copy>
    select * from bank_ledger;

    select bank, deposit_date, deposit_amount, ORABCTAB_INST_ID$, ORABCTAB_CHAIN_ID$, ORABCTAB_SEQ_NUM$, ORABCTAB_CREATION_TIME$, ORABCTAB_USER_NUMBER$, ORABCTAB_HASH$, ORABCTAB_SIGNATURE$, ORABCTAB_SIGNATURE_ALG$, ORABCTAB_SIGNATURE_CERT$ from bank_ledger;
    ```

## **STEP 3:** Verify Rows without Signature
The PL/SQL procedure DBMS\_BLOCKCHAIN\_TABLE.VERIFY_ROWS verifies that rows in a blockchain table were not modified since they were inserted. Being tamper-proof is a key requirement for blockchain tables.

You can validate all rows in the blockchain table or specify a criteria to filter rows that must be validated. Rows can be filtered using the instance ID, chain ID, or row creation time.

1. Run this command to verify all your rows within your current blockchain table:

    ```
    <copy>
    DECLARE
        verify_rows NUMBER;
        instance_id NUMBER;
    BEGIN
        FOR instance_id IN 1 .. 4 LOOP
             DBMS_BLOCKCHAIN_TABLE.VERIFY_ROWS(‘BCADM','BANK_LEDGER', NULL, NULL, instance_id, NULL, verify_rows, false);
             DBMS_OUTPUT.PUT_LINE('Number of rows verified in instance Id '|| instance_id || ' = '|| verify_rows);
        END LOOP;
    END;
    /
    ```

  The procedure has been successfully completed.

  You may now *proceed to the next lab*.

## Acknowledgements
* **Author** - Rayes Huang, Mark Rakhmilevich, Blockchain Product Management
* **Contributors** -  Kamryn Vinson, Database Product Management
* **Last Updated By/Date** - Kamryn Vinson, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
