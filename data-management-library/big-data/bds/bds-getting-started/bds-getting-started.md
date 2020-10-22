# Set Up Your BDS Environment

## Introduction

In this lab, you will perform a few tasks that are required to get started with BDS. Several of these tasks need to be performed by the Cloud Administrator for your tenancy. There are also optional tasks that make it easier to manage your environment. For example, creating compartments and groups are optional; however, they will simplify administration tasks as your environment expands.

### Objectives

In this lab, you will practice performing both the required and optional tasks described in the following table for educational purposes. If you have restrictions on what you can create in your setup, you can use your existing resources; however, make a note of your resources' names which you will need when you create your cluster in the next lab.

**Note:** The steps in this lab and any other labs should be performed sequentially.

| Task                                                             | Purpose                                                                                                                                                                                                                                                                                                                 | Who?                                      | Required? |
|------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|-----------|
| [STEP 1: Log in to Oracle Cloud Console](#STEP1:LogintotheOracleCloudConsole)                         | Log in to the Oracle Cloud Console to create a compartment, a user, a group, policies, a virtual cloud network, and a BDS cluster. | Cloud Administrator                      | No        |
| [STEP 2: Create a Compartment for BDS Resources](#STEP2:CreateaCompartment)                         | Create a compartment named **`training-compartment `** in your tenancy to help organize your BDS resources.                                            STEP                                                                                             | Cloud Administrator                      | No        |
| [STEP 3: Create an Identity and Access Management (IAM) User to be the BDS Administrator](#STEP3:CreateanIAMUsertoBetheBDSAdministrator)           | Create a user named **`training-bds-admin`** that you will add to the administrators group to become a BDS Administrator.                                                                                                                                                                                                          | Cloud Administrator                      | No        |
| [STEP 4: Create an IAM BDS Administrators Group and Add the New User to the Group](#STEP4:CreateanIAMBDSAdministratorsGroupandAddtheNewUsertotheGroup) | <ul><li>Create an administrators group named **`training-bds-admin-group`** with permissions to create and manage your BDS resources.</ul></li><ul> <li>Add the new user to this group to become a BDS Administrator.</ul></li> | Cloud Administrator                      | No        |
| [STEP 5: Create IAM Policies for Administering Your Service](#STEP5:CreateIAMPoliciesforAdministeringYourService) |<ul><li>Create a policy named **`training-admin-policy`** to grant permissions to the BDS Administrator group to manage the cluster.</ul></li><ul><li>Create a second policy named **`training-bds-policy`** to grant permissions to BDS to create clusters in your tenancy.</ul></li>| Cloud Administrator or BDS Administrator   | **Yes**       |
| [STEP 6: Create a Virtual Cloud Network (VCN)](#STEP6:CreateaVirtualCloudNetwork(VCN))                             | Create a Virtual Cloud Network (VCN) in your tenancy named **`training-vcn`**, to be used by your cluster(s). Alternatively, you can use an existing VCN in the tenancy.                                                                                                                                                              | Cloud Administrator or BDS Administrator | **Yes**       |

### What Do You Need?

Login credentials and a tenancy name for the Oracle Cloud Infrastructure Console.


## **STEP 1:** Log in to the Oracle Cloud Console

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator. You will complete all the labs in this workshop using this Cloud Administrator.
See [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm) in the _Oracle Cloud Infrastructure_ documentation.

2. On the **Sign In** page, select your tenancy, enter your username and password, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

   ![](./images/oracle-cloud-console-home.png " ")    

## **STEP 2:** Create a Compartment
A Cloud Administrator can optionally create a compartment in your tenancy to help organize the Big Data Service resources. In this lab, as a Cloud Administrator, you will create a new compartment that will group all of your BDS resources that you will use in the lab.

1. Click the **Navigation** menu in the upper left-hand corner of the **Oracle Cloud Console** Home page.

2. Under **Governance and Administration**, select **Identity > Compartments**.

   ![](./images/training-governance-identity-compartment.png " ")

   **Note:**
   You can alternatively select **Governance and Administration > Identity**. This displays the **Users** page with the **Identity** panel displayed on the left. This panel enables you to easily display the **Users**, **Groups**, **Policies**, and **Compartments** pages that you will need to create the resources required in this lab.

   ![](./images/alternative-access.png " ")

3. On the **Compartments** page, click **Create Compartment**.

4. In the **Create Compartment** dialog box, enter **`training-compartment`** in the **NAME** field and **`Training Compartment`** in the **DESCRIPTION** field.

5. In the **PARENT COMPARTMENT** drop-down list, select your parent compartment, and then click **Create Compartment**.

   ![](./images/create-compartment.png " ")

   The **Compartments** page is re-displayed and the newly created compartment is displayed in the list of available compartments.

   ![](./images/compartment-created.png " ")

## **STEP 3:** Create an IAM User to Be the BDS Administrator

A Cloud Administrator has complete control over all of the BDS resources in the tenancy; however, it's a good practice to delegate cluster administration tasks to one or more BDS administrators. To create a new BDS administrator for a service, a Cloud Administrator must create a user and then add that user to a BDS administrators group. You create Identity and Access Management (IAM) groups with access privileges that are appropriate to your needs.

Create a new **Administrator** group that will have full access rights to the new compartment that you created earlier as follows:

1. In the **Oracle Cloud Console** page, click the **Navigation** menu.

2. Under **Governance and Administration**, select **Identity**, and then click **Users**.

3. On the **Users** page, click **Create User**.

4. In the **Create User** dialog box, enter **`training-bds-admin`** in the **NAME** field, **`training BDS Admin User`** in the  **DESCRIPTION** field, an optional email address for the user in the **EMAIL** field, and then click **Create**.

  **Note:**
  An email address can be used as the user name, but it isn't required.

   ![](./images/create-user.png " ")

5. The **Users** page is re-displayed and the newly created user is displayed in the list of available users.

   ![](./images/user-created.png " ")


   **Note:** In this workshop, you will not login to OCI using the new **`training-bds-admin`** user that you just created in this step; instead, you will continue your work using the same Cloud Administrator user that you used so far in this workshop. As a Cloud Administrator, you can create a one-time password for the new **`training-bds-admin`** user. The user must change the password when they sign in to the Console. For detailed information on this topic, see [Managing User Credentials](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcredentials.htm) in the OCI documentation.


## **STEP 4:** Create an IAM BDS Administrators Group and Add the New User to the Group

Create a BDS group whose members will be granted permissions to manage the BDS cluster life cycle.

1. In the **Oracle Cloud Console** page, click the **Navigation** menu.

2. Under **Governance and Administration**, select **Identity**, and then click **Groups**.

3. On the **Groups** page, click **Create Group**.

   ![](./images/create-group.png " ")

4. In the **Create Group** dialog box, enter **`training-bds-admin-group`** in the **Name** field, **`Training BDS Admin. Group`** in the **Description** field, and then click **Create**.

   ![](./images/create-group-dialog-box.png " ")

5. The **Groups** page is re-displayed and the newly created group is displayed in the list of available groups. Click the **`training-bds-admin-group`** name link.   

   ![](./images/group-created.png " ")

6. On the **Group Details** page, in the **Group Members** section, click **Add User to Group**.

   ![](./images/group-details.png " ")

7. In the **Add User to Group** dialog box, select the **`training-bds-admin`** user that you created earlier from the **USERS** drop-down list, and then click **Add**.

   ![](./images/add-user-group.png " ")

    **Note:**
    If you haven't created the user who will be an administrator yet, go back to **STEP 3: Create an IAM User to be the BDS Administrator to create the user**, create the user, and then return to this step.

8. The **Group Details** page is re-displayed and the newly added user to this group is displayed in the **Group Members** section.

   ![](./images/user-added-to-group.png " ")

## **STEP 5:** Create IAM Policies for Administering Your Service
Create Oracle Cloud Infrastructure Identity and Access Management (IAM) policies to grant privileges to users and groups to use and manage Big Data Service resources. Before you can create a cluster, you must also create a policy that grants the system access to networking resources.

1. In the **Identity** pane on the left, select **Policies**. Alternatively, in the **Oracle Cloud Console** Home page, click the **Navigation** menu, and then navigate to **Governance and Administration > Identity > Policies**.

2. On the **Policies** page, if your compartment is not selected, use the **COMPARTMENT** drop-down list in the **List Scope** section to search for and select the **`training-compartment`** where the new policies will reside.  

   ![](./images/search-box.png " ")

   Type part of the compartment's name in the **Search compartments** text box. When the compartment is displayed in the list, select it.  

   ![](./images/search-compartment.png " ")

3.  Click **Create Policy**.  

    ![](./images/policies-page.png " ")

4. In the **Create Policy** dialog box, provide the following information:

      + Enter **`training-admin-policy`** in the **NAME** field.
      + Enter **`Training Admin Group Policy`** in the **DESCRIPTION** field.
      + Select the **KEEP POLICY CURRENT** option.
      + Use the **COMPARTMENT** drop-down list to select your compartment, if you have not done that yet.
      + In the **Policy Statements** section, click the **Copy** button to copy the policy statement in the box, and then paste it in the **STATEMENT 1** box:

        ```
        <copy>allow group training-bds-admin-group to manage virtual-network-family in compartment training-compartment</copy>
        ```
      + Click **+ Another Statement** to add a **STATEMENT 2** text box to the **Policy Statements** section. Copy the following policy statement, and then paste it in the **STATEMENT 2** box:    

        ```
        <copy>allow group training-bds-admin-group to manage bds-instance in compartment training-compartment</copy>
        ```

       ![](./images/create-policy-1-dialog.png " ")

      + Click **Create**. The newly created policy is displayed in the list of available policies.

        ![](./images/policy-1-created.png " ")

        **Note:** You can click the name of the new policy to view and edit the policy statements in the policy.

5. Create a new policy in the **`training-compartment`** which will contain policies about the network resources that will be used by your **`training-cluster`**. The policy statement in this new policy grants the system the rights to interact with various networking components. Click **Create Policy**.  

6. In the **Create Policy** dialog box, provide the following information:

    + Enter **`training-bds-policy`** in the **NAME** field.
    + Enter **`Training BDS Service Policy`** in the **DESCRIPTION** field.
    + Select the **KEEP POLICY CURRENT** option.
    + Use the **COMPARTMENT** drop-down list to select your compartment, if it's not already  selected.

    + In the a **Policy Statements** section, copy the following policy statement which allows the Big Data Service to access the network, create instances, and more, and then paste it in the **STATEMENT 1** box:
        ```
        <copy>allow service bdsprod to {VNC_READ, VNIC_READ, VNIC_ATTACH, VNIC_DETACH, VNIC_CREATE, VNIC_DELETE,VNIC_ATTACHMENT_READ, SUBNET_READ, VCN_READ, SUBNET_ATTACH, SUBNET_DETACH, INSTANCE_ATTACH_SECONDARY_VNIC, INSTANCE_DETACH_SECONDARY_VNIC} in compartment training-compartment</copy>
        ```
    ![](./images/create-policy-2-dialog.png " ")

    + Click **Create**. The newly created policy is displayed in the list of available policies.

      ![](./images/policy-2-created.png " ")


## **STEP 6:** Create a Virtual Cloud Network (VCN)
In this step of the lab, you will create a new Virtual Cloud Network (VCN) that will be used by your Big Data Service cluster. In general, if you already have an existing VCN, you can use it instead of creating a new one; however, your existing VCN must be using a `Regional` subnet and the appropriate ports must be opened. In addition, if you want to make the cluster accessible from the public internet, the subnet must be public.      

1. In the **Oracle Cloud Console** Home page, click the **Navigation** menu, and then navigate to **Networking > Virtual Cloud Networks**.

   ![](./images/navigate-to-vcn-page.png " ")

2. On the **Virtual Cloud Networks** page, click **Start VCN Wizard**.  

   ![](./images/vcn-page.png " ")

3. In the **Start VCN Wizard** dialog box, select **VCN with Internet Connectivity**, and then click **Start VCN Wizard**.

   ![](./images/start-vcn-wizard.png " ")        

3. The **Configuration** page of the wizard is displayed.

    In the **Basic Information** section, provide the following information:
    + **VCN NAME:** Enter **`training-vcn`**.
    + **COMPARTMENT:** Select **`training-compartment`**.

    ![](./images/basic-information.png " ")        

    In the **Configure VCN and Subnets** section, provide the following information:
    + **VCN CIDR BLOCK:** Enter the range of IP addresses for the network as a Classless Inter-Domain Routing (CIDR) block such as **`10.0.0.0/16`**.
    + **PUBLIC SUBNET CIDR BLOCK:** Enter the CIDR block for the public subnet such as **`10.0.0.0/24`**.
    + **PRIVATE SUBNET CIDR BLOCK:** Enter the CIDR block for the private subnet such as **`10.0.1.0/24`**.
    + In the **DNS RESOLUTION** section, select the **USE DNS HOSTNAMES IN THIS VCN** check box. This allows the use of host names instead of IP addresses for hosts to communicate with each other.

    ![](./images/configure-vcn-subnets.png " ")        

4. Click **Next**. The **Review and Create** wizard's page is displayed. Review the details of the VCN. If you need to make any changes, click **Previous** and make the desired changes.

   ![](./images/vcn-review.png " ")

5. Click **Create**.

   ![](./images/create-vcn.png " ")

6. When the VCN is created, you can click **View Virtual Cloud Network** to see the details of the network on the **Virtual Cloud Network Details** page.

   ![](./images/view-vcn.png " ")

7. The newly created VCN details page is displayed.

   ![](./images/vcn-details.png " ")

**This concludes this lab. Please proceed to the next lab in the Contents menu.**

## Want to Learn More?

* [VCN and Subnets](https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingVCNs.htm)
* [Create a Network](https://docs.oracle.com/en/cloud/paas/big-data-service/user/create-network.html#GUID-36C46027-65AB-4C9B-ACD7-2956B2F1B3D4)
* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Overview of Oracle Cloud Infrastructure Identity and Access Management (IAM)](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)
* [Oracle Cloud Infrastructure Self-paced Learning Modules] (https://www.oracle.com/cloud/iaas/training/foundations.html)
* [Overview of Compute Service](https://www.oracle.com/pls/topic/lookup?ctx=cloud&id=oci_compute_overview)


## Acknowledgements
* **Authors:**
    * Lauran Serhal, Principal UA Developer, Oracle Database and Big Data User Assistance
    * Martin Gubar, Director, Oracle Big Data Product Management
* **Last Updated By/Date:** Lauran Serhal, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
