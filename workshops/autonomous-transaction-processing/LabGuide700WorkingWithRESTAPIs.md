<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

November 08, 2018
</td>
<td class="td-banner">
# Lab 7: Working with REST APIs
</td></tr><table>

## Introduction

Oracle's Autonomous Transaction Processing cloud service provides all of the performance of the market-leading Oracle Database in an environment that is tuned and optimized for transaction processing workloads. Oracle Autonomous Transaction Processing ( or ATP ) service provisions in a few minutes and requires very little manual ongoing administration and is therefore ideal for developers to build and test their applications.

Often times, you would prefer to interact with your cloud services programmatically over REST rather than log into the cloud console and click through screens. Besides, by creating your own deployment and management scripts you can save and reuse your deployments, set gold standards and in fact store entire application infrastructure stacks as version controlled code.

The Oracle Cloud Infrastructure APIs are typical REST APIs that use HTTPS requests and responses and support HTTPS and SSL protocol TLS 1.2, the most secure industry standards.

Also, All Oracle Cloud Infrastructure API requests must be signed for authentication purposes. To create and sign your API requests, you must –
- Form the HTTPS request (SSL protocol TLS 1.2 is required).
- Create the signing string, which is based on parts of the request.
- Create the signature from the signing string, using your private key and the RSASHA256 algorithm.
- Add the resulting signature and other required information to the Authorization header in the request.

While these seem like a lot of steps and can make your curl statements look sick, they are meant to avoid using username/passwords and are based on the draft-cavage-httpsignatures-08 specification for secure communication over the internet.

Let's take a look at how to generate REST calls to the Oracle Cloud Infrastructure using a popular scripting language, node.js. While we are using node.js to build some sample calls to create and list Autonomous Database services, you may use similar concepts to build scripts in Python, Golang, Ruby, Perl, Java, C#, bash or even curl!

### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

- Learn how to generate REST calls to the Oracle Cloud Infrastructure using node.js

## Required Artifacts

- The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- node.js is installed in you local machine. If not you can follow download and installation instructions for your OS [here](https://nodejs.org/en/download/)
- Download this ATP-REST-nodejs.zip file

```
$ wget --no-check-certificate --content-disposition https://github.com/oracle/learning-library/blob/master/workshops/autonomous-transaction-processing/scripts/700/ATP-REST-nodejs.zip?raw=true
```

## Steps

### **STEP 1: Generate an ssh key pair in pem format**

- Generate a private key

```
mkdir ~/.oci

openssl genrsa -out ~/.oci/oci_api_key.pem 2048
```
- Change permission of the key generated

```
chmod go-rwx ~/.oci/oci_api_key.pem
```

- Generate a public key using the private key you just created

```
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
```

### **STEP 2: Upload the public key to your OCI account from the console and note down OCID's**

- Login to Oracle Cloud Infrastructure
- From top left Hamburger menu, select Identity -> Users

![](./images/700/Picture700-1.png)

- Pick respective user from the list of users and on the User page click 'Add API Keys' button.

![](./images/700/Picture700-2.png)

- Paste your oci_api_key_public.pem key text and click on Add. 

![](./images/700/AddPEMKey.png)

- The service generates a key Fingerprint. Save the fingerprint somewhere safe since you will need it to sign your API requests.

![](./images/700/Picture700-3.png)

- Navigate to Identity -> Users and select the user and copy User OCID.

![](./images/700/Picture700-4.png)

- Click on account information on top right corner and click on Tenancy.

![](./images/700/Picture700-5.png)

- Copy Tenancy OCID 

![](./images/700/Picture700-6.png)


- Tenancy OCID, User OCID, Fingerprint artifacts along with user's private key make up a unique signature that is used to sign the REST requests. 

#### Note: It is extremely important that you do not share this with anyone or expose it over an unencrypted network.


### **STEP 3: Run the following scripts you cloned from git**

- In the REST API scripts folder, install node package dependencies

```
cd ATP-REST-nodejs

npm install
```

- Let us take a look at the code you downloaded from the git repository. 

#### 1. auth.js

This module has all the user auth information used to generate the signature and other header information including compartments.

You will need to edit the following
- tenancyID 
- authUserId 
- keyFingerprint 
- privateKeyPath 
- compartments.

```
var fs = require('fs');
var os = require('os');


/* Begin ---- Tenant auth info */

var tenancyId=  "ocid1.tenancy.oc1..aaaaaaaawrgt5au6hbledhhyas2secm3q2atqiuvihck45rbi3jyc5tfyfga";
var authUserId= "ocid1.user.oc1..aaaaaaaavscszlxxcf2wnq73nxpguxtubvpxaklqbspmuuml7xxp26mbxmgq";
var keyFingerprint = "0d:33:d8:eb:9a:48:2a:15:cd:36:2e:f5:20:fe:b3:d3";
var Compartment = "ocid1.compartment.oc1..aaaaaaaai75jrzzbfe6t43fd6yivpqngk2tufisqnohacf3s26p6uhcgz7bq";
var privateKeyPath = "/Users/tejus/Desktop/sshkeys/oci_api_key.pem";

if(privateKeyPath.indexOf("~/") === 0) {
    privateKeyPath = privateKeyPath.replace("~", os.homedir())
}
var privateKey = fs.readFileSync(privateKeyPath, 'ascii');

/* End ---- Tenant auth info */

module.exports = {
tenancyId: tenancyId,
authUserId: authUserId,
keyFingerprint: keyFingerprint,
privateKey: privateKey,
Compartment: Compartment

};
```


#### Note: Make sure the privateKeyPath variable accurately points to the location of your private key file.

Compartments are Oracle’s way of providing isolation among users of a cloud account. Compartments can be created by users, departments, environment types etc and provide	a clear separation among entities that share a single OCI account / tenant.

Before you can create objects in your account, you would need to create a compartment and grant access to the user to that compartment by creating a suitable IAM policy.

Refer to Oracle's [IAM documentation](https://docs.oracle.com/en/cloud/paas/identity-cloud/index.html) to create and enable comartments.


#### 2. region.js

This module lists all the API endpoints for OCI. You do not need to change anything here unless a new service is added or Oracle makes a change to the URLs (which is less likely).

#### 3. headers.js

This module builds API signing keys and generates https headers required for your REST calls depending upon whether it's a GET, PUT, POST or DELETE call.

You do not need to modify anything here.

It also has an option getUser method used in every REST call to get user information from the Identity and Access Management services. You may use that example to generate other IAM REST calls.

#### 4. createAutonomousDatabase.js, listAutonomousDatabase.js, createVCN.js, getAutonomousDatabase.js, deleteAutonomousDatabase.js

These are the scripts you would need to run. Make sure the variable in each of these scripts are set right before you run them. 

For example, in the createAutonomousDatabase.js script, be sure to replace the following to match your requirements
- displayName
- dbName
- adminPassword
- cpuCoreCount
- dataStorageInTbs
- host region

```
var auth = require('./auth.js');
var regions = require('./regions.js');
var headers = require('./headers.js');
var https = require('https');
//Create autonomous database ATP

function createATP(callback) {

var body = JSON.stringify({
  "compartmentId" : auth.Compartment,
  "displayName" : "example_autonomous_database6",
  "dbName" : "adatabasedb6",
  "adminPassword" : "AVeryLongPassword321!",
  "cpuCoreCount" : 1,
  "dataStorageSizeInTBs" : 1
});
var options = {
        host: regions.dbPhoenixRegion,
        path: '/20160918/autonomousDatabases',
        method: 'POST',
        headers: {
            "Content-Type": "application/json"
        }
    };
var request = https.request(options, headers.handleRequest(callback));

    headers.sign(request, {
        body: body,
        privateKey: auth.privateKey,
        keyFingerprint: auth.keyFingerprint,
        tenancyId: auth.tenancyId,
        userId: auth.authUserId
    });

    request.end(body);
};

headers.getUser(auth.authUserId, function(data) {
    console.log(data);


    console.log("\nCREATING ATP Service:");

    
    createATP(function(data) {
        console.log(data);
    });

});
```

- Run these scripts as,

```
node <filename>.js
```

- As an example 

```
node createAutonomousDatabase.js
```

![](./images/700/Picture700-9.png)

- You have successfully created ATP database.

Explore the various scripts provided and build your own instance.

#### Note: Please do not forget to change region and other variables in each of the other scripts before you run them.

You may build similar scripts using Python, Java, golang, Perl, C#, bash and Curl.

-   You are now ready to move to the next lab.

<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
## Great Work - All Done!
</td>
</tr>
<table>