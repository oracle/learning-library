# Shutting Down a Notebook Session
## Introduction

When a notebook session is in an active state there is a boot volume, block storage and compute attached to it. When the notebook is not being used it is possible to detach the computing resource and thus reduce costs. There are two methods for shutting down a notebook session. If a notebook session is deactivated, the underlying computing resource is shut down and the boot volume and block storage are detached. However, the block storage, which is mounted at ``/home/datascience`` is persisted for later use. The boot volume is not persisted. Deactivated notebooks can be activated again and the block volume will automatically be reattached. During activation, it is possible to change the compute shape, size of the block volume, VCN and subnet.

If the notebook session and its block storage are no longer needed, the notebook session can be terminated. Terminating a notebook session will release the underlying compute, boot volume and block storage. Since the boot volume and block storage are not persisted, any data on these volumes will be lost. It is not possible to reactivate a terminated notebook session.

*Estimated Lab Time*: 10 minutes

### Objectives
In this lab, you will:
* Learn the different methods of shutting down a notebook session.
* Understand the differences between deactivating and terminating a notebook session.
* Become familiar with the steps needed to deactivate and terminate notebook sessions.

### Prerequisites
This lab assumes you have:
* An active notebook session that can be deactivated or terminated. However, this is not required.

## Deactivating Notebook Sessions

Before deactivating a notebook session, save all work to the attached block volume. Any data or files stored on the compute boot volume or held in memory are lost when the notebook session is deactivated. The data and files saved on the block volume, which is mounted at ``/home/datascience`` are maintained while the notebook session is inactive. Access to the block volume is restored when the notebook session is activated.

1. [Login to the Console](https://www.oracle.com/cloud/sign-in.html).
1. Open the navigation menu.
1. Under **Data and AI**, click **Data Sciences**, and then click **Projects**.
1. Select the compartment for the project.
1. Click the name of the project to contain the notebook session. This will open the Projects page.
1. Click the name of the notebook session. This will open the Notebook Session page.
1. Click **Deactivate** and the **Deactivate Notebook Session** window will open.
1. Click **Deactivate**. The status will change to **Updating** followed by **Inactive**.


## Terminating Notebook Sessions

To keep the file changes in a notebook session’s boot volume and attached block volume, they must be backed up before the notebook session is terminated. For example, copy the files to an object storage bucket, or commit and push changes to a Git repository outside the notebook session. Otherwise, all file changes in the notebook session’s boot volume and attached block volume will be lost.

1. [Login to the Console](https://www.oracle.com/cloud/sign-in.html).
1. Open the navigation menu.
1. Under **Data and AI**, click **Data Sciences**, and then click **Projects**.
1. Select the compartment for the project.
1. Click the name of the project to contain the notebook session. This will open the Projects page.
1. Click the name of the notebook session. This will open the Notebook Session page.
1. Click **Terminate** and a **Terminate Notebook Session** window will open.
1. Click **Terminate**. The status will change to **Deleting** followed by **Deleted**.

You may now *proceed to the next lab*.

## Acknowledgements

* **Author**: [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist
* **Last Updated By/Date**:
    * [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist, September 2020

## See an issue?

Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request. If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section. Please include the workshop name and lab in your request.
