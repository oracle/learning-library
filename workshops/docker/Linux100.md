# Docker Workshop

## Before You Begin
### Objectives
- Deploy and test a simple Docker container running a simple application
- Introduce and use the Docker Hub registry
- Familiarize yourself with Docker commands (ps, run, exec)
- Understand foundational concepts of container networking and filesystem mapping


### Requirements

- Docker Hub Account: [Docker Hub](https://hub.docker.com/)
- Docker and GIT installed in your own Linux environment

This Lab and Lab 200 assume you have went through the 050 Set Up Lab and have SSH'ed into that Compute Instance. Verify that the Docker engine is up and running.

**NOTE**: The screen shots in this lab guide are using the available Linux VirtualBox VM

In this lab we introduce some basic concepts of Docker, container architectures and functions.  We will do this using a single container which provides a REST service as part of a node.js application.  The application has two pieces, which provide a microservice.

- Datasource: A simple JSON file included in the container
- REST Client: To serve up data from the datasource

You will use various Docker commands to setup, run and connect into containers. In this introduction you will explore concepts of Docker volumes, networking and container architecture.

***To log issues***, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.


## **STEP 1**: Open up a Terminal Window

- Make sure you are in a SSH terminal session (`Assumes login via Lab 050`). **You can follow Step 9 in Lab 050 to re-login if you need to...**

## **STEP 2**: Verify that Docker is running

**NOTE: For the duration of the Labs it's OK that the login user (holuser vs. opc) and the Docker version may vary from the screenshots**

- **Run** the following commands by typing them in the terminal window:

  ```
  cd
  docker version
  ```

  The information on your docker engine should be displayed:

  ![](images/100Linux/Picture100-2.png " ")

## **STEP 3**: See What is running

Let's take a quick look at what is running in the docker engine, if this is a new environment, you should see no docker containers running.

- **Run** the following:

  ```
  docker ps
  ```

  ![](images/100Linux/Picture100-3.png " ")

## **STEP 4**: Run the restclient docker image from docker hub

We will now download and create a container based on an existing docker image stored in the Docker Hub. It uses a JSON formatted datafile to serve up test data via its exposed REST service. Docker looks for the designated image locally first before going to Docker HUB.

- Let's take a look at what the docker **run** command options do:
    - "-d" flag runs the container in the background
    - "-it" flags instructs Docker to allocate a pseudo-TTY connected to the
    container’s stdin, creating an interactive bash capable shell in the container (which we will use in a moment when we connect into the container)
    - "--rm" When this container is stopped all resources associated with it (storage, etc) will be deleted
    - "--name" The name of the container will be "restclient"
    - "-p" Port 8002 is mapped from the container to port 8002 on the HOST
    - "-e" Environment variables used by the application. "DS" setting designates the JSON datasource.

- **Type OR cut and paste** the following (all on one line):

  ```
  docker run -d -it --rm --name restclient -p=8002:8002 -e DS='json' wvbirder/restclient
  ```

  ![](images/100Linux/Picture100-4.png " ")

## **STEP 5**: Check running containers

Again using the `docker ps` command, we should see our newly spawned docker container

- **Run** the following:

  ```
  docker ps
  ```

- Note that the container id is unique, and the container's port is mapped to 8002, which is the same as the Host's port.

  ![](images/100Linux/Picture100-5.png " ")

## **STEP 6**: Check the Application with a browser

- We need the Public IP address to test the deployment. Navigate in a browser to your Oracle Trial account and from the hamburger menu in the upper left hand side of the page select go to **Compute-->Instances**:

  ![](images/100Linux/26.png " ")

- Click on the **Docker** compute instance

  ![](images/100Linux/Picture100-5-4.png " ")

- Note the Public IP address (in this example, `129.213.119.105`)

  ![](images/100Linux/Picture100-5-6.png " ")

- In a local browser go to the following URL substituting your Public IP address:

  ```
  http://<Public-IP>:8002/
  ```

  ![](images/100Linux/Picture100-6.png " ")

- Now enter this URL into your browser :  `http://<Public-IP>:8002/products`

  If your browser contains a JSON Formatter add-on then the output will look something like this (else, it will just be unformatted text, which is OK):

  ![](images/100Linux/Picture100-7.png " ")

## **STEP 7**: Stop the Container

- Since we started the `restclient` container with the --rm option upon stopping it docker will remove ALL allocated resources

- **Run** the following:

  ```
  docker stop restclient
  ```

- Now, entering "docker ps -a" (which will show the status of ALL containers RUNNING or STOPPED) shows nothing proving the container was deleted upon stopping it.

- **Run** the following:

  ```
  docker ps -a
  ```

  ![](images/100Linux/Picture100-7.4.png " ")

## **STEP 8**: Start another Container with a different HOST Port

- Start another container using the Host's 18002 port:

- **Run** the following:

  ```
  docker run -d -it --rm --name restclient -p=18002:8002 -e DS='json' wvbirder/restclient
  ```

- If you change your browsers port to 18002, you will see that the Host server is using 18002 and mapping that to our container's port 8002.

  ![](images/100Linux/Picture100-8.png " ")

  ![](images/100Linux/Picture100-9.png " ")

## **STEP 9**: Inspect the Container's Network and IP Address

- You can get various bits of information from the subnet that docker container is running on by inspecting the default network bridge docker creates out-of-the-box. You can create your own networks and assign containers to them but that is out of the scope of this lab.

 - **Run** the following:

  ```
  docker network inspect bridge
  ```

- This returns information about all the containers running on the default bridge. We see that our `restclient` container is assigned IP Address 172.17.0.2. You can ping that address from the Host server.

  ![](images/100Linux/Picture100-10.png " ")

- Ping the `restclient` container IP Address: (in this example the IP was 172.17.0.2)

- **Run** the following:

  ```
  ping 172.17.0.2 -c3
  ```

  ![](images/100Linux/Picture100-11.png " ")

- Finally, **STOP** the `restclient` container as we will be re-provisioning it in Lab 200 by **typing**:

  ```
  docker stop restclient
  ```

**You are ready to proceed to Lab 200**
