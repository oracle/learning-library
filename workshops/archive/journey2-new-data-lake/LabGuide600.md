![](images/600/600.JPG)  

Updated: Aug 29, 2017

## WORK IN PROGRESS

For now follow pages 4 to 24 of this document: http://www.oracle.com/partners/en/most-popular-resources/journey2-module2-3702610.pdf

## Introduction

In this lab, you learn how to provision a **Oracle Data base cloud service ** Instance and access it  

The Oracle database cloud service that supports any size workload from dev/test to large scale production deployment. Multi-layered, in depth security with encryption by default. A highly available and scalable service delivering speed, simplicity and flexibility for faster time to value and savings. In this lab, we will walk you through the steps to quickly configure and create a Database cloud service instance.  

Please direct comments to: David Bayard (david.bayard@oracle.com)

## Objectives

- Learn how to provision a DBCS instance
- Learn how to access DBCS

## Required Artifacts

- Access to an Oracle Public Cloud identity domain (by following Lab100 or Lab100GSE)
- A provisioned Storage Cloud instance (included the Replication Policy setup, as described in Lab100 or Lab100GSE)

# Provision a new DBCS Instance

## Provision Database cloud service

### **STEP 1**: Navigate/login to the Oracle Cloud My Services Dashboard  

- ![](images/300/snap0011988.jpg) 

### **STEP 2**: Click the Create Instance link (in the Create Instance box under the Welcome layer)

### **STEP 3**: Click All Services, then click Create next to Database cloud service

- ![](images/600/DBCS-createinstance.jpg)  

### **STEP 4**: Click Create Service on the DBCS services page

- ![](images/600/DBCS-createservice.gif)  

### **STEP 5**: Fill in the following parameters and click next

- Service Name: Name of the service
- Description: Generic Description. 
- Notification email:  Email address for DBCS instance creation notification
- Service type:
- Metering Frequncy: Monthly/Hourly
- Software Release: Software Release of DBCS
- Software Edition: Standard/high performance/Exterme edtion
- Database Type: type of database single instance or clustered
Backup and recovery: None

- ![](images/600/DBCS-createservice.jpg)
 

### **STEP 6**: Enter Database connection details 

Database Name: Database container name
PDB Name: Pluggable database
Adminstaration Password: Password for System and Sys users
usable database storage: Actual database storage
Compute shape:  Choose the compute shape based your compute needs
- ![](images/600/DBCS-connection.jpg)  


### **STEP 8**: In the Credentials section, define your SSH public key 

- SSH Public Key: Define a value for a VM Public Key, use a file with a VM Public Key or create a new key. The easiest choice if new to this environment may be to create a new key. Choose to Create a New Key and hit the Enter button.   Once you hit Enter, a File Folder Window will pop up to allow you to control where on your local computer you wish to store your SSH Key file (ex: sshkeybundle.zip).  Make sure and write down the location of this SSH key file.   The SSH Public Key field will then get filled in automatically.

- ![](images/600/DBCS-keyconfig.jpg)  

### **STEP 9**: (optional)If you choose Backup to storage cloud in step 6, Enter following details In the Cloud Storage Credentials section, provide storage cloud URL, username/password .

- ![](images/600/DBCS-Storagecloud.jpg)  

### **STEP 9**: Click Next.

### **STEP 10**: Click Create.

- ![](images/600/confirm.jpg)  

### **STEP 11**: Wait for the DBCS instance to be provisioned.

- While being provisioned, the Status will say "Creating service".  You can click on the status to get more information.
- As of 17.2.5, it can take about 20-40 minutes.

- ![](images/600/DBCS-creatingservice.jpg)  

### **STEP 12**: When the DBCS instance is provisioned, click on the name of the instance to go to the Service Overview page.

- ![](images/600/DBCS-postcreat.gif)  

### **STEP 13**: Review the details on the Service Overview Page
While your instance is being created the status will be “Creating service”.   Once the new Cloud Service instance changes its status to Ready, you can then click on the hyperlink with your Service name and you can look at the details of your new Service.  Sections include:
- Overview – displays the number of nodes
- Administration – displays if there are any patches available.


### **STEP 14**: Accessing DBCS 

#### Access DBCS through SSH (Putty) 

SSH connection to DBCS is using private key created during the provisioning process.  
  
         - ![](images/600/DBCS-ssh_connect.gif)

#### Accessing DBCS through SQL developer 
  Port 1521 is blocked is on DBCS.  So we can either open 1521 port or create a ssh port forwarding to access SQL developer
 Option1: 
   This option is preferred option to use SQL developer with DBCS. create SSH port tunnel between SQL developer and DBCS

    - ![](images/600/SQL_developer_portfwd.gif)
   For additonal information 
   https://blogs.oracle.com/dbaas/connecting-to-a-database-cloud-service-with-sql-developer-and-ssh
 Option2: 
   
   Open Port 1521. 
      - ![](images/600/DBCS-SQLDeveloper-access.gif)
  
/// Populate Data to do

  From End user laptop - use SQL developer import data option 
  From Object store - CLI 
                    - External table - pre-processor script to stream data from object store.
  From DBCS (Block store) - SQL Loader 

### More on creation of DBCS instance: http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/dbaas/obe_dbaas_creating_an_instance/obe_dbaas_creating_an_instance.html#overview


# What you Learned

- Learned how to create DBCS instance
- Learned how to work with the DBCS 

# Next Steps

- Experiment with your own data.  Load it into the DBCS and run querries.
- Try in-memory and multitenant labs.(Coming soon)