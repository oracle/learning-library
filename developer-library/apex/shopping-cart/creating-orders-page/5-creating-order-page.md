# Creating Order Page

## Introduction

In this lab, you will create a new page that will allow customers to identify the details of their recent order.

Estimated Time: 10 minutes

### Objectives
- Create a page to review the items that customer just bought.

## **Step 1** - Creating a Normal Page - Order Information
Create a Normal Page to review the Order that customer has made.

1. In the **App Builder**, click **Create Page**.
    ![](images/create-page.png " ")
2. Select **Blank Page** and click **Next**.
    ![](images/blank-page.png " ")
3. Enter the following and click **Next**.
    - Name - enter **Order Information**
    - Page Mode - select **Normal**
    - Breadcrumb - select **- don't use breadcrumbs on page -** 
4. For Navigation Preference, select **Do not associate this page with a navigation menu entry** and click **Next**.
5. Click **Finish**.

## **Step 2** - Adding a region 
Add a region to the page to display order details.

1. In the new page created, navigate to the **Gallery Menu**.
2. Drag a **Static Content** region and drop it to the Content Body section.
    ![](images/create-static.png " ")
3. In the Property Editor, enter the following:
    - For Title - enter **Thank you for your order!**
    - For Template - select **Content Block**
    - For Template Options - check **Show Region Icon** and click **Ok**
        ![](images/template-options.png " ")
    - For Icon, enter **fa-heart**

## **Step 3** - Adding items to the page
1. In the Rendering tree (left pane), navigate to the **Thank you for your order!** region.
2. Right click on the region and click on **Create Page Item**.
    ![](images/create-item.png " ")
3. Create one hidden item as follows:

    | Name |  Type  | 
    | --- |  --- | 
    | P16_ORDER | Hidden |

    ![](images/order-item.png " ")    
    
## **Step 4** - Adding Static Content Region
Add a region to contain Order details and items.

1. In the Rendering tree (left pane), navigate to the **Thank you for your order!** region.
2. Right click on the region and click on **Create Sub Region**.
    ![](images/create-sub-region.png " ")
3. In the Property Editor, enter the following:
    - For Title - enter **Order: &P16_ORDER.**
    - For Type - select **Static Content**

## **Step 5** - Adding Order Details region
Add a region to display Order details.

1. In the Rendering tree (left pane), navigate to the **Order: &P16_ORDER.** region.
2. Right click on the region and click on **Create Sub Region**.
    ![](images/create-sub-region2.png " ")
3. In the Property Editor, enter the following:
    - For Title - enter **Order Details**
    - For Type - select **Cards**
    - Under Source section:
        - For Type - select **SQL Query**
        - For SQL Query - enter the following SQL Query:

            ``` 
            <copy>
            SELECT o.order_id,
                o.order_datetime,
                o.customer_id,
                o.order_status,
                o.store_id,
                (SELECT Sum(unit_price * quantity)
                    FROM   order_items i
                    WHERE  i.order_id = o.order_id) total
            FROM   orders o
            WHERE  order_id = :P16_ORDER 
            </copy>
            ```
4. Click on Attributes.
    ![](images/attributes.png " ")
    -  Search for Secondary Body in the filter and do the following:
        - Set Advanced Formatting to **On**
        - For HTML Expression - enter:

            ``` 
            <copy>
            <b> Order Placed:</b> &ORDER_DATETIME. <br> 
            <b> Status: </b>&ORDER_STATUS. <br> 
            <b> Total: </b>&TOTAL.    
            </copy>
            ```

## **Step 6** - Adding Items region
Add a region to display items in the order.

1. In the Rendering tree (left pane), navigate to the **Order: &P16_ORDER.** region.
2. Right click on the region and click on **Create Sub Region**.
    ![](images/create-sub-region3.png " ")
3. In the Property Editor, enter the following:
    - For Title - enter **Items**
    - For Type - select **Cards**
    - Under Source section:
        - For Type - select **SQL Query**
        - For SQL Query - enter the following SQL Query: 

            ``` 
            <copy>
            SELECT  o.line_item_id                Item,
                    p.product_name                Product,
                    o.unit_price,
                    o.quantity,
                    ( o.unit_price * o.quantity ) Subtotal,
                    p.product_image
            FROM   order_items o,
                products p
            WHERE  p.product_id = o.product_id
            AND  order_id = :P16_ORDER 
            </copy>
            ```
4. Click on Attributes and do the following:
    ![](images/attributes2.png " ")

    - Under Title section:
        - For Column - select **PRODUCT**    

    - Under Secondary Body:
        - Set Advanced Formatting to **On**
        - For HTML Expression - enter: 
    
            ``` 
            <copy>
            <b>Quantity: </b> &QUANTITY. <br> 
            <b>Unit Price: </b>&UNIT_PRICE.    
            </copy>
            ```

    - Under Media section:
        - For Source - select **BLOB Column**   
        - For BLOB Column - select **PRODUCT_IMAGE**  
        - For Position - select **Body**  
        - For Appearance - select **Auto**  
        - For Sizing - select **Fit**   

    - Under Card:
        - For Primary Key Column 1 - select **ITEM**    

5. Click **Save**.

## **Summary**

You now know how to add more pages to your existing APEX Application.

## **Acknowledgments**

- **Author** - Mónica Godoy, Principal Product Manager
- **Contributors** 
- **Last Updated By/Date** - Mónica Godoy, Principal Product Manager, July 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.