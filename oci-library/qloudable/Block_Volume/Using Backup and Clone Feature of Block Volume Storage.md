# Using Backup and Clone Feature of Block Volume Storage.

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create VCN](#sign-in-to-oci-console-and-create-vcn)

[Create ssh keys, compute instance and Block Volume](#create-ssh-keys,-compute-instance-and-block-volume)

[Clone Block Volume and explore Volume Groups](#clone-block-volume-and-explore-volume-groups)

[Delete the resources](#delete-the-resources)



## Overview

Welcome to the Using Backup and Clone Feature of Block Volume Storage self-paced lab from Oracle!

Oracle Cloud Infrastructure Block Volume Service lets you dynamically provision and manage block storage volumes. You can create, attach, connect, and move volumes to meet your storage and application requirements. Once attached and connected to an instance, you can use a volume like a regular hard drive. Volumes can also be disconnected from one instance and attached to another instance without any loss of data.

In this lab you will create and attach Block Volume Storage to a compute instance and verify the added storage capacity.

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

1. Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

2. OCI Training : https://cloud.oracle.com/en_US/iaas/training

3. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

4. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

5. Familiarity with Compartment: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

6. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm


## Sign in to OCI Console and create VCN

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}


1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="image-alt-text">

2. From the OCI Services menu,Click **Virtual Cloud Networks** under Networking. Select the compartment assigned to you from drop down menu on left part of the screen under Networking and Click **Start VCN Wizard**

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

3. Click **VCN with Internet Connectivity** and click **Start Workflow**

4. Fill out the dialog box:

- **VCN NAME**: Provide a name
- **COMPARTMENT**: Ensure your compartment is selected
- **VCN CIDR BLOCK**: Provide a CIDR block (10.0.0.0/16)
- **PUBLIC SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.1.0/24)
- **PRIVATE SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.2.0/24)
- Click **Next**

5. Verify all the information and  Click **Create**

6. This will create a VCN with followig components.

**VCN**, **Public subnet**, **Private subnet**, **Internet gateway (IG)**, **NAT gateway (NAT)**, **Service gateway (SG)**

                       
## Create ssh keys, compute instance and Block Volume

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL006.PNG" alt="image-alt-text" >

2. Enter command 
```
ssh-keygen
```
**HINT:** You can swap between OCI window, 
git-bash sessions and any other application (Notepad, etc.) by Clicking the Switch Window icon 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL007.PNG" alt="image-alt-text" >

3. Press Enter When asked for 'Enter File in which to save the key', 'Created Directory, 'Enter passphrase', and 'Enter Passphrase again.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL008.PNG" alt="image-alt-text" >

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

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL009.PNG" alt="image-alt-text" >

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0010.PNG" alt="image-alt-text" >

7. Switch to the OCI console. From OCI services menu, Click **Instances** under **Compute** 

8. Click **Create Instance**. Fill out the dialog box:

- **Name your instance**: Enter a name 
- **Choose an operating system or image source**: For the image, we recommend using the Latest Oracle Linux available.
- **Availability Domain**: Select availability domain
- **Instance Type**: Select Virtual Machine 
- **Instance Shape**: Select VM shape 

**Under Configure Networking**
- **Virtual cloud network compartment**: Select your compartment
- **Virtual cloud network**: Choose the VCN 
- **Subnet Compartment:** Choose your compartment. 
- **Subnet:** Choose the Public Subnet under **Public Subnets** 
- **Use network security groups to control traffic** : Leave un-checked
- **Assign a public IP address**: Check this option

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0011.PNG" alt="image-alt-text">

- **Boot Volume:** Leave the default
- **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key saved earlier.

9. Click **Create**

**NOTE:** If 'Service limit' error is displayed choose a different shape such as VM.Standard.E2.2 OR VM.Standard2.2 OR choose a different AD

10. Wait for Instance to be in **Running** state. In git-bash Enter Command:
```
 cd /C/Users/PhotonUser/.ssh
```
11. Enter **ls** and verify id_rsa file exists

12. Enter command 
```bash
ssh -i id_rsa opc@<PUBLIC_IP_OF_COMPUTE>
```

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command

13. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text" >
 
14. Verify opc@<COMPUTE_INSTANCE_NAME> appears at the prompt

15. From OCI services menu Click **Block Volumes** under Block Storage, then Click **Create Block Volume**.

16. Fill out the dialog box:


- Name: Enter a name for the block volume 
- Create in Compartment: Has the correct compartment selected.
- Availability Domain: Select availability domain **(must be different from compute instance's AD)**
- SIZE: Set to 50

**Leave all other fields as Default**

17. Click **Create Block Volume**. Wait for Block Volume state to change from 'Provisioning' to 'Available'

18.  From OCI services menu Click **Instance** under Compute 

19. For the compute instance created earlier Click Action item. Click **Attach Block Volume**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Block_Volume/img/Block_Volume_001.PNG" alt="image-alt-text" >

20. Verify no block volume is available to attach. This is because we created the block volume in different Availability Domain then the compute instance.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Block_Volume/img/Block_Volume_002.PNG" alt="image-alt-text" >

21. Next we will use Manual Backup feature to create a backup of this block volume. We will then restore the backup as a regular volume in the same availability domain as the compute instance.From OCI services menu Click **Block Volumes** under **Block Storage**, Locate the block volume you created earlier, Click Action icon  and Click **Create Manual Backup**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Block_Volume/img/Block_Volume_003.PNG" alt="image-alt-text" >

22. Fill out the dialog box:


- Name: Provide a Name
- BACKUP TYPE: Full Backup

23. Click **Create Block Volume Backup**

24. Click **Block Volume Backups** and verify backup was created and is in **Available** state

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Block_Volume/img/Block_Volume_004.PNG" alt="image-alt-text" >

25. Now we will create a new Block Volume in the same Availability domain as the compute instance. Click Action icon  and then **Create Block Volume**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Block_Volume/img/Block_Volume_005.PNG" alt="image-alt-text" >

26. Fill out the dialog box:


- Name: Enter a name for the block volume 
- Create in Compartment: Has the correct compartment selected.
- Availability Domain: Select availability domain **(must be the same as compute instance's AD)**
- BLOCK VOLUME SIZE: Should be set to 50
- BACKUP POLICY: Leave as is
- ENCRYPTION: ENCRYPT USING ORACLE-MANAGED KEYS

27. From OCI services menu Click **Instance** under Compute 

28. For the compute instance created earlier Click Action item. Click **Attach Block Volume**.

29. Fill out the dialog box:


- Choose how you want to attach your block volume: PARAVIRTUALIZED
- BLOCK VOLUME COMPARTMENT: Choose your compartment
- BLOCK VOLUME: Choose the block volume created in the same AD as the compute instance
- Device Path: Choose a device path. **Note down this device path**
- ACCESS: Read/Write

30. Click **Attach**

31. Click Compute instance Name. Click **Attached Block Volume** and verify the Block volume is attached.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Block_Volume/img/Block_Volume_006.PNG" alt="image-alt-text" >

**We successfully attached a block volume that existed in a different Availability domain than the compute instance.Next we will Clone the original block volume.**

## Clone Block Volume and explore Volume Groups

1. From OCI services menu Click **Block Volumes** under Block Storage, locate the Original Block Volume create.Click Action icon  and then Create Clone.Fill out the dialog box:


- NAME: Provide a Name
- CREATE IN COMPARTMENT: Choose your compartment
- BLOCK VOLUME SIZE: Should be set to 50
- ENCRYPTION: ENCRYPT USING ORACLE-MANAGED KEYS

2. Click **Create Clone**

3. Once the clones volume is in Available State, navigate back to compute instance page and try to attach the cloned volume. Verify the Cloned volume is not available to be attached. **This is due to the same reason as for the original volume i.e the cloned volume is in a different Availability Domain then the compute instance**

**Volume Groups**

The Oracle Cloud Infrastructure Block Volume service provides you with the capability to group together multiple volumes in a volume group. A volume group can include both types of volumes, boot volumes, which are the system disks for your Compute instances, and block volumes for your data storage. You can use volume groups to create volume group backups and clones that are point-in-time and crash-consistent.

This simplifies the process to create time-consistent backups of running enterprise applications that span multiple storage volumes across multiple instances. You can then restore an entire group of volumes from a volume group backup.

4. Next we will look at how to create volume groups. In OCI Console window navigate to **Block Storage**.

5. Click **Volume Groups** and then **Create Volume Group**. Fill out the dialog box:


- NAME: Provide a Name
- CREATE IN COMPARTMENT: Choose your Compartment
- CREATE IN AVAILABILITY DOMAIN: Choose the availability domain whose volume need to be grouped

**NOTE: Only volumes that exist in this AD will appear in the list**

Under **Volumes**


- COMPARTMENT: Choose your comparment
- VOLUME: Click on the drop down and choose the volume that you want to group togehter
 
6. To choose additional volumes (Block or boot) Click **+Volume** and add additional volumes

7. Click **Create Volume Group**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Block_Volume/img/Block_Volume_007.PNG" alt="image-alt-text" >

8. New Volume group will be created

## Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute

3. Locate first compute instance, Click Action icon and then **Terminate** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text" >

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text" >

5. Navigate to **Block Storage** and then Click **Volume Groups**. Click on Volume Group name that was created and then Click **Terminate**

6. Locate any additioan volumes not part of the Volume Group (Cloned Volme) that you created.

**HINT:** If multiple storage block volumes are listed, scroll down to find the volumes you created.   

7. Click the Action icon and select **Terminate**

8. Click **OK** in the confirmation window.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/Customer_Lab_016.PNG" alt="image-alt-text" >

9. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

10. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text" >
