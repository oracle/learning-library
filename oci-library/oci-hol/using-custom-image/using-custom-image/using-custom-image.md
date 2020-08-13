# Creating Compute Instance using Custom Image

## Introduction

In this lab we will use Custom image feature of OCI. Using this feature an existing Compute instance with software packages and updates installed can be used to created additional compute instance.  These new compute instances will come with all the software packages and updates pre-installed.

## **Step 1**: Sign in to OCI Console and create VCN

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**.
    ![](./../grafana/images/Grafana_015.PNG " ")

2. From the OCI Services menu, Click **Virtual Cloud Networks** under Networking. Select the compartment assigned to you from the drop down menu on the left part of the screen under Networking and Click **Start VCN Wizard**.

    **NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

3. Click **VCN with Internet Connectivity** and click **Start VCN Wizard**.

4. Fill out the dialog box:

      - **VCN NAME**: Provide a name
      - **COMPARTMENT**: Ensure your compartment is selected
      - **VCN CIDR BLOCK**: Provide a CIDR block (10.0.0.0/16)
      - **PUBLIC SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.1.0/24)
      - **PRIVATE SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.2.0/24)
      - Click **Next**

5. Verify all the information and  Click **Create**.

6. This will create a VCN with the following components.

    *VCN, Public subnet, Private subnet, Internet gateway (IG), NAT gateway (NAT), Service gateway (SG)*

7. Click **View Virtual Cloud Network** to display your VCN details.

## **Step 2**: Create compute instance

1. Go to the OCI console. From OCI services menu, under **Compute**, click **Instances**.

2. Click **Create Instance**. Fill out the dialog box:

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

3. Click **Create**.

   **NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0011.PNG " ")

4.  Wait for Instance to be in **Running** state. In Cloud Shell Terminal, enter:

    ```
    <copy>cd .ssh</copy>
    ```
5.  Enter **ls** and verify your SSH key file exists.

6.  Enter command
    ```
    <copy>bash</copy>
    ```
    ```
    <copy>ssh -i <sshkeyname> opc@<PUBLIC_IP_OF_COMPUTE></copy>
    ```

    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command.

7.  Enter 'yes' when prompted for security message.

     ![](./../oci-quick-start/images/RESERVEDIP_HOL0014.PNG " ")

8.  Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

## **Step 3**: Install httpd on compute instance and create custom image

1. Switch to ssh session to compute install. Install httpd server, Enter Command:
    ```
    <copy>
    sudo yum -y install httpd
    </copy>
    ```

2. Start httpd, Enter command:
    ```
    <copy>
    sudo systemctl start httpd
    </copy>
    ```

3. Verify http status, Enter command:
    ```
    <copy>
    sudo service httpd status
    </copy>
    ```

4. We now have installed httpd server on a compute instance and will create a custom image. Switch back to OCI Console window.

5. From OCI services menu, Click **Instances** under **Compute**.

6. Click your compute instance name and Click **Stop**.
     ![](./../using-custom-image/images/Custom_Image_001.PNG " ")

7. Once Stopped, Click **Create Custom Image** from **Actions** menu
     ![](./../using-custom-image/images/Custom_Image_002.PNG " ")

8. Fill out the dialog box and Click **Create Custom Image**. VMs status will change to **Creating Image**.
     ![](./../using-custom-image/images/Custom_Image_003.PNG " ")


9.  Navigate to main Instances page under compute and Click **Custom Images**. Locate your custom image, Click the Action icon and then **Create Instance**.
     ![](./../using-custom-image/images/Custom_Image_004.PNG " ")


10. Fill out the dialog box and Click **Create**. Once the instance is in running state note down it's Public IP address.

11. ssh to compute instance as before and Enter command:
    ```
    <copy>
    sudo service httpd start
    </copy>
    ```

12. This will start httpd service, Check the status of httpd service as before.

You have successfully created a custom image with httpd already installed and used this custom image to launch a compute instance and started httpd service. In this new compute instance there was no need to re-install httpd server as it was already present when the custom image was created.

A compute instance can have a lot more applications installed and this custom image feature facilitates launching new compute instances with these applications pre-installed.


## **Step 4**: Delete the resources

1. Switch to  OCI console window.

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute.

3. Locate first compute instance, Click Action icon and then **Terminate**.
     ![](./../oci-quick-start/images/RESERVEDIP_HOL0016.PNG " ")

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate.
     ![](./../oci-quick-start/images/RESERVEDIP_HOL0017.PNG " ")

5. Repeat the step to delete second compute instance.

6. From OCI Servies Menu Click **Compute** then **Custom Images**. Locate the custom image you created. Click the Action icon and then **Delete**.

7. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will appear.

8. Locate your VCN , Click Action icon and then **Terminate**. Click **Terminate All** in the Confirmation window. Click **Close** once VCN is deleted.
     ![](./../oci-quick-start/images/RESERVEDIP_HOL0018.PNG " ")


## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Contributors** - Kamryn Vinson, QA Engineer Lead Intern | Arabella Yao, Product Manager Intern, DB Product Management
- **Last Updated By/Date** - Tom McGinn, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
