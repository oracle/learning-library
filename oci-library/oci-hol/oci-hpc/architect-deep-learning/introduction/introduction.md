# Architecting Deep Learning Training Environments on Oracle Cloud Infrastructure

## Introduction

This lab explains why you should consider running machine-learning and deep-learning workloads on Oracle Cloud Infrastructure. It also provides a framework for IT administrators, machine-learning engineers, and data scientists to build solutions using Oracle Cloud Infrastructure. 

### About Deep Learning and High Performance Computing (HPC)
Building on-premises high-performance computing (HPC) environments for machine learning, deep learning, or other performance-intensive workloads can be complex and time consuming. The public cloud can provide a variety of benefits over this more traditional approach, including faster infrastructure updates, easier scaling of resources, lower capital expenditures (CapEx), and fewer personnel dedicated to basic infrastructure maintenance. But the cloud also provokes concerns around performance and cost for those who tried to run performance-intensive workloads on first-generation public clouds.

This validated solution guide explains why you should consider running deep learning workloads on Oracle’s Generation 2 Cloud. It then provides a framework for IT administrators, deep-learning engineers, and data scientists to build solutions using Oracle Cloud Infrastructure.

This guide can help you accelerate the building of cloud infrastructure for your deep learning workloads while providing guidance on customizing the architecture and security throughout. Additionally, it provides guidelines, code, and Terraform scripts for quickly setting up a proof of concept (PoC) using TensorFlow and NVIDIA GPUs for deep learning and image processing for autonomous driving, a rapidly growing area of focus for deep learning. 


**Estimated Lab Time: 6 hours**

### Objectives

In this lab, you will:
* Prepare your tenancy for the data science service using infrastructure as code
* Automation with Terraform
* Build a convolutional neural network in TensorFlow, running on OCI GPU compute instances, to classify traffic sign images from the German Traffic Sign Dataset
* Train a deep network to replicate the human steering behavior while driving, thus being able to drive autonomously on a simulator provided by Udacity

### Prerequisites

- An Oracle Cloud Infrastructure account with privileges to create a compartment as well as a stack.
- Familiarity with Oracle Cloud resources is helpful
- Familiarity with Data Science and AI/ML is helpful

## About this Workshop

- Lab 1: Prepare your tenancy for the data science service using infrastructure as code

- Lab 2: Build a convolutional neural network in TensorFlow, running on OCI GPU compute instances, to classify traffic sign images from the German Traffic Sign Dataset

- Lab 3: Train a deep network to replicate the human steering behavior while driving, thus being able to drive autonomously on a simulator provided by Udacity


#### All Done! This completes the demo for provisioning an HPC Cluster from Oracle MarketPlace Image.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca
* **Last Updated By/Date** - Harrison Dvoor (9/28/20)


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

**You may now proceed to the next lab**