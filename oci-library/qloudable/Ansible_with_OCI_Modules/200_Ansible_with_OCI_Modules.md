#  Managing Infrastructure with Ansible on OCI

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create a VCN](#sign-in-to-oci-console-and-create-a-vcn)

[Create Compute instance, configure OCI CLI and upload API keys](#create-compute-instance,-configure-oci-cli-and-upload-api-keys)

[Getting Started with Ansible](#getting-started-with-ansible)

[Deploying applicaitons and code with Ansible](deploying-applications-and-code-with-ansible)

[Clean Up your environment](#clean-up-your-environment)

## Overview

Today, the **Infrastructure as Code** paradigm is a norm for DevOps professionals, and Ansible is one of the leading tools that enables this paradigm. Ansible is great; not just for configuration management, but also for infrastructure provisioning and orchestration. And yet, have you ever wondered how to really use Ansible to manage your cloud infrastructure at scale?

This lab will demonstration both provisioning and configuration of your infrastructure. You will first provision a set of infrastructure resources with a single Ansible playbook.  Next, you will leverage Ansible's *Dynamic Inventory* functionality to fetch the details of this infrastructure and install use those details to deploy Apache (the configuration management aspect).   You would be doing all of it using your Ansible playbooks, leveraging the ‘Infrastructure as code’ paradigm.

**Some Key points;**

**We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%**


- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

- Do NOT use compartment name and other data from screen shots.Only use  data(including compartment name) provided in the content section of the lab

- Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the OCI Console

**Cloud Tenant Name**
**User Name**
**Password**
**Compartment Name (Provided Later)**

**Note:** The OCI UI is regularly being enhanced.  Therefore, some screenshots in the instructions might be different than actual user interface.

## Pre-Requisites

1. OCI Training : https://cloud.oracle.com/en_US/iaas/training

2. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

3. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

4. Familiarity with Compartments: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

5. Connecting to a compute instance: https://docs.cloud.oracle.com/iaas/Content/Compute/Tasks/accessinginstance.htm

## Sign in to OCI Console and create a VCN


* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Grafana/img/Grafana_015.PNG" alt="image-alt-text">

2.  From the OCI Services menu,Click **Virtual Cloud Networks** under Networking. Select the compartment assigned to you from drop down menu on left part of the screen under Networking and Click **Start VCN Wizard**

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

## Create Compute instance, configure OCI CLI, and upload API keys

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

  ``/C/Users/ PhotonUser/.ssh/id_rsa (Private Key)``

  ``/C/Users/PhotonUser/.ssh/id_rsa.pub (Public Key)``

  **NOTE:** id_rsa.pub will be used to create the compute instance and id_rsa to connect via SSH into compute instance.

  **HINT:** Enter command
  ```
  cd /C/Users/PhotonUser/.ssh (No Spaces)
  ```
  and then
  ```
  ls
  ```
  to verify the two files exist.

5. In git-bash Enter command, then highlight the key and copy it.
```
cat /C/Users/PhotonUser/.ssh/id_rsa.pub
```
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL009.PNG" alt="image-alt-text">

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup)
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0010.PNG" alt="image-alt-text">

7. Switch to the OCI console. From OCI services menu, Click **Instances** under **Compute** 

8. Click **Create Instance**. Fill out the dialog box:

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

9. Click **Create**


**NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard.B1.1  OR choose a different AD

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

15. Check oci CLI installed version, Enter command:
```
oci -v
```
  **NOTE:** Version should be minimum 2.6.X (7/23/2019)

  <img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_CLI/img/100_CLI_001.png" alt="image-alt-text">

16. Next we will configure OCI CLI. Enter command:
```
oci setup config
```
17. Accept the default location. For user OCI switch to OCI Console window. Click Human Icon and then your user name. In the user details page Click **copy** to copy the OCID. **Also note down your region name as shown in OCI Console window**. Paste the OCID in ssh session.
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_004.PNG" alt="image-alt-text">

18. Repeat the step to find tenancy OCID (Human icon followed by Clicking Tenancy Name). Paste the Tenancy OCID in ssh session to compute instance followe by providing your region name (us-ashburn-1, us-phoneix-1 etc)

19. When asked for **Do you want to generate a new RSA key pair?** answer Y. For the rest of the question accept default by pressing Enter
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_005.PNG" alt="image-alt-text">

20. **oci setup config** also generated an API key. We will need to upload this API key into our OCI account for authentication of API calls. Switch to ssh session to compute instance, to display the conent of API key Enter command :
```
cat ~/.oci/oci_api_key_public.pem
```

21. Highlight and copy the content from ssh session. Switch to OCI Console, Click Human icon followe by your user name. In user details page Click **Add Public Key**. In the dialg box paste the public key content and Click **Add**.
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_006.PNG" alt="image-alt-text">
.
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_007.PNG" alt="image-alt-text">

22. Navigate to ``Identity`` --> ``Compartments`` and locate the OCID for your assigned compartment.  Copy it.

23. Return to your SSH terminal session.  To validate that the CLI is working properly run the following command.
```bash
oci compute instance list --compartment-id <value you copied in previous step>
```

## Getting started with Ansible
In this section we will download some sample Ansible resources and configure it to work with our OCI tenancy.  Before starting this section, make sure you are in your SSH connection to the server you created in the previous section.

1. Create an SSH key that Ansible will use when deploying new compute resources.  Press enter repeatedly to accept all default.
```
ssh-keygen
```
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Ansible_with_OCI_Modules/img/ansible_002.png" alt="image-alt-text">

2. Download and unzip the sample files.
```
wget https://github.com/oracle/learning-library/raw/master/oci-library/qloudable/Ansible_with_OCI_Modules/files/oci_ansible.zip
unzip oci_ansible.zip
```

3. Ansible will use your CLI credentials to authenticate and authorize access to OCI.  You will need to configure details of which Compartment to use and which Compute image.  Modify the **env-vars** file to update these values.
```
# OCID of assigned compartment
export compartment_ocid=[your compartment id goes here - without square brackets]
# Oracle-Linux-7.7-2019.08-28-0
#Ashburn
export image_ocid=ocid1.image.oc1.iad.aaaaaaaayuihpsm2nfkxztdkottbjtfjqhgod7hfuirt2rqlewxrmdlgg75q
#Phoenix
export image_ocid=ocid1.image.oc1.phx.aaaaaaaadtmpmfm77czi5ghi5zh7uvkguu6dsecsg7kuo3eigc5663und4za
# skip host verification prompts for demo
export ANSIBLE_HOST_KEY_CHECKING=False
```

**NOTE:** You should only need to modify the compartment OCID.  If running in Phoenix instead of Ashburn, just move the **#** to comment out the line for the region you are not using.

4. Save and exit the file.
5. Load the variables in the above file into ENV
```
source env_vars
```

6. You will also need to update the ``oci_inventory.ini`` file for the dynamic inventory script.  Uncomment the compartment setting and replace the value with your compartment ocid.
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Ansible_with_OCI_Modules/img/ansible_004.png" alt="image-alt-text">

7. Run the first sample playbook.  This will list some information about any compute resources you have in the compartment (should be the one you are using right now).
```
ansible-playbook sample.yaml
```
<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Ansible_with_OCI_Modules/img/ansible_001.jpg" alt="image-alt-text">

8. If the output is devoid of errors, it is time to deploy our sample infrastructure.
```
ansible-playbook instance_pool_example.yaml
```

**NOTE:** This will take about 5 minutes to provision the network and compute resources.  You can navigate to *Instance Pools* in the OCI Management Console to watch the resources if you'd like.  

9. When the playbook execution is complete, see the output near the end for the public IP address of the instance that was provisioned.  Copy the IP address.

10. Open a new tab in the web browser and paste in the IP address; press enter.  You should encounter an error because nothing has been installed on the server yet.  Proceed to the next section.


## Deploying applications and code with Ansible
Now that we have provisioned our infrastructure, it is time to deploy an application (Apache) and some code (a simple HTML page).

1. Return to your SSH terminal session.

2. Run the following command to deploy and configure Apache on each server in the instance pool.
```
ANSIBLE_INVENTORY=./oci_inventory.py ansible-playbook -u opc --become provision_web_server.yaml
```

3. After this completes (about 10 seconds) return to your web browser and refresh the sample web server page from earlier.  It should now display *Configured by Ansible*.

**Challenge**
In this tutorial, Ansible is deploying a simple HTML page.  You can make modifications to the page and run the command in step 2 to deploy the "new code".

When finished, refresh your browser to see the changes.

## Cleaning up your environment
In this exercise, all of the resources provisioned by Ansible were also tagged.  The sample ``teardown.yaml`` script leverages these tags to find and destroy all the resources that were created.

1. Run the following command to remove all the resources.
```
ansible-playbook teardown.yaml
```

2. It should take 3-5 minutes to complete.

3. You did it!  Feel free to explore the code or repeat the steps above once more if you have time.

***Congratulations! You have successfully completed Getting Started with OCI CLI lab.***
