
# Oracle Graph 

<br>
**Scenario: Which customers bought product with id 44? Shows 100 results per page**

````
<copy>
select customer,opEdge, product, coEdge, orders from oe_sample_graph match 
(customer:CUSTOMERS)-[coEdge:CUSTOMER_ORDERED]->(orders:ORDERS)-[opEdge:ORDER_HAS_PRODUCT]->(product:PRODUCTS)
where product.PRODUCT_ID=44;
</copy>
````
 
![](./images/IMGG37.PNG)

 
 
