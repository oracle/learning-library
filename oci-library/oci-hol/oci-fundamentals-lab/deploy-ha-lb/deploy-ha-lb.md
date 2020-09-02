# Deploy HA Application using Load Balancers

## Introduction

In this lab you will deploy web servers on two compute instances in Oracle Cloud Infrastructure (OCI), configured in High Availability mode by using a Load Balancer. 

Estimated time: 1 hour

### OCI Load Balancing Service

The Load Balancing Service provides automated traffic distribution from one entry point to multiple servers within your Virtual Cloud Network (VCN). The service offers a public load balancer with a public IP address, provisioned bandwidth, and high availability. The Load Balancing Service provisions the public IP address across two subnets within a VCN to ensure accessibility even during an Availability Domain outage.

### Objectives
- Create a Virtual Cloud Network (VCN)
- Create an OCI Compute Instance
- Modify VCN
- Create Load Balancer

### Prerequisites
Lab 1: Login to Oracle Cloud

Lab 2: Create SSH Keys - Cloud Shell

### Recommended Resources

1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)
2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
3. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
4. [Familiarity with Compartments](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)
5. [Connecting to a compute instance](https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm)

## **Step 1**: Create a Virtual Cloud Network

1. From the OCI Services menu, click **Virtual Cloud Networks** under **Networking**. Select the compartment assigned to you from the drop down menu on the left side of the screen(you may need to scroll down to see the dropdown) and Click **Start VCN Wizard**.

    ![](../images/HAApplication_001.png " ")

    *NOTE: Ensure the correct Compartment is selected under COMPARTMENT list*

2. Choose **VCN with Internet Connectivity** and click **Start VCN Wizard**.

    ![](../images/HAApplication_002.png " ")

3. Fill out the dialog box:

    - **VCN Name**: Provide a name
    - **Compartment**: Ensure your compartment is selected
    - **VCN CIDR Block**: Provide a CIDR block (10.0.0.0/16)
    - **Public Subnet CIDR Block**: Provide a CIDR block (10.0.1.0/24)
    - **Private Subnet CIDR Block**: Provide a CIDR block (10.0.2.0/24)
    - Click **Next**

    ![](../images/HAApplication_003.png " ")

    ![](../images/HAApplication_004.png " ")

4. Verify all the information and  Click **Create**.

    ![](../images/HAApplication_005.png " ")

5. This will create a VCN with the following components.

    * VCN
    * Public subnet
    * Private subnet
    * Internet gateway (IG)
    * NAT gateway (NAT)
    * Service gateway (SG)

6. Click **View Virtual Cloud Network** to display your VCN details.
              
    ![](../images/HAApplication_006.png " ")

    ![](../images/HAApplication_007.png " ")
              
## **Step 2**: Create two compute instances and install web server

1. Switch to the OCI console. From OCI services menu, Click **Instances** under **Compute**.

    ![](../images/HAApplication_008.png " ")

2. Click **Create Instance**. Enter a name for your workshop and the compartment you used earlier to create your VCN. Select **Show Shape, Network and Storage Options**.

    ![](../images/HAApplication_009.png " ")

    ![](../images/HAApplication_010.png " ")

    Leave **Image or Operating System** and **Availability Domain** as the default values.

    Scroll down to **Shape** and click **Change Shape**.

    ![](../images/HAApplication_013.png " ")

    Select **Virtual Machine** and **VM.Standar2.1**. Click **Select Shape**.

    ![](../images/HAApplication_014.png " ")

    Scroll down to the section labeled **Configure Networking** select the following.

    - **Virtual Cloud Network Compartment**: Choose the compartment you created your VCN in
    - **Virtual Cloud Network**: Choose the VCN you created in step 1
    - **Subnet Compartment:** Choose the compartment you created your VCN in
    - **Subnet:** Choose the Public Subnet under **Public Subnets**(it should be named `Public Subnet-NameOfVCN`)
    - **Use Network Security Groups to Control Traffic** : Leave un-checked
    - **Assign a Public IP Address**: Check this option

    ![](../images/HAApplication_011.png " ")

    - **Boot Volume:** Leave the default
    - **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key you created in Cloud Shell earlier. 
    
    *Ensure when you are pasting that you paste one line*

    ![](../images/HAApplication_012.png " ")

3. Click **Create**.

    *NOTE: If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD.*

4.  Repeat steps 1 - 3 to launch a second Compute instance.

5.  Wait for both instances to have the **Running** status. Note down the Public IP of both instances. You will need these later.

    ![](../images/HAApplication_015.png " ")

6.  Launch the Cloud Shell if it is not running.  When running, enter the command below:

    ```
    <copy>
    cd .ssh
    </copy>
    ```
7.  Enter **ls** and verify your key file exists.

    ```
    <copy>
    ls
    </copy>
    ```

8.  Ssh to  the **first** compute instance. Enter the following command replacing SSH-KEY-NAME with the name of your ssh key and replacing PUBLIC-IP-OF-COMPUTE1 with the IP addres of the first compute instance you created.

    *Note: Your SSH-KEY-NAME name should NOT end in .pub*
            
    ```
    <copy>
    ssh -i SSH-KEY-NAME opc@PUBLIC-IP-OF-COMPUTE-1
    </copy>
    ```
    *Note: User name is "opc".*

    *Note: If a "Permission denied error" is seen, ensure you are using '-i' in the ssh command. Also make sure that you correctly copied the name of your ssh key and the public IP of your compute instance.*

9.  Enter 'Yes' when prompted for security message.

    ![](../images/HAApplication_016.png " ")
 
10. Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

    ![](../images/HAApplication_017.png " ")

11. Open up a second tab of Oracle Cloud.  Launch a second cloud shell window using the steps above and connect via SSH into the second Compute instance (repeating steps 6-9). In step 8 remember to use the IP address of the second Compute instance in the SSH command. Verify the name of your second compute system is visible on the prompt.

    ![](../images/HAApplication_018.png " ")

12. Go back to the 1st tab cloud shell for the first Compute instance and install a Web server, using the commands below.

    Install Apache HTTP Server
    ```
    <copy>
    sudo yum -y install httpd </copy>
    
    ```

    Open port 80 on the firewall to allow http and https traffic
    ```
    <copy>
    sudo firewall-cmd --permanent  --add-port=80/tcp 
    </copy>
    ```
    *NOTE: --add-port flag has no spaces.*

    Reload the firewall to activate the rules
    ```
    <copy>
    sudo firewall-cmd --reload 
    </copy>
    ```

    Start the web server
    ```
    <copy>
    sudo systemctl start httpd 
    </copy>
    ```

    Change user privilege
    ```
    <copy>
    sudo su 
    </copy>
    ```

    create index.html file. The content of the file will be displayed later when the web server is accessed.
    ```
    <copy>
    echo 'WebServer1' >>/var/www/html/index.html 
    </copy>
    ```

    ![](../images/HAApplication_019.png " ")

13. Bring up the SSH session for the second Compute instance and repeat commands:

    Install Apache HTTP Server
    ```
    <copy>
    sudo yum -y install httpd
    </copy>
    ```

    Open port 80 on the firewall to allow http and https traffic
    ```
    <copy>
    sudo firewall-cmd --permanent  --add-port=80/tcp 
    </copy>
    ```
    *NOTE: --add-port flag has no spaces.*

    Reload the firewall to activate the rules
    ```
    <copy>
    sudo firewall-cmd --reload 
    </copy>
    ```

    Start the web server
    ```
    <copy>
    sudo systemctl start httpd 
    </copy>
    ```

    Change user privilege
    ```
    <copy>
    sudo su 
    </copy>
    ```

    Create index.html file. The content of the file will be displayed later when the web server is accessed.
    ```
    <copy>
    echo 'WebServer2' >>/var/www/html/index.html 
    </copy>
    ```

    ![](../images/HAApplication_020.png " ")

14. Switch back to OCI Console window.

We now have two compute instances with web servers installed and a basis index.html file. Before we create the load balancer we will need to create a new security list, route table and subnet that the load balancer will use.

Load balancers should always reside in different subnets than your application instances. This allows you to keep your application instances secured in private subnets, while allowing public internet traffic to the load balancers in the public subnets.

## **Step 3**: Create Security List Route table and additional subnet

In this section we will create a new security list. This security list will be used by the load balancer (that will be created later on). This will ensure all traffic to the two web servers is routed properly. 

1. From OCI Services menu, Click **Virtual Cloud Network** under **Networking**. This displays the list of VCNs in current compartment.

    ![](../images/HAApplication_001.png " ")

    *Note: If there are multiple Networks, scroll down to locate the one you just created.*

2. Click your VCN name, then **Security Lists** and then **Create Security List** (You will be creating a new security list).

    ![](../images/HAApplication_021.png " ")

    ![](../images/HAApplication_022.png " ")

    - **Name**: Specify a name (for example, LB Security List).
    - **Create in Compartment**: Select the compartment assigned to you (if not already selected).
    - Click **Create Security List** 

    ![](../images/HAApplication_023.png " ")

3. Verify the New Security List got created.

    ![](../images/HAApplication_024.png " ")

    We now have a Security List that will be used by the load balancer. Next we will create a Route table that will be used by two new subnets (that will be used by the load balancer, once created).

4. Click **Route Tables** (You will be creating a new route table), then **Create Route Table**. Fill out the dialog box:

    ![](../images/HAApplication_025.png " ")

    - **Name**: Enter a name (for example, LB Route Table).
    - **Create in Compartment**: This field defaults to your current compartment. Make sure you select the correct compartment.

    **Click +Additional Route Rules**

    ![](../images/HAApplication_026.png " ")

    - **Target Type**: Select **Internet Gateway** 
    - **Destination CIDR Block**: 0.0.0.0/0 
    - **Compartment**: Make sure the correct Compartment is selected
    - **Target Internet Gateway**: Select the Internet Gateway for your VCN. The gateway should have your VCN name in it.

    ![](../images/HAApplication_027.png " ")

5. Click **Create Route Table**.

    ![](../images/HAApplication_028.png " ")

6. Ensure the new route table appears in the list (Under Create Route Table).

    We now have a route table that allows all traffic. Next we will attach this route table to two new subnets that we will create (This subnet will be used by the Load Balancer).

    ![](../images/HAApplication_029.png " ")

7. Click **Subnets** and then click **Create Subnet**.

    ![](../images/HAApplication_030.png " ")

    Fill out the dialog box:
    - **Name**: Enter a name (for example, LB-Subnet-1).
    - **Subnet Type**: Regional

     **(When using a regional subnet, OCI selects two AD's. If you would like to control which two AD's are used, you would want to create individual AD-specific subnets)**

    - **CIDR Block**: Enter 10.0.4.0/24 
    - **Route Table**: Select the Route Table you created earlier.
    - **Subnet access**: select Public Subnet.
    - **DHCP Options**: Select the default.
    - **Security Lists**: Select the Security List you created earlier.

    Leave all other options as default, Click **Create Subnet**.

    ![](../images/HAApplication_031.png " ")

    ![](../images/HAApplication_032.png " ")

8. Ensure the new subnet appears in the list (under Create Subnet).

    ![](../images/HAApplication_033.png " ")

## **Step 4**: Create Load Balancer and update Security List

When you create a load balancer, you choose its shape (size) and you specify subnet (created earlier) from different Availability Domains. This ensures that the load balancer is highly available and is only active in one subnet at a time.

1. From OCI Services menu, click **Load Balancers** under **Networking**.

    ![](../images/HAApplication_034.png " ")

2. Click **Create Load Balancer**. Fill out the dialog box.

    ![](../images/HAApplication_035.png " ")

    **Add Details**

    - **Load Balancer Name**: Enter a name for your load balancer. (example HAA-LoadBalancer)
    - **Choose Visibility Type**: Public
    - **Choose Total Bandwidth**: Small, 100Mbps. (This specifies the bandwidth of the load balancer.)
        - *Note: Shape cannot be changed later.*
    - **Virtual Cloud Network**: Choose your Virtual Cloud Network
    - **Subnet**: Choose the Regional Subnet we created (10.0.4.0 in this lab) 

    ![](../images/HAApplication_036.png " ")

    Click **Next**.

    **Choose Backends:**

    - **Specify a Load Balancing Policy**: Weighted Round Robin
    - Click **Add Backend** and choose the two backend compute instance created earlier

    Click **Add Selected Backends**.

    ![](../images/HAApplication_037.png " ")

    **Specify Health Check Policy**

    - **Protocol**: HTTP
    - **Port**: Enter 80 
    - **URL Path (URI)**: /

    *Note: Leave other options as default*

    ![](../images/HAApplication_038.png " ")

    Click **Next**.

    **Configure Listener**

    - **Specify the Type of Traffic Your Listener Handles**: HTTP
    - **Specify the Port Your Listener Monitors for Ingress Traffic**: 80

    *Note: Leave other options as default.*

    ![](../images/HAApplication_039.png " ")

3. Click **Submit**.

4. From the OCI Services menu, click **Virtual Cloud Network** under **Networking**. Locate the VCN you created.

5. Click  VCN name to display the VCN detail page.

6. Click **Security Lists**, and click the Load Balancer Security List created earlier.

    ![](../images/HAApplication_041.png " ")

7. Click **Add Ingress Rule**. Enter the following ingress rule.

    ![](../images/HAApplication_042.png " ")

    - **Stateless**: un-checked
    - **Source Type**: CIDR 
    - **Source CIDR**: Enter 0.0.0.0/0.
    - **IP Protocol**: Select TCP.
    - **Source Port Range**: All.
    - **Destination Port Range**: Enter 80 (the listener port).

8. Click **Add Ingress Rule**.

    ![](../images/HAApplication_043.png " ")

9. Click **Egress Rule** under Resources. Click **Add Egress Rule**. Enter the following Egress rule.

    ![](../images/HAApplication_044.png " ")

    - **Stateless**: un-checked
    - **Destination Type**: CIDR
    - **Destination CIDR**: 0.0.0.0/0
    - **IP Protocol**: Select TCP.
    - **Destination Port Range**: All.

10. Click **Add Egress Rule**.

    ![](../images/HAApplication_045.png " ")

11. Click the name of your VCN in the top right.

    ![](../images/HAApplication_046.png " ")

12. Click **Security Lists**, and then click Default Security List of the VCN Click 

    ![](../images/HAApplication_047.png " ")

13. **Add Ingress Rule**.

    **First Rule**
    - **Stateless**: un-checked
    - **Source Type**: CIDR
    - **Source CIDR**: 10.0.4.0/24
    - **IP Protocol**: Select TCP.
    - **Source Port Range**: All
    - **Destination Port Range**: 80

14. Click **+Additional Ingress Rule** and enter the following Ingress rule; Ensure to leave the **STATELESS** flag un-checked.

    **Second Rule**
    - **Stateless**: un-checked
    - **Source Type**: CIDR
    - **Source CIDR**: 10.0.5.0/24
    - **IP Protocol**: Select TCP
    - **Destination Port Range**: 80

    ![](../images/HAApplication_048.png " ")

15. Click **Add Ingress Rule**.

We now have the set-up configured with 2 compute instances running an http server with an index.html file and load balancer with all relevant policies and components.

We will now test the load balancer functionality (load balance using round robin). In case one of the http server in high availability configuration is un-available, the load balancer will automatically route the traffic to an available http server.

*Note: Be sure to take note of the "Health" field in the Networking > Load Balancers dashboard. If the health is "Critical," the load balancer may not work as intended, and the best course of action may be to create a new one. This is likely the result of something being mis-configured, and it should only happen rarely.*

## **Step 5**: Verify High Availability of HTTP Servers

In this section we will access the two Web servers configured earlier using the load balancer’s public IP address and demonstrate the load balancer’s ability to route traffic on round robin basis(per the policy configured). In case one of the web server becomes un-available the web content will be available via the second server (high availability).

1. From the OCI Services menu, click **Load Balancers** under **Networking**.

    ![](../images/HAApplication_034.png " ")

2. Click your Load Balancer.

3. Copy your IP from the load balancer.

    ![](../images/HAApplication_040.png " ")

4. Open a web browser and enter the load balancer's public IP address. 

5. Verify that the webpage shows text. Depending on the server either `WebServer1` or `WebServer2` will be displayed.

6. Refresh the browser multiple times and observe the load balancer balancing traffic between the 2 web servers(you should see the text change).

    ![](../../oci-fundamentals-lab/images/OCI_Fundamentals_009.PNG " ")
             
    *Note: In case one of the server goes down the Application will be accessible via the load balancer’s public IP address.*

This Lab is not intended to test failover and recovery of backend servers. User can test that functionality at your own discretion. Any trouble shooting in case any issue is encountered is out of scope of this lab.

##  **Step 6**: Delete the resources

Delete Load Balancer and associated components:

1. From the OCI Services menu, click **Load Balancers** under **Networking**.

    ![](../images/HAApplication_034.png " ")

2. Select your load balancer and click **Terminate**.

    ![](../images/HAApplication_050.png " ")

3. Click **Terminate** in the confirmation window. Wait for the load balancer to fully delete. The load balancer page will no longer show your load balancer.

4. From the OCI Services menu, click **Instances** under **Computing**.

    ![](../images/HAApplication_008.png " ")

5. Locate the first compute instance you created. Click the action icon and then select **Terminate**. 

    ![](../images/HAApplication_051.png " ")

6. Make sure **Permanently Delete the Attached Boot Volume** is checked. Then click **Terminate Instance**. Wait for the instance to fully Terminate.

    ![](../images/HAApplication_052.png " ")

7. Repeat steps 5-6 to delete the second compute intance. The status of both instances should be **Terminated**.

    ![](../images/HAApplication_053.png " ")

8. From the OCI Services menu, click **Virtual Cloud Networks** under **Networking**.The list of all VCNs will appear.

    ![](../images/HAApplication_001.png " ")

9. Locate your VCN, click the action icon and then click **Terminate**. Click **Terminate All** in the confirmation window. Wait for the termination to complete then click **Close**.

    ![](../images/HAApplication_054.png " ")

    ![](../images/HAApplication_055.png " ")

Congratulations! You have successfully completed the lab.

## **Acknowledgements**

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
- **Last Updated By/Date** - Kay Malcolm, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 

