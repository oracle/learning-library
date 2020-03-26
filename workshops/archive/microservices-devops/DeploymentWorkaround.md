# Manual Deployment to ACCS from DevCS Workaround

![](images/deploymentworkaround/Picture-Title.png)

Update: January 30, 2018

## Twitter Feed Deployment Error

### **Step 1:** Deployment Error

- If you get the following error on deployment: **Error creating Storage Cloud Service object or communicating with server**, follow these steps to do a manual deployment to Application Container Cloud Server (ACCS)

    ![](images/deploymentworkaround/Picture1.png)

### **Step 2:** Download Build Artifact

- On the left side navigation panel, click **Build** to access the build page.

    ![](images/deploymentworkaround/Picture2.png)

- Click Twitter Feed Build to view build job details

    ![](images/deploymentworkaround/Picture3.png)

- Expand **targets** to expose the build artifacts.

    ![](images/deploymentworkaround/Picture4.png)

- Click on **twitter-microserver-example-dist.zip** to download the build artifact.

### **Step 3:** Deploy from ACCS Service Console

- Return to the tab where your **Main Cloud Dashboard** window is loaded. If your dashboard Window is not available, simply open a tab and go to cloud.oracle.com, and re-login as previously instructed. **Note:** for those using a Trial account, this is will be your Standard Identity Cloud Service based account/dashboard.

- Click on the ![](images/200/PictureHamburger.png) menu at the bottom right hand side of the **Application Container** Dashboard option, and select **Open Service Console**. If the Application Conatiner is not displayed on the Dashboard, use **Customize Dashboard** to add it to the display.

    ![](images/deploymentworkaround/Picture5.png)

- On the Application Container Cloud Service (ACCS) Service Console you can view all the deployed applications. Click **Create Application**

    ![](images/deploymentworkaround/Picture6.png)

- For application platform click **Java SE**.

    ![](images/deploymentworkaround/Picture7.png)

- Enter `JavaTwitterMicroservice` for Name and click **Choose File**

    ![](images/deploymentworkaround/Picture8.png)

- Click **Downloads**. Verify that the **twitter-microservice-example-dist.zip** is selected and click **Open**

    ![](images/deploymentworkaround/Picture9.png)

- Change **Instances** and **Memory** to `1` and click **Create**

    ![](images/deploymentworkaround/Picture10.png)

- You should see the **JavaTwitterMicroservice** being created.  Once created, return to lab 200 and continue.

    ![](images/deploymentworkaround/Picture11.png)
