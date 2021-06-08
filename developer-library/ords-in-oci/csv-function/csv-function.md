# Title

# Start

## Setup Permissions

Allow dynamic-group <dynamic-group-name> to manage objects in compartment <compartment-name> where target.bucket.name=<input-bucket-name>
Allow dynamic-group <dynamic-group-name> to manage objects in compartment <compartment-name> where target.bucket.name=<processed-bucket-name>

## Prepare Database

log into DB Actions

SQL Worksheet

Create table

Auto-REST Table

Batch Load API Test

## Create and Deploy the Function

Review the following files in the current folder:

    the code of the function, func.py
    its dependencies, requirements.txt
    the function metadata, func.yaml

Deploy the function

In Cloud Shell, run the fn deploy command to build the function and its dependencies as a Docker image, push the image to OCIR, and deploy the function to Oracle Functions in your application.

fn -v deploy --app <app-name>

Set the function configuration values

The function requires several configuration variables to be set.

Use the fn CLI to set the config value:

fn config function <app-name> <function-name> ords-base-url <ORDS Base URL>
fn config function <app-name> <function-name> db-schema <DB schema>
fn config function <app-name> <function-name> db-user <DB user name>
fn config function <app-name> <function-name> dbpwd-cipher <DB encrypted password>
fn config function <app-name> <function-name> input-bucket <input bucket name>
fn config function <app-name> <function-name> processed-bucket <processed bucket name>

e.g.

fn config function myapp oci-adb-ords-runsql-python ords-base-url "https://xxxxxx-db123456.adb.us-region.oraclecloudapps.com/ords/"
fn config function myapp oci-adb-ords-runsql-python db-schema "admin"
fn config function myapp oci-adb-ords-runsql-python db-user "admin"
fn config function myapp oci-adb-ords-runsql-python dbpwd-cipher "xxxxxxxxx"
fn config function myapp oci-adb-ords-runsql-python input-bucket "input-bucket"
fn config function myapp oci-adb-ords-runsql-python processed-bucket "processed-bucket"

## Create an Event rule

Let's configure a Cloud Event to trigger the function when files are dropped into your input bucket.

## Put it all together

Finally, let's test the workflow.


Upload one or all CSV files from the current folder to your input bucket. Let's imagine those files contains sales data from different regions of the world.

On the OCI console, navigate to Autonomous Data Warehouse and click on your database, click on Service Console, navigate to Development, and click on SQL Developer Web. Authenticate with your ADMIN username and password. Enter the following query in the worksheet of SQL Developer Web:

select count(*) from table_we_created;

You should see the data from the CSV files.