# Pre-Requisites

## STEP 1: Creating the Cloud Guard User and Group

Create a user with administrator privileges to work with Cloud Guard.

1. Log in to the Oracle Cloud Infrastructure console as a tenancy administrator.
2. In the Oracle Cloud Infrastructure console, from the Navigation Drawer select Identity, Groups.
3. Click Create Group.
4. Fill in the required fields and then click Create. Provide a name that clearly identifies the group, such as `CloudGuardUsers`.
5. From the Navigation Drawer select Identity, Users.
6. Click Create User.
7. Fill in the required fields and then click Create. Provide a name that clearly identifies this is the primary Cloud Guard user, such as `CloudGuard_Console_Operator`.
8.  Select the newly created user to view its details.
9.  In the left panel click Groups.
10. Click Add User to Group.
11. From the drop-down, select the group created in step 3 above, and then click Add.


## STEP 2: Policy Statement

Add a policy statement that enables the Cloud Guard users group you defined to manage Cloud Guard resources.

Add the policy statement below to enable all users in the `CloudGuardUsers` group to manage Cloud Guard resources. Substitute the name you assigned to the group, if you did not name it `CloudGuardUsers`.

`allow group CloudGuardUsers to manage cloud-guard-family in tenancy`

With this policy in place, the user you created is now ready to proceed with Enabling Cloud Guard.

## STEP 3: Enabling Cloud Guard


1. Log in to the OCI Console as the Oracle Cloud Guard user you created in Prerequisites, in the "Creating the Cloud Guard User and Group" section.
2. Open the navigation menu and select Security, Cloud Guard.
3. On the Cloud Guard page, click the Enable Cloud Guard button at top right
4. In the Enable Cloud Guard dialog box:
   1. In the Tenancy Policies section, click one of the enable links. If all required policies are successfully created, the link text changes to enabled.

   2. If any of the enable links change to failed:
      * Move the mouse pointer over the **failed** link to see what the issue was that prevented the policy from being created.
      * Keep the **Enable Cloud Guard** dialog box open in your browser.
      * Resolve the issue.
      * In the **Enable Cloud Guard** dialog box, **Policy Required To Execute panel**, click the **failed** link.
      * The **failed** link should now change to **enabled**.

   3. Select a **Reporting Region**.
   4. Specify **Compartments To Monitor** in the OCI tenancy. Select:
       * **All** to monitor all compartments.
       * **Select compartments**, and then select from the list, to monitor only compartments that you specify.
       * **None** to monitor no compartments. You might want to do this in order to simply view the contents of the detector recipes, before you enable any of them.
   5. (Optional) Select a **Configuration Detector Recipe** from the list. You can do this later. See Managing Detector Recipes.
   6. (Optional) Select an **Activity Detector Recipe** from the list. You can do this later. See Managing Detector Recipes.
   7. Click **Enable**. A progress bar replaces the Enable Cloud Guard button on the Cloud Guard page.

8. When enablement completes, on the Cloud Guard page, click **Go To Cloud Guard**.
9. The Cloud Guard Overview page appears, and the guided tour starts. Gradually, information about problems detected begins to appear. Take the guided tour to familiarize yourself with the features on the Overview page.


******

**What you have done**

You have successfully set up the policies requirements and enabled Cloud Guard. For further infomation on how to enable Cloud Guard, please refer to [Prerequisites](https://docs.cloud.oracle.com/en-us/iaas/cloud-guard/using/prerequisites.htm)

******