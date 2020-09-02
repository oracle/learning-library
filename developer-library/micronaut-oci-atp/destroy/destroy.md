# Cleaning Up Cloud Resources

## Introduction
This lab takes you through shutting down and destroying the resources created as part of the this lab including VMs and Autonomous Database Instances.

Estimated Lab Time: 5 minutes

### Objectives
In this lab you will:
* Use your Terraform Stack to tear down OCI resources

### Prerequisites
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account
  
## **STEP:** Destroying 

To clean up all of the OCI resources created by Terraform at the start of this lab navigate perform the following steps:

1. Navigate to the Stack you created in the Oracle Cloud Console by going to **Resource Manager** -> **Stacks** and selecting your stack under **Stacks**

2. Under **Terraform Actions** select **Destroy** then click the **Destroy** button

    ![Destroy Stack](images/destroy_stack.png)

The Terraform automation will tear down the VMs and the Autonmous Database created as the start of this lab.

You may now *proceed to the next lab*.

## Acknowledgements
- **Owners** - Graeme Rocher, Architect, Oracle Labs - Databases and Optimization
- **Contributors** - Chris Bensen, Todd Sharp, Eric Sedlar
- **Last Updated By** - Kay Malcolm, DB Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.