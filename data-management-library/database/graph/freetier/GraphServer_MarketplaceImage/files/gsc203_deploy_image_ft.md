# Deploy Graph Server and Client from Oracle Cloud Marketplace

## Introduction

This lab walks you through the steps to deploy and configure the Graph Server and Client kit on a compute instance via an Oracle Cloud Marketplace stack. You will need to provide the SSH key, VCN and Subnet information, and the JDBC URL for the ADB instance during the deployment process.

### What Do You Need?
* Register cloud account
* Create SSH Keys
* Create an ADB instance and download the wallet
* A VCN and Subnet

*Note 1: Some of the UIs may look a little different from the screenshots in the instructions.*

## **Step 1:** Locate the Graph Server and Client in the Oracle Cloud Marketplace

Oracle Cloud Marketplace is an online platform which offers Oracle and partner software as click-to-deploy solutions that
are built to extend Oracle Cloud products and services.  

Oracle Cloud Marketplace stacks are a set of Terraform templates that provide a fully automated end-to-end deployment of a partner solution on Oracle Cloud Infrastructure.   

1. Go to your Cloud Console. Navigate to the **Marketplace** tab and enter "Graph Server and Client" in the serach bar. Click on the Oracle Graph Server and Client stack.

    ![](../images/OCIMarketplaceFindGraphServer.png " ")


2. Select the stack and then review the System Requirements and Usage Instructions. Then select the latest version and choose a compartment and click on `Launch Stack`. 
   

    ![](../images/GSC203LaunchStack.png " ")


3. Most of the defaults are perfect for our purposes. However, you will need to choose, or provide the following:
  - Select a VM shape. Choose an Always Free eligible shape (i.e. a Micro VM).
  - Paste your public SSH key. This is used when you ssh into the provisioned compute later.
  - Choose an existing virtual cloud network.
  - Select a subnet compartment and subnet.
  - Enter the JDBC URL for the ADB instance. The TNS_ADMIN entry points to the directory where you will have uploaded and unzipped the wallet. 
  ***Note: This JDBC URL is stored in a configuration whoch can be updated later if necessary.***

    ![](../images/ConfigureStackVariables_Sombrero203.png " ")


4. Click `Next` to initiate the Resource Manager Job for the stack. The job will take 2-3 minutes to complete. 

    ![](../images/ResourceMgrStackJobStart.png " ")

    You'll see the progress in the log output.  

    ![](../images/RMJobStarted_Sombrero203.png " ")  

    Once the job has successfully completed the status will change from "In Progess" to "Succeeded".

    ![](../images/RMJobCompleted_Sombrero203.png " ")  

    ***NOTE:*** *On completion please make a note of public IP address, so that you can SSH into the running instance later in this lab, and the graph viz and PGX URLs.*

5. The next set of steps are post-install setup and configuration on the newly created compute where the Graph Server was deployed.

6. Add an Ingress Rule for port 7007 (needed later for the Graph Server).  
   Using the menu, under **Networking**, click on **Virtual Cloud Networks**.

    ![Click on the VCN](https://oracle.github.io/learning-library/oci-library/L100-LAB/Compute_Services/media/vcn1.png)

    Then click on the VCN you created for this lab
    ![](../../GraphServer_ManualSetup/images/vcn_instance.png " ")

    Now click on **Security Lists** on the left navigation bar for the VCN.

    ![Click on Security Lists](https://oracle.github.io/learning-library/oci-library/L100-LAB/Compute_Services/media/vcn2.png)

   Click on the **Default Security List** link.

   Here you need to open port 7007. Click on **Add Ingress Rules** and add the following values as shown below:

    - **Source Type:** CIDR
    - **Source CIDR**: &lt;IP address of your PC&gt;/32
    - **IP Protocol:** TCP
    - **Source Port Range:** All
    - **Destination Port Range:** 7007
    - Click on **Add Ingress Rules** at the bottom.
    ![Add Ingress Rule](../../GraphServer_ManualSetup/images/ingress_rule_7007.png " ")

    *Note 1: If you reconnect at a later date or connect to your company's VPN, your local machine's IP address may change.*

    *Note 2: Make sure to enter your PC's IP address, not your LAN/Wifi's IP address.*


7. To connect to the instance, go the environment where you generated your SSH Key. You can use `Oracle Cloud Shell`, `Terminal` if you are using MAC, or `Gitbash` if you are using Windows. On your terminal or gitbash enter the following command:

    *Note: For Oracle Linux VMs, the default username is **opc***

    If your SSH Keys are kept under `HOME/.ssh/` directory, run:
    ```
    <copy>ssh opc@</copy>&lt;public_ip_address>
    ```

    If you have a different path for your SSH key, enter the following:

    ```
    <copy>ssh -i &lt;path_to_private_ssh_key> opc@&lt;public_ip_address></copy>
    ```

    ![](../../GraphServer_ManualSetup/images/ssh_first_time.png " ")

    *Note: You should remove angle brackets <> from your code.*

## **Step 2:** Upload ADB Wallet, Configure your Compute Instance.

The steps are as follows:
 
  - Copy the ADB wallet zip file into the compute.
  - Create the `wallets` directory. Unzip the ADB wallet into that directory.
  - Change the permissions on the wallets directory so that the user `oraclegraph` and members of the group `oraclegraph` have access to that directory.

1. SSH into the compute instance using the private key you created earlier. First navigate to the folder where you created your SSH Keys. And connect using:

    ```
    <copy>ssh -i &lt;private_key> opc@&lt;public_ip_for_compute></copy>
    ```
    *Note: You should not include the angle brackets <> in you code.*

2.  Download your ADB Wallet if you haven't done so. Go to your Cloud console, under **Database**, select **Autonomous Transaction Processing**. If you don't see your instance, make sure the **Workload Type** is **Transaction Processing** or **All**.

    ![](../../GraphServer_ManualSetup/images/console_atp.png " ")

    Click on your Autonomous Database instance. In your Autonomous Database Details page, click **DB Connection**.

    ![](../../GraphServer_ManualSetup/images/DB_connection.png " ")

    In Database Connection window, select **Instance Wallet** as your Wallet Type, click **Download Wallet**.
    ![](../../GraphServer_ManualSetup/images/wallet_type.png " ")

    In the Download Wallet dialog, enter a wallet password in the Password field and confirm the password in the Confirm Password field.
    The password must be at least 8 characters long and must include at least 1 letter and either 1 numeric character or 1 special character. This password protects the downloaded Client Credentials wallet.

    Click **Download** to save the client security credentials zip file.
    ![](../../GraphServer_ManualSetup/images/password.png " ")

    By default the filename is: Wallet_databasename.zip. You can save this file as any filename you want.
    You must protect this file to prevent unauthorized database access.
    ![](../../GraphServer_ManualSetup/images/wallet_name.png " ")

    Content in this section is adapted from [Download Client Credentials (Wallets)](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/connect-download-wallet.html#GUID-B06202D2-0597-41AA-9481-3B174F75D4B1)


## **Step 3:**  Copy ADB Wallet to the Linux Compute


1. On your desktop or laptop (i.e. your machine), do not close your old Terminal window. We'll assume the ADB wallet was downloaded to ~/Downloads. 

    ![](../../GraphServer_ManualSetup/images/download_folder.png " ")
     
     Open a new Terminal, navigate to the folder where you created your SSH Keys, and enter the following command:

    ```
    ## copy the Wallet. Once again modify with correct values for your setup.
    <copy>scp -i private_key ~/Downloads/ADB_Wallet_Zip opc@public_ip_for_compute:/home/opc</copy>
    ```
    ![](../../GraphServer_ManualSetup/images/copy_wallet.png " ")

## **Step 4:** Unzip ADB Wallet

1.  Now go back to the Terminal window which is connected (via SSH) to the compute instance as `opc`. 
    Unzip the ADB wallet to the `wallets` directory. Modify the commands as appropriate for your environment and execute them as `opc`.

    ```
    <copy>
    sudo mkdir /home/oraclegraph
    sudo mkdir /home/oraclegraph/wallets
    sudo chown opc /home/oraclegraph
    sudo chown opc /home/oraclegraph/wallets
    sudo chgrp oraclegraph /home/oraclegraph
    sudo chgrp oraclegraph /home/oraclegraph/wallets
    </copy>
    ```

    ```
    <copy>
    cd /home/oraclegraph/wallets
    unzip /home/opc/&lt;ADB_Wallet>.zip</copy>
    ```

    ```
    <copy>
    sudo chgrp oraclegraph *
    </copy>
    ```
    

    The above is just one way of achieving the desired result, i.e. giving the `oraclegraph` user access to the ADB wallet. There are alternative methods. 

2. Check that you used the right service name in the JDBC URL you entered when configuring the OCI stack. 
   It can be updated if necessary.  

    ```
    ## open the tnsnames and get the service name you will use later.
    <copy>cat /home/oracle/wallets/tnsnames.ora</copy>
    ```

    ```
    ## you will see something similar to
    atpfinance_low =
        (description=
            (address=
                (https_proxy=proxyhostname)(https_proxy_port=80)(protocol=tcps)(port=1522)
                (host=adwc.example.oraclecloud.com)
            )
            (connect_data=(service_name=adwc1_low.adwc.oraclecloud.com))
            (security=(ssl_server_cert_dn="adwc.example.oraclecloud.com,OU=Oracle BMCS US,O=Oracle Corporation,L=Redwood City,ST=California,C=US"))
    )
    ```

    An entry in tnsnames.ora is of the form  
    `<addressname> =`  
    &nbsp;&nbsp;`(DESCRIPTION =`  
    &nbsp;&nbsp;&nbsp;&nbsp;`(ADDRESS_LIST = `  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`(ADDRESS = (PROTOCOL = TCP)(Host = <hostname>)(Port = <port>)) `  
    &nbsp;&nbsp;&nbsp;&nbsp;`) `  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`(CONNECT_DATA =  `  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`(SERVICE_NAME = <service_name>)  `  
    &nbsp;&nbsp;&nbsp;&nbsp;`) `  
    &nbsp;&nbsp;`)`  

    Note the `addressname`, e.g. `atpfinance_low` that you will use later when connecting to the databases using JDBC.

    You may now *proceed to the next lab*.

## Acknowledgements ##

* **Author** - Jayant Sharma, Product Manager, Spatial and Graph.  
* **Contributors** - Albert Godfrind and Ryota Yamanaka.  
  Thanks to Jenny Tsai for helpful, constructive feedback that improved this workshop.
* **Last Updated By/Date** - Arabella Yao, Product Manager Intern, Database Management, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
