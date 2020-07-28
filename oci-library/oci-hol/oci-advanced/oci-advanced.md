# OCI Advanced (Configuring Virtual Cloud Network Peering)

## Introduction

Local VCN peering is the process of connecting two VCNs in the same region and tenancy so that their resources can communicate using private IP addresses without routing the traffic over the internet or through your on-premises network. Without peering, a given VCN would need an internet gateway and public IP addresses for the instances that need to communicate with another VCN

**Some Key points:**

*We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%.*

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

## Step 1: Sign in to OCI Console and create VCN


* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}


**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI.

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**.

    ![](./../grafana/images/Grafana_015.PNG " ")

2. From the OCI Services menu,Click **Virtual Cloud Networks** under Networking. Select the compartment assigned to you from drop down menu on left part of the screen under Networking and Click **Start VCN Wizard**.

    **NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list.

3. Fill out the dialog box:

      - **VCN NAME**: Provide a name
      - **COMPARTMENT**: Ensure your compartment is selected
      - **VCN CIDR BLOCK**: Provide a CIDR block (10.0.0.0/16)

4. Click **Create Virtual Cloud Network**.

5. Virtual Cloud Network will be created and VCN name will appear on OCI Console. Scroll down to find your VCN if multiple VCN exist, and Click your VCN name.

6. In VCN detials page,  Click **Internet Gateways** under Resources, and Click **Create Internet Gateway**. Fill out the dialog box. Click **Create Internet Gateway** (ensure correct compartment is selected).

    ![](./../oci-advanced/images/OCI_Advanced_002.PNG " ")

7. Click **Route tables**, and Click **Default Route Table for `<VCN_NAME>`**.

    ![](./../oci-advanced/images/OCI_Advanced_003.PNG " ")

8. Click **Add Route Rules**. Fill out the dialog box:

      - **Target Type**: Internet Gateway
      - **Destination CIDR Block**: 0.0.0.0/0
      - **Compartment**: Your Compartment.
      - **Target Internet Gateway**: Select the Internet Gateway created previously.

9. Click **Add Route Rules**.

10. Click **VCN** and then **Subnets** then **Create Subnet**. Fill out the dialog box:

    - **Name**: Enter a name (for example Management Peering subnet).
    - **Subnet Type**: Regional
    - **CIDR Block**: Enter 10.0.0.0/24
    - **Route Table**: Default Route Table.
    - **Subnet access**: Public Subnet.
    - **DHCP Options**: Select the default.
    - **Security Lists**: Default Security List

11. Leave all other options as default, Click **Create Subnet**.

    ![](./../oci-fundamentals-lab/images/OCI_Fundamentals_004.PNG " ")

12. Once the Subnet is in the ‘Available’ state, Click **Local Peering Gateways**, then **Create Local Peering Gateway** (local peering gateway  is a component on a VCN for routing traffic to a locally peered VCN). Fill out the dialog box:

    - **NAME**: Provide a Name 
    - **CREATE IN COMPARTMENT**: Select your compartment

13. Click **Create Local Peering Gateway**.

    ![](./../oci-advanced/images/OCI_Advanced_004.PNG " ")

14. Create a second VCN using steps above use CIDR block:

    -**CIDR BLOCK**: 10.10.0.0/16

15. Add Internet Gateway for Second VCN.

16. Add subnet for second VCN, use below data:

    - **Name**: Enter a name (for example Marketing Peering subnet)
    - **Subnet Type**: Regional
    - **CIDR Block**: Enter 10.10.0.0/24
    - **Route Table**: Default Route Table.
    - **Subnet access**: Public Subnet.
    - **DHCP Options**: Select the default.
    - **Security Lists**: Default Security List

17. Leave all other options as default, Click **Create Subnet**.

18. Add route table for second VCN. Click **Route Table**, then **Create Route Table**. Fill out the dialog box:

    - **Name**: Provide a Name
    - **Compartment**: Select your Compartment

    **CLick +Additional Route Rules**

    - **Target Type**: Internet Gateway 
    - **Destination CIDR Block**: 0.0.0.0/0
    - **Compartment**: Select Your Compartment
    - **Target Internet Gateway**: Select second VCN's internet gateway

19. Leave all other options as default, Click **Create Route Table**.

20. Create second Local peering gateway. Once the Subnet is in the ‘Available’ state, Click **Local Peering Gateways**, then **Create Local Peering Gateway** (local peering gateway  is a component on a VCN for routing traffic to a locally peered VCN). Fill out the dialog box:

    - **NAME**: Provide a Name 
    - **CREATE IN COMPARTMENT**: Select your compartment

**WE have created two VCN with internet gateway for internet traffic, added default rule in the route table, created subnet and added two local peering gateways(one for each VCN). For VCN peering each VCN must have a local peering gateway.**

## Step 2: Create ssh keys two compute instances and configure routing

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

5. In git-bash Enter command:  
    ```
    <copy>
    cat /C/Users/PhotonUser/.ssh/id_rsa.pub
    </copy>
    ```
    , highlight the key and copy 

    ![](./../oci-quick-start/images/RESERVEDIP_HOL009.PNG " ")

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup).

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0010.PNG " ")

7. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute**. 

8. Click **Create Instance**. Fill out the dialog box:

    **This is the first compute instance and ensure to create in the first VCN**. 

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

9. Click **Create**.

    **NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0011.PNG " ")

10. Repeate the steps to create a second compute instance in the **Second VCN**.

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

11. Click **Create**.

12. Once the instances are in running state, note down the public and private IP addresses of the two compute instances.

13. Configure **First local peering gateway**. Click **Local Peering gateway** in your VCN details page. Hover over the action icon (3 vertical dots) and Click **Establish Peering Connection**.

    ![](./../oci-advanced/images/OCI_Advanced_005.PNG " ")

14. Fill out the dialog box:

    - SPECIFY THE LOCAL PEERING GATEWAY: Browse below (To browse the list of available gateways)
    - VIRTUAL CLOUD NETWORK COMPARTMENT: Select your compartment
    - VIRTUAL CLOUD NETWORK: Choose the **second VCN** (Gateway1 needs to pair with Gateway2 that is in second VCN)
    - LOCAL PEERING GATEWAY COMPARTMENT: Choose the comprtment
    - UNPEERED PEER GATEWAY: Choose the second peering gateway

    ![](./../oci-advanced/images/OCI_Advanced_006.PNG " ")

15. Verify the Local Peering Gateway shows Status as Peered and Peered information is correct.

    ![](./../oci-advanced/images/OCI_Advanced_007.PNG " ")

16. We now need to configure Route tables and Security Lists for the two VCNs. Navigate to First VCN's details page and click **Route Tables**, then **Default Route table for `<FIRST_VCN_NAME>`**.

17. Click **Add route rule** and add the followig rule

    - Target Type: Select **Local Peering gateway**
    - Destination CIDR Block: Enter 10.10.0.0/24
    - Compartment:  Make sure the correct Compartment is selected: 
    - TARGET LOCAL PEERING GATEWAY: Select the Local peering Gateway of First VCN 

18. Click **Add Route Rule**.

    ![](./../oci-advanced/images/OCI_Advanced_009.PNG " ")

29. Navigate to you VCN details page, Click **Security Lists**, then **Default Security list for <FIRST_VCN_NAME>**. Click **Add Ingress Rule**.

20. Enter the following ingress rule; Ensure to leave STATELESS flag un-checked

    - Source CIDR: 10.10.0.0/24
    - IP Protocol: Select ICMP.
    - Source Port Range: All
    - Destination Port Range: All

    ![](./../oci-advanced/images/OCI_Advanced_008.PNG " ")

21. Click **Add Ingress Rule**. 

22. Repeat the steps for second VCN Route table and security list. Use below data:

    **Second VCN Route table**

    - Target Type: Select **Local Peering gateway**
    - Destination CIDR Block: Enter 10.0.0.0/24
    - Compartment:  Make sure the correct Compartment is selected: 
    - TARGET LOCAL PEERING GATEWAY: Select the Local peering Gateway of second VCN 

    **Second VCN Security list rule** (Navigate to Security List and Click **Add Ingress Rule**.)

23. Enter the following ingress rule; Ensure to leave STATELESS flag un-checked.

    - Source CIDR: 10.0.0.0/24
    - IP Protocol: Select ICMP.
    - Source Port Range: All
    - Destination Port Range: All

**We now have two VCNs with one compute instance in each VCN. These VCNs have been connected using a Local Peering Gateway. Any instance in one VCN can reach an instance in the other VCN. Next we will test the connectivity.**

## Step 3: ssh to compute instance and test VCN peering

1. In git bash window, Enter command:

    ```
    <copy>
    cd /C/Users/PhotonUser/.ssh
    </copy>
    ```

2. Enter **ls** and verify id\_rsa file exists.

3. Enter command 
    ```
    <copy>
    bash
    ssh -i id_rsa opc@PUBLIC_IP_OF_COMPUTE
    </copy>
    ```

    **We will ssh to the First compute instance**

    **NOTE:** User name is opc. This will enable port forwarding on local host which is needed to access Grafana dash board later on.

    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command.

1. Enter 'Yes' when prompted for security message.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0014.PNG " ")
 
2. Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

3. Enter command:

    ```
    <copy>
    bash
    ping <PRIVATE_IP_OF_SECOND_COMPUTE_INSTANCE>
    </copy>
    ```

    **NOTE:** Use Private IP of the compute instance that you are not connected to.

    **Verify the ping is successful**

    If ping is successful then we have successfuly created VCN peering across two different VCNs.


## Step 4: Delete the resources

1. Switch to  OCI console window.

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under **Compute**.

3. Locate compute instance, Click Action icon and then **Terminat**.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0016.PNG " ")

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0017.PNG " ")

5. Repeat the steps to delete the second compute instance.

6. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will appear.

7. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0018.PNG " ")

8. Repeate the step to delete the seond VCN.


## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 
