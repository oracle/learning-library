# Tearing down the infrastructure

## Introduction

In this lab we will be cleaning up our deployment and tearing down the infrastructure.

Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:

- Tear down the infrastructure deployed.

## **STEP 1:** Tearing down the cluster

1. Before tearing down infrastructure, it is recommended to undeploy the kubernetes objects. The terraform will attempt to destroy all kubernetes objects but some artifacts may be left behind if it is not able to deprovision some resources (like buckets that are not empty)

2. To tear down the Kubernetes cluster, use:

    ```bash
    <copy>
    terraform destroy
    </copy>
    ```

    and type `yes` at the prompt.

    This will take several minutes.

3. Sometimes the destroy phase will fail because the nodes in the node pool are not completely cleaned up before the terraform attempts to destroy the VCN.

    Run the destroy command again to finish clean up if it fails at first.



## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabs). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
