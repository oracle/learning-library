![](../common/images/customer.logo.png)
---
# ORACLE Cloud-Native DevOps workshop #
-----
## Using Eclipse IDE (Oracle Enterprise Pack for Eclipse) with Oracle Developer Cloud Service ##

### Introduction ###
You can access Oracle Developer Cloud Service projects from Integrated Development Environments (IDEs) such as Oracle Enterprise Pack for Eclipse (OEPE), Oracle JDeveloper, and NetBeans IDE. The Eclipse IDE and the Oracle Enterprise Pack for Eclipse (OEPE) includes integration for Oracle Developer Cloud Service, which conveniently exposes the most common Cloud development tasks from within the IDE.

Oracle Developer Cloud Service integration with the Eclipse IDE includes the following:

+ A dedicated Oracle Cloud view that displays Oracle Developer Cloud Service projects of which you are a member
+ Integration with Mylyn and the Oracle Developer Cloud Service Issues system
+ Source control system integration with the Oracle Developer Cloud Service Git repository

You can download the Eclipse IDE from [http://www.eclipse.org/](http://www.eclipse.org/) and OEPE from [http://www.oracle.com/technetwork/developer-tools/eclipse/downloads/index.html](http://www.oracle.com/technetwork/developer-tools/eclipse/downloads/index.html).

If you are using the Eclipse IDE, download and install the Oracle Cloud Tools plugin from the Eclipse IDE marketplace. In OEPE, the plugin is installed by default.

### About this tutorial ###
This tutorial demonstrates how to:
  
+ Setup Eclipse IDE (Oracle Enterprise Plugin for Eclipse)

### Prerequisites ###

+ [Create Oracle Developer Cloud Service project for SpringBoot application](../springboot-sample/create.devcs.project.md)
+ [Create continuous build integration using Oracle Developer Cloud Service and Oracle Application Container Cloud Service](../springboot-sample/devcs.accs.ci.md)
+ Eclipse IDE with Oracle Cloud Tools plugin or Oracle Enterprise Plugin for Eclipse installed.

### Steps ###

#### Configure Cloud Tools Plugin ####

Open OEPE (using desktop icon ![](images/01.png)) and set (leave the default, `home/oracle/workspace`) workspace location. Close the Welcome page. To open the *Oracle Cloud* view from the Window menu, click *Show View* and then *Other*.

![](images/02.png)

From the list open *Oracle Cloud* and select *Oracle Cloud*.

![](images/03.png)

If you are connecting to Oracle Developer Cloud Service for the first time, click the Connect link.

![](images/04.png)

In the Oracle Cloud Service Connection dialog, enter the following:

+ **Identity Domain**: Enter the identity domain of Oracle Developer Cloud Service.
+ **Username** and **Password**: Enter the user name and password.
+ **Connection Name**: Enter a name for the service instance, if necessary. By default, the connection name is set to the identity domain name.

![](images/05.png)

Provide a master password to store securely your credentials, so in the future you don't need to enter every time when you open OEPE. Don't forget to note the master password.

![](images/06.png)

After your credentials have been validated, you are logged in to Oracle Developer Cloud Service and the Oracle Cloud view displays all projects that are assigned to you. Open the tree view myOracle Cloud(Cloud connection name) -> Developer -> springboot(DevCS project name) -> Code and there you can see the Git repository hosted on Oracle Developer Cloud Service.

![](images/07.png)

To clone the Git repository to your machine double click or right click -> Activate on the Git repository and clone will start.

![](images/08.png)

After the successful clone your local copy will be available in your workspace.

![](images/09.png)

To import a Maven based project right click on the Project Exporer area and will pop up the menu where you can select Import projects -> Import...

![](images/10.png)

Select Existing Maven Projects and click Next.

![](images/11.png)

Browse the location of the cloned repository in `/home/oracle/workspace/` folder and select `acc/springboot-sample` subfolder. If the workspace location is the default it should look like similar to the following: `/home/oracle/workspace/springboot.git-9534/springboot-sample`
Please note, that you need to give one of the subfolder of the local repository.
Click Finish.

![](images/12.png)

OEPE now starts to validate and build the project which can take few seconds. Finally you can see the imported project in the Project Explorer area.

![](images/13.png)

#### Change code and test using continuous integration ####

The project hosted on Oracle Developer Cloud Service has build job which ensures that new application build and deployment to Application Container Cloud Service happens when any developer push code changes to Git repository.

Check the process modifying small piece on the application. First check the default page of the application. Open the tree view myOracleCloud -> Applications -> springboot-demo. Right click on springboot-demo and select Open In Browser menu item.

![](images/14.png)

New browser is opened and you should see the application's home page.

![](images/15.png)

Go back to OEPE and in the Project Explorer area find the *springbootdemo* project and open the **Deployed Resources -> webapp -> WEB-INF -> views -> welcome.jsp**

![](images/16.png)

Modify the following part:

  	<br>SpringBoot application demo. Current server time: <%= new java.util.Date() %> <br>

To what you would like to see on the page. For example:

	<br>SpringBoot application demo. <font color="red">MODIFIED IN OEPE.</font> Current server time: <%= new java.util.Date() %> <br>  	

Save the changes. To commit and push changes to Git right click on project and select Team -> Commit...

![](images/17.png) 

Git Staging view is displayed. First make sure the `welcome.jsp` is in the *Staged Changes* area. Type a commit message e.g. 'Home page modified in OEPE'. Optionally enter your name or cloud username and give a (valid or fake) email address in the following format as the screenshot shows. Click **Commit and Push...**

![](images/18.png)

In the Push dialog leave the default branch and click OK.

![](images/19.png)

Now change back to the browser and check the Build page in the Oracle Developer Cloud Service project. You should see that a new build (in our case: *springboot_build*) has been fired by the Git changes.

![](images/20.png)

Once the job is done change to the tab to Deploy and you can see that a new deployment has been started too. If you remember the Deployment was configured to redeploy every time when a new successful build artifact is ready.

![](images/21.png)

Now check the changes of the home page of the application. Open the tree view myOracleCloud -> Applications -> springboot-demo. Right click on springboot-demo and select Open In Browser menu item.

![](images/14.png)

New browser (tab) is opened and you should see the changes (red text) on the application's home page.

![](images/22.png)
