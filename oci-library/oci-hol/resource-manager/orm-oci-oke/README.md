# orm-oci-oke
Oracle Resource Manager template to create a Quick Create OKE cluster
# Resource Manager

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Practice 1: Configuring IAM to control user access in Resource Manager](#practice-1-configuring-iam-to-control-user-access-in-resource-manager) 

[Practice 2: Create Resource Manager Stack](#practice-2-create-resource-manager-stack)

[Practice 3: Execute Jobs: Plan, Apply, Destroy](#practice-3-execute-jobs-plan-apply-destroy)

**Note:** *Some of the UIs might look a little different than the screen shots included in the instructions, but you can still use the instructions to complete the hands-on labs.*


## Overview

The Oracle Cloud Infrastructure Resource Manager is a fully managed service that lets you provision infrastructure resources on Oracle Cloud Infrastructure using Terraform. You can bring in your Terraform template definition and easily create and manage your infrastructure resources. This allows you to use infrastructure-as-code to automate provisioning across all OCI resources including Compute, Networking,Load Balancers, Block and Object Storage, Developer Resources such as OKE Clusters. Resource Manager also integrates with Identity and Access Management (IAM) so you can define granular permissions for Terraform operations. It currently has support for CLI, SDK and Console. 


## Pre-Requisites

- Oracle Cloud Infrastructure account credentials (User, Password, and Tenant) 
- To sign in to the Console, you need the following:
  -  Tenant, User name and Password
  -  URL for the Console: [https://console.eu-frankfurt-1.oraclecloud.com/](https://console.eu-frankfurt-1.oraclecloud.com/)
  -  Oracle Cloud Infrastructure supports the latest versions of Google Chrome, Firefox and Internet Explorer 11
-  Basic concepts of Terraform
-  Policy for OKE Cluster Creation and Deployment: <https://docs.cloud.oracle.com/iaas/Content/ContEng/Concepts/contengpolicyconfig.htm#policyforoke>
 

## Practice 1: Configuring IAM to control user access in Resource Manager

**Note:** You can skip the steps below if you are using an user with admin privileges. If this were a real production system, it's both more secure and practical to create additional groups with more granular permissions. For example, it is likely we'd need to create a development team group that can only use predefined stacks and run jobs against it (use-orm-stack and use-orm-job, respectively). [Check Best Practices for IAM](https://docs.cloud.oracle.com/iaas/Content/Security/Concepts/security_features.htm#IdentityandAccessManagementIAMService)

1. Create a Policy by clicking on **Menu** --> **Identity** --> **Policies**
2. Click **Create Policies**

   - **Name:** *orm-admin-policy*
   - **Description:** *Admin policy over all Resource Manager Stacks and Jobs in the sandbox compartment*
   - Add the following statements:
     - `Allow group orm-admin-group to manage orm-stacks in compartment sandbox`
     - `Allow group orm-admin-group to manage orm-jobs in compartment sandbox`
   - Click **Create**
  

## Practice 2: Create Resource Manager Stack

 A Stack represents definitions for a collection of OCI resources within a specific compartment. With this in mind, we're going to configure a new stack in the sandbox compartment in the us-phoenix-1 region and name it "Quickly Create an OKE Cluster". As the stack's name suggests, its configuration files create an OKE cluster with a suggested network configuration. The default is to create a private OKE cluster with worker nodes in a private subnet. The public option will create an OKE cluster with worker nodes in a public subnet.

 Download [ORM OKE Quick Create ](orm_oke_quick_create.zip) and save to your local machine.

1. Create a Stack by clicking on **Menu** --> **Resource Manager** --> **Stack**
2. Click **Create Stack**

   - **Select a Terraform Configuration (.zip) File to Upload:** *Upload the zip file [orm_oke_quick_create.zip](orm_oke_quick_create.zip)*
   - **Name:** *Quickly Create an OKE Cluster*
   - **Description:** *Quickly create a cluster with default settings, also creates a dedicated network*
   - **Create in Compartment:** *sandbox*
   - **Terraform Version:** *0.12.x*
    
    ![](img/CreateStack01.png)
    
3. Click **Next**   
   - **Configure Variables:** (Information gathered from variables.tf file in orm_oke_quick_create.zip)
     - **TENANCY_OCID:** ocid1.tenancy.oc1..aaaaaaaa... <*The OCID of the tenancy*>
     - **COMPARTMENT_OCID:** ocid1.compartment.oc1..aaaaaaaa... <*The OCID of sandbox compartment*>
     - **REGION:** eu-frankfurt-1 
     - **CLUSTER_NAME:** tfTestCluster
     - **VCN_CIDR:** 10.0.0.0/16
     - **CLUSTER_OPTIONS_ADD_ONS_IS_KUBERNETES_DASHBOARD_ENABLED:** Checked
     - **CLUSTER_OPTIONS_ADD_ONS_IS_TILLER_ENABLED:** Checked
     - **CLUSTER_OPTIONS_KUBERNETES_NETWORK_CONFIG_PODS_CIDR:** 10.244.0.0/16
     - **CLUSTER_OPTIONS_KUBERNETES_NETWORK_CONFIG_SERVICES_CIDR:** 10.96.0.0/16
     - **NODE_POOL_INITIAL_NODE_LABELS_KEY:** key
     - **NODE_POOL_INITIAL_NODE_LABELS_VALUE:** value
     - **NODE_POOL_NAME:** Oracle-Linux-7.6
     - **NODE_POOL_NODE_SHAPE:** VM.Standard2.1
     - **NUMBER_OF_NODES:** 3
     - **NODE_POOL_SSH_PUBLIC_KEY:** <*Enter the content of your public ssh key*>
     - **LB_CIDR:** 10.0.20.0/24
     - **NODEPOOLS_CIDR:** 10.0.10.0/24
     - **WORKER_MODE:** <*private or public*>
     - **VCN_DNS_LABEL:** oke
     - **CLUSTER_KUBE_CONFIG_EXPIRATION:** 2592000
     - **CLUSTER_KUBE_CONFIG_TOKEN_VERSION:** 2.0.0

     
     ![](img/CreateStack02a.png)
     ![](img/CreateStack02b.png)

4. Click **Next**
   - **Verify your configuration variables**
   - Click **Create**

     ![](img/CreateStack03.png)

5. Before moving on to executing a job, quickly review the newly configured stack and then click on the hyperlinked stack name. 
   
    ![](img/image002.png)

## Practice 3: Execute Jobs: Plan, Apply, Destroy

Jobs perform actions against the Terraform configuration files associated with a stack. You can perform 3 actions and they are plan, apply and destroy. Since Terraform command execution is not atomic, it is crucial to prevent any race conditions or state corruption from occurring due to parallel execution. To prevent this from happening, the Resource Manager ensures only one job can run against a stack at a given time against a single state file. 

From the Stack Details page, we can completely manage the stack's configuration (i.e., update, delete, add tag/s, edit variables) and also download the zip archive containing the latest Terraform configuration - which can be especially helpful when troubleshooting.

1. Lets execute a plan by clicking on **Terraform Actions** --> **Plan** and enter the following information:

   - **Name:** *Quickly Create an OKE Cluster Plan*
   - Click **Plan**

    ![](img/image003.png)
    ![](img/image004.png)

    **Note:** Once the modal closes, notice the job's state appears as "Accepted" - which indicates that the platform is spinning up resources needed for executing the command  - followed by "In Progress" and then either "Succeeded" or "Failed". 

    ![](img/image005.png)

2. Once the job succeeded, on the Job Details page review the information and scroll through the logs containing the Terraform output. You may also edit the job or download the Terraform Configuration and logs. 

    ![](img/image006.png)
  
3. Since the previous plan action succeeded, lets go back to the Stack page by clicking the breadcrumb on top of the page. On the Stack details page you can select the Apply from the Terraform Actions menu. Click on **Terraform Actions** --> **Apply**

    ![](img/image007.png)

4. Enter the following information:
   
   - **Name:** *Quickly Create an OKE Cluster Apply*
   - **Apply Job Plan Resolution** *Quickly Create an OKE Cluster Plan* (you can select the latest succeed plan job to apply)
   - Click **Apply**

    ![](img/image008.png)

5. The job state is updated as the job execution nears completion:
   
   ![](img/image009.png)
   ![](img/image010.png)
   ![](img/image011.png)

6. Once the apply action succeeds, verify the resources have been provisioned by reading the Terraform output contained with the logs or navigate to Developer Services and view the different resources that now exist (Cluster, node pools) and that the 3 nodes are listed in the node pool. 

    ![](img/image012.png)
    ![](img/image013.png)

7. You can also obtain the kubeconfig file by clicking on the Access Kubeconfig button

    ![](img/image014a.png)
    ![](img/image014b.png)


8. Now that we've successfully applied our Terraform to build out our cloud resources, let's return to the Stack Details page and use the Resource Manager to tear it all down by clicking on **Terraform Actions** --> **Destroy** and enter the following information:

   - **Name:** *Quickly Create an OKE Cluster Destroy*
   - Click **Destroy**
   
    ![](img/image014.png)
    ![](img/image015.png)

9. Once again, notice that the state change is reflected in the console:

    ![](img/image016.png)

10. The final step is to delete the stack by clicking on the Delete Stack button on Stack Details page. Click on **Delete Stack** and confirm it by clicking **Delete** on the modal window

    ![](img/image017.png)
    ![](img/image018.png)
