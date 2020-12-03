# Setup Oracle Database in Docker

## Introduction

This lab will walk you through the steps to build and start an Oracle Database Docker container. You will also deploy and configure the Property Graph server and client components for use with the database Docker container.

That is, you will create a docker container for Oracle Database as backend storage of graphs.

![](images/build_docker.jpg)

Estimated Lab Time: 40 minutes

### Objectives

In this lab, you will:
* Build and start an Oracle Database Docker container
* Deploy and configure the Property Graph server and client components

### Prerequisites

* Cloned `oracle-pg` repository on your instance.

## **STEP 1:** Build the Oracle Database Docker image

### Install Docker build files from GitHub

Oracle has provided a complete set of Docker build files on an Oracle GitHub repository. There are several ways to get the files to the compute instance, but for simplicity, you will use GitHub's download option.

1. If you don't have an open SSH connection to your compute instance, open a terminal window. Navigate to the folder where you created the SSH keys, replace *your-key-name* with your private key name and *your-instance-ip-address* with your compute instance ip address and connect to your compute instance:

    ```
    ssh -i ./your-key-name opc@your-instance-ip-address
    ```

2. Change to `home` directory and use the `wget` to download the repository on the compute instance:

    ```
    [opc@oraclelinux77 ~]$ <copy>wget https://github.com/oracle/docker-images/archive/master.zip</copy>
    --2020-04-07 18:23:39--  https://github.com/oracle/docker-images/archive/master.zip
    Resolving github.com (github.com)... 140.82.112.4
    Connecting to github.com (github.com)|140.82.112.4|:443... connected.
    HTTP request sent, awaiting response... 302 Found
    Location: https://codeload.github.com/oracle/docker-images/zip/master [following]
    --2020-04-07 18:23:39--  https://codeload.github.com/oracle/docker-images/zip/master
    Resolving codeload.github.com (codeload.github.com)... 140.82.112.10
    Connecting to codeload.github.com (codeload.github.com)|140.82.112.10|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: unspecified [application/zip]
    Saving to: ‘master.zip’

        [  <=>                                                                                      ] 2,797,020   12.1MB/s   in 0.2s

    2020-04-07 18:23:39 (12.1 MB/s) - ‘master.zip’ saved [2797020]

    [opc@oraclelinux77 ~]$
    ```

3. Unzip the repository on your compute instance:

    ```
    [opc@oraclelinux77 ~]$ <copy>unzip master.zip</copy>
    Archive:  master.zip
    7e03e466934753bc547c1919729702e5f33e4eba
       creating: docker-images-master/
    ...
       creating: docker-images-master/OracleWebLogic/samples/wls-k8s-domain/k8s/
      inflating: docker-images-master/OracleWebLogic/samples/wls-k8s-domain/k8s/pv.yml
      inflating: docker-images-master/OracleWebLogic/samples/wls-k8s-domain/k8s/pvc.yml
      inflating: docker-images-master/OracleWebLogic/samples/wls-k8s-domain/k8s/secrets.yml
      inflating: docker-images-master/OracleWebLogic/samples/wls-k8s-domain/k8s/wls-admin.yml
      inflating: docker-images-master/OracleWebLogic/samples/wls-k8s-domain/k8s/wls-stateful.yml
      inflating: docker-images-master/README.md
    [opc@oraclelinux77 ~]$
    ```

### Upload Oracle Database zip to your compute instance

1. Navigate to the folder where you want to put your image zip file.

    ```
    <copy>cd docker-images-master/OracleDatabase/SingleInstance/dockerfiles/19.3.0</copy>
    ```

2.  Oracle Database 19c (19.3) for Linux x86-64 has been uploaded to Oracle Object Storage for you. Download the zip file to your compute instance by using its Pre-Authenticated Request (PAR) URL.

    ```
    <copy>wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/LK1k7CgQxR2LcgcF1sG8E0Z_B3q3yNC4H62dZQ8xaSr7OBN7D6lcpIutXF17oZU6/n/c4u03/b/data-management-library-files/o/LINUX.X64_193000_db_home.zip</copy>
    ```

You have finished uploading Oracle Database zip to your compute instance. You can now move to Build the Docker image.

### Other option to Upload Oracle Database zip to your compute instance

1. Download Oracle Database for Linux.

    [Oracle Database 19.3.0 for Linux x86-64 (ZIP)](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html)

2. Replace *your-key-name* with your private key name and *your-instance-ip-address* with your compute instance ip address and put `LINUX.X64_193000_db_home.zip` under: `docker-images-master/OracleDatabase/SingleInstance/dockerfiles/19.3.0/`

    ```
    <copy>
    scp -i ~/.ssh/your-key-name ~/Downloads/LINUX.X64_193000_db_home.zip opc@your-instance-ip-address:docker-images-master/OracleDatabase/SingleInstance/dockerfiles/19.3.0/
    </copy>
    ```

### Build the Docker image

1.  Change directories to the `dockerfiles` directory:

    ```
    [opc@oraclelinux77 ~]$<copy>cd docker-images-master/OracleDatabase/SingleInstance/dockerfiles</copy>
    [opc@oraclelinux77 dockerfiles]$
    ```

2. Build the Docker image using the `buildDockerImage` script. This process may take around 20-30 minutes.

   Be sure to read the [README.md](https://github.com/oracle/docker-images/blob/master/OracleDatabase/SingleInstance/README.md) file which explains the build process in greater detail.

    ```
    [opc@oraclelinux77 dockerfiles]$ <copy>./buildDockerImage.sh -v 19.3.0 -e</copy>
    Checking Docker version.
    Checking if required packages are present and valid...
    LINUX.X64_193000_db_home.zip: OK
    ==========================
    DOCKER info:
    Client:
     Debug Mode: false

    Server:
     Containers: 1
      Running: 0
      Paused: 0
      Stopped: 1
     Images: 1
     Server Version: 19.03.1-ol
     Storage Driver: overlay2
    ...
    Complete!
    Removing intermediate container d4a91ea15cd2
     ---> 1e15b546dc1b
    Step 8/21 : FROM base AS builder
     ---> 1e15b546dc1b
    Step 9/21 : ARG DB_EDITION
     ---> Running in e2d78f4cb68a
    Removing intermediate container e2d78f4cb68a
     ---> c13d9fffaed8
    ...
    Step 20/21 : HEALTHCHECK --interval=1m --start-period=5m    CMD "$ORACLE_BASE/$CHECK_DB_FILE" >/dev/null || exit 1
     ---> Running in 644d9dcff8ef
    Removing intermediate container 644d9dcff8ef
     ---> b856ede31404
    Step 21/21 : CMD exec $ORACLE_BASE/$RUN_FILE
     ---> Running in 399866c4d53f
    Removing intermediate container 399866c4d53f
     ---> d2d287fe9685
    Successfully built d2d287fe9685
    Successfully tagged oracle/database:19.3.0-ee

      Oracle Database Docker Image for 'ee' version 19.3.0 is ready to be extended:

        --> oracle/database:19.3.0-ee

      Build completed in 1850 seconds.

    [opc@oraclelinux77 dockerfiles]$
    ```

    Note when the script completes, it lists the new Docker image: `oracle/database:19.3.0-ee`.

## **STEP 2:** Start the containers

1. Change the directory to `$REPO_HOME/oracle-pg/docker/` and start the containers for **Oracle Database** only.

    ```
    $ <copy>cd oracle-pg/docker/ ;</copy>
    $ <copy>docker-compose -f docker-compose-rdbms.yml up -d oracle-db </copy>
    ```

    This step takes 15-20 minutes because it starts the container and then builds the database itself. View the container's log to track progress.

### Viewing the log files

1. Enter the following commands to view the logs and check on the progress of database initialization.

    ```
    $ cd oracle-pg/docker/
    $ <copy>docker-compose -f docker-compose-rdbms.yml logs -f oracle-db</copy>
    ```

2. Enter `Ctl+C` to quit.

    Proceed to step 2 the database is up and running.

## **STEP 3:** Configure the database

1. Connect to the Oracle Database server.

    ```
    $ <copy>docker exec -it oracle-db sqlplus sys/Welcome1@localhost:1521/orclpdb1 as sysdba</copy>
    ```

2. Set max\_string\_size running max\_string\_size.sql. At the SQL prompt enter:

    ```
    SQL> <copy>@/home/oracle/scripts/max_string_size.sql</copy>

    ...

    NAME              TYPE        VALUE
    ----------------- ----------- ---------
    max_string_size   string      EXTENDED
    ```

### Troubleshooting

1. You will get this error when you try to connect before the database is created.


    ```
    $ <copy>docker exec -it oracle-db sqlplus sys/Welcome1@localhost:1521/orclpdb1 as sysdba</copy>
    ...
    ORA-12514: TNS:listener does not currently know of service requested in connect
    ```

### Starting, stopping, restarting, or removing the containers once built

1. Start, stop, or restart the containers.

    ```
    $ cd oracle-pg/docker/
    $ docker-compose -f docker-compose-rdbms.yml start|stop|restart
    ```

2. Stop the containers and remove them.

    ```
    $ cd oracle-pg/docker/
    $ <copy>docker-compose -f docker-compose-rdbms.yml down</copy>
    ```

You may now proceed to the next lab.

## Acknowledgements ##

* **Author** - Jayant Sharma, Product Manager
* **Contributors** - Ryota Yamanaka, Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, Database Product Management, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-graph). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.



