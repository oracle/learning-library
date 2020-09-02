
# Oracle Graph 

<br>

**Scenario: What did people buy from the Online Store. Return first 50 results.**

 ````
 <copy>
 query.accept(
"select c.FULL_NAME, p.PRODUCT_NAME from oe_sample_graph match (o)-[os:ORDERED_FROM_STORE]->(s:STORES),(c)-[co]->(o:ORDERS)-[op]->(p:PRODUCTS) where s.STORE_ID=1 limit 50");
 </copy>
 ````
  
![](./images/IMGG13.PNG " ") 

