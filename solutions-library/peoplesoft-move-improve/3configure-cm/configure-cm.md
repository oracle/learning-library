# Configuring Cloud Manager Settings

## Introduction
This lab will guide you on how to configure the system and infrastructure settings on Cloud Manager

Estimated Lab Time: 15 minutes

### Objectives
The purpose of this lab is to show you how to configure Cloud Manager settings.

In this lab, you will:
* Upload SSH public key
* Update My Oracle Support Credentials
* Input the image OCID for the Cloud Manager
* Create a Mount Target for a File System

### Prerequisites
* Keys generated in Lab 1, Step 8


## **STEP 1**: Uploading SSH public key

1. Navigate to **Cloud Manager Dashboard** > **My Settings**.

    ![](./images/4.png "")

2. Navigate to the folder where you generated the keys (Lab 1, Step 8) and open the file **id_rsa.pub**.

    ![](./images/5.png "")

3. Copy the contents of the file in **My SSH Public Key** and click on **Save**

    ![](./images/6.png "")

## **STEP 2**: Updating Infrastructure Settings

Go back to the **Cloud Manager Dashboard** > **Cloud Manager Settings**. 
    ![](./images/cmhome.png "")
1.  Navigate to Infrastructure Settings on the left and update Operating System Images.     
    * For Linux, enable **Marketplace Image** radio button and choose the latest version from the displayed list. The OCID should populate automatically.

    * For Windows image, as per your home region, please select the OCID of the vanilla custom image from this [website](https://docs.oracle.com/en-us/iaas/images/image/943bdefa-8858-4b37-98e0-fd710c4aea1e/).

    For example, in this lab, we selected our Availability Domain to be us-ashburn-1 so our OCID is:    
    **ocid1.image.oc1.iad.aaaaaaaa74rl4tzxblzk2sqm43k62srh6bv4hbxkkewlbyar6ximerilowyq**
 
    ![](./images/newImage.png "")

2.	Click **Save** to save the configuration. 

3.	Click **Refresh OCI Metadata** button on top of the page and wait for a few minutes.

## **STEP 3**: Configuring File Server System

1.	Navigate to **File Server tab** on the left.  Accept the defaults. For Mount Target field, type “**lab**”.

    ![](./images/3.png "")

2.	Click **Create**.  This action will create a file server in a few minutes. Please wait until the file server status shows ‘**FSS Configured**' which you can see by clicking **More Info**, and then the system will be ready for downloads. 

You may now **proceed to the next lab.**

## Acknowledgments
* **Authors** - Megha Gajbhiye, Cloud Solutions Engineer; Sara Lipowsky, Cloud Engineer
* **Last Updated By/Date** - Sara Lipowsky, Cloud Engineer, May 2021

