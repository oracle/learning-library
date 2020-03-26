![](images/lab300/300_00_01_Lab300TopImage.png)

Update: April 30, 2017

# Introduction

This is the third of several labs that are part of the **Oracle Public Cloud DevOps Cloud Native Microservices Workshop**. This workshop walks you through the Software Development Lifecycle (SDLC) for a Cloud Native project that will create and use several microservices.

In the first lab (100) Lisa Jones, the project manager, created a new project in the Developer Cloud Service. She then added team members to the project, and created and assigned tasks to the developers of this application. The second lab (200) focused on deploying a MySQL database instance in the Oracle Cloud. In this third lab, you will assume the persona of microservices developer Bala Gupta, who will build two Node.js REST services. One of these REST services will extract Alphaoffice product data from the MySQL database that you built in Lab 200. The second REST service will extract data from a Twitter feed.

**Please direct comments to: John Hennen ([john.hennen@oracle.com](mailto:john.hennen@oracle.com)).**

## Objectives

- Access the Oracle Developer Cloud Service
- Import code from an external Git repository
- Import the project into the Brackets code editor, perform edits and push the edits to the repository in the Oracle Cloud
- Build and deploy the project using the Oracle Developer Cloud Service and the Oracle Application Container Cloud Service
- Follow the Git methodology for source code control
- Follow the Agile methodology for project management

## Required Artifacts

- The following lab requires an Oracle Public Cloud account that will be supplied by your instructor. Included in this account is an Oracle Compute Cloud Service that will simulate a client workstation with all necessary client software pre-installed for local code editing.  You will need to install VNC Viewer on your personal workstation to access this Compute Cloud Service client. 

# Create Initial REST Microservices

### **STEP 1**: Review and Update the Agile Board

- This Lab assumes that you completed Labs 100 and 200. It also assumes you and are still connected to the Oracle Cloud, that you're still in the Developer Cloud Service Dashboard, and that you're viewing the "Alphaoffice Marketing Project". If for some reason that is not the case, follow the first several steps of Lab 100 to once again view the Developer Cloud Service Console.

    ![](images/lab300/300_01_01_project_console.png)   

- Although you will remain connected to the Oracle Cloud using the user account you were provided, you are to take on the persona of ***Bala Gupta*** (microservices developer) as you perform the following steps.

    ![](images/lab300/300_01_02_balagupta.png) 

- Click on **Agile** on the navigation panel.

    ![](images/lab300/300_01_03_agilemenuchoice.png)

- Click on the **Microservices** Board **Active Sprints** and focus on the sprints for Bala Gupta.

    ![](images/lab300/300_01_04_activesprints0.png)

- Designate that Task 3 has moved to **In Progress** by dragging the Task 3 panel into the **In Progress** column.

    ![](images/lab300/300_01_05_sprint11.png)

- Leave the default values and click **Next**.

    ![](images/lab300/300_01_06_sprint12.png)

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab300/300_01_07_sprint13.png)

- The **Active Sprints** screen shows the change.

    ![](images/lab300/300_01_08_sprint14.png)

## Create the MySQL Microservice Repository, and the Default MySQL Microservice Build and Deploy Processes

### **MySQL REST STEP 2**: Create the New Git Repository for the MySQL Microservice Code

- Click on **Project** on the navigation panel.

    ![](images/lab300/300_02_S02_01_repository1.png)

- Click the **New Repository** button.

    ![](images/lab300/300_02_S02_02_repository2.png)

- In the **New Repository** popup, enter the following:
    - **Name** `AlphaofficeMySQLREST` 
    - **Description** (any)
    - Select **Import existing repository** 
    - Enter `https://github.com/johnhennen/AlphaofficeMySQLREST` for the existing repository location.  
    - Finally, click **Create**.

   ![](images/lab300/300_02_S02_03_repository3.png)

- Once all the code files are imported, you will have the file and folder structure below in the **AlphaofficeMySQLREST** repository.

    ![](images/lab300/300_02_S02_04_repository4.png)

### **MySQL REST STEP 3**: Create Default Build Process

Now that you have the source code in your managed Git repository, you will need to create a build process that will be triggered whenever a commit is made to the master branch. In this step you will set up a shell script build process.

- Click **Build** on the navigation panel to access the build page, and then click the **New Job** button.

    ![](images/lab300/300_02_S03_01_build1.png)

- In the New Job popup, enter `BuildMySQLREST` for Job Name. Select **Create a free-style job** and click **Save**.

    ![](images/lab300/300_02_S03_02_build2.png)

- You are now placed into the job configuration screen.

    ![](images/lab300/300_02_S03_03_build3.png)

- Click the **Source Control** tab. Select **Git** and select **AlphaofficeMySQLREST.git** from the dropdown.

    ![](images/lab300/300_02_S03_04_build4.png)

- Click the **Triggers** tab. Select **Based on SCM polling schedule**.

    ![](images/lab300/300_02_S03_05_build5.png)

- Click the **Build Steps** tab. Click the **Add Build Step** dropdown and select **Execute shell**.

    ![](images/lab300/300_02_S03_06_build6.png)

- For the shell script command enter `npm install`.

    ![](images/lab300/300_02_S03_07_build7.png)

- Click the **Post Build** tab and enter the following:
    - Select **Archive the artifacts**
    - **Files To Archive:** `**/target/*`
    - **Compression Type:** **GZIP**

    ![](images/lab300/300_02_S03_08_build8.png)

- Click the **Save** button in the upper right of the job configuration screen. 

    ![](images/lab300/300_02_S03_09_build9.png)

- The build process should immediately queue to begin. If not, you can always initiate a build with the **Build Now** button.

    ![](images/lab300/300_02_S03_10_build10.png)

- After the build, the success status is shown with a check mark in a green circle.

    ![](images/lab300/300_02_S03_11_build11.png)

### **MySQL REST STEP 4**: Create Default Deploy Process

- Click **Deploy** on the navigation panel to access the Deployments page, and then click the **New Configuration** button.

    ![](images/lab300/300_02_S04_01_deploy1.png)

- On the **New Deployment Configuration** popup, enter the following:
    - **Configuration Name:** `DeployMySQLREST` 
    - **Application Name:** `AlphaofficeMySQLREST` (This will be the name for the application in the Oracle Application Container Cloud Service, and this string will be incorporated into the URL for the deployed application.)
    - **Type:** **Automatic** 
    - **Job:** **BuildMySQLREST** 
    - **Artifact:** **target/msdbw-mysqlmicroservice.zip** 
    - Finally, click on the **New** button and select **Application Container Cloud** from the dropdown.

   ![](images/lab300/300_02_S04_02_deploy2.png)

- Enter the Data Center, Identity Domain, Username and Password you were provided for the Oracle Cloud Service, and then click **Test Connection**.

    ![](images/lab300/300_02_S04_03_deploy3.png)

- When this comes back with a **Successful** status, click **Use Connection**.

    ![](images/lab300/300_02_S04_04_deploy4.png)

- Make sure you have chosen the following:
    - **ACCS Properties:** **Node**
    - **Type:** **Automatic** with **Deploy stable builds only** checked
    - Finally, click **Save and Deploy**.

    ![](images/lab300/300_02_S04_05_deploy5.png)

- The panel will first show the deployment in process, and then will show that the **Last deployment succeeded**.  ***Note: this may take several minutes.***

    ![](images/lab300/300_02_S04_06_deploy6.png)

- If the arrow is not green but is orange and pointed down ![](images/lab300/300_02_S04_07_deploy7.png), this means the application has not been started.

- To manually start, stop or redeploy the application in Oracle Application Container Cloud Service, go to the gear dropdown icon for the application, and select the appropriate action.

    ![](images/lab300/300_02_S04_08_deploy8.png)

## Transition From the MySQL Microservice to the Twitter Microservice

 ***You have just completed steps MySQL REST STEP 2, MySQL REST STEP 3 and MySQL REST STEP 4.  These cover the initial build and deployment of the MySQL microservice. The next 3 steps (Twitter REST STEP 2, Twitter REST STEP 3 and Twitter REST STEP 4) are very similar to the MySQL REST steps. They cover the build and deployment of the Twitter microservice.***

## Create the Twitter Microservice Repository, and the Default Twitter Microservice Build and Deploy Processes

### **Twitter REST STEP 2**: Create the New Git Repository for the Twitter Microservice Code

- Click on **Project** on the navigation panel.

    ![](images/lab300/300_02_T02_01_repository1.png)

- Click the **New Repository** button.

    ![](images/lab300/300_02_T02_02_repository2.png)

- In the **New Repository** popup, enter the following:
    - **Name** `AlphaofficeTitterREST` 
    - **Description** (any)
    - Select **Import existing repository** 
    - Enter `https://github.com/johnhennen/AlphaofficeTwitterREST` for the existing repository location.  
    - Finally, click **Create**.

    ![](images/lab300/300_02_T02_03_repository3.png)

- Once all the code files are imported, you will have the file and folder structure below in the **AlphaofficeTwitterREST** repository.

    ![](images/lab300/300_02_T02_04_repository4.png)

### **Twitter REST STEP 3**: Create Default Build Process

Now that you have the source code in your managed Git repository, you will need to create a build process that will be triggered whenever a commit is made to the master branch. In this step you will set up a shell script build process.

- Click **Build** on the navigation panel to access the build page, and then click the **New Job** button.

    ![](images/lab300/300_02_T03_01_build1.png)

- In the New Job popup, enter `BuildTwitterREST` for Job Name. Select **Create a free-style job** and click **Save**.

    ![](images/lab300/300_02_T03_02_build2.png)

- You are now placed into the job configuration screen.

    ![](images/lab300/300_02_T03_03_build3.png)

- Click the **Source Control** tab. Select **Git** and select **AlphaofficeTwitterREST.git** from the dropdown.

    ![](images/lab300/300_02_T03_04_build4.png)

- Click the **Triggers** tab. Select **Based on SCM polling schedule**.

    ![](images/lab300/300_02_T03_05_build5.png)

- Click the **Build Steps** tab. Click the **Add Build Step** dropdown and select **Execute shell**.

    ![](images/lab300/300_02_T03_06_build6.png)

- For the shell script command enter `npm install`.

    ![](images/lab300/300_02_T03_07_build7.png)

- Click the **Post Build** tab and enter the following:
    - Select **Archive the artifacts**
    - **Files To Archive:** `**/target/*`
    - **Compression Type:** **GZIP**

    ![](images/lab300/300_02_T03_08_build8.png)

- Click the **Save** button in the upper right of the job configuration screen. 

    ![](images/lab300/300_02_T03_09_build9.png)

- The build process should immediately queue to begin. If not, you can always initiate a build with the **Build Now** button.

    ![](images/lab300/300_02_T03_10_build10.png)

- After the build, the success status is shown with a check mark in a green circle.

    ![](images/lab300/300_02_T03_11_build11.png)

### **Twitter REST STEP 4**: Create Default Deploy Process

- Click **Deploy** on the navigation panel to access the Deployments page, and then click the **New Configuration** button.

    ![](images/lab300/300_02_T04_01_deploy1.png)

- On the **New Deployment Configuration** popup, enter the following:
    - **Configuration Name:** `DeployTwitterREST` 
    - **Application Name:** `AlphaofficeTwitterREST` (This will be the name for the application in the Oracle Application Container Cloud Service, and this string will be incorporated into the URL for the deployed application.)
    - **Type:** **Automatic** 
    - **Job:** **BuildTwitterREST** 
    - **Artifact:** **target/msdbw-twittermicroservice.zip** 
    - Finally, click on the **New** button and select **Application Container Cloud** from the dropdown.

    ![](images/lab300/300_02_T04_02_deploy2.png)

- Enter the Data Center, Identity Domain, Username and Password you were provided for the Oracle Cloud Service, and then click **Test Connection**.

    ![](images/lab300/300_02_T04_03_deploy3.png)

- When this comes back with a **Succssful** status, click **Use Connection**.

    ![](images/lab300/300_02_T04_04_deploy4.png)

- Make sure you have chosen the following:
    - **ACCS Properties:** **Node**
    - **Type:** **Automatic** with **Deploy stable builds only** checked
    - Finally, click **Save and Deploy**.

    ![](images/lab300/300_02_T04_05_deploy5.png)

- The panel will first show the deployment in process, and then will show that the **Last deployment succeeded**.  ***Note: this may take several minutes.***

    ![](images/lab300/300_02_T04_06_deploy6.png)

- If the arrow is not green but is orange and pointed down ![](images/lab300/300_02_T04_07_deploy7.png), this means the application has not been started.

- To manually start, stop or redeploy the application in Oracle Application Container Cloud Service, go to the gear dropdown icon for the application, and select the appropriate action.

    ![](images/lab300/300_02_T04_08_deploy8.png)

## Test the Initial Microservice Deployments and Update the Agile Board

### **STEP 5**: Update the Agile Active Sprints Screen

- Click **Agile** on the navigation panel, and then drag the Task 3 panel from **In Progress** to the **Verify Code** column to signal Lisa, the project manager, that it's time to verify completion of Task 3.

    ![](images/lab300/300_05_01_sprint14.png)

- Leave the default values and click **Next**.

    ![](images/lab300/300_05_02_sprint15.png)

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab300/300_05_03_sprint16.png)

- The **Active Sprints** screen shows the change.

    ![](images/lab300/300_05_04_sprint17.png)

### **STEP 6**: Test the New Cloud Microservice Applications

- Click **Deploy** on the navigation panel. 

    ![](images/lab300/300_06_01_deploymenuchoice.png)

- Right click on the application name **AlphaofficeMySQLREST**, and choose **Copy link address** in the dropdown. This is the URL for the MySQLREST application in the Application Container Cloud Service.

    ![](images/lab300/300_06_02_getappurl.png) 

- Paste this URL into the address bar of any browser (such as on your personal workstation), and then press **Enter** to navigate to the MySQLREST application in the Oracle Application Container Cloud Service. Note that there is no data displayed (only the JSON structure) because the code must be edited to access and return the MySQL data.

    ![](images/lab300/300_06_03_testcloudmysqlapp.png) 

- In the same way, right click on the application name **AlphaofficeTwitterREST**, and paste this URL into the address bar of any browser. Note that this shows an unfiltered listing of Twitter data in JSON format.

    ![](images/lab300/300_06_04_testcloudtwitterapp.png) 

### **STEP 7**: Designate That Repository Creation is Completed

- Briefly assume the persona of Lisa Jones (the project manager) to verify the completion of the repositories for the microservice applications. Drag the Task 3 panel from **Verify Code** to the **Completed** column.

    ![](images/lab300/300_07_01_sprint17.png)  

- Leave the default values and click **Next**.

    ![](images/lab300/300_07_02_sprint18.png)  

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab300/300_07_03_sprint19.png)  

- The **Active Sprints** screen shows the change.

    ![](images/lab300/300_07_04_sprint20.png)  

# Edit the MySQL Microservice Code to Access the MySQL Data and Push the Edits to the Cloud

### **STEP 8**: Designate Feature 4 is **In Progress**

- At this point you will return to the persona of microservices developer Bala Gupta to designate that Feature 4 (Create REST Services) has been moved to **In Progress**. Do this by dragging the Feature 4 panel from **To Do** to the **In Progress** column.

    ![](images/lab300/300_08_01_sprint21.png)  

- Leave the default values and click **Next**.

    ![](images/lab300/300_08_02_sprint22.png)  

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab300/300_08_03_sprint23.png) 

- The **Active Sprints** screen shows the change.

    ![](images/lab300/300_08_04_sprint23b.png)

## Clone the MySQL Microservice Code and Test it on the Client Workstation

### **STEP 9**: Open the Brackets Code Editor

***At this point you will be moving to the client workstation. (This is the Oracle Compute Cloud Service with pre-installed client software that simulates a client workstation.)*** 

- Start the VNC Viewer software on your personal workstation, and enter the URL you have been provided (including ":" with the port number at the end). Also enter the password provided to you when prompted. After login, you are a user on a UNIX client workstation. 

    ![](images/lab300/300_09_01_vncviewer.png)

- First open a terminal session on the workstation.

    ![](images/lab300/300_09_02_startterminal.png)

Your first task is to create (or locate) a working folder for the local AlphaofficeMySQLREST repository. If you were not given a specific folder location, any appropriate location in the UNIX folder structure will work as long as it is easy for you to access and organize this folder. (Perhaps name the folder **AlphaofficeMySQLREST**.) Also make sure permissions are sufficiently open for your work (chmod). Once an empty folder is created or located, you can move on to the next step.

- Click the Brackets icon on the workstation desktop to start the Brackets code editor.

    ![](images/lab300/300_09_03_bracketsicon.png)

- In the upper left, click on the dropdown for folder location and then select **Open Folder** from the dropdown.

    ![](images/lab300/300_09_04_bracketsopenfolder1.png)

- Navigate the ensuing popups to select the correct folder (the folder you just created or located).

    ![](images/lab300/300_09_05_bracketsopenfolder2.png)

- In the end you will have the correct folder displayed in the upper left.

    ![](images/lab300/300_09_06_bracketsrightfolder.png)

### **STEP 10**: Clone a Repository from the Oracle Developer Cloud Service Repository

- Click the Git icon on the right side of the Brackets screen to make sure the Git panel is open at the bottom of the Brackets screen.

    ![](images/lab300/300_10_01_giticon.png)

- Click the **Clone** button at the top of the Git panel.

    ![](images/lab300/300_10_02_bracketsgitopen.png)

***At this point you will be returning very briefly to the Oracle Developer Cloud Service console.*** 

- Click **Project** on the navigation panel.

    ![](images/lab300/300_10_03_projectmenuchoice.png)

- In the **Repositories** panel, navigate to the URL for the **AlphaofficeMySQLREST.git** repository. Copy this URL 

    ![](images/lab300/300_10_04_getDCSgiturl.png)

***At this point you will be returning to the Brackets code editor on the client workstation.***

- Since you just clicked the **Clone** button in the Brackets editor, the **Clone repository** popup is displayed. 
    - Paste the Oracle Cloud repository URL for **AlphaofficeMySQLREST.git** into the field labeled **Enter Git URL of the repository you want to clone:**.
    - Enter the Username and Password for your Oracle Cloud account.
    - Check **Save credentials to remote url (in plain text)**.
    - Finally, click **OK**.

    ![](images/lab300/300_10_05_clone1.png) 

- Note the cloning **in progress** message.

    ![](images/lab300/300_10_06_clone2.png)

- When the cloning is successfully completed, the code files and folders for the local repository will be displayed in the Brackets editor.

    ![](images/lab300/300_10_07_clone3.png)

### **STEP 11**: Test the Local Code

At this point you will be testing the code running on the client workstation.

- Open a terminal session on the client workstation.

    ![](images/lab300/300_11_01_startterminal.png)

- Navigate to the folder where the **server.js** file is located in the local AlphaofficeMySQLREST repository. (The server.js file is in the root folder of the repository folder you opened in Step 9.) Then enter the command `node server.js` and press **Enter**.

    ![](images/lab300/300_11_02_startnode.png)

The terminal session will appear to suspend without returning a new command prompt. At this point you may minimize the terminal window because the Node.js listener for server.js is running in the background.

- Enter the url `localhost:8002` in the address bar of the browser provided on the client workstation (with the icon displayed on the desktop) and press **Enter** to navigate to the local MySQLREST application.

    ![](images/lab300/300_11_03_testlocal.png)

Again note that there is no data displayed because the microservice code must be edited to access and return the MySQL data.

## Edit the Code and Test the Local Edited Version

### **STEP 12**: Edit the Local Version of the Code

- In the left code repository panel of the Brackets code editor, click on the **server.js** file. ***Note: there are a number of formatting and other non-fatal warnings that will be reported when you open the server.js file. Ignore these.***

    ![](images/lab300/300_12_01_editnode1.png)

In the section highlighted within the red rectangle, notice a number of values required to connect to the MySQL database that you deployed in Lab 200. In particular the host (IP address) and the password will be different from what is displayed in this image. Change these values in the code to reflect your MySQL database deployment.

- Note the code section with critical code commented out.

    ![](images/lab300/300_12_02_editnode2.png)

- Remove the `/*` and `*/` strings from the code to uncomment the code section.

    ![](images/lab300/300_12_03_editnode3.png)

- From the Brackets **File** menu, click **Save** to save your edits to **server.js**.

    ![](images/lab300/300_12_04_editnode4.png)

### **STEP 13**: Test the Edited Code

- You must terminate the Node.js session you started in **Step 11**. You must do this in order to execute the `node server.js` command again with the new edits to the server.js file. To do this, return to the terminal session you used in **Step 11** and press the **CTRL** and **C** keys simultaneously.

- Alternatively you can close the terminal session that you opened in **Step 11** and then open a new terminal session on the client workstation.

    ![](images/lab300/300_13_01_startterminal.png)

- Restart the Node.js module. To do this, navigate to the folder where the **server.js** file is located in the local AlphaofficeMySQLREST repository. Then enter the command `node server.js` and press **Enter**.

    ![](images/lab300/300_13_02_startnode.png)

The terminal session will appear to suspend without returning a new command prompt. At this point you may minimize the terminal window because the Node.js listener for server.js is running in the background.

- Enter the url `localhost:8002` in the address bar of the browser provided on the client workstation (with the icon displayed on the desktop) and press **Enter** to navigate to the edited local MySQLREST application.

    ![](images/lab300/300_13_03_testnodeafteredit.png)

Notice that after the edits, the local version of the MySQL microservice application displays all the data from the Oracle Cloud MySQL database in JSON format. (If you do not see this data, make sure the MySQL database you deployed in Lab 200 is still accessible.)

## Create a New Branch and Push the Edits to the Cloud

### **STEP 14**: Create a New Branch and Commit the Changes

- Click on the **master** branch dropdown in the upper left panel of the Brackets code editor.  Then select **Create new branch**.

    ![](images/lab300/300_14_01_createbranch1.png)

- In the **Create new branch...** popup, enter the branch name `serverjsV2` and click **OK**.

    ![](images/lab300/300_14_02_createbranch2.png)

- You may need to click the Git icon ![](images/lab300/300_14_03_giticon.png) on the right side of the Brackets editor screen in order to display the Git panel at the bottom of the Brackets screen.

- Make sure both check boxes are checked at the bottom left of the Brackets screen. (One checkbox is on the same line as the **Commit** button, and one is on the same line as **server.js** and the label **Modified** or **Staged, Modified**.)

- Then click **Commit**.

    ![](images/lab300/300_14_04_createbranch4.png)

- ***Note: there are a number of formatting and other non-fatal warnings that will be reported for the server.js file. Ignore these.***

- Enter a comment for the commit and click **OK**.

    ![](images/lab300/300_14_05_createbranch5.png)

- You may need to enter a Git username. (Enter your username for your cloud service.) And you may need to enter some email address. (Any will do.) Finally, click **OK**.

    ![](images/lab300/300_14_06_createbranch6.png)

### **STEP 15**: Push the Branch Commits to the Cloud

- Click on the **Git Push Icon** in the Brackets code editor.

    ![](images/lab300/300_15_01_gitpushicon.png)

- Enter your cloud username and password that you were given. Make sure **Save credentials to remote url (in plain text)** is checked. Finally, click **OK**.

    ![](images/lab300/300_15_02_createbranch9.png)

- The edited branch within the local Git repository has been successfully pushed to the repository in the Oracle Developer Cloud Service. Click **OK**.

    ![](images/lab300/300_15_03_createbranch10.png)

# Merge the Code Edits and Rebuild and Redeploy the MySQLREST Application

## Submit a Merge Request for the Branch With the Code Edits and Designate the Edited Code is Ready for Verification

### **STEP 16**: Create a Merge Request as Bala Gupta to Merge the Code Edits

It's time to follow the code repository push to the Oracle Developer Cloud Service. Return to the Oracle Developer Cloud Service Services Console.

- Click **Code** on the navigation panel.

    ![](images/lab300/300_16_01_codemenuchoice.png) 

- Choose **AlphaofficeMySQLREST.git** as the repository.

    ![](images/lab300/300_16_02_merge1.png) 

- Choose **serverjsV2** as the branch. (This is the branch that has the code edits which we wish to merge with the master branch.)

    ![](images/lab300/300_16_03_merge2.png) 

- Click the **Commits** button to view recent commits. Here we again see that the push we made from the Brackets code editor on the client workstation has succeeded. The edited files are now in the **servicerjsV2** branch of the Developer Cloud Service repository. They're all ready to be merged into the **master** branch. 

    ![](images/lab300/300_16_04_merge3.png)

But remember, we are following a rigorous Git-based source control methodology. We cannot have developers like Bala Gupta make changes to the main branch of the code. 

- Instead Bala must make a **merge request** to Lisa the project manager.

    ![](images/lab300/300_16_05_guptalisa.png)

- Click **Merge Request** on the navigation panel, and then click the **New Merge Request** button.

    ![](images/lab300/300_16_06_merge4.png)

- On the **New Merge Request** popup, choose the **Repository**, **Target Branch** and **Review Branch**. Then click **Next**.

    ![](images/lab300/300_16_07_merge5.png)

- On the second popup, add a summary description and select a reviewer. (In real life, Bala might designate several reviewers. In this exercise the only option may be **Cloud Admin**.)  Finally, click **Next**. 

    ![](images/lab300/300_16_08_merge6.png)

- On the third popup, click **Create**.

    ![](images/lab300/300_16_09_merge7.png)

### **STEP 17**: Designate That the UI Code is Ready for Verification

- Click **Agile** on the navigation panel.

    ![](images/lab300/300_17_01_agilemenuchoice.png) 

- Drag the Feature 4 panel from **In Progress** to the **Verify Code** column to designate to the project manager (Lisa) that the code is ready for verification.

    ![](images/lab300/300_17_02_sprint24.png)  

- Leave the default values and click **Next**.

    ![](images/lab300/300_17_03_sprint25.png)

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab300/300_17_04_sprint26.png) 

- The **Active Sprints** screen shows the change.

    ![](images/lab300/300_17_05_sprint26b.png) 

## As Lisa Jones (Project Manager) Merge the Edits, Test the Edited Code, and Designate the Edits and Merge Have Been Completed

### **STEP 18**: Perform the Merge as Lisa the Project Manager

- For this step, you will assume the persona of Lisa, the project manager.

    ![](images/lab300/300_18_01_lisa.png)

- As Lisa, click the **Assigned To Me** button. Then click the merge request just submitted by Bala Gupta.

    ![](images/lab300/300_18_02_merge8.png)

- Click on the **Changed Files** tab to review the changed code, and note how the changes reflect the edits Bala Gupta made in the Brackets code editor on the client workstation. As Lisa, approve and process the merge by clicking the **Merge** button.

    ![](images/lab300/300_18_03_merge9.png)

- On the popup uncheck **Squash commits** and click **Merge**.

    ![](images/lab300/300_18_04_merge10.png)

- Click **Build** on the navigation panel to navigate to the **Build** screen. Processing the merge automatically initiates a rebuild process. Note how the **BuildMySQLREST** job has been placed in the queue automatically.

    ![](images/lab300/300_18_05_merge11.png)

- The rebuild begins.

    ![](images/lab300/300_18_06_merge12.png)

- The rebuild has successfully completed.

    ![](images/lab300/300_18_07_merge13.png)

- Click **Deploy** on the navigation panel to navigate to the **Deployments** screen. Once the rebuild is complete, a redeploy will also automatically start. The panel will first show the deployment in process, and then will show that the **Last deployment succeeded**.

    ![](images/lab300/300_18_08_merge14.png)

- If the arrow is not green but is orange and pointed down ![](images/lab300/300_18_09_merge15.png), this means the application has not been started.

- To manually start, stop or redeploy the application in Oracle Application Container Cloud Service, go to the gear dropdown icon for the application, and select the appropriate action.

- ***If you must manually redeploy, make sure you deploy the latest build with the latest build number.***

    ![](images/lab300/300_18_10_merge16.png)

### **STEP 19**: Test the Completed Code

- Click **Deploy** on the navigation panel.

    ![](images/lab300/300_19_01_deploymenuchoice.png) 

- As Lisa Jones, test the code edits. Right click on the application name **AlphaofficeMySQLREST**, and choose **Copy link address** in the dropdown. This is the URL for the application in the Application Container Cloud Service.

    ![](images/lab300/300_19_02_getappurl.png)

- Paste this URL into the address bar of any browser (such as on your personal workstation), and then press **Enter** to navigate to the MySQLREST application in the Oracle Application Container Cloud Service. Note that all data from the database is now displayed in JSON format. The application is fully operational.

    ![](images/lab300/300_19_03_cloudtestbrowser.png)

### **STEP 20**: Designate the Edits are Complete

- Again you have assumed the persona of Lisa, the project manager. As Lisa you will verify that the MySQL microservice code has been completed. Click **Agile** on the navigation panel.

    ![](images/lab300/300_20_01_agilemenuchoice.png)

- Drag the Feature 4 panel from **Verify Code** to the **Completed** column.

    ![](images/lab300/300_20_02_sprint27.png)

- Leave the default values and click **Next**.

    ![](images/lab300/300_20_03_sprint28.png)

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab300/300_20_04_sprint29.png)

- The MySQL microservice edits have been completed and merged, and the Agile board has been updated. You have successfully completed Lab 300!

    ![](images/lab300/300_20_05_sprint30.png)


