# Scaling and Performance in Your Autonomous Database

## Introduction

In this lab, you will scale up your Oracle Autonomous Data Warehouse (ADW) or Autonomous Transaction Processing (ATP) service to have more CPUs. You will also watch a demo that shows the performance and concurrency impacts of scaling your service online.

### Objectives

-   Learn how to scale up an ADW or ATP service
-   Understand the performance and concurrency impacts of scaling your autonomous database service online

### Prerequisites

-   The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Public Cloud account</a>. If you don't already have your own cloud account or a LiveLabs account, then you can obtain a new cloud account through the Oracle Free Trial program.
-   This lab assumes you have completed the **Prerequisites** and **Provision Autonomous Database** labs seen in the Contents menu on the right.


## **Step 1**: Scaling your Autonomous Database Instance

1. Go back to the Cloud Console you used during the provisioning exercise and open the database instance's Details page. From the **action menu**, click **Scale Up/Down**.

    ![](./images/Picture300-2.jpg " ")

2.  Fill in the form with the following information:

    -   **OCPU count :** 8
    -   **Storage (TB):** 2
    -   **Auto-Scaling:** Disabled
  
  *Note: You can scale up/down your autonomous database only if your autonomous database is NOT Always Free.*

3.  Click **Update** after filling in the form. This will take you to the database instance's Details page.

    ![](./images/Picture300-3.jpg " ")

    *Note: Applications can continue running during the scale operation without downtime.*

4.  **Refresh** the page to see the result of the scale operation.

    ![](./images/Picture300-6.png " ")

## **Step 2**: Performance and Concurrency Benefits of Dynamic Scaling

1.  Watch a demo of the performance impact of scaling up your instance. It shows how you can dynamically scale up a database while the workload is running, to increase transaction throughput. Scaling up can also provide more concurrency for your users.

    [](youtube:YgwbqurhxjM)

2.  In this example, scaling up the number of CPUs from 2 to 8 increased the transaction throughput from 2000 to 7500 transactions per second.

    ![](./images/screenshot-of-increased-transaction-throughput.png " ")

## Want to Learn More?

Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/autonomous-add-resources.html#GUID-DA72422A-5A70-42FA-A363-AB269600D4B0) for documentation on enabling auto scaling.

## **Acknowledgements**

- **Author** - Nilay Panchal, ADB Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Contributors** - LiveLabs QA Team (Jeffrey Malcolm Jr, Ayden Smith, Arabella Yao)
- **Last Updated By/Date** - Arabella Yao, Product Manager Intern, DB Product Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
