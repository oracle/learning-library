# Provision WebLogic on Oracle Cloud Infrastructure

## Introduction

This lab walks you through provisioning the WebLogic Infrastructure by leveraging the OCI Marketplace image. 

Estimated Lab Time: 20 min

### Objectives

In this lab you will:

- Provision WebLogic Server on Oracle Cloud Infrastructure via the Marketplace offering
- Gather information for further steps

### Prerequisites

For this lab, you need to have prepared the OCI tenancy with:

- A Vault
- A Key 
- A Secret for the WebLogic Admin passord


## **STEP 1:** Provision the stack through the Marketplace

1. Go to **Solutions and Platforms** 

  <img src="./images/provision-1.png" width="50%">

2. In the search input, type "`weblogic`". For this lab, we'll use the **WebLogic Enterprise Edition UCM**

   <img src="./images/provision-2.png" width="100%">

3. Make sure you are in the **Compartment** you want to use, use the **default WebLogic version** available, accept the License agreement and click **Launch the Stack**

   <img src="./images/provision-3.png" width="100%">

4. **Name** the stack and click **Next**

   <img src="./images/provision-4.png" width="100%">

5. **Enter** a **Resource Name Prefix**.

  It will be used to prefix the name of all the resources (domain, managed servers, admin server, cluster, machines...)

  The next steps in this workshop assumes the resource name prefix is `nonjrf`, so it is highly recommended to use this name.

  <img src="./images/provision-6-prefix.png" width="70%">

6. **Select** a **Shape**.

   In a real world situation, choose a shape appropriate to handle the load of a single managed server. Since we're using a trial account, choose the **VM.Standard.E2.1** shape, the **VM.Standard.E2.2** shape or a suitable shape that is available in your tenancy.

  <img src="./images/provision-7-shape.png" width="70%">

   To check shape availability, you can go to **Governance -> Limits and Quotas** in another tab, and verify you have a specific shape available

7. **SSH key**

   To connect to the WebLogic servers via SSH, you need to provide a public key the server will use to identify your computer. Since the various commands will be ran from inside the 'on-premises' environment (either the workshop compute instance or the local docker containers), you will need to provide the key generated in the 'on-premises' environment.

  <img src="./images/provision-8-sshkey.png" width="70%">

   To output the public key information, use the following command from inside the 'on-premises' environment as the `oracle` user.
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

8. **Select** an **Availability Domain**

  <img src="./images/provision-9-ad.png" width="70%">

9. **Select** a **Node count**. In this lab, we'll provision 2 nodes.

  <img src="./images/provision-10-nodes.png" width="70%">

10. We'll keep the **WebLogic Server Admin User Name** as the default of `weblogic`

  <img src="./images/provision-11-admin-name.png" width="70%">

11. **Paste** the **OCID** of the **Secret** generated previously for the **Secret OCID for WebLogic Admin Password**

  <img src="./images/provision-12-secret.png" width="70%">

12. **Check** the checkbox for **WebLogic Server Advanced Server Configuration**
   Here you can see all the default ports, which we will keep as-is.

  <img src="./images/provision-13-advanced.png" width="70%">

13. in this same **Advanced** section, **uncheck** the checkbox to **Provision the Sample Application**: since we will migrate our domain, we want a clean domain to start from.

  <img src="./images/provision-14-no-app.png" width="70%">

14. In the **WebLogic Network** section, make sure you are in the proper compartment

  <img src="./images/provision-15-net.png" width="70%">

15. Select **Create New VCN**

  <img src="./images/provision-16-create-vcn.png" width="70%">

16. **Name** the VCN `wls`

  <img src="./images/provision-17-vcn-name.png" width="70%">

17. **Keep the default** VCN CIDR block as-is.
   
  <img src="./images/provision-18-vcn-cidr.png" width="70%">

   Note: If you were to migrate from an on-premises domain connected via VPN or FastConnect, you would want to make sure the CIDR block does not conflict with the local network.

18. **Keep the defaults for subnets** as-is: 

   The stack will create the subnets for us.

  <img src="./images/provision-19-subnets.png" width="70%">

19. **Check** the **Provision Load Balancer** checkbox and keep the defaults

  <img src="./images/provision-20-lb2.png" width="70%">

20. Keep IDCS **unchecked**

  <img src="./images/provision-21-idcs.png" width="70%">

21. Keep Policies **checked**

  <img src="./images/provision-22-policies.png" width="70%">

22. Make sure **Provision with JRF** is **not** selected

  <img src="./images/provision-22-nojrf.png" width="70%">

23. Optionally add Tags

  <img src="./images/provision-23-tags.png" width="70%">

24. Click **Next**

  <img src="./images/provision-24.png" width="100%">

25. and then click **Create**

  <img src="./images/provision-25.png" width="100%">

26. The stack will get provisioned using the **Resource Manager**. This may take 7-15min.

  <img src="./images/provision-26.png" width="100%">


Once the stack is provisioned, you can find the information regarding the URL and IP of the WebLogic Admin server in the logs, or in the **Outputs** left-side menu. 

## **STEP 2:** Gather the necessary WebLogic stack information

  <img src="./images/provision-27.png" width="100%">

1. Make a note of the **WebLogic Admin Server public IP address** from the **WebLogic Admin Server Console URL** for later use.

2. Make a note of the **Load Balancer IP** for later use.

You can copy/paste the **WebLogic Admin Console URL** in your browser and explore the provisioned WebLogic domain. You should find that there are no applications in **deployments** and no data sources in the **service->datasources** menu

While the WebLogic instances are provisioning, it's possible to move forward with the Application Database provisioning as soon as the VCN is provisioned.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
