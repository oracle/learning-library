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

## **Step 1:** Maintain the Cluster

You can use the **Clusters** and **Cluster Details** pages to maintain your clusters.

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator, if you are not already logged in. On the **Sign In** page, select your `tenancy`, enter your `username` and `password`, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

2. Click the **Navigation** menu in the upper left-hand corner of the **Oracle Cloud Console** Home page. Under **Data & AI**, select **Big Data**.

3. On the **Clusters** page, on the row for **`training-cluster`**, click the **Actions** button. You can use the context menu to view the cluster's details, add nodes, block storage, Cloud SQL, and also to rename or terminate the cluster.

    ![](./images/actions-button.png " ")  

3. Alternatively, you can click the **`training-cluster`** link in the **Name** column to display the **Cluster Details** page. You can use the buttons at the top of the page to do the following:

    + Add tags to the cluster.
    + Move resources from the current compartment to a different compartment.
    + Add **Worker** nodes to the **`training-cluster`** cluster. Any new nodes that you add will use the same instance shape and amount of attached block storage as the existing **Worker** nodes in the cluster.
    + Add block storage.
    + Use the **More Actions** drop-down list to add Cloud SQL, rename the cluster, and terminate the cluster.

    ![](./images/maintain-cluster-2.png " ")  

**Note:** Oracle Cloud Infrastructure Tagging allows you to add metadata to resources, which enables you to define keys and values and associate them with resources. You can use the tags to organize and list resources based on your business needs. For additional information, see [Tagging Overview](https://docs.cloud.oracle.com/en-us/iaas/Content/Tagging/Concepts/taggingoverview.htm#Tagging_Overview) in the OCI documentation.    

## **Step 2:** Add Oracle Cloud SQL to the Cluster

You can add Oracle Cloud SQL to a cluster so that you can use SQL to query your big data sources. When you add Cloud SQL support to a cluster, a query server node is added and big data cell servers are created on all worker nodes. For information about using Cloud SQL with Big Data Service see [Use Cloud SQL with Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/use-cloud-sql-big-data-service.html).

**Note:** Cloud SQL is not included with Big Data Service. You must pay an extra fee for using Cloud SQL.

1. On the **Clusters** page, on the row for **`training-cluster`**, click the **Actions** button. From the context menu, select **Add Cloud SQL**.

  ![](./images/add-cloud-sql-menu-option.png " ")  

3. In the **Add Cloud SQL** dialog box, provide the following information:
    + **QUERY SERVER NODE SHAPE CONFIGURATION:** Select **`VM.Standard2.4`**.
    + **QUERY SERVER NODE BLOCK STORAGE (IN GB):** Enter **`1000`**.
    + **CLUSTER ADMIN PASSWORD:** Enter your cluster administration password that you chose when you created the cluster such as **`Training123`**.

    ![](./images/add-cloud-sql.png " ")  

    **Note:** For information on the supported Query Server node shapes and block storage size, see [Plan Your Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/plan-your-cluster.html#GUID-0A40FB4C-663E-435A-A1D7-0292DBAC9F1D).

4. Click **Add**. The **Clusters** page is re-displayed. The status of the **`training-cluster`** is now **Updating** and the number of nodes in the cluster is now **`8`** instead of **`7`**.

    ![](./images/updating-cluster.png " ")  

5. Click the **`training-cluster`** name link in the **Name** column to display the **Cluster Details** page. The **Cluster Information** tab displays the cluster, network, and Cloud SQL Information. In addition, the newly added Cloud SQL node, **`traininqs0`** is displayed in the **List of cluster nodes** section.

    ![](./images/cluster-details-cs.png " ")

6. You can also navigate to **Clusters > Cluster Details > Work Requests** to display the status, logs, and errors (if any) of adding the Cloud SQL node to the cluster.

    ![](./images/add-cloud-sql-wr.png " ")

7. Once the Cloud SQL node is successfully added to the cluster, the cluster's state changes to **Active** and the number of nodes in the cluster is now **`8`**.

    ![](./images/cs-active.png " ")    

**This concludes this lab. Please proceed to the next lab in the Contents menu on the right.**

## Want to Learn More?

* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Overview of Oracle Cloud Infrastructure Identity and Access Management](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)

## Acknowledgements

* **Authors:**
    + Lauran Serhal, Principal UA Developer, Oracle Database and Big Data User Assistance
* **Technical Contributors:**
    + Martin Gubar, Director, Oracle Big Data Product Management
* **Last Updated By/Date:** Lauran Serhal, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
