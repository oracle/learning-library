# Setup Compute and Autonomous DB

## Introduction
This lab will show you how to setup a Resource Manager stack that will generate the Oracle Cloud objects needed to run this workshop.  This workshop requires a compute instance running the Converged Database marketplace image, Autonomous Database and a Virtual Cloud Network (VCN).

The compute image has two docker images running the eShop application.  The docker images will connect to an autonomous database.  You will connect to the compute instance and import all the data needed for eShop into ADB.  For this workshop we will use the Autonomous JSON Database (AJD).

*Estimated Lab Time:* 15 minutes

### About Terraform and Oracle Cloud Resource Manager
For more information about Terraform and Resource Manager, please see the appendix below.

### Objectives
-   Create Compute + ADB + Networking Resource Manager Stack
-   Connect to compute instance

### Prerequisites
This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account
- SSH Keys

## **STEP 1A**: Create Stack:  Compute + Networking

If you already have a VCN setup, proceed to *Step 1B*.

1.  Click on the link below to download the Resource Manager zip file you need to build your environment.  
      - [converged-db-adb.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/SkUC15rHseuHYjEmashs0PEuQYWofh2ver_pSBxHtphjaRG0MU6XgrMbMZpb3yIf/n/idcd8c1uxhbm/b/converged-db/o/converged-db-adb.zip)

2.  Save in your downloads folder.
3.  Login to Oracle Cloud
4.  Open up the hamburger menu in the left hand corner.  Choose the compartment in which you would like to install.  Under the **Solutions and Platform** submenu, choose **Resource Manager > Stacks**.  Click the **Create Stack** button.

  ![](./images/em-oci-landing.png " ")

  ![](./images/em-nav-to-orm.png " ")

  ![](./images/em-create-stack.png " ")

5.  Select **My Configuration**, choose the **.ZIP FILE** radio button, click the **Browse** link and select the zip file (converged-db-adb.zip) that you downloaded. Click **Select**.

  ![](./images/zip-file.png " ")

6. Enter the following information:

      - **Name**:  Enter a name  or keep the prefilled default (*DO NOT ENTER ANY SPECIAL CHARACTERS HERE*, including periods, underscores, exclamation etc, it will mess up the configuration and you will get an error during the apply process)
      - **Description**:  Same as above
      - **Create in compartment**:  Select the correct compartment if not already selected

     ***Note:*** *If this is a newly provisioned tenant such as freetier with no user created compartment, stop here and first create it before proceeding.*
7.  Click **Next**.

  ![](./images/em-create-stack-2.png " ")

8. Enter or select the following:
    - **Instance Count:** Accept the default, **1**, unless you intend to create more for a team for instance
    - **Select Availability Domain:** Select an availability domain from the dropdown list.
    - **SSH Public Key**:  Paste the public key you created in the earlier lab

    ***Note:*** *If you used the Oracle Cloud Shell to create your key, make sure you paste the pub file in a notepad, remove any hard returns.  The file should be one line or you will not be able to login to your compute instance*
9. Depending on the quota you have in your tenancy you can choose from standard Compute shapes or Flex shapes.  We recommend standard shapes unless you have run out of quota (Please visit the Appendix: Troubleshooting Tips for instructions on checking your quota)
    - **Use Flexible Instance Shape with Adjustable OCPU Count?:** Keep the default as checked (unless you plan on using a fixed shape)
    - **Instance Shape:** Keep the default ***VM.Standard.E3.Flex*** as selected, the only option for Flex shapes.
    - **Instance OCPUS:** Accept the default (**4**) This will provision 4 OCPUs and 64GB of memory. You may also elect to reduce or increase the count in the range [2-24]. Please ensure you have the capacity available before increasing.
10. If you prefer to use fixed shapes, follow the instructions below.  Otherwise skip to the next step.
    - **Use Flexible Instance Shape with Adjustable OCPU Count?:** Unchecked
    - **Instance Shape:** Select VM.Standard.E2.4 (this compute instance requires at least 30 GB of memory to run, make sure to choose accordingly)

  ![](./images/standardshape.png " ")

11. For this section we will provision a new VCN with all the appropriate ingress and egress rules needed to run this workshop.  If you already have a VCN, make sure it has all of the correct ingress and egress rules and skip to the next section.
    - **Use Existing VCN?:** Accept the default by leaving this unchecked. This will create a **new VCN**.

12. Click **Next**.
13. Review and click **Create**.

  ![](./images/em-create-stack-3.png " ")

14. Your stack has now been created!  

  ![](./images/em-stack-details.png " ")

You may now proceed to Step 2 (skip Step 1B).

## **STEP 1B**: Create Stack:  Compute only
If you just completed Step 1A, please proceed to Step 2.  If you have an existing VCN and are comfortable updating VCN configurations, please ensure your VCN meets the minimum requirements.  
- Ingress rules for the following ports:  3000, 3001, 3003, 1521, 7007, 9090, 22          

If you do not know how to add egress rules, skip to the Appendix to add rules to your VCN.  

***Note:*** *We recommend using our stack to create to reduce the potential for error.*

1. Click on the link below to download the Resource Manager zip file you need to build your environment.  
     - [converged-db-mkplc-freetier.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/uZPsGTFvwVSVjMn9JtlhRw5tk8zIiYfIz8iTql-I6eI/n/omcinternal/b/workshop-labs-files/o/converged-db-mkplc-freetier.zip)

2. Save in your downloads folder.
3. Open up the hamburger menu in the left hand corner.  Choose the compartment in which you would like to install.  Choose **Resource Manager > Stacks**.  Click the **Create Stack** button.

  ![](./images/em-oci-landing.png " ")

  ![](./images/em-nav-to-orm.png " ")

  ![](./images/em-create-stack.png " ")

4. Select **My Configuration**, choose the **.ZIP FILE** radio button, click the **Browse** link and select the zip file (converged-db-mkplc-freetier.zip) that you downloaded. Click **Select**.

  ![](./images/zip-file.png " ")

  Enter the following information:
    - **Name**:  Enter a name  or keep the prefilled default (*DO NOT ENTER ANY SPECIAL CHARACTERS HERE*, including periods, underscores, exclamation etc, it will mess up the configuration and you will get an error during the apply process)
    - **Description**:  Same as above
    - **Create in compartment**:  Select the correct compartment if not already selected

  ***Note:*** *If this is a newly provisioned tenant such as freetier with no user created compartment, stop here and first create it before proceeding.*

5. Click **Next**.

  ![](./images/em-create-stack-2b.png " ")

  Enter or select the following:
    - **Instance Count:** Keep the default to **1** to create only one instance. You may also choose to a higher number if you need more than one instance created.
    - **Select Availability Domain:** Select an availability domain from the dropdown list.
    - **SSH Public Key**:  Paste the public key you created in the earlier lab

  ***Note:*** *If you used the Oracle Cloud Shell to create your key, make sure you paste the pub file in a notepad, remove any hard returns.  The file should be one line or you will not be able to login to your compute instance*

    - **Use Flexible Instance Shape with Adjustable OCPU Count?:** Keep the default as checked (unless you plan on using a fixed shape)
    - **Instance Shape:** Keep the default ***VM.Standard.E3.Flex*** as selected, the only option for Flex shapes.
    - **Instance OCPUS:** Accept the default (**4**) This will provision 4 OCPUs and 64GB of memory. You may also elect to reduce or increase the count in the range [2-24]. Please ensure you have the capacity available before increasing.
    - **Use Existing VCN?:** Check to select.

  ![](./images/em-create-stack-2c.png " ")

    - **Select Existing VCN?:** Select existing VCN with regional public subnet and required security list.

  ![](./images/em-create-stack-2d.png " ")

    - **Select Public Subnet:** Select existing public subnet from above VCN.

   ***Note:*** *For an existing VCN Option to be used successful, review the details at the bottom of this section*

6. If you prefer to use fixed shapes, follow the instructions below.  Otherwise skip to the next step.
    - **Use Flexible Instance Shape with Adjustable OCPU Count?:** Unchecked
    - **Instance Shape:** Select VM.Standard.E2.4 (this compute instance requires at least 30 GB of memory to run, make sure to choose accordingly)

  ![](./images/standardshape-2.png " ")

7. Review and click **Create**.

  ![](./images/em-create-stack-3b.png " ")

8. Your stack has now been created!  

  ![](./images/em-stack-details-b.png " ")

## **STEP 2**: Terraform Plan (OPTIONAL)
When using Resource Manager to deploy an environment, execute a terraform **plan** to verify the configuration. This is optional, *you may skip directly to Step 3*.

1.  **[OPTIONAL]** Click **Terraform Actions** -> **Plan** to validate your configuration.  This takes about a minute, please be patient.

  ![](./images/em-stack-plan-1.png " ")

  ![](./images/em-stack-plan-2.png " ")

  ![](./images/em-stack-plan-results-1.png " ")

  ![](./images/em-stack-plan-results-2.png " ")

  ![](./images/em-stack-plan-results-3.png " ")

  ![](./images/em-stack-plan-results-4.png " ")

## **STEP 3**: Terraform Apply
When using Resource Manager to deploy an environment, execute a terraform **apply** to actually create the configuration.  Let's do that now.

1.  At the top of your page, click on **Stack Details**.  click the button, **Terraform Actions** -> **Apply**.  This will create your network (unless you opted to use and existing VCN) and the compute instance.

  ![](./images/em-stack-details-post-plan.png " ")

  ![](./images/em-stack-apply-1.png " ")

  ![](./images/em-stack-apply-2.png " ")

2.  Once this job succeeds, you will get an apply complete notification from Terraform.  Examine it closely, 8 resources have been added (3 only if using an existing VCN).  

***Note:*** *If you encounter any issues running the terraform stack, visit the Appendix: Troubleshooting Tips section below.*

  ![](./images/em-stack-apply-results-0.png " ")

  ![](./images/em-stack-apply-results-1.png " ")

  ![](./images/em-stack-apply-results-2.png " ")

  ![](./images/em-stack-apply-results-3.png " ")

3.  Congratulations, your environment is created!  Click on the Application Information tab to get additional information about what you have just done.

  ![](./images/app-info.png " ")

4.  Your public IP address and instance name will be displayed.  Note the public IP address, you will need it for the next step.

## **STEP 4**: Verify connection to your instance

Choose the environment where you created your ssh-key in the previous lab (Generate SSH Keys)
***Note:*** *If you are not using Cloud Shell and are using your laptop to connect your corporate VPN may prevent you from logging in.*

### Oracle Cloud Shell

1. To re-start the Oracle Cloud shell, go to your Cloud console and click the Cloud Shell icon to the right of the region.  

***Note:*** *Make sure you are in the region you were assigned*

  ![](./images/em-cloudshell.png " ")

2.  If you didn't jot down your compute instances public IP address, go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
3.  On the instance homepage, find the Public IP address for your instance.
4.  Enter the command below to login to your instance.    

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/em-cloudshell-ssh.png " ")

6.  When prompted, answer **yes** to continue connecting.
7.  Exit the instance 
   
    ````
    exit
    ````

## **STEP 5:** Create Oracle Wallet
There are multiple ways to create an Oracle Wallet for ADB.  We will be using Oracle Cloud Shell as this is not the focus of this workshop.  To learn more about Oracle Wallets and use the interface to create one, please refer to the lab in this workshop: [Analyzing Your Data with ADB - Lab 6](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?p180_id=553)

1.  With the autonomous_database_ocid that is listed in your apply results, create the Oracle Wallet. You will be setting the wallet password to a generic value:  *WElcome123##*.  
   
      ````
      <copy>
      oci db autonomous-database generate-wallet --password WElcome123## --file converged-wallet.zip --autonomous-database-id </copy> ocid1.autonomousdatabase.oc1.iad.xxxxxxxxxxxxxxxxxxxxxx
      ````
2.  The wallet file will be downloaded to your cloud shell file system
3.  Click the list command below to verify the *converged-wallet.zip* was created
   
      ````
      ls
      ````
4.  Transfer this wallet file to your application compute instance

    ````
    sftp -i cloudshellkey opc@150.136.216.184 <<< $'mput ../converged-wallet*' 
    ````

## **STEP 6:** Create Auth Token
There are multiple ways to create an Oracle Wallet for ADB.  We will be using Oracle Cloud Shell as this is not the focus of this workshop.  To learn more about Oracle Wallets and use the interface to create one, please refer to the lab in this workshop: [Analyzing Your Data with ADB - Lab 6](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?p180_id=553)

1.  Click on the person icon in the upper right corner.
2.  Select **User Settings**
3.  Under the **User Information** tab, click the **Copy** button to copy your User OCID.
4.  Create your auth token using the command below substituting your actual *user id* for the userid below.
5.  
      ````
      <copy>
       oci iam auth-token create --description ConvergedDB --user-id </copy> ocid1.user.oc1..axxxxxxxxxxxxxxxxxxxxxx
      ````
6.  Copy the token somewhere safe, you will need it for the next step.


## **STEP 7:** Connect to SQL Developer and Create Credentials
1.  Go back to your ATP screen by clicking on the Hamburger Menu -> **Autonomous JSON Database**
2.  Click on the **Display Name**, *cvgadbnn*
3.  Click on the **Tools** tab, select **SQL Developer Web**, a new browsrer will open up
4.  Login with the *admin* user and the password that you wrote down in the previous lab.  (*Note*: the admin password can also be changed in the **More Actions** drop down)
5.  In the worksheet, enter the following command to create your credentials.  Replace the password below with your token. Make sure you do *not* copy the quotes.
   
    ````
    begin
      DBMS_CLOUD.create_credential(
        credential_name => 'DEF_CRED_NAME',
        username => 'admin',
        password => '*****************************'
      );
    end;
    /
    ````


You may now [proceed to the next lab](#next).

## Appendix:  Teraform and Resource Manager
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.  Configuration files describe to Terraform the components needed to run a single application or your entire datacenter.  In this lab a configuration file has been created for you to build network and compute components.  The compute component you will build creates an image out of Oracle's Cloud Marketplace.  This image is running Oracle Linux 7.

Resource Manager is an Oracle Cloud Infrastructure service that allows you to automate the process of provisioning your Oracle Cloud Infrastructure resources. Using Terraform, Resource Manager helps you install, configure, and manage resources through the "infrastructure-as-code" model. To learn more about OCI Resource Manager, take a watch the video below.

[](youtube:udJdVCz5HYs)

### Oracle Cloud Marketplace
The Oracle Cloud Marketplace is a catalog of solutions that extends Oracle Cloud services.  It offers multiple consumption modes and deployment modes.  In this lab we will be deploying the free Oracle Enterprise Manager 13c Workshop marketplace image.

[Link to OCI Marketplace](https://www.oracle.com/cloud/marketplace/)

## Appendix:  Adding Security Rules to an Existing VCN
This workshop requires a certain number of ports to be available.

1.  Go to Networking -> Virtual Cloud Networks
2.  Choose your network
3.  Under Resources, select Security Lists
4.  Click on Default Security Lists under the Create Security List button
5.  Click Add Ingress Rule button
6.  Enter the following:  
    - Source CIDR: 0.0.0.0/0
    - Destination Port Range: 3000, 3001, 3003, 1521, 7007, 9090, 22
7.  Click the Add Ingress Rules button


## Appendix: Troubleshooting Tips

If you encountered any issues during the lab, follow the steps below to resolve them.  If you are unable to resolve, please skip to the **Need Help** section to submit your issue via our  support forum.
- Availability Domain Mismatch
- Limits Exceeded
- Invalid public key
- Flex Shape Not Found

### Issue 1: Availability Domain Mismatch
![](images/error-ad-mismatch.png  " ")

#### Issue #1 Description
When creating a stack and using an existing VCN, the availability domain and the subnet must match otherwise the stack errors.  

#### Fix for Issue #1
1.  Click on **Stack**-> **Edit Stack** -> **Configure Variables**.
2.  Scroll down to the network definition.
3.  Make sure the Availability Domain number matches the subnet number.  E.g. If you choose AD-1, you must also choose subnet #1.
4.  Click **Next**
5.  Click **Save Changes**
6.  Click **Terraform Actions** -> **Apply**

### Issue 2: Invalid public key
![](images/invalid-ssh-key.png  " ")

#### Issue #2 Description
When creating your SSH Key, if the key is invalid the compute instance stack creation will throw an error.

#### Tips for fixing for Issue #2
- Go back to the instructions and ensure you create and **copy/paste** your key into the stack correctly.
- Copying keys from Cloud Shell may put the key string on two lines.  Make sure you remove the hard return and ensure the key is all one line.
- Ensure you pasted the *.pub file into the window.
1.  Click on **Stack**-> **Edit Stack** -> **Configure Variables**.
2.  Repaste the correctly formatted key
3.  Click **Next**
4.  Click **Save Changes**
5.  Click **Terraform Actions** -> **Apply**

### Issue 3: Flex Shape Not Found
![](images/flex-shape-error.png  " ")

#### Issue #3 Description
When creating a stack your ability to create an instance is based on the capacity you have available for your tenancy.

#### Fix for Issue #3
If you have other compute instances you are not using, you can go to those instances and delete them.  If you are using them, follow the instructions to check your available usage and adjust your variables.
1. Click on the Hamburger menu, go to **Governance** -> **Limits, Quotas and Usage**
2. Select **Compute**
3. These labs use the following compute types.  Check your limit, your usage and the amount you have available in each availability domain (click Scope to change Availability Domain)
4. Look for Standard.E2, Standard.E3.Flex and Standard2
4.  Click on the hamburger menu -> **Resource Manager** -> **Stacks**
5.  Click on the stack you created previously
6.  Click **Edit Stack** -> **Configure Variables**.
7.  Scroll down to Options
8.  Change the shape based on the availability you have in your system
9.  Click **Next**
10. Click **Save Changes**
11. Click **Terraform Actions** -> **Apply**

### Issue 4: Limits Exceeded
![](images/no-quota.png  " ")

#### Issue #4 Description
When creating a stack your ability to create an instance is based on the capacity you have available for your tenancy.

*Please ensure that you are NOT running this in the **Always Free** Tier. This workshop does not run on the Always Free tier, you must have available cloud credits.  Go to **Governance** -> **Limits, Quotas and Usage,** select **compute**, ensure that you have **more than** the micro tier available.  If you have only 2 micro computes, your account has transitioned to an Always Free.  This means that the promotional period of 30 days has expired or you have run out of credits, this workshop will NOT run.*

#### Fix for Issue #4
If you have other compute instances you are not using, you can go to those instances and delete them.  If you are using them, follow the instructions to check your available usage and adjust your variables.

1. Click on the Hamburger menu, go to **Governance** -> **Limits, Quotas and Usage**
2. Select **Compute**
3. These labs use the following compute types.  Check your limit, your usage and the amount you have available in each availability domain (click Scope to change Availability Domain)
4. Look for Standard.E2, Standard.E3.Flex and Standard2
5. This workshop requires at least 4 OCPU and a minimum of 30GB of memory.  If you do not have that available you may request a service limit increase at the top of this screen.  If you have located capacity, please continue to the next step.
6.  Click on the Hamburger menu -> **Resource Manager** -> **Stacks**
7.  Click on the stack you created previously
8.  Click **Edit Stack** -> **Configure Variables**.
9.  Scroll down to Options
10. Change the shape based on the availability you have in your system
11. Click **Next**
12. Click **Save Changes**
13. Click **Terraform Actions** -> **Apply**

## Acknowledgements

* **Author** - Rene Fontcha, Master Principal Solutions Architect, NA Technology
* **Contributors** - Kay Malcolm, Product Manager, Database Product Management
* **Last Updated By/Date** - Kay Malcolm, Product Manager, Database Product Management, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
