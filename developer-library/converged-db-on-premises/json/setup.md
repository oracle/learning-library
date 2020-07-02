# Oracle JSON 

## Introduction

This lab walks you through the steps of setting up the environment for JSON lab . You can connect Oracle Database instance using any client you wish. In this lab, you'll connect using Oracle SQLDeveloper.

### Lab Prerequisites

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup
- Note :  All scripts for this lab are stored in the /u01/workshop/json folder and are run as the oracle user. 

### About Oracle JSON 

JSON(JavaScript Object Notation)is a syntax for storing and exchanging data. When exchanging data between a browser and a server, the data can only be text.

JSON is text, and we can convert any JavaScript object into JSON, and send JSON to the server.We can also convert any JSON received from the server into JavaScript objects.

This way we can work with the data as JavaScript objects, with no complicated parsing and translations.

### JSON with Oracle Database**

JSON data  can be used in Oracle Database in similar ways. Unlike relational data, it can be stored, indexed, and queried without any need for a schema that defines the data. Oracle Database supports JSON natively with relational database features, including transactions, indexing, declarative querying, and views.

So it's likely we want to send and receive JSON documents from and to our database. And store them in your tables. Oracle Database has a huge amount of functionality that makes this easy.

Oracle database provides a comprehensive implemention of SQL, for both analytics and batch processing. JSON held in the Oracle Database can be directly accessed via SQL, without the need to convert it into an intermediary form. JSON collections can be joined to other JSON collections or to relational tables using standard SQL queries.

**Storing and Managing JSON Documents**

JSON documents can be stored usinga VARCHAR2, CLOB,or BLOB column. An IS JSON SQL constraint ensures that the column contains only valid JSON documents, allowingthe database to understand that the column is being used as a container for JSON documents.

Oracle’s JSON capabilities are focused on providing full support for schemaless development and document-based storage. Developers are free to change the structure of their JSON documents as necessary. With the addition of JSON support, Oracle Database delivers the same degree of flexibility as a NoSQL JSON document store.

[](youtube:oiOCp23T1ZU)

The first thing to realize about JSON is that it remains a simple text format—which is relatively easy to read and inspect with the naked eye. At a syntax level, what starts to set JSON apart from other formats is the characters used to separate data, which are mainly constrained to apostrophes ', brackets ( ), [ ], { }, colons :, and commas ,. This listing illustrates what a JSON payload looks like:

 ![](./images/json_intro.PNG " ")


### Want to learn more
- [JSON](https://docs.oracle.com/en/database/oracle/oracle-database/19/adjsn/index.html
  

## Step 1: Set your Oracle Environment
1. As oracle user navigate to the json workshop directory.
   
    ````
    <copy>
    sudo su - oracle
    cd /u01/workshop/json
    </copy>
    ````
    
2. Set your environment variables to the ConvergedCDB home.
       
    ````
    <copy>
    . oraenv
    ConvergedCDB
    sqlplus appjson/Oracle_4U@JXLPDB
    </copy>
    ````

## Step 2: Make a connection to sqldeveloper.Provide the details as below and click on connect.
   
````
    <copy>
    Name: JSON
    Username: appjson
    Password: Oracle_4U
    Hostname: localhost
    Port: 1521
    Service name: JXLPDB

    </copy>
   ````
 
  ![](./images/env_json.PNG " ") 


## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

### Issues
Have an issue?  Submit it on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.
      
 
