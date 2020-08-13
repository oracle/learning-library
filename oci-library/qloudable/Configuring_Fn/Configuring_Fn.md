# Configuring and using Functions in OCI
## Table of Contents

[Overview](#overview)

[Prerequisites](#Prerequisites)

[Sign in to OCI Console and create a VCN](#sign-in-to-oci-console-and-create-a-vcn)

[Create ssh keys and compute instance](#create-ssh-keys-and-compute-instance)

[Configure and invoke Function](#configure-and-invoke-function)

[Delete the resources](#delete-the-resources)

## Overview

Oracle Functions is a fully managed, highly scalable, on-demand, Functions-as-a-Service platform, built on enterprise-grade Oracle Cloud Infrastructure and powered by the Fn Project open source engine. Use Oracle Functions (sometimes abbreviated to just Functions) when you want to focus on writing code to meet business needs. You don't have to worry about the underlying infrastructure because Oracle Functions will ensure your app is highly-available, scalable, secure, and monitored. With Oracle Functions, you can deploy your code, call it directly or trigger it in response to events, and get billed only for the resources consumed during the execution.

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

1. OCI Training : https://cloud.oracle.com/en_US/iaas/training

2. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

3. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

4. Familiarity with Compartments: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

5. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm

## Sign in to OCI Console and create a VCN

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

Switch to the OCI console. From OCI services menu, Click **Instances** under **Compute** 

7. Click **Create Instance**. Fill out the dialog box:

- **Name your instance**: Enter a name 
- **Choose an operating system or image source**: Click **Change Image Source**. In the new window, Click **Oracle Images** Choose **Oracle Cloud Developer Image**. Scroll down, Accept the Agreement and Click **Select Image**
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

8. Click **Create**


**NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0011.PNG" alt="image-alt-text">

9. Wait for Instance to be in **Running** state. In git-bash Enter Command:
```
 cd /C/Users/PhotonUser/.ssh
```
10. Enter **ls** and verify id_rsa file exists

11. Enter command 
```bash
ssh -i id_rsa_user opc@<PUBLIC_IP_OF_COMPUTE>
```

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command

12. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text">
 
13. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt

## Configure and invoke Function

1. Check oci CLI installed version, Enter command:
```
oci -v
```
**NOTE:** Version should be minimum 2.5.X (3/23/2019)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_CLI/img/100_CLI_001.png" alt="image-alt-text">

2. Next we will configure OCI CLI. Enter command:
```
oci setup config
```

3. Accept the default location. For user OCI switch to OCI Console window. Click Human Icon and then your user name. In the user details page Click **copy** to copy the OCID. **Also note down your region name as shown in OCI Console window**. Paste the OCID in ssh session.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_004.PNG" alt="image-alt-text">

4. Repeat the step to find tenancy OCID (Human icon followed by Clicking Tenancy Name). Paste the Tenancy OCID in ssh session to compute instance followed by providing your region name (us-ashburn-1, us-phoneix-1 etc)

5. When asked for **Do you want to generate a new RSA key pair?** answer Y. For the rest of the question accept default by pressing Enter

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_005.PNG" alt="image-alt-text">

6. **oci setup config** also generated an API key. We will need to upload this API key into our OCI account for authentication of API calls. Switch to ssh session to compute instance, to display the conent of API key Enter command :

```
cat ~/.oci/oci_api_key_public.pem
```

7. Hightligh and copy the content from ssh session. Switch to OCI Console, Click Human icon followed by your user name. In user details page Click **Add Public Key**. In the dialg box paste the public key content and Click **Add**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_006.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_007.PNG" alt="image-alt-text">

**This will generate a finger print**

8. Next we need to generate an Auth token its an Oracle-generated token that you can use to authenticate with third-party APIs and Autonomous Database instance. 
In OCI console Click the user icon (top right)  then **User settings**. Under Resrouces Click **Auth Token**, then **Generate Token**. In pop up window provide a description then Click **Generate Token**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_005.PNG" alt="image-alt-text">
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Autonomous_Data_Warehouse/img/ADW_006.PNG" alt="image-alt-text">

9.  Click **Copy** and save the token in Notepad.

**Do not close the window without saving the token as it can not be retrieved later**


10. Nex install Dcoker, Enter command:

```
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0035.PNG" alt="image-alt-text">

11. Enter command:

```
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo**
```

12. Enter command:

```
sudo systemctl enable docker
```

13. Enter command:

```
sudo systemctl start docker
```

14. Enter command: (To add user opc to Docker)

```
sudo usermod -aG docker opc
```  

15. Docker is installed and user opc enabled to use Docker. Logout and log back in to the compute instance. Enter command;

```
exit
```

ssh back in to the compute instance. Enter commands;

```
docker images 
```
and ensure no error is displayed

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Container_Registry/img/OCIR_HOL0036.PNG" alt="image-alt-text">

```
docker version
```
TO verify docker version

```
$ docker run hello-world
```
To launch the standard hello-world Docker image as a container

16. Next we will install Fn CLI which is needed to execute CLI commands. Enter command;
```
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh
```

17. Confirm that the CLI has been installed. Enter command;
```
fn version
```

18. Next create the new Fn Project CLI context. Enter command;

**NOTE**: 'CONTEXT-NAME' below can be a name that you can choose e.g test-fn
```bash
 fn create context <CONTEXT NAME> --provider oracle
```

19. Specify that the Fn Project CLI is to use the new context. Enter command;
```bash
fn use context <CONTEXT NAME>
```

20. Switch to OCI Cosole. From OCI Services Meneu, Click **Compartments** under **Identity**. 

21. Locate your compartment and click the name. Copy the OCID of the compartment just as was done for User and Tenancy. Also note down youe region name

22. Switch back to ssh session to compute instance. Configure the new context with the OCID of the compartment you want to own deployed functions. Enter Command;

```bash
fn update context oracle.compartment-id <compartment-ocid>
```


23. Configure the new context with the api-url endpoint to use when calling the OCI API. Enter command;

```
fn update context api-url https://functions.us-<REGION NAME>.oraclecloud.com
```

**For example: fn update context api-url https://functions.us-ashburn-1.oraclecloud.com**


24. Configure the new context with the address of the Docker registry and repository that you want to use with Oracle Functions, Enter command;
```bash
fn update context registry <region-code>.ocir.io/<tenancy-namespace>/<repo-name>
```

where "region-code" indicates the registry location. Region codes are list at https://docs.cloud.oracle.com/iaas/Content/Registry/Concepts/registryprerequisites.htm#regional-availability, and "tenancy-namespace" is the tenancy's name string shown on the Tenancy Information page.

***For example:** fn update context registry phx.ocir.io/ansh81vru1zp/acme-repo Here;

**region code:** phx

**tenancy name:** ansh81vru1zp and

**docker registry repo:** acme-repo (which will be used for Function)

25. Configure the new context with the name of the profile you've created for use with Oracle Functions. Enter command;

```
fn update context oracle.profile DEFAULT
```

26. Next we will login to OCI Registry and ensure we have access. Enter command;
```bash
docker login <region-code>.ocir.io
```

**For example: docker login iad.ocir.io**

27. When prompted, enter your user name in the format;

**tenancy-namespace>/<username**

**For example: ansh81vru1zp/jdoe@acme.com**
 
28. When prompted for a password, enter the auth token generated ealier.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Fn/img/Fn_001.PNG" alt="image-alt-text">

29. Next we will create our fist applicaiton. Login to OCI console. Under OCI serverices menu, click  **Solutions and Platform**, click **Developer Services** and then **Functions**

30. Click **Create Application** and fill out the dialog box:

- **NAME**: Provide a name (note down the name)
- **VCN in** : Choose the compartment where VCN was created
- **SUBNETS** : Choose the subnet
- **LOGGING POLICY**: None

Click **Create**

31. Next we will create our first function. In the ssh session to compute instance, Enter command;

**NOTE** 'FUNCTION_NAME' below shoudl be what you created in above step

```bash
fn init --runtime java <FUNCTION_NAME>
```
A directory called <FUNCTION_NAME> is created, containing:

a function definition file called func.yaml
a /src directory containing source files and directories for the <FUNCTION_NAME> function
a Maven configuration file called pom.xml that specifies the dependencies required to compile the function

32. Next we will deploy the function. Change directory to the <FUNCTION_NAME> directory created in the previous step
```bash
cd <FUNCTION_NAME>
```

33. Enter the following single Fn Project command to build the function and its dependencies as a Docker image called <FUNCTION_NAME>, push the image to the specified Docker registry, and deploy the function to Oracle Functions in the <NAME> used when **Create Application** was used. Enter command;
```bash
fn deploy --app <NAME>
```

**NOTE: <FUNCTION_NAME> is what was used in the compute instance and <NAME> is what was used in OCI Console**

34. You can also Confirm that the <FUNCTION_NAME> image has been pushed to Oracle Cloud Infrastructure Registry by logging in to the Console. Under **Solutions and Platform**, go to **Developer Services** and click **Registry**. 

35.  Now lets Invoke your first function. In the ssh session to compute instance, Enter command;
```bash
fn invoke <NAME> <FUNCTION_NAME>-func
```
**For exampel if in OCI console we used *helloworld-app* as the name and in compute instance we use *helloworld* then the command will be 'fn invoke helloworld-app helloworld-func'**

36. Verify 'Hello World !' message is displayed.

Congratulations! You've just created, deployed, and invoked your first function using Oracle Functions!

## Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under **Compute**

3. Locate first compute instance, Click Action icon and then **Terminat** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text">

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text">

5. Repeat the step to delete second compute instance

6. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

7. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">

8. Navigate to **Functions** under **Developer Servies**. Click the action icon and Click **Delete**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Configuring_Fn/img/Fn_002.PNG" alt="image-alt-text">

**Congratulations! You have successfully completed the lab**
