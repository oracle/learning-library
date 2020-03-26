# DevOps: JCS Pipeline Using Oracle Stack Manager

![](image/200_IL/Picture200-title.png)

Update: October 19, 2017

## Introduction

This is the second of several labs that are part of the **DevOps JCS Pipeline using Oracle Stack Manger workshop**. This workshop will walk you through the Software Development Lifecycle (SDLC) for a Java Cloud Service (JCS) project that goes through Infrastructure as Code and deployment of a Struts application.

In the first lab (100), the Project Manager created a new project in the Developer Cloud Service, created and assigned tasks to the developers of this application. In this lab, you will assume the persona of Operations, who will be tasked with creating an Infrastructure as Code pipeline for the provisioning of Alpha Office Java Cloud Service (JCS) environment.

***To log issues***, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Objectives

- Access Developer Cloud Service
- Import configuration from external Git Repository
- Build Infrastructure as Code pipeline
- Check in new template file
- Import Project into Eclipse
- Check in configuration file to provision new JCS environment.

## Required Artifacts

- The following lab requires an Oracle Public Cloud account that will be supplied by your instructor. You will need to download and install latest version of Eclipse or use supplied compute VM.

# Create Initial Git Repository for Infrastructure

## Create Initial Git Repository

 Although you will remain connected to the Oracle Cloud using the user account you were provided, you are to take on the Persona of ***Bala Gupta*** as you perform the following steps. Bala is our operations engineer and will be handling all operations issues.

![](images/bala.png)

### **STEP 1:** Update Issue Status

- From the left have navigation panel, select **Agile** , then click on the **AlphaOffice** Board **Active Sprints**.

    ![](image/200_IL/Picture200-1.png)

- Drag and drop **Task1 - Create Initial GIT Repository for Infrastructure and configure build** into the **In Progress** swim-lane.

    ![](image/200_IL/Picture200-2.png)

- Leave the defaults, and click **OK** on the **Change Progress** popup.

    ![](image/200_IL/Picture200-3.png)
    ![](image/200_IL/Picture200-4.png)

### **STEP 2:** Create Repository

- In the left hand navigation panel, click **Project**.

- Click on **New Repository** to create a new Git Repository.

    ![](image/200_IL/Picture200-5.png)

- In the New Repository wizard enter the following information and click **Create**.

    **Name:** `JCSStackAlphaInfrastructure`

    **Description:** `JCS Stack Alpha Office Infrastructure`

    **Initial content:** `Import existing repository`

    **Enter the URL:** `https://github.com/pcdavies/JCSStackAlphaInfrastructure`

    ![](image/200_IL/Picture200-6.5.png)

- You have now created a new GIT repository based on an existing repository.

    ![](image/200_IL/Picture200-7.png)

## Create Default Build for Template Upload

**Oracle Cloud Stack Manager** is a feature of Oracle Cloud that allows for the provisioning of multiple services within the Oracle Cloud. In order to build and deploy their applications, businesses often require sophisticated environments that consist of multiple, integrated cloud services. Consider a development environment whose needs include a Java application server along with a relational database. Provisioning each of these services for every member of your development team is time consuming and error prone, regardless of whether you’re using service consoles or REST APIs to provision the services. Oracle Cloud Stack Manager uses templates to provision a group of services (called a stack) and in the correct order.

### **STEP 3:** Create Template Update Build Process

Now that we have the configuration code in our managed GIT repository, we need to create a build process that will be triggered whenever a commit is made to the master branch. This build process will trigger any time the Alpha Office Stack template is modified and upload a new version via PSMcli (PaaS Service Manager command line interface) to the Oracle Cloud.

- On navigation panel, click **Build** to access the build page and click **New Job**.

    ![](image/200_IL/Picture200-8.png)

- In the New Job popup enter **Infrastructure Update Template** for the Job Name, and then click **Save**.

    ![](image/200_IL/Picture200-9.png)

- You are now placed into the job configuration screen.

    ![](image/200_IL/Picture200-10.png)

- Click the **Source Control** tab. Click **Git** and select **JCSStackAlphaInfrastructure.git** from the drop down.

- Under the **Branches** section, expand the **Advanced Git Settings** and enter `Alpha-JCS-DBCS-Template.yaml` in the **Included Regions** field.

    ![](image/200_IL/Picture200-11.png)

- Click the **Triggers** tab. Select **Based on SCM polling schedule**.

    ![](image/200_IL/Picture200-15.png)

- Click the **Build Steps** tab. Click **Add Build Step**, and select **InvokePSMcli**.

    ![](image/200_IL/Picture200-12.png)

- Enter your Oracle Cloud credentials given to you by the instructor or Trail confirmation email. Ensure that you enter the correct values for **Username**, **Password** and **Identity Domain**. Note that the default set for the **Region** may not be correct, and must be properly set. The value for the **Output Format** should be set to **JSON**.

    ![](image/200_IL/Picture200-12.2.png)

- Next we will add a second build step. Click **Add Build Step** and select **Execute Shell**

    ![](image/200_IL/Picture200-12.4.png)

- Enter the following PSM CLI call for the **Execute Shell Command:**

```bash
psm stack import-template -f Alpha-JCS-DBCS-Template.yaml -of json
```

![](image/200_IL/Picture200-12.6.png)

- Click **Save** to complete the configuration.

- Click the **Build Now** button to start the build. This will trigger for the build to be placed in the queue and should start shortly.

    ![](image/200_IL/Picture200-14.png)

- Once the build has completed you should see a green check.

    ![](image/200_IL/Picture200-16.png)

- If you want to view the results or debug a failure click on the **Console** link.

    ![](image/200_IL/Picture200-17.png)

### **STEP 4:** Verify Template Upload to Oracle Cloud

- Now we will navigate to the Oracle Stack Manager console to view the newly uploaded template. Click back on the browser tab that you launched the Developer Console. Click on the far left navigation icon ![](images/Menu.png) and select **Database**

    ![](image/200_IL/Picture200-18.png)

- Click on the far left navigation icon and select **Oracle Cloud Stack**

    ![](image/200_IL/Picture200-19.png)

- From this service console you are able to manage and monitor all your **Stacks** and **Templates**.

    ![](image/200_IL/Picture200-20.png)

- Click on **Templates**. You should see your newly uploaded template **Alpha-JCS-DBCS-Template** along with the default templates supplied by Oracle.

    ![](image/200_IL/Picture200-21.png)

- Click on **Alpha-JCS-DBCS-Template** to view details about your template. The **Topology** gives you a graphical view of the Stack.  Our template has **JCS**, **DBCS** and **Storage Cloud** (backupContainer).

    ![](image/200_IL/Picture200-22.png)

- If you click **Template** section you can view the entire template file.

    ![](image/200_IL/Picture200-22.5.png)

- Click **Done** to close the Template.

## Create Default Build for Stack Create

### **STEP 5:** Create Stack Create Build Process

Now we will create a build process that will provision a new Oracle Stack every time a change is made to a configuration file.  This File will define the need parameters to create unique environment using Oracle Stack Manager based on the newly uploaded template **Alpha-JCS-DBCS-Template**.

- Back in the Developer Cloud Service, click **Build**, followed by clicking **New Job**.

    ![](image/200_IL/Picture200-26.png)

- In the New Job popup, leave the **Create a free-style job** selected and enter `Infrastructure Create Stack` for the Job Name, and then click **Save**.

    ![](image/200_IL/Picture200-27.png)

- You are now placed into the job configuration screen.

    ![](image/200_IL/Picture200-28.png)

- Click the **Source Control** tab. Click **Git** and select **JCSStackAlphaInfrastructure.git** from the drop down. Expand **Advanced Git Settings** and enter `JCSBuild.conf` in the **Included Regions** field.

    ![](image/200_IL/Picture200-29.png)

- Click the **Triggers** tab. Select **Based on SCM polling schedule**.

    ![](image/200_IL/Picture200-30.png)

- Click the **Build Steps** tab. Click **Add Build Step**, and select **Invoke PSMcli**.

    ![](image/200_IL/Picture200-31.png)

- Enter your Oracle Cloud credentials given to you by the instructor or Trail confirmation email. Ensure that you enter the correct values for **Username**, **Password** and **Identity Domain**. Note that the default set for the **Region** may not be correct, and must be properly set. The value for the **Output Format** should be set to **JSON**.

    ![](image/200_IL/Picture200-30.2.png)

- Next we will add a second build step. Click **Add Build Step** and select **Execute Shell**

    ![](image/200_IL/Picture200-30.4.png)

- Enter the following PSM CLI call for the **Execute Shell Command:**

```bash
source ./JCSBuild.conf
psm stack create -n $ServiceName -t Alpha-JCS-DBCS-Template \
  -p commonPwd:$CommonPassword \
      backupStorageContainer:$BackupStorageContainer \
      cloudStoragePassword:<OPC Password>
```

**Note:** Replace OPC Password

![](image/200_IL/Picture200-30.6.png)

- Click **Save** to complete the configuration. We will not execute a build at this time, as we want to trigger the build by updating the **JCSBuild.conf** file.

    ![](image/200_IL/Picture200-33.png)

### **STEP 6:** Complete Task

We have now completed our task. To finish up this part of the lab we will want to mark the Issue as completed in our Sprint.

- Back in the Developer Cloud Service, click **Agile**, followed by clicking **Active Sprints**.

- Drag and drop **Task 1** from **In Progress** to **Completed**.

    ![](image/200_IL/Picture200-23.png)

- In the Change Progress popup click **Next**

- Set number of days to 1 and click **OK**

    ![](image/200_IL/Picture200-34.png)

- Your Sprint should now look like the following:

    ![](image/200_IL/Picture200-25.png)

# Provision new Alpha Office Environment by modifying configuration file

## Clone Project to Eclipse IDE

### **STEP 7:** Load Eclipse IDE

- Right Click and select **Run** on the **Eclipse** Desktop Icon

    ![](image/200_IL/Picture200-35.png)

### **STEP 8:** Create connection to Oracle Developer Cloud Service

- We will now create a connection to the Developer Cloud Service. To do this, first click on the menu options **Window -> Show View ->Other**

    ![](image/200_IL/Picture200-36.png)

- Enter **oracle** in the search field. Select **Oracle Cloud**, and click on **OK**.

    ![](image/200_IL/Picture200-37.png)

- Click on **Connect** in the Oracle Cloud tab

    ![](image/200_IL/Picture200-38.png)

- Enter the following information and click **Finish**

    **Identity Domain:** `<your identity domain>`

    **User name:** `<your identity domain username>`

    **Password:** `<your identity domain password>`

    **Connection Name:** `OracleConnection`

    ![](image/200_IL/Picture200-39.png)

- If prompted, enter and confirm a Master Password for the Eclipse Secure Storage. In our example we use the **password** of `oracle`. Next, press **OK**.

    ![](image/200_IL/Picture200-40.png)

- If prompted to enter a Password Hint, click on **No**

    ![](image/200_IL/Picture200-41.png)

### **STEP 9:** Create a local clone of the repository

- Expand **Developer**, and then double click on **Alpha Office Product Catalog** to activate the project.

    ![](image/200_IL/Picture200-42.png)

- **Expand** the **Code**, and double click on the **Git Repo [JCSStackAlphaInfrastructure.git]**, to cause the Repo to be cloned locally.

    ![](image/200_IL/Picture200-43.png)

- **Right Click** on the **JCSStackAlphaInfrastructure** cloned repository and click on **Import Projects**.

    ![](image/200_IL/Picture200-44.png)

- Accept the Import defaults, and **click** on **Finish**

    ![](image/200_IL/Picture200-45.png)

### **STEP 10:** Set Task 2 Status to In Progress

In the previous steps we updated the status of the Tasks using the web interface to the Developer Cloud Service. In this step we will use the Eclipse connection to the Developer Cloud Service to update the status of the tasks.

- Within the Oracle Cloud Connection tab, double click the **Issues** to expand, then double click on **Mine** to expand your list. Once you see the list of your Issues, then double click on **Provision new Alpha Office Environment**.

    ![](image/200_IL/Picture200-55.png)

- Scroll down to the bottom of the **Provision new Alpha Office Environment** window. In the **Actions section**, and change the Actions to **Accept (change status to ASSIGNED)**, then click on **Submit**.

    ![](image/200_IL/Picture200-56.png)

- Optionally, if you return to the Developer Cloud Service web interface, you’ll see that the Eclipse interface caused the **Task 2** to be moved to the **In Progress** column of the **Agile > Active Sprints**.

    ![](image/200_IL/Picture200-57.png)

### **STEP 11:** Modify Configuration File

- In the Eclipse **Project Explorer** panel, expand the project and double click on **JCSBuild.conf** to open

    ![](image/200_IL/Picture200-46.png)

- Modify the values as defined below and click **Save All**

    **ServiceName=Alpha02**

    **BackupStorageContainer=Storage-`Your OPC identity Domain`/Alpha02Backup**

    ![](image/200_IL/Picture200-47.png)

## Commit Code

### **STEP 12:** Commit Code

- Right click on **JCSStackAlphaInfrastructure** and then Select **Team > Commit**

    ![](image/200_IL/Picture200-48.png)

- Enter `Provision Stack Alpha02` in the Commit Message box and click **Commit and Push**.

    ![](image/200_IL/Picture200-49.png)

- Click **OK** on the Push Result dialog

    ![](image/200_IL/Picture200-50.png)

## Verify Provisioning

### **STEP 13:** Verify Build job ran

- Click **Code** on left hand navigation then click **Logs**. Notice that the file has been committed to the Git repository.

    ![](image/200_IL/Picture200-51.png)

- Click **Build** on left hand navigation. You should now see that the **Infrastructure Create Stack** build is running, or just completed. If it's running, wait for it to complete.

    ![](image/200_IL/Picture200-52.png)

### **STEP 14:** Monitor in Oracle Cloud

- Switch back to browser tab with **Oracle Stack Manager**.  Click on the **Stacks** tab. You should see that Alpha02 stack is "Creating" and building out an Oracle Database Cloud Service and a Java Cloud Service. You may need to click on the refresh button if the stack is not immediately visible.

    ![](image/200_IL/Picture200-53.png)

- Click on **Alpha02** to view details.

    ![](image/200_IL/Picture200-54.png)

### **STEP 15:** Set Task 2 Status to In Progress

- From either Eclipse or Developer Cloud Service console update the status of **Task 2** to **Completed**. Your sprint should now look like the following.

![](image/200_IL/Picture200-58.png)

- **You have completed Lab 200**. For the next lab, you will not need to wait for the environment provisioning to complete, as we will use an **already provisioned environment**.
