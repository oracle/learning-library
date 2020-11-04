# Connect Oracle Analytics Cloud with your dedicated autonomous database

## Introduction
Oracle Analytics Cloud empowers business analysts and consumers with modern, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing/generation.

Oracle Analytics Cloud is a scalable and secure public cloud service that provides a full set of capabilities to explore and perform collaborative analytics for you, your workgroup, and your enterprise.

With Oracle Analytics Cloud you also get flexible service management capabilities, including fast setup, easy scaling and patching, and automated lifecycle management.

### Objectives

As a LOB user
1. Insatall and configure Remote Data Gateway in Oracle Cloud Developer Image
2. Configure Remote Data Gateway with Oracle Analytics Cloud
3. Connect Autonomous Database Dedicated with Oracle Analytics Cloud

### Required Artifacts

- A pre-provisioned instance of Oracle Developer Client image in an application subnet. Refer to [Lab 8](?lab=lab-8-configuring-development-system).
- A pre-provisioned dedicated autonomous database instance. Refer to [Lab 7](?lab=lab-7-provisioning-databases).
- A pre-provisioned Oracle Analytics Cloud instance. Refere [Here](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acoci/create-services.html#GUID-D2F03D22-95FB-45C8-AB94-928AE4E167AB) to create Oracle Analytics Cloud.
- VNC Viewer or other suitable VNC client on your local laptop

## STEP 1: Download DB wallet to local machine

Let's first download the DB wallet to your local machine (laptop) and then scp / sftp it to the developer client machine.

 *Note: You may skip the download and secure copy steps below and download the wallet directly into your developer client machine once you connect to it via VNC*

- From your local browser, navigate to OCI console.

- On the ATP console, select the dedicated ATP instance provisioned in [Lab 7](?lab=lab-7-provisioning-databases).
    ![](./images/doneprovision.png " ")

- Click on  *DB Connection* to open up Database Connection pop-up window.
    ![](./images/dbconnection.png " ")

- Click on *Download* to supply a password for the wallet and download your client credentials.
    Please use below Keystore password to download the client credentials.

    ```
    <copy>
    WElcome#1234
    </copy>
    ```

    ![](./images/Picture200-3.png " ")

- The credentials zip file contains the encryption wallet, Java keystore and other relevant files to make a secure TLS 1.2 connection to your database from client applications. 


## STEP 2: Connect to dev client desktop over VNC

First we shh into the dev client and invoke the VNC server that comes pre-installed.

- SSH into your dev client compute instance.

    ```
    <copy>
    $ ssh -i <private-key> opc@PublicIP
    </copy>
    ```

- Change the password on the VNC server.
    
    ```
    <copy>
    $ vncpasswd
    </copy>
    ```
- Once you update the password, start your VNC server with the following command,
  
    ```
    <copy>
    $ vncserver -geometry 1280x1024
    </copy>
    ```
- Your development system may now be ready for accepting VNC connections.

**Mac Users**

  - Open a terminal window and create an ssh tunnel using the following command,
    
    ```
    <copy>
    $ ssh -N -L 5901:127.0.0.1:5901 -i \<priv-key-file\> opc@<publicIP-of-your-devClient>
    </copy>
     ```

**Windows Users**
  - Windows 10 users can use powershell to connect using command above.

  - Alternatively, you may create and ssh tunnel using putty. Detailed instructions on using putty for ssh tunnels are provided in the [Appendix](?lab=appendix).

  You now have a secure ssh tunnel from your local laptop to your developement system in OCI on VNC port 5901.

  *Note: As mentioned earlier, you need a VNC client installed on your laptop. This lab uses VNC Viewer.*

  Start VNC Viewer on your laptop and configure a client connection using the settings as shown.
      ![](./images/vncViewer.png " ")

  - Note how the connect string for VNC Server is simply localhost:1  That is because the default port 5901 on your local machine is forwarded to 5901 on your OCI dev client over an ssh tunnel.

  - Connect to your VNC desktop and provide the password you changed on the host earlier.

  - If all goes well, you should now see a linux desktop in your VNC window.

## STEP 3: Download, install and configure Remote Data Gateway

1. Download OAC Data Gateway 5.6.0+ from [Here](https://www.oracle.com/middleware/technologies/oac-downloads.html)

2. Secure copy the file using scp, sftp or a windows ftp client.

#### Note: You will be secure copying the zip file from your local machine to Cloud Developer Image

    ```
    <copy>
        $ scp -i <path/to/keyfile> <datagateway-linux.zip>  opc@<ipaddress-of-dev-client>:/home/opc
    </copy>
    ```

    Example, for mac users with a private key file named id_rsa in their home directoy,

    ```
    <copy>
        $ scp -i ~/id_rsa datagateway-linux.zip  opc@129.162.23.12:/home/opc
    </copy>
    ```

3. In your VNC session, unzip the data gateway file.

    ```
    unzip 'datagateway_file.zip'
    ```

    ![](./images/unzip-datagateway.png " ")

4. Run the bin fole

    ```
    ./datagate_file.bin
    ```
    ![](./images/run-bin-file.png " ")

5. Oracle Analytics Cloud RDC Installer should pop-up. Select default Inventory Directory and click OK.

    ![](./images/RDC-installer.png " ")

6. Click NEXT on the Welcome page

    ![](./images/RDC-installer1.png " ")

7. Enter RDC installer location and click NEXT
    
    ```
    /home/opc/Oracle/Middleware/Oracle_Home
    ```
    ![](./images/RDC-installer2.png " ")

8. Select Remote Data Gateway in Remote Data Version and click NEXT

    ![](./images/RDC-installer3.png " ")

9. Enter Username and Password for Agent Configuration Credentials and click NEXT
    ```
    Username: admin
    Password: WElcome_123#
    ```
    ![](./images/RDC-installer4.png " ")

10. Verify the Installation Summary and click INSTALL

    ![](./images/RDC-installer5.png " ")

11. Once the installation progress is 100% click NEXT

    ![](./images/RDC-installer6.png " ")

12. Verify Start Jetty is checked and click FINISH

    ![](./images/RDC-installer7.png " ")

13. Configure Data Gateway with Oracle Analytics Cloud. Open web browser in your Cloud Developer Image and type in the below URL.

    ```
    http://localhost:8080/obiee/config.jsp
    ```

    ![](./images/RDC-installer8.png " ")

14. Enter the Username and Password as specified earlier in this lab and click OK

    ```
    Username: admin
    Password: WElcome_123#
    ```

    ![](./images/RDC-installer9.png " ")

15. Enable Data Gateway, enter OAC URL and click on Generate Key to generate json key.

    #### Note: Copy the Generated key to a note pad. We will be using the key in Orace Analytics Cloud console.

    ![](./images/RDC-installer10.png " ")

    ![](./images/RDC-installer11.png " ")

16. Click on Test and scroll down to bottom of the page to verify. You should see the below message.

    ```
    Sucecessfully authenticated
    ```
    
    ![](./images/RDC-installer12.png " ")

17. Click on Save and scroll down to bottom of the page to verify

    ```
    Successfully Submitted
    ```

    ![](./images/RDC-installer13.png " ")


## STEP 4: Configure Remote Data Connectivity and connect Autonomous Database Dedicated to Oracle Analytics Cloud



1. Open Oracle Analytics Cloud URL in you local machine and log in to the console

    ![](./images/oac.png " ")

2. Click on Menu on the top left corner and click on Console

    ![](./images/console.png " ")

3. Click on Remote Data Connectivity on Console page

    ![](./images/console-RDC.png " ")

4. Click on Add in Remote Data Connectivity page

    ![](./images/console-RDC-Add.png " ")

5. Paste the Copied key in Step 3 #15 in Public Key and click OK. 

    #### Note Name, ID and Host will be auto populated once you paste the public key. 

    ![](./images/console-RDC-key.png " ")

6. Click on Menu on top left corner and click on Home.

    ![](./images/oac-home.png " ")

7. Click on Create on the top right corner and click on Connection

    ![](./images/createconn.png " ")

8. Select Oracle Autonomous Transaction Processing

    ![](./images/createconn1.png " ")

9. Enter Connection Name and click on Select to upload your database wallet.

    ![](./images/createconn2.png " ")

10. Once you upload your wallet, Service Name and Client Credentials should be automatically populated.

    ![](./images/createconn3.png " ")

11. Enter Username and Password of your Autonomous Database and check on Use Remote Data Connectivity

    ![](./images/createconn4.png " ")

7. Click on Serach bar and select Connection
    
    ![](./images/connection.png " ")

8. You can see AutonomousDatabase connected to Oracle Analytics Cloud.

    ![](./images/connectionSuccess.png " ")

For more information on Oracle Analytics Cloud please click [Here](https://www.oracle.com/business-analytics/analytics-cloud.html).

To further explore Oracle Analytics Cloud you can visit our blogs [Here](https://blogs.oracle.com/analytics/).

## Acknowledgements

*Great Work! You successfully connected Autonomous Database Dedicated to Oracle Analytics Cloud through Remote Data Gateway.*

- **Author** - Tejus S. & Kris Bhanushali
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, March 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/autonomous-database-dedicated). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.