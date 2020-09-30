
# Oracle Graph 

## Introduction 

This section describes how the tables are modeled as a graph and how the graph representation is generated from them.
In this instance the Vertex (or Node) entities are CUSTOMERS, ORDERS, STORES, and PRODUCTS.
While the Edge(s) are CUSTOMER\_ORDERED (from CUSTOMERS to ORDERS), ORDERED\_BY (the reverse edge from ORDERS to CUSTOMERS), ORDERED\_FROM\_STORE (ORDERS to STORES), STORE\_GOT\_ORDER (STORES to ORDERS), ORDER\_HAS\_PRODUCT (ORDERS to PRODUCTS), and PRODUCT\_IN\_ORDER (PRODUCTS to ORDERS)
A first cut at a graph model simply examines the primary key/foreign key relationships and uses the foreign keys to define the edges.

## Before You Begin

**What Do You Need?**

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup

## **Step 1:** Make a JDBC connection to the database:
At the jshell prompt.

````
<copy>
var jdbcUrl = "jdbc:oracle:thin:@<\instance_ip_address>:<\DB_Port>/SGRPDB";

</copy>
````

````
<copy>
var user = "appgrph";
</copy>
````

````
<copy>
var pass = "Oracle_4U";
</copy>
````

````
<copy>
var conn = DriverManager.getConnection(jdbcUrl, user, pass) ;
</copy>
````

Set auto commit to false.

This is needed for PGQL DDL and other queries.

````
<copy>
conn.setAutoCommit(false);
</copy>
````

Get a PgqlConnection.This will run PGQL queries directly against the VT$ (vertex) and GE$ (edge) tables 

````
<copy>
var pgql = PgqlConnection.getConnection(conn);
</copy>
````
![](./images/IMGG5.PNG) 

## **Step 2:** Create Graph

**Note: Below steps are already completed.**

We have created the views for the use of orders and order_items as multiple edge tables using below commands. 

````
<copy>
Create or replace view co_edge as select * from orders;
Create or replace view oc_edge as select * from orders;
Create or replace view os_edge as select * from orders;
Create or replace view so_edge as select * from orders;
Create or replace view op_edge as select * from order_items;
Create or replace view po_edge as select * from order_items;
</copy>
````

![](./images/IMGG6.PNG) 


We used a property graph query language [PGQL](http://pgql-lang.org) DDL to define and populate the graph.  The statement is as follows:

````
<copy>
CREATE PROPERTY GRAPH OE_SAMPLE_GRAPH
  VERTEX TABLES (
    customers KEY (CUSTOMER_ID) LABEL CUSTOMERS 
PROPERTIES(CUSTOMER_ID, EMAIL_ADDRESS, FULL_NAME),
    products KEY (PRODUCT_ID) LABEL PRODUCTS 
PROPERTIES (PRODUCT_ID, PRODUCT_NAME, UNIT_PRICE),
    orders KEY (ORDER_ID) LABEL ORDERS 
PROPERTIES (ORDER_ID, ORDER_DATETIME, ORDER_STATUS),
    stores KEY (STORE_ID) LABEL STORES 
PROPERTIES (STORE_ID, STORE_NAME, WEB_ADDRESS, PHYSICAL_ADDRESS, 
LATITUDE, LONGITUDE)
  )
  EDGE TABLES (
    co_edge
      SOURCE KEY (CUSTOMER_ID) REFERENCES customers
      DESTINATION KEY (ORDER_ID) REFERENCES orders
      LABEL CUSTOMER_ORDERED
      NO PROPERTIES,
    oc_edge
      SOURCE KEY (ORDER_ID) REFERENCES orders
      DESTINATION KEY (CUSTOMER_ID) REFERENCES customers
      LABEL ORDERED_BY
      NO PROPERTIES,
    os_edge 
      SOURCE KEY (ORDER_ID) REFERENCES orders
      DESTINATION KEY (STORE_ID) REFERENCES stores
      LABEL ORDERED_FROM_STORE
      NO PROPERTIES,
    so_edge 
      SOURCE KEY (STORE_ID) REFERENCES stores
      DESTINATION KEY (ORDER_ID) REFERENCES orders
      LABEL STORE_GOT_ORDER
      NO PROPERTIES,
    op_edge 
      SOURCE KEY (ORDER_ID) REFERENCES orders
      DESTINATION KEY (PRODUCT_ID) REFERENCES products
      LABEL ORDER_HAS_PRODUCT
      PROPERTIES (LINE_ITEM_ID, UNIT_PRICE, QUANTITY),
    po_edge 
      SOURCE KEY (PRODUCT_ID) REFERENCES products
      DESTINATION KEY (ORDER_ID) REFERENCES orders
      LABEL PRODUCT_IN_ORDER
      PROPERTIES (LINE_ITEM_ID)
  )
</copy>
````
The above PQGL query is saved as sql file (CreatePropertyGraph.sql) and stored in path /u01/graph and is run at jshell prompt.

````
<copy>
pgql.prepareStatement(Files.readString(Paths.get("/u01/graph/CreatePropertyGraph.sql"))).execute();
</copy>
````

The Graph Server kit includes the necessary components (a server application and JShell client) that will execute the above CREATE PROPERTY GRAPH statement and create the graph representation. 

The graph itself is stored in a set of tables named 

![](./images/g7.png)  

![](./images/IMGG7.PNG) 

The important ones are the ones that store the vertices (OE SAMPLE GRAPHVT$) and edges (OE SAMPLE GRAPHGE$).

Let’s look at the number of vertices and edges in the graph. 

**SQL query**

There will be multiple entries with the same vid one each for the labels and properties.

````
<copy>
select count(distinct vid) from oe_sample_graphvt$ ;
</copy>
````
(Vid is the vertex id.)

There can be multiple entries with the same eid one each for the label and properties.

````
<copy>
select count(distinct eid) from oe_sample_graphge$;
</copy>
````

(eid is the edge id)
## Step-3:  Required step to print the result of a PGQL statement

Create a convenience function which prepares, executes, and prints the result of a PGQL statement

````
<copy>
Consumer<\String> query = q -> { try(var s = pgql.prepareStatement(q)) { s.execute(); s.getResultSet().print(); } catch(Exception e) { throw new RuntimeException(e); } }
</copy>
````

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
  
