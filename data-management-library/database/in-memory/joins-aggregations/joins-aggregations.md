# In-Memory Joins and Aggregations

## Introduction

### Objectives

-   Learn how to enable In-Memory on the Oracle Database
-   Perform various queries on the In-Memory Column Store

### Lab Prerequisites

This lab assumes you have completed the following labs:
* Lab: Login to Oracle Cloud
* Lab: Generate SSH Key
* Lab: Environment Setup
* Lab: Enabling In-Memory
* Lab: Querying the IMC

### Lab Preview

Watch the video below to get an overview of joins using Database In-Memory.

[](youtube:y3tQeVGuo6g)

## Step: In-Memory Joins and Aggregation

Up until now we have been focused on queries that scan only one table, the LINEORDER table. Let’s broaden the scope of our investigation to include joins and parallel execution. This section executes a series of queries that begin with a single join between the  fact table, LINEORDER, and a dimension table and works up to a 5 table join. The queries will be executed in both the buffer cache and the column store, to demonstrate the different ways the column store can improve query performance above and beyond the basic performance benefits of scanning data in a columnar format.

1.  Let's switch to the Part2 folder and log back in to the PDB. 
    ````
    <copy>
    cd /home/oracle/labs/inmemory/Part3
    sqlplus ssb/Ora_DB4U@localhost:1521/orclpdb
    set pages 9999
    set lines 100
    <copy>    
    ````

    ![](images/num1.png " ") 

2.  Join the LINEORDER and DATE\_DIM tables in a "What If" style query that calculates the amount of revenue increase that would have resulted from eliminating certain company-wide discounts in a given percentage range for products shipped on a given day (Christmas eve 1996).  In the first one, execute it against the IM column store.  

    ````
    <copy>
    set timing on

    SELECT SUM(lo_extendedprice * lo_discount) revenue 
    FROM   lineorder l, 
    date_dim d 
    WHERE  l.lo_orderdate = d.d_datekey 
    AND    l.lo_discount BETWEEN 2 AND 3 
    AND    l.lo_quantity < 24 
    AND    d.d_date='December 24, 1996'; 

    set timing off

    select * from table(dbms_xplan.display_cursor());

    @../imstats.sql
    </copy>
    ````

    ![](images/num2.png) 

    The IM column store has no problem executing a query with a join because it is able to take advantage of Bloom Filters.  It’s easy to identify Bloom filters in the execution plan. They will appear in two places, at creation time and again when it is applied. Look at the highlighted areas in the plan above. You can also see what join condition was used to build the Bloom filter by looking at the predicate information under the plan. 

3.  Let's run against the buffer cache now.  

    ````
    <copy>
    set timing on

    select /*+ NO_INMEMORY */
    sum(lo_extendedprice * lo_discount) revenue
    from
    LINEORDER l,
    DATE_DIM d
    where
    l.lo_orderdate = d.d_datekey
    and l.lo_discount between 2 and 3
    and l.lo_quantity < 24
    and d.d_date='December 24, 1996';

    set timing off

    select * from table(dbms_xplan.display_cursor());

    @../imstats.sql
    </copy>
    ````
    ![](images/num3.png) 

4. Let’s try a more complex query that encompasses three joins and an aggregation to our query. This time our query will compare the revenue for different product classes, from suppliers in a certain region for the year 1997. This query returns more data than the others we have looked at so far so we will use parallel execution to speed up the elapsed times so we don’t need to wait too long for the results.  

    ````
    <copy>
    set timing on

    SELECT d.d_year, p.p_brand1,SUM(lo_revenue) rev 
    FROM   lineorder l, 
        date_dim d, 
        part p, 
        supplier s 
    WHERE  l.lo_orderdate = d.d_datekey 
    AND    l.lo_partkey = p.p_partkey 
    AND    l.lo_suppkey = s.s_suppkey 
    AND    p.p_category = 'MFGR#12' 
    AND    s.s_region   = 'AMERICA'
    AND    d.d_year     = 1997 
    GROUP  BY d.d_year,p.p_brand1; 

    set timing off

    select * from table(dbms_xplan.display_cursor());

    @../imstats.sql
    </copy>
    ````

    ![](images/num4a.png) 

    ![](images/num4b.png) 

    The IM column store continues to out-perform the buffer cache query but what is more interesting is the execution plan for this query: 

    In this case, we noted above that three join filters have been created and applied to the scan of the LINEORDER table, one for the join to DATE\_DIM table, one for the join to the PART table, and one for the join to the SUPPLIER table. How is Oracle able to apply three join filters when the join order would imply that the LINEORDER is accessed before the SUPPLER table? 

    This is where Oracle’s 30 plus years of database innovation kick in. By embedding the column store into Oracle Database we can take advantage of all of the optimizations that have been added to the database. In this case, the Optimizer has switched from its typically left deep tree to create a right deep tree using an optimization called ‘swap_join_inputs’. Your instructor can explain ‘swap_join_inputs’ in more depth should you wish to know more. What this means for the IM column store is that we are able to generate multiple Bloom filters before we scan the necessary columns for the fact table, meaning we are able to benefit by eliminating rows during the scan rather than waiting for the join to do it. 

    
## Conclusion

This lab saw our performance comparison expanded to queries with both joins and aggregations. You had an opportunity to see just how efficiently a join, that is automatically converted to a Bloom filter, can be executed on the IM column store. 

You also got to see just how sophisticated the Oracle Optimizer has become over the last 30 plus years,  when it used a combination of complex query transformations to find the optimal execution plan for a star query. 

Oracle Database adds In-Memory database functionality to existing databases, and transparently accelerates analytics by orders of magnitude while simultaneously speeding up mixed-workload OLTP. With Oracle Database In-Memory, users get immediate answers to business questions that previously took hours. 

## Acknowledgements

- **Author** - Andy Rivenes, Sr. Principal Product Manager,  Database In-Memory
- **Last Updated By/Date** - Kay Malcolm, Director, DB Product Management, April 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request. 