# Oracle Database 19c JSON Documents

## Workshop Overview

**JavaScript Object Notation (JSON)** is defined in standards ECMA-404 (JSON Data Interchange Format) and ECMA-262 (ECMAScript Language Specification, third edition). The JavaScript dialect of ECMAScript is a general programming language used widely in web browsers and web servers.

**Oracle Database** supports **JavaScript Object Notation (JSON)** data natively with relational database features, including transactions, indexing, declarative querying, and views.

This workshop aims to help you understanding JSON data and how you can use SQL and PL/SQL with JSON data stored in Oracle Database.

***Schemaless*** development based on persisting application data in the form of JSON documents lets you quickly react to changing application requirements. You can change and redeploy your application without needing to change the storage schemas it uses.

SQL and relational databases provide flexible support for complex data analysis and reporting, as well as rock-solid data protection and access control. This is typically not the case for NoSQL databases, which have often been associated with schemaless development with JSON in the past.

Oracle Database provides all of the benefits of SQL and relational databases to JSON data, which you store and manipulate in the same ways and with the same confidence as any other type of database data.

## Workshop Requirements

* Oracle Database 19c
    * Installed on local machine, virtual machine, or cloud compute node
* Oracle sample schemas
    * Order Entry (OE) sample schema
* No previous knowledge of JSON development required

## Disclaimer

Unless explicitly identified as such, the sample code here is not certified or supported by Oracle; it is intended for educational or testing purposes only. The code samples may be modified but not redistributed.
This document is intended for attendees of the workshop for their private use. It is not to be sold, distributed to others, or posted on internal or external web sites without the written consent of the Oracle Corporation.

## Agenda

- **Environment Preparation**

For this workshop we will use the ***Order Entry (OE)*** sample schema that comes with Oracle Database installation. Just to make sure we have the same data in all environments, we use Data Pump to import one particular version of OE schema, exported in a dump file. 

- **Working with JSON**

This workshop covers the use of database languages and features to work with JSON data that is stored in Oracle Database. In particular, it covers how to use SQL and PL/SQL with JSON data. 

- **Syntax Simplifications**

In Oracle 19c, there were some improvements in the simplicity of querying JSON documents using SQL. Other improvements were made as well in generating JSON documents on the fly from relational data. 

- **Updating a JSON Document**

You can now update a JSON document declaratively using the new SQL function ***JSON_MERGEPATCH***. You can apply one or more changes to multiple documents by using a single statement. This feature improves the flexibility of JSON update operations. 

- **JSON Materialized View Support**

Materialized views query rewriting has been enhanced so that queries with ***JSON_EXISTS***, ***JSON_VALUE*** and other functions can utilize a materialized view created over a query that contains a ***JSON_TABLE*** function.

This feature is particularly useful when the JSON documents in a table contain arrays. This type of materialized view provides fast performance for accessing data within those JSON arrays.

- **JSON-Object Mapping**

This feature enables the mapping of JSON data to and from user-defined SQL object types and collections. You can convert JSON data to an instance of a SQL object type using SQL/JSON function ***JSON_VALUE***. In the opposite direction, you can generate JSON data from an instance of a SQL object type using SQL/JSON function ***JSON_OBJECT*** or ***JSON_ARRAY***. 

## Access the labs

- Use **Lab Contents** menu on your right to access the labs.
    - If the menu is not displayed, click the menu button ![](./images/menu-button.png) on the top right  make it visible.

- From the menu, click on the lab that you like to proceed with. For example, if you like to proceed to **Environment Preparation**, click **Environment Preparation**.

- You may close the menu by clicking ![](./images/menu-close.png "")

---
