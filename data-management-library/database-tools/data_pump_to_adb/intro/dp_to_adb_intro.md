# Data Pump your data to the Oracle Autonomous Database

## Introduction
Oracle tools make it seamless to move your on-premises database to the Oracle Cloud with virtually no downtime. Using the same technology and standards on-premises and in the Oracle Cloud, you can facilitate the same products and skills to manage your cloud-based Oracle Databases as you would on any other platform.

The <a href="https://blogs.oracle.com/cloud-infrastructure/database-migration-to-oracle-cloud-infrastructure-evaluation-and-planning-checklist" target="\_blank"> Evaluation and Planning Checklist /a> will help you evaluate and plan for the migration of your databases to Oracle Cloud Infrastructure, based on the unique requirements of your source and target databases.

Visit the website <a href="https://www.oracle.com/database/technologies/cloud-migration.html" target="\_blank"> Move to the Oracle Cloud /a> for comprehensive information on migrating to the Oracle Cloud.

### Objectives

-   Migrate data from a source database to the Oracle Autonomous Database using SQL Developer

### Required Artifacts

-   The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

### Prerequisites
This lab assumes you have completed the following labs:
* Lab: [Login to Oracle Cloud]()
* Lab: [Provision an Autonomous Database]()

A Source database is needed. You may already have Virtual Box on your laptop, a database in your data centre, a Docker container running Oracle, and so on.

If you need a simple database to act as a source you can follow the prelimnary labs listed here to establish one.
* Lab: [Deploy a Compute Instance and create a database]
* Lab: [Install the sample schemas]
* Lab: [Establish VNC on a Compute Instance]

This lab will use SQL Developer to coordinate the migration. If you already have SQL Developer co-located with your source database then you are prepared. If you have built the environment described above, you can install SQL Developer on your Compute Instance.
* Lab: [Install SQL Developer on a Compute Instance]

Privileges to run Data Pump are required.
At least one Credential defined to your Oracle Object Store ‘bucket’

# Data Pump your data to the Oracle Autonomous Database

There are many ways to migrate Oracle Databases to the Oracle Autonomous Database, involving and including, but not limited to:

  * SQL Developer
  * Data Guard
  * Golden Gate
  * Zero Dowmtime Migration
  * ZDLRA
  * Oracle Data Transfer Appliance
  * MV2ADB

In this lab you will use the SQL Developer tool, connect to your source database and use Data Pump to create an export of your schema. SQL Developer can then import that data directly in to the Autonomous Database via the Oracle Object Store.

## Acknowledgements

 - **Author** - Troy Anthony, May 2020
 - **Last Updated By/Date** - Troy Anthony, May 20 2020

 ## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
