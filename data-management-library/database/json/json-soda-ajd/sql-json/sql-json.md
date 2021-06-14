# Using SQL to work with JSON

## Introduction

So far, we focused mostly on the document store API where we dealt with JSON document is a collection. But there is another way to interact with your JSON data: SQL.

SQL is a very mature query language, Oracle added new operators to work with JSON data (we created an open standard called SQL/JSON which was adopted by the ISO SQL standard).

A key characteristic of a JSON collection (like 'products') is that it is backed by a table - a table then gets auto-created when you create a collection so that you do not have to specify columns and data types.

In the following we show you how you can use SQL to work with the JSON data in a collection.

Estimated Lab Time: 10 minutes 

### Objectives

In this lab, you will...

* Use JSON_Serialize to convert binary JSON data to a human-eligible string.
* Use dot notation to extract values from JSON data.

### Prerequisites

* All previous labs have been successfully completed.

## **STEP: 1** SQL Developer Web

1. Click on the navigation menu on the top left and select **SQL** under Development.

    ![](./images/nav-sql.png)

2. On the left side, click on PRODUCTS - this is the table for the 'products' collection.

    ![](./images/products-table.png)

    You see that the table 'PRODUCTS' has 5 columns: an 'ID' which is a unique identified for the document, a 'JSON\_DOCUMENT' which holds the document, 2 metadata columns to keep track of creation and update timestamps and 'VERSION' which is typically a hash value for the document and allows to keep caches in sync (similar to an eTag). None of this is really important at this point as we will only use the JSON\_DOCUMENT column in the following examples.

## **STEP: 2** JSON_Serialize

1. Because the JSON data is stored in a binary representation (for query and update efficiency) we need to convert it to a human-readable string using JSON_Serialize.

    Copy and paste the query in SQL Developer Web worksheet and run it. The following query returns 9 (random) documents from the table/collection.

    ```
    <copy>
    SELECT JSON_Serialize(json_document) from products where rownum < 10;
    </copy>
    ```

2. Simple dot notation - We can extract values from the JSON data using a simple notation (similar to JavaScript) directly from SQL.

    For example running the below query shows all movies costing more that 5.

    ```
    <copy>
    Select JSON_Serialize(json_document) 
    from products p
    where p.json_document.type.string() = 'movie'
    and p.json_document.format.string() = 'DVD'
    and p.json_document.price.number() > 5;
    </copy>
    ```

    Please note that we use trailing functions like 'string()' or 'number()' to map a selected JSON value to a SQL value.

3. You can also extract values this way in the Select part. Copy and paste the query in SQL Developer Web worksheet and run it.

    ```
    <copy>
    Select p.json_document.title.string(), p.json_document.year.number()
    from products p
    where p.json_document.type.string() = 'movie'
    order by 2 DESC;
    </copy>
    ```

4. It is also possible to use aggregation or grouping with values from the JSON data.

    The following calculates the average price of movies per decade.

    ```
    <copy>
    Select p.json_document.decade,
    avg(p.json_document.price.number())
    from products p
    where p.json_document.type.string() = 'movie'
    group by p.json_document.decade;
    </copy>
    ```

## Acknowledgements

- **Author** - Beda Hammerschmidt, Roger Ford
- **Contributors** - Anoosha Pilli, Product Manager, Oracle Database
- **Last Updated By/Date** - Brianna Ambler, June 2021