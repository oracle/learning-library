<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

June 13, 2019
</td>
<td class="td-banner">
# Lab 3: Provisioning an Autonomous Container Database
</td></tr><table>

## Introduction
An Autonomous Container Database resource provides a container for your Autonomous Databases. You can create multiple Autonomous Container Database resources in a single Autonomous Exadata Infrastructure resource, but you must create at least one before you can create any Autonomous Databases



### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

As a fleet administrator
- Deploy an Autonomous Container Database (ACD) onto an Autonomous Exadata Infrastructure (AEI)

## Required Artifacts

- An Oracle Cloud Infrastructure account with fleet administrator privileges. For a detailed description of required IAM policies, please refer to the [fleet admin guide](https://docs.oracle.com/en/cloud/paas/atp-cloud/atpfg/index.html) of the autonomous database documentation set.


## Steps

### **Step 1:** Create an Autonomous Container Database (ACD)

**Login to your OCI account as a fleet administrator**

Navigate to the 'Autonomous Transaction Processing' option in the top left hamburger menu from your OCI home screen

Pick 'Autonomous Container Database' from the three option, make sure you have selected the compartment hosting your exadata infrastructure and click the blue 'Create Autonomous Container Database' button

![create_acd](./images/300/create_acd.png)

On the Create Autonomous Container Database dialog box you can choose / modify the compartment to create your ACD. You also need to select the compartment hosting your AEI and the AEI instance as highlighted below

![create_acd2](./images/300/create_acd2.png)

As you scroll down the form you will see an option to modify your ACD's maintenance schedule and the type of update you wish to apply to the container. 

- You may choose to apply a Release Update (RU) or simply apply any rivisions (fixes and security updates) to the current Release Update (RUR)

![create_acd3](./images/300/create_acd3.png)

- Specify your ACDs maintenance schedule, picking a month, week, day and time in each quarter when a maintenance operation can be carried out on that container

![create_acd4](./images/300/create_acd4.png)

You may also choose a different backup retention period by selecting a retention policy from the Management tab under Advanced Options as shown below

![retention-policy](./images/300/retention-policy.png)


That's it. Simply scroll down to the bottom and hit the blue 'Create Autonomous Container Database' button to deploy your ACD.

<table>
<tr><td class="td-logo">[![](./images/obe_tag.png)](#)</td>
<td class="td-banner">
### All Done! You have successfully deployed your Autonomous Container Database and it should be available shortly.
</td>
</tr>
<table>