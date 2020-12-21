# Oracle ORDS 

## Introduction

This lab walks you through --pending

Estimated Lab Time: Pending
### Prerequisites

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup

### About Oracle ORDS

ORDS is middle tier JAVA application that allows you to access your Oracle Database resources via REST. Use standard HTTP calls (GET|POST|PUT|DELETE|HEAD) via URIs that ORDS makes available (/ords/database123/user3/module5/something/)


ORDS will find and run the appropriate database workload (a query, an anonymous block), and return the output as formatted JSON.

![](./images/ords1.png " ") 

**Install ORDS using SQL Developer**

Oracle REST Data Services (ORDS) is bundled with SQL Developer. You can use SQL Developer to install the ORDS version that is bundled in SQL Developer or a standalone version.

As part of this lab , ORDS is pre-installed and ready for use.

About RESTful Services 

Representational State Transfer (REST) is a style of software architecture for distributed hypermedia systems such as the World Wide Web. A service is described as RESTful when it conforms to the tenets of REST.  RESTful Service has the following characteristics: 

•	Data is modeled as a set of resources. Resources are identified by URIs. 

•	A small, uniform set of operations are used to manipulate resources (for example, GET, POST, PUT, DELETE). 

•	A resource can have multiple representations (for example, a blog might have a HTML representation and a RSS representation). 

•	Services are stateless and since it is likely that the client will want to access related resources, these should be identified in the representation returned, typically by providing hypertext links. 


**RESTful Services Terminology** 

Common terms that are used throughout this lab: 

- **RESTful Service** : An HTTP web service that conforms to the tenets of the RESTful Architectural Style, as described in "About RESTful Services" above. 

- **Resource Module** : An organizational unit that is used to group related Resource Templates together. 

- **Resource Template** : An individual RESTful ervice that is able to service requests for some set of URIs (Universal Resource Identifiers). The set of URIs is defined by the URI Template of the Resource Template.

- **Route Patterns**: A simple grammar that defines the particular patterns of URIs that a given Resource Template can handle. For example, the pattern, employees/, will match any URI whose path begins with employees/. 

Example: http://localhost:8888/ords/hr/demo/employees/ 

- **Resource Handler** : Provides the logic required to service a particular HTTP method, for a specific Resource Template. For example the logic of the GET HTTP method for the above Resource Template might be:

select empno, ename, dept from emp where empno = :id

**HTTP Operation**: HTTP (HyperText Transport Protocol) defines a number of standard methods that can be performed on resources:

-	**GET** : Retrieve the resource contents. 
-	**POST** : Store a new resource.
-	**PUT** : Update an existing resource. 
-	**DELETE** : Remove a resource. 

## Step-1: Start ORDS in standalone mode

1. To start ORDS in standalone mode, go to 
   
   ````
   Tools-> Rest Data Services->Run
   ````

2. Select ORDS file as –"/u01/app/oracle/product/19c/db_1/ords/ords.war"
  
3.	Then provide ORDS config file location as – “/u01/app/oracle/product/19c/db_1/ords/config”

4.	Click on **Next**.
  
    ![](./images/ords_lab1_snap1.png " ") 

5.	Checkbox the option “Run in Standalone mode when installation completes” and enter Http Port: **9090**.
  
   ![](./images/ords_lab1_snap2.png " ") 

6.	Click on **Next**. 

7.	On ORDS installation summary page , click on **Finish**.

    ![](./images/ords_lab1_snap3.png " ") 

8.	Below snippet shows the log that ORDS is started.

    ![](./images/ords_lab1_snap4.png " ") 

9. Check if ORDS is connecting through the browser

Open the browser and enter the following URI in the address bar:

````
<copy>
http://&lt;Instance_ip_address&gt:9090/ords/
</copy>
````

If you see **ORACLE REST DATA SERVICES 404 Not Found**, it means that **ORDS** is connected. 

   ![](./images/ords_lab1_snap5.png " ")

    
## Step 2: AutoREST Enable a Schema and its JSON Table

To enable AutoREST on a schema and a table, perform the following steps:
       
1. On the left-side, the Connections navigator is displayed. To make a new connection, click down arrow beside + sign and click New Connection
  
  ![](./images/ordsl1.png " ") 

2.	Enter **JSON** for **Connection Name, appjson** for **Username, Oracle_4U**for **Password** , 
&lt;**Instance _ip_address**&gt; for **Hostname**. Enter **JXLPDB** for **Service name** and **1521** for **Port**. Click **Test** to test the connection.

![](./images/ordsl2.png " ") 

3.	Once the connection test shows Status:success, click **connect** to create the connection.

4.	On the Connections navigator, connect to **appjson** schema by expanding it. Right click **JSON** and select **REST Services> Enable REST Services.**

![](./images/ordsl3.png " ") 

5.	The RESTful Services Wizard will appear. Enter the following and click **Next**.

![](./images/ordsl4.png " ") 


![](./images/ordsl5.png " ") 

6.	The RESTful Summary will appear. Click **Finish**.

![](./images/ordsl6.png " ") 

7.	The SQL is processed and success message appears. Click **OK**.

![](./images/ordsl7.png " ") 

8.	Now, to AutoREST Enable a table, expand Tables (Filtered) under JSON by clicking + beside it. Right click **PURCHASE_ORDER** and select **Enable REST Service.**

![](./images/ordsl8.png " ") 

9.	The RESTful Services Wizard will appear. Enter the following and click **Next**.

![](./images/ordsl9.png " ") 

![](./images/ordsl10.png " ") 

10.	This screen gives a summary of the selected operations. Click the SQL tab.

![](./images/ordsl11.png " ") 

11.	Here is the SQL to REST Enable the table. Click **Finish**.

![](./images/ordsl12.png " ") 

12.	The SQL is processed. Click **OK**.

![](./images/ordsl13.png " ") 

The **appjson** schema and the **Purchase_order** table are now REST enabled.

13.	Retrieve Purchase_order table data.  Open the browser and enter the following URL in the address bar: 

````
http://<instance_IP_address>:9090/ords/JXLPDB/appjson/purchase_order/
````
The URL corresponds to the following:

````
http://<HOST>:<PORT>/ords/<PDBNAME>/<SchemaAlias>/table/ 
````

![](./images/ordsl14.png " ") 

14. Define Resource Module, Resource Template

Perform the following steps to create your first RESTful Service

15. Expand Rest Data Services and right click **Modules** and select **New Module.**

![](./images/ordsl15.png " ") 

16. **The RESTful Services Wizard** appears which will assist you to define a resource module and a resource template. Enter the following values in the wizard and click **Next**.

  ````
  <copy>

Module Name: cnvg 	
URI Prefix: cnvg/ 	
Publish- Make this RESful Service available for use: (check) 
Pagination Size : 25 
Origins Allowed: (leave blank)

   
    </copy>
 ````

![](./images/ordsl16.png " ") 

17. The RESTful Services Wizard - Step 2 of 3 displays the Resource Template attributes. Enter the following values in the wizard.
 
 ````
    <copy>

URI Pattern: cnvg/:id 	
Priority : Low 
ETag : Secure Hash
    
    </copy>
 ````

![](./images/ordsl17.png " ") 

The resource template groups the resource handlers that consist of the HTTP operation method: GET, DELETE, POST and PUT. Only one resource handler per HTTP operation method type is allowed. For example, you cannot have two HTTP GET resource handlers for the same resource template. But you can have one GET and one PUT resource handlers.

18. The RESTful Services Wizard - Step 3 of 3 displays the RESTful Summary. Review the summary and click Finish to create your resource module and resource template.
  
![](./images/ordsl18.png " ") 

URI pattern cnvg/:id in the above template will retrieve the information based on the parameter id. To retrieve full table data, we will create another template with URI patter as cnvg/ in the next step.

19.  Right click on module cnvg and click on add template.

![](./images/ordsl19.png " ") 

20. Provide the URI patter as cnvg/ and click on **Next**

![](./images/ordsl20.png " ") 

21.  Review the summary and click on **Finish**.

![](./images/ordsl21.png " ") 

22. The SQL is processed. Click **OK** .
   
![](./images/ordsl22.png " ") 


23: Retrieve information from JSON table using GET method.

23.  In the RESTful Services navigator, the resource module cnvg contains the resource template cnvg/:id. This template will retrieves the  information from table purchase_order based on the parameter id. Right click on template  **cnvg/:id** then select **Add handler** and select **GET** 

![](./images/ordsl23.png " ") 

24. On the Edit Resource handler, select source type as Collection Query and click on **Apply**.

![](./images/ordsl24.png " ") 

25. The resource handler editor GET cnvg/:id is displayed on the right side. Enter the following query in the SQL worksheet and click **Run** statement icon:

````
    <copy>

Select * from purchase_order j where j.po_document.PONumber=:id
      
     </copy>
````

![](./images/ordsl25.png " ") 

26. The Enter Binds dialog displays. Enter **200** for Value, and click **Apply**. 
   
![](./images/ordsl26.png " ") 

27. The Query Result tab displays the information for PONumber, 200. Save the GET handler

![](./images/ordsl27.png " ") 

28. Let’s test the Restful Service. Open the Postman.
Enter
````
        <copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/200

     </copy>
````
for URL, and select **GET** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.

![](./images/ordsl28.png " ") 

29. Open the browser and test the following URL in the address bar: 
````
    <copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/200
      
      </copy>
````
![](./images/ordsl29.png " ") 

30.	Now will use other template **cnvg/** which is there in the  the resource module cnvg This template will retrieve the  whole table information from purchase_order. Right click on template  cnvg/ then select **Add handler** and select **GET**.

![](./images/ordsl30.png " ") 

31. On the Edit Resource handler, select source type as Collection Query and click on **Apply**.

![](./images/ordsl31.png " ") 

32. The resource handler editor GET cnvg is displayed on the right side. Enter the following query in the SQL worksheet and click **Run** statement icon:

````
    <copy>
Select * from purchase_order j;
    
    </copy>
````
![](./images/ordsl32.png " ")

33. The Query Result tab displays the information for the whole table

![](./images/ordsl33.png " ")

34.Let’s test the Restful Service. Open the Postman.
Enter
````
    <copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/
    
    </copy>
````
for URL, and select **GET** for HTTP Method. Then, click **Send** icon located next to the URL field on the top right side.

![](./images/ordsl34.png " ")

35. Open the browser and test the following URL in the address bar: 
````
    <copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/
   
    </copy>
````

![](./images/ordsl35.png " ")


## Step-4: Insert data into JSON table using POST method

Perform the following steps to create a RESTful Service which inserts the  information into table purchase_order  using the HTTP Method POST.

36.Right click on template  **cnvg/** then select **Add handler** and select **POST**.

![](./images/ordsl36.png " ")

37. In the Mime Types, click the **+** icon to add a row to the Mime Types. Enter **application/json** and click **Apply**.

![](./images/ordsl37.png " ")

 
38. In the RESTful Services navigator, the resource template cnvg/ contains the resource handler POST.
The resource handler editor POST cnvg/ is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab. Save the code in the POST handler.
````
       <copy>
BEGIN
insert into purchase_order (id,DATE_LOADED,po_document) values(SYS_GUID(),to_date('21-JUNE-2020'),:body);
     commit;
END;
   
    </copy>
````

![](./images/ordsl38.png " ")

39.	Test the Restful Service. Provide following values in the Postman.
Enter
````
<copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/  
</copy>
````
for URL, and select POST for HTTP Method. For the **body** select **raw** and **JSON** from dropdown, enter below PO document in the body section Then, click Send icon located next to the URL field on the top right side.

````
<copy>
{"PONumber"             : 10020,
      "Reference"            : "SBELL-20141017",
      "Requestor"            : "Sarah Bell",
      "User"                 : "SBELL",
      "CostCenter"           : "A50",
      "ShippingInstructions" : {"name"    : "Sarah Bell",
                  "Address" : {"street"  : "200 Sporting Green",
                              "city"    : "South San Francisco",
                              "state"   : "CA",
                              "zipCode" : 99236,
                        "country" : "United States of America"},
                        "Phone"   : "983-555-6509"},
      "Special Instructions" : "Courier",
      "LineItems"            : [{"ItemNumber" : 1,
             "Part"       : {"Description" : "Making the Grade",
                             "UnitPrice"   : 20,
                             "UPCCode"     : 27616867759},
             "Quantity"   : 8.0},
                              {"ItemNumber" : 2,
             "Part"       : {"Description" : "Nixon",
                                "UnitPrice"   : 19.95,
                                "UPCCode"     : 717951002396},
                                 "Quantity"   : 5},
                                {"ItemNumber" : 3,
          "Part"       : {"Description" : "Eric Clapton: Best Of 1981-1999",
                               "UnitPrice"   : 19.95,
                               "UPCCode"     : 75993851120},
                                 "Quantity"   : 5.0}
                                ]}
</copy>
````

Once we get the Status:200 OK, POST is successfully done.

![](./images/ordsl39.png " ")

40. Open the browser and test the following URL in the address bar: 

````
<copy>
http://&lt;Instance_ip_address&gt;:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020
</copy>
````

![](./images/ordsl40.png " ")

## Step-5: Update data in JSON table using PUT method.

41. Right click on template  **cnvg/:id** then select **Add handler** and select **PUT**.

![](./images/ordsl41.png " ")

42. In the Mime Types, click the **+** icon to add a row to the Mime Types. Enter **application/json** and click **Apply**.

![](./images/ordsl42.png " ")

43.  In the RESTful Services navigator, the resource template cnvg/:id contains the resource handler PUT.
The resource handler editor POST cnvg/:id is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab. Save the code in the PUT handler.

````
<copy>
BEGIN
update purchase_order j
set    PO_DOCUMENT = json_mergepatch ( 
         PO_DOCUMENT,
         :body
       )
where  j.po_document.PONumber=:id;
     commit;
END;
</copy>
````

![](./images/ordsl43.png " ")

44.	Test the Restful Service. Provide following values in the Postman.

Enter
````

http://<instance_IP_address>:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020

````
for URL, and select PUT for HTTP Method. For the **body** select **raw** and JSON from dropdown, update Requester name as below in the body section Then, click Send icon located next to the URL field on the top right side.

````
{"Requestor":"Dummy_user"}
````

Once we get the Status:200 OK, PUT is successfully done.

![](./images/ordsl44.png " ")

45.	Open the browser and test the following URL in the address bar. Check the requester name , it is changed to dummy_user.

````
<copy>
http://&lt;Instance_ip_address&gt:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020
</copy>
````

![](./images/ordsl45.png " ")

## Step-6: Delete data in JSON table using DELETE method.

46.  In the RESTful Services navigator, right-click **cnvg/:id,** select **Add Handler** and then select **DELETE**.

![](./images/ordsl46.png " ")

47. Click **Apply**.
   
![](./images/ordsl47.png " ")

48. The resource handler editor DELETE cnvg/:id is displayed on the right-side. Enter the following PL/SQL code in the SQL Worksheet tab and save it.

````
<copy>
BEGIN
delete from purchase_order j
where  j.po_document.PONumber=:id;
     commit;
END;
</copy>
````
![](./images/ordsl48.png " ")

49. Test the Restful Service. Provide following values in the Postman.

Enter
````

http://<instance_IP_address>:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020

````
for URL, and select DELETE for HTTP Method. Then, click Send icon located next to the URL field on the top right side.

Once we get the Status:200 OK, DELETE is successfully done.

![](./images/ordsl49.png " ")

50.	Open the browser and test the following URL in the address bar. Check for the PONumber 10020 and its deleted.

````
<copy>
http://&lt;Instance_ip_address&gt:9090/ords/jxlpdb/appjson/cnvg/cnvg/10020
</copy>
````
![](./images/ordsl50.png " ")
   

## ORDS Video
  
  [](youtube:rvxTbTuUm5k)
  

## Want to learn more
- [ORDS](https://www.oracle.com/in/database/technologies/appdev/rest.html)

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

**Issues-**
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.
      

