<!-- "filename": "https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/cloud-login-livelabs2.md" -->

# Introduction

## About this Workshop

This hands-on lab provides users with step-by-step instructions for preparing their **Oracle Cloud Infrastructure (OCI) Tenancy**, including setting up a user group, adding a user and policies, as well as a compartment to house the **Cloud Manager 11 using Marketplace**. The final sections provide guidance for **provisioning a PeopleSoft environment**, followed by interactive, yet simple excercises to familiarize users with the system.

<!-- For your convenience, this lab is available in offline formats available for download here:<br/>
[PSFT-Workshop Word Doc](https://objectstorage.us-ashburn-1.oraclecloud.com/p/1EIFGD4wIGKmoToeJ241ly9AuzPIA-7oeYauUYv1Qoz-t2dmEP4OjCF5BRcmtC3Q/n/orasenatdpltoci03/b/TestDrive/o/PSFT-HOL-Workshop.docx)     
[PSFT-Workshop PPT](https://objectstorage.us-ashburn-1.oraclecloud.com/p/0QHo_3IYUvoU7mdHlc2CgyF9hySoay4jhb5BWNM-7ve_nQEJB4IwlK594fRVbie4/n/orasenatdpltoci03/b/TestDrive/o/PSFT-CM-LabOverview.pptx)    
[PSFT-Workshop PDF](https://objectstorage.us-ashburn-1.oraclecloud.com/p/n7Khl1L7M_HC--UqWmwoiSv2vANQbCOFiqwFIF5xRQrZMLhzKrGviCzywpaBG67p/n/orasenatdpltoci03/b/TestDrive/o/PSFT-HOL-Workshop.pdf)   -->

Estimated Lab Time: 6 hours, including provisioning time. 


**Note**:

- The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
- Follow all naming conventions (compartment, group, etc..) and passwords as directed.   
- IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs as these are dynamically generated.

### Architecture Diagram

  ![](./images/arch.png " ")
<!-- Enter background information here....

*You may add an option video, using this format: [](youtube:YouTube video id)*

  [](youtube:zNKxJjkq0Pw) -->

### Objectives

In this lab, you will:
* Set up an Oracle Cloud Infrastructure Account (Prerequisites) 
* Create Identity and Access Management (IAM) Resources (Lab 1) 
* Provision the Peoplesoft Cloud Manager using Marketplace (Lab 2)
* Configure Cloud Manager Settings (Lab 3)
* Review and Update a Topology (Lab 4)
* Subscribe to PeopleSoft Channels (Lab 5)
* Create a New Environment Template (Lab 6)
* Create Environment in PeopleSoft (Lab 7)



### Prerequisites
1. User already has a tenancy with Administrator user access. (Please complete "Prerequisites" section)

2. My Oracle Support (MOS) credentials. Please make sure that you can successfully login to [Oracle Support](https://support.oracle.com). Note down this login credential in a notepad. You will use it later to configure Cloud Manager.

3. User should have their own workstation/laptop to access the OCI console, PSFT Cloud Manager, and provisioned instances. 

4. User has access to a workstation/laptop with the following installed:

    a. If you have a windows machine, please download Git Bash for Windows from here: https://git-scm.com/download/win  

    b. User must have admin privileges on their laptop to update the **etc/hosts** file to add URL/IP address for PSFT Cloud Manager. Please let the team know if you can't get this access.

    **NOTE: If you don't have admin privileges in your local machine, please make sure to follow the "Windows VM Compute Lab" after step 5 in Lab 2. You can use the windows compute to follow this Workshop. Please also make sure to install Git Bash in Windows Compute.** You will also need to install **Remote Desktop Connection** in your local machine from this [link](https://www.microsoft.com/en-us/p/microsoft-remote-desktop/9wzdncrfj3ps).

    c. A web browser to connect to OCI web console and Cloud Manager PIA – Firefox or Chrome recommended.

## Appendix

*Terminology*

The following terms are commonly employed in Peoplesoft cloud operations and used throughout our documentation:

**Availability Domain** – One or more data centers located within a region.

**Bucket** – A logical container used by Object Storage for storing your data and files. A bucket can contain an unlimited number of objects.

**Compartments** – Allows you to organize and control access to your cloud resources. A compartment is a collection of related resources (such as instances, virtual cloud networks, block volumes) that can be accessed only by certain groups..

**Peoplesoft Cloud Manager (PSFT)** - Oracle Peoplesoft Cloud Manager is a Peoplesoft lifecycle management application used for creating, managing, and configuring Peoplesoft environments on Oracle Cloud Infrastructure.

**PSFT Cloud Manager infrastructure** – Virtual network resources, compute resources, and policies required to run PSFT Cloud Manager on Oracle Cloud Infrastructure.

**Virtual Cloud Network (VCN)** – Networking and compute resources required to run PSFT on Oracle Cloud Infrastructure. The PSFT VCN includes the recommended networking resources (VCN, subnets routing tables, internet gateway, security lists, and security rules) to run Oracle Peoplesoft on OCI.

**Oracle Cloud Infrastructure (OCI)** – Combines the elasticity and utility of public cloud with the granular control, security, and predictability of on-premises infrastructure to deliver high-performance, high availability, and cost-effective infrastructure services.

**Region** – Oracle Cloud Infrastructure are hosted in regions, which are located in different metropolitan areas. Regions are completely independent of other regions and can be separated by vast distances – across countries or even continents. Generally, you would deploy an application in the region where it is most heavily used, since using nearby resources is faster than using distant resources.

**Tenancy** – When you sign up for Oracle Cloud Infrastructure, Oracle creates a tenancy for your company, which is a secure and isolated partition within Oracle Cloud Infrastructure where you can create, organize, and administer your cloud resources.

## Acknowledgements

**Created By/Date**   
- Rich Konopka, Peoplesoft Specialist, October 2020  
- Megha Gajbhiye, Cloud Solutions Engineer, October 2020  

**Last Updated By/Date**    
- Sara Lipowsky, Cloud Solutions Engineer, October 2020  

<!-- ## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store. -->

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
