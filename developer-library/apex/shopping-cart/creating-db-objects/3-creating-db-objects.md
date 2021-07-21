# Creating Database Objects

## Introduction

In this lab, you will learn how to create database objects to use in your APEX application. This package contains the function and procedures to add products to the shopping cart, create the order, clear the cart and more.

Estimated Time: 5 minutes

### Objectives
- Create a package to manage the Shopping Cart.

## **Step 1** - Creating the Package
Create specification and body for the package.

1. Navigate to **SQL Workshop**, click **Object Browser**.
2. Navigate to the + button, in the right side and click **Package**.

    ![](images/create-package.png " ")

3. Select **Specification** and click **Next**.

4. For Package Name, enter **MANAGE_ORDERS** and click **Next**.
    ![](images/create-package2.png " ")
5. For Specification, enter the following:

```
<copy>
CREATE OR replace PACKAGE manage_orders
AS
  --------------------------------------------------------------
  -- create procedure for add a product temporarily
  PROCEDURE add_product (
    p_product  IN NUMBER,
    p_quantity IN NUMBER);
  --------------------------------------------------------------
  -- create procedure for remove a product temporarily
  PROCEDURE remove_product (
    p_product IN NUMBER);
  --------------------------------------------------------------
  -- create funtion to get the number of items in the shopping cart
  FUNCTION Get_quantity
  RETURN NUMBER;
  --------------------------------------------------------------
  -- create procedure for validate if a product exists in the shopping cart
  FUNCTION Product_exists(
    p_product IN NUMBER)
  RETURN NUMBER;
  --------------------------------------------------------------
  -- create procedure for clear the cart
  PROCEDURE clear_cart;
  --------------------------------------------------------------
  -- create function to validate a customer
  FUNCTION Customer_exists(
    p_customer_email IN VARCHAR2)
  RETURN NUMBER;
  --------------------------------------------------------------
  -- create procedure to insert orders
  PROCEDURE create_order (
    p_customer       IN VARCHAR2 DEFAULT NULL,
    p_customer_email IN VARCHAR2,
    p_store          IN NUMBER,
    p_order_id       OUT orders.order_id%TYPE,
    p_customer_id    OUT NUMBER );
END manage_orders; 
</copy>
```

6. Click **Create Package Specification**.
    ![](images/create-specification.png " ")

7. Navigate to body part of the package by clicking on Body tab and enter the following:

```
<copy>
CREATE OR replace PACKAGE BODY manage_orders
AS
  PROCEDURE add_product (p_product  IN NUMBER,
                         p_quantity IN NUMBER)
  IS
  BEGIN
      IF NOT apex_collection.collection_exists (p_collection_name => 'PRODUCTS')
      THEN
        apex_collection.create_collection(p_collection_name => 'PRODUCTS');
      END IF;

      apex_collection.add_member(p_collection_name => 'PRODUCTS',
      p_n001 => p_product,
      p_n002 => p_quantity);
  END add_product;

  PROCEDURE remove_product (p_product IN NUMBER)
  IS
    l_id NUMBER;
  BEGIN
      IF apex_collection.Collection_exists (p_collection_name => 'PRODUCTS')
      THEN
        SELECT seq_id
        INTO   l_id
        FROM   apex_collections a
        WHERE  collection_name = 'PRODUCTS'
               AND a.n001 = p_product;

        apex_collection.delete_member(p_collection_name => 'PRODUCTS', 
                                      p_seq => l_id);
      END IF;
  END remove_product;

  FUNCTION get_quantity
  RETURN NUMBER
  IS
    l_items NUMBER := 0;
  BEGIN
      IF apex_collection.collection_exists (p_collection_name => 'PRODUCTS')
      THEN
        SELECT SUM(n002)
        INTO   l_items
        FROM   apex_collections a
        WHERE  collection_name = 'PRODUCTS';
      END IF;

      RETURN l_items;
  END get_quantity;

  FUNCTION product_exists(p_product IN NUMBER)
  RETURN NUMBER
  IS
    l_quantity NUMBER;
  BEGIN
      IF apex_collection.collection_exists (p_collection_name => 'PRODUCTS')
      THEN
        SELECT a.n002
        INTO   l_quantity
        FROM   apex_collections a
        WHERE  collection_name = 'PRODUCTS'
               AND a.n001 = p_product;

        RETURN l_quantity;
      ELSE
        RETURN 0;
      END IF;
  EXCEPTION
    WHEN OTHERS THEN
               RETURN 0;
  END product_exists;

  PROCEDURE clear_cart
  IS
  BEGIN
      IF apex_collection.collection_exists (p_collection_name => 'PRODUCTS')
      THEN
        apex_collection.truncate_collection(p_collection_name => 'PRODUCTS');
      END IF;
  END clear_cart;

  FUNCTION customer_exists(p_customer_email IN VARCHAR2)
  RETURN NUMBER
  IS
    l_customer customers.customer_id%TYPE;
  BEGIN
      SELECT customer_id
      INTO   l_customer
      FROM   customers
      WHERE  email_address = p_customer_email;

      RETURN l_customer;
  EXCEPTION
    WHEN no_data_found THEN
               RETURN 0;
  END customer_exists;

  PROCEDURE create_order (p_customer       IN VARCHAR2,
                          p_customer_email IN VARCHAR2,
                          p_store          IN NUMBER,
                          p_order_id       OUT orders.order_id%TYPE,
                          p_customer_id    OUT NUMBER)
  IS
  BEGIN
      p_customer_id := customer_exists(p_customer_email);

      IF p_customer_id = 0 THEN
        INSERT INTO customers
                    (full_name,
                     email_address)
        VALUES      (p_customer,
                     p_customer_email)
        returning customer_id INTO p_customer_id;
      END IF;

      INSERT INTO orders
                  (order_datetime,
                   customer_id,
                   store_id,
                   order_status)
      VALUES      (SYSDATE,
                   p_customer_id,
                   p_store,
                   'OPEN')
      returning order_id INTO p_order_id;

      IF apex_collection.collection_exists (p_collection_name => 'PRODUCTS')
      THEN
        INSERT INTO order_items
                    (order_id,
                     line_item_id,
                     product_id,
                     unit_price,
                     quantity)
        SELECT p_order_id,
               seq_id,
               p.product_id,
               p.unit_price,
               n002
        FROM   apex_collections a,
               products p
        WHERE  collection_name = 'PRODUCTS'
               AND p.product_id = a.n001;
      END IF;

      apex_collection.delete_collection(p_collection_name => 'PRODUCTS');
  END create_order;
END manage_orders; 
</copy>
```

8. Click **Save & Compile**.

    ![](images/create-body.png " ")

## **Summary**

You now know how to create a package to be used in your APEX application.

## **Acknowledgments**

- **Author** - Mónica Godoy, Principal Product Manager
- **Contributors** 
- **Last Updated By/Date** - Mónica Godoy, Principal Product Manager, July 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.