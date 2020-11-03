# Introduction

Welcome to the Introduction to JavaScript for APEX Developers hands-on lab.

## Developing on APEX

For developers that know SQL and PL/SQL, no other framework is as empowering as Oracle Application Express (APEX). But at the end of the day, APEX creates web apps, and it's JavaScript that programs the web. Over the years, JavaScript's role in APEX apps has increased, both for the creators of APEX and the developers using it - a trend that will continue in the years to come.

APEX developers only need to know a little bit of JavaScript to have a significant impact, and that's what this hands-on lab is all about! You'll start by learning some of the basics of JavaScript, then learn how to add JavaScript to APEX apps, and finally, you will learn to use jQuery to work with the DOM.

Before continuing to the first lab, follow the steps below to create an APEX workspace using the free tier in Oracle Cloud. If you already have a workspace you'd like to use, you may [proceed to the first lab](?lab=lab-2-javascript-basics).

Estimated Time: 160 minutes

**Labs**

| # | Lab | Est. Time |
| --- | --- | --- |
| 1 | [Create an APEX Workspace](?lab=lab-1-create-apex-workspace) | 20 minutes |
| 1 | [JavaScript Basics](?lab=lab-2-javascript-basics) | 20 minutes |
| 2 | [Adding JavaScript to APEX Apps](?lab=lab-3-adding-javascript-apex-apps) | 60 minutes |
| 3 | [Working with jQuery and the DOM](?lab=lab-4-working-dom-jquery) | 60 minutes |

## **Step 1**: Acquire an Oracle Cloud trial account

In this step, you will sign up for an Oracle Cloud trial account. Trial accounts have access to the <a href="https://www.oracle.com/cloud/free/" target="\_blank">free tier services</a> and get a $300 credit for other services. This lab only requires an APEX workspace, which is available via the free tier services and will continue to work when the credits expire (after 30 days). Use the credits as you wish to explore other parts of the Oracle Cloud.

1.  If you already have an Oracle Cloud trial account (or regular account), you may skip to the next step.

2.  Please <a href="http://bit.ly/Javascript_APEX_HOL" target="\_blank">click this link to create your free account</a>.

3.  Soon after requesting your account you will receive the following email. Once you receive this email you may proceed to Step 2.

    ![](images/get-started-email.png)

## **Step 2:** Log in to your Oracle Cloud account

In this step, you will log into your Oracle Cloud account so that you can start working with various services.

1.  Once you receive the **Get Started Now with Oracle Cloud** email, make note of your **Username**, **Password**, and **Cloud Account Name**.

2.  From any browser go to <a href="https://cloud.oracle.com/en_US/sign-in" target="\_blank">https://cloud.oracle.com/en_US/sign-in</a>.

3.  Enter your **Cloud Account Name** in the input field and click the **Next** button.

    ![](images/enter-oracle-cloud-account-name.png)

4.  Enter your **Username** and **Password** in the input fields and click **Sign In**.

    ![](images/enter-user-name-and-password.png)

## **Step 3:** Create an Autonomous Transaction Processing instance

In this step, you will create an instance of the Autonomous Transaction Processing database service.

1.  From the Cloud Dashboard, click the navigation menu icon in the upper left-hand corner and then select **Autonomous Transaction Processing**.

    ![](images/select-atp-in-nav-menu.png)

2.  Click **Create Autonomous Database**.

    ![](images/click-create-autonomous-database.png)

3.  Select the **Always Free** option, enter **`SecretPassw0rd`** for the ADMIN password, then click **Create Autonomous Database**. Note: you may choose a different password, just be sure to make note of it and substitute it any time there's a reference to **`SecretPassw0rd`**.

    ![](images/atp-settings-1.png)
    ![](images/atp-settings-2.png)
    ![](images/atp-settings-3.png)

    After clicking **Create Autonomous Database**, you will be redirected to the Autonomous Database Details page for the new instance. Continue to the next step when the status changes from:

    ![](images/status-provisioning.png)

    to:

    ![](images/status-available.png)

## **Step 4:** Create a new workspace in APEX

When you first access APEX you will need to log in as an APEX instance administrator to create a workspace. A workspace is a logical domain where you define APEX applications. Each workspace is associated with one or more database schemas (database users) which are used to store the database objects, such as tables, views, packages, and more. These database objects are generally what APEX applications are built on top of.

1.  Click the **Service Console** button.

    ![](images/click-atp-service-console.png)

2.  Click **Tools** option in the menu on the left, then click the **Oracle APEX** option.

    ![](images/click-oracle-apex.png)

3.  Enter the password for the Administration Services and click **Sign In to Administration**. The password is the same as the one entered for the ADMIN user when creating the ATP instance: **`SecretPassw0rd`**

    ![](images/log-in-as-admin.png)

4.  Click **Create Workspace**.

   ![](images/welcome-create-workspace.png)

5.  Enter the following details and click **Create Workspace**.

    | Property | Value |
    | --- | --- |
    | Database User | **DEMO** |
    | Password | **`SecretPassw0rd`** |
    | Workspace Name | **DEMO** |

    ![](images/create-workspace.png)

6.  Click the **DEMO** link in the success message. This will log you out of APEX administration so that you can log into your new workspace.

    ![](images/log-out-from-admin.png)

7.  Enter **`SecretPassw0rd`** for the password, check the **Remember workspace and username** checkbox, and then click **Sign In**.

    ![](images/log-in-to-workspace.png)

You may now proceed to the next lab.

## **Acknowledgements**
 - **Author** -  Dan McGhan, Database Product Management
 - **Contributors** - Arabella Yao, Jeffrey Malcolm Jr, Robert Ruppel, LiveLabs QA
 - **Last Updated By/Date** - Jeffrey Malcolm Jr, LiveLabs QA, June 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
