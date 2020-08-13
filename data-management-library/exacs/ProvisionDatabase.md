## Introduction

This lab walks you through the steps to get started using the Oracle Exadata Cloud Service Database on Oracle Exadata Cloud Service. In this lab, you will provision a new database.

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

Watch the video below for an overview on how to provision databases on your Exadata Cloud Service

<div style="max-width:768px"><div style="position:relative;padding-bottom:56.25%"><iframe id="kaltura_player" src="https://cdnapisec.kaltura.com/p/2171811/sp/217181100/embedIframeJs/uiconf_id/35965902/partner_id/2171811?iframeembed=true&playerId=kaltura_player&entry_id=1_9raaqkdn&flashvars[streamerType]=auto&amp;flashvars[localizationCode]=en&amp;flashvars[leadWithHTML5]=true&amp;flashvars[sideBarContainer.plugin]=true&amp;flashvars[sideBarContainer.position]=left&amp;flashvars[sideBarContainer.clickToClose]=true&amp;flashvars[chapters.plugin]=true&amp;flashvars[chapters.layout]=vertical&amp;flashvars[chapters.thumbnailRotator]=false&amp;flashvars[streamSelector.plugin]=true&amp;flashvars[EmbedPlayer.SpinnerTarget]=videoHolder&amp;flashvars[dualScreen.plugin]=true&amp;flashvars[hotspots.plugin]=1&amp;flashvars[Kaltura.addCrossoriginToIframe]=true&amp;&wid=1_moh7sdfs" width="768" height="432" allowfullscreen webkitallowfullscreen mozAllowFullScreen allow="autoplay *; fullscreen *; encrypted-media *" sandbox="allow-forms allow-same-origin allow-scripts allow-top-navigation allow-pointer-lock allow-popups allow-modals allow-orientation-lock allow-popups-to-escape-sandbox allow-presentation allow-top-navigation-by-user-activation" frameborder="0" title="Kaltura Player" style="position:absolute;top:0;left:0;width:100%;height:100%"></iframe></div></div>


## Objectives

As a database user, DBA or application developer,

- Rapidly deploy databases on exadata cloud service 
- Manage your database backups

## Required Artifacts

- An Oracle Cloud Infrastructure account with a pre-provisioned Exadata Infrastructure 


# Provisioning an Exadata Cloud Service Database Instance

In this section you will be provisioning a database using the cloud console.
## Steps

### **Step 1:** Create an Exadata Cloud Service Database

**Login to your OCI account as a database user**

-  Click on the hamburger menu icon on the top left of the screen

![](./images/Infra/provision_db/oci_homepage.png " ")

-  Click on **Bare Metal, VM, and Exadata** from the menu

![](./images/Infra/provision_db/oci_hamburger_menu.png " ")

- Select **ExaCS Compartment** 

![](./images/Infra/provision_db/oci_db_display.png " ")

**Note:** Oracle Cloud Infrastructure allows logical isolation of users within a tenancy through Compartments. This allows multiple users and business units to share an OCI tenancy while being isolated from each other.

**If you have chosen the compartment you do not have privileges on, such as a root compartment, you will not be able to provision a Database instance in it.**

More information about Compartments and Policies is provided in the OCI Identity and Access Management documentation [here](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm?tocpath=Services%7CIAM%7C_____13).

-  Click on **Exadata Infrastructure** that is already provisioned.

![](./images/Infra/provision_db/create_db.png " ")

-  This will bring you the Exadata Console page

![](./images/Infra/provision_db/oci_db_details.png " ")


-  On the Display page, when you scroll down there is a section called **Databases**, under that section, click on **Create Database** option

![](./images/Infra/provision_db/oci_db_list.png " ")

- Upon clicking a pop-up will appear that will enable you to create a database. Fill in the required details as shown below 

```
<copy>Database name : usrXX
Database version : 19c
PDB Name : usr_XX
Database Home : Select an existing Database Home
Database Home display name : User-XX-db
Create administrator credentials 
    - Password : create password 
Select workload type:
    - On-Line Transaction Processing (Choose this)
    - Decision Support System (DSS)
Configure database backups : do not check this</copy>
```
![](./images/Infra/provision_db/oci_create_db_1.png " ")
![](./images/Infra/provision_db/oci_create_db_2.png " ")

 **NOTE: Password must be 9 to 30 characters and contain at least 2 uppercase, 2 lowercase, 2 special, and 2 numeric characters. The special characters must be _ or # or -** 

#### For this lab, we will be using the following as password

```
<copy>
WE#lcome_1234
</copy>
```

- After filling all the required details, click on **Create Database**  
![](./images/Infra/provision_db/oci_create_db.png " ")

- Your Exadata cloud service database instance should be up and running in a few minutes.

![](./images/Infra/provision_db/oci_db_provisioning.png " ")


All Done! You have successfully deployed your first Exadata cloud service database instance and it should be ready for use in a few minutes.
