# Deploying Infrastructure Using Terraform

## Introduction

Terraform is Infrastructure as Code tool for building and managing infrastructure efficiently and elegantly. In this lab we will use pre-configured terraform scripts to deploy VCN, Compute Instance, Block storage and attach the block storage to compute instance without using OCI console. We will then delete all these infrastructure resources.

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

    **Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI.

### Pre-Requisites

1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)

2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)

3. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)

4. [Familiarity with Compartment](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)

5. [Connecting to a compute instance](https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm)

## Step 1: Sign in to OCI Console and create a VCN

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}


1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**

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

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup).

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0010.PNG " ")

7. Switch to the OCI console. From OCI services menu, Click **Instances** under **Compute**. 

8. Click **Create Instance**. Fill out the dialog box:

       - **Name your instance**: Enter a name 
       - **Choose an operating system or image source**: Click **Change Image Source**. In the new window, Click **Oracle Images** Choose **Oracle Cloud Developer Image**. Scroll down, Accept the Agreement and Click **Select Image**
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
    ssh -i id_rsa opc@PUBLIC_IP_OF_COMPUTE
    </copy>
    ```
    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command.

13. Enter 'Yes' when prompted for security message.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0014.PNG " ")
 
14. Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

## Step 3: Configure OCI CLI Install Terraform Upload API keys and verify functionality

1. Check oci CLI installed version, Enter command:

    ```
    <copy>
    oci -v
    </copy>
    ```
    **NOTE:** Version should be minimum 2.5.X (3/23/2019)

    ![](./../oci-cli/images/100_CLI_001.png " ")

2. Next we will configure OCI CLI. Enter command:

    ```
    <copy>
    oci setup config
    </copy>
    ```

3. Accept the default location. For user OCI switch to OCI Console window. Click Human Icon and then your user name. In the user details page Click **copy** to copy the OCID. **Also note down your region name as shown in OCI Console window**. Paste the OCID in ssh session.

    ![](./../deploying-oci-streaming-service/images/Stream_004.PNG " ")

4. Repeat the step to find tenancy OCID (Human icon followed by Clicking Tenancy Name). Paste the Tenancy OCID in ssh session to compute instance followed by providing your region name (us-ashburn-1, us-phoneix-1 etc).

5. When asked for **Do you want to generate a new RSA key pair?** answer Y. For the rest of the question accept default by pressing Enter.

    ![](./../deploying-oci-streaming-service/images/Stream_005.PNG " ")

6. **oci setup config** also generated an API key. We will need to upload this API key into our OCI account for authentication of API calls. Switch to ssh session to compute instance, to display the conent of API key Enter command:

    ```
    <copy>
    cat ~/.oci/oci_api_key_public.pem
    </copy>
    ```

7. Hightligh and copy the content from ssh session. Switch to OCI Console, Click Human icon followed by your user name. In user details page Click **Add Public Key**. In the dialg box paste the public key content and Click **Add**.

    ![](./../deploying-oci-streaming-service/images/Stream_006.PNG " ")

    ![](./../deploying-oci-streaming-service/images/Stream_007.PNG " ")

8. Next, Download script to install Terraform, Enter command:

    ```
    <copy>
    sudo curl https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/oci-hol/infra-using-terraform/tf_setup.sh -o tf_setup.sh
    </copy>
    ```

    This will download a script file called **tf_setup.sh**.

9. Next modify the permission on the script and execute it, Enter Commands:

    ```
    <copy>
    sudo chmod 755 tf_setup.sh
    </copy>
    ```

    ```
    <copy>
    ./tf_setup.sh
    </copy>
    ```

    Press **Enter** when prompted

    ![](./../infra-using-terraform/images/Terraform_002.PNG " ")

10. The script will install needed packages and create a new directory **tflab**. We will need to modify some env variables in the file. Enter command:

    ```
    <copy>
    cd tflab
    </copy>
    ```

11. tf_setup.sh creates a example .tf called **tftest.tf**, this file needs to be removed as we will download another .tf file to create infrastructure. Enter command

    ```
    <copy>
    rm tftest.tf
    </copy>
    ```

12. Now edit the env-variables file. We will updated 2 variables. Enter command:

    ```
    <copy>
    vi env-vars
    </copy>
    ```

    **NOTE: You can use another editor such as nano as well**

    ![](./../infra-using-terraform/images/Terraform_003.PNG " ")

13. Update the TF\_VAR\_user\_ocid variable with User OCID saved earlier.

    ![](./../infra-using-terraform/images/Terraform_005.PNG " ")

14. Next Update the TF\_VAR\_Compartment\_ocid variable. Switch to OCI Console window, Click **Compartment** under **Identity**. Locate your compartment name and Click it. In the compartment details page , clik **copy** to copy the OCID.

    Paste this OCID in **env-vars** file.

    ![](./../infra-using-terraform/images/Terraform_006.PNG " ")

    ![](./../infra-using-terraform/images/Terraform_007.PNG " ")

15. After updating env-vars file the content will look like below;

    ![](./../infra-using-terraform/images/Terraform_008.PNG " ")

16. Save the file and then source it, Etner command:

    ```
    <copy>
    source env-vars
    </copy>
    ```

17. The enviornment is now set. Next we will download a terraform file (.tf) file that will be used to create VCN, Compute instnace, block volume and attach block volume to compute instance. We will download this file in **/home/opc** directory, Enter Command:

    ```
    <copy>
    cd /home/opc
    </copy>
    ```

    Enter Command: 

    ```
    <copy>
    sudo curl https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/oci-hol/infra-using-terraform/compute.tf -o compute.tf
    </copy>
    ```

18. Ensure you are in **/home/opc** directory. 

19. Now initialize terraform, Enter Command:

    ```
    <copy>
    terraform init
    </copy>
    ```

    Verify successful initialization.

20. To see the deloyment plan, Enter Command:

    ```
    <copy>
    terraform plan
    </copy>
    ```

    This will provide details on what will be configured in OCI.

21. Finally apply the plan to create the infrastructure, Enter Command:

    ```
    <copy>
    terraform apply
    </copy>
    ```

    **NOTE:** You must type **yes** when prompted.

22. This script will take some time to execute. You can switch to OCI console and observe creation of VCN, Compute instance, Block Volume and attachment of block volume to the compute instance.

23. Finally, destroy the infrastructure that we created. Enter Command:

    ```
    <copy>
    terraform destroy
    </copy>
    ```

    **NOTE:** You must type **yes** when prompted.

You can switch to OCI console and observe deletion of VCN, Compute instance, Block Volume.

## Step 4: Delete the resources

1. Switch to  OCI console window.

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under **Compute**.

3. Locate first compute instance, Click Action icon and then **Terminat**.

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

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 
