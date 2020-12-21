
# Oracle Graph 

<br>
**Scenario: List the first 50 other customers who ordered from the same store(s) as customer 202**

````
<copy>
session.queryPgql("Select c.CUSTOMER_ID, c.FULL_NAME from oe_sample_graph match (b:CUSTOMERS)->(o:ORDERS)->(s:STORES)<-(o2:ORDERS)<-(c:CUSTOMERS) Where b.CUSTOMER_ID=202 and b.CUSTOMER_ID <> c.CUSTOMER_ID LIMIT 50").print().close();
</copy>
````
 
![](./images/IMGG19.PNG)

 
 
