# Setup an 'on-premises' environment using the workshop image.

## Introduction: 

This lab walks you through setting up an environment to simulate an established SOA 12.2.1.3 on-premises environment, using a Compute instance on OCI deployed through the marketplace. 

At the end of this lab, you will have a simulated 'on-premises' environment running with an Oracle SOA Suite 12.2.1.3 VM , containing an Oracle Database 12c , WebLogic Server 12c and Jdeveloper 12.2.1.4, along with a demo application to be migrated.

Note: Jdeveloper 12.2.1.4 is required to upgrade the application code from 12.2.1.3 to 12.2.1.4 in order to migrate to the SOAMP 12.2.1.4 on OCI.

Estimated Lab Time: 15 min

### Objectives

In this lab you will:

- Launch the demo environment Marketplace image
- Check that the services are up and running

### Prerequisites

For this lab you need:

- A bare metal compute instance with at least 4 OCPUs (8 preferred) available to run the image.
- Microsoft Remote Desktop Client (or similar RDP client) installed to connect to the demo environment.

## **STEP 1:** Launch the Workshop Marketplace stack

- Navigate to [Workshop Environment Marketplace Stack](https://cloudmarketplace.oracle.com/marketplace/listing/84694612)

1. Click **Get App**

  <img src="./images/1-get-app.png"  width="100%">

2. Select OCI Region and Sign in to your Oracle Cloud Infrastructure Account

  <img src="./images/2-sign-in.png"  width="50%">

3. Select the compartment you prepared to run this workshop

  <img src="./images/3-soa-workshop-mp1.png"  width="100%">

4. Accept the Terms and Conditions and click **Launch**

  <img src="./images/4-soa-workshop-mp1.png"  width="100%">

5. Provide an optional name and description, and click **Next**

  <img src="./images/5-next.png"  width="100%">

6. Choose a shape

  The image will work on a VM shape but will be very slow. It is highly recommended to use a Bare Metal shape such as BM.Standard.E3.128 or BM.Standard.E2.x

  Make sure the shape you chose is available in your tenancy.

  <img src="./images/5-instance-shape.png"  width="70%">

7. Browse to your **SSH Public Key**

   To connect to the SOA servers via SSH, you need to provide a public key the server will use to identify your computer.

  <img src="./images/6-ssh-key.png"  width="70%">

8. Click **Next** and then **Create**

  <img src="./images/7-next.png"  width="100%">

  <img src="./images/8-job-running.png"  width="100%">

  It will take about 1 to 2 minutes to create the stack. 

8. When the job finishes, you can find the Public IP address of the instance at the bottom of the logs, or in the **Output** area. Make a note of this information.

  <img src="./images/outputs-mp-demo.png"  width="100%">

## **STEP 2:** Connect to the demo environment

*It will take another 4 to 5 minutes for all the services to come online.*

Connect to the instance using your RDP Client (examples are using Microsoft Remote Desktop Client)

1. Add a new host, providing the public IP gathered from the stack output.

    <img src="./images/rdp-add-host.png"  width="70%">

2. Connect, using username `oracle` and password `oracle`

3. If you have issues with display sizing, edit the connection and go to `Display` settings to adjust screen size.

## **STEP 3:** Launch the SOA domain

1. Click on `SOA and Compact Domain` on the VM desktop

    <img src="./images/soa-desktop.png"  width="100%">

2. Run the `Start soa_domain Admin Server` script

    <img src="./images/soa-admin.png"  width="100%">

3. Wait for the admin server to be running. This will take 2-3 minutes.

    You will see state changed to `RUNNING` in the logs 

    <img src="./images/soa-admin-running.png"  width="100%">

4. Run the `Start soa_domain SOA Server` script

    <img src="./images/soa-soa.png"  width="100%">

## **STEP 4:** Check the local environment is up and running

1. Once the domains are started open the firefox web browser and select the bookmark for EM, which points to `http://localhost:7001/em'
to open the EM console


2. Login using usename `weblogic`, and password `welcome1`

  <img src="./images/em-login.png" width="100%">

3. Check that the admin server and SOA domain are running (other domains will not be running and that is normal)

  <img src="./images/soa-desktop-em-status.png" width="100%">



## Acknowledgements

 - **Author** - Akshay Saxena, September 2020
 - **Last Updated By/Date** - Akshay Saxena, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
