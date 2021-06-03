# Introduction

## About this Workshop

This hands-on lab provides users with step-by-step instructions for preparing their **Oracle Cloud Infrastructure (OCI) Tenancy**, including setting up a user group, adding a user and policies, as well as a compartment to house **Cloud Manager 12 using Marketplace** and associated resources. After provisioning and configuring Cloud Manager 12, users will **subscribe to the HCM deployment kit** to then create a **topology**, **environment template**, and **provision a PeopleSoft Environment**. 

In addition to getting a PeopleSoft Environment up and running on Cloud Manager, users can then move on to the simple and interactive Labs (8-14). 
These optional labs help familiarize users with the features of Cloud Manager and can be completed in any order.

Estimated Lab Time: 7.5 hours, including provisioning time (Labs 1-7) 

To ensure success:
- The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
- Follow all naming conventions (compartment, group, etc..) and passwords as directed.   
- IP addresses and URLs in the screenshots in this workshop may differ from what you use in the labs as these are dynamically generated.
- The user interface for the Oracle Cloud Infrastructure is constantly evolving. As a result the screens depicted in this tutorial may not exactly coincide with the current release. This tutorial is routinely updated for functional changes of Peoplesoft Cloud Manager and Oracle Cloud Infrastructure, at which time any differences in the user interface will be reconciled.

### Architecture Diagram

  ![](./images/archnew12.png " ")


### Objectives

In Labs 1-7, you will:
* Set up an Oracle Cloud Infrastructure Account (Prerequisites) 
* Create Identity and Access Management (IAM) Resources (Lab 1) 
* Provision the Peoplesoft Cloud Manager using Marketplace (Lab 2)
* Configure Cloud Manager Settings (Lab 3)
* Subscribe to PeopleSoft Channels (Lab 4)
* Review and Update a Topology (Lab 5)
* Create a New Environment Template (Lab 6)
* Deploy a PeopleSoft Environment (Lab 7)

As aforementioned, Labs 1-7 cover the core purpose. 
Labs 8-14 guide users through executing additional Cloud Manager features:
Once users have spun up a PeopleSoft environment, they can:
* Clone an Existing PeopleSoft Environment (Lab 8) 
* Backup an Existing PeopleSoft Environment (Lab 9) 
* Patch an Existing PeopleSoft Environment (Lab 10)
* Upgrade an Existing PeopleSoft Environment (Lab 11)
* Create Governance Policies to Schedule Starting and Stopping a PeopleSoft Environment (Lab 12)
* Create a PUM Connection from a Source PeopleSoft Environment to a Target Environment (Lab 13)
* Refresh a PeopleSoft Environment from a Backup (Lab 14)

### Prerequisites
* An OCI tenancy with administrator user access. 
* My Oracle Support (MOS) credentials. Please make sure that you can successfully login to [Oracle Support](https://support.oracle.com). Note down this login credential in a notepad. You will use it later to provision Cloud Manager.
* Workstation/laptop to access the OCI console, PSFT Cloud Manager, and provisioned instances
* The following should be installed:
    * Firefox to connect to Cloud Manager PIA.
    * A different web browser (i.e. Chrome) to connect to OCI web console. 
    * If you have a windows machine, please download:
        * Git Bash [https://git-scm.com/download/win](https://git-scm.com/download/win)
        * Putty [https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html). In the Package Files section, click on an installer depending on 32/64 bits.


## Appendix

*Terminology*

The following terms are commonly employed in Peoplesoft cloud operations and used throughout our documentation:

**Availability Domain** – One or more data centers located within a region.

**Bucket** – A logical container used by Object Storage for storing your data and files. A bucket can contain an unlimited number of objects.

**Compartments** – Allows you to organize and control access to your cloud resources. A compartment is a collection of related resources (such as instances, virtual cloud networks, block volumes) that can be accessed only by certain groups.

**Peoplesoft Cloud Manager (PSFT)** - Oracle Peoplesoft Cloud Manager is a Peoplesoft lifecycle management application used for creating, managing, and configuring Peoplesoft environments on Oracle Cloud Infrastructure.

**PSFT Cloud Manager infrastructure** – Virtual network resources, compute resources, and policies required to run PSFT Cloud Manager on Oracle Cloud Infrastructure.

**Virtual Cloud Network (VCN)** – Networking and compute resources required to run PSFT on Oracle Cloud Infrastructure. The PSFT VCN includes the recommended networking resources (VCN, subnets routing tables, internet gateway, security lists, and security rules) to run Oracle Peoplesoft on OCI.

**Oracle Cloud Infrastructure (OCI)** – Combines the elasticity and utility of public cloud with the granular control, security, and predictability of on-premises infrastructure to deliver high-performance, high availability, and cost-effective infrastructure services.

**Region** – Oracle Cloud Infrastructure are hosted in regions, which are located in different metropolitan areas. Regions are completely independent of other regions and can be separated by vast distances – across countries or even continents. Generally, you would deploy an application in the region where it is most heavily used, since using nearby resources is faster than using distant resources.

**Subnet, Private** - Instances created in private subnets do not have direct access to the Internet. In this lab, we will be provisioning the Cloud Manager stack in Resource Manager, and creating private subnets. We will then choose to create a "jump host", or bastion host, as part of the installation. The IP for a private subnet cannot be accessed directly from the Internet. To access our CM instance in a private subnet, we will set up a jump host to enable SSH tunneling and Socket Secure (SOCKS) proxy connection to the Cloud Manager web server (PIA). The jump host is created using an Oracle Linux platform image, and will be created inside the VCN.

**Subnet, Public** - Instances that you create in a public subnet have public IP addresses, and can be accessed from the Internet.

**Tenancy** – When you sign up for Oracle Cloud Infrastructure, Oracle creates a tenancy for your company, which is a secure and isolated partition within Oracle Cloud Infrastructure where you can create, organize, and administer your cloud resources.



## Acknowledgments
* **Authors** - Megha Gajbhiye, Cloud Solutions Engineer; Sara Lipowsky, Cloud Engineer; Hayley Allmand, Cloud Engineer
* **Contributors** - Joowon Cho, Cloud Technologist
* **Last Updated By/Date** - Sara Lipowsky, Cloud Engineer, May 2021

