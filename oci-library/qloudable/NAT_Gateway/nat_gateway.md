# NAT gateway.

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Recommended Learning Assets](#recommended-learning-assets)

[Sign in to OCI Console and create VCN](#sign-in-to-oci-console-and-create-vcn)

[Create ssh keys compute instance](#create-ssh-keys-compute-instance)

[Configure NAT gateway](#configure-nat-gateway)

[Delete the resources](#delete-the-resources)


## Overview

Many Oracle Cloud Infrastructure customers have compute instances in virtual cloud networks (VCNs) that, for privacy, security, or operational concerns, are connected to private subnets. To grant these resources access to the public internet for software updates, CRL checks, and so on, a customer’s only option has been to create a NAT instance in a public subnet and route traffic through that instance by using its private IP address as a route target from within the private subnet. Although many have successfully used this approach, it does not scale easily and provides a myriad of administrative and operational challenges.

NAT gateway,  addresses these challenges and provides Oracle Cloud Infrastructure customers with a simple and intuitive tool to address their networking security needs. NAT gateways provide the following features:


- Highly Scalable and Fully Managed: Instances on private subnets can initiate large numbers of connections to the public internet. Connections initiated from the internet are blocked.

- Secure: Traffic through NAT gateways can be disabled with the Click of a button.
Dedicated IP Addresses: Each NAT gateway is assigned a dedicated IP address that can be reliably added to security whitelists.


**Some Key points;**

**We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%**


- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

- Do NOT use compartment name and other data from screen shots.Only use  data(including compartment name) provided in the content section of the lab

- Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the OCI Console

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


**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI


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
              
## Create ssh keys compute instance

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
- **Assign a public IP address**: Check this option

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0011.PNG" alt="image-alt-text">

- **Boot Volume:** Leave the default
- **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key saved earlier.

9. Click **Create**

**NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0011.PNG" alt="image-alt-text">

10. Wait for Instance to be in **Running** state. In git-bash Enter Command:
```
 cd /C/Users/PhotonUser/.ssh
```
11. Enter **ls** and verify id_rsa file exists

12. Enter command 
```bash
ssh -i id_rsa opc@<PUBLIC_IP_OF_COMPUTE> 
```

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command

13. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text">
 
14. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt

## Configure NAT gateway

**We will now create a route table in the VCN.**

1. Switch to OCI console. From OCI services menu Click **Virtual Cloud Networks** under Networking. Locate your VCN and Click the VCN name to display VCN details. 

2. Click **NAT Gateways** 

3. Click **Route Tables**, then **Create Route Table**. Fill out the dialog box:

- Create in Compartment: This field defaults to your current compartment. Make sure correct Compartment is selected.

- Name: Enter a name

**Click +Additional Route Rules**


- Target Type: Select **NAT Gateway** 
- Destination CIDR Block: Enter 0.0.0.0/0 
- Compartment:  Make sure the correct Compartment is selected: 
- Target NAT Gateway: Select the NATGateway for your VCN. 

4. Click **Create Route Table**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/NAT_Gateway/img/NAT_002.PNG" alt="image-alt-text">

5. Click your VCN name to display the VCN details.Click **Create Subnet**. Fill out the dialog box:


- Name: Enter a name 
- Subnet Type: Regional
- CIDR Block: Provide a CIDR (e.g 10.0.5.0/24).
- Route Table: Choose the Route table created earlier

**NOTE:** Do not choose the 'Default route table'. This is being done so all routing for compute instances in this subnet are via the NAT gateway 


- Subnet access:Private Subnet.
- DHCP Options: Select the default.
- Security Lists: Select the Security List you created earlier.

6. Leave all other options as default, Click **Create Subnet**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_004.PNG" alt="image-alt-text">

7. Switch to Git bash session with ssh to compute instance Generate ssh key pair, Enter command:
```
ssh-keygen 
```
8. Press Enter When asked for ‘Enter File in which to save the key’, ‘Created Directory, ‘Enter passphrase’, and ‘Enter Passphrase  again.

9. Enter command 
```
cd ~/.ssh
```
and then 
```
ls
``` 
You should have the Public and Private keys:
/home/opc/.ssh/id_rsa (Private Key)
/home/opc/.ssh/id_rsa.pub (Public Key)

10. Enter command 
```
cat ~/.ssh/id_rsa.pub
``` 

copy and paste the public key content to Notepad. We will use this public key to launch a compute instance in private subnet of the VCN.

11. Switch to OCI console window and launch a second compute instance as done previously. **Ensure the subnet chosen is the private subnet that we created previously**.

12. Once the Instance is running, Note down private IP address of the instance from instance detail page (by Clicking Instance name) 

13. Switch to git-bash window with ssh session to Public compute instance (first compute instance created earlier). Enter command:
```
 cd ~/.ssh
``` 
then
```bash
ssh –i id_rsa opc@<Private_IP_OF_COMPUTE_INSTANCE>
```

**NOTE:** User name is ‘opc’

**HINT:** If ‘Permission denied error’ is seen, ensure you are using ‘-i’ in the ssh command

**NOTE:** Use the private ip of second compute instance noted earlier

14. Enter ‘Yes’ when prompted for security message

15. In the private compute instance Enter command:
```
ping 8.8.8.8 
```
and verify there is internet connectivity

**The compute instance in private subnet has internet access. This is possible since traffic is being routed through the NAT gateway that we created and attached to the VCN. Next we will use the traffic toggle function on NAT gateway to block/allow traffic with a single Click.**

16. Switch to OCI console window. In your VCN's detail page, Click **NAT Gateways**

17. Hover over the Action icon  and choose Block Traffic. 

18. Switch back to ssh session to the private compute instance and Enter command ping 8.8.8.8 (if not already running). Verify there is no repsonse

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/NAT_Gateway/img/NAT_003.PNG" alt="image-alt-text">

19. Switch back to OCI console window and using above step, this time choose Allow Traffic. Switch back to ssh session and verify ping response is received.
       
## Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under **Compute**

3. Locate compute instance, Click Action icon and then **Terminate** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text">

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text">

5. Repeat the steps to delete the second compute instance.

6. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

7. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">



***Congratulations! You have successfully completed the lab. ***

