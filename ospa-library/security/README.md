![](./media/securitytitle.png)

# Security Hands-On Labs

## Hands-On Labs

We recommend you to read the following guide before begin with the labs activities. There are some Prerequisites that you must satisfy in order to proceed with the workshop.
Please read them very carefuly in order to avoid issues during the labs session.

****

## Lab Guide Overview

Here is a brief overview of what you can expect to accomplish in these lab exercises.  
The purpose of the labs is to familiarize yourself with the features and functionality of Oracle CASB Cloud Service, Oracle Identity Cloud Service and Oracle Management Cloud.
To optimize your experience there are some general guidelines that will help you get the most from these lab exercises.

- Read through an entire section before executing any of its steps.  Merely following the screen shots or script files without understanding the flow will diminish your learning experience, so think about what you are doing and why.  If you aren’t sure, ask questions.

- Ask before you do.  If you have any questions, please ask the instructor before you march down a path that may lead to unsatisfactory results.

- Follow the steps as shown in this guide.  Do not freestyle during the labs. This is a live environment.  If you want to do something that is not in the labs, ask the lab instructor first.  Do not create, delete, or alter any database objects without asking first.  

- There is no prize for finishing first and there is no penalty for finishing last. The goal is to gain a firm understanding of Oracle Application Integration.  

- Ask questions freely.  The only dumb questions are those that are not asked.  

- Help your fellow students.

## Labs

The way we do business has evolved by revamping the digital strategy, models, operations, products and marketing approach, fundamentally changing how enterprises operate and deliver value to customers.

New business models help customers to growth and increase their revenue. However, digital transformation introduces new security threats and risks that companies are not used to deal with.  

As many companies, Mama Maggy's IT security and management teams are unable to keep pace with emerging, rapidly-changing hybrid cloud environments.  They face a dramatic increase in risk from security threats and unplanned outages, as well as innovation bottlenecks that slow time-to-market.

Their current security and management process rely on manual tasks, is completely ineffective and cause resources' overhead.

These are some of the concerns that the CISO and security team members have shared with us

- New employee on-boarding process take too much time.
- Security Operation Center analysts are overwhelmed because of the amount of alerts and manual tasks required to investigate an event.
- CISO compliants about the lack of visibility into cloud and on-prem infrastructure, inability to respond to governance requirements in a timely manner, and slow detection and response to threats.
- Security managers must deal with an increasing number of events and capacity to respond to threats that might lead to data breach or expose company assets, and the time wasted on investigations and researches with dead end because of the lack of automated tools and a lack of talent and resources.

### Prerequisites

Before you start the labs you should have:
- Your Oracle Cloud Account Sign In credentials (user name and password).
- Cloud access to an instance of Oracle CASB Cloud Service.
- Access to Oracle Identity Cloud Service console. This service is provisioned alongside your Oracle Cloud Account.
- Access to a compute instance and a compartment.
- Privileges to create dummy accounts on the OCI tenant and IDCS.
- Disable password vaults solutions installed in your laptop, such as OnePassword, LastPass or Dashlane.

### Preparing your environment

You have some setup work to perform first before you start the two hands-on labs in this course.  By performing the following steps, you will complete all the setup work upfront so you won’t be bothered with it during the labs.  NOTE: These steps assume that you have already satisfied all the prerequisites enumerated in the Prerequisites section above.  If you have, continue below:

1. Close your VPN connection if it is active.
2. The Labs have been tested inside and outside the corporate network. If you encounter connectivity constraints, we advise learners to connect to CLEAR-INTERNET to complete the exercises.
2. Create an **Security** folder (directory) on your computer’s file system.  This is where you might store various artifacts during the labs.
3. Open Notepad (Windows PC) or TextEdit (Mac) on your computer and create a new file called *MyLabNotes*.  Save it into your **Security** folder.  Keep the file open as an area where you can conveniently store items that are important to remember and access.
4. Start your Chrome browser.  Again, other browsers may work just fine, but the lab was tested using Chrome.
5. Clear browser data

**On a Windows PC:**
- Click the Customize and control Google Chrome icon (three vertical dots) in the upper-right corner of the window to display a menu.
- Select the More tools option from the menu.
- Select the Clear browsing data option from the submenu.
- Time range: All time
- Browsing history: checked
- Cookies and other site data: checked
- Cached images and files: checked 
- Click the Clear data button

**On a Mac:**
- Select the Chrome option from the menu bar to display a menu.
- Select the Clear Browsing Data option
- Time range: All time
- Browsing history: checked
- Cookies and other site data: checked
- Cached images and files: checked 
- Click the Clear data button
***

## Access your cloud console dashboard

- Click on the **General Menu** located at the top left of the screen
- Click **My Service Dashboard**


![](./media/cloud_new_Dashboard.png)
<p align="center">Figure 1-1</p>

![](./media/idcs_access.png)
<p align="center">Figure 1-2</p>

Here you will find the different services available to you. The services listed in the dashboards might vary depending on your privileges.

***

## Install Postman

If you don't have POSTMAN installed in your laptop, please visit [POSTMAN Website](https://www.getpostman.com/products).

**NOTE: Postman user id is not required to run this lab. Disregard any message during download and/or initial set up**

![](./media/postman.png)
<p align="center">Figure 1-3</p>

- Download the client. 

- Install Postman. *Follow the instructions guidelines for your platform (e.g. Mac, Windows, Linux)*

![](./media/postman_download.png)
<p align="center">Figure 1-4</p>

- Run Postman

![](./media/postman_test.png)
<p align="center">Figure 1-5</p>

- Once opened, close the welcome screen and close Postman. 

****

Now that you have completed this guide, you can proceed with the labs exercises.

- [Lab 1: Oracle Identity Cloud Service](LAB1_IDCS.md)
- [Lab 2: Oracle CASB Cloud Service](LAB2_CASB.md)
- [DEMO: Oracle Management Cloud ](./omc_demo/omc_demo_guide.pdf)

[Back to the top](#Security-Hands-On-Labs)

***** 
