
# Oracle Graph 

<br>
**Scenario: Which stores did customer with id 202 order from?**

````
<copy>
session.queryPgql("select s.STORE_NAME from oe_sample_graph match (c:CUSTOMERS)->(o:ORDERS)->(s:STORES) where c.CUSTOMER_ID=202").print().close();
</copy>
````
 
![](./images/IMGG17.PNG)

 
 