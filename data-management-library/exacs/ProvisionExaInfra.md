## Introduction

This lab walks you through the steps to get started using the Oracle Exadata Cloud Service Infrastructure. You will provision a new database infrastructure.

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

Watch the video below for an overview on how to provision Exadata Infrastructure in a Private OCI Network

<div style="max-width:768px"><div style="position:relative;padding-bottom:56.25%"><iframe id="kaltura_player" src="https://cdnapisec.kaltura.com/p/2171811/sp/217181100/embedIframeJs/uiconf_id/35965902/partner_id/2171811?iframeembed=true&playerId=kaltura_player&entry_id=1_o4ygs1je&flashvars[streamerType]=auto&amp;flashvars[localizationCode]=en&amp;flashvars[leadWithHTML5]=true&amp;flashvars[sideBarContainer.plugin]=true&amp;flashvars[sideBarContainer.position]=left&amp;flashvars[sideBarContainer.clickToClose]=true&amp;flashvars[chapters.plugin]=true&amp;flashvars[chapters.layout]=vertical&amp;flashvars[chapters.thumbnailRotator]=false&amp;flashvars[streamSelector.plugin]=true&amp;flashvars[EmbedPlayer.SpinnerTarget]=videoHolder&amp;flashvars[dualScreen.plugin]=true&amp;flashvars[hotspots.plugin]=1&amp;flashvars[Kaltura.addCrossoriginToIframe]=true&amp;&wid=1_8saov9vg" width="768" height="432" allowfullscreen webkitallowfullscreen mozAllowFullScreen allow="autoplay *; fullscreen *; encrypted-media *" sandbox="allow-forms allow-same-origin allow-scripts allow-top-navigation allow-pointer-lock allow-popups allow-modals allow-orientation-lock allow-popups-to-escape-sandbox allow-presentation allow-top-navigation-by-user-activation" frameborder="0" title="Kaltura Player" style="position:absolute;top:0;left:0;width:100%;height:100%"></iframe></div></div>

## Objectives

As a database user or DBA,

- Rapidly deploy Exadata Infrastructure in a pre-provisioned private network in your OCI account

## Required Artifacts

- An Oracle Cloud Infrastructure account with service limits to deploy at least one 1/4 rack of Exadata Infrastructure in any one region or Availability Domain.
You also need privileges to create Exadata Infrastructure

# Provisioning an Exadata Cloud Service Database Instance

In this section you will be provisioning a database using the cloud console.
## Steps

### **Step 1:** Create an Exadata Cloud Service Infrastructure

**Login to your OCI account as a database user**

-  Click on the hamburger menu icon on the top left of the screen

![](./images/Infra/provision_db_infra/oci_homepage.png " ")

-  Click on **Bare Metal, VM, and Exadata** from the menu

![](./images/Infra/provision_db_infra/oci_hamburger_menu.png " ")

- Select **ExaCS Compartment**

![](./images/Infra/provision_db_infra/oci_db_display.png " ")

**Note:** Oracle Cloud Infrastructure allows logical isolation of users within a tenancy through Compartments. This allows multiple users and business units to share an OCI tenancy while being isolated from each other.

**If you have chosen the compartment you do not have privileges on, such as a root compartment, you will not be able to provision a Database instance in it.**

More information about Compartments and Policies is provided in the OCI Identity and Access Management documentation [here](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm?tocpath=Services%7CIAM%7C_____13).

-  Click on **Create DB System** that is created

![](./images/Infra/provision_db_infra/create_db.png " ")

- Upon clicking, a pop-up will appear that will enable you to create exadata infrastructure. Fill in Section 1: DB System Information with the details shown below

![](./images/Infra/provision_db_infra/create_db_popup.png " ")
![](./images/Infra/provision_db_infra/create_db_system_details.png " ")

- Select a compartment : < Your working compartment >
- Name your DB system : < DB Display Name >
- Select an availability domain : < AD1, AD2, AD3 >

![](./images/Infra/provision_db_infra/create_db_system_details.png " ")

- Select a shape type : Exadata
- You can select required shape from the pop-up based on your availability

![](./images/Infra/provision_db_infra/exadata_shape.png " ")
![](./images/Infra/provision_db_infra/exadata_shape_popup.png " ")

- Configure the DB system
    - Total node count : 2
    - Oracle Database software edition : Enterprise Edition Extreme Performance
    - CPU core count : < Min 4 upto 48 >

![](./images/Infra/provision_db_infra/configure_db_system.png " ")
- Configure storage (Optional)
- Add public SSH keys : < Add public key >
- Choose a license type : < License Included >

![](./images/Infra/provision_db_infra/add_public_key.png " ")

- Specify the network information
    - Virtual cloud network in ExaCS : ExaVCN
    - Client Subnet in ExaCS : Client(regional)
    - Hostname prefix : <your hostname prefix>
    - Host domain name : read-only
    - Host and domain URL : read-only

![](./images/Infra/provision_db_infra/exa_network.png " ")

- After clicking **Next**, fill in the details for Database Information as shown below

```
Database name : usrXX
Database version : 19c
PDB Name : usr_XX
Database Home : Select an existing Database Home
Database Home display name : User-XX-db
Create administrator credentials
    - Password : create password
Select workload type:
    - On-Line Transaction Processing (Choose this)
    - Decision Support System (DSS)
Configure database backups : do not check this
```

![](./images/Infra/provision_db_infra/oci_create_db_1.png " ")
![](./images/Infra/provision_db_infra/oci_create_db_2.png " ")

 ****NOTE: Password must be 9 to 30 characters and contain at least 2 uppercase, 2 lowercase, 2 special, and 2 numeric characters. The special characters must be _, #, or -.****

#### For this lab, we will be using the following as password

```
WE#lcome_1234
```
- After filling all the required details, click on **Create Database**  
![](./images/Infra/provision_db/oci_create_db.png " ")

- Your Exadata cloud service database instance should be up and running in a few minutes.

![](./images/Infra/provision_db/oci_db_provisioning.png " ")All Done! You have successfully deployed your Exadata cloud service infrastructure and created a database instance and it should be ready for use.
