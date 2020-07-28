# Cleaning Up After the Workshop

## Introduction

Now that you have completed the workshop, you may want to remove the artifacts left behind in your Oracle Cloud trial account. This guide will show you how to remove everything that you created during the workshop. Note that compute instances and load balancers left running in your Oracle Cloud trial account will continue to consume trial credits until they are terminated.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
# Remove All Deployed and Installed Workshop Components

## Clean up Oracle Cloud Account

### **STEP 1**: Delete Kubernetes Services

- First we need to delete any load balancers created by Kubernetes outside of the Terraform infrastructure we provisioned. Open an **SSH session** to your cloud VM as documented in Lab 200. _In the SSH session_, run the following command (you may need to switch to `root`):

  `kubectl delete svc --all`

### **STEP 2**: Delete VM Instance

- As documented in the other labs, connect into your Oracle Cloud Account, and go to the OCI Console.

- In the OCI Console, select **Compute > Images** from the navigation menu

  ![](images/manualcleanup/ManualCleanUp-6c5d4d47.png)

- We will now delete the instance created during the Workshop. Hover over the **three dots** to the right of the VM instance, then select **Terminate**

  ![](images/manualcleanup/ManualCleanUp-7d93604b.png)

- Ensure the **Permanently delete** box is checked, and click on **Terminate Instance**.

  ![](images/manualcleanup/Manualcleanup/pic04.png)

### **STEP 3**: Delete Kubernetes Cluster

- Log in to the OCI Console as `cluster-admin`.

- From the navigation menu, select **Developer Services -> Container Clusters (OKE)**

  ![](images/manualcleanup/ManualCleanUp-8a999226.png)

- Click the name of your cluster in the table to view the details page. Then click **Delete Cluster**

  ![](images/CleanUp-79957f38.png)

-  On the confirmation dialog, click **Delete**

  ![](images/CleanUp-21199ceb.png)

- You will see the cluster change status to **Deleting**.

  ![](images/CleanUp-f7668c0e.png)

- Eventually, the worker nodes will be terminated and the cluster status will change to **Deleted**

  ![](images/CleanUp-b9eaf8d0.png)

  ![](images/CleanUp-ebd33f4a.png)

### **STEP 4**: Delete the API Key Fingerprint and Auth Tokens

- In the user menu in the top right corner, select **User Settings**

- From the **API Key** section, click on the **Delete** button to the right of the **Fingerprint** you created during this workshop. Confirm the delete by clicking on **OK** in the popup dialog box.

  ![](images/manualcleanup/Manualcleanup/pic14.png)

- Click **Auth Tokens** in the left navigation pane.

  ![](images/manualcleanup/ManualCleanUp-62bfdca7.png)

- In the **three dots** menu next to each of your tokens, click **Delete**

  ![](images/manualcleanup/ManualCleanUp-970b4a3e.png)

### **STEP 5**: Delete Images from Container Registry

  - Log in to the OCI Console as `cluster-admin`.

  - From the navigation menu, select **Developer Services -> Registry (OCIR)**

  ![](images/manualcleanup/ManualCleanUp-5613e0ba.png)

  - Click the **twitter-feed** repository.

  ![](images/manualcleanup/ManualCleanUp-1a6eebe2.png)

  - From the Actions menu, select **Delete Repository**

  ![](images/manualcleanup/ManualCleanUp-6d8e9559.png)

  - In the confirmation dialog, click **Delete**

  ![](images/manualcleanup/ManualCleanUp-b6b5bd91.png)

  - Repeat the last three instructions to delete the repository **resize128**.

### **STEP 6**: Delete Cluster-Admin User

- In the OCI Console navigation menu, select **Identity -> Groups**

  ![](images/manualcleanup/ManualCleanUp-551a8596.png)

- Click **Administrators**

  ![](images/manualcleanup/ManualCleanUp-471313fb.png)

- In the **three dots** menu for `cluster-admin`, select **Remove Member From Group**

  ![](images/manualcleanup/ManualCleanUp-b4605b23.png)

- In the OCI Console navigation menu, select **Identity -> Users**

  ![](images/manualcleanup/ManualCleanUp-8b355fea.png)

- In the **three dots** menu for the `cluster-admin` user, click **Delete**

  ![](images/manualcleanup/ManualCleanUp-be8e5ba9.png)

- In the confirmation dialog, click **OK**

  ![](images/manualcleanup/ManualCleanUp-f8ca55d6.png)

### **STEP 7**: Remove OKE Policy statement

- In the OCI Console navigation menu, select **Identity -> Policies**

  ![](images/manualcleanup/ManualCleanUp-a2b4ad2f.png)

- Using the compartment drop down list, switch to the **root compartment**.

  ![](images/manualcleanup/ManualCleanUp-4706017c.png)

- Click **PSM-root-policy**

  ![](images/manualcleanup/ManualCleanUp-10a611d6.png)

- Find the statement `allow service oke to manage all-resources in tenancy`. In the **three dots** menu for that statement, select **Delete**

  ![](images/manualcleanup/ManualCleanUp-f6933637.png)

- In the confirmation dialog, click **OK**

  ![](images/manualcleanup/ManualCleanUp-8197b266.png)

### **STEP 8**: (Optional) Delete Wercker Application

- Navigate to the **twitter-feed-oke** application on [app.wercker.com](app.wercker.com)

- Click the **Options** tab

  ![](images/manualcleanup/ManualCleanUp-44cfdb09.png)

- Scroll to the bottom of the options page and click **Delete Application**

  ![](images/manualcleanup/ManualCleanUp-18bff4f7.png)

### **STEP 9**: (Optional) Delete twitter-feed-oke Fork on GitHub

- Navigate to your **twitter-feed-oke fork** on [GitHub](github.com) and click the **Settings tab**

  ![](images/manualcleanup/ManualCleanUp-370ba37e.png)

- Scroll all the way down and click **Delete this repository**

  ![](images/manualcleanup/ManualCleanUp-20b0d4b6.png)
