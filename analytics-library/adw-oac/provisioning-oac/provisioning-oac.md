# Provisioning your Oracle Analytics Cloud (OAC) instance

![Oracle Analytics Cloud](./images/oac_banner.png)

## Introduction

This section describes the process of deploying **Oracle Analytics Cloud** instances on Oracle Cloud Infrastructure Gen 2, which is the default for newly provisioned accounts in **EMEA** and **US**.

Your Oracle Cloud Free Tier account will use the Oracle Cloud Free Trial **credits** while this instance is provisioned, as Oracle Analytics Cloud is not part of the **Always Free** cloud services.

Provisioning an Oracle Analytics Cloud instance can take over **40 minutes**.

Estimated workshop Time 15 minutes.

### Objectives
- Create an Oracle Analytics Cloud Instance

## **STEP 1**: Create an Oracle Analytics Cloud (OAC) Instance

Return to the Oracle Cloud Infrastructure Console accessing from **Oracle Home Page** (oracle.com) and sign in into your cloud account.
Click in **View Account** and **Sign in to Cloud**.

![Oracle Console SignIn](./images/lab200_1.png)

1. Click on the menu icon on the left. Verify that you are signed in as a **Single Sign On** (Federated user) user by selecting the **Profile** icon
in the top right hand side of your screen. If your username is shown as:

    > oracleidentitycloudservice/&lt;your username&gt;
    >
    Then you are **connected** as a **Single Sign On** user.

    ![Federated User](./images/lab200_2.png)

    If your username is shown as:

    > &lt;your username&gt;
    >
    Then you are **signed in** as an **Oracle Cloud Infrastructure** user.

    ![OCI User](./images/lab200_3.png)

    If your user does not contain the identity provider (**oracleidentitycloudprovider**), please logout and select to authenticate
    using **Single Sign On**.

    ![Oracle Console SignIn](./images/lab200_4.png)

    To be capable of using **Oracle Analytics Cloud** we need to be Sign-On as a **Single Sign-On** (SSO) user.

    [More information about federated users](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/usingscim.htm).

2. Return to the *Home Console Page* and navigate to **Analytics** under **Solutions and Platform** section and then **Analytics Cloud**.

    ![Oracle Analytics Console](./images/lab200_5.png)

    > **Note**: You must be connected as a **Single Sign On** (**Federated** user) user to a tenancy, which has available cloud credits to see this menu item. Local OCI users are not able to do this.

3. Select **Create Instance**.

    Complete the form using the following information:

    >**Compartment**: Select a valid compartment in your tenancy
    >
    >**Instance Name**: WORKSHOPADWOAC
    >
    >**Description**: &lt;optional&gt;
    >
    >**Feature Set**: Enterprise Analytics (important)
    >
    >**Capacity**: 1 - Non Production
    >
    >**License Type**: "Subscribe to a new Analytics Cloud software > license and the Analytics Cloud." (You will use this service as part of the free Oracle Cloud trial that you requested for this workshop).

4. Select **Create**.

    ![OAC Instance Creation](./images/lab200_6.png)

5. On the **Confirmation** screen, select **Create**.

    The Analytics instance page will be displayed with a status of ***CREATING***.

    ![OAC Instance Creating](./images/lab200_7.png)

    ***Reminder***: Provisioning an Oracle Analytics Cloud instance can take over **40 minutes**.

6. The Analytics instance page will be displayed with a status of ***ACTIVE***.

    ![OAC Instance Active](./images/lab200_8.png)


*You can proceed to the next lab…*

## **Acknowledgements**

- **Author** - Priscila Iruela - Database Business Development | Juan Antonio Martin Pedro - Analytics Business Development
- **Contributors** - Victor Martin, Melanie Ashworth-March, Andrea Zengin
- **Last Updated By/Date** - Kamryn Vinson, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.