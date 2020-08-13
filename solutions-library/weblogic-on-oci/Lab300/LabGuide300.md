# Lab 300: Provision the WebLogic infrastructure

See Requirements to get the code and the required Docker images.

## Introduction: This 30 mins lab walks you through provisioning the WebLogic Infrastructure by leveraging the OCI Marketplace image. 

## **Step 1:** Provision the stack through the Marketplace

- Go to **Solutions and Platforms** 

  <img src="./images/provision-1.png" width="50%">

- In the search input, type "`weblogic`". For this lab, we'll use the **WebLogic Enterprise Edition UCM**

   <img src="./images/provision-2.png" width="100%">

- Make sure you are in the **Compartment** you want to use, use the **default WebLogic version** available, accept the License agreement and click **Launch the Stack**

   <img src="./images/provision-3.png" width="100%">

- **Name** the stack and click **Next**

   <img src="./images/provision-4.png" width="100%">

   <img src="./images/provision-5.png" width="100%">

- **Enter** a **Resource Name Prefix**.

  It will be used to prefix the name of all the resources (domain, managed servers, admin server, cluster, machines...)

  The next steps in this workshop assumes the resource name prefix is `nonjrf`, so it is highly recommended to use this name.

  <img src="./images/provision-6-prefix.png" width="70%">

- **Select** a **Shape**.

   In a real world situation, choose a shape appropriate to handle the load of a single managed server. Since we're using a trial account, choose the **VM.Standard.1** shape or a shape that is available in your tenancy.

  <img src="./images/provision-7-shape.png" width="70%">

   To check shape availability, you can go to **Governance -> Limits and Quotas** in another tab, and verify you have a specific shape available

- **SSH key**

   To connect to the WebLogic servers via SSH, you need to provide a public key the server will use to identify your computer. Since the various commands will be ran from inside the docker containers, you will need to provide the key generated in the container.

  <img src="./images/provision-8-sshkey.png" width="70%">

   To output the public key information, use the following command from inside the docker container
   ```
   <copy>
   cat ~/.ssh/id_rsa.pub
   </copy>
   ```
   Copy the output of the command (the whole multi-line output) and paste it in the form field for SSH key in the form

   the output will look something like this:

   ```bash
   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlkF23qLyfimJ9Vp4D9psp7bDOB8JvtY/pfYzFxIA2E4v6or+XhvMW5RDhX9Ba54zQNNDLvwUhStdXKkiMXJtEQJarFn45pGy/lyUQKFJolAdHBrXJsg5XWn4DxCFeQUQe1szVfmwDLAktAS14r5g76h3CcA8Kk/cNVqevxVChyejuuOdtAMoriIC8uKV+535qPs/GMiu0zR9aW4w1VodL5eHnXjqdgp8Fr21dVUVQ6of+s/ws0zlQUwghrNguDUqlggzG2mpLBHExypxCrJYmsb05uYjjqVlC3YCatj4nJTIHKLCFiYVY/b8AFkqwXV9EYlja5bjTmunM847dcR8H oracle@ad753161734c
   ```
   **Note:** Do not use the example above as the key: it is a different public key which is useless without the corresponding private key, and you will not be able to access your resources on OCI)

- **Select** an **Availability Domain**

  <img src="./images/provision-9-ad.png" width="70%">

- **Select** a **Node count**. In this lab, we'll provision 2 nodes.

  <img src="./images/provision-10-nodes.png" width="70%">

- We'll keep the WebLogic Administrator Name as the default of `weblogic`

  <img src="./images/provision-11-admin-name.png" width="70%">

- **Paste** the **OCID** of the **Secret** generated in step 2.3) for the **Secret OCID for WebLogic Admin Password**

  <img src="./images/provision-12-secret.png" width="70%">

- **Check** the checkbox for **WebLogic Server Advanced Server Configuration**
   Here you can see all the default ports, which we will keep as-is.

  <img src="./images/provision-13-advanced.png" width="70%">

- in this same **Advanced** section, **uncheck** the checkbox to **Provision the Sample Application**: since we will migrate our domain, we want a clean domain to start from.

  <img src="./images/provision-14-no-app.png" width="70%">

- In the **WebLogic Network** section, make sure you are in the proper compartment

  <img src="./images/provision-15-net.png" width="70%">

- Select **Create New VCN**

  <img src="./images/provision-16-create-vcn.png" width="70%">

- **Name** the VCN `wls`

  <img src="./images/provision-17-vcn-name.png" width="70%">

- **Keep the default** VCN CIDR block as-is.
   
  <img src="./images/provision-18-vcn-cidr.png" width="70%">

   Note: If you were to migrate from an on-premises domain connected via VPN or FastConnect, you would want to make sure the CIDR block does not conflict with the local network.

- **Keep the defaults for subnets** as-is: 

   The stack will create the subnets for us.

  <img src="./images/provision-19-subnets.png" width="70%">

- **Check** the **Provision Load Balancer** checkbox and keep the defaults

  <img src="./images/provision-20-lb.png" width="70%">

- Keep IDCS **unchecked**

  <img src="./images/provision-21-idcs.png" width="70%">

- Make sure **No Database** is selected

  <img src="./images/provision-22-nodb.png" width="70%">

- Optionally add Tags

  <img src="./images/provision-23-tags.png" width="70%">

- Click **Next**

  <img src="./images/provision-24.png" width="100%">

- and then click **Create**

  <img src="./images/provision-25.png" width="100%">

- The stack will get provisioned using the **Resource Manager**. This may take 7-15min.

  <img src="./images/provision-26.png" width="100%">


Once the stack is provisioned, you can find the information regarding the URL and IP of the WebLogic Admin server in the logs, or in the **Outputs** left-side menu. 

## **Step 2:** Gather the necessary WebLogic stack information

  <img src="./images/provision-27.png" width="100%">

- Make a note of the **WebLogic Admin Server public IP address** from the **WebLogic Admin Server Console URL** for later use.

- Make a note of the **Load Balancer IP** for later use.

You can copy/paste the **WebLogic Admin Console URL** in your browser and explore the provisioned WebLogic domain. You should find that there are no applications in **deployments** and no data sources in the **service->datasources** menu
