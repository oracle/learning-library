# Setup a Demo On-Premises Environment Using Docker

## Introduction

This lab will walk you through setting up a local environment to simulate an established on-premises environment, using Docker on your local machine.

At the end of this lab, you will have a local environment running with an Oracle 12c Database and Tomcat 7.0 with a simple application and a datasource connecting to the database.

Estimated Lab Time: 30 minutes

### Objectives

In this lab you will:

- Get the Docker environment files
- Startup the Docker-based 'on-premises' demo environment
- Check that the environment is running properly
- Create an SSH key pair to communicate with the OCI services.


### Prerequisites

To run this lab, you will need:

- Docker installed locally to run the 'on-prems' environment.

  Get Docker here: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)

  ***Note: You need at least 3 CPUs and 6Gb of memory assigned to Docker to run this template.***

- Docker-compose installed (on Linux it needs to be installed separately, but it is installed automatically on Mac OS and Windows)

  [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

- Docker Hub Account, to download necessary Docker images

  [https://hub.docker.com/signup](https://hub.docker.com/signup)


## **STEP 1:** Get the code

### **On Linux**

*Make sure you followed the installation instructions to setup Docker as root and:*

1. If you don't have an `oracle` user, create it an add it to a `oracle` group with:

    ```bash
    <copy>
    groupadd oracle
    useradd -g oracle oracle
    </copy>
    ```

2. Make sure you added the `oracle` user to the `docker` group as root with

    ```bash
    <copy>
    sudo usermod -aG docker oracle
    </copy>
    ```

3. Switch to the `oracle` user with:

    ```bash
    <copy>
    sudo su - oracle
    </copy>
    ```

4. Get the code with:

    ```bash
    <copy>
    cd ~/
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/Wc0_WknE3Q8cRz0zAhDBtaSULux3Nruli_wDfvQrvL5sjvafKTC7CeC6XTOFoiRh/n/ocisateam/b/images/o/tomcat-to-oci.zip
    </copy>
    ```

5. Unzip the files with:

    ```bash
    <copy>
    unzip tomcat-to-oci.zip
    </copy>
    ```

You can also download the code [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/Wc0_WknE3Q8cRz0zAhDBtaSULux3Nruli_wDfvQrvL5sjvafKTC7CeC6XTOFoiRh/n/ocisateam/b/images/o/tomcat-to-oci.zip)

### **On Mac OS X**

1. Get the code with:

    ```bash
    <copy>
    cd ~/
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/Wc0_WknE3Q8cRz0zAhDBtaSULux3Nruli_wDfvQrvL5sjvafKTC7CeC6XTOFoiRh/n/ocisateam/b/images/o/tomcat-to-oci.zip
    </copy>
    ```

    If you do not have wget installed, you can download through your browser, or install wget with 
    ```
    <copy>
    brew install wget
    </copy>
    ```

2. Unzip the files with:

    ```bash
    <copy>
    unzip tomcat-to-oci.zip
    </copy>
    ```

You can also download the code [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/Wc0_WknE3Q8cRz0zAhDBtaSULux3Nruli_wDfvQrvL5sjvafKTC7CeC6XTOFoiRh/n/ocisateam/b/images/o/tomcat-to-oci.zip)

### **On Windows**

1. Download the code [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/Wc0_WknE3Q8cRz0zAhDBtaSULux3Nruli_wDfvQrvL5sjvafKTC7CeC6XTOFoiRh/n/ocisateam/b/images/o/tomcat-to-oci.zip)

2. Unzip the file with your preferred tool 

3. Open a terminal and get into the unzipped folder

## **STEP 2:** Agree to the terms of the private docker images

This repository makes use of Oracle docker images which are licensed and need to be pulled from DockerHub after acknowledging the terms of the license.

1. Sign in to Docker Hub and go to the **Oracle Database** page and accept the license terms at:</br>
  <a href="https://hub.docker.com/_/oracle-database-enterprise-edition" target="_blank">https://hub.docker.com/_/oracle-database-enterprise-edition</a>

    - Click **Proceed to Checkout**
    - Fill in your information
    - Accept the terms of license
    - click **Get Content**.

2. Go to the **Instant Client** page and accept the license terms for the SQL Plus client at:</br>
  <a href="https://hub.docker.com/_/oracle-instant-client" target="_blank">https://hub.docker.com/_/oracle-instant-client</a>

    - Click **Proceed to Checkout**
    - Fill in your information
    - Accept the terms of license
    - click **Get Content**.

3. Login to docker, providing your docker-hub username and password:

    ```bash
    <copy>
    docker login
    </copy>
    ```

## **STEP 3:** Start the local environment

*Startup the local environment stack that will simulate our 'on-premises' environment*

1. On Linux, make sure you are using the `oracle` user.

2. Run:

    ```
    <copy>
    cd tomcat-to-oci
    docker-compose build --no-cache
    docker-compose up -d
    </copy>
    ```

    This step can take several minutes because some images need to be built. 

3. On linux or Windows, Docker permission may cause issues, so run:

    ```bash
    <copy>
    docker exec -it --user=root tomcat-to-oci_oracledb_1 /bin/chown 54321:54321 ~/.ssh
    </copy>
    ```

### Troubleshooting

If you get an error message like the following even though you are logged in, it usually means you have not accepted the *Terms and Condition* for the specific image.

```
pull access denied for store/oracle/database-instantclient, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
```

Go to the appropriate registry and image page, and go through the acknowledgement steps.

## **STEP 4:**  Check the local environment is up and running

**It may take up to 10 minutes for the app to be up and running**

For the tomcat container to run the application, the database needs to be ready, and the schemas created. Be patient.

1. To check status of the initialization, you can check if the `tomcat-to-oci_oracledbinit_1` container has finished running by running:

    ```
    <copy>
    docker ps
    </copy>
    ```
    The following output shows the init container has terminated and the system should be ready:
    ```
    CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS                             PORTS                                                          NAMES
c99433b680ce        tomcat-to-oci_tomcat         "catalina.sh run"        26 seconds ago      Up 25 seconds                      0.0.0.0:8080->8080/tcp                                         tomcat-to-oci_tomcat_1
0b8f99e2deb8        tomcat-to-oci_oracledb       "/bin/sh -c '/bin/ba…"   26 seconds ago      Up 25 seconds (health: starting)   127.0.0.1:1521->1521/tcp, 127.0.0.1:5000->5000/tcp, 5500/tcp   tomcat-to-oci_oracledb_1
    ```

    If you see a container called `tomcat-to-oci_oracledbinit`, like below, this means the initialization is still ongoing.

    ```
    3d8c4e075e5e        tomcat-to-oci_oracledbinit   "/bin/sh -c ./setup.…"   26 seconds ago      Up 25 seconds                                                                                     tomcat-to-oci_oracledbinit_1
    ```

2. To troubleshoot problems in the setup, check the logs in the docker containers with:

    ```bash
    <copy>
    docker logs -t tomcat-to-oci_oracledb_1
    </copy>
    ```

    Before proceeding, make sure the local environment has been deployed properly and is running. 

    The **SimpleDB** application should be running at [http://localhost:8080/SimpleDB/](http://localhost:8080/SimpleDB/)

    It shows statistics of riders of the Tour de France stored in the database, and looks like this:

    ![./images/localhost-simpledb-app.png](./images/localhost-simpledb-app.png)

## **STEP 5:** Create a SSH key

*We'll need a SSH key pair to communicate with the WebLogic servers and the database on OCI. The public key will need to be provided when provisioning those resources.*

Since we'll be running all our commands from docker containers, a folder has been mounted on the `~/.ssh/` folder inside both containers, so that it is shared and also accessible from the outside.

We'll create an SSH key pair in this folder

1. Get inside the Oracle Database container:

    ```bash
    <copy>
    docker exec -it tomcat-to-oci_oracledb_1 /bin/bash
    </copy>
    ```

2. Create the SSH key pair

    ```bash
    <copy>
    ssh-keygen
    </copy>
    ```
    and just hit `Enter` (default) for all the prompts

3. You should find two files `id_rsa` and `id_rsa.pub` inside the folder `./tomcat-to-oci/ssh/` on your local machine, and under `~/.ssh/` inside the containers

    `id_rsa` is the private key, which should never be shared, and will be required to connect to any OCI resource provisioned with the corresponding public key `id_rsa.pub`

    Note this key will be the default SSH key from within either docker container used for the on-premises environment. If you wanted to SSH to the OCI resources from outside the container, you would need to supply the private key as the identity file in the ssh command, with the `-i <path-to-id_rsa>/id_rsa`

    **Note:** This is only to be done once. If you run it again, a new key will overwrite the previous one and you will lose access to any resource provisioned with that key.

    **Note:** If you're using a firewall and your instance is not local, make sure the ports for Tomcat (8080) is open to be able to test the environment.

4. Output the content of the public key

    ```
    <copy>
    cat ~/.ssh/id_rsa.pub
    </copy>
    ```

    Copy the full text output into a notepad for later use. 

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, October 2020
 - **Last Updated By/Date** - Emmanuel Leroy, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
