# Lab Setups

This part of the lab will guide you through some setups that have to happen before we can start the lab.

## **SETUP 1**: Create a Compartment

We are going to create a **Compartment** for this lab so that our functions, logs, database and other OCI components reside in a single place.

1. To create a compartment, use the OCI web console drop down menu and select **Identity & Security**, then **Compartments**.

    ![Use OCI menu for compartments](./images/comp-1.png)

2. On the Compartments page, click the **Create Compartment** button.

    ![Create Compartment Button](./images/comp-2.png)

3. Using the **Create Compartment** modal, set the following values:

    **Name:** livelabs

    ````
    <copy>
    livelabs
    </copy>
    ````

    ![Create Compartment Name Field](./images/comp-3.png)

    **Description:** livelabs

    ````
    <copy>
    livelabs
    </copy>
    ````
    ![Create Compartment Name Field](./images/comp-4.png)

    **Parent Compartment:** Use the root compartment (Should be auto-selected, your root compartment will be named different, but will have (root) after it)

    ![Create Compartment Parent Compartment Field](./images/pol-5.png)

4. When your Create Compartment modal looks like the following image (root compartment name will be different but have (root) after the name), click the **Create Compartment** button.

    ![Create Compartment Modal](./images/pol-6.png)

### Get the Compartment OCID

Before we create some of the resources we need for functions, we need to record the OCID for compartment we just created. Back on the compartments page, find the OCID column of the livelabs compartment we just created and hover your mouse over the characters link in that row. You will see a pop up window with the OCID and a copy link. Click the copy link to copy the compartments OCID and paste it into a text editor for later reference. 
**You may have to refresh the page to see the created compartment.**

![Copy a compartment OCID](./images/compartmentOCID-1.png)

## **SETUP 2**: Setup OCI Permissions

For the Function we create to interact with the Object Store, we first have to create a Dynamic Group and some IAM policies.


### Create a Dynamic Group

Start off by creating a dynamic group. This group will be used with policy generation in the next step. More on Dynamic Groups can be found [here](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingdynamicgroups.htm).

1. Use the OCI web console drop down menu and select **Identity & Security**, then **Dynamic Groups**.

    ![Selecting Dynamic Groups](./images/dgroup-1.png)

2. On the Dynamic Groups page, click **Create Dynamic Group**

    ![Create Dynamic Group Button](./images/dgroup-2.png)

3. On the Create Dynamic Group page, set the following values:

    **Name:** functionsDynamicGroup

    ````
    <copy>
    functionsDynamicGroup
    </copy>
    ````

    ![Create Dynamic Group Name Field](./images/dgroup-3.png)

    **Description:** Dynamic Group for Functions

    ````
    <copy>
    Dynamic Group for Functions
    </copy>
    ````

    ![Create Dynamic Group Description Field](./images/dgroup-4.png)

    **Matching Rules:** 
    
    The Match any rules defined below radio button is selected

    **Rule 1 text is:** 

    ````
    <copy>
    ALL {resource.type = 'fnfunc', resource.compartment.id = '**YOUR COMPARTMENT OCID**'}
    </copy>
    ````
    
    ![Create Dynamic Group Text](./images/dgroup-5.png)

4. Once your Create Dynamic Group page looks like the below image, click the **Create** button. (Remember, your OCID for the compartment will be different than the one in the image)

    ![Create Dynamic Group Filled Out](./images/dgroup-6.png)

5. You will now be on the Dynamic Group Details page for the one we just created

    ![Dynamic Group Details Page](./images/dgroup-7.png)


### Create IAM Policies

Next, we need to associate our dynamic group to some policies so that it has the ability to use object store to see and process the CSV files as they come in.

1. Use the OCI web console menu to navigate to **Identity & Security**, then **Policies**

    ![Navigate to Policies](./images/pol-1.png)

2. On the Policies page

    ![Policies Page](./images/pol-2.png)

    find the Compartment dropdown and select our root compartment if not already selected

    ![Policies Compartment Dropdown](./images/pol-3.png)

3. Next, click the **Create Policy** button

    ![Create Policy Button](./images/pol-4.png)

4. On the Create Policy page, set the following values:

    **Name:** functionPolicies

    ````
    <copy>
    functionPolicies
    </copy>
    ````

    ![Create Policy Name Field](./images/pol-5.png)

    **Description:** Policies for our functions

    ````
    <copy>
    Policies for our functions
    </copy>
    ````

    ![Create Policy Description Field](./images/pol-6.png)

    **Compartment:** livelabs (Should be auto-selected)

    ![Create Policy Compartment Field](./images/pol-7.png)

5. Now in the Policy Builder, click the **Show manual editor** toggle switch

    ![Show manual editor toggle switch](./images/pol-8.png)

6. Copy and paste the following policy code into the text area. You will need to change the text **YOUR_REGION** to reflect the OCI region you are in. You can reference the documentation [here](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm) to find your **Region Identifier** to replace the **YOUR_REGION** text. For example, if we were in the Phoenix OCI region, the policy would be:
    ```
    Allow service objectstorage-us-phoenix-1 to manage object-family in tenancy
    ```
    Now copy and paste the following text and use the appropriate region.

    ````
    <copy>
    Allow dynamic-group functionsDynamicGroup to manage objects in compartment livelabs
    Allow dynamic-group functionsDynamicGroup to manage buckets in compartment livelabs
    Allow service objectstorage-YOUR_REGION to manage object-family in tenancy
    </copy>
    ````

    ![Show manual editor toggle switch](./images/pol-9.png)

7. When your Create Policy page looks like the below image (remember your region may be different than the one in the image), click the **Create** button.

    ![Create Policy Button](./images/pol-10.png)

8. You will be brought to the Policy Details page for the just created policy

    ![Policy Details Page](./images/pol-11.png)

## **SETUP 3**: Create an Autonomous Database

1. Use the OCI web console drop down menu to go to **Oracle Database** and then **Autonomous Database**.

    ![ADB from the menu](./images/adb-1.png)

2. On the Autonomous Database page, change your compartment to the livelabs compartment using the **Compartment** dropdown on the left side of the page.

    ![ADB compartment dropdown](./images/adb-2.png)

3. With the livelabs compartment selected, click the **Create Autonomous Database** button on the top of the page.

    ![Create Autonomous Database button](./images/adb-3.png)


4. In the **Create Autonomous Database** page, we start in the **Provide basic information for the Autonomous Database** section. Here we can ensure our Compartment is livelabs and give our database a **Display Name**. We can use **ORDS ADB** as the Display Name.

    **Display Name:** ORDS ADB

    ````
    <copy>
    ORDS ADB
    </copy>
    ````
    ![Display Name Field](./images/adb-4.png)

    For the **Database Name**, we can use **ORDSADB**.

      **Database Name:** ORDSADB

    ````
    <copy>
    ORDSADB
    </copy>
    ````
    ![Display Name Field](./images/adb-5.png)  

    The **Provide basic information for the Autonomous Database** section should look like the following image:

   ![Provide basic information for the Autonomous Database section](./images/adb-6.png)  

5. For Database **Workload Type**, choose **Transaction Processing**.

   ![Database Workload](./images/adb-7.png)  

6. In the **Deployment Type** section, choose **Shared Infrastructure** if not already selected for you.

   ![Deployment Type](./images/adb-8.png)  

7. Next we have the **Configure the database** section. Start here by clicking the **Always Free** toggle button so that it is switched to the right side as seen in the following image.

   ![Always Free toggle button](./images/adb-9.png)  

8. Use the **Choose database version** dropdown to choose **21c** as the database version.

   ![Choose database version dropdown](./images/adb-10.png)

9. Your **Configure the database** section should look like the following image.

   ![Complete Configure the database section](./images/adb-11.png)

10. The next section is **Create administrator credentials**. Here, provide a password that conforms to the password complexity rules of:

    ```
    Password must be 12 to 30 characters and contain at least one uppercase letter, one lowercase letter, and one number.
    The password cannot contain the double quote (") character or the username "admin".
    ```

    If the password does conform to these rules and matches in both fields, the section should look like the following image.

   ![admin password section](./images/adb-12.png)

11. For the **Choose network access** section, select **Secure access from everywhere** if not already selected. Leave the **Configure access control rules** checkbox unchecked.

   ![admin password section](./images/adb-13.png)

12. The **Choose a license type** section should default to **License Included**.

   ![Choose a license type section](./images/adb-14.png)

13. When the **Create Autonomous Database** is completely filled out, click the **Create Autonomous Database** button on the bottom left of the page.

   ![Create Autonomous Database button](./images/adb-15.png)

14. Your Autonomous Database should be done creating in just a few short minutes. 

15. 

## **SETUP 4**: Create a Virtual Cloud Network

Our functions will need a Virtual Cloud Network (VCN) to live in. We can quickly create one with the VCN Wizard.

1. Use the OCI web console drop down menu to go to **Networking** and then **Virtual Cloud Networks**.

    ![VCN from the menu](./images/vcn-1.png)

2. Next, ensure we are using the livelabs compartment for this Virtual Cloud Network we are about to create. Use the **Compartments** drop down on the left side of the page to select **livelabs**.

    ![choose compartment](./images/vcn-2.png)

3. Back on the top of the page, click the **Start VCN Wizard** button.

    ![click the Start VCN Wizard button](./images/vcn-3.png)

4. After clicking the button, the **Start VCN Wizard** modal window will pop up. Select the **VCN with Internet Connectivity** option if not already selected and then click the **Start VCN Wizard** button on the bottom left of the modal window.

    ![Start VCN Wizard modal](./images/vcn-4.png)

5. On the **Configuration** page of the **Create a VCN with Internet Connectivity** flow, in the **Basic Information** section, set the **VCN Name** to be FunctionsVCN and the **Compartment** to be livelabs if not already selected.

    **VCN Name:** FunctionsVCN

    ````
    <copy>
    FunctionsVCN
    </copy>
    ````
    ![VCN Name Field](./images/vcn-5.png)

    **Compartment:** livelabs (Should be auto-selected)

    ![VCN Compartment Field](./images/vcn-6.png)

    Your **Basic Information** section should look like the following image.

    ![Basic Information section](./images/vcn-7.png)   

6. In the **Configure VCN and Subnets** section, we can leave the default values.

    ![Basic Information section](./images/vcn-8.png)

    Once you have reviewed the default values in the **Configure VCN and Subnets** section, click the **Next** button on the bottom left of the **Create a VCN with Internet Connectivity** page.

   ![click the Next button](./images/vcn-9.png)    

7. On the **Review and Create** page of the **Create a VCN with Internet Connectivity** flow, review the values and when ready, click the **Create** button on the bottom left of the page.

   ![click the Create button](./images/vcn-10.png)

8. Your Virtual Cloud Network components will now be created.

   ![click the Create button](./images/vcn-11.png)

    When done, click the **View Virtual Cloud Network** botton on the bottom left of the page to view the details of the newly created VCN.

   ![click the Create button](./images/vcn-12.png)

## **SETUP 5**: Generate an Auth Token

1. Use the OCI web console menu to navigate to **Identity & Security**, then **Users**

   ![Identity & Security, then Users](./images/tok-1.png)

2. On the Users page, find your user login and click the the name to go to the User Details page.

   ![Users List Page](./images/tok-2.png)

3. On the **User Details** page, on the left side of the page, under **Resources**, find and click **Auth Tokens**.

   ![User Details Page](./images/tok-3.png)

4. With Auth Tokens selected, click the **Generate Token** button.

   ![Generate Token button](./images/tok-4.png)

5. In the **Generate Token** modal window, set the description to **functions**

    ````
    <copy>
    functions
    </copy>
    ````

   ![Generate Token button](./images/tok-5.png)

    then click the **Generate Token** button.

    ![Generate Token button](./images/tok-6.png)

6. The **Generated Token** will now be displayed. Click the **Copy** link and save this token somewhere we can refer to it later in the lab.

    ![Generated Token](./images/tok-7.png)

    When you have copied the token and saved it somewhere (text pad, notes app, etc), click the **Close** button.


## **SETUP 6**: Create Object Store Buckets

The function will be watching an object store bucket for a CSV file, process it then place it into another bucket so we need to create two buckets.

1. Use the OCI web console drop down menu to go to **Storage** and then **Buckets**.

    ![Storage then Buckets](./images/buck-1.png)

2. Next, ensure we are using the livelabs compartment for these buckets we are about to create. Use the **Compartments** drop down on the left side of the page to select **livelabs**.

    ![choose compartment](./images/buck-2.png)

3. Now that we have the compartment set, click the **Create Bucket** button.

    ![Create Bucket button](./images/buck-3.png)

4. Using the **Create Bucket** slide out form, set the **Bucket Name** to **input-bucket**

      **Bucket Name:** input-bucket

    ````
    <copy>
    input-bucket
    </copy>
    ````

    ![Create Bucket button](./images/buck-4.png)

    Once the **Bucket Name** is **input-bucket**, click the **Create** button on the bottom left of the form.

    ![Create button](./images/buck-5.png)

5. We need to create one more bucket. Again click the **Create Bucket** button.

    ![Create Bucket button](./images/buck-3.png)

6. Using the **Create Bucket** slide out form, set the **Bucket Name** to **processed-bucket**

      **Bucket Name:** processed-bucket

    ````
    <copy>
    processed-bucket
    </copy>
    ````

    ![Create Bucket button](./images/buck-6.png)

    Once the **Bucket Name** is **processed-bucket**, click the **Create** button on the bottom left of the form.

    ![Create button](./images/buck-7.png)

7. You should now have two buckets created in the livelabs compartment.

    ![Create button](./images/buck-8.png)

## **SETUP 7**: Create a Vault and Store the Database Admin Password

To ensure we are not using passwords in plain text in any configurations or parts of this lab, we need to create an OCI Vault and place the password for the admin user of the database into the Secrets Service.

1. Use the OCI web console drop down menu to go to **Identity & Security** and then **Valut**.

    ![Identity & Security and then Valut](./images/vault-1.png)

2. Next, ensure we are using the livelabs compartment for the **Vault** we are about to create. Use the **Compartments** drop down on the left side of the page to select **livelabs**.

    ![livelabs compartment](./images/vault-2.png)

3. Now, click the **Create Vault** button on the page.

    ![click the Create Vault button](./images/vault-3.png)

4. In the **Create Vault** slider, ensure that **livelabs** is selected for the **Create in Compartment** dropdown.

    ![livelabs** is selected for the Create in Compartment dropdown](./images/vault-4.png)

5. And lets name the vault **livelabs vault** using the Name field.

    **Name:** livelabs vault
    ````
    <copy>
    livelabs vault
    </copy>
    ````
    ![name field](./images/vault-5.png)

    Also ensure that the **Make it a virtual private vault** checkbox is **not checked** and left empty.

6. Once the **Create Vault** slider looks like the following image, click the **Create Vault** button.

    ![completed create vault slider](./images/vault-6.png)

7. After the vault is done creating, click on the **Vault Name** to view the details.

    ![click on the Vault Name to view the details](./images/vault-7.png)

8. We need to set a **Master Encryption Key** for our vault. On the **Vault Details** page, in the **Master Encryption Keys in livelabs Compartment** section, click the **Create Key** button.

    ![click the Create Key button](./images/vault-8.png)

9. Using the **Create Key** slider, start by ensuring that the **Create in Compartment** dropdown is set to **livelabs**.

    ![Create in Compartment dropdown is set to livelabs](./images/vault-9.png)

10. Next, our **Protection Mode** should be set to **HSM** if not already selected. You can read more about protection modes and keys [here](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm#concepts).

    ![Protection Mode should be set to HSM](./images/vault-10.png)

11. For the **Name** field, use **Vinz Clortho**; this being a master key and all.

    **Name:** Vinz Clortho
    ````
    <copy>
    Vinz Clortho
    </copy>
    ````

    ![Name field](./images/vault-11.png)

12. For our **Key Shape**, set the **Key Shape: Algorithm** to **AES** if not already selected and the **Key Shape: Length** to **256 bits** if also not selected.

    ![click the Create Key button](./images/vault-12.png)

13. When your **Create Key** slider form looks like the following image, click the **Create Key** button.

    ![click the Create Key button](./images/vault-13.png)

14. Once the **Master Encryption Key** is created

    ![Master Encryption Key is created](./images/vault-14.png)

    Use the **Resources** links list on the left of the page and select **Secrets**.

    ![Resources links list on the left of the page and select Secrets](./images/vault-15.png)

15. In the **Secrets in livelabs Compartment** section, click **Create Secret**.

    ![click Create Secret](./images/vault-16.png)

16. Using the **Create Secret** slider, ensure that **livelabs** is selected for the **Create in Compartment** dropdown.

    ![livelabs** is selected for the Create in Compartment dropdown](./images/vault-4.png) 

17. For the **Name** field, enter **dbpwd**.

    **Name:** dbpwd
    ````
    <copy>
    dbpwd
    </copy>
    ````
    ![Name Field](./images/vault-17.png)

18. In the **Description** field, we can enter **Database Password for Admin User**

    **Description:** Database Password for Admin User
    ````
    <copy>
    Database Password for Admin User
    </copy>
    ````
    ![Description Field](./images/vault-18.png)

19. For the **Encryption Key in livelabs** dropdown, select the **Master Key** we just created.

    ![Encryption Key in livelabs dropdown](./images/vault-19.png)

20. The **Secret Type Template** dropdown should be **Plain-Text** if not already selected.

    ![Secret Type Template dropdown should be **Plain-Text](./images/vault-20.png)

21. Lastly, enter the password you used in the **Autonomous Database Creation** section into the **Secret Contents** text area.

    ![Secret Contents text area](./images/vault-21.png)

22. Once your **Create Secret** silder looks like the following image, click the **Create Secret** button in the lower left.

    ![click the Create Secret button](./images/vault-22.png)

23. Once the secret is done creating, use the **pop-up menu** on the right of the secret row and select **Copy OCID**.

    ![click the Create Secret button](./images/vault-23.png)

    Save this OCID in a text editor or notes application for later use.

## Next Steps

Please move to the next section of the lab [Automatically load CSV data from Object Storage into an Autonomous Data Warehouse with Functions and Oracle REST Data Services](../csv-function/csv-function.md).

## Conclusion

In this section, you created a compartment, dynamic group a database and policies for the upcoming lab sections

## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - Brian Spendolini, June 2021