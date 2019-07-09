# Application Development

## Table of Contents

### [Lab Guide Overview](#lab-guide-overview)

### [Lab Purpose and Rules](#lab-purpose-and-rules)

### [Labs](#labs)

  &nbsp;&nbsp;&nbsp;&nbsp;[Lab 1: Introduction, setup, and demo](#lab-1-introduction-setup-and-demo)

  &nbsp;&nbsp;&nbsp;&nbsp;[Lab 2: Spreadsheet-based Business Objects](#lab-2-spreadsheet-based-business-objects)

  &nbsp;&nbsp;&nbsp;&nbsp;[Lab 3: Web and Mobile Apps](#lab-3-web-and-mobile-apps)

  &nbsp;&nbsp;&nbsp;&nbsp;[Lab 4: Data from service](#lab-4-data-from-service)

  &nbsp;&nbsp;&nbsp;&nbsp;[Extra Lab 5: Add Data Using REST Call](#extra-lab-5-add-data-using-rest-call)

  &nbsp;&nbsp;&nbsp;&nbsp;[Extra Lab 6: Review and edit JavaScript code “under the covers” of VBCS](#extra-lab-6-review-and-edit-javascript-code-under-the-covers-of-vbcs)

### [Appendices](#appendix)

&nbsp;&nbsp;&nbsp;&nbsp;[Appendix A: Create VBCS Instance](#appendix-a-create-vbcs-instance) - In case you don't have one already

&nbsp;&nbsp;&nbsp;&nbsp;[Appendix B: Create Service Connection from Endpoint](#appendix-b-create-service-connection-from-endpoint) - For old-style RESTful APIs

&nbsp;&nbsp;&nbsp;&nbsp;[Appendix C: Build Mama Maggy Data Application](#appendix-c-build-mama-maggy-data-application) - Used in Lab 4 and Extra Lab 5

# Lab Guide Overview

## Lab Purpose and Rules

These labs are designed to provide you with an introduction to using
Visual Builder to create Web and Mobile applications and to prepare you
to demonstrate Visual Builder to customers or to use Visual Builder to
demonstrate other products to Oracle’s customers.

Here are some general guidelines that will help you get the most from
these lab exercises.

  - Read through an entire exercise before executing any of the steps.
    Becoming familiar with the expected flow will enhance your learning
    experience.

  - Ask before you do. If you have any questions, please ask the
    instructor before you march down a path that may lead to wasting
    your time.

  - Follow the steps as shown in the Lab Guide. This is a live
    environment. If you want to do something that is not in the labs,
    ask the lab instructor first. In particular, do not create, delete,
    or alter any cloud objects without asking first.

  - There is no prize for finishing first; there is no penalty for
    finishing last. The goal is to gain a firm understanding of Oracle
    Visual Builder.

  - Ask questions freely. The only dumb questions are those that are not
    asked.

# Labs

In these labs you will use Visual Builder to help Mama Maggy’s (using data supporting the Mama Maggy use case, but, other data could be substituted) by adding product ordering and order tracking solutions.

Today when a manager or franchisee needs to order supplies everything is accomplished with a series of phone calls between the manager/franchisee and Mama Maggy headquarters. The only status checks available are by again calling headquarters. 
1. Manager/franchisee determines need.
2. Manager/franchisee calls HQ for product name and pricing info.
3. Manager/franchisee calls HQ to create an order for one or more products.
4. Manager/franchisee waits for delivery, if they wish to check status they must once again call HQ.

In addition, if store managers/franchisees wish to contact other stores to ask about borrowing supplies or to discuss business, they once again have to go through headquarters to get contact information. 

These processes are often inconvenient and slow, the managers/franchisees would like to improve things.

In our lab we will BEGIN to address the needs of the managers/franchisees by adding:
- Web application allowing managers/franchisees to see what products are available for order and what the prices are.
- Web application to list all product orders including each line in the order's product, quantity, and prices.
- Mobile application allowing busy manager/franchisee to check the status of their orders from anywhere with their phone.
- Web application to list all Mama Maggy stores and their locations and the list of associates in that location along with contact information.

In the interest of time this lab focuses on creating apps to help managers/franchisees to self-serve information they currently rely on headquarters for. Future work will be necessary to automate the creation and update of orders and/or the other information.

The lab is presented in four parts: Lab 1 – Introduction and Setup, Lab
2 - Spreadsheet-based Business Objects, Lab 3 – Web and Mobile Apps, Lab
4 – Data from Service. There are two additional “extra” labs available
for anyone who happens to finish early. No prior experience with Visual
Builder is assumed or necessary.

**Prerequisite**: Before starting these labs, you should have an OCI
login and "ServerDeveloper" or "ServerAdminstrator" access to our VBCS instance **"OSPA-Class-Of-SE"**  (if you are doing this lab NOT with Class Of SE; most formal classes will share an existing VBCS instance and your permissions will already correct. If you do not have a VBCS instance you may create one using the instructions in [Appendix A: Create VBCS Instance](#appendix-a-create-vbcs-instance)). 

**Data Files**:
You will need four data files, three will be used in Lab 3 and one will be used in Lab 4. All four files are available in a single .zip file named [vbcsfiles.zip](https://github.com/oracle/learning-library/blob/master/ospa-library/appdev/application-development-lab/files/vbcsfiles.zip) on GitHub; download the file and expand it to find the following four files (keep them handy they will be used later in this lab):
- Lab 2 (data for VBCS Business Objects)
  - Product.csv
  - ProductOrder.csv
  - ProductOrderLine.csv
- Lab 4 (links used for VBCS Service Connections)
  - AppDev_Endpoints.txt

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NOTE: All four files may also be downloaded directly from GitHub, 
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;however, to download the .csv files directly will require extra steps; 
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;open the .csv in your browser, then,
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;click 'Save As' to store the file as .csv (use the .zip file it's easier)

**NOTE:** Content is driven by external factors such as user data
entries and login date. As a result, what you see displayed in your
environment may not exactly match with the lab screenshots. Screenshots
are provided solely for illustrative purposes to help guide you through
the user interface.

**Disclaimer:**  This lab is designed ONLY for large learning groups and assumes the groups are sharing the Oracle Cloud environment to execute this lab.
 
**Options**:
- Who Should Complete This Lab:  All Participants (preferred)
- Who Should Complete This Lab:  1 Participant for group

# Lab 1: Introduction, setup, and demo

In this lab you will make sure you can access the VBCS instance for your
classroom and supporting lab files.

1.  Log into class tenancy using cloud.oracle.com


    ![](./media/cloud-oracle-com-tenancy.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.1.1 - Tenancy<br/>


  ![](./media/image5.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.1.2   - Login<br/>

2.  Some systems will offer a "Guided Journey"


   ![](./media/cloud-guided-journey.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.2.1 - Guided Journey<br/>

If you see the "Guided Journey" select the "Dashboard" icon

   ![](./media/cloud-guided-journey-dashboardbtn.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.2.2 - Guided Journey<br/>


On some systems you will go straight to a “dashboard” as shown below. (same as coming from Guided Journey)

  ![](./media/vbcs_cloud_dashboard.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.2.3 - Dashboard<br/>

   If you see the "Visual Builder' service box [jump to step 5 Open VBCS Home Page](#open-vbcs-home-page)

  (if your dashboard does not show “Visual Builder” – click “Customize
Dashboard”)

   ![](./media/image7.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.2.4 – Customize Dashboard 1<br/>

   Scroll to “Visual Builder” and click the “Show Button”

   ![](./media/image8.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.2.5 – Show Visual Builder<br/>

   On other systems you may see a different style of Dashboard<br/>

  ![](./media/image9.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.2.6 – Visual Builder Icon<br/>

  ![](./media/image10.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.2.7 – Visual Builder Icon (version 2)<br/>

3.  When the "Visual Builder" service box appears there are two ways to proceed to the service console: click on "Visual Builder" text and go through the "Visual Builder Cloud Service" page or use the service box menu.

    ![](./media/image_c_3.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.3.1 – Visual Builder service box<br/> 

*  Option 1: Use the “Hamburger Icon” ![](./media/image11.png) in the Visual
    Builder service box and choose “Open Service Console” from the
    upper-right corner of the screen.
    
    ![](./media/vb_13b.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.3.2 – Open Service Console Menu<br/> 

*  Option 2: Click on the text "Visual Builder" to display the "Visual Builder Cloud Service" page.

    ![](./media/image14.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.3.3 – Service: Oracle Visual Builder Cloud Service<br/> 

## ** For 2019 Class Of SE - All participants will share the "OSPA-Class-Of-SE" instance **
4.  A VBCS instance has been created and designated for your class to
    share **"OSPA-Class-Of-SE"** please create your VBCS application in the OSPA-Class-Of-SE instance unless your facilitator says differently (your instance name may be different than the one shown; the facilitator will let you know.) 
    (see Appendix A for instructions on creating a VBCS instance)

    ![](./media/vbcs_instance_list.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.4 – VBCS Instances<br/>

#### Open VBCS Home Page  

5.  Find the VBCS instance being used for the lab in the list ("OSPA-Class-Of-SE" below), then using the “Hamburger Icon” ![](./media/image16.png) on the far right;
    choose “Open Oracle Visual Builder Cloud Service Home Page”

    ![](./media/vbcs_instance_0.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.5 – Open VBCS<br/>

6.  You should briefly see the VBCS “splash” page.

    ![](./media/image18.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.6 – VBCS Splash<br/>

7.  When the “Visual Applications” welcome appears; choose the “New Application” button.

  ![](./media/New17.1_a.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.7.1 – Visual Applications<br/>

  ![](./media/New17.2.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.7.2 – Import New Buttons<br/>

8.  When the “Create Application” page appears, provide a name for the
    application; you may call your applications anything you wish.
    
    ### ** Note you must be working within VBCS instance "OSPA-Class-Of-SE" for all labs to work properly **

    If you are sharing your lab environment with a group of people you might find it convenient to follow a naming convention to make it easier for you to find your work and for the facilitators to help you.
    
    Combine your name or initials with three characters representing your location to use as an application name or to add as a prefix to the names of all applications you create. Visual Builder's list of applications may be sorted and filtered easily.

    (The facilitator will share a three-character code for you to use in your location.)
      
    Be sure the “Empty Application” template is selected and click
    “Finish” to continue.

    ![](./media/New1.8.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.8 – Name application<br/>

9.  You are now ready to begin creating your application\!

    ![](./media/vbcs_new_start_building.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 1.9 – Start Building Application<br/>

This concludes Lab 1.

[Go to Lab 2](#lab-2-spreadsheet-based-business-objects) – [Return to Table of Contents](#table-of-contents)
<br/>

# Lab 2: Spreadsheet-based Business Objects

To build the solutions for Mama Maggy's managers/franchisees, data is required, right now that data is stored in several spreadsheets. We need to make that data available inside VBCS so that it may be used in the web and mobile applications created in these labs.

Visual Builder provides two main methods to access data: built-in
business objects, and service connections. VBCS business objects store data in tables like a database. This lab focuses on creating
and using built-in business objects with data suppiled via spreadsheet (.csv/.xlsx)
files. These files get copied into an Oracle Database (under the covers
of VBCS) and are actually accessed using the same type of RESTful APIs
as those used for service connections (more on this in Lab 4).

 NOTE: For this lab you will need three data files (Product.csv, ProductOrder.csv, and ProductOrderLine.csv), if you have not already downloaded them they may be obtained from GitHub as a .zip file named [vbcsfiles.zip](https://github.com/oracle/learning-library/blob/master/ospa-library/appdev/application-development-lab/files/vbcsfiles.zip); download the file and expand it to find the following three files (keep them handy they will be used later in this lab):
- Product.csv&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Products available for managers/franchisees to order
- ProductOrder.csv&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Existing order information: date of order, status, and associate who made the order.
- ProductOrderLine.csv&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Order lines showing the products requested in each of the current orders, 
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;their unit price, and the quantity desired.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A fourth file 'AppDev_Endpoints.txt' will be used in a later lab.
<br/><br/>

1.  If you have logged out of the Oracle Cloud, please log back in and
    return to your VBCS application. On the left-hand side of the Visual Builder interface is a navigator
    listing several options; choose “Business Objects”

      | Mobile Applications | ![](./media/image67.png) |
      | ------------------- | ------------------------ |
      | Web Applications    | ![](./media/image68.png) |
      | Service Connections | ![](./media/image69.png) |
      | Business Objects    | ![](./media/image70.png) |
      | Components          | ![](./media/image71.png) |
      | Processes           | ![](./media/image72.png) |
      | Source View         | ![](./media/image73.png) |

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.1.1 – VBCS Icons  
  
   If you don’t see the navigator, click the “Expand Navigator” icon in the
upper-left corner. 
 ![](./media/image74.png)

  - If you don't have any Business Objects already you'll see the following "You don't have any business objects defined yet" image; click on the "+ Business Object" button.

     ![](./media/vbcs_no_biz_objects.png)

     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.1.2 – No Business Objects<br/>

  - If you already have Business Objects a list will appear; click the plus sign "+" at the top of the Business Objects list.

    ![](./media/vbcs_add_biz_object.png)

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.1.3 – Top of Business Object list<br/>

2.  From the application page, click “+ Business Object” to begin adding
    a business object

3.  The first Business Object you will create will contain information about what products are available for managers/franchisees to order for their stores; we'll use the name "Product" to keep things simple.

    Set the business object name to “Product” as shown here and click
    the Checkmark ![](./media/image24.png) when ready to continue.

    ![](./media/image25.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.3 – New Business Object<br/>

4.  The Business Object page allows you to create Fields and manage your
    Business Object. Note that some fields have been defined
    automatically, this is normal. The “id” field is treated as a key
    and will be used to access items in the business object
    automatically later.

    ![](./media/image26.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.4 – Business Objects Start<br/>

5.  To add a field click the “+ New Field” button

    ![](./media/image27.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.5 – New Field Button<br/>

6.  For each new field the Name and General Data Type are specified

<!-- end list -->

  - Set the label of the first field to “Product Name” note that Visual
    Builder creates the name as “productName”

  - Set the Type to character by making sure the “A”
    ![](./media/image28.png) is selected as shown below (be sure to select the correct "type")

  - Click the “Checkmark” icon ![](./media/vbcs_checkmark.png) when done

    ![](./media/image29b.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.6 – New Field Product Name<br/>

7.  In the box at the lower-right part of the VBCS editor set the field property to “Required”

    ![](./media/image30.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.7 – Product Name required<br/>

8.  Now add three more fields; be sure to mark the all “Required” so
    that you end up with a list like this (note that all four of the fields added should be marked "Required"):

<!-- end list -->

  - A (text)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;productName&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Product Name (already done above)

  - A (text)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;product Description&nbsp;&nbsp; Product Description

  - \# (numeric) unitPrice &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Unit Price

![](./media/image31.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.8 – Product Business Object Fields<br/>

9.  Create another Business Object named “Product Order” (ProductOrder) by clicking the "plus sign" at the top of the Business Objects list again ![](./media/vbcs_add_biz_object.png). 

    The "Product Order" Business Object will contain specifics about orders made by managers/franchisees including the associate that made the order, the order date, the current order status (open, shipped, complete) , and the last date some action (order shipped, order closed, etc.) occurred on the order.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.9.1 – Business Objects +
<br/>

    Add new fields as suggested below so that the final result looks like the screen shot in Figure 2.9.2 (please be sure to pick the correct "type" and make sure that all four of the new fields are marked "Required").

<!-- end list -->

  - \# (numeric)&nbsp;&nbsp;&nbsp;&nbsp;associate &nbsp;&nbsp;Associate

  - ![](./media/image32.png) (datetime) orderDate &nbsp;&nbsp;&nbsp;&nbsp;Order Date

  - A (text)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;orderStatus &nbsp;&nbsp;Order Status

  - ![](./media/image33.png)(datetime)&nbsp;&nbsp;actionDate&nbsp;&nbsp;&nbsp;&nbsp;Action Date

> ![](./media/AppDev2.9.2.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.9.2 – Product Order Business Object Fields<br/>

10. Create another Business Object named “Product Order Line”
    (ProductOrderLine). 

    The "Product Order Line" Business Object will contain specifics about each item included in "Product Orders" made by managers/franchisees including the product ordered, its Unit Price, and the Quantity ordered. 
    
    To make it possible for VBCS to connect the "Product Order Line" with the correct "Product Order" and the "Product" being ordered (so that the product name can display rather than a product id) you will create two "Relationships":
    
    - between the "Product Order Line" and its associated "Product Order" record
    - between the "Product Order Line" and the "Product" being ordered
    
    You will begin with the predefined fields as shown in Figure 2.10.1.

    But this time before adding fields you will first add two relationships to the other business objects that will show up as 'references' later. These relationships connect specific products to product order lines and product order lines to product orders allowing VBCS to "automatically" connect that data when building web and mobile applications later.
    

![](./media/image35.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.1 – Start Product Order Line

Click on the “Overview” tab to see where relationships are defined.

![](./media/image36.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.2 – Overview tab

Click on the plus sign “+” to begin adding relationships.

![](./media/image37.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.3 – Add Relationship

Use the “drop down” on the right side of the screen to select “Product Order”
and check to make sure that “Product Order” is on the “One” side and
“ProductOrderLine” is on the “Many” side of the relationship. Click
“Create Relationship” (default values are ok).

![](./media/vbcs_productorderlinerel.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.4 – Product relationship

   Click on the plus sign “+” to add another relationship.

![](./media/vbcs_onerel.png)


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.5 – Add next relationship

Using the drop-down on the right side of the screen select the “Product” and make sure that “Product Order Line” is on the “Many” side and
that “Product” is on the “One” side of the relationship. Click
“Create Relationship” when done (defaults are ok).

![](./media/vbcs_productorderproductrel.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.6 – Add second relationship

The relationships have been defined, now to enter remaining fields.

![](./media/vbcs_two_rel.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.7 – Complete relationships

Return to the “Fields” tab; the two relationships are now listed as
fields with a “reference” icon ![](./media/image42.png) indicating the
relationship. Select the last row, “Product” as shown in Figure 2.10.8 and click “+ New Field” icon ![](./media/vbcs_plus_new_field_small.png) to continue (VBCS adds new fields below the currently selected field).

![](./media/image43.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.8 – ProductOrderLine with relationships


Next, you will add two fields in the usual manner.

Add “Unit Price” and “Quantity” as numeric fields.

![](./media/image44.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.9 – Add Unit Price

![](./media/image45.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.10 – Add Quantity

The completed field list should look like this:

![](./media/image46.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.10.11 – Product Order Line fields

11. Examine the “Endpoints” created by VBCS for each of the Business Objects you
    defined; these are the RESTful APIs that allow your applications
    (and others) to access the Business Object; Get (read), Post
    (create), Patch (update), Delete (delete) – we will use at least two of these in the next lab.
![](./media/image47.png)

12. It will be useful for testing purposes to have some data in the "Product" Business Object. VBCS provides a way to load single rows/records manually as shown below. (In #15 below you will add many rows/records from an input file).

    Reopen the “Product" Business Object (from the Business Objects list); click on the "Data" tab and then click “+ Add Row” to add a
    row of data

![](./media/image48.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.12 – Product Add Row

13. Provide the following values for the new row:

<!-- end list -->

  - Product Name MOZZARELLA

  - Product Description Mozzarella cheese

  - Unit Price 7

  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(click the "Checkmark" ![](./media/vbcs_checkmark.png) when done)

![](./media/image49.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.13.1 – Add Mozzarella

Add two more rows for DOUGH and PIZZA\_SAUCE:

DOUGH

  - Product Name DOUGH

  - Product Description Dough

  - Unit Price 11

![](./media/image50.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.13.2 – Add Dough

PIZZA\_SAUCE

  - Product Name PIZZA\_SAUCE

  - Product Description Pizza Sauce

  - Unit Price 6

![](./media/image51.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.13.3 – Add Pizza Sauce

14. Review the rows

![](./media/image52.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.14 – Product row list

15. To load more rows from a .csv file; click on the “Product” Business
    Object’s hamburger menu ![](./media/image16.png) and choose “Data
    Management”

![](./media/image53.png)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.15 – Data Manager dropdown

16. Choose “Import from File”

![](./media/image54.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.16 – Choose Import from File

17. Click on “Upload a file or drag it here”

![](./media/image55.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.17.1 – Upload file start

Select the “Product.csv” file provided

![](./media/image56.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.17.2 – Product.csv

Click the “Import” button to upload the selected file

![](./media/image57.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.17.3 – Confirm Import

18. You should see success message like the following; if not, try again
    or ask the instructor for help; click “OK” button when complete

![](./media/image58.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.18 – Import


19. Review the “Product” business object data to see the results of the
    load. 

    ![](./media/image59.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.19 – Product List

20. Create an initial “Product Order” (Product Order -> Data -> + Add Row) as follows, then review your
    results  
    ![](./media/AppDev2.20.png)

> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.20 – Add Product Order row

21. Create an initial “Product Order Line” as follows, use the “Product
    Order” and “Product” pull-downs to choose those values (if the value
    you want does not appear in the list you can start to type the
    value in and it will appear, for instance "M" for "Mozzarella"), type in the other two then review your
    results and click the checkmark ![](./media/vbcs_checkmark.png).

    ![](./media/image61.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.21 – Add Product Order Line

22. Now, using the technique illustrated in 16-18 above add data to the
    Product Order and Product Order Line business objects (note: file
    names same as business object names) using the provided data files

<!-- end list -->

  - Product Order - ProductOrder.csv

    ![](./media/AppDev2.22.1.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.22.1 – Product Order data

  - Product Order Line - ProductOrderLine.csv

    ![](./media/image63.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.22.2 – Product Order Line data

23. Click on the business object “Hamburger” icon
    ![](./media/image16.png)and select “Diagram” to see the
    relationships

    ![](./media/image64.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.24.1 – Diagram dropdown

![](./media/image65.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 2.24.2 – Business Object diagram

Congratulations! The data needed allowing Mama Maggy managers/franchisees to see what products are available to order and to check the status of existing orders is now ready for use. This data will be used in the next three labs.

This concludes Lab 2.

[Go to Lab 3](#lab-3-web-and-mobile-apps) – [Return to Table of Contents](#table-of-contents)

# Lab 3: Web and Mobile Apps

Visual Builder provides an easy-to-use WSYIWG (What You See Is What You
Get) graphical interface for “painting” applications and providing
values declaratively allowing people who are not professional developers
to create applications. Professional developers may use Visual Builder
too; they might also choose to use VBCS’s advanced features and
coding capabilities to make applications more-robust.

In this lab you will create Web applications so that Mama Maggy
managers/franchisees may see what products are available for order and to track the status of orders once they are made.

This lab has three sections:

  - Section 1 – [Create First Web Application](#section-1--create-first-web-application)

  - Section 2 – [Create Master-Detail Application](#section-2--create-master-detail-application)

  - Section 3 – [Create Mobile Application](#section-3--create-mobile-application)

## Section 1 – Create First Web Application

In the last lab you created three business objects and added data to
them; now you will create a web application to work with them

1.  If you're still logged in to the Oracle Cloud and VBCS, skip to #2 below. 

    If you have logged out of the Oracle Cloud, please log back in and return to your VBCS application. 

    You might find it useful to close
    any open windows.

2.  On the left-hand side of the Visual Builder interface is a navigator
    listing several options; choose “Web Applications”
    ![](./media/image66.png).

| Mobile Applications | ![](./media/image67.png) |
| ------------------- | ------------------------ |
| Web Applications    | ![](./media/image68.png) |
| Service Connections | ![](./media/image69.png) |
| Business Objects    | ![](./media/image70.png) |
| Components          | ![](./media/image71.png) |
| Processes           | ![](./media/image72.png) |
| Source View         | ![](./media/image73.png) |

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.2.1 – VBCS Icons  
  
  &nbsp;&nbsp;&nbsp;&nbsp;If you don’t see the navigator, click the “Expand Navigator” icon in the upper-left corner, then click the "Web Applications" button

> ![](./media/image74.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.2.2 – Expand Navigator button

3.  Add a new Web Application;

> First, you'll create a web application with two features; a list of all products that a manager/franchisee might order, and a page showing specifics about a chosen product.

> If you don’t have any Web Applications yet; click the “+ Web
> Application” button
> 
> ![](./media/image75.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.3.1 – Add Web App 1
> 
> Or, if you want to add to your existing Web Applications; click the plus
> sign “+” at the top of the Web Apps list
> 
> ![](./media/image76.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.3.2 – Add Web App 2

4.  The first Web Application you will create will be called
    “productList” - type the name in the “Id” box and click the
    “Create” button to start building the application.

![](./media/image77.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.4 – Create Web Application

5.  The Visual Builder interface has three main tabs for creating web
    applications: ![](./media/image78.png) Designer,  
    ![](./media/image79.png) Components, and ![](./media/image80.png)
    Page Structure.

![](./media/image81.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.5.1 – Web UI

> Visual Builder will also display an object list in the navigator

![](./media/image82.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.5.2 – Web Navigator Objects

6.  Drag a “Heading” component from the Component list (icon is a
    toggle) to the display area

![](./media/image83.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.6.1 – Heading Component

![](./media/image84.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.6.2 – Heading in Design window

> Change the heading to “Product List” using the Property Inspector on the
right-side of the screen. The “slider” may be used to alter the
heading’s size.

![](./media/image85.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.6.3 – Heading Property Inspector

> If you don’t see the Property Inspector; click the “Expand Property
Inspector Icon” in the upper-right corner.

![](./media/image86.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.6.4 – Expand Property Inspector icon

> The screen should look something like this now.

![](./media/image87.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.6.5 – Finished Heading

7.  Add a table to the application by scrolling the Components list
    until you see the Table icon.

> ![](./media/image88.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.7.1 – Table icon
> 
> Drag the Table icon to the design area.
> 
> ![](./media/image89.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.7.2 – Empty table

8.  To add data to the table, select the table and click the “Add Data”
    option from the list on the right.

![](./media/image90.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.8.1 – Add Data

> The “Add Data” wizard will list any Business Objects and/or Service
Connections currently defined.

![](./media/image91.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.8.2 – Add Business Object

> Choose the “Product” business object then click “Next” to go to the next
step in the wizard.

> Select the fields you wish to display (select them in the sequence to be
displayed, you can move them if you make a mistake) and click “Next” to
continue in the wizard to “bind” the business object’s data to the
objects on the screen.

![](./media/image92.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.8.3 – Bind Data

> For this app you will not be changing the query, so just click the
“Finish” button

![](./media/image93.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.8.4 – Finish Add Data

> Visual Builder will then show some data in the design window.

![](./media/image94.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.8.5 – Table Sample Data

9.  Test the application by clicking the “Run” button
    ![](./media/image95.png) in the upper-right part of the screen.

![](./media/image96.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.9.1 – Visual Builder menu bar

> A new browser window will open with your running application.

![](./media/image97.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.9.2 – Finished product list

> Success\! Mama Maggy managers/franchisees can now see a list of the various products available for order (without having to call headquarters).

10. Now, let’s add a page of detail. Return to the Visual Builder
    Designer and select the table containing the property list. Notice
    the icon on the right side near the top of the Property Inspector.

![](./media/image98.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.1 – Table Properties

> The “Quick Start” button makes adding to your application easy.

![](./media/image99.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.2 – Quick Start icon

> The Quick Start options include: Adding data, building a Create Page
(new row), an Edit Page (update row), a Detail page (display single
row), Delete Action (delete row), or Task Actions (add task controls).

![](./media/image100.png)

> Click “Add Detail Page” to begin the wizard.

![](./media/image101.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.3 – Quick Start options

> Once the wizard starts; select the “Product” Business Object and click
“Next” to continue.

![](./media/image102.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.4 – Add Detail 1

> Select the fields to be displayed; you may either select by checking
them in the list or “dragging” them to the fields in the center area.
You may also change title and other features, even the name of the
button that will display on the main page to launch this page. Click
“Finish” when done.

![](./media/image103.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.5 – Add Detail 2

> When complete, the object navigator on the left will show the new page.
Select the new page “main-product-detail” to see what it looks like. Note that the "Product List" screen is called "main-start" and the "Product Detail" screen is called "main-product-detail" in Figure 3.10.6. (These may be renamed if desired but it's not really necessary.)

![](./media/image104.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.6 – Detail in flow

#### Potential Context Error

You may see an “error” message similar to the following. Remember that
Visual Builder is WYSIWYG (what you see is what you get) and attempts to
show real data during the design process. This error frequently occurs
because Visual Builder cannot find a “context” to tell it which data to
display. (in this case, the VBCS editor wants to show the Product Detail page with "live" data, but, does not know which record to display) The process below uses the VBCS editor's "Live" capability to set the context.

![](./media/image105.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.7 – 404 Error

Fortunately there is an easy fix for setting the context. First, look for the
“Live/Design/Code” button in the upper-right part of the Visual
Builder editor. Click on “Live” to begin the process.

![](./media/image106.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.8 – Live, Design, Code button 1

Now, return to the Product List display (click "main-start" in the productlist flows - Figure 3.10.6 above) and select a row, this sets the context to the selected row. ("MOZZARELLA" selected below)

![](./media/image107.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.9 – Product List live

Click the "Product Detail" button to return to the Product Detail display and you should now see data rather than the error message.

![](./media/image108.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.10 – Product Detail live

The VBCS "Live" mode is useful in testing to see how changes might behave, it is not the same as running the application. 

Click "Design" to exit "Live" mode.

![](./media/image109.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.11 – Live, Design, Code 2

Now, to really test the application; run the application using the "run" ![](./media/image95.png) button in the upper-right corner. When the “Product List” displays note the
“Product Detail” button is not available (it is "grayed out") since no product has been
chosen. Select one of the products and the “Product Detail” button will
become active. Click on the “Product Detail” button to see the details
for that product.

The following two images show something similar your results.

![](./media/image110.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.12 – Product List

Once you have reviewed the product details, click the provided “Back”
button to return to the list.

![](./media/image111.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.10.13 – Product Detail page

In addition to viewing the data; you may also use the “Quick Start” do add Create, Edit, and Delete pages for products. (not part of this lab).

Congratulations\! You’ve successfully created your first Visual Builder
web application. 

You've also made a day in the life of a Mama Maggy manager/franchisee easier since they can now see what products are available to order without having to play telephone-tag with headquarters.

[Return to top of Section 1 – Create First Web Application](#section-1--create-first-web-application)

[Return to Table of Contents](#table-of-contents)


## Section 2 – Create Master-Detail Application

11. In this section you will create a set of screens to represent
    product orders. As a reminder, here’s what the data model looked
    like.

![](./media/image65.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.11.1 – Data model

The second application will allow Mama Maggy managers/franchisees to track the status of their product orders. This will include a list of all product orders, the ability to see the specifics of a single order including a list of each product in that order, its unit price, and the quantity ordered.

In this lab section you will create a two-screen application similar to
the last one with a twist, the Product Order Detail screen will include
the list of Product Order Lines that match the Product Order. The lab
guide will not be as detailed for activities you have already gone
through.

  - Product Order List

  - Product Order Detail with list of matching Product Order Lines

<!-- end list -->

12. Create a new Web Application to display a list or Product Order
    business object rows. This is very similar to the Product List
    created earlier and you will end up with a screen that looks
    something like this. Include these fields:

<!-- end list -->

  - Id

  - Associate

  - Order Date

![](./media/image112.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.12.1 – Product Order List original

Wow, that date does not look very nice\! A simple way to change the
format is by dragging the “Input Date Time” component from the component
list and dropping it into the date column.

![](./media/image113.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.12.2 – Input Date Time component

![](./media/image114.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.12.3 – Product Order List Changed Date Format

13. Create a Product Order Detail page for the Product Order page’s
    table, select these fields:

<!-- end list -->

  - Id

  - Associate

  - Order Date

  - Order Status

  - Action Date

Your page should look something like this when done (again, you may need
to [switch into “Live” mode to set the context](#potential-context-error)).

![](./media/image115.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.13 – Product Order Detail

Nothing really new so far…

14. Add a new heading “Order Items” BELOW the “Back” button on the
    Product Order Detail page, make the heading size 2.

![](./media/image116.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.14 – Detail with Heading

15. Now you’ll add a new table with data from the Product Order Line
    business object making sure that only lines matching the Product
    Order appear. First, drag a Table component under the new heading.

![](./media/image117.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.15 – Empty table component

16. Add data to the table from the Product Order Line business object
    
    ![](./media/image118.png)
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.16 – Add Data wizard step 1

17. In the “Bind Data” step of the Add Data wizard, select:

<!-- end list -->

  - id

  - product

  - unitPrice (set type to Input Number)

  - quantity (set type to Input Number)

> ![](./media/image119.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.17 – Add Data wizard step 2

18. Here’s the key step\! In step 3 “Define Query” of the Add Data
    wizard you will connect the data from the Product Order and the
    Product Order Line.  
      
    **DO NOT CLICK “Finish” until complete\!**
    
    ![](./media/image120.png)
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.18.1 – Define Query page 1**  
    **
    
    On the right-side of the “Define Query” wizard page under “Target”
    expand “{} filterCriterion -\> \[\] criteria -\>{} item\[0\] -\>” to
    expose attribute, op, and value” as shown below.
    
    ![](./media/image121.png)
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.18.2 – Define Query filterCriterion
    
    Select “attribute” and type “productOrder” as a “static” value
    (references Product Order).
    
    ![](./media/image122.png)
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.18.3 – attribute
    
    Select “op” and type “$eq” also as a “static" value (equal condition
    test).
    
    ![](./media/image123.png)
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.18.4 – op
    
    Drag the “ProductOrderId” value from the left-hand “Sources” column
    and drop it onto the “value” under “Target”.

    Click the "Finish" button when done.
    
    ![](./media/image124.png)
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.18.5 – value
    
    The Product Order Line information matching the current order should
    be displayed, if not, you may need to reset the context using the
    “Live” mode again (see [Section 1 – Create First Web Application
    \#10 for more](#potential-context-error))
    
    ![](./media/AppDev3.18.6.png)
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.18.6 – Finished screen
    
    You should now be able to test your Product Order – Product Order
    Line “master-detail” screens.

    You've enabled Mama Maggy's managers/franchisees to retrieve a list of their orders and check order status when it is convenient to them without having to call headquarters.
    
    This is a good time to use “Quick Start” to build Create, Edit, and
    Delete screens for both the Product Order List table (Product Order
    screen) and the Product Order Line table (Product Order Detail
    screen).
    
    Congratulations\! You’re now ready to create your first Mobile
    application with Visual Builder.

    [Return to top of Section 2 – Create Master-Detail Application](#section-2--create-master-detail-application)

     [Return to Table of Contents](#table-of-contents)

## Section 3 – Create Mobile Application

Mama Maggy's managers/franchisees want to be able to check product order status anytime, not just when they are in their offices. So, in this lab you will create a mobile application allowing them to check order status from their phone or other mobile devices, wherever they want, whenever they want.

19. Use Visual Builder’s Navigator to open Mobile Applications

![](./media/image126.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.19 – Mobile Applications icon

20. If you have not created any Mobile Applications yet click the “+
    Mobile Applications” button; otherwise, click the “+” to the right
    of “Mobile Apps”  
    ![](./media/image127.png)  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.20.1 – Mobile Applications plus button

![](./media/image128.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.20.2 – Mobile Apps plus

21. The New Mobile Application wizard has two steps; select “None” and
    click the right-arrow button “\>” to continue.

![](./media/image129.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.21 – New Mobile Application wizard 1

22. Click “Finish” on the second page of the wizard

![](./media/image130.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.22 – New Mobile Application wizard 2

23. Notice the “mobile” frame to help visualize a mobile app; select the
    title then modify it in the property inspector.

![](./media/image131.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.23 – Mobile title

24. Drag a “Table” component into the body of the phone, below the
    title.

![](./media/image132.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.24 – Adding table

25. Click on the empty table, then use “Quick Start” to “Add Data” -
    choose the “Product Order” business object.

![](./media/image133.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.25 – Add ProductOrder

26. Select the id (Input Number), orderDate (Input Date) , and
    orderStatus (Text) fields (no need to Define Query)

![](./media/image134.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.26 – Product Order data

27. Review the page; test

![](./media/image135.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.27 – Product Order list

28. Add a Detail page using the “Quick Start” menu and ProductOrder. Select id, associate, orderDate, and orderStatus.

![](./media/vbcs_add_detail_prodordermobile.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.28 – Order Detail fields

29. The basic Order Detail page looks like this.

![](./media/image137.png)

30. Add a heading “Items” below the Order Status by dragging the
    “Heading” component to the “Flex Container” in the Visual Builder
    Page Structure (click the Page Structure icon
    ![](./media/image138.png) to show/hide) then change the heading text
    to “Items” and the size to “H3”.

![](./media/image139.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.30 – Items heading

31. Add a table below the new heading by dragging a “Table”
    component to the “Flex Container” in the Page Structure display.

![](./media/image140.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.31 – Screen with empty table

32. Use the table’s “Quick Start” to “Add Data” from "ProductOrderLine" to the table, add Product Name (text),<br/>
__*** find Product Name by drilling down ***__<br/>
&nbsp;&nbsp;&nbsp; __{} response <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [] items <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{} item\[i\] <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{} Product Object <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[] items <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{} item[i] <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Product Name__<br/> 
    Unit Price (Input Number), and
    Quantity (Input Number).

> ![](./media/image141.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.32 – Items table contents  
>   
> Use “Define Query” to connect the Product List to the list of Items as
> follows:

  - Open {} filterCriterion -\> \[\] criteria -\> {} item\[0\] -\>

  - Select “attribute” and type “productOrder”

  - Select “op” and type “$eq”

  - Drag “productOrderId” to “value”

![](./media/image142.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.33 – Define Query complete

33. Product Order Line data populates table row(s).

![](./media/image143.png)

34. Test the mobile application the two screens should look something
    like the following:

![](./media/image144.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.34.1 – Run Order List

![](./media/image145.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 3.34.2 – Order Details

Congratulations! You have made the daily lives of Mama Maggy managers/franchisees easier. Instead of calling headquarters to check the status of their product orders they can now use your mobile app when and where it is convenient.

This concludes Lab 3.

[Return to top of Section 3 – Create Mobile Application](#section-3--create-mobile-application)

[Go to Lab 4](#lab-4-data-from-service) 

[Return to Table of Contents](#table-of-contents)

# Lab 4: Data from service

Mama Maggy's has multiple existing databases and other data stores being used to run their business. Mama Maggy management would prefer to access existing databases and any new databases directly rather than duplicating data in VBCS Business Objects.

While using Visual Builder’s built-in business objects is useful; they
limit applications to data found within the Visual Builder instance.
Most modern applications will use data from varied sources both in and
outside of an organization’s systems. This is accomplished using service
connections that take advantage of RESTful APIs exposed by databases and
other providers. API stands for Application Programming Interface; a
pre-defined calling mechanism used to read and modify data using
standardized calls over the internet with HTTP/HTTPS (often called
RESTful APIs). RESTful APIs are the most common way of using external data in
modern applications. In this Lab you will add useful information to your
application using RESTful API calls rather than Business Objects
(though, the truth is that VBCS uses RESTful API calls when accessing
Business Objects too).

Your resources for this lab include two (2) service connections used to
access data for Mama Maggy stores and Mama Maggy associates. You will
use these “Service Connections” to provide data services to your
applications. 

 ### ** Note you must be working within VBCS instance "OSPA-Class-Of-SE" for this lab to work properly **

Get the correct connection URL values for your class from the ["AppDev_Endpoints.txt" file in GitHub](https://github.com/oracle/learning-library/blob/master/ospa-library/appdev/application-development-lab/files/AppDev_Endpoints.txt) and copy them to your local machine to make the lab a little quicker to complete<br/> 
(please
ask the instructor if you have questions here).

[Skip to Lab 4 beginning](#begin-lab-4)
<br/><br/>

*******************************************************************
NOTE 1:

  If your environment does not have access to the Mama Maggy APIs; use the instructions in [Appendix C: Build Mama Maggy Data Application](#appendix-c-build-mama-maggy-data-application) to create some that you may use.

NOTE 2:

  Lab 4 assumes access to modern APIs that provide an industry-standard manifest; if only old-style endpoints are available use the instructions in [Appendix B: Create Service Connection from Endpoint](#appendix-b-create-service-connection-from-endpoint) instead of the instructions in this Lab to access the APIs.
*******************************************************************


#### Begin Lab 4

In this lab you will create new VBCS Web applications to display a list of Mama Maggy stores and the Associates who work in them. This will make it easier for a Mama Maggy manager/franchisee to collaborate with other. The data used to create these apps will come from "Service Connections" that you will create allowing the application to use data via RESTful APIs provided by the service provider.

1.  If you have logged out of the Oracle Cloud, please log back in and
    return to your VBCS application. You might find it useful to close
    any open windows.

2.  On the left-hand side of the Visual Builder interface is a navigator
    listing several options; choose “Service Connections”
    ![](./media/image146.png) to get started.

3.  If you have not yet created any “Service Connections” click the “+
    Service Connection” button

> ![](./media/image147.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.3.1 – Plus Service Connection
> 
> If you are presented with a list of one or more existing connections
> click the plus “+” sign at the top of the list to the right of the
> word “Services”
> 
> ![](./media/image148.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.3.2 – Services Plus

4.  The “Create Connection” wizard starts by asking for the source of
    the connection; for this lab we will choose “Define by
    Specification” for the connections created. Please click “Define
    by Specification” to continue. (if you only have an “endpoint” see
    [Appendix B: Create Service Connection from Endpoint](#appendix-b-create-service-connection-from-endpoint) for an example of “Define by Endpoint”)

> ![](./media/image149.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.4 – Define by Endpoint

5.  The wizard will then ask for specifics about the endpoint:

<!-- end list -->

  - Choose “ADF Describe” from the API Type pulldown

  - Choose “Web Address” as the Service Specification

  - Paste the provided URL into the space provided

  - Name the Service Id “mmassociates”

  - Choose “Oracle Cloud Account” from the Authentication pulldown

  - Make sure “Enable Token Relay” is UNCHECKED (as shown)

> ![](./media/image150.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.5.1 – Wizard Service Specification
> 
> When prompted to “Select Endpoints” open the navigator-style list
> under “Associate” . and for this exercise choose the two GET methods;
> one returns all “Associate” rows, the other selects specific
> “Associate” rows using an id value.
> 
> ![](./media/image151.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.5.2 – Wizard URL complete
> 
> Click “Create” to complete the process.
> 
> ![](./media/image152.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.5.3 – Create Button

6.  Next, open the service for testing: select the connection, choose
    the “Endpoints” tab, find and select the desired endpoint
    (highlighted below).

> ![](./media/image153.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.6 – Naming Endpoint to test

7.  Test the connection by selecting the “Test” tab, filling in any
    necessary parameters, and clicking “Send” to make a request.

> ![](./media/image154.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.7.1 – Test connection
> 
> When the service responds, look for a response status “200”
> (everything ok) and check the results.
> 
> ![](./media/image155.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.7.2 – Test status 200
> 
> ![](./media/image156.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.7.3 – Response body
> 
> If the response looks good to you click the “Copy to Response Body” so
> that Visual Builder will map out the response details as part of the
> connection.
> 
> ![](./media/image157.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.7.4 – Copy to Reponse Body
> 

> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.7.5 – Create button

8.  Locate the next endpoint to test and select it.

> ![](./media/image159.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.8 – Associate by id endpoint

9.  This endpoint gets a single “Associate” row that is identified by
    passing in an “{Associate\_Id}” value (or whatever the key field is
    named). Type an associate id number (“7 in the example”) and “Send”
    to test.  
    ![](./media/image160.png)  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.9 – Test single associate connection
> 
> You have now created and tested two connections.

10. Repeat the steps in 4.6 – 4.9 above to two the “mmstores” connection
    endpoints.

<!-- end list -->

  - Mama Maggy Store – get all

  - Mama Maggy Store – get single using {Store\_id}

> Be sure to test your connections.

11. Create a new Web Application named “storelist” that displays all of
    the Mama Maggy stores in a table. Refer to Lab 3: Web and Mobile
    Apps if you need a refresher on the basic steps.  
      
    Create a header that says “Mama Maggy Stores” and drop a table
    component below it.

> Use the “mmstores” service connection as the data source for the
> table.
> 
> ![](./media/image164.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.11 – mmstores data source

12. Choose the id, name, city, and state. Be sure to select “id” as the
    Primary Key too. (no need to Define Query)

> ![](./media/image165.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.12 – Add data items

13. The finished screen will look something like this.

> ![](./media/image166.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.13 – Store List

14. Use the table’s “Quick Start” ![](./media/image167.png) to “Add
    Detail Page” to get started.

> ![](./media/image168.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.14.1 – Add Detail Page
> 
> Use the “mmstores” again (because our connection used the standardized
> descriptors Visual Builder will choose the correct endpoint).

![](./media/image164.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.14.2 – mmstores connection

15. Choose id, name, address, city, state, and mailcode from the
    Endpoint Structure. 

> ![](./media/image169.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.15 – Store Detail data

16. Your Store details screen should look something like this.

> ![](./media/image170.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.16 – Sample Store Details

17. Now create an “associatelist” web application to display all
    “Associate” rows (you pick the fields) and provide a “Add Detail Page” to display a
    single Associate (you pick the fields here too).

<!-- end list -->

  - List display of all Associates (“mmassociates”)

  - Details display of selected Associate (“”mmassociates” using
    “associate\_id”)

> Test your application.

18. For something really fun; return to the “storelist” application and
    display the “Stores Detail” page (probably called
    “main-store-detail” or something close).

> ![](./media/image171.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.18 – Store Details original

19. Add a heading “Associates” under the “Back” button and add a “Table”
    component under the heading. Use the table’s “Quick Start“ menu to
    “Add Data” to the screen. Choose the “mmassociates” connection to
    supply the data.

> ![](./media/image172.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.19.1 – mmassociates connection
> 
> Select id, name, email, and hire date. Also be sure the “Primary Key”
> is set to the “id” field.
> 
> ![](./media/image173.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.19.2 – Associates data

20. **STOP** on step (3) “Define Query” so that you can connect the
    Associates to the Store listed on the page. Under “Define Query”
    expand “{} filterCriterion -\> \[\] criteria -\> {} item\[0\].

> ![](./media/image174.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.20.1 – Filtercriterion
> 
> Select “A attribute” and type “store” into the text box provided, this
> is “static” content.
> 
> ![](./media/image175.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.20.2 - attribute
> 
> Select “A op” and type “$eq” into the text box provided, this is
> “static” content.
> 
> ![](./media/image176.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.20.3 – op  
> Expand the “Sources” values under “Page-\>{} store” and drag the “id”
> value from the left side of the screen to the “A value” postion on the
> right. This establishes the link between the current screen (source)
> and the Associates data (target).
> 
> ![](./media/image177.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.20.4 - value

21. The completed screen should look something like this. Note, if the
    system is under stress it may take a few moments for the filtering
    to work properly. (This delay can be masked using an “if” test but
    is not necessary for our lab.)

> ![](./media/image178.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure 4.21 – Completed screen


This concludes Lab 4.

**Congratulations\!** You’ve now finished the required labs for this
course.

You may save today’s work using Visual Builder’s “export” capability, this will provide you with a starting point if you would like to continue working on the labs, **but more importantly will give you a starting point when you want to create a customer demonstration using VBCS**:

  - Return to the list of VBCS applications, highlight your application,
    then click the “Hamburger” menu icon on the right.

> ![](./media/image179.png)

  - Choose “Export

> ![](./media/image180.png)

  - Specify “Export with Data” and you will be prompted for the location
    where you want the application’s “.zip” file copied. (this file may
    be imported into another Visual Builder instance when you want to
    work some more).

> ![](./media/image181.png)

[Go to Extra Lab 5](#extra-lab-5-add-data-using-rest-call) 

[Return to Table of Contents](#table-of-contents)

# Extra Lab 5: Add Data Using REST Call

The “Extra” labs are intended to “flex” the mind-muscles of those who
have finished the other labs early so, they are short on explanation and
there are no example solutions provided.

In this lab you will work more with RESTful API calls.

1.  Review the “orderlist” web application and the similar mobile
    application.

2.  Recreate the “orderlist” as a new application (so that you don’t
    mess up the old one).  
      
    See if you can get data from the “mmassociates” service connection
    (single row access) to provide the associate’s “Name” rather than
    their “id” in the “Product Orders” list and “Product Order Detail”
    displays.

3.  (optional) Try to repeat \#2 and add replace the associate id with
    associate name in a copy of your mobile application (again, don’t
    mess up the original).

This concludes Extra Lab 5.

[Go to Extra Lab 6](#extra-lab-6-review-and-edit-javascript-code-under-the-covers-of-vbcs) – 
[Return to Table of Contents](#table-of-contents)

# Extra Lab 6: Review and edit JavaScript code “under the covers” of VBCS

The “Extra” labs are intended to “flex” the mind-muscles of those who
have finished the other labs early so, they are short on explanation and
there are no example solutions provided.

In this lab you will work actually “code” (assuming you know something
about JET or at least HTML5, JavaScript, and CSS).

Reopen one of your Web or Mobile application pages. Select the “Code”
view.

![](./media/image182.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure X.1 – Live/Design/Code button

This will display the actual code that supports your screen.

![](./media/image183.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure X.2 - Visual Builder code

Depending upon the time available and your proficiency coding,
experiment a little with the code.

If you’re light on coding skills just try something as simple as
changing the size of one of the headings.

For instance:  
  
“\<h2…\>Order Items\</h2\>” on line 19 above might be changed to
“\<h4…\>Order Items\</h4\>” to make the heading much smaller.

This concludes Extra Lab 6.

[Return to Table of Contents](#table-of-contents)

# Appendix

&nbsp;&nbsp;&nbsp;&nbsp;[Appendix A: Create VBCS Instance](#appendix-a-create-vbcs-instance)

&nbsp;&nbsp;&nbsp;&nbsp;[Appendix B: Create Service Connection from Endpoint](#appendix-b-create-service-connection-from-endpoint)

&nbsp;&nbsp;&nbsp;&nbsp;[Appendix C: Build Mama Maggy Data Application](#appendix-c-build-mama-maggy-data-application)

# Appendix A: Create VBCS Instance

Creating a VBCS instance is not part of the current Labs; learners will
be sharing a lab with others that has already been created.

However, it is possible you may need to create a VBCS instance in order
to learn more about VBCS or to create a customer demo. If you are
creating a new instance to support a customer demonstration please do
this BEFORE meeting with the customer; the process is simple but can
sometimes take several minutes.

1.  Log into your tenancy using cloud.oracle.com; be sure it has been
    provisioned to allow Visual Builder Cloud Service and the database
    and object storage instances also required.  
    (check with your tenancy admin if unsure)

![](./media/image_a_1.png)

&nbsp;&nbsp;&nbsp;Figure 1.1 - Login

2.  On some systems you will see a “dashboard” as shown below

![](./media/image_a_2.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.2.1 – Starting Dashboard

If you see a “Visual Builder” box as shown below, proceed to step 3.

If you don’t see the “Visual Builder” service box like this we’ll add it
to the display.

![](./media/image_a_3.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.2.2 – Visual Builder box

If you don’t see the “Visual Builder” box shown above; click on the
“Customize Dashboard

![](./media/image_a_4.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.2.3 – Customize Dashboard

Scroll the “Customize Dashboard” looking for “Visual Builder” service.
Services may be added/removed from the automatic display using the
“Automatic/Expand/Collapse” buttons provided.

![](./media/image_a_5.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.2.4 – Customize Dash choices

Once you find “Visual Builder” click the “Show” button so that it
appears in the dashboard.

![](./media/image_a_6.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.2.5 – Show Visual Builder

3.  From the “Visual Builder” service box there are two ways to open a
    service console.

> ![](./media/image_a_3.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.1.1 – Visual Builder service

One method is to click on the box’s “Visual Builder” text to display an
overview page.

![](./media/image_a_7.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.1.2 – Visual Builder Overview

From the overview page, click the “Open Service Console” button to
continue.

![](./media/image_a_8.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.1.3 – Open Service Console button

> Another method is to click the “hamburger” icon
> ![](./media/image_a_9.png) in the lower-right corner of the  
> “Visual Builder” service box to display a menu.

![](./media/image_a_3.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.2.1 – Visual Builder service box

Select “Open Service Console” from the menu.

![](./media/image_a_10.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.3.2.2 – Visual Builder service menu

4.  If you have not created any services the Service Console prompts you
    to begin the process.

> **DO NOT** CLICK “CREATE INSTANCE” at this time, we will be using
> “Quick Starts” (see step 5).
> 
> ![](./media/image_a_11.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.4.1 – Create Instance invitation
> 
> If Visual Builder instances already exist they will be shown in a
> table.
> 
> ![](./media/image_a_12.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.4.2 – VBCS existing instance(s)
> 
> **DO NOT** CLICK “CREATE INSTANCE” at this time, we will be using
> “Quick Starts” (see step 5).

5.  Visual Builder provides a “Quick Starts” capability to build an
    instance complete with supporting database and object storage. Click
    the “Quick Starts” button to get started it is located in the
    upper-right portion of the Service Console display inside the big
    blue bar.

> ![](./media/image_a_13.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.5.1 – Quick Starts button
> 
> When presented with the “QuickStarts” panel; provide an instance name
> and click the “Start” button to begin the process.
> 
> ![](./media/image_a_14.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.5.2 – QuickStarts page
> 
> Creation should take place in less than five minutes.
> 
> ![](./media/image_a_15.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure A.5.3 – Create button
> 
> That’s it, you’ve created an instance that can support many VBCS
> applications and user.


NOTE:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If others will be sharing your VBCS instance you will need to use Oracle Identity Cloud Service (IDCS)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;to make sure they have 'ServiceDeveloper' (Visual Builder Administrator) role for your instance if they are developers<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-- or 'ServiceAdministrator' (Visual Builder Administrator) role if they need to administer other's applications.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;See Oracle Documentation for more information.


[Return to Appendix list](#appendix)

[Return to Table of Contents](#table-of-contents)

# Appendix B: Create Service Connection from Endpoint


1.  If you have not yet created any “Service Connections” click the “+
    Service Connection” button

> ![](./media/image_1.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.1 – Plus Service Connection
> 
> If you are presented with a list of one or more existing connections
> click the plus “+” sign at the top of the list to the right of the
> word “Services”
> 
> ![](./media/image_2.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.2 – Services Plus

2.  The “Create Connection” wizard starts by asking for the source of
    the connection; for this lab we will choose “Define by Endpoint” for
    the connections created. Please click “Define by Endpoint” to
    continue.

> ![](./media/image_3.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.4 – Define by Endpoint

3.  The wizard will then ask for specifics about the endpoint.

> ![](./media/image_4.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.5.1 – Wizard URL
> 
> Provide the “Method” (GET), “URL” (from course specifications), and
> “Action Hint” (Get Many) then click “Next” to continue. This
> connection will return all rows from the “Associate” data source.
> 
> ![](./media/image_5.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.5.2 – Wizard URL complete

4.  Provide a name for the connection (“mmassociate” in the example).

> ![](./media/image_6.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.6 – Naming connection

5.  Test the connection by selecting the “Test” tab, filling in any
    necessary parameters, and clicking “Send” to make a request.

> ![](./media/image_7.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.7.1 – Test connection
> 
> When the service responds, look for a response status “200”
> (everything ok) and check the results.
> 
> ![](./media/image_8.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.7.2 – Test status 200
> 
> ![](./media/image_9.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.7.3 – Response body
> 
> If the response looks good to you click the “Copy to Response Body” so
> that Visual Builder will map out the response details as part of the
> connection.
> 
> ![](./media/image_10.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.7.4 – Copy to Reponse Body
> 
> Click the “Create” button to finish the process of building the
> service connection.
> 
> ![](./media/image_11.png)

6.  Create the next connection to select a single “Associate” row that
    is identified by passing in an “{id}” value (or whatever the key
    field is named).  
    ![](./media/image_12.png)  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.6.1 – Create single associate connection

> Provide a name for the connection (“mmassociateget” in the example).
> 
> ![](./media/image_13.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.6.2 – Name single connection

7.  Test the connection; be sure to specify a valid id for the test.
    Please notice that the parameters are surrounded by curly-style
    braces “{id}” in the path and that a place is automatically provided
    to enter a test value.

> ![](./media/image_14.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.7.1 – Test single connection
> 
> Check the response status and values, then click “Copy to Response
> Body” and the “Create” button to finish things up.
> 
> ![](./media/image_15.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure B.7.2 – Single connection response
> 
> You have now created and tested two connections.

8.  Repeat the steps in 4.3 – 4.9 above to create two more connections.

<!-- end list -->

  - Mama Maggy Store – get all (maybe “mmstoregetall”)

  - Mama Maggy Store – get single using {id}. (maybe “mmstoreget”)

> Be sure to test your connections. Please ask the instructor if you
> need assistance.

[Return to Appendix list](#appendix)

[Return to Table of Contents](#table-of-contents)

# Appendix C: Build Mama Maggy Data Application

This appendix shows how the “Mama Maggy” application was created to serve
as a data source for the Application Development labs.

Make sure a co-worker has not already performed this task. However, it
is possible you may need to create this VBCS application; it is used to
simulate “external” data available via RESTful APIs.

In this lab you will create:

  - A VBCS Application to house the data components (we suggest the name
    “Mama Maggy”)

  - A “Store” Business Object containing fields and data for the list of
    Mama Maggy’s stores

  - An “Associate” Business Object containing fields and data for Mama
    Maggy associates

  - Two .csv files are provided to provide data for Store and
    Associate  
    (be sure to create “Store” before “Associate” (Associate references
    Store), and  
    load data into “Store” first before loading data into “Associate”)

<!-- end list -->

1.  Log into your tenancy using cloud.oracle.com; be sure it has been
    provisioned to allow Visual Builder Cloud Service and the database
    and object storage instances also required.  
    (check with your tenancy admin if unsure)

![](./media/image_c_1.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.1 - Login

2.  On some systems you will see a “dashboard” as shown below

![](./media/image_c_2.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.2.1 – Starting Dashboard

If you see a “Visual Builder” box as shown below, proceed to step 3.

If you don’t see the “Visual Builder” service box like this we’ll add it
to the display.

![](./media/image_c_3.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.2.2 – Visual Builder box

If you don’t see the “Visual Builder” box shown above; click on the
“Customize Dashboard

![](./media/image_c_4.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.2.3 – Customize Dashboard

Scroll the “Customize Dashboard” looking for “Visual Builder” service.
Services may be added/removed from the automatic display using the
“Automatic/Expand/Collapse” buttons provided.

![](./media/image_c_5.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.2.4 – Customize Dash choices

Once you find “Visual Builder” click the “Show” button so that it
appears in the dashboard.

![](./media/image_c_6.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.2.5 – Show Visual Builder

3.  From the “Visual Builder” service box there are two ways to open a
    service console.

> ![](./media/image_c_3.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.3.1.1 – Visual Builder service

One method is to click on the box’s “Visual Builder” text to display an
overview page.

![](./media/image_c_7.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.3.1.2 – Visual Builder Overview

From the overview page, click the “Open Service Console” button to
continue.

![](./media/image_c_8.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.3.1.3 – Open Service Console button

> Another method is to click the “hamburger” icon
> ![](./media/image_c_9.png) in the lower-right corner of the  
> “Visual Builder” service box to display a menu.

![](./media/image_c_3.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.3.2.1 – Visual Builder service box

Select “Open Service Console” from the menu.

![](./media/image_c_10.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.3.2.2 – Visual Builder service menu

4.  When the VBCS Service Console “Instances” list appears; use the
    “Hamburger Icon” ![](./media/image_c_9.png)on the far right and
    choose “Open Oracle Visual Builder Cloud Service Home Page” to begin
    creating your new application.

![](./media/image_c_11.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.4 – Open Home Page

5.  When the “Visual Applications” list appears; choose the “New” button

![](./media/image_c_12.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.5.1 – Visual Applications

![](./media/image_c_13.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.5.2 – Import New Buttons

6.  When the “Create Application” panel opens; provide an “Application
    Name” of “Mama Maggy” (“Application Info” will default based upon
    what you type), provide a description (optional), and select the
    “Empty Application” template (should be the default).

> ![](./media/image_c_14.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.6.1 – Create Application

Click the “Finish” button when done.

![](./media/image_c_15.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.6.2 – Finish button

7.  This application will be used to host two Business Objects that will
    be used by other applications via RESTful APIs; this is simulating
    the use of external API access such as database or SaaS application.

> Select the “Business Object” button to start creating business
> objects.
> 
> ![](./media/image_c_16.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.7 – Business Object button

8.  From the application page, click “+ Business Object” to begin adding
    a business object.

> ![](./media/image_c_17.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.8.1 – Application Page
> 
> Provide a name “Store” and click the “checkbox” icon.
> 
> ![](./media/image_c_18.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.8.2 – Plus Business Object

9.  Add Fields to the Store object as follows (please create them as
    shown to match the .csv data):

<!-- end list -->

  - Name

  - Address

  - City

  - State

  - Mailcode

![](./media/image_c_19.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.9 – Store object fields

10. Create an “Associate” object next; this will happen in steps to
    account for the reference in the “Associate” row to the “Store” row.
    Add fields as follows:

<!-- end list -->

  - From the “Fields” tab, click “+ New Field” and add “Name”

  - Define the “Store” relationship:
    
    1.  Switch to the “Overview” tab
    
    2.  Click “Relationships +”
    
    3.  Use dropdown to select “Store”
    
    4.  Make sure the relationship is one “Store” to many “Associate”
    
    5.  Click “Done” when finished

  - From the “Fields” tab, click “+ New Field” and add “Hire Date” (date
    field)

  - From the “Fields” tab, click “+ New Field” and add “Email” (email
    field)

> ![](./media/image_c_20.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.10 – Associate object fields

11. Use the Business Object “hamburger” icon’s ![](./media/image_c_9.png)
    menu to select “Diagram” option.

> ![](./media/image_c_21.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.11.1 – Diagram option

The business object diagram should look like the following; if not
please correct or redo.

> ![](./media/image_c_22.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.11.2 – Object relationship diagram

12. To load data into the objects, start by once again using the
    Business Object “hamburger” ![](./media/image_c_9.png)icon but this
    time select the “Data Manager” option.

> ![](./media/image_c_23.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.12.1 – Data Manager option
> 
> Click on “Import from File” from the “Manage Application Data” panel.
> 
> ![](./media/image_c_24.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.12.2 – Manage Application Data
> 
> Click on the “Upload a file or drag it here” picture.
> 
> ![](./media/image_c_25.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.12.3 – Empty import data
> 
> Select the “Store.csv” file supplied as part of the course setup and
> click the “Import” button.
> 
> ![](./media/image_c_26.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.12.4 – Import Store.csv

Visual Builder will report upon the success/failure of the import.

![](./media/image_c_27.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.12.5 – Import Store results

Import the “Associate.csv” file using the same technique.

![](./media/image_c_28.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.12.6 – Import Associate.csv

Results should be.

![](./media/image_c_29.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.12.8 – Import Associate results

13. Review the added data using the “Data” tab for the two objects.

> ![](./media/image_c_30.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.13.1 – Store data
> 
> ![](./media/image_c_31.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.13.2 – Associate data

14. Access points currently have a “version” number and will change each
    time the objects are modified. Currently only the “development”
    addresses are available. The steps below will show you how to publish and make the addresses constant.

> ![](./media/image_c_32.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.14 – Development-only Resource API addresses

15. To “set” the access points so that they will not change over time;
    you must first “Stage” and then “Publish” the application.  (When the application is in "Development" and "Staging" the addresses are versioned; once an application is published to the "Live" environment the address will not change and is suitable for sharing.)
      
    First, return to the list of business objects.

> ![](./media/image_c_33.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.15.1 – Application list
> 
> Using the “hamburger” icon ![](./media/image_c_9.png) (far right) open
> the menu and select “Stage” for the application.
> 
> ![](./media/image_c_34.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.15.2 – Select stage
> 
> Select “Populate Stage with Development data” to copy the data loaded
> previously into the staging environment, then click the “Stage”
> button.
> 
> ![](./media/image_c_35.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.15.3 – Stage application

The addresses we need are still not final, so the application must be
published. Return to the list of applications and click the “hamburger”
icon again. This time choose the “Publish” option.

![](./media/image_c_36.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.15.4 – Publish option

Be sure to “Include data from Stage” before you click the “Publish”
button.

![](./media/image_c_37.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.15.5 – Publish Application

16. Reopen the application. In order for others to use REST APIs to
    access the data in the application’s business objects the Resource
    API addresses must be made available.

> Select the “Store” business object and click on the “Endpoints” tab.
> Addresses are listed for Development, Staging, and Live environments.
> Also there are two columns, the ones on the left provide Metadata that
> more-advanced client applications (like Visual Builder) may take
> advantage of. The column on the right shows data-only “Endpoints” that
> require a little more work to use.
> 
> From the left column select the “Live” address and click the
> “clipboard” icon ![](./media/image_c_38.png). Paste the resulting
> string into a text file in your local environment to share with
> applications wanting to use the data.
> 
> This is the address needed to access “Store” data.
> 
> ![](./media/image_c_39.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.16.1 – Store Resource APIs
> 
> ![](./media/image_c_40.png)
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Figure C.16.2 – Address to copy
> 
> Select the “Associate” business object and once again display the
> “Endpoints” tab. Copy the value from the “Metadata” column “Live”
> row using the “clipboard” icon ![](./media/image_c_38.png). Paste the
> resulting string into a text file in your local environment to share
> with applications wanting to use the data.
> 
> This is the address needed to access “Associate” data

That’s it, you’ve created an application with business objects that may
be accessed using REST APIs like those used in Lab 4.

[Return to Appendix list](#appendix)

[Return to Table of Contents](#table-of-contents)