# Graph Visualization

## Introduction

The results of the analyses done in the previous labs can easily be visualized using Graph Visualization feature.

Estimated time: 5 minutes

The following video provides an overview of the Graph Visualization component (= GraphViz).

[](youtube:zfefKdNfAY4)

### Objectives

- Learn how to execute PGQL graph queries and visualize the results.

### Prerequisites

- This lab assumes you have successfully completed Lab - Graph Query and Analysis with Python and published the graph. It also assumes the GraphViz is up and running on the compute instance on `public_ip_for_compute:7007/ui`. We will use the GraphViz to explore the graph and run some PGQL queries.

## **STEP 1:** Setup

Open the GraphViz at `https://<public_ip_for_compute>:7007/ui` **using Firefox**. Replace `<public_ip_for_compute>` with the one for your Graph Server compute instance.

You should see a screen similar to the screenshot below. Enter the username (`customer_360`) and password you entered when createing the user in SQL Developer Web.

![](images/ADB_GViz_Login.png)

## **STEP 2:** Modify query

Modify the query to get the first 5 rows, i.e. change `LIMIT 100` to `LIMIT 5`, and click Run.

You should see a graph similar to the screenshot below.

![](images/show-5-elements.jpg)

## **STEP 3:** Add highlights

Now let's add some labels and other visual context. These are known as highlights. Click [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/wQFPfdrO-aGGUwxBXSQDX2DzjFueYlgUZ40YoXLrP6x0bqIZrgpSBpyHEo3Q-i33/n/c4u03/b/data-management-library-files/o/highlights.json.zip) to download a zip file, `highlights.json.zip`. Unzip this file and note where it is unzipped.

Click on the Load button under Highlights (on the right side of the screen). Browse to the appropriate folder and choose the file and click Open to load that.

![](images/GraphVizLoadHighlights.png)

The graph should now look like

![](images/GraphVizWithHighlights.png)

## **STEP 4:** Pattern matching with PGQL

1. Next let's run a few PGQL queries.

    The [pgql-lang.org](http://pgql-lang.org) site and [Specification](http://pgql-lang.org/spec/1.3) are the best references for details and examples. For the purposes of this lab, however, here are minimal basics.

    The general structure of a PGQL query is

    ```
    SELECT <select list>
    FROM <graph_name>      (Please omit the graph name here, as it is selected from the GraphViz UI)
    MATCH <graph_pattern>
    WHERE <condition>
    ```

    PGQL provides a specific construct known as the `MATCH` clause for matching graph patterns. A graph pattern matches vertices and edges that satisfy the given conditions and constraints.  
    - `(v)` indicates a vertex variable `v`   
    - `-` indicates an undirected edge, as in (source)-(dest)  
    - `->` an outgoing edge from source to destination  
    - `<-` an incoming edge from destination to source  
    - `[e]` indicates an edge variable `e`

2. Let's find accounts that have had an outbound and and inbound transfer of over 500 on the same day.

    The PGQL query for this is:

    ```
    <copy>
    SELECT *
    FROM MATCH (a)-[t1:transfer]->(a1)
       , MATCH (a2)-[t2:transfer]->(a)
    WHERE t1.transfer_date = t2.transfer_date
      AND t1.amount > 500
      AND t2.amount > 500
    </copy>
    ```

    In the first `MATCH` clause above, `(a)` indicates the source vertex and `(a1)` the destination, while `[t1:transfer]` is the edge connecting them. The `:transfer` specifies that the `t1` edge has the label `TRANSFER`. The comma (`,`) between the two patterns is an AND condition.

3. Copy and paste the query into the PGQL Graph Query text input box of the GraphViz application. Click Run.

    The result should look as shown below. In the highlight settings, the accounts starting with `xxx-yyy-` are shown in red (= accounts of the bank), while `xxx-zzz-` are shown in orange (= accounts from another bank). 

    ![](images/same-day-transfers.jpg)

4. The next query finds patterns of transfers to and from the same two accounts, i.e. from a1->a2 and back a2->a1.

    The PGQL query for this is:
    ```
    <copy>
    SELECT *
    FROM MATCH (a1)-[t1:transfer]->(a2)-[t2:transfer]->(a1)
    WHERE t1.transfer_date < t2.transfer_date
    </copy>
    ```

5. Copy and paste the query into the PGQL Graph Query text input box of the GraphViz application. Click Run.

    The result should look as shown below.

    ![](images/cycle-2-hops.jpg)

6. Let's add one more account to that query to find a circular transfer pattern between 3 accounts.

    The PGQL query becomes:
    ```
    <copy>
    SELECT *
    FROM MATCH (a1)-[t1:transfer]->(a2)-[t2:transfer]->(a3)-[t3:transfer]->(a1)
    WHERE t1.transfer_date < t2.transfer_date
      AND t2.transfer_date < t3.transfer_date
    </copy>
    ```

7. Copy and paste the query into the PGQL Graph Query text input box of the GraphViz application. Click Run.

    The result should look as shown below.

    ![](images/cycle-3-hops.jpg)

## Acknowledgements

* **Author** - Jayant Sharma, Product Manager, Spatial and Graph.
* **Contributors** - Arabella Yao, Product Manager Intern, Database Management, and Jenny Tsai.
* **Last Updated By/Date** - Ryota Yamanaka, Feburary 2021
* **Lab Expiry Date** - November 30, 2021

