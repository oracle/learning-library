# Intro to Containers Hands On Lab

This Hands on Lab (HOL) will take the participant through the basics of containerization, explore its advantages and introduce Docker technology with entry level exercises.  The topics to be covered in this 2 hour session are:

1.  [Intro to Basic Container Concepts](Participant-Guide.md#intro-to-basic-container-concepts)
2.  [Verify Docker Engine Hands on Lab Environment](Participant-Guide.md#verify-docker-engine-hands-on-lab-environment)
3.  [Hello Helloworld](Participant-Guide.md#hello-helloworld)
5.  [Create a Dockerfile and Docker Image](Participant-Guide.md#create-a-dockerfile-and-docker-image)
6.  [Push an Image to your Docker Hub Account](Participant-Guide.md#push-an-image-to-your-docker-hub-account)
7.  [Install Docker Compose](Participant-Guide.md#install-docker-compose)
8.  [Create Wordpress "stack"](Participant-Guide.md#create-a-wordpress-stack)
9.  [Basics of Persistent storage](Participant-Guide.md#basics-of-persistent-storage)
10. [Use Github and Docker Hub together to build an Image and Run the Container](Participant-Guide.md#use-github-and-docker-hub-together-to-build-an-image-and-run-the-container)
11. [Demo of Oracle Container Cloud Service Showing Participant's Containers](Participant-Guide.md#demo-of-oracle-container-cloud-service-showing-participants-containers)


### Requirements to Complete this HOL:

* A pre-configured Docker-Engine environment - See [Prerequisites](Prerequisites.md)

* Access to the Internet

* A laptop

* A text editor to keep notes and snippets as you go along

* A Docker Hub account

* A Github account

***

## Intro to Basic Container Concepts

A container is a runtime instance of a Docker image.

[https://docs.docker.com/engine/reference/glossary/#/container](https://docs.docker.com/engine/reference/glossary/#/container)

Docker is the company and containerization technology.

[https://docs.docker.com/engine/reference/glossary/#/docker](https://docs.docker.com/engine/reference/glossary/#/docker)  

Containers have been around for many years.  Docker created a technology that was usable by mere humans, and was much easier to understand than before.  Thus, has enjoyed a tremendous amount of support for creating a technology for packaging applications to be **portable and lightweight.**

However, there have been and still are variations on container technology.  Here are some of the technologies we have seen through the years.

History of Linux Containers:

<img src=images/002-container-history.png />


Now, let's look at how a virtual machine (VM) is different from a container.

While containers may sound like a VM, the two are distinct technologies. With VMs each virtual machine includes the application, the necessary binaries and libraries and the **entire guest operating system.**

Whereas, Containers include the application, all of its dependencies, but share the kernel with other containers and are not tied to any specific infrastructure, other than having the Docker engine installed on its host – allowing containers to run on almost any computer, infrastructure and cloud.  

<img src=images/002-vm-vs-container.png />


> *Note - at this time, Windows and Linux containers require that they run on their respective kernel base, therefore, Windows containers cannot run on Linux hosts and vice versa.*

Docker images are a collection of files, which have everything needed to run the software application inside the container.  However, they are ephemeral, meaning that any data that is written inside the container, while it is running, will not be retained.  

If the container is stopped and restarted from its image, the container will run exactly the same as the first time, absent of any changes made during the last run cycle.  Changes to the container either have to be made during the image creation process, using the Dockerfile that become part of the image, or data can be retained by mounting a persistent storage volume, from inside the container to the outside.  This will be explored further in the HOL exercises below. 

<img src=images/004-docker-images.jpg />


Jumping back a bit, there is a new nomenclature that Docker introduces, here are terms that you will need to be familiar with.  

Each of these Docker technologies will be explored in this HOL.  It's important to note that this core technology is open source.  There are other technologies in the greater ecosystem, that could be open source, or licensed or even a hybrid, with a paid support option.

<img src=images/005-docker-terms.jpg />


The Docker Engine is THE core piece of technology that allows you to run containers.  In order for a container to run on any Linux host, at a minimum, the Docker Engine needs to be installed.  Then the container can run on any Linux host where Docker Engine is installed, providing the benefit of portability, without doing any application specific configuration changes on each host.

<img src=images/004-docker-engine.jpg />


Ok, so those are some of the mechanics of the technology, but why is Docker popular among all types of IT people?  Let's look at these proof points from Developers and IT Ops.

<img src=images/004-why-containers.jpg />


Additionally, in speaking with hundreds of organizations that are exploring and using Docker, these are the core advantages that Docker brings.  

<img src=images/005-docker-usage.jpg />


All of this is part of a transformation of technologies along a number of fronts, and is the basis for modern agile application development.

<img src=images/006-evolution.jpg />

***

## Verify Docker Engine Hands on Lab Environment

In this first section you are going to verify that you are able to connect to your Docker Engine environment as requested in the [Prerequisites document](Prerequisites.md).  Please access the environment now, and execute the following commands at the terminal.

> *Note - if you are using one of the Worker Nodes in an Oracle Container Cloud Service instance, as your Docker Engine environment, [access it via SSH per these instructions](supplemental/Access-OCCS-VM-SSH.md)

**Optional** - for convenience, run as root, so that you do not have to preface everything with sudo (not applicable if you are running Docker for Windows):

```
$ sudo -s
```

Now, here is the Docker specific command to check what version is installed:

```
$ docker --version
```

If Docker is installed and running, you should see an output of something like this:

```
Docker version 1.1x.x, build 57bf6fd
```

***

## Hello Helloworld

Run Docker’s Hello-world example:

	
```
$ docker run hello-world
```

Since the "hello-world" image is not available locally on the host, the command automatically pulls the hello-world image from the public Docker Hub image repository and runs the container in the foreground.

<img src=images/2017-03-16_13-40-42.jpg />

***

**Congratulations, you have just run your first Docker container!**

List all containers: 

> *Note - the "- a" option = running **and** stopped*

```
$ docker ps -a
```
Notice that the hello-world container ran once and then exited:

<img src=images/2017-03-16_14-46-49.jpg />

***

In this exercise you will explore another Docker image from Docker Hub.

**Browse to another public image Helloworld example on Docker Hub.  Run it.**

Use this Docker Hub image:

[https://hub.docker.com/r/karthequian/helloworld](https://hub.docker.com/r/karthequian/helloworld)

Pull the image from the Docker Hub Registry:

>  *Note - observe how the layers are pulled individually.  Docker image files are composed of multiple layers, for more information, read the [Docker docs here about images and layers](https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/)*

```
$ docker pull karthequian/helloworld:latest
```

Copy/Paste the Docker Run command from the Docker Hub page and add a "-d" option so the container runs in "detached" mode:

> *Note - the "-d" option run the container in detached mode, as opposed to the foreground mode that you saw in the last exercise.  The benefit of this is that for longer running containers, it frees up your terminal window.*

```
$ docker run -d -p 80:80/tcp "karthequian/helloworld:latest"
```

Explore this Helloworld app in the browser.  Navigate to the IP of the Docker Host where it is running and note the number of visits: 

> *Note - the IP is the same as the Host that you are SSH’d into http://host_ip or on your localhost http://localhost (for the rest of this document, it may just be referred to as host IP or Docker host IP for simplicity)*


<img src=images/004-hello-world.png />

***

You are now actually using an application that is in the Docker container.  Refresh the browser and observe how the visits count increments.  This is a live application. A simple example, but an example of the experience of using an application running in a container, which is no different than if it was not running in a container.

> *Makes you wonder about how many apps that you are using on a day to day basis, may indeed be running in a Docker container?*

Now, look at the name that Docker has assigned the Helloworld container that is running.  

List all running containers:

```
$ docker ps
```

Notice that Docker has assigned a container name, something like "ecstatic_lamport" in the below?  What name did Docker give your container?  Remember this name, as we will use it in a bit.

<img src=images/2017-03-16_13-49-25.jpg />

***

> *Note - unless you specify a container name, Docker will assign a similar 2 part name automatically*

**Stop and Re-run Your Container with a More Descriptive Name**

Now, go back to the terminal window, stop the container and give it a more descriptive name, so that we could find it easier if there were many containers running.

Stop the Running Container - Replace **your_container** below with an actual name of your running container:

```
$ docker stop your_container
```

Now, remove the container with the "rm" command:

```
$ docker rm your_container
```

Check to be sure that the container has been removed:

```
$ docker ps -a
```

> *Note - containers can be stopped and removed by using their name **(if there are no dependent image layers)**, their long id or their short id*

Now run the container with a more descriptive name, such as "helloworld_app":

```
$ docker run -d --name helloworld_app -p 80:80/tcp "karthequian/helloworld:latest"
```

List all running containers again:

```
$ docker ps
```

> *Is the container easier to find now, especially that there is context to the name of the container?  Especially if there were many containers running?*

Stop and Remove the container:

```
$ docker stop helloworld_app

$ docker rm helloworld_app
```

We are done with this part of the HOL.

***

## Create a Dockerfile and Docker Image

In this exercise you will build your own image from a Dockerfile.

**About DockerFiles**

A Dockerfile is a recipe that starts with a base image, typically a thin Linux OS distribution such as Alpine Linux, and then layers on an app and configuration.  [According to Docker](https://docs.docker.com/engine/reference/builder/): 

*"Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succession."*

**Build the Docker image**

Use the [Docker Whalesay](https://hub.docker.com/r/docker/whalesay/) example to build your first image.  

Follow these steps:

From your home directory, make a directory to store your Dockerfile:

```
$ cd ~ 

$ mkdir mydockerbuild
```

Change to the new directory:

```
$ cd mydockerbuild
```

In Step 1.3, use VI or editor of your choice, like nano.  

Use VI, if you are on Oracle Linux:

> *Note - case is important in the file name "Dockerfile".  Use a capital D and lower case for the rest of the letters.*

```
$ vi Dockerfile
```

Create a text file named Dockerfile with these 3 lines:

> *Note - if you are using VI, press the "i" key first to enter insert mode, before you paste.

```
FROM docker/whalesay:latest

RUN apt-get -y update && apt-get install -y fortunes

CMD /usr/games/fortune -a | cowsay
```

In Step 1.8, after you are done adding the 3 lines to your Dockerfile with VI, save the file by typing the Esc key - colon - w (for write) - q (for quit):

	
```
esc : w q 
```

Verify the Dockerfile has the correct content:

```
$ cat Dockerfile
```

> *Note - the docs for VI are here: [https://www.cs.colostate.edu/helpdocs/vi.html](https://www.cs.colostate.edu/helpdocs/vi.html)*

Then per section 2, build your Docker image, be sure to include the "." at the end of the command:

```
$ docker build -t docker-whale .
```

Then per section 4, list the images on your host and run the docker-whale image as a container:

```
$ docker images
```

```
$ docker run docker-whale
```

Notice the output in the terminal, the container will run once, then stop.

<img src=images/2017-03-16_14-10-47.jpg /> 

***

## Push an Image to your Docker Hub Account

**Registries**

Registries store Docker images.  Using a registry is the first step towards moving Docker off the laptop.  The most widely used registry is the Docker Hub: [https://hub.docker.com](https://hub.docker.com) 

> *Note - in this exercise you will need a Docker Hub account to use the public Docker registry.  If you do not have one already, you can sign up for free, navigate to: [https://hub.docker.com/](https://hub.docker.com/)*

**Tag and Push your new image to the Docker Hub registry.  In this exercise username will be your Docker Hub account name.**

First, log into your Docker Hub account from the terminal:

```
$ docker login
```

When prompted, enter your Docker account username (lowercase), password and email

Now, tag and push your new docker-whale image to your account on Docker Hub

Substitute your Docker **username** below

```
$ docker tag docker-whale:latest username/docker-whale:latest
```

Push the Docker image to your account.  This will create a new repository called "docker-whale" for this image.

```
$ docker push username/docker-whale:latest
```

Navigate to your account page in Docker Hub via this URL, substituting your **username**:

[https://hub/docker.com/r/username](https://hub.docker.com/r/username)

Do you see the image that you pushed?

<img src=images/010-docker-hub.png />

***

Now, remove the local image and force the image to be pulled and run from the Docker Hub registry.

To do this, you must first remove the stopped container by using its short id, not its name.  Find the short id:

```
$ docker ps -a 
```

Copy the short id for the appropriate container, it will be similar to this format: ee31fe1dd8f8 and use the "rm" command to remove the container: 

```
$ docker rm short_id
```

Now that the container is removed, you can remove the image locally on the host, and force the container to be run from the image on the Docker Hub.  Use the "rmi" command to remove an image.

Remove the image locally that you pushed to the Docker Hub:

```
$ docker rmi username/docker-whale
```

Verify the images are removed from your host.  View all Docker images with the images command:

```
$ docker images
```

Now, run the image directly from your repository on Docker Hub, and force a new pull of the image, because the image does not exist locally:

```
$ docker run username/docker-whale
```

> *Note - if no tag is used, the default tag is "latest", and it is pulled from your registry*

<img src=images/2017-03-16_14-17-38-2.jpg />

***

**At this point please stop and remove all containers.  To do this for all containers, use these commands:**

```
$ docker stop $(docker ps -a -q)

$ docker rm $(docker ps -a -q)
```

***

## Install Docker Compose


**Introduction to Docker Compose**

What is Docker Compose, why use it?

According to Docker: *Docker Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a Compose file to configure your application’s services. Then, using a single command, you create and start all the services from your configuration.*

**Install Docker Compose.**

> *For simplicity, you will install Docker Compose v1.12 in a directory called "compose", under the root home directory to avoid any path issues with the variety of Linux environments that may be used in this HOL.  This is also where you will run Docker Compose locally in that directory and create your first docker-compose.yml file.*

Change to root home directory:

```
$ cd ~
```

Verify that you are in the root home directory:

```
$ pwd
```

Make a new directory called "compose":

```
$ mkdir compose
```

Change into this new directory:

```
$ cd compose
```

Then, use this curl command to install Docker Compose v1.12 locally, in that directory:

```
$ curl -L "https://github.com/docker/compose/releases/download/1.12.0/docker-compose-$(uname -s)-$(uname -m)" -o docker-compose
```

Change the executable permissions:

```
$ chmod +x docker-compose
```

Verify and check which version of Docker Compose was installed:

```
$ ./docker-compose --version
```

> *Note - for further information, please refer to these Docker docs at a later time: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)*
***

## Create a Wordpress "stack"

Follow these steps to create a simple Wordpress stack:

Use an editor or VI to create a file named "docker-compose.yml":

> *Note - just as with the Dockerfile above, case of the file name is important.  Use all lower case for "docker-compose.yml"*

```
$ vi docker-compose.yml
```

Copy / paste the following text, or YAML:

```
version: '2'

services:
   db:
     image: mysql:5.7
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: wordpress
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "80:80"
     restart: always
     volumes:
       - /var/www/html:/var/www/html:rw
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_PASSWORD: wordpress
volumes:
     db_data:
```


Save the docker-compose.yml:

If you are using  VI, save the file by typing the Esc key - colon - w (for write) - q (for quit):

	
```
esc : w q 
```

Verify the docker-compose.yml file has the correct content:

```
$ cat docker-compose.yml
```

Run the Wordpress stack by this command:

```
$ ./docker-compose up -d
```

**Verify the running stack, by visiting the Wordpress setup page.**

In your browser, copy the below URL, using your host IP, to initiate the Wordpress setup:

```
http://host_ip/wp-admin/install.php
```

> *Note - Docker for Mac users - if the following error is observed, try restarting the Docker service on the Mac, to allow writes to /var/www/html*

```
ERROR: for wordpress  Cannot start service wordpress: Mounts denied: 
The path /var/www/html
is not shared from OS X and is not known to Docker.
You can configure shared paths from Docker -> Preferences... -> File Sharing.
See https://docs.docker.com/docker-for-mac/osxfs/#namespaces for more info.
```

**Congratulations, you have successfully launched your first Wordpress app in Docker!**

For further info on this stack, see: [https://docs.docker.com/compose/wordpress/](https://docs.docker.com/compose/wordpress/) 

***

## Basics of Persistent storage

 **Understand Docker Volumes**

This section will explore data persistence through the use of host data volumes.

A full introduction to Docker volumes is located here: [https://docs.docker.com/engine/tutorials/dockervolumes/](https://docs.docker.com/engine/tutorials/dockervolumes/)

In short, unless a container volume is mounted to a persistent host volume, any data stored within the container will be lost when the container is removed.

So let's explore how data is persisted in the Wordpress stack we just used.

Most importantly, in the Docker Compose YAML file, we used 2 volume statements, one for Wordpress and one for the DB.  

For example, this statement in the YAML for Wordpress, allows for images to be retained in blog posts.  In this example, you are explicitly stating where the data is stored on the host volume.
```
     volumes:
       - /var/www/html:/var/www/html:rw
```

Plus this volume statement for the database.  In this example, you are letting Docker map where "db_data" is stored on the host volume:

```
     volumes:
       - db_data:/var/lib/mysql
 ```
 
The host volume is listed first, then the container volume, separated by a colon.  This binds any data written in the specified container volume path to the host volume.  When the container is stopped and rerun on the same host, it will pull any existing data from the host volume. 

*Now you know the magic that we will now explore.*

**Complete the Wordpress setup and create blog post.**

In your browser navigate to Host_IP and append it with the Wordpress initialization URL: /wp-admin/install.php like this:  

> *Note - this is the same setup URL you saw when you deployed with Docker Compose above.  You may already have this loaded in a browser tab.*


```
http://docker_host_ip/wp-admin/install.php
```

First, select your language:

<img src=images/033-wp-setup1.png />

***

Setup the Wordpress login details.  Be sure to keep the Username and Password in your notes:

<img src=images/034-wp-setup2.png />

***

Click the "log In" button to log into to Wordpress:

<img src=images/034-wp-setup2.png />

***

Login using the credentials you created earlier:

<img src=images/036-wp-login2.png />

***

Select "Write your first blog post" in the Next Steps section:

<img src=images/037-write-blog.png />

***

Create a sample blog post.  Include an image of your choosing, if you would like and click Publish:

<img src=images/038-publish-blog.png />

***

Click on the "Permalink" to navigate to the blog post:

<img src=images/039-permalink.png />

***

Copy the Permalink URL of the blog post and keep this in your notes, as you will need it later:

<img src=images/040-view-blog.png />

***

Stop and Remove the running Wordpress and Database containers by using their short id.

Remember this from a previous exercise:

```
$ docker ps -a

$ docker stop short_id

$ docker rm short_id
```

Repeat for next container until all are stopped and removed, or use the bulk removal that was shown before.


Verify in the browser that the Wordpress blog post is gone by refreshing the page:

<img src=images/043-refresh.png />

***

Redeploy the Wordpress stack:

```
$ ./docker-compose up -d
```

Navigate back to the blog post URL that you noted, in your browser and refresh the page:

<img src=images/047-refresh-blog.png />

***

The data persisted because it was written to the host volume, and then re-joined to the containers when they were re-deployed on the same hosts.


**Please stop and remove all containers before going to the next section:**

```
$ docker stop $(docker ps -a -q)

$ docker rm $(docker ps -a -q)
```

***


## Use GitHub and Docker Hub together to build an Image and Run the Container

**Requirements: user account for GitHub and Docker Hub**

> *Note - if you do not have a Github account, get a free one here: [https://github.com/join](https://github.com/join)* 

Now, you will explore another method of creating an image using GitHub and Docker Hub.

> *Note - in this exercise you will fork an existing hello-world like repository, that you will call hello-earth, then modify its web page: Index.html in GitHub to trigger an automated Docker image build in Docker Hub.  You will then verify the successful build and run the image as a container in your Docker environment.*


**To begin, fork this GitHub Docker001 repo to your own**

Log into you GitHub account: 

https://github.com/login

In your browser, navigate to this GitHub repository: 

https://github.com/oracle/cloud-native-devops-workshop/tree/master/containers/docker001


Select the "Fork" button in for the particular GitHub repository:

<img src=images/github-dockerhub_14.jpg />

***

This will automatically copy this repository to your own GitHub account, where you will be able to edit it as you need:

<img src=images/github-dockerhub_9.jpg />

***

Now, in your browser, in another tab, log into your Docker Hub Account: 

https://hub.docker.com/login


Within your Docker Hub account, select "Create Automated Build" in the Top Menu under the Create:

<img src=images/github-dockerhub_13.jpg />

***

This will prompt you to link your GitHub account, so that Docker Hub can pull the source code:

<img src=images/2017-03-16_10-41-09.jpg />

***

Select GitHub as shown here:

<img src=images/2017-03-16_10-41-14.jpg />

***

Select for both Public and Private repositories:

<img src=images/2017-03-16_10-41-23.jpg />

***

Again, within your Docker Hub account, select "Create Automated Build" in the Top Menu under the Create:

<img src=images/github-dockerhub_13.jpg />

***

Select Create Auto-build:

<img src=images/github-dockerhub_11-2.jpg />

***

Select the "cloud-native-devops-workshop" repository:

<img src=images/github-dockerhub-21.jpg />

***

Make the repository name "hello-earth" and add a Short Description and press Save:

> *Note - naming the repository will also result in the image name being "hello-earth", after you do the first build.*

<img src=images/github-dockerhub_10.jpg />

***

Within the Build Settings tab, enter "/containers/docker001/lab1" for the Dockerfile Location and press the "Save Changes" button: 

<img src=images/github-dockerhub-20.jpg />

***

Back in your GitHub account navigate to the URL where you have forked the above Docker001 repo, and specifically open the "lab1" folder.  Replace your GitHub username in the below URL.

https://github.com/*username*/cloud-native-devops-workshop/tree/master/containers/docker001/lab1

On the GitHub page, click on the link for "Index.html":

<img src=images/2017-03-16_11-15-12.png />

***

You are going to modify this Index.html to create a new "Hello Earth" web page, this will automatically trigger a new (and first) image build in Docker Hub.  You will then run the resulting image as a container to observe your changes.

Edit the page via the pencil icon:

<img src=images/050-edit-index.png />

***

Make the following changes to Line 12, replacing your own name and city where it says myName and myCity:

<img src=images/2017-03-16_11-19-42.jpg />

***

Scroll down and Commit your Changes.  Add a description and press the "Commit Changes" button:

<img src=images/052-commit-index.png />

***

This will trigger a new automated build in Docker Hub, which will run the Dockerfile, which incorporates the new changes in Index.html as part of the build process.  Status is seen in the "Build Details" tab.  You need to refresh the browser to see updates to the build status:  

> *Note - if the automated build does not happen automatically, you can just use the "Trigger" button in the Docker Hub - Build Settings tab to manually start an image build.*

<img src=images/github-dockerhub_3.jpg />

***

The build will take a few minutes to complete in Docker Hub.  When it does, Success will be noted in the Status column:

> *Note - you may need to refresh your browser tab to see the updated status.*

<img src=images/github-dockerhub_1.jpg />

***

When you have a successful built, go back into your Docker CLI environment, run the new container.  Replace your Docker Hub name for "username" in the below command:

```
$ docker run -d -p 80:80 "username/hello-earth"
```

Once the container is running, visit the docker host’s IP and observe your changes for a new hello-earth container that you just built and ran!

<img src=images/github-dockerhub_15.jpg />

***

Tweet to the world that you have created your own Hello Earth containerized app! 

> *Note - remember to use your Docker Hub account name where it says "username" in the tweet.*

```
Check out my Hello Earth #Docker app that I just created in my #OracleCode HOL.  It's in my Docker Hub https://hub.docker.com/r/username/hello-earth
```

**Congratulations!**  You have successfully completed this Hands On Lab!

***

## Demo of Oracle Container Cloud Service Showing Participant's Containers

Check out running your container in the Oracle Container Cloud Service:

* [Get Started for Free](https://cloud.oracle.com/tryit)

***

## Summary/Recap Pointer to Further Resources

* [Oracle GitHub](https://github.com/oracle/docker-images)

* [Oracle Images on the Docker Store](https://store.docker.com/search?q=oracle&source=verified&type=image)

* [Oracle Container Registry](https://container-registry.oracle.com)

* [Oracle Container Cloud Service Docs](http://docs.oracle.com/en/cloud/iaas/container-cloud/index.html)

Oracle Blogs:

* [Containers, Docker and Microservices](https://community.oracle.com/community/cloud_computing/containers-docker-and-microservices)

* [Container Cloud Service Blog](https://community.oracle.com/community/cloud_computing/infrastructure-as-a-service-iaas/oracle-container-cloud-service)

**DONE**

