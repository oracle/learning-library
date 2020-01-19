![](./media/securitytitle.png)
# Lab 2:  Oracle CASB Cloud Service

## Table of Contents

- [Module 1: Logging to CASB Community Tenant](#module-1--logging-to-casb-community-tenant)
- [Module 2: Oracle CASB Monitoring Oracle Cloud Infrastructure](#module-4--oracle-casb-monitoring-oracle-cloud-infrastructure)
- [Module 3: Create a Policy for OCI](#module-5--create-a-policy-for-oci)
- [Module 4: Run a Report in CASB](#module-6--run-a-report-in-casb)


***** 

**Disclaimer:  This lab is designed ONLY for large learning groups and assumes the groups are sharing the Oracle Cloud environment to execute this lab.**


## Mama Maggy's security monitoring business needs for SaaS and OCI

Shannon Kim, Director/Manager of IT is seeking to improve the security monitoring capabilities across On-Premise and Cloud services.
Security Operation Center is overwhelmed because of the number of alerts receive daily. They are barely able to respond on time and proactively identify a threat.
Security might sound as a stopper for the users, but she needs to introduce a solution that helps both, Line-of-Business and IT to keep the environment safe, available and without introducing radical changes to the user experience.
The organization needs to shift from a reactive to a proactive approach. That's why Mamma Maggy as opts for Oracle CASB Cloud Service. CASB Keeps enterprises secure by automating responses to threats with forensics, incident management, orchestration and remediation through native capabilities as well as integration with existing technologies.
Security evolves to become a business enabler and she knows that the best fit to meet this requirement is Oracle CASB Cloud Service.
Her team is on its way of implementing CASB to monitor SaaS applications and OCI. You as the SOC Manager have to integrate these services with the solution and put them ready to reduce no only the amount of alerts received, but human intervention.



## **EXERCISE** - Module 1:  Logging to CASB Community Tenant

**Who Should Complete This Lab:  1 Participant for group**


*	We are purposefully using our “shared” tenant instead of the tenant associated with the Cloud Account. 
*	The shared tenant is a persistent sandbox environment where Oracle employees can try out CASB features.
* Open your browser to the CASB instance: https://preprod.casb.ocp.oc-test.com/
* Login to CASB using the Tenant shared admin account

**NOTE: Tenant User id and Password will be delivered by the instructor**

![CASB Console](./media/casb_login1.png)
<p align="center"> Figure 1-1 </p>  

* Click the following in sequence as shown in the image to navigate to the administration dashboard

![CASB Console](./media/casb_login2.png)
<p align="center"> Figure 1-2 </p>

*	Add your First, Last and email address (highlighted in yellow). Leave Role as “Tenant Admin” and click “Save”. 

![CASB Console](./media/casb_login3.png)
<p align="center"> Figure 1-3 </p>

* You should receive an email within a few minutes.

![CASB Console](./media/casb_login3.png)
<p align="center"> Figure 1-4 </p>

* Now you are CASB Tenant administrator. Use your recently created account to login to Oracle CASB Cloud Service


**Note: Due to environment constraints you might not receive the email. Please proceed with the shared id delivered by the facilitator**


## Module 2:  Oracle CASB Monitoring Oracle Cloud Infrastructure


Oracle CASB has the broadest support of infrastructure as cloud services (IaaS). It enables you to monitor infrastructure provided by Amazon Web Services, Microsoft Azure, and Oracle Infrastructure Cloud (OCI). With Oracle CASB you can monitor all layers of your IT.
 
To monitor OCI, CASB requires credentials with the appropriate OCI access. This section explains how to complete these steps. To accomplish this you’ll first need to create an account, group and policy within OCI. As a part of those steps you will require a signed RSA key.
 
Once you have the OCI credentials, then you’ll register the OCI tenant within Oracle CASB for monitoring. Please follow the steps below to complete the registration process.

### **DEMO** - Register OCI tenant

**NOTE: due to capacity constraints, Instructor will guide you through the process of registering OCI tenants in CASB. Learners will use this App for the incoming labs**

* First, sign into your cloud account

![](./media/image81.jpeg)
<p align="center"> Figure 4-1 </p> 

* Go to the dashboard
    
    *  Click on the menu in the bottom left corner of the cloud service ![](./media/image82.png)
    *  Click Open Service console

![](./media/image83.jpeg)
<p align="center"> Figure 4-2 </p> 
 
Note: if you do not see any Compute instance in the dashboard, click to Customize Dashboard and select Show for Compute.

* Click on the Navigation ![](./media/image2.png) menu at the top left to add users


* Scroll down, click on Identity Users

  ![](./media/image84.jpeg)
  <p align="center"> Figure 4-3 </p> 

*  Click create user

![](./media/image85.jpeg)
<p align="center"> Figure 4-4 </p> 

*  Populate fields as shown below.

*  Click Create

  ![](./media/image86.jpeg)
  <p align="center"> Figure 4-5 </p> 

*  Click Groups in the left hand menu
    
    *  Click Create Group button
    
    *  Populate name and description fields as shown below
    
    *  Click Submit

  ![](./media/image87.jpeg)
  <p align="center"> Figure 4-6 </p> 

*  Click Policies in the left hand menu
    
    * Select Compartment from the dropdown menu
    
    * Click on the root compartment. In order to create the policy, it must be on the root compartment.

  ![](./media/image88.jpeg)
  <p align="center"> Figure 4-7 </p> 

*  Create the policy
    
  * Click create policy
    
  * Populate fields as shown below
  
  * On the policy statement field, add the following line "Allow group 
  *name_of_the_group_you_created* to read all-resources IN TENANCY" 
    
  * Click Create
    ![](./media/image89.jpeg)
    <p align="center"> Figure 4-8 </p> 

*  Click on **Groups**
    
  * Click on the group we just created
    
  * Click Add user to Group (to the previously created CASB group)
    
  * Select user created previously(**MY_CASB_ACCOUNT**) and click add

 ![](./media/image90.jpeg)
<p align="center"> Figure 4-9 </p> 

* Now you have to create a new key pair. Ensure that you have a public/private key pair available for use by Oracle Cloud Infrastructure (OCI) before you prepare and register an OCI instance to be monitored by Oracle CASB Cloud Service.
    
    * In Oracle CASB, select Configuration from the Navigation menu. If the Navigation Menu is not displayed,click the Navigation Menu icon in the upper left corner ![](./media/image2.png)
    
    
    * From the Configuration submenu, select **CASB Key-Pair Management**.
    
    * If the Key generation date is not new enough, according to your organization's security policies, click Create new keys.
    
    * Click Generate new keys.

    * The User public key field is updated with a new key value. ![](./media/image91.png)
  

* Click Copy to Clipboard icon to copy the User public key value to the clipboard. ![](./media/image92.png)


* You can also use the Download icon to download the public key to a file.
![](./media/image93.jpeg)
<p align="center"> Figure 4-10 </p> 

*  Go to OCI, Click Identity and then Users
    
  * Click on the user we previously created.
    
  * Add a public key we generated to the user
    
  * Click on API Keys
    
  * Click on Add Public Key
  ![](./media/image94.jpeg)
  <p align="center"> Figure 4-11 </p> 

* Copy/Paste the public key from CASB into OCI.
    
    * Include the lines “Begin Public Key” and “End Public Key”
    
    * Click Add

![](./media/image95.jpeg)
<p align="center"> Figure 4-12 </p> 

###  **DEMO** - Register OCI in CASB to monitor activity

* Open a new tab on your browser and go to the Oracle CASB dashboard

* Select Applications from the Navigation menu in the upper left corner ![](./media/image2.png)

* Click Add/Modify App

* Select OCI and Click Next (bottom right corner of the screen)

  ![](./media/image96.jpeg)
  <p align="center"> Figure 4-13 </p> 

* Enter unique name into the field for your OCI instance. Then click Next

![](./media/image97.jpeg)
<p align="center"> Figure 4-14 </p> 

* As you can see, you can add three types of OCI instances in Oracle CASB Cloud Service, based on the type of OCI compartment that is monitored:

![](./media/image98.jpeg)
<p align="center"> Figure 4-15 </p> 

  - **OCI Tenancy** - the root compartment that contains all of your
    organization's compartments and other Oracle Cloud Infrastructure
    cloud resources. Everything in all compartments and sub-compartments
    is monitored.

  - **Compartment under a registered Tenancy** - a specified compartment
    under a registered OCI tenancy. Only the collection of related
    resources within the specified compartment, which are accessible
    only by certain groups that have been given permission by an
    administrator in your organization, are monitored.

  When you register a compartment inside a tenancy that is already
  registered in Oracle CASB Cloud Service, the compartment inherits
  access credentials from the parent tenancy, so you only have to
  specify the compartment name.

  - **A Standalone Compartment** – an OCI compartment that is accessed
    directly, without first registering the OCI tenancy in Oracle CASB
    Cloud Service. As with a compartment under a registered tenancy,
    only the collection of related resources within the specified
    compartment, which are accessible only by certain groups that have
    been given permission by an administrator in your organization, are
    monitored.

  In our case, we will select the first option.

* Go to OCI

* Copy Tenancy OCID and paste into Tenancy OCID field.

* To get the tenancy OCID from the Oracle Cloud Infrastructure Console, go to the Tenancy Details page:

  Open the navigation menu, under Governance and Administration, go to **Administration** and click **Tenancy Details.**
  
  ![](./media/image99.jpeg)
  <p align="center"> Figure 4-16 </p> 
  
  The tenancy OCID is shown under **Tenancy Information**. Click **Copy** to copy it to your clipboard.
  
  ![](./media/image100.jpeg)
  <p align="center"> Figure 4-17 </p> 

* Get the user's OCID in the Console on the page showing the user's details. To get to that page:
    
    * If you're signed in as the user: Open the **User** menu ) in the upper right corner and click **User Settings**. ![](./media/image101.png)
    * If you're an administrator doing this for another user: Open the navigation menu. Under **Governance and Administration**, go to **Identity** and click **Users**. Select the user created from the list (MY_CASB_ACCOUNT).

![](./media/image102.jpeg)
<p align="center"> Figure 4-18 </p> 

* Now back to the OCI app in Oracle CASB. Ensure all of the fields are populated with the Tenancy OCID and User OCID credentials as shown below:
    
    * Click test credentials. You have to receive the green notification that the direct connection was initiated successfully before the submit button will appear.
    
    * Click **Submit**

![](./media/image103.jpeg)
<p align="center"> Figure 4-19 </p> 

* You should see the screen above.

    * Click **Done**
  
  ![](./media/image104.jpeg)
  <p align="center"> Figure 4-20 </p> 

[Back to Top](#table-of-contents)

****

## **EXERCISE** - Module 3:  Create a Policy for OCI 

**Who Should Complete This Lab:  1 Participant for group**
 
You’ll now create a policy in Oracle CASB that triggers a policy alert every time a user is created in OCI.

### Create a policy

*  Click on Configuration (Left-hand menu)
    
    * Select Policy Management

![](./media/image55.jpeg)
<p align="center"> Figure 5-1 </p> 

*  Click New Policy
    
    * Fill out the fields as shown below. For the purpose of this lab we recommend you to use the following name convention for policies: COSE_FIRST-LETTER-OF-YOUR-NAME_LASTNAME_APPLICATION *(e.g. COSE_ACASAS_OCI)*
  
    * Click Next

![](./media/image105.jpeg)
<p align="center"> Figure 5-2 </p> 

*  On the Application Instance option select **COSE_OCI_OSPATEE_ACASAS**

NOTE: For demo purposes we will use **COSE_OCI_OSPATEE_ACASAS** instance to trigger the alert

* On the Resource section select **Identity Users**

* Check the **Regular Expresion** option  

* On the regular expresion field enter .*

* Click **Next**


![](./media/image106.png)
<p align="center"> Figure 5-3 </p> 

*  Leave UserName settings by default. Click **Next**

![](./media/image107.jpeg)
<p align="center"> Figure 5-4 </p> 

*  Leave Condition settings by default. Click **Next**

![](./media/image108.jpeg)
<p align="center"> Figure 5-5 </p> 

*  Populate fields as shown below. Click Next.

 ![](./media/image109.jpeg)
 <p align="center"> Figure 5-6 </p> 

*  Review details previously entered. Click Submit.
![](./media/image110.jpeg)
<p align="center"> Figure 5-7 </p> 

*  Your screen should show the green notification that a new policy has been added.

![](./media/image111.jpeg)
<p align="center"> Figure 5-8 </p> 

### **DEMO** - Trigger the policy that we created

*  In the OCI Console under the compute tile press the menu for Compute ![](./media/image82.png)

    
* Click Open Service Console
    
![](./media/image112.jpeg)
<p align="center"> Figure 4-9 </p> 

* Open the Navigation menu in the top left corner
    
    *  Navigate to Identity ![](./media/image2.png)    
    *  Click Users
    
    ![](./media/image113.jpeg)
    <p align="center"> Figure 5-10 </p> 

* This will take you to the create user screen. Click Create User

![](./media/image114.jpeg)
<p align="center"> Figure 5-11 </p>


* Name your user and fill out the description. The rest can remain blank. Press Create

![](./media/image115.jpeg)
<p align="center"> Figure 5-12 </p>

***YOU HAVE NOW CREATED A USER WHICH WILL TRIGGER THE CASB USER POLICY***

 ![](./media/image116.jpeg)
 <p align="center"> Figure 5-13 </p>

* After some minutes, you will be able to see the policy alert in the Oracle CASB dashboard. Go to Applications and click to the OCI recently added instance to see the health summary

![](./media/image117.jpeg)
<p align="center"> Figure 5-14 </p>

* As you can see, there is a policy alert. Click on View Details to see the specifics of the user creation event.

![](./media/image118.jpeg)
<p align="center"> Figure 5-15 </p>

[Back to Top](#table-of-contents)

****

## **EXERCISE** - Module 4:  Run A Report in CASB 

**Who Should Complete This Lab:  1 Participant for group**

Oracle CASB offers a variety of predefined reports providing detailed insight into potential security risks. Unless noted otherwise, reports
by default display three days of data, with up to 90 days of data available.

### Run a report

*  Open the Navigation menu in the top left corner of the CASB Dashboard ![](./media/image2.png)
    
    *  Click Reports

![](./media/image119.jpeg)
<p align="center"> Figure 6-1 </p>

*  Scroll down to Oracle Cloud Infrastructure Privileged IAM changes –
    Users and Groups
    
    * Double click the name or press the play button on the report you
        want to run

![](./media/image120.jpeg)
<p align="center"> Figure 6-2 </p>

* You will now be presented with your report findings

![](./media/image121.jpeg)
<p align="center"> Figure 6-3 </p>

[Back to Top](#table-of-contents)


****
**You have successfully connected and monitor third-party apps and OCI with Oracle CASB Cloud Service.**

**Now that you have completed this Hands-on lab, each group must remove the registered third-party apps (Salesforce and Box) in CASB.**

* Click on main menu and applications
* Search the application registered during the exercises (e.g. COSE_AU1_BOX_G1)
* Left click on the application
* Select **Remove**

![](./media/CASB_delete.png)
<p align="center"> Figure Appendix 1 </p>

* Confirm by clicking **OK**.

![](./media/CASB_delete_2.png)
<p align="center"> Figure Appendix 2 </p>

* Repeat above steps for every application registered during the lab

***END OF LAB***

[Back to Top](#table-of-contents)   
