# Provision Audit and Alert Policies and Configure an Audit Trail in Oracle Data Safe

## Introduction
Using Data Safe, provision audit and alert policies for a target database and configure an audit trail for a target database for collecting audit data.

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

In the lab, you learn how to do the following:
- Provision audit and alert policies for a target database
- Configure an audit trail for a target database for collecting audit data

## Requirements

To complete this lab, you need to have the following:
- Login credentials for your tenancy in Oracle Cloud Infrastructure
- An Oracle Data Safe service enabled in a region of your tenancy
- A registered target database in Oracle Data Safe with sample audit data

## Challenge

Suppose that you are notified that your database may have been breached. You plan to use Oracle Data Safe to collect audit data on your database and review it. Do the following:

1. Sign in to the Oracle Data Safe Console for your region.
2. Review the recommended audit policies for your target database in the Oracle Data Safe Console.
3. Sign in to your ExaCS database as the SYS user with SQL Developer Web.
4. In SQL Developer, query the unified auditing policies available on your target database and those that are already enabled. Compare the results with the audit policies being recommended by Oracle Data Safe.
5. In the Oracle Data Safe Console, provision the following audit policies in the target database and alert policies in Oracle Data Safe.
  - Critical Database Activity
  - Login Events
  - Database Schema Changes (DDL) Admin Activity
  - Custom Policies (`APP_USER_NOT_APP_SERVER`, `EMPSEARCH_SELECT_USAGE_BY_PETE`, and `EMP_RECORD_CHANGES`)
  - Oracle Predefined Policies (all of them) CIS
All of the alert policies
6. Configure the audit trail to collect audit data from the target database and start the audit trail.
7. Review the audit policies for your target database to ensure that the policies you selected are correctly provisioned.

## Steps

### Step 1: Sign in to the Oracle Data Safe Console for your region

If you are already signed in to the Oracle Data Safe Console, you can skip this part.

- From the navigation menu, click **Data Safe**

![](./images/dbsec/datasafe/login/navigation.png " ")

- You are taken to the **Registered Databases** Page.
- Click on **Service Console**

![](./images/dbsec/datasafe/login/service-console.png " ")

- You are taken to the Data Safe login page. Sign into Data Safe using your credentials.

![](./images/dbsec/datasafe/login/sign-in.png " ")

### Step 2: Review the recommended audit policies for a target database in the Oracle Data Safe Console

- In the Oracle Data Safe Console, click the **Home** tab, and then click **Activity Auditing**. The **Select Targets for Auditing** page is displayed.

![](./images/dbsec/datasafe/auditing/activity-auditing-home.png " ")

- Select the check box for your database, and then click **Continue**. The **Retrieve Audit Policies** page is displayed.
- Select the check box for your database, and then click **Retrieve** to retrieve the audit policies for your database.

![](./images/dbsec/datasafe/auditing/retrieve-audit-policy.png " ")

- Wait until a green check mark is displayed in the **Retrieval Status** column. The check mark means that all of the audit policies are successfully retrieved.

![](./images/dbsec/datasafe/auditing/retrieve-audit-policy2.png " ")

- **Click Continue**.
The Review and Provision Audit and Alert Policies page is displayed.

![](./images/dbsec/datasafe/auditing/review-provision.png " ")

- Review the audit policies created on your database.
  - Notice that you have a check mark under **Additional Policies**. By default, additional audit policies (including custom and Oracle predefined audit policies) are provisioned on an ExaCS database.
  - Notice that there are currently no basic, admin activity, user activity, and alert auditing policies provisioned on your database. To learn more about the preconfigured audit policies, see [Audit Policies](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/audit-policies.html) in the Using Oracle Data Safe guide.
- Click your database name.
The Edit Policies dialog box is displayed and shows the Audit Policies tab by default.

![](./images/dbsec/datasafe/auditing/edit-policies.png " ")

- Notice that the following basic auditing and admin activity auditing policies are selected by default. Oracle recommends that you provision (create and enable) these policies. They are not provisioned by default. If you are visiting this dialog box for the first time for your database, then the selected policies are what Oracle recommends you provision; else, the selected policies are already provisioned.
  - Critical Database Activity
  - Login Events
  - Database Schema Changes (DDL)
  - Admin Activity
- Expand Oracle Pre-defined Policies. This list shows you the Oracle predefined audit policies already provisioned on your database. The following policies are provisioned:
  - `ORA_ACCOUNT_MGMT`
  - `ORA_DATABASE_PARAMETER`
  - `ORA_SECURECONFIG`
  - `ORA_DV_AUDPOL`
  - `ORA_DV_AUDPOL2`
  - `ORA_RAS_POLICY_MGMT`
  - `ORA_RAS_SESSION_MGMT`
  - `ORA_LOGON_FAILURES`
  - `ORA_STIG_RECOMMENDATIONS`
  - `ORA_LOGON_LOGOFF`
  - `ORA_ALL_TOPLEVEL_ACTIONS`
- Notice that the check box for **Center for Internet Security (CIS)** Configuration is not selected.
By default, this policy is not provisioned for your ExaCS target. Click the checkbox for **CIS**.
- Leave this dialog box open because you return to it in a later step.

### Step 3: Query the unified auditing policies on your database by using SQL Developer Web and compare with the audit policies being recommended by Oracle Data Safe

- In SQL Developer, run the following query to view the list of unified audit policies.

```
<copy>select distinct policy_name from audit_unified_policies order by policy_name asc;</copy>
```

- Notice that the policies listed in the Oracle Data Safe Console are the same as the query results. If you are using a different type of database, the list may be different.

  - `ORA_ACCOUNT_MGMT`
  - `ORA_DATABASE_PARAMETER`
  - `ORA_SECURECONFIG`
  - `ORA_DV_AUDPOL`
  - `ORA_DV_AUDPOL2`
  - `ORA_RAS_POLICY_MGMT`
  - `ORA_RAS_SESSION_MGMT`
  - `ORA_LOGON_FAILURES`
  - `ORA_CIS_RECOMMENDATIONS`

- Run the following query to view the list of unified audit policies that are enabled.

```
<copy>select * from audit_unified_enabled_policies order by policy_name asc;</copy>
```

- Notice that only the `ORA_LOGON_FAILURES` and `ORA_SECURECONFIG` are listed by default. If you are using a different type of database, the list may be different.

### Step 4: In the Oracle Data Safe Console, provision audit policies in the target database and alert policies in Oracle Data Safe

- Return to the Oracle Data Safe Console.
You should be in the **Edit Policies** dialog box, where you left off.
- Select the checkboxes for each of the policies under the **Oracle pre-defined policies**.
- Click the **Alert Policies** tab.

![](./images/dbsec/datasafe/auditing/alert-policies.png " ")

- Notice that by default, all of the alert policies are selected to be provisioned. Oracle recommends that you provision these policies.
  - `Failed Logins by Admin User`
  - `Audit Policy Changes`
  - `Database Parameter Changes`
  - `User Entitlement Changes`
  - `User Creation/Deletion`
- Click the Audit Policies tab and double-check that the following policies are selected:
  - Critical Database Activity
  - Login Events
  - Database Schema Changes (DDL) Admin Activity
  - Oracle Predefined Policies (see below)
  - Center for Internet Security (CIS) Configuration

![](./images/dbsec/datasafe/auditing/additional-alert-policies.png " ")

- **Click Provision**.
The **Review and Provision Audit and Alert Policies** page shows check marks for all audit policy types, except for **All User Activity**.

![](./images/dbsec/datasafe/auditing/review-audit-policies.png " ")

### Step 5: Configure the audit trail to collect audit data from the target database and start the audit trail

- Click **Continue**.
- On the Start Audit Collection page, notice the following defaults:
  - The audit trail location is `UNIFIED_AUDIT_TRAIL` for an ExaCS database.
  - Audit collection is not yet started.
  - The auto purge feature is disabled.

![](./images/dbsec/datasafe/auditing/start-audit-collection.png " ")

- View other options for audit trails:
  - Click *Add*. The **Register Audit Trail** dialog box is displayed.
  - In the **Target Name** drop-down list, select your target database.
![](./images/dbsec/datasafe/auditing/register-audit-trail.png " ")
  - Notice that you cannot deselect `UNIFIED_AUDIT_TRAIL`. The other types of audit trails are `SYS.FGA_LOG$`, `SYS.AUD$`, and `DVSYS.AUDIT_TRAIL$`.
  - Notice that you can set the **Auto Purge Trail** feature for the newly selected audit trails. By default, the feature is off.
  - Click **Cancel**.
- **IMPORTANT**: Turn off the auto purge feature by sliding the Auto Purge Trail slider to the left.
You need to turn this feature off if you want to keep the audit data on your target database.
- Click **Start** to start collecting audit data. A message at the top of the page states the `UNIFIED_AUDIT_TRAIL` is successfully created.

![](./images/dbsec/datasafe/auditing/start-audit.png " ")

- Notice that the **Collection State** column indicates **COLLECTING**, meaning that collection is running.

![](./images/dbsec/datasafe/auditing/collecting-audit.png " ")

- While the audit data is being collected, click **Done**. You are directed to the **Audit Trails** page.

![](./images/dbsec/datasafe/auditing/audit-trails.png " ")

- Wait a couple of minutes for the audit data to be collected from your target database.
  - When collection is finished, the **Collection State** column reads **IDLE**.
  - If you suspect that the audit collection is not working properly, restart the collection process. To do this, select the check box for your target database, click **Stop**, wait until collection stops (the **Collection State** column reads **STOPPED**), and then click **Start**.
  - Make sure that the auto purge feature is not enabled for your target database.

![](./images/dbsec/datasafe/auditing/idle.png " ")

### Step 6: Review the audit policies for your target database to ensure that the policies you selected are correctly provisioned

1. Click the **Targets** tab, and then click **Audit Policies**. The **Audit and Alert Policies page** is displayed.
2. Click the name of your target database.
The **Edit Policies** dialog box is displayed. Here you can provision and disable audit and alert policies, if needed.
3. Click **Cancel**.

### All Done!
