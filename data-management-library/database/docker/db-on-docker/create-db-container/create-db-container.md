# Create an Oracle Database Container and Schema

## Introduction

One of the benefits of using Docker is quick and easy provisioning.  Oracle provides Docker images for its Standard and Enterprise Edition database.  In this lab you will explore more features of Docker and deploy a fully functional containerized version of the AlphaOffice application. The application is made up of the following four containers:

- *Datasource*: Oracle Database
- *TwitterFeed*: Static Twitter posts related to products in the datasource
- *AlphaOffice UI*: Node.js application that makes REST calls to the RESTClient and TwitterFeed containers

You will use various Docker commands to setup, run and connect into containers. Concepts of Docker volumes, networking and intra-container communication will be used.

Estimated Lab Time: 15 minutes.

### Objectives

- In this lab, you will walk through the steps to deploy an Oracle Database to Docker container.

### Prerequisites

* Create a docker hub [account](http://hub.docker.com)
* Successfully have setup docker on compute instance

## **STEP 1:** Create an Oracle Database container

1. Login to the instance using ssh.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````

2.  Verify your docker version.

    ````
    <copy>
    cd ~
    docker version
    </copy>
    ````
3.  Make sure you are in the /home/opc directory.  You will clone some setup scripts from git.
    ````
    <copy>
    pwd
    git clone https://github.com/wvbirder/AlphaOfficeSetup.git
    cd /home/opc
    chmod -R 777 Alpha*
     </copy>
    ````

4.  Login with your Docker Hub credentials.

    ````
    <copy>
    docker login
    </copy>
    ````

    ![](images/section5step2.png " ")

5.  There are database setup files that you cloned in an earlier step.   Ensure the listener has stopped.  Let's see how easy it is to deploy an Oracle Database to a docker container.  Issue the command below.

    ````
    <copy>
    docker run -d -it --name orcl -h='oracledb-ao' -p=1521:1521 -p=5600:5600 -v /home/opc/AlphaOfficeSetup:/dbfiles wvbirder/database-enterprise:12.2.0.1-slim
    </copy>
    ````

    ![](images/section5step3.png " ")

    - -d runs the command in the background
    - -h assigns it the hostname oracleadb-ao
    - -p maps ports 1521 and 5600 (Enterprise Manager Express) inside the container to your compute instance. In an earlier step, we added ingress rules for these ports
    - --name is the name of the container
    - v maps the directory where you downloaded the setup files to the /dbfiles directory inside the container

## **STEP 2:** Follow the progress of container creation

1.  To watch the progress type the following command passing the name of the container:  orcl.  This takes time, **please be patient**.

    ````
    <copy>
    docker logs --follow orcl
    </copy>
    ````

    ![](images/section5step4.png " ")

2.  When the database creation is complete, you may see "The database is ready for use". *The instance creation may happen quickly and that message may scroll past*. Press control-c to continue.

    ![](images/section5step4b.png " ")


## **STEP 3:** Create a schema in container running Oracle Database and login to EM Express

1.  To create the schema we need to "login" to the container.  Type the following:

    ````
    <copy>
    docker exec -it orcl bash
    </copy>
    ````

2.  Let's make sure the /dbfiles directory mapped earlier is writeable.

    ````
    <copy>
    cd /dbfiles
    touch xxx
    ls
    </copy>
    ````

    ![](images/section6step2.png " ")

3.  Now run the sql script from inside the container using sqlplus.

    ````
    <copy>
    sqlplus / as sysdba
    @setupAlphaOracle.sql
    exit
     </copy>
    ````

    ![](images/section6step3.png " ")

4.  Now that our schema is created, let's login to Enterprise Manager Express.  Enter the address below into your browser.  If you've never downloaded flash player, you may need to install it and restart your browser.

    ````
    <copy>
    http://<Public IP Address>:5600/em
    </copy>
    ````

5.  If prompted to enable Adobe Flash, click Allow.  Login using the credentials below.  Leave the container name field blank.

    ````
    Username: sys
    Password: Oradoc_db1
    Check the "as SYSDBA" checkbox
    ````

    ![](images/em-express.png " ")

    ![](images/emexpress.png " ")

6. Explore the database using Enterprise Manager Express.

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Oracle NATD Solution Engineering
* **Contributors** - Kay Malcolm, Director, Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, Product Manager, November 2020

