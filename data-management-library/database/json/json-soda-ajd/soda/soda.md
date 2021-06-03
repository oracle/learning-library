# Using SODA for REST

## Introduction

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: n minutes

### Objectives

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

## **STEP 1:** Mass Insert

1. Now do mass insert:

	Click on New JSON Document icon, copy and paste the following query in the worksheet and click **Create**.

	```
	<copy>
	soda insert products {"id":101,"title":"Top Gun","category":"VHS","condition":"like new","price":8,"starring":["Tom Cruise","Kelly McGillis","Anthony Edwards","Val Kilmer"],"year":1986,"decade":"80s"}
	</copy>
	```

## **STEP 2:** Queries using QBE

let's perform more QBEs to analyze the data.

--> More QBEs to analyze data

1. Find all DVD's cheaper than 10$ and order by price

	```
	<copy>
	{"type":"DVD", "price":{"$lte":10}}
	</copy>
	```

2. Find all movies, there is no movie category, look for DVD, Blueray, VHS, LaserDisk, Betamax

	```
	<copy>
	{}
	</copy>
	```

3. Find all movies by Arnold

	```
	<copy>
	Fulltext search
	</copy>
	```

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.
