
# Oracle Graph 

<br>
**Scenario: : Which customers bought product with id 44? Shows 100 results per page**

````
<copy>
select customer, coEdge, orders, opEdge, product from oe_sample_graph match 
(orders)-[os:ORDERED_FROM_STORE]->(store:STORES),
(customer:CUSTOMERS)-[coEdge:CUSTOMER_ORDERED]->(orders:ORDERS)-[opEdge:ORDER_HAS_PRODUCT]->(product:PRODUCTS)
where store.STORE_ID=1;
</copy>
````
 
![](./images/IMGG36.PNG)



 