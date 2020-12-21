# Lab 300: Provision the WebLogic infrastructure

See Requirements to get the code and the required Docker images.

## Introduction: This 30 mins lab walks you through provisioning the WebLogic Infrastructure by leveraging the OCI Marketplace image. 

## **Step 1:** Provision the stack through the Marketplace

- Go to **Solutions and Platforms** 

  ![](./images/provision-1.png)

- In the search input, type "`weblogic`". For this lab, we'll use the **WebLogic Enterprise Edition UCM**

   ![](./images/provision-2.png)

- Make sure you are in the **Compartment** you want to use, use the **default WebLogic version** available, accept the License agreement and click **Launch the Stack**

   ![](./images/provision-3.png)

- **Name** the stack and click **Next**

   ![](./images/provision-4.png)

   ![](./images/provision-5.png)

- **Enter** a **Resource Name Prefix**.

  It will be used to prefix the name of all the resources (domain, managed servers, admin server, cluster, machines...)

  The next steps in this workshop assumes the resource name prefix is `nonjrf`, so it is highly recommended to use this name.

  ![](./images/provision-6-prefix.png)

- **Select** a **Shape**.

   In a real world situation, choose a shape appropriate to handle the load of a single managed server. Since we're using a trial account, choose the **VM.Standard.1** shape or a shape that is available in your tenancy.

  ![](./images/provision-7-shape.png)

   To check shape availability, you can go to **Governance -> Limits and Quotas** in another tab, and verify you have a specific shape available

- **SSH key**

   To connect to the WebLogic servers via SSH, you need to provide a public key the server will use to identify your computer. Since the various commands will be ran from inside the docker containers, you will need to provide the key generated in the container.

  ![](./images/provision-8-sshkey.png)

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

  ![](./images/provision-9-ad.png)

- **Select** a **Node count**. In this lab, we'll provision 2 nodes.

  ![](./images/provision-10-nodes.png)

- We'll keep the WebLogic Administrator Name as the default of `weblogic`

  ![](./images/provision-11-admin-name.png)

- **Paste** the **OCID** of the **Secret** generated in step 2.3) for the **Secret OCID for WebLogic Admin Password**

  ![](./images/provision-12-secret.png)

- **Check** the checkbox for **WebLogic Server Advanced Server Configuration**
   Here you can see all the default ports, which we will keep as-is.

  ![](./images/provision-13-advanced.png)

- in this same **Advanced** section, **uncheck** the checkbox to **Provision the Sample Application**: since we will migrate our domain, we want a clean domain to start from.

  ![](./images/provision-14-no-app.png)

- In the **WebLogic Network** section, make sure you are in the proper compartment

  ![](./images/provision-15-net.png)

- Select **Create New VCN**

  ![](./images/provision-16-create-vcn.png)

- **Name** the VCN `wls`

  ![](./images/provision-17-vcn-name.png)

- **Keep the default** VCN CIDR block as-is.
   
  ![](./images/provision-18-vcn-cidr.png)

   Note: If you were to migrate from an on-premises domain connected via VPN or FastConnect, you would want to make sure the CIDR block does not conflict with the local network.

- **Keep the defaults for subnets** as-is: 

   The stack will create the subnets for us.

  ![](./images/provision-19-subnets.png)

- **Check** the **Provision Load Balancer** checkbox and keep the defaults

  ![](./images/provision-20-lb.png)

- Keep IDCS **unchecked**

  ![](./images/provision-21-idcs.png)

- Make sure **No Database** is selected

  ![](./images/provision-22-nodb.png)

- Optionally add Tags

  ![](./images/provision-23-tags.png)

- Click **Next**

  ![](./images/provision-24.png)

- and then click **Create**

  ![](./images/provision-25.png)

- The stack will get provisioned using the **Resource Manager**. This may take 7-15min.

  ![](./images/provision-26.png)


Once the stack is provisioned, you can find the information regarding the URL and IP of the WebLogic Admin server in the logs, or in the **Outputs** left-side menu. 

## **Step 2:** Gather the necessary WebLogic stack information

  ![](./images/provision-27.png)

- Make a note of the **WebLogic Admin Server public IP address** from the **WebLogic Admin Server Console URL** for later use.

- Make a note of the **Load Balancer IP** for later use.

You can copy/paste the **WebLogic Admin Console URL** in your browser and explore the provisioned WebLogic domain. You should find that there are no applications in **deployments** and no data sources in the **service->datasources** menu
