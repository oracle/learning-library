# File System Storage Service

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create VCN](#sign-in-to-oci-console-and-create-vcn)

[Create File System Storage](#create-file-system-storage)

[Creat ssh keys and compute instance](#create-ssh-keys-and-compute-instance)

[Mount the File Storage System to Compute Instance](#mount-the-file-storage-system-to-compute-instance)

[Delete the resources](#delete-the-resources)

## Overview

Welcome to the Cloud Storage (File System) self-paced lab from Oracle!

Oracle Cloud Infrastructure File Storage Service provides a durable, scalable, distributed, enterprise-grade network file system. You can connect to a File Storage Service file system from any bare metal, virtual machine, or container instance in your Virtual Cloud Network (VCN). You can also access a file system from outside the VCN using Oracle Cloud Infrastructure FastConnect and Internet Protocol security (IPSec) virtual private network (VPN).

In this lab you will create and mount File Storage System to a compute instance and verify availability of the File Storage system.

**Some Key points;**

**We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%**


- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

- Do NOT use compartment name and other data from screen shots.Only use  data(including compartment name) provided in the content section of the lab

- Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the OCI Console

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

**Cloud Tenant Name**
**User Name**
**Password**
**Compartment Name (Provided Later)**

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

## Pre-Requisites

1. OCI Training : https://cloud.oracle.com/en_US/iaas/training

2. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

3. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

4. Familiarity with Compartment: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

5. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

## Sign in to OCI Console and create VCN


* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}


1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="image-alt-text">

2. From the OCI Services menu,Click **Virtual Cloud Network** under Networking and Click **Create Virtual Cloud Network**

3. Select the compartment assigned to you from drop down menu on left part of the screen

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL001.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL002.PNG" alt="image-alt-text">

4. Fill out the dialog box:


- **Name:** Enter easy to remember name
- **Create in Compartment:** Has the correct compartment
- **Create Virtual Cloud Network Plus Related Resources:** Select this option.
- Click **Create Virtual Cloud Network**
- Click **Close**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL003.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL004.PNG" alt="image-alt-text">
              
5. In your VCN details page, Click **Security List** and then **Default Security list for<YOUR_VCN_NAME>**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/Customer_Lab_001.PNG" alt="image-alt-text">

**NOTE:** Note down the Subnet and Availability domain.We will create File Storage system and compute instance in the same subnet and Availability domain later on​​

6. In Security list details page, Click **Add Ingress Rule**.Click **+Additional Ingress Rule** and add below two rules:

**Rule # 1 for access of NFS and NLM traffic with Destination Port Range of 2048-2050. (Type the values).**


- **Make sure STATELESS Flag in un-checked**
- **SOURCE TYPE:** CIDR
- **SOURCE CIDR:** 10.0.0.0/16
- **IP PROTOCOL:** TCP
- **SOURCE PORT RANGE:** ALL
- **DESTINATION PORT RANGE:** 2048-2050

**Rule # 2 for access of NFS and NLM traffic with Destination Port Range of 2048-2050. (Type the values).**


- **Make sure STATELESS Flag in un-checked**
- **SOURCE TYPE:** CIDR
- **SOURCE CIDR:** 10.0.0.0/16
- **IP PROTOCOL:** TCP
- **SOURCE PORT RANGE:** 2048-2050
- **DESTINATION PORT RANGE:** All

7. Click **+Additional Ingress Rule** to add third ingress rule allowing traffic to a Destination Port Range of 111 for the NFS rpcbind utility.


- Source CIDR: 10.0.0.0/16
- IP Protocol: TCP
- Source Port Range: All
- Destination Port Range: 111

8. Click **+Additional Ingress** Rule  to add fourth ingress rule allowing traffic to a Source Port Range of 111 for the NFS rpcbind utility.


- Source CIDR: 10.0.0.0/16
- IP Protocol: TCP
- Source Port Range: 111
- Destination Port Range: All

9. Click **Add Ingress Rule**

**NOTE:** Note down the Subnet and Availability domain. We will create File Storage system and compute instance in the same subnet and Availability domain later on.

## Create File System Storage

In this section we will create File System Storage.

1. From OCI Services menu, Click **File System** under **File Storage**

2. Click **Creat File System**

3. Click **Edit Details**, under **Mount Target Information** and then **Show advanced options**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_001.png" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_002.png" alt="image-alt-text">

4. In Create File System dialog, under File System Information, enter the following:


- Create in Compartment: Choose your compartment
- Name: Provide a name
- Availability Domain: Choose any AD.

**Under Mount Target Information**


- Select **Create Mount Target**
- Name: Provide a name
- Virtual Cloud Network: Select your VCN.
- Subnet: Select a subnet for the mount target.
- IP Address: Leave blank.
- Hostname: Leave blank.
- Path Name: Enter /
- Maximum Free space: choose Recommended Size

5. Click **Create File System**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_003.png" alt="image-alt-text">
              
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_004.png" alt="image-alt-text">

6. Once created, Click **File System Name** and under Mount Targets Note down the Private IP address

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_005.png" alt="image-alt-text">

**We now have a File Storage system created. Next we will create a SSH key pair that will be used to login to a compute instance and mount the file system.**

## Create ssh keys and compute instance

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL006.PNG" alt="image-alt-text">

2. Enter command 
```
ssh-keygen
```
**HINT:** You can swap between OCI window, 
git-bash sessions and any other application (Notepad, etc.) by Clicking the Switch Window icon 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL007.PNG" alt="image-alt-text">

3. Press Enter When asked for 'Enter File in which to save the key', 'Created Directory, 'Enter passphrase', and 'Enter Passphrase again.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL008.PNG" alt="image-alt-text">

4. You should now have the Public and Private keys:

/C/Users/ PhotonUser/.ssh/id_rsa (Private Key)

/C/Users/PhotonUser/.ssh/id_rsa.pub (Public Key)

**NOTE:** id_rsa.pub will be used to create 
Compute instance and id_rsa to connect via SSH into compute instance.

**HINT:** Enter command 
```
cd /C/Users/PhotonUser/.ssh (No Spaces) 
```
and then 
```
ls 
```
to verify the two files exist. 

5. In git-bash Enter command  
```
cat /C/Users/PhotonUser/.ssh/id_rsa.pub
```
 , highlight the key and copy 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL009.PNG" alt="image-alt-text">

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0010.PNG" alt="image-alt-text">

7. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute** 

8. Click Create Instance. Fill out the dialog box:


- **Name:** Enter a name 
- **Availability Domain:** Select availability domain
- **Image Operating System:** For the image, we recommend using the Latest Oracle Linux available.
- **Choose Instance Type:** Select Virtual Machine
- **Choose Instance Shape:** Select VM shape
- **Configure Boot Volume:** Leave the default
- **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key saved earlier.
- **Virtual Cloud Network Compartment:** Choose your compartment
- **Virtual Cloud Network:** Select the VCN you created in the previous section. 
- **Subnet Compartment:** Choose your compartment. 
- **Subnet:** Choose the first Subnet

9. Click **Create**

**NOTE:** If 'Service limit' error is displayed choose a different shape such as VM.Standard.E2.2 OR VM.Standard2.2 OR choose a different AD

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0011.PNG" alt="image-alt-text">

10. Wait for Instance to be in **Running** state. In git-bash Enter Command:
```
 cd /C/Users/PhotonUser/.ssh
```
11. Enter **ls** and verify id_rsa file exists

12. Enter command 
```
ssh -i id_rsa_user opc@<PUBLIC_IP_OF_COMPUTE>
```

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command

13. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text">
 
14. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt

## Mount the File Storage System to Compute Instance

Users of Ubuntu and Linux operating systems (We launched a Oracle Linux instance) can use the command line to connect to a file system and write files. Mount targets serve as file system network access points. After your mount target is assigned an IP address, you can use it to mount the file system. You need to install an NFS client and create a mount point. When you mount the file system, the mount point effectively represents the root directory of the File Storage file system, allowing you to write files to the file system from the instance.

1. In ssh session to Compute instance Enter command:
``` 
sudo yum install nfs-utils 
```
to install nfs-utils. 

**NOTE:** Type ‘y’ if prompted for ‘Is this OK’

2. Enter command:
```
sudo mkdir -p /mnt/nfs-data 
```
to create a mount point.

3. Mount the file system, Enter command: 
```
sudo mount 10.x.x.x:/ /mnt/nfs-data 
```
**NOTE:** The 10.x.x.x should be replaced with the Private IP of File Storage system noted earlier (Example: sudo mount 10.0.0.3:/ /mnt/nfs-data).

**NOTE:** Mount commands can also be see by Clicking Action icon  in File Storage detail page though 'localpath' in sudo mkdir and sudo mount MUST be replaced by the directory created (nfs-data).

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_006.png" alt="image-alt-text">

 4. Enter command:
```
df -h OR mount | grep /mnt/nfs-data
```
and verify the mounted File System Storage.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_007.png" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_008.png" alt="image-alt-text">

5. If you want to ping the mount point then modify the security list of the VCN for Ingress ICMP rule:


- Source CIDR: 0.0.0.0/0
- IP Protocol: ICMP
- Source port range: All
- Destination port range: All

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_009.png" alt="image-alt-text">

6. **Optional Step**. Second compute instance can be created and same file system mounted on it following earlier steps
             
**You have now mounted Enterprise grade File System storage created in OCI to your compute instance. You can place files in this file system and all other VM instances that have mounted the same file system will have access to it.**

## Delete the resources

In this section we will delete all the resources we created in this lab.

**Delete File System Storage**
1. From OCI Services menu, Click **File Systems**, then File System name that was created.

2. Under Mount Target, Click the action icon and select **Detach**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_010.png" alt="image-alt-text">

3. Verify there is no data under ‘Mount Targets’, then Click Delete, Click **OK** in Confirmation window.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_011.png" alt="image-alt-text">

4. Click **File Systems**

5. Click **Manage Mount Targets**, Select the Mount Target and Click **Delete**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_012.png" alt="image-alt-text">

**Delete File System Storage**
In this section we will delete all the resources we created in this lab.

1. From OCI Services menu, Navigate to File System and Click File System name that was created.

2. Under Mount Target, Click the action icon and select **Detach**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_013.png" alt="image-alt-text">

3. Verify there is no data under ‘Mount Targets’, then Click **Delete**, Click **OK** in Confirmation window.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_014.png" alt="image-alt-text">

4. Click **File Systems**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_015.png" alt="image-alt-text">

5. Click **Manage Mount Targets**, Select the Mount Target and Click **Delete**
 
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/File_Storage_Service/img/FSS_016.png" alt="image-alt-text">

**Delete Compute instance**

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under Compute

3. Locate compute instance, Click Action icon and then **Terminat** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text">


4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text">

**Delete VCN**

1. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

2. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">

3. From OCI services menu Click **Networking**, then **Public IPs**,locate the Reserved Public IP you created. Click Action icon and then **Terminate**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0019.PNG" alt="image-alt-text">


***Congratulations! You have successfully completed the lab. ***

