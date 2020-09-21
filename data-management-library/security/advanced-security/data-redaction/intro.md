## Oracle Data Redaction 

![](../../../images/banner_DR.PNG)

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

![](../images/ASO_Concept_DR.PNG)

**Benefits of Using Oracle Data Redaction**

- You have different styles of redaction from which to choose.

- Because the data is redacted at runtime, Data Redaction is well suited to environments in which data is constantly changing.

- You can create the Data Redaction policies in one central location and easily manage them from there.

- The Data Redaction policies enable you to create a wide variety of function conditions based on SYS_CONTEXT values, which can be used at runtime to decide when the Data Redaction policies will apply to the results of the application user's query.