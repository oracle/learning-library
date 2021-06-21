# Working with JSON collections using the SODA (Simple Oracle Document Access) API

## Introduction

Oracle is a relational database, meaning it typically stores data in rows and column of tables and JSON can be stored as a column value. For this lab though we first focus on the Document Store API SODA (Simple Oracle Document Access) which allows to store JSON data in a so-called collection. A JSON collection stores JSON documents alongside some metadata like the time of creation or update. Collections offer operations like inserts, deletes, index creation or queries.

In order to create a collection all you have to specify is the collection's name. Unlike a relational table you do not have to provide any schema information. So, lets create a collection for the products we want to sell in the store.

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:

* Create Collection
* Insert First Document
* Finding JSON document in a collection
* JSON and Constraints

### Prerequisites

* Have provisioned an Autonomous JSON Database instance and logged into the JSON

## **STEP 1**: Create Collection

1. To create a collection, click on **Create Collection**.

	![](./images/create-collection.png)

2. Provide a name for your collection in the field **Collection Name - products** and click **Create**.

	![](./images/products.png)

3. A notification pops up that displays `products` collections is created.

	![](./images/popup.png)

4. Click on the refresh button to verify `products` collection is created.

	![](./images/refreshed.png)

## **STEP 2**: Insert First Document

1. Double click on **products** collection to show the **JSON-products** worksheet.

	![](./images/double-clicked.png)

2. Click on New JSON Document button.

	![](./images/new-document.png)

3. A New JSON Document panel displays. Copy the following code, paste it in the worksheet and click **Create**.

	```
	<copy>
	{
		"id": 100,
		"type":"movie",
		"title": "Coming to America",
		"format": "DVD",
		"condition": "acceptable",
		"price": 5,
		"comment": "DVD in excellent condition, cover is blurred",
		"starring": ["Eddie Murphy", "Arsenio Hall", "James Earl Jones", "John Amos"],
		"year": 1988,
		"decade": "80s"
	}
	</copy>
	```
	
	![](./images/paste1.png)

4. A notification pops up that says A New Document is created and the new document is shown in the bottom section of the JSON workshop.

	![](./images/popup2.png)

5. Let's repeat this with the following documents:

	Click on New JSON Document button, copy the following codes one by one, paste it in the worksheet and click **Create**.

    ```
	<copy>
	{
		"id": 101,
		"title": "The Thing",
		"type": "movie",
		"format": "DVD",
		"condition": "like new",
		"price": 9.50,
		"comment": "still sealed",
		"starring": [
			"Kurt Russel",
			"Wilford Brimley",
			"Keith David"
		],
		"year": 1982,
		"decade": "80s"
	}
	</copy>
	```

	```
	<copy>
	{
		"id": 102,
		"title": "Aliens",
		"type": "movie",
		" format ": "VHS",
		"condition": "unknown, cassette looks ok",
		"price": 2.50,
		"starring": [
			"Sigourney Weaver",
			"Michael Bien",
			"Carrie Henn"
		],
		"year": 1986,
		"decade": "80s"
	}
	</copy>
	```

	```
	<copy>
		{
		"id": 103,
		"title": "The Thing",
		"type": "book",
		"condition": "okay",
		"price": 2.50,
		"author":"Alan Dean Forster",
		"year": 1982,
		"decade": "80s"
	}
	</copy>
	```

## **STEP 3:** Finding JSON document in a collection

Documents can be selected based on filter conditions - we call them 'Queries By Example' or short 'QBE'. A QBE is a JSON document itself and it contains the fields and filter conditions that a JSON document in the collection must satisfy in order to be selected.

The simplest form of a QBE just contains a key-value pair. Any selected document in the collection must has the same key with the same value. More complex QBEs can contain multiple filter conditions or operators like 'negation' or 'and', etc.

The following are examples for QBEs. You can copy them into the corresponding window (see screenshot) and execute them. Obviously, in a real application those QBE-expressions would be issued directly from the programming language - the SODA drivers have APIs for QBEs.

Now let's issue some simple queries on the *products* collection we just created.

1. Copy and paste the following queries in the worksheet and click on Run Query button to run a query.

2.  Lookup by one value:

	Here, it displays the document with id - 101.

	```
	<copy>
	{"id":101}
	</copy>
	```
	![](./images/id101.png)
	![](./images/id101-results.png)

3.	Find all DVDs:

	Running the query will displays two documents that are of the the format type - DVD.

	```
	<copy>
	{"format":"DVD"}
	</copy>
	```
	![](./images/dvd-results.png)

4.	Find all non-movies:

	This query displays the documents that are not of type - movies i.e., documents with id - 103.

	```
	<copy>
	{"type":{"$ne":"movie"}}
	</copy>
	```
	![](./images/not-movies.png)

5.	Find products where description contain the word 'new'.

	```
	<copy>
	{"condition":{"$like":"%new%"}}
	</copy>
	```
	![](./images/new.png)

6. Find bargains of all products costing 5 or less:

	This query displays the documents with id - 100, 102 and 103 as those documents have price less than 5.

	```
	<copy>
	{"price":{"$lte":5}}
	</copy>
	```
	![](./images/less5.png)

7. Limit above query to just movies and exclude the book:

	This query displays the documents with id - 100, 102 as those documents have price less than 5 and not the type - book.

	```
	<copy>
	{"$and":[{"price":{"$lte":5}}, {"type":"movie"}]}
	</copy>
	```
	![](./images/less5-movie.png)

## **STEP 4:** JSON and Constraints

Some values need to be unique, so how do we enforce it?

1.	Insert a duplicate document for the id - 100:

	Click on New JSON Document icon, copy and paste the following query in the worksheet and click **Create**.

	The values is successfully inserted as duplicate id's are not prevented and JSON database is schema less.

	```
	<copy>
	{
		"id": 100,
		"fruit": "banana"
	}
	</copy>
	```
	![](./images/step4.1.png)

2. Use QBE:

	Copy and paste the following query in the worksheet and click **Run Query**.

	The result now shows duplicate id values which is not good and so let's delete the last inserted document by clicking on the trash bin button.

	```
	<copy>
	{"id":100}
	</copy>
	```

	![](./images/id100.png)

	It is likely we are looking up products by their id. Let's a create an index that gives fast access to 'id'. Make sure id is unique and numeric.

	Now we use a field 'id' in the JSON document to identify the product. The value could also be a SKU (barcode) or some catalog number. Obviously, every product needs an id and we want this to be a unique numeric value across all duplicates. Also, we want to be able to quickly find a product using the id value. So, let's create a unique index that solves all requirements (unique, numeric, present).

3.	Let's navigate to SQL Developer Web. Click on the navigation menu on the top left and select **SQL** under Development.

	![](./images/sql-dw.png)

4. Copy and paste the below query in the worksheet and click on Run query button to creates a unique index that solves all requirements (unique, numeric, present).

	```
	<copy>
	create unique index product_id_idx on products (JSON_VALUE(json_document, '$.id.number()' ERROR ON ERROR));
	</copy>
	```
	![](./images/index.png)

	JSON_Value is a SQL/JSON function that extracts one value from the JSON data that is specified by a JSON Path Expression - in this case we extract the 'id' and convert the selected value to a SQL number. You'll learn more about SQJ/JSON functions later in this lab.

5.	Once the product\_id\_idx is created, navigate back to JSON workshop. Click on the navigation menu on the top left and select **JSON** under Development.

	![](./images/json-nav.png)

6.	Try to insert some documents that do not have an id or a non-numeric id:

	Click on New JSON Document icon, copy and paste the following query in the worksheet and click **Create**.

	Although the "id" is unique the insert fails throws the error "Unable to add new JSON document" because the value is not a number. The same happens if the id is missing or already in use. Try it!

	```
	<copy>
	{"id":"xxx","title":"Top Gun"}
	</copy>
	```
	![](./images/create-error.png)
	![](./images/error.png)

7.  While we're at it lets add more 'checks' - we call them 'constraints'. Navigate back to the SQL Developer Web. Click on the navigation menu on the top left and select **SQL** under Development.

	![](./images/nav.png)

8. Check constraint to make sure every product also has a title of string data type and price >=0.

	We also want to make sure that every item has at least a title and the price. We want the price to be a non-negative number and title to be a string.

	Copy and paste the below query in the worksheet and click on Run query button to alter products table and add constraints.

	```
	<copy>
	alter table products add constraint required_fields check (JSON_EXISTS(json_document, '$?(@.title.type() == "string" && @.price.number() > 0)'));
	</copy>
	```
	![](./images/sql-query.png)

	JSON_Exists is a SQL/JSON function that checks that a SQL/JSON path expression selects at least one value in the JSON data. The selected value(s) are not getting extracted – only their existence is checked. You'll learn more about SQJ/JSON functions later in this lab.

9. Once the *products* table is altered, navigate back to JSON workshop. Click on the navigation menu on the top left and select **JSON** under Development.

	![](./images/nav2-json.png)

10. Validate that the following documents cannot get inserted as fields are missing or of wrong type.

	Click on New JSON Document icon, copy and paste the following query in the worksheet and click **Create**.

	Throws the error "Unable to add new JSON document" since the following document has missing fields while trying to insert.

	```
	<copy>
	{"id":"200","title":"Top Gun"}
	</copy>
	```
	![](./images/tester.png)
	![](./images/error2.png)

11. The following document now satisfies all the constraints: the "id" is a unique number the title is a string and the price is a positive number.

	```
	<copy>
	{
		"id": 200,
		"title": "Top Gun",
		"category": "VHS",
		"condition": "like new",
		"price": 8,
		"starring": [
			"Tom Cruise",
			"Kelly McGillis",
			"Anthony Edwards",
			"Val Kilmer"
		],
		"year": 1986,
		"decade": "80s"
	}
	</copy>
	```

You may now [proceed to the next lab](#next).

## Learn More

* [Creating B-Tree Indexes for JSON_VALUE](https://docs.oracle.com/en/database/oracle/oracle-database/21/adjsn/indexes-for-json-data.html#GUID-FEE83855-780A-424B-9916-B899BFF2077B)

## Acknowledgements

- **Author** - Beda Hammerschmidt, Architect
- **Contributors** - Anoosha Pilli, Product Manager, Oracle Database
- **Last Updated By/Date** - Anoosha Pilli, June 2021