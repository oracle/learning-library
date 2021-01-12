# Initialize SecureOracle Environment

## Introduction

In this lab we will review and startup all components required to successfully run this workshop.

*Estimated Lab Time*:  30 minutes

### Objectives
- Initialize SecureOracle workshop environment.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup

## **STEP 0:** Running your Lab
### Access the graphical desktop
For ease of execution of this workshop, your instance has been pre-configured for remote graphical desktop accessible using any modern browser on your laptop or workstation. Proceed as detailed below to login.

1. Launch your browser to the following URL

    ```
    URL: <copy>http://[your instance public-ip address]:8080/guacamole</copy>
    ```

2. Provide login credentials

    ```
    Username: <copy>oracle</copy>
    ```
    ```
    Password: <copy>Guac.LiveLabs_</copy>
    ```

    ![](./images/guacamole-login.png " ")

    *Note*: There is an underscore `_` character at the end of the password.

3. To launch *Firefox* browser or a *Terminal* client, click on respective icon on the desktop

    ![](./images/guacamole-landing.png " ")

### Login to Host using SSH Key based authentication
While all command line tasks included in this workshop can be performed from a terminal session from the remote desktop session as shown above, you can optionally use your preferred SSH client.

Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
  - Authentication OS User - “*opc*”
  - Authentication method - *SSH RSA Key*
  - OS User – “*oracle*”.

1. First login as “*opc*” using your SSH Private Key

2. Then sudo to “*oracle*”. E.g.

    ```
    <copy>sudo su - oracle</copy>
    ```

Follow the steps below to Start/Stop SecureOracle components.

## **STEP 1**: Start and Stop SecureOracle Components

1.  From any of the terminal session started above, proceed as shown below to start all components as “*oracle*” user

    ```
    <copy>sc start all</copy>
    ```

    **Note:** the time to start the OIG components varies between 15-20 minutes.

    For your reference, the following commands are available to start or stop the different components and applications.

    ```
    sc <start|stop|status> oim          // start, stop or status OIG, SOA Server and OUD
    sc <start|stop|status> oim_bip      // start, stop or status OIG, SOA Server, OUD and BIP Server
    sc <start|stop|status> oam          // start, stop or status OAM, OUD and both OHS Servers
    sc <start|stop|status> oam_ohs1     // start, stop or status OAM, OUD and OHS Server 1
    sc <start|stop|status> oam_ohs2     // start, stop or status OAM, OUD and OHS Server 2
    sc <start|stop|status> all          // start, stop or status all OIG and OAM components
    ```

2. From the terminal session opened on your remote desktop via the browser, proceed as shown below to launch the **OIG Design Console**

    ```
    <copy>
    cd /home/oracle/products/oim/idm/designconsole
    ./xlclient.sh
    </copy>
    ```

3. The **Hedwig Mail Server** can be re-started if you experience issues when connecting with the Roundcube email client. E.g run the following commands to re-start the Hedwig Mail Server as user *opc*:

    ```
    <copy>
    export JAVA_HOME=/home/oracle/products/jdk
    sudo -E /home/oracle/demo/hedwig-0.7/bin/run.sh stop
    sudo -E /home/oracle/demo/hedwig-0.7/bin/run.sh start
    </copy>
    ```

## **STEP 2**: Running Development Tools

The development tools in SecureOracle are aimed to support use cases like editing SOA composites for OIG workflow approvals but also to help in customizing and configuring the different components as needed.


1. From the terminal session opened on your remote desktop via the browser, run the following commands to start **Oracle JDeveloper with SOA extensions** :

    ```
    <copy>
    cd ~
    ./startJDEVSOA.sh
    </copy>
    ```

    **Note**: You can find sample applications showcasing SOA composites with OIG workflows available under folder **`/home/oracle/jdevhome`**.

    ```
    NAME                                 DESCRIPTION
    RoleOwnerApproval.jws                Role single approval
    MultiRoleOwnerApproval.jws           Role multi-approval
    CustomDisconnectedProvisioning.jws   Disconnected app approval based on Sales Role
    ```

    Additionally you can find OIM out-of-the-box SOA composites in the following folder:

    ```
    /home/oracle/products/oam/idm/server/workflows/composites
    ```

2. To start **Oracle SQLDeveloper** run the following commands:

    ```
    <copy>
    cd ~
    ./startJDEVSOA.sh
    </copy>
    ```

    **Notes**: Three connections: `HR`, `HEDWIG` and `IAMDB` are already defined to access My HR, Hedwig and IAM database schemas. Alternatively you can install SQL Developer in your local host computer to access the different database schemas.

3. To start **Apache Studio** and manage the OUD/LDAP instance run the following commands:

    ```
    <copy>
    cd ~
  	./startAStudio.sh
    </copy>
    ```

    **Note**: A connection `IAM-OUD` is already defined to access OUD.

4. To start **Oracle PL/SQL** command line tool pointing to the IAM database, run the following commands:

    ```
    <copy>
    cd ~
    . ./setDBenv.sh
    ./startPLSQL.sh
    </copy>
    ```

## **STEP 3**: Admin Consoles, Applications and User Credentials
For your convenience, important URLs listed in this step for Admin consoles and Applications used throughout this workshop have been bookmarked and are available on Firefox within your remote desktop session.

  ![](./images/guacamole-bookmarks.png " ")

If you prefer accessing these from your local computer then chose one of the following options:
- Use the URLs provided in this section as shown, after adding the host entry below to **`/etc/hosts`** on your local Mac/Linux host or **`C:\Windows\System32\drivers\etc\hosts`** for Microsoft Windows hosts

    ```
    <copy><public_ip> secureoracle.oracledemo.com  secureoracle</copy>
    ```
- Substitute **`secureoracle.oracledemo.com`** in each URL below with the instance's `Public_IP_Address`

1. Use the following URLs and credentials to access all the different web consoles:

    Oracle Identity Manager Web Admin Console:

    ```
    URL         http://secureoracle.oracledemo.com:14000/sysadmin
    User        xelsysadm
    Password    Oracle123
    ```

    Oracle Identity Manager Self Service:

    ```
    URL         http://secureoracle.oracledemo.com:14000/identity
    User        xelsysadm
    Password    Oracle123
    ```

    Oracle Identity Manager Design Console. First run the following commands to start the design console:

    ```
    <copy>
    cd /home/oracle/products/oim/idm/designconsole
    ./xlclient.sh
    </copy>
    ```

    When prompted, enter the following URL and credentials:

    ```
    URL         t3://secureoracle.oracledemo.com:14000
    User        xelsysadm
    Password    Oracle123
    ```

    Oracle BI Publisher Admin Console:

    ```
    URL         http://secureoracle.oracledemo.com:9502/xmlpserver
    User        xelsysadm
    Password    Oracle123
    ```

    Oracle Identity Manager EM Console:

    ```
    URL         http://secureoracle.oracledemo.com:7001/em
    User        weblogic
    Password    Oracle123
    ```

    Oracle Access Manager Admin Console:

    ```
    URL         http://secureoracle.oracledemo.com:8001/oamconsole
    User        oamadmin
    Password    Oracle123
    ```

    Oracle Access Manager EM Console:

    ```
    URL         http://secureoracle.oracledemo.com:8001/em
    User        weblogic
    Password    Oracle123
    ```

    Email Server Admin Console (Hedwig Mail Server):

    ```
    URL         http://secureoracle.oracledemo.com:7001/hedwig-web-0.6/
    User        admin
    Password    Oracle123
    ```

    Email Web Client (Roundcube):

    ```
    URL         http://secureoracle.oracledemo.com/roundcubemail-1.4.1/
    User        admin
    Password    Oracle123
    Server      secureoracle.oracledemo.com
    ```

    My HR Application:

    ```
    URL         http://secureoracle.oracledemo.com:7001/ords/f?p=100
    User        hradmin
    Password    Oracle123
    ```

    My IGA Application:

    ```
    URL         http://secureoracle.oracledemo.com:7001/ords/f?p=102
    User        mgraff
    Password    Oracle123
    ```

    APEX Admin Console

    ```
    URL         http://secureoracle.oracledemo.com:7001/ords/apex_admin
    User        admin
    Pass        #Oracle123
    ```

    APEX HR Workspace

    ```
    URL         http://secureoracle.oracledemo.com:7001/ords/
    Workspace   HRSPACE
    User        hradmin
    Pass        Oracle123
    ```

    **Note**: My HR and My IGA Applications are available after the OIG domain is started as the service (Oracle REST Data Services) supporting these applications is deployed in the OIG Admin Server.

2. The following credentials are available to access other middleware components.

    Oracle IAM database:

    ```
    Host/port       secureoracle.oracledemo.com:1521
    Service name    iamdb.oracledemo.com
    User            sys as SYSDBA
    Password        Oracle123
    ```

    My HR Application database:

    ```
    Host/port       secureoracle.oracledemo.com:1521
    Service name    iamdb.oracledemo.com
    User            hr
    Password        Oracle123
    ```

    Oracle Unified Directory (OUD):

    ```
    Host/port       secureoracle.oracledemo.com:1389
    User            cn=Directory Manager
    Password        Oracle123
    ```

## **STEP 4**: Branding SecureOracle (optional)
Use the following instructions to customize the logo in the OIG Self Service interface. For illustrations we will use a sample logo image staged on your instance. Feel free to use your own image if preferred. Should you elect to use your own logo, ensure follow the recommended size of 145 x 38 pixels.

1. Copy the image file to *`/home/oracle/products/oim/idm/server/apps/oim.ear/iam-consoles-faces.war/images`*

    ```
    <copy>
    cp /home/oracle/demo/sample-data/mylogo.png /home/oracle/products/oim/idm/server/apps/oim.ear/iam-consoles-faces.war/images
    </copy>
    ```

2. Login to the OIG Self Service console as user **xelsysadm**. Click on the **Sandboxes** link located in the top right corner of the Self Service page.

3. In the **Manage Sandboxes** tab, click on **Create Sandbox**, enter a name and click on **Save and Close** and then **OK**.

4. Click on the **Customize** link located in the top right corner of the current page.

5. The customization panel is displayed at the top of the page. Click on **Structure** and then click on the Oracle logo image, in the pop-up window **Confirm Shared Component Edit** click on **Edit** button.

6. Next, click in the **Gear and Pencil** icon located in the top of the right panel.

7. In the **Component Properties: commandImageLink** window, click the **Down Arrow** icon next to the Icon property, and select **Expression Builder**.

8. Enter the path image as follow.

    E.g. enter the path using the following format:

    ```
    <copy>
    /home/oracle/products/oim/idm/server/apps/oim.ear/iam-consoles-faces.war/images/mylogo.png
    </copy>
    ```

9. Click **OK** to close the expression builder window, and then **OK** again to confirm the changes. The custom logo image should be displayed instead of the Oracle logo image.

10. Click in the **Close** button located in the top right corner to close the customization panel.

11. Go back to the **Manage Sandboxes** tab, select the sandbox name you created and click on **Publish Sandbox** and then click **Yes** to confirm.



## **Appendix**: About the Sample Organization

1. SecureOracle includes a sample top OIM organization **Oracle Users** and two child departments **Sales** and **Finance**. For each department an administrator account has been defined to demonstrate delegated administration. In addition, sample users have been added to demonstrate manager approval, escalation and organizational transfers.

    ![](./images/img-orgtree.png " ")

    Figure 4. Sample OIG Organization

2. The following is a quick reference to the demo users included in SecureOracle, please refer to the use cases documentation for more details in how these users and organizations are used in the sample demonstrations.

    ```
    USERNAME        ORGANIZATION     TITLE                        ADMIN ROLE      SCOPE OF CONTROL
    FINANCEADM      Finance          Administration Assistant     FinanceAdmin    Finance             
    SALESADM        Sales            Administration Assistant     SaleseAdmin     Sales
    MGRAFF          Sales            Sales Manager
    HDANIELS        Sales            Sales Manager
    JSMITH          Finance          Finance Manager
    ```

3. In addition, email accounts have been created for all demo users.You can access their in-boxes using the [Roundcube](http://secureoracle.oracledemo.com/roundcubemail-1.4.1/) email client with credentials **USERNAME/Oracle123**.

    ```
    USERNAME     EMAIL
    AHUTTON      ahutton@oracledemo.com
    JMALLIN      jmallin@oracledemo.com
    DFAVIET      dfaviet@oracledemo.com
    SMAVRIS      smavris@oracledemo.com
    MCHAN        mchan@oracledemo.com
    HDANIELS     hdaniels@oracledemo.com
    MGRAFF       mgraff@oracledemo.com
    SALESADM     salesadm@oracledemo.com
    ECLARK       eclark@oracledemo.com
    JSMITH       jsmith@oracledemo.com
    PSONG        psong@oracledemo.com
    PCAR         pcar@oracledemo.com
    FINANCEADM   financeadm@oracledemo.com
    DCOBY        dcoby@oracledemo.com
    GMARTON      gmarton@oracledemo.com
    RLAURIA      rlauria@oracledemo.com
    RMAINOR      rmainor@oracledemo.com
    ```
You may now *proceed to the next lab*.

## Learn More About Identity and Access Management
Use these links to get more information about Oracle Identity and Access Management:
- [Oracle Identity Management Website](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.4/index.html)
- [Oracle Identity Governance Documentation](https://docs.oracle.com/en/middleware/idm/identity-governance/12.2.1.4/index.html)
- [Oracle Access Management Documentation](https://docs.oracle.com/en/middleware/idm/access-manager/12.2.1.4/books.html)

## Acknowledgements
- **Author** - Ricardo Gutierrez, Solution Engineering - Security and Management
- **Contributors** - Rene Fontcha
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, December 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
