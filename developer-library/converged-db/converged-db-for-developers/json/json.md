# JSON 

## Introduction

This lab demonstrates the ease of handling JSON data type in JAVA EE code. We will be performing insert, update and deletion of JSON data using the UI tool.

*Estimated Lab Time*: 30 Minutes

### Objectives

- Walk through the SQL queries having built-in functions for JSON datatype
- Change business logic to query JSON conditionally
- Showcase creation of REST end-points for JSON data retrived

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Setup Compute Instance
    - Lab: Start Services
    - Lab: eSHOP Application
    - Lab: Data Type Demonstrator Tool

### About JSON

JSON (JavaScript Object Notation) is a syntax for storing and exchanging data. When exchanging data between a browser and a server, the data can only be text.

JSON is text, and we can convert any JavaScript object into JSON, and send JSON to the server. We can also convert any JSON received from the server into JavaScript objects.

This way we can work with the data as JavaScript objects, with no complicated parsing and translations.

**Storing and Managing JSON Documents**

JSON documents can be stored usinga VARCHAR2, CLOB, or BLOB column. An IS JSON SQL constraint ensures that the column contains only valid JSON documents, allowing the database to understand that the column is being used as a container for JSON documents.

Oracle’s JSON capabilities are focused on providing full support for schemaless development and document-based storage. Developers are free to change the structure of their JSON documents as necessary. With the addition of JSON support, Oracle Database delivers the same degree of flexibility as a NoSQL JSON document store.

## **STEP 1**: Retrieve JSON data

1. Open the Firefox browser and navigate to `http://localhost:7101/resources/html/endPointChecker.html` OR You can use the bookmark **DataType-End Point Check Utility** under **ConvergedDB-Workshp in Bookmark Toolbar**.

2. Click on the drop-down to see the list of datatypes shown in workshop.

3. Select **JSON** datatype and click on **Change View** button to change.

    ![](./images/datatype-tool.png " ")

4. Search for product with ID **292** and Click on **Go** button.

5. In the text area you will find the JSON data related to product with ID 292 displayed.

    ![](./images/json-search-product-292.png " ")

6. To verify the product on eShop application, Open the firefox browser in the VNC session (Or a new tab if already open) and enter the URL `http://localhost:7101/product/292` to see the details of the product graphically.
    ![](./images/json-product-292.png " ")

7.	Verify the PID, Details and Title.

## **STEP 2**: Update JSON data

1.	In the search result occurring after searching for product 292, update the price of the product from 12$ to 14$ in the text area.

    ![](./images/json-product-292-update.png " ")

2.	Click on the blue **Update** button below the text area.

3.	You will observe the message “1 records updated”.

4.	To verify the product on eShop application, Open the firefox browser in the VNC session (Or a new tab if already open) and enter the URL `http://localhost:7101/product/292` to see the details of the product graphically.

    ![](./images/json-product-292-updated.png " ")

5.	Again, search for product **292**, to observe the results with updated price value in the JSON object retrieved from database.
    
    ![](./images/json-search-product-292-updated.png " ")

   JSON manipulation function which is supplied out of the box called JSON_MERGEPATCH which is entirely replacing the JSON text with the new text is used within the code to update JSON data.  Similarly, we can re-write the query to update only a particular field and value in JSON by other methods provided to scan through and manipulate JSON key-value pairs in Oracle Converged DB for JSON.

## **STEP 3**: Delete JSON data

1. Search for product with ID **292** and Click on **Go** button.

2. Click on red **Delete** button below the search result display text area.

    ![](./images/json-product-292-delete.png " ")

3. The deletion confirmation message is displayed.

    ![](./images/json-product-292-delete-msg.png " ")

4. Click on **Go** button again to search for product with ID 292.

5. The unavailability message is displayed.

    ![](./images/json-product-292-notavlbl.png " ")

6. To verify the product on eShop application, Open the firefox browser in the VNC session (Or a new tab if already open) and enter the URL `http://localhost:7101/product/292`.

7. You will find the product missing from the JSON database.
   
   ![](./images/json-product-292-missing.png " ")

## **STEP 4**: Insert JSON data

1.	Open the Firefox browser and navigate to `http://localhost:7101/resources/html/endPointChecker.html` OR You can use the bookmark **DataType-End Point Check Utility** under **ConvergedDB-Workshp in Bookmark Toolbar**.

   If the tool is already open, continue...

2.	Click on the drop-down to see the list of datatypes shown in workshop.

3.	Select **JSON** datatype and click on **Change View** button to change.

4.	In the text area, paste the below JSON data about product **292**.

    ````
    <copy>
    {"pid":"292","category":"Earring ","title":"Earring 1","details":"Earrings-aiony-haust-o08tVPuvDcQ-unsplash.jpg","price":"12","picture":"https://objectstorage.us-ashburn-1.oraclecloud.com/n/orasenatdpltsecitom03/b/ConvergedDB4/o/Earrings-aiony-haust-o08tVPuvDcQ-unsplash.jpg"}
    </copy>
    ````
5. Click on green **Insert** button.
    
    ![](./images/json-product-292-insert.png " ")

6. Data insert confirmation message is displayed.
    
    ![](./images/json-product-292-insert-msg.png " ")

7. Search for product id **292** and Click **Go**.

8. The newly inserted product details are displayed in the text area.

    ![](./images/json-search-product-292.png " ")

9. To verify the product on eShop application, Open the firefox browser in the VNC session (Or a new tab if already open) and enter the URL `http://localhost:7101/product/292` to see the details of the product graphically.

    ![](./images/json-product-292.png " ")

10.	Verify the PID, Details and Title.

## **STEP 5**: Update JSON Query and verify
   
 We have searched and handled JSON data based on the product id.  Now what if we want to get the products by ID only if the price of the product is $10?  

 There is no need to write special queries to scan through the JSON data in the database.  Oracle provides a function called JSON_EXISTS to check through the values of any key in the JSON data construct.
 
 In this section, we will replace the query helping search product by ID to enhance the search with products of 10$ value.
    
 To achieve this, lets replace the query beneath with a new query having the condition required.

1. Open the JDeveloper on the VNC desktop or if you already have it open continue...

2. navigate to In JDeveloper open the **JSONDao.java** under **Projects->converge->Application Sources->converge.controllers** by double clicking on the file.

3. In the declaration section at top of the file (around line 16) check the GET\_PRODUCT\_BY\_ID string and the sql select statement.

4. Compare the query with the one against GET_PRODUCT\_BY\_ID\_JSON\_CHECK\_PRICE.

    ![](./images/json-query-by-price.png " ")

  We are first using function JSON\_EXISTS which will do a verification if the data is in the JSON format and if the condition is met. 

  You can also see that we are simply using the key “Price” as if in a relational database not even bothering that it’s a key – value entry in a JSON text inside a database.  That’s the power and ease of handing JSON data in Oracle Converged Database.

5. Navigate down in JSONDao.java to function getProductByID().

6. Uncomment the line below:

    ````
    <copy>
    pstmt = conn.prepareStatement(GET_PRODUCT_BY_ID_JSON_CHECK_PRICE);
    </copy>
    ````
    Comment out the line below:

    ````
    <copy>
    pstmt = conn.prepareStatement(GET_PRODUCT_BY_ID);
    </copy>
    ````
  
    ![](./images/json-comment-code.png " ")

7.	Click on **Save** button.

8.	Right Click on **Converge**.

9.	Click on **Run Maven** and click on **redeploy**.
    
    ![](./images/json-redeploy.png " ")

10.	In the JDeveloper Log message area, you will see the successful redeployment.
    
    ![](./images/json-redeploy-log.png " ")

11.	Navigate back to browser to the **End Point Checker** tool at `http://localhost:7101/resources/html/endPointChecker.html`.

12.	Refresh couple of times to ensure avoiding pages from cache.

13.	Enter **292** as product ID and Click **Go** You will NOT see the product details as JSON in the text area., as we have set the Price condition to $10., and the product we are trying to get data is worth $12.
   
    ![](./images/json-product-292-notavlbl.png" ")

14.	Enter product with ID **11** and click **Go**.

15.	You will see the product details retrieved as the price is $10.

    ![](./images/json-search-product-11.png" ")

 OPTIONAL
 You can also try the select statement in GET\_PRODUCT\_BY\_ID\_JSON\_QUERY string in JSONDao.java which has a SQL statement containing built-in JSON operational functions JSON\_QUERY and JSON\_VALUE to handle the same request.

 JSON\_QUERY finds one or more specified JSON values in JSON data and returns the values in a character string. expr. Use this clause to specify the JSON data to be evaluated. For expr , specify an expression that evaluates to a text literal.

 JSON\_VALUE selects a scalar value from JSON data and returns it as a SQL value. You can also use json\_value to create function-based B-tree indexes for use with JSON data — see Indexes for JSON Data. Function json_value has two required arguments and accepts optional returning and error clauses.
 Repeat the steps done above restrict product search to items with Price $10 by changing the query statement and re-deploying the app.

## Summary
In summary, you have performed Create, Update, Retrieve and Delete functions on JSON data-type stored for eShop application in the converged database. You also got familiar with out of box functions provided by Oracle database to handle JSON data-type, modified SQL queries in java code to access JSON as data over REST.

You may now *proceed to the next lab*.

## Want to learn more
- [JSON](https://docs.oracle.com/en/database/oracle/oracle-database/19/adjsn/index.html)
- [REST-JSON using JDeveloper](https://docs.oracle.com/cd/E53569_01/tutorials/tut_jdev_maf_json/tut_jdev_maf_json.html)


## Acknowledgements
- **Authors** - Pradeep Chandramouli, Nishant Kaushik, Balasubramanian Ramamoorthy, Dhananjay Kumar, AppDev & Database Team, Oracle, October 2020
- **Contributors** - Robert Bates, Daniel Glasscock, Baba Shaik, Meghana Banka, Rene Fontcha
- **Last Updated By/Date** - Kanika Sharma, NA Technology, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.