# Setup Cloud Environment

## Introduction

In Lab 1 (as Derek) you will initiate the Oracle cloud environment that you will use to create and deploy your microservices applications. This environment will be contained within a cloud Compartment, and communication within the Compartment will be via a Virtual Cloud Network (VCN). The Compartment and VCN will isolate and secure the overall environment. 

To deploy these services, you will be using Terraform, a tool for building, changing, and versioning infrastructure safely and efficiently. It is an important tool for anyone looking to standardize IaaS (Infrastructure as a Service) within their organization.

Estimated Lab Time: 25 minutes

### Objectives
- Log into OCI tenancy.
- Setup your IAAS environment and create common components.
- Create a MySQL Database Service Instance

*We recommend that you create a notes page to write down all of the credentials you will need.*

## **STEP 1:** Prepare your Terraform Script for Execution

Terraform provides a reusable process for creating infrastructure. In some cases, like this one, you don't have to know anything about how the process works. You can deploy different pre-designed infrastructure designs for many different purposes, which frees up users to focus on their projects. This will create your cloud resources (VCN, Compute Image, Autonomous Transaction Processing Instance, among other things).

1.  We provide an archive containing the Terraform configuration and sample code. You can download it from [here: node-mysql-hol-tf.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/n/c4u03/b/labfiles/o/node-mysql-hol-tf.zip)

 *Note: Keep the file around! We will refer to it later!*

2. Log into the Oracle Cloud and on the OCI console, click on the hamburger menu upper left and scroll down to **Solutions and Platform**. Hover over **Resource Manager** and click on **Stacks**.

   ![](images/010.png " ")

3. Make sure the **Compartment** on the left side says root. If not, then change it to root. Then, click **Create Stack**.

  ![](images/011.png " ")

4. Select **My Configuration**, choose the **.ZIP FILE** button, Click on **Browse** and find the zipped **node-mysql-hol-tf.zip** file. Then, you can give your **Stack** a name (or accept default). You can also give a description if you'd like, but it is not necessary. Then click **Next**.

  ![](./images/zip-file.png)

5. You can configure different variables on this screen. A password for the MySQL user is suggested. You can change it according to your wishes, as long as you fulfill the requirements. **For this Hands-on-Lab the password will not be stored securely. Don't use a password you use elsewhere**.  Select Next.

  ![](images/terra02.png " ")

6. Click **create**.  Note the screen will freeze for a few seconds before returning...be patient.

  ![](images/terra03.png " ")

  ![](images/015.png " ")

## **STEP 2:** Create OCI Resources in Resource Manager

1. Now inside of the resource manager, hover over **Terraform Actions** and click on **Plan**.

  ![](images/terra04.png " ")

2. You can give the plan a name, or keep the default. Then click on **Plan** to begin.

  ![](images/017.png " ")

3. Wait for the plan to succeed.

  ![](images/018.png " ")

4. Return to `Stacks` upper left, select your stack, and select **Terraform Actions** and click on **Apply**.

  ![](images/018.1.png " ")

  ![](images/terra06.png " ")

5. You can give the **Apply** action a name, or keep the default. You can leave the other settings the same. Then click on **Apply**. **This will take about 15 minutes. Please be patient.**

  ![](images/020.png " ")

  ![](images/004.png " ")

6.  The job will take several minutes. When it completes, scroll to the top and click **Application Information**. That screen will contain data you are going to need in the next steps.

  ![](images/terra08.png " ")

  ![](images/terra09.png " ")

Copy the information from the different fields, so you have it available fot the next steps.

*Please proceed to the next lab.*

## Acknowledgements

- **Authors/Contributors** - Johannes Schlüter
- **Last Updated By/Date** - Johannes Schlüter, October 2020
- **Workshop Expiration Date** - October, 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 

