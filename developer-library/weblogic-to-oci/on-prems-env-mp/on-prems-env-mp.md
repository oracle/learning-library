# Setup an 'on-premises' environment using the workshop image.

## Introduction: 

This lab walks you through setting up an environment to simulate an established on-premises environment, using a Compute instance on OCI deployed through the marketplace. 

At the end of this lab, you will have a simulated 'on-premises' environment running with an Oracle 12c Database and WebLogic Server 12c with a domain containing 2 applications and a datasource.

Estimated Lab Time: 15 min

### Objectives

In this lab you will:

- Launch a demo Marketplace image
- Check that the services are up and running
- Log into the instance
- Create a SSH key pair

### Prerequisites

For this lab you need:

- A compute instance with 4 OCPUs available to run the image.

## **STEP 1:** Launch the Workshop Marketplace stack

- Navigate to [Workshop Environment Marketplace Stack](https://cloudmarketplace.oracle.com/marketplace/listing/82173888)

1. Click **Get App**

  <img src="./images/get-app.png"  width="100%">

2. Sign in to your Oracle Cloud Infrastructure Account

  <img src="./images/sign-in.png"  width="50%">

3. Choose a compartment

  <img src="./images/wls-workshop-mp1.png"  width="100%">

4. Accept the Terms and Conditions and click **Launch**

  <img src="./images/wls-workshop-mp2.png"  width="100%">

5. Click **Next**

  <img src="./images/next.png"  width="70%">

6. Paste your **SSH public key**

   To connect to the WebLogic servers via SSH, you need to provide a public key the server will use to identify your computer.

  <img src="./images/ssh-key.png"  width="50%">

   To output the public key information, use the following command from your local machine:
   ```
   <copy>
   cat ~/.ssh/id_rsa.pub
   </copy>
   ```
   Copy the output of the command (the whole multi-line output) and paste it in the form field for SSH key in the form

   the output will look something like this:

   ```bash
   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlkF23qLyfimJ9Vp4D9psp7bDOB8JvtY/pfYzFxIA2E4v6or+XhvMW5RDhX9Ba54zQNNDLvwUhStdXKkiMXJtEQJarFn45pGy/lyUQKFJolAdHBrXJsg5XWn4DxCFeQUQe1szVfmwDLAktAS14r5g76h3CcA8Kk/cNVqevxVChyejuuOdtAMoriIC8uKV+535qPs/GMiu0zR9aW4w1VodL5eHnXjqdgp8Fr21dVUVQ6of+s/ws0zlQUwghrNguDUqlggzG2mpLBHExypxCrJYmsb05uYjjqVlC3YCatj4nJTIHKLCFiYVY/b8AFkqwXV9EYlja5bjTmunM847dcR8H oracle@ad753161734c
   ```
   **Note:** Do not use the example above as the key: it is a different public key which is useless without the corresponding private key, and you will not be able to access your resources on OCI)

7. Click **Next** and then **Create**

  <img src="./images/job-running.png"  width="100%">

It will take about 1 to 2 minutes to create the stack. 

8. When the job finishes, you can find the Public IP address of the instance at the bottom of the logs, or in the **Output** area. Make a note of this information.

  <img src="./images/job-output.png"  width="100%">

## **STEP 2:**  Check the local environment is up and running

*It will take another 4 to 5 minutes for all the services to come online.*

The console will be available at `http://PUBLIC-IP:7001/console` (replace `PUBLIC_IP` with the Compute instance public IP) and the WebLogic admin user is `weblogic` with password `welcome1`

  <img src="./images/localhost-admin-console.png"  width="100%">

The **SimpleDB** application will be running at `http://PUBLIC-IP:7003/SimpleDB/` (substitute `PUBLIC-IP` with the public IP of the instance). It may take a minute or 2 after the admin console is up for the SimpleDB app to be running.

It shows statistics of riders of the Tour de France stored in the database, and looks like this:

  <img src="./images/localhost-simpledb-app.png" width="100%">

You may proceed to next steps while the environment is coming up, but make sure it is up before proceeding to the next lab.

## **STEP 3:** Log in to the 'on-premises' environment

*Most of the work will be done from the simulated on-premises environment deployed in the compute instance on OCI.*

1. To log into the instance, use:

    ```bash
    ssh opc@<public-ip>
    ```
    Replace the `<public-ip>` with the IP provided in the output of the provisioning job.

2. You will be prompted to add this IP to the list of known hosts. Enter `yes`

## **STEP 4:** Create a SSH key

*We'll need a SSH key pair to communicate with the WebLogic servers and the database on OCI. The public key will need to be provided when provisioning those resources. *

We'll create a SSH key pair in the default folder

1. Once on the compute instance on OCI, switch to the oracle user:

    ```bash
    <copy>
    sudo su - oracle
    </copy>
    ```

2. Create the SSH keypair

    ```bash
    <copy>
    ssh-keygen
    </copy>
    ```
    and just hit `Enter` (default) for all the prompts

3. You will find two files `id_rsa` and `id_rsa.pub` inside the folder `~/.ssh/` or `/home/oracle/.ssh/`

    `id_rsa` is the private key, which should never be shared, and will be required to connect to any OCI resource provisioned with the corresponding public key `id_rsa.pub`

    Note this key will be the default SSH key from the instance used for the on-premises environment.

**Note:** This is only to be done once. If you run it again, a new key will overwrite the previous one and you will lose access to any resource provisioned with that key.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
