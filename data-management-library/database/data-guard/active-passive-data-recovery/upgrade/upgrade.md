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
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Initialize Environment

## About the In-Place Upgrade Strategy
The in-place upgrade allows you to take your existing deployment and upgrade it in site.

- When performing an upgrade, you should make as few changes as possible in each stage to ensure that the upgrade is successful.

- For example, it is not recommended to perform multiple upgrade activities such as upgrading Oracle Identity and Access Management, changing the directory, updating the operating system, and so on, all at the same time.

- If you want to perform such an upgrade, you must do it in stages. You must validate each stage before moving on to the next. The benefit of this approach is that it helps you to identify precisely where the issue occurred, and correct it or undo it before you continue the exercise.  

## Upgrade IAM 11g instance to 12c
Follow the instructions in the document below to perform in-place upgrade of the 11g instance to 12c  
[Upgrade to 12c](https://docs.oracle.com/en/middleware/fusion-middleware/iamus/place-upgrade-strategies.html#GUID-9F906AE2-5BDF-426D-A97C-AC546ABFBD28)  

Oracle IAM 12c PS3 can be [downloaded here](https://www.oracle.com/middleware/technologies/identity-management/downloads.html)  

Following activities need to be performed for this upgrade
- In-Place Upgrade of Oracle Unified Directory (OUD)
- In-Place Upgrade of Oracle Identity Manager (OIM)
- In-Place Upgrade of Oracle Access Manager (OAM)
- In-Place Upgrade of Oracle HTTP Server (OHS)

Following sections provide Oracle documentation links that will guide you through the upgrade process.

##  **STEP 1**: Upgrading Oracle Unified Directory (OUD)
You can update an Oracle Unified Directory directory service to the latest version without a service interruption. It also describes how to update an individual directory server instance and provides considerations for Oracle Unified Directory Services Manager on Oracle Weblogic Server.  
- [Updating the Oracle Unified Directory Software](https://docs.oracle.com/en/middleware/idm/unified-directory/12.2.1.3/oudig/updating-oracle-unified-directory-software.html#GUID-FFEACD0B-4A7E-4B22-A5A0-0D96DD0D76EE)

##  **STEP 2**: Upgrading Oracle Identity Manager (OIM)

- [Upgrading Oracle Identity Manager Document](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.4/iamup/upgrading-oracle-identity-manager.pdf)
- [About the Basic 12c Upgrade Process Flow](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/asmas/planning-upgrade-oracle-fusion-middleware-12c.html#GUID-1B86A825-0448-4245-BEA4-0019AEE8AB54)
- [Upgrading Oracle Identity Manager Single Node Environments](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.3/iamup/upgrading-oracle-identity-manager-single-node-environments.html#GUID-5A172DD8-6C47-491C-BEA7-B01A3ED838D6)

##  **STEP 3**: Upgrading Oracle Access Manager (OAM)
- [Introduction to Upgrading Oracle Access Manager](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/oamup/introduction-upgrading-oracle-identity-and-access-management-12c.html#GUID-71B1B82A-A869-42FB-AC79-210C4B3C4CF2)
- [Pre-Upgrade Requirements](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/oamup/upgrade-requirements.html#GUID-5ADFC514-7092-4D69-9B4F-D6637579C02E)
- [In-Place Upgrade of Oracle Access Manager](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/oamup/place-upgrade-oracle-access-manager.html)

##  **STEP 4**: Upgrading Oracle HTTP Server (OHS)
- [Introduction to Upgrading Oracle HTTP Server](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/ohsup/introduction-upgrading-oracle-http-server-12c-12.2.1.2.html#GUID-AAF9C05E-E5C0-4E01-BA68-069C04ADC48F)
- [Preparing to Upgrade Oracle HTTP Server](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/ohsup/preparing-upgrade-oracle-http-server.html#GUID-A8CE118C-2949-4C46-85F9-2D2B523B0A61)
- [Upgrading Oracle HTTP Server](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/ohsup/upgrading-oracle-http-server-11g-12c.html)

## Learn More About Identity and Access Management
Use these links to get more information about Oracle Identity and Access Management:
- [Oracle Identity Management Website](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.4/index.html)
- [Oracle Identity Governance Documentation](https://docs.oracle.com/en/middleware/idm/identity-governance/12.2.1.4/index.html)
- [Oracle Access Management Documentation](https://docs.oracle.com/en/middleware/idm/access-manager/12.2.1.4/books.html)

## Acknowledgements
* **Author** - Anbu Anbarasu, Director, Cloud Platform COE  
* **Contributors** -  Eric Pollard, Sustaining Engineering  
* **Last Updated By/Date** - Anbu, COE, February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
