<!-- Updated March 24, 2020 -->


# Query the Sales History Sample Schema

### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) **WORK IN PROGRESS** ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+)

## Introduction

In this lab, you will query the Sales History (SH) sample schema that comes with the database.

## Objectives

-   Learn how to execute the SELECT statement to query tables in the SH schema

-   Learn how to use the WHERE clause to restrict the rows that are returned from the SELECT query

-   Learn how to use the ORDER BY clause to sort the rows that are retrieved from the SELECT statement


## Prerequisites

-   This lab requires completion of the preceding 4 labs in the Contents menu on the right.

## **Step 1:** Querying Tables

In this section, you execute the `SELECT` statement to retrieve data from tables and views. You can select rows and columns that you want to return in the output. In its simplest form, a `SELECT` statement must contain the following:
-   A `SELECT` clause, which specifies columns containing the values to be matched
-   A `FROM` clause, which specifies the table containing the columns listed in the SELECT clause
    -   Syntax:  `SELECT {*|[DISTINCT] column|expression [alias],...} FROM <table>`

**Note:** Remember that you need to prefix the table names with the schema name SH in your queries.

1. You can display all columns of data in a table by entering an asterisk * after the SELECT keyword. Execute the following statement to view all rows and columns in the   `DEPARTMENTS` table:

    `SELECT *
    FROM departments;`

    ![](./images/blahblahblahblah.jpg " ")

2. You can display specific columns of data in a table by specifying the column names in the SELECT statement. Execute the following statement to view the JOB_ID and `JOB_TITLE` columns in the `JOBS` table:

    `SELECT job_id, job_title
    FROM jobs;`

    ![](./images/blahblahblahblah.jpg " ")

## **Step 2:** Restricting Data
In this section, you use the `WHERE` clause to restrict the rows that are returned from the `SELECT` query. A `WHERE` clause contains a condition that must be met. It directly follows the `FROM` clause. If the condition is true, the row that meets the condition is returned.

1. Modify the `SELECT` statement. Execute the following query to restrict the number of rows to `DEPARTMENT_ID 60`:

    `SELECT *`

    `FROM departments`

    `WHERE department_id=60;`

    ![](./images/blahblahblahblah.jpg " ")

## **Step 3:** Sorting Data

In this section, you use the `ORDER BY` clause to sort the rows that are retrieved from the `SELECT` statement. You specify the column based on the rows that must be sorted. You also specify the `ASC` keyword to display rows in ascending order (default), and you specify the `DESC` keyword to display rows in descending order.

1. Execute the following `SELECT` statement to retrieve the `LAST_NAME`, `JOB_ID`, and `HIRE_DATE` columns of employees who belong to  the `SA_REP` job ID. Sort the rows in ascending order based on the `HIRE_DATE` column.

    `SELECT last_name, job_id, hire_date`

    `FROM   employees`

    `WHERE  job_id='SA_REP'`

    `ORDER BY hire_date;`

    ![](./images/blahblahblahblah.jpg " ")  

2. Modify the `SELECT` statement to display rows in descending order. Use the `DESC` keyword.

    `SELECT last_name, job_id, hire_date`

    `FROM   employees`

    `WHERE  job_id='SA_REP'`

    `ORDER BY hire_date DESC;`

    ![](./images/blahblahblahblah.jpg " ")  

## **Step 4:**  Ranking Data

In this section, you use the `RANK ()` function to rank the rows that are retrieved from the `SELECT` statement. You can use the RANK function as an **aggregate**  function (takes multiple rows and returns a single number) or as an **analytical** function (takes criteria and shows a number for each record).

1. Execute the following `SELECT` statement to rank the rows using RANK as an analytical function.

```
<copy>SELECT channel_desc, TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$,
RANK() OVER (ORDER BY SUM(amount_sold)) AS default_rank,
RANK() OVER (ORDER BY SUM(amount_sold) DESC NULLS LAST) AS custom_rank
FROM sh.sales, sh.products, sh.customers, sh.times, sh.channels, sh.countries
WHERE sales.prod_id=products.prod_id AND sales.cust_id=customers.cust_id
AND customers.country_id = countries.country_id AND sales.time_id=times.time_id
AND sales.channel_id=channels.channel_id
AND times.calendar_month_desc IN ('2000-09', '2000-10')
AND country_iso_code='US'
GROUP BY channel_desc;</copy>
```

    ![](./images/blahblahblahblah.jpg " ")  

## Want to Learn More?

Click [here](https://docs.oracle.com/en/database/oracle/oracle-database/19/cncpt/sql.html#GUID-90EA5D9B-76F2-4916-9F7E-CF0D8AA1A09D) for documentation on Data Manipulation Language (DML) statements.

## Acknowledgements

- **Author** - Supriya Ananth, Database User Assistance
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Richard Green, May 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
