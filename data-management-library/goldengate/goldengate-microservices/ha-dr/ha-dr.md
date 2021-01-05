# GoldenGate Microservices Active-Active

## Introduction
This lab will introduce you to Oracle GoldenGate for Microservices Workshop Architecture and High Availability / Disaster Recovery using Active-Active Technology.
Since we have already done multiple labs, this one will take what we used so far to script this using DB container reset scripts, SQL scripts to setup AutoCDR in the database, OGGCA silent deployment scripts and GG REST API scripts to do a rapid deployment.

*Estimated Lab Time*:  60 minutes

### Lab Architecture
  ![](./images/ggmicroservicesarchitecture.png " ")

### Objectives

- Rapid Deployment using:
  - OGGCA silent deployment scripts (remove and recreate deployments).
  - REST API to setup bi-directional GoldenGate replication between two databases.
  - SQL Scripts to setup up auto conflict detection and resolution in the database.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Initialize Environment
    - Lab: Create One-Way Replication

## **STEP 1**:Generate Transactions with Swingbench

1. As user *oracle* from the SSH terminal session, navigate to `~/Desktop/Scripts/HOL/Lab8` and start Swingbench utility

     ```
    <copy>
    cd ~/Desktop/Scripts/HOL/Lab8
    ./start_swingbench.sh
    </copy>
    ```

    ![](./images/h1.png " ")

2. Open a browser tab session to the Performance Metrics Server for *Boston* Deployment

    ```
    <copy>https://<Your Public IP Address>/Boston/pmsrvr</copy>
    ```

    ![](./images/h2.png " ")

3. Click on *IREP* Replicat to view detailed live performance metrics

    ![](./images/h3.png " ")

## **STEP 2**: Configure Active-Active Replication

1. Navigate to `~/Desktop/Scripts/HOL/Lab9` and create credentials and alias for Boston GG User

    ```
    <copy>
    cd ~/Desktop/Scripts/HOL/Lab9/Build
    ./create_credential_GGAlias.sh Welcome1 17001 c##ggate@orcl ggate SGGATE2</copy>
    ```

    ![](./images/h4.png " ")

2. Go to the browser tab session of the Admin Server for *Atlanta* Deployment and validate

    ```
    <copy>https://<Your Public IP Address>/Atlanta/adminsrvr</copy>
    ```
    ![](./images/h5.png " ")

3. Navigate to `~/Desktop/Scripts/HOL/Lab9/Build` and run `create_credential_Protcol.sh`

    ```
    <copy>
    cd ~/Desktop/Scripts/HOL/Lab9/Build
    ./create_credential_Protcol.sh Welcome1 17001 oggadmin Welcome1 WSTARGET2
    </copy>
    ```
    ![](./images/h6.png " ")

4. Go to the browser tab session of the Admin Server for *Boston* Deployment and validate

    ```
    <copy>https://<Your Public IP Address>/Boston/adminsrvr</copy>
    ```
    ![](./images/h7.png " ")

5. Add Schema Trandata for Boston schema SOE

    ```
    <copy>./add_SchemaTrandata_182.sh Welcome1 17001</copy>
    ```

    ![](./images/h8.png " ")

    ![](./images/h9.png " ")

6. Add Extract to Boston Deployment

    ```
    <copy>./add_Extract2.sh Welcome1 17001 EXTSOE1  </copy>
    ```

    ![](./images/h10.png " ")

7. Go to the browser tab session of the Admin Server for *Boston* Deployment and validate

    ```
    <copy>https://<Your Public IP Address>/Boston/adminsrvr</copy>
    ```

    ![](./images/h11.png " ")

8. Add Distribution path from Boston to connect to Atlanta

    ```
    <copy>./add_DistroPath2.sh Welcome1 17002 SOE2SOE1 bb 16003 ba</copy>
    ```

    ![](./images/h14.png " ")

    ```
    <copy>https://<Your Public IP Address>/Boston/distsrvr</copy>
    ```

    ![](./images/h15.png " ")

9. Create Alias

    ```
    <copy>./create_credential_GGAlias.sh Welcome1 16001 ggate@oggoow19 ggate TGGATE1</copy>
    ```

    ![](./images/h16.png " ")

    ```
    <copy>https://<Your Public IP Address>/Atlanta/adminsrvr</copy>
    ```

    ![](./images/h17.png " ")

10. Create Checkpoint Table

    ```
    <copy>./add_CheckpointTable.sh Welcome1 16001 OracleGoldenGate.TGGATE1</copy>
    ```

    ![](./images/h18.png " ")

    ```
    <copy>https://<Your Public IP Address>/Atlanta/adminsrvr</copy>
    ```

    ![](./images/h19.png " ")

11. Create Replicat at Atlanta

    ```
    <copy>./add_Replicat1.sh Welcome1 16001 IREP1</copy>
    ```
    ![](./images/h20.png " ")

    ```
    <copy>https://<Your Public IP Address>/Atlanta/adminsrvr</copy>
    ```
    ![](./images/h21.png " ")

12. Setup Auto CDR

    ```
    <copy>
    cd ~/Desktop/Scripts/HOL/Lab9
    ./setup_autocdr.sh
    </copy>
    ```

    ![](./images/h22.png " ")


12. Start GoldenGate Processes

    ```
    <copy>./start_replication.sh Welcome1 17001 EXTSOE1 17002 SOE2SOE1 16001 IREP1</copy>
    ```

    ![](./images/h23.png " ")


## **STEP 3**: Generate Load with Swingbench

In this step we will use a script to invoke Swingbench to apply data to the source (Atlanta) and target (Boston) databases at the same time and then validate performance using the Performance Metric Service.

1. As user *oracle* from the SSH terminal session, navigate to `~/Desktop/Scripts/HOL/Lab9` and start Swingbench utility

     ```
    <copy>
    cd ~/Desktop/Scripts/HOL/Lab9
    ./start_swingbench.sh
    </copy>
    ```

    ![](./images/h25.png " ")

2. Go to the browser tab session of the Performance Metrics Server for *Atlanta* Deployment and select "*IREP1 > Database Statistics*" to validate

    ```
    <copy>https://<Your Public IP Address>/Atlanta/pmsrvr</copy>
    ```

    ![](./images/h26.png " ")

3. Go to the browser tab session of the Performance Metrics Server for *Boston* Deployment and select "*IREP > Database Statistics*" to validate

    ```
    <copy>https://<Your Public IP Address>/Boston/pmsrvr </copy>
    ```

    ![](./images/h27.png " ")

You may now *proceed to the next lab*

## Learn More

* [GoldenGate Microservices](https://docs.oracle.com/en/middleware/goldengate/core/19.1/understanding/getting-started-oracle-goldengate.html#GUID-F317FD3B-5078-47BA-A4EC-8A138C36BD59)

## Acknowledgements
* **Author** - Madhu Kumar S., Data Integration, December 2020
* **Contributors** - Brian Elliott, Meghana Banka, Rene Fontcha
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
