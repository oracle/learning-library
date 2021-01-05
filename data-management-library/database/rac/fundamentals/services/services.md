# Services

## Introduction
This lab walks you through the steps to demonstrate many of the capabilities of Oracle Database services.

Estimated Lab Time: 20 Minutes

### Prerequisites
- An Oracle LiveLabs or Paid Oracle Cloud account
- Lab: Generate SSH Key
- Lab: Build a DB System
- Lab: Fast Application Notification
- Lab: Install Sample Schema

### About Oracle Database services

Services represent groups of applications with common attributes, service level thresholds, and priorities. Application functions can be divided into workloads identified by services. You can also group work by type under services. For example, online users can use one service, while batch processing can use another and reporting can use yet another service to connect to the database.

A service can span one or more instances of an Oracle database, multiple databases in a global cluster, and a single instance can support multiple services.  The number of instances that are serving the service is transparent to the application. Services provide a single system image to manage competing applications, and allow each workload to be managed as a single unit.

Response time and CPU consumption metrics, performance and resource statistics, wait events, threshold based alerts, and performance indexes are maintained by the Automatic Workload Repository automatically for all services.  Service, module and action tags are used to identify operations within a service at the server. (MODULE and ACTION are set by the application) End to end monitoring enables aggregation and tracing at Service, Module and Action levels to identify the high load operations. Oracle Enterprise Manager administers the service quality thresholds for response time and CPU consumption, monitors the top services, and provides drill down to the top modules and top actions per service.

Connect time routing and runtime routing algorithms balance the workload across the instances offering a service. RAC use services to enable uninterrupted database operations. Planned operations are supported through interfaces that allow the relocation or disabling/enabling of services.

Application Continuity is set as an attribute of a service.

Oracle recommends that all users who share a service have the same service level requirements. You can define specific characteristics for services and each service can represent a separate unit of work. There are many options that you can take advantage of when using services. Although you do not have to implement these options, using them helps optimize application operation and performance.

For more information on Oracle Database Services visit http://www.oracle.com/goto/ac

 [](https://youtu.be/dIMgaujSydQ)

## **STEP 1:** Login and Identify Database and Instance names
You should have already identified your database name and instance name.  Each place in this lab where you see replacename make sure you use your correct instance and database names. 
1.  If you aren't already logged in to the Oracle Cloud, open up a web browser and re-login to Oracle Cloud. 
2.  Once you are logged in, open up a 2nd webbrowser tab.
3.  Start Cloudshell in each.  Maximize both cloudshell instances.
   
    *Note:* You can also use Putty or MAC Cygwin if you chose those formats in the earlier lab.  
    ![](../clusterware/images/start-cloudshell.png " ")

4.  Connect to node 1 as the *opc* user (you identified the IP address of node 1 in the Build DB System lab). 

    ````
    ssh -i ~/.ssh/sshkeyname opc@<<Node 1 Public IP Address>>
    ````
    ![](../clusterware/images/racnode1-login.png " ")

5. Repeat this step for node 2.
   
    ````
    ssh -i ~/.ssh/sshkeyname opc@<<Node 2 Public IP Address>>
    ps -ef | grep pmon
    ````
    ![](./clusterware/images/racnode2-login.png " ")  

6. Run the command to determine your database name and additional information about your cluster on **node 1**.  Run this as the *grid* user.

    ````
    <copy>
    sudo su - grid
    crsctl stat res -t
    </copy>
    ````
    ![](./../clusterware/images/crsctl-1.png " ")

    ![](./../clusterware/images/crsctl-2.png " ")
    
7. Find your database name in the *Cluster Resources* section with the *.db*.  Jot this information down, you will need it for this lab. 

    ![](./images/db-crsctl.png " ")
8. Confirm that you have the *testy* service running and note the node it is running on.

    ![](./images/testy-crsctl.png " ")

## **STEP 2:**  Create a Service

**NOTE** For simplicity we will often use the EZConnect syntax to specify connect strings to the database:

user/password@**//hostname:port/servicename**  EZConnect does not support all service characteristics. A fully specified URL or TNS Connect String is required for Application Continuity and other service characteristics.  

1.  Create a new service **svctest** with *instance1* as a **preferred** instance and *instance2* as an **available instance**. This means that the service will normally run on the *instance1* but will failover to *instance2* if the first instance becomes unavailable.  Run this on node 1.

    *Note:* Remember to replace all instances of *aTFdbVm_replacename* with the database name you identified in Step 1.

    ````
    <copy>
    sudo su - oracle
    srvctl add service -d aTFdbVm_replacename -s svctest -preferred aTFdbVm1 -available aTFdbVm2 -pdb pdb1
    srvctl start service -d aTFdbVm_replacename -s svctest
    </copy>
    ````
    ![](./images/lab6-step1-num6.png " ")

7. Examine where the service is running by using **lsnrctl** to check the SCAN listener or a local listener on each node. **srvctl** will also show you where the service is running.

    ````
    <copy>
    srvctl status service -d aTFdbVm_replacename -s svctest
    </copy>
    ````
    ![](./images/lab6-step1-num7.png " ")

8.  Use the lsnrctl utility to list the services on both **node 1** and **node 2** as the *grid* user.
    ````
    <copy>
    lsnrctl services
    </copy>
    ````
    ![](./images/lsnrctl-node1.png " ")
    ![](./images/lsnrctl-node2.png " ")


    Note that this service is only active on one instance at a time, so both **local** listeners will not include an entry for this service. In the example shown here, the listener on racnode2 would **not** have an entry for **Service "svctest.tfexsubdbsys.tfexvcndbsys.oraclevcn.com"*

9.  Any of the SCAN listeners will show where the service is offered. Note that SCAN Listeners run from the GI HOME so you have to change the ORACLE_HOME environment variable in order to view the information about the SCAN Listeners.  Run the lsnrctl command below on **node 2** as the *grid*.

    ````
    <copy>
    export ORACLE_HOME=/u01/app/19.0.0.0/grid
    $ORACLE_HOME/bin/lsnrctl service LISTENER_SCAN2
    </copy>
    ````
    ![](./images/scan-node2.png " ")

10. Repeat it on **node 1** as well.

    ![](./images/scan-node1.png " ")


## **STEP 3:** Service Failover

1. Cause the service to fail over. After identifying which instance the service is being offered on, kill that instance by removing the SMON process at the operating system level.  Run this on **node 1**

    ````
    <copy>
    ps -ef | grep ora_smon
    </copy>
    ````
    This will show the SMON process id of your database  
    ![](./images/lab6-step2-num1.png " ")
    ![](./images/lab6-step2-num1-1.png " ")


2. In this example the process ID is 585689, which I can pass to the **kill -9 <process id>** command.  Identify your process id and issue the kill command as the *oracle* user

    ````
    sudo kill -9 ######
    ````

    This will cause the instance to fail, any connections to the database on this instance would be lost. The CRS component of Grid Infrastructure would detect the instance failure, and immediately start the service on an **available** instance (based on the service definition). CRS would then restart the database instance.

3. Rerun the *srvctl status service* command and notice that the service has failed over to the other instance:

    ````
    <copy>
    srvctl status service -d aTFdbVm_replacename -s svctest
    </copy>
    ````

    Depending on where your service was running beforehand, you will notice something similar to

    ![](./images/lab6-step2-num3.png " ")

4. Manually relocate the service. Open a connection (with SQL*Plus) to the instance where the service is running. Use the SCAN address and the domain qualified service name in the format:

    ````
    **sqlplus user/password@//SCAN Address Name/service-name**
    ````
5. Connect via sqlplus and replace the password with the password you chose for your cluster.
   
    ````
     sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/svctest.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    ````
    ![](./images/lab6-step2-num5-2.png " ")


6. Using a different cloud shell window (connected to either node) open a SQL*Plus connection as SYS to the PDB associated with this service

    ````
    sqlplus sys/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com as sysdba
    ````
    and run the following SQL statement

    ````
    <copy>
    set wrap off
    col service_name format  a20
    select inst_id, service_name, count(*) from gv$session where service_name = 'svctest' group by inst_id, service_name;
    exit
    </copy>
    ````
    This statement will show you the instance this service is running and the number of open connections on this service. 
    
    ![](./images/lab6-step2-num6.png " ")


7. Relocate the service using srvctl.  Execute the command on **node 2**

    ````
    <copy>
     srvctl relocate service -d aTFdbVm_replacename -s svctest -oldinst aTFdbVm2 -newinst aTFdbVm1
    </copy>
    ````
    which will move the service from one instance to another:

    ![](./images/lab6-step3-num7.png " ")

    Re-examine the v$session information:

    ````

    SQL> /
    INST_ID     SERVICE_NAME         COUNT(*)
    ---------- -------------------- ----------
       1         svctest                1
    ````
    It has not changed.
    The relocate service command will not disconnect active sessions unless a force option (**-force**) is specified. A stop service command will allow a drain timeout to be specified to allow applications to complete their work during the drain interval.

## **STEP 4:** Connection Load Balancing
This exercise will demonstrate connection load balancing and why it is important to use the SCAN address and the VIPs as integral parts of your connection strategy

1. Create a uniform service, named *unisrv*, that is **available** on both instances of your RAC database.  Execute this on **node 1**

    ````
    <copy>
    srvctl add service srvctl add service -d aTFdbVm_replacename -s unisrv -preferred aTFdbVm1,aTFdbVm2 -pdb pdb1
    srvctl start service -d aTFdbVm_replacename -s unisrv
    </copy>
    ````
    ![](./images/lab6-step3-num1.png " ")

2. Look at the entry for this server in the **lsnrctl service LISTENER_SCAN2** output. Note that any of the SCAN listeners can be used here.  Run this on **node 2** as the *oracle* user

    ````
    <copy>
    export ORACLE_HOME=/u01/app/19.0.0.0/grid
    $ORACLE_HOME/bin/lsnrctl service LISTENER_SCAN2
    </copy>
    ````
where you will see similar to:

    ![](./images/lab6-step3-num2.png " ")

    You should notice that an entry for this service is configured for each instance.

1. Set your oracle environment and ddit your tnsnames.ora file (in $ORACLE_HOME/network/admin wherever you are running your client connections from). 
   
   ````
   . oraenv
   <<Press enter>>
   /u01/app/oracle/product/19.0.0.0/dbhome_1
   vi $ORACLE_HOME/network/admin/tnsnames.ora
   ````
   ![](./images/oraenv.png " ")

   ![](./images/tnsnames-1.png " ")


2. Add the following two entries.  Click **:wq!** to save.

    *Note:* that these tnsnames entries do not comply with the recommended format for continuous availability. They are only used to be illustrative of connection load balancing (CLB)

    ````
    <copy>
    CLBTEST = (DESCRIPTION =
       (ADDRESS = (PROTOCOL = TCP)(HOST = racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)(PORT = 1521))
       (LOAD_BALANCE = no) (FAILOVER = yes)
       (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = unisrv.tfexsubdbsys.tfexvcndbsys.oraclevcn.com) ) )


    CLBTEST-LOCAL = (DESCRIPTION =
        (LOAD_BALANCE = on) (FAILOVER = off)
        (ADDRESS = (PROTOCOL = TCP)(HOST = racnode1)(PORT = 1521))
        (ADDRESS = (PROTOCOL = TCP)(HOST = racnode2)(PORT = 1521))
        (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = unisrv.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)))
    </copy>
    ````

    ![](./images/tnsnames-2.png " ")

3. Create 10 connections using the alias CLBTEST and look at where the connections were established

    ````
    SQL> select inst_id, service_name, count(*) from gv$session where service_name = 'unisrv' group by inst_id, service_name;

    INST_ID SERVICE_NAME             COUNT(*)
    ---------- -------------------- ----------
         1     unisrv                   4
         2     unisrv                   4

    ````
    ![](./images/sqlplus-1.png " ")


    The SCAN listener attempts to distribute connections based on SESSION COUNT by default. The connections will not always end up equally balanced across instances. You can instruct the listener to use the load on an instance to balance connection attempts (the listener will store run queue information), but this is not the default.

4. Now do the same with the CLBTEST-LOCAL alias (close the first sessions as it will make it easier to illustrate what happens)

    ````  
    INST_ID     SERVICE_NAME          COUNT(*)
    ---------- -------------------- ----------
         1      unisrv                   8
         2      unisrv                   2
    ````
    This second case illustrates client-side load balancing. The TNS alias defined, through FAILOVER=ON, instructs an address to be selected at random from the available ADDRESS entries. There is no guarantee of connection balancing. If you disable load balancing \(FAILOVER=OFF\), then the addresses will be tried sequentially until one succeeds. In the case where all instances are available all connections will go to the first ADDRESS in the list:

    ````
    INST_ID    SERVICE_NAME           COUNT(*)
    ---------- -------------------- ----------
      1         unisrv                   10
    ````
5. What if an instance is not available?  Shutdown one of the instances with srvctl - specify \"-f\" as you want to forcibly close services if any are running.
    ````
    <copy>
    srvctl stop instance -d aTFdbVm_replacename -i aTFdbVm2 -f
    exit
    </copy>
    ````

6. Attempt to use the CLBTEST-LOCAL alias to connect as the *oracle* user on **node 1**.  Remember to replace the password with the database password you chose when you provisioned the instance. If the ADDRESS to the instance you just stopped is chosen, you will see the foll
   
   ````
   sudo su - oracle


    ````
    [oracle@racnode1 ~]$ $ORACLE_HOME/bin/sqlplus sh/W3lc0m3#W3lc0m3#@CLBTEST-LOCAL
    SQL*Plus: Release 19.0.0.0.0 - Production on Mon Aug 24 08:34:32 2020
    Version 19.7.0.0.0
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    ERROR:
    ORA-12514: TNS:listener does not currently know of service requested in connect descriptor
    Enter user-name:
    ````
    This address could be repeatedly tried \(it is a random access\)    

    The CLBTEST alias uses the SCAN address and will only send requests to the available instances

    ````
    [oracle@racnode1 ~]$ $ORACLE_HOME/bin/sqlplus sh/W3lc0m3#W3lc0m3#@CLBTEST
    SQL*Plus: Release 19.0.0.0.0 - Production on Mon Aug 24 08:38:56 2020
    Version 19.7.0.0.0
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.
    Last Successful login time: Mon Aug 24 2020 08:37:33 +00:00

    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0
    SQL>
    ````
7. The recommended connect string for all Oracle Drivers of version 12.2 or later is:

    ````
    Alias (or URL) = (DESCRIPTION =
   (CONNECT_TIMEOUT=90)(RETRY_COUNT=20)(RETRY_DELAY=3)(TRANSPORT_CONNECT_TIMEOUT=3)
   (ADDRESS_LIST =(LOAD_BALANCE=on)
      (ADDRESS = (PROTOCOL = TCP)(HOST=primary-scan)(PORT=1521)))
   (ADDRESS_LIST =(LOAD_BALANCE=on)
      (ADDRESS = (PROTOCOL = TCP)(HOST=secondary-scan)(PORT=1521)))
   (CONNECT_DATA=(SERVICE_NAME = gold-cloud))
    ````    
    This is showing how a RAC and Data Guard environment would be specified. The assumption is that both the PRIMARY and SECONDARY sites are clustered environments, hence specifying a SCAN ADDRESS for each one.

    Oracle recommends the connection string configuration for successfully connecting at failover, switchover, fallback and basic startup. Set RETRY_COUNT, RETRY_DELAY, CONNECT_TIMEOUT and TRANSPORT_CONNECT_TIMEOUT parameters in the tnsnames.ora file or in the URL to allow connection requests to wait for service availability and connect successfully. Use values that allow for your RAC and Data Guard failover times.

8.  Update your tnsnames.ora file to specify a configuration similar to that below. This connect string will be used in later labs
    ````
    <copy>
    vi /u01/app/oracle/product/19.0.0.0/dbhome_1/network/admin/tnsnames.ora
    </copy>
    ````

    ````
    <copy>
    RECSRV=(DESCRIPTION =
   (CONNECT_TIMEOUT=90)(RETRY_COUNT=20)(RETRY_DELAY=3)(TRANSPORT_CONNECT_TIMEOUT=3)
   (ADDRESS_LIST =(LOAD_BALANCE=on)
      (ADDRESS = (PROTOCOL = TCP)(HOST=racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)(PORT=1521)))
   (CONNECT_DATA=(SERVICE_NAME = testy.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)))
   </copy>
    ````

     ![](./images/tnsnames-3.png " ")
   
11. Verify you can connect using this alias.

You may now *proceed to the next lab*.  

## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** - Kay Malcolm
* **Last Updated By/Date** - Kay Malcolm, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
