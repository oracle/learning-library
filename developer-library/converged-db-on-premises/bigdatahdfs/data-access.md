# Oracle BigDataSQL-HDFS

## Introdution 
Want to load the data into Oracle?  Perform some simple ETL  (Kay - need to add some more detail here)


## **Step 1:**  Create Purchase Order Table
1. Connect to **database**
    ````
    <copy>
    sqlplus apphdfs/apphdfs@orclpdb
    </copy>
    ````

2. Create **Table**
    ````
      <copy>
    create table purchase_order_info as
    select s.doc.PONumber,
    s.doc.Reference,
    s.doc.Requestor,
    s.doc.CostCenter,
    s.doc.ShippingInstructions.name as CustomerName,
    s.doc.ShippingInstructions.Address.street as Street,
    s.doc.ShippingInstructions.Phone.type as PhoneType,
    s.doc.ShippingInstructions.Address.city as City,
    s.doc.ShippingInstructions.Address.state as State,
    s.doc.ShippingInstructions.Address.zipCode as Zipcode,
    s.doc.ShippingInstructions.Address.country as Country,
    s.doc.LineItems.Part.Description as ProductDescription,
    s.doc.LineItems.Part.UPCCode as UPCCode,
    s.doc.LineItems.Part.UnitPrice as UnitPrice,
    s.doc."Special Instructions" as SpecialInstructions 
    from PURCHASE_EXT s;
      </copy>
    ````

    ![](./images/IMG10.PNG)

3. Query the count of all rows in **purchase order info** table
   
    ````
        <copy>
        sqlplus apphdfs/apphdfs@orclpdb
        </copy>
    ````
    ````
        <copy>
        Select count(*) from purchase_order_info;
        </copy>
    ````
    ![](./images/IMG11.PNG)    


## **Step 2:**  Products with mode of purchase is COD

1. Connect to **Database**
    ````
    <copy>
    sqlplus apphdfs/apphdfs@orclpdb
    </copy>
    ````
2. List purchase information of orders where mode of payments is **COD**
    ````
    <copy>
    Select * from purchase_order_info where SPECIALINSTRUCTIONS=’COD’;
    </copy>
    ````
    ![](./images/IMG12.PNG)


## **Step 3:**  Products ordered from a specific GEO location


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


## **Step 4:**  Customer purchase history details

1. Connect to **Database**
  ````
  <copy>
  sqlplus apphdfs/apphdfs@orclpdb
  </copy>
  ````

2. Query to get customer's **purchase history**
  ````
  <copy>
  Select * from purchase_order_info where CUSTOMERNAME=’Alexis Bull’;
  </copy>
  ````

  ![](./images/IMG14.PNG)

This lab is now complete.

## Acknowledgements

- **Authors/Contributors** - Brian Hengen, Balasubramanian Ramamoorthy, Arvind Bhope
- **Last Updated By/Date** - Kay Malcolm, Director, Database Product Management, May 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.






