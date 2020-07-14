# Deploying OCI Streaming Service

## Introduction

In this lab we will create a compute instance, download a script to configure streaming service, publish and consume messages.The Oracle Cloud Infrastructure Streaming service provides a fully managed, scalable, and durable storage solution for ingesting continuous, high-volume streams of data that you can consume and process in real time. Streaming can be used for messaging, ingesting high-volume data such as application logs, operational telemetry, web Click-stream data, or other use cases in which data is produced and processed continually and sequentially in a publish-subscribe messaging model.

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
             
## Step 2: Create ssh keys and compute instance

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

7. Switch to the OCI console. From OCI services menu, Click **Instances** under **Compute**. 

8. Click Create Instance. Fill out the dialog box:

      - **Name your instance**: Enter a name 
      - **Choose an operating system or image source**: Click **Change Image Source**. In the new window, Click **Oracle Images** Choose **Oracle Cloud Developer Image**. Scroll down, Accept the Agreement and Click **Select Image**

        ![](./../deploying-oci-streaming-service/images/Stream_009.PNG " ")

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
    ssh -i id_rsa opc@`<PUBLIC_IP_OF_COMPUTE>`
    </copy>
    ```

    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command.

13. Enter 'Yes' when prompted for security message.
     ![](./../oci-quick-start/images/RESERVEDIP_HOL0014.PNG " ")
 
14. Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

## Step 3: Download Script to configure Streaming service and Publish messages

1. In ssh session to compute instance, configure OCI CLI, Enter command:
    ```
    <copy>
    oci setup config
    </copy>
    ```

2. Accept the default directory location. For user's OCID switch to OCI Console window. Click Human Icon and then your user name. In the user details page Click **copy** to copy the OCID. **Also note down your region name as shown in OCI Console window**. Paste the OCID in ssh session.
     ![](./../deploying-oci-streaming-service/images/Stream_004.PNG " ")

3. Repeat the step to find tenancy OCID (Human icon followed by Clicking Tenancy Name). Paste the Tenancy OCID in ssh session to compute instance followe by providing your region name (us-ashburn-1, us-phoenix-1 etc).

4. When asked for **Do you want to generate a new RSA key pair?** answer Y. For the rest of the question accept default by pressing Enter.
     ![](./../deploying-oci-streaming-service/images/Stream_005.PNG " ")

5. **oci setup config** also generated an API key. We will need to upload this API key into our OCI account for authentication of API calls. Switch to ssh session to compute instance, to display the conent of API key Enter command:

    ```
    <copy>
    cat ~/.oci/oci_api_key_public.pem
    </copy>
    ```

6. Hightligh and copy the content from ssh session. Switch to OCI Console, Click Human icon followed by your user name. In user details page Click **Add Public Key**. In the dialg box paste the public key content and Click **Add**.

     ![](./../deploying-oci-streaming-service/images/Stream_006.PNG " ")

     ![](./../deploying-oci-streaming-service/images/Stream_007.PNG " ")

7. Download and Install pip utility which will be used to install additional software. Enter command:

    ```
    <copy>
    sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    </copy>
    ```

    followed by

    ```
    <copy>
    sudo python get-pip.py
    </copy>
    ```

8. Install a virtual enviornement. This is being done so we have a clean environment to execute our python script that will create and publish messages to OCI streaming service. Enter command:

    ```
    <copy>
    sudo pip install virtualenv
    </copy>
    ```

9. Now create a virtual environment, Enter command:

    ```
    <copy>
    bash
    virtualenv <Environment_Name>
    </copy>
    ```
    For example **virtualenv stream\_env**.

    Now initialize the virtual enviornment, Enter command:

    **NOTE** : Below command assumes that the enviornment name is 'stream-env'

    ```
    <copy>
    cd /home/opc/stream_env/bin
    </copy>
    ```

    ```
    <copy>
    source ~/stream_env/bin/activate
    </copy>
    ```

10. Once your virtual environment is active, oci can be installed using pip, Enter command:

    ```
    <copy>
    pip install oci
    </copy>
    ```

     ![](./../deploying-oci-streaming-service/images/Stream_008.PNG " ")

11. Now download the main script file though first we will remove the existing file, Enter Command:

    ```
    <copy>
    cd /home/opc
    </copy>
    ```

    ```
    <copy>
    rm stream_example.py
    </copy>
    ```

    ```
    <copy>
    wget https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/oci-hol/deploying-oci-streaming-service/files/stream_example.py
    </copy>
    ```

12. Now download a dependent script file though first we will remove the existing file, Enter Command:

    ```
    <copy>
    cd /home/opc/stream_env/lib/python2.7/site-packages/oci/streaming/
    </copy>
    ```

    ```
    <copy>
    rm stream_admin_client_composite_operations.py
    </copy>
    ```

    ```
    <copy>
    wget https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/oci-hol/deploying-oci-streaming-service/files/stream_admin_client_composite_operations.py
    </copy>
    ```

13. Our setup is now ready. Before running the script switch to OCI Console window, from the main menu Click **Compartments** under **Identity**. Click your compartment name and copy the OCID of the compartment. (Just as was done for user OCID earlier).

14. Switch to ssh session and run the script, Enter command:

    ```
    <copy>
    bash
    python ~/stream_example.py <COMPARTMENT_OCID>
    </copy>
    ```

    For example : 

    python ~/stream\_example.py ocid1.compartment.oc1..aaaaaaaada2gaukcqoagqoshxq2pyt6cdsj2mhnrz3p5nke33ljx2bp476wq

15. Follow the prompts of the script. The script will create Streaming service called **SdkExampleStream**. It will publish 100 messages, create 2 groups on the compute and read those messages. Finally it will delete the streaming service. **You will be prompted to hit enter after verifying each step**.

## Step 4: Delete the resources

1. Switch to OCI console window.

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under **Compute**.

3. Locate compute instance, Click Action icon and then **Terminate**.

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0016.PNG " ")

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate.

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0017.PNG " ")

5. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will appear.

6. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted.
     ![](./../oci-quick-start/images/RESERVEDIP_HOL0018.PNG " ")


## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request. 

