# Connect the Oracle GoldenGate Veridata Agent to Autonomous Data Warehouse

## Introduction
This lab describes how to connect the Oracle GoldenGate Veridata to Autonomous Data Warehouse (ADW) and Autonomous Transaction Processing (ATP) by using the Oracle Wallet.
For proof-of-concept, you will install everything on one host. In a production scenario it would likely be three or four separate hosts: source database, target database, and the repository database with WebLogic Server installed. After completing this lab, you might want to take more GoldenGate training and/or more WebLogic training.

Java applications require Java Key Store (JKS) or Oracle wallets to connect to ATP or ADW. There are two methods in which the Oracle GoldenGate Veridata can be connected to Autonomous Data Warehouse:
  * Using Java Key Stores
  * Using Oracle Wallet

**Note**: This lab is for using the Oracle Wallet only. For using Java Key Sores (JKS),see [Java Connectivity with Autonomous Database (ATP or ADW)](https://www.oracle.com/database/technologies/java-connectivity-to-atp.html)

**Note**:  After you have completed lab 1: Install and Configure Oracle GoldenGate Veridata, the rest of the **labs are independent of each other**. You can complete labs 2 to 5 in any sequence you want to.

### What Do You Need?

+ **Download Client Credentials wallet.**
+ **Oracle Database 12c and above (for the repository)**
+ **Download and install latest jdk (JDK > JDK8u162), and jars in Step 1 > 6 from [Oracle Database 18c (18.3) JDBC Driver and UCP Downloads](https://www.oracle.com/database/technologies/appdev/jdbc-ucp-183-downloads.html)**

## **Step 1:** Set up the Oracle Wallet and Oracle GoldenGate Veridata Agent
To set up Oracle Wallet and the Oracle GoldenGate Veridata Agent:
1. Ensure that you have downloaded the `Wallet_ADW20190410NS.zip` from the ADW/ATP console.
2. Unzip the wallet in a location:

    <pre>-bash-4.2$ unzip Wallet_ADW20190410NS.zip

      Archive: Wallet_ADW20190410NS.zip

      inflating: cwallet.sso

      inflating: tnsnames.ora

      inflating: truststore.jks

      inflating: ojdbc.properties

      inflating: sqlnet.ora

      inflating: ewallet.p12

      inflating: keystore.jks

      -bash-4.2$</pre>

3. Add following lines in `sqlnet.ora`:

    <pre>WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="AGENT_DEPLOY_LOCATION/wallet")))

    SSL_SERVER_DN_MATCH=yes

    SQLNET.USE_HTTPS_PROXY=on

    bequeath_detach=true

    SQLNET.ALLOWED_LOGON_VERSION=8</pre>

4. Remove the comment for the following line in `ojdbc.properties`:
    `oracle.net.wallet_location=(SOURCE=(METHOD=FILE)(METHOD_DATA=(DIRECTORY=${TNS_ADMIN})))`

5. Copy the jdbc 18.3 jars in Oracle GoldenGate Veridata Agent installed location.

6. Point the Veridata Agent to pick the jdbc 18.3 jars with the following entries in `agent.properties`:
    <pre>server.jdbcDriver=ojdbc8.jar ucp.jar oraclepki.jar osdt_core.jar osdt_cert.jar

    server.driversLocation = AGENT_DEPLOY_LOCATION/drivers</pre>

7. Change the database url to: `database.url=jdbc:oracle:thin:@adw20190410ns_low?TNS_ADMIN= AGENT_DEPLOY_LOCATION/wallet`.
8. Ensure that TNS_ADMIN points to the location where the Oracle wallet was unzipped earlier, by using the following syntax: `jdbc:oracle:thin:@{db alias in tnsnames.ora}?TNS_ADMIN={location of the tnsnames.ora of the wallet}`.
9. Start the agent by running the command: `-bash-4.1$ ./agent.sh run`.
10. Connect to the Agent through the Oracle GoldenGate Veridata Server.


## **Step 2:** Add Proxy Information (Optional Topic)

To add proxy information:

1. Replace the Oracle proxy and port in below example with your own `(https_proxy=www-proxy-hqdc.us.oracle.com)(https_proxy_port=80)`. For example:

    <pre>adw20190410ns_low = (description= (address=(https_proxy=www-proxy-hqdc.us.oracle.com)(https_proxy_port=80)(protocol=tcps)

    (port=1522)(host=adb.us-ashburn-1.oraclecloud.com))(connect_data= (service_name=n2yg3pftwi1lovg_adw20190410ns_low.adwc.oraclecloud.com))(security=(ssl_server_cert_dn=

    "CN=adwc.uscom-east-1.oraclecloud.com,OU=Oracle BMCS US,O=Oracle Corporation,L=Redwood City,ST=California,C=US")) )</pre>


## Want to Learn More?

* [Oracle GoldenGate Veridata Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/index.html)
* [Autonomous Transaction Processing](https://docs.oracle.com/en/cloud/paas/atp-cloud/index.html)

## Acknowledgements

* **Author:**
    + Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Reviewed by:**
    + Jonathan Fu, Director, Product Development, GoldenGate Development

* **Last Updated By/Date:** Anuradha Chepuri, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
