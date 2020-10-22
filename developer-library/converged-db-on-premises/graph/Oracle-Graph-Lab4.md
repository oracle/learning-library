
# Oracle Graph 

<br>
**Scenario: Who bought how much of product  with id 19**

````
<copy>
query.accept("select c.FULL_NAME, op.QUANTITY from oe_sample_graph match (c)-[co]->(o:ORDERS)-[op]->(p:PRODUCTS) where p.PRODUCT_ID=19 order by op.QUANTITY desc");
</copy>
````
 
![](./images/IMGG14.PNG)

 
 
