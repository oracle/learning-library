<!-- ![](images/200/Picture200-lab.png)   -->

## Introduction

Welcome to the Automated Code Inspection workshop. This workshop will walk you through application lifecycle management with embedded code review using SonarQube. It will showcase how SonarQube can save time and improve code quality directly inside the agile development process.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
## Objectives

- Deploy the SonarQube server to the Compute Instance
- Verify the Server Deployment and run analysis

## Required Artifacts

For this lab you will need Oracle Cloud account and Developer Cloud service instance.

## Deploying SonarQube Application to Compute Instance

### **STEP 1**: Create Build Job to Deploy SonarQube Docker Image in Compute Instance.

- **Note:Continuing Lab100, make sure you are in Developer Cloud Service Instance. If not follow the below steps click one Hamburger menu on left top and select Developer, then on the following page click on hamburger menu on right of the instance and the click on Access Service Instance.**

    ![](images/200/lab200_access_devcs_1.png)

    ![](images/200/lab200_access_devcs_2.png)

- Click on **Build** in the left panel and then click on **Create Job**

    ![](images/200/lab200_createBuildJob_1.png)

- Give the name for Job. We name it ```deploySonarQube``` but you can give any name of your choice. Make sure to select template and then click **Create**.

    ![](images/200/lab200_createBuildJob_2.png)

- In the Job configuration page, click on **Before Build** in Job Configuration, next click on **Add Before Build Action** and then select **SSH Configuration**.

    ![](images/200/lab200_createBuildJob_3.png)

- Paste the Private Key for the Public key used to create Compute Instance in Lab 050. Also select **Setup files in ~/.ssh for command-lins tools**

- Note: You can use your own keys but to keep the lab guide easy we are providing one for you.

    ![](images/200/lab200_createBuildJob_4.png)

- Next, click on **Steps** and then **Add Step** and select **Unix Shell**.

    ![](images/200/lab200_createBuildJob_5.png)

- Paste the following commands in the Unix Shell.  

```bash
ssh -o StrictHostKeyChecking=no opc@<SONARQUBE_SERVER_URL> << EOF
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo docker pull sonarqube
sudo firewall-cmd --zone=public --permanent --add-port=9000/tcp
sudo firewall-cmd --reload
sudo docker run --detach -p 9000:9000 sonarqube
exit
EOF
```
- NOTE: In the above commands what we are doing is:
    - SSH into the instance
    - Install docker in instance
    - Start docker
    - Pull sonarQube docker image
    - Open firewall  
    - open port 9000 and run docker image
    - exit ssh

    ![](images/200/lab200_createBuildJob_6.png)

- **Enter your public IP** on line 2, for the virtual machine called sonar_compute that you created earlier.

  ![](images/200/LabGuide200-280aa8cd.png)

- Click **Save**

    ![](images/200/lab200_createBuildJob_7.png)

### **STEP 2**: Run the Build Job and Check Server Deployment

- Click on **Build now**

    ![](images/200/lab200_createBuildJob_8.png)

- Once the job is running click on **Build Log** to check the log and see what steps are being performed.

    ![](images/200/lab200_runBuildJob_1.png)

- Scroll down till the end of log to see success message.

    ![](images/200/lab200_runBuildJob_2.png)

### **STEP 3**: Configure Developer Cloud Service to Use SonarQube

- Click on **Project Administration** from the left panel and select **Build**.

  ![](images/200/LabGuide200-78822efb.png)

- Then click on **Add SonarQube Server Connection**

    ![](images/200/lab200_configureSonar_1.png)

- In the form fill out details and click **Create**.

  ```
  Server Name: SonarQubeServer
  SonarQube Server URL: http://<SONARQUBE_SERVER_URL>:9000
  Username: admin
  Pasword: admin
  ```
  ![](images/200/lab200_configureSonar_2.png)

- Once added let's test if the connection works. **Click on the connection** you just created so it is highlighted. Select **Test Connection** and then check the message for the status.

    ![](images/200/lab200_configureSonar_3.png)

- Go back to Build tab in the left panel and click on the **Job created in Lab 100** (i.e build_maven) and click on **Configure**

    ![](images/200/job_configure.png)

    ![](images/200/lab200_configureSonar_4.png)

- Click on **Before Build**, then click on **Add Before Build Action** and select **SonarQube Settings**.

    ![](images/200/lab200_configureSonar_5.png)

- Select the Sonar Server which we created in previous step from the dropdown list.

    ![](images/200/lab200_configureSonar_6.png)

- Go the **Steps** and the click **Add Step** and select **Maven**.

    ![](images/200/lab200_configureSonar_7.png)

- Here add the sonarQube server URL in **Goals** using the following command and then click **Save** once done.

  ```
  sonar:sonar -Dsonar.host.url=http://<SONARQUBE_SERVER_URL>:9000
  ```

- NOTE: Make sure to change the URL in the above command. It should Public IP address of the compute instance and the port which is 9000 for accessing SonarQube server.

    ![](images/200/lab200_configureSonar_8.png)

- Click on **Build Now** and once the job starts building click on **Build Log**

    ![](images/200/lab200_runBuild_1.png)

- Check the logs, scroll down to see the status.

    ![](images/200/lab200_runBuild_2.png)

- Check the IP to see the dashboard.


### **STEP 4**: Check the Analysis

- To check the analysis done by SonarQube, go to the SONARQUBE_SERVER_URL and port :9000 at the end of url.

    ![](images/200/lab200_soarqube_dashboard.png)

Note: SONARQUBE_SERVER_URL is public IP address of the instance used in previous step.

- Click the **Login  Button** and enter:
  ```
  Username: admin
  Password: admin
  ```
  ![](images/200/1.png)

- Click on the **Projects** in the Navbar and then click on project which in our case is **jersey_example**

    ![](images/200/2.png)

- You will see the analysis report in the overview, to check the issues, bugs click on **Issues**.

    ![](images/200/3.png)

- The panel on the left side displays all the bugs reported in the code.

    ![](images/200/4.png)

 **You are now ready to move to the next lab: [Lab 300](LabGuide300.md)**
