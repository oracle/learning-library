# Oracle XML

## Introduction

There are several steps within this lab.
-  The first step walks you through the steps of setting up the environment for XML lab . You can connect Oracle Database instance using any client you wish. In this lab, you will connect using Oracle SQL Developer.
-  The second step shows different ways to query XML data. XQuery is a very general and expressive language, and SQL/XML functions XMLQuery, XMLTable, XMLExists, and XMLCast combine that power of expression and computation with the strengths of SQL. We can query XMLType data, possibly decomposing the resulting XML into relational data using function XMLTable.
-  The third set of steps you will get to insert and update XML contents. We can update XML content or replace either the entire contents of a document or only particular parts of a document. The ability to perform partial updates on XML documents is very powerful, particularly when we make small changes to large documents, as it can significantly reduce the amount of network traffic and disk input-output required to perform the update. The Oracle UPDATEXML function allows us to update XML content stored in Oracle Database.

-  The last step you will look at various sample queries and functions within XML.

*Estimated Lab Time:* 15 Minutes

### Prerequisites
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: **Verify Compute Instance Setup**
    - Lab: **Setup SSH Tunnel** - using port(s) from this Lab as shown in *Step 0* below
    - Lab: **Start Database and Application**

***Note:***  All scripts for this lab are stored in the /u01/workshop/xml folder and are run as the oracle user.

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

## **Step 0:** Running the Workshop
### Setup SSH Tunnel(s)
As per security policies all external connections to this workshop instance are to be done over SSH. As a result, prior to executing this workshop, establish SSH tunnels over the instance public IP for port(s) 1521 as detailed in the table below. Please refer to *Lab 2 - Setup SSH Tunnel* for detailed instructions.

  | Description              | Client                 | Local port       | Remote Port     |
  | :----------------------- | :--------------------- | :--------------- | :-------------- |
  | Remote SQL Access        | SQL Developer          | 1521             | 1521            |.

***Note:*** Once this step is completed, all occurrences of the public IP of the instance when combined with above ports throughout this workshop should be substituted with *localhost*

### Login to Host using SSH Key based authentication
Refer to *Lab 1 - Verify Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
  - Authentication OS User - “*opc*”
  - Authentication method - *SSH RSA Key*
  - Oracle Software OS User – “*oracle*”. First login as “*opc*”, then sudo to “*oracle*”. E.g.

````
<copy>sudo su - oracle</copy>
````

***Note:*** Any SSH session you established in *Lab 2 - Setup SSH Tunnel* for SSH port forwarding can also be used for any task requiring SSH terminal access.

## **Step 1:** Connect to the Pluggable Database (PDB)

1. Open a terminal window and sudo to the user **oracle**
    ````
    <copy>
    sudo su - oracle
    </copy>
    ````

2. Navigate to the xml directory.
    ````
    <copy>
    cd /u01/workshop/xml
    </copy>
    ````

 3. Set your environment.
    ````
    <copy>
    . oraenv
    </copy>
    ````

4. When prompted paste the following:
    ````
    <copy>
    convergedcdb
    </copy>
    ````

5. Open SQLPlus as the user appjson

    ````
    <copy>
    sqlplus appxml/Oracle_4U@JXLPDB
    </copy>
    ````

## **Step 2:** Connect to SQL Developer

1. Make a connection to SQL Developer. Use the details as below and click on connect.

      - **Name**: XML
      - **Username**: appxml
      - **Password**: Oracle_4U
      - **Hostname**: localhost
      - **Port**: 1521
      - **Service name**: JXLPDB

  ![](./images/xml_sql_developer.png " ")

## **Step 3:** XML Query

1. Getting the number of XML documents.
    ````
    <copy>
    SELECT Count(*) FROM   purchaseorder p,  XMLTABLE('for $r in /PurchaseOrder return $r' passing object_value) t;
    </copy>
    ````

    ![](./images/xml_s3_p1.png " ")

2. Retrieving the content of an XML document-using pseudocolumn OBJECT_VALUE
    ````
    <copy>
      SELECT t.object_value.getclobval()FROM   purchaseorder t
      WHERE  rownum = 1;  
    </copy>
    ````

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

    ![](./images/xml_query_meth4a.png " ")


4. Searching XML document
    ````
    <copy>
     SELECT t.object_value.getclobval() FROM   purchaseorder t   WHERE  xmlexists('/PurchaseOrder[Reference/text()=$REFERENCE]' passing    object_value, 'AHUNOLD-20141130' AS "REFERENCE" )
         /

    </copy>
    ````

    ![](./images/xml_step3_search.png " ")

## **Step 4:** Insert XML record.

1. Let's take a count of the rows we have currently and then do a insert.

    ````
    <copy>
    select t.object_value.getclobval() from purchaseorder t;

     </copy>
     ````

     ![](./images/xml_s4_p1.png " ")


2. The insert query is available as a SQL file in the directory “**/u01/workshop/xml**”. The script is called as **insert.sql.** You can run this connecting to the SQL prompt.


3. Set your oracle environment and connect to PDB as **oracle** user.
    ````
    <copy>
    . oraenv
    </copy>
    ````
    ````
    <copy>
    convergedcdb
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

4. Verify XML record post insert

    ````
    <copy>select t.object_value.getclobval() from purchaseorder t;</copy>
    ````
    ![](./images/xml_s4_p3.png " ")

## **Step 5:** Update XML table

1. The update query is available as a sql file in the directory “**/u01/workshop/xml**”.
  The script is called as **update.sql**. You can run this connecting to the SQL prompt.

2. Set your oracle environment and connect to PDB as **oracle** user.
    ````
    <copy>
    . oraenv
    </copy>
    ````

    ````
    <copy>
    convergedcdb
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

    ![](./images/xml_s5_p1.png " ")

3. Below is the select query to check if user is updated.

    ````
    <copy>
    SELECT extractValue(OBJECT_VALUE, '/PurchaseOrder/User') FROM purchaseorder WHERE existsNode(OBJECT_VALUE, '/PurchaseOrder[Reference="MSD-20200505"]') =1;
    </copy>
    ````
    ![](./images/xml_s5_p2.png " ")

## **Step 6:** Example Queries

1. Get the list of the customer and their purchased information from a geo graphical location.  
    **XMLEXISTS** is an SQL/XML operator that you can use to query XML values in SQL, in a regular query I can use the xmlexists function to look if a specific value is present in an xmltype column.

    ````
    <copy>
      SELECT t.object_value.getclobval() FROM   purchaseorder t
      WHERE xmlexists('/PurchaseOrder/ShippingInstructions/Address[city/text()=$CITY]' passing object_value, 'South San Francisco' AS "CITY" );

    </copy>
    ````

    ![](./images/xml_s6_p1.png " ")

2. Customer purchase history  
    **XMLTABLE** converts XML Data into Rows and Columns using SQL. The XMLTABLE operator, which allows you to project columns on to XML data in an XMLTYPE , making it possible to query the data directly from SQL as if it were relational data.

    ````
    <copy>
      SELECT t.object_value.getclobval()
      FROM   purchaseorder p,
      XMLTABLE('for $r in /PurchaseOrder[Reference/text()=$REFERENCE] return $r' passing object_value, 'AHUNOLD-20141130' AS  "REFERENCE") t;  
    </copy>
    ````

    ![](./images/xml_step_6_q2.png " ")

3. Listing the product description those unit price matches to ‘$xx’.  
    **XMLSERIALIZE** is a SQL/XML operator that you can use to convert an XML type to a character type.

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

    ![](./images/xml_s6_p3.png " ")

4. Customer order summary – Cost center wise.  
    **XMLQUERY** lets you query XML data in SQL statements. It takes an XQuery expression as a string literal, an optional context item, and other bind variables and returns the result of evaluating the XQuery expression using these input values. XQuery string is a complete XQuery expression, including prolog.

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

5. Next Day Air - Customer Delivery Priority Instruction for e.g Ex - Courier, Expidite, Surface Mail, Air Mail etc..  
    **ExistsNodechecks** if xpath-expression returns at least one XML element or text node. If so, `existsNode` returns 1, otherwise, it returns 0. `existsNode` should only be used in the where clause of the select statement.

    ````
    <copy>
      SELECT extractValue(OBJECT_VALUE, '/PurchaseOrder/Reference') "REFERENCE"
      FROM purchaseorder WHERE existsNode(OBJECT_VALUE, '/PurchaseOrder[Special_Instructions="Next Day Air"]')=1;

    </copy>
    ````

    ![](./images/xml_m10_gg.png " ")

6. Priority Overnight - Customer Delivery Priority Instruction for e.g Ex - Courier, Expidite, Surface Mail, Air Mail etc..  
    **ExistsNodechecks** if xpath-expression returns at least one XML element or text node. If so, `existsNode` returns 1, otherwise, it returns 0. `existsNode` should only be used in the where clause of the select statement.

    ````
    <copy>
      SELECT extractValue(OBJECT_VALUE, '/PurchaseOrder/Reference') "REFERENCE"
    FROM purchaseorder
    WHERE existsNode(OBJECT_VALUE, '/PurchaseOrder[Special_Instructions="Priority Overnight"]')=1;

    </copy>
    ````

    ![](./images/xml_m10_ba.png " ")

## Want to learn more
- [XML](https://docs.oracle.com/en/database/oracle/oracle-database/19/adjsn/index.html)

## Acknowledgements
* **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
* **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K, Robert Ruppel, David Start, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
