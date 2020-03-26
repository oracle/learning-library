# Continuous Delivery of Java Microservices

![](images/200/Picture-lab.png)

Updated: November 15, 2017

## Introduction

This is the second of several labs that are part of the **Oracle Cloud DevOps and Cloud Native Microservices MySQL workshop.** This workshop will walk you through the Software Development Lifecycle (SDLC) for a Cloud Native project that will create and use several Microservices.

In the first lab (100), the Project Manager created a new project in the Developer Cloud Service and also created and assigned tasks to the developers of this application. In this lab you will assume the persona of the Java developer, who will be tasked with creating a microservices that will allow for retrieval and filtering of twitter data.

***To log issues***, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Objectives

- Access Developer Cloud Service
- Import Code from external Git Repository
- Import Project into Eclipse
- Build and Deploy project using Developer Cloud Service and Oracle Application Container Cloud Service

## Required Artifacts

- The following lab requires an Oracle Public Cloud account that will be supplied by your instructor. You will need to download and install latest version of Eclipse or used supplied compute VM. Instructions are found in the Student Guide.

# Create Initial Static Twitter Feed Service

## Explore Developer Cloud Service

### **STEP 1**: Review Agile Board

- This Lab assumes that you just completed Lab 100 and are still connected to the Oracle Cloud, that you're still in the Developer cloud Service Dashboard, and you're viewing the "Alpha Office Product Catalog Project". If for some reason that is not the case, follow the first several Steps of Lab 100 to once again view the Developer Cloud Service Console.

    ![](images/200/Picture10.5.png)  

- Although you will remain connected to the Oracle Cloud using the user account you were provided, you will take on the Persona of ***Bala Gupta*** as you perform the following steps.

    ![](images/bala.png)  

- Within the **Alpha Office Product Catalog Project**, click on **Agile** found on the left hand navigation.

    ![](images/200/Picture11.png)  

### **STEP 2**: Display the Active Sprint

- On the **Microservices** Board, click **Active Sprints**

    ![](images/200/Picture13.png)  

## Create Initial Git Repository

### **STEP 3**: Create Initial Git Repository

To begin development on our Twitter feed microservices, we could start coding from scratch. However, prior to the formal kickoff of this project, you (as Bala Gupta) have already started doing some proof-of-concept development outside of the Developer Cloud Service in order to assess the feasibility of your assignment. You want to bring that existing code into the Developer Cloud Service as a starting point for your microservices. You will do that by cloning your external GIT repository into the Developer Cloud Service. Your first step will be to accept your task using the agile board.

- Drag and drop **Task1 - Create Initial GIT Repository for Twitter Feed Service** into the **In Progress** swim-lane.  

    ![](images/200/Picture13.5.png)  

- Leave the defaults, and Click **OK**.

    ![](images/200/Picture14.6.png)  

- Your Sprint progress will appear as shown below.

    ![](images/200/Picture16.2.png)  

- In the left hand navigation panel, click **Project**

- On the right side in the **REPOSITORIES** section, click on **New Repository** to create a new Git Repository.

    ![](images/200/Picture17.png)  

- In the New Repository wizard enter the following information and click **Create**.

    **Name:** `TwitterFeedMicroservice`

    **Description:** `Twitter Feed Microservice`

    **Initial content:** `Import existing repository`

    **Enter the URL:** `https://github.com/pcdavies/TwitterFeed.git`

    ![](images/200/Picture18.2.png)  

- You have now created a new GIT repository stored within the Developer Cloud Services that is based on an existing repository.

    ![](images/200/Picture19.png)  

## Create Default Build and Deployment Process

### **STEP 4**: Create Default Build Process

Now that we have the source code in the Developer Cloud Service managed GIT repository, we need to create a build process that will be triggered whenever a commit is made to the master branch. We will set up a Maven build process in this section.

- On the left side navigation panel, click **Build** to access the build page and click **New Job**.

    ![](images/200/Picture20.png)  

- In the New Job popup enter `Twitter Feed Build` for the Job Name, and then click **Save**.

    ![](images/200/Picture21.png)  

- You are now placed into the job configuration screen.

    ![](images/200/Picture22.png)  

- On the Main tab of the Configure Build screen change the **JDK** drop down to **JDK8**.

    ![](images/200/Picture23.png)  

- Click the **Source Control** tab.

- Click **Git** and select the **TwitterFeedMicroservice.git** from the drop down.

    ![](images/200/Picture24.png)  

- Click the **Triggers** tab.

  **Select**: `Based on SCM polling schedule`

    ![](images/200/Picture25.png)  

- Click the **Build Steps** tab. Click **Add Build Step**, and select **Invoke Maven 3**.

    ![](images/200/Picture26.png)  

- Change **Goals** to `clean assembly:assembly`

    ![](images/200/Picture27.png)  

- Click the **Post Build** tab and complete the following:
  - Check **Archive the artifacts**.
  - Enter `**/target/*` for **Files to Archive**.  
  - Verify **GZIP** in the Compression Type.
  - Check **Publish JUnit test report**
  - Enter `**/target/surefire-reports/*.xml` for the Test Report XMLs. This will provide a report on the Test Scripts results for each build.

    ![](images/200/Picture28.png)  

- Click **Save** to complete the configuration.

- Click the **Build Now** button to start the build immediately. Wait, as it may a few minutes for the queued job to execute, but when it does, the status will change to the following:

    ![](images/200/Picture28_5.png)  
    ![](images/200/Picture29.png)  

  **NOTE:** Once the build begins, it should take about approximately 1 to 2 minutes for the build to complete. Once complete, you will see the number of successful test runs in the Test Result Trend section. ***Wait for the build to complete before continuing to the next step***, as we need the build artifact to complete the deployment configuration.

- After the build begins, you can also click on the **Console Icon** ![](images/200/Picture30.1.png) to monitor the build log details.

    ![](images/200/Picture30.png)  

### **STEP 5**: Create Default Deployment Process

Now that you have successfully built your project, you need to create a deployment configuration that will watch for stable builds and deploy them to a new Application Container Cloud Service instance for testing.

- On the navigation panel click **Deploy** to access the Deployment page. Click **New Configuration**.

    ![](images/200/Picture31.png)  

- Enter the following data:

  **Configuration Name**: `TwitterFeedMicroserviceDeploy`

  **Application Name**: `JavaTwitterMicroservice`

    ![](images/200/Picture32.png)  

- To the Right of Deployment Target, click **New** and select **Application Container Cloud**

    ![](images/200/Picture33.png)  

- Enter the following data:

  - **Data Center**: `<Your Assigned Datacenter>` 

  - **Identity Domain**: `<Your Identity Domain>` ***Note***: If you are using a **Trial account** and followed the instructions in the [Trial Account Student Guide](StudentGuide.md), then in place of the Identity Domain, you populate this field with the **Identity Tenant ID** you recorded.

  - **Username**: `<Your User Name>`

  - **Password**: `<Supplied Password>`

- Click **Test Connection**. If Successful, click **Use Connection**:

    ![](images/200/Picture34.3.png)  

    **Note:** If you are not able to connect, double check you credentials. If your connection still does not work, and this is an **Oracle Trial account**, please review the Student Guide for this workshop, and follow the steps outlining how to set your **Storage Replication Policy**.  

- Set the following Properties as follows:

  - **Runtime**: `Java`

  - **Subscription**: `Hourly`

  - **Type:** `Automatic` and `Deploy stable builds only`

  - **Job:** `Twitter Feed Build`

  - **Artifact:** `target/twitter-microservice-example-dist.zip`

    ![](images/200/Picture35.3.png)  

- To reduce the number of resources that are used we will modify the default deployment of 2 instances. Click **Include ACCS Deployment** and enter the following in the text box:

```
{
  "memory": "2G",
  "instances": "1"
}
```

![](images/200/Picture35.4.png)  


- Click **Save**

    ![](images/200/Picture36.2.png)  

- Click the gear drop down and select **Start**

    ![](images/200/Picture37.2.png)  

- Wait until the message **Starting application** changes to **Last deployment succeeded**

    ![](images/200/Picture38.2.png)  

    ![](images/200/Picture38.3.png)  

- **Note**: You possibly may receive the following message in the header. If the status of the deployment is still showing **Starting** or **Deploying**, close this error message and wait for the deployment status to show failed or success, as the deployment may automatically retry and successfully complete.

    ![](images/200/Picture38.4.png)

## Verify Twitter Feed Microservice deployment

### **STEP 6**: Login to Oracle Application Container Cloud Service

- Return to the tab where your **Main Cloud Dashboard** window is loaded. If your dashboard Window is not available, simply open a tab and go to cloud.oracle.com, and re-login as previously instructed. **Note:** for those using a Trial account, this is will be your Standard Identity Cloud Service based account/dashboard.
 

- Once the Oracle Public Cloud **Dashboard** is displayed, click on the  ![](images/200/PictureHamburger.png) menu in the upper left and select **Application Container** service. 

    ![](images/200/Picture43.1.png)  

- On the Application Container Cloud Service (ACCS) Service Console you can view all the deployed applications, including our newly created **JavaTwitterMicroservice**. Click on the **URL**, and it will load a new browser tab. Alternatively, copy and paste the URL into the address bar of a new browser tab.

    ![](images/200/Picture44.png)  

- Append **/statictweets** to the end of the URL in the browser.

    **Note:** The URL should return a JSON array containing a Static Twitter feed. If you desire to see a formatted view of the JSON, and you are using Chrome, open a new tab and search Google for **JSONViewer chrome plugin** – After you install the Chrome Plugin and re-submit the URL, you will be able to view the JSON in a more readable format.

    ![](images/200/Picture45.png)  

### **STEP 7**: Complete Task

We have now verified that the statictweets microservice has been deployed and functions properly. To finish up this part of the lab, we will mark the Issue as completed in the Sprint.

- Back in the Developer Cloud Service window, click **Agile**, followed by clicking **Active Sprints**.

- Drag and drop **Task 1** from **Verify Code** to **Completed**.

    ![](images/200/Picture46.2.png)  


- In the Change Progress popup click **Next**.

    ![](images/200/Picture47.1.jpg)  

- In the **Add Time Spent** popup, set the **Time Spent** to `1` and click **OK**.

    ![](images/200/Picture47.5.png)  

- Your Sprint should now look like the following:

    ![](images/200/Picture48.2.png)  

- You can also click on the **Reports** button and view your progress in the **Burndown Chart** and **Sprint Report**.

    ![](images/200/Picture49.png)  

# Add Filter to Static Twitter Feed Service

Now that we have completed the import, build, deployment, and verification of our initial static twitter microservice, it is time to extend the project by adding a new microservice that allows us to dynamically filter the incoming tweets based on their contents. We will use the Eclipse IDE to clone the managed GIT repository to our local workstation and add the filtering feature to the local copy. We will create a new code branch for it and commit the branch. Then we will create a merge request and switch to the Project Manager persona to approve that request. We will also see how we can manage our agile task status directly from Eclipse.

## Clone Project to Eclipse IDE

### **STEP 8**: Load Eclipse IDE

In the following task we will provide screen shots taken from the optional compute image provided with the workshop. If you are using Eclipse and Brackets on your local hardware, your screens may vary slightly.

- Right Click and select **Run** on the **Eclipse** Desktop Icon.

    Note: If you have not already installed and configured Eclipse, please see this Workshop's **Student Guide** for instructions on how to install and configure it.

    ![](images/200/Picture50.png)  

### **STEP 9**: Create connection to Oracle Developer Cloud Service

- We will now create a connection to the Developer Cloud Service. To do this, first click on the menu options **Window -> Show View ->Other**  

    ![](images/200/Picture52.png)  

- Enter `oracle` in the search field. Select **Oracle Cloud**, and click on **OK**.  

    ![](images/200/Picture53.png)  

- Click on **Connect** in the Oracle Cloud tab

    ![](images/200/Picture54.png)  

- Enter the following information, then click on the **Finish** button:

  - **Identity Domain**: `<your identity domain>` ***Note:*** if you're using a trial account, since you are connecting to the Developer Cloud Services, which is a Traditional Service, you populate this field with the **Identity Domain Name** you recorded.

  - **User name**: `<your Username>`

  - **Password**: `<your Identity domain password>`

  - **Connection Name**: `OracleConnection`

    ![](images/200/Picture55.2.png)  

- If prompted, enter and confirm a Master Password for the Eclipse Secure Storage.
  - In our example we use the **password:**  `oracle`. Press **OK**.

    ![](images/200/Picture56.png)  

  - If prompted to enter a Password Hint, click on ***No***

    ![](images/200/Picture57.png)  

### **STEP 10**: Create a local clone of the repository

- **Expand Developer**, and then **double click** on **Alpha Office Product Catalog** project to activate the project.

    ![](images/200/Picture58.png)  

- **Expand** the **Code** section, and **double click** on the **Git Repo** [**TwitterFeedMicroservice.git**], to cause the Repo to be cloned locally.

    ![](images/200/Picture59.png)  

- To import project into Eclipe navigate to the top left **File** menu and select **Import**.

    ![](images/200/Picture59.1.png)  

- In Import wizard, expand the **Git** menu item and select **Projects from Git**. Click **Next**

    ![](images/200/Picture59.2.png)  

- Select **Existing local repository** and click **Next**

    ![](images/200/Picture59.3.png)  

- Select the **TwitterFeedMicroservice** git repository and click **Next**

    ![](images/200/Picture59.4.png)  

- Take the defaults and click **Next**

    ![](images/200/Picture59.5.png)  

- Review configuration and click **Finish**

    ![](images/200/Picture59.6.png)  


### **STEP 11**: Set Feature 2 Status to In Progress

In the previous steps we updated the status of the Tasks assigned to "Bala Gupta" using the web interface to the Developer Cloud Service. In this step we will use the Eclipse connection to the Developer Cloud Service to update the status of Bala’s tasks.

- Within the Oracle Cloud Connection tab, double click the **Issues** to expand, then double click on **Mine** to expand your list. Once you see the list of your Issues, then double click on **Create Filter on Twitter Feed**. You can adjust what Eclipse views are visible using the right side and top Window menu options. 

    ![](images/200/Picture71.png)  

- Scroll down to the bottom of the **Create Filter on Twitter Feed** window. In the Actions section, and change the **Actions** to **Accept (change status to ASSIGNED)**, then click on **Submit**.

    ![](images/200/Picture72.2.png)  

- Optionally, if you return to the Developer Cloud Service web interface, you’ll see that the Eclipse interface caused the Feature 2 to be moved to the **In Progress** column of the **Agile > Active Sprints**.

    ![](images/200/Picture73.2.png)  

## Add the Filter to the Service

The Code we cloned locally contains the entire source necessary to filter the Static Twitter Feed. In this section of the lab, we will un-comment the code and test the filter.

### **STEP 12**: Add Filter

- In the Project Explorer, **expand** the **TwitterFeedMicroservice > src/main/java > com.example** and **double click** on **StaticTweets.java** to open the source code.

    ![](images/200/Picture78.png)  

- In the StaticTweets.java source file, scroll down until you find two lines of code that begin with “**--- Remove this comment**”. **Delete both of these lines** to activate the code that will cause filtering of the Static Tweets file to occur.

    ![](images/200/Picture79.png)  

- Your code should now look like this:

    ![](images/200/Picture75.5.png)  

- Next we will enable the filter in the testing code. Expand the **src/test/java > com.example folder**, and **double click** on **MyServiceTest.java** to open the source file

    ![](images/200/Picture80.png)  

- In the MyServiceTest.java source file, locate the method **testGetStaticSearchTweets()**, and **remove** the **comments** so that section of code will execute.

    ![](images/200/Picture81.png)  

- Click on the **Save All** icon

    ![](images/200/Picture82.png)  

## Create Branch and Merge Request

### **STEP 13**: Create Branch

- right click on **TwitterFeedMicroservice** and select **Team > Switch To > New Branch**

    ![](images/200/image087.png)  

- Enter **Feature2** for the Branch name, and click on **Finish**

    ![](images/200/image088.png)  

- We can now commit our code to the branch by Right Clicking on **TwitterFeedMicroservice** and then selecting **Team > Commit**

    ![](images/200/image089.png)  

- Enter “**Feature2: Added Support for Filtering**” in the Commit Message box.
- If the changed files are not already identified as Staged Changes, **Drag and Drop** the **changed files** into the **Staged Changes** panel.
- Click on **Commit and Push**. Note: it is possible to change the default Author and Committer to match the current “persona." However, for the sake of this lab guide, we will leave the defaults.  

    ![](images/200/image090.png)  

- Accept the Default for the **Push Branch Feature** 2 dialog and click on **Next**
- Click on the **Finish button** in the Push Confirmation dialog
- Click on **Ok** in Push Result dialog

### **STEP 14**: Create Merge Request

- Return to the Developer Cloud Service Dashboard in the browser.  If the session has timed out you may have to navigate to it again. On navigation panel click **Code**, select the **Feature2** branch. Notice the changes. Click on the **Src** folder to view the changes commited to the branch from Eclipse.

    ![](images/200/image094.png)  

- Click **Logs** to view latest commit.  Click commit link on left hand side to view code changes.

    ![](images/200/image093.5.png)  
    ![](images/200/image093.6.png)  


- Now that "Bala Gupta" has completed the task of adding the search filter, a **Merge Request** can be created by Bala and assigned to Lisa Jones. Click on **Merge Requests** on navigation panel and then click on the **New Merge Request** button.

    ![](images/200/image094.5.png)  

- Enter the following information into the **New Merge Request** and click **Next**

  **Repository:** 	`TwitterFeedMicroservice.git`

  **Target Branch:** `master`

  **Review Branch:** `Feature2`

    ![](images/200/image096.png)  


- Enter the following information into **Details** and click **Create**

  **Summary:** `Merge Feature 2 into master`

  **Reviewers:** `<Your Username>`

    ![](images/200/image097.2.png)  

    **Note**: **Bala Gupta** is logically sending this request to **Lisa Jones**

## Merge the Branch as Lisa Jones

In the following steps “Lisa” will merge the branch create by “Bala” into the master.

### **STEP 15**: Merge Requests

![](images/lisa.png)  

- On navigation panel click **Merge Requests**. Select the **Assigned to Me** search. After the search completes, click on the **Merge Feature 2 into master** assigned request.

    ![](images/200/image106.png)  

- Once the request has loaded, select the **Changed Files** tab. “Lisa” will now have the opportunity to review the changes in the branch, make comments, request more information, etc. before Approving, Rejecting or Merging the Branch.

    ![](images/200/image107.2.png)  

- Click on the **Merge** button.

    ![](images/200/image108.png)  

- Leave the defaults, and click on the **Create a Merge Commit** button in the confirmation dialog.

    ![](images/200/image109.png)  

- Now that the code has been committed to the Developer Cloud Service repository, the build and deployment will automatically start. On the navigation panel click **Build**, and you should see a **Twitter Feed Build** in the Queue

    ![](images/200/image110.png)

- Wait a minute or two for the build to start and to complete. The **Last Success** will be set to **Just Now** when the build completes.

    ![](images/200/image111.png)

## Test the JavaTwitterMicroservice in the Cloud

### **STEP 16**: Test Microservice

- Click **Deploy** in the left-hand menu to load the **Deployments** screen.

- Once the Deploy completes Successfully, click on the **JavaTwitterMicroservice** link

    ![](images/200/image113.png)  

- When the new browser tab loads, Append **/statictweets** to the end of the URL and **press enter** to test the original static twitter service

    ![](images/200/Picture45.png)  

- Now appended `/statictweets/%23Expo` to the end of the URL and **press enter**. This will cause records containing **#Expo** in the tweet’s text or hashtags to be returned. This is how our Product Catalog will retrieve tweet's associated to a product.

    ![](images/200/image115.png)  

- To complete the Sprint Feature, click **Agile** on left hand navigation. Then click on the **Active Sprints** button.

    ![](images/200/image116.png)  

- Complete the feature request by Dragging and Dropping **Feature 2** (Create Filter on Twitter Feed) from the **In Progress** to the **Completed** Column.

    ![](images/200/image117.png)  

- Leave defaults and click **Next**.

    ![](images/200/image118.png)  

- Set the **Time Spent** to `1` and click on **OK**.

    ![](images/200/image118.5.png)  

- **You are now done with this lab.**

# Supplementary Assignment – Twitter Live Feed Credentials

## Create Twitter App

***This is an optional assignment. We recommend that this section only be attempted if you have ample time to complete the other labs. Otherwise, return to this section later***. During this assignment you’ll have an opportunity to put your new knowledge of the Developer Cloud Service to work by extending our static twitter microservices to use live twitter data. In this exercise, you will acquire Twitter Application Credentials and use them to operate on a live twitter feed in your microservices. For the purposes of this assignment, you will use a personal account to log in to twitter and generate the credentials. However, in the context of our application, assume that these credentials have been provided by Product Management and represent the approved credentials for our production application.

You have two options for managing this code change in the version control system. If you would like more practice with the multi-user workflow, you can start a new branch for this feature, commit to that branch, create a merge request, and approve the merge. We’ll refer to this in the instructions as **Method A**. If you’re comfortable with that workflow, you can switch to master in your local repository, pull the latest revision from the cloud, and commit and push directly to master for this exercise. This will be **Method B**.

### **STEP 17**: Create New Twitter App

To generate the unique twitter credentials for our microservices, we need to sign in to twitter and create a new application for this project, then generate access tokens for it.

- Navigate to https://apps.twitter.com. Click on the **Sign In** link.

    ![](images/200/image119.png)  

- If you are already a twitter user, **Log In** using your twitter credentials. Otherwise, click on the **Sign up Now** link

    ![](images/200/image120.png)  

- Once logged in, click on the **Create New App** button.

    ![](images/200/image121.png)  

- **Enter the following** and Click on the **Create your Twitter application** button. When entering the Application Name, append something unique to the Name’s end. E.g. your initials or name:

  **Name:** `JavaTwitterMicroservice<UniqueName>`

  **Description:** `A Twitter Feed Microservice`

  **Website:** `https://cloud.oracle.com/acc`

  **Developer Agreement:** Click `Yes`

    ![](images/200/image122.png)  

- Click on the **Keys and Access Tokens** tab.

    ![](images/200/image123.png)  

- If at the bottom of the page your Tokens are not visible, click on the **Create my access tokens** button

    ![](images/200/image124.png)  

- Note: If you are following **Method B**, before you start modifying code in Eclipse, you should switch to the master branch and pull from the remote repository.

- Return to Eclipse, and in the Project Explorer tab, expand **TwitterFeedMicroservices.git > src/main/config** and double click on **twitter-auth.json** to load the source.

    ![](images/200/image125.png)  

- This is the File that will be deployed to the Application Container Cloud. Edit this file by replacing the xxx’s in **consumerKey, consumerSecret, token and tokenSecred with the Consumer Key (API Key), Consumer Secret (API Secret), Access Token and Access Token Secret** found on the Twitter Application Management page.

    ![](images/200/image126.png)  

- Click on the Save All icon in Eclipse ![](images/200/image127.png)

- So we can test locally, let’s repeat the same step by updating the Test Code’s twitter-auth.json credentials. Open the file located in **TwitterFeedMicroservices.git > src/test/resources > twitter-auth.json** and update. Once updated, click on the **Save All** Icon.

    ![](images/200/image128.png)

- Let’s now un-comment the code that will allow the online Twitter Feed to be tested. Using the Project Explorer, open the **TwitterFeedMicroservice.git > src/test/java > com.example > MyServiceTest.java** file.

    ![](images/200/image129.png)

- In the MyServiceTest.java file, located the method **testGetTweets()** and **remove the comment** surrounding that method.

    ![](images/200/image130.png)

- Click on the Eclipse Save All icon ![](images/200/image127.png)

- Run the Test by right clicking on **TwitterFeedMicroservice** and selecting **Run As > Maven Test**

    ![](images/200/Picture87.png)

- After the tests run, the testGetTweets() method will return the message “The client read 10 messages!,” and all Tests should complete successfully.

    ![](images/200/image131.png)

- If you’re following **Method A**, now that you’ve enabled this new feature to access the live twitter feed, you can follow the previous steps used in this document to commit the code to the cloud. Once committed, you will use the Developer Cloud Service to create a merge request and then approve that request. Once the master branch is updated, an automatic build and deployment to the Application Container Cloud Service will be performed. Verify that deployment is successful before continuing.

- If you’re following **Method B**, now that you’ve enabled this new feature to access the live twitter feed, you can follow the previous steps used in this document to commit the code to the cloud. That will trigger an automatic build and cause the Application Container Cloud Service deployment to be performed by the Developer Cloud Service. Verify that deployment is successful before continuing.

- For either method, you will now be able append `/tweets` to the end of the Application Container Cloud Service URL and retrieve the Live Tweets.

- The example below shows the live tweets returned, once the application is re-deployed.

    ![](images/200/image132.png)
