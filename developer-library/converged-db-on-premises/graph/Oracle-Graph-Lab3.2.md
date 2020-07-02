
# Oracle Graph 

<br>
**Scenario: Which customers placed orders from  store with id 1 (the Online store)? 
Show the first 100 results**

````
<copy>
Select * from oe_sample_graph 
Match (c)-[co]->(o)-[os:ORDERED_FROM_STORE]->(s)
Where s.STORE_ID=1 LIMIT 100;
</copy>
````
 
![](./images/IMGG26.PNG)

Let’s add some highlights to indicate Cancelled or Refunded orders.

Click on Settings-> Highlights-> New Highlight 

![](./images/IMGG27.PNG)

We will add two conditions that match cancelled or refunded orders.

Select Apply To Vertices (i.e. the conditions apply to Vertices)

Click on the +  sign to add a condition

Choose label = ORDERS

Again, Click + sign  to add another condition

Choose ORDER_STATUS = CANCELLED

Click the checkbox for Color (vertex color) and choose a red color from the color-picker

![](./images/IMGG28.PNG)

Scroll down and enter Cancelled as the Legend Title and then Click Add Highlight.

![](./images/IMGG29.PNG)

Repeat the above process to add one more highlight for Refunded Orders.

Select Apply To Vertices (i.e. the conditions apply to Vertices)

Click on the +  sign to add a condition

Choose label = ORDERS

Click + to add another condition

Choose ORDER_STATUS = REFUNDED

Click the checkbox for Color (vertex color) and choose a yellow color from the color-picker

Set the Legend Title to Refunded

Then Click Add Highlight.

![](./images/IMGG30.PNG)

There should now be two highlights. Click OK

![](./images/IMGG31.PNG)


The resulting viz should look like

![](./images/IMGG32.PNG)












 
 