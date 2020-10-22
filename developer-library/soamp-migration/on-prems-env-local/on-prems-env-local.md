# Setup a local (on-premises) environment using Virtual Box

## Introduction: 

This lab will walk you through setting up a local SOA Suite environment to simulate an established on-premises environment, using **Oracle VM Virtual Box** on your local machine. 

At the end of this lab, you will have a local environment running with an Oracle SOA Suite 12.2.1.3 VM and a SOA Suite 12.2.1.4 quick start with Jdev 12.2.1.4.

Estimated Lab Time: 30 min to 1h+ depending on internet speed for download

### Objectives

In this lab you will:

- Install Oracle Virtual Box
- Download the SOA Suite 12.2.1.3 .ova VM image file.
- Startup Oracle VM Virtual Box demo environment
- Prepare your VM box with downloaded soa suite 12.2.1.3 .ova file
- Install the SOA Suite 12.2.1.4 quick start on your local machine

### Prerequisites

To run this lab, you will need :
- An oracle account to download the files from Oracle Technical Network (OTN)
- 25 GB of local storage available
- A minimum of 16 GB of RAM
- A minimum of 4 CPUs

## **STEP 1:** Download the SOA Suite 12.2.1.3 VM image

1. Download the SOA Suite 12.2.1.3 .ova image file from 

    [https://www.oracle.com/middleware/technologies/vmsoa-v122130.html](https://www.oracle.com/middleware/technologies/vmsoa-v122130.html)

    Download the file `Integration_12.2.1.3.0_OTN.ova (16.36 GB)`

    <img src="../../on-prems-env-local/images/download-soa12213-ova.png"  width="70%">


## **STEP 2:** Import the OVA image into Virtual Box

1. Start Oracle VM Virtual Box 

2. Go to **File -> Import Appliance**

    <img src="../../on-prems-env-local/images/provision-vm.png"  width="100%">

3. Select the `Integration_12.2.1.3.0_OTN.ova` file 

4. Click on **next**

    This may take several minutes

## **STEP 3:** Start the SOA 12.2.1.3 VM

Once the import is successfull

1. Click on the **Start** button to start your SOA 12.2.1.3 environment. 

2. Login to the VM with:

    - username: `oracle`
    - password: `oracle`

## **STEP 4:** Install SOA Suite 12.2.1.4 quick start

1. Go to 
    [https://www.oracle.com/in/middleware/technologies/soasuite/downloads.html](https://www.oracle.com/in/middleware/technologies/soasuite/downloads.html)


2. Click the `Download` button in front of `SOA Suite` product

    *note: You need an Oracle OTN account and be logged in, in order to reach the site*

    <img src="../../on-prems-env-local/images/download-soa-12214.png"  width="100%">

3. Select the following items in the list:

    - `V983385-01_1of2.zip`
    - `V983385-01_2of2.zip`
    
    <img src="../../on-prems-env-local/images/download-quickstart.png"  width="100%">

4. Select your platform

5. Click on **Download**

6. Run both the SOA Suite versions SOA Suite 12.2.1.3 VM and SOA Suite 12.2.1.4 local installation are working properly and j developer for both the versions are working fine.


## Acknowledgements

 - **Author** - Akshay Saxena, September 2020
 - **Last Updated By/Date** - Akshay Saxena, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
