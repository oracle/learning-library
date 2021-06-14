# Selective Adoption

## Introduction
Cloud Manager enables customers to take advantage of Selective Adoption by quickly creating PUM environments in Oracle Cloud and automating configuration of target databases in PUM source. Once target databases are configured, standard procedure should be followed to apply updates to target environments. For additional information on selective adoption please visit [https://docs.oracle.com/cd/F40091_01/psft/pdf/pcd858cmif-b032021.pdf](https://docs.oracle.com/cd/F40091_01/psft/pdf/pcd858cmif-b032021.pdf) and navigate to Chapter 9.

Estimated Lab Time: 30 minutes

### Objectives
In this lab you will:
* Create a PUM Connection from one PeopleSoft environment to another

### Prerequisites
- Two PeopleSoft environments up and running. One that will be used as a source environment and one that will be used as a target environment. The source environment must have a newer image version than the target environment.

## **STEP 1**: Create PUM Connection

1.  Navigate to **Dashboard** > **Environments**. On your source environment click the down arrow button and then click **Details**.
    ![](./images/sourcedetails.png "")

    Click **Manage PUM Connections** on the side menu then click **Add Target**.
    ![](./images/managepum.png "")

2.  Select your desired target environment and for client select the Windows client. Click **Add**.
    ![](./images/selecttarget.png "")

    Under **Target Databases** you should now see your new PUM connection. Notice how under **Upload target to PUM Source** the status is **in progress**. Wait until the status says **COMPLETE**, then you can move on to the next step.
    ![](./images/.png "")
    ![](./images/.png "")

## **STEP 2**: Logging into PUM Source

If you want to apply packages to the target DB you can use the PIA URL to log into the PUM source and manually apply a change package. 

1.  Navigate to **Dashboard** > **Environments**. On your source environment click the down arrow button and then click **Details**. 
    ![](./images/sourcedetails.png "")

    On the side menu click **Environment Details** and then click on the URL.
    ![](./images/url.png "")

    Enter your User ID (**PS** if you are using an HCM instance) and Password to sign in.
    ![](./images/login.png "")

2.  Click the navigation icon in the top right to open the navigation menu.
    ![](./images/nav.png "")

    Navigate to **PeopleTools** > **Lifecycle Tools** > **Update Manager** > **Update Manager Dashboard**.
    ![](./images/updatedash.png "")

    From here you will be able to see the uploaded target DB information.
    ![](./images/dbinfo.png "")

    From **Define Change Package** on the side menu you will be able to apply packages to the target DB.
    ![](./images/define.png "")

You may now **proceed to the next lab.**

## Acknowledgments

**Created By/Date**   
* **Authors** - Hayley Allmand, Cloud Engineer; Joowon Cho, Cloud Technologist
* **Last Updated By/Date** - Hayley Allmand, Cloud Engineer, May 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.