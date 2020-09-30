

## Introduction

Welcome to the Automated Code Inspection workshop. This workshop will walk you through application lifecycle management with embedded code review using SonarQube. It will showcase how SonarQube can save time and improve code quality directly inside the agile development process.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

- Create docker image and push it to Docker Hub.
- Create compute instance using Docker image.
- Test the application.

## Required Artifacts

For this lab you will need Github and Oracle Cloud account Hub Accounts. Use the following links to set up:

## Deploying the Application to Compute Instance

### **STEP 1**: Create Build Job to Create and Push Docker Image to Registry

- Continuing the previous lab, make sure to be in Developer Cloud Service Instance.
- Create Build Job. Click on **Builds** in left panel and then click **Create Job**.

    ![](images/400/1.png)

- Give name to job and select template.

    ![](images/400/2.png)

- Click on **git** in the Job configuration, click on **add Git** and then make sure to select correct git repository.

    ![](images/400/3.png)

- Click on **Steps** , **Add step** , select Docker and then **Docker login**.

    ![](images/400/4.png)

- Enter username and password of the docker hub account. **Note: If you don't have docker account, create one from [Docker Hub website](https://hub.docker.com)**

    ![](images/400/5.png)

- Again click on **Steps** , **Add step** , select Docker and then **Docker build**.

    ![](images/400/6.png)

- Enter Registry host, desired name for the image (twitter-feed), tag (latest) and source (we have it in git repo)

    ![](images/400/7.png)

- Once again click on **Steps** , **Add step** , select Docker and then **Docker push**.

    ![](images/400/8.png)

- Enter registry host and name of the image and then click **Save** on top of the page.

    ![](images/400/9.png)

- Click on **Build Now** to run the job and see the build logs to see if it is successful.

    ![](images/400/9-1.png)

- To confirm go to [Docker Hub website](https://hub.docker.com) and click on **repositories** in navigation bar.

    ![](images/400/10.png)

### **STEP 2**: Create Build Job to Run Docker Image in Compute Instance

- Create another Build Job. Click on **Builds** in left panel and then click **Create Job**.

    ![](images/400/1.png)

- Give name to job and select template.

    ![](images/400/11.png)

- Click on **Before Build** in Job configuration, **Add Before Build Action** and then select **SSH configuration**.

    ![](images/400/12.png)

- Paste the private key provided in git repo or paste the below key and select option **Setup files in ~/.ssh for command line tools**.

- Note: You can use your own keys but to keep the lab guide easy we are providing one for you.

    ![](images/400/13.png)

- Click on **Steps**, **Add Step** and select **Unix Shell**.

    ![](images/400/14.png)

- Paste the below command to the shell.

  _NOTE: Replace the IP address with the IP address of your JavaWebService compute image created in lab 050, docker image name from your docker hub._

  ```
  ssh -o StrictHostKeyChecking=no opc@ENTER_THE_IP_ADDRESS_HERE_OF_JavaWebService_INSTANCE << EOF
  sudo yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
  sudo yum-config-manager \
      --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum -y install docker-ce docker-ce-cli containerd.io
  sudo systemctl start docker
  sudo docker pull DOCKER_IMAGE_NAME
  sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
  sudo firewall-cmd --reload
  sudo docker run --detach -p 8080:8080 DOCKER_IMAGE_NAME
  exit
  EOF
  ```



- Paste the commands in Unix Shell and click **Save**.

    ![](images/400/15.png)

- Click on **Build Now** to run the Job. Check the logs for message.

    ![](images/400/16.png)

- To confirm everything is deployed successfully. Go to your **IP_address:8080/statictweets**.

    ![](images/400/17.png)
