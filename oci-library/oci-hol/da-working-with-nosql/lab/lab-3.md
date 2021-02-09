## Introduction

In this lab, you learn how to connect to a NoSQL database table from a Node.js REST API.

## **STEP 1:** Connect to NoSQL database using NoSQLClient

To connect to the NoSQL table, you need to provide credentials. These credentials include the RSA key pair, public key fingerprint, the tenancy's OCID, and the user's OCID you created in one of the previous labs.

In addition to these credentials, you need the OCID of the compartment in which you created the NoSQL table. You can get the compartment OCID in the OCI Console by selecting **Identity** from the main menu and clicking **Compartments**. 

You can get the public key fingerprint by clicking the **Profile** icon, selecting **User Settings**, and clicking the **API Keys** link under **Resources**. 

The following Javascript code snippet shows how you connect to the NoSQL table using by using the `NoSQLClient` class and the credentials:

```javascript
<copy>
const client = new NoSQLClient({
    region: Region.US_ASHBURN_1,
    serviceType: ServiceType.CLOUD,
    compartment:
        'ocid1.compartment.oc1..example',
    auth: {
        iam: {
            tenantId:
                'ocid1.tenancy.oc1..example',
            userId:
                'ocid1.user.oc1..example',
            fingerprint: '12:34:56:78:90:ab:cd:ef:12:34:56:78:90:ab:cd:ef',
            passphrase: '',
            privateKeyFile: 'oci_api_key.pem',
        },
    },
});
</copy>
```

>You could also use the Oracle NoSQL Database Cloud Simulator, which simulates the cloud service and lets you write and test your application locally without accessing OCI. To learn more about the simulator and to download it, see [Developing in Oracle NoSQL Database Cloud Simulator](https://docs.oracle.com/en/cloud/paas/nosql-cloud/csnsd/developing-oracle-nosql-database-cloud-simulator.html).

## **STEP 2:** Writing the code

Create an `index.js` file in the `tasks-app` folder. In this file, connect to the NoSQL table, and create all the REST endpoints.

Copy the following contents to your `index.js` file:

```javascript
<copy>
const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

const { Region } = require('oracle-nosqldb');
const { ServiceType } = require('oracle-nosqldb/lib/constants');
const NoSQLClient = require('oracle-nosqldb').NoSQLClient;

const port = 3000;
let client = new NoSQLClient({
    region: Region.US_ASHBURN_1,
    serviceType: ServiceType.CLOUD,
    compartment:
        'ocid1.compartment.oc1..example',
    auth: {
        iam: {
            tenantId: 'ocid1.tenancy.oc1..example',
            userId: 'ocid1.user.oc1..example',
            fingerprint: '12:34:56:78:90:ab:cd:ef:12:34:56:78:90:ab:cd:ef',
            passphrase: '',
            privateKeyFile: 'oci_api_key.pem',
        },
    },
});

const TasksTableName = 'tasks';

// Create a new task
app.post('/', async (req, res) => {
    let { id, title, description, completed } = req.body;

    if (completed === undefined) {
        completed = false;
    }
    if (!id) {
        res.status(400).json({ err: 'id cannot be empty' });
        return;
    }

    try {
        const result = await client.put(TasksTableName, {
            id,
            title,
            description,
            completed,
        });
        res.json({ result: result.success});
    } catch (err) {
        console.error('failed to insert data', err);
        res.status(500).json({ error: err });
    }
});

// Get all tasks
app.get('/', async (req, res) => {
    try {
        const result = await client.query(`SELECT * FROM ${TasksTableName}`);
        res.json(result.rows);
    } catch (err) {
        console.error('failed to get data', err);
        res.status(500).json({ error: err });
    }
});

// Get a task by id
app.get('/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const result = await client.get(TasksTableName, { id })
        res.json(result.row);
    } catch (err) {
        console.error('failed to get data', err);
        res.status(500).json({ error: err });
    }
});

// Get completed tasks
app.get('/completed', async (req, res) => {
    try {
        const result = await client.query(
            `SELECT * FROM ${TasksTableName} WHERE completed`,
        );
        res.json(result.rows);
    } catch (err) {
        console.error('failed to get data', err);
        res.status(500).json({ error: err });
    }
});

// Get uncompleted tasks
app.get('/uncompleted', async (req, res) => {
    try {
        const result = await client.query(
            `SELECT * FROM ${TasksTableName} WHERE completed=false`,
        );
        res.json(result.rows);
    } catch (err) {
        console.error('failed to get data', err);
        res.status(500).json({ error: err });
    }
});

// Delete a task
app.delete('/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const result = await client.delete(TasksTableName, { id });
        res.json({ result: result.success});
    } catch (err) {
        console.error('failed to delete data', err);
        res.status(500).json({ error: err });
    }
});

app.listen(port, () => {
    console.log(`Tasks API listening at http://localhost:${port}`);
});
</copy>
```

Be sure to set the correct values for *compartment*, *tenantId*, *userId*, *fingerprint*, and *privateKeyFile*.

Finally, install the dependencies by running `npm install` and then run the application with `node index.js`. You should see an output like this:

```bash
$ node src/index.js
Tasks API listening at http://localhost:3000
```

## **STEP 3:** Testing the API

To test the API, open another terminal window and create a task using *curl*:

```bash
$ curl -X POST -d '{"id": 1, "title": "My first task", "description": "This is my first task", "completed": false }' -H 'content-type: application/json' localhost:3000

{"result":true}
```

You can then view the inserted data in the OCI Console.

1. In the Console, go to the NoSQL Database page.
2. From the list, click the **tasks** table.
3. Click the **Table rows** in the sidebar.
4. Click **Run query** to retrieve the data.

![Figure 2: Running a query](./images/run-a-query.png)

You can switch back to the terminal and get the same task by calling the API:

```
$ curl http://localhost:3000
[{"id":1,"title":"My first task","description":"This is my first task","completed":false}]
```