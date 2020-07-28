# Environment Setup 

## Introduction

This lab will show you that how to start database instance and listener from putty window,also this covers how to setup vncserver and sqldeveloper etc. 

Estimated time: 1 hour

### Objectives
- Start the Oracle Database and Listener
- Download and Setup SQL Developer Client

### Lab Prerequisites

- Lab 1: Login to Oracle Cloud
- Lab 2: Generate SSH Key
- Lab 3: Create Compute Instance

## Step 1: Start the Database and the Listener

1. Click the Hamburger Menu in the top left corner. Then hover over Compute > Instances. Find the instance you created in the previous lab. 

   ![](./images/nav_compute_instance.png " ")

2. Click on your instance and copy your Public IP address to a notepad. 

   ![](./images/public_ip.png " ")


3. In Oracle CloudShell (*recommended*) or the terminal of your choice, login via ssh as the **opc** user.  
 
      ````
      ssh -i <<sshkeylocation>> opc@<<your address>>
      ````

      - sshkeylocation - Full path of your SSH key
      - your address - Your Public IP Address
  
4. Switch to the oracle user
      ````
      <copy>
      sudo su - oracle
      </copy>
      ````

   ![](./images/env1.png " ")

5.  Run the script env_setup_script.sh, this will start the database, listener, oracle rest data service and our eshop          application.


````
<copy>
cd /u01/script
./env_setup_script.sh
</copy>
````

   ![](./images/env2.png " ")



## Step 2: Download SQL Developer

Certain workshops require SQL Developer.  To setup SQL Developer, follow the steps below.

1. Download [SQL Developer](https://www.oracle.com/tools/downloads/sqldev-downloads.html) version 19.4 from the Oracle.com site and install on your local system.

2. Once installed, open up the SQL Developer console.

      ![](./images/start-sql-developer.png " ")
   
## Step 3:  Test a connection

1.  In the connections page click the green plus arrow to create a new connection

2.  Enter the following connection information to test your connection

3.  Once your connection is successful in the SQL Developer panel execute the query below
      ````
      <copy>
      select name, open_mode from v$database;
      </copy>
      ````

      ![](./images/vdatabase.png " ")



You may proceed to the next workshop.

## Converged Database Workshop Collection

- [Node.js](?lab=node.js-lab-1-intro-setup) - Use Rest API to add products to the eShop Application
- [Json](?lab=json-lab-1-intro-setup) - Store and read JSON documents from the Oracle Database
- [XML](?lab=xml-lab-1-setup)- Manage XML content in the Oracle Database
- [Spatial](?lab=spatial-lab-1-setup) - Work with Spatial Data in the Oracle Database
- [Graph](?lab=graph-lab-1-intro-setup) - Work with Graph Data in the Oracle Database
- [Cross Datatype](?lab=cross-lab-1-intro-usage) - Work with Cross Data Types

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K., Robbie Ruppel
- **Team** - North America Database Specialists
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
  


















