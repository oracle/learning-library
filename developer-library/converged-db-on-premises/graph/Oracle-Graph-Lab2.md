
# Oracle Graph 

<br>
**Scenario: What did Dale Hughes buy?**

````
<copy>
query.accept(
"select o.ORDER_STATUS, op.QUANTITY, p.UNIT_PRICE, p.PRODUCT_NAME from oe_sample_graph match (c)-[co]->(o:ORDERS)-[op]->(p:PRODUCTS) where c.FULL_NAME='Dale Hughes'");
</copy>
````
 
![](./images/IMGG12.PNG)

 
 
