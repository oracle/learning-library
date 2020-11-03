# Data Science Service Setup

## Introduction

To use the Data Science service, the tenancy has to be configured to grant permission to users and resources. If your tenancy is not already configured, you will need administrator access to configure it. If you created a free-tier account, your account has administrator access. There are two ways to create configure the tenancy. It can be [manually configured](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/configure-tenancy.htm) or the [Oracle Resource Manager](https://www.oracle.com/cloud/systems-management/resource-manager/). In this lab, the tenancy will be configured using the [Data Science Solution Hub](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/orm-configure-tenancy.htm), which is part of the Oracle Resource Manager. The Oracle Resource Manager provides an interface that assists in creating customized stacks that will configure the tenancy to work with the Data Science service.

The **Quick-start Tenancy Configuration** and **Advanced Configuration of a Tenancy** both provide instructions on using the Data Science Solution Hub to configure the tenancy. The **Quick-start Tenancy Configuration** provides instructions to set up a basic configuration to work with the Data Science service. It is the recommended path for free-tier accounts and other tenancies that have a standard configuration. The **Advanced Configuration of a Tenancy** section provides more details and options and should be used if a tenancy needs some customization. For more elaborate tenancy configurations follow the service guide to [manually configure the resources](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/configure-tenancy.htm). 

By default, a tenancy is not configured to work with the Data Science service. If the tenancy is already configured to work with the service then you can skip the following setup instructions. If you do not know if your account is configured for the service or not, ask your system administrator. 

You only need to complete the instructions in the **Quick-start Tenancy Configuration** or the **Advanced Configuration of a Tenancy** if the tenancy is not configured to work with the Data Science service. If you are not sure which set of instructions to follow, start with the **Quick-start Tenancy Configuration**.

*Estimated Lab Time:* 30 minutes

### Objectives
In this lab, you will:
* Use the Oracle Resource Manager Solution Hub to create a stack
* Become familiar with the options available to configure a tenancy to work with the Data Science service.
* Apply a stack to create the policies, groups, dynamic groups, VCN, subnet and other resources need to access the Data Science service.
* Destroy a stack is the stack fails to be applied.

### Prerequisites
This lab assumes you have:
* Logged into the tenancy with an administrator account.
* An understanding of how the tenancy is configure such that you are able to determine if the quick-start of advanced configuration directions should be followed. 

## Quick-start Tenancy Configuration

Configuring a tenancy using Oracle Resource Manager involves creating a solution stack, selecting the solution, providing identifying information for the new stack, and updating variables. For most tenancies, the default options will be sufficient. This section outlines the minimal requirements needed for configuring a tenancy to work with the Data Science service. If your tenancy has a more advanced setup then skip this section and follow the instructions in the **Advanced Configuration of a Tenancy** section. For most tenancies, the following instructions will be sufficient but minor changes may be needed. It is possible to change the configuration later.

1. [Login to the Console](https://www.oracle.com/cloud/sign-in.html) with an account with administrator access.
1. Open the navigation menu. Under **Solutions and Platform**, go to **Resource Manager** and click **Stacks**.
1. Choose a compartment on the left side of the page.
1. Click **Create Stack**.
1. Click **Sample Solution**, and then click **Select Solution**.
1. Select **Data Science**, and then click **Select Solution**.
1. Click **Next**. The **Configure Variables** panel displays variables auto-populated from the Terraform configuration for the Data Science solution.
1. Uncheck **Create a Project and Notebook Session?** 
1. Uncheck **Enable Vault Support?**
1. Uncheck  **Provision Functions and API Gateway?** 
1. Click **Next** and review the stack configuration.
1. Click **Create** to create your stack. This creates the stack but does not create the Data Science resources. The **Stack Details** page will be displayed.
1. Click **Terraform Actions**, and then click **Apply** to apply the Terraform script and create the Data Science resources. If the stack generates an error, click **Terraform Actions**, and then click **Destroy** to remove the resources that were created. Fix any issues and then repeat this step.

## Advanced Configuration of a Tenancy

Follow the instructions in this section if you need a more elaborate configuration then is provided for in the **Quick-start Tenancy Configuration**. If you have successfully created a stack and were able to apply it by following the instructions in the **Quick-start Tenancy Configuration** section, then skip this section.

Configuring a tenancy using Oracle Resource Manager involves creating a solution stack, selecting the solution, providing identifying information for the new stack, and updating variables. For most tenancies, the default options will be sufficient. However, for advanced configurations changes may need to be made. It is possible to change the configuration later.

1. [Login to the Console](https://www.oracle.com/cloud/sign-in.html) with an account with administrator access.
1. Open the navigation menu. Under **Solutions and Platform**, go to **Resource Manager** and click **Stacks**.
1. Choose a compartment you have permission to work in (on the left side of the page). The page updates to display only the resources in that compartment. If you are not sure which compartment to use, contact an administrator.
1. Click **Create Stack**.
1. Click **Sample Solution**, and then click **Select Solution**.
1. Select **Data Science**, and then click **Select Solution**.
1. Enter a **Name** for the new stack, or use the default.
1. Optionally, enter a **Description**.
1. From the **Create in Compartment** drop-down, select the compartment in which the stack will be created. This compartment will contain all the resources the stack creates.
1. Optionally, tags can be applied.
1. Click **Next**. The **Configure Variables** panel displays variables auto-populated from the Terraform configuration for the Data Science solution.
1. Change the IAM variables as necessary.
1. Enter the network information or use the defaults to create a VCN, or select **Use Existing VCN** to enter the information to connect to an existing network.
1. Optionally, select **Create a Project and Notebook Session?** and enter a project and notebook configuration. It is recommended that projects and notebooks are not created using the Solution Hub. Refer to [Creating Projects](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/manage-projects.htm#create-project) and [Creating Notebook Sessions](https://docs.cloud.oracle.com/en-us/iaas/data-science/using/manage-notebook-sessions.htm#create-notebooks) on how to manually create these resources.
1. Select **Enable Vault Support?** to enable storing secrets, encrypted passwords, and keys, and then enter vault values to create a vault.
1. Select **Provision Functions and API Gateway?** to enable deploying models to Functions and use the API gateway.
1. Click **Next** and review the stack configuration.
1. Click **Create** to create your stack. This creates the stack but does not create the Data Science resources. The **Stack Details** page will be displayed.
1. Click **Terraform Actions**, and then click **Apply** to apply the Terraform script and create the Data Science resources. If the stack generates an error, click **Terraform Actions**, and then click **Destroy** to remove the resources that were created. Fix any issues and then repeat this step.

You may now *proceed to the next lab*.

## Acknowledgements

* **Author**: [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist
* **Last Updated By/Date**:
    * [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist, September 2020

## See an issue?

Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request.
