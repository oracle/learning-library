# Setup a Property Graph Analysis Environment in Docker

## Introduction

This lab will walk you through the steps to build and start Oracle Linux Docker containers. You will deploy and configure the Property Graph server and client component in these containers.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:
* Build and start Oracle Linux Docker containers
* Deploy and configure the Property Graph server and clients component in the containers

### Prerequisites

* Docker and GIT on your local machine (laptop or desktop).
* Internet access to download the Graph Server and Client kit.

## **STEP 1:** Get required components

### Clone repository

1. Clone the git repository which has the required Docker Compose files and other configuration files and scripts to your machine.

    ```
    <copy>git clone https://github.com/jayant62/oracle-pg.git</copy>
    ```

  Note the directory where you have cloned it. We will refer to it as `$REPO_HOME` here and in other labs in this workshop.

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

3. Change directory to `$REPO_HOME` and run the following script to extract the packages:

    ```
    $ <copy>cd oracle-pg/docker/tmp/</copy>
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

### Starting, stopping, restarting, or removing containers once they're built.

1. Start, stop, or restart the containers.

    ```
    $ <copy>cd oracle-pg/docker/ </copy>
    $ <copy>docker-compose start|stop|restart</copy>
    ```

2. To remove the docker containers.

    ```
    $ <copy>cd oracle-pg/docker/ </copy>
    $ <copy>docker-compose down</copy>
    ```

You may now proceed to the next lab.

## Acknowledgements ##

* **Author** - Jayant Sharma, Product Manager
* **Contributors** - Ryota Yamanaka
* **Last Updated By/Date** - Anoosha Pilli, Database Product Management, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
