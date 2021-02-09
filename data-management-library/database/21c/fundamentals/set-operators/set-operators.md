# New Set Operators

## Introduction

This lab shows how to use the new set operators, EXCEPT, EXCEPT ALL and INTERSECT ALL.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP  1**: Set up the environment

In this step you will execute the `/home/oracle/labs/M104783GC10/setup_oe_tables.sh` shell script. The shell script creates and loads the `OE.INVENTORIES`, `OE.ORDERS` and `OE.ORDER_ITEMS` tables.

1.  Change to the lab directory and run the shell script to setup the tables

	```

	$ <copy>cd /home/oracle/labs/M104783GC10</copy>

	```

2. Run the script to setup the Order Entry (OE) tables.

	```
	$ <copy>/home/oracle/labs/M104783GC10/setup_oe_tables.sh</copy>

	...

	Commit complete.

	Disconnected from Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production

	Version 21.2.0.0.0

	$

	```

## **STEP  2**: Test the set operator with the `EXCEPT` clause

1. Connect to `PDB21` as `OE`.


	```

	$ <copy>sqlplus oe@PDB21</copy>

	Copyright (c) 1982, 2020, Oracle.  All rights reserved.

	Enter password: <b><i>WElcome123##</i></b>

	Last Successful login time: Mon Mar 16 2020 11:32:00 +00:00

	Connected to:

	SQL>

	```

2. Count in both tables, `INVENTORIES` and `ORDER_ITEMS`, respectively the number of products available in the inventory and the number of products that customers ordered.  Start with the `INVENTORIES` table.


	```

	SQL> <copy>SELECT count(distinct product_id) FROM inventories;</copy>

	COUNT(PRODUCT_ID)

	-----------------

				208
	```

3. Run a count in the `ORDER_ITEMS` table.  Note the difference.

	```

	SQL> <copy>SELECT count(distinct product_id) FROM order_items;</copy>

	COUNT(PRODUCT_ID)

	-----------------

				185

	SQL>

	```

4. How many products are in the inventory that were never ordered? Use the `EXCEPT` operator to retrieve only unique rows returned by the first query but not by the second.


	```

	SQL> <copy>SELECT count(*) FROM
			(SELECT product_id FROM inventories
			EXCEPT
			SELECT product_id FROM order_items);</copy>

	COUNT(*)

	----------

		84

	SQL>

	```

5. How many products were ordered that are now missing in the inventory? The order of the queries is relevant for the result.


	```

	SQL> <copy>SELECT count(*) FROM
			(SELECT product_id FROM order_items
					EXCEPT
			SELECT product_id FROM inventories);
		</copy>

	COUNT(*)

	----------

		61

	SQL>

	```

## **STEP  3**: Test the set operator with the `EXCEPT ALL` clause

1. Would the usage of ALL in the set operator defined in a query in a previous step mean anything? Run the SQL statement using the *EXCEPT ALL* operator.

	```

	SQL> <copy>SELECT product_id FROM inventories
		EXCEPT ALL
		SELECT product_id FROM order_items;</copy>

	PRODUCT_ID
	----------
		1729
		1729
		1729
		1729
		1729
		1729
		1733
		1733
		1733
		1733
		1733
		1733
		1733
		1733
		1733
	...
		3502
		3502
		3502
		3502
		3502
		3503
		3503
		3503
		3503
		3503

	826 rows selected.
	```

2. Run the same query but reverse the tables.  

	```
	SQL> <copy>SELECT count(*) FROM
		(SELECT product_id FROM inventories
		EXCEPT ALL
		SELECT product_id FROM order_items);</copy>

	COUNT(*)
	----------
		826

	SQL>

	```

The result shows all rows in the `INVENTORIES` table that contain products that were never ordered all inventories. This does not mean anything relevant. The use of `ALL` in operators must be appropriate.

## **STEP  4**: Test the set operator with the `INTERSECT` clause

1. How many products that were ordered are still orderable? The statement combining the results from two queries with the `INTERSECT` operator returns only those unique rows returned by both queries.

	````
	SQL> <copy>SELECT count(*) FROM
		(SELECT product_id FROM inventories
		INTERSECT
		SELECT product_id FROM order_items);</copy>

	COUNT(*)
	----------
		124

	````

2. Run the sql statement below reversing the intersect clause.

	````
	SQL>
	<copy>
	SELECT count(*) FROM
		(SELECT product_id FROM order_items
		INTERSECT
		SELECT product_id FROM inventories);
		</copy>

	COUNT(*)
	----------
		124

	SQL>

	````

## **STEP  5**: Test the set operator with the `INTERSECT ALL` clause

1. Would the usage of `ALL` in the operator defined in the query in step 8 mean anything?

	```

	SQL> <copy>SELECT count(*) FROM
		(SELECT product_id FROM order_items
		INTERSECT ALL
		SELECT product_id FROM inventories);</copy>

	COUNT(*)
	----------
		286
	```

2. Exit SQL*Plus

	```
	SQL> <copy>exit</copy>
	```

	The result shows all rows in the `INVENTORIES` table that contain products that were ordered. This does not mean that these products were ordered from these warehouses. The query does not mean anything relevant. The use of `ALL` in operators must be appropriate.

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
