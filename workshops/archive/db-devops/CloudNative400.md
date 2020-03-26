![](images/lab400/400_00_01_Lab400TopImage.png)  


Update: April 30, 2017

# Introduction

This is the fourth of several labs that are part of the **Oracle Public Cloud DevOps Cloud Native Microservices Workshop**. This workshop walks you through the Software Development Lifecycle (SDLC) for a Cloud Native project that will create and use several microservices.

In the first lab (100) Lisa Jones, the project manager, created a new project in the Developer Cloud Service. She then added team members to the project, and created and assigned tasks to the developers of this application. The second lab (200) focused on deploying a MySQL database instance in the Oracle Cloud. Lab 300 developed and deployed two microservices to access MySQL database data and to access Twitter feed data. In this fourth lab, you will assume the persona of the UI developer (John Dunbar) who will build a Node.js UI front end application that consumes and displays the data from the two microservices created in Lab 300.

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

# Create the Initial Marketing UI Service

## Create the Initial Git Repository

### **STEP 1**: Review and Update the Agile Board

- This Lab assumes that you completed Labs 100, 200 and 300. It also assumes you and are still connected to the Oracle Cloud, that you're still in the Developer Cloud Service Dashboard, and that you're viewing the "Alphaoffice Marketing Project". If for some reason that is not the case, follow the first several steps of Lab 100 to once again view the Developer Cloud Service Console.

    ![](images/lab400/400_01_01_project_console.png)  

- Although you will remain connected to the Oracle Cloud using the user account you were provided, you are to take on the Persona of ***John Dunbar*** (UI developer) as you perform the following steps.

    ![](images/lab400/400_01_02_johndunbar.png) 

- Click on **Agile** on the navigation panel.

    ![](images/lab400/400_01_03_agilemenuchoice.png)  

- Click on the **Microservices** Board **Active Sprints**.

    ![](images/lab400/400_01_04_activesprints.png)

- Focus on the sprints for John Dunbar.

    ![](images/lab400/400_01_05_activesprints0.png)

- Designate that Task 5 has moved to **In Progress** by dragging the Task 5 panel into the **In Progress** column.

    ![](images/lab400/400_01_06_sprint31.png)

- Leave the default values and click **Next**.

    ![](images/lab400/400_01_07_sprint32.png)

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab400/400_01_08_sprint33.png)

- The **Active Sprints** screen shows the change.

    ![](images/lab400/400_01_09_sprint34.png)

### **STEP 2**: Create the New Git Repository for the UI code

- Click on **Project** on the navigation panel.

    ![](images/lab400/400_02_01_repository1.png)

- Click the **New Repository** button.

    ![](images/lab400/400_02_02_repository2.png)

- In the **New Repository** popup, enter the following:
    - **Name** `AlphaofficeUI` 
    - **Description** (any)
    - Select **Import existing repository** 
    - Enter `https://github.com/johnhennen/AlphaofficeUI` for the existing repository location.  
    - Finally, click **Create**.

    ![](images/lab400/400_02_03_repository3.png)

- Once all the code files are imported, you will have the file and folder structure below in the **AlphaofficeUI** repository.

    ![](images/lab400/400_02_04_repository4.png)

## Create Default Build and Deployment Processes

### **STEP 3**: Create Default Build Process

Now that you have the source code in your managed Git repository, you will need to create a build process that will be triggered whenever a commit is made to the master branch. In this step you wil set up a shell script build process.

- Click **Build** on the navigation panel to access the build page, and then click the **New Job** button.

    ![](images/lab400/400_03_01_build1.png)

- In the New Job popup, enter `BuildUI` for Job Name. Select **Create a free-style job** and click **Save**.

    ![](images/lab400/400_03_02_build2.png)

- You are now placed into the job configuration screen.

    ![](images/lab400/400_03_03_build3.png)

- Click the **Source Control** tab. Select **Git** and select **AlphaofficeUI.git** from the dropdown.

    ![](images/lab400/400_03_04_build4.png)

- Click the **Triggers** tab. Select **Based on SCM polling schedule**.

    ![](images/lab400/400_03_05_build5.png)

- Click the **Build Step** tab. Click the **Add Build Steps** dropdown and select **Execute shell**.

    ![](images/lab400/400_03_06_build6.png)

- For the shell script command enter `npm install`.

    ![](images/lab400/400_03_07_build7.png)

- Click the **Post Build** tab and enter the following:
    - Select **Archive the artifacts**
    - **Files To Archive:** `**/target/*`
    - **Compression Type:** **GZIP**

    ![](images/lab400/400_03_08_build8.png)

- Click the **Save** button in the upper right of the job configuration screen. 

    ![](images/lab400/400_03_09_build9.png)

- The build process should immediately queue to begin. If not, you can always initiate a build with the **Build Now** button.

    ![](images/lab400/400_03_10_build10.png)

- After the build, the success status is shown with a check mark in a green circle.

    ![](images/lab400/400_03_11_build11.png)

### **STEP 4**: Create Default Deploy Process

- Click **Deploy** on the navigation panel to access the Deployments page, and then click the **New Configuration** button.

    ![](images/lab400/400_04_01_deploy1.png)

- On the **New Deployment Configuration** popup, enter the following:
    - **Configuration Name:** `DeployUI` 
    - **Application Name:** `AlphaofficeUI` (This will be the name for the application in the Oracle Application Container Cloud Service, and this string will be incorporated into the URL for the deployed application.)
    - **Type:** **Automatic** 
    - **Job:** **BuildUI** 
    - **Artifact:** **target/msdbw-microserviceui.zip** 
    - Finally, click on the **New** button and select **Application Container Cloud** from the dropdown.

    ![](images/lab400/400_04_02_deploy2.png)

- Enter the Data Center, Identity Domain, Username and Password you were provided for the Oracle Cloud Service, and then click **Test Connection**.

    ![](images/lab400/400_04_03_deploy3.png)

- When this comes back with a **Succssful** status, click **Use Connection**.

    ![](images/lab400/400_04_04_deploy4.png)

- Make sure you have chosen the following:
    - **ACCS Properties:** **Node**
    - **Type:** **Automatic** with **Deploy stable builds only** checked
    - Finally, click **Save and Deploy**.

    ![](images/lab400/400_04_05_deploy5.png)

- The panel will first show the deployment in process, and then will show that the **Last deployment succeeded**.

    ![](images/lab400/400_04_06_deploy6.png)

- If the arrow is not green but is orange and pointed down ![](images/lab400/400_04_07_deploy7.png), this means the application has not been started.

- To manually start, stop or redeploy the application in Oracle Application Container Cloud Service, go to the gear dropdown icon for the application, and select the appropriate action.

    ![](images/lab400/400_04_08_deploy8.png)

### **STEP 5**: Update the Agile Active Sprints Screen

- Click **Agile** on the navigation panel, and then drag the Task 5 panel from **In Progress** to the **Verify Code** column to signal Lisa, the project manager, that it's time to verify completion of Task 5.

    ![](images/lab400/400_05_01_sprint34.png)

- Leave the default values and click **Next**.

    ![](images/lab400/400_05_02_sprint35.png)

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab400/400_05_03_sprint36.png)

- The **Active Sprints** screen shows the change.

    ![](images/lab400/400_05_04_sprint37.png)

### **STEP 6**: Test the New Cloud UI Application

- Click **Deploy** on the navigation panel. 

    ![](images/lab400/400_06_01_deploymenuchoice.png)

- Right click on the application name **AlphaofficeUI**, and choose **Copy link address** in the dropdown. This is the URL for the UI application in the Application Container Cloud Service.

    ![](images/lab400/400_06_02_getappurl.png) 

- Paste this URL into the address bar of any browser (such as on your personal workstation), and then press **Enter** to navigate to the UI application in the Oracle Application Container Cloud Service. Note that there is no data displayed, because the UI code must be edited to consume and display the microservices data.

    ![](images/lab400/400_06_03_testclouduiapp.png)  

### **STEP 7**: Designate That Repository Creation is Completed

- Briefly assume the persona of Lisa (the project manager) to verify the completion of the repository for the UI application. Drag the Task 5 panel from **Verify Code** to the **Completed** column.

    ![](images/lab400/400_07_01_sprint37.png)  

- Leave the default values and click **Next**.

    ![](images/lab400/400_07_02_sprint38.png)  

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab400/400_07_03_sprint39.png)  

- The **Active Sprints** screen shows the change.

    ![](images/lab400/400_07_04_sprint40.png)  

# Edit the UI Code to Consume and Display the Microservices Data and Push the Edits to the Cloud

### **STEP 8**: Designate Feature 6 is **In Progress**

- At this point you will return to the persona of UI developer John Dunbar to designate that Feature 6 (Create Twitter Marketing UI) has been moved to **In Progress**. Do this by dragging the Feature 6 panel from **To Do** to the **In Progress** column.

    ![](images/lab400/400_08_01_sprint41.png)  

- Leave the default values and click **Next**.

    ![](images/lab400/400_08_02_sprint42.png)  

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab400/400_08_03_sprint43.png) 

- The **Active Sprints** screen shows the change.

    ![](images/lab400/400_08_04_sprint43b.png)

## Clone the UI Code and Test it on the Client Workstation

### **STEP 9**: Open the Brackets Code Editor

***At this point you will be moving to the client workstation. (This is the Oracle Compute Cloud Service with pre-installed client software that simulates a client workstation.)*** 

- Start the VNC Viewer software on your personal workstation, and enter the URL you have been provided (including ":" with the port number at the end). Also enter the username and password provided to you when prompted. After login, you are a user on a UNIX client workstation. 

    ![](images/lab400/400_09_01_vncviewer.png)

- First open a terminal session on the workstation.

    ![](images/lab400/400_09_02_startterminal.png)

Your first task is to create (or locate) a working folder for the local AlphaofficeUI repository. This is similar to what you did in Lab 300 for the AlphaofficeMySQLREST repository. If you were not given a specific folder location, any appropriate location in the UNIX folder structure will work as long as it is easy for you to access and organize this folder. (Perhaps name the folder **AlphaofficeUI**.) Also make sure permissions are sufficiently open for your work (chmod). Once an empty folder is created or located, you can move on to the next step.

- Click the Brackets icon on the workstation desktop to start the Brackets code editor.

    ![](images/lab400/400_09_03_bracketsicon.png)

- In the upper left, click on the dropdown for folder location and then select **Open Folder** from the dropdown.

    ![](images/lab400/400_09_04_bracketsopenfolder1.png)

- Navigate the ensuing popups to select the correct folder (the folder you just created or located).

    ![](images/lab400/400_09_05_bracketsopenfolder2.png)

- In the end you will have the correct folder displayed in the upper left.

    ![](images/lab400/400_09_06_bracketsrightfolder.png)

### **STEP 10**: Clone a Repository From the Oracle Developer Cloud Service Repository

- Click the Git icon on the right side of the Brackets screen to make sure the Git panel is open at the bottom of the Brackets screen.

    ![](images/lab400/400_10_01_giticon.png)

- Click the **Clone** button at the top of the Git panel.

    ![](images/lab400/400_10_02_bracketsgitopen.png)

***At this point you will be returning very briefly to the Oracle Developer Cloud Service console.*** 

- Click **Project** on the navigation panel.

    ![](images/lab400/400_10_03_projectmenuchoice.png)

- In the **Repositories** panel, navigate to the URL for the AlphaofficeUI.git repository. Copy this URL 

    ![](images/lab400/400_10_04_getDCSgiturl.png)

***At this point you will be returning to the Brackets code editor on the client workstation.***

- Since you just clicked the **Clone** button in the Brackets editor, the **Clone repository** popup is displayed. 
    - Paste the Oracle Cloud repository URL for **AlphaofficeUI.git** into the field labeled **Enter Git URL of the repository you want to clone:**.
    - Enter the Username and Password for your Oracle Cloud account.
    - Check **Save credentials to remote url (in plain text)**.
    - Finally, click **OK**.

    ![](images/lab400/400_10_05_clone1.png) 

- Note the cloning **in progress** message.

    ![](images/lab400/400_10_06_clone2.png)

- When the cloning is successfully completed, the code files and folders for the local repository will be displayed in the Brackets editor.

    ![](images/lab400/400_10_07_clone3.png)

### **STEP 11**: Test the Local Code

At this point you will be testing the code running on the client workstation.

- Open a terminal session on the client workstation.

    ![](images/lab400/400_11_01_startterminal.png)

- Navigate to the folder where the **server.js** file is located in the local AlphaofficeUI repository. (The server.js file is in the root folder of the repository folder you opened in Step 9.) Then enter the command `node server.js` and press **Enter**.

    ![](images/lab400/400_11_02_startnode.png)

The terminal session will appear to suspend without returning a new command prompt. At this point you may minimize the terminal window because the Node.js listener for server.js is running in the background.

- Enter the url `localhost:8001` in the address bar of the browser provided on the client workstation (with the icon displayed on the desktop) and press **Enter** to navigate to the local UI application.

    ![](images/lab400/400_11_03_testlocal.png)

Again note that there is no data displayed because the UI code must be edited to consume and display the microservices data.

## Edit the Code and Test the Local Edited Version

### **STEP 12**: Edit the Local Version of the Code

- In the left code repository panel of the Brackets code editor, click on the **microserviceui.js** file in the **doc_root** folder. ***Note: there are a number of formatting and other non-fatal warnings that will be reported when you open the microserviceui.js file. Ignore these.***

    ![](images/lab400/400_12_01_editnode1.png)

In the section highlighted within the red rectangle, notice the two variables **dbServiceURL** and **tweetServiceBaseURL**. These variables are currently pointing to localhost URLs for microservices that would run on the client workstation. These values must be updated to the working URLs for the Oracle Application Container Cloud Service applications for the two microservices. To obtain these, go back to the Oracle Developer Cloud Service services console. 

- Click **Deploy** on the navigation panel.

    ![](images/lab400/400_12_02_editnode2.png)

- Right click on the application name **AlphaofficeMySQLREST**, and choose **Copy link address** in the dropdown. This is the URL for the MySQL microservice. 

    ![](images/lab400/400_12_03_editnode3.png)

- Paste the copied URL for **AlphaofficeMySQLREST** as the value for the variable **dbServiceURL** in the microserviceui.js code.

    ![](images/lab400/400_12_04_editnode4.png)

- Repeat these steps for the application named **AlphaofficeTwitterREST**. In the **Deployments** screen in Oracle Developer Cloud Service, right click on the application name **AlphaofficeTwitterREST**, and choose **Copy link address** in the dropdown. This is the URL for the Twitter microservice. Paste this URL as the value for the variable **tweetServiceBaseURL** in the microserviceui.js code.

    ![](images/lab400/400_12_04_editnode4.png)

- Note the code section with critical code commented out.

    ![](images/lab400/400_12_05_editnode5.png)

- Remove the `/*` and `*/` strings from the code to uncomment the code section.

    ![](images/lab400/400_12_06_editnode6.png)

- From the Brackets **File** menu, click **Save** to save your edits to **microserviceui.js**.

    ![](images/lab400/400_12_07_editnode7.png)

### **STEP 13**: Test the Edited Code

- You must terminate the Node.js session you started in **Step 11**. You must do this in order to execute the `node server.js` command again with the new edits to the server.js file. To do this, return to the terminal session you used in **Step 11** and press the **CTRL** and **C** keys simultaneously.

- Alternatively you can close the terminal session that you opened in **Step 11** and then open a new terminal session on the client workstation.

    ![](images/lab400/400_13_01_startterminal.png)

- Restart the Node.js module. To do this, navigate to the folder where the **server.js** file is located in the local AlphaofficeUI repository. Then enter the command `node server.js` and press **Enter**.

    ![](images/lab400/400_13_02_startnode.png)

The terminal session will appear to suspend without returning a new command prompt. At this point you may minimize the terminal window because the Node.js listener for server.js is running in the background.

- Enter the url `localhost:8001` in the address bar of the browser provided on the client workstation (with the icon displayed on the desktop) and press **Enter**. 

    ![](images/lab400/400_13_03_testnodeafteredit.png)

- Then after the initial product screen is displayed, click on one of the products such as the **#FranklinCovey** hashtag to see Twitter data.

    ![](images/lab400/400_13_04_testnodeafteredit2.png)

Notice that after the edits, the local version of the UI application displays all the data from the two Oracle Cloud microservices. (If you do not see this data, make sure both microservices are running in the Oracle Application Container Cloud Service.)

## Create a New Branch and Push the Edits to the Cloud

### **STEP 14**: Create a New Branch and Commit the Changes

- Click on the **master** branch dropdown in the upper left panel of Brackets.  Then select **Create New Branch**.

    ![](images/lab400/400_14_01_createbranch1.png)

- In the **Create new branch...** popup, enter the branch name `microserviceuijsV2` and click **OK**.

    ![](images/lab400/400_14_02_createbranch2.png)

- You may need to click the Git icon ![](images/lab400/400_14_03_giticon.png) on the right side of the Brackets editor screen in order to display the Git panel at the bottom of the Brackets screen.

- Make sure both check boxes are checked at the bottom left of the Brackets screen. (One checkbox is on the same line as the **Commit** button, and one is on the same line as **doc_root/microserviceui.js** and the label **Modified** or **Staged, Modified**.)

- Then click **Commit**.

    ![](images/lab400/400_14_04_createbranch4.png)

- ***Note: there are a number of formatting and other non-fatal warnings that will be reported for the server.js file. Ignore these.***

- Enter a comment for the commit and click **OK**.

    ![](images/lab400/400_14_05_createbranch5.png)

- You may need to enter a Git username. (Enter your username for your cloud service.) And you may need to enter some email address. (Any will do.) Finally, click **OK**.

    ![](images/lab400/400_14_06_createbranch6.png)

### **STEP 15**: Push the Branch Commits to the Cloud

- Click on the **Git Push Icon**.

    ![](images/lab400/400_15_01_gitpushicon.png)

- Enter your cloud username and password that you were given. Make sure **Save credentials to remote url (in plain text)** is checked. Finally, click **OK**.

    ![](images/lab400/400_15_02_createbranch9.png)

- The edited branch within the local Git repository has been successfully pushed to the repository in the Oracle Developer Cloud Service. Click **OK**.

    ![](images/lab400/400_15_03_createbranch10.png)

## Submit a Merge Request for the Branch With the Code Edits and Designate the Edited Code is Ready for Verification

### **STEP 16**: Create a Merge Request as John Dunbar to Merge the Code Edits

It's time to follow the code repository push to the Oracle Developer Cloud Service. Return to the Oracle Developer Cloud Service Services Console.

- Click **Code** on the navigation panel.

    ![](images/lab400/400_16_01_codemenuchoice.png) 

- Choose **AlphaofficeUI.git** as the repository.

    ![](images/lab400/400_16_02_merge1.png) 

- Choose **microserviceuijsV2** as the branch. (This is the branch that has the code edits which we wish to merge with the master branch.)

    ![](images/lab400/400_16_03_merge2.png) 

- Click the **Commits** button to view recent commits. Here we again see that the push we made from the Brackets code editor on the client workstation has succeeded. The edited files are now in the **microserviceuijsV2** branch of the DCS repository. They're all ready to be merged into the **master** branch. 

    ![](images/lab400/400_16_04_merge3.png)

But remember, we are following a rigorous Git-based source control methodology. We cannot have developers like John Dunbar make changes to the main branch of the code. 

- Instead John must make a **merge request** to Lisa the project manager.

    ![](images/lab400/400_16_05_johnlisa.png)

- Click **Merge Request** on the navigation panel, and then click the **New Merge Request** button.

    ![](images/lab400/400_16_06_merge4.png)

- On the **New Merge Request** popup, choose the **Repository**, **Target Branch** and **Review Branch**. Then click **Next**.

    ![](images/lab400/400_16_07_merge5.png)

- On the second popup, add a summary description and select a reviewer. Then click **Next**. 

    ![](images/lab400/400_16_08_merge6.png)

- On the third popup, click **Create**.

    ![](images/lab400/400_16_09_merge7.png)

### **STEP 17**: Designate That the UI Code is Ready for Verification

- Click **Agile** on the navigation panel.

    ![](images/lab400/400_17_01_agilemenuchoice.png) 

- Drag the Feature 6 panel from **In Progress** to the **Verify Code** column to designate to the project manager (Lisa) that the code is ready for verification.

    ![](images/lab400/400_17_02_sprint44.png)  

- Leave the default values and click **Next**.

    ![](images/lab400/400_17_03_sprint45.png)

- Set the **Time Spent** value to 1 day and click **OK**.

    ![](images/lab400/400_17_04_sprint46.png) 

- The **Active Sprints** screen shows the change. You have successfully completed Lab 400!

    ![](images/lab400/400_17_05_sprint46b.png)