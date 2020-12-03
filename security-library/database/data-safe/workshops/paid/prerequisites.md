
# Prerequisites

## Introduction

To complete the Oracle Data Safe labs in your own tenancy in Oracle Cloud Infrastructure, you require access to an Oracle Data Safe environment. As a regular Oracle Cloud user, you do not have the necessary permissions in Oracle Cloud Infrastructure to set up your own environment. The environment needs to be set up by your tenancy administrator. Please refer to STEP 3 below for more detail.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you'll:

- Request access to an Oracle Data Safe service in your tenancy
- Sign in to a region of your tenancy by using your Oracle Cloud account credentials

### Prerequisites

Your tenancy administrator needs to set up an Oracle Data Safe environment for you before you can work through the labs in the Oracle Data Safe Workshop. After the environment is set up, you should have the following items:

- An Oracle Cloud account in your tenancy.
- A compartment in your tenancy. During the labs, you create an Autonomous Database in the compartment and register it with Oracle Data Safe. By using your own compartment, the tenancy administrator can ensure that only you can access your database and save Oracle Data Safe resources to the compartment. In the labs, this compartment is referred to as "your compartment."
- An Oracle Data Safe service that you can access in a region of your tenancy.
- Privileges to use all of the Oracle Data Safe features, including User Assessment, Security Assessment, Activity Auditing, Data Discovery, and Data Masking.

## **STEP 1:** Request access to Oracle Data Safe

1. Send your email address to your tenancy administrator and request a user account in your tenancy and access to Oracle Data Safe.

2. Refer your tenancy administrator to STEP 3 below for instructions on how to set up an Oracle Data Safe environment for you.

## **STEP 2:** Sign in to the Oracle Cloud Infrastructure Console by using your Oracle Cloud account credentials

After the Oracle Data Safe environment is set up by your tenancy administrator, you should receive an email from Oracle with instructions on how to sign in to your tenancy.

1. Access the Oracle email that was sent to you with the sign-in information for your Oracle Cloud user account. The email provides two links to the Oracle Cloud Infrastructure Console (you can use either link), your tenancy name, and your user name.

2. Obtain your password to the tenancy from your tenancy administrator.

3. When you're ready to sign in, click the **Sign in to your new user account** link. The **Oracle Cloud Infrastructure Sign In** page is displayed. Your tenancy name is already filled in for you.

4. Under **Oracle Cloud Infrastructure**, in the **USER NAME** field, enter your Oracle Cloud user name.

5. In the **PASSWORD** field, enter the temporary password provided to you by your tenancy administrator.

6. Click **Sign In**.

7. If prompted by your browser to save the password, click **Never**.

8. If this is the first time that you are signing in to the Oracle Cloud Infrastructure Console, you are prompted to change your password. Enter your temporary password and your new password, and then click **Save New Password**. After you sign in, the message **Email Activation Complete** is displayed.

You are ready to begin the labs. Start with the [**Introduction**](?lab=introduction).

If you have a question during this workshop, you can use the **[Autonomous Data Warehouse Forum](https://cloudcustomerconnect.oracle.com/resources/32a53f8587/summary)** on **Cloud Customer Connect** to post questions, connect with experts, and share your thoughts and ideas about Oracle Data Safe. Are you completely new to the **Cloud Customer Connect** forums? Visit our **[Getting Started forum page](https://cloudcustomerconnect.oracle.com/pages/1f00b02b84)** to learn how to best leverage community resources.

## **STEP 3:** Set Up an Oracle Data Safe Environment

This step is intended for your tenancy administrator. The steps show the administrator how to set up an Oracle Data Safe environment for a regular Oracle Cloud user.

### **Create an Oracle Cloud account for a regular Oracle Cloud user**

You can create a native or federated user account. Both are supported in Oracle Data Safe. The following steps show you how to create a native Oracle Cloud Infrastructure user account. If your tenancy uses federated user accounts, create the user account in the identity provider.

1. Sign in to the Oracle Cloud Infrastructure Console using your tenancy administrator credentials.

2. From the navigation menu, select **Identity**, and then **Users**. The **Users** page in Oracle Cloud Infrastructure Identity and Access Management (IAM) is displayed.

3. Click **Create User**.

4. Enter a short form name for the user account, for example, `dsu01`.

5. Enter a user description for the user account, for example, **Data Safe user 1**.

6. Enter the email address for the user. Oracle will send an email to this address with instructions on how to sign in to the tenancy.

7. Click **Create**. Details about the new user are displayed on the **User Information** tab. Notice that there is a **(Verification Pending)** message next to the email address.

8. Click **Create/Reset Password**. The **Create/Reset Password** dialog box is displayed.

9. Click the **Create/Reset Password** button. A new password is generated.

10. Click the **Copy** link to copy the password to the clipboard. Save the password in your records.

11. Click **Close**.

### **Create a user group and add the user account to the group**

1. From the navigation menu, select **Identity**, and then **Groups**. The **Groups** page in IAM is displayed.

2. Click **Create Group**. The **Create Group** dialog box is displayed.

3. Enter a name for the group, for example, `dsg01` (short for Data Safe group 1)

4. Enter a description for the group, for example, **User group for data safe user 1**. A description is required.

5. (Optional) Create a tag.

6. Click **Create**. The **Group Information** tab is displayed.

7. Under **Group Members**, click **Add User to Group**. The **Add User to Group** dialog box is displayed.

8. From the drop-down list, select the regular Oracle Cloud user account that you created (for example, `dsu01`), and then click **Add**. The user account is listed as a group member.

### **Create a compartment for the user**

1. From the navigation menu, select **Identity**, and then **Compartments**. The **Compartments** page in IAM is displayed.

2. Click **Create Compartment**. The **Create Compartment** dialog box is displayed.

3. Enter a name for the compartment, for example, `dsc01` (short for Data Safe compartment 1).

4. Enter a description for the compartment, for example, **Compartment for Data Safe user 1**.

5. Click **Create Compartment**.

### **Create a policy for the user group**

Create a policy in IAM that grants permissions to the group to which the user belongs. The policy needs to allow the user to create an Autonomous Database in the compartment and use it with Oracle Data Safe.

1. From the navigation menu, select **Identity**, and then **Policies**. The **Policies** page in IAM is displayed.

2. Under **COMPARTMENT**, select the user's compartment.

3. Click **Create Policy**. The **Create Policy** page is displayed.

4. Enter a name for the policy. It is helpful to name the policy after the group to which the policy pertains, for example, `dsg01 `.

5. Enter a description for the policy, for example, **Policy for Data Safe group 1**.

6. From the **COMPARTMENT** drop-down list, select the **root** compartment.

7. In the **Policy Builder** section, do the following:

    a) From the **POLICY USE CASES** drop-down list, select **Compartment Management**.

    b) From the **COMMON POLICY TEMPLATES** drop-down list, select **Let compartment admins manage the compartment**.

    c) From the **GROUPS** drop-down list, select the user group, for example, `dsg01`.

    d) From the **LOCATIONS** drop-down list, select the user's compartment, for example, **dsc01**.

    e) Verify that the policy statement generated reads: **Allow dsg01 to manage all-resources in compartment dsc01**. This statement allows the user to create and manage an Autonomous Database.

8. For **Policy Versioning**, leave **KEEP POLICY CURRENT** selected.

9. Click **Create**.

10. Click **Edit Policy Statements** to add another statement. The **Edit Policy Statements** page is displayed.

11. Click **+ Another Statement**.

12. In the **STATEMENT 2** field, enter **Allow group dsg01 to use autonomous-database in compartment dsc01**. This statement is required so that the user can successfully register and access the database in Oracle Data Safe. Without it, the user can register the database with Oracle Data Safe, but not view it in Oracle Data Safe.

13. Click **Save Changes**.

### **Enable Oracle Data Safe in a region of your tenancy**

You can enable Oracle Data Safe in multiple regions of your tenancy, if needed. For the Oracle Data Safe Workshop, you need to enable Oracle Data Safe in at least one region of your tenancy. Be aware that you cannot disable Oracle Data Safe after it's enabled.

1. From the navigation menu, select **Data Safe**. The **Overview** page is displayed.

2. At the top of the page on the right, select the region in which you want to enable Oracle Data Safe, for example, **US East (Ashburn)**.

3. Click **Enable Data Safe** and wait a couple of minutes for the Oracle Data Safe service to enable.

4. Before continuing, verify that the following message is displayed in the upper-right corner: **Data Safe is enabled. Please click Service Console to use the features**.

### **Grant all Oracle Data Safe privileges to the user group**

1. From the **Overview** page for Oracle Data Safe, click **Service Console** to access the Oracle Data Safe Console. As a tenancy administrator, you have all privileges in Oracle Data Safe.

2. In the Oracle Data Safe Console, click the **Security** tab in the upper-right corner.

3. From the **Compartment** drop-down list, select the user's compartment, for example, `dsc01`.

4. For the user group that you created (for example, `dsg01`), select **Manage** from the **All Features** drop-down list.

5. Click **Save**. The regular user can now access Oracle Data Safe.

### **Send information to the user**

When you are done setting up the environment, email the user with the following information:

- The user's password to access the Oracle Cloud Infrastructure Console.

- The user's compartment name.

## Learn More

- [ Oracle Cloud Infrastructure documentation - Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm)

## Acknowledgements

* **Author** - Jody Glover, Principal User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, November 4, 2020

## Need Help?
Please submit feedback or ask for help using our [Data Safe Community Support Forum]( https://community.oracle.com/tech/developers/categories/data-safe). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
