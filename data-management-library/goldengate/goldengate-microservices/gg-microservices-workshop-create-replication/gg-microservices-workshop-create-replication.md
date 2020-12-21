# Lab  -  Setup of Golden Gate Microservices for Replication

![](./images/ggmicroservicesarchitecture.png)

## Want to learn more:
* [GoldenGate Microservices](https://docs.oracle.com/goldengate/c1230/gg-winux/GGCON/getting-started-oracle-goldengate.htm#GGCON-GUID-5DB7A5A1-EF00-4709-A14E-FF0ADC18E842")

## Introduction

Contents

Introduction
Disclaimer
Oracle GoldenGate for Microservices Workshop Architecture 


Lab  – Create GoldenGate Microservices Replication

Lab  – Active - Active Replication
  
Lab  – High Availability / Disaster Recovery

Lab  - Transformations using GoldenGate Microservices


### Objectives

KEY FEATURES

Non-invasive, real-time transactional data streaming

Secured, reliable and fault-tolerant data delivery 
Easy to install, configure and maintain real-time changed data 
Easily extensible and flexible to stream changed data to other relational targets

KEY BENEFITS

Improve IT productivity in integrating with data management systems. 
Use real-time data in big data analytics for more timely and reliable insight 
Improve operations and customer experience with enhanced business insight 

• Minimize overhead on source systems to maintain high performance

Oracle GoldenGate Microservices provides optimized and high performance delivery.Designed to demonstrate how Oracle GoldenGate 19c Microservices can be used to setup a replication environment by a mix of web page, shell scripts and Rest API interfaces.  All labs will use shell scripts to facilitate the building of the environment, at the same time provide insight into how to use the web pages and AdminClient.  

Oracle GoldenGate Microservices real-time data streaming platform also allows customers to keep their data reservoirs up to date with their production systems.

Time to complete - 60 mins

### Summary

Oracle GoldenGate offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform. It easily extends customers’ real-time data
integration architectures without impacting the performance of the source systems and enables timely business insight for better decision making.

### Disclaimer

This workshop is only for learning and testing purposes. None of the files from the labs should be used in a production environment. 

Time to Complete -
Approximately 30 min

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

In this lab we will setup GoldenGate Microservices


## **Step 1:** In this task, you will create two deployments 

Open a terminal session

![](./images/terminal3.png)

````
<copy>sudo su - oracle</copy>
````

**Deployments are a new concept in Oracle GoldenGate Microservices.**

Deployments provide a siloed approach to splitting replication environments between applications, customers, or environments.  This allows for greater control over the use of Oracle GoldenGate in larger environments.

1.	Log in to ServiceManager’s HTML5 webpage.  This is done by opening Firefox on your linux host machine.

2.	From the browser, connect to port 16000 to access the ServiceManager login page:
```
 <copy>https://<You IP Address>:16000</copy>
```
The URL should bring up the following login page.

![](./images/a1.png)

3. Log in to the Service Manager using the following credentials:

User Name: oggadmin
Password: Welcome_1
```
<copy>oggadmin</copy>
```
```
<copy>Welcome_1</copy>
```

4.	You should see “ServiceManager” under Deployments at the bottom of the page and the status should be set to “Running”.  

![](./images/a2.png)


5.	Now switch back to the Remote Desktop Viewer and from the Terminal window, navigate to the Lab3 directory under ~/Desktop/Scripts/HOL.

```
<copy> cd ~/Desktop/Scripts/HOL/Lab2</copy>
```

![](./images/a3.png)

6.	At this point, by doing an “ls” in the directory; you will notice two files in the lab directory.  The rsp file is a template file that will be copied and used by the sh file.  In order to create two Deployments, the sh script file needs to be ran twice.

First, find out your current VM’s local IP Address by issuing the following command

```
<copy>$ hostname -I</copy>
```
7. Write down the IP Address shown.  For example, 10.145.34.23.  
(** The IP address it shows might be different than the IP address you obtained when using VNC Viewer to connect.  That is fine)

8. Open oggca_deployment.rsp with an editor, such as vi.  Find the following line, replace the IP address with the value you got from above ‘hostname -I’ command

Example: HOST_SERVICEMANAGER=10.0.2.15

9. For example, using above IP address, change it to
```
<copy>HOST_SERVICEMANAGER= <your_public_ip></copy>
```

10. To run the create_deployment.sh script, you will need to provide eight (8) command line parameters.  Here is the template of the command:

**sh ./create_deployment.sh (deployment_name) (admin password) (SMPort) (ASPort) (DSPort) (RSPort) (PMSPort) (PMSPortUDP)**

Each of the parameters will be used to replace items in the response file and build the Deployment and associated services.  Each of the command line parameters corresponds to the following:

<deployment_name> = Name of the deployment to be created
<admin password> = Password used by the Security Role user for the ServiceManager
<SMPort> = Port number of the ServiceManager (16000)
<ASPort> = Port number of the Administration Service (16001)
<DSPort> = Port number of the Distribution Service (16002)
<RSPort> = Port number of the Receiver Service (16003)
<PMSPort> = Port number of the Performance Metric Service (16004)
<PMSPortUDP> = UDP port number for Performance Metric Service NoSQL Database connection (16005)

11. **Run the script using the following parameter values, to create the Atlanta Deployment:**
```
<copy>sh ./create_deployment.sh Atlanta Welcome_1 16000 16001 16002 16003 16004 16005</copy>
```
![](./images/a4.png)

12. Return to Firefox and refresh the ServiceManager page.  You should have one (1) new Deployment called Atlanta, with four (4) services listed.

![](./images/a5.png)

13. Return to the Terminal Window where you ran the create_deployment.sh script and re-run the script again to create a 2nd Deployment (Boston), this time changing the Deployment name and all port numbers other than the ServiceManager (16000) port number.

**Run the script using the following parameter values, to create the Boston Deployment:**

```
<copy>sh ./create_deployment.sh Boston Welcome_1 16000 17001 17002 17003 17004 17005</copy>
```

![](./images/a6.png)

14. Return to Firefox and refresh the ServiceManager page again.  You should now have two (2) Deployments with a total of eight (8) services running.  

![](./images/a7.png)

## **Step 2:** Configure Reverse Proxy

In this Task, you will configure the NGINX Reverse Proxy.  

Note:  Prior to configuring the reverse proxy, you have to have a self-signed certificate.  These certificates have already been created for you and are stored in ~/wallet.  These are the same certificates that were used to setup the security for the ServiceManager and Deployments you created in an Task 3.

To complete this task, you will need to run the following script:

configureNginx.sh

After the completion of this task, accessing the Oracle GoldenGate Microservices HTML5 pages will be simpler.  

1.	From the Terminal window in the VNC Console, navigate to the Lab4 directory under ~/Desktop/Scripts/HOL/Lab3
```
<copy>cd ~/Desktop/Scripts/HOL/Lab3</copy>
```
2.	Execute the script.  This script will configure all items related to the Nginx Reverse Proxy

**Note: The configureNginx.sh script is making a call to the ReverseProxySettings utility that can be found under $OGG_HOME/lib/util/reverseproxy.  We provide this script to make it easier for you to configure the Nginx Reverse Proxy in your environment.**

```
<copy>sh ./configureNginx.sh oggadmin Welcome111! 16000</copy>
```
![](./images/a8.png)

**During the script run, it will ask you the password for user oracle so it can run sudo, the password is Welcome111!.**

3.	Upon completion, return to your web browser.   You should be able to access the ServiceManager page by only using the URL without a port number.

```
<copy>https://localhost</copy>
```
If this is the first time you access this address, you will need click through some security exceptions page as it is using a self-signed certificate.  Once you get to the page, you will see below website.

![](./images/a9.png)

Once you are able to access the ServiceManager by using the simpler URL, you have completed this task.


**Extra Information:**

Simplified URLs:

The benefit of using the Reverse Proxy is that is makes the URLs simpler to use.  If you are so inclined, provide your browser a URL that models this:

https://localhost/(deployment)/adminsrvr

(deployment) = the name of a deployment you build in Task 3. 

In the example, if using the Atlanta deployment, the URL would look like this:

**https://localhost/Atlanta/adminsrvr**

```
<copy>https://localhost/Atlanta/adminsrvr</copy>
```
![](./images/a10.png)

## **Step 3:** Create Credentials

In this Task, you will configure the database user credentials and tnsnames entries needed for replication.  This requires running the following scripts:

Edit_tnsnames.sh
Create_credential_GGAlias.sh
Add_SchemaTrandata.sh

After running these scripts, you will be able to establish connections for replication between the source and target pluggable database.


**Note: The script create_credential_protocol.sh will not be used in this lab and can be ignored.**

Before you work through this task, understand that there are multiple ways of doing this lab.  The scripts provided are meant to speed up the lab process.  If you are interested in creating credentials and adding schematrandata from the web pages or AdminClient the beginning steps are provided below for you.

For web page access, access the Administration Service (adminsrvr) using the simplified URL (https://localhost/<deployment>/adminsrvr).  Login and go to Context Menu -> Configuration -> Credentials -> click on the plus ( + ) sign.

![](./images/a11.png)

1. To access the AdminClient, open a Terminal Window and execute:
```
<copy> $OGG_HOME/bin/adminclient</copy>
```
## **Step 4:** Create Oracle Objects

To begin this Task 5, follow the below steps:

1.	From the Terminal window in the Remote Desktop Viewer, navigate to the Lab5 directory under ~/Desktop/Scripts/HOL.
```
<copy>cd ~/Desktop/Scripts/HOL/Lab4</copy>
```

![](./images/a12.png)

2.	Edit the tnsnames.ora file using the edit_tnsnames.sh script.  This script will need to be ran twice to add entries for both pluggable databases (oggoow19 & oggoow191)

```
<copy>sh ./edit_tnsnames.sh oggoow19</copy>
```
```
<copy>sh ./edit_tnsnames.sh oggoow191</copy>
```

![](./images/a13.png)

3.	Verify that the tnsnames.ora file has been updated.

```
<copy>cat $ORACLE_HOME/network/admin/tnsnames.ora</copy>
```
4.	With the tnsnames.ora file updated, you can now create the Oracle GoldenGate Credentials (create_credential_GGAlias.sh) needed to connect the capture process (Extract) to the Oracle Database. 
 
In order to create the required credentials, run the following:

```
<copy>sh ./create_credential_GGAlias.sh Welcome_1 16001 c##ggate@orcl ggate</copy>
```
After running this script, can go to your browser and that the credential was created

5. Open a new browser tab and connect to 
```
<copy>https://localhost/(deployment)/adminsrvr</copy>
```
6. Login with the following oggadmin/Welcome_1

7. c.	Click the Context Menu in the upper left, then select Configuration from the left pane

![](./images/a14.png)

8.	Next, we will enable schematrandata on the schema that we want to replicate.  In order to do this, you will need to run the add_SchemaTrandata.sh script.  

To run this script, execute the following

```
<copy>sh ./add_SchemaTrandata.sh Welcome1 16001</copy>
```
![](./images/a15.png)

9. You can also check that SCHEMATRANDATA has been added from the Administration Service -> Configuration page as well.  Simply log in to the SGGATE alias.

![](./images/a16.png)

10. Then, under “Trandata”, make sure that the magnifying glass and radio button for “Schema” are selected.  Enter “oggoow19.soe” into the search box and then select the magnifying glass to the right of the search box to perform the search.

![](./images/a17.png)

11. After the search is performed, you will see a column that provides the number of tables enabled for supplemental logging within the “SOE” schema.

![](./images/a18.png)

You have now completed configuring schema level supplemental logging needed for use in the replication process

You may now *proceed to the next lab*.

## Learn **More

* [GoldenGate Microservices](https://docs.oracle.com/goldengate/c1230/gg-winux/GGCON/getting-started-oracle-goldengate.htm#GGCON-GUID-5DB7A5A1-EF00-4709-A14E-FF0ADC18E842")

## Acknowledgements
* **Author** - Brian Elliott, Data Integration, November 2020
* **Contributors** - Zia Khan
* **Last Updated By/Date** - Brian Elliott, November 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

