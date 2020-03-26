 ![](./media/securitytitle.png)
# Lab 1:  Oracle Identity Cloud Service

## Table of Contents

- [Module 1: User Management](#module-1--user-management)
- [Module 2: Configure SSO and Provisioning for Salesforce](#module-2--configure-sso-and-provisioning-for-salesforce)

***** 

**Disclaimer:  This lab is designed ONLY for large learning groups and assumes the groups are sharing the Oracle Cloud environment to execute this lab.**

## Mama Maggy's Identity Management business needs

Shannon Kim, Director/Manager of IT is seeking to reduce users and privileges' provisioning timeframe while improving security controls and governance.
Mama Maggy's current Identity Management solution cannot scale to the cloud.
Line-of-business has complained about the number of user ids and passwords that they must manage across its heterogeneous environment.
CIO has identified an exponential trend on the help desk calls for user ids and passwords reset since they have starting to move the workload to the cloud, so he asked Shannon to implement a solution that can help them not only consolidate on-premises and Cloud services user management but also help them to improve productivity and user experience.
Mama Maggy has acquired Oracle Identity Cloud Services to manage their enterprise infrastructure, regardless if its in the cloud or on-prem. 
As part of the new project, the CIO office is looking to implement Single Sign-On with their main SaaS applications, which will reduce not only the help desk calls but the average login timeframe.
You as the IdM Manager must set up Oracle Identity Cloud Service to allow users to log in to third-party services using Open Standards and to manage user id and privileges provisioning.


 
# Lab Configuration and Details

For the workshop lab exercises, the current version of the Oracle Identity Cloud Service (IDCS) is being demonstrated.
 
This workshop includes a combination of cloud services and 3rd party software. Aside from the Identity Cloud Service, the remaining components are included to enable demonstrating integration, including identity synchronization, federation, authentication, SSO and more.

This workbook is primarily designed to provide the necessary instructions and context to allow you to complete the labs in the Oracle Identity Cloud Service Workshop. 

Due to environment privileges constraints, user id creation/modification/deletion and application registration assignments have been already implemented in this tenant.
The instructor will guide you through the process of creating a new account and onboarding a new application into IDCS. These steps have been highlighted within this workshop for your reference.
The tasks labeled as **DEMO** will be instructor guide, while the exercises labeled as **EXERCISE** are assignments that you as the learner must complete.


The following summarizes the components in our workshop:
 

  * [Oracle Identity Cloud Service](https://cloud.oracle.com/en_US/identity)

  * Salesforce – used for IDCS Application Integration and CASB Create
    and Monitor a sanctioned Application use-cases

 The following configuration information is provided to assist with
 accessing lab assets:

  * Workshop Actors
    
      * IDCS End Users (e.g. employees, customers, partners, etc.)
    
      * IDCS Administrators

**NOTE: This lab contains two main modules with optional exercises. Due to timing constraints, we encourage you to complete first the mandatory modules and then go back to the optional tasks.**

# Overview: Oracle Identity Cloud Service

## Introduction

 Identity Cloud Service is Oracle’s next generation comprehensive security and identity platform that provides an innovative, fully integrated service that delivers all the core identity and access management capabilities through a Cloud platform “as a service. The design of Identity Cloud Service (IDCS) is based on micro service architecture which is naturally aligned with Cloud principles of Scalability, Elasticity, Resilience, Ease of Deployment, Functional Agility, Technical Adoption and Organization Alignment.
 
 At high level, Oracle Identity Cloud Service offers the following functionalities:

  * Identity & Access Management

  * Integration with on-prem Active Directory or 3rd party Identity
    Systems

  * Single-Sign-On (SSO)

  * User Authentication Service

  * Identity Federation service (SAML)

  * OAuth services

  * Auditing & Reporting Services

### Concepts and Terminology

  * **OAUTH 2.0** – OAUTH is a standard protocol for delegating authorization. It’s a way for an entity to be authorized to access resources (services, API, data) stored in a remote provider. For example, an on-premises application might leverage the IDCS REST API to retrieve information about users or groups from IDCS for use within its application. The REST API is protected by the OAUTH service, to ensure the client application is registered and authorized to a specific scope of REST API. Thus, OAUTH prevents internet-visible services (such as IDCS REST API) from being consumed by an unauthorized user or application.

  * **SAML 2.0** – SAML stands for *Security Assertion Mark-up Language*. It is a standard for federating user authentication. SAML defines two participating entities, the Service Provider and the Identity Provider. When a user attempts to access an application or service (at the Service Provider) which is configured for SAML, rather than log the user in through local ID/PW, the SP causes the user authentication to be performed by the Identity Provider. There is therefore a trust relationship established between SP and IDP. Oracle IDCS can be configured to take the role of Service Provider and/or Identity Provider. As a service provider, IDCS enables self-service profile management, password reset, etc.

  * **Identity Provider (IdP)** – This type of provider, also known as an Identity Assertion provider, provides identifiers for users who want to interact with Oracle Identity Cloud Service using a website that's external to Oracle Identity Cloud Service.

  * **Service Provider (SP)** - Third-party actor who provides a service. Offers application services but does not act as identity provider.

  * **Federation** - Federation in identity management enables two or more partners to work together, exchanging identity information securely across internet domains providing secure single sign-on (SSO). Common to a SAML federation are the concepts of identity provider (IdP) and service provider (SP)

***

### **DEMO** - Navigation between IDCS and Cloud My Services Dashboards

During the following exercises we will cover the following Personas:
 
 * IDCS Administrator
 * IDCS End User
 
 Let’s first get used to how to access IDCS from within Oracle’s Cloud console and how to move between the two dashboards.
 
 * Login to your Oracle Cloud Account:
 [Login to your Cloud Account](https://cloud.oracle.com/en_US/sign-in)

![](./media/idcs5.jpeg)
<p align="center"> Figure 1-1 </p>

 * On the login page, enter your user name and password and click **Sign In**
 
 * You will be presented with a dashboard displaying the various cloud services available to this account.
 
 ![](./media/idcs6.png)
 <p align="center"> Figure 1-2 </p>
 
 * From the **Cloud My Services** dashboard, click on **Users** in the upper right-hand corner. Then click on **Identity Console** button located towards upper right-hand corner again.

![](./media/idcs7.png)
<p align="center"> Figure 1-3 </p>

 * If you have logged in using your administrator Account, the users are shown up in IDCS admin console. Other admin console sections are also available.
 
 ![](./media/idcs8.jpeg)
 <p align="center"> Figure 1-4 </p>
 
 * In the upper left-hand corner select the navigator menu or sometimes referred to as the "General Menu”. Select **Dashboard**. This will display the **Identity Cloud Service** dashboard.
 
 * Click on the navigator menu to hide it.

![](./media/idcs9.jpeg)
<p align="center"> Figure 1-5 </p>

* To return to the Cloud Console, do the following:

  *  Select the **My Home** menu from the upper right corner of the
    screen.

![](./media/idcs10.jpeg)
<p align="center"> Figure 1-6 </p>

  *  Then select the Dashboard button at top right of screen. This will
    return you to the **Cloud My Services** dashboard. Or just use your
    bookmarked URL as suggested earlier.

 ![](./media/idcs11.jpeg)
 <p align="center"> Figure 1-7 </p>

# **DEMO** - IDCS Quick Tour

 Return to the IDCS dashboard and click on the navigator menu
 (hamburger menu).

![](./media/idcs12.jpeg)
<p align="center"> Figure 1-8 </p>

 You may navigate around IDCS from the dashboard screen items or through the menu on the left. Note the **My Services** link at the bottom of the menu list. This provides a shortcut to **Cloud My Services** dashboard.
 
 The IDCS documentation may be accessed through the **Learn More** button on the dashboard.
 
 Click on the following menus and just get familiar with the content:

  * Users

  * Groups

  * Settings

  * Security

 We’ll get into the details shortly, but this will give you a quick
 navigation overview of the menus and services available.

# Module 1:  User Management

 It is often a requirement for organizations to on-board an employee or contractor or some identity manually into a central identity systems like IDCS. In this use case, an IDCS user administrator will manually add a new user in IDCS service. Typically, this would occur through automated provisioning, bulk flat-file import or synchronization with your on- premises Active Directory.
 
 The IDCS features are built 100% using the IDCS REST API service. Therefore, any task we perform interactively in the web interface could also be performed via custom app, using these same REST API calls. It’s a clear advantage of Oracle’s API-first architecture with IDCS.
 
 IDCS supports user (also groups) on-boarding from on-premises **Active Directory**, using file upload, REST API, on-premises **Oracle Identity Management** solution, or manually from IDCS admin console. For the workshop we will be using file upload option and API calls user management.

### **DEMO** - Create User in UI (Persona: Administrator)

*  Go to IDCS Admin console using your administrator account credentials. Select the **Users** menu on the left and click **+Add** or select the **Add a user** icon from the dashboard.

![](./media/idcs13.png)
<p align="center"> Figure 1-9 </p>

*  Fill in all required fields and click **Finish**. For this lab purposes, create a dummy account using your personal email address (e.g. *name@gmail.com*). We will use this account as part of our Single Sign-On module.

 ![](./media/idcs14.png)
 <p align="center"> Figure 1-10 </p>

*  Verify user creation
    
      * Go to the **Users** tab in admin console. Verify that the new users are visible on the console.

 ![](./media/idcs15.jpeg)
 <p align="center"> Figure 1-11 </p>

****

## API User administration with REST API’s (Persona: Administrator)


The following exercise has been developed to showcase IDCS API capabilities.
This use case involves making API calls to IDCS using a REST client; in this case Postman. The Postman collection of relevant REST API calls is provided to each participant.


### **DEMO** - Register a client POSTMAN application in IDCS

*  Navigate to your tenant https://**yourtenant**/ui/v1/adminconsole
 
 ![](./media/idcs23.jpeg)
 <p align="center"> Figure 1-12 </p>

*  Select the Applications tab from the IDCS dashboard presented after log in

![](./media/idcs24.png)
<p align="center"> Figure 1-13 </p>

*  Click the **Add** button to create a new application for Postman use. In order for Postman to be able to call IDCS REST APIs, it first requires to have a **CLIENT_ID** and **CLIENT_SECRET** that authorize Postman to do so. This can be achieved by creating a Confidential Application type into IDCS with specific authorization grant types as you will see into the following steps.

 ![](./media/idcs25.jpeg)
 <p align="center"> Figure 1-14 </p>

*  Select Confidential Application from the pop-up menu of application types:

![](./media/idcs26.jpeg)
<p align="center"> Figure 1-15 </p>

*  Set the **Name** to “Postman”. Then click **Next**

 ![](./media/idcs27.jpeg)
 <p align="center"> Figure 1-16 </p>

*  Click “**Configure this application as a client now**” in order toprovide the authorization grant types and the API role.

![](./media/idcs28.jpeg)
<p align="center"> Figure 1-17 </p>

![](./media/idcs29.jpeg)
<p align="center"> Figure 1-18 </p>

*  Select all the Allowed Grant Types checkboxes and set Redirect URL to [**https://localhost.**](https://localhost/) Go to “**Grant the client access to Identity Cloud Service Admin APIs**” section (bottom of the page) and add the following API role “**Identity Domain Administrator**”. This way you are basically granting access for this IDCS app to the full set of IDCS APIs.

*  Finally, click **Next**.

![](./media/idcs30.jpeg)
<p align="center"> Figure 1-19 </p>

*  Make no changes in the next screens and click **Next**

 ![](./media/idcs31.png)
 <p align="center"> Figure 1-20 </p>

* For finalizing the IDCS app that grants API roles to Postman via Auth2.0 standard click **Finish.**

![](./media/idcs32.jpeg)
<p align="center"> Figure 1-21 </p>

* Once the application is created, note down the **Client ID** and the **Client Secret** then click **Close.** These will be used by Postman desktop application to call IDCS APIs using the Auth2.0 standard protocol.

![](./media/idcs33.jpeg)
<p align="center"> Figure 1-22 </p>

* Click the **Activate** button. Don’t forget to activate the application

![](./media/idcs34.jpeg)
<p align="center"> Figure 1-23 </p>

* Confirm the application activation

![](./media/idcs35.png)
<p align="center"> Figure 1-24 </p>

* The application is now active and ready to use.
 
 ![](./media/idcs36.jpeg)
 <p align="center"> Figure 1-25 </p>
 
* Sign out from IDCS

###  **EXERCISE** - Configure Postman - Who Should Complete This Lab:  All Participants
    
*  Open **Postman**. Ignore all startup messages if any. 

**For this lab purposes you don't need to create a Postman user id. You can ignore all the messages**

![](./media/idcs37.jpeg)
<p align="center"> Figure 1-26 </p>

*  First we need to import IDCS Postman environment variables, global variables and IDCS API collection. Click the Import button on the left upper corner:

 ![](./media/idcs38.jpeg)
 <p align="center"> Figure 1-27 </p>

*  Select “**Import from Link**” and provide the following URL to import the environment variables:
   
    https://github.com/oracle/idm-samples/raw/master/idcs-rest-clients/example_environment.json

    * and then click **Import**

*  To import the Oracle Identity Cloud Service REST API Postman
    collection, on the Postman main page, click **Import**.

*  In the Import dialog box, select “**Import From Link**”, paste the
    following GitHub Postman collection URL into the box, and then click
    **Import**:

https://github.com/oracle/idm-samples/raw/master/idcs-rest-clients/REST_API_for_Oracle_Identity_Cloud_Service.postman_collection.json

 
 ![](./media/idcs39.png)
 <p align="center"> Figure 1-28 </p>

*  To import the global variables file, click **Import**.

*  In the Import dialog box, select **“Import From Link”,** paste the following GitHub Postman Globals URL into the box, and then click **Import**:

 https://github.com/oracle/idm-samples/raw/master/idcs-rest-clients/oracle_identity_cloud_service_postman_globals.json

**NOTE: You might not receive a notification once the variables have been imported**

*  Click on the **Settings** button (cogwheel icon) to **Manage Environments**

 ![](./media/idcs40.png)
 <p align="center"> Figure 1-29 </p>

*  Click on the newly created environment which will be like “Oracle Identity Cloud Service Example Environment with Variables” and it will probably be the only one available in your cases.

![](./media/idcs41.png)
<p align="center"> Figure 1-30 </p>

* Set the following parameters current values in order to be able to obtain an IDCS access token and click **Update**:

 HOST: https://**your IDCS tenant** 

**NOTE: Verify the URL format. Must end in oraclecloud.com, no extra / or endpoints**

 e.g. https://idcs-8ba16123120745658135edd99d8a5c78.identity.oraclecloud.com 

 
 CLIENT_ID: **the Postman IDCS Client application CLIENT_ID** 

 CLIENT_SECRET: **the Postman IDCS Client application CLIENT_SECRET** 

 USER_LOGIN: **Your Oracle Cloud User Id**

 USER_PW: **Your Oracle Cloud Password**

**NOTE: CLIENT_ID and CLIENT_SECRET information is available in the participant guide**

![](./media/idcs42.png)
<p align="center"> Figure 1-31 </p>

* Click the **Environment** drop-down list, and then select the updated environment from the list.

 ![](./media/idcs43.png)
 <p align="center"> Figure 1-32 </p>

*  Request an Access Token
    
    * On the **Collections** tab, expand **OAuth**, and then **Tokens**.
    
    * Select **Obtain access_token (client credentials),** and then click **Send**. The access token is returned in the response from Oracle Identity Cloud Service.
    
    * Highlight the access token content between the quotation marks, and then **right-click**. In the shortcut menu, select **Set: Oracle Identity Cloud Service Example Environment with Variables**.

    * In the secondary menu, select **access_token**. The highlighted content is assigned as the access token value.

 ![](./media/idcs44.jpeg)
 <p align="center"> Figure 1-33 </p>

*  Search an IDCS User via API
    
    * On the **Collections** tab, expand **Users**, and then **Search**.
    * Click on **Search all users (return specific attributes)**
    * Add the key **count** and the Value **1000**
    * Click on **Send**
    * On the result windown search your user id (e.g. alejandro.casas@oracle.com) and copy the id value without the quotes
    

![](./media/idcs45.png)
 <p align="center"> Figure 1-34 </p>

*  Modify an IDCS User via API
    * On the user collection select **Modify** and **Update user (replace single attribute)**
    * On the patch parameters replace **{{userID}}** with your ID string copied in the previous step
    * Select the Body Tab and update the Phone value number as shown on the screen
    * Click **Send**

![](./media/idcs46.png)
 <p align="center"> Figure 1-35 </p>


* You will receive an email with the profile update confirmation

![](./media/idcs47.png)
 <p align="center"> Figure 1-36 </p>

* Open your profile to see the changes

![](./media/idcs48.png)
 <p align="center"> Figure 1-37 </p>


At this point you are able to make REST application programming interface (API) calls to Oracle Identity Cloud Service using Postman to create, delete and modify users.
For further information about using IDCS REST interface with postman, please visit [Using the Oracle Identity Cloud Service REST APIs with Postman](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/idcs/idcs_rest_postman_obe/rest_postman.html)


# Module 2:  Configure SSO and Provisioning for Salesforce

 Oracle Identity Cloud Service (IDCS) provides integration with any service that can be integrated via **SAML** (Security Access Markup Language) protocol. Administrations will be able to manage users into various applications via single control panel and end users will be able get to applications via single click.
 
 IDCS provides support for standard SAML 2.0 Browser POST Login & Logout Profiles.
 
 Please note, that though IDCS supports SAML and OpenID Connect/OAuth, there are many times when a non-SAML enabled system requires SSO. IDCS App Gate provides support for non-SAML systems that use header-based, cookie-based or form-fill SSO. App Gate is an Nginx-based, software appliance deployed in a proxy configuration that can be deployed on AWS, OCI, OCI-C or on-premises in VMWare or Oracle Virtualbox. It is delivered via Identity Cloud Service and available for IDCS Standard customers.
 
 This lab is intended to demonstrate federated Single Sign-on (SSO) with a 3rd party SaaS application. The purpose is to illustrate the business value of having IDCS as a central Identity Provider for your growing portfolio of Oracle and non-Oracle.
 
 In this hands-on exercise, we will setup integration with **Salesforce** using SAML. IDCS will act as **IdP** (Identity Provider) and Salesforce org as **SP** (Service Provider also known as a Relying Party)

### **DEMO** - Enable SSO on SalesForce

* Download IDCS Metadata to a local XML file. Metadata is available from the following location - https://**yourtenant**/fed/v1/metadata. Depending on the browser you are using,the simplest way of doing this is to right click anywhere on the page and chose “Save as” option provide a name and save it as XML file. Try not to use the copy / paste option as the xml file may be altered.

 ![](./media/idcs47.jpeg)
 <p align="center"> Figure 2-1 </p>

* Navigate to [Developer SalesForce](https://developer.salesforce.com/)
    * Click the **Sign-up** button in the top right corner
    * Enter the required information
    * Click **Sign me up**

**Note: You must sign-up with your personal account (e.g. Gmail, Yahoo, Outlook)**

![SF registration](./media/sf_registration.png)
<p align="center"> Figure 2-2 </p>  


* You will get an email to confirm your account. Click **Verify Account**


![SF verification](./media/sf_verification.png)
<p align="center"> Figure 2-3 </p>  


* Create a password for your account

![SF Create Password](./media/sf_password.png)
<p align="center"> Figure 2-4 </p>  

 
* Access Salesforce application using the URL provided after registration. 

 ![](./media/sf_login_.png)
 <p align="center"> Figure 2-5 </p>

* On the main page, click under your user name on the top-right corner

![](./media/sf_main_page.png)
 <p align="center"> Figure 2-6 </p>

 * Select **My Developer account** form the menu

![](./media/sf_menu_profile.png)
 <p align="center"> Figure 2-7 </p>

* Once in the developer page, click on the profile menu as per below print screen and select the option: **“Switch to Salesforce Classic”**.

![](./media/idcs49.jpeg)
<p align="center"> Figure 2-8 </p>

*  Go to **Setup** into the upper tab menu, near the profile.

*  Register a custom Domain. Go to **Domain Management**, **My Domain** and register a domain of your choosing. This is to have a custom application URL dedicate for our use case.
 
 ![](./media/idcs50.jpeg)
 <p align="center"> Figure 2-9 </p>

*  Check your email for the domain login and login.

*  Bring up the **setup** page.

![](./media/idcs51.jpeg)
<p align="center"> Figure 2-10 </p>

*  From side menu bar, go to **Security Controls**, **Single Sign-On Settings**

![](./media/idcs52.jpeg)
<p align="center"> Figure 2-11 </p>

*  Click on **Edit** and enable **Federated Single Sign-On Using SAML** option.

![](./media/idcs53.png)
<p align="center"> Figure 2-12 </p>

* Click on **New from Metadata File** button to import IDCS metadata. Select the downloaded metadata file using **Choose File** button. Click on **Create**.

![](./media/idcs54.png)
<p align="center"> Figure 2-13 </p>

* Update the **Entity ID** with the domain information registered in the previous steps (e.g *https://acasas-dev-ed.my.salesforce.com*) and click **Save**

![](./media/idcs55.jpeg)
<p align="center"> Figure 2-14 </p>

* Below are the details for this example. Note, your URLs and domain information will be different.

![](./media/idcs56.jpeg)
<p align="center"> Figure 2-15 </p>

![](./media/idcs57.jpeg)
<p align="center"> Figure 2-16 </p>

* Make note the following:

  * Organization ID value

  * Org Domain Name value.

![](./media/idcs58.jpeg)
<p align="center"> Figure 2-17 </p>

Now that the Salesforce configurations are done, we need to configure IDCS to be aware of the Salesforce application.

* Go to IDCS admin console, navigation menu, **Applications**

 ![](./media/idcs59.jpeg)
 <p align="center"> Figure 2-18 </p>

* Click on **Add** button and select **App Catalog** and search for Salesforce. Click on **Add.**

 ![](./media/idcs60.jpeg)
 <p align="center"> Figure 2-19 </p>

* On the first page of configuration screen provide the **Organization**

 **ID** and **Domain Name** values that you made note of from within Salesforce.

![](./media/idcs_salesforce_1.png)
<p align="center"> Figure 2-20 </p>

* Click on **Next** to move to the SSO configuration

 ![](./media/idcs_salesforce_2.png)
 <p align="center"> Figure 2-21 </p>

* Click on **Next**  to move to the provisioning configuration

 ![](./media/idcs_salesforce_3.png)
 <p align="center"> Figure 2-22 </p>

 * Click on **Finish**

* **Activate** the application

 ![](./media/idcs63.png)
 <p align="center"> Figure 2-23 </p>

### **DEMO** - Assign Apps to Group (Persona: Administrator)

In IDCS you have the option to assign access to users directly, by direct assignment to a specific application, or indirectly using dedicated groups. For the purpose of the use case we’ll be using groups to provide users access to Salesforce application.

*  Go to IDCS admin console, **Groups** menu

*  Add a group labeled **CoSE_Employee**. Check the box **User can request access**.

 ![](./media/idcs64.png)
 <p align="center"> Figure 2-24 </p>

*  Click on **Finish**

*  Go to the **Access** tab. Click on **Assign**.

*  Select **Salesforce** and click on **OK**.

![](./media/idcs65.jpeg)
<p align="center"> Figure 2-25 </p>

Moving back to Salesforce in order to create a corresponding account for one that we have into IDCS.

*  **Login** into **Salesforce** as an administrator.

*  Go to **Setup**.

*  On the left panel, click on **Manage Users**, then on **Users** and then on **New User**.

*  Create a user as shown below. Be sure to use a Oracle email address as the login.


*  Set the **User License** to **Salesforce Platform**.

![](./media/idcs_salesforce_create_id.png)
<p align="center"> Figure 2-26 </p>

Now that the account is available in Salesforce and IDCS has the authenticated account you are ready to test.

### **DEMO** - Request Group Access (Persona: End User)

Remember that we have created the **CoSE_Employee** group into IDCS which is having access to Salesforce application but there is no user assigned yet to it. Since we chose the option **“User can request access”** at the creation of the group, now we should be able to request access to it and implicitly to the salesforce application.

*  Close your browser to clear the cache and then login into IDCS https://**yourtenant**/ui/v1/myconsole

*  From **My Apps** page, click on **+ Add** access request button.

![](./media/idcs67.jpeg)
<p align="center"> Figure 2-26 </p>

*  From the **Groups** tab, select **CoSE_Employee** group and select the **+** sign.

*  Click on + sign to request access to the group. Provide justification on the resulting popup page. Click on **OK**. This is an auto approved request and access should be granted immediately without the need of and administrator intervention.

 ![](./media/idcs69.jpeg)
 <p align="center"> Figure 2-27 </p>

*  Go to **My Profile** section from menu located top-right

![](./media/idcs70.png)
<p align="center"> Figure 2-28 </p>

*  Ensure that **CoSE_Employee** group is visible under **My Access** sub-tab

 ![](./media/idcs71.png)
 <p align="center"> Figure 2-29 </p>

*  Ensure that Salesforce applications are visible now on the **MyApps** page

![](./media/idcs72.png)
<p align="center"> Figure 2-30 </p>

### **DEMO** - Verify SSO Configuration (Persona: End User)

*  Click on the **Salesforce Chatter** app from **My Apps** page

*  Ensure that user is automatically logged into Salesforce Chatter (**SSO**)

![](./media/idcs73.jpeg)
<p align="center"> Figure 2-31 </p>

You should now see the same user profile information, that you started within IDCS, within Salesforce without having had to log into Salesforce.


## Configuring Provisioning and Synchronization – Additional Reading

Now that you have completed the lab, let's review some additional Oracle Identity Cloud Service features that customers can leverage to easily manage their user ids life cycle regardless the environment or application.

User provisioning and synchronization are an important aspect of application management. Provisioning allows you to manage the lifecycle of accounts in applications like creating and deleting accounts using Oracle Identity Cloud Service. For example, when you grant the user access to an application such as Google Suite, then this user account is automatically created in Google Suite. This allows you to quickly add new users to multiple applications and de-provision users from those applications instantly when they change roles or leave your organization.

You can enable and configure provisioning for App Catalog applications either when adding the app or later when modifying it. When you enable provisioning by selecting the option, the following steps appear:

Provisioning will provide you with the following available operations:
 
 **Create Account**: Automatically creates a Salesforce account when Salesforce access is granted to the corresponding user in Oracle Identity Cloud Service.
 
 **De-activate Account**: Automatically deactivates or activates a Salesforce account when the Salesforce access is deactivated or activated for the corresponding user in Oracle Identity Cloud Service.
 
 **Delete Account:** Automatically removes an account from Salesforce when Salesforce access is revoked from the corresponding user in Oracle Identity Cloud Service.
 
 Beside this you have the ability to map attributes between the user account fields defined in Salesforce and the corresponding fields defined in Oracle Identity Cloud Service.

* Go to IDCS admin console

* Select the application

* On the Provisioning page, select **Enable Provisioning**.

* A window will pop up. Click “**Grant Consent**”

* Fill in the **Host Name (e.g. acasas-dev-ed.my.salesforce.com), Administrator Username**, **Administrator Password**, **Client ID** and **Client Secret**.

NOTE: Visit [IDCS documentation](https://docs.oracle.com/en/cloud/paas/identity-cloud/uaids/enable-provisioning-app-catalog-application.html) for further information on how to enable provisioning for specific applications.

![](./media/idcs84.png)
<p align="center"> Figure 2-41 </p>

* Click **Test Connectivity** to verify the connection with Salesforce. Oracle Identity Cloud Service displays a confirmation message.

* Scroll down on the Provisioning page, select **Enable Synchronization**.

* Click **Save**

 ![](./media/idcs85.jpeg)
 <p align="center"> Figure 2-42 </p>
 
*  On the applications page, select **Import**.

*  Click on **Import** and wait for a moment

*  Click **Refresh**

*  The imported users that were imported from IDCS will be displayed.

This option will synchronize the existing account details from the application and link them to the corresponding Oracle Identity Cloud Service users.

![](./media/idcs86.png)
<p align="center"> Figure 2-43 </p>


****
**You have successfully connected and provision IDs on third-party app and enable Single Sign-On to easily login to other vendor services.**

***END OF LAB***

[Back to Top](#table-of-contents)   