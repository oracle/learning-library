# Provision Audit and Alert Policies on Oracle Data Safe

## Before You Begin
### Objectives
- Provision audit and alert policies on a target database by using the Activity Auditing wizard
- View details for an audit trail in Oracle Data Safe
- Enable a custom audit policy on a target database

### Requirements
To complete this lab, you need to have the following:
- Login credentials and a tenancy name for the Oracle Cloud Infrastructure Console
- Oracle Data Safe enabled in a region of your tenancy
- A registered target database in Oracle Data Safe with sample audit data

### Assumptions
This lab assumes that you are already signed in to the Oracle Data Safe Console. If not, see [View a Registered Target Database](?lab=lab-1-view-registered-target-database), steps 1 and 2.

## **STEP 1**: Provision audit and alert policies on a target database by using the Activity Auditing wizard

- In the Oracle Data Safe Console, click the **Home** tab, and then click the **Activity Auditing** tab.

  ![](./images/access-activity-auditing.png " ")

- On the **Select Targets for Auditing** page, select the check box for your target database, and then click **Continue**.

  ![](./images/select-targets-for-auditing.png " ")

- On the **Retrieve Audit Policies** page, select the check box for your target database, and then click **Retrieve** to retrieve the audit policies for your database.

  ![](./images/retrieve-audit-policies.png " ")

- Wait until a green check mark is displayed in the **Retrieval Status** column, and then click **Continue**.

  The check mark means that all of the audit policies are successfully retrieved.


  ![](./images/policies-retrieved.png " ")

- On the **Review and Provision Audit and Alert Policies** page, review the types of audit policies already enabled on your target database, and then click your target database name to provision more policies.

  The check marks under **Additional Policies** and **Compliance Standards** mean that the Autonomous Transaction Processing (ATP) database has predefined audit policies and the Center for Internet Security (CIS) Configuration audit policy enabled.

  Currently, there are no basic, admin activity, or user activity audit policies provisioned on your database, nor are there any alert policies.


  ![](./images/additional-policies-cis.png " ")


- On the **Audit Policies** tab in the **Edit Policies** dialog box, notice that the following **Basic Auditing** and **Admin Activity Auditing** policies are selected by default. Oracle recommends that you provision these policies. They are not provisioned by default.

  - **Critical Database Activity**
  - **Login Events**
  - **Database Schema Changes (DDL)**
  - **Admin Activity**


  ![](./images/basic-admin-policies.png " ")


- Expand **Custom Policies**.

  If a custom policy is selected, it means that it is already provisioned and enabled on your database. There are two such policies: `EMPSEARCH_SELECT_USAGE_BY_PETE` and `EMP_RECORD_CHANGES`.

  If a custom policy is deselected, it means that you can select it to enable it on your database. There is one such policy: `APP_USER_NOT_APP_SERVER`.

  If a custom policy is selected, but greyed out, it means that the policy is already provisioned and enabled on your database and is mandatory. There are two such policies on an ATP database: `COMMON_USER` and `SYS_USER_ACTIONS`.


  ![](./images/additional-audit-policies.png " ")



- Expand **Oracle Pre-defined Policies** to view the list of Oracle predefined audit policies available on your ATP database. By default, the following policies are provisioned:

  - `ORA_ACCOUNT_MGMT`
  - `ORA_DATABASE_PARAMETER`
  - `ORA_SECURECONFIG`
  - `ORA_DV_AUDPOL`
  - `ORA_DV_AUDPOL2`
  - `ORA_RAS_POLICY_MGMT`
  - `ORA_RAS_SESSION_MGMT`
  - `ORA_LOGON_FAILURES`


  ![](./images/oracle-predefined-policies.png " ")

- Notice that the **Center for Internet Security (CIS) Configuration** policy is provisioned and enabled by default.


  ![](./images/cis-provisioned-enabled.png " ")


- Click the **Alert Policies** tab.


  ![](./images/alert-policies-tab.png " ")

- Review the selected alert policies, and then click **Provision**. Oracle recommends that you provision all of these policies, which are as follows:

  - **Failed Logins by Admin User**
  - **Database Parameter Changes**
  - **Audit Policy Changes**
  - **User Creation/Deletion**
  - **User Entitlement Changes**

   ![](./images/selected-alert-policies.png " ")

- On the **Review and Provision Audit and Alert Policies** page, wait for check marks to appear under all audit policy types, except for **All User Activity**, and then click **Continue**.

  ![](./images/review-provision-audit-alert-policies.png " ")



- On the **Start Audit Collection** page, notice the following defaults:

  The audit trail location is automatically set to  `UNIFIED_AUDIT_TRAIL`.

  Audit collection is not yet started.

  The auto purge feature is enabled.


  ![](./images/start-audit-collection-page.png " ")


- Turn off the auto purge feature by sliding the **Auto Purge Trail** slider to the left.

  You need to turn off this feature if you want to keep the audit data on your target database.

   ![](./images/turn-off-auto-purge.png " ")

- Click **Start** to start collecting audit data.

  ![](./images/click-start-to-collect-audit-data.png " ")

- A message at the top of the page states the `UNIFIED_AUDIT_TRAIL` is successfully created.

  The **Collection State** column indicates that collection is **Loading**, then **STARTING**, and then **COLLECTING**.


  ![](./images/audit-trail-created-audit-collecting.png " ")

- While the audit data is being collected, click **Done**.

  You are directed to the **Audit Trails** page.

   ![](./images/click-done-audit-collection.png " ")




## **STEP 2**: View details for an audit trail

On the **Audit Trails** page, you can manage all of the audit trails for your target databases.

- In the **Collection State** column, click **COLLECTING** or **IDLE** if the audit data is collected.

  Collection takes approximately 2 minutes. You can continue to the next step.


  ![](./images/click-collecting-or-idle.png " ")

- In the **Trail Log** dialog box, review the logs, and then click **X** to close the dialog box.


  ![](./images/trail-log.png " ")



## **STEP 3**: Enable a custom audit policy on a target database


- Click the **Audit Policies** tab.


  ![](./images/click-audit-policies-tab.png " ")



- On the **Review and Provision Audit and Alert Polices** page, click the name of your target database.


  ![](./images/click-database-on-audit-policies-tab.png " ")


- In the **Edit Policies** dialog box, expand **Custom Policies**, select the `APP_USER_NOT_APP_SERVER` unified auditing policy to enable it, and then click **Provision**.


  ![](./images/enable-custom-audit-policy.png " ")  
