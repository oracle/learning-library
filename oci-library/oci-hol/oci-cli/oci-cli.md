#  Getting started with the OCI Command Line Interface (CLI)

## Introduction

Automation is a critical component when it comes to managing Cloud workloads at scale.  Although the OCI UI is user-friendly, many tasks may be repetitive and could further reduce an administrator's effort if they can be automated. The OCI Command Line Interface (CLI) is a toolkit developed in Python that is capable of performing almost any task that can be executed in the OCI UI.  The toolkit runs on Linux, Mac, and Windows, making it easy to write BASH or PowerShell scripts that perform a series of commands when executed.

This lab will walk you through installation and configuration of the CLI, along with the execution of several create, read, and terminate commands.  Upon completion of this lab you should have a good understanding of how to use the OCI CLI to automate common tasks in OCI.

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

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**.
    ![](./../grafana/images/Grafana_015.PNG " ")

2. From the OCI Services menu,Click **Virtual Cloud Networks** under Networking. Select the compartment assigned to you from drop down menu on left part of the screen under Networking and Click **Start VCN Wizard**

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
              
## Step 2: Create Compute instance, configure OCI CLI and upload API keys

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

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup)

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0010.PNG " ")

7. Switch to the OCI console. From OCI services menu, Click **Instances** under **Compute**.

8. Click **Create Instance**. Fill out the dialog box:

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
    ssh -i id_rsa opc@<PUBLIC_IP_OF_COMPUTE>
    </copy>
    ```

    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command.

13. Enter 'Yes' when prompted for security message.
     ![](./../oci-quick-start/images/RESERVEDIP_HOL0014.PNG " ")
 
14. Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

15. Check oci CLI installed version, Enter command:
   
    ```
    <copy>
    oci -v
    </copy>
    ```
    **NOTE:** Version should be minimum 2.5.X (3/23/2019)

     ![](./../oci-cli/images/100_CLI_001.png " ")

16. Next we will configure OCI CLI. Enter command:

    ```
    <copy>
    oci setup config
    </copy>
    ```

17. Accept the default location. For user OCI switch to OCI Console window. Click Human Icon and then your user name. In the user details page Click **copy** to copy the OCID. **Also note down your region name as shown in OCI Console window**. Paste the OCID in ssh session.
     ![](./../deploying-oci-streaming-service/images/Stream_004.PNG " ")

18. Repeat the step to find tenancy OCID (Human icon followed by Clicking Tenancy Name). Paste the Tenancy OCID in ssh session to compute instance followe by providing your region name (us-ashburn-1, us-phoneix-1 etc).

19. When asked for **Do you want to generate a new RSA key pair?** answer Y. For the rest of the question accept default by pressing Enter.
     ![](./../deploying-oci-streaming-service/images/Stream_005.PNG " ")

20. **oci setup config** also generated an API key. We will need to upload this API key into our OCI account for authentication of API calls. Switch to ssh session to compute instance, to display the conent of API key Enter command:

    ```
    <copy>
    cat ~/.oci/oci_api_key_public.pem
    </copy>
    ```

21. Hightligh and copy the content from ssh session. Switch to OCI Console, Click Human icon followe by your user name. In user details page Click **Add Public Key**. In the dialg box paste the public key content and Click **Add**.

     ![](./../deploying-oci-streaming-service/images/Stream_006.PNG " ")

     ![](./../deploying-oci-streaming-service/images/Stream_007.PNG " ")

We will now test the functionality of the CLI.

## Step 3: Testing the CLI, Create another VCN with one public subnet

1. In the SSH terminal session, type the following command:

    ```
    <copy>
    oci iam availability-domain list
    </copy>
    ```

    This will list all availability domains in the current region.  Make note of one of the availability domain names.  It should look something like this ``nESu:PHX-AD-3``.  You will use this in a future step.

     ![](./../oci-cli/images/100_CLI_001.png " ")

2. Return to the OCI Console and navigate to Identity -> Compartments.  Retrieve the OCID of the assigned compartment.

3. Enter the following command to list VCN's:
    
    ```
    <copy>
    bash
    oci network vcn list --compartment-id <your compartment id>
    </copy>
    ```

      ![](./../oci-cli/images/100_CLI_003.png " ")

    **NOTE:** It should return the details of the VCN you created at the start of this lab.  If you encounter an error message, please contact the instructor.

    **TIP:** You can create an environment variable for your compartment ID to avoid having to paste it each time.

    ```
    <copy>
    bash
    export cid=<your compartment ocid>
    oci network vcn list --compartment-id $cid
    </copy>
    ```

4. Create a new virtual cloud network with a unique CIDR block.  You will need the OCID of your compartment.

    ```
    <copy>
    bash
    oci network vcn create --cidr-block 192.168.0.0/16 -c <your compartment OCID> --display-name CLI-Demo-VCN --dns-label clidemovcn
    </copy>
    ```
    Record the ``id:`` of the resource after it is created.  You will need it in the upcoming steps.

5. Create a new security list.

    ```
    oci network security-list create --display-name PubSub1 --vcn-id <your VCN OCID> -c $cid --egress-security-rules  '[{"destination": "0.0.0.0/0", "destination-type": "CIDR_BLOCK", "protocol": "all", "isStateless": false}]' --ingress-security-rules '[{"source": "0.0.0.0/0", "source-type": "CIDR_BLOCK", "protocol": 6, "isStateless": false, "tcp-options": {"destination-port-range": {"max": 80, "min": 80}}}]'
    ```
    Make a note of the resource ``id:`` for use in the next step.

6. Create a public subnet.
    ```
    <copy>
    bash
    oci network subnet create --cidr-block 192.168.10.0/24 -c <your compartment OCID> --vcn-id <your VCN OCID> --security-list-ids '["<security list OCID from previous step>"]'
    </copy>
    ```
    Record the ``id:`` of the resources after it is created.  You will need it in an upcoming step.

    **Note:** You have the option to specify up to 5 security lists and a custom route table.  In this case, we are only assigning one security list and allowing the system to automatically associate the default route table.

7. Create an Internet Gateway.  You will need the OCID of your VCN and Compartment.
    ```
    <copy>
    bash
    oci network internet-gateway create -c <your compartment OCID> --is-enabled true --vcn-id <your VCN OCID> --display-name DemoIGW
    </copy>
    ```
    Make a note of the ``id:`` for this resource after it has been created.

8. Next, we will update the default route table with a route to the internet gateway.  First, you will need to locate the OCID of the default route table.

    ```
    <copy>
    bash
    oci network route-table list -c <your compartment OCID> --vcn-id <your VCN OCID>
    </copy>
    ```
     ![](./../oci-cli/images/100_CLI_004.png " ")

    record the ``id:`` of the `Default Route Table`

9. Update the route table with a route to the internet gateway.
    
    ```
    <copy>
    bash
    oci network route-table update --rt-id <route table OCID> --route-rules '[{"cidrBlock":"0.0.0.0/0","networkEntityId":"<your Internet Gateway OCID>"}]'
    </copy>
    ```

     ![](./../oci-cli/images/100_CLI_004.png " ")

    **Note:** When updating route tables or security lists you cannot insert a single rule.  You must ``update`` with the entire set of rules.  The prompt shown in the screenshot above illustrates this point.

    **Use QUERY to find Oracle Linux Image ID, then launch a compute instance**

10. Use the CLI ``query`` command to retrieve the OCID for the latest Oracle Linux image.  Make a note of the image ID for future use.

    ```
    <copy>
    bash
    oci compute image list --compartment-id <your compartment OCID> --query 'data[?contains("display-name",`Oracle-Linux-7.6-20`)]|[0:1].["display-name",id]'
    </copy>
    ```

    You may find more information on the Query command [here](https://docs.cloud.oracle.com/iaas/Content/API/SDKDocs/cliusing.htm#ManagingCLIInputandOutput).

11. Launch a compute instance with the following command.  We previously created a regional subnet because our command did not include a specific availability domain. For compute instances, we must specify an availability domain and subnet.

    You will need the following pieces of information:

    - Availability domain name
    - Subnet OCID
    - Valid compute shape (i.e. VM.Standard.E2.1)
    - Your public SSH key

    ```
    <copy>
    bash
    oci compute instance launch --availability-domain <your AD name> --display-name demo-instance --image-id <ID from previous step> --subnet-id <subnet OCID> --shape VM.Standard.E2.1 --compartment-id <Compartment_ID> --assign-public-ip true --metadata '{"ssh_authorized_keys": "<your public ssh key here>"}'
    </copy>
    ```

    Capture the ``id:`` of the compute instance launch output.

12. Check the status of the instances

    ```
    <copy>
    bash
    oci compute instance get --instance-id <the instance OCID> --query 'data."lifecycle-state"'
    </copy>
    ```

13. Rerun the command every 30-60 seconds until the lifecycle-state is ``RUNNING``

    ***This completes the exercise for basic usage of the OCI CLI.***

    **Bonus Exercise: Use the CLI to create the rest of the VCN resources**

    This section is optional and does not contain detailed instructions.  Instead, there are a series of objectives that you will complete on your own.  Use the [OCI CLI](https://docs.cloud.oracle.com/iaas/tools/oci-cli/latest/oci_cli_docs/index.html) reference documentation for guidance.

14. Locate the public IP address of the instance using the CLI.

    ```
    <copy>
    bash
    oci compute instance list-vnics --instance-id <instance OCID> | grep "ip.:"
    </copy>
    ```

15. Attempt to connect via SSH.  Does it work? (hint: it should time out)

16. Use the CLI to create an ingress rule for SSH traffic in your custom security list.  Don't forget the ``oci network security-list update`` command requires you to pass all current and new rules.  If you just pass one rule, it will overwrite the existing rules.

17. Connect via SSH now.  Is it working?

18. Create and attach a 50GB block volume to your instance.

19. Terminate / destroy all of the resources you created in this lab.  Hint: the order in which you delete the resources is very important.

20. Delete the Block volume, then compute instance and then VCN. Example command to delete VCN

    ```
    <copy>
    bash
    oci network vcn delete --vcn-id <YOUR_VCN_OCID>
    </copy>  
    ```
## Step 4: Delete the resources

1. Switch to  OCI console window.

2. If your Compute instance is not displayed, From OCI services menu Click **Instances** under **Compute**.

3. Locate first compute instance, Click Action icon and then **Terminate**.

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

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request. 

