
# Oracle BigDataSQL
<br>

**Products ordered from a specific GEO location**


##Steps:

1. Connect to **Database**

````
<copy>
sqlplus apphdfs/apphdfs@orclpdb
</copy>
````

2. Query to get product infomation from specific **GEO location** 
````
<copy>
Select * from purchase_order_info where city=’South San Francisco’;
</copy>
````

![](./images/IMG13.PNG)
