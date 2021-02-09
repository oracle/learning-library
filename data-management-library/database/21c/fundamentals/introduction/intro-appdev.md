# Introduction

This section of the workshop introduces new operators, parameters, expressions and SQL Macros available in the latest release of Oracle Database, 21c. Oracle 21c introduces three new operators, EXCEPT, EXCEPT ALL and INTEREST ALL. The SQL set operators now support all keywords as defined in ANSI SQL. The new operator EXCEPT [ALL] is functionally equivalent to MINUS [ALL]. The operators MINUS and INTERSECT now support the keyword ALL.

You can use expressions in initialization parameters, that are evaluated during database start up. You can now specify an expression that takes into account the current system configuration and environment. This is especially useful in Oracle Autonomous Database environments.

You can create SQL Macros (SQM) to factor out common SQL expressions and statements into reusable, parameterized constructs that can be used in other SQL statements. SQL macros can either be scalar expressions, typically used in SELECT lists, WHERE, GROUP BY and HAVING clauses, to encapsulate calculations and business logic or can be table expressions, typically used in a FROM clause.

Estimated Workshop Time: 60 minutes

### Labs
* New Set Operators
* Expressions in Init Parameters
* SQM Scalar and Table Expressions
* Searching Text/JSON in In-Memory

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Working knowledge of vi

You may now [proceed to the next lab](#next).

## About Oracle Database 21c
The 21c generation of Oracle's converged database offers customers; best of breed support for all data types (e.g. relational, JSON, XML, spatial, graph, OLAP, etc.), and industry leading performance, scalability, availability and security for all their operational, analytical and other mixed workloads.

 ![Oracle DB 21c Advantages](images/21c-support.png "Oracle DB 21c Advantages")
Key updates made in Database 21c are:
* JSON binary data type
* Blockchain tables
* Auto machine learning with Python
* Enhancements for sharding, database in-memory and graph analytics.

With 21c, customers can
* Reduce IT cost and complexity
* Unlock innovation
* Develop powerful, data-driven applications


## Learn More

* [Oracle Database Blog](http://blogs.oracle.com/database)
* [Introducing Oracle Database 21c](https://blogs.oracle.com/database/introducing-oracle-database-21c)

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** - Kay Malcolm, David Start, Kamryn Vinson, Anoosha Pilli, Tom McGinn, Database Product Management
* **Last Updated By/Date** - Kay Malcolm, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
