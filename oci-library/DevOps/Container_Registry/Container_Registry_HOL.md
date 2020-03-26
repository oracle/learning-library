# Container Registry Practice - Creating Container Registry
  
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Practice 1: Sign in to OCI Console and create VCN and Docker Registry](#practice-1-sign-in-to-oci-console-and-create-vcn-and-docker-registry)

[Practice 2: Create ssh keys and compute instance](#practice-2-create-ssh-keys-and-compute-instance)

[Practice 3: SSH to Compute Instance install Docker and push images to registry](#practice-3-ssh-to-compute-instance-install-docker-and-push-images-to-registry)

[Practice 4: Delete the resources](#practice-4-delete-the-resources)

## Overview

In this lab we will create Docker registry in OCI, we will then install Docker on a 
compute instance and push and pull images to/from this registry.

Oracle Cloud Infrastructure Registry is an Oracle-managed registry that enables you to simplify your development to production workflow. Oracle Cloud Infrastructure Registry makes it easy for you as a developer to store, share, and manage development artifacts like Docker images. And the highly available and scalable architecture of Oracle Cloud Infrastructure ensures you can reliably deploy your applicationsYou can use Oracle Cloud Infrastructure Registry as a private Docker registry for internal use, pushing and pulling Docker images to and from the Registry using the Docker V2 API and the standard Docker command line interface (CLI). You can also use Oracle Cloud Infrastructure Registry as a public Docker registry, enabling any user with internet access and knowledge of the appropriate URL to pull images from public repositories in Oracle Cloud Infrastructure Registry.

## Pre-Requisites

- Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

## Practice-1: Sign in to OCI Console and create VCN and Docker Registry


**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

**Before You Begin**

- We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

1. Sign in using your tenant name, user name and password.

2. Once signed in select the compartment assigned to you from drop down menu on left part of the screen

3. From the OCI Services menu,click **Virtual Cloud Network** under Networking and click **Create Virtual Cloud Network**

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

![]( img/OCIR_HOL001.PNG)
![]( img/OCIR_HOL002.PNG)

4. Fill out the dialog box:

- **Create in Compartment:** Has the correct compartment

- **Name:** Enter easy to re¬member name

- **Create Virtual Cloud Network Plus Related Resources:** Select this option.

- Click **Create Virtual Cloud Network**

- Click **Close**

![]( img/OCIR_HOL003.PNG)
![]( img/OCIR_HOL004.PNG)

***We will now create an Auth Token. This token will be used to login to connect to OCI Docker registry from the Docker computeinstance that will be created later one***

5.  Click **user icon** (Top Right of OCI Console Window) and then **User Settings** and then **Auth Token**
![]( img/OCIR_HOL005.PNG)

6. Click **Generate Token**, Provide a description, and click **Generate Token**
![]( img/OCIR_HOL006.PNG)

7. Click **Copy** (Under the token) to copy the token

8. If Notepad is not launched already, click the Apps icon  and click notepad.

![]( img/RESERVEDIP_HOL006.PNG)

9. Paste the Auth Token in Note pad(using your mouse/touch pad or Ctrl v).
10. Switch to the OCI console window. 

**HINT:** You can swap between OCI window and any other application(git-bash etc) by clicking the switch window icon
![]( img/RESERVEDIP_HOL007.PNG)

11. From OCI Services menu, click **Registry(OCIR)** under **Developer Services**
 
12. Click **Create Repository**. Provide Repository name (all Lowercase), Check **Public** and click **Submit**
![]( img/OCIR_HOL0012.PNG)

13.  Once created, verify there are no existing images in 
the repository (as shown in OCI console)

***We now have a Docker registry and Auth token (to validate login to the registry). Next we will create a Public/Private key pair and then compute instance to test pushing and pulling images from the registry.***

## Practice 2: Create ssh keys and compute instance

1. Open built in Git bash application and generate ssh keys

2. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

3. Enter command:
```
ssh-keygen
```
**HINT:** You can swap between OCI window, 
git-bash sessions and any other application (Notepad, etc.) by clicking the Switch Window icon 

![]( img/RESERVEDIP_HOL007.PNG)

4. Press Enter When asked for ‘Enter File in which to save the key’, ‘Created Directory, ‘Enter passphrase’, and ‘Enter Passphrase again.
![]( img/RESERVEDIP_HOL008.PNG)

5. You should now have the Public and Private keys:

/C/Users/ PhotonUser/.ssh/id_rsa (Private Key)
/C/Users/PhotonUser/.ssh/id_rsa.pub (Public Key)

**NOTE:** id_rsa.pub will be used to create 
Compute instance and id_rsa to connect via SSH into compute instance.

**HINT:** Enter command: (No Spaces)
 ```
 cd /C/Users/PhotonUser/.ssh
```
 and then 
 ```
 ls
 ```
to verify the two files exist. 

6. In git-bash Enter command:
```
cat /C/Users/PhotonUser/.ssh/id_rsa.pub
```
, highlight the key and copy 

![]( img/RESERVEDIP_HOL009.PNG)

7. Click the apps icon, launch notepad and paste the key in Notepad (as backup)

![]( img/RESERVEDIP_HOL0010.PNG)

8. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute** 

9. Click Create Instance. Fill out the dialog box:

- **Name:** Enter a name 

- **Availability Domain:** Select the first available domain.(usually AD1)

- **Image Operating System:** For the image, we recommend using the Latest Oracle Linux available.

- **Choose Instance Type:** Select Virtual Machine

- **Choose Instance Shape:** Select VM.Standard.E.2.1

- **Configure Boot Volume:** Leave the default

- **Add SSH Keys:** Choose ‘Paste SSH Keys’ and paste the Public Key saved earlier.

- **Virtual Cloud Network Compartment:** Choose your compartment

- **Virtual Cloud Network:** Select the VCN you created in the previous section. 

- **Subnet Compartment:** Choose your compartment. 

- **Subnet:** Choose the first Subnet

10. Click **Create**

**NOTE:** If 'Service limit' error is displayed choose a different shape such as VM.Standard.E2.2 OR VM.Standard2.2

![]( img/RESERVEDIP_HOL0011.PNG)

***Next we will ssh to the compute instance and install Docker.***

## Practice 3: SSH to Compute Instance install Docker and push images to registry

1. In git-bash type cd /C/Users/PhotonUser/.ssh

2. Enter command
```
ls
```
and verify id_rsa file exists

3. Enter command 
```
ssh –i id_rsa opc@<PUBLIC_IP_OF_COMPUTE_INSTANCE>
```
**NOTE:** User name is opc

**HINT:** If ‘Permission denied error’ is seen, ensure you are using ‘-i’ in the ssh command

4. Enter ‘Yes’ when prompted for security message

![]( img/RESERVEDIP_HOL0014.PNG)
 
5. Verify opc@<COMPUTE_INSTANCE_NAME(reserved-ip-instance1 in this case) appears on the prompt

6.  Enter command:
```
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```
![]( img/OCIR_HOL0020.PNG)

7. Enter command:
```
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo**
```
![]( img/OCIR_HOL0021.PNG)

8. Enter command:
```
sudo yum install docker-ce –y
```
(Wait for ‘Complete’message)
![]( img/OCIR_HOL0022.PNG)

9. Enter command:
```
sudo systemctl enable docker
```

10. Enter command:
```
sudo systemctl start docker
```
11. Enter command: (To add user opc to Docker)
```
sudo usermod -aG docker opc
```  

12. Docker is installed and user opc enabled to use Docker. Enter Command 
```Exit
```
to logout of ssh session on compute instance and then ssh back in to the compute instance. Enter command **Docker images** and ensure no error is displayed
![]( img/OCIR_HOL0023.PNG)

13. We will now pull a example image from Docker registry  to the compute instance. Enter Command:
```
docker image pull alpine
``` 
Verify image pull was successful, Enter Command 
```
Docker images
``` 
and verify alpine is present
![]( img/OCIR_HOL0024.PNG)

14. Now we will push this image to Docker registry created in OCI. First login to Registry in OCI. Enter command 
```
docker login <Region_Name_Code>.ocir.io
```
**NOTE:** Region name code are, fra for Frankfurt, iad for Ashburn, lhr for London, phx for Phoenix.

![]( img/OCIR_HOL0025.PNG)

**HINT:** Your region is shown on top right corner of OCI console window

![]( img/OCIR_HOL0026.PNG)

- Username:  Enter it in format Tenancy Name/User name (TS-SPL-55/john_doe)
- Password: Paste the Auth key saved earlier (Characters wont be visible)

![]( img/OCIR_HOL0027.PNG)

15. Verify Login Succeeded message is displayed.

16. Next we will tag the image that we pulled from the web. Enter command 
```
docker images
``` 
and note down the image id of alpine. Enter command: (No Spaces)
```
docker tag <image_id>  <Region_Name_Code>.ocir.io/<TenancyName>/<docker_registry_name>:<image_name> 
```
17. Verify the tag was created, Enter command 
```
docker images
``` 
and verify version x.y.test is present. x and y will be the numeric version number)

**NOTE:** In below example:

- <image_id> is **3fd9065eaf02** 

- <Region_Name_Code> is **iad** 

- <Tenancy_Name> is **us_training** 

- <docker_registry_name> is **docker-test-image**

- <image_name> is **version4.0.test**  
![]( img/OCIR_HOL0028.PNG)

18. We will now push the image to docker registry in OCI. 
Enter command: 
```
docker push <Region_Name_Code>.ocir.io/<Tenancy_Name>/<docker_registry_name>:<image_name>** (No Spaces)
```
**NOTE:** In below example:
- <Region_Name_Code> is **iad**
- <Tenancy_Name> is **us_training**
- <docker_registry_name> is **docker-test-image**
- <image_name> is **version4.0.test**  
![]( img/OCIR_HOL0029.PNG)

19. Switch to OCI window and navigate to your registry. Newly pushed image should be visible.

**HINT:** Refresh the browser window if image is not displayed

![]( img/OCIR_HOL0030.PNG)

20. Switch to compute instance ssh window. Enter command 
```
docker pull <Region_Name_Code>.ocir.io/<Tenancy_Name>/<docker_registry_name>:<image_name>**  (No Spaces)    
```
21. Verify the pull command was successful
![]( img/OCIR_HOL0031.PNG)

**HINT:** We are pulling the same image that we just pushed.

***We now have a working Docker registry and can successfully push and pull images to/from it.***

## Practice 4: Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute

3. Locate first compute instance, Click Action icon and then **Terminat** 
![]( img/RESERVEDIP_HOL0016.PNG)

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

![]( img/RESERVEDIP_HOL0017.PNG)

5. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

6. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted
![]( img/RESERVEDIP_HOL0018.PNG)

7. From OCI Services menu, click **Registry(OCIR)** under **Developer Services**, click Registry Name, Under **Action** click **Delete Repository**  ,click **Delete** in confirmation window
![]( img/OCIR_HOL0032.PNG)

***Congratulations! You have successfully completed Creating Docker Registry on Oracle Cloud Infrastructure .In this lab we successfully set up a Registry in OCI, Installed Docker on compute instance and then pushed and pulled images from the registry.***