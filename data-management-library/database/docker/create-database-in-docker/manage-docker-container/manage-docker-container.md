# Manage a Docker Container
## Before You Begin

This lab walks you through the steps to manage your Docker container, including stopping and restarting the container and reviewing container logs.

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* SSH keys
* A Docker container running Oracle Database 19c

## **STEP 1**: Stopping a Docker container

 You can stop the Docker container using the docker `stop` command with the container name or id. The stop command triggers the container to issue a immediate shutdown  for the database inside the container. By default, Docker will only allow 10 seconds for the container to shutdown before killing it. For applications that may be fine, but for persistent containers such as the Oracle Database container you may want to give the container a bit more time to shutdown the database appropriately. The `t` parameter allows you to specify a timeout in seconds for the container to shutdown the database gracefully. Note that once the database has successfully shutdown, the container will exit normally. Therefore, a good practice is to specify a long timeout (600 seconds is 10 minutes), knowing that command will return control to the terminal as soon as the database is shutdown.

1. If you don't have an open SSH connection to your compute instance, open a terminal window. Navigate to the folder where you created the SSH keys and connect:

    ```
    $ <copy>ssh -i ./myOracleCloudKey opc@</copy>123.123.123.123
    Enter passphrase for key './myOracleCloudKey':
    [opc@oraclelinux77 ~]$
    ```

2. Stop the docker container:

    ```
    [opc@oraclelinux77 ~]$ <copy>docker stop -t 600 oracle-ee</copy>
    oracle-ee
    [opc@oraclelinux77 ~]$
    ```

## **STEP 2**: Starting a Docker Container

The docker `start` command will put the container into background and return control immediately. You can check the status of the container via the `docker logs` command which should print the same `DATABASE IS READY TO USE!` line.

1. Start the docker container:

    ```
    [opc@oraclelinux77 ~]$ <copy>docker start oracle-ee</copy>
    oracle-ee
    ```

2. Check the logs:

    ```
    [opc@oraclelinux77 ~]$ <copy>docker logs oracle-ee</copy>
    Starting /opt/oracle/product/19c/dbhome_1/bin/tnslsnr: please wait...
    ...

    The Oracle base remains unchanged with value /opt/oracle
    #########################
    DATABASE IS READY TO USE!
    #########################
    The following output is now a tail of the alert.log:
    ORCLPDB1(3):Completed: ALTER DATABASE DEFAULT TABLESPACE "USERS"
    2020-04-07T20:18:55.253120+00:00
    ALTER SYSTEM SET control_files='/opt/oracle/oradata/ORCLCDB/control01.ctl' SCOPE=SPFILE;
    2020-04-07T20:18:55.267972+00:00
    ALTER SYSTEM SET local_listener='' SCOPE=BOTH;
     ALTER PLUGGABLE DATABASE ORCLPDB1 SAVE STATE
    Completed:    ALTER PLUGGABLE DATABASE ORCLPDB1 SAVE STATE
    2020-04-07T20:18:55.706902+00:00

    XDB initialized.
    [opc@oraclelinux77 ~]$
    ```

  Note that using `docker logs -f` will tail the log.

Congratulations! You have completed this workshop. Oracle has also provided build files for other Oracle Database versions and editions. The steps described in this workshop are largely the same but you should always refer to the `README.md` that comes with the build files. You will also find more options for how to run your Oracle Database containers.

## Want to Learn More?

* [Oracle Docker Github repo](https://github.com/oracle/docker-images/tree/master/OracleDatabase)

## Acknowledgements
* **Author** - Gerald Venzl, Master Product Manager, Database Development
* **Adapted for Cloud by** -  Tom McGinn, Learning Architect, Database User Assistance
* **Last Updated By/Date** - Tom McGinn, March 2020
* **Contributor** - Arabella Yao, Product Manager Intern, Database Management, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request. 
