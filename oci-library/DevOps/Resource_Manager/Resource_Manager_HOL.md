# Resource Manager


## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Practice 1: Configuring IAM to control user access in Resource Manager](#practice-1-configuring-iam-to-control-user-access-in-resource-manager) 

[Practice 2: Create Resource Manager Stack](#practice-2-create-resource-manager-stack)

[Practice 3: Execute Jobs: Plan, Apply, Destroy](#practice-3-execute-jobs-plan-apply-destroy)

**Note:** *Some of the UIs might look a little different than the screen shots included in the instructions, but you can still use the instructions to complete the hands-on labs.*


## Overview

The Oracle Cloud Infrastructure Resource Manager is a fully managed service that lets you provision infrastructure resources on Oracle Cloud Infrastructure using Terraform. You can bring in your Terraform template definition and easily create and manage your infrastructure resources. This allows you to use infrastructure-as-code to automate provisioning across all OCI resources including Compute, Networking,Load Balancers, Block and Object Storage. Resource Manager also integrates with Identity and Access Management (IAM) so you can define granular permissions for Terraform operations. It currently has support for CLI, SDK and Console. 


## Pre-Requisites

- Oracle Cloud Infrastructure account credentials (User, Password, and Tenant) 
- To sign in to the Console, you need the following:
  -  Tenant, User name and Password
  -  URL for the Console: [https://console.us-ashburn-1.oraclecloud.com/](https://console.us-ashburn-1.oraclecloud.com/)
  -  Oracle Cloud Infrastructure supports the latest versions of Google Chrome, Firefox and Internet Explorer 11
-  Basic concepts of Terraform

## Practice 1: Configuring IAM to control user access in Resource Manager

**Note:** You can skip the steps below if you are using an user with admin privileges. If this were a real production system, it's both more secure and practical to create additional groups with more granular permissions. For example, it is likely we'd need to create a development team group that can only use predefined stacks and run jobs against it (use-orm-stack and use-orm-job, respectively). [Check Best Practices for IAM](https://docs.cloud.oracle.com/iaas/Content/Security/Concepts/security_features.htm#IdentityandAccessManagementIAMService)

1. Create a Policy by clicking on **Menu** --> **Identity** --> **Policies**
2. Click **Create Policies**

   - **Name:** *orm-demo-admin-policy*
   - **Description:** *Admin policy over all Resource Manager Stacks and Jobs in the OCI-ORM compartment*
   - Add the following statements:
     - `Allow group orm-demo-admin-group to manage orm-stacks in compartment OCI-ORM`
     - `Allow group orm-demo-admin-group to manage orm-jobs in compartment OCI-ORM`
   - Click **Create**
  

## Practice 2: Create Resource Manager Stack

 A Stack represents definitions for a collection of OCI resources within a specific compartment. With this in mind, we're going to configure a new stack in the OCI-ORM compartment in the us-phoenix-1 region and name it "HA Load Balanced Simple Web App". As the stack's name suggests, its configuration files define the load balancing, networking, and compute resources to deploy the target architecture plus an HTTP server. 

 Download [HA Load Balanced Simple Web App](orm-lbaas-demo/orm-lbass-demo.zip) and save to your local machine.

1. Create a Stack by clicking on **Menu** --> **Resource Manager** --> **Stack**
2. Click **Create Stack**

   - **Name:** *HA Load Balanced Simple Web App*
   - **Description:** *Enter a description of your deployment*
   - **Upload Zip File:** *Upload the zip file [orm-lbass-demo.zip](orm-lbaas-demo/orm-lbass-demo.zip)*
   - **Variables:**
     - **KEY:** compartment_ocid 
     - **VALUE:** <*Enter the ocid of the compartment you want to deploy your HA Load Balanced Simple App*>
     - **KEY:** region
     - **VALUE:** us-phoenix-1
     - **KEY:** ssh_public_key
     - **VALUE:** <*Enter the content of your public ssh key*>
   - Click **Create**


    ![](img/image001.png)

3. Before moving on to executing a job, quickly review the newly configured stack and then click on the hyperlinked stack name. 
   
    ![](img/image002.png)

## Practice 3: Execute Jobs: Plan, Apply, Destroy

Jobs perform actions against the Terraform configuration files associated with a stack. You can perform 3 actions and they are plan, apply and destroy. Since Terraform command execution is not atomic, it is crucial to prevent any race conditions or state corruption from occurring due to parallel execution. To prevent this from happening, the Resource Manager ensures only one job can run against a stack at a given time against a single state file.

From the Stack Details page, we can completely manage the stack's configuration (i.e., update, delete, add tag/s, edit variables) and also download the zip archive containing the latest Terraform configuration - which can be especially helpful when troubleshooting.

1. Lets execute a plan by clicking on **Terraform Actions** --> **Plan** and enter the following information:

   - **Name:** *HA LB App Plan*
   - Click **Plan**

    ![](img/image003.png)
    ![](img/image004.png)

    **Note:** Once the modal closes, notice the job's state appears as "Accepted" - which indicates that the platform is spinning up resources needed for executing the command  - followed by "In Progress" and then either "Succeeded" or "Failed". Hovering over the vertical ellipses displays the menu items related to the job. From this menu (or by clicking on the hyperlinked job name) you can view the job details and its logs containing the Terraform output.

    ![](img/image005.png)

2. From the Job Details page, review the information and scroll through the logs.

    ![](img/image006.png)
  
3. Since the previous plan action succeeded, lets select the Apply from the Terraform Actions menu. Click on **Terraform Actions** --> **Apply**

    ![](img/image007.png)

4. Enter the following information:
   
   - **Name:** *HA LB App Apply*
   - Click **Apply**

    ![](img/image008.png)

5. The job state is updated as the job execution nears completion:
   
   ![](img/image009.png)
   ![](img/image010.png)
   ![](img/image011.png)

6. Once the apply action succeeds, verify the resources have been provisioned by reading the Terraform output contained with the logs or navigate to Networking and view the different resources that now exist (VCN, load balancer, subnets, etc.) and that the 2 instances are listed in Compute. 

    ![](img/image012.png)
    ![](img/image013.png)

7. Now that we've successfully applied our Terraform to build out our cloud resources, let's use the Resource Manager to tear it all down by clicking on **Terraform Actions** --> **Destroy** and enter the following information:

   - **Name:** *HA LB App Destroy*
   - Click **Destroy**
   
    ![](img/image014.png)
    ![](img/image015.png)

8. Once again, notice that the state change is reflected in the console:

    ![](img/image016.png)

9. The final step is to delete the stack by clicking on the Delete button on Stack Details. Click on **Menu** --> **Resource Manager** --> **Stack** Select the HA Load Balanced Simple Web App and then click **Delete Stack**

    ![](img/image017.png)
    ![](img/image018.png)