# Creating Add to Cart Page

## Introduction

In this lab, you will create a new modal page to add product to the Shopping Cart.

Estimated Time: 20 minutes

### Objectives
- Create a page that allows user to add products to the Shopping Cart.

## **Step 1** - Creating a Modal Page
Create a Modal Page to add products to the cart.

1. Navigate to Create button and click **Page**.
     ![](images/create-modal-page.png " ")  
2. Select **Blank Page** and click **Next**.
3. Enter the following and click **Next**.
    - For Name - enter **Add to Cart**
    - For Page Mode - select **Modal Dialog**
4. For Navigation Preference, select **Do not associate this page with a navigation menu entry** and click **Next**.
5. Click **Finish**.

## **Step 2** - Adding Cards region for Product Details

1. In the new modal page created, navigate to the **Gallery Menu**.
2. Drag a **Cards** region and drop it to the Content Body section.
     ![](images/create-cards.png " ")  
3. In the Property Editor, enter the following:
    - For Title, enter **Product**
    - Under Source section:
        - For Type - select **SQL Query**
        - For SQL Query - enter the following SQL Code:

            ```
            <copy>
            SELECT product_id,
                product_name,
                unit_price,
                product_details,
                product_image,
                image_mime_type,
                image_filename,
                image_charset,
                image_last_updated,
                color_id,
                department_id,
                clothing_id,
                d.description,
                b.brand
            FROM   products p,
                json_table (p.product_details, '$' columns ( description varchar2(4000) path '$.description') ) d,
                json_table (p.product_details, '$' columns ( brand       varchar2(4000) path '$.brand') ) b
            WHERE  product_id = :p18_product_id
            </copy>
            ```

    - For Template Options - click on **Use Template Defaults**.
        ![](images/template-options.png " ") 
        - For **Style** - select **Style C**
        - Click **Ok**

4. Click on Attributes and enter the following:
     ![](images/attributes.png " ") 

    - Under Appearance section:
        - For Layout - select **Float**

    - Under Title section:
        - For Column - select **PRODUCT_NAME**

    - Under Subtitle section:
        - For Column - select **BRAND**

    - Under Body section:
        - For Column - select **DESCRIPTION**

    - Under Secondary Body section:    
        - Set Advanced Formatting to **On**.
        - For HTML Expression - enter the following:
            
            ``` 
            <copy>
            Price: &UNIT_PRICE.
            </copy>
            ```   

    - Under Media section:
        - For Source - select **BLOB Column**
        - For BLOB Column - select **PRODUCT_IMAGE**
        - For Position - select **First**
        - For Appearance - select **Square**
        - For Sizing - select **Fit**

    - Under Card section:
        - For Primary Key Column 1 - select **PRODUCT_ID**    
    
## **Step 3** - Adding Cards region for Customer Reviews

1. Navigate to the **Gallery Menu**.
2. Drag a **Cards** region and drop it to the Content Body section under **Product** region.
     ![](images/create-cards2.png " ")  
3. In the Property Editor, enter the following:
    - For Title - enter **Customer Reviews**
    - Under Source section:
        - For **Type** - select **SQL Query**
        - For **SQL Query** - enter the following SQL Code:

            ```
            <copy>
            SELECT m.rating,
                m.review
            FROM   products p,
                product_reviews m
            WHERE  p.product_name = m.product_name
                AND p.product_id = :p18_product_id 
                order by m.rating desc
            </copy>
            ```
    - Under Appearance section:
        - For Template - select **Standard**

4. Click on Attributes and enter the following:
     ![](images/attributes.png " ")  
    - Under Appearance section:
        - For Layout - select **Horizontal (Row)**

    - Under Title section:
        - Set Advanced Formatting to **On**
        - For HTML Expression - enter the following:
            
            ``` 
            <copy>
            <b>Review:</b> &REVIEW. <br>
            <b>Rating:</b> &RATING.
            </copy>
            ```  

    - Under Messages:
        - For When No Data Found - enter **There are no customer reviews yet.**
     
## **Step 4** - Adding Items and Buttons
In this step, you will create four page items:
- PRODUCT_ID: To get the product ID.
- ACTION: To identify the action (Add / Edit / Delete)made for the customer.
- QUANTITY: To allow customers to select the number of items to add or edit in the shopping cart.
- SHOPPING\_CART\_ITEMS: To get the quantity of items (total) in the shopping cart after an action is made.


1. Navigate to the **Gallery Menu**.
2. Drag a **Static Content** region and drop it to the Dialog Footer.
     ![](images/create-sc.png " ")  

3. In the Property Editor, enter the following:
    - For Title - enter **Buttons Bar**
    - For Template - select **Buttons Container**
4. In the Rendering tree (left pane), navigate to **Buttons Bar** region
5. Right-click on the **Buttons Bar** region and click  **Create Page Item**
     ![](images/create-page-item2.png " ") 
6. Create four items as follows. In the Property Editor, do the following:

    | Name |  Type  | Label  | Template | 
    | ---  |  ---   | ---    | --- | 
    | P18_ACTION | Hidden |
    | P18\_PRODUCT\_ID | Hidden |
    | P18_SHOPPING\_CART\_ITEMS | Hidden |
    | P18_QUANTITY | Select List | Quantity | Required | 

    For **P18_QUANTITY** item, do the following: 
    - Under List of Values section:
        - For Type - select **Static Values**
        - For Static Values - click on **Display1, Display2** and enter the following:

            | Display Value |  Return Value  |
            | --- |  --- |
            | 1 | 1 |
            | 2 | 2 |
            | 3 | 3 |
            | 4 | 4 |
            | 5 | 5 |

    - Click **Ok** 
    - Set Display Extra Values to **Off**
    - Set Display Null Value to **Off**

7. Navigate to **Buttons Bar** region (left side).
8. Right-click on the region and click **Create Button**.
     ![](images/create-button.png " ") 
9. Create three buttons as follows:

    | Name | Label | Button Position |Button Template | Hot | 
    | ---  | ---   | ---             | --- | ---             | 
    | Add          | Add to Cart | Next |Text  |  On  |  On |
    | Edit         | Update Quantity| Create   |Text  |  On | |
    | Delete       | Remove from Cart | Edit   |Text  |  Off | 

     Under Server-side Condition section:
    | Name | Type | Item |
    | ---  | ---   | ---             | 
    | Add  | Item is zero | P18_QUANTITY |
    | Edit         | Item is NOT zero | P18_QUANTITY |
    | Delete       | Item is NOT zero | P18_QUANTITY |

      ![](images/buttons.png " ")    

10. For **Delete** button, apply the following changes:
    - Under Appearance section, click on Template Options:
        - For Type - select **Danger**
        - For Style -select **Display as Link**
        - For Spacing Right, select **Large**

## **Step 5** - Adding computation to calculate the number of items for a product
1. In the Rendering tree (left pane), expand the **Pre-Rendering**.
2. Right-click on **Before Regions** and click **Create Computation**.
     ![](images/computation.png " ")    
3. In the Property Editor, enter the following:
    - Under Identification section:
        - For Item Name - select **P18_QUANTITY**
    - Under Computation:
        - For Type - select **Function Body**
        - For PL/SQL Function Body - enter the following PL/SQL Code:

        ```
        <copy>
        RETURN manage_orders.product_exists(p_product => :P18_PRODUCT_ID);
        </copy>
        ```
     ![](images/computation2.png " ")          

## **Step 6** - Adding process to add products to the Shopping Cart

1. In the Rendering tree (left pane), navigate to **Processing** tab.  
     ![](images/create-process.png " ")    
2. Right click on Processing and click **Create Process**.
     ![](images/create-process2.png " ")   
3. In the Property Editor, enter the following:
    - For Name - enter **Add product**
    - For Type - select **Execute Code**
    - For PL/SQL Code - enter the following code:

        ```
        <copy>
        BEGIN
            IF manage_orders.product_exists(p_product => :P18_PRODUCT_ID) = 0 THEN
                manage_orders.add_product (p_product  => :P18_PRODUCT_ID,
                                        p_quantity => :P18_QUANTITY);
            END IF;
            :P18_ACTION := 'ADD';
        END; 
        </copy>
        ```

    - Under Server-side Condition section:
        - For When Button Pressed - select **Add**      

## **Step 7** - Adding process to edit products in the Shopping Cart

1. In the **Processing** tab.    
2. Right click on Processing and click **Create Process**.
3. In the Property Editor, enter the following:
    - For Name - enter **Edit product**
    - For Type - select **Execute Code**
    - For PL/SQL Code - enter the following PL/SQL code:

        ```
        <copy>
        BEGIN
            IF manage_orders.product_exists(p_product => :P18_PRODUCT_ID) > 0 THEN
                manage_orders.remove_product(p_product => :P18_PRODUCT_ID);
                manage_orders.add_product (p_product  => :P18_PRODUCT_ID,
                                        p_quantity => :P18_QUANTITY);
            END IF;
            :P18_ACTION := 'EDIT';
        END; 
        </copy>
        ```

    - Under Server-side Condition section:
        - For When Button Pressed, select **Edit**

## **Step 8** - Adding process to delete products from the Shopping Cart

1. In the **Processing** tab.    
2. Right click on Processing and click **Create Process**.
     ![](images/create-process-cart.png " ")  
3. In the Property Editor, enter the following:
    - For Name - enter **Delete product**
    - For Type - select **Execute Code**
    - For PL/SQL Code - enter the following code:

        ```
        <copy>
        BEGIN
            IF manage_orders.product_exists(p_product => :P18_PRODUCT_ID) > 0 THEN
                manage_orders.remove_product(p_product => :P18_PRODUCT_ID);
            END IF;
            :P18_ACTION := 'DELETE';
        END; 
        </copy>
        ```

    - Under Server-side Condition section:
        - For When Button Pressed - select **Delete**    

## **Step 9** - Adding process to calculate the shopping cart items

1. In the **Processing** tab.    
2. Right click on Processing and click  **Create Process**.
     ![](images/create-process-cart.png " ")  
3. In the Property Editor, enter the following:
    - For Name - enter **Calculate Shopping Cart Items**
    - For Type - select **Execute Code**
    - For PL/SQL Code - enter the following PL/SQL code:

        ```
        <copy>
        BEGIN
            :P18_SHOPPING_CART_ITEMS := manage_orders.get_quantity;
        END;  
        </copy>
        ```

## **Step 10** - Adding process to close the Modal Page

1. In the **Processing** tab.    
2. Right click on Processing and click **Create Process**.
     ![](images/create-process-cart.png " ")  
3. In the Property Editor, enter the following:
    - Under Identification section:
        - For Name - enter **Close Dialog**
        - For Type - select **Close Dialog**
    - Under Settings section:
        - For Items to Return - enter **P18\_SHOPPING\_CART\_ITEMS,P18\_PRODUCT\_ID,P18\_ACTION,P18\_QUANTITY** 

## **Step 11** - Enhance the Modal Page

1. Navigate to **Rendering** tab (left pane).
     ![](images/rendering-tab.png " ")  

2. Navigate to **Page 18: Add to Cart** 
3. In the Property Editor, do the following changes:
    - Under Identification section:
        For Title, enter **Manage your Cart**
    - Under Dialog section:
        - For Width, enter **600**
        - For Height, enter **600**
     ![](images/enhance-modal.png " ")     

4. Click **Save**. 

## **Summary**

You now know how to customize and enhance the APEX page.

## **Acknowledgments**

- **Author** - Mónica Godoy, Principal Product Manager
- **Contributors** 
- **Last Updated By/Date** - Mónica Godoy, Principal Product Manager, July 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.