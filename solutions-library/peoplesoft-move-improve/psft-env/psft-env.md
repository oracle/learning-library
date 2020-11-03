# Lab 7: Creating Environment in PeopleSoft

## Introduction

This lab walks you through the steps to a PeopleSoft Environment from the previously created environment template

Estimated Lab Time: 90 minutes

### Objectives

The purpose of this lab is to show you how to create a PeopleSoft Environment from an environment template in the PeopleSoft Cloud Manager.

In this lab, you will:
* Create a PeopleSoft Environment

### Prerequisites

1. A PeopleSoft Cloud Manager Instance

2. A PeopleSoft Environment Template 

## **STEP 1**: Creating a New PeopleSoft Environment

1. 	Navigate to Dashboard | Environments.  Click Create Environment button.

  ![](./images/e1.png "")

2. 	Provide a unique Environment Name - **MYPUMENV**. Select the Template that was created in previous section – **MYPUM**. Click **yes** for **Pause after infra creation**.  

  ![](./images/e2.png "")

3. Go to **Environment Attributes -> Region and Availability Domains -> Credentials**

  Give following values to the field.

  No. | Full Tier | Credentials
  --- | --------- | -----------
  1 | Gateway Administrator Password | Psft1234
  2 | Web Profile Password for user PTWEBSERVER | Psft1234
  3 | Database Connect Password | Psft1234
  4 | Weblogic Administrator Password | Psft1234
  5 | Database Administrator Password | **Psft1234#**
  6 | Database Access Password | Psft1234
  7 | Database Operator Password | Psft1234

  ![](./images/e3.png "")

  Leave the rest as default. You can also expand all sections under Environment Attributes. 

4. Scroll up and click Done on the top right to begin the environment creation process. 

  ![](./images/e4.png "")

5. Accept the license. 

  ![](./images/e5.png "")

6. Refresh the page and click on the arrow button -> Details.

  ![](./images/e6.png "")

7. Monitor the deployment logs under Dashboard -> Environments -> Environment Name -> Action Menu -> Details -> Logs

  ![](./images/cl.png "")

  You can also go to **Provision Task Status** to see detailed progress status for every step. Click on **Deployment Tasks**. If any step fails, you can change the attribute as per the error and start the process from where it failed.

    ![](./images/pts.png "")

8. Once environment creation is completed, you can click on arrow button -> Deploy to start provisioning.

  ![](./images/e9.png "")

9. Monitor the deployment logs under Dashboard -> Environments -> Environment Name -> Action Menu -> Details -> Logs

  ![](./images/e10.png "")

  You can also go to **Provision Task Status** to see detailed progress status for every step. Click on **Deployment Tasks**. If any step fails, you can change the attribute as per the error and start the process from where it failed.

    ![](./images/pts.png "")

10. After the environment up and running, you can perform a variety of actions on the environment by using the Related Actions button corresponding to each environment. 

  ![](./images/e11.png "")

  The actions can be:

    • **Details**: Select this option to view environment details and to perform additional actions on the environment such as performing a health check, applying a PeopleTools patch, viewing logs, and managing PUM connections.

    • **Start**: Select this option to start all the instances and then all the domains within them.

    • **Stop**: Select this option to stop all domains and shutdown all the instances. In case of database, only compute database instances are shutdown.

    • **Delete**: Select this option to remove the environment.

    • **Manage Node**: Select this option to scale environment up or down.

    • **Clone Environment**: Select this option to clone an existing environment.

    • **Refresh**: Select this option to refresh the database or the database, ps app home and ps cust home.  
  This option is only available for DBaaS environments.

    • **Backup and Restore**: Select this option to backup or restore an environment.

  NOTE: You can also login to your application by adding it's IP addess and host name in hosts file.

  Login credential: 

      ```
      Username : PS
      Password: Psft1234
      ```

You may proceed to the next lab.

## Acknowledgements
**Authors** 
- Rich Konopka, PeopleSoft Specialist, October 2020
- Megha Gajbhiye, Cloud Solutions Engineer, October 2020

**Last Updated By/Date** 
- Sara Lipowsky, Cloud Engineer, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
