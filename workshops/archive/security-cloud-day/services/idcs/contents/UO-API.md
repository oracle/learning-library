
# User On-boarding - API

The Oracle Identity Cloud Service REST APIs support SCIM 2.0 compliant endpoints with standard SCIM 2.0 core schemas and Oracle schema extensions to programmatically manage users, groups, applications, and identity functions, such as password management and administrative tasks. 

To make REST API calls to your Oracle Identity Cloud Service environment, you need an OAuth2 access token to use for authorization. The access token provides a session (with scope and expiration), that your client application can use to perform tasks in Oracle Identity Cloud Service.

This demonstration runs on Jupyter notebook. This page is the static snapshot of the notebook file.

Click [here](UO-API.ipynb) to actually run the API's described here


```python
import requests, json
from ipywidgets import widgets, Layout
from IPython.display import display
from IPython.display import HTML
```

## 1 - Discovery

First let's gather information about your IDCS Tenant

Run the following cell after providing the following information
- Tenant
- Domain
- Port

Then you will discover the IDCS End Points automatically.

Explore by expanding the Discovered **`IDCS Configuration`**


```python
tenant = ""
domain = "identity.oraclecloud.com"
port = "443"

baseurl = 'https://' + tenant + '.' + domain + ':' + port
configurl =  baseurl + '/.well-known/idcs-configuration'
response = requests.get(configurl).text
config = json.loads(response)

configD = widgets.Accordion(children=[widgets.Textarea(value=json.dumps(config, indent=4, sort_keys=True), 
                                                             layout=Layout(width='100%', height='800px'))])
configD.set_title(0, 'IDCS Configuration')
configD.selected_index = None
display(configD)
```

The Discovery End-Point was public and so didn't require any Access Token or other form of authentication

___

## 2 - Access Token (2-legged OAuth)

Next We will get an OAuth Access Token  using 2-legged OAuth2 Authorization flow.

Check out the following diagram of 2-legged flow -

![OAuth2 2-Legged Diagram](resources/oauth2legged.jpg)

Some minimal setup in IDCS is needed for the flow. 

- Login to your [IDCS Admin Console]() using Administrator credentials
- Create an **App** that grants access to IDCS protected REST API's. 
- Record the `Client ID` and `Client Secret` from the App Configuration

Follow the video below to create your App in IDCS.


<iframe width="560" height="315" src="https://www.youtube.com/embed/A2LiNJRRINk?rel=0&amp;controls=1&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>



<iframe width="560" height="315" src="https://docs.oracle.com/en/cloud/paas/identity-cloud/17.4.2/rest-api/OATOAuthClientWebApp.html#GUID-51E5C29A-6B7E-487A-8832-5D709410C16A__RegisterAnOAuthClientWebApplication-29DDFF36" frameborder="0" allowfullscreen></iframe>



Now it's time to store the recorded `Client ID` and `Client Secret`. They will be used duing API call.


```python
from getpass import getpass 
#Lets get the App's Client ID and Client secret. They will be needed for proceted API calls
clientId = ""
clientSecret = ""
```

Having collected all the necessary data, you can now generate **Access Token** from IDCS.

The steps are -
- Find the Token End-Point URL from IDCS Discovery Configuation
- Specify the grant type as `password`
- Pass the `Client ID` and `Client Secret` in base-64 encoded format as **HTTP Basic Authentication** header.  
    > The format of the data is -
    **<font color="blue">b64encode(Client ID:Client Secret)</font>**
- Make an **HTTP POST** call to the Token End-Point URL
    - Include the `Authentication` Header
    - POST data should contain - `Grant Type`, `User ID`, `User Password` and `Scope`
- The POST response will contain the issued **Access Token**
  
View the **AT** from displayed Output   


```python
import base64, urllib.parse

#Find the OAuth2 Token Endpoint from Discovery Config
tokenurl = config["openid-configuration"]["token_endpoint"]

grant_type = "client_credentials"
scope = "urn:opc:idm:__myscopes__"

#Token Endpoint needs the App Creds in base64 encoded Header
basicauthHeader = base64.b64encode(bytes(clientId + ":" + clientSecret, 'utf-8')) 
#reqdata = {'grant_type': grant_type, 'scope' : scope}
reqheaders = {'Authorization': 'Basic ' + basicauthHeader.decode("utf-8"), 'content-type': 'application/x-www-form-urlencoded'}

response = requests.post(tokenurl, data = reqdata, headers = reqheaders)
accesstoken = response.json()["access_token"]
accesstokenD = widgets.Accordion(children=[widgets.Textarea(value=accesstoken, layout=Layout(width='100%', height='400px'))])
accesstokenD.set_title(0, 'Access Token')
accesstokenD.selected_index = None
display(accesstokenD)
```

___

## 3 - User Management

Armed with Access Token having **Scopes** that grant access to **User Administrator** level Admin API's, let's now get all the users currently in **IDCS**.

Run the following cell to display IDCS Users with their **Email Address** and internal **ID** values

> Notice that the User REST API call contains an **Authorization** Header where the **AT** is passed as a **Bearer Token**


```python
userurl = baseurl + "/admin/v1/Users"

uheaders = {'Authorization': 'Bearer ' + accesstoken, 'content-type': 'application/json'}
userlist = requests.get(userurl, headers = uheaders).json()["Resources"]
userDF = pd.DataFrame(userlist)
userDispList = [userDF["userName"], 
                userDF.emails.apply(lambda x: x[0]["value"] if x[0]["primary"] == True else x[1]["value"]), 
                userDF["id"]]
userDispDF = pd.concat(userDispList, axis=1)

HTML(userDispDF.to_html())

```

#### Additional Resources:

[IDCS REST API](https://docs.oracle.com/en/cloud/paas/identity-cloud/idcsa/index.html)

[What is SCIM](http://www.ateam-oracle.com/what-is-scim/)
