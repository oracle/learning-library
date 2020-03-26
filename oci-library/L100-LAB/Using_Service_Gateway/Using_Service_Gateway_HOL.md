#  Using Service Gateway 
  
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Practice 1: Sign in to OCI Console, create Object Storage Bucket and VCN](#practice-1-sign-in-to-oci-console,-create-object-storage-bucket-and-vcn)

[Practice 2: Generate ssh keys, Create 2 Compute instances and install OCI CLI](#practice-2-generate-ssh-keys,-create-2-compute-instances-and-install-oci-cli)

[Practice 3: Upload API keys, Create Service gateway and verify functionality](#practice-3-upload-api-keys,-create-service-gateway-and-verify-functionality)

[Practice 4: Delete the resources](#practice-4-delete-the-resources)

## Overview

If you're a typical Oracle Cloud Infrastructure customer, you may have resources in your virtual cloud network (VCN) that need to access the Oracle Cloud Infrastructure Object Storage service, which has publicly addressable endpoints. Until now, you could use either public subnets or a NAT instance, with an internet gateway in your VCN to access the service. However, you might not have wanted to use these options because of privacy, security, or operational concerns.
Service Gateway alleviates the preceding concerns by enabling the following functions:
- Private connectivity between your VCNs and Object Storage: You can add a service gateway to a VCN and use the VCN's private address space to access Object Storage without exposing the instances to the public internet. You don't need a public subnet, NAT instance, or internet gateway in your VCN. 
- Enhanced security for your Object Storage buckets: You can limit access to Object Storage buckets from an authorized VCN or from a specific range of IP addresses within the subnet. You can add  conditional references to VCN and IP addresses in IAM policies, which can only be satisfied when you initiate connections through a service gateway 

## Pre-Requisites

- Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

## Practice-1: Sign in to OCI Console, create Object Storage Bucket and VCN


**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

**Before You Begin**

- We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

1. Sign in using your tenant name, user name and password.

2. Once signed in select the compartment assigned to you from drop down menu on left part of the screen

3. From the OCI Services menu, click **Object Storage**
![]( img/OBJECT-STORAGE001.PNG)

4. Select the  correct Compartment (Left side of the OCI console) as shown below.
![]( img/RESERVEDIP_HOL002.PNG)

5. Click Create Bucket, Fill out the dialog box:

- Bucket Name: Provide a name (Test-Bucket in this lab)
- Bucket Name: Provide a name (Test-Bucket in this lab)
- Storage Tier: STANDARD 

6.  Click **Create Bucket**
![]( img/OBJECT-STORAGE002.PNG)

7. Click the Apps icon in the toolbar and select Git-Bash to open a terminal window.

![]( img/OBJECT-STORAGE004.PNG)

8. Change directory to the Downloads folder Enter command:
```
$ cd /c/Users/PhotonUser/Downloads/
```
![]( img/OBJECT-STORAGE005.PNG)

9. Create a sample file, Enter command:
```
touch samplefile
```
This should create a file by the name"samplefile" in the Downloads folder

10. Switch to OCI window and click the Bucket Name.

**HINT:** You can swap between OCI window and any other application(git-bash etc) by clicking switch window
![]( img/OBJECT-STORAGE006.PNG)

11. Bucket detail window should be visible. Click **Upload Object**
![]( img/OBJECT-STORAGE007.PNG)

12. Click on Upload Object > Browse > This PC > Downloads. You should see the sample file created earlier

13. Select the file, then click **Upload Object** in the Dialog box.

14. File should be visible under Objects

15. From the OCI Services menu,click **Virtual Cloud Network** under Networking and click **Create Virtual Cloud Network**

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

![]( img/RESERVEDIP_HOL001.PNG)
![]( img/RESERVEDIP_HOL002.PNG)

16. Fill out the dialog box:

- **Create in Compartment:** Has the correct compartment

- **Name:** Enter easy to re¬member name

- **Create Virtual Cloud Network Plus Related Resources:** Select this option.

- Click **Create Virtual Cloud Network**

- Click **Close**
![]( img/RESERVEDIP_HOL003.PNG)
![]( img/RESERVEDIP_HOL004.PNG)

## Practice 2: Generate ssh keys, Create 2 Compute instances and install OCI CLI

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

![]( img/RESERVEDIP_HOL006.PNG)

2. Enter command 
```
ssh-keygen
```
**HINT:** You can swap between OCI window, 
git-bash sessions and any other application (Notepad, etc.) by clicking the Switch Window icon 

![]( img/RESERVEDIP_HOL007.PNG)

3. Press Enter When asked for ‘Enter File in which to save the key’, ‘Created Directory, ‘Enter passphrase’, and ‘Enter Passphrase again.

![]( img/RESERVEDIP_HOL008.PNG)

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

![]( img/RESERVEDIP_HOL009.PNG)

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup)

![]( img/RESERVEDIP_HOL0010.PNG)

7. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute** 

8. Click Create Instance. Fill out the dialog box:

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

9. Click **Create**

**NOTE:** If 'Service limit' error is displayed choose a different shape such as VM.Standard.E2.2 OR VM.Standard2.2
![]( img/RESERVEDIP_HOL0011.PNG)

10. Wait for Instance to be in **Running** state. In git-bash Enter Command:
```
 cd /C/Users/PhotonUser/.ssh
```
11. Enter **ls** and verify id_rsa file exists

12. Enter command 
```
ssh –i id_rsa opc@<PUBLIC_IP_OF_COMPUTE_INSTANCE>
```
**NOTE:** User name is opc

**HINT:** If ‘Permission denied error’ is seen, ensure you are using ‘-i’ in the ssh command

13. Enter ‘Yes’ when prompted for security message

![]( img/RESERVEDIP_HOL0014.PNG)
 
14. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt

15. In the compute instance Enter command 
```
ssh-keygen
```
, Press Enter at all the prompts. We now have a ssh key pair that we will use to launch a second compute instance.
![]( img/SGW_013.PNG)

16. Enter command 
```
cd /home/opc/.ssh
```

17. Enter command 
```
cat id_rsa.pub
```
, highlight and copy the key starting at ssh
![]( img/SGW_014.PNG)

18.  Switch to OCI Console window

19. From OCI services menu, Click **Instances** under Compute 

20. Create a second compute instance as done before.

**NOTE:** If 'Service limit' error is displayed choose a different shape such as VM.Standard.E2.2 OR VM.Standard2.2

21. Once the instance is in Running state, click **Instance name** and note down its **Private IP address**
![]( img/SGW_015.PNG)

22. Switch to git-bash session used to ssh into first compute instance and ssh to second compute instance using the Private IP, Enter Command:
```
ssh –i id_rsa opc@<PRIVATE_IP_OF_COMPUTE_INSTANCE>
```
23. To install OCI CLI on the compute instance, Enter Command:

```
bash -c "$(curl –L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```
![]( img/SGW_001.PNG)

24.  When prompted for Install directory, Press Enter (choose default)
![]( img/SGW_002.PNG)

25. When prompted for ‘oci’ directory, Press Enter (choose default)
![]( img/SGW_003.PNG)

26. When prompted for ‘Y/N’ for $Path, Enter Y, when prompted for path for rc file Press Enter (choose default)
![]( img/SGW_004.PNG)

27. Check oci CLI installed version, Enter command:
```
oci -v
```
**NOTE:** Version shoudl be minimum 2.4.2X
![]( img/SGW_005.PNG)

28. Next we will configure OCI CLI. Enter command: 
```
oci setup config
```
 . Press Enter when prompted for directory name to accept the default. You will be prompted to enter user OCID
![]( img/SGW_006.PNG)

29. Switch to OCI Console window, Click user icon (Top Right of OCI Console Window) and click **User Settings**. In User settings click **copy** next to OCID for your user name
![]( img/SGW_007.PNG)

30. Switch to git-bash window and paste the user OCID using 
mouse/touch pad and press Enter. You will be prompted to
Enter Tenancy OCID

31. Switch to OCI Console window, Click user icon (Top Right of OCI Console Window) and click your Tenancy name, copy the OCID as was done for user OCID. Also note down your region (in this example "us-ashburn-1")
![]( img/SGW_008.PNG)

32. Switch to git-bash window and paste the tenancy OCID using mouse/touch pad and press Enter.You will be prompted to Enter your region.
![]( img/SGW_009.PNG)

33. Type your region and press Enter. Enter Y for ‘New 
RSA key pair’. Press Enter and accept default options for directories. Press Enter when prompted for passphrase (i.e leave it empty)
![]( img/SGW_010.PNG)

34.  In git-bash session for second compute, Enter command:
```
cd /home/opc/.oci
```
and then 
```
ls
```
Verify the API key files and OCI CLI config files exist.
![]( img/SGW_011.PNG)

35. Enter command 
```
cat config
```
and ensure fingerprint exists. Leave the git-bash session open as we will verify the
finger print in config file aginst OCI, once we upload api
keys next.
![]( img/SGW_012.PNG)


## Practice 3: Upload API keys, Create Service gateway and verify functionality

1. In git-bash window for second compute, Enter command 
```
cat /home/opc/.oci/oci_api_key_public.pem
```
, highlight the output, right click mouse/touchpad and click copy
![]( img/SGW_016.PNG)

2. Switch to OCI Console window, Click user iconc(Top Right of OCI Console Window) and click User Settings. In User settings click **API Keys** and **Add Public Key**.
![]( img/SGW_017.PNG)

3. Paste the content of oci_api_key_public.pem copied earlier and click **Add**.
![]( img/SGW_018.PNG)

4. A new finger print will be generated. Switch to git-bash window and enter command
```
cat /home/opc/.oci/config
```
Compare the finger print in the output of config file to 
the one in OCI console window and make sure they match

**NOTE:** If multiple finger prints exist in OCI console window then identify your finger print by looking at the time stamp.
![]( img/SGW_019.PNG)

***We will now upload an object to object storage and access it from second compute instance. This download will use the Public IP of Compute Instance***

5. In OCI console locate Object storage name space and Object Storage name. From the OCI Services menu, click Object Storage. Locate your object storage and click the name. Note down the name space and object storage name
**NOTE:** In below example, Object Storage bucket name is 'Service-Gateway-Bucket' and Name Space is 'us_training'
![]( img/SGW_020.PNG)

6. Switch to git-bash window (ssh session to second compute instance) and download samplefile. Enter command:
```
oci os object get --namespace <NAME_SPACE> --bucket-name <BUCKET_NAME> --name samplefile --file ./samplefile
```
**HINT:** In this example the command will be:
oci os object get --namespace us_training --bucket-name
Service-Gateway-Bucket --name samplefile --file ./samplefile
![]( img/SGW_021.PNG)

7. Enter command 
```
ls
```
 and verify sample file was downloaded

**NOTE:** The file was downloaded using Public IP of compute instance along with Internet Gateway. Next we will remove the Public IP of compute instance and verify the file can not be downloaded anymore.

8. Enter command 
```
rm samplefile
```
to remove the file.

9. Switch to OCI Console window. From OCI services menu, 
Click **Instances** under Compute. Locate your instance and click on Instance name.

10. Click **Attached VNIC** and then VNIC Name.
![]( img/SGW_022.PNG)

11. In VNIC detail page, Click Action icon and then **Edit**. In the pop up window choose No Public IP and click **Update**.
This will remove the Public IP of the compute instance.
![]( img/SGW_023.PNG)
![]( img/SGW_024.PNG)

12. Switch to git-bash window (with ssh to second compute instance) Re-enter the download command:
```
oci os object get --namespace <NAME_SPACE> --bucket-name <BUCKET_NAME> --name samplefile --file ./samplefile**
```
13. No output will be displayed and no file will be downloaded. Enter Ctrl+C to terminate the command. Enter command 
```
ls
```
and verify samplefile was not downloaded.
![]( img/SGW_025.PNG)

***Since there is no Public IP on the second compute instance it can no longer access Object storage. Next will create a Service gateway, initialize the route table and re-download the file. (without assigning Public IP to compute instance)***

14. From OCI Services menu, click Virtual Cloud Network under Networking

15. Locate your VCN and Click VCN name. Click **Service-Gateways**, then **Create Service Gateway**.
Fill out the dialog box:
- **Create in Compartment:** Ensure correct compartment is selected.
- **Name:** Provide a name.
- **Services:** Click **Drop down** and choose OCI IAD-ObjectStorage.
![]( img/SGW_027.PNG)

16. Click **Create**, then click **Close**

17. Click **Route Tables**, then **Default Route table for <VCN_NAME>**. Click **Edit Route Rule**, then **Add Another Route Rule**. Fill out the dialog box:
- **TARGET TYPE:**  Service Gateway
- **DESTINATION SERVICE:** OCI IAD-ObjectStorage
- **COMPARTMENT:** Choose the assigned compartment
- **TARGET SERVICE GATEWAY:** Choose the service Gateway created earlier

18.  Click **Save**, new route entry should be created.

![]( img/SGW_028.PNG)

19. In Your VCN , Click **Security Lists** and then **Default Security List for <VCN_NAME>**

20. Click **Edit All Rules** and then **+Another Egress Rule**. Add the below Rule under Allow Rules for Egress
- **DESTINATION TYPE:** Service
- **DESTINATION SERVICE:** OCI IAD Object Storage
- **IP Protocol:** All Protocol

![]( img/SGW_030.PNG)

21. Click **Save Security List Rules**

22. Switch to git-bash window (with ssh to second compute instance).

23. Re-enter download command:
```
oci os object get --namespace <NAME_SPACE> --bucket-name<BUCKET_NAME> --name samplefile --file ./samplefile**
```
![]( img/SGW_029.PNG)

***This completes the lab for provisioing service gateway for Private Instances access to other OCI resources.***

## Practice 4: Delete the resources
**NOTE:**  ***As a practice user will need to figure out any errors encountered during deletion of resources***

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute

3. Locate first compute instance, Click Action icon and then **Terminat** 

![]( img/RESERVEDIP_HOL0016.PNG)

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

![]( img/RESERVEDIP_HOL0017.PNG)

5. Repeat steps to delete the second compute instance

6. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

7. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

![]( img/RESERVEDIP_HOL0018.PNG)

8. From OCI services menu Click **Networking**, then **Public IPs**, locate the Service Gateway you created. Click Action icon and then **Terminate**

![]( img/RESERVEDIP_HOL0019.PNG)

***Congratulations! You have successfully completed Using Service Gateway lab. ***