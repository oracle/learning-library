# Oracle SOA suite

## What is SOA?
SOA, Service Orientated Architecture. It is a style of an enterprise IT design where services are provided to the other components by application components, through a communication protocol over a network. A SOA service is a discrete unit of functionality that can be accessed remotely and acted upon and updated independently, such as retrieving a credit card statement online. These services are representation of multiple applications that each delivers specific business functions. SOA is also an architectural approach to integration and orchestrating these service. Together, the services perform end to end business flow task. SOA is also intended to be independent of vendors, products and technologies

### About Oracle SOA suite
SOA suite is is a comprehensive, standards-based software suite to build, deploy and manage integration following the concepts of service-oriented architecture(SOA). The components of the suite benefit from consistent tooling, a single deployment and management model, end-to-end security and unified metadata management you can skip this module and go straight to Module 2 by clicking the navigation menu icon, in the upper-left corner of the header.

Oracle SOA Suite provides easy-to-use, reusable, and unified application development tooling and life cycle management support to further reduce development and maintenance costs and complexity. Businesses can improve efficiency and agility through rules-driven, process connectivity and automation with Oracle SOA Suite.

SOA Suite functional architecture

>  ![](images/1/soa-architecture.png)

Critical business services, such as customer, financial, ordering information, and others that were previously accessible only in packaged application user interfaces can now be rapidly repurpose for digital-enabled channel such as: smart phone and tablets.

Estimated lab time: 15 minutes

### Objectives

- Introducing SOA development tool, JDeveloper 12c
- Build SOA composite application using JDeveloper
- Design service orchestration using the composite app
- Deploy the composite application to the embedded Weblogic in JDeveloper
  
<!-- ## How to Run the Labs
To run this lab as per instruction provided during live session led by an instructor. 

For participating these labs, you've been granted access to a compute resource via an email invitation or an event code. Please check your inbox email to find details regarding access to a compute resource on Oracle Cloud infrastructure (OCI). -->

<!--Below are steps on how to sign-up for either an Oracle cloud service o. The always free Oracle Compute on OCI is ideal for learning about the Oracle Cloud Infrastructure. This service can readily be upgraded to a paid service as necessary. 

Detail can be found on https://docs.cloud.oracle.com/en-us/iaas/Content/FreeTier/resourceref.htm 


## SOA deployment on Cloud or Data Center
### **Option 1**: To deploy SOA on Oracle Cloud - OCI, use SOA on Oracle Marketplace

To gain access to free tier compute resource, follow these steps:
1.  Please [click this link to create your free account](https://myservices.us.oraclecloud.com/mycloud/signup?language=en&sourceType). When you complete the registration process you'll receive an account with a $300 credit and several "forever free" services that will enable you to complete the lab for free. You can then use any remaining credit to continue to explore the Oracle Cloud. The forever free services will continue to work after the trial expires.

2.  Soon after requesting your trial you will receive a  **Get Started Now with Oracle Cloud** email.   
    Make note of your **Username**, **Password**, and **Cloud Account Name**.

    ![](images/1/get-started-email.png)

3. Now that you have a service, you will log into your Oracle Cloud account so that you can start working with various services.        
    From any browser go to https://cloud.oracle.com/en_US/sign-in.

    Enter your **Cloud Account Name** in the input field and click the **Next** button.

    ![](images/1/enter-oracle-cloud-account-name.png)

4. Enter your **Username** and **Password** in the input fields and click **Sign In**.

    ![](images/1/enter-user-name-and-password.png)

5. From within your Oracle Cloud environment, you can create an instance of Oracle SOA suite.

    From the Cloud Dashboard, select the navigation menu icon in the upper left-hand corner and then select **Marketplace -> Applications**.

    ![](images/1/click-marketplace.png)

6. Click **Search for SOA**.

    ![](images/1/choose-soa-cloud-options.png)

7. Select the **appropriate** option, enter **based on license type or subscription** that you may already have
  * SOA suite BYOL
  * SOA suite with B2B EDI platform
  * SOA suite with OCI as consumption

8. After clicking **SOA suite BYOL**, you will be redirected to the SOA Details page for provisioning new instance. 

    Continue when the status changes from:

    ![](images/1/click-soa-byol-compartment.png)

    
### **Option 2** To deploy Oracle SOA on a nominated data center
Here is the link <a href="https://www.oracle.com/cloud/integration/soa-cloud-service/"> SOA Suite</a>

For details about Oracle SOA
   go to <a href="https://www.oracle.com/cloud/integration/soa-cloud-service/pricing.html"> SOA Cloud Values</a>
-->

## Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
  
## **Summary**

At this point, you're ready to start building amazing enterprise-grade orchestration and integration, rapidly. You may proceed to the lab: **Develop SOA composite for validating payment** by clicking the navigation menu icon, in the upper-right corner of the header.

## Acknowledgements
* **Author for LiveLabs** - Daniel Tarudji
* **Contributors, reviewers** - Tom McGinn, Kamryn Vinson
* **Last review by** - Kamryn Vinson, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.