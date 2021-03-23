# Initialize Environment

## Introduction

In this part you’ll generate application load on the UPGR database before upgrade. You will use an external load tool, HammerDB.  In a later stage we’ll compare statements and overall performance before/after upgrade.  You can use your own load scripts as well.

*Estimated Lab Time:* 30 Minutes.

### About AWR Snapshots
The Automatic Workload Repository (AWR) collects, processes, and maintains performance statistics for problem detection and self-tuning purposes. This data is both in memory and stored in the database. The gathered data can be displayed in both reports and views.

The statistics collected and processed by AWR include:
- Object statistics that determine both access and usage statistics of database segments
- Time model statistics based on time usage for activities, displayed in the `V$SYS_TIME_MODEL` and `V$SESS_TIME_MODEL` views
- Some of the system and session statistics collected in the `V$SYSSTAT` and `V$SESSTAT` views
- SQL statements that are producing the highest load on the system, based on criteria such as elapsed time and CPU time
- ASH statistics, representing the history of recent sessions activity

Snapshots are sets of historical data for specific time periods that are used for performance comparisons by ADDM. By default, Oracle Database automatically generates snapshots of the performance data once every hour and retains the statistics in the workload repository for 8 days. You can also manually create snapshots. In this lab we will manually create snapshots.

### Objectives

In this lab, you will:
- Validate the environment
- Generate an AWR snapshot
- Start HammerDB
- Load Driver Script and start virtual users
- Capture SQL, load test and monitor
- Generate another AWR snapshot

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup

## **Step 0**: Running your Lab
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

3. Review the desktop. Important shortcuts have been placed on the desktop for your convenience.

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

## **Step 1**: Validate the environment
1. As user *oracle* from any of the sessions started above, verify that the DB listener and all databases are up and running.

    The host is preconfigured to automatically start a database listener and 4 databases upon startup.

    ```
    <copy>
    ps -ef|grep LISTENER|grep -v grep
    ps -ef|grep ora_|grep pmon|grep -v grep
    systemctl status oracle-database
    </copy>
    ```
    ![](./images/check-tns-up.png " ")
    ![](./images/check-pmon-up.png " ")
    ![](./images/check-db-service-up.png " ")

2. Click on *SQLDeveloper* icon on the desktop to Launch

    ![](./images/sqldeveloper-1.png " ")

3. On the connection panel on the left, click the *+* sign next to each of the following databases to confirm that you can connect.
    - UPGR
    - FTEX
    - DB12
    - CDB2

    ![](./images/sqldeveloper-2.png " ")

## **Step 2**: Generate an AWR snapshot

1. Switch the environment to UPGR using *`. upgr`*, change directory to /home/oracle/scripts and start SQL*Plus:

    ```
    <copy>
    . upgr
    cd /home/oracle/scripts
    sqlplus / as sysdba
    </copy>
    ```
    ![](./images/upgrade_19c_1.png " ")

2.  Execute snap.sql which generates an AWR snapshot.  Please NOTE down the snapshot number (e.g.: 110)

    ```
    <copy>
    @/home/oracle/scripts/snap.sql
    </copy>
    ```
    ![](./images/upgrade_19c_2.png " ")

3. Don’t exit from the terminal or SSH session. Keep SQL*Plus open.

4. On the remote desktop session, Double-Click on the *HammerDB* icon on the desktop to Launch it
    ![](./images/upgrade_19c_3.png " ")

## **Step 3**: Load Driver Script and start Virtual Users

1. Click on the triangle “TPC-C“:
2. Open the Driver Script setup with a Click:
3. Then Double-Click on the Load option.
4. This will populate the script window with the driver script (ignore the error messages in the script window):
5. Click on Virtual Users.  Now Double-Click on Create – you should see then 3 Virtual Users being started below the script window:
   ![](./images/upgrade_19c_4.png " ")

## **Step 4**: Capture SQL, Load Test and Monitor

Please start the following script in your SQL*plus window. With this script you’ll capture now all SQL Statements directly from cursor cache while HammerDB is running and generating load on your database.

1. Run the capture script. The capture is scheduled for 240 seconds. It polls the cache every 10 seconds.

    ```
    <copy>
    @/home/oracle/scripts/capture_cc.sql
    </copy>
    ```
    ![](./images/upgrade_19c_5.png " ")

2. Start TPC-C Load Test and Monitor the progress by double clicking on the Run icon:
    ![](./images/upgrade_19c_6.png " ")

3. Click on the Graph / Transaction Counter icon in the top menu icon bar. You’ll see that the script window changes now waiting for data.

4. It takes a few seconds, then you’ll see the performance charts and the transactions-per-minute (tpm). The load run usually takes 2-3 minutes until it completes:
    ![](./images/upgrade_19c_7.png " ")
    ![](./images/upgrade_19c_8.png " ")

5. Note the Complete=1 per Virtual User underneath the graph.  We will use this load only to generate some statements.

6. Finally Exit HammerDB:


## **Step 5**: Generate another AWR snapshot

Please WAIT until the capture_cc.sql scripts returns control back to you – DON’T CTRL-C it!

1. In the existing sqlplus create another AWR snapshot once the command prompt is visible execute the sql script below.  Please NOTE down the snapshot number (e.g. 111).

    ```
    <copy>
    @/home/oracle/scripts/snap.sql
    </copy>
    ```
    ![](./images/upgrade_19c_9.png " ")

## Appendix 1: Additional Information on HammerDB

You can modify the standard parameters in either the GUI tool or as defaults in config.xml located in `/home/oracle/HammerDB-3.3`

You may now [proceed to the next lab](#next).

## Learn More

* [HammerDB](https://www.hammerdb.com/)
* [AWR Snapshots](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgdba/gathering-database-statistics.html#GUID-144711F9-85AE-4281-B548-3E01280F9A56)

## Acknowledgements
* **Author** - Mike Dietrich, Database Product Management
* **Contributors** -  Roy Swonger, Kay Malcolm, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, March 2021

