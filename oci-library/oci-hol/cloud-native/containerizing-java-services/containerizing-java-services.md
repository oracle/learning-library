# Building, Containerizing Java REST Services

## Introduction

In this lab you will deploy a Java application using Docker. This will require you to setup Visual Builder Studio configurations of build job and run the job to deploy java REST application container to OKE.

Estimated time: 45 minutes

### Objectives
- Setup Visual Builder Studio Project and build job configuration
- Create a Docker image and then deploy java REST application
- Deploy Docker container to Oracle Kubernetes Engine

### Prerequisites
- Successful completion of previous labs

*In addition to the workshop*, feel free to watch the walkthrough companion video by clicking on the following image:
[](youtube:uty6BgUWeeA)

## **STEP 1**: Create Project and Setup Build VM
1.  Navigate to Visual Builder Studio by selecting **Platform Services**->**Developer**

  ![](images/44-1.png " ")

2.  Click the **Access Service Instance** for the **AppDev** instance

  ![](images/44-0.png " ")

3.  Click on **OCI Account** to validate the setup.

  ![](images/44-7.PNG " ")


4. If you're an Organization Administrator, you first create **Build VM templates** with software that your organization members use. After creating the templates, you allocate some Build VMs to each Build VM template. When your organization's members create jobs, they associate the Build VM template with each job.  Click on **Virtual Machine Templates** then **Create Template**.

  ![](images/45a.png " ")


5. You can create a new VM Template, specify a unique name to identify templates to be used for jobs.  Click **Create**.

  ![](images/45-1.png " ")

6. Once you have created your Build VM template, click on **Configure Software**.

  ![](images/45-2.png " ")

7. Add required software to run build job with latest versions available, for **Docker, Kubectl, OCIcli, Python, SQLcl**. Click **Done**.

  ![](images/45-3.png " ")


8. Next, Click on **Virtual Machines** then **Create VM** to add one to the project.

  ![](images/45-4.png " ")

9. Select the template you just created.  In this example it is named **Docker-kubernetes-template**.

  ![](images/45-5.png " ")


10. Create a **Project**.

  From the Organization page, you can create a project with a Git repository.

  ![](images/46-a.png " ")

11. Click **Create**, enter the Project name **Product-services**, click **Next**.

  ![](images/46-b.png " ")

12. Select **Empty Project** and click Next.

  ![](images/46-c.png " ")

13. Click **Finish**.

  ![](images/46-d.png " ")

  ![](images/46-e.png " ")

14. Once the Project services are provisioned, you land on the Project Home Page. From the Project Home page, you can view a summary of the project's actions, repositories, team members, and statistics.

  ![](images/46-f.png " ")


## **STEP 2**: Create Build Job to Build and Deploy Docker Container

In this step, you will clone the application code, edit the Kubernetes secret file for ATP username and password. Next, create and setup build job configuration to containerize java microservice code, push the docker image to Oracle Cloud Infrastructure Registry (OCIR) and deploy the image to run pod and service in Oracle Kubernetes Engine.


Add **Git Repository** in your VBS Project

1. On your Project Home, click **Repositories** and click **Create**.

  ![](images/46g.png " ")


2. Enter the repository name **product-catalog-service** and select **Import existing repository**, enter the Git repository listed below and click **Create**.

    ```
    <copy> https://github.com/sasankapdn/product-catalog </copy>
    ```


  ![](images/46-h.png " ")


  It will import the contents and you can access files from VBS Git.

3. Similarly, create second repository for user-catalog service code.

    ```
    <copy> https://github.com/sasankapdn/user-catalog </copy>
    ```

    ![](images/46-i.png " ")


4. Change the **DBusername, DBpassword and DBurl base64 coded** in the secret yaml files.  **product-svc-secret.yaml**, **user-svc-secret.yaml** files are applied to Kubernetes cluster, so that the ATP DB username, password and DBurl are configured with the application container.

5. Before we change the values in VBS Git, let's encode them into base64.

  From ATP DBs created in lab 50,

  Values Required:
    ```
    ATP:  ProductCatalog
          Username: Alpha
          Password: AppD3v0ps01_
          DBurl: jdbc:oracle:thin:@product_LOW?TNS_ADMIN=/helidon/wallet

    ATP:  UserCatalog
          Username: Alpha
          Password: AppD3v0ps01_
          DBurl: jdbc:oracle:thin:@user_LOW?TNS_ADMIN=/helidon/wallet
    ```

6. Go to OCI console, and click on cloud shell, once it is ready with your user directory, convert the values and save it in your notepad.

  **Note:**  If your ATP Database names are NOT **product** and **user**, please be sure to change them accordingly in the below commands.

    ```
    <copy> echo -n Alpha | base64 </copy>
    ```
    ```
    <copy>echo -n AppD3v0ps01_ | base64 </copy>
    ```
    ```
    <copy>echo -n jdbc:oracle:thin:@product_LOW?TNS_ADMIN=/helidon/wallet | base64 </copy>
    ```
    ```
    <copy> echo -n jdbc:oracle:thin:@user_LOW?TNS_ADMIN=/helidon/wallet | base64 </copy>
    ```


  ![](images/47-c.png " ")


  ![](images/47-d.png " ")



7. Now, go back to your VBS instance project, Select **product-catalog.git** from Git Section.


  ![](images/47-a.png " ")


8. Select **product-svc-secret.yaml** file. Edit the file by clicking on **Edit file** option from the right corner. Change the parameter value under data block for **dbUser**, **dbPassword** and **dbUrl** that you have encoded to base64 from cloud shell. **Commit** the changes.


  ![](images/47-b.png " ")


  ![](images/47-e.png " ")


9. Similarly, switch to **user-catalog.git**, select **user-svc-secret.yaml** file and edit the parameter values under data block for **dbUser, dbPassword** and **dbUrl** that you have encoded to base64. Commit the changes.

10. Change the docker image name you care going to create in your job build.
  Under, **product-services.git**, **edit** app.yaml file. And **Commit** the changes.

  ![](images/img-2.png " ")


  ![](images/img-3.png " ")


11. Change the value for parameter image as
    ```
    image: [region].ocir.io/[storage namespace]/product_catalog:{{BUILD_NUMBER}}

    ```


  For Region code: (see [Availability by Region](https://docs.cloud.oracle.com/en-us/iaas/Content/Registry/Concepts/registryprerequisites.htm#Availab))


  Storage Namespace: Refer to lab 50, Step 5.6.


  ![](images/img-4.png " ")



  ![](images/img-5.png " ")

12. Similarly, switch to **user-catalog.git**, edit app.yaml file, change the docker image name you care going to create in your job build.

  ![](images/50.png " ")

13. Change the value for parameter image as
    ```
    image: [region].ocir.io/[storage namespace]/user_catalog:{{BUILD_NUMBER}}

    ```

    **Commit** the changes.

    ![](images/51.png " ")


14. Create a **Build Job**

    ***3.1. Creating Product-catalog JAVA REST service docker container***

15. From left panel, click **Builds**. Create a new **job**.

    ![](images/48-a.png " ")

16. Enter a **Name**, select the template created earlier and click **Create**.

    ![](images/48-b.png " ")


    This lands you on the job **configure** section.

17. Add **Git**. Select **product-catalog.git**.  

    ![](images/48-c.png " ")


    ![](images/48-d.png " ")


18. Under **Steps**, Click the **Add Step**

    ![](images/48-e.png " ")


19. Select **OCIcli**

20. Enter values for **user ocid, Fingerprint, tenancy ocid, private key (pem format), region**. You can refer to Step 2.2.


    ![](images/48-f.png " ")

    ![](images/48-1.png " ")


21. Under **Common Build Tools** select  **Unix Shell**

    ![](images/48-2.png " ")

    You need product-catalog ATP ocid, admin password. This step will download the wallet.zip file and store it in required location. Replace these in this format.

    oci db autonomous-database generate-wallet --autonomous-database-id **ATP ocid** --password **password** --file Wallet_**ATP Database name**.zip

    ![](images/img-1.png " ")




    ```
    <copy>
    oci db autonomous-database generate-wallet --autonomous-database-id ocid1.autonomousdatabase.oc1.iad.abuwcljto2uskxs53rn5iuiw7doebwidhoh4p3dwc336qllbiwv5f --password AppD3v0ps01_ --file Wallet_ProductCatalog.zip

    unzip -o Wallet_ProductCatalog.zip -d build-resource/wallet
    git add .
    git commit -m"Updating git repo with ATP wallet zip file"
    git push --force
    </copy>
    ```

    ![](images/48-3.png " ")


22. Add the Step **Docker Login**

    ![](images/48-4.png " ")

    ```
    <copy>
    Registry Host: [region].ocir.io
    Username: [Storage namespace]/[username]
    Password: [Auth Token]
    </copy>
    ```
    For Region code: (see [Availability by Region](https://docs.cloud.oracle.com/en-us/iaas/Content/Registry/Concepts/registryprerequisites.htm#Availab))

    Storage Namespace: Refer to lab 50, Step 5.6.

    Username: Local user (non-federated)

    *Note: Go to OCI Navigation Menu > Identity > Users, you can notice 2 users with your name, refer non-federated user here. Select the user, scroll down and Select **Auth Token** from left panel.  Enter description, click Generate Token. **Save it in your notepad, as it will be only visible this one-time.***


    ![](images/48-6.png " ")


    ![](images/48-7.png " ")


    ![](images/48-8.png " ")


    ![](images/48-9.png " ")

23. Enter these values in Docker login parameters.

    ![](images/48-5.png " ")


24. Add the Step **Docker Build**

    ```
    Registry Host: [Region].ocir.io
    Image Name: [Storage Namespace]/[OCIR Name]
    Version Tag: $BUILD_NUMBER
    ```
25. For OCIR Name, go to OCI Navigation Menu > **Developer Services** > **Registry (OCIR)**.

26. Click Create Repository. '**product_catalog**' as Name and change Access to **Public**.

27. Similarly, you can create one more repository for the user service **user_catalog** as Name and change Access to **Public**.

    *NOTE: OCIR names does not take capital letters as valid names.*

      ![](images/48-11.png " ")


      ![](images/48-12.png " ")

28. Enter these values, Full Image name will get populated itself. Here *$BUILD_NUMBER* represents the VBS build number to create a new image every time the build is run, to retain backups of your old images.

      ![](images/48-10.png " ")


29. Add the Step **Docker Push**

    The values populate from the Docker build step.

      ![](images/48-13.png " ")


30. Add the Step **Unix Shell**

31. To get the command for your Kubernetes cluster kubeconfig generation. Go to OCI Navigation Menu > **Developer Services** > **OKE**.

32. Select your cluster, Click **Access Cluster**. And copy command and replace it in the script below.

      ![](images/48-15.png " ")

    ```
    <copy>
    mkdir -p $HOME/.kube
    oci ce cluster create-kubeconfig --cluster-id ocid1.cluster.oc1.iad.aaaaaaaaae4gcnbumvqwkodbgzqtcyjshftdczrrgu2dazdgmczdmmz --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0
    export BUILD_NUMBER=$BUILD_NUMBER
    export KUBECONFIG=$HOME/.kube/config

    kubectl apply -f product-svc-secret.yaml

    cat app.yaml | sed "s/{{BUILD_NUMBER}}/${BUILD_NUMBER}/g" | kubectl apply -f -

    kubectl get pods -A
    kubectl get svc -A
    </copy>
    ```

      ![](images/48-14.png " ")



33. Now, you are done with the job configurations. Click **Save**.

34. To run the job, click **Build Now**.

      ![](images/48-16.png " ")


      ![](images/48-17.png " ")


    Build gets assigned to the Build VM created earlier in Step 2.4.
35. You can check the logs from **Build Log**.


      ![](images/48-18.png " ")


    If you get the job status as **SUCCESSFUL**, it shows the deployment result in the logs.


      ![](images/48-19.png " ")


    You have successfully deployed your product-catalog JAVA REST service on Oracle Kubernetes Engine.


    ***3.2. Creating User-catalog JAVA REST service docker container***

    Now you can perform the same steps for you user-catalog service deployment.
    Make sure you **replace the following required configurations**.

36. To avoid creating similar steps again, you can use the same job build configuration, while creating a new Build Job. Select **Copy from Existing**. Click Create.

      ![](images/49-1.png " ")

    This lands you on the Job Configure section. All other steps will remain same.

37. Change **Git** to user-catalog.git.

38. Next, click **Steps** section.

      ![](images/49-2.png " ")

39. Change the **ATP ocid, file names for the wallet zip file(in lines 1 and 4)**.

      ![](images/49-3.png " ")

40. Change the repository to user_catalog in **Image Name**.

      ![](images/49-4.png " ")


      ![](images/49-5.png " ")

41. Change the **secret yaml name** in the shell script.

      ![](images/49-6.png " ")


42. Click **Save**.

43. Click **Build Now**.

    If the job status is **SUCCESSFUL**. You can track the build logs for deployment details.

      ![](images/49-7.png " ")

*You are ready to proceed to the next lab...*

## Acknowledgements

- **Author** - Divya Kashyap
- **Last Updated By/Date** - Kamryn Vinson, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
