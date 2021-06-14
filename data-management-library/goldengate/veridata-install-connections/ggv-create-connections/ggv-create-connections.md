# Create Datasource Connections

## Introduction
This lab describes how to configure datasource connections. The Oracle GoldenGate Veridata  Server must be able to connect to an Oracle GoldenGate Veridata Agent for each database that contains source and target data that you want to compare. A connection is defined by a host, the port number of an Oracle GoldenGate Veridata Agent (or Manager, if a C-agent), and the datasource that is accessed by the agent. You need to create connections before you create any of the GoldenGate Veridata objects, such as groups, compare pairs, profiles, or jobs.

Watch this short video on how to create datasource connections, groups, compare pairs, jobs, and repair data:

[](youtube:DiAapnWt0No)


*Estimated Lab Time*: 45 minutes

### Objectives
In this lab, you will:
* Create a Connection in Oracle GoldenGate Veridata.

### Prerequisites
This lab assumes you have:

* A Free Tier, Paid or LiveLabs Oracle Cloud account
* SSH Private Key to access the host via SSH
* You have completed:
    * Lab: Generate SSH Keys (Free-tier and Paid Tenants only)
    * Lab: Prepare Setup (Free-tier and Paid Tenants only)
    * Lab: Environment Setup
    * Lab: Initialize Environment
* The following are required to complete this lab:
    * Oracle Database 19c (19.3.0.0) (for the repository)

## **STEP 1:** Login to Oracle GoldenGate Veridata
  To login to GoldenGate Veridata:
  1. Open a browser in VNC and enter the URL:
    ```
    <copy>
    http://<your instance public-ip address>:8830/veridata/login.jsf
    </copy>
    ```
      OR

    ```
    <copy>
    http://localhost:8830/veridata/login.jsf
    </copy>
    ```
      OR

    ```
  <copy>
  http://veridata.livelabs.oraclevcn.com:8830/veridata/login.jsf
  </copy>
    ```
  2. Enter your login credentials:
      * **username**: ggadm
      * **Password**: welcome1

    ![](./images/1-login-veridata.png " ")
  3. Click **Login**.

  **Note**: After you login, in the displayed **Memory Check** pop-up screen, click **Ok** or close this pop-up screen.

## **STEP 2:** Create a Connection
To get started with Oracle GoldenGate Veridata, you must define a connection to the source and target databases that contain the data that you want to compare. Oracle GoldenGate Veridata Server uses the connection information to communicate with Oracle GoldenGate Veridata Agent.

**Note**: Ensure that you have the Administrator or the Power User roles to create and configure connections.

To create connections:
1. From the left navigation pane, click **Configuration** and then click **Connection Configuration** to display the **Connection configuration** page.
    ![](./images/2-connection-configuration.png " ")
2. Click **New** to display the **New Connection Assistant** page to create one connection for the source database.
3. Enter the **Connection Name**, for example, **SourceConnection** and click **Next**.
    ![](./images/3-connection-name-description.png " ")
4. Enter the following details:
    * **Host Name or IP Address**: Name of the host where Oracle GoldenGate Veridata Agent is running.
      Enter
          ```
          <copy>
          veridata.livelabs.oraclevcn.com
          </copy>
          ```
      OR
          ```
          <copy>
          localhost
          </copy>
          ```

    * **Port**: The port number for Oracle GoldenGate Veridata Agent on that host. Enter

          ```
          <copy>
          7850
          </copy>
          ```
    * **Datasource Type**: The datasource that is associated with this agent. Click **Verify**.
      ![](./images/4-new-connection-assistant.png " ")

5. Click **Next** to enter the Datasource Connection credentials:
    * **User**: source
    * **Password**: source
    ![](./images/5-new-connection-assistant-datasource-credentials.png " ")

6. Click **Test Connection**.

7. Click **Finish**.
    You have created one connection successfully.
8. Click **Create another Connection** to create the target connection. Follow points 3 to 7 to create the second connection (for example, **TargetConnection**) for the target database:
    * **User**: target
    * **Password**: target
    ![](./images/6-new-connection-create-another-connection.png " ")  

9. Click **OK** to display the **New Connection Assistant** page.

You may now [proceed to the next lab](https://oracle.github.io/learning-library/data-management-library/goldengate/veridata-install-connections/workshops/freetier/?lab=ggv-create-groups-compare-pairs).

## Learn More

* [Oracle GoldenGate Veridata Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/index.html)
* [Configuring Connections](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/configure-workflow-objects.html#GUID-75005B4D-5C24-4467-A68B-1FE66A168905)

### Acknowledgements
* **Author** - Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Contributors** -  Nisharahmed Soneji, Senior Principal Product Manager and Sukin Varghese, Senior Member of Technical staff
* **Last Updated By/Date** - Anuradha Chepuri, June 2021
