# Create an ODI Instance

## Introduction
This lab will show you how to create an ODI instance from a Marketplace image and configure ODI Studio

### Objecives
* Create an ODI Instance from Marketplace
* Configure ODI Studio

## **Step 1:** Create an ODI instance from OCI Marketplace

1. Login to the OCI Console and choose **Marketplace -> Applications**

    ![](./images/marketplace.png " ")
2. OCI Marketplace hosts many applications ready to be deployed.
   Search for “Oracle Data Integrator”.

    ![](./images/odi_marketplace.png " ")

   If there are more than one listing then pick the one which says “Free”

3. Choose the ODI listing. A page displays describing the ODI product overview and usage instructions. There is also a link to a detailed user guide for deploying the marketplace image.
Make sure you have chosen the correct **COMPARTMENT**
    ![](./images/odi_config_1.png " ")
    ![](./images/odi_config_2.png " ")    
    Select the latest free version (*not BYOL or Web versions*) from the list. If in doubt then check with your instructor for which version to use for this workshop.

    Accept the Terms&Conditions and click **Launch Stack**
    ![](./images/odi_config_3.png " ")

4. Add your initials to the **Name** field so you can easily identify your Instance. Click **Next**
    ![](./images/odi_config_4.png " ")    

5. ***IMPORTANT: If your administrator has created a network then use that network rather than creating a new one.***

    Select *Create an embedded ODI repository*. Embedded repository uses MySQL DB included in the compute instance. It is much simpler and good enough for the workshop. In practice an external database (autonomous database or DBCS) will be used for the ODI repository. 

    Add your initials to the **Resource Display Name Prefix** field so that you can identify your compute instance later.
    ![](./images/odi_config_5_1.jpg " ")

    Scroll down and enter *Network Configuration* info. (*Check with your administrator/instructor for which network to use*)
    ![](./images/odi_config_5_2.jpg " ")

6. Scroll down to **ODI Instance Settings** and choose the
    * **VM Shape** (*Check with your administrator/instructor for which shape to use*),
    * **SSH Key**: Paste the Public Key you created earlier (it should be only ONE line)
    * **Availability Domain**: (*Check with your administrator/instructor for which availibility domain to use*)
    * **VNC Password**: create and remember a password to access your VNC environment (This password will not be accessible again and is required to access the VNC from which to run ODI Studio)
    ![](./images/odi_config_6a.png " ")

7. Click **NEXT** and then click **CREATE** in the next page

8. The Stack will get created and a job should have started to create other resources. If you don't see any job created automatically then go to "Terraform Action" and click "Apply" to start the job. Scroll down for the JOB logs:
    ![](./images/odi_instance_create.png " ")

    Your instance will have your initials as a Prefix (provided you added them as instructed)
    ![](./images/odi_instance_create_2.png " ")

## **Step 2:** Configure ODI Studio and import training repository

1. From the hamburger menu, open **Compute** -> **Instances**

    ![](./images/odi_studio_1.png " ")

2. Search for your instance by *Display Name*. Ensure you have chosen the correct *Region* and *Compartment*

    ![](./images/odi_studio_2.png " ")     

3. Select the Instance Detail page by clicking the Name

4. Copy the Public IP Address. This is needed to access the ODI Instance
    ![](./images/odi_studio_3.png " ")       

5. You will need a VNC viewer for the following steps

**Mac**
If you are using an Apple Mac, you can use the <a href="https://support.apple.com/guide/mac-help/share-the-screen-of-another-mac-mh14066/mac" "target=\_blank"> Screen Sharing application </a>. On other operating systems you will need a suitable VNC viewer.

**Windows**
To install a VNC viewer for Windows
<a href="https://tigervnc.org/TigerVNC" "target=\_blank"> TigerVNC</a> is available from *My Desktop* for Oracle employees    

This example uses TigerVNC

Open the VNC viewer and enter the Public IP Address for your compute Instance
    ![](./images/odi_studio_4.png " ")

6. Enter the VNC Password you added when creating the ODI Instance

    ![](./images/odi_studio_5.png " ")  

7. You will be connected to the ODI instance and you will see the Desktop. Click through the *Welcome* screen on the first access
    ![](./images/odi_studio_6.png " ")     

8. Right-click in the Desktop and open a **Terminal**. Enter the following commands:
  ````
  <copy>
  cd /home/oracle/Downloads
  wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/vBJMV8xqU9kHSXst796obVBr65gZVOBr-VQS7FTcEFU/n/c4u03/b/labfiles/o/ODI12c_training_master_repo.zip
  wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/gigeWSEkMgDfjYDWzXjK2lCkITZh76X_3LPkOU6knC0/n/c4u03/b/labfiles/o/ODI12c_training_work_repo.zip
  wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/BX0sxMejz7IWOHvX9frw5EPqek2Ryf75TbxrKMjchNk/n/c4u03/b/labfiles/o/ODI12c_Sales_data.zip

  unzip ODI12c_Sales_data.zip

  ls -al
  </copy>
  ````
    
![](./images/odi_studio_7.png " ")  

All files as shown in the screenshot should be present in the directory      

9. It can take up to **30 minutes** for the configuration of the ODI repository to complete. This process is running in the background and you will not be able to launch ODI Studio until the configuration is completed.

Approximately 1/3 of the way through the configuration the **odiConfigure.log** file is created and will begin to be populated with progress entries. You can examine this log if you would like to follow the progress of the ODI repository configuration:

  ````
  <copy>
  cd $MW_HOME
  cd ../logs
  tail -f odiConfigure.log
  </copy>
  ````
The last log update will be **...Scheduler started for work repository WORKREP on Agent OracleDIAgent**

10. Launch ODI Studio from the Desktop
    ![](./images/odi_studio_8.png " ")

11. Click **No** to *Import from a previous ODI installation*  

    ![](./images/odi_studio_8a.png " ")

12. Click the radio button to *store passwords without secure wallet*

    ![](./images/odi_studio_8b.png " ")

13. Connect to the ODI repository (it will be empty)
    ![](./images/odi_studio_8c.png " ")     

**Note** The first time you connect to the ODI repository, it may take up to 5 minutes    

14. Select Import to open the Import Wizard

    ![](./images/odi_studio_9.png " ")

15. Select *Import the Master Repository*    

    ![](./images/odi_studio_9a.png " ")

16. Select the radio button *import from a zip file* and then enter the path to the **ODI12c\_training\_master\_repo.zip** file (/home/oracle/Downloads/ODI12c\_training\_master\_repo.zip if you followed the suggestions)

    ![](./images/odi_studio_9b.png " ")  

The import will take approximately 5 minutes

17. Click **Close** after import completes successfully
    ![](./images/odi_studio_9c.png " ")      

## **Step 3:** Configure connections

1. Open the **Topology** Tab and expand **Physical Architecture \-\> Technologies \-\> Oracle**

    ![](./images/odi_studio_10.png " ")  

You will see connections for all available ADW databases. These could be used in a data integration project. For this exercise we will focus on the **DEMO\_SRC\_DB** and **DEMO\_TRG\_DB** which you have imported from the training master repository.

2. Open **DEMO\_SRC\_DB** and test connection. You will get an **ERROR** stating *wallet can not be found*. This occurs because the wallet file we are using is either stored in a different location to that expected or the wallet file is not yet downloaded.

3. Click **OK** to close the error window

4. Click **Discover ADB** and select your ADW created earlier

  ![](./images/odi_studio_10a.png " ")

Click **OK** and associate your data server to the correct wallet file for connection

5. Enter the connection details for the ADW database you created:
  * User - **ADMIN**
  * Password - what you entered when creating the Autonomous database
  * Credentials - Downloaded by the *Discover ADB* action
  * Select the **low** service - **yourDBname\_low**

  ![](./images/odi_studio_10b.png " ")

and then select **Save**

6. Test the connection

  ![](./images/odi_studio_10c.png " ")

7. Repeat Step 5 and Step 6 for the database **DEMO\_TRG\_DB**

Use the same connection parameters as used in Step 5. These are defined as two different data servers but point to the same DB schema for simplicity.

## **Step 4:** Import the work Repository

1. Open the **Designer** tab and select **Import**

  ![](./images/odi_studio_11.png " ")

2. Select **Import the Work Repository**
  ![](./images/odi_studio_11a.png " ")

3. Select the radio button *import from a zip file* and then enter the path to the **ODI12c\_training\_work\_repo.zip** file (/home/oracle/Downloads/ODI12c\_training\_work\_repo.zip if you followed the suggestions)

    ![](./images/odi_studio_11b.png " ")  

The import will take approximately 5 minutes  

4. Click **Close** when import completes successfully

    ![](./images/odi_studio_11c.png " ")

## **Step 5:** Test the environment

1. Expand **Model** and right-click on **SRC\_AGE\_GROUP** and select **View Data**

    ![](./images/odi_studio_12.png " ")   

2. If you see data your environment is ready to use

    ![](./images/odi_studio_12a.png " ")      

Congratulations!  Now you have the environment to run the ODI labs.   

## Acknowledgements

- **Author** - Jayant Mahto, July 2020
- **Last Updated By/Date** - Troy Anthony, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
