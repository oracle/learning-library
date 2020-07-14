# Docker image for the WebLogic and Oracle Cloud Infrastructure Registry (OCIR)

## Before You Begin
### Objectives
- Sign in to Oracle Cloud Infrastructure
- Get Authentication Token to use Oracle Cloud Infrastructure Registry (OCIR)
- Accept Licence Agreement to use Oracle WebLogic Server image from Docker Store
- Pull Docker images for the operator and push to Oracle Cloud Infrastructure Registry (OCIR)

### Requirements
To complete this lab, you need to have the following:
- Login credentials and a tenancy name for the Oracle Cloud Infrastructure Console
- Login credentials for Docker
- Login credentials for Wercker
- Login credentials for Github

## **STEP 1**: Sign in to Oracle Cloud Infrastructure

- From any browser, enter the following url:

  [https://console.us-ashburn-1.oraclecloud.com/a/tenancy](https://console.us-ashburn-1.oraclecloud.com/a/tenancy)

- In the **Cloud Tenant** field, enter the tenancy name provided to you during the lab, and then click **Continue**.

    ![](./images/2019-08-13%2013_59_08-Oracle%20Cloud%20Infrastructure%20_%20Sign%20In.png " ")

- Under **Oracle Cloud Infrastructure**, enter your **username** and **password**, and then click **Sign In**.

  Be sure to use the correct user name, which is similar to `dsu01`.

  Please do not change your password.

  ![](./images/oci-sign-in.png " ")


## **STEP 2**: Get Authentication Token to use Oracle Cloud Infrastructure Registry (OCIR)

- Once you logged in click your name on top-rigth corner and select **User Settings**. 

  ![](./images/100/user_settings.png " ")

- Click Users
  
  ![](./images/100/user_settings1.png " ")

- You may see two users in the list, one that is named with just your email address, and another that is named `oracleidentitycloudservice`/your-email-address. **Choose the one that is named just your-email-address.**
  
  ![](./images/100/user_settings2.png " ")

- On the user details page select **Auth Tokens** in the left menu. Click **Generate Token**.
  
  ![](./images/100/auth_keys.png " ") 
  
  
-  Enter a friendly description for the auth token and click **Generate Token**.

  ![](images/100/ocir_token.png " ")

- The new auth token is displayed. **Copy** the auth token immediately to a secure location from where you can retrieve it later, because you won't see the auth token again in the Console. **Close** the Generate Token dialog.

 ![](images/100/ocir_token_save.png " ")

## **STEP 3**: Sign in to Docker Account

- Click [`Docker Login`](https://hub.docker.com/sso/start)

- Enter your account details and click **Login**.
  
  ![](./images/docker-sign-in.png " ") 

- If you don't already have one, obtain a Docker Store account, click Create Account.

  ![](./images/docker-sign-up.png " ") 

## **STEP 4**: Accept Licence Agreement to use Oracle WebLogic Server image from Docker Store

- If you have not used the base image [`Oracle WebLogic Server`](https://hub.docker.com/_/oracle-weblogic-server-12c) before, you will need to visit the [Docker Store web interface](https://hub.docker.com/_/oracle-weblogic-server-12c) and accept the license agreement before the Docker Store will give you permission to pull that image.

Open [https://hub.docker.com/_/oracle-weblogic-server-12c](https://hub.docker.com/_/oracle-weblogic-server-12c) in a new browser and click **Log In**.

![](images/100/01.docker.store.login.png " ")


- Click **Proceed to Checkout**.

![](images/100/03.docker.store.login.png " ")

- Complete your contact information and accept agreements. Click **Get Content**.

![](images/100/04.docker.store.login.png " ")

- Now you are ready to pull the  image on docker enabled host after authenticating yourself in Docker Hub using your Docker Hub credentials.

![](images/100/05.docker.store.login.png " ")

## **STEP 5**: Sign in to Github Account

- Click [`Github Login`](https://github.com/login)

- Enter your Github Account details and click **Login**.
  
  ![](./images/github-sign-in.png " ") 

- If you don't already have one, obtain a free Github Account, click Create Account.

  ![](./images/github-sign-up.png " ") 

## **STEP 6**: Pull Docker images for the operator and push to Oracle Cloud Infrastructure Registry (OCIR)

In this step you will fork the tutorial's source repository. The source repository contains the demo application deployed on top of WebLogic server, configuration yaml to quickly create Oracle Container Pipelines(CI/CD) application to build custom WebLogic image and few additional Kubernetes configuration files to deploy the custom WebLogic image.

- Open the [`WebLogic Tutorial Reference`](https://github.com/nagypeter/weblogic-operator-tutorial.git) repository in your browser. Click the **Fork** button at the left top area. Sign in to github.com if necessary.

![alt text](images/100/wercker/fork.png " ")

- Wait until the fork process is complete.

First create your Oracle Container Pipelines application. Oracle Container Pipelines acts as continuous integration tool which will produce WebLogic container image and uploads to Oracle Container Registry.

The following pipelines are predefined in the Oracle Container Pipelines configuration file ([wercker.yml](https://github.com/nagypeter/weblogic-operator-tutorial/blob/master/wercker.yml)):

- **build**: Default and mandatory pipeline to start the workflow. It builds the demo Web Application using Maven.
- **build-domain-in-home-image**: Pipeline which runs Docker build to create custom WebLogic container image. First time when no *latest* image available in repository it uses official WebLogic image from Docker Store as base image and runs WLST script to customise the image. Also copies the demo Web Application into the image and deploys using WLST. Once *latest* (tag) of the image is available in the repository then the workflow just builds the Web Application and update the *latest* image with the new application binaries. After the Docker build the pipeline produces a new image and pushes to the image repository. Thus every time when changes happen in the sources and committed to Github. The image tag will be the commit hash tag of the source changes  which triggered the new build process. Also the historically latest gets the *latest* tag as well.

- [Sign in to Oracle Container Pipelines (former Wercker)](https://app.wercker.com/) and click **Create your first application** button or the **+** icon at the top right corner and select *Add Application*.

NOTE! If you need to sign up to Oracle Container Pipelines do it with your Github account. Click the **LOG IN WITH GITHUB** button and authorise Oracle Container Pipelines application for your Github account. You can revoke Oracle Container Pipelines's authorisation request anytime using your Github's profile settings.

![alt text](images/100/wercker/add.png " ")

- Select the owner of the application. By default it is your Oracle Container Pipelines username, but it can be any organization where you belong to. Make sure the selected SCM is *GitHub*. Click **Next**.

![alt text](images/100/wercker/create.png " ")

- Select *weblogic-operator-tutorial* repository what you imported previously. Click **Next**.

![alt text](images/100/wercker/create1.png " ")

- Leave the default repository access without SSH key. Click **Next**.

![](images/100/wercker/create2.png " ")

- If you want you can make your application public if you want to share the application's status otherwise leave the default private settings. Click **Create**.

![alt text](images/100/wercker/create3.png " ")

The repository already contains a necessary `wercker.yml` but before the execution provide the following key/value pairs:

| Key | Value | Note |
|----------------|---------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `OCI_REGISTRY_USERNAME` | your cloud username |  The username what you note during user settings.  |
| `OCI_REGISTRY_PASSWORD` | OCIR Auth Token | The Auth Token you generated previously |
| `TENANCY` | Name of your tenancy |
| `REGION` | The code of your home region. See the [documentation](https://docs.cloud.oracle.com/iaas/Content/Registry/Concepts/registryprerequisites.htm#Availab) to get your region code. | e.g. `iad` - stands for *us-ashburn-1* `fra` - stands for *eu-frankfurt-1* |
| `DOCKER_USERNAME` | Your Docker Hub username | Necessary to pull official WebLogic Server image from Docker Store |
| `DOCKER_PASSWORD` | Your Docker Hub password | Necessary to pull official WebLogic Server image from Docker Store |

- Define these variables click **Environment** tab and enter keys and values. Remember that these values will be visible to anyone to whom you give access to the Oracle Container Pipelines application, therefore select **Protected** for any values that should remain hidden, including all passwords.

![alt text](images/100/wercker/create4.png " ")

- Click the **Worklflow** tab and then **Add new pipeline** to enable pipeline defined in *wercker.yml*.

![alt text](images/100/wercker/create5.png " ")

- Enter the name of the pipeline and the "YML Pipeline Name" as *build-domain-in-home-image*. Please enter exactly this name - because this name is hardcoded in the *wercker.yml*. Click **Create**.

![alt text](images/100/wercker/create6.png " ")

- Click again the **Worklflow** tab to get back to the editor page. Click the + sign after the mandatory *build* pipeline.

![alt text](images/100/wercker/create7.png " ")

- Leave the default branch(es) configuration and select the *build-domain-in-home-image* pipeline.

![alt text](images/100/wercker/create8.png " ")

- Your workflow should be similar:

![alt text](images/100/wercker/create9.png " ")

- Go to the **Runs** tab and click ***trigger a build now*** link.

![alt text](images/100/wercker/create10.png " ")

- To get more details about the current step click on the pipeline.

![alt text](images/100/wercker/create11.png " ")

- When the workflow is completed the WebLogic image is available in your image repository.

![alt text](images/100/wercker/create12.png " ")

- From the OCI Console navigation menu, select **Developer Services->Registry (OCIR)**.
  
![alt text](images/100/ocir.png " ")

In the registry you have to find a repository named like your Oracle Container Pipelines application (e.g. *weblogic-operator-tutorial*). If you open the repository for more details you  find two images. Technically the two images are the same, but got two tags. One of them is the git commit hash tag which is uniquely identify the image. The second *latest* tag applied because to have easier access to the historically latest release/image.

![alt text](images/100/wercker/create13.png " ")

- Now the WebLogic domain image is ready to deploy on Kubernetes using WebLogic Operator.

**You are now ready to move to the next lab: [Lab 200](LabGuide200.md)**