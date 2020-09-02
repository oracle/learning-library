## Lab 2

Update August 19, 2020

## Configuring ServiceManager , Atlanta and SanFran Deployments


## Introduction

This lab walks you through configuring ServiceManager, Atlanta and SanFran deployments using **Goldengate 19.1 MicroServices** web interface and the **Oracle GoldenGate Configuration Assistant (OGGCA)** silent install scripts in a Cloud environment.

## Objectives

-	Configure the initial ServiceManager and then the Atlanta and SanFran Deployments 
-	Connect to the Admin Service through a web browser and confirm that the deployments succeeded and that the ServiceManager and core GoldenGate services are running.


### **STEP 1**: Open up a terminal window and create the ServiceManager and Source(Atlanta) Deployment

In this step you will create the initial ServiceManager. ServiceManager is the bootstrap process that can be configured as a daemon process in Unix and windows so that it can start and stop on system startup and shutdown.   
It is also responsible for starting and stopping the other GoldenGate services and presents the initial web user interface and access point for the AdminClient command line interface.

-	On the desktop, right-click and select “Open Terminal”.

![](images/200/vnc1.jpg)

-   Then, change to the **/u01/gghome/bin** directory.

		cd /u01/gghome/bin

-   Then, run the **oggca.sh** script:

		[oracle@@ggma bin] ./oggca.sh

-	The following screen will appear.   

![](images/200/Lab002_1.jpg)

-	Select the option to **"Create New Service Manager"** and click on the **"Browse"** to select the location for the Service Manager as **"/u01/gg_deployments/ServiceManager"**.

-	For the ServiceManager details screen enter the hostname of **"ggma"** for the listening hostname/address and enter **"16000"** for the listening port value.  Click on the **"Register Service as a system service/daemon"** checkbox. Click on **"Next"** to continue the configuration. 

![](images/200/Lab002_2.jpg)


- 	Since this is the **First deployment** on the system, you will only have ***one*** option. Take the default and click **Next**.

![](images/200/Lab002_3.jpg)

-	You will need to provide a **Deployment Name** which in this case is **Atlanta** and the **OGG_HOME** is selected by default. If the wrong OGG_HOME is listed; use the Browse button to correct it.

![](images/200/Lab002_4.jpg)

-	For the directory selection dialog box navigate to the **"/u01/gg_deployments/Atlanta"** directory and click on the **"Select"** button.

![](images/200/Lab002_5.jpg)

-	For  the **"Specify Enviroment Variables"** screen, review the settings and click on **"Next"** to continue.  

![](images/200/Lab002_6.jpg)

- 	For the **"Specify Administrator Account"** screen, enter **"oggadmin"** for the username field, and enter **"Welcome123#"** for the password field.  Enter the same value of **"Welcome123#"** for the confirm password field.   Click on **"Next"** to continue.

![](images/200/Lab002_7.jpg)

- 	For the **"Specify Security Options"** screen, make sure all the **"SSL/TLS security"** and **"This nonsecure deployment will be used to send trail data to a secure deployement"** checkboxes are ***unchecked***.  Click on **"Next"** to continue.

![](images/200/Lab002_8.jpg)

- 	For the **"Specify Port Settings"** screen, set the following field and checkbox values (you will note that they will autofill based on the first setting which is fine).   

| Field/Checkbox				|	Setting	|
|-------------------------------|-----------|
|Administration Server Port"	| 	16001	|
|Distribution Server Port"		|	16002	|
|Receiver Server Port"			| 	16003	|
|Enable Monitoring"				| 	Checked	|
|Metrics Server Port			|	16004	|
|Metrics Server UDP Port (data) |   16005	|
|Metrics Server Datastore Type  |   BDB		|


-    For the **"Metrics Server Datastore home"** click on the button next to the option and the **Select Path** dialog box will appear.For the directory selection dialog box navigate to the **"/u01/gg_deployments/Atlanta"** directory and select ***metrics*** directory .Click **"Next"** to continue.

![](images/200/Lab002_9.jpg)


- 	For the "Specify OGG Replication Settings" screen, enter **ggate** for the "Default Schema" field.  Click on **"Next"** to continue.
 
![](images/200/Lab002_10.jpg)

- 	For the **"Summary"** screen review the options carefully and then select the **"Finish"** button.

![](images/200/Lab002_11.jpg)

- 	Follow the progress carefully on the **next** screen.

![](images/200/Lab002_12.jpg)

- 	For the **"Execute Configuration Scripts"** screen, you will be prompted to manually execute the ***registerServiceManager.sh*** script which will daemonize the SerivceManager executable to enable it to be started and stop on system shutdown and startup.

![](images/200/Lab002_13.jpg)

- 	At a terminal prompt login as root using the ***sudo su -*** command and password ***Welcome1***.Execute the shell script as directed:

		[oracle@ggma ~]$ sudo su -
		[root@ggma ~]# /u01/gg_deployments/ServiceManager/bin/registerServiceManager.sh

- 	The output should look like the following:

![](images/200/Lab002_14.jpg)

- 	When complete go back to the **"Execute Configuration Scripts"** screen and click on the **"Ok"** button


- 	For the **"Finish"** screen confirm the ***successful deployment status*** and click on the **"Close"** button.   

![](images/200/Lab002_15.jpg)

**The GoldenGate ServiceManager** deployment and the **"Atlanta"** deployment are now complete and ready to start using.   Lets now verify the deployment by connecting through the brower interface.  

- 	Open up a browser window in your Oracle Cloud environmentor on your laptop using a browser (like Chrome or Firefox) and enter the following URL and port: **http://132.145.207.65:16000/** .  

- 	You should get a sign on page.   Sign in using the username: **"oggadmin"** and password **"Welcome123#"**.

- You will then be taken to the following page.   Review that the Services for the ***"Atlanta"*** deployment and the ServiceManager are all in a ***"Running"*** state. 

![](images/200/Lab002_16.jpg)

### **STEP 2**: Configuring Target (SanFran) deployment using OGGCA silent install script

In this step you will configure the Target (SanFran) deployment. 

-	If you don't have a terminal windows open already, on the desktop, right-click and select “Open Terminal”.

![](images/200/open_terminal.PNG)

-   Then, change to the **~/script/Lab2** directory.

		
		[oracle@ggma ~]$ cd ~/script/Lab2

-   You will run the **create_deployment.sh** script to create the SanFran deployment using a response file for OGGCA.

-	Review the **create_deployment.sh** script
		
		[oracle@ggma Lab2]$ less create_deployment.sh 

-	The arguments for the script are:

	create_deployment.sh A1  A2 A3 A4 A5 A6 A6 A7 A8

|    Arguement    | DESCRIPTION	       	        |       VALUES	      |
|-----------------|-----------------------------|---------------------|
|      A1         |Deployment Name	            | 	    SanFran	      |
|      A2         |Admin User Password	        |	    Welcome1      |
|      A3         |Service Manager Port     	| 	    16000	      |
|      A4         |Administration Server Port	| 	    17001	      |
|      A5         |Distribution Server Port 	|	    17002	      |
|      A6         |Receiver Server Port         |       17003	      |
|      A7         |Metrics Server Port          |       17004         |
|      A8         |Metrics Server UDP Port      |       17005         |

-	Run the script

		[oracle@ggma Lab2]$ ./create_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
		Successfully Setup Software.

-	Once the script is executed, you will see a statement saying that the ***“Successfully Setup Software.”*** indicates that deployment ***SanFran*** has been created.

- 	Open up a browser window in your Oracle Cloud environmentor on your laptop using a browser (like Chrome or Firefox) and enter the following URL and port: **http://129.213.30.234/17000** .  

- 	You should get a sign on page.   Sign in using the username: **"oggadmin"** and password **"Welcome123#"**.

- You will then be taken to the following page.   Review that the Services for the ***"SanFran"*** deployment and the ServiceManager are all in a ***"Running"*** state. 

![](images/200/Lab002_17.jpg)

You have completed lab 200!   **Great Job!**

## Acknowledgements

 - ** Authors ** - Brian Elliott, Zia Khan
 - ** Contributors ** - Brian Elliott, Zia Khan
 - ** Team ** - Data Integration Team
 - ** Last Updated By ** - Brian Elliott, Zia Khan
 - ** Expiration Date ** – July 2021


<a href="https://oraclecps.github.io/GGMicroservices/index.html" target="_blank">Click here to return</a>
