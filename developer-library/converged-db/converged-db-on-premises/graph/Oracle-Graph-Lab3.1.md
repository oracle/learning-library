
# Oracle Graph 

<br>
**Scenario: What products did customer 202 buy from which store(s)?**

````
<copy>
select * from oe_sample_graph 
match (c:CUSTOMERS)-[co]->(o:ORDERS)-[os]->(s:STORES), (o:ORDERS)-[e:ORDER_HAS_PRODUCT]->(p:PRODUCTS) 
where c.CUSTOMER_ID=202;
</copy>
````
 
![](./images/IMGG22.PNG)

**Add some labels to the vertices**

Click on Settings -> Then choose the Visualization tab 

![](./images/IMGG23.PNG)

Select label as the vertex label and then click OK

![](./images/IMGG23.PNG)

**The result should look like as below**

![](./images/IMGG23.PNG)







 
 
