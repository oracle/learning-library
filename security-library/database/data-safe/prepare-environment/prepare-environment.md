---
inject-note: true
---

# Prepare Your Environment

## Introduction

The preparation required depends on how you want to run this workshop.

- If you are using the Oracle free tier, then you can skip steps 3, 4, and 5 below.
- If you are using a paid account, the preparation required depends on the permissions that you have in your tenancy. If you are a member of the tenancy's `Administrators` group, then you can skip steps 3, 4, and 5 below. If you are a regular user, then you need to enlist the help of a tenancy administrator in your organization to complete steps 2, 3, 4, and 5 below.
- If you are using an Oracle-provided environment, you can skip all of the steps below, except for STEP 7 (Verify the setup). Your Oracle-provided environment already has the resources and permissions set up for you.


Estimated Lab Time: 15 minutes

### Objectives

You learn how to perform the following tasks:

- Enable Oracle Data Safe
- Create a compartment
- Create a user group and add the user account to the group
- Create an IAM policy for the user group
- Grant all Oracle Data Safe privileges to the user group
- Provision an Autonomous Transaction Processing database
- Verify the setup


### Prerequisites

Before starting, be sure that you have completed the following prerequisite tasks:

- You obtained an Oracle Cloud account and signed in to the Oracle Cloud Infrastructure Console.


## **STEP 1**: Enable Oracle Data Safe

Enable Oracle Data Safe in a region of your tenancy. Usually you enable Oracle Data Safe in your home region.

> **Note**: If Oracle Data Safe is already enabled in a region of your tenancy, or you are working in an Oracle-provided environment, you can skip this step.

1. In Oracle Cloud Infrastructure, at the top of the page on the right, select the region in your tenancy in which you want to enable Oracle Data Safe. Usually, you leave your home region selected, for example, **US East (Ashburn)**.

   ![Select Home region](images/select-region.png "Select Home region")

2. From the navigation menu, select **Oracle Database**, and then **Data Safe**.

    The **Overview** page is displayed.

3. Click **Enable Data Safe** and wait a couple of minutes for the service to enable. When it's enabled, a confirmation message is displayed in the upper-right corner.

    ![Enable Data Safe button](images/enable-data-safe-button.png "Enable Data Safe button")



## **STEP 2**: Create a compartment

As a tenancy administrator, create a compartment in your tenancy to store an Autonomous Database and Oracle Data Safe resources. This compartment from here on in is referred to as "your compartment."

> **Note**: If you have an existing compartment in your tenancy that you can use, or you are using an Oracle-provided environment, you can skip this step.

1. From the navigation menu, select **Identity & Security**, and then **Compartments**. The **Compartments** page in Oracle Cloud Infrastructure Identity and Access Management (IAM) is displayed.

2. Click **Create Compartment**. The **Create Compartment** dialog box is displayed.

3. Enter a name for your compartment, for example, `dsc01` (short for Data Safe compartment 1).

4. Enter a description for the compartment, for example, **Compartment for the Oracle Data Safe Workshop**.

5. Click **Create Compartment**.


## **STEP 3**: Create a user group and add the user account to the group

A tenancy administrator needs to create a user group and add your Oracle Cloud account to that group.

> **Note**: If you are a member of your tenancy's `Administrators` group, or you are using an Oracle-provided environment, you can skip this step.

1. From the navigation menu, select **Identity & Security**, and then **Groups**. The **Groups** page in IAM is displayed.

2. Click **Create Group**. The **Create Group** dialog box is displayed.

3. Enter a name for the group, for example, `dsg01` (short for Data Safe group 1).

4. Enter a description for the group, for example, **User group for data safe user 1**. A description is required.

5. (Optional) Create a tag.

6. Click **Create**. The **Group Information** tab is displayed.

7. Under **Group Members**, click **Add User to Group**. The **Add User to Group** dialog box is displayed.

8. From the drop-down list, select the user for this workshop, and then click **Add**. The user account is listed as a group member.


## **STEP 4**: Create an IAM policy for the user group

A tenancy administrator needs to create an IAM policy that allows the user group to which you belong to create an Autonomous Database in a compartment and register and use that database with Oracle Data Safe.

> **Note**: If you are a member of your tenancy's `Administrators` group, or you are using an Oracle-provided environment, you can skip this step.

1. From the navigation menu, select **Identity & Security**, and then **Policies**. The **Policies** page in IAM is displayed.

2. Under **COMPARTMENT**, leave the **root** compartment selected.

3. Click **Create Policy**. The **Create Policy** page is displayed.

4. Enter a name for the policy. It is helpful to name the policy after the group to which the policy pertains, for example, `dsg01 `.

5. Enter a description for the policy, for example, **Policy for Data Safe group 1**.

6. From the **COMPARTMENT** drop-down list, select the **root** compartment.

7. In the **Policy Builder** section, move the **Show manual editor** slider to the right to display the policy field instead of drop-down lists.

8. In the policy field, enter the following policy statements. Substitute {group name} and {compartment name} with the appropriate values.

    ```
    Allow group {group name} to manage all-resources in compartment {compartment name}
    Allow group {group name} to use autonomous-database in compartment {compartment name}

    ```
    The first statement allows the user group to create and manage an Autonomous Database in the specified compartment. The second statement is required so that the user group can register the database with Oracle Data Safe in the specified compartment. The third statement is required so that the user group can use the Autonomous Database with Oracle Data Safe features in the Oracle Data Safe Console.
    ```

9. Click **Create**.


## **STEP 5**: Grant all Oracle Data Safe privileges to the user group

A tenancy administrator or an Oracle Data Safe administrator needs to grant the user group to which you belong the `manage` privilege on all Oracle Data Safe features by creating an authorization policy in the Oracle Data Safe Console.

> **Note**: If you are a member of your tenancy's `Administrators` group, or you are using an Oracle-provided environment, you can skip this step.

1. From the navigation menu, select **Oracle Database**, and then **Data Safe**.

    The **Overview** page is displayed.

2. From the **Overview** page for Oracle Data Safe, click **Service Console** to access the Oracle Data Safe Console.

3. In the Oracle Data Safe Console, click the **Security** tab in the upper-right corner.

4. From the **Compartment** drop-down list, select the user's compartment.

5. For the user group that you created, select **Manage** from the **All Features** drop-down list.

6. Click **Save**.


## **STEP 6**: Provision an Autonomous Transaction Processing database

Provision an Autonomous Transaction Processing (ATP) database to use with Oracle Data Safe.

> **Note**: If you plan to use an existing ATP database in your own tenancy, or you are using an Oracle-provided environment, you can skip this step.

1. From the navigation menu in the Oracle Cloud Infrastructure Console, select **Oracle Database**, and then **Autonomous Transaction Processing**.

2. In the **Filters** section on the left, make sure your workload type is **Transaction Processing** or **All** so that you can see your database listed after you create it.

3. From the **Compartment** drop-down list, select your compartment.

4. Click **Create Autonomous Database**.

5. On the **Create Autonomous Database** page, provide basic information for your database:

    - **Compartment** - If needed, select your compartment.
    - **Display name** - Enter a memorable name for the database for display purposes, for example, **ad01** (short for Autonomous Database 1).
    - **Database Name** - Enter **ad01**. It's important to use letters and numbers only, starting with a letter. The maximum length is 14 characters. Underscores are not supported.
    - **Workload Type** - Leave **Transaction Processing** selected.
    - **Deployment Type** - Leave **Shared Infrastructure** selected.
    - **Always Free** - Leave this option deselected (the slider should be to the left).
    - **Database version** - Leave **19c** selected.
    - **OCPU Count** - Select **1**.
    - **Storage** - Leave **1** selected.
    - **Auto scaling** - Leave this checkbox selected.
    - **Password** and **Confirm Password** - Specify a password for the `ADMIN` database user and jot it down. The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character. It cannot contain your username or the double quote (") character.
    - **Network Access** - Leave **Secure access from everywhere** selected.
    - **License Type** - Select **License Included**.

6. Click **Create Autonomous Database**. The **Autonomous Database Details** page is displayed.

7. Wait a few minutes for your instance to provision. When it is ready, **AVAILABLE** is displayed below the large ATP icon.


## **STEP 7**: Verify the setup

Verify that you can access your ATP database in your compartment and that its status reads AVAILABLE.

> **Note**: If you just provisioned an ATP database in the previous step, then you can skip this step.

1. Make sure that you have the correct region in Oracle Cloud Infrastructure selected.

2. From the navigation menu, select **Oracle Database**, and then **Autonomous Transaction Processing**.

3. From the **Compartment** drop-down list, browse to and select your compartment.

4. On the right, click your database. The **Autonomous Database Information** tab is displayed.

5. Verify that the database's status reads **AVAILABLE**.

6. On the **Autonomous Database Information** tab, under **Data Safe**, verify that there is a **Register** option.


## Learn More

- [Oracle Cloud Infrastructure documentation](https://docs.oracle.com/en-us/iaas/Content/home.htm)
- [Try Oracle Cloud](https://www.oracle.com/cloud/free/)




## Acknowledgements

* **Author** - Jody Glover, Principal User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, June 15 2021
