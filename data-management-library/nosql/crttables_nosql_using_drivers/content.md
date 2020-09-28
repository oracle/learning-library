<!-- Start by renaming this file with the same name as the lab folder, for example, provision-adb.md -->
# Get Started with Tables in Oracle NoSQL Database Cloud Service Using <if type="Java">Java </if><if type="Python">Python</if><if type="Go">Go</if><if type="Node.js">Node</if>
## Before you Begin
This 15-minute tutorial walks you through the steps to connect to Oracle NoSQL Database Cloud Service and do basic table level operations using a sample application.

### Background

Oracle NoSQL Database Cloud Service is a fully managed database cloud service that handles large amounts of data at high velocity. As a developer, you can connect to the Oracle NoSQL Database Cloud Service and work with NoSQL tables using the NoSQL SDKs available in multiple languages.

Developers can start using this service in minutes by following the simple steps outlined in this tutorial. To get started with the service, you create a table.

After you sign up for an Oracle NoSQL Database Cloud Service account, you can easily create and populate a table by following these steps:

* Generate required keys and get the Tenancy ID and User ID
* Create a <if type="Java">Java</if> <if type="Python">Python</if><if type="Go">Go</if><if type="Node.js">Node.js</if> application with the required credentials
* Execute the application to connect to Oracle NoSQL Database Cloud Service

### What Do You Need?
<if type="Java">* Download and install Oracle NoSQL Java SDK from [Oracle Cloud Downloads](https://www.oracle.com/downloads/cloud/nosql-cloud-java-driver-downloads.html).
* Access the [Java API Reference Guide](https://docs.oracle.com/en/cloud/paas/nosql-cloud/csnjv/index.html) to reference Java driver packages, methods, and interfaces.
* You can either create a [free trial account](https://www.oracle.com/cloud/free) or buy a [paid subscription](https://myservices.us.oraclecloud.com/mycloud/signup?selectedPlan=PAYG&language=en&sourceType=_ref_coc-asset-opcHome) by navigating to [oracle.com](https://www.oracle.com/database/nosql-cloud.html).</if>

<if type="Python">* Download and install Oracle NoSQL Python SDK from [GitHub](https://github.com/oracle/nosql-python-sdk/releases). See [Downloading and Installing the SDK](https://nosql-python-sdk.readthedocs.io/en/stable/installation.html) for reference.
* Access the [Python API Reference Guide](https://nosql-python-sdk.readthedocs.io/en/latest/api.html) to reference Python driver packages, methods, and interfaces.
* You can either create a [free trial account](https://www.oracle.com/cloud/free) or buy a [paid subscription](https://myservices.us.oraclecloud.com/mycloud/signup?selectedPlan=PAYG&language=en&sourceType=_ref_coc-asset-opcHome) by navigating to [oracle.com](https://www.oracle.com/database/nosql-cloud.html).</if>

<if type="Go">* Download and install GO 1.12 or later version binary release suitable for your system from [Go Downloads](https://golang.org/dl/).
* Add the directory that contains the `go` executable into your system PATH, for example:

   `export PATH=/usr/local/go/bin:$PATH`
* Access the [online godoc](https://godoc.org/github.com/oracle/nosql-go-sdk/nosqldb) for information on using the SDK and to reference Go driver packages, types, and methods.
* You can either create a [free trial account](https://www.oracle.com/cloud/free) or buy a [paid subscription](https://myservices.us.oraclecloud.com/mycloud/signup?selectedPlan=PAYG&language=en&sourceType=_ref_coc-asset-opcHome) by navigating to [oracle.com](https://www.oracle.com/database/nosql-cloud.html).</if>

<if type="Node.js"> * Download and install Node.js 12.0.0 or higher version from [Node.js Downloads](https://nodejs.org/en/download/).
* Ensure that Node Package Manager (npm) is installed along with Node.js
* Download and install Oracle NoSQL Node.js SDK from [GitHub](https://github.com/oracle/nosql-node-sdk/releases). See [Connecting an Application to Oracle NoSQL Database Cloud Service](https://oracle.github.io/nosql-node-sdk/tutorial-connect-cloud.html) for instructions.
* Access the [Node.js API Reference Guide](https://oracle.github.io/nosql-node-sdk/index.html) to reference Node.js classes, events, and global objects.
* You can either create a [free trial account](https://www.oracle.com/cloud/free) or buy a [paid subscription](https://myservices.us.oraclecloud.com/mycloud/signup?selectedPlan=PAYG&language=en&sourceType=_ref_coc-asset-opcHome) by navigating to [oracle.com](https://www.oracle.com/database/nosql-cloud.html).</if>

##  Acquire the Credentials

1. Acquire the following credentials that are required for running this sample application.
    * OCID of the tenancy.
    * OCID of the user calling the API.
    * Fingerprint for the key pair being used.
    * Full path and filename of the private key.
    * The passphrase used for the key, if it is encrypted.

##  Update the Sample Application
<if type="Java">
1. Copy the HelloWorld.java application to an editor of your choice. You use this application to connect to Oracle NoSQL Database Cloud Service.
You can access the [JavaAPI Reference Guide](https://docs.oracle.com/en/cloud/paas/nosql-cloud/csnjv/index.html) to reference Java classes, methods, and interfaces included in this sample application.
```
<copy>
import java.io.File;
import oracle.nosql.driver.NoSQLHandle;
import oracle.nosql.driver.NoSQLHandleConfig;
import oracle.nosql.driver.NoSQLHandleFactory;
import oracle.nosql.driver.Region;
import oracle.nosql.driver.iam.SignatureProvider;
import oracle.nosql.driver.ops.GetRequest;
import oracle.nosql.driver.ops.GetResult;
import oracle.nosql.driver.ops.PutRequest;
import oracle.nosql.driver.ops.PutResult;
import oracle.nosql.driver.ops.TableLimits;
import oracle.nosql.driver.ops.TableRequest;
import oracle.nosql.driver.ops.TableResult;
import oracle.nosql.driver.values.MapValue;

public class HelloWorld {
    /* Name of your table */
    final static String tableName = "HelloWorldTable";

    public static void main(String[] args) {
        NoSQLHandle handle = null;
        try {
            handle = generateNoSQLHandle();
            createTable(handle);
            writeRows(handle);
            readRows(handle);
            dropTable(handle);
        } catch (Exception e) {
            System.err.print(e);
        } finally {
            handle.close();
        }
    }

    /* Create a NoSQL handle to access the cloud service */
    private static NoSQLHandle generateNoSQLHandle() throws Exception {

        SignatureProvider ap = new SignatureProvider();
                "<your tenancy OCID>",
                "<your user OCID>",
                "<fingerprint of your public key>",
                new File("<full path to your private key file>"),
                "<optional passphrase>".toCharArray());

        /* Create a NoSQL handle to access the cloud service */
        NoSQLHandleConfig config = new NoSQLHandleConfig(
                Region.US_PHOENIX_1, ap);
        NoSQLHandle handle = NoSQLHandleFactory.createNoSQLHandle(config);
        return handle;
    }

    /**
      * Create a simple table with an integer key
      * and a single string data field
      * and set your desired table capacity
      */
    private static void createTable(NoSQLHandle handle) throws Exception {
        String createTableDDL = "CREATE TABLE IF NOT EXISTS " +
                tableName + "(employeeid INTEGER, name STRING, " +
                "PRIMARY KEY(employeeid))";

        TableLimits limits = new TableLimits(1, 2, 1);
        TableRequest treq = new TableRequest()
                .setStatement(createTableDDL).setTableLimits(limits);

        System.out.println("Creating table " + tableName);
        TableResult tres = handle.tableRequest(treq);

        /* The request is async,
          * so wait for the table to become active.
          */
        System.out.println("Waiting for "
                + tableName + " to become active");
        tres.waitForCompletion(handle, 60000, /* wait 60 sec */
                1000); /* delay ms for poll */
        System.out.println("Table " + tableName + " is active");
    }

    /**
      * Make a row in the table and write it
      */
    private static void writeRows(NoSQLHandle handle) throws Exception {
        MapValue value =
                new MapValue().put("employeeid", 1).put("name", "Tracy");
        PutRequest putRequest =
                new PutRequest().setValue(value).setTableName(tableName);
        PutResult putResult = handle.put(putRequest);
        if (putResult.getVersion() != null) {
            System.out.println("Wrote " + value);
        } else {
            System.out.println("Put failed");
        }
    }

    /**
      * Make a key and read the row from the table
      */
    private static void readRows(NoSQLHandle handle) throws Exception {
        MapValue key = new MapValue().put("employeeid", 1);
        GetRequest getRequest =
                new GetRequest().setKey(key).setTableName(tableName);
        GetResult getResult = handle.get(getRequest);
        if (getResult.getVersion() != null) {
            System.out.println("Wrote " + getResult.getValue());
        } else {
            System.out.println("Get failed");
        }
    }

    /**
      * Drop the table and wait for the table to move to dropped state
      */
    private static void dropTable(NoSQLHandle handle) throws Exception {
        System.out.println("Dropping table " + tableName);
        TableRequest treq = new TableRequest()
                .setStatement("DROP TABLE IF EXISTS " + tableName);
        TableResult tres = handle.tableRequest(treq);
        System.out.println("Waiting for " + tableName + " to be dropped");
        tres.waitForCompletion(handle, 60000, /* wait 60 sec */
                1000); /* delay ms for poll */
        System.out.println("Table " + tableName + " has been dropped");
    }
}
</copy>
```
2. In the `generateNoSQLHandle` method, update the appropriate Oracle Cloud Infrastructure region.
3. In the `generateNoSQLHandle` method, update the parameters of the `SignatureProvider` constructor with the   following values.
    * OCID of the tenancy.
    * OCID of the user calling the API.
    * Fingerprint for the key pair being used.
    * Full path and filename of the private key.
    * The passphrase used for the key, if it is encrypted. This should be a character array.
4. Save the application as `HelloWorld.java` in your local system.
 </if>
 <if type="Python">
 1. Copy the code given below to an editor of your choice. You use this program to connect to Oracle NoSQL Database Cloud Service and create a simple NoSQL Table.
You can access the [Python API Reference Guide](https://nosql-python-sdk.readthedocs.io/en/latest/api.html) to reference Python classes, methods, and interfaces included in this sample application.
 ```
 <copy>
 import os

from borneo import (Regions, NoSQLHandle, NoSQLHandleConfig, PutRequest,
                    TableRequest, GetRequest, TableLimits, State)
from borneo.iam import SignatureProvider

# Given a region, and compartment, instantiate a connection to the
# cloud service and return it
def get_connection(region, compartment):
    print("Connecting to the Oracle NoSQL Cloud Service")
    provider = SignatureProvider(
        tenant_id='<your tenancy OCID>',
        user_id='<your user OCID>',
        private_key='<full path to your private key file>',
        fingerprint='<fingerprint of your public key>',
        pass_phrase='<optional passphrase>')

    config = NoSQLHandleConfig(region, provider)
    config.set_default_compartment(compartment)
    return(NoSQLHandle(config))

# Given a handle to the Oracle NoSQL Database cloud service,
# this function will create the hello_world table with two columns
# and set the read units to 1, write units to 1, and GB storage to 1
def create_table(handle):
    statement = 'create table if not exists hello_world (id integer, content JSON,  primary key(id))'
    print('Creating table: ' + statement)
    request = TableRequest().set_statement(statement).set_table_limits(TableLimits(1, 1, 1))

    # Ask the cloud service to create the table, waiting for a total of 40000 milliseconds
    # and polling the service every 3000 milliseconds to see if the table is active
    table_result = handle.do_table_request(request, 40000, 3000)
    table_result.wait_for_completion(handle, 40000, 3000)
    if (table_result.get_state() != State.ACTIVE):
        raise NameError('Table hello_world is in an unexpected state ' + str(table_result.get_state()))

# Given a handle to the Oracle NoSQL Database cloud service, the name of the table
# to write the record to, and an instance of a dictionary, formatted as a
# record for the table, this function will write the record to the table
def write_a_record(handle, table_name, record):
    request = PutRequest().set_table_name(table_name)
    request.set_value(record)
    handle.put(request)

# Given a handle to the Oracle NoSQL Database cloud service, the name of the table
# to read from, and the primary key value for the table, this function will
# read the record from the table and return it
def read_a_record(handle, table_name, pk):
    request = GetRequest().set_table_name(table_name)
    request.set_key({'id' : pk})
    return(handle.get(request))

def main():

    handle = get_connection(Regions.your-region-id,'your-compartment-id')
    create_table(handle)

    record = {'id' : 1, 'content' : {'hello' : 'world'}}
    write_a_record(handle, 'hello_world', record)
    print('Wrote record: \n\t'  + str(record))

    the_written_record = read_a_record(handle, 'hello_world', 1)
    print('Read record: \n\t' + str(record))
    os._exit(0)

if __name__ == "__main__":
    main()
    </copy>
 ```
 2. In the `get_connection` method, set the following values:
    * OCID of the tenancy.
    * OCID of the user calling the API.
    * Full path and filename of the private key.
    * Fingerprint for the key pair being used.
    * The passphrase used for the key, if it is encrypted. This should be a character array.

 3. Set the parameters for invoking the `get_connection` method with the following values:
    * Oracle Cloud Infrastructure region ID. For example, `Regions.US_ASHBURN_1`
    * Compartment ID where you want to create your table. This can be a dot separated path.

 4. Save the program as `HelloWorld.py` in your local system..
  </if>
  <if type="Go">
  1. Copy the code given below to an editor of your choice. You use this program to connect to Oracle NoSQL Database Cloud Service and create a simple NOSQL Table.
 You can access the [online godoc](https://godoc.org/github.com/oracle/nosql-go-sdk/nosqldb) to reference Go classes, types, and methods included in this sample application.
  ```
  <copy>
  package main

import (
  "fmt"
  "time"

  "github.com/oracle/nosql-go-sdk/nosqldb"
  "github.com/oracle/nosql-go-sdk/nosqldb/auth/iam"
  "github.com/oracle/nosql-go-sdk/nosqldb/jsonutil"
  "github.com/oracle/nosql-go-sdk/nosqldb/types"
  "github.com/oracle/nosql-go-sdk/nosqldb/httputil"
)

// createClient creates a client with the supplied configurations.

func createClient() (*nosqldb.Client, error) {

    var cfg nosqldb.Config

    // This program demonstrates two approaches for supplying configurations
    // for cloud service.
    //
    //   1. Directly in this program.
    //   2. Use a configuration file.
    //
    // If you use the second approach, set "useConfigFile" to true.
    useConfigFile := false

    // Set desired region id for NoSQL cloud service. e.g. us-ashburn-1
    region := "<your region ID>"

    // Set desired compartment name or id.
    // Set to an empty string to use the default compartment, that is
    // the root compartment of the tenancy.
    // If using a nested compartment, specify the full compartment path
    // relative to the root compartment as compartmentID.
    // For example, if using rootCompartment.compartmentA.compartmentB, the
    // compartmentID should be set to compartmentA.compartmentB.
    // Alternatively you can use the compartment OCID as the
    // string value.
    compartmentID := "<your compartment ID>"

    if !useConfigFile {
      // Set the following information accordingly:
      //
      //   tenancy OCID
      //   user OCID
      //   fingerprint of your public key
      //   your private key file or private key content
      //   passphrase of your private key
      //
      tenancy := "<your tenancy OCID>"
      user := "<your user OCID>"
      fingerprint := "<fingerprint of your public key>"
      privateKey := "<full path to your private key file>"
      // If passphrase is not required, use an empty string
      privateKeyPassphrase := "<optional passphrase>"

      sp, err := iam.NewRawSignatureProvider(tenancy, user, region, fingerprint,
        compartmentID, privateKey, &privateKeyPassphrase)
      if err != nil {
        return nil, fmt.Errorf("cannot create a Signature Provider: %v", err)
      }

      cfg = nosqldb.Config{
        Region:                nosqldb.Region(region),
        AuthorizationProvider: sp,
      }

    } else {
      // Modify and save the following content into the
      // configuration file $HOME/.oci/config.
      //
      // [DEFAULT]
      // tenancy=<your tenancy OCID>
      // user=<your user OCID>
      // fingerprint=<fingerprint of your public key>
      // key_file=<full path to your private key file>
      // pass_phrase=<optional passphrase>
      //
      sp, err := iam.NewSignatureProviderFromFile("~/.oci/config", "", "", compartmentID)
      if err != nil {
        return nil, fmt.Errorf("cannot create a Signature Provider: %v", err)
      }
      cfg = nosqldb.Config{
        Mode:                  "cloud",
        Region:                nosqldb.Region(region),
        AuthorizationProvider: sp,

        HTTPConfig: httputil.HTTPConfig{
          InsecureSkipVerify: true,
        },
      }
    }

  client, err := nosqldb.NewClient(cfg)
  return client, err
}

func main() {
  client, err := createClient()
  if err != nil {
    fmt.Printf("cannot create NoSQL client: %v\n", err)
    return
  }
  defer client.Close()

  // Creates a simple table with a LONG key and a single STRING field.
  tableName := "go_quick_start"
  stmt := fmt.Sprintf("CREATE TABLE IF NOT EXISTS %s ("+
    "id LONG, "+
    "test_data STRING, "+
    "PRIMARY KEY(id))",
    tableName)
  tableReq := &nosqldb.TableRequest{
    Statement: stmt,
    TableLimits: &nosqldb.TableLimits{
      ReadUnits:  50,
      WriteUnits: 50,
      StorageGB:  2,
    },
  }
  tableRes, err := client.DoTableRequest(tableReq)
  if err != nil {
    fmt.Printf("cannot initiate CREATE TABLE request: %v\n", err)
    return
  }

  // The create table request is asynchronous, wait for table creation to complete.
  _, err = tableRes.WaitForCompletion(client, 60*time.Second, time.Second)
  if err != nil {
    fmt.Printf("Error finishing CREATE TABLE request: %v\n", err)
    return
  }
  fmt.Println("Created table ", tableName)

  // put a simple set of string data
  mapVals := types.ToMapValue("id", 12345)
  mapVals.Put("test_data", "This is a sample string of test data")
  putReq := &nosqldb.PutRequest{
    TableName: tableName,
    Value:     mapVals,
  }
  putRes, err := client.Put(putReq)
  if err != nil {
    fmt.Printf("failed to put single row: %v\n", err)
    return
  }
  fmt.Printf("Put row: %v\nresult: %v\n", putReq.Value.Map(), putRes)

  // get data back
  key := &types.MapValue{}
  key.Put("id", 12345)
  getReq := &nosqldb.GetRequest{
    TableName: tableName,
    Key:       key,
  }
  getRes, err := client.Get(getReq)
  if err != nil {
    fmt.Printf("failed to get single row: %v\n", err)
    return
  }

  if getRes.RowExists() {
    fmt.Printf("Got row: %v\n", getRes.ValueAsJSON())
  } else {
    fmt.Printf("The row does not exist.\n")
  }

  // Delete the row
  delReq := &nosqldb.DeleteRequest{
    TableName: tableName,
    Key:       key,
  }
  delRes, err := client.Delete(delReq)
  if err != nil {
    fmt.Printf("failed to delete single row: %v\n", err)
    return
  }

  if delRes.Success {
    fmt.Printf("Deleted key: %v\nresult: %v\n", jsonutil.AsJSON(delReq.Key.Map()), delRes)
  }

  // Drop the table
  dropReq := &nosqldb.TableRequest{
    Statement: "DROP TABLE IF EXISTS " + tableName,
  }
  tableRes, err = client.DoTableRequestAndWait(dropReq, 60*time.Second, time.Second)
  if err != nil {
    fmt.Printf("failed to drop table: %v\n", err)
    return
  }
  fmt.Println("Dropped table ", tableName) }
  </copy>
  ```
  2. Set the following values under `case "cloud":` in the `createClient` function:
      * Region identifier
      * Optional compartment ID
      * OCID of the tenancy.
      * OCID of the user calling the API.
      * Fingerprint for the key pair being used.
      * Full path and filename of the private key.
      * The passphrase used for the key, if it is encrypted. This should be a character array.

  3. Create a directory `quickstart`, and save the example program as `quickstart.go` in the directory.
 </if>
   <if type="Node.js">
   1. Copy the code given below to an editor of your choice. You use this application to connect to Oracle NoSQL Database Cloud Service.
  You can access the [Node.js API Reference Guide](https://oracle.github.io/nosql-node-sdk/index.html) to reference Node.js classes, events, and global objects.
   ```
   <copy>
   'use strict';

const NoSQLClient = require('oracle-nosqldb').NoSQLClient;
const Region = require('oracle-nosqldb').Region;

/**
  * Call the main function tfor this example
  **/
doHelloWorld();

/** This function will authenticate with the cloud service,
  * create a table, write a record to the table, then read that record back
  **/
async function doHelloWorld() {
    try {
        let handle = await getConnection(Region.'your-service-region');
        await createTable(handle);
        await writeARecord(handle, {
            id : 1,
            content : {
                'hello' : 'world'
                }
            }
        );

        console.log("Wrote a record with primary key 1")
        let theRecord = await readARecord(handle, 1);
        console.log('Successfully read the record: ' + JSON.stringify(theRecord.row));
        process.exit(0);
    } catch (error) {
        console.log(e);
        process.exit(-1);
    }
}

/**
  * Create and return an instance of a NoSQLCLient object. NOTE that
  * you need to fill in your cloud credentials and the compartment
  * where you want your table created. Compartments can be dot seperated
  * paths.  For example: developers.dave.
  *
  * @param {Region} which Region An element in the Region enumeration
  * indicating the cloud region you wish to connect to
  */
function getConnection(whichRegion) {
    return new NoSQLClient({
        compartment: 'your-compartment-id',
        region: whichRegion,
        auth: {
                iam: {
                    tenantId: '<your tenancy OCID>',
                    userId: '<your user OCID>',
                    fingerprint: '<fingerprint of your public key>',
                    privateKeyFile: '<full path to your private key file>',
                    passphrase: '<optional passphrase>'
                }
            }
    });
}

/**
  * This function will create the hello_world table with two columns,
  * one long column which will be the primary key and one JSON column.
  *
  * @param {NoSQLClient} handle An instance of NoSQLClient
  */
  async function createTable(handle) {
    const createDDL = `CREATE TABLE IF NOT EXISTS hello_world (id LONG, content JSON, PRIMARY KEY(id))`;
    console.log('Create table: ' + createDDL);

        let res =  await handle.tableDDL(createDDL, {
            complete: true,
            tableLimits: {
                readUnits: 1,
                writeUnits: 1,
                storageGB: 1
            }
        });  
}

/**
  * Writes a single record to the hello_world table
  *
  * @param {NoSQLClient} handle an instance of NoSQLClient
  * @param {Object} record A JSON object representing
  * record to write to hello_world.  
  */
async function writeARecord(handle, record) {
    await handle.put('hello_world', record);
}

/**
  * Reads and returns a record from the hello_world table
  *
  * @param {NoSQLClient} handle an instance of NoSQLClient
  * @param {number} pk The primary key of the record to retrieve
  */
async function readARecord(handle, pk) {
    return await handle.get('hello_world', {
        'id' : pk
    })
}
</copy>
   ```
   2. In the function `doHelloWorld`, replace **'your-service-region'** with the appropriate Oracle Cloud Infrastructure region. For example:

   `let handle = await getConnection(Region.US_ASHBURN_1);`

   3. Set the following values in the `getConnection` function:

      * Compartment ID where you want to create your table. This can be a dot separated path.
      * OCID of the tenancy.
      * OCID of the user calling the API.
      * Fingerprint for the key pair being used.
      * Full path and filename of the private key.
      * The passphrase used for the key, if it is encrypted. This should be a character array.

   4. Save the example program as `HelloWorld.js` in your local system.
    </if>
## Add the Credentials in OCI Configuration File
Alternatively, instead of hard coding OCID, fingerprint & key credentials in the program, you can add this information in the Oracle Cloud Infrastructure configuration file and add that configuration file in the <if type="Java">`HelloWorld.java` application.</if><if type="Python">`HelloWorld.py` application.</if><if type="Go">`quickstart.go` application.</if><if type="Node.js">`HelloWorld.js` application.</if>

Note: This section is required only if you want to execute the example using OCI credential file. Else, you can skip this section and go to the [Execute the Sample Application](#ExecutetheSampleApplication) section.
1. Create a directory named `~/.oci`.
2. Create an OCI configuration file named `config` and place it in the above directory.
3. Open the `config` file and add the following code in it, and replace the placeholder values with actual values.
```
<copy>
[DEFAULT]
tenancy=ocid1.tenancy.oc1..<unique_ID>
user=ocid1.user.oc1..<unique_ID>
fingerprint=<fingerprint of your public key>
key_file=~/.oci/oci_api_key.pem
pass_phrase=<optional passphrase>
</copy>
```

**Note:** This is the `DEFAULT` profile. The OCI configuration file can contain several profiles.
4. Update the details in the `config` file with the following values.
    * OCID of the tenancy.
    * OCID of the user calling the API.
    * Fingerprint for the key pair being used.
    * Full path and filename of the private key.
    * The passphrase used for the key, if it is encrypted.
  <if type="Java">  
5. In the `HelloWorld.java` program, in the `generateNoSQLHandle` method, update the `SignatureProvider` parametrized constructor as described below.
    * If using the `DEFAULT` profile with the `config file` in default location `~/.oci/config`
    ```
    <copy>
    SignatureProvider ap = new SignatureProvider();
    </copy>

     ```
    * If using non-default profile `TEST` with the `config file` in default location `~/.oci/config`
```
<copy>
SignatureProvider ap = new SignatureProvider("TEST");
</copy>

```
  * If using non-default profile `DEV` with the `config file` at non-default location such as `/home/users/config`
```

<copy>
SignatureProvider ap = new SignatureProvider("/home/users/config","DEV");
</copy>

```
6. Save the `HelloWorld.java` application.
</if>

<if type="Python">  
5. In the `HelloWorld.py` program, in the `get_connection` method, update the `SignatureProvider` parametrized constructor as described below.
  * If using the `DEFAULT` profile with the `config` file in default location `~/.oci/config`.
```
<copy>
  provider = SignatureProvider()
  </copy>
```
* If using non-default profile `myprofile` with the `config` file in non-default location.
```
<copy>
provider = SignatureProvider(config_file='myconfigfile', profile_name='myprofile')
</copy>
```

6. Save the `HelloWorld.py` application.
</if>

<if type="Go">  
5. In the `quickstart.go` program, set the flag `useConfigFile` to true, under `case "cloud"`

 `useConfigFile := true`
6. Provide appropriate parameters for `iam.NewSignatureProviderFromFile` method:

  * If using the `DEFAULT` profile with the `config` file in default location `~/.oci/config`.
```
    <copy>sp, err := iam.NewSignatureProviderFromFile("~/.oci/config", "", "", compartmentID)</copy>
```
* If using non-default profile `TEST` with the `config` file in default location `~/.oci/config`.
```
  <copy>sp, err := iam.NewSignatureProviderFromFile("~/.oci/config", "TEST", "", compartmentID)</copy>
```
* If using non-default profile `DEV` with the `config` file at non-default location such as`/home/users/config`.
```
  <copy>sp, err := iam.NewSignatureProviderFromFile("/home/users/config", "DEV", "", compartmentID)</copy>
```

7. Save the `quickstart.go` program.
</if>

<if type="Node.js">  
5. In the `HelloWorld.js` program, in the `getConnection` function, modify the code as described below:

  * If using the `DEFAULT` profile with the `config` file in default location `~/.oci/config`, you need not provide authentication details explicitly. Therefore, comment the following lines of code in the `HelloWorld.js` program.

```
<copy>
     /* auth: {
        iam: {
            tenantId: 'your-tenancy-OCID',
            userId: 'your-user-OCID',
            fingerprint: 'fingerprint-for-your-key-pair',
            privateKeyFile: 'fully-qualified-path-to-your-private-key-file',
            passphrase: 'passphrase-used-to-create-your-private-key'
        }
    } */
    </copy>
```
  * If using non-default profile `TEST` with the config file in default location `~/.oci/config`.
```
<copy>
     auth: {
        iam: {
          profileName: 'TEST'
        }
    }
    </copy>
```
  * If using non-default profile `DEV` with the `config` file at non-default location such as `/home/users/config`
```
<copy>
     auth: {
        iam: {
          configFile: '/home/users/config',
          profileName: 'DEV'
        }
    }
    </copy>
```
6.
Save the `HelloWorld.js` program.
</if>

## Execute the Sample Application
<if type="Java">  
1. Open the Command Prompt.
2. Build the `HelloWorld.java` application.
```
<copy>
   javac -cp oracle-nosql-java-sdk-X.X.X/lib/* HelloWorld.java
</copy>

```
**Note:** Update `oracle-nosql-java-sdk-X.X.X` with the Java driver version number that you have downloaded.

For Example:

`javac -cp oracle-nosql-java-sdk-5.2.9/lib/* HelloWorld.java`

3. Execute the `HelloWorld.java` application.
```

<copy>
java -cp ".:oracle-nosql-java-sdk-X.X.X/lib/*" HelloWorld
</copy>

```

**Note:** Update `oracle-nosql-java-sdk-X.X.X` with the Java driver version number that you have downloaded.

For Example:

`java -cp ".:oracle-nosql-java-sdk-5.2.9/lib/*" HelloWorld`

Expected Output:
```
<copy>
    Using region: oracle.nosql.driver.Region@14ae5a5
    Creating table HelloWorldTable
    Waiting for HelloWorldTable to become active
    Table HelloWorldTable is active
    Wrote {"name":"Tracy","employeeid":1}
    Read {"employeeid":1,"name":"Tracy"}
    Dropping table HelloWorldTable
    Waiting for HelloWorldTable to be dropped
    Table HelloWorldTable has been dropped
    </copy>
```
**Note:** In the `main` method, you can remove the method calls you don't want to execute. For example, if you want to create a table, write the rows and read those rows but don't want to drop the table, you can remove the `dropTable(handle)` method call before building the application.
</if>
<if type="Python">  
1. Open the Command Prompt, and navigate to the directory where you saved the `HelloWorld.py` program.
2. Execute the `HelloWorld` program.

      `python HelloWorld.py cloud`

Expected Output:
```
<copy>
Connecting to the Oracle NoSQL Cloud Service
Creating table: create table if not exists hello_world (id integer, content JSON,  primary key(id))
Wrote record:
    {'id': 1, 'content': {'hello': 'world'}}
Read record:
    {'id': 1, 'content': {'hello': 'world'}}
    </copy>
```
</if>
<if type="Go">  
1. Open the Command Prompt.
2. Initialize a new module for the example program.

   `go mod init example.com/quickstart`  

3. Build the `quickstart` application.

    `go build -o quickstart`
4. Run the `quickstart` application.

     `./quickstart`

Expected Output:
```
<copy>
Created table  go_quick_start
Put row: map[id:12345 test_data:This is a sample string of test data]
result: {"readKB":0,"writeKB":1,"readUnits":0,"existingVersion":null,"existingValue":null,"version":"rO0ABXcsABU0XG/CPt1KFpeLA0xx6KY/AAAAAC9lq0cBAwAAAAsAAAABAAAEjAV5Rpc=","generatedValue":null}
Got row: {"id":12345,"test_data":"This is a sample string of test data"}
Deleted key: {"id":12345}
result: {"readKB":1,"writeKB":1,"readUnits":2,"existingVersion":null,"existingValue":null,"success":true}
Dropped table  go_quick_start
</copy>
```
</if>
<if type="Node.js">  
1. Open the Command Prompt, and navigate to the directory where you saved the `HelloWorld.js` program

2. Execute the `HelloWorld` program.

   `node HelloWorld.js`

Expected Output:
```
<copy>
Create table: CREATE TABLE IF NOT EXISTS hello_world (id LONG, content JSON, PRIMARY KEY(id))
Wrote a record with primary key 1
Successfully read the record: {"id":1,"content":{"hello":"world"}}
</copy>
```
**Note:** You can modify the program as per your requirement. For example, if you want to create a table, write the rows and read those rows but don't want to drop the table, you can delete the code to drop the table before building the application.
</if>
## Want to Learn More?
* [About Oracle NoSQL Database Cloud Service](https://docs.oracle.com/pls/topic/lookup?ctx=cloud&id=CSNSD-GUID-88373C12-018E-4628-B241-2DFCB7B16DE8)

* [Oracle NoSQL Database Cloud Service page](https://cloud.oracle.com/en_US/nosql)

* [Java API Reference Guide](https://docs.oracle.com/en/cloud/paas/nosql-cloud/csnjv/index.html)
