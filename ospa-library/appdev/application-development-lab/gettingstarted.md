# Getting Started

## Lab Purpose and Rules

These labs are designed to provide you with an introduction to Visual Builder and Digital Assistant to prepare you to showcase these services.

Here are some general guidelines that will help you get the most from
these lab exercises.

  - Read through an entire exercise before executing any of the steps.
    Becoming familiar with the expected flow will enhance your learning
    experience.

  - Ask before you do. If you have any questions, please ask the
    instructor before you march down a path that may lead to wasting
    your time.

  - Follow the steps as shown in the Lab Guide. This is a live
    environment. If you want to do something that is not in the labs,
    ask the lab instructor first. In particular, do not create, delete,
    or alter any cloud objects without asking first.

  - There is no prize for finishing first; there is no penalty for
    finishing last. The goal is to gain a firm understanding of Oracle
    Visual Builder.

  - Ask questions freely. The only dumb questions are those that are not
    asked.


## Create a VBCS Instance

As part of the lab, we expect learners to create the VBCS instance before the session delivery.
If you are creating a new instance either for the lab purposes or a customer demonstration, please follow the next steps; the process is simple but require several minutes to complete.

In this lab you will make sure you can access the VBCS instance for your classroom and supporting lab files.


### Video


[![Creating a Visual Builder Cloud Service Instance](./media/playback_creating_instance_vbcs.png)](https://otube.oracle.com/media/Oracle+Sales+and+Partner+Academy+-+AppDev+Virtual+Workshop/1_xryvhe4k)

*Note: By clicking the video, this will redirects you to OTube. Remember to get back to this page to continue with the Lab*


### Oracle Visual Builder Cloud Service Instance Creation Guide

1. First, go to cloud.oracle.com, click on **View Accounts** and select **Sign in to cloud**
<br>![](./media/cloudoracle.png)

2. Enter your tenant account
<br>![](./media/tenant.png)

1. On the login screen select SSO and provide your credentials *(Contact your tenant admin if you are using a different login mechanism)*
<br>![](./media/credentials_2.png)

1. Once in the main dashboard, open the **General Menu** located at the top left hand side of the screen, select **Platform Services**, and click on **Visual Builder**
<br>![](./media/vb_dashboard.png)

1. Log into your tenancy using cloud.oracle.com; be sure it has been provisioned to allow Visual Builder Cloud Service and the database and object storage instances also required.  (check with your tenancy admin if unsure)
   
2. Select Platform Services and click on **Visual Builder**


3. If you have not created any services the Service Console prompts you to begin the process.
**DO NOT** CLICK “CREATE INSTANCE” at this time, we will be using **Quick Starts**
<br>![](./media/image_a_11.png)


1. Visual Builder provides a “Quick Starts” capability to build an instance complete with supporting database and object storage. Click the “Quick Starts” button to get started it is located in the upper-right portion of the Service Console display inside the big blue bar.
<br>![](./media/image_a_13.png)


1. Click on **Custom**
<br>![](./media/vbcs_instance_custom.png)

1. Provide an instance name, description, and region. Once complete, click next and confirm. The instance creation can take up to 10 min.
<br>![](./media/vbcs_instance_data.png)
<br>![](./media/vbcs_instance_creation.png)

That’s it, you’ve created an instance that can support many VBCS applications and user.


NOTE:
If others will be sharing your VBCS instance you will need to use Oracle Identity Cloud Service (IDCS)
to make sure they have `ServiceDeveloper` (Visual Builder Administrator) role for your instance if they are developers or 'ServiceAdministrator' (Visual Builder Administrator) role if they need to administer other's applications. 
See Oracle Documentation for more information.


## Create an Digital Assistant Instance

As part of the lab, we expect learns to create the Digital Assitant instance before the session delivery.
If you are creating a new instance either for the lab purposes or a customer demonstration, please follow the next steps; the process is simple but require several minutes to complete.

### Video


[![Creating a Digital Assistant Instance](./media/playback_creating_instance_oda.png)](https://otube.oracle.com/media/Oracle+Sales+and+Partner+Academy+-+AppDev+Virtual+Workshop+-+Creating+an+ODA+Instance/1_ee3m2ce9)

*Note: By clicking the video, this will redirects you to OTube. Remember to get back to this page to continue with the Lab*


### Oracle Digital Assistance Instance Creation Guide

1. First, go to cloud.oracle.com, click on **View Accounts** and select **Sign in to cloud**
<br>![](./media/cloudoracle.png)

1. Enter your tenant account
<br>![](./media/tenant.png)

1. On the login screen select SSO and provide your credentials *(Contact your tenant admin if you are using a different login mechanism)*
<br>![](./media/credentials.png)
<br>![](./media/credentials_2.png)

1. Once in the main dashboard, open the **General Menu** located at the top left hand side of the screen and click on **Digital Assitant**
<br>![](./media/creating_oda_1.png)

1. In the Digital Assistant console, select the compartment where to deploy the new instance and click on **Create Digital Assistant**
<br>![](./media/creating_oda2.png)

1. In the Digital Assistant creation screen, provide a name, description, and shape (For the lab purposes select `Production`), and click **Create**
<br>![](./media/creating_oda_3.png)

1. The process might take a few minutes. Once created, you should see the instance as **Active**
<br>![](./media/creating_oda_4.png)


That’s it, you’ve created your first Oracle Digital Assistant instance.

## Hands-On Labs

You can access the Labs using the navigation bar located on the top-right hand corner.
