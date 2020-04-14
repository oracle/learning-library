# JSON Data and the Oracle Database

## Introduction
Oracle Database supports JavaScript Object Notation (JSON) data natively with relational database features, including transactions, indexing, declarative querying, and views.

Structured Query Language (SQL) queries are declarative. With Oracle Database you can use SQL to join JSON data with relational data. And you can project JSON data relationally, making it available for relational processes and tools. You can also query, from within the database, JSON data that is stored outside Oracle Database in an external table.

You can access JSON data stored in the database the same way you access other database data, including using Oracle Call Interface (OCI), Microsoft .NET Framework, and Java Database Connectivity (JDBC).

In Oracle Database, JSON data is stored using the common SQL data types VARCHAR2, CLOB, and BLOB (unlike XML data, which is stored using abstract SQL data type XMLType). Oracle recommends that you always use an is_json check constraint to ensure that column values are valid JSON instances.

Oracle also provides a family of Simple Oracle Document Access (SODA) APIs for access to JSON data stored in the database. SODA is designed for schemaless application development without knowledge of relational database features or languages such as SQL and PL/SQL. It lets you create and store collections of documents in Oracle Database, retrieve them, and query them, without needing to know how the documents are stored in the database.

### Objectives

-   Learn how to store and access JSON Data in the Oracle Database

### Lab Prerequisites

This lab assumes you have completed the following labs:
* Lab: Login to Oracle Cloud
* Lab: Generate SSH Key
* Lab: Setup

### Lab Preview

Watch the video below to get an explanation of using JSON in the Oracle Database


## Step 1:

Lab under construction

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Troy Anthony, DB Product Management, April 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
