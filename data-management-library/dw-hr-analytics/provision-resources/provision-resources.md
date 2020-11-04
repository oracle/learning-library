# Provision Resources

## Introduction

In this lab you will provision the resources required for this workshop.

Estimated Lab Time: 30 minutes

### Objectives

<!--Provision a stack comprising of an Autonomous Datawarehouse and an Analytics Cloud instance.-->
Provision an Autonomous Datawarehouse instance and an Analytics Cloud instance.

### Prerequisites

- Method 1
    - IDCS Access Token to provision an analytics instance as part of the stack.
    - Necessary permissions to provision the stack in a compartment.

- Method 2
    - Necessary permissions to provision an analytics instance and an autonomous database.

## **METHOD 1:** Using a Resource Manager Stack

In order to provision an analytics cloud instance as part of a **Resource Manager** stack, an IDCS access token is required. If you don't have the necessary privileges, then proceed to Method 2.

### STEP 1: Obtain IDCS Access Token

1. Login to the OCI console and go the navigation menu using the menu button in the top left.

    ![](./images/1.1.png " ")

2. Scroll down to the **Governance and Administration** section and under **Identity**, select **Federation**.

    ![](./images/1.2.png " ")

3. Click on the link to the **OracleIdentityCloudService**.

    ![](./images/1.3.png " ")

4. In the page that opens, click on the Service Console URL.

    ![](./images/1.4.png " ")

5. In the Identity Cloud Service Console, click on the user icon in the top right corner and select **My Access Tokens**.

    ![](./images/1.5.png " ")

6. If you have access to the relevant APIs, you should be able to select them, under the **Invokes Identity Cloud Service** radio button. Thereafter, enter the duration of validity of the token in minutes and click on the **Download Token** button.

    ![](./images/1.6.png " ")

**Note:** If you don't have access to the required APIs, follow **Method 2**.

7. Open the token.tok file that you just downloaded. Keep it handy because in a few minutes you will need to copy the contents of this file.

    ![](./images/1.7.png " ")

**Note:** You may follow the video [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/OVQA-GCUjlO9VwEdWqHSre02rNj4K6wZ3VsacpzsXNg/n/oradbclouducm/b/bucket-20200907-1650/o/mdw%20-%20idcs.mp4), if you are unsure of the steps above.

8. You may now close the Identity Cloud Service Console.

### STEP 2: Provision the Stack

1. In the navigation menu, scroll down to the **Solutions and Platform** section. Under **Resource Manager**, select **Stacks**.

    ![](./images/1.13.png " ")

2. Click on the **Create Stack** button.

    ![](./images/1.14.png " ")

3. Select the **Sample Solution** radio button. Then, click on the **Select Solution** button.

    ![](./images/1.15.png " ")

4. In the side menu that opens up, check the **Departmental Data Warehousing** solution and hit the **Select Solution** button.

    ![](./images/1.16.png " ")

5. Provide a name to the stack and hit **Next**.

    ![](./images/1.17.png " ")

6. On the **Configure Variables** screen, enter the admin password, database name and database display name.![](./images/1.18.png " ")

7. Check the **Auto Scaling** box to enable auto-scaling of the database. Enabling this is optional, but recommended. Also, enter 0.0.0.0/0 in the public IP address field.

    ![](./images/1.19.png " ")

8. Scroll down and provide a name to the analytics instance and paste the access token that you had downloaded, earlier. Now, hit **Next**.

    ![](./images/1.20.png " ")

9. Review all the details and click on the **Create** button.

    ![](./images/1.21.png " ")

10. Now that the stack has been created, click on **Terraform Actions** and select **Apply**. In the iframe that pops-up, click on **Apply**, again.

    ![](./images/1.22.png " ")

    ![](./images/1.23.png " ")

**Note:**  If you have followed the steps above the job should succeed without any issues. Keep an eye on the logs to monitor the progress. If the job fails, please fix the issues and proceed.

![](./images/1.30.png " ")

11. If everything goes to plan, you will see the following message at the bottom of the logs.

    ![](./images/1.31.png " ")

12. On the same page, you will find the **Associated Resources** under the **Reosurces** menu. Click on it to get the links to the provisioned resources.

    ![](./images/1.25.png " ")

13. Clicking on the links to the resources should take you to their pages.

**Note:** In case there is no link to get to analytics instance, follow the two steps given below, else proceed to the next lab.

14. From the navigation menu, under **Solutions and Platform**, go to **Analytics** and select **Analytics Cloud**.

    ![](./images/1.27.png " ")

15. Click on the analytics instance to get to its page. Thereafter, click on the **Open URL** button to access the instance.

    ![](./images/1.28.png " ")

    ![](./images/1.29.png " ")

## **METHOD 2:** Independently Provision the Resources

### STEP 1: Provision the Autonomous Data Warehouse

1. Login to the OCI console and go the navigation menu using the Menu button in the top left.

    ![](./images/2.1.png " ")

2. Choose **Autonomous Data Warehouse** from the **Oracle Database** section.

    ![](./images/2.2.png " ")

3. Click on the **Create Autonomous Database** button.

    ![](./images/2.3.png " ")

4. Choose a compartment, enter the **Display Name** and also enter a name for the **Database**. Leave everything else set to the default values.

    ![](./images/2.4.png " ")

5. Scroll down and provide a password for the administrator.

    ![](./images/2.5.png " ")

6. Thereafter, hit **Create Autonomous Database**.

    ![](./images/2.6.png " ")

7. The database should be up and running in a couple of minutes.

    ![](./images/2.7.png " ")

**Note:** Keep this page open or make note of how to get here, since you would need to visit this page for information needed to connect to the database.

### STEP 2: Provision the Analytics Cloud Instance

1. From the navigation menu, under **Solutions and Platform**, go to **Analytics** and select **Analytics Cloud**.

    ![](./images/2.8.png " ")

2. On the next page, click on the **Create Instance** button.

    ![](./images/1.28.png " ")

3. Choose a compartment and provide a name for the instance. Let everything else stay the same. Then click on **Create**.

    ![](./images/2.10.png " ")

4. The instance will be up in 12-14 minutes. Once the instance is available, click on the **Open URL** button to gain access to the instance.

    ![](./images/2.11.png " ")

You may now proceed to Lab 2.

## Acknowledgements
 - **Author** - Yash Lamba, Cloud Native Solutions Architect, September 2020
 - **Contributors** - Maharshi Desai, Frankie OToole, Clarence Ondieki, Shikhar Mishra, Srihareendra Bodduluri, Arvi Dinavahi, Devika Chandrasekhar, Shikhar Mishra,
 - **Last Updated By/Date** - Kay Malcolm, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.