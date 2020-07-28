# Visualizing and monitoring compute instance using Grafana

## Introduction

Grafana is an open source visualization tool that can be used on top of a variety of different data stores

Essentially, it’s a feature-rich replacement for Graphite-web, which helps users to easily create and edit dashboards. It contains a unique Graphite target parser that enables easy metric and function editing. Users can create comprehensive charts with smart axis formats (such as lines and points) as a result of Grafana’s fast, client-side rendering — even over long ranges of time — that uses Flot as a default option.

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

    **Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI.

### Pre-Requisites

1. Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

2. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)

3. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)

4. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)

5. [Familiarity with Compartment](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)

6. [Connecting to a compute instance](https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm)

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

3. Click **VCN with Internet Connectivity** and click **Start Workflow**.

4. Fill out the dialog box:

      - **VCN NAME**: Provide a name
      - **COMPARTMENT**: Ensure your compartment is selected
      - **VCN CIDR BLOCK**: Provide a CIDR block (10.0.0.0/16)
      - **PUBLIC SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.1.0/24)
      - **PRIVATE SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.2.0/24)
      - Click **Next**

5. Verify all the information and  Click **Create**.

6. This will create a VCN with followig components.

    *VCN, Public subnet, Private subnet, Internet gateway (IG), NAT gateway (NAT), Service gateway (SG)*

7. Click **View Virtual Cloud Network** to display your VCN details.
             
## Step 2: Create ssh keys, compute instance

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

    /C/Users/ PhotonUser/.ssh/id_rsa (Private Key)

    /C/Users/PhotonUser/.ssh/id_rsa.pub (Public Key)

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

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup).
    ![](./../oci-quick-start/images/RESERVEDIP_HOL0010.PNG " ")

7. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute**.

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

9. Click **Create**.

    **NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0011.PNG " ")

10. Wait for Instance to be in **Running** state. In git-bash Enter Command:

    ```
    <copy>
    cd /C/Users/PhotonUser/.ssh
    </copy>
    ```
11. Enter **ls** and verify id\_rsa file exists.

12. Enter command 
    
    ```
    <copy>
    bash
    ssh -i id_rsa opc@<PUBLIC_IP_OF_COMPUTE> -L 3000:localhost:3000
    </copy>
    ```
    **NOTE:** User name is opc. This will enable port forwarding on local host which is needed to access Grafana dash board later on.

    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command.

13. Enter 'Yes' when prompted for security message.
    ![](./../oci-quick-start/images/RESERVEDIP_HOL0014.PNG " ")
 
14. Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

## Step 3: Install Grafana and stress tool on compute instance

As part of preperation for this lab, a dynamic group and IAM policy was created. This configuration enables Grafana based monitoring on the compute instance. Below 2 policy statements are already configured though for any new deployment they must be configured under IAM Policy.

**allow group `<GROUP_NAME>` to read metrics in tenancy**

**allow group `<GROUP_NAME>` to read compartments in tenancy**

1. Switch to ssh session to compute install. Install Grafana, Enter Command:

    ```
    <copy>
    sudo yum install https://dl.grafana.com/oss/release/grafana-5.4.2-1.x86_64.rpm -y
    </copy>
    ```

    ![](./../grafana/images/Grafana_001.PNG " ")

2. Install OCI Plugin, Enter Command:

    ```
    <copy>
    sudo grafana-cli plugins install oci-datasource
    </copy>
    ```

    ![](./../grafana/images/Grafana_002.PNG " ")

3. We now need to set execute permission on one of the files, Enter command:

    ```
    <copy>
    sudo chmod 555 /var/lib/grafana/plugins/oci-datasource/dist/oci-plugin_linux_amd64
    </copy>
    ```

4. Start Grafana server, Enter Command: 

    ```     
    <copy>       
    sudo systemctl start grafana-server
    </copy>
    ```

5. Now we will login to Grafana Console, Open a new Broswer tab and enter URL http://localhost:3000 , You should see grafana console.

    **NOTE: You can use your OCI compute instance Public IP instead of 'localhot' as well**

    User name and password are 'admin' 

    ![](./../grafana/images/Grafana_003.PNG " ")

6. Once logged in you will be asked to change the password or skip the step, Click **skip** so the user name and password stays as admin.
    ![](./../grafana/images/Grafana_004.PNG " ")

7. On the Home Dashboard Click the gear icon on the left side of the page and Click **Add data source**.
    ![](./../grafana/images/Grafana_005.PNG " ")

8. Choose **Oracle Cloud Infrastructure** as your data source type.
    ![](./../grafana/images/Grafana_006.PNG " ")

9. In the next screen you will be asked for some details of your OCI account. To get **Tenancy OCID** switch to OCI console window.

10. Click the Human icon on top right corner and then your tenacy name.
    ![](./../grafana/images/Grafana_007.PNG " ")

11. Click **copy** next to **OCID**. Also note down your region.
    ![](./../grafana/images/Grafana_008.PNG " ")

12. Switch to Grafana tab and paste the OCID in **Tenancy OCID**. Choose your region for **Default Region**
Choose **OCI Instance** for Enviornment.
    ![](./../grafana/images/Grafana_009.PNG " ")

13. Click **Save & Test** and verify **Data source is working** message is displayed.
    ![](./../grafana/images/Grafana_010.PNG " ")

14. Click **+** sign and then **Dashboard** to create a new dash board. Click **Graph**.
    ![](./../grafana/images/Grafana_011.PNG " ")

15. Click **Panel Title** and then **Edit** to add metrics to the dashboard.
    ![](./../grafana/images/Grafana_012.PNG " ")

16. Choose the appropriate fields;

    - Region: Choose your region
    - Compartment: Choose your compartment
    - Namespace: oci_computeagent
    - Metric: CpuUtilization

17. Click **Add Query** to add a second Query

     - Compartment: Choose your compartment
     - Namespace: oci\_computeagent
     - Metric: MemoryUtilization

    ![](./../grafana/images/Grafana_013.PNG " ")

18. Save the dashboard by clicking the save icon (disk icon). 

19. Switch to ssh session to compute instance and install tool called **stress**. We will use this tool to stress the CPU and Memory of the compute instance. Enter Command:
    
    ```
    <copy>
    sudo yum install stress
    </copy>
    ```

20. Now generate traffic, Enter Command:

    ```
    <copy>
    sudo stress --cpu 5 --io 12 --vm 5 --vm-bytes 256M --timeout 600s
    </copy>
    ```
We now have  completed our setup with a compute instance and installed and executed a tool to stress the CPU and Memory. Next we will monitor  Grafana dash board for this compute instance.

## Step 4: Adjust Parameters in Grafana dashboard

1. Switch to Grafana dash board, you should observe the CPU utilization and Memory utilization grpah changing. You can adjust parameters such as Time period and refresh rate as shown below.
    ![](./../grafana/images/Grafana_014.PNG " ")

We have now completed Grafana setup and can monitor the utilization of parameters on the compute instance. Next we will delete the resources we created.

## Step 5: Delete the resources

1. Switch to  OCI console window.

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under **Compute**.

3. Locate compute instance, Click Action icon and then **Terminate**.
    ![](./../oci-quick-start/images/RESERVEDIP_HOL0016.PNG " ")

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate.
    ![](./../oci-quick-start/images/RESERVEDIP_HOL0017.PNG " ")

5. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

6. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted.
    ![](./../oci-quick-start/images/RESERVEDIP_HOL0018.PNG " ")


## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 

