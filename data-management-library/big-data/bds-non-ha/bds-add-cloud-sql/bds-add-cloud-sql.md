# Add Oracle Cloud SQL to the Cluster

## Introduction

In this lab, you will learn how to maintain the new cluster that you created in the previous lab. You will also learn how to add Oracle Cloud SQL to your cluster.

### Objectives

* Maintain your cluster.
* Add Oracle Cloud SQL to your cluster.

### What Do You Need?

This lab assumes that you have successfully completed the following labs in the **Contents** menu on the right:
+ **Lab 1: Setup the BDS Environment**
+ **Lab 2: Create a BDS Hadoop Cluster**

## **STEP 1:** Maintain the Cluster

You can use the **Clusters** and **Cluster Details** pages to maintain your clusters.

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator, if you are not already logged in. On the **Sign In** page, select your `tenancy`, enter your `username` and `password`, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

2. Click the **Navigation** menu in the upper left-hand corner of the **Oracle Cloud Console** Home page. Under **Data and AI**, select **Big Data**.

3. On the **Clusters** page, on the row for **`training-cluster`**, click the **Actions** button to display the context menu.

  ![](./images/cluster-active.png " ")  

4. You can use the context menu to view the cluster's details, add nodes, add block storage, add Cloud SQL, rename the cluster, remove Cloud SQL (if already added), and terminate the Big Data Cluster.

  ![](./images/add-cloud-sql-menu.png " ")    

5. Alternatively, you can click the **`training-cluster`** link in the **Name** column to display the **Cluster Details** page. You can use the buttons at the top of the page to do the following:

    + Add nodes to the cluster.
    + Add Block Storage.
    + Add Cloud SQL.
    + Change Shape.
    + Use the **More Actions** drop-down list to rename the cluster, move a resource from the current compartment to a different compartment, add tags, remove Cloud SQL, and terminate Big data Cluster.

    ![](./images/maintain-cluster-2.png " ")  


## **STEP 2:** Add Oracle Cloud SQL to the Cluster

You can add Oracle Cloud SQL to a cluster so that you can use SQL to query your big data sources. When you add Cloud SQL support to a cluster, a query server node is added and big data cell servers are created on all worker nodes. For information about using Cloud SQL with Big Data Service see [Use Cloud SQL with Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/use-cloud-sql-big-data-service.html).

**Note:** Cloud SQL is not included with Big Data Service. You must pay an extra fee for using Cloud SQL.

1. On the **Clusters** page, on the row for **`training-cluster`**, click the **Actions** button.

  ![](./images/cluster-active.png " ")  

2. From the context menu, select **Add Cloud SQL**.

  ![](./images/add-cloud-sql-menu.png " ")    

2. In the **Add Cloud SQL** dialog box, provide the following information:
    + **Query Server Node Shape:** Select **`VM.Standard2.4`**.
    + **Query Server Node Block Storage (In GB):** Enter **`1000`**.
    + **Cluster Admin Password:** Enter your cluster administration password that you chose when you created the cluster such as **`Training123`**.

    ![](./images/add-cloud-sql.png " ")  

    **Note:** For information on the supported Query Server node shapes and block storage size, see [Plan Your Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/plan-your-cluster.html#GUID-0A40FB4C-663E-435A-A1D7-0292DBAC9F1D) in the Using Oracle Big Data Service documentation.

3. Click **Add**. The **Clusters** page is re-displayed. The status of the **`training-cluster`** is now **Updating** and the number of nodes in the cluster is now **`6`** instead of **`5`**.

    ![](./images/updating-cluster.png " ")  

4. Click the **`training-cluster`** name link in the **Name** column to display the **Cluster Details** page. Click the **Cloud SQL Information** tab to display information about the new Cloud SQL node. In addition, the newly added Cloud SQL node, **`traininqs0`**, is displayed in the **List of cluster nodes** section.

    ![](./images/cluster-details-cs.png " ")

5. Navigate to the **Clusters > Cluster Details** page, and then click **Work Requests** in the **Resources** section. In the **Work Requests** section, the **`ADD_CLOUD_SQL`** operation is displayed along with the status of the operation and percent completed. Click the **`ADD_CLOUD_SQL`** link.

  ![](./images/cloud-sql-wr.png " ")

6. The **Work Request Details** page displays the status, logs, and errors (if any) of adding the Cloud SQL node to the cluster.

  ![](./images/add-cloud-sql-details.png " ")

8. Click the **Cluster Details** link in the breadcrumbs at the top of the page to re-display the **Cluster Details** page. Once the Cloud SQL node is successfully added to the cluster, the cluster's state changes to **Active** and the number of nodes in the cluster is now **`6`**.

    ![](./images/cs-active.png " ")    

**This concludes this lab. Please proceed to the next lab in the Contents menu.**

## Want to Learn More?

* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Overview of Oracle Cloud Infrastructure Identity and Access Management](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)

## Acknowledgements

* **Authors:**
    + Lauran Serhal, Principal UA Developer, Oracle Database and Big Data User Assistance
* **Technical Contributors:**
    + Martin Gubar, Director, Oracle Big Data Product Management
* **Last Updated By/Date:** Lauran Serhal, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
