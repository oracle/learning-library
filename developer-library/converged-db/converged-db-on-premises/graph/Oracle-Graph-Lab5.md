
# Oracle Graph 

<br>
**Scenario: Which customers bought products that customer 202 bought? Return the first 10 results  that had the most products in common with 202**

````
<copy>
var qStr = 
"select c1.FULL_NAME " + 
"FROM oe_sample_graph " + 
"MATCH (c:CUSTOMERS)->(:ORDERS)-[:ORDER_HAS_PRODUCT]->(p:PRODUCTS)," +
"(c1:CUSTOMERS)->(:ORDERS)-[:ORDER_HAS_PRODUCT]->(p:PRODUCTS) " +
"WHERE c.CUSTOMER_ID=202 " + 
"AND c.CUSTOMER_ID <> c1.CUSTOMER_ID " +
"GROUP BY c1 " + 
"ORDER BY count(DISTINCT p) DESC " + 
"LIMIT 10";

query.accept(qStr);
</copy>
````
 
![](./images/IMGG15.PNG)

 
 
