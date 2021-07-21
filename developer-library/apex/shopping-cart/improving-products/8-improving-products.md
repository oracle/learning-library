# Improve Products Page

## Introduction

In this lab, you will learn how to improve the Products page by adding new facets and customizing the cards.

Estimated Time: 15 minutes

### Objectives
- Add new facets to the page
- Enhace the cards region

## **Step 1** - Adding new facets
In the Runtime environment navigate to Products, this is the page where your customers can explore the products and select what they wish to buy.
As you can see, it's hard to find the products and it would be beneficial to see additional details related to the products.

![](images/products-page.png " ")

1. From the runtime application, navigate to the Products page in Page Designer.

    Given you ran this app from the APEX App Builder, a Developer Toolbar is displayed at the bottom of the screen. 
    *{Note: End users who log directly into the app will not see this toolbar.}*

    In the Developer Toolbar click **Edit Page 1**.

    ![](images/dev-toolbar.png " ")
    
    Alternatively, you can also navigate back to the APEX App Builder tab in your browser manually by selecting the appropriate browser tab or window.   
    Once in the App Builder click **1 - Products**.

    ![](images/alt-app-builder.png " ")
    
    You should now be in Page Designer with **Page 1: Products** loaded.

    You need to add three new facets to the Products page:
    - DEPARTMENT
    - CLOTHING
    - COLOR

2. Within Page Designer, in the Rendering tree (left pane), navigate to Facets under **Search** Faceted Search.
3. Right click on Facets and click **Create Facet**.

    ![](images/create-facet.png " ")

4. In the Property Editor, enter the following:
    - Name - enter **P1\_DEPARTMENT\_ID**
    - Type - select **Checkbox Group**
    - Label - **Department**
    - Under List of Values section:
        - Type - select **Shared Component**
        - List of Values - select **DEPARTMENT_LOOKUP.DEPARTMENT**

    ![](images/department-facet.png " ")
    
5. Create the second facet. Right click on Facets and click **Create Facet**.

    In the Property Editor, enter the following:
    - Name - enter **P1\_CLOTHING\_ID**
    - Type - select **Checkbox Group**
    - Label - **Clothing**
    - Under List of Values section:
        - Type - select **Shared Component**
        - List of Values - select **CLOTHING_LOOKUP.CLOTHING**

    ![](images/clothing-facet.png " ")

6. Create the third facet. Right click on Facets and click **Create Facet**.

    In the Property Editor, enter the following:
    - Name - enter **P1\_COLOR\_ID**
    - Type - select **Checkbox Group**
    - Label - **Color**
    - Under List of Values section:
        - Type - select **Shared Component**
        - List of Values - select **COLOR_LOOKUP.COLOR**

    ![](images/color-facet.png " ")

## **Step 2** - Reorder facets
Unit price is not a common search criteria, so you want to put this facet at the bottom.

1. In the Rendering tree (left pane), under Search, within Facets, click and hold **P1\_UNIT\_PRICE** and drag it up until it is under **P1\_COLOR\_ID** then release the mouse.

    ![](images/reorder-facet.png " ")

## **Step 3** - Enhance the Faceted Search 

1. In the Rendering tree (left pane), navigate to **Search**.
2. In the Property Editor (right pane), click Attributes and do the following:
    -   For Total Row Count Label - enter **Total Products**
    -   For Show Charts - select **No**.

    ![](images/enhance-facet.png " ")    

## **Step 4** - Enhance the Cards Region
    
1.  In the Rendering tree (left pane), navigate to **Search Results** and in the Property Editor (right pane), do the following:
    - For SQL Query - enter the following SQL code:

    ```
    <copy>
    SELECT "PRODUCT_ID",
        "PRODUCT_NAME",
        "UNIT_PRICE",
        "PRODUCT_DETAILS",
        "PRODUCT_IMAGE",
        "IMAGE_MIME_TYPE",
        "IMAGE_FILENAME",
        "IMAGE_CHARSET",
        "IMAGE_LAST_UPDATED",
        "COLOR_ID",
        (
                SELECT l1."COLOR"
                FROM   "COLOR_LOOKUP" l1
                WHERE  l1."COLOR_ID" = m."COLOR_ID") "COLOR_ID_L$1",
        "DEPARTMENT_ID",
        (
                SELECT l2."DEPARTMENT"
                FROM   "DEPARTMENT_LOOKUP" l2
                WHERE  l2."DEPARTMENT_ID" = m."DEPARTMENT_ID") "DEPARTMENT_ID_L$2",
        "CLOTHING_ID",
        (
                SELECT l3."CLOTHING"
                FROM   "CLOTHING_LOOKUP" l3
                WHERE  l3."CLOTHING_ID" = m."CLOTHING_ID") "CLOTHING_ID_L$3",
        b.brand
    FROM   "PRODUCTS" m,
        json_table (m.product_details, '$' columns ( brand varchar2(4000) path '$.brand') ) b
    </copy>
    ```
    - Under Appearance section:
        - Click on Template Options. For Style - select **Style A**
    ![](images/template-options.png " ")  
        - Click **Ok**
        
2. Click Attributes and apply the following changes:
    ![](images/attributes.png " ")
    - Under Apperance section:
        - For Layout - select **Grid**.
        - For Grid Columns - select **Auto**.

    - Under Title section:
        -   For Column - select **PRODUCT_NAME**.      

    - Under Subtitle section:
        - Set Advanced Formatting to **On**.
        - For HTML Expression - enter the following:

            ```
            <copy>
            <small>&BRAND.</small><br />
            <b class="u-success-text u-pullRight" id="message_&PRODUCT_ID.">
            {if QUANTITY/} &QUANTITY. in cart {endif/}
            </b>
            <b>$&UNIT_PRICE.</b>
            </copy>
            ```

    - Under Media section:
        -   For Source - select **BLOB Column**
        -   For BLOB Column - select **PRODUCT_IMAGE**
        -   For Position - select **First**
        -   For Appearance - select **Widescreen**
        -   For Sizing - select **Fit**

    - Under Card section:
        -   For Primary Key Column 1 - select **PRODUCT_ID**.          

        ![](images/cards.png " ")        

## **Step 5** - Create Actions 
You need to provide a way for customers to shop the products, so in this step you will add an action to allow customers to learn more about the product.

1. Navigate to **Search Results** (left pane).
2. On Actions, right-click **Create Action**.

    ![](images/create-action.png " ")

3. In the Property Editor (right pane), enter the following:
    -   For Type - select **Full Card**
    -   For Target - click on **No Link Defined** and do the following:
        - For Page - enter **18**.
        - For Set Items, enter:

            | Name | Value | 
            | --- | --- | 
            | P18\_PRODUCT\_ID | &PRODUCT_ID. |
             
        - For Clear Cache, enter **18**
        - Click **Ok**.

    ![](images/full-card.png " ")

## **Step 6** - Adding Dynamic Actions
In this step, you will create two dynamic actions:
- To show success message when a product is added / edited / removed from the shopping cart.
- To update the badge and icon shown in the navigation bar after the customer has added / edited / removed a product from the shopping cart.

1. Navigate to **Dynamic Actions** tab (left pane).
     ![](images/create-da.png " ")  

2. Right-click on Dialog Closed and click **Create Dynamic Action**.
     ![](images/create-da2.png " ")  
3. In the Property Editor, enter the following: 
    - Under Identification section:
        - For Name - enter **Show Success Message**
    - Under When section:
        - For Event - select **Dialog Closed**
        - For Selection Type - select **Region**
        - For Region - select **Search Results**

4. Navigate to **Refresh** Action.
    - Under Identification section:
        - For Action - select **Execute JavaScript Code**
    - Under Settings section:        
        - For Code - enter the following JavaScript Code:

            ```
            <copy>    
            var productAction   = this.data.P18_ACTION,
                productQuantity = this.data.P18_QUANTITY,
                productCard$  = apex.jQuery("#message_" + this.data.P18_PRODUCT_ID);

            if (productAction === 'ADD') {
                productCard$.text("Added " + productQuantity + " to cart!");
            } else if (productAction === 'EDIT') {
                productCard$.text("Updated quantity to " + productQuantity + "!");
            } else if (productAction === 'DELETE') {
                productCard$.text("Removed from cart!");
            }
            </copy>
            ```

8. Create a second dynamic action. Right-click on Dialog Closed and click **Create Dynamic Action**.  
     ![](images/create-da4.png " ") 
9. In the Property Editor, enter the following:    
    - Under Identification section: 
        - For Name - enter **Update Shopping Cart Header**
    - Under When section:        
        - For Event - select **Dialog Closed**
        - For Selection Type - select **Region**
        - For Region - select **Search Results**     
    - Under Client-side Condition:
        - For Type - select **JavaScript expression**
        - For JavaScript Expression, enter the following:

            ```
            <copy>
            parseInt(this.data.P18_SHOPPING_CART_ITEMS) > 0
            </copy>
            ```

10. Navigate to **Refresh** Action.
    - Under Identification section:
        - For Action - select **Execute JavaScript Code**
    - Under Settings section:        
        - For Code - enter the following JavaScript Code:

            ```
            <copy>
            // Update Badge Text
            apex.jQuery(".js-shopping-cart-item .t-Button-badge").text(this.data.P18_SHOPPING_CART_ITEMS);

            // Update Icon
            apex.jQuery(".js-shopping-cart-item .t-Icon").removeClass('fa-cart-empty').addClass('fa-cart-full');
            </copy>
            ```
11. Create an opposite action. In the Dynamic Actions tab (left pane), navigate to the newly dynamic action.
12. Right-click on **Execute JavaScript Code** and click **Create Opposite Action**.
     ![](images/create-opposite-action.png " ") 

13. Navigate to **Execute JavaScript Code** Action.
    - Under Identification section:
        - For Action - select **Execute JavaScript Code**
    - Under Settings section:        
        - For Code - enter the following JavaScript Code:

            ```
            <copy>
            // Update Badge Text
            apex.jQuery(".js-shopping-cart-item .t-Button-badge").text('');

            // Update Icon
            apex.jQuery(".js-shopping-cart-item .t-Icon").removeClass('fa-cart-full').addClass('fa-cart-empty');
            </copy>
            ```
14. Click **Save an Run Page**.

## **Step 7** - Run Products Page 

When running products page, you will notice that Department, Clothing and Color facets don't have values as the products are not associated with the corresponding characteristic.
   ![](images/products-facets.png " ")

For that, navigate to **Manage Products** Page, upload a picture and select the proper color, department and clothing characteristic for each product.
    ![](images/manage-products.png " ")

[Click here](./files/clothing-images.zip) to download images for your application.

Once you have updated products information, you would be able to check facet values:
    ![](images/products-image.png " ")

## **Summary**

You now know how to enhance faceted search and cards region.

## **Acknowledgments**

- **Author** - Monica Godoy, Principal Product Manager
- **Contributors** - 
- **Last Updated By/Date** - Monica Godoy, Principal Product Manager, July 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
