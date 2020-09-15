# Start a Docker Container

## Introduction

A Docker container is a running instance of a Docker image. However, unlike in traditional virtualization with a type 1 or type 2 hypervisor, a Docker container runs on the kernel of the host operating system. Within a Docker container, there is no separate operating system.

Estimated Lab Time: 10 minutes

### Objectives
This lab walks you through the steps to start the Docker container and Oracle Database 19c instance.


### Prerequisites

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* SSH keys
* A Docker image built with Oracle Database 19c

## **STEP 1**: Start the Docker container

Once the Docker image build is complete, you can start and run the Oracle Database inside a Docker container using the `docker run` command. There a few important parameters:
- The **`-p`** parameter maps ports inside the container to the outside world. We need to map port 1521 to enable access to the database.
- The **`-v`** parameter allows data files created by the database to exist outside of the Docker container. This separation means that even if the container is destroyed, the data files will be preserved. You should always use the `-v` parameter and create a named Docker volume.
- The **`--name`** parameter specifies the name of the container. Starting and stopping the container requires the container name as a parameter. If you omit this parameter, a random name is generated.

1. If you don't have an open SSH connection to your compute instance, open a terminal window. Navigate to the folder where you created the SSH keys and connect using the public IP address of your compute instance:

    ```
    $ <copy>ssh -i ./myOracleCloudKey opc@&lt;your IP address&gt;</copy>
    Enter passphrase for key './myOracleCloudKey':
    [opc@oraclelinux77 ~]$
    ```
2. Create a docker volume to hold the data files:

    ```
    [opc@oraclelinux77 ~]$ <copy>docker volume create oradata</copy>
    oradata
    [opc@oraclelinux77 ~]$
    ```
3. Run the Oracle Database container: (This may take around 30 minutes)

    ```
    [opc@oraclelinux77 ~]$ <copy>docker run --name oracle-ee -p 1521:1521 -v oradata:/opt/oracle/oradata oracle/database:19.3.0-ee</copy>
    ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN: N2z6X3FBa08=1

    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 07-APR-2020 19:58:10

    Copyright (c) 1991, 2019, Oracle.  All rights reserved.

    Starting /opt/oracle/product/19c/dbhome_1/bin/tnslsnr: please wait...

    TNSLSNR for Linux: Version 19.0.0.0.0 - Production
    System parameter file is /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
    Log messages written to /opt/oracle/diag/tnslsnr/dfd1c761d655/listener/alert/log.xml
    Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
    Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))

    Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=IPC)(KEY=EXTPROC1)))
    STATUS of the LISTENER
    ------------------------
    Alias                     LISTENER
    Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
    Start Date                07-APR-2020 19:58:11
    Uptime                    0 days 0 hr. 0 min. 1 sec
    Trace Level               off
    Security                  ON: Local OS Authentication
    SNMP                      OFF
    Listener Parameter File   /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
    Listener Log File         /opt/oracle/diag/tnslsnr/dfd1c761d655/listener/alert/log.xml
    Listening Endpoints Summary...
    (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
    (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))
    The listener supports no services
    The command completed successfully
    ...
    SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0
    The Oracle base remains unchanged with value /opt/oracle
    #########################
    DATABASE IS READY TO USE!
    #########################
    The following output is now a tail of the alert.log:
    ORCLPDB1(3):Completed: ALTER DATABASE DEFAULT TABLESPACE "USERS
    2020-04-07T20:18:55.253120+00:00
    ALTER SYSTEM SET control_files='/opt/oracle/oradata/ORCLCDB/control01.ctl' SCOPE=SPFILE;
    2020-04-07T20:18:55.267972+00:00
    ALTER SYSTEM SET local_listener='' SCOPE=BOTH;
     ALTER PLUGGABLE DATABASE ORCLPDB1 SAVE STATE
    Completed:    ALTER PLUGGABLE DATABASE ORCLPDB1 SAVE STATE
    2020-04-07T20:18:55.706902+00:00

    XDB initialized.
    2020-04-07T20:28:28.304983+00:00
    ORCLPDB1(3):Resize operation completed for file# 10, old size 327680K, new size 337920K
    ```
  At this point, the database is running and ready for connections!

  Note the startup script generated a password for the database accounts. In the next step, you can reset the password to one of your choice.

## **STEP 2**: Reset the Database admin accounts password

1. In a new terminal window, open another connection to compute instance:

    ```
    $ <copy>ssh -i ./myOracleCloudKey opc@</copy>123.123.123.123
    Enter passphrase for key './myOracleCloudKey':
    [opc@oraclelinux77 ~]$
    ```

2. Use the container provided `setPassword.sh` script to reset the password to `LetsDocker`:

    ```
    [opc@oraclelinux77 ~]$ <copy>docker exec oracle-ee ./setPassword.sh LetsDocker</copy>
    The Oracle base remains unchanged with value /opt/oracle

    SQL*Plus: Release 19.0.0.0.0 - Production on Thu Apr 9 18:14:33 2020
    Version 19.3.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0

    SQL>
    User altered.

    SQL>
    User altered.

    SQL>
    Session altered.

    SQL>
    User altered.

    SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0
    [opc@oraclelinux77 ~]$
    ```

  You may now *proceed to the next lab*.

## Want to Learn More?

* [Docker run command documentation](https://docs.docker.com/engine/reference/run/)

## Acknowledgements
* **Author** - Gerald Venzl, Master Product Manager, Database Development
* **Adapted for Cloud by** -  Tom McGinn, Sr. Principal Product Manager, Database and Database Cloud Service
* **Contributor** - Arabella Yao, Product Manager Intern, Database Management, June 2020
* **Last Updated By/Date** - Kamryn Vinson, March 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
