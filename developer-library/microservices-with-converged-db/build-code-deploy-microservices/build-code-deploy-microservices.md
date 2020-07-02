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
* Setup the OKE cluster and the ATP databases

## **STEP 1**: Create the cluster namespace

In order to divide and isolate cluster resources, you will create a cluster
    namespace which will host all related resources to this application, such as
    pods and services.

1. Log in to the Cloud Console and open the Cloud Shell by
    clicking the Cloud Shell icon in the top-right corner of the Console.

  ![](images/7feb61fbebb010b7acada8a1e8b5a742.png " ")

2. Create the `msdataworkshop` namespace using the following command:

    ```
    <copy>kubectl create ns msdataworkshop</copy>
    ```

  ![](images/0b897b3ec674bba2f8042287514cd9d5.png " ")

  You have successfully created the `msdataworkshop` namespace which is used for
  deploying the application code.

## **STEP 2**: Build the Microservices image from the GitHub repo

1. To work with application code, you need to download a GitHub repository using
    the following command. The Cloud Shell already has the `wget` command
    installed:

    ```
    <copy>wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/ZaegTuNX8_vVPyP6QF1W6LaMXdziREUN1U_8JUEU9Zw/n/c4u03/b/data-management-library-files/o/msdataworkshop-master.zip</copy>
    ```

2. Unzip the file you downloaded:

    ```
    <copy>unzip msdataworkshop-master.zip</copy>
    ```

3.  You need to compile, test and package the Helidon front-end
    application code into a `.jar` file using maven. The maven package is already installed in the
    Cloud Shell. Inside Cloud Shell go to the frontend helidon microservice
    folder.

    ```
    <copy>cd msdataworkshop-master/frontend-helidon</copy>
    ```

4.  Run `maven` to build the package using the following command. Since this is
    the first time maven is executed, nothing is cached, thus it will first
    download all the necessary libraries and bundles.

    ```
    <copy>mvn clean install</copy>
    ```

  The build should be completed in 1-2 minutes, and a target folder with the related Java files is created.

  ![](images/2826286b95e74bd51237859bd7d3d891.png " ")

5. Execute the following command to investigate the target folder.

    ```
    <copy>ls -al target/</copy>
    ```

  ![](images/a88b7e437c7a46e3b9878adb62942107.png " ")

## **STEP 3**: Push image to OCI Registry, deploy and access microservices

After you have successfully compiled the application code, you are ready to push it as a docker image into the OCI Registry. Once the image resides in the OCI registry, it can be used for deploying into the cluster. You are going to log into OCIR through the Cloud Shell using the following command.

1.  You will need the following parameters which you have already noted down in the previous Labs.

    - `REGION-ID` - is the Region identifier
    - `OBJECT-STORAGE-NAMESPACE` - is Object Storage namespace
    - `USERNAME` - is the username used to log in. If your username is federated from Oracle Identity Cloud Service, you need to add the `oracleidentitycloudservice/` prefix to your username, for example `oracleidentitycloudservice/firstname.lastname@something`

    ```
    <copy>docker login REGION-ID.ocir.io -u OBJECT-STORAGE-NAMESPACE/USERNAME<copy>
    ```

    *When prompted for password use the Auth token (msdataworkshoptoken) you generated.*

  ![](images/1bcf17e7001e44e1e7e583e61618acbf.png " ")

2.  Once successfully logged into OCIR, we can list the existing docker images. Since this is the first time logging into OCIR, no images will be shown.

    ```
    <copy>docker images</copy>
    ```

  ![](images/cc56aa2828d6fef2006610c5df4675bb.png " ")

3.  For convenience, let’s store some environment variables into the `.bashrc` file. Open `bashrc` file with `nano` editor. Alternatively, you can use the `vi` editor if you are familiar with `vi`.

    ```
    <copy>nano ~/.bashrc</copy>
    ```

  ![](images/36b9360ef7998ffe686346031227258f.png " ")

4. Append the following lines at the end of the file:

    ```
    <copy>export MSDATAWORKSHOP_LOCATION=~/msdataworkshop-master
    source $MSDATAWORKSHOP_LOCATION/shortcutaliases
    export PATH=$PATH:$MSDATAWORKSHOP_LOCATION/utils/
    export DOCKER_REGISTRY="REGION-ID.ocir.io/OBJECT-STORAGE-NAMESPACE/REPO-NAME"</copy>
    ```

  Where `REGION-ID` and `OBJECT-STORAGE-NAMESPACE` are the same as in the previous step, and `REPO-NAME` is the Repository full name you created in the OCIR Registry (`firstname.lastname/msdataworkshop`). You can use `Ctrl+SHIFT+V` to paste text into nano.

  ![](images/86828131170ee9c9fdb11fe1641ef34b.png " ")

  ![](images/05cb8e8493d83f0db1e36ca85ac84b40.png " ")

  Close nano with the commands `CTRL+X`, `SHIFT+Y`, and `ENTER`.

5. Source the newly created `.bashrc` file with the following command.

    ```
    <copy>source ~/.bashrc</copy>
    ```

  ![](images/185c88da326994bb858a01f37d7fb3e0.png " ")

## **STEP 4**: Build the Docker image

1.  You are ready to build a docker image of the front-end helidon application.
    Change directory into frontend helidon microservice folder:

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/frontend-helidon</copy>
    ```

  ![](images/418a175c8093375d4264d6cd5897ead9.png " ")

2.  Run the build script which will build the frontend-helidon application, store it in a docker image and push it to OCIR

    ```
    <copy>./build.sh</copy>
    ```

  ![](images/807b7c494dab6ccb6864c60344ca7e0e.png " ")

  After a couple of minutes, the image should have been successfully pushed into the repository.

  ![](images/cb413dce71ae945decf19e468a94a89e.png " ")

3.  Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Registry (OCIR)**.

  ![](images/efcd98db89441f5a40389c99e5afd4b5.png " ")

4. You should see the newly created image in the list. Click the repository with the new image.

  ![](images/b4a27ed98282369ffa60e48e6cea591b.png " ")

5.  To simplify the usage of this image and avoid the need to do `docker login` in
    the deployment yaml file or git CI/CD, we will change the image from Private
    to Public, by clicking **Actions > Change to Public**.

  ![](images/3df6ee1cf8469d3277b107b4aca6efab.png " ")

  ![](images/62015eda55591496a1becfe11063fac5.png " ")

6.  Go back to the Cloud Shell and run the deploy script from the same directory
    as build. This will create a new pod and service for this image in the OKE
    cluster `msdataworkshop` namespace:

    ```
    <copy>./deploy.sh</copy>
    ```

  ![](images/5b817258e6f0f7b55d4ab3f6327a1779.png " ")

7.  Once successfully created, check that the frontend pod is running:

    ```
    <copy>kubectl get pods --all-namespaces</copy>
    ```

  ![](images/bf1ec14ebd4cb789fca7f77bb2d4b2d3.png " ")

  Alternatively, you can execute the `pods` shortcut command:

  ![](images/d575874fe6102633c10202c74bf898bc.png " ")

8. Check that the load balancer service is running, and note the external IP
    address and port.

    ```
    <copy>kubectl get services --all-namespaces</copy>
    ```

  ![](images/ce67dfe171836b79a14533f479039ff5.png " ")

  Alternatively, you can execute the `services` shortcut command.

  ![](images/72c888319c294bed63ad9db029b68c5e.png " ")

9. You are ready to access the frontend page. Open a new browser tab and access
    the external page `http://<external-IP>:8080`:

  ![](images/0335beb6b95e66bef6b3a5154833094f.png " ")

10. Run the remaining build script to build and push the rest of the
    microservices images into the repository

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION ; ./build.sh</copy>
    ```

  ![](images/70e6b9bab9f2e247e950e50745de802d.png " ")

  In a couple of minutes, you should have successfully built and pushed all the images into the OCIR repository.

  ![](images/bdd2f05cfc0d1aac84b09dbe5b48993a.png " ")

11.  Go to the Console, click the hamburger menu in the top-left corner and open
    **Developer Services > Registry (OCIR)**.

  ![](images/efcd98db89441f5a40389c99e5afd4b5.png " ")

12. Mark all the images as public, as you did previously for the frontend image:

  ![](images/71310f61e92f7c1167f2016bb17d67b0.png " ")

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Paul Parkinson, Consulting Member of Technical Staff
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
