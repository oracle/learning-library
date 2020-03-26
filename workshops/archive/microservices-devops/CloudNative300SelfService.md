# Continuous Delivery of Database Microservices

![](images/300/PictureLab.png)  
Updated: April 17, 2018

## Introduction

This is the third of several labs that are part of the **Oracle Cloud DevOps and Cloud Native Microservices workshop.** This workshop will walk you through the Software Development Lifecycle (SDLC) for a Cloud Native project that will create and use several Microservices.

In the first lab (100), the Project Manager created a new project in the Developer Cloud Service and also created and assigned tasks to the developers of this application. In the second lab (200), the java developer created a new microservice to retrieve and filter twitter data. In this lab you will assume the persona of the full stack developer, who will be tasked with creating a microservices that will supply JSON data from a product database.

## Objectives

- Access Developer Cloud Service
- Import Code from external Git Repository
- Build and Deploy project using Developer Cloud Service and Oracle Application Container Cloud Service (ACCS)
- Show how to pass Environment Variables to ACCS Applications during the Deployment Process

## Required Artifacts

- The following lab requires an Oracle Public Cloud account that will be supplied by your instructor.

# Create REST Microservice

## Explore Developer Cloud Service

### **STEP 1**: Review Agile Board

- This Lab assumes that you just completed Lab 200 and are still connected to the Oracle Cloud, that you're still in the Developer cloud Service Dashboard, and you're viewing the "Alpha Office Product Catalog Project." If for some reason that is not the case, follow the first several Steps of Lab 100 to once again view the Developer Cloud Service Console.

- Although you will remain connected to the Oracle Cloud using the user account you were provided, you will take on the Persona of ***Roland Dubois*** as you perform the following steps.

    ![](images/Roland.png)  

- Within the **Alpha Office Product Catalog Project**, click on **Agile** found on the left hand navigation.

    ![](images/300/Picture11.png)  

### **STEP 2**: Display the Active Sprint

- On the **Microservices** Board, click **Active Sprints**

    ![](images/300/Picture13.png)  

## Create Initial Git Repository

### **STEP 3**: Create Initial Git Repository

To begin development on our Catalog REST microservices, we could start coding from scratch. However, prior to the formal kickoff of this project, you (as Roland Dubois) have already started doing some proof-of-concept development outside of the Developer Cloud Service in order to assess the feasibility of your assignment. You want to bring that existing code into the Developer Cloud Service as a starting point for your microservices. You will do that by cloning your external GIT repository into the Developer Cloud Service. Your first step will be to accept your task using the agile board.

- Drag and drop **Feature 3 - Create Microservice to allow access to Product Catalog data** into the **In Progress** swim-lane.  

    ![](images/300/Picture14.1.png)  

- Leave the defaults, and Click **OK**.

    ![](images/300/Picture14.2.png)  

- Your Sprint progress will appear as shown below.

    ![](images/300/Picture16.2.png)  

- In the left hand navigation panel, click **Project**

- Click **New Repository**. In the New Repository wizard enter the following information and click **Create**.

    **Name:** `AlphaOfficeREST`

    **Description:** `AlphaOffice REST`

    **Initial content:** `Import existing repository`

    **Enter the URL:** `https://github.com/pcdavies/AlphaOfficeREST.git`

    ![](images/300/Picture18.3.png)  

- You have now created a new GIT repository stored within the Developer Cloud Services that is based on an existing repository.

    ![](images/300/Picture19.2.png)  

## Create Default Build and Deployment Process

### **STEP 4**: Create Default Build Process

Now that we have the source code in our managed GIT repository, we need to create a build process that will be triggered whenever a commit is made to the master branch.  We will use NPM package manager to set up a Node.js build process in this section.

- On the left side navigation panel click **Build** to access the build page.

- Click **New Job**.

- In the New Job popup enter `AlphaRESTBuild` for the Job Name, Select `OEL7NodeJava` as the **Software Template**, and then click **Create Job**.

    ![](images/300/PictureSelfServe01.png)  

- You are now placed into the job configuration screen. Click the **Add Source Control** drop down, and select **Git**.

    ![](images/300/PictureSelfServe02.png)  

- Select **AlphaOfficeREST.git** from the **Respository**. Select on the **Automatically perform build on SCM commit**.

    ![](images/300/PictureSelfServe03.png)  


- Click the **Builders** tab. Click **Add Builder**, and select **Unix Shell Builder**.

    ![](images/300/PictureSelfServe04.png)  

- For the **Script** enter: `npm install`

  **NOTE:** **npm** can manage packages that are local dependencies of a particular project, as well as globally-installed JavaScript tools. When used as a dependency manager for a local project, npm can install, in one command, all the dependencies of a project through the package.json file.

    ![](images/300/PictureSelfServe05.png)  

- Click on the **Post Build** tab. Click on the **Add Post Build Action** dropdown and select **Artifact Archiver**.

    ![](images/300/PictureSelfServe06.png)  

- Click the **Post Build** tab and complete the following:
  - Enter `**/target/*` for **Files to Archive**.  
  - Verify **GZIP** in the Compression Type.
  
    ![](images/300/PictureSelfServe07.1.png)  

- Click **Save** to complete the configuration.

- Click the **Build Now** button to start the build immediately. Wait, as it may take 30 seconds to a few minutes for the queued job to execute, but when it does, the status will change to the following:

    ![](images/300/Picture28_5.png)  

- Wait, as it may take 30 seconds to a few minutes for the queued job to execute, but when it does, the status will change to the following:

    ![](images/300/Picture29.png)  

  **NOTE:** Once the build begins, it should take about approximately 1 to 2 minutes for the build to complete. Once complete, you will be able to see the number of successful test runs in the Test Result Trend section. ***Wait for the build to complete before continuing to the next step***, as we need the build artifact to complete the deployment configuration.

- After the build begins, you can also click on the **Build Log**to monitor the build log details.

    ![](images/300/PictureSelfServe08.png)  

### **STEP 5**: Create Default Deployment Process

Now that we have an automated build process, we will setup up a deployment configuration that will push out build artifacts to a node.js environment running on Application Container Cloud Service whenever a successful build occurs.

- On the navigation panel click **Deploy** to access the Deployment page. Click **New Configuration**.

- Enter the following data:

  **Configuration Name**: `DeployREST`

  **Application Name**: `AlphaOfficeREST`

- Click on **Select a Deployment Target**

    ![](images/300/PictureSelfServe09.png)  

- Select the **Application Container Cloud** connection you defined in lab 200.

    ![](images/300/PictureSelfServe10.png)  

- In Deployment window enter your **Password**, and click **Test Connection**. If Successful, click **Use Connection**:

    ![](images/300/PictureSelfServe11.png)  

- Set the following Properties as follows:

  **Runtime**: `Node`

  **Subscription**: `Hourly`

  **Type:** `Automatic` and `Deploy stable builds only`

  **Job:** `Alpha REST Build`

  **Artifact:** `target/msdbw-microservice.zip`

  **Include ACCS Deployment**: Check, and add the following text to reduce the number of resources that are used:

    ```
    {
      "memory": "1G",
      "instances": "1"
    }
    ```

    ![](images/300/PictureSelfServe12.png)  

- Click **Save**

    ![](images/200/Picture36.2.png)  

- Click the gear drop down for **AlphaOfficeREST** and select **Start**

    ![](images/300/Picture37.3.png)  

- Wait until the message **Starting application** changes to **Last deployment succeeded**. Sometimes you may need to refresh this page to get an accurate reading on the status.

    ![](images/300/Picture38.2.png)  

    ![](images/300/Picture38.4.png)  

## Verify REST Microservice deployment

### **STEP 6**: Test REST services

- We are able to access the application directly from Developer Cloud Service. Click **AlphaOfficeREST** to launch the application.

    ![](images/300/Picture39.3.png)  

- A new tab in the browser should open with application running.

    ![](images/300/Picture42.png)  

- Now lets test out the **products** REST call.  Append `/products` to the end of the URL and hit **enter**.  All of the Alpha Office products should be returned in a JSON payload. 

    ![](images/300/Picture43.3.png)
 
### **STEP 7**: Complete Task

We have now verified that the REST microservice has been deployed and functions properly. To finish up this lab, we will mark the Issue as completed in the Sprint.

- Back in the Developer Cloud Service window, click **Agile**, followed by clicking **Active Sprints**.

- Drag and drop **Feature 3** from **In Progress** to **Completed**.

    ![](images/300/Picture46.2.png)  


- In the Change Progress popup click **Next**.

    ![](images/300/Picture47.png)  

- In the **Add Time Spent** popup, set the **Time Spent** to `1` and click **OK**.

    ![](images/200/Picture47.5.png)  

- Your Sprint should now look like the following:

    ![](images/300/Picture48.2.png)  

- You can also click on the **Reports** button and view your progress in the **Burndown Chart** and **Sprint Report**.

    ![](images/300/Picture49.png)  


- **You are now done with this lab.**

