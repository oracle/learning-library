# Create the Customer_360 graph from the tables

## Introduction

Now, the tables are created and populated with data. Let's create a graph representation of them.

### Steps
- Modify the graph server configuration to disable Transport Layer Security (TLS) / Secure Sockets Layer (SSL) for this lab
- Start the graph server
- Start a client (JShell) that connects to the server
- Setup a Property Graph Query Language (PGQL) connection to the database
- Use PGQL Data Definition Language (DDL) (e.g. CREATE PROPERTY GRAPH) to instantiate a graph


## STEP 1: Modify the graph server config file

1. SSH into the compute instance where you installed the graph server.
    First navigate to the folder where you created your SSH Keys. And connect using:
    ```
    <copy>ssh -i &lt;private_key> opc@&lt;public_ip_for_compute></copy>
    ```

2. Switch to the user account (e.g. `oracle`) that has the database wallet and will run the server and client instances.

    *Note: You must logout and then log back in for the changes in the `oracle` user's `bash_profile` to take effect.*

    ```
    <copy>su - oracle</copy>
    ```

3. Then edit the `/etc/oracle/graph/server.conf` file.
    ```
    <copy>vi /etc/oracle/graph/server.conf</copy>
    ```

    Change the line  
    ` "enable_tls": true,`
    to  
    ` "enable_tls": false,`  

4. Save the file and exit.

    ![](../images/change_tls.png " ")

## STEP 2: Start the graph server

1. Check that JAVA\_HOME and JAVA11\_HOME env variables are set and correct. That is, JAVA\_HOME points to JDK1.8 and Java11\_HOME to jdk1.11.
    Using command:

    ```
    <copy>vi /home/oracle/.bash_profile</copy>
    ```

    You should see the following in your `.bash_profile`:
    ```
    JAVA_HOME=/usr/java/jdk1.8.0_251-amd64
    JAVA11_HOME=/usr/java/jdk-11.0.5

    export JAVA_HOME
    export JAVA11_HOME
    ```

2. Then, as the `oracle` user, start the server using
    ```
    <copy>/opt/oracle/graph/pgx/bin/start-server</copy>
    ```

    *Note: Do not exit this shell since the graph server process runs in the foreground.*

    You will see the following log output once the server is up and running. It may take a minute for this log output to show up.
    >INFO: Starting ProtocolHandler ["http-nio-7007"]

## STEP 3: Start a client shell

1. Once the graph server is up and running, open a new SSH connection to the same compute instance.  

2. Check that the exploded database wallet is in the compute instance and accessible from the user account which will run the graph client.

    Assuming the user is named `oracle` and the wallet is in `/home/oracle/wallets`. Check that the wallet exists and has the right permissions.

    ```
    <copy>su - oracle</copy>
    ```

    ```
    <copy>ls -l /home/oracle/wallets</copy>
    ```

    ![](../images/wallet_exist.png " ")


3. Then start a client shell instance that connects to the server
    ```
    <copy>/opt/oracle/graph/bin/opg-jshell --base_url http://localhost:7007</copy>
    ```
    ![](../images/connect_shell_to_server.png)

## STEP 4: Create the graph

Enter the following sets of commands once the JShell has started and is ready.

1. First setup the database connection. Enter the following into the JShell.  
   
    Replace *{db\_tns\_name}* with the appropriate database service name in the tnsnames.ora file of the wallet (e.g. `atpfinance_high`, if you follow the previous labs exactly).
    *Please refer back to Lab 4, Step 4, to check the content of `tnsnames.ora` file.*

    Replace *{wallet_location}* with the full path to the directory which has the unzipped wallet (e.g. `/home/oracle/wallets`).

    ```
    <copy>var jdbcUrl = "jdbc:oracle:thin:@{db_tns_name}?TNS_ADMIN={wallet_location}";</copy>
    ```

    ```
    <copy>var user = "customer_360";</copy>
    ```

    ```
    <copy>var pass = "Welcome1_C360";</copy>
    ```

    ```
    <copy>var conn = DriverManager.getConnection(jdbcUrl, user, pass) ;</copy>
    // example jshell output
    // conn ==> oracle.jdbc.driver.T4CConnection@54d11c70
    ```

2. Then create a PGQL connection and set its properties.

    ```
    // Get a PGQL connection in order to run PGQL statements
    // Set auto commit to false for PGQL
    <copy>conn.setAutoCommit(false);</copy>
    ```

    ```
    <copy>var pgql = PgqlConnection.getConnection(conn);</copy>

    // example jshell output
    // pgql ==> oracle.pg.rdbms.pgql.PgqlConnection@6493f780
    ```

3. Next set up the create property graph statement.

    ```
    
    // create the graph from the existing tab
    <copy>
    var cpgStmtStr = "CREATE PROPERTY GRAPH customer_360 " +
    "    VERTEX TABLES (" +
    "     customer " +
    "     PROPERTIES (type, name, age, location, gender, student) " +
    "   , account " +
    "     PROPERTIES (type, account_no, balance) " +
    " , merchant " +
    "     PROPERTIES (type, name) " +
    " ) " +
    " EDGE TABLES ( " +
    "   owned_by " +
    "     SOURCE KEY(from_id) REFERENCES account " +
    "     DESTINATION KEY(to_id) REFERENCES customer " +
    "     LABEL owned_by " +
    "     PROPERTIES (since) " +
    " , parent_of " +
    "     SOURCE KEY(from_id) REFERENCES customer " +
    "     DESTINATION KEY(to_id) REFERENCES customer " +
    "     LABEL parent_of " +
    " , purchased " +
    "     SOURCE KEY(from_id) REFERENCES account " +
    "     DESTINATION KEY(to_id) REFERENCES merchant " +
    "     LABEL purchased " +
    "     PROPERTIES (amount) " +
    " , transfer " +
    "     SOURCE KEY(from_id) REFERENCES account " +
    "     DESTINATION KEY(to_id) REFERENCES account " +
    "     LABEL transfer " +
    "     PROPERTIES (amount, date)" +
    " )" ;
    </copy>
    // example jshell output
    // cpgStmtStr ==> "CREATE PROPERTY GRAPH customer_360     VERTEX TABLES (     customer      PROPERTIES (type, name, age, location, gender, student)    , account      PROPERTIES (type, account_no, balance)  , merchant      PROPERTIES (type, name)  )  EDGE TABLES (    owned_by      SOURCE KEY(from_id) REFERENCES account      DESTINATION KEY(to_id) REFERENCES customer      LABEL owned_by      PROPERTIES (since)  , parent_of      SOURCE KEY(from_id) REFERENCES customer      DESTINATION KEY(to_id) REFERENCES customer      LABEL parent_of  , purchased      SOURCE KEY(from_id) REFERENCES account      DESTINATION KEY(to_id) REFERENCES merchant      LABEL purchased      PROPERTIES (amount)  , transfer      SOURCE KEY(from_id) REFERENCES account      DESTINATION KEY(to_id) REFERENCES account      LABEL transfer      PROPERTIES (amount, date) )"
    ```

    ![](../images/create_graph_1.png " ")

4. Now execute the PGQL DDL to first DROP any existing graph of the same name before CREATEing it.

    ```
    <copy>var dropPgStmt = "DROP PROPERTY GRAPH customer_360";</copy>
    ```

    ```
    // drop any existing garph
    <copy>pgql.prepareStatement(dropPgStmt).execute();</copy>
    ```

    ```
    // Now create the graph 
    <copy>pgql.prepareStatement(cpgStmtStr).execute();</copy>
    // example jshell output
    // $12 ==> false
    ```

    The create graph process can take 3-4 minutes depending on various factors such as network bandwidth and database load.

    ![](../images/create_graph_2.png  " ")

## STEP 5: Check the newly created graph

Check that the graph was created. Copy, paste, and run the following statements in the JShell.

1. Copy the following code, paste, and execute it in the JShell.

    ```
    // create a helper method for preparing, executing, and printing the results of PGQL statements
    <copy>Consumer&lt;String&gt; query = q -> { try(var s = pgql.prepareStatement(q)) { s.execute(); s.getResultSet().print(); } catch(Exception e) { throw new RuntimeException(e); } }</copy>
    // sample jshell output
    // query ==> $Lambda$583/0x0000000800695c40@65021bb4
    ```

2. Then copy, paste, and execute the following.

    ```
    // query the graph

    // what are the edge labels i.e. categories of edges
    <copy>query.accept("select distinct label(e) from customer_360 match ()-[e]->()");</copy>
    ```

    ```
    // what are the vertex types i.e. values of the property named "type"
    <copy>query.accept("select distinct v.type from customer_360 match (v)-[e]->()");</copy>
    ```

    ```
    // how many vertices with each type/category
    <copy>query.accept("select count(distinct v), v.type from customer_360 match (v) group by v.type");</copy>
    ```

    ```
    // how many edges with each label/category
    <copy>query.accept("select count(e), label(e) from customer_360 match ()-[e]->() group by label(e)");</copy>
    ```

    ![](../images/check_graph.png " ")
    You may now *proceed to the next lab* (query and analyse the graph in JShell)

## Acknowledgements

- **Author** - Jayant Sharma - Product Manager, Spatial and Graph.  
  With a little help from colleagues (Albert Godfrind and Ryota Yamanaka).  
  Thanks to Jenny Tsai for helpful, constructive feedback that improved this workshop.

- **Last Updated By/Date** - Arabella Yao, Product Manager Intern, Database Management, June 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.