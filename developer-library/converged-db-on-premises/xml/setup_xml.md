# Oracle XML Introduction and Setup

## Introduction

This lab walks you through the steps of setting up the environment for XML lab . You can connect Oracle Database instance using any client you wish. In this lab, you will connect using Oracle SQLDeveloper.

### Before You Begin

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup
- Note :  All scripts for this lab are stored in the /u01/workshop/xml folder and are run as the oracle user. 
  
### About Oracle XML 

XML(Extensible Markup Language) is used to store and transport data. XML data is known as self-describing or self-defining, meaning that the structure of the data is embedded with the data, thus when the data arrives there is no need to pre-build the structure to store the data; it is dynamically understood within the XML.

The basic building block of an XML document is an element, defined by tags. An element has a beginning and an ending tag. All elements in an XML document are contained in an outermost element known as the root element. XML can also support nested elements, or elements within elements. This ability allows XML to support hierarchical structures. Element names describe the content of the element, and the structure describes the relationship between the elements.

For example, XML documents can be very simple, such as the following:


 ![](./images/xml_snapa.png " ") 


### XML with Oracle Database

Oracle XML DB is a high-performance, native XML storage and retrieval technology that is delivered as a part of all versions of Oracle Database. 

Oracle XML DB also supports the SQL/XML standard, which allows SQL-centric development techniques to be used to publish XML directly from relational data stored in Oracle Database.XML is an extremely popular way to persist and exchange business critical information.

 [](youtube:lGQvxPCYR2c)

Oracle XML DB allows an organization to manage XML content in the same way that ii manages traditional relational data. This allows organizations to save costs and improve return on investment by using a single platform to manage and secure all of their mission critical data. Oracle XML DB was first released with Oracle 9iR2, and it has been enhanced in each subsequent major release of the database.

 
### Want to learn more
- [XML](https://docs.oracle.com/en/database/oracle/oracle-database/19/adjsn/index.html)

## **Step 1:** Connect to the Pluggable Database (PDB)

1. As oracle user navigate to below path- 

  ````
    <copy>
    sudo su - oracle
    </copy>
  ````

  ````
    <copy>
    cd /u01/workshop/xml
    </copy>
  ````

  ![](./images/xml_inputa.png " ")

 2. Enter instructions.  Choose the ConvergedCDB sid
       
    ````
    <copy>
    . oraenv
    </copy>
    ````

    ````
    <copy>
    sqlplus appxml/Oracle_4U@JXLPDB
    </copy>
    ````

## **Step 2:** Connect to SQL Developer

1. Make a connection to sqldeveloper. Use the details as below and click on connect.

    ````
    Name: XML
    Username: appxml
    Password: Oracle_4U
    Hostname: localhost
    Port: 1521
    Service name: JXLPDB
    ````
 
  ![](./images/env_xmla.png " ") 

You may proceed to the next lab.

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K, Robert Ruppel.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
      
 
