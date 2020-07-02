# Use Case: Customer 360 analysis #

## Overview
The results of the analyses done in the previous labs can easily be visualized using Graph Visualization.

The following video provides an overview of the visualization component.
[](youtube:zfefKdNfAY4)

**Note:** This lab assumes you have successfully completed Lab 3.8 and published the graph. It also assumes the Graph Visualization component is up and running on the compute instance on `public_ip_for_compute:7007/ui`.

## Graph Visualization

Next we will use the Graph Visualization component to explore the graph and run some PGQL queries.
Open the Graph Viz at `http://<public_ip_for_free_tier_compute>:7007/ui`. Replace `public_ip_for_free_tier_compute` with the one for your instance.

You should see a screen similar to the screenshot below.  
![GraphViz on startup](../images/ADB_GViz_Landing.png)


Modify the query to get the first 50 rows, i.e. change LIMIT 10 to LIMIT 50, and click Run.

You should see a graph similar to the screenshot below.  
![Customer 360 graph](../images/ADB_GViz_Show50Elements.png)

Now let's add some labels and other visual context. These are known as highlights.  
**Note:** If you did the first lab (Setup witn Docker) and cloned the `oracle-pg` repo then the required `highlights.json` file is in the `customer_360` folder. If however you are doing this (Setup with Free Tier) lab by itself then right-click on this link [download highlights.json](highlights.json) to download it.

Click on the Load button under Highlights (on the right side of the screen). Browse to the appropriate folder (i.e. either to `oracle-pg/graphs/customer_360`  or the folder where you just downloaed it) and choose the file named 'highlights.json' and click Open to load that.  
![Load highlights for graph](../../customer_360_analysis/images/GraphVizLoadHighlights.png)

The graph should now look like  
![Customer 360 graph with highlights](../../customer_360_analysis/images/GraphVizWithHighlights.png)

### Pattern matching with PGQL
Next let's run a few PGQL queries. 

The [pgql-lang.org](http://pgql-lang.org) site and [specification](http://pgql-land.org/spec/1.2) are the best reference for details and examples. For the purposes of this lab, however, here are minimal basics. 

The general structure of a PGQL query is
```
SELECT <select list>
FROM <graph_name> 
MATCH <graph_pattern>
WHERE <condition>
```

PGQL provides a specific construct known as the MATCH clause for matching graph patterns. A graph pattern matches vertices and edges that satisfy the given conditions and constraints.  
- `(v)` indicates a vertex variable `v`   
- `-` indicates an undirected edge, as in (source)-(dest)  
- `->` an outgoing edge from source to destination  
- `<-` an incoming edge from destination to source  
- `[e]` indicates an edge variable `e`

Let's find accounts that have had an outbound and and inbound transfer of over 500 on the same day.

The PGQL query for this is:
```
<copy>
SELECT * 
MATCH (FromAcct)-[TransferOut:TRANSFER]->(ToAcct1), (ToAcct2)-[TransferIn:TRANSFER]->(FromAcct)
WHERE TransferOut.DATE = TransferIn.DATE and TransferOut.AMOUNT > 500 and TransferIn.AMOUNT > 500
</copy>
```
In the query text above (FromAcct) indicates the source vertex and (ToAcct1) the destination, while [TransferOut:transfer] is the edge connecting them. The [:transfer] specifies that the TransferOut edge has  the label 'transfer'. The comma (',') between the two patterns is an AND condition. 

Copy and paste the query into the PGQL Graph Query text input box of the GraphViz application.
Click Run.

The result should look as shown below.

![Same day txns of more than 500](../images/ADB_Gviz_SameDayTransfers.png)

The next query finds patterns of transfers to and from the same two accounts, i.e. from A->B and back B->A.

The PGQL query for this is:
```
<copy>
SELECT * 
MATCH (FromAcct)-[TransferOut:TRANSFER]->(ToAcct)-[TransferIn:TRANSFER]->(FromAcct)
WHERE TransferOut.DATE < TransferIn.DATE 
</copy>
```

Copy and paste the query into the PGQL Graph Query text input box of the GraphViz application.
Click Run.

The result should look as shown below.

![Transfer A to B to A](../images/ADB-GViz_ABA_Transfer.png)

Let's add one more account to that query to find a circular transfer pattern between 3 accounts. 

The PGQL query becomes:
```
<copy>
SELECT * 
MATCH (FromAcct)-[TxnAB:TRANSFER]->(ToAcctB)-[TxnBC:TRANSFER]->(ToAcctC)-[TxnCA:TRANSFER]->(FromAcct)
WHERE TxnAB.DATE < TxnBC.DATE and TxnBC.DATE < TxnCA.DATE
</copy>
```

Copy and paste the query into the PGQL Graph Query text input box of the GraphViz application.
Click Run.

The result should look as shown below.

![Circular transfer A to B to C to A](../images/ADB_GViz_ABCA_Transfer.png)


## Acknowledgements ##

- **Author** - Jayant Sharma - Product Manager, Spatial and Graph.  
With a little help from colleagues (Albert Godfrind and Ryota Yamanaka). And lots from Jenny Tsai. Thank you.