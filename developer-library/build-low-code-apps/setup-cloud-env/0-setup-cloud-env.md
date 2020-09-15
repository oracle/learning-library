# Setup Cloud Environment

## Before You Begin
### Objectives
- Log into OCI Tenancy.
- Setup Oracle Cloud Infrastructure (OCI) components.  
- Create an Autonomous Transaction Processing (ATP) Database.
- Create an OKE Cluster.
- Create Visual Builder Studio (Developer Cloud Service) instance.
- Create Visual Builder Cloud Service (VBCS) instance.

### Introduction

In Lab 50, you will take on the persona of an Operations Engineer. You will initiate the Oracle cloud environment that will be used to create and deploy your microservices applications. This environment will be contained within a cloud Compartment, and communication within the Compartment will be via a Virtual Cloud Network (VCN). The Compartment and VCN will isolate and secure the overall environment. You will deploy two Oracle Cloud Services for this environment. An Oracle Cloud Developer Image will be used to develop and deploy your microservices code. The microservices will access data within an Autonomous Transaction Processing (ATP) Cloud Service.

To deploy these services, you will use Terraform, a tool for building, changing, and versioning infrastructure safely and efficiently. It is an important tool for anyone looking to standardize IaaS (Infrastructure as a Service) within their organization.

Estimated time: 20 minutes

***We recommend that you create a notes page to write down all of the credentials you will need.***

### Prerequisites
- Your Oracle Cloud Trial Account
- You have already applied for and received your Oracle Cloud Free Tier Account.

*In addition to the workshop*, feel free to watch the walkthrough companion video by clicking on the following image:
[](youtube:wIoLDX7iWXo)


## **STEP 1:** Log into OCI Tenancy

   Log in to your OCI dashboard and retrieve information required to create resources.

1. From any browser go to oracle.com to access the Oracle Cloud.

    [https://www.oracle.com/](https://www.oracle.com/)

  ![](../images/common/login-screen.png " ")

2. Click the icon in the upper right corner.  Click on **Sign in to Cloud** at the bottom of the drop down.   

  ![](../images/common/signup.png " ")   

3. Enter your **Cloud Account Name** in the input field and click the **Next** button.  *NOTE: this is NOT your email. This is the name of your tenancy noted in the email you received during signup. Do NOT click the Sign-In button, this will take you to Single Sign-On, not the Oracle Cloud.*

![](../images/common/cloud-login-tenant.png " ")   

4. Enter your username (this may be your email address) and password and click on **Sign In**.  

![](../images/common/username.png " ")   

5. Once you log in you will see a page similar to the one below. Click on "Infrastructure Dashboard."

  ![](images/landingScreen2.png " ")


## **STEP 2:** Basic OCI Infrastructure setup

  Lets create following components in it's hierarchical order <br/>

   - Compartment <br/>
   - Groups <br/>
   - Policies  <br/>
   - Fingerprint <br/>

   1. Open the navigation menu. Under Governance and Administration, go to Identity and click Compartments. From this screen, you will see a list of compartments, click **Create Compartment**.

   ![](images/OCI-1.png " ")

   ![](images/compartmentScreen.png " ")

  Enter the following:
      - Name: Enter **"AppDev".**
      - Description: Enter a description (required), for example: "AppDev compartment for the getting started tutorial". Avoid                   entering confidential information.
      - Parent Compartment: Select the compartment you want this compartment to reside in. Defaults to the root compartment (or                 tenancy).
      - Click Create Compartment.
      - Your compartment is displayed in the list.

  ![](images/OCI-2.png " ")


  2.  To access Cloud Shell:

      Click the Cloud Shell icon in the Console header. Note that the OCI CLI running in the Cloud Shell will execute commands against         the region selected in the Console's Region selection menu when the Cloud Shell was started.

  ![](images/cloudshell-1.png " ")

  ![](images/cloudshell-2.png " ")

   Execute below commands in cloudshell. We are going generate a public and private key pair.

    ```
    <copy>
    mkdir ~/.oci
    openssl genrsa -out ~/.oci/oci.api.key.pem 2048
    chmod go-rwx ~/.oci/oci.api.key.pem
    openssl rsa -pubout -in ~/.oci/oci.api.key.pem -out ~/.oci/oci.api.key.public.pem
    cat ~/.oci/oci.api.key.public.pem
    </copy>
    ```

  Below are steps for reference

  ![](images/cloudshell-4.png " ")

  ![](images/cloudshell-3.png " ")

Make sure to **copy the generated public key** and paste in a notepad, we will need it for the next step.

  ![](images/cloudshell-5.png " ")

We will also need to copy the generated **private key** and paste it into a notepad, we will use it later on. Enter in the following command:

```
<copy>
cat ~/.oci/oci.api.key.pem
</copy>
```
Make sure to include ----BEGIN RSA PRIVATE KEY---- and ----END RSA PRIVATE KEY----

![](images/privateKey.png " ")

  Now, we need to generate a **fingerprint** againt your user-id, click on right handside top corner user profile icon and go to click your       username

  ![](images/fp-1.png " ")

  Now, scroll down to **API Keys** section and hit **Add Public Key** button to paste the **oci.api.key.public.pem** that you copied

  ![](images/fp-2.png " ")

  ![](images/fp-3.png " ")

  Make sure to copy the **fingerpint** and paste in a notepad, we will use it later in this lab.

## **STEP 3:** Lets create ATP

  1. To create ATP, Click on the hamburger menu icon on the top left of the screen and select **Autonomous Transaction Processing**.

  ![](images/1.JPG " ")

  Make sure you are in the **AppDev** Compartment and click **Create Autonomous Database**.

  ![](images/2.jpg " ")

  2. You should see the Create Autonomous Database screen, here we will specify some configurations:

   -    Verify the correct compartment is selected
   -    Display Name: **ProductCatalog**
   -    Database Name: **product**
   -    Select Transaction Processing
   -    Select Shared Infrastructure
   -    Select a OCPU Count of 1
   -    Select 1 TB of storage
   -    Password: **AppD3v0ps01_**


  ![](images/3.JPG " ")

 ![](images/4.JPG " ")

 ![](images/5.JPG " ")

Click **Create Autonomous Database**. You should be taken to a screen of your ATP provisioning:

![](images/productCatalogATP.png " ")


  3. Now we are going to create another ATP. Click the hamburger menu and Navigate back to the Autonomous Transaction Processing Page and click **Create Autonomous Database**.

  ![](images/ATP2.png " ")

  ![](images/2.jpg " ")

  4. Enter in the following specifications:

   -    Verify the correct compartment is selected
   -    Display Name: **UserCatalog**
   -    Database Name: **user**
   -    Select Transaction Processing
   -    Select Shared Infrastructure
   -    Select a OCPU Count of 1
   -    Select 1 TB of storage
   -    Password: **AppD3v0ps01_**


  ![](images/ATP2Info.png " ")

  ![](images/4.JPG " ")

  ![](images/5.JPG " ")

Click **Create Autonomous Database**. You should be taken to the following screen.

  ![](images/ATPUserCatalog.png " ")

Now you are ready to move on to Step 4.

## **STEP 4:** Lets create OKE

  1.  To create an OKE cluster, open up the hamburger button in the top-left corner of the Console and go to Developer Services >             Container Clusters (OKE).

   ![](images/OKE1.png " ")



  2.  Verify you are in the **AppDev** Compartment and click **Create Cluster**.

  ![](images/createCluster.png " ")

  Choose Quick Create as it will create the new cluster along with the new network resources such as Virtual Cloud Network (VCN), Internet Gateway (IG), NAT Gateway (NAT), Regional Subnet for worker nodes, and a Regional Subnet for load balancers. Select **Launch Workflow**

   ![](images/OKE-2.png " ")


  1.  Keep the name to **cluster1**, choose visibility type to **Public**, change number of nodes to **1**, enable **Kubernetes Dashboard**, and click Next to review the cluster settings

   ![](images/OKE-3.PNG " ")


    Review the the Cluster Creation and then select **Create Cluster**.

   ![](images/OKE-5.png " ")


  4.  Once launched it should usually take around 5-10 minutes for the cluster to be fully provisioned and display an Active. To start working with the Cluster, click  **Access Cluster**.


   ![](images/OKE-4.png " ")

## **STEP 5:** Lets create Visual Builder Studio

   You can create only one **Visual Builder Studio instance** in an Oracle Cloud account. Before you attempt to create an instance make    sure there's no existing Visual Builder Studio instance in your account.

 - On the OCI Console, click Navigation Bar the Menu icon in the top-left corner.

 ![](images/image4b.png " ")

  1.  Under More Oracle Cloud Services, select Platform Services, and then select **Developer**.

  ![](images/image4c.png " ")

  2. In the Instances tab, click **Create Instance**.

  ![](images/image4d.png " ")

  3. On the Create New Instance page, enter in the following specifications then click **NEXT**.

      Instance Name: **AppDev**
      Region: Pick the region where your compartment is

      ![](images/VBCS-5.png " ")

      On the Confirmation page, click **Create**.

      ![](images/VBCS-6.png " ")


 **Create Project and setup OCI Account**

  4. Once the service instance is created, you can open the service console by clicking Action the Action menu icon, and then                selecting **Access Service Instance**.

   ![](images/image4e.png " ")

   The VBS Organization page opens will open. Before we can create a project, we need to configure some OCI connections; select **OCI Account tab**.


   ![](images/VBCS-7.png " ")

   Click **Connect**.

   ![](images/VBCS-8.png " ")

  5. Configure OCI Account Credentials

     To connect to OCI and OCI Object Storage, you will need the following credentials:

     - Tenancy OCID
     - Home Region
     - Compartment OCID
     - User OCID
     - Fingerprint
     - Private Key
     - Storage Namespace


  6. First we will retrieve **Tenancy OCID, Home Region, and Storage Namespace**

  Click on the User Profile Icon in the upper right-hand corner and select **Tenancy:....**


  ![](images/tenancyDetails.png " ")

  Copy down and paste in a notepad the **Tenancy OCID** from the OCID, **Home Region** from the Home Region, and the **Storage Namespace** from the Object Storage Namespace.


   ![](images/44-2.PNG " ")


  7. Now we will retrieve the **User OCID and Fingerprint**.

  Click on the hamburger menu, in Governance and Administration and under Identity select **Users**.

   ![](images/VBCS-9.png " ")

  Click on your username and copy the **OCID** from OCID.

   ![](images/44-4.PNG " ")

   To retrieve the fingerprint of the public key associated with your OCI account, scroll down, select **API Keys** and copy the fingerprint value.

   ![](images/44-5.PNG " ")


  8. We will get the **Compartment OCID**. Click the hamburger menu, under Identity, select **Compartments**.


  ![](images/compartmentOCID.PNG " ")

   Copy the OCID and paste into your notepad.

  ![](images/44-6.PNG " ")


  9. Finally, we will grab the private key.The private key file was generated and saved on your computer when you created the private-public key pair in the PEM format. As you recall, we copied the private key at the beginning of this lab and  pasted it into a notepad. Copy the private key and make sure to include -----BEGIN RSA PRIVATE KEY----- and -----End RSA PRIVATE KEY-----

  10. With all of the necessary information copied, we can go back to VBCS and fill out the Configure OCI Account page. After entering the information, check the Visual Builder Studio Requirements boxy, click **Validate** and then **Save**.


  ![](images/44-7.PNG " ")


## **STEP 6:** Lets create Visual Builder Cloud Service

  1. Navigate back to your Cloud Console and click on the hamburger menu on top left, scroll down to Platform Services, and then click on **Visual Builder**

   ![](images/VBCS-1.png " ")

  2. Click on Create Instance

   ![](images/VBCS-2.png " ")

  3. Give a name for instance, **AppDevVBCSInstance**, and select the region and then click **Next**

   ![](images/VBCS-3.png " ")

  4. Confirm the details and then click **Create**.
     Note: It will take few minutes for instance to provision

   ![](images/VBCS-4.png " ")

**This completes the Lab!**

**You are ready to proceed to** *Lab 1*

## Acknowledgements

- **Authors/Contributors** - Satyajeet Joshi
- **Last Updated By/Date** -
- **Workshop Expiration Date** - May 31, 2021

  ## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.   Please include the workshop name   and lab in your request.
