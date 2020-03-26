# Demo Introduction

## Keywords:
```
Oracle Integration Cloud Service, Oracle Storage Cloud Service
```

![](https://cdn.app.compendium.com/uploads/user/e7c690e8-6ff9-102a-ac6d-e4aebca50425/f4a5b21d-66fa-4885-92bf-c4e81c06d916/Image/55d948c4e07007e169299a02b4dfe6db/construction.png) -- This lab (Integration Cloud Service) is under construction and a new version is in the works.  The instructions currently listed below may be **inaccurate** or **incomplete**.


## Goal of Demo:

To demonstrate how easily it is to leverage Oracle Integration Cloud Service and build integrations to pull Twitter feeds which the user cares about and store the data into Data Lake in Oracle Storage Cloud.

## Pre-requisites: 

* User has registered both Oracle Integration Cloud Service and Oracle Storage Cloud Service.
* The storage containers for the demo have been configured properly.
* User already has a Twitter account.

# Demo Steps

## Step 1: Create an Application in Twitter

This step will create an application in Twitter. However it is actually not an application running in Twitter. Instead it is for allocating OAuth 1.0 credentials for a remote application which can request Twitter services, for example retrieving feeds, creating Twitter message etc.

To create an application in Twitter, open a browser and access the Twitter Application Management System with the URL <https://apps.twitter.com/>.  After a successful login with your Twitter account, you will see following Application Management page:

![](./images/200/picture200-1-1.png)

Click the **Create New App** button to load the page below to create a new application.

![](images/200/picture200-1-2.png) 

The **Name** of the application must be unique among all users in Twitter. You may want to add a user-specific prefix to the name. The **Website** of the application must start with a protocol, either http or https in the demo. **Callback URL** is only necessary if the application needs to request Twitter services as some other accounts. In the Oracle Integration Cloud Service, it only allows you to use the same account, so you can leave the field empty.

After reading and accepting the _Twitter Developer Agreement_, click **Create your Twitter application** button at bottom.

When the application is created, the following application page will appear. You can review general information of the application. But the most critical information we need in the Oracle Integration Cloud Service is OAuth 1.0 credentials.

![](images/200/picture200-1-3.png) 

Select the **Keys and Access Tokens** tab in the page. By default, only Consumer Key & Secret are generated. In this demo, we also need to allocate an Access Token to access Twitter services from the application.

![](images/200/picture200-1-4.png) 

Click the **Create my access token** button in the Token Actions section to generate the required credentials.

Keep the values "Consumer Key/Secret" and "Access Token/Secret" pairs confidential for configuring connections to Twitter with Oracle Cloud Integration Service.

## Step 2 : Configure Connections in Oracle Integration Cloud Service

Oracle Integration Cloud Service can leverage built-in adapters to connect various kinds of external services. In this step, we will configure connections to Twitter and Oracle Storage Cloud Services.

You need to first login to Oracle Cloud to configure Oracle Integration Cloud Service. Open a browser, and then enter the URL of [Oracle Cloud](https://cloud.oracle.com/home). Click the **Sign In** link along the top of the Oracle page to access following page:

![](images/200/picture200-2.0-1.png) 

Oracle Cloud will leverage data center infrastructure in different spots across the world.  After registering to Oracle Cloud, customers can request services from the data center near their location to get better performance.

When logged into Oracle Cloud, customers need to first select the data center where their services have been deployed.

An Identity Domain is the container where accounts and Cloud Services are provisioned.  Customers must enter the correct Identity Domain to login and access their services. In this demo, the user should select the Identity Domain where Oracle Integration Service is provisioned.  This will be provided by the instructor if you do not know it.

![](images/200/picture200-2.0-2.png) 

Then, credential information needs to be input to login to Oracle Cloud platform. 

![](images/200/picture200-2.0-3.png) 

After login to Oracle Cloud, the user can view and access cloud services from following page.

![](images/200/picture200-2.0-4.png) 

Select the **Integration** catalog link on this Dashboard to jump to the following Oracle Integration Service page.

![](images/200/picture200-2.0-5.png) 

From the **Overview** section (this is selected by default), the user can view current instances of Oracle Integration Cloud Service.
Integrations are configured and deployed in separate service instances.

Click **Open Service Console** link of the service instance where connections and integrations can be configured. Integration Service Console will display as below:

![](images/200/picture200-2.0-6.png) 

**2.1 Configure connection to Twitter**

Click Create Connections in the Console to load the Connection Designer page:

![](images/200/picture200-2.1-1.png) 

Click **New Connection** action in the page.  The following Wizard will appear to let you first select from pre-built adapters.

![](images/200/picture200-2.1-2.png) 

Scrolling down to the bottom of the list you can find the **Twitter** adapter, click the **Select** button to confirm your selection. A Twitter dialog will pop up to input your Twitter connection configuration information.  

![](images/200/picture200-2.1-3.png) 

To allow a request service to Twitter, specify a **Name** of the connection, and select the value **Invoke** for the **Role**. Click the **Create** button to create the connection.

After the connection is successfully created, you can see a light-green banner on top of the page. Next you need to configure parameters of the connection.

![](images/200/picture200-2.1-4.png) 

Click the **Configure Security** button half way down on the right side of the page.  The following dialog will appear to let you input
credential information to establish the Twitter connection.

![](images/200/picture200-2.1-5.png) 

All credential information used in this dialog is from previous step. You can copy those parameters from the Twitter Application Management page directly. After filling in all required fields, click the **OK** button.

Once all required parameters have been configured for the Twitter connection click the **Test** action on top of the page to trigger a test. If the
test passed, a message will display in the light-green banner. Also the progress icon on the right will indicate that the connection is 100 percent correct.

After test is done, you can save the connection by clicking **Save** action. Then click **Exit Connection** action to go back to Connection Designer page.

![](images/200/picture200-2.1-6.png) 

**2.2 Configure connection to Oracle Storage Cloud Service**

In the Connection Designer page, click **New Connection** action to launch the Adapter Selection dialog. Oracle Integration Service does not provide a built-in adapter for Oracle Storage Cloud Service, however the user can leverage generic REST adapter to access REST API endpoint of
the Oracle Storage Cloud.

In the search box of the dialog, input â€œRESTâ€ then click the search icon, the REST adapter will be the only available adapter in the list.

![](images/200/picture200-2.2-1.png) 

Click the **Select** action in the REST adapter.  The connection design page will let you configure the connection to Oracle Storage Cloud Service.

![](images/200/picture200-2.2-2.png) 

Specify the **Name** of the connection and select **Trigger and Invoke** for the **Role**.  This means that the connection can both receive notification from Oracle Storage Cloud when Object Store is changed and make requests to the Oracle Storage Service. Click the **Create** button to create the
connection.

Next, we need to input the connection parameters to REST API endpoint of the Oracle Storage Cloud. Click the **Configure Connectivity** button in the page to launch following dialog.

![](images/200/picture200-2.2-3.png) 

Set **Connection Type** to "REST API Base URL", set **TLS Version** to "TLS V1.1" and copy the base URL (without URI part) of the REST API endpoint of the Storage Cloud to the **Connection URL** field. Click **OK** to close the dialog.

The last parameters that need to be configured are the security information to login to REST API endpoint of the Storage Cloud. Click **Configure Security** button in the page to launch following dialog.

![](images/200/picture200-2.2-4.png) 

All the information in this dialog can be known from the Oracle Storage Cloud configuration.  Format of the **Username** field is "Storage-\<Identity Domain>:\<login name>".

After specifying all required information, click **OK** to close the dialog.  Now all the required parameters have been configured for the Oracle Storage Cloud connection.  A test is also required to ensure the configuration is correct. After the test is done, click **Save** action to save the connection, and then click **Exit Connection** action to return to Connection Design page.

## Step 3 : Design the Integration

In this step, we will demonstrate how to design integrations with Oracle Integration Cloud Service to load Twitter feeds that the user is interested in and pull the data into Data Lake in Oracle Storage Cloud.

Oracle Integration Cloud Service provides an interactive tool for designing integrations with zero coding. The tool is available from the Designer Portal in Oracle Integration Cloud Service. To go to Designer Portal, select **Designer** link on top of the Oracle Integration Cloud Service page.

![](images/200/picture200-3-1.png) 

From the Designer Portal the user can go directly to various designer tools, for example Integration Designer, Connection Designer etc., in Oracle Integration Cloud Service. Click **Integrations** icon to launch following Integration Designer.

![](images/200/picture200-3-2.png) 

User can manage and monitor integrations in the designer page. To create a new integration, click the **New Integration** button on the top. Oracle Integration Cloud Service has pre-defined styles or patterns to design the integration.

![](images/200/picture200-3-3.png) 

In this demo, the integration is complex. It needs to handle connections to both Twitter and Oracle Storage Cloud carefully. The User also needs to control data ingestion, transform and output at fine-grained level.

Select the **Orchestration** pattern for the integration.  The following dialog will pop up to allow the user provide general information of the integration.

Name, version and an optional package are used to uniquely identify the integration. An integration could be triggered either by an event from a service connection or a schedule defined by Oracle Integration platform.

![](images/200/picture200-3-4.png) 

Select Schedule as the trigger for the integration, and specify name, version and package for the integration, then click the **Create** button.

The following Designer page will appear to give the user an interactive interface to design logic of the integration. On the left of the page are popup toolboxes. User can **Invoke** an available services, add an **Action** and handle **Error** in the integration. In the middle of the page are panels to view and edit the integration interactively. If the integration logic is very complex, the user can also zoom and go to a different part of the view with UI controls in the page.

![](images/200/picture200-3-5.png) 

Initially, there is only a start and end node in the integration design page. The User needs to add more logic to the integration.

In the demo, the user will first invoke Twitter to retrieve any new feeds. Move the mouse to the **INVOKES** tab on the left, which will pop up a toolbox to let the user select available services. Select the Twitter catalog.  All Twitter service connections will show just below the catalog.

![](images/200/picture200-3-6.png) 

Drag the connection in between start and end node of the flow in the design panel.

![](images/200/picture200-3-7.png)

The following wizard will appear to let the user customize the service invocation. The **Basic Info** tab lets the user assign a name of the invocation. The name will show as the display name of the invocation node in the design panel.

![](images/200/picture200-3-8.png) 

After filling the required information, click the **Next** button to move to following page. In this page the user can select which service function needs to be invoked from the integration.

![](images/200/picture200-3-9.png) 

Select "**Search tweets**" from the function list, then click the **Next** button to move to following page. This page will show overview information of the invocation. The User has the opportunity to check the configuration.  If anything is wrong, they can go back to previous page to make modifications.

![](images/200/picture200-3-10.png) 

Click **Done** to accept the configuration. A new invocation node will appear in the design panel. However it is not done yet, the user also needs to customize parameters of the invocation.  Click the invocation node, a pop up toolbox will appear.

![](images/200/picture200-3-11.png) 

Click ![](images/200/picture200-3-11a.png) the pencil button in the toolbox to launch the following dialog to map invocation parameters.  Available parameters of the service call are listed on the right. The user can design mapping for each individual parameter. A mapping is the way to assign runtime value of the target of existing sources. The source could be a static value, data from an available data source etc. Click a parameter in the list can modify the mapping.

![](images/200/picture200-3-12.png) 

The first parameter that needs to be customized in the demo is **q**. Click the parameter will launch another dialog to design the mapping. The user can select an entity from a source on the left, and drag it to link with the target. Also the user can assign a fixed value to the target.

![](images/200/picture200-3-13.png) 

In this demo, the parameter will use a fixed value which indicates search tweets by a specific tag.

Click the target directly, a text box will appear to let you input the value. Input name of the interested tag in the tweets. You should encode the string according to XML standard.

Click the **Save** button on the top to apply the change, then click the **Close** button to return to the previous dialog.

![](images/200/picture200-3-14.png) 

Another parameter that needs to be customized is **result_type**. Use a fixed value of "recent" for this parameter to only retrieve new tweets from the user's Twitter account.

After both parameters are customized, the user can view the configuration in the dialog. If properly configured, click **Exit Mapper** button to save the change.

![](images/200/picture200-3-15.png) 

Now the integration can invoke Twitter to retrieve interested tweets from user's account.  The next step is to enable writing those tweets to Data Lake in Oracle Storage Cloud. Services from the Oracle Storage Cloud can be leveraged to implement the function.

The integration will first authenticate to the Oracle Storage Cloud to retrieve a security token for following requests. Select pre-defined Oracle Storage Cloud connection from the **INVOKES** pop up toolbox on the left. Then drag the connection to the position between the Twitter node and the end node in the flow.

![](images/200/picture200-3-16.png) 

The following dialog will appear to configure the service invocation. The REST service endpoint at Oracle Storage Cloud is a HTTP service. The authentication process is wrapped in HTTP communication. Credential information is wrapped in a HTTP GET request, the server returns authentication result in the HTTP response.

![](images/200/picture200-3-17.png)

Specify the relative URI of the authentication service at the Oracle Storage Cloud, it is _/auth/v1.0_ in this demo. Select to use GET method to send HTTP request. Customization need to be enabled for both preparing Request headers and analyzing Response headers.

Click the **Next** button to move to the following page. The page allows the user to configure HTTP headers that are specific to the authentication process. Click ![](images/200/picture200-3-18a.png) the PLUS button to add a new header declaration. A name must be given in left column and an optional description in the right column.

![](images/200/picture200-3-18.png)

Two headers, **X-Storage-User** and **X-Storage-Pass** are defined. They wrap username and password for authentication respectively.

After declaring both request headers, click the **Next** button to move to following page. This page will declare response headers specific to the authentication process.

![](images/200/Twitter40.png)

The response header **X-Auth-Token** is pre-defined to wrap the token if authentication succeeds.

After declaring the header click **Next** to move to the following page. User can check the configuration in the page. If all configurations are correct, click the **Done** button to commit the configuration.

![](images/200/Twitter41.png)

Next, we will provide value for parameters (request headers) in the request. Select the invocation node and click the button in the pop up toolbox to launch the Mapper dialog.

![](images/200/Twitter42.png)

Click each HTTP header declared previously. In the demo, we will use static value for both headers. Values for both headers are from Oracle Storage Cloud configuration. Format for 

X-Storage-User is  "Storage-\<identity domain\>:\<login name\>".

![](images/200/Twitter43.png)
![](images/200/Twitter44.png)
![](images/200/Twitter45.png)

After committing the values, click the **Exit Mapper** button to return to the Integration Designer. The next action in the integration flow is to write data to Oracle Storage Cloud.

![](images/200/Twitter46.png)

Select the Oracle Storage Cloud connection from the **INVOKES** toolbox, and drag it between authentication result node and end node in the flow. The following dialog appears again to configure REST invocation.

![](images/200/Twitter47.png)

The URI for the data object upload service in Oracle Storage Cloud is in the format:
/v1/Storage-\<Identity Domain\>/\<Container\>/\<Object Name\>. The service leverages HTTP PUT method to upload the data object. Content of the data object is sent as payload in a HTTP request. The **X-Auth-Token** header must be included in the HTTP request as the authentication proof to the service.

To enable the integration flow to control data object name at runtime, we use the template /v1/Storage-\<Identity Domain\>/\<Container\>/{Object Name} for the service URL. The container must be created in advance before the demo.

Select **PUT** as the request method, and check **Configure a request payload for this endpoint** to enable payload customization. Also you need to enable request header customization in order to append the **X-Auth-Token** header in the request.

Click the **Next** button to move to following page. The user can add additional query parameters for the URI.

![](images/200/Twitter48.png)

However, there is no query parameter defined for the service. So simply click the **Next** button to move to the following page.

In this page, the user needs to customize format of the payload. First, the user needs to select the type of the payload. For different payload types, there are different ways to describe the format. For example, the user can select an XSD schema file as the format for a XML-based payload. The Integration Platform will parse the format selected in the page to build data object at runtime.

In the demo, payload of the request is in XML format. A XSD schema file has been created to describe the XML document architecture.

![](images/200/Twitter49.png)

Select XML as type of payload and also upload the XSD schema file. Then click the **Next** button to go to the following page.

![](images/200/Twitter50.png)

Add **X-Auth-Token** as a required HTTP header in the request. The exact value of the header will map the security token returned from the previous step.

Click the **Next** button to go to the **Summary** page to check your configuration. If everything looks OK, click **Done** button to commit the invocation.

![](images/200/Twitter51.png)

Next, we will customize mapping for parameters in the invocation. Click invocation node in the flow and click button in the pop up toolbox to launch following Mapper dialog.

The first parameter is **X-Auth-Token** header in the HTTP request. The value for the request header should be identical as the token returned from the authentication action.

![](images/200/Twitter52.png)

The result of invocation to authenticate to Oracle Storage Cloud is a source in the left column.  Collapse the source to find the custom response header **X-Auth-Token**, and then drag it to the **X-Auth-Token** header as the target in the right. A link is established between the source and target as below.

![](images/200/Twitter53.png)

The next parameter that must be customized is **objectName** in the URI template. It will denote the name of the data object in Oracle Storage Cloud. Click the parameter to launch following Mapping dialog.

![](images/200/Twitter54.png)

In the demo, current date will be used as name of the data object. To get value of current date, we will use pre-defined function in the Integration platform.

Function is a kind of Mapping Component which is defined to return a value. All available functions can be selected from Mapping Components catalog in the left.

![](images/200/Twitter55.png)

Select **Mapping Components** catalog in the left panel and locate the **current-date** function from the _Functions -> Date_ path. Drag the function to the target parameter on the right. The following page will indicate that the parameter will use the function to retrieve current date as name of the data object.
```
Click Save action, then click the Close button to save the mapping.
```
![](images/200/Twitter56.png)

The last parameter in the invocation is the payload in the request. In the demo, the payload will be generated from the result retrieved from Twitter previously. The result of that invocation is a XML document too. So the standard and easiest way is to transform the document into the payload with a XSL template.

To make the demo simpler, we use same schema for the payload as that for the retrieved tweets. The XSL template only needs to iterate elements in the source document and generate elements with the same name, with same number in the payload. All child elements are mapped one-to-one from source to target.

![](images/200/Twitter57.png)

The Mapper Designer supports creating a XSL template interactively. In the schema tree, an element that can repeat more than once is decorated with an icon ahead. Those elements are always starting point of the template design. In the demo, we will start from the **statuses** element. Clicking the element in the target schema tree will launch the following dialog.

![](images/200/Twitter58.png)

The transform process will iterate corresponding elements in the source document then generate elements in the target. To enable the iteration process, select the statement in the right panel, then click **Actions** button on the right-top of the dialog. The following menu will pop up.

![](images/200/Twitter59.png)
```
Select Insert Parent from the menu, an empty control is added as the parent.
```
![](images/200/Twitter60.png)

Next, you can add the iteration control to the parent statement. XSL Elements is a kind of Mapping Component in the tool. You can list available elements within **Mapping Components** catalog.

![](images/200/Twitter61.png)

The **for-each** element is designed to iterate elements in a XML document. You can find it under the **XSL Elements** node. Drag and drop it onto the parent. The empty parent will be replaced by **for-each** element.

![](images/200/Twitter62.png)

The **for-each** element requires a **select** attribute to specify name of the elements in the source document. The user can map value of the attribute with an element in the schema of source document.

![](images/200/Twitter63.png)

Find the source document schema from the **Source** catalog, and then locate the element that will be transformed to the target document. In this demo, it is the element with identical name. Drag and drop the **statuses** element to the **select** attribute under the **for-each** element in the right panel.

![](images/200/Twitter64.png)

Click Save action on top of the dialog then click Close button and return to Mapper Designer page.  Next, we need to map child elements. Collapse the statuses element in the schema tree on both sides. All child elements are listed so that you can easily establish the map.

![](images/200/Twitter65.png)

The mapping rules used in this demo include:
```
1. Map the elements with identical name between source and target.
2. Only need to map those elements you want them appear in target document.
```

To implement those rules, user can simply drag selected child elements in the source to the elements with identical name in the target.

![](images/200/Twitter66.png)

When required element mappings are done, click **Save** action to keep your modification safe.  Then click **Exit Mapper** button and return to the Integration Designer.

![](images/200/Twitter67.png)

Now the integration flow is completed. The user can further customize tracking for the integration. Tracking is a mechanism of Oracle Integration Cloud Service to enable administrators to identify a running integration. Tracking record is composed of information or business identifier from the running integration.

Click **Tracking** action in the upper right to launch the following dialog to customize tracking for the integration. User can select up to three business identifiers available from the list in the left panel as tracking fields. One of them must be marked as primary tracking field.

![](images/200/Twitter68.png)

In this demo, we only rely on the time when the integration was launched to identify a running integration. Drag the schedule variable **startTime** from the left and drop it into Tracking Field column in the right, then click **Done** button in the dialog.

![](images/200/Twitter69.png)

Congratulations, you have done all design efforts for the integration. Click **Save** action in the Integration Designer to save your work then click **Exit Integration** button.

## Step 4: Activate the Integration

The integration is ready to run. In this step, we will demonstrate how to activate an integration and monitor it after execution.

**4.1 Activate an integration flow**

In the following page, find the integration we just created. You may notice that it is not activated yet.

![](images/200/Twitter70.png)

Click the button in the right of the integration and a menu as below will pop up. Select **Activate** item in the menu.

![](images/200/Twitter71.png)
```
The following dialog will appear to let the user control how the integration is activated.
```
![](images/200/Twitter72.png)

Click the **Activate and Schedule...** button to schedule the integration right now. Following designer gives the user additional control on the integration schedule.

![](images/200/Twitter73.png)

In this demo, we will customize **Frequency** of execution of the integration. From the drop-down menu you can see that the integration can be scheduled at fine-grained level.

![](images/200/Twitter74.png)

In this demo, select **Hours and Minutes** to schedule the integration repeatedly. Controls in the dialog as shown below let user customize the schedule.

![](images/200/Twitter75.png)

Increase the **hour(s)** field to 1 to schedule the integration every 1 hour. Click **Save** action in the upper right, then click **Exit Scheduler**. The following page will display and allow the user to review the schedule and decide when to submit the schedule.

![](images/200/Twitter76.png)
```
Click Submit Now button to schedule the integration immediately.
```
**4.2 Track and monitor an integration flow**

After the integration is scheduled, the user can track and monitor the integration through Oracle Integration Cloud Service. All monitoring functions are consolidated in the following monitoring page. The user can go to the page by clicking the **Monitoring** link on the top.

The dashboard in the page will give user an overview of the whole Integration Service instance from workloads to performance. The panel on the left is a quick navigation to different monitoring functions.

![](images/200/Twitter77.png)

Selecting **Integrations** from the left panel will show following Integration Monitoring page. In the page, user can see clearly statistics of execution history of integrations.

![](images/200/Twitter78.png)

Selecting **Tracking** from the left panel will show following Integration Tracking page. In the page, the user can see every scheduled execution of integrations. You may notice that the tracking fields you selected for integrations are displayed here. It helps users to uniquely identify an integration execution.

![](images/200/Twitter79.png)

Click an integration execution in the list will jump to the following page. The user can view the progress and state of the integration flow.

![](images/200/Twitter80.png)
