# IAM 11g to 12c Upgrade

## Introduction

An Oracle Identity and Access Management deployment consists of a number of different components:
- A database
- An LDAP directory to store user information
- Oracle Access Manager for Authentication
- Oracle Identity Governance (formally Oracle Identity Manager) for provisioning
- Optionally, Oracle HTTP Server and Webgate securing access to Oracle Access Manager and Oracle Identity Governance

There are different upgrade strategies that you can employ for an upgrade of Oracle Internet Directory, Oracle Unified Directory, and Oracle Identity and Access Management. The strategy you choose will depend mainly on your business needs.

*Estimated Lab Time*:  24 Hours

### Objectives
- Become familiar with the process to upgrade IAM 11g to 12c

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

##  **STEP 1**: Upgrading Oracle Unified Directory (OUD)
You can update an Oracle Unified Directory service to the latest version without a service interruption. It also describes how to update an individual directory server instance and provides considerations for Oracle Unified Directory Services Manager on Oracle WebLogic Server.  
1. First review the Prerequisites and considerations for upgrading OUD
    - [Updating the Oracle Unified Directory Software](https://docs.oracle.com/en/middleware/idm/unified-directory/12.2.1.3/oudig/updating-oracle-unified-directory-software.html#GUID-FFEACD0B-4A7E-4B22-A5A0-0D96DD0D76EE)
2. You can upgrade all Oracle Unified Directory server instances that are associated with a specific ORACLE_HOME directory.
    - [Upgrading an Existing Oracle Unified Directory Server Instance](https://docs.oracle.com/en/middleware/idm/unified-directory/12.2.1.3/oudig/updating-oracle-unified-directory-software.html#GUID-506B9DAC-2FDB-47C9-8E00-CC1F99215E81)
3. If any step in the upgrade process fails, then terminate the upgrade process and restore the environment to its original state using the backup files you created
4. Oracle Unified Directory provides several command-line utilities to tune the server and to configure the various options for the Java Virtual Machine (JVM), Java, and database cache.
    - [Configure OUD](https://docs.oracle.com/en/middleware/idm/unified-directory/12.2.1.3/oudig/configuring-jvm-java-and-database-cache-options-oracle-unified-directory.html#GUID-CB679A74-AC86-436F-AFB1-8717CFC55911)

##  **STEP 2**: Upgrading Oracle Identity Manager (OIM)

Before you begin, review all introductory information to understand the standard upgrade topologies and upgrade paths for Oracle Identity Manager 12c (12.2.1.3.0). The product Oracle Identity Manager is referred to as Oracle Identity Manager (OIM) and Oracle Identity Governance (OIG) interchangeably in the guide. To identify potential issues with the upgrade, Oracle recommends that you run a readiness check before you start the upgrade process. Be aware that the readiness check may not be able to discover all potential issues with your upgrade. An upgrade may still fail, even if the readiness check reports success.

1. Review the upgrade process for upgrading OIM
    - [Upgrading Oracle Identity Manager Document](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.4/iamup/upgrading-oracle-identity-manager.pdf)
2. Review the starting points for OIM Upgrade
    - [Starting Points](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.3/iamup/introduction-upgrading-oracle-identity-and-access-management-12c.html#GUID-DB254BA6-1858-45F7-B8EC-0D1D247348DD)
3. Follow the instructions to perform in-place upgrade of a single node environment
    - [Upgrading Oracle Identity Manager Single Node Environments](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.3/iamup/upgrading-oracle-identity-manager-single-node-environments.html#GUID-5A172DD8-6C47-491C-BEA7-B01A3ED838D6)

##  **STEP 3**: Upgrading Oracle Access Manager (OAM)

Oracle Access Management provides innovative new services that complement traditional access management capabilities. It not only provides Web SSO with MFA, coarse grained authorization and session management but also provides standard SAML Federation and OAuth capabilities to enable secure access to external cloud and mobile applications. It can be easily integrated with the Oracle Identity Cloud Service to support hybrid access management capabilities that can help customers to seamlessly protect on-premise and cloud applications and workloads.

The following steps will guide you through the OAM 11g upgrade to 12c.

1. Review the basics of OAM Upgrade
    - [Introduction to Upgrading Oracle Access Manager](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/oamup/introduction-upgrading-oracle-identity-and-access-management-12c.html#GUID-71B1B82A-A869-42FB-AC79-210C4B3C4CF2)
2. Review and Verify pre-upgrade Requirements
    - [Pre-Upgrade Requirements](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/oamup/upgrade-requirements.html#GUID-5ADFC514-7092-4D69-9B4F-D6637579C02E)
3. Upgrade the single-node OAM instance to 12c using these steps
    - [In-Place Upgrade of Single Node Oracle Access Manager](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/oamup/upgrading-oracle-access-manager-single-node-environments.html#GUID-2E216D22-A2F6-4D68-ACB6-17A015E8991E)

##  **STEP 4**: Upgrading Oracle HTTP Server (OHS)
Oracle HTTP Server is the Web server component for Oracle Fusion Middleware. It provides a listener for Oracle WebLogic Server and the framework for hosting static pages, dynamic pages, and applications over the Web. Before you begin, review all introductory information to understand the standard upgrade topologies and upgrade paths for Oracle HTTP Server 12c (12.2.1.3.0)

1. Review the starting points and upgrade restrictions
    - [Introduction to Upgrading Oracle HTTP Server](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/ohsup/introduction-upgrading-oracle-http-server-12c-12.2.1.2.html#GUID-AAF9C05E-E5C0-4E01-BA68-069C04ADC48F)
2. Review Pre-Upgrade checklist and verify the Requirements
    - [Preparing to Upgrade Oracle HTTP Server](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/ohsup/preparing-upgrade-oracle-http-server.html#GUID-A8CE118C-2949-4C46-85F9-2D2B523B0A61)
3. Review the standalone OHS upgrade process, upgrade considerations, and install OHS 12c
    - [Upgrading Oracle HTTP Server](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/ohsup/upgrading-oracle-http-server-11g-12c.html)

## Appendix 1: About the In-Place Upgrade Strategy
The in-place upgrade allows you to take your existing deployment and upgrade it in site.

- When performing an upgrade, you should make as few changes as possible in each stage to ensure that the upgrade is successful.

- For example, it is not recommended to perform multiple upgrade activities such as upgrading Oracle Identity and Access Management, changing the directory, updating the operating system, and so on, all at the same time.

- If you want to perform such an upgrade, you must do it in stages. You must validate each stage before moving on to the next. The benefit of this approach is that it helps you to identify precisely where the issue occurred, and correct it or undo it before you continue the exercise.  

## Appendix 2: Upgrade IAM 11g instance to 12c
Follow the instructions in the document below to perform in-place upgrade of the 11g instance to 12c  
[Upgrade to 12c](https://docs.oracle.com/en/middleware/fusion-middleware/iamus/place-upgrade-strategies.html#GUID-9F906AE2-5BDF-426D-A97C-AC546ABFBD28)  

As stated in *Lab: Initialize Environment*, all software downloads needed for all labs have been staged in */home/oracle/Downloads*. To familiarize yourself with the downloads, [Click here to review the listing of Oracle IAM 12c PS3](https://www.oracle.com/middleware/technologies/identity-management/downloads.html)  

Following activities need to be performed for this upgrade
- In-Place Upgrade of Oracle Unified Directory (OUD)
- In-Place Upgrade of Oracle Identity Manager (OIM)
- In-Place Upgrade of Oracle Access Manager (OAM)
- In-Place Upgrade of Oracle HTTP Server (OHS)

**This concludes this lab.**

## Learn More
Use these links to get more information about Oracle Identity and Access Management:
- [Oracle Identity Management Website](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.4/index.html)
- [Oracle Identity Governance Documentation](https://docs.oracle.com/en/middleware/idm/identity-governance/12.2.1.4/index.html)
- [Oracle Access Management Documentation](https://docs.oracle.com/en/middleware/idm/access-manager/12.2.1.4/books.html)

## Acknowledgements
* **Author** - Anbu Anbarasu, Director, Cloud Platform COE  
* **Contributors** -  Eric Pollard, Rene Fontcha  
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, March 2021

## Need Help?
Please submit feedback or ask for help by sending an email to [livelabs-help-iam_us@oracle.com](livelabs-help-iam_us@oracle.com). Please make sure to include your workshop name and lab name. You can also include screenshots and attach files.
