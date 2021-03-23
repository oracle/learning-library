#  Using Reserved Public IP. 

## Introduction

A public IP address is an IPv4 address that is reachable from the internet. If a resource in your tenancy needs to be directly reachable from the internet, it must have a public IP address. Depending on the type of resource, there might be other requirements.

The purpose of this lab is to give you an overview of the Reserved Public IP Service and an example scenario to help you understand how the service works.

Estimated lab time: 35 minutes

### Prerequisites

1. Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment).
   
2. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)

3. [Familiarity with OCI console](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/console.htm)

4. [Overview of Networking](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/overview.htm)

5. [Familiarity with Compartment](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts.htm)

6. [Connecting to a compute instance](https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/accessinginstance.htm)

## Step 1: Create your VCN and Subnets

Set up a VCN to connect your Linux instance to the internet. You will configure all the components needed to create your virtual network.

1. Open the navigation menu. Under Core Infrastructure, go to Networking and click **Virtual Cloud Networks**.

    Ensure that a compartment (or the compartment designated for you) is selected in the Compartment list on the left.

2. Click **Start VCN Wizard**.

3. Select VCN with Internet Connectivity, and then click **Start VCN Wizard**.

4. Enter the following (descriptions are italicized. replace with the values for your scenario):

	* Name: *Enter a name for your cloud network*
	* COMPARTMENT: *select the desired compartment*
	* VCN CIDR BLOCK: *10.0.0.0/16*
	* PUBLIC SUBNET CIDR BLOCK: *10.0.0.0/24*
	* PRIVATE SUBNET CIDR BLOCK: *10.0.1.0/24*
	* DNS RESOLUTION: *checked*

   **Note**: The public and private subnets have different CIDR blocks.

4. Click Next. 

    The Create a VCN with Internet Connection configuration dialog will be displayed, confirming all the values you just entered and listing additional components that will be created.

5. Click **Create** to start the workflow.

This will create a VCN with the following components:

    *VCN, Public subnet, Private subnet, Internet gateway (IG), NAT gateway (NAT), Service gateway (SG)*


6. After the workflow completes, click on **View Virtual Cloud Networks** and you will be directed to the details page of the VCN you created.

## Step 2: Create reserved Public IP

1. Open the OCI navigation menu. Under Core Infrastructure, go to Networking and click **IP Management**.

    Ensure that a compartment (or the compartment designated for you) is selected in the Compartment list on the left.

2. Click **Reserve Public IP Address**.

3. Enter the following (descriptions are italicized.):

    * RESERVED PUBLIC IP ADDRESS NAME: *Enter a name for your reserved IP address*
    * CREATE IN COMPARTMENT : *select the desired compartment*
    * IP Address Source in COMPARTMENT_NAME: *You do need to change/fill this field, unless your brought an IP Address Block*

4. You will see a list of the reseved IPs.


## Step 3: Assigning the reserved IP to a new instance

Create an Oracle Linux instance and assign the IP after its creation.

1. Open the navigation menu. Under Core Infrastructure, select go to **Compute** then **Instances**.

3. From the list of instances screen, click **Create Instance**.

4. Enter a name for the instance.

5. Select the compartment to create the instance in.

6. In the Configure placement and hardware section, make the following selections:

    - Availability domain Select the Availability domain that you want to create the instance in
    - Fault Domain Optional. Can be left unchecked
    - Image Latest Oracle Linux ( by default the latest supported version will be already selected)
    - Shape Select the desired shape

7. In the **Configure networking** section, make the following selections:

    - Network Select an existing virtual cloud network
    - Virtual cloud network in Choose the compartent that has the desired VCN
    - Network Select the Virtual Network Cloud Network
    - Subnet in Choose the compartent that has the desired VCN
    - Subnet Select a public subnet
    - Use network security groups to control traffic unchecked
    - Public IP Address |  *Do not assign a public IPv4 address*
    
8. In the **Add SSH keys** section:

    If you don't have an SSH key pair: 
    1. Select **Generate SSH key pair**.
    2. Click on **Save Private Key** and follow the browser propmpt to save the private key.
    3. Click on **Save Public Key** and follow the browser propmpt to save the public key.

    If you have a public key, you can:
    
    1. Select **Choose public key files**
    2. Drag and drop the public key files over or **Or browse to a location.**, find the location and select the files.

    or

    1. Select **Paste public keys**.
    2. Paste the Public Key Value into **SSH keys** (multiple keys can be added by clicking on **Anotehr key**).

9. In the **Configure boot volume**, leave all options unchecked.

10. Click **Create**. You will be taken to the instace details page. Wait until the instance's state change to running.
             
11. Under Resources (left side of the screen, click on **Attached VNICs**

12. Click on the VNIC name that has *(Primary VNIC)* after its name. You will be taken to the VNIC's details.

13. Under Resources (left side of the screen, click on **IP Addresses**. In the IP Addresses list, you will see the Private IP Address assigned to the VNIC and the Public IP Value as *(Not Assigned)* as you chose not to assign a public IP.

14. Click on the 3 dots icon (at the end of the line) and then select **Edit**

15. On the section **Public IP Type**, select **Reserved public IP**. A new section will be displayed. Enter the following:
    * SELECT EXISTING RESERVED IP ADDRESS: *Select this option*
    * RESERVED IP ADDRESS IN COMPARTMENT_NAME: *Chose the reserverd IP that you created earlier*

16. Click on the **Update** button. You will be taken back to the IP Adresses screen and you can see the Public Value populated with reserved IP value.


## Step 4: Unassign Reserved Public IP

1. Open the navigation menu. Under Core Infrastructure, select go to **Compute** then **Instances**.

2. Click on the name of the instance from the list of instances.

3. Under Resources (left side of the screen, click on **Attached VNICs**

4. Click on the VNIC name that has *(Primary VNIC)* after its name. You will be taken to the VNIC's details.
5. Under Resources (left side of the screen, click on **IP Addresses**. In the IP Addresses list, you will see the Private IP Address assigned to the VNIC and the Public IP Value with the reserved IP and *(Reserved)* aside it.

**Note**: If the instance had an ephemeral IP, it would have *(Ephemeral)* aside it. Ephemeral IPs can be unassigned too.

6. At the far right, click in the three dots ![](images/3dots.png " ") and then select **Edit**

7. On the section **Public IP Type**, select **NO PUBLIC IP**.

8. Click on the **Update** button. You will be taken back to the IP Adresses screen and you can see the Public Value populated with *(Not Assigned)* value.


## Step 5: Delete the resources

1. Open the navigation menu. Under Core Infrastructure, select **Instaces**. At the far right, click in the three dots ![](images/3dots.png " ") of the instance that will be deleted and select **Terminate**. Cehck the box **Permanently delete the attached boot volume** and click on **Terminate Instance**.


2. Open the navigation menu. Under Networking, select **Virtual Cloud Networks**. At the far right, click in the three dots ![](images-sandbox/3dots.png " ") of the VCN that will be deleted and select **Terminate**. Click on **Terminate** when prompted.

3. Open the navigation menu. Under Networking, select **IP Management**.Ubder resources , select **Public IPs**. You will be taken to the *Reserved Public IP Addresses*. At the far right, click in the three dots ![](images-sandbox/3dots.png " ") of Reserved IP that will be deleted. Click on **Terminate** when prompted.


*Congratulations! You have successfully completed the lab.*

## Acknowledgements

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - ORlando Gentil, March 2021

## Need Help?

Please submit feedback or ask for help by sending an email to livelabs-help-oci_us@oracle.com. Please make sure to include your workshop name and lab name. You can also include screenshots and attach files.