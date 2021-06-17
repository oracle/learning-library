# Underlying Infrastructure

![Requirements](images/requirements.png)

## Introduction

A **virtual private network** closely resembles a traditional network, with firewall rules and specific types of communication gateways that you can choose to use. A VCN resides in a single Oracle Cloud Infrastructure region and covers one or more CIDR blocks (IPv4 and IPv6, if enabled).

The Oracle Cloud Infrastructure Object Storage service is an internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. The Object Storage service can store an unlimited amount of unstructured data of any content type, including analytic data and rich content, like images and videos.

[](youtube:RHIfvO9aTQ0)

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will:

- Create Virtual Cloud Network.
- Create Bastion Host.
- Create Object Storage and upload files.

### Prerequisites

- Oracle Free Trial Account


## **STEP 1:** Create Virtual Cloud Network (VCN)

1. We are going to **create a network with a public subnet** (with access from the Internet) and a **private subnet** (no direct access from the Internet).

   This **network** layout is interesting to protect those services that don't need to be exposed to the Internet (living in the Private subnet) meanwhile other services and virtual machines with **direct access from the internet**, like Bastion hosts or Web Servers (living in the Public Subnet).

2. Go to **Menu** > **Networking** > **Virtual Cloud Networks**.

   ![VCN menu](images/vcn_menu.png)

   > Note: If you have not picked a compartment, pick the **root** compartment for this Lab.
   >
   > ![Pick Compartment](images/pick_compartment.png)

3. Click **Start VCN Wizard**.

   ![Start VCN Wizard](images/start_vcn_wizard.png)

4. Select **VCN with Internet Connectivity** and click **Start VCN Wizard**.

   ![VCN with Internet](images/vcn_with_internet_connectivity.png)

5. Change the **VCN name** and leave everything else as **default**.

      - VCN Name: `nature`

6. Click **Next**.

   ![VCN Name](images/vcn_name.png)

7. Review all the details and click **Create**.

   ![VCN Review](images/vcn_review.png)

   The creation process takes few seconds. Confirm everything is created (green tick on all resources) before you continue.

8. Click **View Virtual Cloud Network**.

   ![VCN Creation OK](images/vcn_create_ok.png)

9. Go to your new **Private Subnet-nature**.

   ![VCN Private Subnet](images/vcn_private_subnet.png)

10. Click **Security List for Private Subnet-nature**.

   ![VCN Security List](images/vcn_security_list.png)

   We need to open the ports for MySQL and MySQL X protocols: `3306` and `33060`.

11. Click **Add Ingress Rules** and fill the form with the following information:

   ![VCN Add Ingress Rule](images/vcn_add_ingress_rules.png)

   We are adding an **ingress rule** on those ports from the internal VCN CIDR `10.0.0.0/16`.

      - Source CIDR: `10.0.0.0/16`
      - Destination Port Range: `3306,33060`
      - Description: `MySQL and MySQL X Protocol`
      - Leave the rest of the fields with default values.

   And click **Add Ingress Rule** to confirm the values.

   ![VCN Ingress Rule MySQL](images/vcn_ingress_rule_mysql.png)

12. You can **confirm** the rules are added.

   ![VCN Security List Rules for MySQL](images/vcn_security_list_for_mysql.png)

## **STEP 2:** Create Bastion Host

1. We are going to **create a compute instance** in the Public Subnet with a public IP; it will be our access point to public and private resources.

2. Go to **Menu** > **Compute** > **Instances**.

   ![Compute Instance Menu](images/compute_instance_menu.png)

3. Click **Create Instance**.

   ![Create Intance Button](images/compute_create_instance_button.png)

4. Change the **name** to: `bastion`

   Make sure the rest of the **properties** are like the following:

      - Image: `Oracle Linux 7.9`
      - Shape for Always Free: `VM.Standard.E2.1.Micro`
      - Alternative Shape could be: `VM.Standard.E2.Flex, VM.Standard.E3.Flex, VM.Standard.E4.Flex`
      - Virtual cloud network: `nature`
      - Subnet: `Public Subnet-nature`
      - Assign a public IPv4 address: `Yes`

   ![Instance Values](images/compute_create_values.png)

5. On the section **Add SSH Keys**, make sure **Generate SSH Keypair** is checked.

6. Click **Save Private Key** and **Save Public Key**.

7. After the files are stored on your computer, click **Create**.

   ![Instance Values](images/compute_create_ssh.png)

   The **provisioning** takes few minutes.

   ![Compute Provisioning](images/compute_provisioning.png)

8. You can **copy** the assigned **Public IP** that we will use to SSH into the instance, also notice that the username is `opc`.

   Make sure the Icon turns **green**, and it says "RUNNING".

   ![Compute Provisioning](images/compute_public_ip.png)

   To avoid install tools on your local computer, we are going to use **Cloud Shell**. Cloud Shell is a small and **free Linux virtual machine** with a lot of DevOps tools preinstalled that Oracle Cloud offers.

9. Click on the **Cloud Shell** icon on the top-right menu bar.

   ![Cloud Shell](images/compute_cloud_shell.png)

   It will provision this small virtual machine, and you will have access to its terminal from the **Oracle Cloud Web Console**.

   ![Cloud Shell terminal](images/cloud_shell.png)

10. Click on the Cloud Shell **menu** icon and then in **Upload**.

   ![Cloud Shell terminal](images/cloud_shell_upload.png)

11. Click on **select from your computer**. And select the private key you downloaded for the compute instance.

   > Note: You don't need to upload the public key (`.pub` file), but feel free to do it.

   ![Cloud Shell terminal](images/cloud_shell_select_file.png)

12. After you Upload the file you can **Hide** the message.

   ![Cloud Shell terminal](images/cloud_shell_select_file_hide.png)

13. On **Cloud Shell terminal**, create `.ssh` folder for your SSH keys.

      ```
      <copy>mkdir -p .ssh</copy>
      ```

14. **Move** the key file to your `.ssh` folder with a different name, `bastion`.

      ```
      <copy>mv ssh-key-*.key .ssh/bastion</copy>
      ```

15. **Connect** with your bastion host with SSH. The `PUBLIC_IP` was copied when the bastion host was created.

      ```
      <copy>ssh -i ~/.ssh/bastion opc@PUBLIC_IP</copy>
      ```

16. To the question `Are you sure you want to continue connecting (yes/no/[fingerprint])?` type `yes` and ENTER.

   You will most likely get a `bad permissions` warning. Basically the permissions of the key are too open.

      ```
      Warning: Permanently added 'xxx.xxx.xxx.xxx' (ECDSA) to the list of known hosts.
      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      @         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      Permissions 0644 for '/home/it/.ssh/bastion' are too open.
      It is required that your private key files are NOT accessible by others.
      This private key will be ignored.
      Load key "/home/it/.ssh/bastion": bad permissions
      Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
      ```

17. Security first, let's fix the **permissions** to `600` with the following command:

      ```
      <copy>chmod 600 .ssh/bastion</copy>
      ```

18. **Connect** with SSH again (remember to replace `PUBLIC_IP` with your bastion host IP):

      ```
      <copy>ssh -i ~/.ssh/bastion opc@PUBLIC_IP</copy>
      ```

   This time you should be inside of the bastion host. This is the machine we will use to access MySQL Database Service that lives in a private subnet.

19. **Update** your Linux (it might take few minutes):

      ```bash
      <copy>sudo yum update -y</copy>
      ```

20. **Install** MYSQL Shell with the following commands:

      ```bash
      <copy>wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm</copy>
      ```

      ```
      <copy>sudo yum localinstall mysql80-community-release-el7-3.noarch.rpm</copy>
      ```

      ```
      <copy>sudo yum install mysql-shell mysql-community-client -y</copy>
      ```

21. Let's check the **version** of MySQL Shell:

      ```
      <copy>mysqlsh --version</copy>
      ```

## **STEP 3:** Create Object Storage and Upload Files

1. Go to **Menu** > **Storage** > **Buckets**.

   ![Object Storage Menu](images/os_menu.png)

2. Click **Create Bucket**.

   ![Create Bucket](images/os_create_bucket.png)

3. **Change** the bucket name, leave everything else by default.

      - Bucket Name: `bucket-study`

4. Click **Create**.

   ![Bucket Name](images/os_bucket_name.png)

5. Click on your **new** `bucket-study` bucket to see details.

   ![Create Bucket](images/os_bucket_study.png)

6. On the section **Objects**, click **Upload**.

   ![Create Bucket](images/os_object_upload.png)

7. **Download** the dataset <a href="https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/27PK5yRJp6ikvVdli-21D0vTwNywA0Q1aUPD2RQ7G8rtbPQwO2onh7TaZjfjawPj/n/odca/b/workshops-livelabs-do-not-delete/o/mds-di-ds-reef_life_survey_fish.csv" target="\_blank">Reef Life Survey Fish</a>.

8. Drop the file on **Choose Files from your Computer**. Leave everything else by default.

   ![Object Select File](images/os_object_select_file.png)

9. Click **Upload**.

   ![Object Upload Reef File](images/os_object_reef_upload.png)

10. Click **Close**.

   You will see the new file in the Objects list. Click on the three dots contextual menu.

   ![Object List with new File](images/os_file_uploaded.png)

11. On the contextual menu, select **View Object Details**.

   ![Object Details Menu](images/os_object_details_menu.png)

12. Take note of the URL you have. We will use it in the Lab number 3, Create Data Integration Instance.

   ![Object Details URL](images/os_object_details_url.png)

Congratulations! You are ready to go to the next Lab!

## **Acknowledgements**

- **Author** - Victor Martin, Technology Product Strategy Manager
- **Contributors** - Priscila Iruela
- **Last Updated By/Date** - Brianna Ambler, June 2021
