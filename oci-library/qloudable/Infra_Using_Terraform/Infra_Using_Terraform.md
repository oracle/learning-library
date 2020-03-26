# Deploying Infrastructure Using Terraform
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create a VCN](#sign-in-to-oci-console-and-create-a-vcn)

[Create ssh keys and compute instance](#create-ssh-keys-and-compute-instance)

[Configure OCI CLI Install Terraform Upload API keys and verify functionality](#configure-oci-cli-install-terraform-upload-api-keys-and-verify-functionality)


## Overview

Terraform is Infrastructure as Code tool for building and managing infrastructure efficiently and elegantly. In this lab we will use pre-configured terraform scripts to deploy VCN, Compute Instance, Block storage and attach the block storage to compute instance without using OCI console. We will then delete all these infrastructure resources.

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

4. Familiarity with Compartments: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

5. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm

## Sign in to OCI Console and create a VCN

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
- **Image Operating System:** Click **Change Image Source**. In the new window, Click **Oracle Images** Choose **Oracle Cloud Developer Image**. Scroll down, Accept the Agreement and Click **Select Image**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_009.PNG" alt="image-alt-text">


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

**HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command

13. Enter 'Yes' when prompted for security message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0014.PNG" alt="image-alt-text">
 
14. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt

## Configure OCI CLI Install Terraform Upload API keys and verify functionality

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

8. Next, Download script to install Terraform, Enter command:
```
sudo curl https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Infra_Using_Terraform/tf_setup.sh -o tf_setup.sh
```

This will download a script file called **tf_setup.sh**

9. Next modify the permission on the script and execute it, Enter Commands:
```
sudo chmod 755 tf_setup.sh
```

```
./tf_setup.sh
```

Press **Enter** when prompted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Infra_Using_Terraform/img/Terraform_002.PNG" alt="image-alt-text">

10. The script will install needed packages and create a new directory **tflab**. We will need to modify some env variables in the file. Enter command:
```
cd tflab
```

11. Now edit the env-variables file. We will updated 2 variables. Enter command:
```
vi env-vars
```

**NOTE: You can use another editor such as nano as well**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Infra_Using_Terraform/img/Terraform_003.PNG" alt="image-alt-text">

12. Update the TF_VAR_user_ocid variable with User OCID saved earlier

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Infra_Using_Terraform/img/Terraform_005.PNG" alt="image-alt-text">

13. Next Update the TF_VAR_Compartment_ocid variable. Switch to OCI Console window, Click **Compartment** under **Identity**. Locate your compartment name and Click it. In the compartment details page , clik **copy** to copy the OCID
Paste this OCID in **env-vars** file

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Infra_Using_Terraform/img/Terraform_006.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Infra_Using_Terraform/img/Terraform_007.PNG" alt="image-alt-text">

14. After updating env-vars file the content will look like below;

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Infra_Using_Terraform/img/Terraform_008.PNG" alt="image-alt-text">

15. Save the file and then source it, Etner command:
```
source env-vars
```

16. The enviornment is now set. Next we will download a terraform file (.tf) file that will be used to create VCN, Compute instnace, block volume and attach block volume to compute instance. We will download this file in **/home/opc** directory, Enter Command:
```
cd /home/opc
```

Enter Command: 

```
sudo curl https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Infra_Using_Terraform/compute.tf -o compute.tf
```

17. Ensure you are in **/home/opc** directory. 

18. Now initialize terraform , Enter Command:
```
terraform init
```

Verify successful initialization

19. To see the deloyment plan, Enter Command:
```
terraform plan
```

This will provide details on what will be configured in OCI

20. Finally apply the plan to create the infrastructure, Enter Command:
```
terraform apply
```

**NOTE:** You must type **yes** when prompted

21. This script will take some time to execute. You can switch to OCI console and observe creation of VCN, Compute instance, Block Volume and attachment of block volume to the compute instance.

22. Finally, destroty the infrastrucutre that we created. Enter Command:
```
terraform destroy
```

**NOTE:** You must type **yes** when prompted

You can switch to OCI console and observe deletion of VCN, Compute instance, Block Volume

**Congratulations! You have successfully completed the lab**
