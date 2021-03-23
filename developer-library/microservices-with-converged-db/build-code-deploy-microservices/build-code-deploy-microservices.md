# Build Code from GitHub and Deploy Microservices

## Introduction

This lab will show you how to build images, push them to Oracle Cloud
Infrastructure Registry and deploy the microservices on our Kubernetes cluster.
You will also clone a GitHub repository.

### Objectives

  -   Clone a GitHub repository
  -   Build and push an image to OCI Registry
  -   Deploy and access the front-end microservice

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* The OKE cluster and the ATP databases that you created in Lab 1


## **STEP 1**: Set values for workshop in the environment and source ~/.bashrc

1. Run `source addAndSourcePropertiesInBashrc.sh`

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION; source addAndSourcePropertiesInBashrc.sh</copy>
    ```

    ```
    <copy>source ~/.bashrc</copy>
    ```

## **STEP 2**: Build and push the Docker images

1. Run the `build.sh` script to build and push the
    microservices images into the repository

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION ; ./build.sh</copy>
    ```

  ![](images/70e6b9bab9f2e247e950e50745de802d.png " ")

  In a few minutes, you should have successfully built and pushed all the images into the OCIR repository.

  ![](images/bdd2f05cfc0d1aac84b09dbe5b48993a.png " ")

2.  Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Container Registry**.

  ![](images/efcd98db89441f5a40389c99e5afd4b5.png " ")

3. Mark all the images as public (**Actions** > **Change to Public**):

  ![](images/71310f61e92f7c1167f2016bb17d67b0.png " ")

## **STEP 3**: Build deploy and access FrontEnd UI microservice

1. Run `./setJaegerAddress.sh` and verify successful outcome.

 It may be necessary to run this script multiple times if the Jaeger load balancer has not been provisioned yet.

   ```
   <copy>cd $MSDATAWORKSHOP_LOCATION; ./setJaegerAddress.sh</copy>
   ```

2. Source the `.bashrc` file with the following command.

   ```
      <copy>source ~/.bashrc</copy>
   ```

  ![](images/185c88da326994bb858a01f37d7fb3e0.png " ")

3.  Change directory into `frontend-helidon` folder:

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/frontend-helidon</copy>
    ```

4. Run the build script which will build the frontend-helidon application, store it in a docker image and push it to Oracle Registry

    ```
    <copy>./build.sh</copy>
    ```

  ![](images/70e6b9bab9f2e247e950e50745de802d.png " ")

  After a couple of minutes, the image should have been successfully built and pushed into the OCIR repository.

  ![](images/bdd2f05cfc0d1aac84b09dbe5b48993a.png " ")

5.  Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Container Registry**.

  ![](images/efcd98db89441f5a40389c99e5afd4b5.png " ")

6. Mark all the images as public (**Actions** > **Change to Public**):

  ![](images/71310f61e92f7c1167f2016bb17d67b0.png " ")

## **STEP 4**: Start the frontend-helidon service

1.  Run the deploy script from the same directory
    as build. This will create the deployment and pod for this image in the OKE
    cluster `msdataworkshop` namespace:

    ```
    <copy>d $MSDATAWORKSHOP_LOCATION/frontend-helidon;./deploy.sh</copy>
    ```

   ![](images/5b817258e6f0f7b55d4ab3f6327a1779.png " ")

2.  Once successfully created, check that the frontend pod is running:

    ```
    <copy>kubectl get pods --all-namespaces</copy>
    ```

  ![](images/bf1ec14ebd4cb789fca7f77bb2d4b2d3.png " ")

  Alternatively, you can execute the `pods` shortcut command:

  ![](images/d575874fe6102633c10202c74bf898bc.png " ")

3. Check that the load balancer service is running, and write down the external IP
    address.

    ```
    <copy>kubectl get services --all-namespaces</copy>
    ```

  ![](images/frontendservicekubectloutput.png " ")

  Alternatively, you can execute the `services` shortcut command.

  ![](images/72c888319c294bed63ad9db029b68c5e.png " ")

4. You are ready to access the frontend page. Open a new browser tab and enter the external IP URL:

  `https://<EXTERNAL-IP>`

  Note that for convenience a self-signed certificate is used to secure this https address and so it is likely you will be prompted by the browser to allow access.
  
  You will then be prompted to authenticate to access the Front End microservices.  The user is `grabdish` and the password is the on created and stored in a vault secret in Lab 1 Step 4.
  
  ![](images/frontendauthlogin.png " ")
  
  You should then see the Front End home page. You've now deployed and accessed your first microservice of the lab!
  
  Note that links on Front End will not work yet as they access microservices that will be created and deployed in subsequent labs.

  We created a self-signed certificate to protect the frontend-helidon service.  This certificate will not be recognized by your browser and so a warning will be displayed.  It will be necessary to instruct the browser to trust this site in order to display frontend.  In a production implementation a certificate that is officially signed by a certificate authority should be used.
  
  ![](images/frontendhome.png " ")

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Paul Parkinson, Dev Lead for Data and Transaction Processing, Oracle Microservices Platform, Helidon
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

