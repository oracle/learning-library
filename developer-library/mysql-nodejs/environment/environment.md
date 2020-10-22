# Exploring and Finishing Setup

## Introduction

Now your environment is running. You have a Virtual Cloud Network (VCN),
a MySQL Database Service instance and a few more services we will explore at 
later stages. To access our environment a Compute instance was launched and
pre-installed Node.js, MySQL Shell and OCI tools.

You can use SSH to connect to this instance.

Estimated Lab Time: 25 minutes

### Objectives

- Connect to the Compute Instance using SSH
- Explore MySQL using MySQL Shell and create a Collection for MySQL Document Store usage
- Configure OCI Client and Fn


## **STEP 1a:** Using OpenSSH from Command Line

To access the system you need the private ssh key and the IP, which were created by
Terraform and was shown on the **Application Information** tab in the 
**Resource Manager**. Store it in a file like `ssh_private_key`. The file must
not be world readble on your machine, otherwise the ssh client will complain.
By default a user with name `opc` is created. On first connect your
client will ask to confirm the server identity, type `yes` to confirm.

If you stored the key in a file `ssh_private_key` and the IP of your instance is
`123.45.67.89` your shell session might look like this:

    $ chmod 600 ssh_private_key
    $ ssh -i ssh_private_key opc@123.45.67.89
    The authenticity of host '123.45.67.89 (123.45.67.89)' can't be established.
    ECDSA key fingerprint is SHA256:1MICcPQUNhEeOfIiKgG01PYJKD0rze+W61qBQECWNe8.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '123.45.67.89' (ECDSA) to the list of known hosts.
    [opc@compute ~]$

## **STEP 1b:** Using PuTTY on Windows

[PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) is a
ssh client frequently used on Windows. To access the system you need 
the private ssh key and the IP, which were created by Terraform. The key from the
previous Lab has to be stored in a file.

Before being able to use it, the key has to be converted to PuTTY's format. For that
the **PuTTYgen** tool is being used. In that tool open the **Conversion** menu and 
pick **Import key**. After picking the file you stored the key details will be
shown in the main window. Now click **Save private key** and store that file.

  ![](images/putty_key_convert.png " ")

After the conversion you can close **PuTTYgen** and open **PuTTY**. In there pick
the **SSH**, **Auth** section and load the **Private Key**.

  ![](images/putty_key.png " ")

After that go to the **Session** section, enter the **IP** address from your compute
isntance, as shown in the Terraform Application Informationm ake sure **SSH** is set
as protocol and **Port 22** is selected. After clicking **Open** enter **opc** as
username when asked.

  ![](images/putty_connect.png " ")

## **STEP 2:** Use MySQL Shell to access the MySQL Database Service Instance

In the Terraform output you got an URL in the format `mysqlx://` which can be
used with MySQL Shell. MySQL Shell is an interactive Shell, introduced with
MySQL 8.0. Compared to the classic MySQL monitor it supports scripting not only
using SQL, but also JavaScript and Python. It contains advanced features, like
the Dump and Load utilities, which allow migrating data between MySQL database
systems or support for MySQL InnoDB Cluster.

Let's login to MySQL:

    [opc@compute ~]$ mysqlsh 'mysqlx://root:N0d3js!MySQL@10.0.2.7:33060'
    MySQL Shell 8.0.21
    ...
    Server version: 8.0.21-u1-cloud MySQL Enterprise - Cloud
    No default schema selected; type \use <schema> to set one.
     MySQL  10.0.2.7:33060+ ssl  JS > 
    
*Note: Make sure you are using the IP from your environment. Also mind that the
default password of this setup uses special characters like `!` thus we have to
escape it using single quote (`'`) on the command line!*

The application you will build uses MySQL as Document Store. As the database
instance is empty we have to create a database schema and a collection.

     MySQL  10.0.2.7:33060+ ssl  JS > session.createSchema('hol');
    <Schema:hol>
     MySQL  10.0.2.7:33060+ ssl  JS > session.getSchema('hol').createCollection('people');
    <Collection:people>

A **Collection** is a special form of table to store JSON documents. You can
explore it using SQL after switching into **SQL mode**:

     MySQL  10.0.2.7:33060+ ssl  JS > \sql
    Switching to SQL mode... Commands end with ;
     MySQL  10.0.2.7:33060+ ssl  SQL > show create table hol.people\G
    *************************** 1. row ***************************
           Table: people
    Create Table: CREATE TABLE `people` (
      `doc` json DEFAULT NULL,
      `_id` varbinary(32) GENERATED ALWAYS AS (json_unquote(json_extract(`doc`,_utf8mb4'$._id'))) STORED NOT NULL,
      `_json_schema` json GENERATED ALWAYS AS (_utf8mb4'{"type":"object"}') VIRTUAL,
      PRIMARY KEY (`_id`),
      CONSTRAINT `$val_strict_A0C872677D3F3232DA6BCA07470A7F17F408900C` CHECK (json_schema_valid(`_json_schema`,`doc`)) /*!80016 NOT ENFORCED */
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    1 row in set (0.0007 sec)

You can explore the database as you like. You can switch back into
**JavaScript mode** by typing `\js`, into **Python mode** using `\py`, 
and when done quit using `\quit`.

## **STEP 3:** Configure the OCI Client

Later we are going to deploy serverless functions using the `fn` tool. The `fn`
tool requires access to OCI APIs for deploying the code.

In order to access OCI services via API the profile has to be configured. This
can be done using a Wizard with the `oci` command line tool after you gathered
some information on your Cloud Tenancy.

Information you need to collect contains:

- The Region
- User OCID
- Tenancy OCID

The Region is part of the information provided by Terraform in the *Application
Information* the previous Lab. This could be something like `us-ashburn-1` or
`eu-frankfurt-1`.

The user OCID (Oracle Cloud Identifier) is your unique user id. It can be found on your
profile page, which you can find by clicking on your name in the menu on the top right.

  ![](images/menu_user.png " ")

  ![](images/user_ocid.png " ")

The tenancy OCID is the ID of the tenancy. It's on the tenancy's page:

  ![](images/menu_tenancy.png " ")

  ![](images/tenancy_oci.png " ")

After gathering the data, invoke the wizard using

    [opc@compute ~]$ oci setup config

You have to confirm the default location for the config file and provide the
requested config data.

The wizard will ask, whether it should create an API key. Confirm this and
pick the default location.

After that you can print your public key and register it inside the OCI
Cloud console.

    [opc@compute ~]$ cat ~/.oci/oci_api_key_public.pem 

For registering the API key go back to your profile page via the menu on the top right of the
Console. On the profile page click the **API Keys** link under **Resources** (bottom left corner) and then click the **Add Public Key** Button. In the popup you can paste the key and confirm by clicking **Add**.

  ![](images/api_key.png " ")

Having this configured you can now access OCI services from the command line, in
addition to the Web Console. For instance you can get information on the MySQL
Database Service Instance, which had been created by providing your
compartment's OCID, which is also in the *Application Information* from the
Terraform setup:

    [opc@compute ~]$ oci mysql db-system list --compartment-id=ocid1.compartment.oc1..aa....
    {
      "data": [
        {
          "availability-domain": "povk:US-ASHBURN-AD-1",
          "compartment-id": "ocid1.compartment.oc1..aaa....",
          "defined-tags": {
          },
          "description": null,
          "display-name": "Node.js Hands-on-Lab",
          "endpoints": [
            {
              "hostname": null,
              "ip-address": "10.0.2.7",
              "modes": [
                "READ",
                "WRITE"
              ],
              "port": 3306,
              "port-x": 33060,
              "status": "ACTIVE",
              "status-details": null
            }
          ],
          "fault-domain": "FAULT-DOMAIN-1",
          "freeform-tags": {},
          "id": "ocid1.mysqldbsystem.oc1.iad.aa.....",
          "lifecycle-state": "ACTIVE",
          "mysql-version": "8.0.21-u1-cloud",
          "time-created": "2020-10-05T17:32:24.679000+00:00",
          "time-updated": "2020-10-05T17:32:24.679000+00:00"
        }
      ]
    }

Using the `--help` option the OCI tool will provide context sensitive help
about available APIs.

## **STEP 4:** Configure fn client for Oracle Functions

The application you are going to build, is a serverless application using
Oracle Functions. Serverless also known as FaaS let's you run an microservice
style application without having to administrate a server on your own. Oracle
Functions will deploy your code to service runners when required and increase 
on load. If the code isn't invoked it will scale down automatically and won't
cost resources when not used.

Since Oracle Functions and the underlying fn framework are built on Docker
containers we first have to identify your Cloud Tenancy's Docker namespace and
login from our compute instance to docker in able to publish our code.

You can find the **namespace** on the overview of the **Container Registry** service:
  
  ![](images/menu_docker.png " ")
  
  ![](images/docker.png " ")

Also, you have to generate an **API Key** for Docker to login.

The **API Key** can be generated on the **Auth Tokens** section on your
profile page.

  ![](images/auth_token.png " ")

After providing a name for the token you get a popup which allows you to copy
the Token

  ![](images/auth_token2.png " ")

*Important: When closing the popup the token can not be retrieved again and a
new token has to be created. Make sure you noted the token before closing the
popup.*

You'll also need your region's region key for the hostname of the docker
registry.

| Region         | Region key |
| -------------- | ---------- |
| us-ashburn-1   | iad        |
| us-phoenix-1   | phx        |
| eu-frankfurt-1 | fra        |

Full list can be found in [the OCI documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm).

Last thing is your username, this is the one you used to login to the 
console.

With that information you can configure the `fn` client.

The `fn` client allows having multiple contexts to allow using different
systems. Let's create a context and activate it:

    [opc@compute ~]$ fn create context node-mysql --provider oracle
    Successfully created context: node-mysql 
    [opc@compute ~]$ fn use context node-mysql
    Now using context: node-mysql

 For accessing OCI you have to set your compartment and the API URL. Mind that
 you have to replace `us-ashburn-1` with your region.

    [opc@compute ~]$ fn update context oracle.compartment-id ocid1.compartment.oc1..aaaa....
    Current context updated oracle.compartment-id with ocid1.compartment.oc1..aaaa...
    [opc@compute ~]$ fn update context api-url https://functions.us-ashburn-1.oraclecloud.com
    Current context updated api-url with https://functions.us-ashburn-1.oraclecloud.com

Next steps are to configure the Docker registry and signing in. For example, if
your Cloud Region is `us-ashburn-1` (registry URL `iad.ocir.io`) and your namespace is
`idylsdbcgx1d` and your username is `user@example.com` this might look like this:

    [opc@compute ~]$ fn update context registry iad.ocir.io/idylsdbcgx1d/nodejsmysql
    Current context updated registry with iad.ocir.io/idylsdbcgx1d/idylsdbcgx1d
    [opc@compute ~]$ docker login -u 'idylsdbcgx1d/user@example.com' iad.ocir.io
    Password: (Your API Token created above)
    WARNING! Your password will be stored unencrypted in /home/opc/.docker/config.json.
    Configure a credential helper to remove this warning. See
    https://docs.docker.com/engine/reference/commandline/login/#credentials-store

    Login Succeeded

Finally our configuration is done. In the next lab you will create your first
function and load data into the database.

*Please proceed to the next lab.*

## Acknowledgements

- **Authors/Contributors** - Johannes Schlüter
- **Last Updated By/Date** - Johannes Schlüter, October 2020
- **Workshop Expiration Date** - October, 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 

