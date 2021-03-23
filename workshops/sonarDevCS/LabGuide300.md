

## Introduction

Welcome to the Automated Code Inspection workshop. This workshop will walk you through application lifecycle management with embedded code review using SonarQube. It will showcase how SonarQube can save time and improve code quality directly inside the agile development process.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
## Objectives

- Run the job to see the new analysis in SonarQube.
- Create issue in Developer Cloud Service
- Fix the issue in code
- Close issue in Developer Cloud Service.

## Required Artifacts

For this lab you will need Oracle Cloud account and Developer Cloud service instance.

## Fixing the issue in code

### **STEP 1**: Check for the Issue in SonarQube

- Continuing the previous lab, go to the issues page in sonarQube, for this workshop we will solve the issue type **Bug**.

    ![](images/300/1.png)

- As you can see there are two issues shown under bug category with severity Critical and Major.

    ![](images/300/2.png)

- Click on the first issue and check for the error message. As you see the error message, you can select the type of issue, severity, whether the issue is solved or still open, who is it assign to and how many minutes it might take to fix the issue.

    ![](images/300/3.png)

### **STEP 2**: Create issue in Developer Cloud Service

- Go back to Oracle Cloud, navigate back to your MyServices dashboard by selecting the **Hamburger Menu** and clicking **MyServices Dashboard**.

    ![](images/050/4.png)

- Expand the **Developer Hamburger Menu** and select **Open Service Console**.

    ![](images/100/LabGuide100-502d58d4.png)

- You should see the Developer Cloud Instance you provisioned in the previous lab. Ensure it is in the ready state then click the menu icon to the right of the name and with the options visible select **Access Service Instance**.

    ![](images/100/5.png)

- We will generate new issue based on the error messagee seen in the previous step. Click on **Issues** in the left panel and then click on **Create Issue**.

    ![](images/300/4.png)

- Fill out the form as shown in the below image.
    ```
    Summary: Solve bug in TwitterService.java
    Description: Error on line 86
    Owner: Set to Your Name
    ```

    ![](images/300/LabGuide300-adf2be32.png)

- We will generate another issue. Fill out the form as shown in the below image.
    ```
    Summary: Solve bug in SampleStreamExample.java
    Description: Error on line 114
    Owner: Set to Your Name
    ```

    ![](images/300/Lab300_bug.png)

### **STEP 3**: Edit Code in DevCS Git Repo

- Click on **Git** in left panel to see the code repository.

    ![](images/300/6.png)

- Go to the file SampleStreamExample.java , path as shown in following image and  click on pencil icon to edit.
    ![](images/300/7.png)

- Go to line 114 and add word **throw** before the line.

    ![](images/300/8.png)

- Repeat the process and go to file TwitterService.java, path as shown in following image and click on pencil icon to edit.

    ![](images/300/9.png)

- Go to line 86 and remove **return**.
Reason of error: Using return, break, throw, and so on from a finally block suppresses the propagation of any unhandled Throwable which was thrown in the try or catch block.

    ![](images/300/10.png)

### **STEP 4**: Check the SonarQube for Issue Fix

- With the job already configured to run automatically on commit, go to SonarQube server dashboard. And you can see there are zero bugs shown.

    ![](images/300/11.png)

- To confirm open issues page and click on bug.

    ![](images/300/12.png)

### **STEP 5**: Close the Issue in Developer Cloud Service

- Go back to Developer cloud service and click on **Issues** in left panel.

    ![](images/300/13-1.png)

- Select the issue and then click on **Update Selected**

    ![](images/300/13.png)

- In the form check the **Status** and select **Resolved**. Also check **Resolution** and select **Fixed** from dropdown. Click **Next** when finished.

    ![](images/300/14.png)

    ![](images/300/15.png)

- Click **Save** to close the issue.

    ![](images/300/LabGuide300-3814f43a.png)

 **You are now ready to move to the next lab: [Lab 400](LabGuide400.md)**
