# Oracle Grid Infrastructure - Server-side Fast Application Notification Callouts

## Introduction

This lab walks you through the steps to demonstrate Oracle Clusterware’s FAN callout capability. Fast Application Notification, FAN, is a critical component towards solving the poor experience that end users can encounter when planned maintenance, unplanned outages, and load imbalances occur that make database instances unavailable or unresponsive. FAN enables end-to-end, lights-out recovery of applications and load balancing at runtime based on real transaction performance.

FAN is configured and runs automatically when you install Oracle Grid Infrastructure. All Oracle clients are FAN-aware and versions later than Oracle Database 12c Release 2 will auto-configure the FAN communication path. There is another lesson showing FAN at the application tier.

Estimated Lab Time: 20 Minutes
### Prerequisites

This lab assumes you have completed the following labs:
- Lab: Generate SSH Key
- Lab: Setup DB System
- Lab: Connected to database

### About FAN Callouts
FAN callouts provide a simple yet powerful integration mechanism available with RAC that can be deployed with minimal programmatic efforts. A FAN callout is a wrapper shell script or pre-compiled executable written in any programming language that is executed each time a FAN event occurs. The purpose of the FAN callout is for simple logging, filing tickets and taking external actions. The purpose of the callout is not for integrated client failover –The FAN client failover is Fast Connection Failover in the next section. With the exception of node and network events (which act on all nodes), a FAN callout executes for the FAN events that are generated locally to each node and thus only for actions affecting resources on that node


For more information about FAN view the technical paper https://www.oracle.com/technetwork/database/options/clustering/applicationcontinuity/learnmore/fastapplicationnotification12c-2538999.pdf

## **Step 1:**  Write a callout

1. On each node (node 1 and node 2), as the grid user, change in to the **racg/usrco** directory under the GI home
    ````
    <copy>
    sudo su - grid
    cd /u01/app/19.0.0.0/grid/racg/usrco/
    </copy>
    ````
2. Create a file named **callout-log.sh** using an editor \(vim and vi are installed\). Add the following lines to this file:

    ````
    <copy>
    #!/usr/bin/bash
    umask 022
    FAN_LOGFILE=/tmp/`hostname -s`_events.log
    echo $* " reported = "`date` >> ${FAN_LOGFILE} &
    </copy>
    ````
This callout will, whenever a FAN event is generated, place an entry in the logfile (FAN_LOGFILE) with the time (date) the event was generated.

3. Ensure that the callout file has the execute bit set

    ````
    chmod +x /u01/app/19.0.0.0/grid/racg/usrco/callout-log.sh
    ````

    ````
   [grid@racnode2 usrco]$ chmod +x callout-log.sh
   [grid@racnode2 usrco]$ ls -al
   total 12
   drwxr-xr-x 2 grid oinstall 4096 Aug 17 10:14 .
   drwxr-xr-x 6 grid oinstall 4096 Aug 14 04:55 ..
   -rwxr-xr-x 1 grid oinstall  118 Aug 17 10:14 callout-log.sh
    ````
Ensure that the callout directory has write permissions only to the system user who installed Grid Infrastructure (in our case, grid), and that each callout executable or script contained therein has execute permissions only to the same Grid Infrastructure owner. Each shell script or executable has to be able to run when called directly with the FAN payload as arguments.

4. Create this file on the other node
    ````
    [grid@racnode1 usrco]$ ls -al
    total 12
    drwxr-xr-x 2 grid oinstall 4096 Aug 17 10:26 .
    drwxr-xr-x 6 grid oinstall 4096 Aug 14 04:47 ..
    -rwxr-xr-x 1 grid oinstall  119 Aug 17 10:26 callout-log.sh

    ````

## **Step 2** Perform an action that will generate an event

1. Stopping or starting a database instance, or a database service will generate a FAN event. A failure of an instance, a node, or a public network will generate an event.

Stop the database instance on node1 using srvctl

    ````
    <copy>
    /u01/app/oracle/product/19.0.0.0/dbhome_1/bin/srvctl stop instance -d aTFdbVm_mel1nk -i aTFdbVm1
    </copy>
    ````
2. Check the instance status

    ````
    <copy>
    /u01/app/oracle/product/19.0.0.0/dbhome_1/bin/srvctl stop instance -d aTFdbVm_mel1nk -i aTFdbVm1
    </copy>
    ````

    ````
    [oracle@racnode1 ~]$ /u01/app/oracle/product/19.0.0.0/dbhome_1/bin/srvctl status database -d aTFdbVm_mel1nk
    Instance aTFdbVm1 is not running on node racnode1
    Instance aTFdbVm2 is running on node racnode2
    ````

3. If your callout was written correctly and had the appropriate execute permissions, a file named racnode1_events.log should be visible in the /tmp directory
    ````
    <copy>
    ls -altr /tmp/racnode*.log
    </copy>
    ````

    ````
    [oracle@racnode1 ~]$ ls -altr /tmp/racnode*.log
    -rw-r--r-- 1 grid oinstall 600 Aug 17 10:41 /tmp/racnode1_events.log
    ````
4. Examine the contents of the racnode*xx*_events.log file

    ````
    <copy>
    cat /tmp/racnode*.log
    <copy>
    ````
Depending on which instance you stopped you will see an entry similar to the following:

    ````
    INSTANCE VERSION=1.0 service=atfdbvm_mel1nk.tfexsubdbsys.tfexvcndbsys.oraclevcn.com database=atfdbvm_mel1nk instance=aTFdbVm1 host=racnode1 status=down reason=USER timestamp=2020-08-17 10:41:07 timezone=+00:00 db_domain=tfexsubdbsys.tfexvcndbsys.oraclevcn.com  reported = Mon Aug 17 10:41:07 UTC 2020
    ````

This is an **INSTANCE** event, a stop event as **reason=down**, it occurred on the **host=racnode1** and it was user initiated via **reason=USER**.

Note that there will be no entry for this event on **racnode2** as most events are local to the host on which they occur. The exceptions are node and network events which will generate an identical entry on all nodes in the cluster.

If you did not get an entry similar to the above there is a problem with your script. Execute the script directly and correct any errors. For example:

    ````
    sh -x /u01/app/19.0.0.0/grid/racg/usrco/callout-log.sh  ABC
    ````
will produce a detailed execution of each line such as, for example:
    ````
    [grid@racnode1 usrco]$ sh -x callout-log.sh GGG
    + umask 022
    ++ hostname -s
    + FAN_LOGFILE=/tmp/racnode1_events.log
    [grid@racnode1 usrco]$ ++ date
    + echo GGG ' reported = Mon' Aug 17 10:36:25 UTC 2020
    callout-log.sh: line 4: /tmp/racnode1_events.log: syntax error: operand expected (error token is "/tmp/racnode1_events.log")
    ````
This attempt shows an error on line 4 of the file (the append to the log). In this case it was the wrong type of bracket. Other mistakes will produce different errors.

## **Step 3** Create a more elaborate callout

1. Callouts can be any shell-script or executable. There can be multiple callouts in the racg/usrco directory and all will be executed with the FAN payload as arguments. The scripts are executed sequentially, so it is not recommended to have many scripts in this directory, as they could place a load on the system that is not desired, and there may be timeliness issues if the scripts wait for scheduling.

A script may perform actions related to the eventtype. **eventtype** can be one of SERVICE, SERVICEMEMBER, INSTANCE, DATABASE  or NODE

The following example will filter on the eventtype looking for a NODE, DATABASE or SERVICE event. If the FAN payload indicates a DOWN event for these eventypes it will perform a different action than for all other events.

    ````
    <copy>
    #!/usr/bin/bash
    # Scan and parse HA event payload arguments:
    #
    # define AWK
    AWK=/bin/awk
    # Define a log file to see results
    FAN_LOGFILE=/tmp/`hostname -s`_callout2.log
    # Event type is handled differently
    NOTIFY_EVENTTYPE=$1
    for ARGS in $*; do
        PROPERTY=`echo $ARGS | $AWK -F "=" '{print $1}'`
        VALUE=`echo $ARGS | $AWK -F "=" '{print $2}'`

        case $PROPERTY in
          VERSION|version) NOTIFY_VERSION=$VALUE ;;
          SERVICE|service) NOTIFY_SERVICE=$VALUE ;;
          DATABASE|database) NOTIFY_DATABASE=$VALUE ;;
          INSTANCE|instance) NOTIFY_INSTANCE=$VALUE ;;
          HOST|host) NOTIFY_HOST=$VALUE ;;
          STATUS|status) NOTIFY_STATUS=$VALUE ;;
          REASON|reason) NOTIFY_REASON=$VALUE ;;
          CARD|card) NOTIFY_CARDINALITY=$VALUE ;;
          VIP_IPS|vip_ips) NOTIFY_VIPS=$VALUE ;; #VIP_IPS for public_nw_down
          TIMESTAMP|timestamp) NOTIFY_LOGDATE=$VALUE ;; # catch event date
          TIMEZONE|timezone) NOTIFY_TZONE=$VALUE ;;
          ??:??:??) NOTIFY_LOGTIME=$PROPERTY ;; # catch event time (hh24:mi:ss)
        esac
    done

    # FAN events with the following conditions will be inserted# into the critical trouble ticket system:
    # NOTIFY_EVENTTYPE => SERVICE | DATABASE | NODE
    # NOTIFY_STATUS => down | public_nw_down | nodedown
    #
    if (( [ "$NOTIFY_EVENTTYPE" = "SERVICE" ] ||[ "$NOTIFY_EVENTTYPE" = "DATABASE" ] || \
        [ "$NOTIFY_EVENTTYPE" = "NODE" ] \
        ) && \
        ( [ "$NOTIFY_STATUS" = "down" ] || \
        [ "$NOTIFY_STATUS" = "public_nw_down" ] || \
        [ "$NOTIFY_STATUS" = "nodedown " ] ) \
        ) ; then
        # << CALL TROUBLE TICKET LOGGING PROGRAM AND PASS RELEVANT NOTIFY_* ARGUMENTS >>
        echo "Create a service request as " ${NOTIFY_EVENTTYPE} " " ${NOTIFY_STATUS} " occured at " ${NOTIFY_LOGTIME} >> ${FAN_LOGFILE}
    else
        echo "Found no interesting event: " ${NOTIFY_EVENTTYPE} " " ${NOTIFY_STATUS} >> ${FAN_LOGFILE}
    fi
    </copy>
    ````
2. Cause the generation of a DATABASE DOWN event with srvctl

    ````
    <copy>
    /u01/app/oracle/product/19.0.0.0/dbhome_1/bin/srvctl stop database -d aTFdbVm_mel1nk
    </copy>
    ````

3. Examine the entry created in the log file generated in /tmp

On node1:

    ````
    cat /tmp/racnode1_callout2.log
    ````  
On node2:
    ````
    cat /tmp/racnode2_callout2.log
    ````
2. Cause a DATABASE UP event to be generated:

    ````
    <copy>
    /u01/app/oracle/product/19.0.0.0/dbhome_1/bin/srvctl start database -d aTFdbVm_mel1nk
    </copy>
    ````        
Note the different entries generated in each log (on each node)    

## **Step 4** Client-side FAN events

FAN events are sent to the application mid-tier or client tier using the Oracle Notification Service (ONS). ONS is configured automatically on the cluster when you install Grid Infrastructure. CRS manages the stop and start of the ONS daemon.

ONS is configured automatically by FAN-aware Oracle clients, which include Universal Connection Pool (UCP), ODP.Net, Weblogic Server with Active Gridlink, CMAN and others, when a particular format connect string is used (for more information on this refer to the Application Continuity checklist: https://www.oracle.com//technetwork/database/clustering/checklist-ac-6676160.pdf)

In order to determine if a client has received FAN events may require running your client in a debug fashion. This may be difficult to do and even more difficult to interpret.

To confirm that FAN events are being received at a particular tier, you can install a java utility called FANWatcher, that will subscribe to ONS on a cluster and display events that it receives.

Download the FANWatcher utility
1. Open a terminal on one of the nodes using Putty or CYGWIN

2. Become the "oracle" user and create a directory named fanWatcher

    ````
    <copy>
    sudo su - oracle
    mkdir -p /home/oracle/fANWatcher
    cd /home/oracle/fANWatcher
    </copy>
    ````
3. Download the fanWatcher utility and unzip the file

    ````
    wget
    https://objectstorage.uk-london-1.oraclecloud.com/p/gKfwKKgzqSfL4A48e6lSKZYqyFdDzvu57md4B1MegMU/n/lrojildid9yx/b/labtest_bucket/o/fanWatcher_19c.zip
    unzip fanWatcher_19c.zip
    ````    
    ![](./images/clusterware-4.png " ")

4. Create a database user in the PDB **pdb1** and a database service to connect to. The service should have 1 preferred instance and 1 available instance. In this example the service name is **testy** (choose a name you like), the instance names are as specified, the username is **test_user** and the password is **W3lcom3\#W3lcom3\#**

Create the service and start it
    ````
    <copy>
    /u01/app/oracle/product/19.0.0.0/dbhome_1/bin/srvctl add service -d aTFdbVm_mel1nk -s testy -pdb pdb1 -preferred aTFdbVm1 -available aTFdbVm2
    /u01/app/oracle/product/19.0.0.0/dbhome_1/bin/srvctl start service -d aTFdbVm_mel1nk -s testy
    </copy>
    ````
Connect to sqlplus as **SYS**
    ````
    </copy>
    /u01/app/oracle/product/19.0.0.0/dbhome_1/bin/sqlplus sys/W3lc0m3#W3lc0m3#@//racnode1/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com as sysdba
    </copy>
    ````    
and run the following commands:
    ````
    <copy>
    create user test_user identified by W3lcom3#W3lcom## default tablespace users temporary tablespace temp;
    alter user test_user quota unlimited on users;
    grant connect, resource, create session to test_user;
    </copy>
    ````    
5. Edit the **fanWatcher.bash** script entering the **user**, **password**, and **URL** you just created
Following the example shown the fanWatcher.bash script will look like:

    ````
    #!/usr/bin/bash
    ORACLE_HOME=/u01/app/oracle/product/19.0.0.0/dbhome_1
    JAVA_HOME=${ORACLE_HOME}/jdk
    export ORACLE_HOME
    export JAVA_HOME
    # Set the credentials in the environment. If you don't like doing this,
    # hardcode them into the java program
    # Edit the values for password, url, user and CLASSPATH
    password=W3lcom3#W3lcom3#
    url='jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=racnode1)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=racnode2)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=testy.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)))'
    user=test_user
    export password url user
    CLASSPATH="/u01/app/oracle/product/19.0.0.0/dbhome_1/jdbc/lib/ojdbc8.jar:/u01/app/oracle/product/19.0.0.0/dbhome_1/opmn/lib/ons.jar:."
    export CLASSPATH

    # Compile fanWatcher with the exported classpath
    #javac fanWatcher.java

    # Run fanwatcher with autoons
    ${JAVA_HOME}/jre/bin/java fanWatcher autoons
    # EOF
    ````
Note that the service name will be domain qualified (use the operating system utility **lsnrctl service** to confirm the service name registered with the listener).

6. Run the **fanWatcher.bash** script

    ````
    <copy>
    ./fanWatcher.bash
    </copy>
    ````

When fanWatcher is run with the argument **autoons** it will use the credentials and url provided to connect to the database (wherever it is running) and use that connection to obtain the ONS configuration of the DB system it is connected to. A subscription, to receive FAN events, is created with the Grid Infrastructure ONS daemon.

Connections to the ONS daemon on each node is established forming  redundant topology - with no knowledge of the cluster configuration required.

    ![](./images/clusterware-5.png " ")

7. Perform an action on another node that will generate a FAN event. Kill a SMON background process
For example, on node2 in my system

    ````
    <copy>
    ps -ef | grep smon
    </copy>
    ````     
will show the SMON process ids for ASM and my database
    ![](./images/clusterware-6.png " ")
choose the process id for
   ````
   oracle   31138     1  0 06:39 ?        00:00:00 ora_smon_aTFdbVm2
   ````
The process id in this example is 31138. Your process id will be a different number

    ````
    sudo kill -9 31138
    ````   
    ![](./images/clusterware-7.png " ")        

8. Look at the output from the fanWatcher utility

    ![](./images/clusterware-8.png " ")

The fanWatcher utility has received FAN events over ONS. The first event shows **reason=FAILURE** highlighting the abnormal termination of SMON (by the operating system kill command). **event_type=INSTANCE** and **status=down** shows that the instance has crashed.

The event payload contains the same information as displayed in the CALLOUT example you observed, but there are some differences. All Oracle clients are FAN-aware and interpret the FAN events automatically.

You will also see the failed instance get restarted by Grid Infrastructure, and the corresponding **UP** event is sent. Oracle clients, such as UCP, will react to both UP and DOWN events - closing connections on down and re-establishing them automatically on UP.

    ````

    ** Event Header **
    Notification Type: database/event/service
    Delivery Time: Tue Aug 18 08:54:51 UTC 2020
    Creation Time: Tue Aug 18 08:54:51 UTC 2020
    Generating Node: racnode2
    Event payload:
    VERSION=1.0 event_type=INSTANCE service=atfdbvm_mel1nk.tfexsubdbsys.tfexvcndbsys.oraclevcn.com instance=aTFdbVm2 database=atfdbvm_mel1nk db_domain=tfexsubdbsys.tfexvcndbsys.oraclevcn.com host=racnode2 status=down reason=FAILURE timestamp=2020-08-18 08:54:51 timezone=+00:00

    ** Event Header **
    Notification Type: database/event/service
    Delivery Time: Tue Aug 18 08:55:26 UTC 2020
    Creation Time: Tue Aug 18 08:55:26 UTC 2020
    Generating Node: racnode2
    Event payload:
    VERSION=1.0 event_type=INSTANCE service=atfdbvm_mel1nk.tfexsubdbsys.tfexvcndbsys.oraclevcn.com instance=aTFdbVm2 database=atfdbvm_mel1nk db_domain=tfexsubdbsys.tfexvcndbsys.oraclevcn.com host=racnode2 status=up reason=FAILURE timestamp=2020-08-18 08:55:25 timezone=+00:00

    ````
If fanWatcher can auto-configure with ONS and receive and display events, so can any client on the same tier. This validates the communication path (no firewall blockage for example), and that FAN events are propagating correctly. 

## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** -
* **Last Updated By/Date** - Troy Anthony, Database Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
