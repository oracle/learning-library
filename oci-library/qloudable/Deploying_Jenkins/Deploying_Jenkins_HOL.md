# Deploying Jenkins
  
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Sign in to OCI Console and create VCN](#sign-in-to-oci-console-and-create-vcn)

[Create Compute instance, configure OCI CLI and upload API keys](#create-compute-instance,-configure-oci-cli-and-upload-api-keys)

[Install Jenkins, Configure Jenkins Master instance and create Jenkins Slave instance](#install-jenkins,-configure-jenkins-master-instance-and-create-jenkins-slave-instance)

[Delete the resources](#delete-the-resources)

## Overview

Faster software development has become a competitive advantage for companies. The automation of software development processes facilitates speed and consistency, which led to the rise for having a Continuous Integration (CI) and Continuous Delivery and Deployment (CD) pipelines. Jenkins is a very popular product among Oracle Cloud Infrastructure customers, which can automate all of the phases of CI and CD. You can host Jenkins on Oracle Cloud Infrastructure to centralize your build automation and scale your deployment as the needs of your software projects grow.

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

2. From the OCI Services menu, Click **Virtual Cloud Network** under Networking and Click **Create Virtual Cloud Network**

3. Select the compartment assigned to you from drop down menu on left part of the screen

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL001.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL002.PNG" alt="image-alt-text">

4. Fill out the dialog box:


- **Create in Compartment:** Has the correct compartment
- **Name:** Enter easy to re¬member name
- **Create Virtual Cloud Network Plus Related Resources:** Select this option.
- Click **Create Virtual Cloud Network**
- Click **Close**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL003.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL004.PNG" alt="image-alt-text">
                    
##  Create Compute instance, configure OCI CLI and upload API keys

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

15. Check oci CLI installed version, Enter command:
```
oci -v
```
**NOTE:** Version should be minimum 2.5.X (3/23/2019)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_CLI/img/100_CLI_001.png" alt="image-alt-text">

16. Next we will configure OCI CLI. Enter command:
```
oci setup config
```

17. Accept the default location. For user OCID switch to OCI Console window. Click Human Icon and then your user name. In the user details page Click **copy** to copy the OCID. **Also note down your region name as shown in OCI Console window**. Paste the OCID in ssh session.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_004.PNG" alt="image-alt-text">

18. Repeat the step to find tenancy OCID (Human icon followed by Clicking Tenancy Name). Paste the Tenancy OCID in ssh session to compute instance followe by providing your region name (us-ashburn-1, us-phoneix-1 etc)

19. When asked for **Do you want to generate a new RSA key pair?** answer Y. For the rest of the question accept default by pressing Enter

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_005.PNG" alt="image-alt-text">

20. **oci setup config** also generated an API key. We will need to upload this API key into our OCI account for authentication of API calls. Switch to ssh session to compute instance, to display the conent of API key Enter command :

```
cat ~/.oci/oci_api_key_public.pem
```

21. Hightlight and copy the content from ssh session. Switch to OCI Console, Click Human icon followe by your user name. In user details page Click **Add Public Key**. In the dialg box paste the public key content and Click **Add**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_006.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_OCI_Streaming_service/img/Stream_007.PNG" alt="image-alt-text">

## Install Jenkins, Configure Jenkins Master instance and create Jenkins Slave instance

1. Swtich to git bash widnow with ssh session to the compute instance, Enter commands: (Install Jenkins)
```
sudo yum install java –y
```

```
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
```        

```
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
```
```

sudo yum  install jenkins –y
```
```

sudo service jenkins start   
```
**(Ok message should be displayed)**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_003.PNG" alt="image-alt-text">

```
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp  
```
**(By default,Jenkins listens on port TCP 8080. Open this port on the instance firewall by configuring the firewall)**
     
```
sudo firewall-cmd --reload
```

2.  To login to Jenkins master node we just set-up its password needs to be retrieved. Enter command:

```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword. 
```
Copy and paste the password to Notepad

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_004.PNG" alt="image-alt-text">

3. Now we need to open port 8080 in Firewall rule for the compute instance. Switch to OCI console window. 

4. From OCI Services menu, Click **Virtual Cloud Network** under Networking

5. From OCI services menus Navigate to your VCN created earlier and Click your VCN name, Click **Security List** and then **Default Security list for<YOUR_VCN_NAME>**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploy_Redis/img/Customer_Lab_001.PNG" alt="image-alt-text">)

6. In Security list details page, Click **Add Ingress Rule**. Click **+Additional Ingress Rule** and enter the following ingress rule; Ensure to leave STATELESS flag un-checked


- Source Type: CIDR 
- Source CIDR: 0.0.0.0/0
- IP Protocol: TCP
- Source Port Range: All
- Destination Port Range: 8080

7. Click **Add Ingress Rule**. 

8. Open a new browser tab 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_008.PNG" alt="image-alt-text">

9. Enter the URL 
http://<PUBLIC_IP_OF_COMPUTE_INSTANCE>:8080

10. In the ‘Unlock Jenkins’ Screen, under ‘Administrator password’, copy/paste the password retrieved using command:

```
sudo cat  /var/lib/jenkins/secrets/initialAdminPassword 
```

from computeinstance earlier (32 character password)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_009.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_010.PNG" alt="image-alt-text">

11. In ‘Customize Jenkins’ screen, Click **Install suggested plugins**. Wait for plugins installation  to complete

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_011.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_012.PNG" alt="image-alt-text">

12. In ‘Create First Admin User’ screen, Click **Continue as admin**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_013.PNG" alt="image-alt-text">

13.  In ‘Instance Configuration’ screen, verify the correct IP (Public IP of compute instance) and port number is displayed. Click **Save and Finish**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_014.PNG" alt="image-alt-text">

14. In ‘Jenkins is ready’ screen, Click **Start using Jenkins**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_015.PNG" alt="image-alt-text">

15. In ‘Welcome to Jenkins’ screen, Click **Manage Jenkins**, Scroll down and Click **Manage Plugins**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_017.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_018.PNG" alt="image-alt-text">

16. In Plugin Manager screen, Click **Available**, In the Filter search box type oracle. In the resulting list, check **Oracle Cloud Infrastructure Compute** and then Click **Install Without restart**

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_019.PNG" alt="image-alt-text">

17. Once installation is complete, scroll up and Click **Manage Jenkins**.

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_020.PNG" alt="image-alt-text">

18. In Manage Jenkins screen, Click **Configure System**, Scroll Down and Click **drop down arrow under Add a new cloud**. Click **Oracle Cloud Infrastructure Compute**. New dialog box will appear

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_021.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_022.PNG" alt="image-alt-text">

19. Fill out the dialog box:


- **Name:** Use easy to remember name (This is the slave node that will be created)
- **Fingerprint:** Copy/paste OCI_api_key_fingerprint file content save earlier
- **APIKey:** Copy/paste OCI_api_key.pem file content saved earlier
- **PassPhrase:** Leave empty
- **Tenant Id:** Copy/Pare Tenant OCID saved earlier
- **User Id:** Copy/Pare User OCID saved earlier
- **Region:** Type your region Name (Shown in OCI console window, us-ashburn-1 etc)

20. Click **Test Connection** and verify ‘Successful’ message. We have now verified connectivityto OCI via the master Jenkins compute node. Next we will create a slave Jenkins node

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_023.PNG" alt="image-alt-text">

21. Click **Add a new instance template**. Fill out the dialog box:


- Instance Template Description: Provide description (Jenkins-Slave etc)
- Usage: Leave as is (use this node as much as possible)
- Label: Provide label(Jenkins-Slave etc)
- Compartment: Choose the compartment assigned to you from drop down
- Availability Domain: Choose the same Availability domain as the Compute instance created earlier
- Image: Select latest Oracle Linux (Not anything with‘GPU’ in it)
- Shape: Select a VM shape

**NOTE:** If 'Service limit' error is displayed choose a different shape 


- Virtual Cloud Network: Select the VCN you created in the previous section
- Subnet: Select the same subnet as the Compute instance created earlier
- Assign Public IP address: Check this box
- Connect Agent using public IP: Check this box
- SSH Public key: Copy/Paste ssh public key generated earlier 9Id_rsa_user.pub)
- SSH Private key: Copy/Paste ssh private key generated earlier (id_rsa_user)

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_024.PNG" alt="image-alt-text">

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_025.PNG" alt="image-alt-text">

22. Click **Verify SSH key pair** and confirm Successful message

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_026.PNG" alt="image-alt-text">

23. Click **Advanced**, Fill out the dialog box:


- Remote FS Root: /tmp
- Remote SSH User: opc
- Instance Creation Timeout: 300
- Instance SSH Connection Timeout: 30
- Idle Termination Minutes: 30
- Number of Executors: 1
- Init Script: sudo yum install java –y
- Init Script Timeout: 120

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_027.PNG" alt="image-alt-text">

24. Click **Save** . Main Jenkins page will appear

25. In main Jenkins web page, Click Build Executor Status (Left Navigation pan). Click **drop down menu (Under master node information section)** and choose the Newly saved template.(Jenkins-Slave in this case)

26. Verify ‘Started Provisioning’ message is displayed

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_028.PNG" alt="image-alt-text">

27. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute**  Verify new compute node (Jenkins-Slave) is being provisioned.

28. Once compute instance is fully provisioned, switch back to Jenkins window and verify the new node appears on the screen. Click **Refresh Status** a few times to ensure Node is fully accessible (no next to it). You have now successfully deployed Jenkins with two compute nodes

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/Deploying_Jenkins/img/Jenkins_030.PNG" alt="image-alt-text">

***We have now successfully deployed Jenkins master and slave nodes on OCI.*** 

 ## Delete the resources

**NOTE:**  ***As a practice user will need to figure out any errors encountered during deletion of resources***

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute

3. Locate first compute instance, Click Action icon and then **Terminate** 

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0016.PNG" alt="image-alt-text">

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0017.PNG" alt="image-alt-text">

5. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

6. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

<img src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/qloudable/OCI_Quick_Start/img/RESERVEDIP_HOL0018.PNG" alt="image-alt-text">


***Congratulations! You have successfully completed the lab. ***
