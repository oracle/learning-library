# Unit 2: Using SQL Workshop

This exercise includes two hands-on-labs.

**HOL 2-1: Loading the Tables and Data**: In this lab, you use SQL Workshop to create the underlying database objects and data required for you to build the Demo Projects application.

**HOL 2-2: Creating a Lookup Table**: In this lab, you create a tabled named HARDWARE and load data in to the table. Then, you create a lookup table.


## HOL 2-1: Loading the Tables and Data

It is essential to have at least the tables defined in order for the Create Application wizard to generate pages in your application. In this hands-on-lab, you create the required database objects, and populate the tables with sample data.

1. Use SQL Workshop to upload a script that creates the tables for the Demo Projects application. Perform the following steps:
   
    a) Click **SQL Workshop** and select **SQL Scripts**.

      ![1a](images/hol02/image3.png)

    b) Click **Upload**.

    c) Click **Choose File**, navigate to the working directory where you extracted apex-course-labs.zip.
      Locate the **Project\_Basic\_Tables.sql** file, and double-click the file or click the file and then click **Open**.

    d) Click **Upload**.

      ![1d](images/hol02/image4.png)

    e) Review the uploaded script to see what tables will be created.
      In the SQL Scripts list, click the **Edit** icon (pencil), to the left of the script you just uploaded.

      ![1e](images/hol02/image5.png)

    f) Click the **Run** icon to the right of the script you uploaded.
      ![1f](images/hol02/image6.png)

      Click **Run Now**.

    g) Click the **View Results** icon for the script you just ran.

      ![1g](images/hol02/image7.png)

      ![1h](images/hol02/image8.png)

2.  Currently the tables you created do not have any data. A script has been provided that creates an Oracle database package which can be run at any time to  insert or reset the data in the tables. Use SQL Workshop to upload a script that you can use to populate table data. Perform the following steps:

    a)  Click **SQL Scripts**. Click **Upload**.

    b)  Click **Choose File**, where you extracted apex-course-labs.zip.

    c)  Locate the **Project\_Data.sql** file, and double-click the file or click the file and then click **Open**.

    d)  Click **Upload**.
        ![](images/hol02/image9.png)
       
    e)  Click the **Run** icon to the right of the script you uploaded (top row).
        ![](images/hol02/image10.png)
        Click **Run Now**.

    f)  Click the View Results icon for the script you just ran (top row).
        ![](images/hol02/image11.png)

         

3.  In step 1, you uploaded a package called DEMO\_PROJECTS\_DATA\_PKG. However, this package has not yet been run so the tables you created still do not have any data. The SQL Commands facility, within SQL Workshop, allows a developer to run any valid SQL commands. You will run a SQL command to execute the data package and populate the tables. Use SQL Commands to execute n Oracle Database package. Perform the following steps:



    a)  Click the Up arrow, before SQL Scripts. 
        ![3a](images/hol02/image13.png)

    b)  Click **SQL Commands**.
        ![3b](images/hol02/image14.png)

    c)  Enter the following code:
  
        begin demo\_projects\_data\_pkg.load\_sample\_data;
  
        end;
  
    d)  Click **Run**.
        ![3c](images/hol02/image15.png)
        The Results show: Statement Processed.

4.  Use the Object Browser within SQL Workshop to review all of the database objects, such as the tables and packages you created, available in the underlying Oracle database schema which is associated with the Application Express workspace you logged into. Perform the following steps:


    a)  At the top of the page, select **SQL Workshop** and then select **Object Browser**.
        ![3d](images/hol02/image16.png)

    b)  In Object Browser, select the **DEMO\_PROJ\_TEAM\_MEMBERS** table, and then click on the **Data** tab.
        ![4a](images/hol02/image17.png)

    **Note**: There are a number of other tables listed, outside of those you created using the script file above. The APEX\$ tables are created by Application Express to store internal data specific to your workspace. Tables such as DEMO\_CUSTOMERS were created when the Sample Database Application was installed. The Sample Database Application is installed by default when an Application Express Workspace is created.

    c)  To review the package you created, select Packages and select DEMO\_PROJECTS\_DATA\_PKG. Click **Body** to review the primary PL/SQL rather than the specification.
![4b1](images/hol02/image18.png)     
  **Note**: This package includes complex PL/SQL code to insert images and replicate users entering in records. It is not important that you understand the PL/SQL code in this package, as you will not normally have to populate data in this matter. Generally, you would create the tables with no data and then use the application you build to insert the records.
    ![4b2](images/hol02/image19.png)


----------

## HOL 2-2: Creating a Lookup Table


In this hands-on-lab, you use the Data Workshop utility to create a table and populate the table with data. Once this table is created, you also create a lookup table.

1.  Click **SQL Workshop &gt; Utilities &gt; Data Workshop**.
    ![5a](images/hol02/image20.png)

2.  Click **Data Load &gt;Spreadsheet Data**. </p>
    ![5b](images/hol02/image21.png)


3.  The Load Data Wizard appears.
    Under Load To, select **New Table**, and under Load From, select **Upload file**.
    Click **Next**.
    ![5c](images/hol02/image22.png)


4.  Click **Choose File**, open the working directory where you extracted **apex-course-labs.zip**. Locate the **hardware.csv** file, and double-click the file or click the file and then click **Open**.
    Ensure that First row contains column names is selected, accept the remaining defaults, and click **Next**.
    ![5d](images/hol02/image23.png)


5.  Enter **Hardware** for Table Name, verify the table properties, and click **Next**.
    ![5e](images/hol02/image24.png)


6.  Accept the defaults on the Load Data - Primary Key page, and click **Load Data**.
    ![5f](images/hol02/image25.png)


7.  The new table is now created and is populated with the data.

    Click **Object Browser**.
    ![5g](images/hol02/image26.png)


8.  In the Object Selection pane, click **Hardware**.
    The Detail pane now shows details about Hardware table. For the Hardware table, review the column names and data types.
    Click **Data**.
    Now you see a report of the data contained in the Hardware table.
    ![5h](images/hol02/image27.png)


9.  You want to create a lookup table now. Perform the following steps:



    a)  Click **Table**. Click **Create Lookup Table**.
    ![6a](images/hol02/image28.png)


    b)  Select **DEPARTMENT** for Column. Click **Next**.
    ![6b](images/hol02/image29.png)


    c)  Accept the defaults on this page and click **Next**.
    ![6c](images/hol02/image30.png)


    d)  Click **Create Lookup Table**.
    ![6d](images/hol02/image31.png)


    e)  Review the table definition of **DEPARTMENT\_LOOKUP** table.
    ![6e](images/hol02/image32.png)


    f)  In the Object Selection pane, click **HARDWARE**.
    Review the table details. Notice that the DEPARTMENT column has been extracted from the HARDWARE table and is now available in the DEPARTMENT\_LOOKUP table.   
    ![6f](images/hol02/image33.png)


----------


![Snap3.jpeg](images/hol02/image34.png)
