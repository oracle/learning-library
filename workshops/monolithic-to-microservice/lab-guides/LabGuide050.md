# Monolithic to Microservice Cloud Native Development - Setup Cloud Environment

  ![](images/050/Title.png)

## Workshop Overview

In this workshop you are guided through using many of the Oracle's Cloud Services to support a transition from a monolithic on-prem environment to a Cloud based microservices environment. The high level flow will be:

- Lab 050: Provision supporting services (Client Image, Database, Visual builder Instance).
- Lab 100: Populate your database with seed data.
- Lab 200: Create a Compute Instance and use Docker to deploy a Java based REST application.
- Lab 300: Deploy and explore the REST application into a Kubernetes Cluster.
- Lab 400: Create a Visual Builder mobile application to use the REST endpoints of the Java application.

***To log issues***, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Lab 050 Objectives

- Start up the supporting Client Image
- Create Autonomous Transaction Processing (ATP) Database
- Provision a new Visual Builder Cloud Service and Application

# Infrastructure Setup

You will create all required infrastructure components that support this workshop.

## Startup your Client Image

The client image is a pre-installed Compute Service Instance that has GIT and SQL Developer already installed. You will use VNC Viewer to access this instance.

### Prerequisite

Once the infrastructure is provisioned you can access your enironment using `VNC Viewer`. Please download and install from: <a href="https://www.realvnc.com/en/connect/download/viewer/" target="newwer">VNC Viewer</a>

### **STEP 1**: Access and Register for the Jumpstart Client

- Open the following link in a new tab in your browser. <a href="https://oci.qloudable.com/demoLab/public-preview/24007932-775e-42e6-a4c1-528c39b1b757" target="newwerc">Client Image Link</a>

- Click the **Sign Up** button in the top right corner. _If you already have and account you can proceed to step 2 below._

 ![](images/050/qloudable_signup.png)

- Fill out the required fields and click **Sign Up**.

 ![](images/050/qloudable_form.png)

- You will receive a email asking you to verify your account. Open your email client in a new window and click **Confirm My Account** before proceeding.

 ![](images/050/LabGuide050-1df0ca2e.png)

### **STEP 2**: Start the Jumpstart Client Image

- Navigate back to your browser window. Enter your email address and password and click **Sign In** on the next screen.

 ![](images/050/LabGuide050-ce7c8377.png)

- Click **Demo Lab**.
 ![](images/050/JS3.PNG)

- In **5** minutes the Oracle IaaS infrastructure including the client image will be available. **Leave this browser tab opened** as we will return to it shortly.
 ![](images/050/JS4.PNG)


## Access Your Trial Account

### **STEP 3:** Your Oracle Cloud Trial Account

You have already applied for and received your Oracle Cloud Trial Account.

### **STEP 4**: Log in to your OCI dashboard and Switch Regions

  - Once you receive the **Get Started Now with Oracle Cloud** Email, make note of your **Username, Password and Cloud Account Name**.

    ![](images/050/image1.png)

  - From any browser go to

    [https://cloud.oracle.com/en_US/sign-in](https://cloud.oracle.com/en_US/sign-in)

  - Enter your **Cloud Account Name** in the input field and click the **Next** button.

    ![](images/050/image2.png)

  - Enter your **Username** and **Password** in the input fields and click **Sign In**.

    ![](images/050/image3.png)

  - You are presented with the Oracle Cloud Infrastructure (OCI) Dashboard/Portal

    ![](images/050/image4a.png)

  - To switch Regions, click on the Region Drop-Down in the upper right-hand corner and select **Manage Regions**
  
    ![](images/050/image4b.png)

  - On the Tenancy page, click on the **Subscibe To This Region** button for the **us-phoenix-1** Region
  
    ![](images/050/image4c.png)

  - Click **OK** to confirm the subscribtion to the region.
  
    ![](images/050/image4d.png)

	**NOTE:** Refresh the Page to verify the Region is now Active (Green Circle).  The subscribtion can take 1 minute to occur.
	
  - Once the Region is Active (Green Circle), click on the Region Drop-Down in the upper right-hand corner and select **us-phoenix-1**

    ![](images/050/image4d1.png)
	
    ![](images/050/image4e.png)

### **STEP 5**: Create a Compartment

Compartments are used to isolate resources within your OCI tenant. User-based access policies can be applied to manage access to compute instances and other resources within a Compartment.

  - Click the **Menu icon** in the upper left corner to open the navigation menu. Under the **Governance and Administration** section, select **Identity** and select **Compartments**.

    ![](images/050/image6a.png)

    ![](images/050/image7a.png)

  - Click **Create Compartment**

    ![](images/050/image8.png)

  - In the **Name** field, enter `monoTOmicro`. Enter a **Description** of your choice. Click **Create Compartment**.

    ![](images/050/image9.png)

  - In a moment, your new Compartment will show up in the list.

    ![](images/050/image10a.png)

## Autonomous Transaction Processing (ATP) Database Creation
	
### **STEP 6**: Create an Autonomous Transaction Processing (ATP) Database

We require a Database to store the Alpha Office data which is accessed later in this workshop.  We will create an Autonomous Transaction Processing (ATP) Database to load data into.  Autonomous Transaction Processing is one of a family of cloud services built on the self-driving, self-securing, and self-repairing Oracle Autonomous Database.  Autonomous Transaction Processing uses machine learning and automation to eliminate human labor, human error, and manual tuning, delivering unprecedented cost saving, security, availability, and production. Autonomous Transaction Processing supports a complex mix of high-performance transactions, reporting, batch, IoT, and machine learning in a single database, allowing much simpler application development and deployment and enabling real-time analytics, personalization, and fraud detection.

  - Click the **Menu icon** in the upper left corner to open the navigation menu. Under the **Database** section of the menu, click **Autonomous Transaction Processing** .

    ![](images/050/image11a.png)

  - Select the **Compartment** `monoTOmicro` and click **Create Autonomous Transaction Processing Database**.

    ![](images/050/image12.png)

  - Select the **Compartment** `monoTOmicro` if it is not already selected. Enter the **Display Name** `AlphaOffice`, **Database Name** `orcl`, enter the **Administrator Password** of `a1phaOffice1_` and Click **Create Autonomous Transaction Processing Database**

    ![](images/050/image13.png)

    ![](images/050/image14.png)

  - After approximately 5 minutes, the ATP instance will be provisioned. You can immediately proceed to the next section.

    ![](images/050/image15.png)

## Visual Builder Instance Creation

### **STEP 7**: Create a New Visual Builder Cloud Service

In this step you will create a VBCS instance that will be used in Lab 400. It takes about 20 minutes for the underlying infrastructure to be created. We just need to fire off the create instance process at this point. We'll check the status of the instance at the beginning of Lab 400.

- From your `Original login page` goto the My Services dashboard by clicking on the hamburger menu in the upper left hand side of the page and selecting **Administration-->My Services Dashboard**

  ![](images/050/LabGuide50-vbcs1a.png)

  ![](images/050/LabGuide50-vbcs2a.png)

- You are now in the Traditional Dashboard:

  ![](images/050/cloud_dash.png)

- Click the **Customize Dashboard** panel.

  ![](images/050/custom_dash.png)

- Then select `Visual Builder` and click the **Show** button.

  ![](images/050/show_dash_vb.png)

- You should see the following added to your dashboard:

  ![](images/050/LabGuide50-80c36c4c.png)

### **STEP 8**: Create a New Visual Builder Instance

- In the Visual Builder panel click the **hamburger menu**, right-click **Open Service Console** and select **Open link in new tab**.

  ![](images/050/LabGuide50-6196f9d1.png)

- Next, click the **Create Instance** button.

  ![](images/050/LabGuide50-11580389.png)

- On the next screen set your `Instance Name` to:

  ```
  monoTOmicro
  ```

- Enter a `Description` and for the `Region` select the same region you chose for the ATP database. **In this example us-phoenix-1**. Click **Next**.

  ![](images/050/LabGuide50-vbcs3.png)

- Review your information and press **Create**.

  ![](images/050/LabGuide50-vbcs4.png)

- You will see the following screen once your request is submitted. The refresh button can to used to update the provisioning status:

  ![](images/050/LabGuide50-fcc49616.png)

- You can immediately proceed to the next section. We will check for completion at the beginning of Lab 400.

  ![](images/050/LabGuide50-vbcs5.png)

## Access Your Client Environment

### **STEP 9**: Access Client Image

- Back at the Demo Lab browser tab (that you left opened)... when the environment is ready you will see the following along with the connect string to use in VNC Viewer. (In this example 129.213.167.192:10.)

  **NOTE: Your IP address will be different**

  **Also NOTE: The screen resolution on VNC port :10 is 1920x1200. If you would prefer to use a smaller resolution of 1680x1050 then use port :11 instead. `Example: 129.213.167.192:11`**

  ![](images/050/JS6.PNG)

- **NOTE: You have 7 hours** before the environment will go away.

  ![](images/050/JS7.PNG)


### **STEP 10**: Start VNC Viewer

Use VNC Viewer to connect to your provisioned account.

- Enter the connect string you were given and hit **Return**. (Example Shown below).

**NOTE: Do NOT click the Sign In button**

  ![](images/050/JS8.PNG)

- If presented with this prompt, click **Continue**.

  ![](images/050/JS9.PNG)

- Enter the VNC password  **Oracle123** and click **OK**.

  ![](images/050/JS10.PNG)

- Your Desktop is displayed:

  ![](images/050/JS11.PNG)

**This completes the Lab!**

**You are ready to proceed to [Lab 100](LabGuide100.md)**
