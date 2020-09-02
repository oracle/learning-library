# Advanced Security Option

## Transparent Data Encryption

![](../../images/banner_ASO.PNG)

Hard-coded within the Oracle Database core product, two features comprise this option:

![](images/ASO_Features.PNG)

![](../../images/banner_TDE.PNG)

Enables you to encrypt data so that only an authorized recipient can read it.

Use encryption to protect sensitive data in a potentially unprotected environment, such as data you placed on backup media that is sent to an off-site storage location. You can encrypt individual columns in a database table, or you can encrypt an entire tablespace.
    
After the data is encrypted, this data is transparently decrypted for authorized users or applications when they access this data. TDE helps protect data stored on media (also called data at rest) in the event that the storage media or data file is stolen.
    
Oracle Database uses authentication, authorization, and auditing mechanisms to secure data in the database, but not in the operating system data files where data is stored. To protect these data files, Oracle Database provides Transparent Data Encryption (TDE). TDE encrypts sensitive data stored in data files. To prevent unauthorized decryption, TDE stores the encryption keys in a security module external to the database, called a keystore.
    
You can configure Oracle Key Vault as part of the TDE implementation. This enables you to centrally manage TDE keystores (called TDE wallets in Oracle Key Vault) in your enterprise. For example, you can upload a software keystore to Oracle Key Vault and then make the contents of this keystore available to other TDE-enabled databases.

![](images/ASO_Concept_TDE.PNG)

**Benefits of Using Transparent Data Encryption**

- As a security administrator, you can be sure that sensitive data is encrypted and therefore safe in the event that the storage media or data file is stolen.

- Using TDE helps you address security-related regulatory compliance issues.

- You do not need to create auxiliary tables, triggers, or views to decrypt data for the authorized user or application. Data from tables is transparently decrypted for the database user and application. An application that processes sensitive data can use TDE to provide strong data encryption with little or no change to the application.

- Data is transparently decrypted for database users and applications that access this data. Database users and applications do not need to be aware that the data they are accessing is stored in encrypted form.

- You can encrypt data with zero downtime on production systems by using online table redefinition or you can encrypt it offline during maintenance periods. (See Oracle Database Administrator’s Guide for more information about online table redefinition.)

- You do not need to modify your applications to handle the encrypted data. The database manages the data encryption and decryption.

- Oracle Database automates TDE master encryption key and keystore management operations. The user or application does not need to manage TDE master encryption keys.
    
---
Click here to access to the [Transparent Data Encryption (TDE)](TDE/README.md) labs

---
<br>

## Data Redaction

![](../../images/banner_DR.PNG)

Enables you to mask (redact) data that is returned from queries issued by applications. We can also talk about Dynamic Data Masking.

You can redact column data by using one of the following methods:

- **Full redaction**<br>
You redact all of the contents of the column data. The redacted value that is returned to the querying user depends on the data type of the column. For example, columns of the NUMBER data type are redacted with a zero (0) and character data types are redacted with a blank space.

- **Partial redaction**<br>
You redact a portion of the column data. For example, you can redact most of a Social Security number with asterisks (*), except for the last 4 digits.

- **Regular expressions**<br>
You can use regular expressions in both full and partial redaction. This enables you to redact data based on a search pattern for the data. For example, you can use regular expressions to redact specific phone numbers or email addresses in your data.

- **Random redaction**<br>
The redacted data presented to the querying user appears as randomly generated values each time it is displayed, depending on the data type of the column.

- **No redaction**<br>
This option enables you to test the internal operation of your redaction policies, with no effect on the results of queries against tables with policies defined on them. You can use this option to test the redaction policy definitions before applying them to a production environment.

Data Redaction performs the redaction at runtime, that is, the moment that the user tries to view the data. This functionality is ideally suited for dynamic production systems in which data constantly changes. While the data is being redacted, Oracle Database is able to process all of the data normally and to preserve the back-end referential integrity constraints. Data redaction can help you to comply with industry regulations such as Payment Card Industry Data Security Standard (PCI DSS) and the Sarbanes-Oxley Act.

![](images/ASO_Concept_DR.PNG)

**Benefits of Using Oracle Data Redaction**

- You have different styles of redaction from which to choose.

- Because the data is redacted at runtime, Data Redaction is well suited to environments in which data is constantly changing.

- You can create the Data Redaction policies in one central location and easily manage them from there.

- The Data Redaction policies enable you to create a wide variety of function conditions based on SYS_CONTEXT values, which can be used at runtime to decide when the Data Redaction policies will apply to the results of the application user's query.

---
Click here to access to the [Oracle Data Redaction](Data_Redaction/README.md) labs

---
<br>

Click to return [home](/README.md)
