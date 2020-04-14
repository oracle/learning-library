![](img/docker-title.png)  

## Table of Contents 
- [Table of Contents](#table-of-contents)
- [Lab Introduction](#lab-introduction)
- [Lab Assumptions](#lab-assumptions)
- [Section 1-Login to your Oracle Cloud Account](#section-1-login-to-your-oracle-cloud-account)
- [Section 2-Lab Setup](#section-2-lab-setup)
- [Section 3-Docker Basic Concepts](#section-3-docker-basic-concepts)
- [Section 4-Docker Networking Basics](#section-4-docker-networking-basics)
- [Section 5-Create an Oracle Database Container](#section-5-create-an-oracle-database-container)
- [Section 6-Create A Schema in Container Running Oracle Database and Login to EM Express](#section-6-create-a-schema-in-container-running-oracle-database-and-login-to-em-express)
- [Section 7-Deploy Application](#section-7-deploy-application)
- [Section 8-Change Application](#section-8-change-application)

## Lab Introduction 
Docker is a set of platform-as-a-service products that use OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their own software, libraries and configuration files; they can communicate with each other through well-defined channels.

Lab courtesy of NATD Solution Engineering Team.  Check out the original lab [here!](http://go.oracle.com/docker).

## Lab Assumptions
- Each participant has completed the Environment Setup lab and succesfully created a compute instance or has a Oracle Database marketplace instance running
- The Virtual Compute Network (VCN) has been created with the appropriate Ingress rules
- Each participant has created a docker hub [account](http://hub.docker.com)
- Participants are not logged onto Oracle's VPN
- Participants are using Chrome as the preferred browser and have installed Chrome's JSON formatter


## Section 1-Login to your Oracle Cloud Account 

1.  From any browser go to www.oracle.com to access the Oracle Cloud.

    ![](img/login-screen.png)

2. Click the icon in the upper right corner.  Click on **Sign in to Cloud** at the bottom of the drop down.  *NOTE:  Do NOT click the Sign-In button, this will take you to Single Sign-On, not the Oracle Cloud*

    ![](img/signup.png)    

3. Enter your **Cloud Account Name**: `c4u03` in the input field

    ![](img/login-tenancy.png)  

4.  Enter your **Username** and **Password** in the input fields and click **Sign In**

    ![](img/cloud-login.png) 

[Back to Top](#table-of-contents)

## Section 2-Lab Setup

1. Login to the ssh terminal

    ````
    ssh -i optionskey opc@<your ip address>
    ````

1.  OPTIONAL:  If you are running this on a compute instance that has Oracle already installed, you may need to shut down the listener.  If you do not have a listener running, proceed to the next step.

    ````
    sudo su - oracle
    ps -ef | grep tns
    lsnrctl status LISTENER
    lsnrctl stop LISTENER
    ps -ef | grep tns
    exit
    ````

2. You will use yum (a package management tool for Linux) to install the Docker engine, enable it to start on re-boot, grant docker privledges to the opc user and finally install GIT.  When prompted, press *Y* to download.  All of these steps will be performed as the root user.

    ````
    sudo -s
    yum install docker-engine
    usermod -aG docker opc
    systemctl enable docker
    systemctl start docker
    ````
   ![](img/docker/python1.png) 

    ![](img/docker/python2.png) 

3. Next, we are going to install git using yum as the root user

    ````
    yum install git
    ````
    ![](img/docker/installgit.png) 

4.  Verify the version by switching to the opc user

    ````
    su - opc
    docker version
    docker images
    git --version
    ````
    ![](img/docker/gitversion.png) 

5.  Place your server in permissive mode

    ````
    exit
    setenforce 0
    sestatus
    ````
    ![](img/docker/setenforce.png) 

6. Switch back to the opc user and verify you are the `opc` user

    ````
    su - opc
    whoami
    `````

[Back to Top](#table-of-contents)

## Section 3-Docker Basic Concepts

1.  Check the version of docker

    ````
    docker version
    ````
    ![](img/docker/dockerversion2.png) 

2.  Start your application, restclient, in docker on port 8002 in json format.  


    ````
    docker ps
    docker run -d -it --rm --name restclient -p=8002:8002 -e DS='json' wvbirder/restclient
    ````

    - "-d" flag runs the container in the background
    - "-it" flags instructs docker to allocate a pseudo-TTY connected to the container’s stdin, creating an interactive bash capable shell in the container (which we will use in a moment when we connect into the container)
    - "-h" We give the container a hostname "oracledb-ao" to make it easier to start/stop/remove, reference from other containers, etc
    - "-p" We map port 8002 from within the container to the same ports on the HOST for accessibility from outside of the container's private subnet (typically 172.17.0.0/16). This allows the container to be accessed from the HOST, for example. The default port for Oracle's tns listener is on port 1521 and port 5600 is used for HTTP access to Enterprise Manager Express
    - "--name" The name of the container will be "restclient"
    - "-v" This maps the directory where you downloaded the restclient setup.
    ![](img/docker/dockerps.png) 

3.  Find the public IP address of your instances.  Compute -> Instance. It is listed on the main page.  If you would like to do more exploration, it is also listed in the page for your instance.

    ![](img/docker/computeinstance.png) 

    ![](img/instance-public-ip.png)

    ![](img/docker/selectdboptions2.png) 

    ![](img/docker/dboptions2.png) 

4.  Open up a browser on your laptop and go to your public URL on port 8002.  Go to http://Enter IP Address:8002/products. Depending on whether you have a JSON formatter, you should see the products in your application, in RAW or FORMATTED format.  `Note:  If you are on the VPN, disconnect`

    ![](img/products2-8002.png) 

    ![](img/docker/products.png)    

5.  The `restclient` container was started earlier with the -rm option.  This means when stopping it will remove ALL allocated resources.  The `ps` command with the `-a` option shows the status of ALL containers that are running.  As you can see, there are no containers running.

    ````
    docker stop restclient
    docker ps -a
    ````
    ![](img/docker/restclient2.png)

 6.  Let's start another container on your compute instance's 18002 port.  Type the following command:

        ````
        docker run -d -it --rm --name restclient -p=18002:8002 -e DS='json' wvbirder/restclient
        docker ps -a
        ```` 
        ![](img/docker/restclient.png)

7.  Go back to your browser and change the port to 18002.

    ![](img/docker/18002.png)

[Back to Top](#table-of-contents)

## Section 4-Docker Networking Basics

Now that you know how to start, stop and relocate a container, let's see how to get information about the network.

1.  Inspect the network bridge that docker created for you out of the box.  This shows network information about all the containers running on the default bridge. We see that our restclient container is assigned IP Address 172.17.0.2. You can ping that address from your compute instance.

    ````
    docker network inspect bridge
    ````
    ![](img/docker/network.png)

2.  Ping that address for your restclient container from your compute instance.

    ````
    ping 172.17.0.2 -c3
    ````
4.  Stop your restclient container

    ````
    docker stop restclient
    ````  
[Back to Top](#table-of-contents)

## Section 5-Create an Oracle Database Container

1.  Verify your docker version
    ````
    cd ~
    docker version
    ````
2.  Make sure you are in the /home/opc directory.  You will clone some setup scripts from git.
    ````
    pwd
    git clone https://github.com/wvbirder/AlphaOfficeSetup.git
    cd /home/opc
    chmod -R 777 Alpha*
    ````

3.  Login with your Docker Hub credentials
    ````
    docker login
    ````
    ![](img/docker/section5step2.png)
4.  There are database setup files that you cloned in an earlier step.   Ensure the listener has stopped.  Let's see how easy it is to deploy an Oracle Database to a docker container.  Issue the command below.  
    ````
    docker run -d -it --name orcl -h='oracledb-ao' -p=1521:1521 -p=5600:5600 -v /home/opc/AlphaOfficeSetup:/dbfiles wvbirder/database-enterprise:12.2.0.1-slim
    ````
    ![](img/docker/section5step3.png)

    - -d runs the command in the background
    - -h assigns it the hostname oracleadb-ao
    - -p maps ports 1521 and 5600 (Enterprise Manager Express) inside the container to your compute instance. In an earlier step, we added ingress rules for these ports
    - --name is the name of the container
    - v maps the directory where you downloaded the setup files to the /dbfiles directory inside the container

5.  To watch the progress type the following command passing the name of the container:  orcl.  This takes time, **please be patient**.
    ````
    docker logs --follow orcl
    ````
    ![](img/docker/section5step4.png)

6.  When the database creation is complete, you may see "The database is ready for use". *The instance creation may happen quickly and that message may scroll past*. Press control-c to continue.

    ![](img/docker/section5step4b.png)

[Back to Top](#table-of-contents)

## Section 6-Create A Schema in Container Running Oracle Database and Login to EM Express

1.  To create the schema we need to "login" to the container.  Type the following:
    ````
    docker exec -it orcl bash
    ````
2.  Let's make sure the /dbfiles directory mapped earlier is writeable
    ````
    cd /dbfiles
    touch xxx
    ls
    ````
    ![](img/docker/section6step2.png)

3.  Now run the sql scipt from inside the container using sqlplus
    ````
    sqlplus / as sysdba
    @setupAlphaOracle.sql
    exit
    ````
    ![](img/docker/section6step3.png)

4.  Now that our schema is created, let's login to Enterprise Manager Express.  Enter the address below into your browser.  If you've never downloaded flash player, you may need to install it and restart your browser.
    ````
    http://<Public IP Address>:5600/em
    ````

5.  If prompted to enable Adobe Flash, click Allow.  Login using the credentials below.  Leave the container name field blank.  
    ````
    Username: sys
    Password: Oradoc_db1
    Check the "as SYSDBA" checkbox
    ````
    ![](img/docker/em-express.png)

    ![](img/docker/emexpress.png)    

6. Explore the database using EM Express.



[Back to Top](#table-of-contents)

## Section 7-Deploy Application

In this section, you will deploy an application, twitterfeed, that is stored in the hub.docker.com site under the account wvbirder.  You will then run the rest client using an oracle database as the data source.

1.  Make sure you have exited out of the docker container.  Download the docker image, twitterfeed, extract it and run the container.  The download is from the wvbirder docker hub account where this application is staged.
    ````
    docker run -d --name=twitterfeed -p=9080:9080 wvbirder/twitterfeed
    ````
    ![](img/docker/section7step1.png)
2.  Check to see which containers are running.  
    ````
    docker ps
    ````
    ![](img/docker/section7step2.png)
3.  Open up a broswer to see the application with the stream of texts.  http://Public IP address:9080/statictweets.  Expand to see the full json file.

    ![](img/docker/section7step3.png)
4.  Let's run the restclient with the Oracle Database as the datasource.
    ````
    docker run -d -it --rm --name restclient -p=8002:8002 --link orcl:oracledb-ao -e ORACLE_CONNECT='oracledb-ao/orclpdb1.localdomain' -e DS='oracle' wvbirder/restclient

    ````

5.  Go back to your broswer to see the application with the stream of texts.  http://Public IP address:8002/products

    ![](img/docker/twitterproducts.png)

6.  An application called AlphaOfficeUI has been staged in the docker hub account, wvbirder.  Let's download it, extract and run it.  Later on in this lab you will push a modified application up to your docker account.
    ````
    docker run -d --name=alphaofficeui -p=8085:8085 wvbirder/alpha-office-ui-js
    ````
    ![](img/docker/section7step6.png)

7.  Go back to your broswer to see the application running on port 8085.  http://Public IP address:8085.  Click on one of the products to see the details and the twitterfeed comments. 
   ![](img/docker/alphaoffice.png)

[Back to Top](#table-of-contents)

## Section 8-Change Application

This lab will show how you can share applications and make modifications in the container.  

1. Copy a background image from your compute instance into the filesystem of the container. 
    ````
    docker cp /home/opc/AlphaOfficeSetup/dark_blue.jpg alphaofficeui:/pipeline/source/public/Images
    ````

2.  wvbirder's container does not have vim (an editor) installed.  So you will configure it and use it to make changes to the css and html pages of the application.  First you need to login to the docker container using the command `docker exec`.
    ````
    docker exec -it alphaofficeui bash
    apt-get update
    apt-get install vim
    ````
    ![](img/docker/section8step1.png)
    
    ![](img/docker/section8step2.png)
3.  Verify the dark_blue.jpg file is in the container and then use vim to edit the html file for the main page in your application.  
    ````
    ls /pipeline/source/public/Images
    ````
4.  Use the vim editor to change the name of the application (between the H1 tags) to your name.
    ````
    vim /pipeline/source/public/alpha.html
    ````
    ![](img/docker/section8step4.png) 

5.  Let's edit the css file as well and change the background color of the app.  Change the bg image to the dark_blue.jpg image you copied into the container.
    ````
    vim /pipeline/source/public/css/alpha.css
    exit
    ````
    ![](img/docker/section8step5b.png) 

    **Old Version of File**

    ![](img/docker/section8oldversion.png) 

6.  Let's view the running application now.  Notice the name and the background has changed.

    ![](img/docker/section8step9.png) 

    **Old Version of Application**

    ![](img/docker/oldalphaoffice.png) 


7.  If you were working with a team and needed to get this updated online, you would commit it.  Let's commit this new docker image to your docker hub now.  Wvbirder thanks but we have our own Docker account.  Once commited, list the images.  Note that your image is now listed.
    ````
    docker commit alphaofficeui (your-dockerhub-account)/(image-name)
    docker images
    ````
    ![](img/docker/section8step5a.png)
    ![](img/docker/section8step5.png)    

8.  Let's start a container based on your image.  First we need to stop the existing container.
    ````
    docker stop alphaofficeui
    docker rm alphaofficeui
    ````
    ![](img/docker/section8step6.png)

9.  Let's download, extract and install the new container from your docker account
    ````
    docker run -d --name=alphaofficeui -p=8085:8085 (your-dockerhub-account)/(image-name)
    ````
    ![](img/docker/section8step7.png)
10. Go back to your broswer to view the application.  http://Public IP address:8085

11. Now let's push this image to your docker hub account
    ````
    docker push (your-dockerhub-account)/(image-name)
    ````

12.  Open up a new browswer tab and login to hub.docker.com.  Verify your new image was successfully pushed. 

Congratulations, this is the end of this lab.







   

