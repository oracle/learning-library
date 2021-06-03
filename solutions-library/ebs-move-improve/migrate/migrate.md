# Migrate Existing EBS to Cloud Manager

## About this Workshop

This workshop showcases the use of the migration of an existing Oracle E-Business Suite to Oracle Cloud Infrastructure using the Object Storage service to our Cloud Manager instance. 

### **Access this workshop**:
[**Migrate EBS to OCI EBS Cloud Manager**](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=753&p210_type=1&session=12356884103673)

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
* Prepare the source EBS enviornment for migration.
* Install the Oracle E-Business Suite Cloud Backup Module on the source environment.
* Create a backup of the source EBS environment and store it on the Oracle Object Storage service.
* Provision a new EBS instance in Cloud Manager using the backup of the source EBS enviornment.

### **Prerequisites**

* A MyOracleSupport account is needed to download the Cloud Backup tool to the source EBS environment.
* key-data.txt file documented with following information (from this EBS Cloud Manger lab).

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

**Access this workshop**

[**Migrate EBS to OCI EBS Cloud Manager**](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=753&p210_type=1&session=12356884103673)

## Acknowledgements

* **Author:** William Masdon, Cloud Engineering
* **Contributors:** Santiago Bastidas, Product Management Director
* **Contributors:** Quintin Hill, Cloud Engineering
* **Last Updated By/Date:** William Masdon, Cloud Engineering, May 2021

