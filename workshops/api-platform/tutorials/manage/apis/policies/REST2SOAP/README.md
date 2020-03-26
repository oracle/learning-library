# REST2SOAP Policy

The REST to SOAP policy allows us to provide a REST front-end or API for a SOAP back-end Service.  This is a common use-case where we have a SOAP style service, but our clients need to be able to work in REST.  This tutorial will guide you through the process of creating a REST API for a SOAP Service.

> Note: Your service will need to be a SOAP service.  If you have one already, you can use that.  For our tutorial, we will just use a simple [Calculator Service](http://www.dneonline.com/calculator.asmx) that is publicly available.  Using this service, we can practice some basic concepts.  You can visit the [Calculator Service](http://www.dneonline.com/calculator.asmx) and download the **.wsdl** file which you will use in this tutorial.

## Before you begin

- You have an API Platform environment.  See [environments](../../../../environments/README.md) for details on procuring an API Platform environment.
- You have completed both the [Creating a Service](../../services/create_service/README.md) and [Creating an API](../../../apis/create_api/README.md) tutorials and are comfortable with creating services and APIs.

## Creating an API that provides a REST API for a SOAP Service

### Registering the SOAP Service
As you learned in the [Creating a Service](../../services/create_service/README.md) tutorial, we can register a service implementation end-point for use in one or more APIs.  Unlike REST implementations, we must register a SOAP service before it can be used in an API because we need to associate the **.wsdl** for use with the service.

- Register your service as follows:
  - Name the service *CalculatorService*
  - Give it whatever version and description you like
  - Choose the type as *SOAP*
  - Choose the **.wsdl** you downloaded from [Calculator Service](http://www.dneonline.com/calculator.asmx)

> Note: If you need a refresher on creating a service, refer to the [Creating a Service](../../services/create_service/README.md) tutorial

### Creating the Calculator API

Now we will create the API Implementation that will provide the REST interface for the SOAP Service.

- Create your API as follows:
  - Name the API *Calculator*
  - Give it whatever version and description you like.
    - If you have the *Plan Manager* role, you may see the option to create a plan which you can ignore.
- After creating the API set the *API Request* and *Service Request* as follows
  - API Request: Set the end-point to *calc*
  - Service Request: Select the SOAP Service you created in [Registering the SOAP Service](registering-the-soap-service)

### Adding the REST API to SOAP Service Policy

For this exercise, we will pretend that the requirements of our clients is to provide a service that accepts parameters *a* and *b* (two numbers).  The service needs to accept the operation as a resource.  For example to add two numbers, the client would call the api as `http(s)://MyGatewayIP/calc/add?a=20&b=30` and would expect a result like the following
```json
{
    "Sum": "50"
}
```

We know that a SOAP (over http) service uses HTTP POST to a specific end-point with the operation being specified in the SOAP Envelope.  In this case we will need to translate four operations (add, subtract, multiply and divide) into a REST style API but these do not really translate to HTTP verbs.  We will therefore use resources to map to the operations so let's begin adding the *REST API to SOAP Service* policy.

#### Add the Policy to your API

- In the *Available Policies*, expand *Interface Managment* and hover your mouse over the *REST API to SOAP Service* policy and click *Apply*
  - On the first screen you can set the name and comments to any value you like.  Accept the defaults of the placements in the request/response pipelines and click the navigation to move to the next page of the wizard.
  - Under *Conversion Configuration*, click the *Select Service* button and choose your SOAP service you created in [Registering the SOAP Service](registering-the-soap-service)
  - Once selected, the methods will populate and you can select one or more to configure.  For now, just select the *Add* Operation

#### Configuring the Method to Operation Mappings

- Update the Method to *GET*.  In this case, the method, or http verb does not really translate to mathmetical operations.
- Set the Path for the Operation to be the same as the Operation but lowercase.  For example for the *Add* Operation, set the Path to *add*.  The mapping should be configured as follows:
  - Method: GET
  - Path: add
  - Operation: Add

##### Configuring Payload Mappings
Notice that the Method to Operation Mapping is expandeable (arrow on right-hand side).  Expand the first mapping (add) and you will see the SOAP Payload similar to the following: 
```xml
<Envelope xmlns="http://www.w3.org/2003/05/soap-envelope">
   <Body>
      <Add xmlns="http://tempuri.org/">
         <intA>${payload.Add.intA}</intA>
         <intB>${payload.Add.intB}</intB>
      </Add>
   </Body>
</Envelope>
```

Focus in on the *intA* and *intB* elements.  In an API, there are a number of variables.  Some examples are:

- **payload**: The body of the request
- **headers**: The http headers of the request
- **queries**: The http query parameters

We can see that *payload* comes from a message body and it makes sense, given that policy will simply map based on the underlying SOAP service.  The corresponding REST/JSON request would be:

```json
{
    "Add":
    {
        "intA": 20,
        "intB": 30
    }
}
```

If our client was expecting to POST a request with the above body, then this would operate as expected, but our client's requirements were to call the API with GET and pass the request with query parameters.  We need to update the payload accordingly
```xml
<Envelope xmlns="http://www.w3.org/2003/05/soap-envelope">
   <Body>
      <Add xmlns="http://tempuri.org/">
         <intA>${queries.a}</intA>
         <intB>${queries.b}</intB>
      </Add>
   </Body>
</Envelope>
```

Notice that we are referencing queries *a* and *b* so a request like `http(s)://MyGatewayIP/calc/add?a=20&b=30` will work as expected.

Now for the response payload, select the *SOAP to REST* tab in the payload mapping and you will see a result similar to the following

```json
{
  "AddResponse":{
    "AddResult": "${payload.Body.AddResponse.AddResult}"
  }
}
```
Let's change this and make it similar to the following:

```json
{
    "Sum": "${payload.Body.AddResponse.AddResult}"
}
```

Here we modified the payload so that when calling the API to add *30* and *50* we get a result similar to the following:

```json
{
    "Sum": 50
}
```

Make sure to click *Apply* and *Save* your API.

### Deploying and Testing your API

Go ahead and deploy your API.  If you need a refresher, visit the [Deploying and API](../../deploy_api/README.md) tutorial.

Once your API has completed the deployment, go ahead and invoke the API.  In this case, since it is a simple GET with parameters, you could simply point your web-browser to the API.  If you need a refesher on invoking your APIs, visit the [Invoking an API](../../invoke_api) 

## Conclusion

In this tutorial, you learned: 

- How to create a REST API for a SOAP Service.  
- How to use the API execution variables.
- How to reshape the response payloads.

## Extra Credit

Perform the steps for the rest of the Operations and see how you can reshape the response payload for the difference, product and quotient.