
# Oracle Identity Cloud Service' SDK Node.js Sample Application

Oracle Identity Cloud Service provides a Software Development Kit (SDK) that you can use to integrate Node.js web applications with Oracle Identity Cloud Service.

The Node.js SDK is available as a passport strategy, called **passport-idcs**, and must be installed in the Node.js web application source code's node_modules folder.

This Sample Code is used in the following tutorial: [Use Oracle Identity Cloud Service's SDK for Authentication in Node.js Web Applications](https://apexapps.oracle.com/pls/apex/f?p=44785:112:0::::P112_CONTENT_ID:22661)

**Important:** The sample web application isn't meant to be published to production and isn't concerned about the language’s specific best practices, such as data handling, patterns, security, and so on. The sole purpose of the sample web application is to address the recommended approach to integrate Oracle Identity Cloud Service and a custom application using the SDK.

**Note:** Before deploying or using this sample application, it need to be updated following the instruction below:

## How to Update the Sample Application:

The sample web application needs an application's Client ID and Secret to establish communication with Oracle Identity Cloud Service.  Follow the referenced tutorial to register an application.

Access the Oracle Identity Cloud Service console, and add a Confidential Application with the following information:
- Populate the Details pane as follows, and then click Next.
    Name: SDK Web Application
    Description: SDK Web Application

- In the Client pane, select Configure this application as a client now, and then populate the fields of this pane, as follows:
    Allowed Grant Types: Select **Client Credentials** and **Authorization Code**.
    Allow non-HTTPS URLs: Select this check box. The sample application works in non-HTTPS mode.
    Redirect URL: http://localhost:3000/callback
    Post Logout Redirect URL: http://localhost:3000

- In the Client pane, scroll down, select Grant the client access to Identity Cloud Service Admin APIs., enter **Me** and **Authenticator Client**.  
- Finish, make a note of the **Client ID** and **Client Secret** values, and activate the application.

Access the Oracle Identity Cloud Service console, ddownload the SDK for Node.js, open the downloaded zip file, and extract the **passport-idcs** folder into the web application source code's node_modules folder.

Edit the **auth.js** file, update the ClientId, ClientSecret, IDCSHost and AudienceServiceUrl variables with the correct values for your Oracle Identity Cloud Service environment, and then save the file.
```javascript
var ids = {
  oracle: {
    "ClientId": "123456789abcdefghij",
    "ClientSecret": "abcde-12345-zyxvu-98765-qwerty",
    "ClientTenant": "idcs-abcd1234",
    "IDCSHost": "https:///%tenant%.identity.oraclecloud.com",
    "AudienceServiceUrl" : "https://idcs-abcd1234.identity.oraclecloud.com",
    "TokenIssuer": "https://identity.oraclecloud.com/",
    "scope": "urn:opc:idm:t.user.me openid",
    "logoutSufix": "/oauth2/v1/userlogout",
    "redirectURL": "http://localhost:3000/callback"
  }
};
module.exports = ids;
```

Below is a brief explanation  for each of the required attributes for the SDK:
- **ClientId**: Client ID value generated after you register the web application in Oracle Identity Cloud Service console.
- **ClientSecret**: Client Secret value generated after you register the web application in Oracle Identity Cloud Service console.
- **ClientTenant**: The domain prefix of you Oracle Identity Cloud Service instance. Usually a value similar to the example above.
- **IDCSHost**: The full qualified domain name URL of your Oracle Identity Cloud Service instance. It uses the */%tenant%* variable that is replaced by the **ClientTenant** attribute value.
- **AudienceServiceUrl**: The full qualified domain name URL of your Oracle Identity Cloud Service instance.
- **TokenIssuer**: Oracle recomends to keep the value as presented here.
- **scope**: Scope contols what data the application can access/process on behalf of the user. Since the application uses the SDK for authentication purpose the scope is openid. The application also implements the get user's details use case. In this case you need to also use the scope urn:opc:idm:t.user.me.

The **logoutSufix** and **redirectURL** are both used by the application, hence they are not required by the SDK.

The **/auth/oracle** route handler uses the IdcsAuthenticationManager.getAuthorizationCodeUrl() SDK's function to generate the authorization URL.
Four important parameters are used to generate the authorization code URL:
- **redirectUrl**: After successfull sign in, Oracle Identity Cloud Service redirects the user browser to this URL. This URL must match the one configured in the trusted application in Oracle Identity Cloud Service console.
- **scope**: The OAuth/OpenID Connect scope of authentication.
- **state**: The state value is meant to be a code that the sample web application might use to check if the communication was made correctly to Oracle Identity Cloud Service. The state parameter is defined by the OAuth protocol.
- **response_type**: The value **code** is required by the authorization code grant type.

The sample application handles the **/callback** route, and uses the authorization code, sent as a query parameter, to request an access token and id token. Both tokens are stored in the application's user session,  the access token is stored as a cookie, and then sent to the browser for future use.

The **IdcsAuthenticationManager.authorizationCode()** SDK's function also uses promise (then/catch statement) to set the access token as cookie, and to redirect the browser to the **/auth.html** page.

The **/home** and **/myProfile** URLs are protected resources. The sample web application uses the ensureAuthenticated function to handle these protected resources.

The **/myProfile** route's handler calls the **IdcsUserManager.getUser()** SDK's function to get the JSON object, which represents the user profile, and sends it to the **myProfile.handlebars** file to be rendered in the browser.

The **/logout** route's handler clears all the cookie previously set up, calls **req.logout()** function to remove the user session, and then redirects the user to Oracle Identity Cloud Service's log out URL.

## Run the Sample Web Application

- Open a command prompt, navigate to the **nodejs folder**, and enter `npm install` to install all of the necessary modules, which are specified in the **package.json** file.

- Extract the **passport-idcs** folder of the SDK zip file into the sample web application source code's **node_modules** folder.

- In the command prompt, run the `npm start` command to start the application

- Open a browser window, access the http://localhost:3000 URL, click **Log in**, and then click the Oracle red icon.

- The Oracle Identity Cloud Service Sign In page appears.

## License

Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

You may not use the identified files except in compliance with the Universal Permissive License (UPL), Version 1.0 (the "License.")

You may obtain a copy of the License at https://opensource.org/licenses/UPL.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
