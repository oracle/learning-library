# Monitor Extracts and Replicats

## Introduction

This lab walks you through the steps to monitor the Extract and Replicat processes that were created and run in the previous lab.

Estimated Lab Time: 2 minutes

### About Performance Monitoring
Monitoring the performance of your GoldenGate instance ensures that your data replication processes are running smoothly and efficiently. You can monitor performance in both the GoldenGate deployment console as well as in the Oracle Cloud Infrastructure Console on the Deployment Details page.

### Objectives

In this lab, you will:
* View charts and statistics using the Performance Metrics Server in the GoldenGate deployment console
* Use Metrics on the Deployment Details page in the Oracle Cloud Infrastructure Console to determine overall instance health and utilization.

### Prerequisites

In order to complete this lab, you should have completed the preceding lab and have both an Extract and Replicat running.

## **STEP 1**: Using the Performance Metrics Server

1.  In the GoldenGate deployment console, click **Performance Metrics Server**.

    ![](images/05-01-perf-serv.png)

    ![](images/05-01-perf-serv-b.png)

    Note: You can also view performance details for the Administration, Distribution, and Receiver Servers, as well as any processes created.

2.  Click the Extract to view its performance details.

    ![](images/05-02-ext.png)

3.  Click **Database Statistics**.

    ![](images/05-03-db-stats.png)

    Here, you can view the real time database statistics, such as Inserts, Updates, Deletes, and so on.

4.  Repeat steps 1-3 to view a snapshot of the Replicat's (named **Rep** in our lab) Database Statistics.

## **STEP 2:** Viewing GoldenGate Metrics in the OCI Console

1.  On the OCI GoldenGate Deployments page, select **GGSDeployment**.

2.  On the GGSDeployment Details page, scroll down to the **Metrics** section.

    ![](images/05b-02-metrics.png)

3.  Review the **DeploymentInboundLag** and **DeploymentOutboundLag** charts.

4.  Refresh your view after 5 minutes to see updated metrics.

In this lab, you learned to monitor performance in the OCI GoldenGate Deployment Console and in the OCI Console.

## Learn More

* [Viewing Performance Metrics](https://docs.oracle.com/en/cloud/paas/goldengate-service/using/goldengate-deployment-console.html#GUID-A533E3ED-ADB9-42EE-A1FF-D3E6C5638DF3)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management
* **Last Updated By/Date** - March 2021

