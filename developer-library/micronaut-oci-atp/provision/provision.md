# Provision Oracle Cloud Instances

## Introduction
In this lab you are going to provision the Oracle Cloud instances needed to run a Micronaut application with Autonomous Database.

Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:

* Download a Terraform script to setup an Oracle Cloud VM and Autonomous Database instance
* Create and Apply a Oracle Cloud Stack via Terraform
* Obtain the necessary configuration to run a Micronaut application locally and communicate with Autonomous Database

### Prerequisites
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account
- A generated SSH key pair (see Lab 1)

## **STEP 1**: Create a new Stack

1. Create Infrastructure by downloading the Terraform configuration: A [stack.zip](https://objectstorage.us-phoenix-1.oraclecloud.com/n/toddrsharp/b/micronaut-lab-assets/o/stack.zip) file.

2. In the Oracle Cloud Console go to the "Solutions and Platforms" -> "Resource Manager" -> "Stacks".

   ![Resource Manager Stacks Link](images/resource_manager_link.png)

3. Click 'Create Stack' to create a new stack:

   ![Create Stack button](images/create_stack_btn.png)

4. Choose 'My Configuration', and upload the Terraform configuration zip either by browsing to the location locally where the zip exists or dragging and dropping the ZIP into the "Stack Configuration" pane:

   ![Stack Configuration - Step 1](images/stack_info_1.png)

5. You can optionally enter a name and description of the stack then then choose the compartment for the Stack, then click 'Next':

   ![Stack Configuration - Step 2](images/stack_info_2.png)

6. Under "Required Configuration" add the SSH key that you created in Lab 1. You can do so by dragging and dropping the public key file (the file that ends with `.pub`) or by choosing `PASTE SSH KEYS` then copying and pasting the contents of the public key file.

    Tip: On OS X running the following command from a terminal window will copy the contents of your public key into the clipboard which can then be pasted:

    ```
    cat ~/.ssh/id_oci.pub | pbcopy
    ```

   ![Stack Configuration - Step 3](images/choose_ssh_key.png)

7. Under "Optional Configuration" make sure that "INSTANCE SHAPE" is set to "VM.Standard.E2.1.Micro":

   ![Stack Configuration - Step 4](images/choose_shape.png)

8. Finally review and create your stack.

   ![Review and Create Stack](images/review_stack.png)

##  **STEP 2**: Apply the Terraform Plan

1. On the Stack Details page, click 'Terraform Actions' and select 'Plan'.

   ![Terraform Plan](images/stack_plan.png)

2. Review the plan output and ensure no failures occurred.

   ![Review Terraform Plan Log](images/plan_log.png)

3. On the Stack Details page, Click 'Terraform Actions' and select 'Apply'.

   ![Applying the Stack](images/stack_apply.png)

4. Choose the plan you just created, then click 'Apply'.

   ![Applying the Stack](images/stack_apply_2.png)


##  **STEP 3**: Capture Application Configuration Variables

1. Monitor the logs and ensure the Stack plan has been successfully applied then review the plan output variables by clicking "Outputs" on the left hand side of the Job Details panel:

   ![Apply Job Outputs](images/tf_output.png)

2. Collect the following values from the output:

      * `compartment_ocid` - This is the compartment OCID used to identify the compartment where the database is setup
      * `tns_name` - This is the TNS name of the Autonomous Database instance
      * `atp_admin_password` - This is the administrative password of the Autonomous Database Instance
      * `atp_schema_password` - This is the schema password of the Autonomous Database Instance
      * `atp_wallet_password` - This is the wallet password of the Autonomous Database Instance
      * `atp_db_ocid` - This is the unique OCID of the Autonomous Database Instance
      * `public_ip` - This is the public IP address from the Oracle Cloud Infrastructure address pool
      * `region` - This is the region where the instance is running

      You will need the values of these variables in the next step to configure your database. However, if you forget to take note of them you can retrieve them later by going to the Oracle Cloud Console and going to "Resource Manager" -> "Stacks" 

      ![Resource Manager Stacks Link](images/resource_manager_link.png)

      Click the name of your Stack under "Jobs"
      ![](images/click-stack-name.png)

      Under "Jobs" select the "apply-" job that ran 
      ![](images/apply-job.png)

      Under "Resources" on the left you can navigate to "Outputs" where you will find the variables again.
      ![](images/outputs.png)

You may now *proceed to the next lab*.

## Learn More

* [Oracle Cloud Resource Manager](https://docs.cloud.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm)
* [Oracle Cloud Autonomous Database](https://docs.cloud.oracle.com/en-us/iaas/Content/Database/Concepts/adboverview.htm)

## Acknowledgements
- **Owners** - Graeme Rocher, Architect, Oracle Labs - Databases and Optimization
- **Contributors** - Chris Bensen, Todd Sharp, Eric Sedlar
- **Last Updated By** - Kay Malcolm, DB Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
