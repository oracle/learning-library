# Setup OCI, OKE, ATP and Cloud shell
## Introduction

This 25-minute lab will show you how to setup the Oracle Cloud Infrastructure Container Engine for Kubernetes for creating and deploying a front-end helidon application which accesses in the backend the Oracle Autonomous Database.

### Objectives

* Setup the OKE cluster
* Setup the ATP databases

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).

## **STEP 1**: Create the basic OCI resources
You'll need to keep track of important information about the tenancy, such as resource IDs, Tenancy OCID, Region name and user OCID.

1. Download and save <a href="files/ConvergedDBWorksheet.txt" target="\_blank">ConvergedDBWorksheet.txt</a> to store and keep track of the data you'll need in later labs. Open this file in a text editor.

2. On your Oracle Cloud account, open up the hamburger menu in the top-left corner of the Console. Choose **Administration > Tenancy Details**.

  ![](images/1-tenancy-details.png " ")

3. The Tenancy Details page shows information about your cloud account. Note the Tenancy OCID by clicking on the **Copy** link next to it. Also note the Object Storage Namespace.

  ![](images/2-copy-ocid.png " ")

4. To get the Region name, open up the hamburger menu in the top-left corner of the Console and choose **Administration > Region Management**. Note down the region identifier.

  ![](images/3-admin-region-mgmt.png " ")

  In this example, the home region is US West, and the region identifier is `us-phoenix-1`.

  ![](images/4-example-region-id.png " ")

5. To get the User OCID, open up the User icon in the top-right corner of the Console, and click your user name. Note your user name. If your user is federated, it will be prefixed with `oracleidentitycloudservice/`.

  ![](images/5-get-user-ocid.png " ")

6. On the next page, note the OCID by clicking on the **Copy** link next to it.

  ![](images/6-example-user-ocid.png " ")

## **STEP 2**: Create User API Keys

To create a user API key, you will use the Cloud Shell. Cloud Shell is a small virtual machine running a Bash shell which you access through the OCI Console. Cloud Shell comes with a pre-authenticated OCI CLI, set to the Console tenancy home page region, as well as up-to-date tools and utilities.

1.	Click the Cloud Shell icon in the top-right corner of the Console.

  ![](images/7-open-cloud-shell.png " ")

2. Once the Cloud Shell has started, confirm that the `.oci` directory doesn’t already exist.

    ```
    <copy>ls ~/.oci</copy>
    ```

  ![](images/8-confirm-oci-dir.png " ")

3. Assuming the` ~/.oci` directory does not already exist, create it using the following command.

    ```
    <copy>mkdir ~/.oci</copy>
    ```

  ![](images/8A-create-oci-dir.png " ")

4. Generate a private key with the following command. Choose a private key name you can remember. When prompted, enter a passphrase to encrypt the private key file. Be sure to make a note of the passphrase you enter, as you will need it later. When prompted again, re-enter the passphrase to confirm it.

    ```
    <copy>openssl genrsa -out ~/.oci/user1_api_key_private.pem -aes128 2048</copy>
    ```

  ![](images/8B-gen-private-key.png " ")

5. Confirm that the private key file has been created in the directory you specified using the following command. Note the complete path to the private key because you will need it later.

    ```
    <copy>ls -l ~/.oci/user1_api_key_private.pem</copy>
    ```

  ![](images/8C-confirm-private-key.png " ")

6. Change permissions on the file to ensure that only you can read it.

    ```
    <copy>chmod go-rwx ~/.oci/user1_api_key_private.pem</copy>
    ```

  ![](images/8D-change-perm-priv-key.png " ")

7. Generate a public key in the same location as the private key file using the following command. When prompted, enter the same passphrase you previously used to encrypt the private key file.

    ```
    <copy>openssl rsa -pubout -in ~/.oci/user1_api_key_private.pem -out ~/.oci/user1_api_key_public.pem</copy>
    ```

  ![](images/8E-gen-public-key.png " ")

8. Confirm that the public key file has been created in the directory you specified.

    ```
    <copy>ls -l ~/.oci</copy>
    ```

  ![](images/9-confim-public-key.png " ")

9. Copy the content of the public key file you just created to your clipboard by opening the file, selecting the entire content and right-click to copy.

    ```
    <copy>cat ~/.oci/user1_api_key_public.pem</copy>
    ```

  ![](images/10-copy-public-key.png " ")

10. Having created the API key pair, upload the public key value to Oracle Cloud Infrastructure. In the top-right corner of the Console, open the Profile menu (User menu icon) and then click **User Settings** to view the details.

  ![](images/11-user-settings.png " ")

11. On the API Keys page, click **Add Public Key**.

  ![](images/12-upload-key.png " ")

12. Paste the public key's value into the window and click **Add**. The key is uploaded, and its fingerprint is displayed. Note the fingerprint value, you'll use the fingerprint later.

  ![](images/13-upload-key2.png " ")

  ![](images/14-save-fingerprint.png " ")

## **STEP 3**: Create a Compartment for OKE and ATP Resources

You will now create a compartment which would hold the resources used by OKE and ATP.

1. Open up the hamburger in the top-left corner of the Console and select **Identity > Compartments**.

  ![](images/15-identity-compartments.png " ")

2. Click **Create Compartment** with the following parameters:
    - Compartment name: `msdataworkshop`
    - Description: `MS workshop compartment`

  ![](images/16-create-compartment.png " ")

  ![](images/17-create-compartment2.png " ")

3. Once the compartment is created, click on the name of the compartment and note of the compartment name and OCID.

  ![](images/19-compartment-name-ocid.png " ")

  ![](images/20-compartment-ocid.png " ")

## **STEP 4**: Create an Oracle Cloud Infrastructure Registry and Auth key
You are now going to create an Oracle Cloud Infrastructure Registry and an Auth key. Oracle Cloud Infrastructure Registry is an Oracle-managed registry that enables you to simplify your development to production workflow by storing, sharing, and managing development artifacts such as Docker images.

1. Open up the hamburger button in the top-left corner of the console and go to **Developer Services > Registry (OCIR)**.

  ![](images/21-dev-services-registry.png " ")

2. Click **Create Repository** and specify the following details for your new repository.
    - Repository Name: `<firstname.lastname>/msdataworkshop`
	  - Access: `Public`

  You can only make the new repository public if you belong to the tenancy's Administrators group or have been granted the REPOSITORY_MANAGE permission. If you make the new repository public, any user with internet access and knowledge of the appropriate URL will be able to pull images from the repository. If you make the repository private, you (along with users belonging to the tenancy's Administrators group) will be able to perform any operation on the repository.

  ![](images/22-create-repo.png " ")

  ![](images/22-create-repo2.png " ")

3. You will now create the Auth key by going back to the User Settings page. Click the Profile icon in the top-right corner of the Console and select **User Settings**.

  ![](images/23-user-settings.png " ")

4. Click on **Auth Tokens** and select **Generate Token**.

  ![](images/24-gen-auth-token.png " ")

5. In the description type `msdataworkshoptoken` and click **Generate Token**. Once the token has been generated, it is important to note down the token, as it will not be shown again.

  ![](images/25-gen-auth-token2.png " ")

  ![](images/26-save-auth-token.png " ")

## **STEP 5**: Create OKE Cluster

1.  To create an OKE cluster, open up the hamburger button in the top-left
    corner of the Console and go to **Developer Services > Container Clusters
    (OKE)**.

  ![](images/27-dev-services-oke.png " ")

2. Make sure you are in the newly created compartment and click **Create Cluster**.

  ![](images/28-create-oke.png " ")

3. Choose **Quick Create** as it will create the new cluster along with the new network
resources such as Virtual Cloud Network (VCN), Internet Gateway (IG), NAT
Gateway (NAT), Regional Subnet for worker nodes, and a Regional Subnet for load
balancers. Click **Launch Workflow**.

  ![](images/29-create-oke-wizard.png " ")

4. Change the name of the cluster to `msdataworkshopcluster`, set the kubernetes version to **v1.15.7**, and accept all the other
defaults, and click **Next** to review the cluster settings.

  *The default kubernetes version is v1.16.8. If you do not change the version to v1.15.7 you may encounter errors that prevent the completion of this workshop.*

  ![](images/30-create-oke-wizard2.png " ")

5. The defaults will create 3 worker nodes in a private subnet with a `VM.Standard2.1` shape. Once reviewed click **Create Cluster**, and you will see the resource creation progress.

  ![](images/31-create-oke-wizard3.png " ")

6. Close the creation window.

  ![](images/32-close-cluster-create.png " ")

7. Once launched it should usually take around 5-10 minutes for the cluster to be
fully provisioned and the Cluster Status should show Active. Go to the
`msdataworkshopcluster` page and check that the Cluster Status shows Active, and
note down the Cluster ID.

  ![](images/33-click-cluster-name.png " ")

  ![](images/34-copy-cluster-id.png " ")

## **STEP 6**: Setup ATP databases

1. To create the two Autonomous Transaction Processing databases, open up the
    hamburger button in the top-left corner of the Console and go to Autonomous
    Transaction Processing.

  ![](images/35-open-atp-menu.png " ")

2. You will create the ATP databases in the same compartment as the OKE cluster, so make sure compartment `msdataworkshop` is displayed, and click **Create Autonomous Database**.

  ![](images/36-create-atp-instance.png " ")

3. You will create two ATP databases called `orderdb` and `inventorydb`. On the Create
Autonomous Database page provide the following basic information and click **Create Autonomous Database**:

    -   Compartment: `msdataworkshop`
    -   Display name: `Order DB`
    -   Database name: `orderdb`
    -   Workload type: `Transaction Processing`
    -   Deployment type: `Shared Infrastructure`
    -   Leave the defaults for version, OCPU count and Storage
    -   Leave Auto scaling on
    -   Provide the admin password - *Note: do not use special characters in the password, instead use integers and upper and lower case characters.*
    -   Leave the defaults for network access, which is “Allow secure access from
        everywhere”
    -   License type: `License included`

  ![](images/37-create-atp2.png " ")

4. It will take a couple of minutes for the database to be provisioned, in the
meantime you can proceed to create the second ATP instance. Click the Autonomous
Database link in the top-left corner of the page to get back to the Autonomous
Database main page and click **Create Autonomous Database**.

  ![](images/38-return-main-page.png " ")

  ![](images/39-create-second-atp.png " ")

5. For `inventorydb` database follow the same steps and provide the following basic
information and click **Create Autonomous Database**:

    -   Compartment: `msdataworkshop`
    -   Display name: `Inventory DB`
    -   Database name: `inventorydb`
    -   Workload type: `Transaction Processing`
    -   Deployment type: `Shared Infrastructure`
    -   Leave the defaults for version, OCPU count and Storage
    -   Leave Auto scaling on
    -   Provide the admin password
    -   Leave the defaults for network access, which is “Allow secure access from
        everywhere”
    -   License type: `License included`

  ![](images/40-create-second-atp2.png " ")

6. Once both databases are provisioned you should see the state changed to
Available. Click on each of the ATP names in order to go to their pages and copy
their OCIDs.

  ![](images/41-copy-atp-ocids.png " ")

  ![](images/42-copy-atp-ocids2.png " ")

  ![](images/43-copy-ocids3.png " ")

  You have successfully created the two ATP databases that will be used for
  backend inventory and order datastores.

## **STEP 7**: Access OKE from the Cloud Shell
For this step, we are going to use the Cloud Shell to access the OKE cluster
we created in Step 5 and we will verify that all the cluster resources are up
and running.

1.  In the Cloud console go to **Developer Services > Container Clusters (OKE)**.

    ![](images/44-dev-services-oke.png " ")

2. From the available clusters select the `msdataworkshopcluster` you have created in Step 5.

    ![](images/45-open-cluster.png " ")

3. On the cluster page click **Access Cluster** button to get the list of available methods of accessing the cluster.

    ![](images/46-access-cluster.png " ")

4.  Click on **Launch Cloud Shell**, copy the Cloud Shell command, and execute it.
    This will configure `kubectl` and create a new `kubeconfig` file in the default
    `~/.kube/config` location, allowing you to manage your cluster remotely via
    Cloud Shell.

    ![](images/47-cloud-shell-access.png " ")

5.  You can now verify the OKE cluster and check that all the pods are up and
    running using the following command

    ```
    <copy>kubectl get pods --all-namespaces</copy>
    ```

    ![](images/48-verify-oke.png " ")

    *Note: You may have to execute the command a couple times to see all the pods.*

You may proceed to the next lab.

## Acknowledgements
* **Author** - Paul Parkinson, Consulting Member of Technical Staff
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
