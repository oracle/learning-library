# Adding Columns to Product table

## Introduction

The **PRODUCTS** table includes some columns such as, image, price and details. But there are other characteristics that customers would appreciate to know about the product itself, like color, type of clothing and department. For that reason, you will add these  columns to the Products table. 
To avoid data redundancy, you will need to create three additional tables to normalize the data, but instead of creating these three tables for yourself, you'll use the **Create Lookup Table** feature.

In this lab, you will learn how to add these three new columns to the **PRODUCTS** table and then create lookup tables for those new columns.

Estimated Time: 10 minutes

## **Step 1** - Adding Columns to the Products Table

1. From the Oracle APEX Home, click **SQL Workshop**.

2. Click **Object Browser**.

3. Navigate to **PRODUCTS** Table.

    ![](images/products.png " ")

4. Click on **Add Column** button.

5. For Color column, enter the following:

    * Add Column - enter **COLOR**
    * Type - select **VARCHAR2**
    * Length - enter **200**.

6. Click **Next**.

    ![](images/color-column.png " ")

7. Click **Finish**.

8. Click on **Add Column** button.

9.  For Department column, enter the following:

    * Add Column - enter **DEPARTMENT**
    * Type - select **VARCHAR2**
    * Length - enter **200**.

10. Click **Next**.

    ![](images/department-column.png " ")

11. Click **Finish**.

12. Click on **Add Column** button.

13. For Clothing column, enter the following:

    * Add Column - enter **CLOTHING**
    * Type - select **VARCHAR2**
    * Length - enter **200**.

14. Click **Next**.

    ![](images/clothing-column.png " ")

15. Click **Finish**.

## **Step 2** - Creating Lookup Tables
You will create lookup tables based on the new three columns, after you will have created a lookup table, you will notice that a new table was created and the column in the PRODUCTS table has been renamed and the data type was changed to NUMBER.

1. Navigate to **PRODUCTS** Table.

2. Click on **Create Lookup Table** button.

    ![](images/lookup-table.png " ")

3. For Column, select **COLOR - varchar2**.

4. Click **Next**.

    ![](images/lt-color.png " ")

5. Leave the table and sequence name by default:

    * New Table Name: **COLOR_LOOKUP**
    * New Sequence: **COLOR\_LOOKUP\_SEQ**

6. Click **Next**.

    ![](images/lt-color2.png " ")

7. Click **Create Lookup Table**.

    ![](images/lt-color3.png " ")

    *Note: Click on the **Create Lookup Table** button only once. Then you will find the new table listed in the Object Browser.*

8. To create **Department** lookup table, navigate to **Products** table and click on **Create Lookup Table** button.

    ![](images/lookup-table2.png " ")

9. For Column, select **DEPARTMENT - varchar2**.

10. Click **Next**.

    ![](images/lt-department.png " ")

11. Leave the table and sequence name by default:

    * New Table Name: **DEPARTMENT_LOOKUP**
    * New Sequence: **DEPARTMENT\_LOOKUP\_SEQ**

12. Click **Next**.

    ![](images/lt-department2.png " ")
    
13. Click **Create Lookup Table**.

    ![](images/lt-department3.png " ")
    *Note: Click on the **Create Lookup Table** button only once. Then you will find the new table listed in the Object Browser.*
    
14. To create **Clothing** lookup table, navigate to **Products** table and click on **Create Lookup Table** button.

    ![](images/lookup-table3.png " ")

15. For Column, select **CLOTHING - varchar2**.

16. Click **Next**.

    ![](images/lt-clothing.png " ")

17. Leave the table and sequence name by default:

    * New Table Name: **CLOTHING_LOOKUP**
    * New Sequence: **CLOTHING\_LOOKUP\_SEQ**

18. Click **Next**.

    ![](images/lt-clothing2.png " ")

19. Click **Create Lookup Table**.

    ![](images/lt-clothing3.png " ")
    *Note: Click on the **Create Lookup Table** button only once. Then you will find the new table listed in the Object Browser.*

20. The columns COLOR, DEPARTMENT, and CLOTHING in the **PRODUCTS** table were renamed and the data type changed to NUMBER. Also, three new tables were created:
    - COLOR_LOOKUP
    - DEPARTMENT_LOOKUP
    - CLOTHING_LOOKUP

    ![](images/lookup-table4.png " ")

## **Step 3** - Populating Lookup Tables

1. From the Oracle APEX Home, click **SQL Workshop**.

2. Click **SQL Scripts**.

3. Click **Create**.

4. For Script Name, enter **Populating Lookup Tables**.

5. Copy the following script.
    ```
    <copy>
    INSERT INTO clothing_lookup
                (
                            clothing
                )
    SELECT DISTINCT Substr(product_name, Instr(product_name, ' ',1,1)+1, Instr(product_name, ' ',1, 2)+1 - Instr(product_name, ' ',1,1)- 2) clothing
    FROM            products p;

    INSERT INTO department_lookup
                (
                            department
                )
    SELECT DISTINCT r.department
    FROM            products p ,
                    json_table (p.product_details, '$' COLUMNS ( department VARCHAR2(4000) path '$.gender') ) r;

    INSERT INTO color_lookup
                (
                            color
                )
    SELECT DISTINCT r.color
    FROM            products p ,
                    json_table (p.product_details, '$' COLUMNS ( color VARCHAR2(4000) path '$.colour' ) ) r;
    ```

5. Click **Run**.

6. Click **Run Now**.

    ![](images/create-script.png " ")

7. The Script Results page will be displayed listing the statements processed, successful, and with errors.

    ![](images/script-results.png " ")
    
## **Summary**

You now know how to create new columns to your existing tables and how to create lookup tables.

## **Learn More** - *Useful Links*

- APEX on Autonomous:   [https://apex.oracle.com/autonomous](https://apex.oracle.com/autonomous)
- APEX Collateral:   [https://apex.oracle.com](https://apex.oracle.com)
- Tutorials:   [https://apex.oracle.com/en/learn/tutorials](https://apex.oracle.com/en/learn/tutorials)
- Community:  [https://apex.oracle.com/community](https://apex.oracle.com/community)
- External Site + Slack:   [http://apex.world](http://apex.world)

## **Acknowledgments**

- **Author** - Mónica Godoy, Principal Product Manager
- **Contributors** 
- **Last Updated By/Date** - Mónica Godoy, Principal Product Manager, July 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-apex-development-workshops). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
