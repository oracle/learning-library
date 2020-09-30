
![](images/100/Picture100-lab.png)  
Updated: August 22, 2018

## Introduction

This is the first of several labs that are part of the **Oracle Public Cloud WLS On-Prem to Cloud Workshop.** This workshop will walk you through the movement on a Java EE application from your on-prem WLS environment to Oracle's Cloud.

You will take on 2 Personas during the workshop. The **Lead DevOps Engineer Persona** Chip, who manages a team of developers writing and maintaining production applications and Richard **Infrastructure engineer** persona who's current challenge is providing the resources to host current applications on-premises.


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
### **STEP 1**: Acquire an Oracle Cloud Trial or Workshop Account

- Bookmark this page for future reference.

- Please click on the following link to create your Free Account, and complete all the required steps to get your free Oracle Cloud Trial Account. When you complete the registration process you will receive a $300 credit that will enable you to complete the lab for free. Additionally, you will have 1000s of hours left over to continue to explore the Oracle Cloud.

    - Soon after requesting your trial you will receive the following email. You may begin working on Lab 100 before you receive this email, but you will not be able to start Lab 200 until you have received it.

    ![](images/100/100_1_1.png)

    ***setup a password***

### **STEP 2**: Login to your Oracle Cloud Account
- From any browser, go to the URL:
    `https://cloud.oracle.com`

- click **Sign In** in the upper right hand corner of the browser

    ![](images/100/Picture100-1.png)


- Enter your identity domain and click **My Services**

    **NOTE:** The **Identity Domain** should come from your Trial confirmation email.

    ![](images/100/LabGuide100-067ce155.png)

- Once your Identity Domain is set, enter your User Name and the Password you set after your confirmation e-mail and click **Sign In**

    ![](images/100/LabGuide100-938844ff.png)


    ![](images/100/Picture100-3.5.png)

- You will be presented with a Dashboard displaying the various cloud services available to this account.

    ![](images/100/LabGuide100-63e3321e.png)

- If all your services are not visible, **click** on the **Customize Dashboard**, you can add services to the dashboard by clicking **Show.** For this workshop, you will want to ensure that you are showing at least the **Java, Application Container, Database and Storage Classic** cloud services. If you do not want to see a specific service, click **Hide**

    ![](images/100/LabGuide100-59574863.png)

    ![](images/100/LabGuide100-7f4bb05a.png)

    ![](images/100/LabGuide100-9a5951ea.png)

In order to complete the remaining migration labs, we will first create our on-prem application.  We have a pre-created image with an embeded Weblogic Server which will be used for this process.  To import this image, we must first create a network (VNC) that will allow you access into your image and a compartment which will contain your instances.


### **STEP 3**: Create Network and Compartment on OCI
- Click Compute from the Customize Dashboard or from Services. After that from the Menu Click Identity and Compartments. 
  
  ![](images/100/LabGuide100-CreateCompartment.png)

- Click Create Compartments button to create a Compartment called WebLogicLab.
  
  ![](images/100/LabGuide100-CreateCompartment2.png)

- You can see the recently created WebLogicLab Compartment in  Compartments.
  
  ![](images/100/LabGuide100-CreateCompartment3.png)

- Click Compute from the menu and click Custom Images.
  
  ![](images/100/LabGuide100-CustomImages.png)

### **STEP 4**: Import Custom Image

- Click Import Image button and fill name of import image and  **copy** object storage URL.
  https://objectstorage.us-ashburn-1.oraclecloud.com/p/0wZwJGDzVjygLdY2mMWO6L32dzCO0CxQ2k-c1T3liMI/n/gse00015058/b/PlaceForImages/o/Nov7JDevImage

   After that, click Import Image.
  
![](images/100/LabGuide100-ImageImport.png)

- You can see your WeblogicOnPrem Image is importing.
  
![](images/100/LabGuide100-ImageImport2.png)

- Later you can is your WeblogicOnPrem Image is up and available to use.
  
![](images/100/LabGuide100-ImageImport3.png)

### **STEP 5**: Create Instance

- From the Custom Images page, select WeblogicOnPrem image and click Create Instance
  
  ![](images/100/CreateInstanceOnImage.png)

- Click Create Instance button after completing required name for the instance.

  ![](images/100/CreateInstance1.png)

- If you do not have SSH key file, open a terminal window (by right clicking on the desktop and and selecting Open Terminal) and run each of the following commands, one at a time, pressing Enter between each one. These commands will create a new directory called .oci, generate a new PEM private key, generate the corresponding public key, and copy the public key to the clipboard.
  
  ```bash
mkdir ~/.oci
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
cat ~/.oci/oci_api_key_public.pem
```

  ![](images/100/CreateInstance2.png)
  ![](images/100/CreateInstance3.png)

- You can see your WebLogicLabInstance is provisioning.
  
  ![](images/100/ProvisioningInstance.png)

- Then you can see your instance is up and running.
  
  ![](images/100/RunningInstance.png)

- You can connect to the image instance using the public ip Address (Mac Clients).
  
  Example: vnc://132.145.175.73:5910
  Password: Oracle123

- You can connect to the image instance using the public ip Address (Windows Clients).
  
  If you do not have VNC Viewer, you can download it from here. <a href="https://www.realvnc.com/en/connect/download/viewer/windows/" target="_trial">Download VNC Viewer</a>.
  
  Enter public ip address and port 5910 as follows.
  ![](images/100/vnc1.png)

  Click continue to connect.
  ![](images/100/vnc2.png)

  You can view your up and running instance as follows.
  ![](images/100/vnc3.png)
  
### **STEP 6**: Open JDeveloper Environment

- Click JDeveloper icon to open JDeveloper Environment

 ![](images/100/ImageWelcome.png)

- Select Java EE Developer option
  
 ![](images/100/j2eesettings.png)
  
- You have JDeveloper Environment is ready to use
  
  ![](images/100/JDeveloper.png)
