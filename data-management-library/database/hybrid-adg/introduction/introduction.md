# Introduction

## About this Workshop
In this workshop you will be using a compute instance in OCI to simulate the on-premise database, which is deployed in one region (For example: Seoul). The standby cloud database is deployed in another region (For example: Tokyo). The primary and the standby database communicate through public internet.

When provisioning Database Cloud Services in OCI, there are 2 options for the storage management. One is **Oracle Grid Infrastructure** which is using ASM to manage the database files. The other is **Logical Volume Manager** which is using the File System to manage the database files. In Lab 3, please choose the right one according to your requirement. When doing Lab 5, choose Lab 5A for LVM or Lab 5B for ASM.

Estimated Workshop Time: 5 hours

### About ADG
Oracle’s Maximum Availability Architecture (Oracle MAA) is the best practices blueprint for data protection and availability for Oracle databases deployed on private, public or hybrid clouds. Data Guard and Active Data Guard provide disaster recovery (DR) for databases with recovery time objectives (RTO) that cannot be met by restoring from backup. Customers use these solutions to deploy one or more synchronized replicas (standby databases) of a production database (the primary database) in physically separate locations to provide high availability, comprehensive data protection, and disaster recovery for mission-critical data. 

An effective disaster recovery plan can be costly due to the need to establish, equip and manage a remote data center. The Oracle Cloud offers a great alternative for hosting standby databases for customers who do not have a DR site or who prefer not to deal with the cost or complexity of managing a remote data center. Existing production databases remain on-premises and standby databases used for DR are deployed on the Oracle Cloud. This mode of deployment is commonly referred to as a hybrid cloud implementation. 

### Benefits of Hybrid Standby in the Cloud 

1. Cloud data center and infrastructure is managed by Oracle 

2. Cloud provides basic system life cycle operations including bursting and shrinking resources 

3. Oracle Data Guard provides disaster recovery, data protection and ability to offload activity for higher utilization and return on investment. 

4. When configured with MAA practices, RTO of seconds with automatic failover when configured with Data Guard Fast-Start failover and RPO less than a second for Data Guard with ASYNC transport or RPO zero for Data Guard in SYNC or FAR SYNC configurations 

### Objectives

In this lab, you will:
* Provision a Compute instance as the on-premise primary database
* Provision a DBCS as the standby database
* Setup the ADG between primary and standby.
* Test the ADG including DML redirection and switchover.
* Failover and reinstate the instance.

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account


## Learn More
- [Oracle Data Guard](https://www.oracle.com/database/technologies/high-availability/dataguard.html)
- [Oracle Database 19c](https://www.oracle.com/database/)

## Acknowledgements
* **Author** - Minqiao Wang, DB Product Management
* **Last Updated By/Date** - Minqiao Wang, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.