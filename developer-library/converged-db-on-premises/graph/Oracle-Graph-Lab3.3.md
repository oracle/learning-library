
# Oracle Graph 

<br>
**Scenario:What products did Dale Hughes buy?**

````
<copy>
select customer, coEdge, orders, opEdge, product from oe_sample_graph match 
(customer:CUSTOMERS)-[coEdge:CUSTOMER_ORDERED]->(orders:ORDERS)-[opEdge:ORDER_HAS_PRODUCT]->(product:PRODUCTS)
where customer.FULL_NAME='Dale Hughes';
</copy>
````
 
![](./images/IMGG33.PNG)

Add highlights on edges for Order items that had Quantity > 1 and unit_Price > 25

Click on settings-> Highlights-> New Highlights -> Select Apply To Edge

Add two conditions

Click on the +  sign to add conditions

1.	One for QUANTITY > 1
2.	Another for UNIT_PRICE > 25
3.	Choose a red color for the Edge ,Click on Add Highlight and then OK.

![](./images/IMGG34.PNG)

![](./images/IMGG35.PNG)



 
 
