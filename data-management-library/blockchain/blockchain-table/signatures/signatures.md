# Work with Signatures for Blockchain Table

## Introduction

Digital certificates can be used to verify the signature of a Blockchain table row, Use pre-built Database package to add a certificate DBMS\_USER\_CERTS.ADD_SIGNATURE When a certificate is added to the database, it is assigned a unique certificate GUID. as package output.The certificate GUID is used when adding and verifying signatures for a blockchain table row. You must remember this certificate GUID, else you cannot use the associated digital certificate.

Estimated Lab Time: 15 minutes


### Objectives


In this lab, you will:
* Add your certificate
* Get bytes for signature – Write to an external file
* Create signature externally
* Add signature to a row
* Verify rows with signature

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a VCN
* Lab: Provision a 20c instance

## **STEP 1**: Add your Certificate

1. Upload your certificate. You have to add your certificate into the table before you can use the certificate to sign the data.

    ```
    <copy>
    CREATE DIRECTORY CERT_DIR AS '/blockchain/certs’;
    /
    DECLARE
      file       BFILE;
      buffer     BLOB;
      amount     NUMBER := 32767;
      cert_guid  RAW(16);
    BEGIN
      file := BFILENAME('CERT_DIR', 'user01.pem');
      DBMS_LOB.FILEOPEN(file);
      DBMS_LOB.READ(file, amount, 1, buffer);
      DBMS_LOB.FILECLOSE(file);
      DBMS_USER_CERTS.ADD_CERTIFICATE(buffer, cert_guid);
      DBMS_OUTPUT.PUT_LINE('Certificate GUID = ' || cert_guid);
    END;
    /
    SELECT * FROM USER_CERTIFICATES ORDER BY user_name;
    ```
2. To sign the data, you need to get the bytes for signature. 

    ```
    <copy>
    DECLARE
            row_data BLOB;
            buffer RAW(4000);
            inst_id BINARY_INTEGER;
            chain_id BINARY_INTEGER;
            sequence_no BINARY_INTEGER;
            row_len BINARY_INTEGER;
            l_output utl_file.file_type;
    BEGIN
            SELECT ORABCTAB_INST_ID$, ORABCTAB_CHAIN_ID$, ORABCTAB_SEQ_NUM$ INTO inst_id, chain_id, sequence_no 
                    FROM bank_ledger WHERE ORABCTAB_INST_ID$=1 and ORABCTAB_CHAIN_ID$=17 and ORABCTAB_SEQ_NUM$=1;
            DBMS_BLOCKCHAIN_TABLE.GET_BYTES_FOR_ROW_SIGNATURE('BCADM','bank_ledger',inst_id, chain_id, sequence_no, 1, row_data);
            row_len := DBMS_LOB.GETLENGTH(row_data);
            DBMS_LOB.READ(row_data, row_len, 1, buffer);
            l_output := utl_file.fopen('CERT_DIR', 'row_data1','WB', 32767);
            utl_file.put_raw(l_output, buffer, TRUE);
    END;
    /
    ```
        
## **STEP 2:** Create Signature Externally

You will not sign the data in the database, you will sign the data externally.

1. In a terminal window, sign the data with the following command:

      ```
      <copy>
      openssl dgst -sha256 -sign user01.key -out row1.sha256 row_data1
      ```

## **STEP 3:** Add Signature to a Row

Signing a row sets a user signature for a previously created row. A signature provides additional security against tampering.

Oracle Database verifies that the current user owns the row being updated and the hash, if provided, matches the stored hash value of the row. You must have the INSERT privilege on the blockchain table. The existing signature of the row for which a signature is being added must be NULL. Use the DBMS\_BLOCKCHAIN\_TABLE.SIGN_ROW procedure to add a signature to an existing row.

1. Add the signature back to the database.

    ```
    <copy>
    DECLARE
            file BFILE;
            amount NUMBER := 32767;
            signature RAW(32767);
            cert_guid RAW (16) := HEXTORAW('A068927D1EE855C7E0530200000A6D34');
            inst_id binary_integer;
            chain_id binary_integer;
            sequence_no binary_integer;
    BEGIN
            SELECT ORABCTAB_INST_ID$, ORABCTAB_CHAIN_ID$, ORABCTAB_SEQ_NUM$ INTO inst_id, chain_id, sequence_no  
                    FROM bank_ledger WHERE ORABCTAB_INST_ID$=1 and ORABCTAB_CHAIN_ID$=17 and ORABCTAB_SEQ_NUM$=1;
            file := bfilename('CERT_DIR', 'row10.sha256');
            DBMS_LOB.FILEOPEN(file);
            dbms_lob.READ(file, amount, 1, signature);
            dbms_lob.FILECLOSE(file);
            DBMS_BLOCKCHAIN_TABLE.SIGN_ROW('BCADM','bank_ledger', inst_id, chain_id, sequence_no, NULL, signature, cert_guid, DBMS_BLOCKCHAIN_TABLE.SIGN_ALGO_RSA_SHA2_256);
    END;
    /
    ```

The procedure has been successfully completed.
The signature has been added to your row.

## **STEP 4:** Verify Rows with Signature

1. Verify the signature of the Blockchain table row.

    ```
    <copy>
    DECLARE
      verify_rows NUMBER;
      instance_id NUMBER;
    BEGIN
      FOR instance_id IN 1 .. 4 LOOP
        DBMS_BLOCKCHAIN_TABLE.VERIFY_ROWS('BCADM','BANK_LEDGER', NULL, NULL, instance_id, NULL, verify_rows, true);
        DBMS_OUTPUT.PUT_LINE('Number of rows verified in instance Id '|| instance_id || ' = '|| verify_rows);
      END LOOP;
    END;
    /
    ```

## Acknowledgements
* **Author** - Rayes Huang, Mark Rakhmilevich, Blockchain Product Management
* **Contributors** -  Kamryn Vinson, Database Product Management
* **Last Updated By/Date** - Kamryn Vinson, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
