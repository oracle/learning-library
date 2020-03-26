## Machine Learning on Oracle Cloud Infrastructure

## Table of Contents 

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

### H20ai Lab 

[Practice 1: Provision a GPU instance on OCI](#practice-1-provision-a-gpu-instance-on-oci)

[Practice 2: Access the GPU instance](#practice-2-access-the-gpu-instance)

[Practice 3: Install H2Oai in the GPU Instance](#practice-3-install-h2oai-in-the-gpu-instance)

[Practice 4: Access H2Oai application](#practice-4-access-h2oai-application)

[Practice 5: Loading an adult census dataset](#practice-5-loading-an-adult-census-dataset)

### TensorFlow Lab

[Practice 1: Open a second Gitbash window](#practice-1-open-a-second-gitbash-window)

[Practice 2: Pull the TensorFlow docker image](#practice-2-pull-the-tensorflow-docker-image)

[Practice 3: Use TensorFlow to recognize the visual contents of images](#practice-3-use-tensorflow-to-recognize-the-visual-contents-of-images)

[Practice 4: Try Oracle Cloud Infrastructure for FREE](#practice-4-try-oracle-cloud-infrastructure-for-free)

## Overview
For this Machine Learning session you will complete two Hands-on-Labs

- **H20ai Lab:** In this lab you will experience the first part of a typical Machine Learning process which is training the model, then you will execute the second part of the process which is known as inferencing. We are going to use a partner tool, H2O.ai on top of one of our **Pascal GPU Bare Metal machines** to run this lab.

- **TensorFlow Lab:** This is a demo to show TensorFlow Image Recognition using the power of our **Pascal GPU Bare Metal machine** in order to recognize the visual contents of images.

The key topics touched upon by both labs are:

- To showcase Nvidia-Docker as a means of containerising ML workloads to leverage GPU (because normal docker cannot  _see_  the GPU).
- To show how quickly the GPU can process ML image recognition workloads.

## Pre-Requisites 

- Access to a GPU instance in Oracle Cloud Infrastructure
- SSH Client
- Download the SSH key into your desktop from this link: https://bit.ly/2Ef9GE4


## H20.ai Lab

## Practice 1: Provision a GPU instance on OCI

1. Open your browser and nagivate to the OCI Console by clicking on: [http://bit.ly/ociash](http://bit.ly/ociash)
2. On the left corner click on the **Menu** then click **Compute**, choose a compartment you have permission to work in, and then click **Create Instance.**
3. In the Create Instance dialog box execute the following:
      - **Name:** H2Oai
      - **Availability Domain:** AD1
      - **Image Source:** Click on Change Image Source and select Image OCID. Enter the following image ocid: `ocid1.image.oc1.iad.aaaaaaaaikn6ub6heefqxbe5fkiv4otbfe6ivza6y7di5khnkxkyvf2bkdta`
      - **Shape:** Change the Shape and select VM.GPU3.4
      - **Instance Type:** Bare Metal
      - **Add SSH Key:** Choose the SSH file you downloaded before
      - **Virtual Cloud Network:** VCN-DEMO-AI
      - **Subnet:** subnet01 (regional)
      - Click **Create**
 

## Practice 2: Access the GPU instance

**3.** On Gitbash terminal use SSH command to connect to the GPU instance:

- **username**: *ubuntu*
- **IP address**: *Use the Public IP address of the instance you createdr*

```
# ssh -i ~/Downloads/gpu_id_rsa ubuntu@<Public_IP_Address> 
```

![](img/image000.png)

`Please enter your NGC APIkey to login to the NGC Registry`

_`<<Hit enter to skip>>`_

**_Hit Enter to skip_**


![](img/image001.png)

## Practice 3: Install H2Oai in the GPU Instance

**1.** Execute the following commands to pull H2O docker image:

``# sudo nvidia-smi -pm 1``

``# mkdir h2oai``

``# cd h2oai``

``# wget http://bit.ly/h2oai-docker``

``# docker load < dai-docker-centos7-x86_64-1.5.4-9.0.tar.gz``

This will take a few minutes to complete

**2.** Create the folder structure to support H2O.ai

``# mkdir data log license tmp``

**3.** Start the Driverless AI image using NVIDIA docker:

``# nvidia-docker run --pid=host --init --rm --shm-size=256m -u `id -u`:`id -g` -p 12345:12345 -v `pwd`/data:/data -v `pwd`/log:/log -v `pwd`/license:/license -v `pwd`/tmp:/tmp h2oai/dai-centos7-x86_64:1.5.4-cuda9.0 &``

![](img/h2oimage001.png)

This will keep H20.ai application running. Leave this gitbash open. 

## Practice 4: Access H2Oai application

**1.** Open a browser and access:

``http://<Public_IP_Address>:12345``

Scroll at the bottom of the page and Agree with the terms:

![](img/h2oimage002.png)

**2.** Enter the following credentials and click Sign In:

**Username:** admin
**Password:** admin

![](img/h2oimage003.png)

**3.** Click on Enter License and copy/paste the following trial license:

```
nHMJw_S6iDjOXcQ8GRbX_B_3YmIsQbDn0L5u8NtHG446g9gWh7AVttgeldLQEHF1vdLQ242NY3zK1pMS-EyG8_NI8CHMJkORkbbABn1vPQtKpLviOu169k8MGkc_riHZsR5OAFy5UB4c3W0bR16TtWPLhyNGHCh47LUCbRIuCfQYPAnPrRko9Ee_6tK0lrUNkPGZAYw3x8A0-FzlckJH4W7R8IozyCY2txUXspm7hwfyWHFnQPZSxNLwjZAbMQEJQ-7cMyB0i7ZWxRwKjDSIaEc1ZMcZy2QOqm9IuQO2LFp856IVqNNJbEibin7Way4pTli31xrYPgo-rQQVL_zU92xpY2Vuc2VfdmVyc2lvbjoxCnNlcmlhbF9udW1iZXI6MzE2MTMKbGljZW5zZWVfb3JnYW5pemF0aW9uOk9yYWNsZQpsaWNlbnNlZV9lbWFpbDpmbGF2aW8ucGVyZWlyYUBvcmFjbGUuY29tCmxpY2Vuc2VlX3VzZXJfaWQ6MzE2MTMKaXNfaDJvX2ludGVybmFsX3VzZTpmYWxzZQpjcmVhdGVkX2J5X2VtYWlsOmtheUBoMm8uYWkKY3JlYXRpb25fZGF0ZToyMDE5LzAzLzA3CnByb2R1Y3Q6RHJpdmVybGVzc0FJCmxpY2Vuc2VfdHlwZTp0cmlhbApleHBpcmF0aW9uX2RhdGU6MjAxOS8wMy8yOAo=
```

![](img/h2oimage004.png)
![](img/h2oimage005.png)

**4.** Click Save and it will redirect you to the home screen:


![](img/h2oimage006.png)

## Practice 5: Loading an adult census dataset

**1.** Click on Add Dataset and select Amazon S3

![](img/h2oimage007.png)

**2.** Select census_income

![](img/h2oimage008.png)

**3.** Select adult_test.csv and click to import selection

![](img/h2oimage009.png)

**4.** After the data is imported, click on **Click for Actions** and select **Visualize**. 

![](img/h2oimage010.png)

**5.** Select a few of the plots to see how the data interacts. For example **Correlation Graph**

![](img/h2oimage011.png)

**6.** Now lets launch an experiment. Click on **datasets** at the top of the page, then **click for actions** but this time select **Predict**

![](img/h2oimage012.png)

**7.** If a message appears asking if you want to do a tour of H2O, just click **No**.

**8.** Click **Select target column** and select **Age**

![](img/h2oimage013.png)
![](img/h2oimage014.png)

**9.** Make sure **Enable GPU** is highlighted in yellow and then click **Launch Experiment**

![](img/h2oimage015.png)


**10.** Click on **GPU Usage** on the right side of the screen to see GPUs working. This simulation will take about 15 minutes to complete. 


![](img/h2oimage016.png)


**NOTE**: Let this simulation running while you complete the TensorFlow lab. 


**11.** When the model is complete, click **Interpret this Model** 

![](img/h2oimage017.png)
![](img/h2oimage018.png)

**12.** On the left side of the page click on **Dashboard**

![](img/h2oimage019.png)


## TensorFlow Lab

## Practice 1: Open a second Gitbash window

**1.** Rgith click on your current gitbash window and select **New**

![](img/tensorimage000.png)

**2.** On terminal use SSH command to connect to the GPU instance:

- **username**: *ubuntu*
- **IP address**: *Use the IP address provided by your instructor*

```
# ssh -i ~/Downloads/gpu_id_rsa ubuntu@IPAddress 
```

![](img/image000.png)

`Please enter your NGC APIkey to login to the NGC Registry`

_`<<Hit enter to skip>>`_

**_Hit Enter to skip_**

## Practice 2: Pull the TensorFlow docker image

**1.** Run the following command to pull and run the docker image:

``# nvidia-docker run -dti -p 80:80 --restart always ramnathn/oci-nvidia-docker-gpu-tensorflow-demo node callpy.js``

**Note**: This will pull the docker image ``oci-nvidia-docker-gpu-tensorflow-demo`` from this repo ``ramnathn`` and it will have port 80 open. This will take around 5 minutes to complete.

![](img/image002.png)

**2.** Open a browser and access the TensorFlow application by typing: ``http://IPAddress`` 

![](img/image003.png)

**3.** Back to gitbash and type the following command:

```
# watch -n 1 nvidia-smi
```

This will show that the GPU is actually getting used by the image recognision process. Keep that terminal open and running.

## Practice 3: Use TensorFlow to recognize the visual contents of images

We will try to solve a problem which is as simple and small as possible while still being difficult enough to teach us valuable lessons. All we want the GPU instance to do is the following: when presented with an image, our system should analyze it and score the images. Our goal is for our model to pick the correct category as often as possible. This task is called image classification. 

For that we will use two images. Please download those images and save to your Desktop and unzip it:

- [cat image](https://raw.githubusercontent.com/flavio-santino/learning-library/master/oci-library/OOW-2018/ML-GPU/img/cat.jpg.zip)

- [navy image](https://raw.githubusercontent.com/flavio-santino/learning-library/master/oci-library/OOW-2018/ML-GPU/img/navy.jpg.zip)

**1.** Go back to your broswer where TensorFlow is running and click on **Choose File** at  uper-left corner of your screen:

![](img/image004.png)

**2.** Upload the cat image image first. Once you click upload, the app will run the TensorFlow inference classification process and display the image score. As you can see it was classified as cat. 

![](img/image005.png)

**3.** Now, lets upload our second image (navy.jpg). This image has more elements to show. You can notice that now, it recognize the military uniform, the suits and even the type of the tie!!

![](img/image006.png)


**Please help us to improve this LAB and provide your feedback by clicking here:** [https://www.surveymonkey.com/r/ML-LAB](https://www.surveymonkey.com/r/ML-LAB)


## Practice 4: Try Oracle Cloud Infrastructure for FREE 

Sign up for the free Oracle Cloud Infrastructure trial account. 
https://cloud.oracle.com/tryit

<img width="800" alt="image001" src="https://raw.githubusercontent.com/oracle/learning-library/master/oci-library/OOW-2018/EdgeLab/media/image34.png">

