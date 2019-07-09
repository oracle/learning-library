#  Using Reserved Public IP. 
  
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create reserved public IP](#sign-in-to-oci-console-and-create-reserved-public-ip)

[Assign reserved public IP to first compute instance](#assign-reserved-public-ip-to-first-compute-instance)

[Un assign Reserved Public IP and assign it to a new compute instance](#un-assign-reserved-public-ip-and-assign-it-to-a-new-compute-instance)

[Delete the resources](#delete-the-resources)

## Overview

Oracle Cloud Infrastructure Reserved Public IP service is an internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. The Reserved Public IP service can store an unlimited amount of unstructured data of any content type, including analytic data and rich content, like images and videos.

With Reserved Public IP, you can safely and securely store or retrieve data directly from the internet or from within the cloud platform. Reserved Public IP offers multiple management interfaces that let you easily manage storage at scale.

Reserved Public IP is a regional service and is not tied to any specific compute instance. You can access data from anywhere inside or outside the context of the Oracle Cloud Infrastructure

The purpose of this lab is to give you an overview of the Reserved Public IP Service and an example scenario to help you understand how the service works.

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


## Sign in to OCI console and create reserved Public IP

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

**Before You Begin**


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


- Create in Compartment: Has the correct compartment
- Name: Enter easy to remember name
- Create Virtual Cloud Network Plus Related Resources: Select this option.

5. Click **Create Virtual Cloud Network**

6. Click **Close**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL003.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL004.PNG" alt="image-alt-text">

7. From OCI servies menu Click **Public IPs** under **Networking** 

8. Click **Create Reserved Public IP**.  Fill out the dialog box:


- **NAME:** Provide a name (optional)
- **COMPARTMENT:** Ensure correct compartment is selected

9. Click **Create Reserved Public IP**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Using_Reserved_Public_IP/img/RESERVEDIP_HOL0020.PNG" alt="image-alt-text">

## Assign reserved public IP to first compute instance

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

8. Click **Create Instance**. Fill out the dialog box:


- Name: Enter a name 
- Availability Domain: Select availability domain
- Image Operating System: For the image, we recommend using the Latest Oracle Linux available.
- Choose Instance Type: Select Virtual Machine
- Choose Instance Shape: Select VM shape
- Configure Boot Volume: Leave the default
- Add SSH Keys: Choose 'Paste SSH Keys' and paste the Public Key saved earlier.
- Virtual Cloud Network Compartment: Choose your compartment
- Virtual Cloud Network: Select the VCN you created in the previous section. 
- Subnet Compartment: Choose your compartment. 
- Subnet: Choose the first Subnet

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Using_Reserved_Public_IP/img/RESERVEDIP_HOL0021.PNG" alt="image-alt-text">

9. Click **Show Advanced Options**. 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Using_Reserved_Public_IP/img/RESERVEDIP_HOL0022.PNG" alt="image-alt-text">

10. Click **Networking**. Un-check **Assign Public IP address** option if it is checked

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Using_Reserved_Public_IP/img/RESERVEDIP_HOL0023.PNG" alt="image-alt-text">

11. Click **Create**

12. Once the instance is in Running state, Click Instance name

13. In the instance detail page Click **Attached VNICs** and then VNIC name

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Using_Reserved_Public_IP/img/RESERVEDIP_HOL0024.PNG" alt="image-alt-text">

14. In VNIC detail page Click **IP Addresses**, then **Edit** under the Action icon

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Using_Reserved_Public_IP/img/RESERVEDIP_HOL0025.PNG" alt="image-alt-text">


15. In the dialog box under Public IP Address choose RESERVED PUBLIC IP. From the drop down list select the Reserved Public IP created earlier. Click **Update**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Using_Reserved_Public_IP/img/RESERVEDIP_HOL0026.PNG" alt="image-alt-text">

16. Note down the Public IP address.

***We have successfully assigned a Reserved Public IP address to the compute instance***

In git-bash Enter Command:
```
 cd /C/Users/PhotonUser/.ssh
```
17. Enter **ls** and verify id_rsa file exists

18. Enter command: **Make sure to use the Reserved Public IP that we assigned to the compute instane**
```
ssh -i id_rsa_user opc@<RESERVED_PUBLIC_IP_OF_COMPUTE>
```

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command

19. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text">
 
20. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt

***We successfully ssh into the compute instance using the reserved public IP. Next we will use the same Public IP and assign it to a different Compute instance***

## Un assign Reserved Public IP and assign it to a new compute instance

1. Navigate to VNIC details page in OCI console window. Click **IP Addresses**, then **Edit** under the Action icon

2. In the dialog box under Public IP Address choose **NO PUBLIC IP** (Note the Warning message indicating
Reserved Public IP will be unassigned) . Click **Update**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Using_Reserved_Public_IP/img/RESERVEDIP_HOL0027.PNG" alt="image-alt-text">

**Reserved Public IP has now been un-assigned from this compute instance. Next we will create a new compute instance and assign this same Public IP to it.**

3. Create a second compute instance following same steps as for the first compute instnae. **Make sure to not assign a Public IP to this compute either**

4. Following same steps as earlier Edit the VNIC information for this compute instance and assign it the same Reserved Public IP that we created.

5. Following same steps as earlier, ssh to the second compute instance using the Reserved Public IP address.

6. Verify you logged into the second compute instance.

**This demonstrated how to use Reserved IP address functionality in OCI to access different compute instances**

## Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute

3. Locate first compute instance, Click Action icon and then **Terminate** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text">

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text">

5. Repeat the step to delete the scond compute instance

6. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

7. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">

8. From OCI services menu Click **Networking**, then **Public IPs**,locate the Reserved Public IP you created. Click Action icon and then **Terminate**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0019.PNG" alt="image-alt-text">

***Congratulations! You have successfully completed Using Reserved Public IP address lab. ***
