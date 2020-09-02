<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

November 08, 2018
</td>
<td class="td-banner">
# Lab 3: Scaling an ATP instance
</td></tr><table>

## Introduction

Autonomous Transaction Processing provides all of the performance of the market-leading Oracle Database in an environment that is tuned and optimized for transaction processing workloads. Oracle Autonomous Transaction Processing (or ATP) service provisions in a few minutes and requires  very little manual ongoing administration.

Scaling in the context of an ATP database means increasing or decreasing the amount of CPU or storage resources allocated to the service. Scaling an ATP instance is easy, flexible and can be done without any downtime so your application can continue to run unaffected while the scaling operation is in progress.


### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

- Learn how to scale an ATP instance

## Required Artifacts

- Please ensure you are connected to your cloud account and have provisioned an ATP instance. Refer<a href="./LabGuide100ProvisionAnATPDatabase.md" target="_blank">LabGuide1.md</a>


## Steps

### **STEP 1: Log into your cloud account and navigate to ATP console**

- Log into your cloud account and navigate to ATP console

![](./images/300/Picture300-1.png)

- On the instance details page, select Scale Up/Down button at the top

![](./images/300/Picture300-2.png)

- Enter the CPU or storage you need to change to.

![](./images/300/Picture300-3.png)

#### NOTE: The service does not limit you to any rigid shapes ( 2,4, 8, 16 etc). You can choose any size from 1 – 128 for both CPU and storage in TB.

- The service details page would indicate that the scaling operation is in progress. Once it completes, the status changes to ‘Available’.

#### NOTE:  Regardless to the change in CPU or storage, your database is always available to your application and your workload can run uninterrupted during the scaling process.


-   You are now ready to move to the next lab.

<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
## Great Work - All Done!
</td>
</tr>
<table>