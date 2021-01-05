<!-- Not tested -->
# Create and Attach a Block Volume Service

## Introduction

The Oracle Cloud Infrastructure Block Volume service lets you dynamically provision and manage block storage volumes. You can create, attach, connect and move volumes as needed to meet your storage and application requirements. Once attached and connected to an instance, you can use a volume like a regular hard drive. Volumes can also be disconnected and attached to another instance without the loss of data.

This video provides an overview of creating and attaching Oracle Cloud Infrastructure Block Volumes:

[](youtube:kpL7czRCRLs)

### Prerequisites

- Oracle Cloud Infrastructure account credentials (User, Password, and Tenant)
- To sign in to the Console, you need the following:
  -  Tenant, User name and Password
  -  URL for the Console: [https://cloud.oracle.com/](https://cloud.oracle.com/)
  -  Oracle Cloud Infrastructure supports the latest versions of Google Chrome, Firefox and Internet Explorer 11

## **STEP 1**: Create a Block Volume

A common usage of Block Volume is adding storage capacity to an Oracle Cloud Infrastructure instance. Once you have launched an instance and set up your cloud network, you can create a block storage volume through the Console or API. Once created, you attach the volume to an instance using a volume attachment. Once attached, you connect to the volume from your instance's guest OS using iSCSI or paravirtualized mode. The volume can then be mounted and used by your instance.

1. Navigate to the Menu and click on **Block Storage**.

2. In Block Volume service, click on **Create Block Volume** and provide the following details:

     - **Name:** BV-DEMO
     - **Compartment:** Demo
     - **Availability Domain:** It must be the same as the AD you choose for your instance.
     - **Size**: Please choose **50 GB**.
     - **Backup Policy**: **Gold**

    **Note**: Must be between **50 GB** and **32 TB**. You can choose in 1 GB increments within this range. The default is 1024 GB)

     Quick recap on the block volume backup policies: There are three predefined backup policies, Bronze, Silver, and Gold Each backup policy has a set backup frequency and retention period.

    - **Bronze Policy:** The bronze policy includes monthly incremental backups, run on the first day of the month. These backups are retained for twelve months. This policy also includes a full backup, run yearly on January 1st. Full backups are retained for five years.

    - **Silver Policy:** The silver policy includes weekly incremental backups that run on Sunday. These backups are retained for four weeks. This policy also includes monthly incremental backups, run on the first day of the month and are retained for twelve months. Also includes a full backup, run yearly on January 1st. Full backups are retained for five years.

    - **Gold Policy**: The gold policy includes daily incremental backups. These backups are retained for seven days. This policy also includes weekly incremental backups that run on Sunday and are retained for four weeks. Also includes monthly incremental backups, run on the first day of the month, retained for twelve months, and a full backup, run yearly on January 1st. Full backups are retained for five years.

3. Leave the encryption and tags options as their default values and click on **Create Block Volume**. The volume will be ready to attach once its icon no longer lists it as **PROVISIONING** in the volume list.

   ![](images/Create1.png " ")
   ![](images/image002.png " ")
   ![](images/image003.png " ")

## **STEP 2**: Attaching a Block Volume to an instance

1. Once the Block Volume is created, you can attach it to the VM instance you just launched on Compute Practice. When you attach a block volume to a VM instance, you have two options for attachment type, iSCSI or paravirtualized.

    - **iSCSI:** iSCSI attachments are the only option when connecting block volumes to bare metal instances. Once the volume is attached, you need to log in to the instance and use the iscsiadm command-line tool to configure the iSCSI connection

     - **Paravirtualized** Paravirtualized attachments are now an option when attaching volumes to VM instances. For VM instances launched from Oracle-Provided Images, you can select this option for Linux-based images published. Once you attach a volume using the paravirtualized attachment type, it is ready to use, you do not need to run any additional commands. However, due to the overhead of virtualization, this reduces the maximum IOPS performance for larger block volumes, see [Paravirtualized Attachment Performance](https://docs.cloud.oracle.com/iaas/Content/Block/Concepts/blockvolumeperformance.htm#paraPerf) for more information.

2. Go to the Compute instance Menu, and navigate to the VM instance you created before and click on the **Attached Block Volumes** link.

    ![](images/attached1.png " ")

3. Click on the **Attach Block Volume** button.

4. Select the volume created from the drop down menu and choose the following options:

     - **Attachment mode:** iSCSI
     - **Block Volume:** Select the volume created
     - **Device Path:** Select `/dev/oracleoci/oraclevdb`
     - Click **Attach**

   ![](images/Attached2.png " ")

5. Once the volume is attached, you can click on the ellipsis and then click **iSCSI Command and Information link.**

    ![](images/image006.png " ")

6. Connect to the instance through SSH and **run the iSCSI ATTACH COMMANDS**.Click on **COPY** to copy all attach commands run all these commands by pasting it in the terminal:

    ![](images/iscsi-commands.png " ")
    ![](images/image008.png " ")

7. Once the disk is attached, you can run the following commands to format the disk and mount it.
     ```
     # <copy>ls -l /dev/oracleoci/oraclevd*</copy>
     ```
     ```
     # <copy>sudo mkfs -t ext4 /dev/oracleoci/oraclevdb</copy>
     Press y when prompted
     ```
     ```
     # <copy>sudo mkdir /mnt/disk1</copy>
     ```
     ```
     # <copy>sudo mount /dev/oracleoci/oraclevdb /mnt/disk1</copy>
     ```
     ```
     # <copy>df -h</copy>
     ```

    ![](images/format-mount.png " ")

    **Note** When mounting a storage volume for the first time, you can format the storage volume and create a single, primary partition that occupies the entire volume by using fdisk command (Caution: Using fdisk to format the disk deletes any data on the disk).

## Acknowledgements

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Tom McGinn, Database Product Management
- **Contributors** - Oracle LiveLabs QA Team (Kamryn Vinson, QA Intern, Arabella Yao, Product Manager Intern, DB Product Management)
- **Last Updated By/Date** - Tom McGinn, October 2020
