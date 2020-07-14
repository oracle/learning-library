# Provision the Database System on OCI

In this lab you will provision a Database system on OCI to act as the standby database in the cloud. You will create a different VCN in different region from the on-premise database, and provision a DBCS in that VCN. 

## Lab Prerequisites

This lab assumes you have already completed the following labs:

- Register for Free Tier
- Create SSH Keys

## Step 1: Create the VCN

1. Open the navigation menu. Under **Core Infrastructure**, go to **Networking** and click **Virtual Cloud Networks**.

   ![](./images/image-20200505123858663.png " ")

2. Click **Start VCN Wizard**.

   ![](./images/image-20200505124016137.png " ")

3. Select **VCN with Internet Connectivity**, and then click **Start Workflow**. 

   ![](./images/image-20200505124118072.png " ")

4. Enter a unique VCN Name and following value:

    - VCN CIDR BLOCK: 10.0.0.0/16
    - Public Subnet CIDR Block: 10.0.0.0/24
    - Private Subnet CIDR Block: 10.0.1.0/24

    ![](./images/image-20200130161029651.png " ")

5. Click **Next**, review the VCN and click **Create**.

6. In the VCN detail page, click **Security Lists** under Resources, then click the **Default Security List** link.

   ![](./images/image-20200505124535018.png " ")

7. Click **Add Ingress Rules**.

   ![](./images/image-20200505124752217.png " ")

8. Add an Ingress Rule to allow TCP traffic for port 1521, 

   ![](./images/image-20200505124937347.png " ")



## Step 2: Create the DB system

1. Open the navigation menu. Under **Database**, click **Bare Metal, VM, and Exadata**.

2. Click **Create DB System**.

3. On the **Create DB System** page, provide the basic information for the DB system:

    - **Select a compartment:** use the compartment which assign to you.
    - **Name your DB system:** enter a unique name of your DB system
    - **Select an availability domain:** The **availability domain** in which the DB system resides.
    - **Select a shape type:** Choose **Virtual Machine**
    - **Select a shape:** change the Shape to **VM.Stanard2.2**

    ![](./images/image-20200130175456611.png " ")

   

4. In the **Configure the DB system** section, specify the following:

    - **Total node count:** 1
    - **Oracle Database software edition:** choose **Enterprise Extreme Performance**.
    - **Storage Management Software:**  choose the storage management software according to your requirements. You will do a different **Lab 7** based on your choice. Select **Oracle Grid Infrastructure** to use Oracle Automatic Storage Management (recommended for production workloads). Select **Logical Volume Manager** to quickly provision your DB system using Logical Volume Manager storage management software.  ASM takes about 60 minutes, and LVM takes about 30 minutes.

    ![](./images/image-20200505123551616.png " ")

    - Accept the default storage.
    - Upload the public SSH Keys file which you create in Lab2.

    ![](./images/image-20200130180431669.png " ")

    - License type: choose **Bring Your Own License**.
    - Choose the VCN you created before and choose the **Public Subnet**, enter the Hostname prefix.

    ![](./images/image-20200130180737270.png " ")

    - click **Next**

5. In the **Database Information** page, Specify the following:

    - **Database name:** **ORCL**, same as the on premise database
    - Check the Display all available versions box, select the Database version: 19.7.0.0. same version as the on premise database
    - PDB name: orclpdb

    ![](./images/image-20200130181300472.png " ")

    - Enter a strong password
    - Workload type: OLTP

    ![](./images/image-20200130181651405.png " ")

    - Click the **Create DB System**.

6. If you choose ASM as the storage manage, wait about 60 minutes. If you choose LVM as the storage manage, wait about 15 minutes. Then the Database is ready.

   ![](./images/image-20200130200100992.png " ")

7. Write down your Database Unique Name ie:`ORCL_nrt1d4`.
8. Click the **Nodes**,  write down the public ip address of the database host node and the Host Domain Name.

   ![](./images/image-20200130200337237.png " ")

You have completed the Database Cloud provisioning steps.  It will be used as your standby database.