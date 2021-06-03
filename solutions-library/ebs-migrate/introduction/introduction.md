# Introduction

## About this Workshop

This workshop showcases the use of the migration of an existing Oracle E-Business Suite to Oracle Cloud Infrastructure using the Object Storage service. 

In order to complete this lab, it is required that you complete the **Lift and Shift On-Premises EBS to OCI Workshop** found [here](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=672&clear=180&session=5980193088668). This workshop uses information that is recorded in the referenced lab. This information is necessary in order to preform this workshop. 

Estimated Workshop Time: 1.5 hours
    Note: This does not include downtime for creating the backup, which lasts about 2.5 hours. 

### **Background**

Creating a backup of your source Oracle E-Business Suite instance is the first part of a lift and shift process. You can subsequently complete the lift and shift process by using Oracle E-Business Suite Cloud Manager to provision an environment on Oracle Cloud Infrastructure based on the backup.

Note: Although this process is intended primarily for on-premises instances, you can also run the Oracle E-Business Suite Cloud Backup module to conduct a lift and shift in certain cases when the source environment is already in Oracle Cloud Infrastructure with optional database services. These cases include the following:
  * You initially used a manual procedure, such as a platform migration, to migrate an environment to Oracle Cloud Infrastructure, and now would like to leverage Oracle E-Business Suite Cloud Manager to manage that environment going forward.
  * You want to migrate your environment from one tenancy to another. The lift and shift process can be used for this purpose whether or not you are currently using Oracle E-Business Suite Cloud Manager.

Notes:

* The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
* IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs as these are dynamically generated.
* For security purposes, some sensitive text (such as IP addresses) may be redacted in the screenshots in this workbook.

UNIX commands (usually executed in an SSH session using PuTTY) are displayed in a monospace font within a box, as follows:

```
$ sudo yum install wget -y $ wget -O bitnami-mean-linux-installer.run https://bitnami.com/stack/mean/download_latest/linux-x64
```

### Workshop Overview


This workshop uses the following components:

* Trial accounts (one per attendee).

* Virtual Cloud Network and related resources.
    - User-generated using Resource Manager and provided Terraform script.

* Oracle E-Business Suite Cloud Manager Compute instance.
    - User-provisioned using Oracle Marketplace image.
    - Oracle E-Business Suite Cloud Manager application.
    - EBS sandbox network deployment script.

* Oracle E-Business Suite environment 1 Compute instance.
    - User-provisioned environment from OCI Marketplace.
    - Application and database tiers on this compute instance.



### Objectives

In this lab, you will:
* Create a standalone E-Business Suite Environment that will act as the source for the migration.
* Prepare the source EBS environment for migration.
* Install the Oracle E-Business Suite Cloud Backup Module on the source environment.
* Create a backup of the source EBS environment and store it on the Oracle Object Storage service.
* Provision a new EBS instance in Cloud Manager using the backup of the source EBS environment.

### **Prerequisites**

* Complete Workshop: [Lift and Shift On-Premises EBS to OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=672&clear=180&session=5980193088668).
* A MyOracleSupport account is needed to download the Cloud Backup tool to the source EBS environment.
* key-data.txt file documented with following information (from the EBS Cloud Manger lab).

**From MyOracleSupport Account:**

* `MOS_Email_Address` (typically your tenancy admin user).

**From Provisioning your Cloud Manager Instance You Should have recorded:**

* `Oracle_Cloud_Region_Identifier`
* `Oracle_Cloud_Tenancy_Name`
* `Oracle_Cloud_Tenancy_OCID`
* `Cloud_Manager_Admin_User_OCID`
* `Cloud_Manager_Admin_Fingerprint`
* `Oracle_Cloud_Compartment_OCID`
* `Cloud_Manager_Instance_public_IP`

**From your source EBS Instance**

* `Source_EBS_Instance_public_IP`
* `Source_EBS_Instance_private_IP`
* `Fully_Qualified_Hostname` (In this Lab: apps.example.com)
* `apps_password` (In this Lab: apps)
* `weblogic_password` (In this Lab: welcome1)


You may now proceed to the next lab.

## Appendix
### Terminology

The following terms are commonly employed in Oracle E-Business Suite cloud operations and used throughout our documentation:

**Availability Domain** – One or more data centers located within a region.

**Bucket** – A logical container used by Object Storage for storing your data and files. A bucket can contain an unlimited number of objects.

**Compartments** – Allows you to organize and control access to your cloud resources. A compartment is a collection of related resources (such as instances, virtual cloud networks, block volumes) that can be accessed only by certain groups.

**Oracle E-Business Suite Cloud Backup Module** – The Oracle E-Business Suite Cloud Backup Module is a standalone tool that interviews the user to establish settings, and then uses those settings to back up an Oracle E-Business Suite environment to Oracle Cloud Infrastructure Object Storage.

**Oracle E-Business Suite Cloud Manager** - Oracle E-Business Suite Cloud Manager is a graphical user interface used for creating, managing, and configuring Oracle E-Business Suite environments on Oracle Cloud Infrastructure. Oracle E-Business Suite Cloud Manager can be used with the Oracle E-Business Suite Cloud Backup Module to lift and shift or clone environments from on-premises to Oracle Cloud Infrastructure.

**EBS Cloud Manager infrastructure** – Virtual network resources, compute resources, and policies required to run EBS Cloud Manager on Oracle Cloud Infrastructure.

**EBS Sandbox Virtual Cloud Network (VCN)** – Networking and compute resources required to run EBS on Oracle Cloud Infrastructure. The EBS Sandbox VCN includes the recommended networking resources (VCN, subnets routing tables, internet gateway, security lists, and security rules) to run Oracle E-Business Suite on OCI.

**Oracle Cloud Infrastructure Load Balancing Service** - The Oracle Cloud Infrastructure Load Balancing service provides automated traffic distribution from one entry point to multiple servers reachable from your virtual cloud network (VCN). The service offers a load balancer with your choice of a public or private IP address, and provisioned bandwidth.

**Oracle Cloud Infrastructure (OCI)** – Combines the elasticity and utility of public cloud with the granular control, security, and predictability of on-premises infrastructure to deliver high-performance, high availability, and cost-effective infrastructure services.

**Region** – Oracle Cloud Infrastructure are hosted in regions, which are located in different metropolitan areas. Regions are completely independent of other regions and can be separated by vast distances – across countries or even continents. Generally, you would deploy an application in the region where it is most heavily used, since using nearby resources is faster than using distant resources.

**Tenancy** – When you sign up for Oracle Cloud Infrastructure, Oracle creates a tenancy for your company, which is a secure and isolated partition within Oracle Cloud Infrastructure where you can create, organize, and administer your cloud resources.

**Virtual Cloud Network (VCN)** – A virtual version of a traditional network – including subnets, route tables, and gateways – on which your instances run. A cloud network resides within a single region, but can cross multiple availability domains.

## Acknowledgments

* **Author:** William Masdon, Cloud Engineering
* **Contributors:** 
    - Aurelian Baetu, Technology Engineering HUB - Cloud Infrastructure
    - Santiago Bastidas, Product Management Director
    - Quintin Hill, Cloud Engineering
* **Last Updated By/Date:** William Masdon, Cloud Engineering, May 2021


