# Create a Notebook Session

## Introduction

Data Science notebook sessions are interactive coding environments for building and training models. Notebook sessions provide access to a JupyterLab serverless environment that is managed by the Data Science service. All notebook sessions run in the Data Science service tenancy.

A Notebook session is associated with a compute instance, VCN, subnet and block storage. There are two block storage drives that are associated with a notebook session. There is a boot volume that is initialized each time the notebook session is activated. Any data on the boot volume is lost when the notebook session is deactivated or terminated. There is an additional block storage that is persisted when a notebook session is deactivated but it is not persisted when a notebook session is terminated. This block volume is mounted in the ``/home/datascience`` directory and it is where the JupyterLab notebooks, data files, installed custom software and other files should be stored.

When a notebook session is activated or created, the compute instance shape, block storage, VCN and subnet are configured. Thus, these resources can be changed by deactivating a notebook session, then activating the session and changing the configuration. The size of the block storage can only be increased.

*Estimated Lab Time*: 15 minutes

### Objectives
In this lab, you will:
* Use the Console to create a Data Science notebook session
* Use the console to open the Data Science notebook session

### Prerequisites
This lab assumes you have:
* A tenancy that is configured to work with the Data Science service.
* A Project, VCN and subnet configured.
* An account that has permission to create a Data Science notebook session.

## **Step 1:** Creating a Notebook Session

1. [Login to the Console](https://www.oracle.com/cloud/sign-in.html).
1. Open the navigation menu.
1. Under **Data and AI**, click **Data Sciences**, and then click **Projects**.
1. Select the compartment for the project.
1. Click the name of the project to contain the notebook session.
1. Click **Create Notebook Session** and a **Create Notebook Session** window will open.
1. Select the compartment that you want to contain the notebook session.
1. (Optional, but recommended) Enter a unique name for the notebook session (limit of 255 characters). If you do not provide a name, a name is automatically generated for you. For example, ``datasciencenotebooksession20200108222435``.
1. Select a VM shape. The [Compute Shapes](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm) page has details on the specifications.
1. Enter the block volume in GB. 
1. Select the VCN compartment that contains the VCN that will be used. 
1. Select the VCN to use.
1. Select the subnet compartment that contains the subnet to use.
1. Select the subnet to use. Generally, a subnet that has public internet access is desired, but not required.
1. (Optional) Add tags to the notebook session by selecting a tag namespace, then entering the key and the value. You can add more tags to the compartment by clicking **+Additional Tags**, see [Working with Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm#workingtags).
1. (Optional) View the details for your notebook session immediately after creation by selecting **Display notebook session details after creation**. 
1. Click **Create**

While the notebook session is being created, you can navigate away from the current page.

## **Step 2:** Opening a Notebook Session

Once the notebook session has been created the notebook session page will show the notebook in an **Active** or **Inactive** state. To open the notebook:

1. [Login to the Console](https://www.oracle.com/cloud/sign-in.html).
1. Open the navigation menu.
1. Under **Data and AI**, click **Data Sciences**, and then click **Projects**.
1. Select the compartment for the project.
1. Click the name of the project to contain the notebook session. This will open the Projects page.
1. Click the name of the notebook session. This will open the Notebook Session page.
1. If the notebook is in an **Active** state, 
    1. Click **Open**.
1. If the notebook is in an **Inactive** state,
    1. Click **Activate** and this will open the **Activate Notebook Session** window with the configuration from the last time the notebook session was activated or created.
    1. Select a VM shape. The [Compute Shapes](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm) page has details on the specifications.
    1. Enter the block volume in GB. The size of the block storage can be increased but not decreased. 
    1. Select the VCN compartment that contains the VCN that will be used. 
    1. Select the VCN to use.
    1. Select the subnet compartment that contains the subnet to use.
    1. Select the subnet to use. Generally, a subnet that has public internet access is desired, but not required.
    1. Click **Activate** and the notebook session status will change to **Updating**.
    1. When the notebook session status changes to **Active**, click **Open**

You may now *proceed to the next lab*.

## Acknowledgements

* **Author**: [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist
* **Last Updated By/Date**:
    * [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist, September 2020

## See an issue?

Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request.
