
# Oracle Graph 

<br>
**Scenario: what products did customer 202 buy?**

````
<copy>
session.queryPgql("select s.STORE_NAME, o.ORDER_ID, p.PRODUCT_NAME from oe_sample_graph match (c:CUSTOMERS)->(o:ORDERS)->(s:STORES), (o:ORDERS)-[e:ORDER_HAS_PRODUCT]->(p:PRODUCTS) where c.CUSTOMER_ID=202").print().close();
</copy>
````
 
![](./images/IMGG18.PNG)

 
 
