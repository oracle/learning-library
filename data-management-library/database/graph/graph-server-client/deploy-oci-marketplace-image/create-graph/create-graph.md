# Create the Graph

## Introduction

Now, the tables are created and populated with data. Let's create a graph representation of them.

Estimated time: 5 minutes

### Objectives

Learn how to create a graph from relational data sources by:
- Restarting the graph server
- Starting a client (Python shell) that connects to the server
- Using PGQL Data Definition Language (DDL) (e.g. CREATE PROPERTY GRAPH) to instantiate a graph

### Prerequisites

- This lab assumes you have successfully completed the lab - Create and populate tables.

## **STEP 1:** Start the Python client

Start a client shell instance that connects to the server

```
<copy>
opgpy -b https://localhost:7007 --username customer_360
</copy>
```

You should see the following if the client shell starts up successfully.

```
enter password for user customer_360 (press Enter for no password):
Oracle Graph Client Shell 21.1.0
>>>
```

## **STEP 2:** Create the graph

Set up the create property graph statement, which creates the graph from the existing tables.

```    
<copy>
statement = '''
CREATE PROPERTY GRAPH "customer_360"
  VERTEX TABLES (
    customer
  , account
  , merchant
  )
  EDGE TABLES (
    account
      SOURCE KEY(id) REFERENCES account
      DESTINATION KEY(customer_id) REFERENCES customer
      LABEL owned_by PROPERTIES (id)
  , parent_of
      SOURCE KEY(customer_id_parent) REFERENCES customer
      DESTINATION KEY(customer_id_child) REFERENCES customer
  , purchased
      SOURCE KEY(account_id) REFERENCES account
      DESTINATION KEY(merchant_id) REFERENCES merchant
  , transfer
      SOURCE KEY(account_id_from) REFERENCES account
      DESTINATION KEY(account_id_to) REFERENCES account
  )
'''
</copy>
```

For more about DDL syntax, please see [pgql-lang.org](https://pgql-lang.org/spec/1.3/#create-property-graph). Please note that **all columns of the input tables are mapped to the properties of vertices/edges [by default](https://pgql-lang.org/spec/1.3/#properties)**. For `owned_by` edge, only `id` property is given with `PROPERTIES` keyword for edge ID generation purpose, and the other properties are not given, because they are already hold by the account vertices. 

Now execute the PGQL DDL to create the graph.

```
<copy>
session.prepare_pgql(statement).execute()
</copy>

False   // This is the expected result
```

## **STEP 3:** Check the newly created graph

Check that the graph was created. Copy, paste, and run the following statements in the Python shell.

Attach the graph to check that the graph was created.
```
<copy>
graph = session.get_graph("customer_360")
graph
</copy>

PgxGraph(name: customer_360, v: 15, e: 24, directed: True, memory(Mb): 0)
```

Run some PGQL queries.

The list of the vertex labels:
```
<copy>
graph.query_pgql("""
  SELECT DISTINCT LABEL(v) FROM MATCH (v)
""").print()
</copy>

+----------+
| LABEL(v) |
+----------+
| ACCOUNT  |
| CUSTOMER |
| MERCHANT |
+----------+
```

How many vertices with each label:
```
<copy>
graph.query_pgql("""
  SELECT COUNT(v), LABEL(v) FROM MATCH (v) GROUP BY LABEL(v)
""").print()
</copy>

+---------------------+
| COUNT(v) | LABEL(v) |
+---------------------+
| 5        | MERCHANT |
| 6        | ACCOUNT  |
| 4        | CUSTOMER |
+---------------------+
```

The list of the edge labels:
```
<copy>
graph.query_pgql("""
  SELECT DISTINCT LABEL(e) FROM MATCH ()-[e]->()
""").print()
</copy>

+-----------+
| LABEL(e)  |
+-----------+
| OWNED_BY  |
| PARENT_OF |
| PURCHASED |
| TRANSFER  |
+-----------+
```

How many edges with each label:
```
<copy>
graph.query_pgql("""
  SELECT COUNT(e), LABEL(e) FROM MATCH ()-[e]->() GROUP BY LABEL(e)
""").print()
</copy>

+----------------------+
| COUNT(e) | LABEL(e)  |
+----------------------+
| 4        | OWNED_BY  |
| 8        | TRANSFER  |
| 1        | PARENT_OF |
| 11       | PURCHASED |
+----------------------+
```

## **STEP 4:** Publish the graph (optional)

The newly created graph is "private" by default, and is accessible only from the current session. To access the graph from new sessions in future, you can "publish" the graph.

First, login to SQL Developer Web as the `admin` user, and give permission to publish graphs to the `customer_360` user.
```
GRANT PGX_SESSION_ADD_PUBLISHED_GRAPH TO customer_360;
```

Exit the Python shell and re-connect to pick up the updated permissions, then create the graph again and publish it.
```
<copy>
opgpy -b https://localhost:7007 --username customer_360
</copy>
```
```
<copy>
graph.publish()
</copy>
```

Next time you connect you can access the graph in-memory without re-loading it, if the graph server has not been shutdown or restarted between logins.
```
<copy>
graph = session.get_graph("customer_360")
</copy>
```

You may now proceed to the next lab.

## Acknowledgements

- **Author** - Jayant Sharma, Product Manager, Spatial and Graph
- **Contributors** - Thanks to Jenny Tsai for helpful, constructive feedback that improved this workshop. Arabella Yao, Product Manager Intern, Database Management
- **Last Updated By/Date** - Ryota Yamanaka, Feburary 2020

