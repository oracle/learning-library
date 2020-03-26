![](images/100/image1.png)

Update: March 24th, 2017

## Introduction

This workshop will walk you through building an automated Software Development Lifecycle (SDLC) pipeline using the Oracle cloud and third party tools

This new pipeline will compile code, build environments in the cloud, and deploy the code into the new environment. You will assemble this pipeline leveraging Developer Cloud Service, Jenkins, Oracle Cloud Orchestrations, and Chef. You will take on 2 Personas during the workshop. The stack automation engineer will assemble the pipeline and make it available for developers. The developer will leverage the new SDLC stack and check in code leveraging the pipeline.

At the end of the workshop you will have deployed a new application in the Oracle cloud as the developer persona leveraging the pipeline to complete all the tasks after the code is checked into source control.

***To log issues***, click here to go to the [github oracle](https://github.com/pcdavies/DevopsAutomationChefJenkins/issues/new) repository issue submission form.

## Objectives

-   Create Jenkins Server

-   Configure Chef Server

-   Clone Application

-   Build a new version of the application

## Required Artifacts

-   The following lab requires an Oracle Public Cloud account that will be supplied by your instructor.

-   You will need to install an object storage browser

-   You will need a SSH client



# Install Object Storage Tools

### **STEP 1**: Install CloudBerry Explorer for OpenStack desktop Client

**Note**: If you prefer to use Cyberduck you can find instructions at [this URL](https://trac.cyberduck.io/wiki/help/en/howto/oraclecloud) or follow the instructions out lined in **MAC OSX Appendix**. For MAC users you will need to use Cyberduck as CloudBerry only runs on Windows.

-   From any browser, go to [this URL](http://www.cloudberrylab.com/free-openstack-storage-explorer.aspx)

-   Click **Download FREEWARE**. After download completes run executable to install.

    ![](images/100/image2.png)

-   Open **CloudBerry Explorer for OpenStack Storage** desktop client.

-   Click **File** and select **New Oracle Cloud Account** from the list of options.

    ![](images/100/image3.png)

-   Supply the necessary information:

    **Display name**: `my_domain`

    **Username**: `Storage-<Your Identity Domain>:<Your OPC Username>`

    **Password**: `<Your OPC Password>`

    **Account location**: `Select the correct data center`

    ![](images/100/image4.png)

-   Click **Test Connection**. If you get Connection success click **Close** and **OK** to complete the configuration.

    ![](images/100/image5.png)

-   From the **Source** dropdown, select the newly created **my\_domain** account. You should see the pre-created containers.

    ![](images/100/image6.png)

### **STEP 2**: Install PuTTY - SSH Client Tool

-   From any browser, go to this [URL](http://www.putty.org/)

    ![](images/100/image7.png)

-   Click on the link to download PuTTY. From the PuTTY download page click on **putty.exe** to download.

    ![](images/100/image8.png)

-   Save **putty.exe**. Navigate to the location you downloaded the file and double click on **putty.exe** to run.

    ![](images/100/image9.png)

-   We will be using PuTTY later in the workshop to access the newly create Cloud Instance. You can minimize or exit PuTTY for now.

# Building the Client Machine (Stack Engineer Persona)

## Building the Instance

In this section we are going to build Oracle Compute VM using a private disk image. This VM contains a fully configured Jenkins Server with all the jobs already created to support this workshop.

### **STEP 3**: Verify Image file has been uploaded

-   From CloudBerry make sure that **my\_domain** is selected on the right hand side. Double click on **compute\_images** to navigate into the container. Due to the size of the disk image, we have already uploaded the **Jenkins** image file that will be used later in the lab.

    ![](images/100/image10.png)

## Preparing Network Assets in the Instance

### **STEP 4**: Move Orchestration from Storage Cloud

-   From CloudBerry make sure that **my\_domain** is selected on the left hand side **Source** dropdown. Navigate to **SDLC\_Pipeline\_wksp -> general -> orchestration\_json**. ON right hand side source select **My Computer**. Either create a new directory or navigate to a location on your local system that you want to store Workshop Files. In our example we are using **D:\\SDLCwithDevOpsWorkshop**.

    ![](images/100/image11.png)

-   Drag and drop **wkshpnetwork.json** from **my\_domain** to **My Computer**. When prompted **Do you really want to copy** click **Yes**

    ![](images/100/image12.png)

-   Right click on **wkshpnetwork.json** and click **Open** to open the file in a text editor.

    ![](images/100/image13.png)

-   Search and replace Identity Domain **gse00002056** with you **your Identity Domain**. Save file and exit editor.

    ![](images/100/image14.png)

-   In my\_domain, navigate to **SDLC\_Pipeline\_wksp -> general -> SSH\_KEY.** Drag and drop the 3 SSH Key files from **my\_domain** over to **My Computer.**

    ![](images/100/image15.png)

# Creating the Instance (Stack Engineer Persona)

## Create the Network Configuration

### **STEP 5**: Login to your Oracle Cloud account

-   From any browser, go to the following URL:

```
https://cloud.oracle.com
```

-   Click **Sign In** in the upper right hand corner of the browser:

    ![](images/100/image16.png)

-   **IMPORTANT** - Under My Services, ask your instructor which **Region** to select from the drop down list, and **click** on the **My Services** button.

    ![](images/100/image17.png)

-   Enter your identity domain and click **Go**

    ***NOTE***: the **Identity Domain, User Name** and **Password** values will be given to you from your instructor.

    ![](images/100/image18.png)

-   Once your Identity Domain is set, enter your User Name and Password and click **Sign In**

    ![](images/100/image19.png)

-   You will be presented with a Dashboard displaying the various cloud services available to this account.

    ![](images/100/image20.png)

-   If all your services are not visible, **click** on the **Customize Dashboard,** you can add services to the dashboard by clicking **Show**. If you do not want to see a specific, service click **Hide**.

    ![](images/100/image21.png)

### **STEP 6**: Compute Service Console

-   From the main Cloud Dashboard, click **Compute** to navigate to details page.

    ![](images/100/image22.png)

-   Compute Service Details page will give you an overview of your compute service. Make note of the default **Site** from the **REST Endpoint** (Z\#\# - In our example Z16). Click **Open Service Console**

    ![](images/100/image23.png)

-   The Compute Service Console will be used for the monitoring and creation of all compute VM’s. In the upper right hand corner click **Site** dropdown:

    ![](images/100/image24.png)

-   Verify that the default **Site** you select matches the default site you previously located within the REST endpoint. If it does not match, use the **Site Selector** to select the correct **Site**. In our example, we are changing from Z17 to Z16 to match the zone referenced in the REST endpoint.

    ![](images/100/image25.png)

### **STEP 7**: Upload Orchestration

-   Click on **Orchestrations** Tab. From the Orchestrations page click **Upload Orchestration**

    ![](images/100/image26.png)

-   Click **Select File** and select the **wkshpnetwork.json** file on your workstation that you just edited. Click **Upload**

    ![](images/100/image27.png)

-   You should now see the newly uploaded orchestration in your list. Click ![](images/100/image28.png) and select **Start**

    ![](images/100/image29.png)

-   Click **Yes** to start the Orchestration

    ![](images/100/image30.png)

-   The Orchestration status will change to **Starting**. After a short period, the status will change to **Ready**

    ![](images/100/image31.png)

    ![](images/100/image32.png)

### **STEP 8**: Upload SSH Key

-   Click on the **Network** Tab then click **SSH Pubic Keys**. Click **Add SSH Public Key**

    ![](images/100/image33.png)

-   Enter Name **DevOpsDemoKey**. This name is important to remember, because it will be referenced later when configuring Jenkins. Open file **DevOpsDemo.pub**, copied over earlier, in a text editor. Copy the key and paste into the **Value** field. Click **Add**

    ![](images/100/image34.png)

    ![](images/100/image35.png)

    ***Note***: If you get an error that it is not a valid key make sure you do not have an extra carriage return at the end of the line.

## Build Instance on Oracle Compute

### **STEP 9**: Associate Image to upload disk

-   Navigate to the **Images** tab and click **Associate Image**

    ![](images/100/image36.png)

-   In the Associate Image window enter the following then click **Select File**:

    **Name**: `Jenkins_Server`

    **Description**: `Jenkins Server`

    ![](images/100/image37.png)

-   Verify **JenkinsImage.tar.gz** is selected and click **Ok**

    ![](images/100/image38.png)

-   Verify the information is correct and click **Ok**

    ![](images/100/image39.png)

-   After a short amount of time, you should see your newly created Image.

    ![](images/100/image40.png)

### **STEP 10**: Create Instance

-   Now we will use the newly created image to create an Instance. Navigate to the **Instances** tab and click **Create Instance**

    ![](images/100/image41.png)

-   Select **Private Images** on the left. Click **Select** to the right of the **Jenkins\_Server**

    ![](images/100/image42.png)

-   Click **Shape** and verify that **oc3** shape is selected.

    ![](images/100/image43.png)

-   Click **Instance**. We will leave the default Name.

    ![](images/100/image44.png)

-   Click in the **SSH Keys** field. Select **DevOpsDemoKey** that was added previously

    ![](images/100/image47.png)

-   Click **Network**. Click inside of the **Security Lists** field. Select **ssh_access**.

    ![](images/100/image45.png)

-   Also, select **web\_access** from the Security Lists.

    ![](images/100/image46.png)

-   Click **Storage**. Click ![](images/100/image28.png) next to the default storage, and select **Remove**

    **Note**: By removing the disk, the instance will build the disk as ephemeral, which is faster, and will allow for Snapshots.

    ![](images/100/image48.png)

-   Click **Review**. Once you have verified all the information is correct click **Create**.

    ![](images/100/image49.png)

-   From the Summary page, you can monitor the process of the Instance creation.

    **Note**: It may take a couple of minutes for the instance to appear.

    ![](images/100/image50.png)

-   While the instance is creating you are able to view details as they are made available. Click ![](images/100/image28.png) and select **View**

    ![](images/100/image51.png)

-   On this screen, you can view all the details about the instance that is being created.

    ![](images/100/image52.png)

-   Click **Logs** to monitor the Console Log during creation. You might need to wait a few minutes before the console log will display.

    ![](images/100/image53.png)

-   Click **Instances** to navigate back to the summary page. After about 10 minutes the status of the instance should change to **Running**

    ![](images/100/image54.png)

## Log into Instance

### **STEP 11**: Get Public IP of Instance

-   From the Summary page copy down the **Public IP** for your newly created instance.

    ![](images/100/image55.png)

### **STEP 12**: Configure PuTTY to connect to Image

-   If you closed out PuTTY start it again.

-   On the **Session** Category paste in the Public IP for you instance.

    ![](images/100/image56.png)

-   Under category **Connection** click **Data**. Enter **opc** for Auto-login username.

    ![](images/100/image57.png)

-   Expand **SSH** and click **Auth**. Click **Browse** and select the **DevOpsDemo.ppk** file that you downloaded earlier in the lab.

    ![](images/100/image58.png)

-   Click back on **Session** category. Enter **JenkinsServer** in the Saved Sessions and click **Save**. Now click **Open** to connect to the instance

    ![](images/100/image59.png)

-   Click **Yes** on PuTTY Security Alert.

    ![](images/100/image60.png)

-   When prompted for a Passphrase enter **Summer15\#**. You are now connected to your newly create Jenkins instance.

    ![](images/100/image61.png)

### **STEP 13**: Test Jenkins

**Note:** Jenkins is a continuous integration and continuous delivery application, used to automate parts of the SDLC. Jenkins can be leveraged to build and test software projects continuously     making it easier for developers to integrate changes to the project, and making it easier for users to obtain a fresh build. It also allows for continuous delivery of software by providing powerful ways to define build pipelines and integrating with many testing and deployment technologies.

-   Open a browser and enter the **Public IP** for your newly create instance. The Jenkins login page should render as shown below.

    ![](images/100/image62.png)

-   Click **log in** and enter the following credentials:

    **User**: `opcmasterchef`

    **Password**: `Summer15#`

    ![](images/100/image63.png)

## Configure the Server for work

### **STEP 14**: Configure Chef client (Knife)

-   Switch back to your **SSH** session. Switch to the **jenkins** user and change to the home directory

    ```
    sudo -s

    su jenkins

    cd /home/jenkins
    ```

    ![](images/100/image64.png)

    -   Run script **downloadcheffiles.sh** to load the needed chef configuration files. 
    
    ***Note***: The instructor will supply each group with an **Organization Id**. For our example, we will be using Org Id 1.

    `./downloadcheffiles.sh <Username> <Password> <ID Domain> <groupnumber>`

    ![](images/100/image65.png)

-   Notice that the **.chef** directory now contains 3 files:

    ![](images/100/image66.png)

-   Verify your connectivity to the Chef Server

```
knife environment list
```

![](images/100/image67.png)

### **STEP 15**: Download WebLogic Maven dependencies

-   Run the script **downloadWLSMavenfiles.sh** to install WebLogic Maven dependencies. Run to the following command:

```
./downloadWLSMavenfiles.sh <Username> <Password> <ID Domain> <groupnumber>
```

![](images/100/image68.png)

![](images/100/image69.png)

### **STEP 16**: Load Cookbooks to Chef

-   **Clone** the Git repository that contains the Cookbooks that will be used during the lab.

```
git clone https://github.com/pcdavies/Chef_Cookbooks.git
```

**Note:**

-   **git** is a source control tool used by developers and now with the emergence of DevOps, “DevOps Full Stack Engineers” are using git as well for the code that describes the infrastructure.

    -   A **Cookbook** is a term used by Chef. A cookbook is a set of recipes, attributes and other Chef files.

        -   A **recipe** is a set of instructions that run on the server that configure it.

        -   Attributes are set in cookbooks in the attributes folder

    -   The cookbook we are going to use for this lab has already been written and versioned into git. As the full stack engineer, you are going to clone the cookbook from the repo, configure it for your cloud environment and upload it to the new Chef organization.

    ![](images/100/image70.png)

### **STEP 17**: Configuring the Cookbook for your cloud environment

-   Change directories to the WebLogic cookbook:

```
cd /home/jenkins/Chef_Cookbooks/opcwls
```

![](images/100/image71.png)

-   We will now update the **cloud-environment.rb** file with your Identity Domain and password. Edit file **cloud-environment.rb** in **attributes** directory:

```
vi attributes/cloud-environment.rb
```

![](images/100/image72.png)

-   Update **cloud\_identity\_domain** and **cloud\_password** with your credentials.

    ![](images/100/image73.png)

-   Install the WebLogic cookbook: **Note**: berks is a command that comes with a Chef Client installation, it is used to manage and upload cookbooks to a Chef server. The berks install command finds all dependencies defined in a cookbook and downloads them to the local machine.

```
berks install
```

![](images/100/image74.png)

-   Upload Chef Cookbooks to Chef Server. **Note**: Nodes pull cookbooks from the Chef server; to make it available to Chef Nodes, we must first upload it to the Chef server.

```
berks upload --ssl-verify false
```

![](images/100/image75.png)

-   Verify the cookbooks uploaded correctly

```
knife cookbook list
```

![](images/100/image76.png)

# Application Development (Developer Persona)

## Create Developer Cloud Service Project

### **STEP 18**: Login to Developer Cloud Service

Oracle Developer Cloud Service provides a complete development platform that streamlines team development processes and automates software delivery. The integrated platform includes an issue tracking system, agile development dashboards, code versioning and review platform, continuous integration and delivery automation, as well as team collaboration features such as wikis and live activity stream. With a rich web based dashboard and integration with popular development tools, Oracle Developer Cloud Service helps deliver better applications faster.

-   From Cloud UI dashboard click on the **Developer** service. In our example, the Developer Cloud Service is named **developer71725**.

    ![](images/100/image77.png)

-   The Service Details page gives you a quick glance of the service status overview.

    ![](images/100/image78.png)

-   Click **Open Service Console** for the Oracle Developer Cloud Service. The Service Console will list all projects for which you are currently a member.

    ![](images/100/image79.png)

### **STEP 19**: Create Developer Cloud Service Project

-   Click **New Project** to start the project create wizard.

-   On Details screen enter the following data and click **Next**.

    **Name**: `Sample Application`

    **Description**: `A quick sample application`

    ![](images/100/image80.png)

-   Select template **Initial Repository** and click **Next**

    ![](images/100/image81.png)

-   Select your **Wiki Markup** preference to **MARKDOWN.**

- Click **Import existing repository** and enter repository URL supplied by the instructor. Click **Finish**.

```
https://github.com/pcdavies/SampleMavenWLSApp.git
```

![](images/100/image82.png)

-   Project creation will take about 1 minute.

    ![](images/100/image83.png)

-   You now have a new project; in which you can manage your software development.

    ![](images/100/image84.png)

### **STEP 20**: Clone Repository

Now that we have imported the Git repository into Developer Cloud Service, we will want to clone that into our Jenkins image.

-   On the right-hand side, find URL for the newly create Git repository and copy into the clipboard. Select the URL and right click to select **Copy**. Save this URL, as it will be used several times
    throughout this workshop.

    ![](images/100/image85.png)

-   Back in the ssh session, confirm that you are in the **/home/jenkins** directory then enter the following command to clone the DevCS Git repository.

```
git clone <copied URL>
```

![](images/100/image86.png)

-   When prompted enter your **Oracle Cloud password**

    ![](images/100/image87.png)

# Configure Jenkins for the Sample Application

## Configure Jenkins

### **STEP 21**: Configure Jenkins

-   Switch back to the browser tab where you are logged into Jenkins. If you need to login again following the instructions outlined earlier in this lab.

-   Click **Credentials**

    ![](images/100/image88.png)

-   We are going to update the credentials for **DevCS**. Click **cloud.admin** and select **Update**

    ![](images/100/image90.png)

-   Enter the password used for the cloud.admin domain user and click **Save**

    ![](images/100/image91.png)

-   Click on **Jenkins** to navigate back to the home page. Click **Manage Jenkins**

    ![](images/100/image92.png)

-   On the Manage Jenkins page click **Configure System**.

    ![](images/100/image93.png)

-   Scroll down the configuration page and locate the **Jenkins Location** section. Check the IP of the **Jenkins URL** and enter the **Public IP** of your newly created **Jenkins instance**. Click **Save**

    ![](images/100/image94.png)

### **STEP 22**: Configure Jenkins job **wkshp\_build\_pipeline**

-   Click on the job **wkshp\_build\_pipeline**

    ![](images/100/image95.png)

-   Click **Configure**

    ![](images/100/image96.png)

-   On **General** tab, scroll down and update **ID\_DOMAIN** **Default Value** with your OPC Identity Domain

    ![](images/100/image97.png)

-   Continue to scroll down and update **Password Default Value** parameter with your OPC Password.

    ![](images/100/image98.png)

-   Next we need to get the Compute URL that will be used by REST APIs. To get the correct URL, switch back to the OPC Services Dashboard browser Tab. Navigate back to the main **Dashboard**. Click the **Compute** navigation and select **View Details**.

    ![](images/100/image99.png)

-   Select the **REST Endpoint** and right click to **Copy**.

    ![](images/100/image100.png)

-   Back on the Jenkins administration tab, update the **RESTAPI Default Value** with correct **REST endpoint**

    ![](images/100/image101.png)

-   Continue to scroll down and find **SSHKEY**. Update **Default Value** with your **Identity Domain** and the correct **Name** for the SSH Key created earlier in the lab guide.

    ![](images/100/image102.png)

-   Click on **Source Code Management** Tab. Enter the Developer Cloud Service repository URL that you captured earlier and click **Apply**. Then click on **Save**

    ![](images/100/image103.png)

### **STEP 23**: Configure Jenkins job Build\_And\_Deploy\_WebLogicApp

-   Click on Jenkins to navigate back to main page.

    ![](images/100/image104.png)

-   Click on the job **Build\_And\_Deploy\_WebLogicApp**

    ![](images/100/image105.png)

-   Click **Configure**

    ![](images/100/image96.png)

-   On **Source Code Management** tab, scroll down and update **Git Repository** with the value that you copied from Developer Cloud Service. Click **Apply**, then click on **Save**

    ![](images/100/image106.png)

## Configure DevCS & Jenkins Build Server Integration

### **STEP 24**: Configure Developer Cloud Service

-   Switch back to the browser tab where you are logged into Developer Cloud Service. If you need to login again follow the instructions outlined earlier in this lab.

-   On left hand navigation panel click **Administration** drop down and select **Webhooks**

    ![](images/100/image107.png)

Developer Cloud Service provides out of the box integration with 3rd party systems via Webhooks. We will use the Hudson/Jenkins – Git Plugin webhook to notify our Jenkins build server of changes to our source code Git repository.

-   Click **New Webhook** and enter the following information and click **Done**

    **Type**: `Hudson/Jenkins – Git Plugin`

    **Name**: `Jenkins Webhook`

    **Active**: `<Leave checked>`

    **URL**: `<Jenkins Server IP>/git/notifyCommit`

    **Expand Notification Parameters**

    **URL**: `HTTP Repository Address`

    **Uncheck** `sha1`

    **Repository**: `Select Git repo with your sample application`

    **Branch**: `master`

    ![](images/100/image108.png)

-   Once the Webhook is created click **Test** to validate connectivity.

    ![](images/100/image109.png)

-   Click **Logs** to inspect the status of your connection. A green check in the log window will appear when you have connectivity.

    ![](images/100/image110.png)

# Creating a new version of the Application

## Creating a new version of the Application

### **STEP 25**: Modify Application

-   Switch back to your **ssh** session. If your ssh session has closed follow instructions described earlier in the lab guide. As the **jenkins** user change to the project directory for the application that you cloned from Developer cloud service.

```
cd /home/jenkins/sample-application
```

![](images/100/image111.png)

-   Edit the **index.html** file and change Basic to your name.

```
vi ./src/main/webapp/index.xhtml
```

- On line 15 change: **Basic Webapp** to **YOURNAME Webapp**

    Put your curser on the “**B**” of **Basic**,

    **type**: `cw`

    **Enter**: `your name`

    Hit the **esc** key

    **Type**: `:wq` and press **enter**

    ![](images/100/image112.png)

-   View all changes to Git repository: You should see that the **index.xhtml** file has been modified

```
git status
```

![](images/100/image113.png)

-   Commit the changes to your local Git repository:

```
git commit -am “changed title to my name”
```

![](images/100/image114.png)

-   Push changes to the Developer Cloud Service Git repository. When prompted enter your **OPC password**:

```
git push origin master
```

![](images/100/image115.png)

### **STEP 26**: Automatic deployment of Application

-   Click **Jenkins** to navigate back to the home page. It may take a minute to begin, but you should see a job running as shown below.

    ![](images/100/image116.png)

-   From the main page jobs that are running will have the ball on the left blinking. It will take about 25 minutes for the job to complete.

    ![](images/100/image117.png)

-   While the job is running, we will explore both the Jenkins jobs and Chef Server.

## Exploring the Jenkins Server

### **STEP 27**: Explore Jenkins job wkshp\_build\_pipeline

**Description:** Jenkins is a continuous integration and continuous delivery application, used to automate parts of the SDLC. Jenkins can be leveraged to build and test software projects continuously making it easier for developers to integrate changes to the project, and making it easier for users to obtain a fresh build. It also allows for continuous delivery of software by providing powerful ways to define build pipelines and integrating with many testing and deployment technologies.

All the jobs you see listed on the home page are being used for this lab. The master job is called **Wkshp\_build\_pipeline**. Click on the link for that job.

-   Click on the job **wkshp\_build\_pipeline**

    ![](images/100/image118.png)

-   Click **Configure**

    ![](images/100/image96.png)

-   Click on the flow tab

    ![](images/100/image119.png)

Here you can see the various jobs getting called to build the environment and deploy the application. This process is started by a developer checking in a new version of their code. Creating that communication between git and this job is something you will do in the workshop today.

## Explore Chef

### **STEP 28**: Log into Chef Web Console

**Description:** Chef is configuration management tool written in Ruby and Erlang. It uses a pure-Ruby, domain-specific language (DSL) for writing system configuration "recipes". Chef is used to streamline the task of configuring and maintaining a company's servers, and can integrate with cloud-based platforms

-   Open a browser and enter **140.86.12.215**. The Chef Login page should render. Enter Username and Password and click **Sign In**

    **Username**: `sdlcwkshpgroup<Organization Id>`

    **Password**: `Summer15#`

    ![](images/100/image120.png)

    ![](images/100/image121.png)

Notice the Nodes are empty; the last lab of the workshop will create nodes as part of the Jenkins build process; be sure to check this screen again at the end of the workshop

-   As the new server is being built by Jenkins it is being automatically registered to the Chef Server and assigned a role

    -   Once the new server is registered with Chef it is downloading all of the required cookbooks(a collections of recipes) to configure the server correctly

        ![](images/100/image122.png)

        Earlier when you ran the Berks command, you uploaded all the cookbooks required for this workshop.

-   To see the cookbooks you uploaded earlier, click on the “Policy” tab on the top of the page.

    -   Select Cookbooks on the left side menu

    -   Highlight any cookbook to see details about that cookbook

        ![](images/100/image123.png)

## Verify Application Deployment

### **STEP 29**: Verify Application Deployment

-   Click **Jenkins** to navigate back to the home page.

    ![](images/100/image124.png)

-   After about 25 minutes you will see success. You new WebLogic environment and application is now running.

    ![](images/100/image125.png)

-   Switch back to Oracle Public Cloud. If not already on main dashboard click **dashboard**

-   Click **Compute** navigation icon and select **Open Service Console**

    ![](images/100/image126.png)

-   Notice that a new compute instance **MT\_Server-1** has been created. Copy **Public IP** of newly created instance.

    ![](images/100/image127.png)

-   Along with the provisioning of a new compute instance, WebLogic was installed and your sample application has been deployed. Access application using the URL and the Public IP of your new **MT\_Server-1**
    
    `<IP>:7001/basicWebapp`

    ![](images/100/image128.png)

-   You have completed the lab.

# Appendix

## MAC OSC - Cyberduck

### **STEP 30**: Download Cyberduck App

-   Download the MAC version of Cyberduck from the following URL:
    <http://cyberduck.io>

-   Unzip the downloaded zip file, and copy the **Cyberduck.app** file to the desired directory – e.g. the Application directory

-   Double Click on Cyberduck.app and successfully open the application.

-   Once successfully opened, you will need to fully close the application by right clicking on the toolbar icon and selecting Quit

    ![](images/100/image129.png)

-   From the directory where the file was copied, **right click** on the **Cyberduck.app** file, and select **Show Package Contents**

    ![](images/100/image130.png)

-   In the Explorer window, navigate to the **Contents > Resources > Profiles** directory. Leave this window open for the next step.

    ![](images/100/image131.png)

### **STEP 31**: Download Oracle Profiles

-   Go to the following URL: <https://trac.cyberduck.io/wiki/help/en/howto/oraclecloud>

-   Select the link to download all Cyberduck profiles

    ![](images/100/image132.png)

-   Using another Explorer window, **Unzip** the downloaded file. Then copy the \*.cyberductprofile files from the unzip directory into the **Contents > Resources > Profiles** directory of the Cyberduck.app

    ![](images/100/image133.png)

### **STEP 32**: Create Cyberduck connection to Oracle Storage Container

-   Open the Cyberduck app, and click on the “+” sign at the bottom of the window to create a new connection

    ![](images/100/image134.png)

-   Enter the appropriate information to configure your Storage Container Connection. 
    
    **Select the Oracle Connection type:** `Oracle Storage Cloud Container XX` 
    
    **ServiceName-Identifier**: `Storage-<domain>:<user Name>`

    ![](images/100/image135.png)

-   Close the dialog to save the connection profile.

-   Double click on the bookmark to connect. You will be prompted for your domain’s password.
