# Creating a Service

A service captures the end-point of the Service Implementation of your API.  You can create a service and manage grants to allow others to use it in their APIs as well as associate Service Accounts to it.

## Before you begin

- You have an API Platform environment.  See [environments](../../../environments/README.md) for details on procuring an API Platform environment.
- You should have a service end-point, either one that you have set up already, or you can complete the tutorial [Designing an API](../../design/design_api) which will provide you with a mock-service

## Creating the Service

### Log into API Platform Cloud Service

1. Point your browser to the management portal URL as described in your chosen environment.

> This URL is based on the [environment](../../../environments/README.md) that you have selected but it will take the form of `http(s)://<host>:<port>/apiplatform`

1. Log in as a user that has the *Service Manager* role.  

### Create a new Service

1. Make sure you are on the *Services* menu.  You should see *Services* in the upper left-hand side as well as a *Create Service* button on the right-hand side.  If you don't see this, select the menu button on the left and then select *Services*

1. Click the *Create Service* button

1. Provide a name such as _TicketServiceImpl_ and a version for your Service.  You can also provide a description.  
1. Choose your Service Type.
   1. If you are defining a REST service, choose REST.  You will notice both REST and HTTP, they operate the same at this point.
   1. If you are connecting to a SOAP service, make sure you have downloaded the **.wsdl** file.  When you select SOAP service, you will have the opportunity to upload the wsdl and choose the appropriate port type for your service.

1. Set the End-point name to identify your end-point (optional)
1. Enter the URL of the actual service implementation.  Note the following:
   1. When a request is received, API Platform will accept any resource and will append it onto the Service end-point to call the service.
   1. Bear in mind that if you add a resource to the service *Endpoint URL* that all requests will start with that resource and continue from there.  This could limit the available resources your consumers may access.

> If you are using a shared environment, your Service may already be created.  You can elect to modify the name such as add your initials so you know which Service is yours

Once your Service is created, you will see it in the list of Services.  You can click on the Service name to continue editing it.

#### Grant Access (optional)

Unless you want to restrict access to use your service to yourself as the creator or to the administrator(s), you will want to grant access to others.

After you have clicked on the service to edit it, select the *User Management* side-tab

You will notice that you already have the *Manage Service* grant

Click the *Reference Service* top-tab
Click *Add Grantee* button
Choose the *API Managers* group and click *Add*

What you have done here is granted access for any *API Manager* to be able to reference your service in your API.

You can grant users the ability to view, reference and manage as you see fit.

## Conclusion

In this tutorial you learned the following:

- How to create an Service in API Platform Cloud Service
- How to grant access to the service
  
### Next Steps

- You can either create an API, or choose an API you've already created and update the *Service Request* selecting your service.  See [Creating an API](../../apis/create_api) for more detail about the API

> Note, you will need the *API Managers* role to be able to create/update APIs.  If you do not already have this, make sure that you have access to a credential that has the *API Managers* role.