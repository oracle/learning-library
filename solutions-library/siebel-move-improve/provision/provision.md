# Provisioning the Siebel Application

## Introduction

In this exercise, you will create your Siebel application by setting up the Siebel Marketplace image and then use Jenkins to deploy an instance of Siebel.

Estimated Lab Time: 1 hour 15 minutes

### Objectives

To deploy the Siebel Instance, in this lab, you will:
*   Launching Instance of Siebel from Marketplace
*   Deploy the Siebel Application
*   Generate a Jenkins URL
*   Deploy and access Siebel instance

### Prerequisites
* A user with 'manage' access to Networking and Compute, compartment, and marketplace access
* SSH key
* VCN setup from the previous lab

## **STEP 1**: Launching Instance of Siebel from Marketplace

1. Make sure you are on the Oracle Cloud Infrastructure site

2. Navigate to ***Oracle Cloud Infrastructure Marketplace*** by using the dropdown menu on the left side of your screen and clicking the ***Marketplace*** option under ***Solutions and Platforms***

  ![From the menu bar in OCI console, click on Marketplace](./images/2.png " ")

3. In the search bar type in siebel and hit search. Click on ***Siebel CRM 20.x install Container w/Sample Database*** image

  ![Select the Siebel CRM 20.x install Container w/sample database image option](./images/3.png " ")

4. In the instance page select the most up to date version and then select the compartment you made earlier. Then click ***Launch Instance***

  ![Select the desired compartment then select Launch Instance](./images/4.png " ")

5. In the Create Compute Instance page you will need to fill in additional info for your Instance

    a.  **Name:** You can name it whatever you like, such as "siebel_instance"

    b.  **Select compartment:** Select the compartment that you created earlier

    c.  **Configure placement and hardware:** You can leave this as it is by default for this Lab

    d.   For the next **Configure networking** section you will choose the ***SELECT EXISTING VIRTUAL CLOUD NETWORK*** option and choose the ***SELECT EXSISTING SUBNET*** option before selecting the Network and Subnet you created in the prevous lab

    Make sure that ***ASSIGN A PUBLIC IP ADDRESS*** is also selected since we will use this to deploy our Siebel application

    e. **Add SSH keys:** here you will need to selct the ssh key you created earlier. You can either use the

    *   ***CHOOSE PUBLIC KEY FILES*** and open the public key file you made if you know its location

        or you can use the

    *   ***PASTE PUBLIC KEYS*** and paste the data within the keyfile if you have the file open

    f.  **Configure boot volume:** You can leave this as default

    g. Now review your settings and click ***Create*** at the bottom of the page when you are ready

    ![Fill in desired name, compartment, AD, and leave everthing else as is](./images/5.1.png " ")
    ![Select existing virtual cloud network, selct existing subnet, select assign a public IP adress, add your own ssh key then click create](./images/5.2.png " ")

6. Now you will be taken to the Instance Page and will see that your newly created instance is provisioning

     Once you see the small orange box change to green your instance will have provisioned successfully and now you can move onto the next step in the Lab

     ![Once the orange box changes to a green box your intance will have been succesfully provisioned](./images/6.png " ")


## **STEP 2**: Deploying the Siebel Application

After you have created the instance, you have to generate two URLs:
*	Jenkins URL: To deploy Siebel application
*	Application domain URL: To create Siebel industry specific application

Generating Jenkins URL

1.	Copy the Public IP Address from your previously created Instance

  ![Copy the public IP adress of the instance you created ](./images/2.1.png " ")

2.	Add the port 8080 preceded with a colon and paste the URL in a browser window to open the Jenkins application like this "<public IP address>:port number"

    For example, you would type: 111.111.111.11:8080 into you browser search bar

    **Note:** If your instance was created recently you may not be able to access the Jenkins URL right away, it may take an additional 5 min before you can complete this step

3. Once you arrive at the Jenkins site you will enter the information as follows

  USERNAME AND PASSWORD :  siebel/oracle

  ![After reaching the site enter the username siebel, and password oracle. All lowercase](./images/2.3.png " ")

4. After you have logged in you will see the Jenkins Home Screen. Select the ***SiebelDeploy*** option from the list

  ![When logged in you will see this home screen, select siebel deploy](./images/2.4.png " ")

5. Now select the ***Open Blue Ocean*** Option from the dropdown on the lefthand side of the screen

  ![Select blue ocean from the left hand menu](./images/2.5.png " ")

6. Select the ***Run*** button to create your new instance

  ![SSelect the run button on the lefthand side of the screen](./images/2.6.png " ")

7. In the window that opens you can specify the Siebel version and Industry that you desire. For this Lab we will choose Siebel version ***20.8*** and select ***Sales*** as the industry; then click the ***Run*** button

  ![Select verion 20.8 , Then select Sales. Select sample version of docker](./images/2.7.png " ")

8. After hitting run you will see that your new Siebel instance is being created, by clicking on it you can see more details

    **This can take 40 minutes to fully deploy**

    ![Wait unti the instance shows that it was successfully deployed. When finished it will have the green circle](./images/2.8.png " ")

    Once it is finished provisioning you will see its status change to a green circle with a check signifying that it is complete and that you may move onto the next step

## **STEP 3**: Generating application domain URL

Generating the Application domain URL

1. You can create the application URL using the port 4430, that you opened in the previous lab, and the industry you selected while deployment

  **NOTE:** For this step you Google Chrome may not allow you to access the site, we recommend using an alternative such as Firefox for this step

  The url you will need to type into your browser's search bar should look like this:

  ```
https://<public IP address>:4430/siebel/app/<industry>/enu
```

  For example, if you selected Sales, your application URL for Sales industry  could be the following.

    https://111.111.111.11:4430/siebel/app/sales/enu

    **NOTE:** Make sure your url has ***"https"*** and not ***"http"*** at the beginning of it otherwise you will not obtain access

    ![Type the appropriate url into the firefox searchbar](./images/blast.png " ")

2. When accessing the url you may come across a "Potential Security Risk" warning message

    ![Click the advanced button on this warning screen](./images/bblast.png " ")

    Since this is the url and IP address that you created, you know that it is safe and that you can safely bypass the warning

    You can do this on Firefox by first clicking the ***Advanced Settings*** button and then clicking ***Accept Risk and Continue*** button

    ![Click the accept the risk and continue button](./images/aclast.png " ")

3. Now you should see the proper site where you can log in with the default Siebel credentials

  USERNAME AND PASSWORD :    SADMIN/Welcome1

  ![On this login screen enter the default Siebel credentials, username SADMIN andd the password Welcome1](./images/last.png " ")

  Please also note that the application URL will be specific to the Industry you select for deployment, for example, the URL could be:

  For Service - https://"your ip address":4430/siebel/app/callcenter/enu

  For Siebel Management Console (SMC) - https://"your ip address":4430/siebel/smc

# Extension to provision
Verify Siebel version on home screen
login home Page
from the health menu - check technical support Option
popup box will show Siebel version, db connection, etc.

In this lab you launched an instance of Siebel from the OCI marketplace, deployed the Siebel application, and then deployed the Siebel CRM Application.

***Congratulations*** on completing this interactive lab and integrating Siebel with OCI. Please continue to work within the OCI environment using our other tutorials and explore our countless other features and possibilities


## Acknowledgements
* **Authors**
  - JB Anderson, Cloud Engineering
  - Chris Wegenek, Cloud Engineering
  - Naresh Sanodariya, Cloud Engineering
* **Contributors** -  Arunkumar Ravichandran, Cloud Engineering
* **Last Updated By/Date** - Chris Wegenek, Cloud Engineering, Jan 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/migrate-saas-to-oci). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
