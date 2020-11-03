# Deploying Jenkins

## Introduction

Faster software development has become a competitive advantage for companies. The automation of software development processes facilitates speed and consistency, which led to the rise for having a Continuous Integration (CI) and Continuous Delivery and Deployment (CD) pipelines. Jenkins is a very popular product among Oracle Cloud Infrastructure customers, which can automate all of the phases of CI and CD. You can host Jenkins on Oracle Cloud Infrastructure to centralize your build automation and scale your deployment as the needs of your software projects grow.

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

### Prerequisites

1. Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment).
   
2. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)

3. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)

4. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)

5. [Familiarity with Compartment](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)

6. [Connecting to a compute instance](https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm)


## **Step 1:** Sign in to OCI Console and create VCN

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}

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
      - Click **Next**.

5. Verify all the information and  Click **Create**.

6. This will create a VCN with followig components.

    *VCN, Public subnet, Private subnet, Internet gateway (IG), NAT gateway (NAT), Service gateway (SG)*

7. Click **View Virtual Cloud Network** to display your VCN details.
                    
##  Step 2: Create Compute instance, configure OCI CLI and upload API keys

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL006.PNG " ")

2. Enter command 
   
    ```
    <copy>
    ssh-keygen
    </copy>
    ```
    **HINT:** You can swap between OCI window, git-bash sessions and any other application (Notepad, etc.) by Clicking the Switch Window icon. 

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
      - **Choose an operating system or image source**: Click **Change Image Source**. In the new window, Click **Oracle Images** Choose **Oracle Cloud Developer Image**. Scroll down, Accept the Agreement and Click **Select Image**.

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

12. Enter command: 
    
    ```
    <copy>
    bash
    ssh -i id_rsa opc@PUBLIC_IP_OF_COMPUTE
    </copy>
    ```
    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command.

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

17. Accept the default location. For user OCID switch to OCI Console window. Click Human Icon and then your user name. In the user details page Click **copy** to copy the OCID. **Also note down your region name as shown in OCI Console window**. Paste the OCID in ssh session.

    ![](./../deploying-oci-streaming-service/images/Stream_004.PNG " ")

18. Repeat the step to find tenancy OCID (Human icon followed by Clicking Tenancy Name). Paste the Tenancy OCID in ssh session to compute instance followe by providing your region name (us-ashburn-1, us-phoenix-1 etc).

19. When asked for **Do you want to generate a new RSA key pair?** answer Y. For the rest of the question accept default by pressing Enter.

    ![](./../deploying-oci-streaming-service/images/Stream_005.PNG " ")

20. **oci setup config** also generated an API key. We will need to upload this API key into our OCI account for authentication of API calls. Switch to ssh session to compute instance, to display the conent of API key Enter command :

    ```
    <copy>
    cat ~/.oci/oci_api_key_public.pem
    </copy>
    ```

21. Hightlight and copy the content from ssh session. Switch to OCI Console, Click Human icon followed by your user name. In user details page Click **Add Public Key**. In the dialg box paste the public key content and Click **Add**.

    ![](./../deploying-oci-streaming-service/images/Stream_006.PNG " ")

    ![](./../deploying-oci-streaming-service/images/Stream_007.PNG " ")

22. This will generate a finger print, Copy and save the finger print in notepad using built in application in the platform.

23. Switch back to ssh session to the compute instance and Enter command:

    ```
    <copy>
    cat ~/.oci/oci_api_key.pem
    </copy>
    ```

    Copy and save the content of the file. 

## **Step 3:** Install Jenkins, Configure Jenkins Master instance and create Jenkins Slave instance

1. Swtich to git bash widnow with ssh session to the compute instance, Enter commands: (Install Jenkins).

    ```
    <copy>
    sudo yum install java –y
    </copy>
    ```

    ```
    <copy>
    sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    </copy>
    ```

    ```
    <copy>
    sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
    </copy>
    ```

    ```
    <copy>
    sudo yum  install jenkins –y
    </copy>
    ```

    ```
    <copy>
    sudo service jenkins start  
    </copy> 
    ```
    **(Ok message should be displayed)**

    ![](./../deploying-jenkins/images/Jenkins_003.PNG " ")

    ```
    <copy>
    sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
    </copy>
    ```
    **(By default,Jenkins listens on port TCP 8080. Open this port on the instance firewall by configuring the firewall)**
        
    ```
    <copy>
    sudo firewall-cmd --reload
    </copy>
    ```

2.  To login to Jenkins master node we just set-up its password needs to be retrieved. Enter command:

    ```
    <copy>
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    </copy>
    ```
    Copy and paste the password to Notepad.

    ![](./../deploying-jenkins/images/Jenkins_004.PNG " ")

3. Now we need to open port 8080 in Firewall rule for the compute instance. Switch to OCI console window. 

4. From OCI Services menu, Click **Virtual Cloud Network** under Networking.

5. From OCI services menus Navigate to your VCN created earlier and Click your VCN name, Click **Security List** and then **Default Security list for`<YOUR_VCN_NAME>`.**
    ![](./../deploy-redis/images/Customer_Lab_001.PNG " ")

6. In Security list details page, Click **Add Ingress Rule** and enter the following ingress rule; Ensure to leave STATELESS flag un-checked

      - Source Type: CIDR 
      - Source CIDR: 0.0.0.0/0
      - IP Protocol: TCP
      - Source Port Range: All
      - Destination Port Range: 8080

7. Click **Add Ingress Rule**. 

8. Open a new browser tab. 

    ![](./../deploying-jenkins/images/Jenkins_008.PNG " ")

9. Enter the URL 
    http://`<PUBLIC_IP_OF_COMPUTE_INSTANCE>`:8080

10. In the ‘Unlock Jenkins’ Screen, under ‘Administrator password’, copy/paste the password retrieved using command:

    ```
    <copy>
    sudo cat  /var/lib/jenkins/secrets/initialAdminPassword
    </copy> 
    ```

    from computeinstance earlier (32 character password)

    ![](./../deploying-jenkins/images/Jenkins_009.PNG " ")

    ![](./../deploying-jenkins/images/Jenkins_010.PNG " ")

11. In ‘Customize Jenkins’ screen, Click **Install suggested plugins**. Wait for plugins installation  to complete.

    ![](./../deploying-jenkins/images/Jenkins_011.PNG " ")

    ![](./../deploying-jenkins/images/Jenkins_012.PNG " ")

12. In ‘Create First Admin User’ screen, Click **Continue as admin**.

    ![](./../deploying-jenkins/images/Jenkins_013.PNG " ")

13.  In ‘Instance Configuration’ screen, verify the correct IP (Public IP of compute instance) and port number is displayed. Click **Save and Finish**.

    ![](./../deploying-jenkins/images/Jenkins_014.PNG " ")

14. In ‘Jenkins is ready’ screen, Click **Start using Jenkins**.

    ![](./../deploying-jenkins/images/Jenkins_015.PNG " ")

15. In ‘Welcome to Jenkins’ screen, Click **Manage Jenkins**, Scroll down and Click **Manage Plugins**.

    ![](./../deploying-jenkins/images/Jenkins_017.PNG " ")

    ![](./../deploying-jenkins/images/Jenkins_018.PNG " ")

16. In Plugin Manager screen, Click **Available**, In the Filter search box type oracle. In the resulting list, check **Oracle Cloud Infrastructure Compute** and then Click **Install Without restart**.

    ![](./../deploying-jenkins/images/Jenkins_019.PNG " ")

17. Once installation is complete, scroll up and Click **Manage Jenkins**.

    ![](./../deploying-jenkins/images/Jenkins_020.PNG " ")

18. In Manage Jenkins screen, scroll down and Click **Manage Nodes and Clouds**. Click **Configure Clouds** in the left menu. 

    ![](./../deploying-jenkins/images/Jenkins_021.PNG " ")

    ![](./../deploying-jenkins/images/Jenkins_021b.PNG " ")

19. Click **Add a new cloud** dropdown. Select **Oracle Cloud Infrastructure Compute**. Insert a name. 

    - **Name:** Use easy to remember name (This is the slave node that will be created).
  
    ![](./../deploying-jenkins/images/Jenkins_022.PNG " ")

20.   Click **Add** dropdown. Select **Jenkins**. A new dialog box will appear.  

    ![](./../deploying-jenkins/images/Jenkins_022b.PNG " ")

21.   Click **Kind** dropdown. Select **Oracle Cloud Infrastructure Credentials**. Fill out the dialog box:

    ![](./../deploying-jenkins/images/Jenkins_022c.PNG " ")

      - **Fingerprint:** Copy/paste OCI\_api\_key\_fingerprint file content saved earlier
      - **APIKey:** Copy/paste OCI\_api\_key.pem file content saved earlier
      - **PassPhrase:** Leave empty
      - **Tenant Id:** Copy/Pare Tenant OCID saved earlier
      - **User Id:** Copy/Pare User OCID saved earlier
      - **Region:** Type your region Name (Shown in OCI console window, us-ashburn-1 etc)

22.  Click **Verify Credentials** and verify ‘Successful’ message. Click **Add**. We have now verified connectivityto OCI via the master Jenkins compute node. Next we will create a slave Jenkins node.

    ![](./../deploying-jenkins/images/Jenkins_023.PNG " ")

23. Click **Add a new instance template**. Fill out the dialog box:

    - **Instance Template Description**: Provide description (Jenkins-Slave etc)
    - **Usage**: Leave as is (use this node as much as possible)
    - **Label**: Provide label(Jenkins-Slave etc)
    - **Compartment**: Choose the compartment assigned to you from drop down
    - **VCN Compartment**: Choose your VCN compartment
    - **Availability Domain**: Choose the same Availability domain as the Compute instance created earlier
    - **Image Compartment**: Choose the compartment of your image
    - **Image**: Select latest Oracle Linux (Not anything with‘GPU’ in it)
    - **Shape**: Select a VM shape

    **NOTE:** If 'Service limit' error is displayed choose a different shape. 

    - **Virtual Cloud Network**: Select the VCN you created in the previous section
    - **Subnet**: Select the same subnet as the Compute instance created earlier
    - **Assign Public IP address**: Check this box
    - **Connect Agent using public IP**: Check this box
    - **SSH Public key**: Copy/Paste ssh public key generated earlier 9Id_rsa_user.pub)
    - **SSH Private key**: Copy/Paste ssh private key generated earlier (id\_rsa\_user)

    ![](./../deploying-jenkins/images/Jenkins_024.PNG " ")

    ![](./../deploying-jenkins/images/Jenkins_025.PNG " ")

24. Click **Verify SSH key pair** and confirm Successful message.

    ![](./../deploying-jenkins/images/Jenkins_026.PNG " ")

25. Click **Advanced**, Fill out the dialog box:

    - Remote FS Root: /tmp
    - Remote SSH User: opc
    - Instance Creation Timeout: 300
    - Instance SSH Connection Timeout: 30
    - Idle Termination Minutes: 30
    - Number of Executors: 1
    - Init Script: sudo yum install java –y
    - Init Script Timeout: 120

    ![](./../deploying-jenkins/images/Jenkins_027.PNG " ")

26. Click **Save** . Main Jenkins page will appear.

27. In main Jenkins web page, Click Build Executor Status (Left Navigation pan). Click **drop down menu (Under master node information section)** and choose the Newly saved template.(Jenkins-Slave in this case).

28. Verify ‘Started Provisioning’ message is displayed

    ![](./../deploying-jenkins/images/Jenkins_028.PNG " ")

29. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute**  Verify new compute node (Jenkins-Slave) is being provisioned.

30. Once compute instance is fully provisioned, switch back to Jenkins window and verify the new node appears on the screen. Click **Refresh Status** a few times to ensure Node is fully accessible (no next to it). You have now successfully deployed Jenkins with two compute nodes.

    ![](./../deploying-jenkins/images/Jenkins_030.PNG " ")

***We have now successfully deployed Jenkins master and slave nodes on OCI.*** 

## **Step 4:** Delete the resources

**NOTE:**  As a practice user will need to figure out any errors encountered during deletion of resources.

1. Switch to  OCI console window.

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute.

3. Locate first compute instance, Click Action icon and then **Terminate**. 

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0016.PNG " ")

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0017.PNG " ")

5. Repeat the steps to delete second compute instance.

6. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will appear.

7. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0018.PNG " ")

## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, June 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-cloud-infrastructure-fundamentals). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
