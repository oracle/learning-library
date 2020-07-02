# Use Case: Customer 360 analysis #

## Overview
  This example shows how integrating multiple datasets, using a graph, facilitates additional analytics and can lead to new insights. We will use three small datasets for illustrative purposes. The first contains accounts and account  owners. The second is purchases by the people who own those accounts. The third is transactions between these accounts.

  The combined dataset is then used to perform the following common graph query and analyses: pattern matching, detection of cycles, finding important nodes, community detection, and recommendation.

  *Note: This lab assumes you have successfully completed the previous steps (Labs 1 through Lab 7).*


## STEP 1: Graph Query and Analysis in JShell

### SECTION 1: Skip the following if you completed the Create Graph step and the graph server and client are up.  
  >Open an SSH connection to the compute instance. `su` to the `oracle` user or whichever user deployed the graph server and client kit and was added to the oraclegraph group in Lab 3.3.
  >
  > Check that  the line  
  >` "enable_tls": true,`  
  >in `/etc/oracle/graph/server.conf` is set to false, i.e. it is  
  >` "enable_tls": false,`  


  >Start the graph server.

  ```
  <copy>/opt/oracle/graph/pgx/bin/start-server</copy>
  ```

  >Once it has started and you see the notification `INFO: Starting ProtocolHandler ["http-nio-7007"]` open a new SSH connection, if necessary, to the compute instance.  
  >`su` to the `oracle` user or whichever user deployed the graph server and client kit and was added to the >oraclegraph group in Lab 3.  
  >
  >Start the JShell in the graph server. Copy and paste the following command to do that.
  ```
  <copy>/opt/oracle/graph/bin/opg-jshell --base_url http://localhost:7007</copy>
  ```

  >That starts up a shell which connects to the server instance running on the graph server.
  >Once it starts up you should see the following:

  ```
  For an introduction type: /help intro
  Oracle Graph Server Shell 20.2.0
  PGX server version: 20.0.2 type: SM
  PGX server API version: 3.7.2
  PGQL version: 1.3
  Variables instance, session, and analyst ready to use.
  opg-jshell>
  ```
### SECTION 2: End of portion to skip when server and client are already up and running.

  Check to see which graphs have been loaded into the graph server. 

  ```
  <copy>session.getGraphs();</copy>
  ```

  If the `Customer_360' graph exists in the in-memory graph server then load it into the client shell.
  ```
  <copy>var graph = session.getGraph("Customer_360");</copy>
  ```

  If it **does not exist** then read it from the database. 
  The necessary steps are:
  - Set up the JDBC connection. **Modify the URL for your instance**  
  For `{db_service}` use  database service name from the tnsnames file in the ADB Wallet you downloaded when setting up your ADB instance.  
  For `{wallet_location}` specify the directory where you unzipped the downlaoded wallet in the compute instance.
  - Specifcy a graph config.
  - Read the graph into memory.

  ```
  <copy>
  var jdbcUrl = "jdbc:oracle:thin:@{db_service}?TNS_ADMIN={unzipped_wallet_location}";
  var user = "customer_360";
  var pass = "Welcome1_C360";
  var conn = DriverManager.getConnection(jdbcUrl, user, pass) ;
  </copy>
  // conn ==> oracle.jdbc.driver.T4CConnection@54d11c70
  ```

  Copy, paste, and execute the following code in JShell.

  ```
  <copy>
  // now load the graph into memory to run some more analyses
  // specify the graph config (i.e. vertex and edge properties and datatypes)
  Supplier&lt;GraphConfig&gt; pgxConfig = () -> { return GraphConfigBuilder.forPropertyGraphRdbms()
  .setJdbcUrl(jdbcUrl)
  .setUsername(user)
  .setPassword(pass)
  .setName("Customer_360")
  .addVertexProperty("TYPE", PropertyType.STRING)
  .addVertexProperty("NAME", PropertyType.STRING)
  .addVertexProperty("LOCATION", PropertyType.STRING)
  .addVertexProperty("GENDER", PropertyType.STRING)
  .addVertexProperty("STUDENT", PropertyType.STRING)
  .addVertexProperty("ACCOUNT_NO", PropertyType.STRING)
  .addVertexProperty("AGE", PropertyType.INTEGER)
  .addVertexProperty("BALANCE", PropertyType.DOUBLE)
  .addEdgeProperty("SINCE", PropertyType.STRING)
  .addEdgeProperty("DATE", PropertyType.STRING)
  .addEdgeProperty("AMOUNT", PropertyType.DOUBLE)
  .setLoadVertexLabels(false)
  .setLoadEdgeLabel(true)
  .setKeystoreAlias("alias")
  .build(); }
  </copy>
  // pgxConfig ==> $Lambda$607/0x0000000800add440@616d9a6d
  ```

  ```
  <copy>
  // load the graph. Can take 4-5 minutes depending on network bandwidth

  var graph = session.readGraphWithProperties(pgxConfig.get()) ;
  </copy>
  // graph ==> PgxGraph[name=Customer_360,N=15,E=24,created=1591215633384]
  ```

  Now we can query this graph and run some analyses on it.

### SECTION 3: Pattern Matching

  PGQL Query is convenient for detecting specific patterns.

  Find accounts that had an inbound and an outbound transfer, of over 500, on the same day. The PGQL query for this is:

  ```
  <copy>
  graph.queryPgql(
    " SELECT a.ACCOUNT_NO, a.BALANCE, t1.AMOUNT, t2.AMOUNT, t1.DATE " +
    " MATCH (a)<-[t1:TRANSFER]-(a1) " +
    "    , (a)-[t2:TRANSFER]->(a2) " +
    " WHERE t1.DATE = t2.DATE " +
    "  AND t1.AMOUNT > 500 " +
    "  AND t2.AMOUNT > 500 "
  ).print();
  </copy>

  +---------------------------------------------------------------+
  | a.account_no | a.balance | t1.amount | t2.amount | t1.date    |
  +---------------------------------------------------------------+
  | xxx-yyy-202  | 200       | 900       | 850       | 2018-10-06 |
  +---------------------------------------------------------------+
  ```

### SECTION 4: Detection of Cycles

  Next we use PGQL to find a series of transfers that start and end at the same account such as A to B to A, or A to B to C to A.

  The first query could be expressed as:

  ```
  <copy>
  graph.queryPgql(
  "  SELECT a1.ACCOUNT_NO, t1.DATE, t1.AMOUNT, a2.ACCOUNT_NO, t2.DATE, t2.AMOUNT " +
  "  MATCH (a1)-[t1:TRANSFER]->(a2)-[t2:TRANSFER]->(a1) " +
  " WHERE t1.DATE < t2.DATE"
  ).print();
  </copy>

  +---------------------------------------------------------------------------------+
  | a1.account_no | t1.date    | t1.amount | a2.account_no | t2.date    | t2.amount |
  +---------------------------------------------------------------------------------+
  | xxx-yyy-201   | 2018-10-05 | 200       | xxx-yyy-202   | 2018-10-10 | 300       |
  +---------------------------------------------------------------------------------+
  ```

  ![](../../customer_360_analysis/images/detection.jpg)

  The second query just adds one more transfer to the pattern (list) and could be expressed as:


  ```
  <copy>
  graph.queryPgql(
  "  SELECT a1.ACCOUNT_NO, t1.AMOUNT, a2.ACCOUNT_NO, t2.AMOUNT " +
  "       , a3.ACCOUNT_NO, t3.AMOUNT " + 
  "  MATCH (a1)-[t1:TRANSFER]->(a2)-[t2:TRANSFER]->(a3)-[t3:TRANSFER]->(a1) " +
  "  WHERE t1.DATE < t2.DATE " +
  "    AND t2.DATE < t3.DATE "
  ).print();
  </copy>

  +-----------------------------------------------------------------------------------+
  | a1.account_no | t1.amount | a2.account_no | t2.amount | a3.account_no | t3.amount |
  +-----------------------------------------------------------------------------------+
  | xxx-yyy-201   | 500       | xxx-yyy-203   | 400       | xxx-yyy-204   | 300       |
  +-----------------------------------------------------------------------------------+
  ```

  ![](../../customer_360_analysis/images/detection2.jpg)


### SECTION 5: Influential Accounts

  Filter customers from the graph. (cf. [Filter Expressions](https://docs.oracle.com/cd/E56133_01/latest/prog-guides/filter.html))

  ```
  <copy>var sg = graph.filter(new EdgeFilter("edge.label()='TRANSFER'")); </copy>
  ```  
  Run [pagerank](https://docs.oracle.com/cd/E56133_01/latest/reference/analytics/algorithms/pagerank.html) algorithm.

  ```
  <copy>analyst.pagerank(sg); </copy>
  ```

  Show the result.

  ```
  <copy>
  sg.queryPgql(
  " SELECT a.ACCOUNT_NO, a.PAGERANK " +
  " MATCH (a) " + 
  " ORDER BY a.PAGERANK DESC "
  ).print();
  </copy>

  +-------------------------------------+
  | a.account_no | a.pagerank           |
  +-------------------------------------+
  | xxx-yyy-201  | 0.18012007557258927  |
  | xxx-yyy-204  | 0.1412461615467829   |
  | xxx-yyy-203  | 0.1365633635065475   |
  | xxx-yyy-202  | 0.12293884324085073  |
  | xxx-zzz-212  | 0.05987452026569676  |
  | xxx-zzz-211  | 0.025000000000000005 |
  +-------------------------------------+
  ```

### SECTION 6: Community Detection

  Let's find which subsets of accounts form communities. That is, there are more transfers among accounts in the same subset than there are between those and accounts in another subset. We'll use the built-in weekly / strongly connected components algorithm.

  The first step is to create a subgraph that only has the accounts and the transfers among them. This is done by creating and applying an edge filter (for edges with the table "transfer') to the graph.

  Filter customers from the graph.
  ```
  <copy>var sg = graph.filter(new EdgeFilter("edge.label()='TRANSFER'")); </copy>
  ```  

  [Weakly connected component](https://docs.oracle.com/cd/E56133_01/latest/reference/analytics/algorithms/wcc.html) algorithm detects only one partition.

  ```
  <copy>
  var result = analyst.wcc(sg);
  // The partition value is stored in a property named wcc
  sg.queryPgql(
  " SELECT a.WCC, COUNT(a) MATCH (a) GROUP BY a.WCC"
  ).print();
  </copy>
  ```

  Run a strongly connected components algorithm, SCC Kosaraju, instead.

  [Strongly connected component](https://docs.oracle.com/cd/E56133_01/latest/reference//analytics/algorithms/scc.html) algorithm detects three partitions.

  ```
  <copy>
  result = analyst.sccKosaraju(sg);
  // List partitions and number of vertices in each
  sg.queryPgql(
  " SELECT a.SCC_KOSARAJU, COUNT(a) MATCH (a) GROUP BY a.SCC_KOSARAJU"
  ).print();
  </copy>

  +---------------------------+  
  | a.scc_kosaraju | COUNT(a) |  
  +---------------------------+  
  | 1              | 4        |  
  | 2              | 1        |  
  | 0              | 1        |  
  +---------------------------+  
  ```

  List the other accounts in the same conneted component (partition) as John's account.

  The partition (or component) id is added as a property named scc_kosaraju for use in PGQL queries.

  ```
  <copy>
  sg.queryPgql(
  " SELECT a.SCC_KOSARAJU as component, COUNT(a.ACCOUNT_NO), MAX(a.ACCOUNT_NO) " +
  " MATCH (a) " +
  " GROUP BY component " +
  " ORDER BY component"
  ).print();
  </copy>

  +-------------------------------------------------------+  
  | component   | COUNT(a.account_no) | MAX(a.account_no) |  
  +-------------------------------------------------------+  
  | 0           | 1                   | xxx-zzz-001       |  
  | 1           | 4                   | xxx-yyy-204       |  
  | 2           | 1                   | xxx-zzz-002       |  
  +-------------------------------------------------------+  
  ```

  ![](../../customer_360_analysis/images/community.jpg)


### SECTION 7: Recommendation

  Lastly let's use Personalized PageRank to find stores that John may purchase from given that people he is connected to have made purchases from those stores.

  Filter customers and merchants from the graph.
  ```
  <copy>var sg = graph.filter(new EdgeFilter("edge.label()='PURCHASED'"));</copy>
  ```

  Add reverse edges. Copy, paste, and execute both sets of code cnippets below.

  ```
  <copy>
  var cs = sg.&lt;Long&gt;createChangeSet();
  var rs = sg.queryPgql("SELECT id(a), id(x) MATCH (a)-[]->(x)");
  for (var r : rs) {
    var e = cs.addEdge(r.getLong(2),r.getLong(1)).setLabel("PURCHASED_BY");
  }
  sg = cs.build();
  sg.queryPgql(
  " SELECT ID(r), x.NAME, LABEL(r), a.ACCOUNT_NO" +
  "  MATCH (x)-[r:PURCHASED_BY]->(a)" +
  " LIMIT 3"
  ).print();
  </copy>

  +---------------------------------------------------+
  | ID(r) | x.name      | LABEL(r)     | a.account_no |
  +---------------------------------------------------+
  | 11    | Apple Store | purchased_by | xxx-yyy-201  |
  | 16    | Apple Store | purchased_by | xxx-yyy-202  |
  | 19    | Apple Store | purchased_by | xxx-yyy-203  |
  +---------------------------------------------------+
  ```

  ![](../../customer_360_analysis/images/recommendation1.jpg)


  ![](../../customer_360_analysis/images/recommendation2.jpg)

  We will focus on the account no. xxx-yyy-201 (John's account) and run PPR.

  ```
  <copy>
  sg.queryPgql("select id(a) match (a) where a.ACCOUNT_NO='xxx-yyy-201'").print();
  </copy>

  +---------------------+
  | id(a)               |
  +---------------------+
  | 3244710687574720295 |
  +---------------------+
  ```

  Copy, paste, and execute both sets of code snippets below.


  ```
  <copy>
  var vertexSet = sg.&lt;Long&gt;createVertexSet();
  vertexSet.addAll(3244710687574720295L);
  var ppr = analyst.personalizedPagerank(sg, vertexSet);
  </copy>
  ```

  Show the result. (cf. [EXISTS and NOT EXISTS subqueries](https://pgql-lang.org/spec/1.3/#exists-and-not-exists-subqueriess))

  ```
  <copy>
  sg.queryPgql(
  "  SELECT ID(x), x.NAME, x.PAGERANK " +
  "  MATCH (x) " +
  "  WHERE x.TYPE = 'merchant' " +
  "    AND NOT EXISTS ( " +
  "     SELECT * " +
  "     MATCH (x)-[:PURCHASED_BY]->(a) " +
  "     WHERE ID(a) = 3244710687574720295 " +
  "    ) " +
  "  ORDER BY x.PAGERANK DESC"
  ).print();
  </copy>

  +----------------------------------------------------------+
  | ID(x)               | x.name       | x.pagerank          |
  +----------------------------------------------------------+
  | 6541727421521309923 | Asia Books   | 0.04932640133302745 |
  | 8574591124594145469 | Kindle Store | 0.04932640133302745 |
  | 8664546881222905044 | ABC Travel   | 0.01565535511504672 |
  +----------------------------------------------------------+
  ```

## STEP 2: Publish the Graph for use with the visualization component

  Run the following to publish the graph while still in the JShell.
  ```
  <copy>
  // publish the customer_360 graph so that other sessions , e.g. the GraphViz webapp can use it
  graph.publish(VertexProperty.ALL, EdgeProperty.ALL) ;
  </copy>
  ```


## Acknowledgements ##

- **Author** -  Jayant Sharma - Product Manager, Spatial and Graph  
With a little help from colleagues (Albert Godfrind and Ryota Yamanaka). And lots from Jenny Tsai. Thank you.

- **Last Updated By/Date** - Arabella Yao, Product Manager Intern, Database Management, June 2020