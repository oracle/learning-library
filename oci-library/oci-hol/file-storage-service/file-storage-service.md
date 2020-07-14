# File System Storage Service

## Introduction

Welcome to the Cloud Storage (File System) self-paced lab from Oracle!

Oracle Cloud Infrastructure File Storage Service provides a durable, scalable, distributed, enterprise-grade network file system. You can connect to a File Storage Service file system from any bare metal, virtual machine, or container instance in your Virtual Cloud Network (VCN). You can also access a file system from outside the VCN using Oracle Cloud Infrastructure FastConnect and Internet Protocol security (IPSec) virtual private network (VPN).

In this lab you will create and mount File Storage System to a compute instance and verify availability of the File Storage system.

**Some Key points:**

*We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%*

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

### Pre-Requisites

1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)

2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)

3. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)

4. [Familiarity with Compartment](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)

5. [Connecting to a compute instance](https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm)

**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI.

## Step 1: Sign in to OCI Console and create VCN

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}


1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**.
    ![](./../grafana/images/Grafana_015.PNG " ")

2. From the OCI Services menu,Click **Virtual Cloud Networks** under Networking. Select the compartment assigned to you from drop down menu on left part of the screen under Networking and Click **Start VCN Wizard**

    **NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

3. Click **VCN with Internet Connectivity** and click **Start Workflow**.

4. Fill out the dialog box:

      - **VCN NAME**: Provide a name
      - **COMPARTMENT**: Ensure your compartment is selected
      - **VCN CIDR BLOCK**: Provide a CIDR block (10.0.0.0/16)
      - **PUBLIC SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.1.0/24)
      - **PRIVATE SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.2.0/24)
      - Click **Next**

5. Verify all the information and  Click **Create**

6. This will create a VCN with followig components.

    *VCN, Public subnet, Private subnet, Internet gateway (IG), NAT gateway (NAT), Service gateway (SG)*

7. Click **View Virtual Cloud Network** to display your VCN details.
              
8. In your VCN details page, Click **Security List** and then **Default Security list for YOUR\_VCN\_NAME**

     ![](./../oci-quick-start/images/Customer_Lab_001.PNG " ")

    **NOTE:** Note down the Subnet and Availability domain.We will create File Storage system and compute instance in the same subnet and Availability domain later on​​.

9. In Security list details page, Click **Add Ingress Rule**.Click **+Additional Ingress Rule** and add below two rules:

    **Rule # 1 for access of NFS and NLM traffic with Destination Port Range of 2048-2050. (Type the values).**


    - **Make sure STATELESS Flag in un-checked**
    - **SOURCE TYPE:** CIDR
    - **SOURCE CIDR:** 10.0.0.0/16
    - **IP PROTOCOL:** TCP
    - **SOURCE PORT RANGE:** ALL
    - **DESTINATION PORT RANGE:** 2048-2050

    **Rule # 2 for access of NFS and NLM traffic with Destination Port Range of 2048-2050. (Type the values).**


    - **Make sure STATELESS Flag in un-checked**
    - **SOURCE TYPE:** CIDR
    - **SOURCE CIDR:** 10.0.0.0/16
    - **IP PROTOCOL:** TCP
    - **SOURCE PORT RANGE:** 2048-2050
    - **DESTINATION PORT RANGE:** All

10. Click **+Additional Ingress Rule** to add third ingress rule allowing traffic to a Destination Port Range of 111 for the NFS rpcbind utility.

    - Source CIDR: 10.0.0.0/16
    - IP Protocol: TCP
    - Source Port Range: All
    - Destination Port Range: 111

11. Click **+Additional Ingress** Rule  to add fourth ingress rule allowing traffic to a Source Port Range of 111 for the NFS rpcbind utility.

    - Source CIDR: 10.0.0.0/16
    - IP Protocol: TCP
    - Source Port Range: 111
    - Destination Port Range: All

12. Click **Add Ingress Rule**

    **NOTE:** Note down the Subnet and Availability domain. We will create File Storage system and compute instance in the same subnet and Availability domain later on.

## Step 2: Create File System Storage

In this section we will create File System Storage.

1. From OCI Services menu, Click **File System** under **File Storage**

2. Click **Create File System**

3. Click **Edit Details**, under **Export Information**. Change **Export Path** to a easy to remember name and click **Create**

     ![](./../file-storage-service/images/FSS_001.png " ")

     ![](./../file-storage-service/images/FSS_002.png " ")

4. OCI console will show your File System details. Under **Exports** Click your mount target name under **Mount Target**. In Mount Target details page, note down the IP address.

     ![](./../file-storage-service/images/FSS_003.png " ")
              
     ![](./../file-storage-service/images/FSS_004.png " ")

We now have a File Storage system created. Next we will create a SSH key pair that will be used to login to a compute instance and mount the file system.

## Step 3: Create ssh keys and compute instance

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

     ![](./../oci-quick-start/images/RESERVEDIP_HOL006.PNG " ")

2. Enter command 
    
    ```
    <copy>
    ssh-keygen
    </copy>
    ```
    **HINT:** You can swap between OCI window, 
    git-bash sessions and any other application (Notepad, etc.) by Clicking the Switch Window icon.

     ![](./../oci-quick-start/images/RESERVEDIP_HOL007.PNG " ")

3. Press Enter When asked for 'Enter File in which to save the key', 'Created Directory, 'Enter passphrase', and 'Enter Passphrase again.

     ![](./../oci-quick-start/images/RESERVEDIP_HOL008.PNG " ")

4. You should now have the Public and Private keys:

    /C/Users/ PhotonUser/.ssh/id\_rsa (Private Key)

    /C/Users/PhotonUser/.ssh/id\_rsa.pub (Public Key)

    **NOTE:** id\_rsa.pub will be used to create 
    Compute instance and id\_rsa to connect via SSH into compute instance.

    **HINT:** Enter command 
    ```
    <copy>
    cd /C/Users/PhotonUser/.ssh (No Spaces) 
    </copy>
    ```
    and then 
    ```
    <copy>
    ls 
    </copy>
    ```
    to verify the two files exist. 

5. In git-bash Enter command  

    ```
    <copy>
    cat /C/Users/PhotonUser/.ssh/id_rsa.pub
    </copy>
    ```
    , highlight the key and copy 

     ![](./../oci-quick-start/images/RESERVEDIP_HOL009.PNG " ")

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup)

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0010.PNG " ")

7. Switch to the OCI console. From OCI services menu, Click **Instances** under **Compute**.

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

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0011.PNG " ")

      - **Boot Volume:** Leave the default
      - **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key saved earlier.

9. Click **Create**

    **NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD.

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0011.PNG " ")

10. Wait for Instance to be in **Running** state. In git-bash Enter Command:
    
    ```
    <copy>
    cd /C/Users/PhotonUser/.ssh
    </copy>
    ```

11. Enter **ls** and verify id\_rsa file exists

12. Enter command 
    ```
    <copy>
    bash
    ssh -i id_rsa opc@<PUBLIC_IP_OF_COMPUTE>
    </copy>
    ```

    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command.

13. Enter 'Yes' when prompted for security message

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0014.PNG " ")
 
14. Verify opc@COMPUTE\_INSTANCE\_NAME appears on the prompt

## Step 4: Mount the File Storage System to Compute Instance

Users of Ubuntu and Linux operating systems (We launched a Oracle Linux instance) can use the command line to connect to a file system and write files. Mount targets serve as file system network access points. After your mount target is assigned an IP address, you can use it to mount the file system. You need to install an NFS client and create a mount point. When you mount the file system, the mount point effectively represents the root directory of the File Storage file system, allowing you to write files to the file system from the instance.

1. In ssh session to Compute instance Enter command: 

    ``` 
    <copy>
    sudo yum install nfs-utils 
    </copy>
    ```
    (This is just to ensure nfs-utils is installed)


2. Enter command:
    
    ```
    <copy>
    sudo mkdir -p /mnt/nfs-data 
    </copy>
    ```
    to create a mount point.

3. Mount the file system, Enter command: 
    
    ```
    <copy>
    bash
    sudo mount 10.x.x.x:/<EXPORT_PATH_NAME> /mnt/nfs-data
    </copy>
    ```
    **NOTE:** The 10.x.x.x should be replaced with the  IP of File Storage system  and EXPORT\_PATH\_NAME should be replaced with Export path name used earlier(Example: If '/' was the EXPORT\_PATH\_NAME then **sudo mount 10.0.0.3:/ /mnt/nfs-data**).

    **NOTE:** Mount commands can also be seen by Clicking Action icon in File Storage detail, and selecting ‘Mount Commands’.


     ![](./../file-storage-service/images/FSS_006.png " ")

 4. Enter command:
    
    ```
    <copy>
    df -h OR mount | grep /mnt/nfs-data
    </copy>
    ```
    and verify the mounted File System Storage.

     ![](./../file-storage-service/images/FSS_007.png " ")

     ![](./../file-storage-service/images/FSS_008.png " ")

5. If you want to ping the mount point then modify the security list of the VCN for Ingress ICMP rule:

      - Source CIDR: 0.0.0.0/0
      - IP Protocol: ICMP
      - Source port range: All
      - Destination port range: All

     ![](./../file-storage-service/images/FSS_009.png " ")

6. **Optional Step**. Second compute instance can be created and same file system mounted on it following earlier steps
             
You have now mounted Enterprise grade File System storage created in OCI to your compute instance. You can place files in this file system and all other VM instances that have mounted the same file system will have access to it.

## Step 5: Delete the resources

In this section we will delete all the resources we created in this lab.

**Delete File System Storage**
1. From OCI Services menu, Click **File Systems**, then File System name that was created.

2. Under Exports, Click the action icon and select **Delete**

     ![](./../file-storage-service/images/FSS_010.png " ")

3. Verify there is no data under **Exports**.


4. Click **File Systems**, select your File system and Click **Delete**.


**Delete Compute instance**

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under Compute

3. Locate compute instance, Click Action icon and then **Terminate** 

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0016.PNG " ")


4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0017.PNG " ")

**Delete VCN**

1. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

2. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0018.PNG " ")


## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request. 
