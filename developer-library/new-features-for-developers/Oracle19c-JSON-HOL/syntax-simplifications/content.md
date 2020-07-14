# Oracle Database 19c JSON Documents

## Syntax Simplifications

In Oracle Database 19c, there were some improvements in the simplicity of querying JSON documents using SQL. Other improvements were made as well in generating JSON documents on the fly from relational data.

## Query JSON Data

This is a basic example of generating JSON documents from a relational table, to be used in a web service. Through these web services, you can integrate heterogeneous applications within the enterprise, or expose business functions to third parties over the internet. All this can be done directly from the database, without any other components installed and configured.

### Query JSON Data Using Plane SQL

Let’s consider **ORDERS** table from OE schema.

````
<copy>column ORDER_DATE format a28</copy>
````

````
> <copy>desc ORDERS</copy>
````

````
> <copy>select * from ORDERS;</copy>
````

SQL/JSON function ***JSON_OBJECT*** constructs JSON objects from relational (SQL) data. Using this function on a relational table to generate JSON, prior to 19c, it was necessary to specify for each column an explicit field name–value pair.

````
> <copy>select JSON_OBJECT (
    key 'OrderID' value to_char(o.order_id) format JSON,
    key 'OrderDate' value to_char(o.order_date) format JSON ) "Orders"
  from ORDERS o;</copy>
````

This requires more time and code to be written.

### JSON Query Improvements In Oracle 19C

In Oracle 19c, function ***JSON_OBJECT*** can generate JSON objects receiving as argument just a relational column name, possibly preceded by a table name or alias, or a view name followed by a dot. For example ***TABLE.COLUMN***, or just ***COLUMN***.

````
> <copy>select JSON_OBJECT(order_id, order_date) from ORDERS;</copy>
````

Another improvement was made in generating JSON documents in 19c using wildcard. The argument in this case can be the table name or alias, or a view name, followed by a dot and an asterisk wildcard (.*), or just an asterisk wildcard like in the following example.

````
> <copy>SELECT json_object(*) FROM ORDERS;</copy>
````

In conclusion, in Oracle 19c we can say that ***JSON_OBJECT*** function follows what is allowed for column names and wildcards in a SQL SELECT query. 

### Using Custom Types And Wildcard

There are some cases, exceptions, where wildcards are not accepted for tables with columns of certain custom data types, like our table **CUSTOMERS**, for example.

````
> <copy>desc CUSTOMERS</copy>  
       
 Name                      Null?    Type
 ------------------------- -------- ---------------------
 CUSTOMER_ID               NOT NULL NUMBER(6)
 CUST_FIRST_NAME           NOT NULL VARCHAR2(20)
 CUST_LAST_NAME            NOT NULL VARCHAR2(20)
 CUST_ADDRESS                       CUST_ADDRESS_TYP
 PHONE_NUMBERS                      PHONE_LIST_TYP
 NLS_LANGUAGE                       VARCHAR2(3)
 NLS_TERRITORY                      VARCHAR2(30)
 CREDIT_LIMIT                       NUMBER(9,2)
 CUST_EMAIL                         VARCHAR2(30)
 ACCOUNT_MGR_ID                     NUMBER(6)
 CUST_GEO_LOCATION                  MDSYS.SDO_GEOMETRY
 DATE_OF_BIRTH                      DATE
 MARITAL_STATUS                     VARCHAR2(20)
 GENDER                             VARCHAR2(1)
 INCOME_LEVEL                       VARCHAR2(20)
````

Asterisk wildcard is allowed in a normal SQL query.

````
> <copy>select * from CUSTOMERS;</copy>
```` 

But we receive an error if we try to use the asterisk wildcard with ***JSON_OBJECT*** function.

````
> <copy>select JSON_OBJECT(*) from CUSTOMERS;</copy>

ERROR at line 1:
ORA-40579: star expansion is not allowed
```` 

There is a solution for that.

### Workaround For Custom Types

The workaround for this issue is to create a view on the original table. This view will compile the custom data types and will use the result as standard data types.

````
> <copy>CREATE OR REPLACE VIEW view_cust AS SELECT * FROM customers;</copy>
````

````
> <copy>SELECT json_object(*) FROM view_cust;</copy>
````

In conclusion, instead of passing SQL expressions that are used to define individual JSON object members, you can pass a single instance of a user-defined SQL object type. This produces a JSON object whose field names are taken from the object attribute names and whose field values are taken from the object attribute values (to which JSON generation is applied recursively). Or use an asterisk (*) wildcard as a shortcut to explicitly specifying all of the columns of a given table or view to produce object members. The resulting object field names are the uppercase column names. You can use a wildcard with a table, a view, or a table alias. 

---