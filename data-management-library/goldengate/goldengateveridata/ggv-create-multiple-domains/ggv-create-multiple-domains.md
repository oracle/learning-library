# Create Multiple Domains for Oracle GoldenGate Veridata

## Introduction
This lab shows you how to create multiple domains for Oracle GoldenGate Veridata.
This scenario considers an existing Oracle GoldenGate Veridata install that is fully functional, any user logged on to the Web interface can see all the jobs created and run by other users in the existing WebLogic domain, and users belong to different department or LOB. If users from a particular LOB wish to create and run their own jobs not visible to other LOB, they can create a new domain that is isolated from the existing domain. In the new domain, they can add users only from their own line of businesses (LOB), or add all users from original domain but restrict privilege of users from certain LOB.

**Note**:  After you have completed lab 1: Install and Configure Oracle GoldenGate Veridata, the rest of the **labs are independent of each other**. You can complete labs 2 to 5 in any sequence you want to.

### What Do You Need?

+ **An existing Oracle GoldenGate Veridata install that is functional, version 12.2.1.2 and higher**

## **Step 1:** Create the Oracle GoldenGate Veridata Repository Schema
In this step you will learn how to use the Repository Creation Utility (RCU) to create the Veridata database repository where your Oracle GoldenGate domain instances are hosted.
1. Ensure to have installed and configured a certified database. See [My Oracle Support](https://support.oracle.com/portal/) for information on supported database.

2. To start the Repository Creation Utility (RCU), set the `JAVA_HOME` environment variable to your JDK location:

  * **On Windows**: Right-click on the desktop, then select My Computer, then select **Properties**. Click **Advanced System Settings** in the left column, then click **Environment Variables** in the **System Properties** window.
  * **On Unix**: `setenv JAVA_HOME/home/Oracle/Java/jdkversion`
  * Navigate to the `ORACLE_HOME/oracle_common/bin` directory.

3. Select a repository creation method. If you have the necessary permission and privileges to perform DBA activities on your database, select System Load and Product Load Concurrently. This procedure assumes that you have the necessary privileges. For Oracle database, if you do not have the necessary permission or privileges to perform DBA activities in the database, you must select Prepare Scripts for System Load on this screen. This option will generate a SQL script, which can be provided to your database administrator.

4. In the **Repository Creation Utility > Database Connection** screen, provide the database connection details for RCU to connect to your database. Click **Next** to proceed, then click **OK** on the dialog window confirming that connection to the database was successful.

5. To select components, select **Create new prefix**, specify a custom prefix, then select the **Oracle GoldenGate Veridata Repository** schema. Ensure to select a **unique prefix for each new domain**.
The custom prefix is used to logically group these schemas together for use in this domain only; you must create a unique set of schemas for each domain as schema sharing across domains is not supported.
6. Click **Next** to proceed, then click **OK** on the dialog window confirming that prerequisite checking for schema creation was successful.
7. Specify how you want to set the schema passwords on your database, then specify and confirm your passwords. Make a note the passwords you set on this screen; they are required later on during the domain creation process.
8. Specify the Tablespaces for the Oracle GoldenGate Veridata Repository.
9. Navigate through the remainder of the RCU screens to complete schema creation. When you reach the **Completion Summary** screen, click Close to dismiss RCU.


## **Step 2:** Configure Domain for Oracle GoldenGate Veridata

In this step you will create and configure an Expanded WebLogic domain for Oracle GoldenGate Veridata using the configuration wizard. To configure a domain:

1. Navigate to the `ORACLE_HOME/oracle_common/common/bin` directory and start the **WebLogic Server Configuration Wizard**.
    * **On Windows**: `config.cmd`
    * **On Unix**: `./config.sh`

2. On the **Configuration Type** screen, select **Create a new domain**.

3. On the **Templates** screen, make sure **Create Domain Using Product Templates** is selected, then select **Oracle GoldenGate** from the Template Categories.

4. On the **Administrator Account** screen, specify the user name and password for the default WebLogic Administrator account for the domain. It is recommended that you make a note of the user name and password specified on this screen; you will need these credentials later to boot and connect to the domain's Administration Server.

5. Specify the **Domain Mode** and JDK on the Domain Mode and JDK screen. Select **Production** in the Domain Mode field. Select the **Oracle HotSpot JDK** in the **JDK** field. JDK Version 1.8.0_101 or higher is required.

6. Specify the **Datasource Configuration Type**. Select RCU Data to activate the fields on this screen. The RCU Data option instructs the Configuration Wizard to connect to the database and Service Table (STB) schema to automatically retrieve schema information for the schemas needed to configure the domain.
**Note**: If you choose to select **Manual Configuration** on this screen, you will have to manually fill in the parameters for your schema on the JDBC Component Schema screen. After selecting **RCU Data**, specify the database connection details in the following fields:
    * **DBMS/Service**: Enter the database DBMS name, or service name if you selected a service type driver.
    * **Host Name**: Enter the name of the server hosting the database.
    * **Port**: Enter the port number on which the database listens.
    * **Schema Owner**, **Schema Password**: Enter the username and password for connecting to the database's Service Table schema. This is the schema username and password that was specified for the Service Table component on the "Schema Passwords" screen in RCU. The default username is `prefix_STB`, where prefix is the custom prefix that you defined in RCU.
7. Click **Get RCU Configuration** when you are finished specifying the database connection information. A message is displayed indicating that the connection is successful.

8. Specify JDBC Component Schema Information. Verify that the values on the JDBC Component Schema screen are correct for all schemas. If you selected **RCU Data** on the previous screen, then the schema table should already be populated appropriately.

9. Test the JDBC Connections. Use the **JDBC Test** screen to test the datasource connections you have just configured. A green check mark in the Status column indicates a successful test. If you encounter any issues, then see the error message in the **Connection Result** Log section of the screen, fix the problem, and then try to test the connection again.

10. Specify the keystore details. Use the **Keystore** screen to specify the path to the trusted certificate for each keystore. You can also specify the path to each keystore's private key, the password for the private key and the path to the Identity Certificate for the private key. To select an Identity certificate, select the Identity keystore name from the Store Key Name drop down list and specify the paths to the private key and the identity certificate. When you select the Trust Store from the **Store Key Name** drop-down list, the path to the sample certificate provided with the Veridata installation is displayed by default. You can specify the path to your trusted certificate on this page.

11. Configure the Administration Server Listen Address.On the Administration Server screen, select the drop-down list next to **Listen Address** and select the IP address on the host where the Administration Server will reside. Do not use **All Local Addresses**. Do not specify any server groups for the Administration Server.

12. Configure Node Manager. The Node Manager screen can be used to select the type of Node Manager you want to configure, along with the Node Manager credentials. Select **Per Domain** as the Node Manager type, then specify the Node Manager credentials.

13. Configure Managed Server. On the **Managed Servers** screen, in the **Listen Address** drop-down list, select the IP address of the host on which the Managed Server will reside. Do not use **All Local Addresses**.
  **Note**: If you want to run Oracle GoldenGate Veridata servers from multiple domains concurrently, then you must choose unique port numbers for Administration Server and Managed Server across different domains. If Oracle GoldenGate Veridata Server is only run from one domain at a time, then you can use the same port numbers for all domains.

14. In the **Server Groups** drop-down list, select **VERIDATA-MANAGED-SERVERS**. This server group ensures that the Oracle JRF services are targeted to the Managed Servers you are creating. Server groups target Fusion Middleware applications and services to one or more servers by mapping defined application service groups to each defined server group. A given application service group may be mapped to multiple server groups if needed. Any application services that are mapped to a given server group are automatically targeted to all servers that are assigned to that group. A new Managed Server named `VERIDATA_server1` is created.

15. Review your configuration specifications. The **Configuration Summary** screen contains the detailed configuration information for the domain you are about to create. Review the details of each item on the screen and verify that the information is correct. You can go back to any previous screen if you need to make any changes, either by using the Back button or by selecting the screen in the navigation pane. Click **Create** to begin the domain creation process.

16. Review your Domain Home and Administration Server URL. The **Configuration Success** screen will show the Domain home location and URL of the Administration Server you just configured. You must make a note of both items as you will need them to start the servers in your domain. Click **Finish** to close the Configuration Wizard.

## **Step 3:** Perform Next Steps
Familiarize yourself with the tasks described in this section and perform them as needed to verify that your domain is properly configured. See [Next Steps After Configuring an Oracle GoldenGate Veridata Domain](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdis/next-steps-configuring-oracle-goldengate-veridata-domain.html#GUID-0ACB030D-738F-4AAA-B0D7-0AAF5ED562D1)


## Want to Learn More?

* [Creating a WebLogic Domain](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.3/wldcw/creating-weblogic-domain.html#GUID-40F10C88-F8A2-4849-869C-65CFC5243B71)
* [Repository Creation Utility (RCU)](https://docs.oracle.com/en/middleware/lifecycle/12.2.1.3/rcuug/repository-creation-utility.html#GUID-2E73B30E-9E64-4986-82AD-CD54BB9641BD)
* [Oracle GoldenGate Veridata Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/index.html)
* [Creating the Oracle GoldenGate Veridata Repository Schema ](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdis/creating-oracle-goldengate-veridata-repository-schema.html#GUID-8613B259-F576-4749-8757-89E571286AF0)

## Acknowledgements

* **Author:**
    + Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Reviewed by:**
    + Jonathan Fu, Director, Product Development, GoldenGate Development

* **Last Updated By/Date:** Anuradha Chepuri, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
