#  Using Reserved Public IP. 
  
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create reserved public IP](#sign-in-to-oci-console-and-create-reserved-public-ip)

[Assign reserved public IP to first compute instance](#assign-reserved-public-ip-to-first-compute-instance)

[Un assign Reserved Public IP and assign it to a new compute instance](#un-assign-reserved-public-ip-and-assign-it-to-a-new-compute-instance)

[Delete the resources](#delete-the-resources)

## Overview

A public IP address is an IPv4 address that is reachable from the internet. If a resource in your tenancy needs to be directly reachable from the internet, it must have a public IP address. Depending on the type of resource, there might be other requirements.

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

7. Click **View Virtual Cloud Network** to display your VCN details.
             
8. From OCI servies menu Click **Public IPs** under **Networking** 

9. Click **Create Reserved Public IP**.  Fill out the dialog box:

- **NAME:** Provide a name (optional)
- **COMPARTMENT:** Ensure correct compartment is selected

10. Click **Create Reserved Public IP**

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
- **Do Not Assign a public IP address**: Check this option

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0011.PNG" alt="image-alt-text">

- **Boot Volume:** Leave the default
- **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key saved earlier.


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
```bash
ssh -i id_rsa opc@<RESERVED_PUBLIC_IP_OF_COMPUTE>
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

3. Create a second compute instance following same steps as for the first compute instance. **Make sure to not assign a Public IP to this compute either**

4. Following same steps as earlier Edit the VNIC information for this compute instance and assign it the same Reserved Public IP that we created.

5. Remove the known_hosts file to ensure old entry for the host is deleted. Enter Command:

```
rm /c/Users/PhotonUser/.ssh/known_hosts
```

6. Following same steps as earlier, ssh to the second compute instance using the Reserved Public IP address.Verify you logged into the second compute instance.

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
