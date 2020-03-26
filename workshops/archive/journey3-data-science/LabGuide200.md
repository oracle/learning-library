![](images/200/200.JPG)  
Updated: August 13, 2017 for BDCSCE Version 17.3.1-20

# Lab: Setup R and Big Data Cloud

## Introduction

This lab will walk you through configuring the R environment for **Oracle Big Data Cloud (BDC)**.  

In particular, this lab will focus on installing **R**, **SparkR**, **RStudio Server**, and a variety of R packages and dependencies.


Please direct comments to: David Bayard (david.bayard@oracle.com)

## Objectives

- Configure R, SparkR, and RStudio Server to run on BDC

## Required Artifacts

- A running BDC instance and Storage Cloud Object Store instance, created as per the instructions in the New Data Lake Journey Lab 100.  These instructions included the use of a special "bootstrap.sh" script which setup the BDC environment for this workshop.
- **You completed the tutorials in the New Data Lake Journey Lab 200 Getting to know BDC**



# Connect to the BDC Console

**Make sure you completed the tutorials in the New Data Lake Journey Lab 200 Getting to know BDCS-CE before starting this lab.  They create certain objects (like hive tables and object store files) needed by this lab.**

## Steps

### **STEP 1**: Navigate/login to the Oracle Cloud My Services Dashboard  

![](images/200/snap0011988.jpg) 

### **STEP 2**: Navigate to the My Services page for your BDCS-CE cluster

![](images/200/snap0011989.jpg)  

### **STEP 3**: Launch the Big Data Cluster Console
- Launch the Big Data Cluster Console for your BDCS-CE cluster.  If this is your first time, you will likely need to allow your browser to accept the self-signed certificate for the web console application.
- You will be asked to provide a username/password.  Use the username and password you defined earlier when you created the BDCS-CE instance (the username defaults to bdcsce_admin).  
![](images/200/snap0012205.jpg)  






# Learn how to setup R, SparkR, and RStudio Server

## Open and run the "DataSci Tutorial 1 Setup for R SparkR RStudio" note in the notebook

### **STEP 1**: Click on the Notebook tab.  Then click on the "DataSci Tutorial 1 Setup for R SparkR RStudio" tutorial to open it. 

![](images/200/snap0012217.jpg) 

### **STEP 2**: Read and follow the instructions in the Tutorial

The commands in the tutorial will install R as well as numerious R packages.  This particular paragraph that installs R will take 20 minutes or so to run, so be patient for that step.

![](images/200/snap0012218.jpg)



# What you Learned

- Learned how to setup R, SparkR, and RStudio Server with BDCS-CE

# Next Steps

- Proceed to the next Lab to see R in action with BDCS-CE's Zeppelin and Spark components

# Want to Learn More?

- [R project](https://www.r-project.org/)

- [SparkR (R on Spark)](http://spark.apache.org/docs/latest/sparkr.html)