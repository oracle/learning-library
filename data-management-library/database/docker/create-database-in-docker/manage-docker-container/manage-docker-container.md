# Manage a Docker Container
## Introduction

This lab walks you through the steps to manage your Docker container, including stopping and restarting the container and reviewing container logs.

Estimated Lab Time: 5 minutes

### Prerequisites

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* SSH keys
* A Docker container running Oracle Database 19c

## **STEP 1**: Stopping a Docker container

 You can stop the Docker container using the docker `stop` command with the container name or id. The stop command triggers the container to issue a immediate shutdown  for the database inside the container. By default, Docker will only allow 10 seconds for the container to shutdown before killing it. For applications that may be fine, but for persistent containers such as the Oracle Database container you may want to give the container a bit more time to shutdown the database appropriately. The `t` parameter allows you to specify a timeout in seconds for the container to shutdown the database gracefully. Note that once the database has successfully shutdown, the container will exit normally. Therefore, a good practice is to specify a long timeout (600 seconds is 10 minutes), knowing that command will return control to the terminal as soon as the database is shutdown.

1. If you don't have an open SSH connection to your compute instance, open a terminal window. Navigate to the folder where you created the SSH keys and connect:

    ```nohighlight
    ssh -i ~/.ssh/cloudshellkey opc@123.123.123.123
    ```

2. Stop the docker container:

    ```
    <copy>docker stop -t 600 oracle-ee</copy>
    ```

## **STEP 2**: Starting a Docker Container

The docker `start` command will put the container into background and return control immediately. You can check the status of the container via the `docker logs` command which should print the same `DATABASE IS READY TO USE!` line.

1. Start the docker container:

    ```
    <copy>docker start oracle-ee</copy>
    ```

2. Check the logs:

    ```
    <copy>docker logs oracle-ee</copy>
    ```

  Note that using `docker logs -f` will tail the log.

Congratulations! You have completed this workshop. Oracle has also provided build files for other Oracle Database versions and editions. The steps described in this workshop are largely the same but you should always refer to the `README.md` that comes with the build files. You will also find more options for how to run your Oracle Database containers.

## Want to Learn More?

* [Oracle Docker Github repo](https://github.com/oracle/docker-images/tree/master/OracleDatabase)

## Acknowledgements
* **Author** - Gerald Venzl, Master Product Manager, Database Development
* **Adapted for Cloud by** -  Tom McGinn, Sr. Principal Product Manager, Database and Database Cloud Service
* **Contributor** - Arabella Yao, Product Manager Intern, Database Management, June 2020
* **Last Updated By/Date** - Tom McGinn, June 2021
