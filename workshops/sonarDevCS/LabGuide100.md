
## Introduction

Welcome to the Automated Code Inspection workshop. This workshop will walk you through application lifecycle management with embedded code review using SonarQube. It will showcase how SonarQube can save time and improve code quality directly inside the agile development process.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
## Objectives

- Get Started With Developer Cloud Service
  - Create OCI Connection
  - Create project in Developer Cloud Service Instance and configure git
  - Configure Template VM through Developer Cloud Service
  - Design a job and test it by building the application on your Template VM

## Required Artifacts

For this lab you will need Github and Oracle Cloud account Hub Accounts. Use the following links to set up:

## Run a Build Job in Developer Cloud Service

### **STEP 1**: Configure OCI connection in Developer Cloud Service

- Navigate back to your MyServices dashboard by selecting the **Hamburger Menu** and clicking **MyServices Dashboard**.

  ![](images/050/4.png)

- Expand the **Developer Hamburger Menu** and select **Open Service Console**.

  ![](images/100/LabGuide100-502d58d4.png)

- You should see the Developer Cloud Instance you provisioned in the previous lab. Ensure it is in the ready state then click the menu icon to the right of the name and with the options visible select **Access Service Instance**.

  ![](images/100/5.png)

- Now you have landed in the dashboard of your Developer Cloud Service instance. You will notice a warning informing you that you must configure storage to continue with the service. Start the process by clicking **OCI Account** from the horizontal menu below the warning message.

  ![](images/100/6.png)

- Click **Connect** to begin configuring the connection.

  ![](images/100/7.png)

- The next steps will require you to pull information from multiple locations within your Oracle Cloud Trial, ensure that you use a separate tab to gather this info while switching back to the below form to insert the information.

  ![](images/100/7a.png)

- First in the OCI console that you started in (the tab should still be open). Expand the same top left hamburger you used to originally access your Service Dashboard. Scroll down to and hover over **Administration** then select **Tenancy Details**.

  ![](images/100/8.png)

- From this page you can find three of the required items you need to complete the OCI Connection: Tenancy OCID, Home-Region, and Storage Namespace. Copy these three items and paste them into the form one at a time.

  ![](images/100/9.png)

- With all of the tenancy information complete, again expand the hamburger in the top left. This time scroll and hover over **Identity** then select **Users** from the options.

  ![](images/100/10.png)

- Select the user that does NOT begin with **oracleidentitycloudservice/**; it should be just the email address you use to login to the cloud.

  ![](images/100/11.png)

- From the user details page copy the User OCID and paste it into the OCI Connection form.

  ![](images/100/LabGuide100-c5a01c33.png)

- Next you will need to create a fingerprint for the user. But first let's create pem key files.

    **Mac/Linux**:

      - Open a terminal or shell window and run the following commands:

      - Make sure to be in the same directory which you created in lab 050. Use to following command to change directory if not already in it.

        ```bash
        cd /container-workshop/ssh-keys
        ```

      - To generate private pem key use the following command
        ```
        openssl genrsa -out key.pem 2048
        ```

      - To generate public pem key use the following command
        ```
        openssl rsa -in key.pem -outform PEM -pubout -out public.pem
        ```

      - Copy the private key using following command
        ```
        cat key.pem
        ```

    **Windows**:

      -  Download git bash using this link https://gitforwindows.org/

       ```bash
        cd /container-workshop/ssh-keys
        ```

      - To generate private pem key use the following command
        ```
        openssl genrsa -out key.pem 2048
        ```

      - To generate public pem key use the following command
        ```
        openssl rsa -in key.pem -outform PEM -pubout -out public.pem
        ```

      - Copy the private key using following command
        ```
        cat key.pem
        ```


- Paste into the **Private Key** field on the OCI connection form.

  ![](images/100/LabGuide100-2d41b2e5.png)

- Return to the user details page and then select **Add Public Key** from the API keys section.

  ![](images/100/LabGuide100-cd397db8.png)  

- To obtain the fingerprint you must paste the public key into the provided field. Copy the key using following command and paste into the field. then select **Add**.

    ```
    cat public.pem
    ``` 

  ![](images/100/13.png)

- After clicking add you will see a new fingerprint available, copy the fingerprint you just created and paste it into the OCI Connection form.

  ![](images/100/14.png)

- Now you will just need to obtain the Compartment OCID from the compartment you created in Lab 50. Expand the top left hamburger once more scroll to and hover over **Identity** and select **Compartments**.

  ![](images/100/15.png)

- Select the compartment you created in Lab 50.

  ![](images/100/16.png)

- **Copy the compartment OCID** and then paste it into the corresponding field on the OCI Connection form.

  ![](images/100/17.png)

- The form should now be completely filled except for passphrase which you will not use in this workshop. Click **Validate** on the bottom of the form and wait to see that compute and storage connections are successful then click **Save**.

  ![](images/100/18.png)

### **STEP 2**: Create VM Template for Job Execution

- First though you must create a Virtual Machine template. From the same Nav-bar you selected **OCI Connection**, select **Virtual Machine Templates**.

  ![](images/100/19.png)

- Select **Create**.

  ![](images/100/20.png)

- Give the template a name, the guide follows the name **ocivm**. Add a brief description and leave the platform as the default value. Then click **Create**.

  ![](images/100/21.png)

- Once you see the VM click on **Configure Software**.

    ![](images/100/21-1.png)

- Search for Docker and  click on Plus sign for **Docker 1**. It should add the item to the right panel as **Selected Software**. Click **Done**. This will create the template for our workshop

    ![](images/100/21-2.png)

- Next click on **Build Virtual Machines** and then click **create VM**.

    ![](images/100/VM_1.png)

- Select the quantity, template we created, region and shape.

    ![](images/100/VM_2.png)

### **STEP 3**: Create Developer Cloud Project and Configure Git

- Now that you have several of the tools within Developer Cloud Service setup to handle a project, you can create a project within the service. From the nav-bar select **Projects**. Select **Create**.

  ![](images/100/25.png)

- Give the project name **SonarQube_demo** and add a brief description; the remaining values can be left in their default settings. Select **Next**.

  ![](images/100/26.png)

- Select **Empty Project** and click **Next**.

  ![](images/100/27.png)

- You can leave the Wiki Markup field set to Markdown. Select **Finish**.

  ![](images/100/28.png)

- You will see a loading screen showing you all of the services being built into your project for you by Developer Cloud Service. This should take 1 to 2 minutes to complete.

  ![](images/100/29.png)

- You will land in the **Project Home** of your new project. Select the hamburger icon in the top left and then select **Git** from the list of options.

  ![](images/100/30.png)

- Select **Create Repository**.

  ![](images/100/31.png)

- Give your new repo a name, brief description and select **Import existing repository**. In the textbox that appears paste this link https://github.com/varunyn/twitter-feed-sonarQube.git , then select **Create**.

  ![](images/100/32.png)

### **STEP 4**: Configure and Run Successful Build Job

- You will now see the file structure imported from github on your page, its time to build using your VM template. If the side menu is not open, once more select the hamburger from the top left and select **Builds** and then click on **Create Job**

    ![](images/100/33.png)

- Give the job a descriptive name and a brief description. Then select the template you created earlier from the dropdown. With everything filled out, select **Create**.

    ![](images/100/35.png)

- You will be taken to the Job Configuration page for your new job. The first thing you need to is connect the git repo you just established to the job. Select **Add Git** to see the options then select **Git**.

    ![](images/100/36.png)

- Using the repository dropdown select your git repository. Leave everything else as default. Then from the Nav-bar above select **Steps**.

    ![](images/100/37.png)

- Select **Add Step** and from the dropdown select **Maven**.

    ![](images/100/38.png)

- Goals should read **clean install** and POM File should read **pom.xml**. Then in the upper right select save.

    ![](images/100/39.png)

- You will be taken to the home page for the job. Select **Build Now**, this will provision a VM spec'd to your template, using your OCI connection to build the app you have imported from github. While you see **Waiting for executor** the OCI instance is being provisioned, once you see a progress bar then Developer Cloud Service is running the steps you established in your job inside the OCI instance. When complete you should see a check mark next to the job.

    ![](images/100/41.png)

 **You are now ready to move to the next lab: [Lab 200](LabGuide200.md)**
