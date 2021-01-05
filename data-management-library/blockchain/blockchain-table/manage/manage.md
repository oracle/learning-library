# Manage Blockchain Tables

## Introduction

In this lab we will create a blockchain table. Blockchain tables are append-only tables in which only insert operations are allowed. Deleting rows is either prohibited or restricted based on time. Rows in a blockchain table are made tamper-resistant by special sequencing & chaining algorithms. Users can verify that rows have not been tampered. A hash value that is part of the row metadata is used to chain and validate rows. Blockchain tables enable you to implement a centralized ledger model where all participants in the blockchain network have access to the same tamper-resistant ledger.

Estimated Lab Time: 5 minutes


### Objectives


In this lab, you will:
* Create the Blockchain Table
* Describe and query blockchain table
* View all blockchain tables


### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a VCN
* Lab: Provision a 20c instance


## **STEP 1**: Create the Blockchain Table

1. Create the blockchain table named `bank_ledger`. Rows can never be deleted in the blockchain table `bank_ledger`. Moreover the blockchain table can be dropped only after 16 days of inactivity. 

    ```
    <copy>
    CREATE BLOCKCHAIN TABLE bank_ledger (bank VARCHAR2(128), deposit_date DATE, deposit_amount NUMBER)
          NO DROP UNTIL 16 DAYS IDLE
          NO DELETE LOCKED
          HASHING USING "SHA2_512" VERSION "v1";
    ```
  The blockchain table has been created. 

## **STEP 2:** Describe and Query Blockchain Table

1. At this time you can look at your table. Describe and query blockchain table:

    ```
    <copy>
    DESC bank_ledger;

    select * from USER_BLOCKCHAIN_TABLES;

    select bank, deposit_date, deposit_amount, ORABCTAB_INST_ID$, ORABCTAB_CHAIN_ID$, ORABCTAB_SEQ_NUM$, ORABCTAB_CREATION_TIME$, ORABCTAB_USER_NUMBER$, ORABCTAB_HASH$, ORABCTAB_SIGNATURE$, ORABCTAB_SIGNATURE_ALG$, ORABCTAB_SIGNATURE_CERT$ from bank_ledger;
  ```

## **STEP 3:** View all blockchain tables

1. View all the blockchain tables in your current database:
    
    ```
    <copy>
    select * from dba_blockchain_tables;  
    ```

You may now *proceed to the next lab*.

## Acknowledgements
* **Author** - Rayes Huang, Mark Rakhmilevich, Blockchain Product Management
* **Contributors** -  Kamryn Vinson, Database Product Management
* **Last Updated By/Date** - Kamryn Vinson, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
