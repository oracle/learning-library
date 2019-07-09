# OCI Fundamentals (Deploy HA application using Load Balancer)

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create VCN](#sign-in-to-oci-console-and-create-vcn)

[Create Public Private SSH Key Pair, two compute instances and install web server](#create-public-private-ssh-key-pair,-two-compute-instances-and-install-web-server)

[Create Security List Route table and additional subnet](#create-security-list-route-table-and-additional-subnet)

[Create Load Balancer and update Security List](#create-load-balancer-and-update-security-list)

[Verify High Availability of HTTP Servers](#verify-high-availability-of-http-servers)

[Delete the resources](#delete-the-resources)

## Overview

Deploying High Availability Applications Using Load Balancer - Intro
Welcome to the Deploying High Availability Applications Using Load Balancer self-paced lab from Oracle!

In this lab you will deploy http servers on two compute instances in Oracle Cloud Infrastructure which will be configured in High Availability mode by using a Load Balancer. The Load Balancing Service provides automated traffic distribution from one entry point to multiple servers within your Virtual Cloud Network (VCN). The service offers a Public load balancer with a public IP address, provisioned bandwidth, and high availability. The Load Balancing Service provisions the public IP address across two subnets within a VCN to ensure accessibility even during an Availability Domain outage.

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
              
              
## Create Public Private SSH Key Pair, two compute instances and install web server

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL006.PNG" alt="image-alt-text">

2. Enter command 
```
ssh-keygen
```
**HINT:** You can swap between OCI window, git-bash sessions and any other application (Notepad, etc.) by Clicking the Switch Window icon 

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

10. Repeat Steps to launch a second Compute instance and note down its public IP address.

11. Wait for Instances to be in **Running** state. In git-bash Enter Command:
```
 cd /C/Users/PhotonUser/.ssh
```
12. Enter **ls** and verify id_rsa file exists

13.  ssh to **first** compute instance. Enter command:
            
```
ssh -i id_rsa_user opc@<PUBLIC_IP_OF_COMPUTE>
```
**NOTE:** User name is ‘opc’.

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command

14. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text">
 
15. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt

16. Launch a second git-bash window using above steps and connect via SSH into the second Compute instance (using the same steps as above. 

**HINT:** You can swap between the OCI window, git-bash sessions and any other application (Notepad, etc.) by Clicking the Switch Window icon 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_001.PNG" alt="image-alt-text">

**HINT:** Ensure to use the IP address of the second Compute instance in the SSH command.

17. Bring up  SSH session for the first Compute instance and install a Web server, Enter Commands: 
```
sudo yum -y install httpd (Install Apache HTTP Server)
```
```
sudo firewall-cmd --permanent  --add-port=80/tcp 
```
(Open port 80 on the firewall to allow http and https traffic).

**NOTE:** --add-port flag has no spaces.

```
sudo firewall-cmd --reload 
```
(Reload the firewall to activate the rules).

```
sudo systemctl start httpd 
```
(Start the web server).

```
sudo su 
```
(Change user privilege)

```
echo 'WebServer1' >>/var/www/html/index.html 
```
(create index.html file. The content of the file will be displayed when the web server is accessed.)

18. Bring up the SSH session for the second Compute instance and repeat commands:

```
sudo yum -y install httpd (Install Apache HTTP Server)
```
```
sudo firewall-cmd --permanent  --add-port=80/tcp 
```
(Open port 80 on the firewall to allow http and https traffic).

**NOTE:** --add-port flag has no spaces.

```
sudo firewall-cmd --reload 
```
(Reload the firewall to activate the rules).

```
sudo systemctl start httpd 
```
(Start the web server).

```
sudo su 
```
(Change user privilege)

```
echo 'WebServer2' >>/var/www/html/index.html 
```
(create index.html file. The content of the file will be displayed when the web server is accessed.)

19. Switch back to OCI Console window.

We now have two Compute instances with Web servers installed and a basis index.html file. Before we create the load balancer we will need to create a new security list, route table and subnet that theload balancer will use.

Load balancers should always reside in different subnets than your application instances. This allows you to keep your application instances secured in private subnets, while allowing public Internet traffic to the load balancers in the public subnets.

## Create Security List Route table and additional subnet

In this section we will create a new security list. This security list will be used by the load balancer (that will be created later on). This will ensure all traffic to the two web servers is routed properly.

1. From OCI Services menu, Click **Virtual Cloud Network** under **Networking**. This displays the list of VCNs in current compartment.

**HINT:** If there are multiple Networks, scroll down to locate the one you just created. 

2. Click your VCN name, then **Security Lists** and then **Create Security List** (You will be creating a new security list).


- CREATE IN COMPARTMENT: Select the compartment assigned to you (if not already selected).
- SECURITY LIST Name: Specify a name (for example, LB Security List).
- Click **Create Security List** 

3. Verify the New Security List got created.

**We now have a Security List that will be used by the load balancer. Next we will create a Route table that will be used by two new subnets (that will be used by the load balancer, once created).**

4. Click your Virtual Cloud Network name 

5. Click **Route Tables** (You will be creating a new route table), then **Create Route Table**. Fill out the dialog box:


- Name: Enter a name (for example, LB Route Table).
- Create in Compartment: This field defaults to your current compartment. Make sure correct Compartment is selected.

**Click +Additional Route Rules**


- Target Type: Select **Internet Gateway** 
- Destination CIDR Block: 0.0.0.0/0 
- Compartment: Make sure the correct Compartment is selected
- Target Internet Gateway: Select the Internet Gateway for your VCN. 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_003.PNG" alt="image-alt-text">

6. Click **Create Route Table**.

7. Ensure the new route table appears in the list (Under Create Route Table).

**We now have a route table that allows all traffic. Next we will attach this route table to two new subnets that we will create (These 2 subnets will be used by the Load Balancer).**

8. Create First subnet:
**First Subnet:** (Your Virtual Cloud Network should be visible in OCI Console window.) 

9. Click **Subnets**.

10. Click **Create Subnet**. Fill out the dialog box:


- Name: Enter a name (for example, LB-Subnet-1).
- Subnet Type: Regional

 **(When using a regional subnet, OCI selects two AD's. If you would like to control which two AD's are used, you would want to create individual AD-speicfic subnets)**


- CIDR Block: Enter 10.0.4.0/24 
- Route Table: Select the Route Table you created earlier.
- Subnet access: select Public Subnet.
- DHCP Options: Select the default.
- Security Lists: Select the Security List you created earlier.

11. Leave all other options as default, Click **Create Subnet**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_004.PNG" alt="image-alt-text">


## Create Load Balancer and update Security List

**When you create a load balancer, you choose its shape (size) and you specify subnet (created earlier) from different Availability Domains. This ensures that the load balancer is highly available and is only active in one subnet at a time.**

1. From OCI Services menu, Click **Load Balancers** under **Networking**

2. Click **Create Load Balancer**. Fill out the dialog box;

**Under Add Details**


- LOAD BALANCER NAME: Enter a name for your load balancer.
- CHOOSE VISIBILITY TYPE: Public
- CHOOSE THE MAXIMUM TOTAL BANDWIDTH: Select 100Mbps. (This specifies the bandwidth of the load balancer.)

**NOTE:** Shape cannot be changed later.


- VIRTUAL CLOUD NETWORK: Choose your Virtual Cloud Network
- SUBNET: Choose the Regional Subnet we created. 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_006.PNG" alt="image-alt-text">

**Under Choose Backends:**


- SPECIFY A LOAD BALANCING POLICY: Weighted Round Robin
- Click **Add Backend** and choose the two backend compute instance created earlier

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_007.PNG" alt="image-alt-text">

***Under SPECIFY HEALTH CHECK POLICY***


- PROTOCOL: HTTP
- Port: Enter 80 
- URL PATH (URI): /

***Leave other options as default***

**Under Configure Listener**


- SPECIFY THE TYPE OF TRAFFIC YOUR LISTENER HANDLES: HTTP
- SPECIFY THE PORT YOUR LISTENER MONITORS FOR INGRESS TRAFFIC: 80

***Leave other options as default***


3. Click **Create Load Balancer** 

4. Wait for the load balancer to become active and then note down it’s Public IP address.

**We now have a load balancer that will manage the 2 subnets we had created earlier.**

5. From OCI Services menu, Click **Virtual Cloud Network** under Networking. Locate the VCN you created.

6. Click  VCN name to display VCN detail page.

7. Click **Security Lists**, and locate the Load Balancer Security List created earlier.

8. Click Load Balancer Security List created earlier, Click **Add Ingress Rule**.
Click **+Additional Ingress Rule** and enter the following ingress rule; Ensure to leave STATELESS flag un-checked



- Source Type: CIDR 
- Source CIDR: Enter 0.0.0.0/0.
- IP Protocol: Select TCP.
- Source Port Range: All.
- Destination Port Range: Enter 80 (the listener port).

9. Click **Add Ingress Rule**. 

10. Click **Egress Rule** under Resources. Click **Add Egress Rule**,  Click **+Additional Egress Rule** and enter the following Egress rule; Ensure to leave STATELESS flag un-checked


- Destination Type: CIDR
- Destination CIDR: 0.0.0.0/0
- IP Protocol: Select TCP.
- Destination Port Range: All.

11. Click **Add Egress Rule**.

12. Click **Security Lists**, and locate the Default Security List of the VCN Click **Add Egress Rule**.  Click **+Additional Egress Rule** and Add below 2 Rules for Egress; Ensure to leave STATELESS flag un-checked.:

**First Rule**


- Destination Type: CIDR
- Destination CIDR: 10.0.4.0/24
- IP Protocol: Select TCP.
- Source Port Range: All
- Destination Port Range: 80

13. Click **+Additional Egress Rule** and enter the following Egress rule; Ensure to leave STATELESS flag un-checked

**Second Rule**


- Destination Type: CIDR
- Destination CIDR: 10.0.5.0/24
- IP Protocol: Select TCP
- Destination Port Range: 80

14. Click **Add Egress Rule**.

We now have the set-up configured with 2 Compute instances running http server with a index.html file, Load Balancer with all relevant policies and components.

We will now test the Load Balancer functionality (load balance using round robin). In case one of the http server in High Availability configuration is un-available, Load Balancer will automatically route the traffic to the available http server.

**Note:** Be sure to take note of the "Health" field in the Networking > Load Balancers dashboard. If the health is "Critical," the load balancer may not work as intended, and the best course of action may be to create a new one. This is likely the result of something being mis-configured, and it should only happen rarely.

## Verify High Availability of HTTP Servers

In this section we will access the two Web servers configured earlier using Load Balancer’s Public IP address and demonstrate Load Balancer’s ability to route traffic on round robin basis(Per the Policy Configured). In case one of the web server becomes un-available the web content will be available via the second server (High Availability)

1. Open a web browser and enter load balancer's public IP address. 

2. Verify the text in index.html file on the 2 servers (WebServer1, WebServer2)  displayed.

3. Refresh the browser multiple times and Observer Load Balancer Balancing traffic between the 2 web servers.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_009.PNG" alt="image-alt-text">
             
**NOTE:** In case one of the server goes down the Application will be accessible via Load Balancer’s Public IP address.

**This Lab is not intended to test Failover and Recovery of Backend Servers. User can test that functionality at their own discretion. Any trouble shooting in case any issue is encountered is out of scope of this lab**

##  Delete the resources

Delete Load Balancer and associated components:

1. From OCI Services menu, Click **Load Balancers**, under Networking. Click your Load Balancer Name

2. Click **Delete**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_010.PNG" alt="image-alt-text">

3. Step 3. Click **OK** in the Confirm Window. Wait for Load Balancer to fully delete.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Fundamentals_Lab/img/OCI_Fundamentals_011.PNG" alt="image-alt-text">

4. From OCI services menu Click **Instances** under Compute

5. Locate first compute instance, Click Action icon and then **Terminat** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text">

6. Make sure **Permanently delete the attached Boot Volume** is checked, Click **Terminate Instance**. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text">

7. Repeat the step to delete the second compute intance.

8. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

9. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">

10. From OCI services menu Click **Networking**, then **Public IPs**,locate the Reserved Public IP you created. Click Action icon and then **Terminate**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0019.PNG" alt="image-alt-text">


***Congratulations! You have successfully completed the lab. ***

