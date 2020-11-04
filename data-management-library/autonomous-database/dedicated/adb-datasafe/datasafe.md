# Data Safe with Autonomous Dedicated
## Introduction
Data Safe is a unified security control center for your Oracle Autonomous Databases in OCI. Data Safe provides security automation to easily detect PII and other sensitive data elements in your autonomous databases, create masked clones for test/dev, assess and monitor user security, centralize audit data and generate security and compliance reports. Data Safe also works on your on-premises Oracle databases and other OCI database services.

This workshop walks you through the steps to get started using Oracle Data Safe with ADB Dedicated on Oracle Cloud Infrastructure.

*Note: There are a few ways to sign in to the Oracle Data Safe Console. You can sign in from the Oracle Data Safe service page in Oracle Cloud Infrastructure. You can sign in through the Oracle Cloud Infrastructure Console. And you can sign in using a bookmark to your Oracle Data Safe Console.*

### Objectives

This workshop comprises various aspects of Data Security. So follow the given sequence to enhance your skills on utilizing Data Safe with ADB
1. [Register a Target Database](?lab=lab-27-1-register-target-database)

2. Security and User Assessment
- [Assessment Lab 1](?lab=lab-27-2-assess-database-configurations) - Assess Database Configurations with Oracle Data Safe
- [Assessment Lab 2](?lab=lab-27-3-assess-users-oracle-data-safe) - Assess Users with Oracle Data Safe
3. Sensitive Data Discovery
- [Discovery Lab 1](?lab=lab-27-4-discover-sensitive-data-oracle) - Discover Sensitive Data with Oracle Data Safe
- [Discovery Lab 2](?lab=lab-27-5-verify-sensitive-data-model) - Verify a Sensitive Data Model with Oracle Data Safe
- [Discovery Lab 3](?lab=lab-27-6-update-sensitive-data-model) - Update a Sensitive Data Model with Oracle Data Safe
- [Discovery Lab 4](?lab=lab-27-7-create-sensitive-type-sensitive) - Create a Sensitive Type and Sensitive Category with Oracle Data Safe
4. Data Masking
- [Masking Lab 1](?lab=lab-27-8-discover-mask-sensitive-data-by) - Discover and Mask Sensitive Data by Using Default Masking Formats in Oracle Data Safe
- [Masking Lab 2](?lab=lab-27-9-explore-data-masking-results) - Explore Data Masking Results and Reports in Oracle Data Safe
- [Masking Lab 3](?lab=lab-27-10-create-masking-format-oracle-data) - Create a Masking Format in Oracle Data Safe
- [Masking Lab 4](?lab=lab-27-11-configure-variety-masking-formats) - Configure a Variety of Masking Formats with Oracle Data Safe
5. Auditing and Reporting
- [Auditing Lab 1](?lab=lab-27-12-provision-audit-alert-policies) - Provision Audit and Alert Policies and Configure an Audit Trail in Oracle Data Safe
- [Auditing Lab 2](?lab=lab-27-13-analyze-audit-data-reports-ale) - Analyze Audit Data with Reports and Alerts in Oracle Data Safe
- [Auditing Lab 3](?lab=lab-27-14-create-provision-custom-audit)- Create and Provision a Custom Audit Policy and View Audit Data in Oracle Data Safe

### Required Artifacts

- Login credentials for your tenancy in Oracle Cloud Infrastructure
- An Oracle Database Service enabled in a region in your tenancy
- A registered target database in Oracle Data Safe with sample audit data and the password for the SYS user account. 
- [Enable Oracle Data Safe](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/enable-oracle-data-safe.html#GUID-1293621D-A6C6-448C-AD97-38B90A9473F0)

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/autonomous-database-dedicated). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.