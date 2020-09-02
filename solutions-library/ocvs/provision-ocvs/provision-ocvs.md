# Provisioning Oracle Cloud VMware Solution

## Introduction

This lab will get you started with the Oracle Cloud VMware Service. In this lab, you will provision an Oracle Cloud VMware stack including the Oracle Cloud Infrastructure resources needed to host the solution.

<!---### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.-->

To log issues, go to this [Confluence](https://confluence.oraclecorp.com/confluence/display/NOCSH/5.+Oracle+Cloud+VMware+Solution%3A+Training+Registration+and+Tracking) page.

## Objectives

As a system administrator or application developer:

1. Rapidly deploy OCVS on Oracle Cloud Infrastructure  
2. Manage your VMware workloads

## Prerequisites

1. An OCI account with atleast 3 available Bare Metal DenselIO 2.52 compute shape in the same availability domain.
2. A virtual cloud network with a recommended CIDR size of /20.
3. A CIDR block for VMWare workload that does not overlap with the VCN CIDR.

## **Step 1:** Create an SDDC

1.  Sign in to the OCI console and open the navigation menu by clicking on the hamburger menu icon on the top left of the screen.

2.  Under **Solutions and Platform**, click on **VMware Solution**.

    ![](./images/100_1.png " ")

3. From the **Compartment** drop down on the left side of the screen, select the compartment where you wish to deploy the solution and click on the **Create SDDC** button.

    ![](./images/100_2.png " ")

**Note**: Oracle Cloud Infrastructure allows logical isolation of users within a tenancy through Compartments. This allows multiple users and business units to share an OCI tenancy while being isolated from each other.

**If you have chosen a compartment where you do not have the required privileges, then you will not be able to provision the solution.**

More information about Compartments and Policies is provided in the OCI Identity and Access Management documentation [here](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm?tocpath=Services%7CIAM%7C_____13).

4.  On the basic information page, provide the following details:-
    1. **SDDC Name**: A descriptive name for the SDDC, such as 'SDDCVMWare'. This name has to be unique among all SDDCs across all compartments in the region. The name must have 1 to 16 characters, must start with a letter, can contain only alphanumeric characters and hyphens (-), and is not case-sensitive.
    2. **SDDC Compartment**: The deployment compartment. You can change the compartment from here, as well.
    3. **VMware Software Version**: The version of bundled VMware software that you want to install on the ESXi hosts. The software bundle includes vSphere, vSAN, and NSX components. For the purpose of this lab, please select version **6.7 update 3**.
    4. **Number of ESXi Hosts**: The initial number of ESXi hosts to create in the SDDC. This number has to be at least 3 and can be at most 64. Please choose **3** for this workshop.
    
    ![](./images/100_4.png " ")

    **Note:** The Oracle Cloud VMware Solution supports addition and deletion of ESXi hosts in the SDDC. 
    
    5. **Prefix for ESXi Hosts**: (Optional) The prefix that you would like to use for the names of the ESXi hosts for identification. This string follows the same rules, as the SDDC name.
    6. **SSH Key**: The public key portion of the SSH key that will be used for remote connections to the ESXi hosts. 
    7. **Availability Domain**: The availability domain in which the SDDC and the ESXi hosts will be created. The management subnet and VLANs for this SDDC must be in the same availability domain. 
    
    **Note**: ESXi hosts are uniformly distributed across fault domains within the availability domain. 

5. Click **Next**. 

    ![](./images/100_5.png " ")

6. On the SDDC Networks page, provide the following values:- 
    1. **Virtual Cloud Network (VCN)**: The VCN represents the underlying data center network that hosts the SDDC. The VCN can be in a different compartment from the SDDC and its ESXi hosts. 
    2. **Create New Subnet and VLAN**: If the network resources for this SDDC have to be created, then this option has to be selected, otherwise enter the details of the subnet that you wish to use. For this workshop, we recommend using this option.
    3. **SDDC Networks**: An available CIDR block in the selected VCN for the SDDC management CIDR. 

    The SDDC Management CIDR is divided into eight segments, one for the provisioning subnet and seven for VLANs. Since each cluster can have a maximum of  64 ESXi hosts, the size of the CIDR must be at least /22 to allow each host to have their own IP address. However, we recommend using a CIDR block of size /20. Clicking on **Check Availability** will help to ensure that the selected CIDR block is available in the VCN. 
    
    ![](./images/100_6.png " ")

    4. **SDDC Workload Network**: The SDDC workload CIDR block. This CIDR block provides the IP addresses in the SDDC to be used by the VMware VMs to run workloads. The value must be /30 or larger and must not overlap with the VCN CIDR block. We recommend using a CIDR block of size /24 for workload network.

        ![](./images/100_7.png " ")

    5. Click on **Next** to review a summary of the settings for creating the SDDC. If everything is correct, click on **Create SDDC**.

        ![](./images/100_8.png " ")

    The summary page tells you that the SDDC creation request has been initiated and shows the provisioning status of each resource. 
    
    The SDDC should be up and running in, roughly, two and a half hours.

    ![](./images/100_10.png " ")

7. To monitor the progress of the SDDC creation, click on the URL at the top of the summary page. The SDDC details page will open. 

    ![](./images/100_11.png " ")

## **Step 2:** Configure connectivity to the internet through NAT Gateway

Since the SDDC is sittng in a private subnet, to allow it to communicate with the internet, we will need a NAT Gateway. 

1. Once the SDDC is active, click on the box that says **Configure connectivity to the internet through NAT Gateway** 

    ![](./images/100_11_0.png " ")

2. A configuration page will open up on the right showing the resources that will be created within the VCN. These would include: a NAT Gateway, a route table with a route rule for the NAT gateway and a network security group allowing egress traffic for all protocols.

    ![](./images/100_11_000.png " ")

    ![](./images/100_11_00.png " ")

3. Click on **Apply configuration**, to get a confirmation that the changes have been applied. Click on **Close**.

    ![](./images/100_11_1.png " ")

## **Step 3:** Configure connectivity to Oracle Services Network

1. To connect to the Oracle services network we would need a **Service Gateway (SGW)**. We will create one using the **Configure connectivity to Oracle Services Network** wizard. Click on that wizard to begin.

    ![](./images/100_11_2.png " ")

2. Once again, a configuration page will open up on the right with the SDDC workload CIDR details. Click on **Next**.

    ![](./images/100_11_3_0.png " ")

3. Review the resources that will be created within the VCN: a SGW, a route table with a route rule for service gateway and a network security group that allows access to all OCI services in the region. Click on **Apply Configuration**. You will get a confirmation that the changes have been applied. Now, click on **Close**.

## **Step 4:** Create a Public Subnet to host the Bastion server

We will now create a public subnet in the same VCN, as the SDDC, to host a Bastion server. We need this jump server to access the SDDC.

1. Open the navigation menu by clicking on the hamburger menu icon on the top left of the screen.
Go to **Networking** and select **Virtual Cloud Networks**. Make sure that you are in the correct compartment. If not then you can switch to the correct compartment from the drop down on the left side of the screen. 
    
    ![](./images/100_11_3_01.png " ")

    ![](./images/100_11_3_02.png " ")

2. Click on the VCN that hosts your SDDC. From the **Resources** panel on the left, choose subnets and then and click on **Create Subnet**. 

    ![](./images/100_11_3_03.png " ")

    ![](./images/100_11_3_1.png " ")

2. Give the subnet a name for e.g. \<your-name>-public-subnet, and provide a CIDR range with a minimum size of /30. Leave all other options as default.

    ![](./images/100_11_3_2.png " ")

3. Click on the **Create Subnet** button. You should now be able to see the created public subnet.

    ![](./images/100_11_3_3.png " ")

    ![](./images/100_11_3_4.png " ")

We still have to update the route rules for this subnet, but we will do that while we wait for our Bastion host to come up. So, let us go and create the bastion host. We will return to this public subnet, in a bit.

## **Step 5:** Create a bastion host to access your SDDC

1. Return to the navigation menu and under **Core Infrastructure**, click on **Compute** and then on **Instances**.

    ![](./images/100_12.png " ")

2. On the instances page, click on the **Create Instance** button.

    ![](./images/100_13.png " ")

    ![](./images/100_14.png " ")

3. On the Create Compute Instance page, provide the following values:- 
    1. **Name**: The name of the virtual machine. 
    2. **Image**: The image/operating system to be used by the virtual machine. We want to use the Windows Server 2016 Standard Image for this machine. 
    
    Clicking on the Change Image button will open a side panel. Scroll down to find the Windows Server 2016 Standard image.

    ![](./images/100_15.png " ")

    3. **Availability Domain (AD)** - The AD where the instance will be provisioned. 

    4. **Shape**: The shape (OCPU & memory) configuraion of the machine. Select a VM.Standard2.1 shape for your compute instance.

    ![](./images/100_16.png " ")

    ![](./images/100_17.png " ")

    5. **VCN**: Select the same VCN that was used for creating the SDDC. Select a public subnet, so that a public IP is assigned to the Virtual Machine.

    ![](./images/100_18.png " ")

5. Click on the **Create** button. Proceed to Step 6, while we wait for the creation to complete.

**Upon the creation of this instance, a user name and an initial password will be generated for you. They will be available on the details screen of the newly launched instance. You must create a new password upon logging into the instance for the first time.**

## **Step 6:** Create an Internet Gateway

Upon creation, the bastion server will have to communicate with the internet. For this, the public subnet will need an **Internet Gateway**.

1. Go to the navigation menu. Under **Core Infrastructure**, choose **Networking** and then **Virtual Cloud Networks**. 

    ![](./images/100_11_3_01.png " ")

2. Select your VCN from the given list. 

    ![](./images/100_11_3_03.png " ")

3. From the **Resources** section on the left side of the page, select **Internet Gateway**.

    ![](./images/100_11_6.png " ")
    
4. Click on the **Create Internet Gateway** button.

    ![](./images/100_11_7.png " ")

5. Provide a name and compartment for the Internet gateway and hit the **Create Internet Gateway** button.
    
    ![](./images/100_11_8.png " ")

    ![](./images/100_11_9.png " ")

You have successfully created an Internet Gateway. Now, let us attach it to the public subnet where your bastion resides.
    
## **Step 7:** Attach the Internet Gateway to the public subnet

We will now modify the route rules for the public subnet to direct the traffic through the internet gateway that you just created.

1. From the **Resources** section on the left side of the web page, select **Subnets**.

    ![](./images/100_11_9_1.png " ")

2. From the list, select the public subnet.
    
    ![](./images/100_11_10.png " ")

3. Click on the link to the associated **Route Table** in the panel at the top.

    ![](./images/100_11_11.png " ")

4. Click on the **Add Route Rules** button.

    ![](./images/100_11_12.png " ")

5. Select the **Target Type** as **Internet Gateway**, set the **Destination CIDR** as 0.0.0.0/0 and choose the internet gateway that you just created as the **Target Internet Gateway**. Thereafter, click on **Add Route Rules**. 

    ![](./images/100_11_13.png " ")

## **Step 8:** Update security list to allow Remote Desktop connection

1. We will now open port 3389 in the security list attached to the public subnet. Go back to the previous page and select **Security Lists** from the Resources panel.

    ![](./images/100_35.png " ")

2. Click on the Default Security List for the VCN, as it was the one that we attached to our public subnet.

    ![](./images/100_36.png " ")

3. Click on the **Add Ingress Rules** button.

    ![](./images/100_37.png " ")

4. Enter 0.0.0.0/0 as the **Source CIDR**, then click on the **IP Protocol** dropdown and select **RDP (TCP/3389)**. The **Destination Port Range** will get auto-populated with 3389.

    ![](./images/100_38.png " ")

5. Click on **Add Ingress Rules**.

    ![](./images/100_39.png " ")

    ![](./images/100_40.png " ")

The bastion host is now ready to accept remote desktop connections. 

## **Step 9:** Configure Connectivity from VMWare private subnet to our public subnet

1. We will now navigate back to the SDDC. Click on the hamburger icon, and under **Solutions and Platform**, click on **VMware Solution** and select the SDDC that you provisioned.

    ![](./images/100_1.png " ")

2. On the SDDC's page, click on the box that says **Configure connectivity to VCN resources**

    ![](./images/100_40_2.png " ")

3. A configuration page will up. Here, click on **Select Subnets**.

    ![](./images/100_40_3.png " ")

4. Select the private SDDC subnet and the public subnet you created in the previous step.

    ![](./images/100_40_5.png " ")

5. It gets added to the list of subnets. Now click **Next**

    ![](./images/100_40_4.png " ")

6. Review the resources that will get created within the VCN and click on **Apply Configuration**

    ![](./images/100_40_6.png " ")

    ![](./images/100_40_7.png " ")

7. You get a confirmation for all the configuration changes that were just applied.

    ![](./images/100_40_8.png " ")

    ![](./images/100_40_9.png " ")


## **Step 10:** Access the SDDC using the Bastion

1. Under **Core Infrastructure**, click on **Compute** and then on **Instances**.

    ![](./images/100_12.png " ")

2. Once the VM is created, click on your instance for details.

    ![](./images/100_19.png " ")

3. Copy the public IP address, username and one-time password from the console of the VM. You will need these to establish remote desktop connectivity to the machine.

    ![](./images/100_20.png " ")

4. Connect to the instance using a Remote Desktop application of your choosing. The screenshots below show the process using a Mac based client.

    ![](./images/100_21.png " ")

    ![](./images/100_22.png " ")    

    ![](./images/100_23.png " ")    

    ![](./images/100_24.png " ")

5. When you login for the first time, you will be prompted to set a new password. Reset your password and make a note of it.

    ![](./images/100_25.png " ")

6. Now, we will go to the page of our SDDC and we will copy the vSphere Client vCenter URL.

    ![](./images/100_26.png " ")

7. Install a web browser like Firefox on the Windows machine that you have connected to. Once it is installed, paste the **vSphere Client** link and hit enter.

    ![](./images/100_27.png " ")

 8. You will get a warning for unprotected access. Click on **Advanced** and then select the **Proceed** option to continue.

    ![](./images/100_28.png " ")

    ![](./images/100_29.png " ")

9. Click on the **Launch vSphere Client** button.

    ![](./images/100_30.png " ")

10. Here you will need to enter the credentials available on the SDDC's OCI console page. Go to the SDDC's console page and copy the **vCenter Username** and **vCenter Initial Password**.

    ![](./images/100_31.png " ")

**Note**: You will also find the NSX login information here.

11. You should now be able to access the vCenter. From here you can manage the VMware environment.

    ![](./images/100_33.png " ")

12. If you look at the panel on the left, you should be able to see the backend hosts used for the environment.

    ![](./images/100_34.png " ")