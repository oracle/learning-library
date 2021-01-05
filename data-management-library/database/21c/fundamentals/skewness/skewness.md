# Measuring Asymmetry in Data with the SKEWNESS Functions

## Introduction

This lab shows how to use the `SKEWNESS_POP` and `SKEWNESS_SAMP` aggregate functions to measure asymmetry in data. For a given set of values, the result of population skewness (`SKEWNESS_POP`) and sample skewness (`SKEWNESS_SAMP`) are always deterministic.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you will:
* Setup the environment

### Prerequisites

* An Oracle Free Tier, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a DBCS VM Database
* Lab: 21c Setup


## **STEP 1:** Set up the environment

1. Connect to `PDB1` as `HR` and execute the `/home/oracle/labs/M104784GC10/Houses_Prices.sql` SQL  script to create a table with skewed data.

	```

	$ <copy>cd /home/oracle/labs/M104784GC10</copy>
	$ <copy>sqlplus system@PDB21</copy>

	Copyright (c) 1982, 2020, Oracle.  All rights reserved.

	Enter password: <b><i>WElcome123##</i></b>
	Last Successful login time: Mon Mar 16 2020 08:49:41 +00:00

	Connected to:
	```
	```
	SQL> <copy>@/home/oracle/labs/M104784GC10/Houses_Prices.sql</copy>
	SQL> SET ECHO ON
	SQL>SQL> DROP TABLE houses;
	DROP TABLE houses
			*
	ERROR at line 1:
	ORA-00942: table or view does not exist

	SQL> CREATE TABLE houses (house NUMBER, price_big_city NUMBER, price_small_city NUMBER, price_date DATE);

	Table created.

	SQL> INSERT INTO houses VALUES (1,100000,10000, sysdate);

	1 row created.
	...
	SQL> INSERT INTO houses VALUES (1,900000,40000, sysdate+5);

	1 row created.
	...
	SQL> COMMIT;

	Commit complete.

	SQL>

	```

## **STEP 2:** Examine skewed data

1. Display the table rows. The `HOUSE` column values refer to types of house that you want to look at and categorize the data that you look at statistically and compare with each other. With Skewness, you measure whether there is more data towards the left or the right end of the tail (positive/negative) or how close you are to a normal distribution (skewness = 0).


	```

	SQL> <copy>SET PAGES 100</copy>

	SQL> <copy>SELECT * FROM houses;</copy>

		HOUSE PRICE_BIG_CITY PRICE_SMALL_CITY PRICE_DAT

	---------- -------------- ---------------- ---------

			1         100000            10000 05-FEB-20

			1         200000            15000 06-FEB-20

			1         300000            25000 06-FEB-20

			1         400000            28000 07-FEB-20

			1         500000            30000 08-FEB-20

			1         600000            32000 08-FEB-20

			1         700000            35000 09-FEB-20

			1         800000            38000 09-FEB-20

			1         900000            40000 10-FEB-20

			2        2000000          1000000 11-FEB-20

			2         200000            20000 05-FEB-20

			2         400000            35000 06-FEB-20

			2         600000            55000 06-FEB-20

			2         800000            48000 07-FEB-20

			3         400000            40000 08-FEB-20

			3         500000            42000 08-FEB-20

			3         600000            45000 09-FEB-20

			3         700000            48000 09-FEB-20

			3         800000            49000 10-FEB-20

	19 rows selected.

	SQL>

	```

2. Display the result of population skewness prices (`SKEWNESS_POP`) and sample skewness prices (`SKEWNESS_SAMP`) for the three houses in the table.


	```

	SQL> <copy>SELECT house, count(house) FROM houses GROUP BY house ORDER BY 1;</copy>

		HOUSE COUNT(HOUSE)

	---------- ------------

			1            9

			2            5

			3            5

	SQL> <copy>SELECT house, SKEWNESS_POP(price_big_city), SKEWNESS_POP(price_small_city) FROM houses
				GROUP BY house;</copy>

		HOUSE SKEWNESS_POP(PRICE_BIG_CITY) SKEWNESS_POP(PRICE_SMALL_CITY)

	---------- ---------------------------- ------------------------------

			1                            0                     -.66864012

			2                   1.13841996                     1.49637083

			3                            0                     -.12735442

	SQL> <copy>SELECT house, SKEWNESS_SAMP(price_big_city), SKEWNESS_SAMP(price_small_city) FROM houses
				GROUP BY house;</copy>

		HOUSE SKEWNESS_SAMP(PRICE_BIG_CITY) SKEWNESS_SAMP(PRICE_SMALL_CITY)

	---------- ----------------------------- -------------------------------

			1                             0                      -.81051422

			2                    1.69705627                      2.23065793

			3                             0                      -.18984876

	SQL>

	```

  *Skewness is important in a situation where `PRICE_BIG_CITY` and `PRICE_SMALL_CITY` represent the prices of houses to buy and you want to determine whether the outliers in data are biased towards the left end or right end of the distribution, that is, if there are more values to the left of the mean when compared to the number of values to the right of the mean.*

## **STEP 3:** Examine skewed data after data evolution

1. Insert more rows in the table.


	```

	SQL> <copy>INSERT INTO houses SELECT * FROM houses;</copy>

	19 rows created.

	SQL> <copy>/</copy>

	38 rows created.

	SQL> <copy>/</copy>

	76 rows created.

	SQL> <copy>/</copy>

	152 rows created.

	SQL> <copy>COMMIT;</copy>

	Commit complete.

	SQL> <copy>SELECT house, SKEWNESS_POP(price_big_city), SKEWNESS_POP(price_small_city) FROM houses
		GROUP BY house ORDER BY 1;</copy>

		HOUSE SKEWNESS_POP(PRICE_BIG_CITY) SKEWNESS_POP(PRICE_SMALL_CITY)

	---------- ---------------------------- ------------------------------

			1                            0                     -.66864012

			2                   1.13841996                     1.49637083

			3                            0                     -.12735442

	SQL> <copy>SELECT house, SKEWNESS_SAMP(price_big_city), SKEWNESS_SAMP(price_small_city) FROM houses
		GROUP BY house ORDER BY 1;</copy>

		HOUSE SKEWNESS_SAMP(PRICE_BIG_CITY) SKEWNESS_SAMP(PRICE_SMALL_CITY)

	---------- ----------------------------- -------------------------------

			1                             0                      -.67569912

			2                     1.1602897                      1.52511703

			3                             0                      -.12980098

	SQL>

	```

  *As the number of values in the data set increases, the difference between the computed values of `SKEWNESS_SAMP` and `SKEWNESS_POP` decreases.*

2. Determine the skewness of distinct values in columns `PRICE_BIG_CITY` and `PRICE_SMALL_CITY`.


	```

	SQL> <copy>SELECT house,
						SKEWNESS_POP(DISTINCT price_big_city) pop_big_city,
						SKEWNESS_SAMP(DISTINCT price_big_city) samp_big_city,
						SKEWNESS_POP(DISTINCT price_small_city) pop_small_city,
						SKEWNESS_SAMP(DISTINCT price_small_city) samp_small_city  
					FROM houses
					GROUP BY house;</copy>

		HOUSE POP_BIG_CITY SAMP_BIG_CITY POP_SMALL_CITY SAMP_SMALL_CITY

	---------- ------------ ------------- -------------- ---------------

			1            0             0     -.66864012      -.81051422

			2   1.13841996    1.69705627     1.49637083      2.23065793

			3            0             0     -.12735442      -.18984876

	SQL>

	```

  Is the result much different if the query does not evaluate the distinct values in columns `PRICE_BIG_CITY` and `PRICE_SMALL_CITY`?


	```

	SQL> <copy>SELECT house,
						SKEWNESS_POP(price_big_city) pop_big_city,
						SKEWNESS_SAMP(price_big_city) samp_big_city,
						SKEWNESS_POP(price_small_city) pop_small_city,
						SKEWNESS_SAMP(price_small_city) samp_small_city  
					FROM houses
					GROUP BY house;</copy>

		HOUSE POP_BIG_CITY SAMP_BIG_CITY POP_SMALL_CITY SAMP_SMALL_CITY

	---------- ------------ ------------- -------------- ---------------

			1            0             0     -.66864012      -.67569912

			2   1.13841996     1.1602897     1.49637083      1.52511703

			3            0             0     -.12735442      -.12980098

	SQL>

	```

  The population skewness value is not different because the same exact rows were inserted.

3. Insert more rows in the table with a big data set for `HOUSE` number 1.


	```

	SQL> <copy>INSERT INTO houses (house, price_big_city, price_small_city)
					SELECT house, price_big_city*0.5, price_small_city*0.1
					FROM houses WHERE house=1;</copy>

	144 rows created.

	SQL> <copy>/</copy>

	288 rows created.

	SQL> <copy>/</copy>

	576 rows created.

	SQL> <copy>/</copy>

	1152 rows created.

	SQL> <copy>/</copy>

	2304 rows created.

	SQL> <copy>COMMIT;</copy>

	Commit complete.

	SQL> <copy>SELECT house, count(house) FROM houses GROUP BY house ORDER BY 1;</copy>

			HOUSE COUNT(HOUSE)

	---------- ------------

			1         4608

			2           80

			3           80



	SQL> <copy>SELECT house,
						SKEWNESS_POP(price_big_city) pop_big_city,
						SKEWNESS_SAMP(price_big_city) samp_big_city,
						SKEWNESS_POP(price_small_city) pop_small_city,
						SKEWNESS_SAMP(price_small_city) samp_small_city  
					FROM houses
					GROUP BY house;</copy>

		HOUSE POP_BIG_CITY SAMP_BIG_CITY POP_SMALL_CITY SAMP_SMALL_CITY

	---------- ------------ ------------- -------------- ---------------

			1   2.57050631    2.57134341      5.7418481      5.74371797

			2   1.13841996     1.1602897     1.49637083      1.52511703

			3            0             0     -.12735442      -.12980098

	SQL> <copy>EXIT</copy>

	$

	```

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  David Start, Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  David Start, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/database-19c). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
