# Multitenant Database Lifecycle Management
## Before You Begin

The objective of this workshop is to highlight the Oracle Enterprise Manager Cloud Control 13c’s Lifecycle Management capabilities around Multitenant Database. We will walk through how Database organizations can begin their Cloud journey with Multitenant Database by requesting a Pluggable Database (PDB) for testing purposes and perform other Lifecycle Operations like Clone, Unplug etc. We will also focus on setting up Private Cloud for PDBs and highlighting the ease of Provisioning, Resizing and even Deleting a PDB using a Self-Service option.

Applicable User Roles in the Organization:

![](images/ca612c296dce62109ae33de2f81110a7.jpg)

### Background

The estimated time to complete all the Step activities is approximately 60 minutes.

| **Step No** | **Feature**                                                                | **Approx. Time** | **Details**                                                                                                                                                                      | **Value proposition**                                                                                                                                                                                                                   |
|--------|----------------------------------------------------------------------------|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1    | Create a Pluggable Database (PDB)                                      | 10min                     | Create Pluggable database (PDB) within a CDB and run a post-script to lock/unlock accounts.                                                                                  | Create multiple PDBs with few clicks while making sure they follow organization’s standards by using automated post-scripts.                                                                                                           |
| 2    | Un-plug/Plug an existing Pluggable Database | 10min                     | Un-plug a PDB and later Plug it back in a CDB when needed (Create from unplugged)                                                                                                                       | Unplug a PDB when not needed and plug it back as per need hence maximizing resource utilization in your organization. Easily upgrade PDBs with few clicks by moving from one container to another.                                                                                                                  |
| 3    | Clone an existing Pluggable Database                                 | 5min                      | Create multiple copies (Clones) of a PDB to dev/test purpose                                                                                                                     | Create multiple PDBs clones for Dev/test with few clicks while making sure they follow organization’s standards by using automated post-scripts.                                                                                      |
| 4    | Compliance Management for Pluggable Database                                                         | 10min                     | Apply a compliance standard on PDB and use corrective action to fix the violation                                                                                                | Make sure PDBs comply with compliance standards and fix them with a click of a button if there is any anomaly.                                                                                                                         |
| 5    | Self- service to request a PDB using PDBaaS            | 10min                     | Request PDB pluggable database using Service Catalog. (Private Cloud) Resize the PDB and then Delete the PDB while preserving the contents.                                                      | Review self-service option to provision PDB, which only requires minimal inputs.                                                                                                                                                        |
| 6    | Administrative Setup for PDBaaS (Private Cloud)- Review only               | 10min                     | An overview of the administrative setup involved for PDBaaS (Private Cloud) which includes setting up a PaaS Infrastructure Zone, Pluggable Database Pool, Data Sources, Service Template, etc. | Setup private cloud using Enterprise Manager where admin can define resources and EM’s placement algorithm and make sure that resources are utilized to their best. It is complimented by metering, and show back/chargeback capabilities. |

### What Do You Need?

Prior to starting, you will need:
- EM Instance Public IP address
- OMS Console URL: http://\{EM Instance Public IP\}:7803/em
- OMS super-user Credentials:
    -   Username: **sysman**
    -   password: **welcome1**

## Getting Started

### Access

1. Login to OMS Console
Log into your Enterprise Manager VM using the Public IP of your EM instance. The Enterprise Manager credentials are “**sysman/welcome1**”

You may see an error on the browser while accessing the Web Console - “*Your connection is not secure*”. Ignore and add the exception to proceed. Access this URL and ensure that you are able to access Enterprise Manager Web Console.

## Step 1: Create Pluggable Database (PDB)

1.  Log into your Enterprise Manager VM using the IP provided on your cheat sheet. The Enterprise Manager credentials are “**sysman/welcome1**”.

2.  **Navigate** to the “***Enterprise menu >> Provisioning and Patching >> Database provisioning***”.

![](images/167e561726cc8d0a58d8b90a37274b06.jpg)

3.  In the Database Provisioning page, in the Related Links section of the left menu pane, **click** “**Provision Pluggable Databases**”

4.  In the Provision Pluggable Database Console, in the **Container Database** section, **select** the CDB (**CDB186 – 18.8 version**) within which you want to create new PDBs.

![](images/4a1835f78c064502ccac88138075133c.jpg)

5.  In the PDB Operations section, **select** Create Pluggable Databases, **Click** Launch

![](images/2248640eabc0efa2fb32293ec07fb389.jpg)

6.  Use the named credentials (CDB186\_SYS) for login

![](images/8741cbb813d375a296f8344f4beaeb7e.jpg)

![](images/9be6823423a692b7e1f0e240c10567c9.jpg)

7.  In the Source page of the Create Pluggable Database Wizard, in the Source Type section, **select** Create a new PDB . **Select** Named credentials “ORACLE”In the Identification page, **enter** a unique name for the PDB you are creating (your initial\_pdb). **Optionally**, **select** check box to “create multiple DBs” and put **2** as number of copies.

8.  In the PDB Administrator section, **enter** the credentials of the admin user account you need to create for administering the PDB. **UserName**: pdbadmin **Password**: welcome1 **Click** Next.

![](images/7442f8d5bf4704af57849ae9741f5a36.jpg)

9. For storage option, **select** “Use Common Location for PDB Datafiles” and leave defaults as-is.

![](images/e42b8bce3bdaac0c78fccbe24f1ede48.jpg)

10. Optionally, you may also want to select a post-script, which will run post creation of PDB. Choose “Select from software library” and then search for
“**unlock**” and select unlock.sql (Or you can upload a SQL file from your system).

![](images/7d3fcabc8fe5f6f80fe20e55bb28655d.jpg)

11. In the Schedule page, **select** immediately check box next to Start. **Click** Next**.**

12. In the Review page, review the details you have provided for the deployment procedure. If you are satisfied with the details, click Submit. You can now
    click on View Execution Details link to see details.

![](images/d12c1a1d5e3c3f394248da7d12813b6b.jpg)

13. In the Procedure Activity page, view the status of the procedure. Click the Status link for each step to view the details of the execution of each step.

![](images/3657eb9bb536b26d163c148e40a99332.jpg)

14. Once the procedure is completed (takes about 3-5 mins), you can **Navigate to Targets >> Databases, Click on CDB186** and you will see the newly created PDB

![](images/657ef309d7087942b8d871256a359050.jpg)

## Step 2: Un-plug/Plug an Existing Pluggable Database (PDB)

1. **Navigate** to the “***Enterprise menu >> Provisioning and Patching >> Database provisioning***”.

![](images/167e561726cc8d0a58d8b90a37274b06.jpg)

2. In the Database Provisioning page, in the Related Links section of the left menu pane, **click** “**Provision Pluggable Databases**”

![](images/33b77cf547caf09fe9c2d56b23fbaf43.jpg)

3.  In the Provision Pluggable Database Console, in the Container Database section, **select** the CDB (**CDB186**) within which you want to create new PDBs.

![](images/4a1835f78c064502ccac88138075133c.jpg)

4.  In the PDB Operations section, **select Unplug** Pluggable Databases, then **Click** Launch

![](images/b727e1673cfa38c85130ef6e2365055d.jpg)

5.  In the **Select** PDB page of the Unplug Pluggable Database Wizard, in the Select Pluggable Database section, select the PDB you want to unplug. Also **Select** Named credentials “ORACLE”

![](images/39102476b5e5915a1491e28525af88f5.jpg)

6.  In the Destination page, select the type of PDB template you want to generate for unplugging the PDB, and the location where you want to store it. The PDB template consists of all datafiles as well as the metadata XML file. **Select** radio button for software library. **Select** Generate PDB archive. **Enter** /tmp in location under Temporary working directory

![](images/4ad828f403bf702b7318f718ad98f117.jpg)

7.  In the Schedule page, **Select** immediately check box next to Start. **Click Next.** In the Review page, review the details you have provided for the deployment procedure. If you are satisfied with the details, click Submit. In the Procedure Activity page, view the status of the procedure.

![](images/bdbafe949b2bc880e2a09b82f9edaf8a.jpg)

8.  You can Navigate to ***Targets >> Databases***, Click on CDB186 and you will see the PDB you unplugged is no longer in the list.

9.  Let us continue to next steps and plug the same PDB back into the container database. Navigate to the “Enterprise menu >> Provisioning and Patching >> Database provisioning”.

![](images/167e561726cc8d0a58d8b90a37274b06.jpg)

10. In the Database Provisioning page, in the Related Links section of the left menu pane, **click** Provision Pluggable Databases

![](images/33b77cf547caf09fe9c2d56b23fbaf43.jpg)

11. In the Provision Pluggable Database Console, in the Container Database section, **select** the CDB (**CDB186**) within which you want to create new PDBs.

![](images/4a1835f78c064502ccac88138075133c.jpg)

12. In the PDB Operations section, **select** Create Pluggable Databases , **Click** Launch

![](images/2248640eabc0efa2fb32293ec07fb389.jpg)

13. In the Create Pluggable Database Wizard, in the Create Options section, select **Plug an unplugged PDB**. **Select** Named credentials “ORACLE”

![](images/5427807b6e4c677bd991497cfc5468ce.jpg)

14. In the Identification page, enter a unique name for the PDB you are plugging in. **Select** Create As Clone to ensure that Oracle Database generates unique PDB DBID, GUID, and other identifiers expected for the new PDB. **Enter** PDB name like “clone\_pdb”.

![](images/2ac79b220d664b868c62e4529791e187.jpg)

**Note**: We will keep pdbadmin as a default admin. So, don’t select anything in this section.

17. On the Identification page, in the PDB Template Location section: **Select** “Software Library” radio button. **Click** on the magnifier icon placed on Location text box. **Select** the Name which you created During Unplug **Click** Next

![](images/dad1846d73cd9ca339bab04718e09816.jpg)

18.  **Select** “Use Common Location for PDB Datafiles” and use **/tmp** as temporary working directory.

![](images/a6353f812935eeb6148a79693ae0c4fd.jpg)

21.  In the Schedule page, **select** immediately check box next to Start. **Click** Next.

22.  In the review page, review the details you have provided for the deployment procedure. If you are satisfied with the details, **click** Submit. You can now click on View Execution Details link to see details.

23.  In the Procedure Activity page, view the status of the procedure.

24. Optionally **Click** the status link for each step to view the details of the execution of each step. Once the procedure is completed, you can Navigate to ***Targets >> Databases***, Click on CDB186 and you will see the newly created PDB

**Note**: You do not have to wait until the steps complete and move on to the next section.

## Step 3: Clone an Existing Pluggable Database (PDB)

1.  **Navigate** to the “***Enterprise menu >> Provisioning and Patching >> Database provisioning***”.

![](images/167e561726cc8d0a58d8b90a37274b06.jpg)

2.  In the Database Provisioning page, in the Related Links section of the left menu pane, **click** Provision Pluggable Databases

![](images/33b77cf547caf09fe9c2d56b23fbaf43.jpg)

3.  In the Provision Pluggable Database Console, in the Container Database section, **select** the CDB (**CDB186**) within which you want to create new PDBs.

![](images/4a1835f78c064502ccac88138075133c.jpg)

4.  In the PDB Operations section, **select** Create Pluggable Databases, **Click** Launch

![](images/2248640eabc0efa2fb32293ec07fb389.jpg)

5.  **Select** clone PDB and select source as CDB186 (if you choose any other CDB, this operation might fail). Please keep Database link box empty. Select named credentials “ORACLE”, **Click** Next.

![](images/472126037592bdeca5eaa6027ebb57a3.jpg)

6.  **Enter** new PDB name

![](images/4a4164d7ee405fed16dc5a0aeefe430f.jpg)

7.  **Select** “Use Common Location for PDB Datafiles” in the Source page of the Create Pluggable Database Wizard, please enter **/tmp** in temporary working directory.

Optionally, you can select the postscript as we did in the creation flow. **Click** Next

![](images/ff556eb15570c55dfd477361c20051d6.jpg)

8.  When the see the Schedule page, just **select** the immediately check box next to Start. Then **Click** Next.

![](images/dblmschedulepage.jpg)

9.  After the Review page appears, and you have confirmed the information is correct for your deployment, click Submit. You can now click on View Execution Details link to see details and on the Procedure Activity page see the status of the procedure.

10.  Once the procedure is completed,  Navigate to ***Targets >> Databases***, then **Click** on CDB186 and you will see the newly created PDB

## Step 4: Compliance Management for Pluggable Database

Now database administrator applies a Corporate Standard on the newly created PDB database, which results in a “Violation”. Then, the DBA fixes the issue using corrective actions. Let us examine how a DBA applies the fixes in the following steps.

Navigate to ***Enterprise >> Compliance >> Library*** to get started

![](images/dblmcompliancelibrary.png)

1.  **Click** the Compliance Standards tab,  **Select** the row “Corporate Database Standard”, and then **Click** the Associate Targets tab

![](images/8ed5400adb044b81194db800cfd4c953.jpg)

2.  After which, **Click** Add and choose the row with your PDB, then **Click** OK  

3. In the Save Association dialog box, **Click** Yes

![](images/0ccc894ff6c91bdd0aa1b7e5f78fbe6e.png)

4. Then upon the Information processing prompt, **Click** OK

![](images/a01dffb956af685a866f02e68eff72b1.png)

5.  You need to refresh PDB statistics to see notifications. To refresh:

- **Click** the ***target icon >> Databases >> View >> Expand All***
- **Right Click** on ***PDB >> Oracle Database >> Configuration >> Latest.***
- **Click** the Refresh icon on the page (it will take few minutes for refresh to complete)

6.  Now Navigate to ***Enterprise >> Compliance >> Results***

![](images/1317deb228d80211d9e6a2edf2cbba9e.png)

7. Click Corporate Database Standard under Compliance Standards

![](images/4fd761f917fd5b2374e852575b2fe99f.jpg)

8. And you  will see the following screen

![](images/1376bfeae918518dbfd16d32ffc67b72.jpg)

9.  Click Violations link and  click on one of the Open Cursor Setting lines on the left under the Corporate Database Standard heading (red x).

![](images/e48f5a64f52812e23a631e0f3f270371.jpg)

10. You will see open cursors notification. Scroll down as needed then **Click** on the link “Submit from Library” link under the Corrective Actions heading.

![](images/19317a4da691bc2a1049ca7923414db3.png)

11. From the Corrective Actions popup box, Select the “FIX OPEN CURSOR” corrective action.

![](images/61ea7b2393701bf4ce48bd301a67b332.jpg)

12. Then review/enter the Named Credentials for the database and host and **Click** the Submit button

    -  For the database named credentials use: OEM\_SYS (scroll down after Database Credentials to see Host Credentials
    -  For the host credentials use: ORACLE\_HOST

![](images/6ccf17bb69cbc79dae30f95bc508f640.jpg)

13.  You will then see the popup as shown below. **Click** on the link “Click here to view the execution details”

![](images/21e5a02e32296dd7dea196a7edfd29ac.jpg)

    The job will take about a minute to complete. Click on refresh icon if the job did not complete. You will see the status change to Succeeded

![](images/3be714a84eeca17c22b2c786688b567a.jpg)

14. Once the status changes to Succeeded, **Click** Databases >> View >> Expand All and **Click** on Your PDB that you choose in the earlier step.

15. Under Administration drop down **Click** Initialization Parameters, then Scroll down and you will see the “open\_cursors” initialization parameter set to 400 as shown.

![](images/6b842b0948b11c52c1d56d2f9cdf1088.jpg)

 Now that you have gone through PDB life cycle operations, we will switch focus and cover the use case of building a private cloud using Enterprise Manager and how to quickly provision (with minimal inputs) and manage PDBs using PDB-as-a-service (PDBaaS).

## Step 5: Self-Service to Request PDB Using PDBaaS

With the Self-Service Portal, cloud users can request an  Pluggable Database through a simple process, monitor resource consumptions, and manage the pluggable database through an intuitive graphical user interface. Expiry time is provided while requesting the PDB instance and PDB is automatically deleted based on the expiry time.

1.  Login into Enterprise Manager as a Self-Service User. Self-Service User credentials are: **cyrus/welcome1**

2.  By default, you'll see the Database Cloud Self Service Portal landing page as shown below.

![](images/2d9dd5550b4774b590ccb4b1815ac70d.jpg)

3. **Click** the “Create Instance” button and then **Click** on Select icon for “**Provision New Empty Pluggable Database**”

![](images/ee694403e4c718e224a01ae91dbc88fd.jpg)

**Note: There are two service templates pertaining to Pluggable Database**

* **Provision New Empty Pluggable Database**: This template enables users to create a new pluggable database in a container database configured by DBA
* **Provision Pluggable Database with Data**: This template enables users to create a new pluggable database with data from non-container database.

4.  In the “**Pluggable Database Configuration**” section, enter Service and SID details:

- Name: **YOUR INITIALS\_PDB2** (e.g. AS\_PDB2)
- Database Service Name **: SERVICE\_YOUR INITIALS\_PDB2 (e.g. SERVICE\_AS\_PDB2)**
- Workload Size: Choose **Small**

![](images/fd8fe73465009dbd65e2231503481e40.jpg)

5.  Enter Credentials details in the “**Pluggable Database Administrator Account**”

- Administrator Name: **PDBADMIN**
- Password: **welcome1**
- Confirm Password: **welcome1**
- Tablespaces: **Accept default**

![](images/181bed80a9978ed3e02c050838749f2b.jpg)

6.  Instance Details, keep all defaults as they are. The Properties Page has the properties for the instance. The Self-Service Administrator has configured this as a optional step. However, properties can help users locate an instance more quickly. So Enter:

- Contact: **CYRUS**
- Lifecycle Status: **Test**

![](images/f5f29e12efaaf8a1fce318e871d9009d.jpg)

7.  Instance Duration - For Instance Duration Start: Accept the default (Immediately). For Duration: Specify 4 hours from the current time by selecting the “Until” radio button, changing to current date and specify time to be 4 hours from the current time

![](images/3035739cd46353882939fd894197f2ed.jpg)

8.  Click on Submit button

What do these options represent? In most cases the PDBaaS options are self-explanatory. The self-service user should be able to provision a PDB by entering minimal information. Fields with an ‘\*’ represent mandatory input fields. Please refer to the table listed below for a description of each option:

| **Field**                   | **Description**                                                                                                                                                                                                                                                                                    |
|-----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Request Name                | By default, it is the Self-Service User Requestor name with timestamp. This field can be modified                                                                                                                                                                                                  |
| Zone                        | The Zone is a PaaS Zone that represents hosts/vm, where the PDB database will be deployed for this request. The zones are configured by the administrator. Self-service user need not know the host or platform details.                                                                           |
| PDB Name                    | Required input. PDB database with user defined will be created for the container database                                                                                                                                                                                                          |
| Database Service Name       | The user defined prefix for the database service or alias for this self-service PDB. The rest of the service name will be system generated and will be associated with a database resource management plan.                                                                                        |
| Workload Size               | The resources allocated to the Database Service. The database resource management plan is derived from this option. You can configure multiple workload sizes. Each service template will contain unique workload sizes. This typically depends on the roles assigned to self-service user.        |
| Schedule Request            | Self-service user has the ability to create a PDB database immediately or choose to create at a later time. In this lab exercise, the administrator has defined a policy, so a self- service user has to specify time duration. The PDB database will be automatically deleted after the duration. |
| Administrator Name/Password | A database user with required administrative privileges will be created on the provisioned PDB. A self-service user will be able to administer the PDB database by logging in as this database user.                                                                                               |

9.  Once you submit a request, you will be redirected back to the “**Database Cloud Services**” Page. Your PDB creation request has been submitted to Enterprise Manager for execution. Under “**Requests**” region, you should see 2 requests: “**Create**” and “**Delete**” request

![](images/0d01a3a45ebb7f97fcc8752d52241b9d.jpg)

10. At this point, provisioning engine has received a request to create a PDB based on the service template and input provided by self-service user. You will also notice the delete operation is scheduled for future (not started yet) time. Click on the **hourglass** icon under Status column for the Create Pluggable Database step. You will see details of request.

11.  It will perform the following actions:

* Create database roles and PDB
* Create a resource plan based on the workload size
* Create and register the database

The request should take less than 10 minutes to complete. Click on refresh icon or as an alternative set Refresh to 30 seconds. The success status
indicates that PDB database was successfully created. The new PDB database should be visible under Database Cloud Services page.

![](images/3fc668c3d45cc0a1a7dc3c3f7233bfe6.jpg)

12. Click on Close button. You will see the following under Requests section.

![](images/9bd785e399889d2a53d9e7284bf6c329.jpg)

13. Click on the Home Icon. You will see new PDB instance.

![](images/ee3e8bccf25b8a836bea2f9a3a487cb7.jpg)

**Note**: Following widgets are shown on the Database Cloud Services landing Page

* **Instances** show the number and status (Up/Down) of the DB/PDB Instances provisioned by the self-service user.
* **Expiry**, shows the expiration summary of DB/PDB Instances.
* **Usage**, resource usage status for the Self-Service user, status of the resource consumption for this user.
* **Memory**, current memory consumption against the Quota for this user.
* **Storage**, current storage consumption against the Quota for this user.

14. Click on the name of the PDB. You can use the connection details to connect to the PDB using SQL tools.

![](images/9ca31e90c86263e6cddde14da1c6954f.jpg)

15. Click on **Resize** button to resize a PDB instance.

![](images/20537907e3a274a9df16e7c54f73713f.jpg)

* Resize allows you to resize your instance to other available resource sizes.
* We have 2 resource sizes available for Service Template. Both are displayed.
* Current size of PDB instance is Small, you can now resize it to large.

![](images/cc03cc86d7e3d8146a3d799b52583a83.jpg)

16. One you click on **Resize**, a job will be submitted to resize instance. In few minutes instance resize is completed. Expand **Resource Usage** section on PDB Home page. This shows now new resource usage limits.

![](images/64a8954df11d2e688a930fd92ae38cd8.jpg)

17.  Next delete the database Instance: Go to the Database Cloud Services Home page by clicking on **Database Cloud Service Portal link**

![](images/a24b112c579e1df59bb4919a0bbe2b67.jpg)

18. Click on the action menu for new PDB and delete this instance.

![](images/877bc45ab2f0ab8acd7ea6507baee575.jpg)

19. While deleting instance you can preserve a backup of the instance and create a new instance using this backup. To store backup of this instance, select check-box: **Preserve a backup of this instance**

![](images/2840b2e0869edc22af3245e98dba13eb.jpg)

20. Click OK. You will see confirmation to delete the instance.

![](images/2b44dd4c41f594cddd9adc74dd193297.jpg)

## Step 6: Administrative setup for PDB-as-a-Service (Private Cloud)

Previous exercises demonstrated the process of requesting PDBs using available service templates as performed by a Self-Service user. In this section, we will see the Administrative setup for PDBaaS.

Login to the EM Console as super administrator **sysman/welcome1**

### PaaS Infrastructure Zone

1. On the EM Console, go to Setup ->> Cloud ->> Database.

![](images/edfbce40d3abb0f21705992cc042c3ee.jpg)

2. Select **Pluggable Database** from the drop-down menu.

![](images/cf57fcbd4fe1570c40a1ee7f9b75dcec.jpg)

3. Then **Click** on **PaaS Infrastructure Zone** **Sales Infra Zone** is the zone where PDBs were provisioned in the previous sections. **Click** on name of the zone.

![](images/8ed6c692f382172bbc9f6e2b90179f9e.jpg)

4. You are taken to the Zone Home page; you can see all the details of a Zone such as the host members of this zone. You can explore more about the zone on this page.

![](images/b3ddc4d5e436d1e6dec7eb0ed795f0b7.jpg)

### Pluggable Database Pool

1. On the EM Console, go to **Setup**, then **Cloud**, then **Database**. Select **Pluggable Database** from the drop-down menu. And then click on **Pluggable Database Pool**’.

A Pluggable Database Pool consists of a set of Container Databases on which PDBs will be provisioned.

![](images/b49f455842d0fb11dd7de44fcaccfe26.jpg)

2. Click on name of the pool to see more details.

![](images/5fa7e9b6bb3648c664e4afc7aeac5670.jpg)

3. Scroll down to see details of Members and Service Templates.

![](images/243ed347412f16a2159b2184c2dacdf7.jpg)

### Data Sources

1. On the EM Console, go to **Setup**, then **Cloud**, then **Database**. Select Pluggable Database from the drop-down menu. And then click on **Data Sources** observe that the profile is based on Schema Export(s). This Data Profile was used for provisioning a PDB with data.

![](images/d834209bf1c6a238679ae419098ee0f3.jpg)

2. Select the row with profile to see more details.

![](images/532db10bbaab85fcdd83f245bd317a6b.jpg)

### Service Templates

1. On the EM Console, go to **Setup**, then **Cloud**, then **Database**. Select Pluggable Database from the drop-down menu. And then click on **Service Templates from you left menu.**

![](images/47baba2a1e7567bfb0b5f89429a7831d.jpg)

There are two service templates pertaining to Pluggable Database

* **Provision New Empty Pluggable Database**: This template enables the user to create a new pluggable database in a container database configured by DBA
* **Provision Pluggable Database with Data**: This template enables user to create a new pluggable database with data from a non-container database.

2. Click on name of any template to explore more details.

![](images/a0efb63a12d01e1254593656765ec52a.jpg)

That concludes this lab.

## Want to Learn More?

- [Oracle Enterprise Manager](https://www.oracle.com/enterprise-manager/)
- [Enterprise Manager Documentation Library](https://docs.oracle.com/en/enterprise-manager/index.html)
- [Database Lifecycle Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/lifecycle.html)
- [Database Cloud Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/cloud.html)

## Acknowledgements
* **Author** - Pankaj Chandiramani, Oracle Enterprise Manager Product Management
* **Adapted for Cloud by** -  Rene Fontcha, Oracle Enterprise Manager Sales Engineering
* **Last Updated By/Date** - Rene Fontcha, July 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
