# Migrating on-premises workload to OCVS

## Introduction

In this lab, we will import the on-premises VMWare environment that we had exported in Lab 2 to OCVS. 

## Objectives
1. Import an ovf file and access the environment as part of the Oracle Cloud VMWare Service.

## Prerequisites
1. Access to the object storage bucket used to store the exported workload in Lab 2.
2. The deployed OCVS environment from Lab 1.

## STEP 1: Import the osCommerce OVF into Oracle Cloud VMware Service

1. Use the RDP client to connect to the bastion host. Using the pre-authenticated request URL from Lab 2, download the zipped ovf file. Unzip to extract the 3 ovf files on your computer.

    ![](./images/300_1.png " ")

2.  Now, login to the vSphere client of your OCVS platform and enter the credentials. You can get the vCenter server details from your OCVS page.

    ![](./images/300_2.png " ")
    
3. Once logged into the vSphere Client, right click on **Workload** and select **Deploy OVF Template**.

    ![](./images/300_14.png " ")

    ![](./images/300_15.png " ")
    
4. Select the .ovf and VMDK file from the unzipped folder.

    ![](./images/300_5.png " ")

5. Enter a name and select a location for your VM. Also, select a compute resource. Review the details.

    ![](./images/300_6.png " ")

    ![](./images/300_7.png " ")
    
    ![](./images/300_8.png " ")

6. Now, select the storage. After doing so, choose the Workload network on the next screen.

    ![](./images/300_9.png " ")

    ![](./images/300_10.png " ")

7. Click on **Finish** to complete the deployment.

    ![](./images/300_11.png " ")

**Note**: You can monitor the progress of the import from the panel bar at the bottom of the screen, under the **Recent Tasks** tab.

![](./images/300_16.png " ")

8. Once the import OVF and deploy OVF tasks are complete, you can power on the VM. Select the VM that you just imported and power it on by clicking on **Actions**, then selecting **Power On** under the Power sub-menu. Again, the status of the operation can be monitored from the **Recent Tasks** tab.

    ![](./images/300_17.png " ")

    ![](./images/300_18.png " ")

9. Launch the web console by clicking on the link just below the VM's thumbnail. Choose **Web Console** and click on **OK**. 

    ![](./images/300_19.png " ")

    ![](./images/300_20.png " ")
    
10. Login to the VM using the password 'oscommerce'. Then, open Firefox, enter **localhost/catalog/index.php**, and check for the oscommerce index page.

     ![](./images/300_13.png " ")

## STEP 2: Enable Internet on the VM

1. The VM does not have DNS settings. To add the DNS server click the network icon in the top right corner and click on **Edit Connections**

    ![](./images/300_21.png " ")

2. Open the **Wired Connections 1** and go to **IPv4 Settings**. Enter the Google DNS server **8.8.8.8** in the **Additional DNS Servers** field and click on **Save**.

    ![](./images/300_22.png " ") 

3. Click on the networking icon, again, and disable network by toggling the **Enable Networking** settings.

    ![](./images/300_23.png " ")

4. Enable the network by toggling the same button  **Enable Networking**, again.

    ![](./images/300_24.png " ")

5. Visit any website on the browser and confirm that you have internet access.
