# Setup a Property Graph Analysis Environment in Docker

## Introduction

This lab will walk you through the steps to build and start Oracle Linux Docker containers. You will deploy and configure the Property Graph server and client component in these containers.

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:
* Build and start Oracle Linux Docker containers
* Deploy and configure the Property Graph server and clients component in the containers

### Prerequisites

* This lab assumes that you have completed the lab - Set up Docker on an Oracle Cloud Compute Instance
* Internet access to download the Graph Server and Client kit.

## **STEP 1:** Get required components

### Clone repository

1. If you don't have an open SSH connection to your compute instance, open a terminal window. Navigate to the folder where you created the SSH keys, replace *your-key-name* with your private key name and *your-instance-ip-address* with your compute instance ip address and connect to your compute instance as opc user:

    ```
    <copy>
    ssh -i ./your-key-name opc@your-instance-ip-address
    </copy>
    ```

2. Clone the git repository which has the required Docker Compose files and other configuration files and scripts to your machine.

    ```
    <copy>git clone https://github.com/jayant62/oracle-pg.git</copy>
    ```

    Note the directory where you have cloned it. We will refer to it as `$REPO_HOME` here and in other labs in this workshop.

3. Grant permission on the directory

    ```
    <copy>
    chmod 777 oracle-pg
    </copy>
    ```

### Download and extract the graph and other packages

1. Go to the following sites and download the packages.

    - [Oracle Graph Server and Client 20.1](https://www.oracle.com/database/technologies/spatialandgraph/property-graph-features/graph-server-and-client/graph-server-and-client-downloads.html)

  Note: This version of the lab only works with the **20.1** Graph Server & Client kit. **It will not work later versions**

    - [Apache Groovy 2.4.18](https://dl.bintray.com/groovy/maven/apache-groovy-binary-2.4.18.zip)

  The Graph Server and client kit require Groovy.

2. Once you have downloaded the above do the following.
Put the following files into `$REPO_HOME/oracle-pg/docker/tmp/`

    - oracle-graph-20.1.0.x86_64.rpm
    - oracle-graph-zeppelin-interpreter-20.1.0.zip
    - apache-groovy-binary-2.4.18.zip
    - oracle-graph-client-20.1.0.zip

    To put the files in the directory, open a new terminal window, run the below commands by copying one by one, and replace *your-key-name* with your private key name and *your-instance-ip-address* with your compute instance ip address.

    ```
    <copy>
    scp -i ~/.ssh/your-key-name ~/Downloads/oracle-graph-20.1.0.x86_64.rpm opc@your-instance-ip-address:oracle-pg/docker/tmp/
    </copy>
    ```

    ```
    <copy>
    scp -i ~/.ssh/your-key-name ~/Downloads/oracle-graph-zeppelin-interpreter-20.1.0.zip opc@your-instance-ip-address:oracle-pg/docker/tmp/
    </copy>
    ```

    ```
    <copy>
    scp -i ~/.ssh/your-key-name ~/Downloads/apache-groovy-binary-2.4.18.zip opc@your-instance-ip-address:oracle-pg/docker/tmp/
    </copy>
    ```

    ```
    <copy>
    scp -i ~/.ssh/your-key-name ~/Downloads/oracle-graph-client-20.1.0.zip opc@your-instance-ip-address:oracle-pg/docker/tmp/
    </copy>
    ```

3. Navigate to the previous terminal in which you were opc user and change directory to `$REPO_HOME`.

    ```
    $ <copy>cd oracle-pg/docker/tmp/</copy>
    ```

4. Now let's unzip oracle-graph-client-20.1.0.zip file.

    ```
    <copy>
    unzip oracle-graph-client-20.1.0.zip
    </copy>
    ```

5. Run the following script to extract the packages:

    ```
    $ <copy>sh extract.sh</copy>
    ```

### Modify the PGX interpreter settings for Zeppelin

1. The extract script above copies the necessary jar files and a json configuration file into the `oracle-pg/docker/zeppelin/interpreter/pgx` directory.

2. Open the file `interpreter-settings.json` in a text editor and change the default `PGX_BASE_URL` property in it. i.e. change the line (line 15)
` "defaultValue":"https://localhost:7007" `
to

    ```
    <copy>"defaultValue":"http://graph-server:7007"</copy>
    ```

## **STEP 2:** Create and start the containers

### Build and pull images, create containers, and start them

1. To build and pull images, create containers, and start them, run the following commands.

    ```
    $ <copy>cd oracle-pg/docker/</copy>
    $ <copy>docker-compose up -d</copy>
    ```

  This takes some time. The next section shows some docker commands for viewing the log files to check the progress or state of the initialization.

### Viewing the log files

1. View the containers' log files to check the progress of creating and starting them.

    ```
    $ <copy>cd oracle-pg/docker/ </copy>
    $ <copy>docker-compose logs -f</copy>
    ```

2. `Ctl+C` to quit.

### Starting, stopping, restarting, checking status or removing containers once they're built.

1. Start, stop, or restart the containers.

    ```
    $ <copy>cd oracle-pg/docker/ </copy>
    $ <copy>docker-compose start|stop|restart</copy>
    ```

2. Check status of the containers.

    ```
    $ <copy>docker-compose ps</copy>
    ```

3. To remove the docker containers.

    ```
    $ <copy>cd oracle-pg/docker/ </copy>
    $ <copy>docker-compose down</copy>
    ```

You may now proceed to the next lab.

## Acknowledgements ##

* **Author** - Jayant Sharma, Product Manager
* **Contributors** - Ryota Yamanaka, Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, Database Product Management, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-graph). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
