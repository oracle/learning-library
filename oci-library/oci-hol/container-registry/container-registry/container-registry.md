# Create Docker registry in OCI

## Introduction

Oracle Cloud Infrastructure Registry is an Oracle-managed registry that enables you to simplify your development to production workflow. Oracle Cloud Infrastructure Registry makes it easy for you as a developer to store, share, and manage development artifacts like Docker images. And the highly available and scalable architecture of Oracle Cloud Infrastructure ensures you can reliably deploy your applications.

## **STEP 1**: Create VCN, Auth token and Docker Registry

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**.

   ![](images/Grafana_015.PNG " ")

2. From the OCI Services menu, click **Virtual Cloud Networks** under Networking. Select the compartment assigned to you from drop down menu on left part of the screen under Networking and Click **Start VCN Wizard**.

    **NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

3. Click **VCN with Internet Connectivity** and click **Start VCN Wizard**

4. Fill out the dialog box:

    - **VCN NAME**: Provide a name
    - **COMPARTMENT**: Ensure your compartment is selected
    - **VCN CIDR BLOCK**: Provide a CIDR block (10.0.0.0/16)
    - **PUBLIC SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.1.0/24)
    - **PRIVATE SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.2.0/24)
    - Click **Next**

5. Verify all the information and  Click **Create**

6. This will create a VCN with following components.

    *VCN, Public subnet, Private subnet, Internet gateway (IG), NAT gateway (NAT), Service gateway (SG)*

7. Click **View Virtual Cloud Network** to display your VCN details.

    *We will now create an Auth Token. This token will be used to login to connect to OCI Docker registry from the Docker compute instance that will be created later on*

8. In OCI console Click the user icon (top right)  then **User settings**. Under Resources Click **Auth Token**, then **Generate Token**. In pop up window provide a description then Click **Generate Token**

     ![](images/ADW_005.PNG " ")

     ![](images/ADW_006.PNG " ")

9.  Click **Copy** and save the token in Notepad.**Do not close the window without saving the token as it can not be retrieved later**

     ![](images/ADW_007.PNG " ")

10. From OCI Services menu, Select **Developer Services** -> **Container Registry**

     ![](images/OCIR_HOL0033.PNG " ")

11. Click **Create Repository**. Provide Repository name (all Lowercase), Check **Public** for **Access**, Click **Create Repository**

12.  Once created, verify there are no existing images in the repository (as shown in OCI console)

     ![](images/OCIR_HOL0034.PNG " ")

*We now have a Docker registry and Auth token (to validate login to the registry). Next we will create a Public/Private key pair and then compute instance to test pushing and pulling images from the registry.*

## **STEP 2**: Create a compute instance

1. Go to the OCI console. From OCI services menu, under **Compute**, click **Instances**.

2. Click **Create Instance**. Fill out the dialog box:

      - **Name your instance**: Enter a name
      - **Create in Compartment**: Choose the same compartment you used to create the VCN
      - **Choose an operating system or image source**: For the image, we recommend using the Latest Oracle Linux available.

3. Click **Show Shape, Network and Storage Options**:

      - **Availability Domain**: Select an availability domain (the default AD 1 is fine)
      - **Shape**: Click Change Shape

      ![](images/create-compute-1.png)

4. In the **Browse All Shapes** dialog:

      - **Instance Type**: Select Virtual Machine
      - **Shape Series**: Intel Lake
      - **Instance Shape**: Select VM.Standard2.1

      Click **Select Shape**.

      ![](images/create-compute-2.png)

5. Under Configure Networking:

      - **Virtual cloud network compartment**: Select your compartment
      - **Virtual cloud network**: Choose the VCN you created in Step 1
      - **Subnet Compartment:** Choose your compartment.
      - **Subnet:** Choose the Public Subnet under **Public Subnets**
      - **Use network security groups to control traffic** : Leave un-checked
      - **Assign a public IP address**: Check this option

      ![](images/create-compute-3.png)

6. Boot Volume and Add SSH Keys     

      - **Boot Volume:** Leave the default, uncheck values
      - **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key saved in Lab 1.

      ![](images/create-compute-4.png)

7. Click **Create**.

   **NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD

8.  Wait for Instance to be in **Running** state. In Cloud Shell Terminal, enter:

    ```
    <copy>cd ~/.ssh</copy>
    ```
9.  Enter **ls** and verify your SSH key file exists.

10.  SSH into your compute instance:
    ```
    <copy>ssh -i <sshkeyname> opc@<PUBLIC_IP_OF_COMPUTE></copy>
    ```

    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command.

11.  Enter 'yes' when prompted for security message, and enter your passphrase.

     ![](images/Custom_Image_0010.PNG " ")
     ![](images/Custom_Image_0011.PNG " ")

12.  Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

## **STEP 3**: Push images to the registry

1. Next install Docker:

    ```
    <copy>
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    </copy>
    ```

     ![](images/OCIR_HOL0035.PNG " ")

9.  Add a repo:

    ```
    <copy>
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    </copy>
    ```

10. Enter command:

    ```
    <copy>
    sudo yum install docker-ce –y
    </copy>
    ```
    (Wait for ‘Complete’ message)

11. Enable docker:

    ```
    <copy>
    sudo systemctl enable docker
    </copy>
    ```

12. Start docker:

    ```
    <copy>
    sudo systemctl start docker
    </copy>
    ```

13. Add user opc to Docker:

    ```
    <copy>
    sudo usermod -aG docker opc
    </copy>
    ```  

14. Docker is installed and user opc enabled to use Docker. Logout of the current SSH session:

    ```
    <copy>
    exit
    </copy>
    ```

15. SSH back in to the compute instance. Enter the command **docker images** and ensure no error is displayed:

    ```
    <copy>
    docker images
    </copy>
    ```

     ![](images/OCIR_HOL0036.PNG " ")

16. We will now pull a example image from Docker registry  to the compute instance. Enter Command:

    ```
    <copy>
    docker image pull alpine
    </copy>
    ```
    Verify image pull was successful, Enter Command
    ```
    <copy>
    docker images
    </copy>
    ```
    and verify alpine is present

     ![](images/OCIR_HOL0037.PNG " ")

17. Now we will push this image to Docker registry created in OCI. First login to Registry in OCI. Enter command:

    ```
    <copy>
    docker login <Region_Name_Code>.ocir.io
    </copy>
    ```

    **NOTE:** Region name code are, fra for Frankfurt, iad for Ashburn, lhr for London, phx for Phoenix.

    **HINT:** Your region is shown on top right corner of OCI console window

17. Find the Tenancy Namespace on the tenancy details page by clicking on the your login icon and selecting the tenancy link.

    ![](images/tenancy-namespace.png)

18. Provide the information:

    - Username:  Enter it in format Tenancy Namespace/User name (for example: TS-SPL-55/john.doe@gmail.com)
    - Password: Paste the Auth key saved earlier (The characters won't be visible)

     ![](images/docker-login.png)

18. Verify Login Succeeded message is displayed.

19. Next we will tag the image that we pulled from the web. Enter command:

    ```
    <copy>
    docker images
    </copy>
    ```
    and note down the image id of alpine. Create a tag:

    ```
    <copy>
    docker tag <image_id>  <Region_Name_Code>.ocir.io/<TenancyNamespace>/docker-test-image:version4.0.test
    </copy>
    ```

20. Verify the tag was created, Enter command:

    ```
    <copy>
    docker images
    </copy>
    ```
    and verify version<x.y>.test is present.

     ![](images/OCIR_HOL0039.PNG " ")

21. We will now push the image to docker registry in OCI. Enter command:

    ```
    <copy>
    docker push <Region_Name_Code>.ocir.io/<Tenancy_Namespace>/docker-test-image:version4.0.test
    </copy>
    ```

     ![](images/docker-push.png)

22. Switch to OCI window and navigate to your registry. Newly pushed image should be visible.

    **HINT:** Refresh the browser window if image is not displayed

    ![](images/oci-registry.png)

23. Switch to compute instance ssh window. Enter command:

    ```
    <copy>
    docker pull <Region_Name_Code>.ocir.io/<Tenancy_Namespace>/docker-test-image:version4.0.test  
    </copy>  
    ```

24. Verify the pull command was successful

     ![](images/docker-pull.png)

    **HINT:** We are pulling the same image that we just pushed.

*We now have a working Docker registry and can successfully push and pull images to/from it.*

## **STEP 4:** Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute

3. Locate first compute instance, Click Action icon and then **Terminate**

     ![](images/RESERVEDIP_HOL0016.PNG " ")

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

     ![](images/RESERVEDIP_HOL0017.PNG " ")

5. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will
appear.

6. Locate your VCN , Click Action icon and then **Terminate**. Click **Terminate All** in the Confirmation window. Click **Close** once VCN is deleted

     ![](images/RESERVEDIP_HOL0018.PNG " ")

7. Navigate to your registry(**Registry(OCIR)** under **Developer Services**), Click Registry Name, Under **Actions** Click **Delete Repository**  ,Click **Delete** in confirmation window

     ![](images/OCIR_HOL0042.PNG " ")


## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Contributors** - Kamryn Vinson, QA Specialist
- **Last Updated By/Date** - Tom McGinn, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
