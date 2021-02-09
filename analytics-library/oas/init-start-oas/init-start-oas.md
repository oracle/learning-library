# Environment Setup

## Introduction
This lab will show you how to access Oracle Analytics Server and obtain necessary workshop artifacts needed for executing the labs

*Estimated time:* 10 Minutes

### Objectives
- Validate that the environment has been initialized and is ready
- Download and stage workshop artifacts

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup

## **Step 1:** Login to Oracle Analytics Server UI
This lab has been designed to be executed end-to-end with any modern browser on your laptop or workstation. Proceed as detailed below to login.

### UI Access
1. Launch your browser to the following URL to access Oracle Analytics Server UI

    ```
    URL: <copy>http://[your instance public-ip address]:9502/dv/ui</copy>
    e.g: http://111.888.111.888:9502/dv/ui
    ```

    ***Note:*** While application processes are automatically started upon instance boot up, it takes approximately 15 minutes for this URL to become active after all processes have fully started. Should this URL remain inactive after 15 minutes, refer to **Step 3** below for manual start.

2. Provide login credentials

    ```
    Username: <copy>biworkshopuser</copy>
    ```
    ```
    Password: <copy>Admin123</copy>
    ```

    ![](./images/oas-login.png " ")

3. The landing page is displayed

    ![](./images/oas-landing-page.png " ")

### Login to Host using SSH Key based authentication (optional)
While you will only need the browser to perform all tasks included in this workshop, you can optionally use your preferred SSH client to connect to the instance should you need to perform any troubleshooting task such as restarting processes, rebooting the instance, or just look around.

Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
 - Authentication OS User - “*opc*”
 - Authentication method - *SSH RSA Key*
 - OS User – “*oracle*”.

1. First login as “*opc*” using your SSH Private Key

2. Then sudo to “*oracle*”. E.g.

    ```
    <copy>sudo su - oracle</copy>
    ```

## **Step 2:** Download and Stage Workshop Artifacts
In order to run this workshop, you will need a set of files that have been conveniently packaged for you. Proceed as indicated below.

1. Download [OAS_Workshop.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/6_WvdYP8HOSRFYJpU2958aV8WpEq2sDaqZUP4dJdFlz2NvBPIdlRg8uHyDC0WMyA/n/natdsecurity/b/labs-files/o/OAS_Workshop.zip) and save to a staging area on your laptop or workstation.

2. Uncompress the ZIP archive

## **Step 3:** Managing DB and OAS processes (optional)
Your workshop instance is configured to automatically start all processes needed for the labs. Should you need to stop/start these processes, proceed as shown below as user *opc* from your SSH terminal session

### DB Startup/Shutdown

1. Startup

    ```
    <copy>sudo systemctl start dbora</copy>
    ```

2. Shutdown

    ```
    <copy>sudo systemctl stop dbora</copy>
    ```

### OAS Startup/Shutdown

1. Startup

    ```
    <copy>sudo systemctl start oas</copy>
    ```

2. Shutdown

    ```
    <copy>sudo systemctl stop oas</copy>
    ```

**This concludes this lab. You may now [proceed to the next lab](#next).**

## Learn more
* [Oracle Analytics Server Documentation](https://docs.oracle.com/en/middleware/bi/analytics-server/index.html)
* [https://www.oracle.com/business-analytics/analytics-server.html](https://www.oracle.com/business-analytics/analytics-server.html)
* [https://www.oracle.com/business-analytics](https://www.oracle.com/business-analytics)

## Acknowledgements
* **Authors** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, January 2021
* **Contributors** - Diane Grace
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
