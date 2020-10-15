# Network setup

## Introduction: 

This lab with guide you through how to setup Compartments and Virtual Cloud Network (VCN) with the required policies for cloud environment (tenancy)

Estimated Lab Time: 20 min

### Requirements

If you are not an administrator in your tenancy, you will need the administrator to create the compartment and set the following policies in place:

```
<copy>
allow group soa-migration to manage instance-family in compartment SOAMP1Compartment
allow group soa-migration to manage virtual-network-family in compartment SOAMP1Compartment
allow group soa-migration to manage volume-family in compartment SOAMP1Compartment
allow group soa-migration to use database-family in compartment SOAMP1Compartment
allow group soa-migration to use autonomous-database-family in compartment SOAMP1Compartment
</copy>
```

### Objectives

In this lab you will:

- Create a Compartment
- Create a VCN with private and public subnets


## **STEP 1:** Create the Compartment

Before we can provision the Application Database (SOADB), we need to provision a **Compartment** where we can setup the Network Layer ,or you can take details of already created **Compartment** from your network administrator.

1. Go to the menu button on the top left and select **Identity -> Compartment** .

  <img src="./images/menu-compartment.png" width="50%">

2. Click on **Create Compartment**

  <img src="./images/compartment-create-0.png" width="70%">

3. Provide all the required details and make sure you have relevant permissions from your OCI Administrator to create the **Compartment**.

  <img src="./images/compartment-create.png" width="70%">

## **STEP 2:** Create the VCN

We need to provision a **VCN** by choosing **Start VCN Wizard** with preconfigured **public subnet** and **private subnet** with appropriate **Security Lists** to open up the required ports:

1. Go to the menu button and go to **Networking -> Virtual Cloud Networks**.

  <img src="./images/vcn-menu.png" width="50%">

2. Click on **Create VCN** button and then select **VCN with Internet Connectivity** and click on **Start VCN Wizard** button.

  <img src="./images/provision-vcn-4.png" width="100%">

3. Provide the VCN NAME (we'll use `SOAMP1VCN`) and select the Compartment which you have created earlier.

  <img src="./images/provision-vcn-5.png" width="100%">

4. Select the default values for Configure VCN and Subnets unless you have been provided by specific CIDR range from your Network Administrator to use, then click on **Next** button.

  <img src="./images/provision-vcn-6.png" width="100%">

5. Review all the **VCN** ,**Subnet** ,**Gateway**, **Security List** and **Route Table** details and then click on **Create** button.

Here you can see stack has created two subnets which we we'll use later for creating DB and SOA instance:-
A **Private Subnet** with its security list **Security List For Private Subnet-SOAMP1VCN**,
A **Public Subnet** with it's security lists **Default Security List for SOAMP1VCN**

6. Click **Create**

  <img src="./images/provision-vcn-7.png" width="100%">

7. If you see any provisioning error, make sure to click **Re-provision**

8. When all is clear click **Close**

## **STEP 3:** Create the required Security Lists

Before we can provision the SOAMP Instance, we need to provision a **Security list** for the database subnet to be reachable from the SOA instances, and open up the required ports: 

  - port 1521 for the database
  - port 22 for SSH

As well as open up ports to access the WebLogic and SOA domain servers:

  - 7001-7004 for SOA weblogic
  - 9001-9004 for weblogic internal ports

In this section we will create a Security List for the SOA subnet to be able to reach the Database subnet on port 1521 (the Oracle Database default port), SSH port 22 and weblogic ports 7001-7004 , 9001-9004 to communicate to SOA instance.

1. Click **Security Lists**

  <img src="./images/sec-lists.png" width="70%">

2. Click **Security List for Private Subnet-SOAMP1VCN** 

  <img src="./images/provision-db-23-sl.png" width="100%">

3. Click on **Add Ingress Rules**

4. Add an ingress rules to open the DB port to the VCN CIDR.

  <img src="./images/db-seclist.png" width="70%">

5. Add an ingress rules to open the 7001-7004 ports to the world CIDR (0.0.0.0/0).

  <img src="./images/wls-7001-seclist.png" width="70%">

6. Add an ingress rules to open the 9071-9074 ports to the world CIDR (0.0.0.0/0).

  <img src="./images/wls-9071-seclist.png" width="70%">

< !-- 
Not clear if needed. it seems like it was an artifact of bad deployment of VCN
9. Click **Subnets**

10. Select the **Private Subnet-SOAMP1VCN**

  <img src="./images/private-subnet.png" width="70%">

11. Click **Add Security List**

  <img src="./images/add-seclist.png" width="70%">

12. Select the **Security List for Private Subnet-SOAMP1VCN**

  <img src="./images/add-seclist2.png" width="70%">

13. Click **Add Security List** -->


You may proceed to the next lab
## Acknowledgements

 - **Author** - Akshay Saxena, September 2020
 - **Last Updated By/Date** - Akshay Saxena, Septemebr 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
