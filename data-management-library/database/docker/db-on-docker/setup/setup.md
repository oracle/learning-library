# Docker Setup and Basic Concepts

## Before You Begin

This lab walks you through the steps to setup Docker engine.  It also covers basic tasks in Docker.

### Background


### Prerequisites

Participant has completed the following labs:


## **Step 1:**  Install Docker Engine
1. Login to the ssh terminal using the Oracle Cloud Shell or your terminal of choice

    ````
    <copy>
    ssh -i optionskey opc@<your ip address>
    </copy>
    ````

2. You will use yum (a package management tool for Linux) to install the Docker engine, enable it to start on re-boot, grant docker privledges to the opc user and finally install GIT.  When prompted, press *Y* to download.  All of these steps will be performed as the root user.

    ````
    <copy>
    sudo -s
    yum install docker-engine
    usermod -aG docker opc
    systemctl enable docker
    systemctl start docker
    </copy>
    ````
    ![](images/python1.png) 

    ![](images/python2.png) 

## **Step 2:**  Install Git and Verify Docker Version
1. Next, we are going to install git using yum as the root user

    ````
    <copy>
    yum install git
    </copy>
    ````
    ![](images/installgit.png) 

2.  Verify the version by switching to the opc user

    ````
    <copy>
    su - opc
    docker version
    docker images
    git --version
    </copy>
    ````
    ![](images/gitversion.png) 

3.  Place your server in permissive mode

    ````
    <copy>
    exit
    setenforce 0
    sestatus
    </copy>
    ````
    ![](images/setenforce.png) 

4. Switch back to the opc user and verify you are the `opc` user

    ````
    <copy>
    su - opc
    whoami
    </copy>
    `````

## **Step 3:** Docker Basic Concepts

1.  Check the version of docker

    ````
    <copy>
    docker version
    </copy>
    ````
    ![](images/dockerversion2.png) 

2.  Start your application, restclient, in docker on port 8002 in json format.  


    ````
    <copy>
    docker ps
    docker run -d -it --rm --name restclient -p=8002:8002 -e DS='json' wvbirder/restclient
    </copy>
    ````

    - "-d" flag runs the container in the background
    - "-it" flags instructs docker to allocate a pseudo-TTY connected to the container’s stdin, creating an interactive bash capable shell in the container (which we will use in a moment when we connect into the container)
    - "-h" We give the container a hostname "oracledb-ao" to make it easier to start/stop/remove, reference from other containers, etc
    - "-p" We map port 8002 from within the container to the same ports on the HOST for accessibility from outside of the container's private subnet (typically 172.17.0.0/16). This allows the container to be accessed from the HOST, for example. The default port for Oracle's tns listener is on port 1521 and port 5600 is used for HTTP access to Enterprise Manager Express
    - "--name" The name of the container will be "restclient"
    - "-v" This maps the directory where you downloaded the restclient setup.
    ![](images/dockerps.png) 

3.  Find the public IP address of your instances.  Compute -> Instance. It is listed on the main page.  If you would like to do more exploration, it is also listed in the page for your instance.

    ![](images/computeinstance.png) 

    ![](images/instance-public-ip.png)

    ![](images/selectdboptions2.png) 

    ![](images/dboptions2.png) 

4.  Open up a browser on your laptop and go to your public URL on port 8002.  Go to http://Enter IP Address:8002/products. Depending on whether you have a JSON formatter, you should see the products in your application, in RAW or FORMATTED format.  `Note:  If you are on the VPN, disconnect`

    ![](images/products2-8002.png) 

    ![](images/products.png)    

5.  The `restclient` container was started earlier with the -rm option.  This means when stopping it will remove ALL allocated resources.  The `ps` command with the `-a` option shows the status of ALL containers that are running.  As you can see, there are no containers running.

    ````
    <copy>
    docker stop restclient
    docker ps -a
    </copy>
    ````
    ![](images/restclient2.png)

 6.  Let's start another container on your compute instance's 18002 port.  Type the following command:

    ````
    <copy>
    docker run -d -it --rm --name restclient -p=18002:8002 -e DS='json' wvbirder/restclient
    docker ps -a
    </copy>
    ```` 
    ![](images/restclient.png)

7.  Go back to your browser and change the port to 18002.

    ![](images/18002.png)

## **Step 4:** Docker Networking Basics

Now that you know how to start, stop and relocate a container, let's see how to get information about the network.

1.  Inspect the network bridge that docker created for you out of the box.  This shows network information about all the containers running on the default bridge. We see that our restclient container is assigned IP Address 172.17.0.2. You can ping that address from your compute instance.

    ````
    <copy>
    docker network inspect bridge
    </copy>
    ````
    ![](images/network.png)

2.  Ping that address for your restclient container from your compute instance.

    ````
    <copy>
    ping 172.17.0.2 -c3
    </copy>
    ````
4.  Stop your restclient container

    ````
    <copy>
    docker stop restclient
    </copy>
    ````

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Oracle NATD Solution Engineering
* **Last Updated By/Date** - Anoosha Pilli, April 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 
