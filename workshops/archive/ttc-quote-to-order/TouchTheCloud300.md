<img class="float-right" src="https://oracle.github.io/learning-library/workshops/common-content/images/touch-the-cloud/ttc-logo.png" width="200">
# Lab 300 - Integration Cloud Service

---

## Objectives

- Part 1: Explore Integration Cloud Service (ICS)
- Part 2: Use ICS to modify an integration
- Part 3: Modify PCS Process from Lab 200 to Call New ICS Integration

## Required Artifacts

- The following lab and an Oracle Public Cloud account that will be supplied by your instructor.

## Introduction

This is the third of several labs that are part of the **iPaaS - Build a Quote to Order Process Workshop**. 

In this lab, you will acquire a good overview of the Oracle Integration Cloud Service (ICS), the next generation integration platform. You will explore various consoles and tools available to interact with your integration. The exercise will get your familiar with all the tooling available to work with this cloud service. You will then modify an integration to Oracle EBS, then update a PCS application to call to the updated ICS endpoint.

# Part 1: Explore Integration Cloud Service

In this first part of the lab, we will explore the main parts of Integration Cloud Service (ICS).  We’ll look at the following:
1.	Oracle Cloud Services Dashboard
2.	ICS Designer User Interface
3.	ICS Monitoring User Interface

The ICS integration that we'll be working with is shown in the following picture:

![](images/300/image000.png)

Here is a description of what is happening with this integration:

Process Cloud Service (PCS) will be used to call the exposed Web Service endpoint of the ICS integration called *Create EBS Order*.  This integration has 3 connections.  The incoming message is received by the incoming *Create Order* Soap Connection.  The *Create EBS Order* orchestration makes 2 queries into the EBS database using the *eBusiness Suite DB APPS* connection to get details needed to create an order.  The orchestration finally uses the *eBusiness Suite OPERATIONS* EBS Adapter connection for creating the order in EBS.  After the order is created in EBS, the Order Number is returned to PCS.

Let’s start by logging into the Oracle Cloud account and explore the Services Dashboard

## 1.1: Explore the Oracle Cloud Dashboard

### **1.1.1**: Login to your Oracle Cloud Account

---

**1.1.1.1** From your browser (Firefox or Chrome recommended) go to the following URL:
<https://cloud.oracle.com>

**1.1.1.2** Click Sign In in the upper right hand corner of the browser
- **IMPORTANT** - Under My Services, change Data Center to `US Commercial 2 (us2)` and click on Sign In to My Services

![](images/300/image001.png)

**1.1.1.3** If your identity domain is not already set, enter it and click **Go**

**NOTE:** the **Identity Domain** values will be given to you from your instructor.

![](images/300/image002.png)  

**1.1.1.4**  Once your Identity Domain is set, enter your `User Name` and `Password` and click **Sign In**

***NOTE:*** the **User Name and Password** values will be given to you by your instructor.

![](images/300/image003.png)  

**1.1.1.5**  You will be presented with a Dashboard displaying the various cloud services available to this account.

**NOTE:** The Cloud Services dashboard is intended to be used by the *Cloud Administrator* user role.  The Cloud Administrator is responsible for adding users, service instances, and monitoring usage of the Oracle cloud service account.  Developers and Operations roles will go directly to the service console link, not through the service dashboard.

![](images/300/image004.png)

### **1.1.2:**	Explore Oracle Cloud Dashboard

---

The Cloud Dashboard is the launching pad for all the cloud services in your account. You have access to the following Cloud service: **Oracle Integration Cloud Service, Oracle Process Cloud Service, Oracle Database Cloud Service, Oracle Database Backup Service, Oracle Storage Cloud Service, Oracle Compute Cloud Service, Oracle Java Cloud Service and Oracle SOA Cloud Service**. The dashboard can be customized by selecting the `Customize Dashboard` button.

**1.1.2.1** To look at the details for the Integration Cloud Service (ICS) instance, first click on the `hamburger` icon, then click on the `View Details` link.

![](images/300/image004a.png)

**1.1.2.2**  The `Service Details` pages will show various important details about the ICS service instances in this identity domain such as service start date, end date, and your Oracle Cloud subscription ID.

![](images/300/image004b.png)

**1.1.2.3**  Access to `Billing Metrics`, `Resource Quotas`, etc.  can be found in the left-hand navigation.  Select the `Business Metrics` tab as shown below:

![](images/300/image004c.png)

**1.1.2.4**  The `Business Metrics` page will show the total number of messages that ICS has processed and the total number of active connections currently in the subscription.

![](images/300/image004d.png)

**1.1.2.5**  After getting familiar with the Business Metrics, go back to the “Overview” tab and select the `Open Service Console` link to go to the ICS Service Console.  

![](images/300/image005.png)  

**1.1.2.6**  You will now be presented with the ICS Service Console from which you will be performing the rest of this workshop lab.

![](images/300/image006.png)  

## 1.2: Explore the ICS Designer User Interface

### **1.2.1:**	Open the ICS Designer

---

**1.2.1.1**  **Click** on the `Designer` tab in the upper-right corner of the ICS Service Console to navigate to open the ICS Designer.

![](images/300/image007.png)  

**1.2.1.2** You will be presented with the ICS Designer Portal:

![](images/300/image008.png)  

### **1.2.2:**	Explore ICS Connections

---

**1.2.2.1** Select the `Connections` graphic in the designer portal

![](images/300/image009.png)  

**1.2.2.2** Make note of the connections that have been created. Notice that there are three connections, one called *eBusiness Suite OPERATIONS*, one called *eBusiness Suite DB APPS* and the other called *Create Order*.

![](images/300/image010.png)  

**1.2.2.3** Note that both *eBusiness Suite OPERATIONS*, and *eBusiness Suite DB APPS* are using the ICS Connectivity Agent.  You can identify this by the note that it has an associated agent group.  This agent allows ICS to call on-premise systems.

![](images/300/image010a.png) 

*(More information about the ICS Connectivity Agent will be given later)*

**1.2.2.4** Click on the `New Connection` button so we can see all the different ICS Connectors that are available.

![](images/300/image010b.png)

**1.2.2.5** Scroll through the list of connection types that are available in ICS:

![](images/300/image010c.png)

- Note that the icons with the plug are those that support the ICS Connectivity Agent for those service types which are not in the cloud, but on-premise, behind the company firewall.

**1.2.2.6** When you are done browsing, select the “Cancel” button to dismiss the “Select an Adapter” dialog.

### **1.2.3:**	Explore ICS Integrations

---

**1.2.3.1** Select the `Integrations` link from the navigation bar on the left of the Connections designer console

![](images/300/image011.png)  

**1.2.3.2** Make note of the integrations that have been created. We will be working with the integration called *Create EBS Order*.

![](images/300/image012.png)  

**1.2.3.3** Open the integration `Create EBS Order` by clicking on the integration name.  We want to see what it looks like.  Since the integration is already active, we’ll be looking at it in `Viewing` mode.

![](images/300/image012a.png)

**1.2.3.4**  You can see that this orchestration has many steps in it.  The view of the orchestration is *Zoom to Fit* in the browser real estate.  In order to get a closer view of the individual steps, you can either scroll with your mouse wheel to zoom in and out, or you can use the *-/+* slider in the top right of the designer.

**1.2.3.5** Try zooming in and out by using both methods.  

**1.2.3.6** If you get zoomed-in too close and want to pan, you’ll be able to move around the orchestration using the Pan window by clicking on the dark area and moving around.

![](images/300/image012b.png)

**1.2.3.7** Selecting the Home icon (the little house) the drawing gets reset to a zoomed in view with the orchestration trigger at the very top.

![](images/300/image012c.png)

**1.2.3.8** Try selecting the `Maximize` viewing control on the very right of the view control bar.  This will hide some of the detail on top of the screen to give the designer the most area to work in.  Hitting the `Maximize` button again will toggle that view.

![](images/300/image012d.png)

**1.2.3.9** Let’s look at some of the components of the integration.  Select the `Home` view button again to reset the view.

**1.2.3.10** The component at the very top of the orchestration is the `Trigger`.  The trigger is representative of the connector that’s sending data into the integration.

**1.2.3.11** If you hover over the Trigger node, you can see the details.  Our trigger is a SOAP connector type.  It is called *CreateOrder* and it is using the connection named *Create Order* that we looked at before in the Connection section of the ICS Designer.

![](images/300/image012e.png)

**1.2.3.12** If you click on the Trigger, a pop-up will appear with a view icon.  Select the little eye on the view icon so we can walk through the wizard that was used to setup the SOAP trigger.

![](images/300/image012f.png)

**1.2.3.13** After the wizard initializes, you’ll be shown the basic information about the trigger – it’s name and description.

![](images/300/image012g.png)

**1.2.3.14** Select the `Next` button to see the `Operations` that were configured for this SOAP Trigger.  Details like the Port Type, Operation, and request and response objects are shown.  In our case, no special SOAP headers were needed so that was set to `No`.

![](images/300/image012h.png)

**1.2.3.15** Select `“Next` again to see the `Summary` of the Trigger’s configuration.  The SOAP WSDL was uploaded to ICS when the connection was first configured, not in the wizard to configure the Trigger.

![](images/300/image012i.png)

**1.2.3.16** Select the `Close` button to dismiss the Trigger view wizard.

**1.2.3.17** Let’s view the next node down in the integration.  This is an *Assign* node.  The job of this Assign activity is to initialize variables that will be used in the calls to be made to the eBusiness Suite.

![](images/300/image012j.png)

**1.2.3.17** The variables defined in this Assign activity are greyed-out because we are only viewing them.  Later on in this lab, we’ll de-activate the integration and all the values will be changeable.  These variables are constants that are needed for the EBS API call for creating an order.  You can see that variables such as the *EBS responsibility*, *application*, *security group*, and *OrgId* are needed.  Using variable rather than hard-coding these in the mapping for the adapter is preferable because they can be re-used across multiple EBS adapter invocations if necessary.

![](images/300/image012k.png)

**1.2.3.18** Select the `Exit Assignments` button in the upper-left to go back to the view of the orchestration.

**1.2.3.19** Back in the view of the orchestration we want to explore some of the nodes toward the bottom.  You can pan directly in the design window by clicking & holding the mouse button down in the background of the design palette, then you can pan up and down.

![](images/300/image012l.png)

**1.2.3.20** Pan down to the map called `createEBSOrder`.  Click on this map activity and select the view icon.  We are going to see the values that are mapped into EBS.

![](images/300/image012m.png)

**1.2.3.21** This is the most complex mapping in this integration because the EBS API we’re leveraging has thousands of attributes that can be passed.

What you’ll see in the mapper is the possible input source variables on the left and the EBS target variables that can be mapped to on the right.  The values that have been mapped are shown to the right of the EBS inbound variables in the mapper.

**1.2.3.22** In order to simplify this view, we want to `Filter` the Target variables.  Select the `Filter` button above the Target section and then select the radio button labeled `Mapped`, then select the `Apply` button.

![](images/300/image012n.png)

**1.2.3.23** Now we only see variables in the Target that have been mapped from a Source variable.  If you want to get a visual depiction of where a Target variable has been mapped from, select the little green checkbox to the very left of the Target variable.  This will make a line visible from the Source variable to the Target.

![](images/300/image012o.png)

Note that the icon next to the `P_LINE_TBL_ITEM` has a double bar on top of it.  This indicates that it is a variable that can have multiple values in it (an array).  The ICS mapper automatically adds the `for-each(Lines)` function to that mapping so all possible order lines passed in from the Source will be mapped to the EBS adapter’s invocation.

**1.2.3.23** Once you are done exploring this complex ICS map, select the `Exit Mapper` button in the upper-left to return back to the ICS orchestration.

**1.2.3.24** One last orchestration node we want to explore is one of the *Database Adapter* invocations.  Click on the database adapter call just above the `createEBSOrder` which is called `getCustomerShipToInfo`.   When you click on the little eye icon to view it, the DB Connector wizard will initialize.

![](images/300/image012p.png)

**1.2.3.25** Along with the basic information about this invoke activity like the name and description, you can see that this connection is being used to execute a SQL query on the EBS database from ICS.

![](images/300/image012q.png)

**1.2.3.26** The SQL query being run can be examined.  This query is joining together 6 tables to provide the shipping information needed to create the EBS order for the customer.

![](images/300/image012r.png)

**1.2.3.27** Select the `Close` button now that we have seen the SQL used in the Database Adapter invocation to the EBS Oracle Database.

Note that ICS also has Database adapters for *MySQL*, *DB2*, and *SQL Server*.

**1.2.3.28** We’ve spent a lot of time exploring the `Create EBS Order` integration.  Let’s move on and explore the Agent setup.  Select the `Exit Integration` button in the upper-left to navigate back to the ICS Designer.

![](images/300/image012s.png)

### **1.2.4:** Explore ICS Agents

---

**1.2.4.1** Select the `Agents` link from the navigation bar on the left of the Integrations designer console

![](images/300/image013.png)  

**1.2.4.2** Make note of the agent that has been created to communicate with the EBS instance called *EBS Agent*.

![](images/300/image014.png)  

**1.2.4.3** Selecting the `1` shows the on-premise connectivity agent that is registered with the *EBS Agent* agent group.

![](images/300/image014a.png)

**1.2.4.4** The agent identifier along with the ICS version is shown in the details.  You can also remove the agent by selecting the `X` to the right of the dialog. Click on the `X` so you can see the connections that are currently associated with this agent.

![](images/300/image014b.png)

**1.2.4.5** You can see that both the *eBusiness Suite DB APPS* and *eBusiness Suite OPERATIONS* ICS Connectors are both using this agent so you can’t just remove it without first removing the references to it in those connections.

**1.2.4.6** Select the `Close` button twice to dismiss the `“Agent Is In Use` and `Agent` dialogs.

**1.2.4.7** This Connectivity Agent was installed on the EBS system so it could have access to the on-premise EBS APIs.  EBS Business Events and XML Gateway messages are available for inbound integrations in Oracle Integration Cloud Service when adding the Oracle E-Business Suite Adapter as a trigger (source) connection in an integration. If the Oracle E-Business Suite Adapter is added as an invoke (target) connection, PL/SQL APIs and Concurrent Programs are available as REST services for invocation from Oracle Integration Cloud Service. In this workshop we are using an EBS PL/SQL API as a target connection.  The architecture of the ICS Connectivity Agent as used by the EBS Adapter is shown below:

![](images/300/image014c.png)

**1.2.4.8** The Connectivity Agent is available from the `Download` pull-down on the Agent page shown below:

![](images/300/iamge014d.png)

**1.2.4.9** The `Execution Agent` that you see in the download dropdown is a version of ICS that can run on-premise behind the customer firewall.  You can use ICS both in the cloud and on-premise for creating integrations.

## 1.3: Explore the ICS Monitoring User Interface

### **1.3.1:**	Open ICS Monitoring Console

---

**1.3.1.1** In the upper right corner of the ICS Portal, click the `Monitoring` tab.  The `Monitoring Tab` is where you go to see how your activated integrations are working at runtime. 

![](images/300/image015.png)

### **1.3.2:**	Explore ICS Monitoring Console - Dashboard

---

**1.3.2.1** By default, you will be presented with the ICS Monitoring Dashboard.  Observe the various data that is available from this dashboard such as *% of successful messages*, *# of Connection Currently Used*, etc.

![](images/300/image016.png)  

**1.3.2.2** On the right side of the `Dashboard` there are links where you can view the `Activity Stream`, Download the logs, and Download an Incident if a service request needs to be raised.

**1.3.2.3** Click on the Activity Stream link

![](images/300/image017.png)

**1.3.2.4** You will be directed to the `Runtime Health` screen where you can view a summary of all messages that have passed through ICS in both chart form and numerical rollup form.

![](images/300/image018.png)

**1.3.2.5** In the `Activity Stream` at the bottom of the page you can see the steps in the *Create EBS Order* integration that were executed and whether or not they were successful.

### **1.3.3:**	Explore ICS Monitoring Console - Logfiles

---

**1.3.3.1** In order to see the details of the payload that passed through the ICS integration, you need to download the Activity Stream Log from the `Download Logs` link on the right of the Activity Stream.

**1.3.3.2** Select the `Download Activity Stream` link and then save the zipfile to a location on your workstation such as *C:\temp* (Windows path)

![](images/300/image019.png)
![](images/300/image020.png)

**1.3.3.3** Extract the zipfile and you’ll see that there are 2 directories of logfiles – this is because the ICS instance is running on a cluster of 2 servers for high availability.

![](images/300/image021.png)

**1.3.3.4** Navigate into one of the server directories and examine the `ics-flow.log` file in your favorite text editor.

Here is a view of the end of the *ics-flow.log* file in the *Notepad++* text editor showing the response given by EBS of the order payload after a successful execution of the create order API call:

![](images/300/image022.png)

This logfile is helpful for investigation during development or runtime analysis.  The capture of the runtime payloads can be turned on or off during activation of the ICS integration where you are prompted whether or not you want to save the payloads.

### **1.3.4:**	Explore ICS Monitoring Console - Integrations & Errors

---

**1.3.4.1** Back in the ICS Monitoring console, select “Integrations” from the left-hand navigation.

**1.3.4.2** Note that all the statistics of the “Create EBS Order” are shown.

![](images/300/image023.png)

**1.3.4.3** We are wondering why there were 4 errors in the integration?  (**Note:** during the lab there may not be any errors in the integration flows like there were when this lab was written.  If not, just review the documentation below to see how the ICS monitoring can be used to pinpoint the error)

**1.3.4.4** Click on the `Errors` link beneath the red letter 4 to drill into the error details.

![](images/300/image024.png)

**1.3.4.5** You are directed to the ICS `Error Message Details` screen where all 4 of the failed ICS instances are listed.

**1.3.4.6** Click on the grey warning icon ![](images/300/image025.png) on the right of the instance error description to see the details of the error.

You can see that there was a timeout in this integration of 120 seconds.

**1.3.4.7** We want to see which step the timeout occurred on.  Click on the integration instance name so you can see the flow of this instance and where it failed.

![](images/300/image026.png)

**1.3.4.8** This leads us to a graphical view of that particular integration flow instance detail.

Zooming in, we can see that everything was fine with the flow until the *createEBSOrder* API was called – this is where the flow line turns red.

![](images/300/image027.png)

**1.3.4.9** This shows us that the API call was timing out.

On investigation with the EBS system, it was found that the API was down because the EBS HTTP server (Oracle HTTP Server, OHS) was not running.  Starting OHS up on EBS made the API available and now the integration is up and running again.

**1.3.4.10**  Select the `Exit Instance` button to go back to the ICS Error Message Details Monitoring console.

![](images/300/image028.png)

### **1.3.5:**	Explore ICS Monitoring Console - Agents

---

**1.3.5.1**  Now, select `Agents` from the left-hand navigation.

From the `Agents` monitoring console, you’ll be able to see if the ICS Connectivity Agent is up or down.  The green *sun* or *light* icon indicates that the Connectivity Agent is running fine.

![](images/300/image029.png)

### **1.3.6:**	Explore ICS Monitoring Console - Tracking

---

**1.3.6.1** Select the `Tracking` link in the navigation bar on the left

![](images/300/image030.png)

**1.3.6.2** The ICS `Tracking` monitor page shows all integration flows that have been executed.

**1.3.6.3** Select the chevron just to the right of the *Tracking* label at the top of the page to change the granularity of the Tracking report to `Last 6 Hours`

![](images/300/image031.png)

**1.3.6.4** Next, drill into a `COMPLETED` integration flow by selecting the integration name like we did while tracking down the Error earlier.

![](images/300/image032.png)

**1.3.6.5** We can now see that all steps in the this ICS integration flow were successful because the arrow is green highlighting all the orchestration flow steps.

![](images/300/image033.png)

**1.3.6.6** Select the `Exit Instance` button to go back to the ICS monitoring page.

![](images/300/image034.png)

We are now done exploring the ICS monitoring features.

# Part 2: Use Integration Cloud Service to Modify an Integration

In this second part of the lab, we will change the *Create EBS Order* ICS integration in order to support the new requirement of adding a comment to the EBS order from the mobile application.  The following steps will be followed in this part of the lab:
1.	Clone an existing ICS integration
2.	Modify the integration to support the new comment field
3.	Update ICS tracking to include the comment
4.	Re-Activate and Test the updated orchestration
Let’s start by logging into ICS and cloning an existing integration.

## 2.1: Clone an existing integration

### **2.1.1:**	Open the ICS Design Console

---

**2.1.1.1** Open the ICS Service Console.  (Steps to do this were outlined in the first part of this lab when we were exploring ICS)

**2.1.1.2** Select the `Designer` tab on top of the ICS Service Console to go to the `ICS Designer Portal`.

**2.1.1.3** Select the `Integrations` icon

![](images/300/image035.png)

### **2.1.2:**	Clone the integration

---

**2.1.2.1** Click the `Hamburger` icon ![](images/300/image036.png)  just to the right of the *Create EBS Order* integration.

**2.1.2.2** Drop down to the `Clone` menu selection so we can make a working copy of the current working *Create EBS Order* integration.

![](images/300/image037.png)

**2.1.2.3** In the `Clone` dialog that comes up, enter the new name of the cloned integration.  Since there may be multiple participants in this lab, use your assigned user # as a prefix with *Create EBS Order* at the end.  In the following example, *demo.user01* was assigned so the name of the cloned integration is *User 01 Create EBS Order*

**2.1.2.4** After entering the name, select the `Clone` button in the lower-right of the dialog.

![](images/300/image038.png)

**2.1.2.5** You will now see that your new cloned integration is ready to edit as it’s in the `de-activated` state.

![](images/300/image039.png)

**2.1.2.6** Click on the integration name so that we can go to the integration editor.  In the image above `User 01 Create EBS Order` is the hot-link to select.

## 2.2: Edit the mapping to the EBS update service call

### **2.2.1:**	Navigate to the mapping *createEBSOrder*

---

**2.2.1.1** Since there are many steps in this orchestration style integration the text on each step may be difficult to read.  In order to quickly zoom-in, select the `Home` icon in the view control bar in the upper-right.

![](images/300/image040.png)

**2.2.1.2** The *createEBSOrder* mapping step we are going to change is toward the bottom of the orchestration.  As shown in the first part of the lab, by clicking and dragging your mouse in the background you can pan down the orchestration steps to the *createEBSOrder* mapping step.

![](images/300/image012l.png)

### **2.2.2:**	Open the mapping *createEBSOrder* for editing

---

**2.2.2.1** The *createEBSOrder* mapping orchestration step is just above the corresponding *createEBSOrder* API invocation.

**2.2.2.2** Click on the double arrow mapping symbol to pop-up the edit pencil.

**2.2.2.3** Click on the little pencil to edit the mapping.

![](images/300/image041.png)

### **2.2.3:**	Map the new *Comment* field

---

**2.2.3.1** Once the mapping is displayed, we need to expand the target node that we will map the inbound `Comment` field to.

**2.2.3.2** We are going to map `Comment` source to the target called `ATTRIBUTE1` which is in the `P_HEADER_REC` section of the Target payload.

**2.2.3.3** Select the little arrow icon ![](images/300/image042.png) just to the left of the `P_HEADER_REC` in the Target payload to expand it and expose `ATTRIBUTE1`.

![](images/300/image043.png)

**2.2.3.4** Now that the `ATTRIBUTE1` variable can be seen, we can map the `Comment` source variable to it by dragging the little circle just to the right of the `Comment` variable over to the `ATTRIBUTE1` circle.

**2.2.3.5** Click and hold on the circle just to the right of the `Comment` Source variable then drag it on top of the little circle just to the left of the `ATTRIBUTE1` Target variable.

![](images/300/image044.png)

**2.2.3.6** Release the mouse on the little circle just to the left of the `ATTRIBUTE1` Target variable.

![](images/300/image045.png)

**2.2.3.7** You will now be able to see the two variables mapped together by the green line connecting them.  Also note that the `Comment` field is shown as the mapping to the right of the `ATTRIBUTE1` variable.

![](images/300/image046.png)

**2.2.3.8** Now we need to select the `Save` button in the upper right to save our mapping changes

![](images/300/image047.png)

### **2.2.4:**	Testing the Updated Mapping

---

**2.2.4.1** ICS has a built-in test harness so that you can see if the changes you made to your mapping actually work.

**2.2.4.2** First, select the `Test` button just below the `Save` button just pressed.

![](images/300/image048.png)

**2.2.4.3** Next, select the `Generate Inputs` button in the upper-right of the testing window.

![](images/300/image049.png)

**2.2.4.4** We want to put some interesting comment in the input `<ns0:Comment>` element in the `Input: createOrderRequest` incoming payload.

**2.2.4.5** Edit the data in the generated inbound payload to something custom.  In this example it was set to *This is my Comment!*

![](images/300/image050.png)

**2.2.4.6** Now that the input data is ready, select the `Execute` button in the upper-right of the test window.

![](images/300/image051.png)

**2.2.4.7** The mapping will be applied to the generated input data and the result will be shown in the `Output: PROCESS_ORDER_Input` section on the right side of the test window.

**2.2.4.8** Look for your custom comment and note that it has been mapped to the `P_HEADER_REC` -> `ATTRIBUTE1` element.

![](images/300/image052.png)

**2.2.4.9** Now that we have seen that our mapping has been successfully modified, we can close the test window.

**2.2.4.10** Select the `Close` button in the lower-right of the test window.

![](images/300/image053.png)

**2.2.4.11** Now we can close the Mapping Editor because our changes have been made and tested.

**2.2.4.12** Click on the `Exit Mapper` button in the upper-left of the Mapping Editor.

![](images/300/image054.png)

**2.2.4.13** Save your changes made to the cloned integration by pushing the `Save` button in the upper-right of the integration.

![](images/300/image055.png)

## 2.3: Add Tracking to the Integration

### **2.3.1:**	Open the “Tracking” editor

---

**2.3.1.1** We want to add the *Comment* we just mapped as a `Business Identifier`.  Business Identifiers enable runtime tracking on messages.  These identifiers will be saved in ICS’s monitoring tab for each instance of the integration that is run.

**2.3.1.2** Click on the `Tracking` button next to the *Save* button to bring up the business identifier editor.

![](images/300/image056.png)

### **2.3.2:**	Add a “Business Identifier”

---

**2.3.2.1** The `Business Identifiers For Tracking` editor will be opened up

![](images/300/image057.png)

**2.3.2.2** Click on the *Comment* variable in the Source variable section.  The editor will show the metadata for this variable such as type, path, etc.

**2.3.2.3** Next, click on the `Shuttle Icon` to move the *Comment* variable over to be a new `Tracking Field`.

_(Note that you can also click and drag variables from the Source to the Tracking Field instead of using the shuttle icon)_

![](images/300/image058.png)

**2.3.2.4** Observe that the *Comment* variable has now been added as a `Tracking Field`.  The source variable name is also added as the `Tracking Name` by default – since *Comment* means something and is suitable for people to read in the monitoring tab we’ll keep it. If the comment variable was something random like *C2EF*, we would want to change it and give it a human-readable tracking name.

**2.3.2.5** Select the `Done` button now that the new `Business Identifier` has been added.

![](images/300/image059.png)

**2.3.2.6** Once again, click on the `Save` button to save the tracking changes.

![](images/300/image060.png)

**2.3.2.7** All modifications have now been made to the cloned integration.

**2.3.2.8** Select the `Exit Integration` button to go back to the ICS Designer Portal.

![](images/300/image061.png)

## 2.4: Activate Changes to the Integration

### **2.4.1:**	Select the “Activate” switch

---

**2.4.1.1** Click on the *Activate* switch/slider on the right of the cloned `Create EBS Order` integration.

![](images/300/image062.png)

**2.4.1.2** The `Activate Integration?` dialog will be displayed

**2.4.1.3** Select the *Enable tracing* button since this isn’t a production deployment.  This checkbox will tell ICS that the payloads for each instance of the integration will be saved in the logfiles as explored in the first part of this lab earlier.

**2.4.1.4** Now select the *Activate* button to begin activation of the integration.

![](images/300/image063.png)

**2.4.1.5** The progress bar of the integration activation will move across the `Activate Integration?` dialog box.

![](images/300/image064.png)

**2.4.1.6** Once the integration is activated you will see that the activation slider now is colored green with a checkmark in it.

**2.4.1.7** A message will appear on the top of the ICS Designer Portal indicating that the integration activation was successful.  The WSDL for the service endpoint will also be displayed.

![](images/300/image065.png)

### **2.4.2:**	Check the Service Endpoint

---

**2.4.2.1** Click on the WSDL link so we can ensure that this integration has an available service endpoint.

![](images/300/image066.png)

**2.4.2.2** The WSDL for you new ICS integration will now be displayed in your browser.

![](images/300/image067.png)

**2.4.2.3** Now that we have a modified integration with a new service endpoint, we need to update PCS so that the comment sent in from the mobile application can be passed through ICS into EBS.

# Part 3: Testing the New ICS Integration from PCS

Now that we have a new ICS integration mapping the *Comment* field to the EBS order, we need to update the PCS process with the new ICS endpoint.
Using the PCS Process from the previous lab we’ll now go through the steps necessary to do this.

### **3.1:**	Update PCS Process with the New ICS Service

---

**3.1.1** First, get back into the PCS Composer and open up the PCS process you created in Lab 200 by clicking on the PCS Application name.

- In the screenshot below, we are using the process created with user `demo.user03`:

![](images/300/image068.png)

**3.1.2** Open up the *Quote to Order Process* process by clicking on it:

![](images/300/image069.png)

**3.1.3** Ensure that the process is in *Edit* mode by selecting the pencil icon in the top middle of the editor window.  If the process is not in edit mode, it will be shown in *Viewing* mode as shown below:

![](images/300/image070.png)

**3.1.4** Pan over to the *Capture Order* service call, click on that activity and then select the *Open Properties*:

![](images/300/image071.png)

**3.1.5** Edit the service call by clicking on the small pencil icon on the right of the *Service Call* dropbox.

![](images/300/image072.png)

**3.1.6** Select the `Plus` (`+`) icon to the right of the ICS integration endpoint:

![](images/300/image073.png)

**3.1.7** Now select the new ICS integration that was created in the previous part of this lab, then select the *Next* button.  In the screenshot below, the integration for the *demo.user03* user is shown:

![](images/300/image074.png)

**3.1.8** In the Advanced service configuration dialog, select *APP Id – Username Token* for the Security.

**3.1.9** Select *[New Key]* for the Keystore Credential and give it a name that matches the user you have been given for the lab… something like *demo.user03.key*

**3.1.10** Input the username/password given to you for the workshop.  In the screenshot below, the user *demo.user03* is shown.

**3.1.11** After inputting all this info, click on the *Create* button:

![](images/300/image075.png)

**3.1.12** Select the *OK* button back in the *Configuration* dialog:

![](images/300/image076.png)

**3.1.13** Collapse the properties window at the bottom of the PCS Composer by selecting the small down-arrow at the right hand side of the properties section:

![](images/300/image077.png)

**3.1.14** Save the changes made to the PCS process by clicking on the diskette icon in the middle of the top blue header bar:

![](images/300/image081.png)

You are now ready to publish and deploy your changes

### **3.2:**	Deploy the Updated PCS Process

---

**3.2.1** The first step in deploying is to publish the process.

**3.2.2** Select the little *globe + arrow* icon in the middle of the top blue header bar:

![](images/300/image082.png)

**3.2.3** Select the *Make Snapshot* checkbox and enter the comment *Added New ICS Service Endpoint*.  Add the same comment to the free-form textarea at the bottom of the *Publish Application* dialog.

**3.2.4** After making these changes, select the *Publish* button on the bottom of the dialog:

![](images/300/image083.png)

**3.2.5** After the application has been published, it needs to be deployed.

**3.2.6** Select the *Management* link in the top right of the PCS Composer screen:

![](images/300/image084.png)

**3.2.7** If this is the first time you've published in this browser session, you may be prompted to login with your username/password for publishing.  If this is the case, enter your assigned username/password (ie: `demo.userXX`)

![](images/200/Picture55a.png)

**3.2.8** In the upper left side of the PCS Management window, click on the `hamburger` icon then select the *Deploy* menu item:

![](images/300/image085.png)

**3.2.9** Select your *Touch the Cloud* Space in the *Select Space* dropdown

**3.2.10** Select your PCS application *Quote to Order – UserXX* in the *Select Application* dropdown (where `XX` is your workshop user number, ie: 01, 02, etc.)

**3.2.11** Select your snapshot name in the *Select a snapshot* dropdown. In the example below, the snapshot was given the name *Added New ICS Service Endpoint*

**3.2.12** After you have configured the application in the *Deploy Application to My Server* dialog, select the *Customize* button.

![](images/300/image086.png)

**3.2.13** Select the *Use design-time credentials and certificates* checkbox in the upper right of the *Customize* page of the wizard.

**3.2.14** In the *Keystore Credential* dropdown box, select the security key created during design time.  In the example shown below, we created the key called *demo.user03.key*.

**3.2.15** The username/password will automatically be filled in based on the key which was already created during design time.

**3.2.16** After customizing the new service call, select the *Validate* button:

![](images/300/image087.png)

**3.2.17** After the validation is shown to be successful, select the *Options* button:

![](images/300/image088.png)

**3.2.18** Enter the id *1.0* in the *Revision id* textbox (we'll be overwriting the version currently deployed because we don't need two out there)

**3.2.19** Select the *Override* checkbox

**3.2.20** Select the *Force default* checkbox

**3.2.21** Finally, select the *Deploy* button

![](images/300/image089.png)

**3.2.22** The *Deploying* modal-dialog will pop-up and spin while this new revision is deployed.  This could take about a minute depending on how many other participants are deploying at the same time.

![](images/300/image090.png)

**3.2.23** Select the *Finish* button once the application deployment is complete

![](images/300/image091.png)

The updated PCS application is now ready to test

### **3.3:**	Test the Updated End-to-End Application Using MAX Mobile Application

---

**3.3.1** Login to the Mobile Cloud Service (MCS) Console as described in Lab 100 using your assigned username (ie: demo.userXX).

**3.3.2** Once you have logged into MCS, click on the **hamburger menu** in the upper left of the screen.

![](images/300/image092.png)

**3.3.3** Select the **Applications** link in the left-hand navigation - this will bring up a bunch of colorful icons in the main window for various MCS capabilities.

![](images/300/image093.png)

**3.3.4** Click on the **Mobile Apps** icon to launch the MAX application editor

![](images/300/image094.png)

**3.3.5** Select the mobile application you developed in Lab 100, labeled with your assigned user number.  In the screenshot below, `TTC_APP_03` is selected because the user was assigned **demo.user03** as their username.

![](images/300/image095.png)

**3.3.6** The mobile application will be displayed with a map of the "Customers".

**3.3.7** Select the **Test** button in the upper right to launch the mobile phone simulator.

![](images/300/image096.png)

**3.3.8** Login with the test user's credentials.  Note that if you have previously logged in with the **Save test user** checkbox selected you may not be prompted to login again.

Remember that this mobile application is for a sales rep that is checking for his list of customers to visit in his area from whom he can take quotes for computer equipment orders.

- **Username**: `maxtester`
- **Password**: `W3lcome1*`
- **Save test user**: check the box so you will only have to login once for the simulator per browser session

**3.3.9** Click on the **Sign In** button

![](images/300/image097.png)

**3.3.10** Click on one of the orange dots representing a customer visit that the sales rep will be making.

![](images/300/image098.png)

**3.3.11** In the screenshot below, the customer selected is _Bigmart_.  You can see their address and the main contact's information.

**3.3.12** After the sales rep has had a discussion with his contact, Paul Pub, he needs to order them one `Sentinel Standard Desktop - Rugged` because it is needed in the warehouse where conditions are rough.  

**3.3.13** Click on the elipses in the upper right of the mobile application to initiate creating a quote.

![](images/300/image099.png)

**3.3.14** Select the **Create Quote Line** menu item

![](images/300/image100.png)

**3.3.15** Click on the pulldown on the right side of the `ItemDescription` item and select `Sentinel Standard Desktop - Rugged` from the pulldown menu.

![](images/300/image101.png)

**3.3.16** Fill in the rest of the quote line with the following information:

  * **Price** = *13000*  (We want this to be above $10000 so it trigger Sales Director approval in the PCS workflow)
  * **Qty** = *1*
  * **UOM** = *Each*

**3.3.17** After finishing filling out the information for the quote line, select the **Save** button in the upper right of the mobile app

![](images/300/image102.png)

**3.3.18** Select `Quote Lines` tab in the **Customer Summary** page to see the quote line just saved

![](images/300/image111.png)

**3.3.19** You can now submit the quote.  Select the elipses in the upper right of the mobile app.

**3.3.20** Select `Submit Quote` from the menu list.

**3.3.21** Wait for 5-10 seconds while the mobile application creates a process instance in PCS and initiates the approval workflow with the quote just created on the mobile application.

![](images/300/image112.png)

Now we will check in PCS to ensure that the process workflow was initiated.
	
### **3.4:**	Ensure the Mobile Application created the PCS Workflow Instance

---

**3.4.1** Navigate back to the PCS Composer window from section 3.2 of this lab

**3.4.2** Select the `PCS Home` icon on the upper right of the PCS Management window

![](images/300/image113.png)

**3.4.3** Select the Tasks button on the top of the PCS Workspace

![](images/300/image114.png)

**3.4.4** First, the quote needs to be approved by the "Sales Operations" role.  In Lab 200, we had added our user (`demo.userXX`) to all 3 of the roles in our PCS process: "Sales Operations", "Sales Manager", and "Sales Director".

Click on the task so we can see the approval form.

![](images/300/image121.png)

**3.4.5** The Quote form will be shown so you can review that the data from the mobile application came through.  Note the _Account Name_ and _Price_ match what you put into the mobile application.

**3.4.6** After reviewing the quote, select the **Approve** button to send this process further down the workflow.

![](images/300/image122.png)

**3.4.7** The previous task (Sales Operations Approval) will disappear from the tasklist.  Click on the **Refresh** icon in order to update the tasklist.  

![](images/300/image123.png)

**3.4.8** Since this order was more than $10000, it will have been routed to the Sales Director role in the PCS process.

**3.4.9** Since you have "Sales Director" role, you should see another task show up in the tasklist for a secondary large quote order approval.

![](images/300/image124.png)

**3.4.10** Just like you did as "Sales Operations", the Quote form will be shown so you can review that the data from the previous approval came through.

**3.4.11** After reviewing the quote, select the **Approve** button to send this quote over to EBS to create an order.

![](images/300/image125.png)

**3.4.12** This was the last approval needed in the process so you won’t see any more tasks for that process showing up in the tasklist.

**3.4.13** Select the **Tracking** icon on the top of the PCS Workspace so we can see the details of the entire process just completed.

![](images/300/image117.png)

**3.4.14** Select the **Completed** checkbox - by default because only the `In Progress`, `Suspended`, and `Completed` are shown by default.

![](images/300/image118.png)

**3.4.15** Look near the top of the list for your process instance since it was just executed.

**3.4.16** Select the arrow at the right of the instance to see the details:

![](images/300/image119.png)

**3.4.17** Select the chevron icon just to the right of the History section so you can see a graphical representation of the process history. The green line highlights the path that the process took.

![](images/300/image120.png)

**3.4.18** Select the **Maximize Instance Details** button in the upper right so we can see the entire process flow graph

![](images/300/image126.png)

**3.4.19** Observe the entire PCS process flow.  Note again that the _green highlighted lines_ indicate the path of the successful process flow.

![](images/300/image127.png)

Now we want to be sure that the callout made by PCS to ICS worked and that the payload for creating the new order was sent to EBS.

### **3.5:**	Ensure that PCS called the new ICS Integration

---

**3.5.1** Login to ICS and visit the *Monitoring* window

![](images/300/image103.png)

**3.5.2** Select “Tracking” from the left-hand navigation

![](images/300/image104.png)

**3.5.3** Select your ICS integration name from the tracking list – this will probably be the first one in the list

![](images/300/image105.png)

**3.5.4** Select the *Business Identifiers* icon on the upper right of the integration and make sure that the comment was sent over to ICS from PCS - this comment was the `mcs_id` variable from the MCS API which should be `UserXX` where XX is your user number.

![](images/300/image106.png)

### **3.6:**	Verify the Order was Created in EBS

---

**3.6.1** Login to EBS using the endpoint and credentials provided to you by the workshop organizer.  You will use the user *operations*.

- *NOTE:* For the EBS instance used in this workshop, the Oracle Single Sign-On system is used to regulate access.  Unless individual users are explicitly added to have access to the EBS system, they will not be able to access the following EBS login page.  If you can't access the login page with your Oracle SSO login, then you can look at the following screenshots to see how you would be able to see your Order in an EBS R12.2 system.

![](images/300/image107.png)

**3.6.2** Select the EBS Responsibility *Order Management, HTML User Interface*:

![](images/300/image108.png)

**3.6.3** Examine the list in the *Open Orders* report and verify that your new order shows up in the list.

Note that the _Order Amount_ shown is larger than that of the quote because of shipping costs and taxes that were added automatically by EBS .

![](images/300/image109.png)

You now have used Oracle Integration Cloud Service to explore and modify an integration to Oracle EBS. 

This Lab is now completed.
