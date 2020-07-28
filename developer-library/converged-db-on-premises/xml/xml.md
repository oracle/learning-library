# Oracle XML

## Introduction

Steps 1-2
This lab walks you through the steps of setting up the environment for XML lab . You can connect Oracle Database instance using any client you wish. In this lab, you'll connect using Oracle SQLDeveloper.

Step 3
This lab walks you through different ways to query XML data. XQuery is a very general and expressive language, and SQL/XML functions XMLQuery, XMLTable, XMLExists, and XMLCast combine that power of expression and computation with the strengths of SQL.
We can query XMLType data, possibly decomposing the resulting XML into relational data using function XMLTable.

Steps 4-5
This lab will show you how to perform insert and update XML contents.
We can update XML content or replace either the entire contents of a document or only particular parts of a document.
The ability to perform partial updates on XML documents is very powerful, particularly when we make small changes to large documents, as it can significantly reduce the amount of network traffic and disk input-output required to perform the update.
The Oracle UPDATEXML function allows us to update XML content stored in Oracle Database.

Steps 6-?
This lab walks you through the steps of inserting and updating xml data. We can add a row to our xml table purchaseorder using insert query. Also we can use Oracle UPDATEXML function to update XML content stored in Database.

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

## Step 1: Connect to the Pluggable Database (PDB)

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

## Step 2: Connect to SQL Developer

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

## Step 3: XML Query

1. Getting the number of XML documents.

````
<copy>
    SELECT Count(*) FROM   purchaseorder p,  XMLTABLE('for $r in /PurchaseOrder return $r' passing object_value) t;
</copy>
````

     ![](./images/xml_m1a.png " ")

2. Retrieving the content of an XML document-using pseudocolumn OBJECT_VALUE

````
<copy>
      SELECT t.object_value.getclobval()FROM   purchaseorder t
      WHERE  rownum = 1;  


</copy>
````

![](./images/xml_query_m2a.png " ")
![](./images/xml_m2a.png " ")

3. Accessing text node value

    ````
      <copy>
      SELECT xmlcast(xmlquery('$p/PurchaseOrder/Reference/text()' passing object_value AS "p" returning content) AS varchar2(30))
      FROM   purchaseorder
      WHERe ROWNUM<= 5
      /

      </copy>
     ````

![](./images/xml_m4a.png " ")
![](./images/xml_query_meth4a.png " ")


4. Searching XML document

````
<copy>
     SELECT t.object_value.getclobval() FROM   purchaseorder t   WHERE  xmlexists('/PurchaseOrder[Reference/text()=$REFERENCE]' passing    object_value, 'AHUNOLD-20141130' AS "REFERENCE" )
         /

</copy>
````

## Step 4: Insert XML record.

 1. Lets take a count of the rows we have currently and then will do a insert.

  ````
    <copy>
    select t.object_value.getclobval() from purchaseorder t;

     </copy>
  ````

 ![](./images/xml_insert1a.png " ")


2. Insert XML record

  The insert query is available as a sql file in the directory “**/u01/workshop/xml**”.
  The script is called as **insert.sql.** You can run this connecting to the SQL prompt.

  Set your oracle environment and connect to PDB as **oracle** user.
  ````
    <copy>
    . oraenv
    </copy>
  ````
  ````
    <copy>
    ConvergedCDB
    </copy>
  ````
  ````
    <copy>
    cd /u01/workshop/xml
    </copy>
  ````
  ````
    <copy>
    sqlplus appxml/Oracle_4U@JXLPDB
    </copy>
  ````

    ![](./images/xml_input2a.png " ")
  ````
    <copy>
    @insert.sql
    </copy>
  ````
  ![](./images/xml_input3a.png " ")

3.  Verify XML record post insert

  ````
    <copy>
    select t.object_value.getclobval() from purchaseorder t;    

         </copy>
  ````
  ![](./images/xml_insert3a.png " ")


## Step 5: Update XML table

1. The update query is available as a sql file in the directory “**/u01/workshop/xml**”.
  The script is called as **update.sql**. You can run this connecting to the SQL prompt.

  Set your oracle environment and connect to PDB as **oracle** user.
  ````
    <copy>
    . oraenv
    </copy>
  ````

  ````
    <copy>
    ConvergedCDB
    </copy>
  ````
  ````
    <copy>
    cd /u01/workshop/xml
    </copy>
  ````
  ````
    <copy>
    sqlplus appxml/Oracle_4U@JXLPDB
    </copy>
  ````

  ![](./images/xml_input2a.png " ")
  ````
    <copy>
    @update.sql
    </copy>
  ````

  ![](./images/xml_input4a.png " ")

 2. Below is the select query to check if user is updated.

   ````
    <copy>
    SELECT extractValue(OBJECT_VALUE, '/PurchaseOrder/User') FROM purchaseorder WHERE existsNode(OBJECT_VALUE, '/PurchaseOrder[Reference="MSD-20200505"]') =1;
    </copy>
  ````
  ![](./images/xml_update2a.png " ")

## Step 6: Example Queries

1. Get the list of the customer and their purchased information from a geo graphical location

XMLEXISTS is an SQL/XML operator that you can use to query XML values in SQL, in a regular query I can use the xmlexists function to look if a specific value is present in an xmltype column

````
<copy>
      SELECT t.object_value.getclobval() FROM   purchaseorder t
      WHERE xmlexists('/PurchaseOrder/ShippingInstructions/Address[city/text()=$CITY]' passing object_value, 'South San Francisco' AS "CITY" );

</copy>
````

     ![](./images/xml_m6a.png " ")

**Notes:** XMLEXISTS is an SQL/XML operator that we can use to query XML values in SQL, in a regular query we can use the xmlexists function to look if a specific value is present in an xmltype column.

2. Customer purchase history  

XMLTABLE: Convert XML Data into Rows and Columns using SQL. The XMLTABLE operator, which allows you to project columns on to XML data in an XMLTYPE , making it possible to query the data directly from SQL as if it were relational data.

````
<copy>
      SELECT t.object_value.getclobval()
      FROM   purchaseorder p,
      XMLTABLE('for $r in /PurchaseOrder[Reference/text()=$REFERENCE] return $r' passing object_value, 'AHUNOLD-20141130' AS  "REFERENCE") t;  

</copy>
````

![](./images/xml_m7a.png " ")

**Notes:** The XMLTABLE operator, which allows you to project columns on to XML data in an XMLTYPE , making it possible to query the data directly from SQL as if it were relational data.


3. Listing the product description those unit price matches to ‘$xx’


XMLSERIALIZE is a SQL/XML operator that you can use to convert an XML type to a character type.

````
<copy>
      SELECT XMLSERIALIZE(CONTENT COLUMN_VALUE AS CLOB INDENT SIZE=2)
  FROM  Purchaseorder p,
        XMLTable(
          '&lt;Summary&gt;
           {
            for $r in /PurchaseOrder/LineItems/Part
            return $r/Description
           }
           &lt;/Summary&gt;'
           passing object_value
        )
  WHERE xmlexists('/PurchaseOrder/LineItems/Part[UnitPrice/text()=$UnitPrice]' passing object_value, '27.95' AS "UnitPrice" );

</copy>
````

![](./images/xml_m8a.png " ")

**Notes:** XMLSERIALIZE is a SQL/XML operator that you can use to convert an XML type to a character type.

4. Customer order summary – Cost center wise

XMLQUERY lets you query XML data in SQL statements. It takes an XQuery expression as a string literal, an optional context item, and other bind variables and returns the result of evaluating the XQuery expression using these input values. XQuery string is a complete XQuery expression, including prolog.

````
<copy>
      SELECT xmlquery(
          '&lt;POSummary lineItemCount="{count($XML/PurchaseOrder/LineItems/ItemNumber)}"&gt;{
             $XML/PurchaseOrder/User,
             $XML/PurchaseOrder/Requestor,
             $XML/PurchaseOrder/LineItems/LineItem[2]
           }
           &lt;/POSummary&gt;'
          passing object_value AS "XML"
          returning content
        ).getclobval() initial_state
  FROM  PURCHASEORDER
  WHERE xmlExists(
          '$XML/PurchaseOrder[CostCenter=$CS]'
           passing object_value AS "XML",
                   'A90' AS "CS"      )
                   /
</copy>
````

![](./images/xml_m9a.png " ")

**Notes:** XMLQUERY lets you query XML data in SQL statements. It takes an XQuery expression as a string literal, an optional context item, and other bind variables and returns the result of evaluating the XQuery expression using these input values. XQuery string is a complete XQuery expression, including prolog.

5. Custer Delivery Priority Instruction for e.g Ex - Courier, Expidite, Surface Mail, Air Mail etc..  

Condition -1: Special_Instructions="Next Day Air

````
<copy>
      SELECT extractValue(OBJECT_VALUE, '/PurchaseOrder/Reference') "REFERENCE"
      FROM purchaseorder WHERE existsNode(OBJECT_VALUE, '/PurchaseOrder[Special_Instructions="Next Day Air"]')=1;

</copy>
````


![](./images/xml_m10_aa.png " ")

Condition -2: Special_Instructions="Priority Overnight

````
<copy>
      SELECT extractValue(OBJECT_VALUE, '/PurchaseOrder/Reference') "REFERENCE"
    FROM purchaseorder
    WHERE existsNode(OBJECT_VALUE, '/PurchaseOrder[Special_Instructions="Priority Overnight"]')=1;

</copy>
````

![](./images/xml_m10_ba.png " ")
![](./images/xml_m10_ca.png " ")

**Notes**: ExistsNodechecks if xpath-expression returns at least one XML element or text node. If so, existsNode returns 1, otherwise, it returns 0. existsNode should only be used in the where clause of the select statement.
