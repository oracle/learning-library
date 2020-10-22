# Lab 100: Setup the local (on-premises) environment

## Introduction: 

This 30 mins lab walks you through setting up your local environment. Please see Requirements to get the code and the required Docker images.


## Step 1) Start the local environment

To startup the local environment stack that will simulate our 'on-premises' environment, run:
```
<copy>
cd on-prems-setup
docker-compose up -d
</copy>
```
This step can take several minutes because some images need to be built. 

If you get an error message like:
```
pull access denied for store/oracle/database-instantclient, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
```
This means you have not accepted the *Terms and Condition* for the specific image.

Go to the appropriate registry and image page, and go through the acknowledgement steps, and/or pull the image as indicated above.

## Step 2)  Check the local environment is up and running

**It may take several minutes for the domain to be up and running**, because the weblogic container waits for the database to be ready, and the schemas to be created. Be patient.

The console will be available at <a href="http://localhost:7001/console" target="_blank">http://localhost:7001/console</a> and the WebLogic admin user is `weblogic` with password `welcome1`

To check status of the initialization, you can check if the `on-prems-setup_oracledbinit_1` container has finished running by running:

```
<copy>
docker ps
</copy>
```
The following output shows the init container has terminated and the system should be ready:
```
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS                PORTS                                                                          NAMES
bf43e3bd5a78        on-prems-setup_oracledb    "/bin/sh -c '/bin/ba…"   7 days ago          Up 7 days (healthy)   127.0.0.1:1521->1521/tcp, 127.0.0.1:5000->5000/tcp, 5500/tcp                   on-prems-setup_oracledb_1
38bcbb1555b8        on-prems-setup_wls_admin   "/u01/oracle/startNM…"   7 days ago          Up 7 days             127.0.0.1:7001->7001/tcp, 127.0.0.1:7003->7003/tcp, 127.0.0.1:7005->7005/tcp   on-prems-setup_wls_admin_1
```

If you see a container called `on-prems-setup_oracledbinit`, this means the initialization is still ongoing.

To troubleshoot problems in the setup, check the logs in the docker containers with:

```bash
<copy>
docker logs -t on-prems-setup_wls_admin_1
</copy>
```
or
```bash
<copy>
docker logs -t on-prems-setup_oracledb_1
</copy>
```

Before proceeding, make sure the local environment has been deployed properly and is running. 

![](./images/localhost-admin-console.png)


The **SimpleDB** application should be running at [http://localhost:7003/SimpleDB/](http://localhost:7003/SimpleDB/) or [http://localhost:7005/SimpleDB/](http://localhost:7005/SimpleDB/)

It shows statistics of riders of the Tour de France stored in the database, and looks like this:

![](./images/localhost-simpledb-app.png)

## Step 3) Create a SSH key

We'll need a SSH key pair to communicate with the WebLogic servers and the database on OCI. The public key will need to be provided when provisioning those resources. 

Since we'll be running all our commands from docker containers, a folder has been mounted on the `~/.ssh/` folder inside both containers, so that it is shared and also accessible from the outside.

We'll create a SSH key pair in this folder

- Get inside the Oracle Database container:

```bash
<copy>
docker exec -it on-prems-setup_oracledb_1 /bin/bash
</copy>
```

- Create the SSH keypair

```bash
<copy>
ssh-keygen
</copy>
```
and just hit `Enter` (default) for all the prompts

- You should find two files `id_rsa` and `id_rsa.pub` inside the folder `./on-prems-setup/common/`

   `id_rsa` is the private key, which should never be shared, and will be required to connect to any OCI resource provisioned with the corresponding public key `id_rsa.pub`

   Note this key will be the default SSH key from within either docker container used for the on-premises environment. If you wanted to SSH to the OCI resources from outside the container, you will need to supply the private key as the identity file in the ssh command, with the `-i <path-to-id_rsa>/id_rsa`

**Note:** This is only to be done once. If you run it again, a new key will overwrite the previous one and you will lose access to any resource provisioned with that key.


