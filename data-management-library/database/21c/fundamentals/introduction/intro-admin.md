# Introduction

This section of the workshop highlights enhancements in Oracle Database 21c to improve the security of passwords.

Estimated Workshop Time: 60 minutes

## Administration in Oracle Database 21c
Starting in this release, the parameter to enable or disable password file case sensitivity is removed. All passwords in new password files are case-sensitive.

Case-sensitive password files provide more security than older password files that are case insensitive. Oracle recommends that you use case-sensitive password files. However, upgraded password files from earlier Oracle Database releases can retain their original case-insensitivity. You can force your password files to be case-sensitive by migrating password files from one format to another.

### Labs
* Upgraded Password File Case Sensitivity
* Password Length Enforcement

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
