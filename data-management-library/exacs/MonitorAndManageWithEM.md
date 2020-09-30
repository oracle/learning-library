## Introduction

Oracle Enterprise Manager is Oracle’s management platform that provides a single dashboard to manage all of your Oracle deployments, in your data center or in the cloud. Through deep integration with Oracle’s product stack, it provides market-leading management and automation support for Oracle applications, databases, middleware, hardware, and engineered systems.


### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.​


## Objectives

In this lab, you learn how to do the following:

- Deploy an Enterprise Manager(EM) Marketplace Image.

- Install Agents.

- View monitoring details and set alerts.

​

## Requirements

To complete this lab, you will have needed to do the following:

- Installed Enterprise Manager Marketplace Image on a Private IP:
- Followed Steps in the [Lab 1](?lab=lab-1-preparing-private-data-center-o) to setting up an app subnet in your ExaCS compartment
- Created a preexisting EM with Fast Connect to connect to OCI infrastructure

​

## Overview

1. Setting Up Policies/Prerequisites
2. Provision Marketplace Image
3. Logging into the Image
4. Set up credentials in Enterprise Manager
5. Add host target manually
6. Add Non-Host targets using a guided process
7. View monitoring details/set alerts
8. Creating Groups
9. Viewing Monitoring Details

​
## Step-by-Step Instructions


### **Step 1:** Setting Up Policies


- Refer the [documentation](https://blogs.oracle.com/oem/oracle-enterprise-manager-is-now-available-on-oracle-cloud-marketplace) here to help set up your EM Marketplace Image.

- Keep in mind that the following steps must be executed by an OCI ADMIN, and it is assumed that you already have an ExaCS compartment setup.

​- Navigate to the ExaCS compartment and copy the compartment OCID.


![](./images/dbsec/lab6EM/NavigatetoCompartment.png " ")

![](./images/dbsec/lab6EM/CopyCompartmentOCID.png " ")

​

- From the navigation menu, under 'Identity', click **Dynamic Groups**.

​
![](./images/dbsec/lab6EM/NavigateOCIDynamic.png " ")

​
- Click **Create Dynamic Group**

​
-  Name your dynamic group **OEM_GROUP**, give it a description, and optionally give it a tag.


![](./images/dbsec/lab6EM/CreateOCIDynamicGroup.png " ")

- In the **Matching Rules** section, type the following for 'Rule 1':

```
<copy>ALL {instance.compartment.id = '<compartment ocid>'}</copy>
```

- Click **Create Dynamic Group**


- Now, from the navigation menu, under 'Identity' click on **Policies**

​
![](./images/dbsec/lab6EM/NavigateOCIPolicies.png " ")


- Under 'List Scope', select the 'root' compartment.
​

![](./images/dbsec/lab6EM/ChangetorootCompartment.png " ")

​
- Click **Create Policy**.


- Name your policy **OEM_Policy** and provide an optional description.

​
- Under 'Policy Statements', provide the following:

​

```

<copy>Allow dynamic-group OEM_Group to manage instancefamily in tenancy</copy>

```
​

```

<copy>Allow dynamic-group OEM_Group to manage volumefamily in tenancy</copy>

```

- Click **Create**.

​

![](./images/dbsec/lab6EM/SetOCIPolicy.png " ")

​

- Lastly, you need to ensure that these ports are open in your app subnet in your EXACS VPN. Refer to [Lab 1](?lab=lab-1-preparing-private-data-center-o)  for Networking.

​

| Destination Port Range |  Protocol Type | Service |

|------------------------|----------------|---------|

|22    |  TCP | SSH

|7803 | TCP |   Console

|4903 | TCP |   Agent Upload

|7301 | TCP |   JVMD

|9851 | TCP |   BIP


​
### **Step 2:** Provision Marketplace Image

- From the navigation menu, under 'Solutions and Platform' click on **Marketplace**

​
![](./images/dbsec/lab6EM/NavigateMarketplace.png " ")

​
- Search for 'Oracle Enterprise Manager 13.3' and click on it.


![](./images/dbsec/lab6EM/FindEMinMarketplace.png " ")
​

- Review the 'Oracle Enterprise Manager Overview' and click on **Launch Instance**


![](./images/dbsec/lab6EM/ReviewandLaunch.png " ")

​
- Select the 'Package Version', select the 'Compartment', Accept the 'Terms of Use' and click **Launch Instance**.


![](./images/dbsec/lab6EM/SpecifyCompartment.png " ")

​

- Enter an Instance Name, select your desired OCI Availability Domain and select the desired shape for the VM. You can choose any shape that is available.

​

![](./images/dbsec/lab6EM/NameInstanceSelectAD.png " ")

​

![](./images/dbsec/lab6EM/SelectComputeShape.png " ")


- Add the SSH Public Key that will be used to access the instance. Configure network by adding Virtual Cloud Network and Subnet created in the prerequisites. Click **Create**.


![](./images/dbsec/lab6EM/EnterSSHkey.png " ")


- Now you can go get some coffee while the Image is installed in your OCI compartment. The installation should take approximately 30 minutes.

​

### **Step 3:** Logging into the Image


- Once your VM instance is in running state, click on the instance and copy the Public IP Address.  SSH into the VM instance with the ssh key.

```
<copy>ssh –i private_ssh_key opc@public_IP_Address</copy>
```

![](./images/dbsec/lab6EM/CopyVMIP.png " ")

​

- Check the status of your newly-installed EM:  In the command line console, change user to ‘oracle’ by following command and check the OMS(Oracle Management Service) status using the EMCTL command.



```

<copy>sudo su – oracle</copy>

```


```

<copy>/u01/app/em13c/middleware/bin/emctl status oms</copy>

```

- Refer sample status as follow:

​

![](./images/dbsec/lab6EM/CheckStatus.png " ")

- Change the default passwords. The password for the EM user sysman, EM Agent, Registration Password, Fusion Middleware user weblogic and Node Manager can be accessed from the following file (access as root user).

​

```

<copy>cat /root/.oem/.sysman.pwd</copy>

```


```

<copy>/u01/app/em13c/middleware/bin/emctl config oms -change_repos_pwd</copy>

```

- Log into your new EM Console


``` 

<copy>https://private_ip_address:7803/em</copy>

``` 


- If you need help trouble shooting before going to Step 4, the installation log is located at:

```
<copy>cat /var/log/emcg_setup.log</copy>
```

You should refer to this [doc](https://blogs.oracle.com/oem/enterprise-manager-on-oci-installation-phase-2-installing-the-em-app-into-your-oci-compartment) for more help.

​

### **Step 4:** Set up credentials in Enterprise Manager

- Log in to your Enterprise Manager from a bastion host through VNC/ VNC like application.

``` 

<copy>https://private_ip_address:7803/em</copy>

``` 
​

- Username should be **sysman / welcome16**


- Go to **Setup**, select **Security** and  click on **Named Credentials**.

​
![](./images/dbsec/lab6EM/SelectNamedCredentials.png " ")

​

- Click **Create**.

​
![](./images/dbsec/lab6EM/PressCreateCredentials.png " ")



- Fill in the required fields (write **Credential Name** as 'ExaCS1'), select **SSH Credentials** under **Credential Type** and select **Global** as the **Scope**.


- UserName should be opc. Upload SSH Private Key. ​

![](./images/dbsec/lab6EM/CreateCredential.png " ")

### **Step 5:** Add host target manually

- To **Add Target manually**, Click on **Setup**, select **Add Target** and then click **Add Targets Manually**.


![](./images/dbsec/lab6EM/SelectAddTargets.png " ")


- Select **Install Agent on Host**.

​​![](./images/dbsec/lab6EM/SelectAddHost.png " ")

- Click **Add**.

​![](./images/dbsec/lab6EM/SelectAdd.png " ")

​

- If you have added the ExaCS node IP addresses to your EM hosts file, enter the Full Qualified Domain Name you have entered there, otherwise enter the IP address.


- For the Platform, select **Linux x86-64**.


- Add as many nodes as there are on the ExaCS (Quarter Rack=2, Half=4, etc.).


![](./images/dbsec/lab6EM/EnterHostName.png " ")


- Click **Next** then select your 'Named Credential' and specify an install directory that the user in your named credentials file has access to.

![](./images/dbsec/lab6EM/InstallationDetails.png " ")


- Click **Next** and after reviewing, click **Deploy Agent**.

**NOTE: If you run into deployment issues, make sure port 3872 is open on DB port, and edit hosts file on both target and EM host to include each other with a full qualified unique name.** 

​
### **Step 6:** Add Non-Host Targets using a guided process

- Click on **Setup**, then **Add Target**, and then **Configure Auto Discovery**.

![](./images/dbsec/lab6EM/SelectConfigureAutoDisc.png " ")

- Select **Targets on Hosts**.

![](./images/dbsec/lab6EM/SetupDiscovery.png " ")

- Select your hosts, one at a time and click **Discover Now**.

​![](./images/dbsec/lab6EM/SelectTargetsonHosts.png " ")

- Select **Discover Now**.
​
- Select your next host and repeat the process until all nodes have been discovered.

- Now navigate to 'Auto Discovery Results'.


![](./images/dbsec/lab6EM/NavigateAutoDiscRes.png " ")

​
- Now, you need to find the 'Cluster' Target and promote it. 

​
![](./images/dbsec/lab6EM/SelectClusterTarget.png " ")

​
- No Cluster database target can be added/promoted/discovered until the 'Cluster' target has been added or discovered. Promote it with its default inputs.


- After promoting the 'Cluster' Target, promote the 'Cluster Database' target by finding one and clicking **Promote**. Promoting the Cluster DB should also promote its DB instances.
​

![](./images/dbsec/lab6EM/FindClusterDB.png " ")

- You will need to enter Monitoring User Credentials (like dbnsmp) for this cluster. You can also enter the SYSDBA Password.


![](./images/dbsec/lab6EM/PromoteClusterDatabase.png " ")

​
- If you have selected multiple databases and you want to set the same monitoring properties for all of them, select **Specify Common Monitoring Credentials**. Enter the monitoring credentials, monitoring password, and role. Click **Apply**.


- Click **Next**, review the page and  click **Save**.


![](./images/dbsec/lab6EM/PromoteClusterReview.png " ")


- Click [here](https://docs.oracle.com/cd/E63000_01/EMADM/discovery_db.htm#EMADM13664) for more details on Discovering and adding DB Targets.


- Repeat this process for all Cluster Databases. Promote any additional target you want to monitor.​

- You can review by going to the 'Configure Auto Discovery' to see what has been promoted.


- If there are errors, you need to make changes to your credentials or Installation Details Page.
​

### **Step 7:** View monitoring details/set alerts

- To View an Enterprise Summary of all targets, go to 'Enterprise' and click on **Summary**.


![](./images/dbsec/lab6EM/NavigateEnterpriseSummary.png " ")


- In 'Enterprise Summary' you can view the status of all the targets, with the availability to sort by different types.


![](./images/dbsec/lab6EM/EnterpriseSummary.png " ")


### **Step 8:** Creating Groups

- To create a group, navigate to 'Targets' and click on **Groups**. We will create a dynamic group that includes everything on our Exadata Cloud Service hosts.


![](./images/dbsec/lab6EM/NavigateGroups.png " ")


- Once there, click **Create** and then **Dynamic Group**.


![](./images/dbsec/lab6EM/CreateGroupButton.png " ")


- Give it a name (for example ExaCS).

- Click **Define Membership Criteria**.


![](./images/dbsec/lab6EM/CreateDynamic.png " ")


- Press the search bar next to 'On Host'.


![](./images/dbsec/lab6EM/DefineMemberCriteria.png " ")


- Move over all nodes(hosts) from the ExaCS and press **Select**.


![](./images/dbsec/lab6EM/AddHosts.png " ")


- Then press **OK** and **OK** again to create 'Group'.

### **Step 9:** Viewing Monitoring Details

- To navigate to 'Targets', click on the **Targets** dropdown and select **All Targets**.

![](./images/dbsec/lab6EM/NavigateTargets.png " ")

- In 'Search Target Name', add a target you want to see the metrics for, for example a db name.


![](./images/dbsec/lab6EM/SearchTarget.png " ")


- Select **Cluster Database**.


- This will take you to main target page for the database. To see all metrics, select **Cluster Database**, then **Monitoring**, and then **All Metrics**.


![](./images/dbsec/lab6EM/NavigateAllMetrics.png " ")


- Here you can search and explore different metrics on the cluster level.


![](./images/dbsec/lab6EM/SearchMetrics.png " ")


- To view metrics, navigate to 'Members', and select **Dashboard**


![](./images/dbsec/lab6EM/NavigateMemDash.png " ")


- Here you can select a database instance and repeat the process to see the metrics for an instance.


![](./images/dbsec/lab6EM/SeeMembers.png " ")

