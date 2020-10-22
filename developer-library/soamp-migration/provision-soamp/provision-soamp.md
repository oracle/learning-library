# Provision SOA Suite Marketplace on Oracle Cloud Infrastructure

## Introduction

This lab walks you through provisioning the SOA Suite Infrastructure by leveraging the OCI Marketplace image. 

Estimated Lab Time: 40 min

### Objectives

In this lab you will:

- Provision SOA Server on Oracle Cloud Infrastructure via the Marketplace offering
- Gather information for further steps
- Connect to the Fusion Middleware console of the SOA Suite installation through the bastion host.

### Prerequisites

We'll use the 'on-premises' environment as our working environment from which we'll connect to the newly deployed environment, so we'll need to create a SSH key pair there.

## **STEP 1:** Create a SSH key pair 

Create a SSH key in the on-premises environment (whether you chose to provision via the demo marketplace or with a local VirtualBox VM)

1. Open a terminal in the 'on-premises' environment.

  <img src="../../provision-soamp/images/desktop-terminal-launch.png" width="100%">

2. In the terminal, create a SSH key

   ```
   <copy>
   ssh-keygen
   </copy>
   ```

   - Hit **Enter** to use all defaults to all questions

3. Get the content of the public key

   Getting the content of the key depends on the environment:

   - if you used the demo marketplace 'on-premises' environment, SSH from your local machine to the VM with 

   ```
   <copy>
   ssh -p 7022 oracle@<PUBLIC_IP>
   </copy>
   ```

   Where the `PUBLIC_IP` is the public IP of the on-premises enviroment you gathered when provisioning the VM in Lab 1a, 
   
   The password you will be prompted for is `oracle`

   Then use:

   ```
   <copy>
   cat ~/.ssh/id_rsa.pub
   </copy>
   ```

   - If you used the Virtual Box VM, you should be able to output the key directly with

   ```
   <copy>
   cat ~/.ssh/id_rsa.pub
   </copy>
   ```

   and copy the content to clipboard.

4. Take a note of this key content to provide during provisioning of SOA


## **STEP 2:** Provision the stack through the Marketplace

1. Go to **Solutions and Platforms -> Marketplace -> Applications**

  <img src="../../provision-soamp/images/marketplace-menu.png" width="50%">

2. In the search input, type "`soa`". For this lab, we'll use the **Oracle SOA Suite (BYOL)**

   <img src="../../provision-soamp/images/soa-mp-list.png" width="100%">

3. Make sure you are in the **Compartment** you want to use, use the **default WebLogic version** available, accept the License agreement and click **Launch the Stack**

   <img src="../../provision-soamp/images/provision-3.png" width="100%">

4. **Name** the stack and click **Next**

   <img src="../../provision-soamp/images/provision-4.png" width="100%">

5. **Enter** a **Resource Name Prefix**, we'll use `SOAMP2`.

  It will be used to prefix the name of all the resources (domain, managed servers, admin server, cluster, machines...)

  The next steps in this workshop assumes the resource name prefix is `SOAMP2`, so it is highly recommended to use this name.

   <img src="../../provision-soamp/images/prefix.png" width="70%">

6. **Select** a **Service Type**.

   In a real world situation, choose a service type according to your requirement. for this workshop we are using **SOA with SB & B2B Cluster**.

   <img src="../../provision-soamp/images/service-type.png" width="70%">


7. Keep the **Enable SOA Schema partinioning** unchecked

   <img src="../../provision-soamp/images/partitioning.png" width="70%">

8. **Select** a **Shape**.

   In a real world situation, choose a shape appropriate to handle the load of a single managed server. Since we're using a trial account, choose the **VM.Standard.E2.1** shape, the **VM.Standard.2.1** shape or a suitable shape that is available in your tenancy.

   <img src="../../provision-soamp/images/shape.png" width="70%">

   To check shape availability, you can go to **Governance -> Limits and Quotas** in another tab, and verify you have a specific shape available

9. **SSH key**

   *Important:* Provide the SSH public key you created earlier inside the on-premises environment, not your local public key.

   <img src="../../provision-soamp/images/ssh-key.png" width="70%">

9. **Select** an **Availability Domain**

   <img src="../../provision-soamp/images/ad.png" width="70%">

10. **Select** a **Node count**. In this lab, we'll provision `1` node.

   <img src="../../provision-soamp/images/node-count.png" width="70%">

11. We'll keep the **WebLogic Server Admin User Name** as the default of `weblogic`

   <img src="../../provision-soamp/images/admin-user.png" width="70%">

12. Provide password of your choice or you can use the below which we have used for this lab `welcome1`

   <img src="../../provision-soamp/images/admin-password.png" width="70%">

13. In the **WebLogic Network** section, make sure you are in the proper compartment for this lab we have used `SOAMP1Compartment`
 
14. For **VIRTUAL CLOUD NETWORK STRATERGY** Select `Use Existing VCN`

15. Select **EXISTING NETWORK** as `SOAMP1VCN`

  <img src="../../provision-soamp/images/network1.png" width="70%">

16. Select **SUBNET STRATEGY** as `Use Existing Subnet`
   
17. Select **SUBNET COMPARTMENT** as `SOAMP1Compartment` 

18. Select **SUBNET TYPE** as `Use Private Subnet` 

19. Select **SUBNET SPAN** as `Regional Subnet`

20. Select **EXISTING SUBNET** as `Private Subnet-SOAMP1VCN(Regional)`

  <img src="../../provision-soamp/images/network2.png" width="70%">

21. Select **Bastion Instance Strategy** as `Create new Bastion Instance`

  <img src="../../provision-soamp/images/bastion2.png" width="70%">

21. Select **EXISTING SUBNET FOR BASTION HOST** as `Public Subnet-SOAMP1VCN(Regional)`

   **Note:** Since we are choosing private subnet for SOA instance we need a bastion host in public subnet (using public IP which is the gateway to SOA instance for the external world) to connect internally to the private IP of SOA Instance , bastion host wouldn't be required if we use public subnet for SOA instance as it will have a public IP to be commnubicated from eternal world.

  <img src="../../provision-soamp/images/bastion3.png" width="70%">

22. Select **BASTION HOST SHAPE** as `VM Standard2.1`
or can Select `VM StandardE2.1` if working on trial instance

  <img src="../../provision-soamp/images/bastion4.png" width="70%">

23. **Check** the **Provision Load Balancer** checkbox

      - Select **EXISTING SUBNET FOR LOAD BALANCER** as `Public Subnet-SOAMP1VCN(Regional)` 
      - Select **LOAD BALANCER SHAPE** as `400Mbps`

  <img src="../../provision-soamp/images/load-balancer.png" width="70%">

24. Select **DATABASE STRATEGY** as `Database Systems`

  <img src="../../provision-soamp/images/db-strategy.png" width="70%">

25. Select **DB SYSTEM COMPARTMENT** as `SOAMP1VCNCompartment`

   **Note:** Since we already have created DB for SOA, we should choose the compartment where we have provision the DB and check if we are able to see the DB instance  

26. Select the below details:

      - **DB SYSTEM** as the name of your DB System created earlier,
      - **DB HOME IN THE DB SYSTEM** from drop down,
      - **DB IN THE DB SYSTEM** as `SOAMP2DB` and
      - **PDB** as `PDB1`

  <img src="../../provision-soamp/images/db1.png" width="70%">

27. Select **DATABASE ADMINISTRATOR** as `SYS`

28. Select **DATABASE ADMINISTRATOR PASSWORD** as `WELcome##123`

   <img src="../../provision-soamp/images/db-password.png" width="70%">

29. **Check** the checkbox for **SERVICE INSTANCE ADVANCED CONFIGURATION**
   Here you can see all the default ports, which we will keep as-is.

   <img src="../../provision-soamp/images/provision-13-advanced.png" width="70%">

30. In this same **Advanced** section, **check** the checkbox to **DEPLOY SAMPLE APPLICATION**: since we can reuse the service to migrate from onprem to soamp.

   <img src="../../provision-soamp/images/provision-14-advanced.png" width="70%">


31. Once you got all the port details click **Next** and then verify all the details and click **Create**

  <img src="../../provision-soamp/images/provision-17.png" width="100%">

34. The stack will get provisioned using the **Resource Manager**. This may take 7-15min.

  <img src="../../provision-soamp/images/provision-19.png" width="100%">

Once the stack is provisioned, you can find the information regarding the URL and IP of the WebLogic Admin server in the logs, or in the **Outputs** left-side menu. 

To save some time you may proceed to the next lab and move to first steps of migrating the demo application, however you will need to come back and gather the info and create the tunnel connection to proceed further.


## **STEP 3:** Gather the necessary SOA stack information


1. In the job **Outputs** (left menu)

  <img src="../../provision-soamp/images/outputs.png" width="100%">

   Make a note of :

      - **FMW Console**
      - **Load Balancer IP**
   
   for later use.

      - FMW URL gives you the private IP of the SOA node to reach

2. Go to **Core Infrastructure -> Compute -> Instances**

3. Make sure you are in the right compartment and look for the **SOAMP2-bastion-instance** 

   Note the Public IP address of the bastion

   <img src="../../provision-soamp/images/bastion-ip.png" width="100%">


## **STEP 4:** Connect to the SOA Console through the Bastion Host.

Since the stack is deployed in a **private subnet**, accessing the console is achieve by tunneling through the bastion host.

1. In the terminal where you created the SSH key, create a tunnel to the SOA host via the bastion host

      Note: do not confuse the Bastion Host public IP with the load balancer IP.

      ```
      <copy>
      export BASTION_IP=<PUBLIC IP of BASTION HOST>
      export REMOTEHOST=<PRIVATE IP OF SOA HOST>
      export PORT=7002
      # tunnel
      ssh -M -S socket -fnNT -L ${PORT}:${REMOTEHOST}:${PORT} opc@${BASTION_IP} cat -
      </copy>
      ```

      **Through RDP you might have to type the command**

2. Once your SOA private instance is tunneled, open the web browser to `https://localhost:7002/em`

   Provide your WebLogic username/password provided during SOAMP provisioning.

   Note: the connection uses SSL, so make sure to use the `https://` scheme.

   <img src="../../provision-soamp/images/provision-29-connectinstance.png" width="100%">

11. go to **SOA -> soa-infra** you can see some pre deployed example applications, and check the server health.

   <img src="../../provision-soamp/images/provision-30-connectinstance.png" width="100%">


You may proceed to the next lab

## Acknowledgements

 - **Author** - Akshay Saxena, September 2020
 - **Last Updated By/Date** - Akshay Saxena, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
