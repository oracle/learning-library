<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

October 18, 2018
</td>
<td class="td-banner">
# Lab 10: Mastering DevOps in the Oracle Cloud
</td></tr><table>

# Mastering DevOps in the Oracle Cloud

DevOps is an organizational philosophy that allows for rapid delivery of products using agile practices, tools and infrastructure. DevOps focuses on the ability of developers and IT Operations  staff to leverage cloud resources to rapidly deploy infrastructure and PaaS services such that personnel bottlenecks is no longer an issue for delivering applications internally. DevOps practices can be adopted by anyone in an organization that wishes to participate in a changing culture of agility and collaboration.

Two docker images are provided here to give you a jumpstart on developing applications on Oracle Autonomous Transaction Processing Service. These images are pre-configured with tools and language drivers so that you can,

1. Instantly connect to your ATP instance using SQLCL or SQL*Plus
2. Use OCI CLI commands to provision and manage ATP instances from a command line interface. Sample scripts are included.
3. Orchestrate ATP instances using your favourite programming language. SDK sample scripts are included for Python, Java and Node.js
4. Use sample applications written in Python, Java and Node.js to understand how apps connect to ATP using the secure encryption wallet
5. Use terraform scripts to work with Oracle cloud. Sample scripts for managing ATP instances are provided


**README files with usage directions and example scripts have been added to each language folder in the image and are also listed below**


### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.


## **Download Docker image**

- Start by pulling the image from Docker, provided by your instructor.

- Next, create a directory on your local machine to download the ATP connection wallet from the Oracle Cloud Console. We will map this local directory to the docker container folder /opt/oracle/database/wallet so that client tools in the container have access to wallet files

On your local machine - 
```
mkdir -p ~/tmp/wallet
```
If you are on Windows, you can run a similar command using Powershell as Administrator -
```
mkdir tmp/wallet
```

- Now you can launch a container using the image you just pulled.

Note: With this run command you are mapping the local directory ~/tmp/wallet/ to the directory in the image /opt/oracle/database/wallet.
This command also maps the port 3050 to your local machine port 3050 which will be used for testing node.js application.

```
docker run -it -p 3050:3050 -v ~/tmp/wallet:/opt/oracle/database/wallet {INSTRUCTOR PROVIDED URL} /bin/bash
```
If you are on Windows you can run a similar command using Powershell as Administrator, this will prompt you to enter your system username and password to share volume. Change the username in the line below to your username or where you created the wallet directory. Hit enter when you are done -
```
docker run -it -p 3050:3050 -v C:\Users\{Username}\tmp\wallet:/opt/oracle/database/wallet {INSTRUCTOR PROVIDED URL} /bin/bash
```

![](./images/1000/lab1000-1.png)

## **Connect to your ATP instance using SQLCL or SQL*Plus**

- Get started connecting to a database using SQL and SQLPLUS *if you have already created an ATP instance*. 

**Please make sure:**

- **You have downloaded your wallet of the database you created and placed the files in the local directory mapped to /opt/oracle/database/wallet in your container**

- **For SQL CL you will need the zip file in /opt/oracle/database/wallet**

SQL CL

```
sql /nolog
```

```
SQL> set cloudconfig /opt/oracle/database/wallet/Wallet_testing.zip
```

```
SQL> connect admin@testing_high  (replace 'testing_high' with an appropriate service for your instance)
```
Provide your admin password and you are in!


![](./images/1100/sqlcl.png)

SQL PLUS

For SQL*Plus, you will need to unzip the wallet in your local folder and edit sqlnet.ora as follows-

- Edit the sqlnet.ora file in /opt/oracle/database/wallet and change the line ?/network/admin:

Before:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="?/network/admin")))
SSL_SERVER_DN_MATCH=yes
```

After:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="/opt/oracle/database/wallet")))
SSL_SERVER_DN_MATCH=yes
```

- Now, run:

```
sqlplus admin@testing_high
```

![](./images/1100/sqlplus.png)




## **Configuring and using Oracle Cloud Infrastructure CLI**

- Next, we'll take a look at configuring and using Oracle Cloud Infrastructure CLI commands. Once in the image we will setup OCI-CLI like we did in <a href="./LabGuide900ConfigureOCI-CLI.md" target="_blank">LabGuide9.md</a>:

In your container, run

```
$ oci setup config
```

- The command prompts you for the information required for the config file and the API public/private keys. The setup dialog generates an API key pair and creates the config file.


![](./images/900/OCI-Setup-Config.png)

- Once you run the above command, you will need to enter the following:

    - **Enter a location for your config [/Users/tejus/.oci/config]**: Press Return key
    - **Enter a user OCID**: This is located on your user information page in OCI console

    Login to OCI console and click on Menu, Identity and Users. Click on the User and navigate to User Details page. Copy the User OCID.

    ![](./images/900/UserOCID1.png)

    ![](./images/900/UserOCID2.png)


    - **Enter a tenancy OCID**: This is located in the bottom left of your OCI console
    
    Login to OCI console click on User icon on top right corner on the page and click on Tenancy and copy Tenancy OCID

    ![](./images/900/TenancyOCID1.png)

    ![](./images/900/TenancyOCID2.png)

    - **Enter a region (e.g. eu-frankfurt-1, uk-london-1, us-ashburn-1, us-phoenix-1)**: Select a region

    - **Do you want to generate a new RSA key pair? (If you decline you will be asked to supply the path to an existing key.) [Y/n]**: Y
    - **Enter a directory for your keys to be created [/Users/tejus/.oci]**: Press Return key
    - **Enter a name for your key [oci_api_key]**: Press Return key
    - **Enter a passphrase for your private key (empty for no passphrase)**: Press Return key
  
## OCI CLI

These commands can be run from any folder as long as you have run `oci setup config` 

-   Example scripts can be found in **/opt/oracle/tools/oci**

-   Here is a list of several OCI commands with their **required** options:

**Creating Database**
```

oci db autonomous-database create --admin-password [password] --compartment-id [OCID] --cpu-core-count [integer] --data-storage-size-in-tbs [integer] --db-name [Database Name]

```

**Deleting Database**
```

 oci db autonomous-database delete --autonomous-database-id [OCID]

```

**Get Database**
```

oci db autonomous-database get --autonomous-database-id [OCID]

```

**Listing Databases**
```

oci db autonomous-database list --compartment-id [OCID]

```

**Restore Database**
```

oci db autonomous-database restore --autonomous-database-id [OCID] --timestamp [datetime]

```

**Start Database**
```

oci db autonomous-database start --autonomous-database-id [OCID]

```

**Stop Database**
```

oci db autonomous-database stop --autonomous-database-id [OCID]

```

**Update Database**
```

oci db autonomous-database update --autonomous-database-id [OCID] --cpu-core-count [integer]

```

## Python

These scripts are intended to help any python developer get started connecting to Oracle Autonomous Database, as well as easily create, update, restore, start, stop ATP instances. These scripts serve as a starting point to using language SDK to create cloud orchestrations. Users are encouraged to read Oracle Cloud documentation and modify / enhance these scripts as per their requirements

### Getting Started

Assuming you have setup oci using ```oci setup config``` change directories to /opt/oracle/tools/python/ and you will see two directories **sdk** and **apps**

- **Edit your /root/.oci/config file and add the compartmentid line at the bottom as shown below**:

![](./images/1100/compartmentid.png)

### **APPLICATION EXAMPLE**:

- /opt/oracle/tools/python/apps

In this simple python application, we are connecting to an existing ATP database, creating a table, and loading data from sales.csv into the table. We then do a simple query of that data and output that we are connected to the database

**Please make sure:**

- **You have downloaded your wallet of the database you created and placed the files in the local directory mapped to /opt/oracle/database/wallet in your container**

- **You have edited /root/.oci/config to point to the correct compartmentid where the database is located**

- Edit the sqlnet.ora file in /opt/oracle/database/wallet and change the line ?/network/admin: 

Before:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="?/network/admin")))
SSL_SERVER_DN_MATCH=yes
```

After:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="/opt/oracle/database/wallet")))
SSL_SERVER_DN_MATCH=yes
```

- You may now run the sample python app as - 

```
python exampleConnection.py ADMIN OraclePassword123! salesdb_low
```

![](./images/1100/application.png)


### **SDK EXAMPLES**:

- /opt/oracle/tools/python/sdk

Here's some more scripts provided to manage lifecycle operations of Autonomous Database instances. Note that while the scripts are specific to Autonomous Transaction Processing, they can be used equally effectively for Autonomous Datawarehouse instances with a slight modification of keyword. Please refer to Oracle Autonomous Database documentation **here**

**Create Database**

```

args: DBNAME DISPLAYNAME PASSWORD CPUCOUNT STORAGEINTBS

python createAutonomousDatabase.py salesDatabase salesDB OraclePassword123! 2 3

```

![](./images/1100/createDatabase.png)


**Delete Database**

```

python deleteAutonomousDatabase.py ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra

```

**Get Database**

```

python getAutonomousDatabase.py ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra

```

**List Database**

```

python listAutonomousDatabase.py

```

**Start Database**

```

python startAutonomousDatabase.py ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra

```

**Stop Database**

```

python stopAutonomousDatabase.py ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra

```

**Update Database**

```

python updateAutonomousDatabase.py ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra cpuCoreCount storageSizeInTBs

```

**Restore Database**

```

python restoreAutonomousDatabase.py ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra timestamp

```

## **Java**

Similarly, scripts and sample app are  provided here to help Java developers get started connecting to Oracle Autonomous Database, as well as  create, update, restore, start, stop ATP instances

### Script Examples

CLASSPATH env variable has been set so you can run this scripts from any folder. For syntax help on any command, you can type `COMMAND [-h for help] [arg_1 arg_2 ...]` 

```

createAutonomousDatabase DBNAME DISPLAYNAME PASSWORD CPUCOUNT STORAGEINTBS

```

```

deleteAutonomousDatabase DBOCID

```

```

getAutonomousDatabase DBOCID

```

```

listAutonomousDatabases

```

```

startAutonomousDatabase DBOCID

```

```

stopAutonomousDatabase DBOCID

```

```

updateAutonomousDatabase CPUCount StorageInTBs DBOCID

```

### Running the Sample Java Application

**Please make sure:**

- **You have downloaded your wallet of the database you created and placed the files in the local directory mapped to /opt/oracle/database/wallet in your container**

- **You have edited /root/.oci/config to point to the correct compartmentid where the database is located**

- Edit the sqlnet.ora file in /opt/oracle/database/wallet and change the line ?/network/admin:

Before:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="?/network/admin")))
SSL_SERVER_DN_MATCH=yes
```

After:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="/opt/oracle/database/wallet")))
SSL_SERVER_DN_MATCH=yes
```


Run the sample Java app to test connectivity to your ATP instance as,

```

ATPConnectionTest DB_USER DB_PASSWD WALLET_DIR -sn service-name

```

![](./images/1100/javaConnection.png)

`ATPConnectionTest` can also be called directly 
if you include a file, `db.config`, like
```text
 DB_USER=admin
 DB_PASSWD=Welcome123456!
 WALLET_DIR=/opt/oracle/database/wallet
```
to do this either place the db.config file in the `target` folder
or specify the file location like this 
```bash
ATPConnectionText -c /tmp/db.config
```

-   Please ensure that you have moved your wallet into the correctly mapped directory

### Building 

-   For your reference:

Uses 
- JDK 1.8+
- Maven 3.5
- [Java SDK from GitHub](https://github.com/oracle/oci-java-sdk/releases)
- [JDBC for Oracle Database](https://www.oracle.com/technetwork/database/application-development/jdbc/downloads/index.html)
- [Picocli](https://picocli.info/)

```bash
# you will have to download most deps 
# and place them in the ${BASEDIR}/lib folder
# install the rest
mvn install 

# make that jar
mvn package
```


## NODE.JS

These scripts are intended to help any nodejs developer get started connecting to Oracle Autonomous Database, as well as easily create, update, restore, start and stop ATP instances

### Getting Started

Assuming you have setup oci using ```oci setup config``` change directories to /opt/oracle/tools/python/ and you will see two directories **sdk** and **apps**

- Edit your /root/.oci/config file and add the compartmentid line at the bottom like so:

![](./images/1100/compartmentid.png)

### **APPLICATION EXAMPLE**:

- /opt/oracle/tools/nodejs/apps

In this simple node application we are connecting to the database 

**Please make sure:**

- **You have downloaded your wallet of the database you created and placed the files in the local directory mapped to /opt/oracle/database/wallet in your container**

- **You have edited /root/.oci/config to point to the correct compartmentid where the database is located**

- Edit the sqlnet.ora file in /opt/oracle/database/wallet and change the line ?/network/admin:

Before:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="?/network/admin")))
SSL_SERVER_DN_MATCH=yes
```

After:
```
WALLET_LOCATION = (SOURCE = (METHOD = file) (METHOD_DATA = (DIRECTORY="/opt/oracle/database/wallet")))
SSL_SERVER_DN_MATCH=yes
```

- The sample node.js app used a dbconfig.js configuration file for database credentials

-   Edit the dbconfig.js file and update the user, password and connectString variables to point to your ATP instances

-   To run the app as a background process -
```
node server.js &
```
You can now test the status of your app by opening a browser window on your local machine and pointing it to http://localhost:3050
Please recall that you need to launch the container mapping port 3050 on your local machine to the container.


![](./images/1100/nodeConnection.png)


### **SDK EXAMPLES**:

Lets take a look at some more node.js SDK examples located in /opt/oracle/tools/nodejs/sdk

**Create Database**

```

args: DBNAME DISPLAYNAME PASSWORD CPUCOUNT STORAGEINTBS

node createAutonomousDatabase.js salesDatabase salesDB OraclePassword123! 2 3

```

![](./images/1100/nodeCreate.png)


**Delete Database**

```

node deleteAutonomousDatabase.js ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra

```

**Get Database**

```

node getAutonomousDatabase.js ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra

```

**List Database**

```

node listAutonomousDatabase.js

```

**Start Database**

```

node startAutonomousDatabase.js ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra

```

**Stop Database**

```

node stopAutonomousDatabase.js ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra

```

**Update Database**

```

node updateAutonomousDatabase.js ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra cpuCoreCount storageSizeInTBs

```

**Restore Database**

```

node restoreAutonomousDatabase.js ocid1.autonomousdatabase.oc1.iad.abuwcljss3jw6ch4phusrfjsz2g3ly2ymjvldaex5acg6gy5mwp3zhfxcfra timestamp

```

## Terraform

Terraform is a popular cloud orchestration tool. Sample terraform scripts are provided here to get your started with using it to manage ATP instances. However, users are encouraged to check out Oracle Cloud documentation to further build on these and learn to provision complete application stacks using terraform 


### About / Setup
Utilize Terraform to create and destroy your ATP instances


### Example Scripts 
These scripts are very simple and do all the work for you. 

- Enter the /opt/oracle/tools/terraform directory and run:

```
chmod +x createATP.sh
./createATP.sh
```

- Follow the instructions after running the script above and your database will create with the parameters entered

```
var.autonomous_database_cpu_core_count
  Enter a value: 1

var.autonomous_database_data_storage_size_in_tbs
  Enter a value: 1

var.autonomous_database_db_name
  Enter a value: DBNAME

var.autonomous_database_display_name
  Enter a value: testDB
```

- The **password** to your database will be output after it has finished creating. The user is ADMIN

- To destroy the database created:

```
terraform destroy
```

- To update the database created, simply run 
```terraform apply``` 
and you can update the CPU Count and the data storage in TBs as well as the display name with the prompts.


### Download Database Wallet

- Enter the `/opt/oracle/tools/terraform/getWallet` directory and run:

```
chmod +x getWallet.sh
./getWallet.sh
```

Enter the database OCID and the password that was output when you created the instance

And now the database wallet will be downloaded into wallet.zip

### List directory

- Enter the `/opt/oracle/tools/terraform/list` directory and run:

```
chmod +x listATPInstances.sh
./listATPInstances.sh
```

And now you will see all the database instances in the given compartment


### Get Database details

- Enter the `/opt/oracle/tools/terraform/getATP` directory and run:

```
chmod +x listATP.sh
./listATP.sh
```

Enter the database OCID

And now several details of that individual database will be displayed


## **Useful Links**:

- [Autonomous Transaction Processing REST API Information](https://docs.cloud.oracle.com/iaas/api/#/en/database/20160918/AutonomousDatabase/)
- [Autonomous DataWarehouse REST API Information](https://docs.cloud.oracle.com/iaas/api/#/en/database/20160918/AutonomousDataWarehouse/)
- [Oracle Cloud Infrastructure Language SDK Documentation](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/sdks.htm)
- [Oracle Cloud Infrastructure Command Line Interface Documentation](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/cliconcepts.htm)
- [Oracle Cloud Infrastructure DevOps Tools](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/devopstools.htm)
