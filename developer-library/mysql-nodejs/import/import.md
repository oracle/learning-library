# Serverless Function to Import Data

## Introduction

First thing needed for our application is to get data into the database. We
assume that there is another cloud service, creating the data and storing it
on Object Store. Whenever a file is being uploaded there it will trigger an
event, which calls our serverless function.

Estimated Lab Time: 25 minutes

### Objectives

- Create a first serverless function with Node.js
- Import data from Object Store to MySQL

## **STEP 1:** Creating the Code for an Hello World

As with any good guide, the first Function built is a _Hello World_. The name
used is `import` since that describes the future purpose well:

    [opc@compute ~]$ mkdir import
    [opc@compute ~]$ cd import/
    [opc@compute import]$ fn init --runtime node 
    Function boilerplate generated.
    func.yaml created.

This creates a bunch of files.

* `func.yaml`: This file contains meta-data for the Fn framework.
* `package.json`: Same file as with other Node.js projects. It lists our dependencies etc. At the moment this is only the Fn Development Kit, fdk.
* `func.js`: The actual implementation of our function.

Take a look at func.js

    [opc@compute import]$ cat func.js 
    const fdk=require('@fnproject/fdk');

    fdk.handle(function(input){
      let name = 'World';
      if (input.name) {
        name = input.name;
      }
      console.log('\nInside Node Hello World function')
      return {'message': 'Hello ' + name}
    })

The way Fn works is that the framework will start inside a Docker container
Node with this script and the provided `handle` callback will invoked. If the
function is called again within a timeout of a few minutes the same Container
with the same Node.js instance will be reused. If it isn't called for a few
minutes a cleanup task will shut down.

## **STEP 2:** Deploying and running the Function

To see this in effect you have to deploy this into an Fn application. Our setup
created a function with the name `DemoApp`, which we will be using. No worries,
we will inspect this function in the Web Console in a minute.

 
    [opc@compute import]$ fn deploy --app DemoApp
    Deploying import to app: DemoApp
    Bumped to version 0.0.2
    ...
    Updating function import using image iad.ocir.io/.../..../import:0.0.2...

 With that the function is deployed and you can invoke it:

    [opc@compute import]$ fn invoke DemoApp import
    {"message":"Hello World"}
  
You will notice that the invocation takes a few seconds. This comes from the 
time it takes to instantiate the function. If you call it again, the response
will be fast.

If data is provided to the `fn` tool, the function can access it:

    [opc@compute import]$ echo -n '{"name": "my friend" }'  | fn invoke DemoApp import --content-type application/json
    {"message":"Hello my friend"}

To learn more about Fn please check the [Fn Project Website](https://fnproject.io/).

## **STEP 3:** Exploring the Console

In the Web Console you can find *Functions* under the *Developer Services* menu. 

  ![](images/faas_menu.png " ")

When opening it you see the Application, click on _DemoApp_.

  ![](images/faas_application.png " ")

If you can't find that entry make sure the `node-mysql` compartment has been
selected on the left. In case the `node-mysql` compartment is not listed in
the drop-down try reloading the page.

  ![](images/faas_func.png " ")

In this screen you can see the list of functions, currently our `import`
function. On the left is a menu leading, among other things, to metrics and
configuration.

*Metrics* provide you with different statistics regarding the environment. In the
*Configuration* section you can see that our setup pre-configured a set of,
variables which are available to the functions within this application. We will
make use of those in the next step.

  ![](images/faas_config.png " ")

*Note: As you can see here the MySQL user's password is stored in plain sight
in this setup. Since this is a tutorial this is tolerable. In a production
environment you should secure credentials by using OCI's Vault Service or some
other mechanism.*

## **STEP 4:** Talking to MySQL and Object Store

In this step we extend our Function to interpret information provided by a
Cloud Event, when a file is uploaded to Object Store. That file will be
downloaded, interpreted as a JSON file containing an array of objects and 
each object will then be stored into our Database's Collection we created
before.

First thing needed is to install the dependencies. Since we didn't have a 
`node_modules` folder before `fn` fetched the FDK library while deploying the
function. Let's install it locally, so we have all dependencies together:

    [opc@compute import]$ npm install
    npm notice created a lockfile as package-lock.json. You should commit this file.
    npm WARN hellofn@1.0.0 No repository field.
    
    added 1 package from 2 contributors and audited 1 package in 1.764s
    found 0 vulnerabilities

Then add the MySQL Connector/Node.js, which brings
the MySQL Document Store features for Node.js.
    
    [opc@compute import]$ npm install --save @mysql/xdevapi
    npm notice created a lockfile as package-lock.json. You should commit this file.
    npm WARN hellofn@1.0.0 No repository field.
    
    + @mysql/xdevapi@8.0.21
    added 3 packages from 6 contributors and audited 3 packages in 1.317s
    found 0 vulnerabilities

*Note: Fn can handle Node.js dependencies automatically, depending on the
presence of a `node_modules` directory. If that directory exists it will
be packaged as is during deployment. If it doesn't exist Fn will fetch
dependencies from `package.json` automatically. You have to ensure that
either your `package.json` and `node_modules` are in sync or remove
`node_modules` so Fn manages this.*

Now adapt `func.js` to do what we need:

    const fdk=require('@fnproject/fdk');
    const mysqlx = require('@mysql/xdevapi');
    const download = require('./download');

    fdk.handle(async function(input, env) {
        const config = env.config;

        const session = await mysqlx.getSession({
            host: config.mysql_host,
            port: config.mysql_port,
            user: config.mysql_user,
            password: config.mysql_pass,
        });
        const people = session.getSchema(config.mysql_schema).getCollection('people');

        try {
            const dataRaw = await download(`https://objectstorage.${config.cloud_region}.oraclecloud.com${input.data.resourceId}`);
            const data = JSON.parse(dataRaw);

            session.startTransaction();
            data.forEach(row => {
                people.add(row).execute();
            });
            await session.commit();
            return { success: true };
        } finally {
            session.close();
        }
    });

*Note: On the Compute Instance editors like `nano` and `vim` are preinstalled.
You can install other editors using the `yum` package manager. Instead of
editing files yourself you will find the code also in `/home/opc/step2` (`step1`
contains the Hello World) as well as part of `data/functions.tbz2` inside the 
`node-mysql-hol-tf.zip` file you initially downloaded at the beginning of this
course*

This script is quite straight-forward. It connects to the MySQL Database using
the values provided in the configuration we looked at above, downloads the file
and then stores each object into our collection.

Error handling is relatively basic: The script ensures that the database session
is closed in all cases and terminates on error leaving the cleanup to the Fn
framework. It also uses a database transaction, to make sure that either all or
none data is stored, to keep a consistent state.

*Note: For production-grade software the error handling should be improved. Also
it should track whether files have been fully processed or not.*

For downloading the files from Object Store a small library `download.js` is
being used, which wraps Node.js's `https` module behind a single function:

    const https = require('https');
    module.exports = (url) => {
        return new Promise((resolve, reject) => {
            https.get(url, (res) => {
                if (res.statusCode != 200) {
                    reject(new Error(`Failed to load. Status Code: ${res.statusCode}`));
                    res.resume();
                    return;
                }

                res.setEncoding('utf8');
                let rawData = '';
                res.on('data', (chunk) => { rawData += chunk; });
                res.on('end', () => {
                    resolve(rawData);
                });
            }).on('error', (e) => {
                reject(e);
            e});
        });
    };

*Note: The `download.js` file is provided in the `step2` directory as well.*

After getting the code ready it has to be deployed as before:

    [opc@compute import]$ fn deploy --app DemoApp
    Deploying import to app: DemoApp
    Bumped to version 0.0.3
    ...
    Updating function import using image iad.ocir.io/.../..../import:0.0.3...


## **STEP 5:** Configure the Event Handling

First thing we do is take a look at the Object Store in the console. Navigate
to it in your Web Browser.

  ![](images/os_menu.png " ")

  ![](images/os_buckets.png " ")

You will see that our initial setup already created two Buckets. A Bucket
is a collection of related files in Object store. For now we care about
the `import` Bucket.

Click on the `import` Bucket and ensure that `Emit Object Events` is
activated. In the center area you could upload files. In the left you get 
access to different options. You can take a look, but don't have to make
any changes.

  ![](images/os_import_event.png " ")

*Note: The Bucket is configured as Public. This makes Objects accessible to
everybody (who can guess the exact URL) world-wide. Outside this Lab you
should protect the files and use signed requests to download files*

Next configure the Event to trigger the Function. For that navigate to
*Application Integration* - *Events Service*.

  ![](images/event_menu.png " ")


And click *Create Rule* to create our Event. Enter `import` as *Display Name*
and a *Description*.

In the *Rule Conditions* box select *Condition* `Event Type`, *Service Name*
`Object Storage`, *Event Type* `Object - Create` and then click *+ Add Another
Condition*.

In the new row Pick `Attribute` as *Condition*, *Attribute* is `bucketName` and
*Attribute Values* `import`, the name of our Bucket.

Finally configure the Action, by setting *Action Type* `Functions`, *Function
Compartment* `node-mysql`, *Function Application* `DemoApp` and *Function*
`import`.

  ![](images/event.png " ")

With a click on *Create Rule* this rule becomes effective.

## **STEP 6:** Upload a file and verify the data arrived

Navigate back to the Object Storage page in the Console and open the `import`
Bucket. Click *Upload*. In the panel pick the `data1.json` file provided
within the `node-mysql-hol-tf.zip` file and click *Upload* in the panel.
Once the upload finishes you can close the panel and the view should update
and list the file.

After a few moments you can go back to MySQL Shell and verify the data is
there:

    [opc@compute import]$ mysqlsh 'mysqlx://root:N0d3js!MySQL@10.0.2.7:33060'
     MySQL  10.0.2.7:33060+ ssl  JS > session.getSchema('hol').getCollection('people').find().limit(5).execute();
    {
        "_id": "00005f7b5b290000000000000001",
        "city": {
            "name": "Adel",
            "state": "GA"
        },
        "last_name": "Ferra",
        "first_name": "Beata",
        "salary_history": [
            {
                "date": "2009-09-05",
                "salary": 170000
            },
            {
                "date": "2010-10-30",
                "salary": 178500
            },
        },
        {
            "date": "2018-11-17",
            "salary": 492752
        }
	...
        ]
    }
    ...
    5 documents in set (0.0011 sec)
     MySQL  10.0.2.7:33060+ ssl  JS > session.getSchema('hol').getCollection('people').count();
    1000

In this you can see the structure of the data and that we have 1,000 entries. In the next Lab
a Web Frontend will be added.

*Please proceed to the next lab.*

## Acknowledgements

- **Authors/Contributors** - Johannes Schlüter
- **Last Updated By/Date** - Johannes Schlüter, October 2020
- **Workshop Expiration Date** - October, 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 

