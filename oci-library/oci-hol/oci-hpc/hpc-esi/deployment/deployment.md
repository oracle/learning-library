# Deployment

## Introduction

There are many different ways of deploying the architecture (which we talked about in the previous lab) in OCI. In this particular lab, we will cover three different methods for deployment. 

* **via Resource Manager** - The *resource Manager* let you deploy it from the console. Only relevant variables are shown but others can be changed in the zip file.
* **via Terraform** - *Terraform* is a scripting language for deploying resources. It is the foundation of the Resource Manager, using it will be easier if you need to make modifications to the terraform stack often.
* **via Web Console** - The *web console* let you create each piece of the architecture one by one from a webbrowser. This can be used to avoid any terraform scripting or using existing templates.

Estimated Lab Time: 30 minutes

### Objectives

In this lab:
* We will walk you through the different steps that you would need to deploy the architecture in OCI. 

### Prerequisites

* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful
* Familiarity with networking is helpful

## ****OPTION 1****: Deployment through Resource Manager

1. **Log In**

    * You can start by logging in the Oracle Cloud console. If this is the first time, instructions to do so are available [here](https://docs.cloud.oracle.com/iaas/Content/GSG/Tasks/signingin.htm). Select the region in which you wish to create your instance. Click on the current region in the top right dropdown list to select another one.

   ![Image alt text](images/login.png)

2. **Resource Manager**

    * In the OCI console, there is a Resource Manager available that will create all the resources needed. The region in which you create the stack will be the region in which it is deployed.

    * Select the menu  ![Image alt text](images/menu.png) on the top left, then select Resource Manager and Stacks.
        

    * Create a new stack:  ![Image alt text](images/stack.png)

    * Download the [ZIP file](https://github.com/oci-hpc/oci-hpc-runbook-vps/raw/master/Resources/pamcrash.zip) for VPS and upload it as a stack.

    * Choose the Name and Compartment.


3. **Add VPS Binaries to Object Storage**

    * Select the menu on the top left, then select Object Storage and Object Storage.
        ![Image alt text](images/create_bucket.png) 

    * Create a new bucket or select an existing one. To create one, click on ![](images/create_bucket.png " ") 

    * Leave the default options: Standard as Storage tiers and Oracle-Managed keys. Click on ![](images/upload_object.png " ") 

    * Click on the newly created bucket name and then select ![](images/upload_object.png " ") 

    * Select your file and click ![](images/menu.png " ") 

    * Click on the 3 dots to the right side of the object you just uploaded ![](images/3dots.png " ")  and select "Create Pre-Authenticated Request".

    * In the following menu, leave the default options and select an expiration date for the URL of your installer. Click on ![](images/pre_auth.png " ") 

    * In the next window, copy the "PRE-AUTHENTICATED REQUEST URL" and keep it. You will not be able to retrieve it after you close this window. If you loose it or it expires, it is always possible to recreate another Pre-Authenticated Request that will generate a different URL.

4. **Select Variables**

    Click on 'Next' and fill in the following variables.  
    ![](images/next.png " ")

    **Headnode:**

    * CLUSTER AVAILABILITY DOMAIN: Availability Domain of the headnode (1,2 or 3)
    * SHAPE OF THE HEADNODE: Shape of the Head Node which is also the Compute Node in our architecture (BM.GPU3.8)
    * VNC TYPE FOR THE HEADNODE: Visualization Type for the headnode: none, VNC or X11VNC

    **Compute nodes:**

    * NUMBER OF COMPUTE NODES: How many compute nodes in the private network. This does not include the headnode
    * SHAPE OF THE COMPUTE NODES: Shape of the Compute Nodes
    * HYPERTHREADING: Turn hyperthreading On or Off. STAR-CCM+ performs usually better when it is turned off.

    **Visualization Nodes:**

    * NUMBER OF VISUALIZATION NODES: Number of visualization machines for Pre/Post
    * PASSWORD FOR THE VNC SESSIONS: password to use the VNC session on the Pre/Post Node 

    **Visualization Nodes Options:**

    * VNC TYPE FOR THE VISUALIZATION NODES: Visualization Type for the headnode: none, VNC or X11VNC
    * SHAPE OF THE VISUALIZATION NODES: Shape of the Visualization Node (VM.GPU2.1, BM.GPU2.2,...)
    * VISUALIZATION NODE AVAILABILITY DOMAIN: Availability Domain of the GPU Machine (1, 2 or 3)

    **File Storage:**

    * NVME SHARE DRIVE: Create a NFS shared drive from a NVMe disk on the headnode (Only available if headnode is BM.HPC2.36 or DENSE shapes)
    * BLOCK VOLUME SHARE DRIVE: Create a NFS shared drive from block storage.
    * FSS: Create a FSS to be accessible from all nodes.

    **Block Options:**

    * BLOCK VOLUME SIZE ( GB ): Size of the shared block volume

    **FSS Options**:

    * AVAILABILITY DOMAIN OF FSS: AD of the FSS mount


    **PAM-CRASH**

    * URL TO DOWNLOAD PAM-CRASH: URL of the installer of STAR-CCM+ (Leave blank if you wish to download later)
    * URL TO DOWNLOAD A MODEL TARBALL: URL of the model you wish to run (Leave blank if you wish to download later)
    * SHARE DRIVE FOR THE INSTALLER: Drive on which the installer will be installed (NVMe, Block or FSS)
    * SHARE DRIVE FOR THE MODEL: Drive on which the installer will be installed (NVMe, Block or FSS)
    * LICENSE SERVER IP: IP address for the license server
    * LICENSE SERVER PORT: Port on which the license server is listening.


    Click on ![](images/next.png " ")

    Review the informations and click on ![](images/create.png " ")


5. **Run the stack**

    Now that your stack is created, you can run jobs.

    Select the stack that you created. In the "Terraform Actions" dropdown menu , run terraform apply to launch the cluster and terraform destroy to delete it.

    Click on ![](images/tf_actions.png " ")


6. **Access your Cluster**

    Once you have created your cluster, if you gave a valid URL for the VPS binaries, no other action will be needed except [running your jobs](https://github.com/oci-hpc/oci-hpc-runbook-vps#running-the-application).

    Public IP addresses of the created machines can be found on the lower left menu under Outputs.

    The Private Key to access the machines can also be found there. Copy the text in a file on your machine, let's say /home/user/key.

    ```
    <copy>
    chmod 600 /home/user/key
    ssh -i /home/user/key opc@ipaddress 
    </copy>
    ```

    Access to the GPU instances can be done through a SSH tunnel:

    ```
    <copy>
    ssh -i /home/user/key -x -L 5902:127.0.0.1:5900 opc@ipaddress
    </copy>
    ```

    And then connect to a VNC viewer with localhost:2.
    
    [More information](https://github.com/oci-hpc/oci-hpc-runbook-StarCCM/blob/master/Documentation/ManualDeployment.md#accessing-a-vnc) about using a VNC session.



## ****OPTION 2****: Deployment through Terraform Scripts

1. **Terraform Installation**

    Download the binaries on the [terraform website](https://www.terraform.io/) and unzip the package. Depending on your Linux distribution, it should be similar to this:

    ```
    <copy>
    tf_install_dir=~/tf_install_dir
    cd $tf_install_dir
    wget https://releases.hashicorp.com/terraform/0.12.0/terraform_0.12.0_linux_amd64.zip
    unzip terraform_0.12.0_linux_amd64.zip
    echo export PATH="\$PATH:$tf_install_dir" >> ~/.bashrc
    source ~/.bashrc    
    </copy>
    ```

    To check that the installation was done correctly: ``` terraform -version ``` should return the version

2. **Using Terraform:**

    **Configure**

    1. Download the [zip](https://github.com/oci-hpc/oci-hpc-runbook-vps/raw/master/Resources/tf_pamcrash.zip) file and unzip the content.

    2. Edit the file terraform.tfvars for your settings, info can be found [on the terraform website](https://www.terraform.io/docs/providers/oci/index.html#authentication)

        * Tenancy_ocid
        * User_ocid
        * Compartment_ocid
        * Private_key_path
        * Fingerprint
        * SSH_private_key_path
        * SSH_public_key
        * Region

    **Note1: For Compartment_ocid: To find your compartment ocid, go to the menu and select Identity, then Compartments. Find the compartment and copy the ocid.**

    ![](images/menu.png " ")

    ![](images/compartment_OCID.png " ")
 
    **Note2: The private_key_path and fingerprint are not related to the ssh key to access the instance. You can create using those [instructions](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm). The SSH public and private keys can be generated like [this](https://docs.cloud.oracle.com/iaas/Content/GSG/Tasks/creatingkeys.htm)**

    In the variable.tf file, you can change the availability domain, the number of compute nodes, the number of GPU nodes, the shapes of the instances, ip of the license server,...
    

    **Run**

    ```
    <copy>
    cd <folder>
    terraform init
    terraform plan
    terraform apply   
    </copy>
    ```    

    If you wish to add or remove nodes after the setup has happened, just modify the variable in the variable.tf file and rerun the ```terraform apply``` command


    **Destroy**

    ```
    <copy>
    cd <folder>
    terraform destroy  
    </copy>
    ```    

3. **Access your Cluster**

    Once you have created your cluster, if you gave a valid URL for the STAR-CCM+ installation, no other action will be needed except [running your jobs](https://github.com/oci-hpc/oci-hpc-runbook-StarCCM/blob/master/Documentation/STAR-CCM%2B.md#running-the-application).

    Public IP addresses are written at the end of the run.

    The key to log on to your cluster has been created in your main directory as key.pem

    ```
    <copy>
    ssh -i /home/user/key.pem opc@ipaddress
    </copy>
    ```

    Access to the GPU instances can be done through a SSH tunnel:

    ```
    <copy>
    ssh -i /home/user/key.pem -x -L 5902:127.0.0.1:5900 opc@ipaddress
    </copy>
    ```

    And then connect to a VNC viewer with localhost:2.
    
    [More information](https://github.com/oci-hpc/oci-hpc-runbook-rocky/blob/master/Documentation/ManualDeployment.md#accessing-a-vnc) about using a VNC session.

## ****OPTION 3****: Deployment via Web Console

1. **Log In**

    You can start by logging in the Oracle Cloud console. If this is the first time, instructions to do so are available [here](https://docs.cloud.oracle.com/iaas/Content/GSG/Tasks/signingin.htm). Select the region in which you wish to create your instance. Click on the current region in the top right dropdown list to select another one.

    ![](images/Region.png " ")

2. **Virtual Cloud Network**

    Before creating an instance, we need to configure a Virtual Cloud Network. Select the menu ![Image alt text](images/menu.png) on the top left, then select Networking and Virtual Cloud Networks. ![Image alt text](images/createVcn.png)

    On the next page, select the following:

    * Name of your VCN
    * Compartment of your VCN
    * Choose "CREATE VIRTUAL CLOUD NETWORK PLUS RELATED RESOURCES"

    Scroll all the way down and ![Image alt text](images/createVcn.png)

    Close the next window.


    **Subnets**

    If you are using one compute node, the subnet was created during the VNC creation. If you want to create a cluster, we will generate a private subnet for the compute nodes, accessible only from the headnode.

    Before we generate a private subnet, we will define a security rule to be able to access it from the headnode. We would also like to download packages on our compute nodes, we will create a NAT gateway to be able to access online repositories to update the machine.


    **NAT Gateway**

    You have just created a VCN, click on the name. In the ressource menu on the left side of the page, select NAT Gateways.

    ![Image alt text](images/resources_menu.png)

    Click ![Image alt text](images/NAT.png)

    Choose a name (Ex:VPS_NAT) and click ![Image alt text](images/NAT.png)


    **Security List**

    In the ressource menu on the left side of the page, select Security Lists.

    Click on ![Image alt text](images/create_sl.png)

    Select a name like VPS_Private_SecList

    Add an Ingress Rule with CIDR 10.0.0.0/16 and select All Protocols

    Add an Egress Rule with CIDR 0.0.0.0/0 and select All Protocols

    Click on ![Image alt text](images/create_sl.png)

    To allow the creation of a Network File System, we also need to add a couple of ingress rules for the Default Security List for VPS_VCN. Click on "Default Security List for VPS_VCN" in the list.

    Add one ingress rules for all ports on TCP for NFS.

    Click ![Image alt text](images/addIngress.png)

    * CIDR : 10.0.0.0/16
    * IP PROTOCOL: TCP
    * Source Port Range: All
    * Destination Port Range: All Click ![Image alt text](images/addIngress.png)


    Add another ingress rules for UDP for NFS.

    Click ![Image alt text](images/addIngress.png)

    * CIDR : 10.0.0.0/16
    * IP PROTOCOL: UDP
    * Source Port Range: All
    * Destination Port Range: All Click ![Image alt text](images/addIngress.png)

    **Route Table**

    In the resource menu on the left side of the page, select Route Tables.

    Click on ![Image alt text](images/create_rt.png)

    Change the name to VPS_Private_RT

    Click + Additional Route Rule and select the settings:

    * TARGET TYPE : NAT Gateway
    * DESTINATION CIDR BLOCK : 0.0.0.0/0
    * TARGET NAT GATEWAY : VPS_NAT

    Click on ![Image alt text](images/create_rt.png)


    **Subnet**

    In the ressource menu on the left side of the page, select Subnets. Click on ![Image alt text](images/create_subnet.png)

    Choose the following settings:

    * NAME : VPS_Private_Subnet
    * TYPE: "REGIONAL"
    * CIDR BLOCK: 10.0.3.0/24
    * ROUTE TABLE: VPS_Private_RT
    * SUBNET ACCESS: "PRIVATE SUBNET"
    * SECURITY LIST: VPS_Private_SecList

    Click on ![Image alt text](images/create_subnet.png)


3. **Compute Instance**

    Create a new instance by selecting the menu on the top left, then select Compute and Instances.

    ![](images/Instances.png " ")

    On the next page, select ![](images/create_instance.png " ")

    On the next page, select the following:

    * Name of your instance
    * Availibility Domain: Each region has multiple availability domain. Some instance shapes are only available in certain AD.
    * Change the image source to Oracle Linux 7.6.
    * Instance Type: Select Bare metal
    * Instance Shape:
        * BM.HPC2.36
        * Other shapes are available as well, [click for more information](https://cloud.oracle.com/compute/bare-metal/features).
    * SSH key: Attach your public key file. For more information, click [here](https://cloud.oracle.com/compute/bare-metal/features).
    * Virtual Cloud Network: Select the network that you have previsouly created. In the case of a cluster: Select the public subnet for the Headnode and the Private Subnet for the compute nodes.

    Click ![](images/create_instance.png " ")

    After a few minutes, the instances will turn green meaning it is up and running. You can now SSH into it. After clicking on the name of the instance, you will find the public IP. You can now connect using ``` ssh opc@xx.xx.xx.xx ``` from the machine using the key that was provided during the creation.

    For a compute node to be able to access the NAT Gateway, select the compute node and in the Resources menu on the left, click on Attached VNICs.

    Hover over the three dots at the end of the line and select "Edit VNIC"

    Uncheck "Skip Source/Destination Check"

    Click ![Image alt text](images/updateVNIC.png)

    Restart This section for each compute instance. Before you do that, we will create a ssh key specific for the cluster to allow all machines to talk to each other using ssh. Log on to the headnode you created and run the command ssh-keygen. Do not change the file location (/home/opc/.ssh/id_rsa) and hit enter when asked about a passphrase (twice). Or run this command:


     ```
    <copy>
    cat /dev/zero | ssh-keygen -q -N ""
    </copy>
    ```

    Add the content of id_rsa.pub into the file /home/opc/.ssh/authorized_keys. You will also use the content of id_rsa.pub as the public key when creating your compute nodes.

     ```
    <copy>
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    </copy>
    ```
    

4. **Mounting a Drive**

    HPC machines have local NVMe storage but it is not mounted by default. Let's take care of that!

    After logging in using ssh, run the command ``` lsblk ```. The drive should be listed with the NAME on the left (Probably nvme0n1, if it is different, change it in the next commands)

    The headnode will have the shared drive with the installation and the model. This will be shared between all the different compute nodes. Each compute node will also mount the drive to be running locally on a NVMe drive. In this example the share directory will be 500 GB but feel free to change that.

    If your headnode is also a compute node, you can partition the drive.

    Make sure gdisk is installed : ``` sudo yum -y install ``` gdisk Let's use it:


     ```
    <copy>
    sudo gdisk /dev/nvme0n1
    > n      # Create new partition
    > 1      # Partition Number
    >        # Default start of the partition
    > +500G  # Size of the shared partition
    > 8300   # Type = Linux File System
    > n      # Create new partition
    > 2      # Partition Number
    >        # Default start of the partition
    >        # Default end of the partition, to fill the whole drive
    > 8300   # Type = Linux File System
    > w      # Write to file
    > Y      # Accept Changes
    </copy>
    ```

    Format the drive on the compute node:

     ```
    <copy>
    sudo mkfs -t ext4 /dev/nvme0n1
    </copy>
    ```

    Format the partitions on the headnode node:

     ```
    <copy>
    sudo mkfs -t ext4 /dev/nvme0n1p1
    sudo mkfs -t ext4 /dev/nvme0n1p2
    </copy>
    ```

    Create a directory and mount the drive to it. For the headnode, select ``` /mnt/share ``` as the mount directory for the 500G partition and ``` /mnt/local ``` for the larger one. For compute node, select ``` /mnt/local``` as the mount directory of the whole drive.

    Compute Node:

    ```
    <copy>
    sudo mkdir /mnt/local
    sudo mount /dev/nvme0n1 /mnt/local
    sudo chmod 777 /mnt/local
    </copy>
    ```

    Head Node:

    ```
    <copy>
    sudo mkdir /mnt/share
    sudo mkdir /mnt/local
    sudo mount /dev/nvme0n1p1 /mnt/share
    sudo mount /dev/nvme0n1p2 /mnt/local
    sudo chmod 777 /mnt/share
    sudo chmod 777 /mnt/local
    </copy>
    ```


5. **Creating a Network File System**

    * **Headnode**  

        Since the headnode is in a public subnet, we will keep the firewall up and add an exception through.

        ```
        <copy>
        sudo firewall-cmd --permanent --zone=public --add-service=nfs
        sudo firewall-cmd --reload
        </copy>
        ```

        We will also activate the nfs-server:

        ```
        <copy>
        sudo yum -y install nfs-utils
        sudo systemctl enable nfs-server.service
        sudo systemctl start nfs-server.service
        </copy>
        ```

        Edit the file /etc/exports with vim or your favorite text editor. ``` sudo vi /etc/exports ``` and add the line ``` /mnt/share 10.0.0.0/16(rw) ```

        To activate those changes:

        ```
        <copy>
        sudo exportfs -a
        </copy>
        ```

    * **Compute Nodes**  

        On the compute nodes, since they are in a private subnet with security list restricting access, we can disable it altogether. We will also install the nfs-utils tools and mount the drive. You will need to grab the private IP address of the headnode. You can find it in the instance details in the webbrowser where you created the instances, or find it by running the command ```ifconfig``` on the headnode. It will probably be something like 10.0.0.2, 10.0.1.2 or 10.0.2.2 depending on the CIDR block of the public subnet.

        ```
        <copy>
        sudo systemctl stop firewalld
        sudo yum -y install nfs-utils
        sudo mkdir /mnt/share
        sudo mount 10.0.0.2:/mnt/share /mnt/share
        </copy>
        ```

7. **Allow communication between machines**

    After creating the headnode, you generated a key for the cluster using ```ssh.keygen```. We will need to send the file ```~/.ssh/id_rsa``` on all compute nodes. On the headnode, run ```scp /home/opc/.ssh/id_rsa 10.0.3.2:/home/opc/.ssh``` and run it for each compute node by changing the IP address.

8. **Adding a GPU Node for pre/post processing**

    If you have a post-processing tool that can let you take advantage of the power of GPUs for post-processing your model. We can turn a GPU node on demand while the simulation is done.


    Create a new instance by selecting the menu ![](images/menu.png " ") on the top left, then select Compute and Instances.

    ![](images/Instances.png " ")

    On the next page, select ![](images/create_instance.png " ")

    On the next page, select the following:

    * Name of your instance
    * Availibility Domain: Each region has multiple availability domain. Some instance shapes are only available in certain AD.
    * Change the image source to Oracle Linux 7.6
    * Instance Type: Select Bare metal for BM.GPU2.2 or Virtual Machine for VM.GPU2.1
    * Instance Shape:
        * BM.GPU2.2
        * VM.GPU2.1
        * BM.GPU3.8
        * VM.GPU3.*
        * Other shapes are available as well, [click for more information](https://cloud.oracle.com/compute/bare-metal/features). 
    * SSH key: Attach your public key file. [For your more information].(https://docs.cloud.oracle.com/iaas/Content/GSG/Tasks/creatingkeys.htm)
    * Virtual Cloud Network: Select the network that you have previsouly created. In the case of a cluster: Select the public subnet.

    Click ![](images/create_instance.png " ")

    After a few minutes, the instances will turn green meaning it is up and running. You can now SSH into it. After clicking on the name of the instance, you will find the public IP. You can now connect using ```ssh opc@xx.xx.xx.xx``` from the machine using the key that was provided during the creation.

    Use SSH to remote login to the machine and mount the share drive as show before:

    ```
    <copy>
    sudo firewall-cmd --permanent --zone=public --add-service=nfs
    sudo firewall-cmd --reload
    sudo yum -y install nfs-utils
    sudo mkdir /mnt/share
    sudo mount 10.0.0.2:/mnt/share /mnt/share
    </copy>
    ```

    You will need to follow the steps to set up a VNC session described below.

8. **Set up a VNC**

    If you used terraform to create the cluster, this step has been done already for the GPU instance.

    By default, the only access to the machines is through SSH in a console mode. If you want to see the Ansys EDT interface, you will need to set up a VNC connection. The following script will work for the default user opc. The password for the vnc session is set as "password" but it can be edited in the next commands.

    ```
    <copy>
    sudo yum -y groupinstall "Server with GUI"
    sudo yum -y install tigervnc-server mesa-libGL
    sudo systemctl set-default graphical.target
    sudo cp /usr/lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:0.service
    sudo sed -i 's/<USER>/opc/g' /etc/systemd/system/vncserver@:0.service
    sudo mkdir /home/opc/.vnc/
    sudo chown opc:opc /home/opc/.vnc
    echo "password" | vncpasswd -f > /home/opc/.vnc/passwd
    chown opc:opc /home/opc/.vnc/passwd
    chmod 600 /home/opc/.vnc/passwd
    sudo systemctl start vncserver@:0.service
    sudo systemctl enable vncserver@:0.service
    </copy>
    ```

9. **Accessing a VNC**

    We will connect through an SSH tunnel to the instance. On your machine, connect using ssh

    ```
    <copy>
    ssh -x -L 5902:127.0.0.1:5900 opc@public_ip
    </copy>
    ```

    You can now connect using any VNC viewer using localhost:2 as VNC server and the password you set during the vnc installation.

    If you would rather connect without a SSH tunnel. You will need to open ports 5900 and 5901 on the Linux machine both in the firewall and in the security list.

    ```
    <copy>
    sudo firewall-offline-cmd --zone=public --add-port=5900-5901/tcp
    </copy>
    ```
    Select the menu ![](images/menu.png " ") on the top left, then select Networking and Virtual Cloud Networks. 

    ![](images/create_vcn.png " ")

    Select the VCN that you created. Select the Subnet in which the machine reside, probably your public subnet. Select the security list.

    Click ![](images/addIngress.png " ")

    * CIDR : 0.0.0.0/0
    * IP PROTOCOL: TCP
    * Source Port Range: All
    * Destination Port Range: 5900-5901 Click ![](images/addIngress.png " ")

    Now you should be able to VNC to the address: ip.add.re.ss:5900

    Once you accessed your VNC session, you should go into Applications, then System Tools Then Settings.

    ![](images/CentOSSeetings.jpg " ")

    In the power options, set the Blank screen timeout to "Never". If you do get locked out of your user session, you can ssh to the instance and set a password for the opc user.

    ```
    <copy>
    sudo passwd opc 
    </copy>
    ```


## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.