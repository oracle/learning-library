# Create Docker registry in OCI
  
## Table of Contents

[Overview](#overview)

[Prerequisites](#Prerequisites)

[Sign in to OCI Console and create VCN Auth token and Docker Registry](#sign-in-to-oci-console-and-create-vcn-auth-token-and-docker-registry)

[Create compute instance install Docker and push images to registry](#create-compute-instance-install-docker-and-push-images-to-registry)

[Delete the resources](#delete-the-resources)

## Overview

Oracle Cloud Infrastructure Registry is an Oracle-managed registry that enables you to simplify your development to production workflow. Oracle Cloud Infrastructure Registry makes it easy for you as a developer to store, share, and manage development artifacts like Docker images. And the highly available and scalable architecture of Oracle Cloud Infrastructure ensures you can reliably deploy your applications.

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

## Prerequisites

1. Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

2. OCI Training : https://cloud.oracle.com/en_US/iaas/training

3. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

4. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

5. Familiarity with Compartment: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

6. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm


## Sign in to OCI Console and create VCN Auth token and Docker Registry


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
             

***We will now create an Auth Token. This token will be used to login to connect to OCI Docker registry from the Docker computeinstance that will be created later one***

8. In OCI console Click the user icon (top right)  then **User settings**. Under Resrouces Click **Auth Token**, then **Generate Token**. In pop up window provide a description then Click **Generate Token**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_005.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_006.PNG" alt="image-alt-text">

9.  Click **Copy** and save the token in Notepad.**Do not close the window without saving the token as it can not be retrieved later**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_007.PNG" alt="image-alt-text">

10. From OCI Services menu, Click **Registry(OCIR)** under **Developer Services**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0033.PNG" alt="image-alt-text">
 
11. Click **Create Repository**. Provide Repository name (all Lowercase), Check **Public** for **Acess**, Click **Submit**

12.  Once created, verify there are no existing images in the repository (as shown in OCI console)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0034.PNG" alt="image-alt-text">

***We now have a Docker registry and Auth token (to validate login to the registry). Next we will create a Public/Private key pair and then compute instance to test pushing and pulling images from the registry.***

## Create compute instance install Docker and push images to registry

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

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command

13. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text">
 
14. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt. Nex install Dcoker, Enter command:

```
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0035.PNG" alt="image-alt-text">

15. Enter command:
```
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo*
```

16. Enter command:
```
sudo yum install docker-ce –y
```
(Wait for ‘Complete’message)

17. Enter command:
```
sudo systemctl enable docker
```

18. Enter command:
```
sudo systemctl start docker
```

19. Enter command: (To add user opc to Docker)
```
sudo usermod -aG docker opc
```  

20. Docker is installed and user opc enabled to use Docker. Enter Command 
```
exit
```

to logout of ssh session on compute instance and then ssh back in to the compute instance. Enter command **Docker images** and ensure no error is displayed

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0036.PNG" alt="image-alt-text">

21. We will now pull a example image from Docker registry  to the compute instance. Enter Command:

```
docker image pull alpine
``` 
Verify image pull was successful, Enter Command 
```
docker images
``` 
and verify alpine is present

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0037.PNG" alt="image-alt-text">

22. Now we will push this image to Docker registry created in OCI. First login to Registry in OCI. Enter command:

```bash
docker login <Region_Name_Code>.ocir.io
```

**NOTE:** Region name code are, fra for Frankfurt, iad for Ashburn, lhr for London, phx for Phoenix.

**HINT:** Your region is shown on top right corner of OCI console window

23. Provide the information:


- Username:  Enter it in format Tenancy Name/User name (for example: TS-SPL-55/john_doe)
- Password: Paste the Auth key saved earlier (Characters wont be visible)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0038.PNG" alt="image-alt-text">

24. Verify Login Succeeded message is displayed.

25. Next we will tag the image that we pulled from the web. Enter command:

```
docker images
``` 
and note down the image id of alpine. Enter command: (No Spaces)

```bash
docker tag <image_id>  <Region_Name_Code>.ocir.io/<TenancyName>/<docker_registry_name>:<image_name> 
```

26. Verify the tag was created, Enter command:

```
docker images
``` 
and verify version<x.y>.test is present. 

**NOTE:** In below example (version4.0.test) x is 4 and y is 0 


- <image_id> is **3fd9065eaf02** 
- <Region_Name_Code> is **iad** 
- <Tenancy_Name> is **us_training** 
- <docker_registry_name> is **docker-test-image**
- <image_name> is **version4.0.test**  

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0039.PNG" alt="image-alt-text">

27. We will now push the image to docker registry in OCI. Enter command: 

```bash
docker push <Region_Name_Code>.ocir.io/<Tenancy_Name>/<docker_registry_name>:<image_name>* (No Spaces)
```
**NOTE:** In below example:


- <Region_Name_Code> is **iad**
- <Tenancy_Name> is **us_training**
- <docker_registry_name> is **docker-test-image**
- <image_name> is **version4.0.test**  

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0040.PNG" alt="image-alt-text">

28. Switch to OCI window and navigate to your registry. Newly pushed image should be visible.

**HINT:** Refresh the browser window if image is not displayed

29. Switch to compute instance ssh window. Enter command:
```bash
docker pull <Region_Name_Code>.ocir.io/<Tenancy_Name>/<docker_registry_name>:<image_name>*  (No Spaces)    
```
30. Verify the pull command was successful

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0041.PNG" alt="image-alt-text">

**HINT:** We are pulling the same image that we just pushed.

***We now have a working Docker registry and can successfully push and pull images to/from it.***

## Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute

3. Locate first compute instance, Click Action icon and then **Terminat** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text">

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text">


5. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

6. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">

7. Navigate to your registry(**Registry(OCIR)** under **Developer Services**), Click Registry Name, Under **Actions** Click **Delete Repository**  ,Click **Delete** in confirmation window

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0042.PNG" alt="image-alt-text">

***Congratulations! You have successfully completed the lab.***
