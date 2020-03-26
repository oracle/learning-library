# Using OAuth with APIs
> This tutorial is under development and you may be more likely to encounter bugs.  We welcome any feedback from our early adopters!

An API Platform Gateway can act both as an OAuth client and an OAuth resource server.  Consider the following use-cases:

1. OAuth Client: The service back-end is OAuth protected and does not meet the requirements for the front-end API.  This can happen when the back-end system has only internal users that are not available or appropriate for the API consumer(s)
1. OAuth Resource Server: The gateway acts as an OAuth resource server to require and validate the Bearer token.  This provides the ability to maintain access control at the API level based on the API consumer.

The gateway can act as the resource server an OAuth client in the same flow, or can provide a more modern OAuth front-end for a service back-end that uses basic auth.

## Before you begin
You should already be familiar with the concepts of API Platform and have completed the tutorials of creating, deploying and invoking APIs.

In this tutorial, you will create/update an API to enforce an OAuth token.  There are multiple personas involved in setting up an API for this sort of authorization.
1. **API Manager**: Created the API Implementation.  Will configure the OAuth policy and will choose how scopes will be handled
1. **Gateway Manager**: Loads the OAuth profile for the gateway to be able to act as a *Resource Server*.  See [Configuring OAuth](../../../../configure/gateway/oauth/README.md) to learn how a gateway is configured with an OAuth provider
1. **Identity Administrator**: Creates required client application to be used with the gateway, or specific API if necessary

### Required
- You have an API Platform environment.  See [environments](../../../../environments/README.md) for details on procuring an API Platform environment.

> Note: Whenever there is a link, open it in a new tab (right-click->"Open Link in New Tab").  This way you will maintain your place this lab guide without having to re-orient yourself after completing a task from a linked tutorial, etc

- You have access to your Identity Cloud Service *Identity Console* and
  - You have the rights to create an application
- Your environment has at least one gateway deployed and 
  - It has been configured to be an OAuth *Resource Server*.  See [Configuring OAuth](../../../../configure/gateway/oauth/README.md) to learn how a gateway is configured with an OAuth provider
- You have access to API Platform as an *API Manager* and you have an API which you can add the *OAuth 2.0* policy.  If you need to create an API, you can refer to [Creating an API Policy Implementation](../../../../manage/apis/create_api/README.md) to create an API.
- Your API is deployed and you can invoke it.

## Registering Client in Identity Cloud Service (IDCS)
There are many things to consider when setting up OAuth, but here we need to keep in mind that the token will arrive to the gateway that will include the  *audience* and *scope*  

In the gateway, we've loaded one profile (covered in [Configuring OAuth](../../../../configure/gateway/oauth/README.md)) with the audience to be the gateway's load balancer address.

The resource application simply has four scopes (Create, Read, Update, Delete), but a scope can have any name.

In this case, clients wishing to call an API with the API Platform Gateway acting as a resource server, that client will fetch an OAuth token with a scope in the form of *audience* + *scope*.

We don't want to give the app we created for the OAuth resource server to our API clients, so we will create a client that will have limited access to only a couple of scopes.

### Log into IDCS
1. Log into your Oracle Cloud Domain using the user that has *Identity Administrator* rights.
1. Click on the *Users* menu at the upper-right hand of your Dashboard
1. Click the *Identity Console* button

### Creat an Application for your API
1. Choose *Applications* from the side-menu
1. Click *Add*
1. Choose *Trusted Application*
1. Give your application a name like *API Client*.  If you are sharing this environment with others, make it unique, adding your name for example.  Click *Next*
1. Select *Configure this application as a client now*
  1. Choose *Client Credentials*, and *Refresh Token*
  1. Set *Trust Scope* to *Allowed scopes*
  1. Under *Allowed Scopes* click *Add*
    1. Choose the APIGateway resource app, and select the *Create* and the *Read* scope
  1. Click *Next* and skip all remaining screens.
  1. Click *Finish*

> You will get a confirmation that the Application which will display the *Cient ID* and *Client Secret*.  Copy both of these values and store them in your favorite text editor for use later.

Click *Activate* to activate your client application

> Note: there are multiple authenication methods and ways to handle clients that cannot maintain the security of their *client_secret*.  We are using this method for simplicity, but the IDCS documentation will open much greater detail.

### Test the OAuth token for your application
Call the OAuth token end-point with the client credentials for your created application.

#### Example (using cURL)
`curl -u <client_id>:<client_secret) -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&scope=http://129.213.40.20:8011/Read" https://idcs-ba024983814aa13048333cd48889.identity.oraclecloud.com/oauth2/v1/token`

You will receive an access_token value like the example below.

```json
{"access_token":"eyJ4NXQjUzI1NiI6Ijg4em5OWVFaMER2Njl6TUh2UXNiSzA4SmhLaTR6d0RsUUNUV25HbHhVVFUiLCJ4NXQiOiJJUmJtbEQtaFIzWDV2WXhma1N1M2pyenVoM1kiLCJraiL5TVBV9eE2S8nHO-CFXMhpdOjGk6Xb8Q2M23XGb8PCfSKHH6iQbG-MHvgnDeOMdYy0XkV-yNsKmeSHm4JhndAFzWuiUdX0sZ7nvZ2sbRBXFA6M7Lfg8YzL2m3LfLMObX5zPA","token_type":"Bearer","expires_in":3600}
```

### Decode the token to view the contents
1. Copy the value of *access_token* without the quotes.
1. Point your browser to jwt.io
1. Paste the encoded token into the *Encoded* box

You will see the Payload Data in the *Decoded* box similar to the example below.

```json
{
  "sub": "1bf4d3e599ec22a9f937a49c9a4c",
  "user.tenant.name": "idcs-ba0244839b3414da735440cd48889",
  "sub_mappingattr": "userName",
  "iss": "https://identity.oraclecloud.com/",
  "tok_type": "AT",
  "client_id": "1bf4d3e599ec4923543a4a49c4d4c",
  "aud": "http://10.10.10.1:8011/",
  "sub_type": "client",
  "scope": "Read",
  "client_tenantname": "idcs-ba027ab544aa1559373cd48889",
  "exp": 1529362611,
  "iat": 1529359011,
  "client_guid": "67981394d5548c4510",
  "client_name": "APIClient",
  "tenant": "idcs-ba04aa1558ddcd48889",
  "jti": "4a8e-4e06-ba29"
}
```

Notice the scope is *Read*

### Try other Scopes
Your resource application supports Create, Read, Update, and Delete, but the client you created for your API, only allows *Create* and *Read*

Try the same call to get a token, but instead of using the *Read* scope, try to use the *Update* scope

#### Example (using cURL)
```curl -u <client_id>:<secret) -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&scope=http://10.10.10.1:8011/Update" https://idcs-ba024b284581833cd49.identity.oraclecloud.com/oauth2/v1/token```

You should receive a result similar to the following:
```json
{"error":"unauthorized_client","error_description":"Client authorization failed."}
```

This is because the client is not allowed the Write scope, so the client cannot obtain that scope.


## Adding OAuth 2.0 to your API
### Log into API Platform Cloud Service
1. Point your browser to the management portal URL as described in your chosen environment. 

> This URL is based on the [environment](../../../environments/README.md) that you have selected but it will take the form of `http(s)://<host>:<port>/apiplatform`

1.  Log in as a user that has the *API Manager* role and has rights to manage the API.

### Edit your API and add the OAuth 2.0 policy
1. Choose your API from the list of APIs
1. Click the *API Implementation* side-tab
1. Expand  *Security* in the list of *Available Policies*
1. Select *OAuth 2.0* and click *Apply*
  1. You can choose a different name and add a description, but make sure to place it after the *API Request*.  Click the next (right arrow) to move to the next screen in the wizard
1. Choose *At Least One* and add *Read* for the *Get* method as the valid scope, and click *Apply*

In the *OAuth 2.0* policy, you have a few scope enforcement options.  You can just validate that it is an authenicated user (Any), or that the user has at least one scope in a list, or you can associate a scope to a method.  For example, if a user were to call the API with POST, then you can require that the user has the *Create* scope.

In the above example, we are making this Read only.  The user must have the Read scope, but this API won't accept any other scope, even if the user has it.

> If you wanted to make this API truly *Read Only* then you would use the Interface Filtering method as well to establish a condition that only the **GET** method is used.

> Note: Tested on 18.2.5 and HTTP method restricted did not eliminate a POST with Read being called.  The restricted though would be used when defining the scope that must be used for each Method.  It does not seem to restrict methods like Interface Filtering would.  This is pending review.

Save and re-deploy your API.

### Test your API
1. Using the client application you created, obtain a token with the read scope.  
  1. If you need a refresher, see the [example](test-the-oauth-token for-your-application) when you created the application
1. Call the API, using the token

#### Example of Read Scope (using cURL)
The client application has the allowed scopes of *Read* and *Create*.  Let's first test the API with *Read*

##### Obtaining the OAuth token
```curl -u <client_id>:<secret> -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&scope=http://129.213.40.20:8011/Read" https://idcs-ba024aaa1558b89.identity.oraclecloud.com/oauth2/v1/token```

##### Calling the API with the token
``` curl -H "Authorization: Bearer eyJ4NXQjUzI1NiI6Ijg4em5OWVFaMER2Njl6TUh2UXNiSzA4SmhLaTR6d0RsUUNUV25HbHhVVFHgQo0K3rV5Ez5WnrajltwGCEgbJ_6y2mraFyb2sVb4qi4RzS7DrZV-4IdlaBXE5R1j-swNIzHcRjPBBtK7BDJCw55cCI7QRTBJSLgt2rs86zZDhfSYxsrVhQxBOzvIusYA" -H "Accept: application/json" http://129.213.40.20:8011/beers/ ```

##### Example results from API call
```json
[
    {
        "id": "1",
        "label": "Breakfast Stout",
        "brewery": "Founders Brewing Company",
        "location": "Michigan",
        "ibu": 60,
        "abv": 8.30
    },
    {
        "id": "2",
        "label": "90 Minute IPA",
        "brewery": "Dogfish Head Craft Brewery",
        "location": "Delaware",
        "ibu": 90,
        "abv": 9.00
    },
    {
        "id": "3",
        "label": "Heady Topper",
        "brewery": "The Alchemist Brewery",
        "location": "Vermont",
        "ibu": 75,
        "abv": 8.00
    }
]
```
#### Example of Create Scope (using cURL)
##### Obtaining the OAuth Token
` curl -u <client_id>:<secret> -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&scope=http://129.213.40.20:8011/Create" https://idcs-ba024b2844b3414aa15581833cd48889.identity.oraclecloud.com/oauth2/v1/token `

##### Calling the API with the token
` curl -H "Authorization: Bearer eyJ4NXQjUzI1NiI6Ijg4em5OWVFaMER2Njl6TUh2UXNiSzA4SmhLaTR6d0RsUUNUV25HbHhVVFUiLCJ4NXQiOiJJUmJtbEQtaFIzWDV2WXhma1N1M2pyenVoM1kiLCJraWQiOiJTSUdOSU5H5s-92MLRv_-VZYqlwJQE7BgP6DYCEBwxFTliS147aheipO7gY3-w3uGGSbVcziQ" http://129.213.40.20:8011/beers/1 `

##### Example results from API Call
` UnAuthorized to access the resource. `

> This is because while *Create* is an allowed scope, the API specifically only allows *Read*.  Again, to ensure that the API is *read only*, the *Interface Filtering* policy should also be used.

### Review the logs
The gateway logs information about the API calls and you can review the log to observe the OAuth 2.0 policy in action.

1. Log into your gateway server's as the OS user who installed the gateway node or other user that access to the appropriate directories.
1. Navigate to `<nodeInstallDir>/domain/gateway/gateway1/apics/logs`
1. Open `apics.log`  

#### Example log entries
You will see results in the log similar to the following examples

##### Successful Read request
```
[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.enforcer.strategy.impl.RetrieveJWKPublicKeyStrategy] Key ID for Selecting Public Key ::SIGNING_KEY

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.enforcer.strategy.impl.RetrieveJWKPublicKeyStrategy] Public Key is loaded :: Algorithm RSA::FormatX.509

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.validator.impl.JWTTokenValidatorImpl] Signature is valid => true

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.claim.APICSJWTClaimsVerifier] -------Token Validity  Claim is Validated ------

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.claim.APICSJWTClaimsVerifier] -------Issuer Claim is Validated ------

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.claim.APICSJWTClaimsVerifier] -------Subject Claim is Validated ------

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.claim.APICSJWTClaimsVerifier] -------Mandatory Claims is Validated ------

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.claim.APICSJWTClaimsVerifier] --- All the claims are validated --- 

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.claim.APICSJWTClaimsVerifier] --- Token is Valid ---

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.validator.impl.JWTTokenValidatorImpl] Audience Claim is validated

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.validator.impl.JWTTokenValidatorImpl] Scopes from Access Token is Read

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.validator.impl.JWTTokenValidatorImpl] Scope Read is asserted based on the list of scope ['[Read]'] defined in the policy

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.validator.impl.JWTTokenValidatorImpl] OAuth JWT Access Token is valid

[06-18 10:26:27:INFO oracle.apiplatform.policies.oauth.OAuthRuntime] !!!!! OAuth Access Token is validated !!!!!!!
```

##### Rejected Create Request
> Note: Most of the duplicate log statements are removed for brevity.  For example, not repeating that this event also stated the *Audience Claim is validated*, etc

```
...
[06-18 10:35:27:INFO oracle.apiplatform.policies.oauth.validator.impl.JWTTokenValidatorImpl] Scopes from Access Token is Create

[06-18 10:35:27:ERROR oracle.apiplatform.policies.oauth.validator.impl.JWTTokenValidatorImpl] Scope from access token ['[Create]'] is not present in the list of scopes ['[Read]'] defined in the policy

[06-18 10:35:27:ERROR oracle.apiplatform.policies.oauth.OAuthRuntime] Error Occured in enforcing an Access Token ==>oracle.apiplatform.policies.oauth.exception.ScopeNotValidException: Scope from access token ['[Create]'] is not present in the list of scopes ['[Read]'] defined in the policy

[06-18 10:35:27:ERROR oracle.apiplatform.policies.oauth.OAuthRuntime] UnAuthorized to access the resource.Scope from access token ['[Create]'] is not present in the list of scopes ['[Read]'] defined in the policy
```
##### Invalid Token
You can try a bad token, such as change a couple of characters in your token from your previous request and you will see messages similar to the following in the log.

```
[06-18 10:53:45:INFO oracle.apiplatform.policies.oauth.enforcer.strategy.impl.RetrieveJWKPublicKeyStrategy] Key ID for Selecting Public Key ::SIGNING_KEY

[06-18 10:53:45:INFO oracle.apiplatform.policies.oauth.enforcer.strategy.impl.RetrieveJWKPublicKeyStrategy] Public Key is loaded :: Algorithm RSA::FormatX.509

[06-18 10:53:45:INFO oracle.apiplatform.policies.oauth.validator.impl.JWTTokenValidatorImpl] Signature is valid => false

[06-18 10:53:45:ERROR oracle.apiplatform.policies.oauth.OAuthRuntime] Error Occured in enforcing an Access Token ==>oracle.apiplatform.policies.oauth.exception.OAuthAccessTokenException: Signature Validation Failed

[06-18 10:53:45:ERROR oracle.apiplatform.policies.oauth.OAuthRuntime] UnAuthorized to access the resource.Signature Validation Failed
```
## Conclusion
In this lab, you learned:
- How to define a client application for use with the OAuth 2.0 policy in an API
- How to add and configure the OAuth 2.0 policy in an API



