# Connect Oracle Analytics Cloud with your Exadata Cloud Service Database

## Introduction
Oracle Analytics Cloud empowers business analysts and consumers with modern, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing/generation.

Oracle Analytics Cloud is a scalable and secure public cloud service that provides a full set of capabilities to explore and perform collaborative analytics for you, your workgroup, and your enterprise.

With Oracle Analytics Cloud you also get flexible service management capabilities, including fast setup, easy scaling and patching, and automated lifecycle management.

Estimated Lab Time: 45 minutes.

### Objectives

As a LOB user,
* Install and configure Remote Data Gateway in Oracle Cloud Developer Image
* Configure Remote Data Gateway with Oracle Analytics Cloud
* Connect Exadata Cloud Service Database with Oracle Analytics Cloud

### Prerequisites

* A pre-provisioned instance of Oracle Developer Client image in an application subnet.
* A pre-provisioned ExaCS database instance.
* A pre-provisioned Oracle Analytics Cloud instance. Refer [here](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acoci/create-services.html#GUID-D2F03D22-95FB-45C8-AB94-928AE4E167AB) to create an Oracle Analytics Cloud instance.
* VNC Viewer or other suitable VNC client on your local laptop

## **STEP 1:** Connect to Dev Client Desktop over VNC

1. First, we shh into the dev client and invoke the VNC server that comes pre-installed.

2. SSH into your dev client compute instance.

    ```
    <copy>ssh -i /path_to/private-key opc@PublicIP</copy>
    ```

3. Change the password on the VNC server.

    ```
    <copy>vncpasswd</copy>
    ```
4. Once you update the password, start your VNC server with the following command,

    ```
    <copy>vncserver -geometry 1280x1024</copy>
    ```
5. Your development system may now be ready for accepting VNC connections.

**Mac Users**

6. Open a terminal window and create an ssh tunnel using the following command,

    ```
    <copy>ssh -N -L 5901:127.0.0.1:5901 -i /path_to/priv-key-file opc@publicIP-of-your-devClient</copy>
    ```

**Windows Users**

7. Windows 10 users can use powershell to connect using command above.

8. Alternatively, you may create and ssh tunnel using putty. Detailed instructions on using putty for ssh tunnels are provided in the [Appendix](?lab=appendix).

9. You now have a secure ssh tunnel from your local laptop to your developement system in OCI on VNC port 5901. *Note: As mentioned earlier, you need a VNC client installed on your laptop. This lab uses VNC Viewer.*

10. Start VNC Viewer on your laptop and configure a client connection using the settings as shown.

    ![](./images/vncViewer.png " ")

11. Note how the connect string for VNC Server is simply localhost:1  That is because the default port 5901 on your local machine is forwarded to 5901 on your OCI dev client over an ssh tunnel.

12. Connect to your VNC desktop and provide the password you changed on the host earlier.

13. If all goes well, you should now see a linux desktop in your VNC window.

## **STEP 2:** Download, Install and Configure Remote Data Gateway

1. Download OAC Data Gateway 5.6.0+ from [here](https://www.oracle.com/middleware/technologies/oac-downloads.html).

2. Secure copy the file using scp, sftp or a windows ftp client. *Note: You will be secure copying the zip file from your local machine to Cloud Developer Image*

    ```
    <copy>scp -i /path_to/keyfile /path_to/datagateway-linux.zip  opc@ipaddress-of-dev-client:/home/opc</copy>
    ```

3. Example, for mac users with a private key file named id_rsa in their home directoy,

    ```
    <copy>scp -i ~/id_rsa datagateway-linux.zip  opc@129.162.23.12:/home/opc</copy>
    ```

4. In your VNC session, unzip the data gateway file.

    ```
    <copy> unzip 'datagateway_file.zip' </copy>
    ```

    ![](./images/unzip-datagateway.png " ")

5. Run the datagate_file.bin

    ```
    <copy> ./datagate_file.bin </copy>
    ```

    ![](./images/run-bin-file.png " ")

6. Oracle Analytics Cloud RDC Installer should pop-up. Select default Inventory Directory and click OK.

    ![](./images/RDC-installer.png " ")

7. Click NEXT on the Welcome page

    ![](./images/RDC-installer1.png " ")

8. Enter RDC installer location and click NEXT

    ```
    <copy> /home/opc/Oracle/Middleware/Oracle_Home </copy>
    ```

    ![](./images/RDC-installer2.png " ")

9. Select Remote Data Gateway in Remote Data Version and click NEXT

    ![](./images/RDC-installer3.png " ")

10. Enter Username and Password for Agent Configuration Credentials and click NEXT. (Username: admin, Password: WElcome_123#)

    ![](./images/RDC-installer4.png " ")

11. Verify the Installation Summary and click INSTALL

    ![](./images/RDC-installer5.png " ")

12. Once the installation progress is 100% click NEXT

    ![](./images/RDC-installer6.png " ")

13. Verify Start Jetty is checked and click FINISH

    ![](./images/RDC-installer7.png " ")

14. Next we will configure Data Gateway with Oracle Analytics Cloud. Open web browser in your Cloud Developer Image and type in the below URL.

    ```
    <copy> http://localhost:8080/obiee/config.jsp </copy>
    ```

    ![](./images/RDC-installer8.png " ")

15. Enter the Username and Password as specified earlier in this lab and click OK (Username: admin, Password: WElcome_123#)

    ![](./images/RDC-installer9.png " ")

16. Enter your OAC URL, click Generate Key and Save. Once saved, Enable Data Gateway. Note: Copy the Generated key to a note pad. We will be using the key in Oracle Analytics Cloud console.

    ![](./images/RDC-installer10.png " ")

    ![](./images/RDC-installer11.png " ")

17. Now, on your local machine, open a browser and navigate to the homepage of the OAC instance you are attempting to connect to. In the top left, click on the hamburger menu to open the side menu

     ![](./images/OACHOME.png " ")

18. In the side menu, click on Console.

     ![](./images/OACSIDEMENU.png " ")

19. In the console, scroll to the bottom and click **Remote Data Connectivity**.

     ![](./images/RDGFROMMENU.png " ")

20. Inside the Remote Data Connectivity pane, click on the **Add** button.

     ![](./images/CLICKADDRDG.png " ")

21. Paste the generated key inside the Public Key box. Notice that all of the information will then populate in the  Name, ID, and Host page.

     ![](./images/PASTEPUBKEY.png " ")

22. After entering the Public Key, click **Ok** and then **Add**. Then, see your connection added.

     ![](./images/SEECONNECTION.png " ")

23. Now, navigate back to your VNC Viewer where you got the Public Key from. Click on Test and you should see a Successfully Authenticated message.

    ![](./images/RDC-installer12.png " ")

24. Click on Save and scroll down to bottom of the page to verify.

    ![](./images/RDC-installer13.png " ")

## **STEP 3:** Configure Remote Data Connectivity and Connect ExaCS Database to Oracle Analytics Cloud

1. Now, in your Oracle Analytics Cloud URL in you local machine, log in to the console.

2. Click on Create on the top right corner and click on Connection

    ![](./images/createconn.png " ")

3. Select Oracle Database.

    ![](./images/exadbconnection.png " ")

4. Enter Host, Port, Service Name, Username and Password in the Create Connection page. Then click **Save** to save your connection.

    ![](./images/filloutthesefields.png " ")

    a. Host: Host Name can be found in tnsnames.ora
    b. Port: 1521
    c. Service Name: Service name can be found in tnsnames.ora
    d. Username: sysdba
    e. Password: Database Admin password

5. After saving your connection, click on the Search bar and select **Connection** from the drop-down menu.

    ![](./images/connection.png " ")

6. Here, you can see your ExaCS db connected to Oracle Analytics Cloud.

    ![](./images/finalscreen.png " ")

## Learn More

For more information on Oracle Analytics Cloud please click [Here](https://www.oracle.com/business-analytics/analytics-cloud.html).

To further explore Oracle Analytics Cloud you can visit our blogs [Here](https://blogs.oracle.com/analytics/).

## Acknowledgements

- **Author** - Tejus Subrahmanya, Phani Turlapati, Abdul Rafae, Sathis Muniyasamy, Sravya Ganugapati, Padma Natarajan, Aubrey Patsika, Jacob Harless
- **Last Updated By/Date** - Jess Rein - Cloud Engineer, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
