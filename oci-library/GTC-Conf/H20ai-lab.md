## Machine Learning on Oracle Cloud Infrastructure

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

### H20ai Lab 

[Practice 1: Provision a GPU instance on OCI](#practice-1-provision-a-gpu-instance-on-oci)

[Practice 2: Access the GPU instance](#practice-2-access-the-gpu-instance)

[Practice 3: Access H2Oai application](#practice-3-access-h2oai-application)

[Practice 4: Loading an adult census dataset](#practice-4-loading-an-adult-census-dataset)

### TensorFlow Lab

[Practice 1: Pull the TensorFlow docker image](#practice-1-pull-the-tensorflow-docker-image)

[Practice 2: Use TensorFlow to recognize the visual contents of images](#practice-2-use-tensorflow-to-recognize-the-visual-contents-of-images)

[Practice 3: Try Oracle Cloud Infrastructure for FREE](#practice-3-try-oracle-cloud-infrastructure-for-free)

## Overview
For this Machine Learning session you will complete two Hands-on-Labs

- **H20ai Lab:** In this lab you will experience the first part of a typical Machine Learning process which is training the model, then you will execute the second part of the process which is known as inferencing. We are going to use a partner tool, H2O.ai on top of one of our **Pascal GPU machines** to run this lab.

- **TensorFlow Lab:** This is a demo to show TensorFlow Image Recognition using the power of our **Pascal GPU machines** in order to recognize the visual contents of images.

The key topics touched upon by both labs are:

- To showcase Nvidia-Docker as a means of containerizing ML workloads to leverage GPU.
- To show how quickly the GPU can process ML image recognition workloads.

## Pre-Requisites 

- Access to a GPU instance in Oracle Cloud Infrastructure
- SSH Client

## H20.ai Lab

## Practice 1: Provision a GPU instance on OCI

1. Open your browser and navigate to the OCI Console by clicking on: [http://bit.ly/ociash](http://bit.ly/ociash)
2. Enter the following credentials:
    - **Cloud Tenancy:** hpctraininglab
    - **Username:** _Instructor will provide your username_
    - **Password:** *GTC_OCI_gpu_2019!*

    ![](img/login.png)

3. On the left corner click on the **Menu** then click **Compute** and **Instances**:
   
    ![](img/menu.png)

4. On the left side, choose a compartment your user has permission to work, and then click **Create Instance.**
   
    ![](img/compartment.png)
    ![](img/create_instance.png)

5. In the Create Instance dialog box enter the following information:
      - **Name:** H2Oai-demo
      - **Availability Domain:** AD2
      - **Image Source:** Click on **Change Image Source** and select **Custom Images**. Now select the **common** compartment and check mark the image **H2Oai-GPU-Image**. Click **Select Image**
  
      ![](img/select_image.png)

      - **Choose Instance Type:** Virtual Machine
      - **Choose Instance Shape:** Change the Shape and select VM.GPU3.1
      - **Add SSH Key:** Choose the SSH file name labkey-linux.pub from your Desktop Folder.
      - **Virtual Cloud Network Compartment:** Select **common** compartment
      - **Virtual Cloud Network:** VCN-GPU-DEMO
      - **Subnet Compartment:** Select **common** compartment
      - **Subnet:** subnet-gpu (Regional)
      - Click **Create**
  
     ![](img/instance_001.png)
     ![](img/instance_02.png)

## Practice 2: Access the GPU instance

1. Hit **Command+Tab** to switch to terminal and use SSH command to connect to the GPU instance:

   - **Username**: *ubuntu*
   - **IP address**: *Use the Public IP address of the GPU instance you created*


    ``# ssh -i ~/Desktop/labkey-linux ubuntu@<Public_IP_Address>``

    ``Please enter your NGC APIkey to login to the NGC Registry``

    _``<<Hit enter to skip>>``_


2. Check if your H2Oai docker is running by typing:

    ``# nvidia-docker ps`` 

3. Hit **Command+Tab** to switch back to your browser

## Practice 3: Access H2Oai application

1. Open a browser and access:

    ``http://<Public_IP_Address>:12345``

2. Scroll at the bottom of the page and Agree with the terms:

    ![](img/h2oimage002.png)

3. Enter the following credentials and click Sign In:

    - **Username:** admin
    - **Password:** admin

    ![](img/h2oimage003.png)

    ![](img/h2oimage006.png)

## Practice 4: Loading an adult census dataset

1. Click on Add Dataset and select Upload File

    ![](img/h2oimage007.png)

2. Select **adult.csv** file from Desktop Folder

3. After the data is imported, click on **Click for Actions** and select **Visualize**. 

    ![](img/h2oimage010.png)

4. Select a few of the plots to see how the data interacts. For example **Correlation Graph**

    ![](img/h2oimage011.png)

5. Now lets launch an experiment. Click on **datasets** at the top of the page, then **click for actions** but this time select **Predict**

    ![](img/h2oimage012.png)

6. If a message appears asking if you want to do a tour of H2O, just click **No**.

7. Click **Select target column** and select **Age**

    ![](img/h2oimage013.png)
    ![](img/h2oimage014.png)

8. Make sure **Enable GPU** is highlighted in yellow and **Accuracy** is set to **2** then click **Launch Experiment**

    ![](img/h2oimage015.png)

9.  Click on **GPU Usage** on the right side of the screen to see GPUs working. This simulation will take about 5 minutes to complete. 

    ![](img/h2oimage016.png)

10. When the model is complete, click **Interpret this Model** 

    ![](img/h2oimage017.png)
    ![](img/h2oimage018.png)

11. On the left side of the page click on **Dashboard**

    ![](img/h2oimage019.png)

## TensorFlow Lab

## Practice 1: Pull the TensorFlow docker image

1. Hit **Command+Tab** to switch to terminal and run the following commands to pull and run the docker image:
   
```
# sudo su
# echo nameserver 169.254.169.254 >> /etc/resolv.conf
# nvidia-docker run -dti -p 80:80 --restart always ramnathn/oci-nvidia-docker-gpu-tensorflow-demo node callpy.js

```

**Note**: This will pull the docker image `oci-nvidia-docker-gpu-tensorflow-demo` and will run the docker on port 80. This will take around 5 minutes to complete.

![](img/image002.png)

1. Open a browser and access the TensorFlow application by typing: `http://<Public_IP_Address>` 

![](img/image003.png)

3. Back to terminal and type the following command:

```
# watch -n 1 nvidia-smi
```

This will show that the GPU is actually getting used by the image recognition process. Keep that terminal open and running.

## Practice 2: Use TensorFlow to recognize the visual contents of images

We will try to solve a problem which is as simple and small as possible while still being difficult enough to teach us valuable lessons. All we want the GPU instance to do is the following: when presented with an image, our system should analyze it and score the images. Our goal is for our model to pick the correct category as often as possible. This task is called image classification. 

For that we will use two images. Please download those images and save to your Desktop and unzip it:

- [cat image](https://raw.githubusercontent.com/flavio-santino/learning-library/master/oci-library/OOW-2018/ML-GPU/img/cat.jpg.zip)

- [navy image](https://raw.githubusercontent.com/flavio-santino/learning-library/master/oci-library/OOW-2018/ML-GPU/img/navy.jpg.zip)

1. Go back to your broswer where TensorFlow is running and click on **Choose File** at uper-left corner of your screen:

![](img/image004.png)

2. Upload the cat image image first. Once you click upload, the app will run the TensorFlow inference classification process and display the image score. As you can see it was classified as cat. 

![](img/image005.png)

3. Now, lets upload our second image (navy.jpg). This image has more elements to show. You can notice that now, it recognize the military uniform, the suits and even the type of the tie!!

![](img/image006.png)

4.  After you finished this lab please go ahead and terminate your instance.
     
## Practice 3: Try Oracle Cloud Infrastructure for FREE 

Sign up for the free Oracle Cloud Infrastructure trial account. 
https://cloud.oracle.com/tryit

<img width="800" alt="image001" src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/OOW-2018/EdgeLab/media/image34.png">
