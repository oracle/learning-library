# Introduction

## About this Workshop

In this workshop, you will create a simple web shop for 80s,90s and 2000s memorabilia (movies, posters, mugs, wearables, caps, toys electronics) -> easter eggs.

This lab is organized into different topics, each topic consists of multiple steps. Some steps are a bit more advanced, they're marked as 'advanced' and you can skip them. After completing this workshop a user has a very good understanding what JSON features are available in Oracle Database and when to use them. A user will also have learned why Oracle database is better suited for JSON Development than MongoDB, etc.

### Workshop Scenario

This workshop is loosely based on the video below where an "order processing system' is described. In this workshop, we implement an online shop selling used products: popular items like movies, posters, merchandise from the 80s, 90's and 2000s (maybe you find your favorite movie?). We show how the product catalog can be managed with JSON in a very schema-flexible way - allowing to add new product types on the fly. We also show how multiple JSON collections (products, shopping carts, orders, etc) play well together using SQL and JOIN, etc.

This workshop is not a 'cookbook' or 'design guideline' on how to build an online shop - the purpose is to illustrate various JSON features that the Oracle Database offers. That said, you likely find that many examples are applicable to your business needs!

The workshop uses the 'Autonomous JSON Database' cloud service. But everything shown here also works in other Oracle cloud and on-premise databases.

You can complete this entire workshop using your web browser. There is no need to install any extra software. Obviously, when writing a real application, you would call many of the functionalities from a programming language like Java, JavaScript(nodeJS) or Python.

This workshop consists of multiple 'labs' - each describing one aspect or feature. Most labs build on previous steps but there are also optional (advanced) labs which are optional - they can be skipped.

Estimated Lab Time: 75 minutes (without extended labs); 90 minutes with extended labs.

Watch this quick video to know why JSON in Oracle Autonomous Database is awesome.

[](youtube:I8k8K6LGsug)

### About JSON

Before we get started let's take a brief look at JSON (you may skip this step if you're already familiar with it)

#### What is JSON?

JSON is a human-readable, self-describing format to represent data in a hierarchical format. This is best illustrated by an example - a JSON object with information about a person:

```
{
	"id":100,
	"firstName":"John",
	"lastName":"Smith",
	"age":25,
	"address":{
		"street":"21 2nd Street“,"city":"New York",
		"state":"NY","postalCode":"10021",	 
		"isBusiness":false	
	},	
	"phoneNumbers":[		
		{"type":"home","number":"212 555-1234"},	
		{"type":"mobile","number":"646 555-4567"}
	],
	"bankruptcies":null,
	"lastUpdated":"2019-05-13T13:03:35+0000"
}
```

Objects consist of key-value pairs: the key "id" has the value 100. Keys are always strings (identified by double quotes). Scalar values can be numeric (like 100), strings ("John"), Boolean (true, false) or null. The ordering of key-values pairs in an object is not relevant but keys have to be unique per object. Keys can also point to a non-scalar value, namely another object (like address) or array (phoneNumbers). A JSON array is an ordered list of value. You can think of objects and arrays both being containers with values; in an object the key identifies the value whereas in an array it is the position that identifies the value.

No problem, if this does not make much sense yet, you'll get more comfortable with JSON very soon - it is really easy!

One thing to keep in mind is that JSON needs no upfront definition of keys or data types. You can easily modify the shape (schema) of your data.

#### Why is JSON so popular for application development?

Schema-flexibility is a big reason why JSON makes a lot of sense for application development. Especially in the initial phase an application is quite dynamic, new fields are needed, interfaces get changed, etc. Maintaining a relational schema is hard if application changes often need a change in the underlying tables and existing data needs to be modified to fit into the new schema. JSON makes this much easier as new documents may look different than old one (for example have additional fields).

JSON also avoids normalization of a business object into multiple tables. Look at the example above with a customer having multiple phone numbers. How would we store the phone numbers relationally? In separate columns (thus limiting the total amount of phone numbers per person) or in a separate table so that we need to join multiple tables if we want to retrieve on business object? In reality most business objects get normalized into many more than two tables to that an application developer has to deal with the complexity into inserting into many tables when adding a new object and joining the tables back on queries - the SQL to do that can get quite complex. JSON on the other hand allows to map an entire business object into one JSON document. Every insert or query now only affects one value in the database - no joins.

Now you know what JSON is and also why so many people love it. Enough theory for now - time to code!

### Objectives

In this workshop, you will explore: 
*	How to start an Oracle Autonomous (JSON) Database,
*	Fundamentals on the JSON data model and when to use it,
*	How to store, query and process JSON document in collections using the SODA Api,
*	How to use SQL to query, generate and process JSON data,
*	How to convert JSON data to the relational model (e.g., for analytics or reporting),
*	How to generate JSON data from relational sources (e.g., to serve a microservice)
*	How to update JSON data,
*	How to perform transactions over JSON data,
*	How to use stored procedures with JSON business logic

### Prerequisites

* An Oracle Cloud Account

You may now [proceed to the next lab](#next).

## Learn More

* [Overview of JSON](https://docs.oracle.com/en/database/oracle/oracle-database/21/adjsn/json-data.html#GUID-B2D82ED4-B007-4019-8B53-9D0CDA81C4FA)

## Acknowledgements

* **Author** - Beda Hammerschmidt, Architect
* **Contributors** -  Anoosha Pilli, Product Manager, Oracle Database
* **Last Updated By/Date** - Anoosha Pilli, June 2021
