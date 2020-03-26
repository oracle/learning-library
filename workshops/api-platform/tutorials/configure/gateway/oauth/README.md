# Configuring OAuth
> This tutorial is under development and you may be more likely to encounter bugs.  We welcome any feedback from our early adopters!

An API Platform Gateway can act both as an OAuth client and an OAuth resource server.  Consider the following use-cases:

1. OAuth Client: The service back-end is OAuth protected and does not meet the requirements for the front-end API.  This can happen when the back-end system has only internal users that are not available or appropriate for the API consumer(s)
1. OAuth Resource Server: The gateway acts as an OAuth resource server to require and validate the Bearer token.  This provides the ability to maintain access control at the API level based on the API consumer.

The gateway can act as the resource server an OAuth client in the same flow, or can provide a more modern OAuth front-end for a service back-end that uses basic auth.  

## Before you begin
> You should open your favorite text editor.  **Make sure it is an editor that does not introduce special characters.**  At certain points in this lab you will capture values for later use.  You will also be editing the *OAuth Profile* file to be loaded into the gateway

Choose your favorite REST client to use.  This lab will either give an example using cURL, or will provide you with the attributes necessary for any REST call.  You will need to understand how to configure this in your particular REST client of choice.

This lab also includes a Postman collection with the requests pre-configured, if that is your REST client.  The collection uses Variables.  As you work through this lab, you will need to update the variables in order to make the collection work properly.

### Required
- You have an API Platform environment.  See [environments](../../../../environments/README.md) for details on procuring an API Platform environment.

> Note: Whenever there is a link, open it in a new tab (right-click->"Open Link in New Tab").  This way you will maintain your place this lab guide without having to re-orient yourself after completing a task from a linked tutorial, etc

- You have access to your Identity Cloud Service *Identity Console* and
  - You have the rights to create users
  - You have the rights to create an application
- Your environment has at least one gateway deployed and 
  - You have have the *Weblogic Domain" credentials*  to administer that gateway as well as OS access to the machine the gateway node is running on.
  - You have the credentials for a user that is a *Gateway Manager* and has the *Manage Gateway* grant on the gateway you are going to be installing the profile on.
  - You have the credentials for the *Gateway Runtime* user that is being used by the gateway you are going to be installing the profile on.
  - You have the **client_id** and **client_secret** for the `APIPCSAUTO_<name of your instance>` application.
  - If you do not yet have a gateway node deployed, you can visit the [tutorial](../gateway_node/README.md) and install the node.

## Registering the OAuth Resource Server and Client in Identity Cloud Service (IDCS)
### Log into IDCS
1. Log into your Oracle Cloud Domain using the user that has *Identity Administrator* rights.
1. Click on the *Users* menu at the upper-right hand of your Dashboard
1. Click the *Identity Console* button

#### Creating an Application for your Gateway
1. Choose *Applications* from the side-menu
1. Click *Add*
1. Choose *Trusted Application*
1. Give your application a name like *API Gateway*.  If you are sharing this environment with others, make it unique, adding your name for example.  Click *Next*

> The best practice is to create a resource application, then create one or more client applications that use that resource application.  You can create a client interface along with the resource as well.  In this case we will create both together and we will use the client application for our testing.  
>
> In the future, we can add client applications for our API consumers that will leverage this gateway.

1. Select *Configure this application as a client now*
  1. Choose *Resource Owner*, *Client Credentials*, and *Refresh Token*
  1. Choose *Introspect*
  1. Choose *All Resources* for *Trust Scope*
  1. Click *Next*
1. Select *Configure this application as a resource server now*
  1. Choose *Is Refresh Token Allowed*
  1. Set the Primary Audience.  This can be any text, we just need to make sure we match it at multiple points.  A best practice is to use the load-balancer address of your gateway.
    - If you are sharing an environment with others and do not have a unique *Load Balancer Address* for your gateway, then use your unique gateway name.
    - If you are using your own entitlement with your own gateway, then you can use the *Load Balancer Address*
    - Make sure you put a trailing `/` on the end of the audience.
  1. Add the Allowed Scopes for (Create, Read, Update, Delete)
    - You can name the scopes anything you wish based on the purpose of the application.  At this point we are simply setting up the gateway as a resource server, but in the future an API can differentiate between the scopes.  In this case, we will just set up to test the basic CRUD functions.
  1. Click *Next* and choose *Skip for later* on *Web Tier Policy*
  1. Click *Next* and then check *Finish*
  1. Make sure you *Activate* your application before using it

> You will get a confirmation that the Application which will display the *Cient ID* and *Client Secret*.  Copy both of these values and store them in your favorite text editor for use later.

> You can create different clients, such as one client who may only be able to Read, but cannot modify records would only have the *Read* scope.  Above we will test as a client who has the capability to Create and Read records, but cannot Update or Delete records.

## Understanding the OAuth Token
Let's test accessing and interpeting the token.

### Getting a token with all scopes
1. Call the token endpoint with the following attributes.
  - URL: `https://<Identity Domain>.identity.oraclecloud.com/oauth2/v1/token` (you can see this when you navigate to the *Oracle Cloud Account* sign in for your domain)
  - Verb: POST
  - Basic Auth
    - Username: *Client ID* from the App you created
    - Password: *Client Secret* from the App you created
  - Headers
    - `Content-type: application/x-www-form-urlencoded`
  - Form
    - `grant_type=client_credentials`
    - `scope=urn:opc:idm:__myscopes__`

#### Example, retrieving the token (in cURL)
> Note: The values are altered for publication.  The token samples will not render 
`curl -u 79b0673:442af -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&scope=urn:opc:idm:__myscopes__" https://idcs-ba024b2844b3414aa15581833cd48889.identity.oraclecloud.com/oauth2/v1/token`

You should receive a result similar to the following:
```json
{"access_token":"eyJ4NXQjUzI1NiI6Ijg4em5OWVFaMER2Njl6TUh2UXNiSzA4SmhLaTR6d0RsUUNUV25HbHhVVFUiLCJ4NXQiOiJJUmJtbEQtaFIzWDV2WXhma1N1M2pyenVoM1kiLCJraWQiOiJTSUdOSU5HX0tFWSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI3OWIwMDBkNzU0OTc0ZjA4Yjg2OThjNDI3MzJkZjY3MyIsInVzZXIudGVuYW50Lm5hbWyg5IiwianRpIjoiMDUyZDY5NWItMWYxZS00NTFmLTk3OGEtMmQ2MmM3YzBjMzA0In0.a8LW7GHF8uIpRRy0VHV8tDUerA2O6SIKEfdLp3tijBzpfqYbcn1E8X1qCv5nvKO1uDvBa0GjxixFyPkzs2OBlLfBsxx0D0C67GmaBzOjgzGX1Ah_rKK7x4_9lhlLKJtRnMos6PhP0_2wk1L64Yzc1yd64xN9Uhf30hew","token_type":"Bearer","expires_in":3600}

```

If you have `jq` installed on your machine, you can update your cURL command to select only the value of the *access_token* which you will need for the next step.

#### Example, retriving just the value of the token
`curl -u 79j73:4fg-450xx01af -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&scope=urn:opc:idm:__myscopes__" https://idcs-ba024b28xx414aa147291833cd48889.identity.oraclecloud.com/oauth2/v1/token | jq -r '.access_token'`

You should receive a result similar to the following:
`eyJ4NXQjUzI1NiI6Ijg4em5OWVFaMER2Njl6TUh2UXNiSzA4SmhLaTR6d0RsUUNUV25HbHhVVFUiLCJ4NXQiOiJJUmJtbEQtaFIzWDV2WXhma1N1M2pyenVoM1kiLCJraWQiOiJTSUdOSU5HX0tFWSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI3OWIwMDBkNzU0OTc0ZjA4Yjg2OThjNDI3MzJkZjY3MyIsInVzZXIudGVuYW50Lm5hbWUiOiJpZGNzLWJhMDI0YjI4NDRiMzQxNGFhMTU1ODE4MzNjZDQ4ODg5Iiwic3ViX21hcHBpbmdhdHdYjI4NDRiMzQxNGFhMTU1ODE4MzNjZDQ4ODg5IiwianRpIjoiY2ZmYzZmZGQtMTA5OS00NDg2LTlmYWMtOGIzMDJjN2VmNjA1In0.gMsusYorDC2BdXLlXh-x9bARZ-8H0p9SgOZHx-RuLDeKXH2vMdFnk3EPtllEJYJLlxoZv5U4kouXx32th1Oq0ubXwrJyTLIVwMpUK6ucjcerKGBHA8SMCvuLzhIEQ2Tf5qPFJA5_livj3vZZt6Pnt0lr4q2Q8-g-E2hZatZAlrkViL00Kf08SGJIvUnZhydMGa3chSIkgjrgnjyw2JxLck4aSKlA1XRZayDkdT8oNQV1OkLGZKPg`

Notice that this is just the *access_token* value only.

## Interpreting the Token
An easy way for us to view the token, is to open a browser and point it to `http://jwt.io`

Paste the value of the *access_token* into the **Encoded** box where it states *PASTE A TOKEN HERE*.  Remember, this is the value of the access_token only, similar to the second example output above.

You should see a result in the **PAYLOAD: DATA** similar to the following:
```json 
{
  "sub": "76649b000dvd32drf673",
  "user.tenant.name": "idcs-ba0248889",
  "sub_mappingattr": "userName",
  "iss": "https://identity.oraclecloud.com/",
  "tok_type": "AT",
  "client_id": "79b09f673",
  "user_isAdmin": false,
  "aud": [
    "urn:opc:lbaas:logicalguid=idcs-ba024bb9",
    "https://idcs-ba0249.identity.oraclecloud.com"
  ],
  "sub_type": "client",
  "clientAppRoles": [
    "Authenticated Client"
  ],
  "scope": "urn:opc:idm:t.security.client",
  "client_tenantname": "idcs-ba024bb889",
  "exp": 1529342878,
  "iat": 1529339278,
  "client_guid": "370f740",
  "client_name": "APIGateway",
  "tenant": "idcs-ba9400ab3475889",
  "jti": "1099-4486-9fac"
}
```

Capture the **iss** value from this output and save it for later.

## Creating and loading the OAuth Profile to the Gateway
In order to act as an **OAuth Resource Server**, we need to create an OAuth profile for the **OAuth Authorization Server**.  In this case it is IDCS, but we could use other servers that conform to the RFC7519 when generating JSON Web Tokens (JWT)


In order to validate OAuth tokens, we establish a trust relationship between IDCS and the API Gateway.  A JSON Web Token (JWT) is protected in the following ways:
- Only SSL communications should be used when retrieving and using tokens.  This will prevent attackers from being able to access the token in transit.
- If a client requests a scope of a resource that the client does not have access to (Write instead of Read), IDCS will not provide a token for that client.
- IDCS uses a JSON Web Key to sign the token.  The key is registered in the gateway and the gateway uses it to validate the token against the signature.  
  - If a client requests a scope that the client is authorized for and then tries to change the scope in the token, the signature checking would result in an invalid token and the API Gateway would refuse the request.


### Retrieving the JWK from IDCS
As we prepare to create our OAuth profile, we need to retrieve the JSON Web Key (JWK) from our IDCS environment.  To do this, we need to get an OAuth token, then call the SigningCert end-point.

1. Retrieve a valid JSON Web Token.  A token is set to expire after a minute, so you will likely need to request a new one.  Review the steps above if you need a refresher.
1. Call the SigningCert endpoint to retrieve the key
  - URL: `https://<Your IDCS Domain>.identity.oraclecloud.com/admin/v1/SigningCert/jwk`
  - Verb: `GET`
  - Headers:
    - `Authorization: Bearer <the token value retrieved in the previous step>`
    - Accept: `application/scim+json,application/json`

#### Example (using cURL)
##### Get the OAuth Token
```
curl -u 79b000d754974f08b8698c42732df673:442eda5f-b8ae-44e8-996b-450dd1c301af -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&scope=urn:opc:idm:__myscopes__" https://idcs-ba024889.identity.oraclecloud.com/oauth2/v1/token
{"access_token":"eyJ4NXQjUzI1NiI6Ijg4em5OWVFaMER2Njl6TUh2UXNiSzA4SmhLaTR6d0RsUUNUV25HbHhVVFUiLCJ4NXQiOiJJUmJtbEQtaFIzWDV2WXhma1N1M2pyenVoM1kiLCJraWQiOiJTSUdOSU5HX0tFWSIsImFsZyI6IlJTMjU2In0.ey8gD09Fauu9SKqVZCX4vR57KyIRUKrtEVc9jvRPu1ykdc0YP0mScavW-0J1JYsPNlyBavXlvwjaSOYEBWG1TCz_W_DbGIU9GqjdIIiIC-KIqEoBRLs3aWddi5NZj-gBOscmKcgqxZh1lkSMuhyxwqdScNpZ0D0C67GmaBzOjgzGX1Ah_rKK7x4_9lhlLKJtRnMos6PhP0_2wk1L64Yzc1yd64xN9Uhf30hew","token_type":"Bearer","expires_in":3600}
```
##### Use the token and call the Signing Cert end-point
```
curl -H "Authorization: Bearer eyJ4NXQxs6KWNVEXv9bhQcv7zfRLi6T3ueu9fbEknqc7p2ppLNPRBGIK52mIG39luTMuLdpY_0L6k-Xd9IRPSKR-dN1gwR8poY0_x3uYXjYiKRZ8D_jD-T2bMzbLsgL78rh7ui1b1cMz6fdk-K8aVmlLbNJniLy39-s2RiaeK37VYS5zkhe4W9bkewCCukBPc09rHSD8ougX4-WPs2YF57h_c-uxhnnuKRuuUS6iqwGdHLdNfUUVj2ihM4VlxHnQq9V1RxogxKYQ029ijWhy3tzFFMHyoUt-Y-r-8h5LULnKoHcuDf7xKAB5ILdFYg" -H "Accept: application/scim+json,application/json" https://idcs-ba024b2844b3414aa15581833cd48889.identity.oraclecloud.com/admin/v1/SigningCert/jwk
```
##### Sample result of SigningCert.
> Note: the samples are altered.  Your actual result will be much more complete.

```json 
{"keys":[{"kty":"RSA","x5t#S256":"88znNYlxUTU","e":"AQAB","x5t":"IRbmlD-hR3X5vYxfkSu3jrzuh3Y","kid":"SIGNING_KEY","x5c":["MIIDXz+2Z3FR0CWdpx+dT91JmalvB01QlcCjdXv4SGKXmF","MIIDdDCCAlygAwIBAgIGAVw4Ns68MA0GCSqGSIb3DQEBCwUAMFcxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaTAPBgNVHQ8BAf8EBQMDB9gAMA0GCSqGSIb3DQEBCwUAA4IBAQBKcaopdLvr5+EstU3zjpPoZh4XnKvJuD+1J8LVDei"],"key_ops":["encrypt","sign"],"alg":"RS256","n":"lIOuSLMNto9t5P2YmGAqXCW_I19vBpzjjDkfoNh1o7ZEbS5VjKW3uaq9yuVTmYhrIMj1k_WOQGxN3QFTmQ"}]}
```
You will use the complete value returned in your OAuth profile, so make sure to capture it.

### Completing the OAuth Profile XML file
In your OAuth Profile, you will set the following values:
- Issuer: The value of **iss** you received in the token
- Audience: The value of **Audience** defined for the resource application in IDCS
- useFormat: **JWKFormatPubKey**
- Include `<JWKFormatPubKey>`*Value of the complete key returned*`</JWKFormatPubKey>`

> Note: Samples in the documentation mention **PEMFormatPubKey** and **X509FormatPubKey** but not the **JWKFormatPubKey**.  If you begin with any of those samples, then remove those references as we are using the **JWKFormatPubKey**

Here is a sample of the OAuth profile 
```xml
<OAuth2TokenLocalEnforcerConfig>
	<Name>DEFAULT</Name>
	<Issuer>https://identity.oraclecloud.com/</Issuer>
        <Audience>http://129.213.40.20:8011/</Audience>
	<AudienceRestrictionFromConfig>true</AudienceRestrictionFromConfig>
	<!-- useFormat has 2 values  PEMFormatPubKey, X509FormatPubKey -->
	<PublicCertLocation useFormat='JWKFormatPubKey'>
		<JWKFormatPubKey>{"keys":[{"kty":"RSA","x5t#S256":"88znNYQZ0Dv69nGlxUTU","e":"AQAB","x5t":"IRbmlD-hR3X5vYxfkSu3jrzuh3Y","kid":"SIGNING_KEY","x5c":["MIIDXzCCAkegAwIBAgIGAWEwsA2SMA0GCSqGSIb3DQEBCwUAMFcxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZvcmFjbGUxFTATBgoJkiaJk/IsZAEZFgVjbG91ZDERMA8GA1UEAxMIQ2xvdWQ5Q0EwHhcNMTgwMTI2MDQxODE5WhcNMjgwMTI2MDQxODE5WjBWMR+eckE3WvNtZKOwTfO3wTnli/IrauKfLJPOsIGnYy4lohr8k1iuJuroNh1bAY2ZJidoo2zz/pTRRBYGJ00Q+NwrnSUVpHk2qV0N9e6KX9v5jL98SdNjRjoQQ8CQGokNRvwIDAQABo0YwRDASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRs+bdtrcF6S9hWxzjj2hnZyxS6RTAPBgNVHQ8BAf8EBQMDB9gAMA0GCSqGSIb3DQEBCwUAA4IBAQBKcaopdLvr5+EstU3zjpPoZh4XnKvJuD+1J8L1XGkA0brP0sAwg_h-kN4zZqRr8Mb1FwvV1NJpwXAiFDe0Tq_KXui5Fn8U-a4IqMcadoNAc9v6VCFTmQ"}]}</JWKFormatPubKey>
</PublicCertLocation>
</OAuth2TokenLocalEnforcerConfig>
```

### Loading the OAuth Profile into the Gateway
Once you have your OAuth profile ready, you need to load it into your gateway.

1. Log (SSH) into the machine running your gateway
1. Navigate to and open the *gateway-props.json* file for your gateway.
1. Confirm the following settings in the *gateway-props.json* file
  1. nodeInstallDir
  1. managementServerHost
  1. managementServerPort
  1. oauthProfileLocation
1. Put your OAuth profile file into the directory specified in the oauthProfileLocation.  If you do not have this setting, create the directory and then add the setting to your gateway-props.json file

> Note: do not add the oauth profile directory under the nodeInstallDir.  If you ever re-install the node, the directory is cleaned out and would remove your OAuth profile file.

Once you have this in place, then run the following command:
`./APIGateway -f gateway-props.json -a updateoauthprofile`

> Note: The example above assumes that the gateway-props.json file is the name of your configuration file for the gateway and that it is in the same directory as the installer.  You may need to update the syntax if this is different.

Here are some examples of an installation where the name of the *gateway-props.json* file was named differently.

#### Example (gateway-props-gse.json)
```json
{
    "logicalGatewayId" : "100",
    "managementServiceUrl" : "https://<instanceName>-<IdentityDomain>.apiplatform.ocp.oraclecloud.com:443",
    "idcsUrl" : "https://idcs-ba0d48889.identity.oraclecloud.com/oauth2/v1/token",
    "requestScope" : "https://2890D9.apiplatform.ocp.oraclecloud.com:443.apiplatform",
    "gatewayNodeName" : "GSE Dev 1 Node 1",
    "gatewayNodeDescription" : "GSE Dev 1 Node 1",
    "listenIpAddress" : "10.0.0.2",
    "publishAddress" : "10.0.0.2",
    "nodeInstallDir" : "/u01/gw",
    "oauthProfileLocation" : "/u01/oauth/SampleOAuth.xml",
    "gatewayExecutionMode" : "Development",
    "heapSizeGb" : "2",
    "maximumHeapSizeGb" : "4",
    "gatewayMServerPort" : "8011",
    "gatewayMServerSSLPort" : "9022",
    "nodeManagerPort" : "5556",
    "coherencePort" : "8088",
    "gatewayDBPort" : "1527",
    "gatewayAdminServerPort" : "8001",
    "gatewayAdminServerSSLPort" : "9021"
}
```
#### Example, loading the profile
```
[opc@api-gw-n-1 ~]$ ./APIGateway -f gateway-props-gse.json -a updateoauthprofile
Please enter user name for weblogic domain,representing the gateway node:
weblogic
Password:
2018-06-18 19:56:23,775 INFO Initiating validation checks.
2018-06-18 19:56:23,835 INFO validation complete
2018-06-18 19:56:23,835 INFO Install action logs are located in /u01/gw/logs
2018-06-18 19:56:23,836 INFO Logging to file /u01/gw/logs/main.log
2018-06-18 19:56:23,836 INFO Outcomes of operations will be accumulated in /u01/gw/logs/status.log
Please enter gateway manager user:
api-gateway-manager                  
Password:
Please enter gateway manager client id:
<client_id>
Please enter gateway manager client secret:
<secret>
Please enter gateway manager runtime user:
api-gateway-runtime
Password:
Please enter gateway manager runtime client id:
<client_id>
Please enter gateway manager runtime client secret:
<secret>
2018-06-18 19:58:05,461 INFO Performing update oauth profile step.
2018-06-18 19:58:35,317 INFO Update oauth profile step complete. Status = UPDATE_EXECUTED .Please refer log file for details.
2018-06-18 19:58:35,318 INFO Execution complete.
```

When the installer is run, it generates a few logs to `<nodeInstallDir>`/logs

##### main.log
```
2018-06-18 19:56:23,836 INFO Logging to file /u01/gw/logs/main.log
2018-06-18 19:58:05,461 INFO Performing update oauth profile step.
2018-06-18 19:58:35,317 INFO Update oauth profile step complete. Status = UPDATE_EXECUTED .Please refer log file fo
r details.
2018-06-18 19:58:35,318 INFO Execution complete.
```
##### updateOAuthProfile.log
```
DEBUG:root:trying to fetch IDCS access token
DEBUG:root:Performing dev env SSL related workarounds
DEBUG:root:Calling https://idcs-ba024b83768889.identity.oraclecloud.com/oauth2/v1/token to fetch 
access token ...
DEBUG:root: Invoked access token call
DEBUG:root:Fetched Ok response
DEBUG:root:IDCS Access token fetch successful
DEBUG:root:Trying update oauthprofile = /u01/oauth/SampleOAuth.xml
DEBUG:root:Calling REST API to updateoauth profile on url = http://10.0.0.2:8011/apiplatform/gatewaynode/v1/securit
y/profile
DEBUG:root:Invoked REST API to update oauth profile.
DEBUG:root:Fetched OK response from REST API.
DEBUG:root:
INFO:main:Update oauth profile step complete. Status = UPDATE_EXECUTED .Please refer log file for details.
INFO:main:Execution complete.
```

## Next Steps
### Updating an API to validate and enforce an OAuth token
Follow the [OAuth policy tutorial](../../../manage/apis/policies/oauth/README.md) to learn how to configure an API to validate and enforce OAuth tokens
