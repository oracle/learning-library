# Optional: Scaling the Weblogic Domain

## Introduction

In this lab, we'll look at scaling a WebLogic domain provisioned with the Marketplace.

There are 2 ways to scale a domain:

- Change the shape of the WebLogic Server VM to increase or reduce OCPU counts or memory
- Add or remove node by editing the Resource Manager stack

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:

- Scale out the WebLogic domain provisioned on OCI using the Resource Manager
- Scale the shape of a single node of the WebLogic deployment.

### Prerequisites

For this lab you need:

- To have deployed the WebLogic on OCI stack successfully

## **STEP 1:** Scaling the number of nodes

***Important note***: If you changed a node shape manually, any change using the variables and re-applying to the stack will revert node shapes to their original shape defined at provisioning time.

1. To scale the number of nodes, go to **Resources Manager -> Stacks** and select the stack that was used to provision the WebLogic domain

  <img src="./images/scale-stack.png" width="100%">

2. Click **Variables** then click **Edit Variables**

  <img src="./images/scale-variables.png" width="100%">

3. Scroll to the **Weblogic Server Node Count** input and adjust the number of nodes

  <img src="./images/scale-10-nodes.png" width="70%">

4. Make sure the **Do not update domain configuration** is left **unchecked**. This option is to be used if you want to scale the number of nodes without scaling the cluster

  <img src="./images/scale-no-update.png" width="70%">

5. Click **Next** and then **Save Changes**

6. Then Click **Terraform Actions -> Apply** to make the changes

  <img src="./images/scale-tf-apply.png" width="70%">

  The new job will update the number of nodes, reverting any manual shape change to the originally provisioned shape. Servers will be restarted and new nodes will join the cluster if there was one defined, unless the **Do not update domain** was checked.

  The load balancer is also updated to take new nodes into account.

7. Go check the Admin Console under **Environment -> Servers** to verify an server was added

## **STEP 2:** Scaling a node by changing shape

***Important Note***: Beware that manual node shape changes will be overriden when applying changes through the Resources Manager, like when scaling the number of nodes. It is recommended to scale the number of nodes rather than change the shape of the nodes, but we'll show this process for reference.

1. To scale a node by changing its shape, go to **Compute -> Instances**

  <img src="./images/scale-compute.png" width="50%">

2. Click the WebLogic instance to modify

  <img src="./images/scale-compute-instance.png" width="100%">

3. In the instance details, click **Edit**

  <img src="./images/scale-compute-edit.png" width="70%">

4. In the Edit pane, click **Edit Shape**

  <img src="./images/scale-compute-edit-shape.png" width="70%">

5. Select an new shape and click **Save Changes**

  <img src="./images/scale-compute-edit-shape2.png" width="70%">

  You will be prompted to reboot the instance. The WebLogic servers will be restarted on reboot.

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
