# Provisioning Cloud Manager from Resource Manager 

## Introduction
Resource Manager is an Oracle Cloud Infrastructure service that helps you install, configure, and manage resources. Resource Manager uses Terraform (which is part of the service) to codify your infrastructure in declarative configuration files, which allows you to review and edit, version, persist, reuse, and share them across teams. You can then use Resource Manager to provision Oracle Cloud Infrastructure resources using your Terraform configurations.

In this tutorial, you obtain the configuration files, or stack, for Cloud Manager from the Oracle Cloud Infrastructure Marketplace, and use Resource Manager to create an instance and link it with associated resources such as a Virtual Cloud Network (VCN), subnet, gateways, and route tables. You enter the necessary passwords and other information in the Resource Manager interface and choose the types of resources created.

Estimated Lab Time: 30 mins + 1 hour waiting

### Objectives
The purpose of this lab is to show you how to create a PeopleSoft Cloud Manager instance from the Marketplace. 

In this lab, you will:
* Configure a stack for the Cloud Manager 
* Provision a Cloud Manager instance from the Marketplace Stack 
* Login to the Cloud Manager

### Prerequisties
- Oracle Cloud Infrastructure account credentials.
    * User
    * Password
    * Tenant
- Admin privileges on your local machine or Windows instance on Cloud.


## **STEP 1**: Generating Keys

**Option A:** For your convenience, you can use these pre-built keys for the purpose of the demo and skip to Step 2: [TestDrivekeys.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/ayiPYT9IgCE8e4fT1qc3jjyyMKgdIbC-t_zn7TUsx8Lhlqp_W-gSJ0I2r-2c7LU9/n/c4u03/b/solutions-library/o/TestDrivekeys.zip)

**Option B:** If you would like to generate your own keys, continue here:
1. Ensure Git Bash is installed on your laptop/workstation.

2. Download the following script: [make_keys.sh](https://objectstorage.us-ashburn-1.oraclecloud.com/p/4siaoXfcndYoTXRI9y7evzGbNLgCcLt1YjMpb76eW87EAVGoGJCkzFxWk1S-EMn8/n/c4u03/b/solutions-library/o/make_keys.sh)

3. Launch Terminal for Mac or Git Bash for Windows command line and navigate to the folder where the file was downloaded. For example, if the file was downloaded in the Downloads folder, you can type the following command:

    ```
    <copy>
    cd ~/Downloads
    </copy>
    ```

4. Give permission to the file by typing in the command line: 

    ```
    <copy>
    chmod u+rx make_keys.sh
    </copy>
    ```

5. For Windows, run the script:

    ```
    <copy>
    bash make_keys.sh
    </copy>
    ```

  For Mac terminal run the command:

    ```
    <copy>
    ./make_keys.sh
    </copy>
    ```

    ![](./images/4.png "")

6. The command will generate the following sets of key files:

	**I.	API Signing keys**: ``api_key`` and ``api_key.pub``

	**II.	SSH key pair**: ``id_rsa`` and ``id_rsa.pub``

    ```
    Note: These Keys are necessary for you to be able to securely connect into your PeopleSoft Cloud Tenancy.
    ```
    ![](./images/apikeypub.png "")

## **STEP 2**: Setting API Keys for User01

Verify you have the following 4 keys: 
* **API Signing keys**: ``api_key`` and ``api_key.pub``
* **SSH key pair**: ``id_rsa`` and ``id_rsa.pub``

1. Copy the contents of api_key.pub key (the one you have created through the script) as follows: 
    - Right click on the api_key.pub and open with a text editor as shown below. 

    ![](./images/apikeys.png "")  

    ```
    Note: Copy EVERYTHING from the text editor (including the beginning and ending "---") and keep it in your clipboard to paste it in the OCI console.
    ```

2. In a browser, launch the OCI console. Login as **User01**. After you are successfully logged in, click on the **profile button on top right**. Click on your user name - **User01**.
   (Refer to Lab 1 for details on how to login as User01.)

    ![](./images/api.png "")

2. Scroll to the bottom, on the left side click on **API Keys** and then click on **Add Public Key**

    ![](./images/apisetup.png "")

3. Click on **Paste public keys** and paste the content of **api_key.pub** (the one you just copied above). Click on **Add**.  

    ![](./images/apikeypub.png "")

    ![](./images/apipaste.png "")

## **STEP 3**: Gather Information for the Cloud Manager Stack

Paste the below information in a notepad. You will need it later while creating the stack.

1. From the same User detail page, copy the OCID by clicking on **copy** and paste it in your notepad. 

    ![](./images/ocid.png "")

2. On the top right, click on the region. Note the home region displayed in your notepad. 

    ![](./images/homeregion.png "")

## **STEP 4**: Obtain the PeopleSoft Cloud Manager Stack from the Marketplace

To obtain the PeopleSoft Cloud Manager stack:

1. On the Oracle Cloud Infrastructure console home page, click the top left three-line menu icon and select **Marketplace** > **Applications**.

    ![](./images/marketplace.png "")

2. Under Filters on the left, select **Stack** from the Type drop-down list, and **Oracle** from the Publisher drop-down list. Search for **Peoplesoft** on the search bar. Select **PeopleSoft Cloud Manager for OCI**.

    ![](./images/searchpsft.png "")

3. On the Overview page for the PeopleSoft Cloud Manager stack, select the compartment to install the instance. If it's a nested compartment, make sure to click on **+** to navigate to your sub-compartment.   
Review the **Oracle terms**, and then select the option indicating that you have reviewed and understand the conditions.
Click **Launch Stack**. 

    ![](./images/launch.png "")

4. On the Create Stack, Stack Information page, enter a stack name and description if desired.

    Click **Next** 

    ![](./images/psftname.png "")

    Continue with the steps in Enter Cloud Manager Instance Values.

## **STEP 5**: Enter Cloud Manager Instance Values and provision PSFT Cloud

The Create Stack, Configure Variables page includes a list of the parameters needed to create and configure the Cloud Manager instance.

1. In the Cloud Manager Instance section, select the **Availability Domain** as **US-ASHBURN-AD-2**. 

2. For **Shape**, select **VM.Standard2.1**. 

3. Select the **storage volume size in GBs** for the secondary block volume for the Cloud Manager instance. We will set it as **200 GBs**.

4. For SSH public key, enter the contents of your ``id_rsa.pub`` from your keys folder in a single line, with no line feeds or spaces.

5. Enter your **User OCID** (you have copied this in your notepad in Step 3) in a single line, with no line feeds or spaces.

6. For API private key, enter the contents of your ``api_key`` file.   

7. Leave API Private passphrase as blank (Enter if you have created one).

8. For **Tenancy Home Region**, Select the home region for your tenancy from the drop-down list. (You have noted this down in your notepad in Step 3)

    ![](./images/varscm1.png "")

9. Enter following password values:

    Attribute | Value
    --------- | -----
    DB CONNECT PASSWORD	| Psft1234
    ACCESS PASSWORD | Psft1234
    DB ADMIN PASSWORD | Psft1234#
    CLOUD MANAGER ADMINISTRATOR PASSWORD | Psft1234
    INTEGRATION GATEWAY USER PASSWORD | Psft1234
    WEBLOGIC ADMINISTRATOR USER PASSWORD | Psft1234
    WEB PROFILE USER PASSWORD | Psft1234
    DOMAIN CONNECT PASSWORD | Psft1234

    ![](./images/varscm2.png "")

10. In the Networking section, enter a host name for the Cloud Manager instance.
This name will be used as part of the URL you use to access Cloud Manager in a browser. We'll use **psftcm**.

11. Select the option **Create Network Resources**

12. For **Network Name**, enter **OCIHOLVCN**

13. Select the option **Create Private Subnets**

14. Select the option **Create Subnets for Peoplesoft Components**

15. Select the option for **Create a Jump Host**

16. Using the drop-down, select **US-ASHBURN-AD-1** for the **Availability Domain for Jump Host** 

    ![](./images/varscm3.png "")

17. Click **Next**. Review the configuration variables, and then click **Create**.  

18.	This will add a new stack. Click on **stack details**. You can navigate to **Variables** to see all the assigned variables.

    ![](./images/variablestack.png "")

19. Click on **Terraform Actions** > **Plan**.

    ![](./images/plan.png "")

20. Give plan name as **plan-job-1** and click on **Plan**

    ![](./images/plandetail.png "")

21. Refresh the page after a few minutes, and it will say the plan is succeeded. Navigate back to **Stack Details** page, click on **Terraform Actions** > **Apply**.

    ![](./images/plans.png "")

    ![](./images/apply.png "")

22. Give name as **apply-job-1** and click on **Apply**.

    ![](./images/applydetail.png "")

    Wait a few minutes for the job to finish. You may have to refresh this page.

    On the Apply Job details page, click on **Logs** under **Resources** on the left side. 

    Scroll to the very bottom to find the **Outputs**. Copy and paste the following lines to your notepad. (Wait for a while if you can't see this information). 

    ![](./images/output2.png "")

    NOTE: If you don't have admin access in your laptop, before proceeding with Step 6, please follow the 
    **Windows VM Compute Lab:** 

    ![](./images/wlab.png "")

Depending on your workstation, choose Step 6 (for Mac) or 7 (for Windows)

## **STEP 6**: FOR MAC USERS- Accessing Cloud Manager using SSH 

SSH key pair  (``` id_rsa ``` & ```id_rsa.pub ```) is required to access Cloud Manager instance which was created in Step 1 of Lab 2. 

**NOTE**: Make sure you are off VPN.

1.	Retrieve the **Cloud Manager Output Variables** you just copied to your Notepad. We will need them.
    
2.  Launch terminal or Git Bash and navigate to the keys folder. 
For example: ```cd ~/Downloads/keys ```

3.	Once you're in the directory, create an SSH tunnel using this command: (Be sure to replace the **CM private IP** and the **Jump Host public IP** from the variables in your Notepad.)
   
    ```
    <copy>
    ssh -f -C -q -N -i id_rsa -L 2222:<CM_private_ip>:22 opc@<jumphost_public_IP>
    </copy>
    ``` 
    *Example:* ``` ssh -f -C -q -N -i id_rsa -L 2222:10.X.X.X:22 opc@XXX.XXX.XXX.XXX```

4. Now, let's connect through SSH. Run this command in the keys directory as well.

    ```
    <copy>
    ssh –p 2222 opc@localhost -i id_rsa
    </copy>
    ```
## **STEP 7**: FOR WINDOWS USERS- Accessing Cloud Manager using SSH 
Reminder of Prerequisites: PuTTY, Git Bash, and Firefox. Please download those if you haven't already.

1. Open up PuTTYgen. Click **Conversions** --> **Import key**. 
    ![](./images/puttykey.png "")

    Now, select the ```id_rsa``` key from Step 1 of Lab 2, and click **Open**

    ![](./images/puttyloadkey.png "")

    Click **Save private key**.

    ![](./images/puttysaveprivatekey.png "")

    Now, rename the file to ```id_rsa_ppk``` and click **Save**.

    ![](./images/puttyrename.png "")

2. Open up PuTTY and create a **Session** by filling in the following fields:
    * Host Name: **`<`jumphost`_`public`_`ip`>`** (get this value from the Outputs you copied in your Notepad)
    * Port: **22**
    * Saved Sessions: **CMtunnel**

    Click **Save**

    ![](./images/puttysession.png "")
3. Under SSH --> **Tunnels**, fill in:
    * Source Port: **2222**
    * Destination: **`<`cm`_`private`_`ip`>`:22** 

    Click **Add** and you should see an entry added in the forwarded ports box like the one here in blue:
    ![](./images/puttytunnel.png "")

4. Under SSH --> **Auth**, Click **Browse**. 
    ![](./images/puttybrowse.png "")
    Select the ```id_rsa_ppk``` file we just created above. Click **Open**
    ![](./images/puttyppk.png "")
5. Go back to **Session**. Click **Save** and then **Open**.
     ![](./images/puttysession2.png "")
    A dialog box will pop up with a Security Alert. Go ahead and click **Yes** to add this key.
    ![](./images/puttyyes.png "")
    In the window, login as: **opc**.
    If you see this, you've successfully connected to the jumphost.
    ![](./images/puttyjhconnect.png "")

6. Now open up GitBash. Navigate to the folder in which your keys are located. Type in this command:

    ```
    <copy>
    ssh -p 2222 opc@localhost -i id_rsa
    </copy>
    ```
    
    If you see something like this, you are now connected to Cloud Manager.

    ![](./images/puttycmconnect.png "")




## **STEP 8**: Monitoring Cloud Manager

1. SSH into Cloud Manager instance to check status of the deployment.  Monitor Cloud Manager bootstrap installation using the below command.

    ```
    <copy>
    tail -f /home/opc/bootstrap/CloudManagerStatus.log
    </copy>
    ```

    ![](./images/tail.png "")

2. While Cloud Manager is being installed, review **Associated Resources** for the list of all resources created by automation.

    The deployment automation (Resource Manager Stack) provisions numerous resources in the tenancy.  To find the list of resources that were created, navigate to OCI console, then go to **Resource Manager** > **Jobs** and click on the job you wish to view. Then on this page, click **Associated Resources** under **Resources** (on the left side of the webpage).  

    ![](./images/19.png "")

3. After Cloud Manager bootstrap is complete, the CloudManagerStatus.log will show the following messages. 

		The PeopleSoft Environment Setup Process Ended.
		CM installed successfully
		Cloud Manager PIA URL: http://psftcm.cm.ociholvcn.oraclevcn.com:8000 
		Cloud Manager PIA SSL URL: https://psftcm.cm.ociholvcn.oraclevcn.com:8443

    *NOTE: Usually, it takes an hour for Cloud Manager to finish the bootstrap script. Till the script is successfully executed and you get the above message, you won't be able to access cloud manager URL. This is a long process. 


## **STEP 9**: Set up SOCKS Proxy to Access Cloud Manager in Browser

**NOTE**: Make sure you are off VPN. 

1. Launch Firefox and go to **Preferences** by clicking the gear in the top right. (If you don't see the gear, open up a new tab)

    ![](./images/firefoxpref.png "")

2. Scroll down to the bottom to navigate to **Network Settings**

    ![](./images/foxpref.png "")

3. Make the following changes to configure Proxy access to the internet.

    * Toggle Manual Proxy Configuration
    * SOCKS host: localhost and Port: 8123
    * Toggle SOCKS v5
    * Select both Proxy DNS when using SOCKS v5 and Enable DNS over HTTPS

    Click OK


    ![](./images/firefox.png "")

4.  Launch terminal or Git Bash and navigate to the keys folder. Run the following command to create the SOCKS proxy making sure to replace the **Jump Host Public IP**.

    ```
    <copy>    
    ssh -D 8123 -f -C -q -N -i id_rsa opc@<jump_host_public_IP>
    </copy>
    ```
    *Example:* ``` ssh -D 8123 -f -C -q -N -i id_rsa opc@XXX.XXX.XXX.XXX ```

5. Enter your **Cloud Manager PIA URL** (``CM_http_url``) in Firefox

6. To login, use the username **CLADM** and password as **Psft1234**.
    ```
    <copy>CLADM</copy>
    ```
    ```
    <copy>Psft1234</copy>

    ```
     ![](./images/login.png "")
    

You may now proceed to the next lab.

## Acknowledgements

**Created By/Date**   
* **Authors** - Rich Konopka, Peoplesoft Specialist, Megha Gajbhiye, Cloud Solutions Engineer
* **Contributor** -  Sara Lipowsky, Cloud Engineer
* **Last Updated By/Date** - Sara Lipowsky, Cloud Engineer, February 2021
* **Lab Expiry Date** - June 30, 2021 

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.



