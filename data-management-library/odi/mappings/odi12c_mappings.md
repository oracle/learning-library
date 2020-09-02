# Oracle Data Integrator 12c: Working with Mappings

## Introduction to Working with Mappings

This chapter describes how to work with mappings in Oracle Data Integrator. The demonstration environment includes several example mappings. In this chapter you will learn how to create the following mappings:

  * Load TRG\_CUSTOMER: This mapping loads the data from the SRC\_CUSTOMER table in the *Orders Application* model into the TRG\_ CUSTOMER target table in the *Sales Administration* model.
  * Load TRG\_SALES: This mapping loads the data from the SRC\_ ORDERS table and from the SRC\_ORDER\_LINES table in the *Orders Application* model into the TRG\_SALES target table in the *Sales Administration* model.

## **Step 1:**  Load TRG\_CUSTOMER Mapping Example

1. Purpose and Integration Requirements
The purpose of the Load TRG\_CUSTOMER mapping is to load the data from the SRC\_ CUSTOMER table in the *Orders Application* model into the TRG\_CUSTOMER target table in the *Sales Administration* model.

However, the SRC\_CUSTOMER table does not contain all of the data that is required for this operation. The following information has to be added to the target table:

  * The age range (AGE\_RANGE) that is defined in the SRC\_AGE\_GROUP flat file in the *Parameters* model corresponds to the AGE attribute in the source table.
  * The last and first names of the customer sales rep. (LAST\_NAME and FIRST\_ NAME) that is defined in the SRC\_SALES\_PERSON file in the *Parameters* model correspond to the sales representative ID (SALES\_PERS\_ID) in the source table.
  * The transformed value of the numeric data (0, 1, 2) from the DEAR column in the source table into an standard salutation text string in the target (Mr, Mrs, or Ms).
  * The concatenated first and last names of the source customers.

The source data is not always consistent with the integrity rules implemented in the target environment. For this mapping, the data has to be cleansed by verifying that all constraints are satisfied and by storing invalid rows in an error table rather than in our target database. In this example, two important integrity rules must be satisfied:
  * Customers must be older than 21 (condition AGE \> 21)
  * The customers must be associated with a city (CITY\_ID) that exists in the TRG\_ CITY table (reference FK\_CUST\_CITY)

The functional details for these rules and the procedure to follow are described later in this lab.

2. Mapping Definition
This section describes the mapping Load TRG\_CUSTOMER that will be created in this example. See *Creating the Mapping* for more information.

The Load TRG\_CUSTOMER mapping uses the following data and transformations:
  * One target datastore. Details:
|-----------------------|---------------|-------------|--------------|
| Model                 | Datastore     | Description |  Type        |
|-----------------------|---------------|-------------|--------------|
| Sales Administration  | TRG\_CUSTOMER |             | Oracle Table |
|-----------------------|---------------|-------------|--------------|

  * Three source datastores:

|-----------------------|---------------|-------------|--------------|  
| Model                 | Datastore     | Description |  Type        |
|-----------------------|---------------|-------------|--------------|
| Orders Application    | SRC\_CUSTOMER | Customers in| Oracle Table |
|                       |               | the source  |              |
|                       |               | system      |              |
|-----------------------|---------------|-------------|--------------|  
| Parameters            | SRC\_AGE\_GRO | Age bracket | File         |
|                       | UP            | file        | delimited by |
|                       |               |             | semicolons   |
|-----------------------|---------------|-------------|--------------|
| Parameters            | SRC\_SALES\_P | Salesperson | File         |
|                       | ERSON         | File        | delimited by |
|                       |               |             | semicolons   |
|-----------------------|---------------|-------------|--------------|

  * One Join:

|-----------------------|---------------|----------------------------|
| Join                  | Description   | SQL RULE                   |
|-----------------------|---------------|----------------------------|
| Sales Representatives | Join          | SRC\_CUSTOMER.SALES\_PERS\_|
| and Customers         | SRC\_SALES\_P | ID = SRC\_SALES\_PERSON\.S |
|                       | ERSON and     | ALES\_PERS\_ID             |
|                       | SRC\_CUSTOMER |                            |
|-----------------------|---------------|----------------------------|

  * One **Lookup** table:

|-----------------------|---------------|----------------------------|
| Lookup                | Description   | SQL RULE                   |
|-----------------------|---------------|----------------------------|
| Customers and         | The customers | SRC\_CUSTOMER.AGE between  |
| age range             | age must be   | SRC\_AGE_GROUP.AGE\_MIN and|
|                       | between the mi| SRC\_AGE_GROUP.AGE\_MAX    |
|                       | n and max ages|                            |
|                       | in the file   |                            |
|-----------------------|---------------|----------------------------|  

  * Several transformation rules:

|---------------|-------------------------|-------------------------|
| Target Column | Origin                  | SQL Rule(Expression)    |
|---------------|-------------------------|-------------------------|
| CUST\_ID      | SRC\_ CUSTOMER.CUSTID   | SRC\_ CUSTOMER.CUSTID   |
|---------------|-------------------------|-------------------------|
| DEAR          | If SRC\_CUSTOMER.DEAR = | CASE                    |
|               | 0                       |                         |
|               |                         | WHEN CUSTOMER.DEAR=0    |
|               | then \'MR\'             | THEN \'Mr\'             |
|               |                         |                         |
|               | If SRC\_ CUSTOMER.DEAR  | WHEN CUSTOMER.DEAR=1    |
|               | = 1                     | THEN \'Mrs\'            |
|               |                         |                         |
|               | then \'MRS\' else       | ELSE \'Ms\'             |
|               | \'MS\'                  |                         |
|               |                         | END                     |
|---------------|-------------------------|-------------------------|
| CUST\_NAME    | Concatenation of SRC\_  | TRIM(SRC                |
|               | CUSTOMER.FIRST\_NAME    | \_CUSTOMER.FIRST\_NAME) |
|               | and SRC\_               | \|\| \' \' \|\|         |
|               | CUSTOMER.LAST\_NAME in  | UPPER(TRIM(SRC          |
|               | upper case              | \_CUSTOMER.LAST\_NAME)) |
|---------------|-------------------------|-------------------------|
| ADDRESS       | SRC\_CUSTOMER.ADDDRESS  | SRC\_CUSTOMER.ADDRESS   |
|---------------|-------------------------|-------------------------|
| CITY\_ID      | SRC\_CUSTOMER.CITY\_ID  | SRC\_CUSTOMER.CITY\_ID  |
|---------------|-------------------------|-------------------------|
| PHONE         | SRC\_CUSTOMER.PHONE     | SRC\_CUSTOMER.PHONE     |
|---------------|-------------------------|-------------------------|
| AGE           | SRC\_CUSTOMER.AGE       | SRC\_CUSTOMER.AGE       |
|---------------|-------------------------|-------------------------|
| AGE\_RANGE    | SRC\_AGE\_              | SRC\_AGE\_              |
|               | GROUP.AGE\_RANGE        | GROUP.AGE\_RANGE        |
|---------------|-------------------------|-------------------------|
| SALES\_PERS   | Concatenation of        | TRIM(SRC\_SAL           |
|               | SRC\_SA                 | ES\_PERSON.FIRST\_NAME) |
|               | LES\_PERSON.FIRST\_NAME | \|\| \' \' \|\|         |
|               | and                     | UPPER(TRIM(SRC\_SAL     |
|               | SRC\_S                  | ES\_PERSON.LAST\_NAME)) |
|               | ALES\_PERSON.LAST\_NAME |                         |
|               | in uppercase            |                         |
|---------------|-------------------------|-------------------------|
| CRE\_DATE     | Today's date            | SYSDATE                 |
|---------------|-------------------------|-------------------------|
| UPD\_DATE     | Today's date            | SYSDATE                 |
|---------------|-------------------------|-------------------------|

## **Step 2:** Creating the Mapping

This section describes how to create the Load TRG\_CUSTOMER mapping. To create the Load TRG\_CUSTOMER mapping perform the following procedure:
1. Insert a New Mapping
   To create a new mapping:
   1. In Designer Navigator, expand the Demo project node in the Projects accordion.
   2. Expand the Sales Administration node.
   3. In the Sales Administration folder, right-click the Mapping node and select **New Mapping**:
  ![](./images/mapping_new_instance.png)
   4. Enter the name of your mapping (Load TRG\_CUSTOMER) in the Name field:
  ![](./images/mapping_editor.png)
     Ensure the *Create Empty Dataset* option is not selected.

## **Step 3:** Define the Target

The target is the element that will be loaded by the mapping.

**To insert the target in the Load TRG\_CUSTOMER mapping:**

1.  Verify you are in the Logical tab of the Mapping Editor.

2.  In the Designer Navigator, expand the Models accordion and the *Sales Administration* model.

3.  Select TRG\_CUSTOMER datastore under the *Sales Administration* model and drag it into the mapping editor

  ![](./images/selecting_the_target.png)

## **Step 4:** Define the Source

The source datastores contain data used to load the target datastore. Two types of datastores can be used as a mapping source: datastores from the models and reusable mappings. This example uses datastores from the *Orders Application* and *Parameters* models.

**To add source datastores to the Load TRG\_CUSTOMER mapping:**

1.  Under models, drag the following source datastores into the Source Diagram:

  * SRC\_CUSTOMER from the *Orders Application* model
  * SRC\_SALES\_PERSON from the *Parameters* model

2.  The Mapping should look like:

  ![](./images/adding_data_stores.png)

## **Step 5:** Define the Lookup

This section describes how to create a lookup that defines that the customer\'s age must be between the minimum and maximum ages in the file.
A lookup is a datastore (from a model or the target datastore of a map) - called the *lookup table* - associated to a source datastore - the *driving table* - via a join expression and from which data can be fetched and used in mappings.

Lookup tables are added with the Lookup Component.

**To create a lookup in the Load TRG\_CUSTOMERmapping:**

1.  From the Components panel, drag **Lookup into the mapping** as shown:

  ![](./images/insert_a_lookup.png)

2.  From the Parameters model, drag the SRC\_AGE\_GROUP datastore into the Mapping. The SRC\_AGE\_GROUP datastore will be used as a lookup table.

3.  Drag the following source columns into the Lookup:

  * Age from the SRC\_CUSTOMER source datastore
  * AGE\_MIN from the SRC\_AGE\_GROUP datastore
  * AGE\_MAX from the SRC\_AGE\_GROUP datastore

  ![](./images/select_the_lookup.png)

4.  Select the LOOKUP, click **Condition** in the LOOKUP -- Properties as shown:

  ![](./images/lookup_condition.png)

5.  Modify the Condition by replacing the '=' with the string 'between'. You should have the following in the Lookup Condition:

  * SRC\_CUSTOMER.AGE between SRC\_AGE\_GROUP.AGE\_MIN and SRC\_AGE\_GROUP.AGE\_MAX

This corresponds to a join between the SRC\_CUSTOMER and the SRC\_AGE\_GROUP datastore and defines that the customer\'s age must between the minimum and maximum ages in the file.

  ![](./images/modified_expression.png)

6.  Click **Save**.

## **Step 6:** Define the Join between the Source Datastores

This section describes how to define a join between the source datastores. To create the join defined in Step 1 above:

1.  Drag the JOIN component into the mapping.

2.  In the mapping, drag the SALES\_PERS\_ID column from the SRC\_CUSTOMER datastore into the JOIN.

3.  In the mapping, drag the SALES\_PERS\_ID column from the SRC\_SALES\_PERSON datastore into the join.

  ![](./images/join_properties.png)

***Source Diagram of the Load TRG\_CUSTOMER Mapping with a Lookup and a Join***

  ![](./images/diagram_of_TRG_CUSTOMER_mapping.png)

## **Step 7:** Define the Target Expressions

The following columns are mapped in this section: CUST\_ID, DEAR, CUST\_NAME, AGE\_RANGE, SALES\_PERS, CRE\_DATE and UPD\_DATE.
To Auto Map from the sources to the target, the connector points need to be dragged and dropped between components.

1.  From the JOIN component, drag the connector point, holding and dragging to the target input connector point. An Attribute matching dialog is displayed, keep the defaults and click **OK**.

  ![](./images/attribute_matching.png)

**The transformation rules, defined as *expressions*, are listed on the target column.**

2. To complete the custom mappings.

Click on the TRG\_CUSTOMER datastore in the mapping to display the properties.

  ![](./images/trg_customer_properties.png)

## **Step 8:** CUST\_ID Mapping Expression

The CUST\_ID mapping expression maps the SRC\_CUSTOMER.CUSTID source column to the TRG\_CUSTOMER.CUST\_ID target column. Note that these 2 columns have not been automatically mapped, since their names are slightly different.

To define the expression for the CUST\_ID target column:

1.  In the SRC\_CUSTOMER data source, select the CUSTID column.

2.  Drag it into the CUST\_ID field in the Target Datastore as shown:

  ![](./images/cust_id_mapping_expr.png)

3.  Select the mapped field, CUST\_ID in the Target Datastore to display its properties in the Property Inspector.

**DEAR Mapping Expression**

This transformation rule maps the source datastore\'s DEAR column (numeric) as a string expression (0 \--\>\'MR\', 1 \--\>\'MRS\', 2\--\>\'MS\').

To define the expression for the DEAR target column:

1.  In the Target Datastore, select the DEAR target column to display the mapping properties in the Property Inspector.

2.  In the Expression field, enter the following mapping expression:

  ````
  <copy>
  CASE
    WHEN SRC_CUSTOMER.DEAR = 0 THEN 'Mr'
    WHEN SRC_CUSTOMER.DEAR = 1 THEN 'Mrs'
  ELSE 'Ms'
  END
  </copy>
  ````
**Tip:** You can drag source columns, for example the SRC\_CUSTOMER.DEAR column, into the Expression field. You can also use the Expression Editor.

**CUST\_NAME Mapping Expression**

This transformation rule maps the concatenated value of the first name
and uppercase last name of each customer.

To define the expression for the CUST\_NAME target column:

1.  In the Target Datastore, select CUST\_NAME to display the expression
    properties in the Property Inspector.

2.  In the Expression field, enter the following mapping expression:

  ````
  <copy>
  TRIM(SRC_CUSTOMER.FIRST\_NAME) || ' ' ||
  UPPER(TRIM(SRC_CUSTOMER.LAST_NAME))
  </copy>
  ````
**Tip:** Use the Expression Editor to create this rule. By using the Expression Editor, you can avoid most common syntax errors.

**AGE\_RANGE Mapping Expression**

This mapping expression maps the SRC\_AGE\_GROUP.AGE\_RANGE to the TRG\_CUSTOMER.AGE\_RANGE and is already defined.

1.  In the Target Datastore, select AGE\_RANGE to display the mapping properties in the Property Inspector.

2.  In the Expression field, the following mapping expression should appear:

     SRC\_AGE\_GROUP.AGE\_RANGE

**Tip:** Auto-completion functions are available in ODI Studio. In the Expression, type SRC\_ and then press \<CTRL-SPACE\>, a pop-up window displays available fields as shown:

  ![](./images/auto_completion.png)

You can also drag and drop the AGE\_RANGE column from SRC\_AGE\_GROUP into AGE\_RANGE in TRG\_CUSTOMER.

**SALES\_PERS Mapping Expression**

This will map the concatenated value of the first name and uppercase last name of each salesperson.

To define the mapping expression for the SALES\_PERS target column:

1.  In the Target Datastore, select SALES\_PERS to display the expression properties in the Property Inspector.

2.  In the Expression field, enter the following mapping expression:

  ````
  <copy>
  TRIM(SRC_SALES_PERSON.FIRST_NAME) || ' ' ||
  UPPER(TRIM(SRC_SALES_PERSON.LAST_NAME))
  </copy>
  ````
**CRE\_DATE Mapping Expression**

To define the mapping expression for the CRE\_DATE target column:

1.  In the Target Datastore, select CRE\_DATE to display the mapping
    properties in the Property Inspector.

2.  In the Expression field, enter the following mapping expression:
       SYSDATE

3.  Verify that **Active** is selected.

4.  Unselect **Update**. The mapping will be performed only on Insert.

5.  The Property Inspector of the CRE\_DATE attribute appears as shown:

  ![](./images/property_inspector_cr_date_mapping.png)

**UPD\_DATE Mapping Expression**

To define the mapping expression for the UPD\_DATE target column:

1.  In the Target Datastore, select UPD\_DATE to display the attribute properties in the Property Inspector.

2.  In the Expression field, enter the following mapping expression:
        SYSDATE

3.  Verify that **Active Mapping** is selected.

4.  Unselect **Insert**. The mapping expression will be performed only on Update.

**Notes on the Expression Editor**

  * The Expression Editor that is used to build the Expressions does not contain all the functions specific to a technology. It contains only functions that are common to a large number of technologies. The fact that a function does not appear in the Expression Editor does not prevent it from being entered manually and used in an Expression.
  * If you were to execute this mapping on the target using the Execute on Hint field, the Expression Editor would give you the syntax for your target system.

**The Target Datastore Panel**

Your transformation rules appear in the Target Datastore Attributes panel:

  ![](./images/target_datastore_mappings.png)

**Set the Integration Type**

Finally click on TRG\_CUSTOMER datastore in the Mapping and in the Properties panel under Target set the Integration Type to Incremental Update.

## **Step 9:** Define the Data Loading Strategies (LKM)

The data loading strategies are defined in the Physical tab of the Mapping Editor. Oracle Data Integrator automatically computes the flow depending on the configuration in the mapping\'s diagram. It proposes default Knowldege Modules (KMs) for the data flow. The Physical tab enables you to view the data flow and select the KMs used to load and integrate data.

Loading Knowledge Modules (LKM) are used for loading strategies and Integration Knowledge Modules (IKM) are used for integration strategies.

You have to define the way to retrieve the data from the SRC\_AGE\_GROUP, SRC\_ SALES\_PERSON files and from the SRC\_CUSTOMER table in your source environment.

To define the loading strategies:

1.  In the Physical tab of the Mapping Editor, select the access point that corresponds to the loading of the SRC\_AGE\_GROUP, SRC\_SALES\_PERSON files. In this example, this is the SRC\_AGE\_GROUP\_AP and SRC\_SALES\_PERSON\_AP. The Property Inspector should display the properties of the access points.

2.  In the Property Inspector, verify that the **LKM SQL to SQL (Built-In)** is selected in the Loading Knowledge Module Selector list:

  ![](./images/load_mapping_editor.png)

3.  Use **LKM SQL to SQL (Built-In)** for the access point corresponding to SRC\_CUSTOMER as well.

## **Step 10:** Define the Data Integration Strategies (IKM)

After defining the loading phase, you need to define the strategy to adopt for the integration of the data into the target table.

To define the integration strategies:

1.  In the Physical tab of the Mapping Editor, select TRG\_CUSTOMER in the TARGET\_GROUP object. The Property Inspector will display the properties of the target.

2.  In the Property Inspector, set the IKM to **IKM Oracle Incremental Update** in the *Integration Knowledge Module* Selector list. If this IKM is not in the list, make sure you have correctly set the  Target Integration Type to Incremental Update in the Logical panel.

3.  In the knowledge module options, leave the default values. The Property Inspector appears as shown:

  ![](./images/property_insp_trg_customer.png)

**Note:** Only the built-in Knowledge Modules or the ones you imported to your Project appear in the KM Selector lists. The demonstration environment already includes the Knowledge Modules required for the getting started examples. You do not need to import KMs into the demonstration Project.For more information on importing KMs into your Projects, see *Importing a KM* in the *Oracle Fusion Middleware Developer\'s Guide for Oracle Data Integrator*.

## **Step 11:** Define the Data Control Strategy

In the preceeding steps you have specified the data flow from the source to the target. You must now define how to check your data (CKM) and the constraints and rules that must be satisfied before integrating the data.

To define the data control strategy:

1.  In the Mapping Physical tab under the TRG\_CUSTOMER Properties, select Check Knowledge Module, verify that the **CKM Oracle** is selected for Check Knowledge Module.

2.  In the Logical view, select the target datastore TRG\_CUSTOMER and verify the Constraints panel. Set the constraints that you wish to verify to true.

  * PK\_TRG\_CUSTOMER
  * FK\_CUST\_CITY

The Constraints tab appears as shown:

  ![](./images/constr_trg_cusomer.png)

3.  From **File** main menu, select **Save**.

The Load TRG\_CUSTOMER mapping is now ready to be run.

Load TRG\_SALES Mapping Example
-------------------------------

This section contains the following topics:

-   Purpose and Integration Requirements

-   Mapping Definition

-   Creating the Mapping

    1.  

        1.  ### Purpose and Integration Requirements

This section describes the integration features and requirements the
mapping Load TRG\_SALES is expected to meet.

The purpose of this mapping is to load the SRC\_ORDERS table of orders
and the SRC\_ ORDER\_LINES table of order lines from the *Orders
Application* model into the TRG\_SALES target table in the *Sales
Administration* model. The data must be aggregated before it is
integrated into the target table. Only orders whose status is CLO are to
be used.

However, the source data is not always consistent with the integrity
rules present in the target environment. For this transformation, we
want to cleanse the data by verifying that all of the constraints are
satisfied. We want to place any invalid rows into an error table rather
that into our target database. In our case, two important integrity
rules must be satisfied:

-   The sales must be associated with a product (PRODUCT\_ID) that
    exists in the TRG\_PRODUCT table (reference FK\_SALES\_PROD

-   The sales must be associated with a customer (CUST\_ID) that exists
    in the TRG\_ CUSTOMER table (reference FK\_SALES\_CUST

The functional details for these rules and the procedure to follow are
given in Section 5.2.3, \"Creating the Mapping\".

### Mapping Definition

This section describes the mapping Load TRG\_SALES that will be created
in this example. See [Section 4.2.3, \"Creating the
Mapping\"](#creating-the-mapping-1) for more information.

The Load TRG\_SALES mapping uses the following data and transformations:

-   One target datastore. Table 4--7 lists the details of the target
    datastore.

> ***Table 4--7 Target Datastore Details of Load TRG\_SALES***

  Model                  Datastore    Description                                       Type
  ---------------------- ------------ ------------------------------------------------- --------------
  Sales Administration   TRG\_SALES   Target table in the Sales Administration System   Oracle table

-   Two source datastores. Table 4--8 lists the details of the source
    datastores.

> ***Table45--8 Source Datastore Details of Load TRG\_SALES***

  Model                Datastore           Description                              Type
  -------------------- ------------------- ---------------------------------------- --------------
  Orders Application   SRC\_ORDERS         Orders table in the source systems       Oracle table
  Orders Application   SRC\_ORDER\_LINES   Order lines table in the source system   

-   One **Join**. Table 4--9 lists the details of the join.

> ***Table 4--9 Joins used in Load TRG\_SALES***

|------------------------|------------------|------------------------|
| Join                   | Description      | SQL Rule               |
|========================|==================|========================|
| Commands and Order     | Join SRC\_ORDERS | SRC\_ORDERS.ORDER\_ ID |
| lines                  |                  | = SRC\_ORDER\_         |
|                        | and SRC\_ORDER\_ | LINES.ORDER\_ID        |
|                        |                  |                        |
|                        | LINES            |                        |
|------------------------|------------------|------------------------|

-   One **Filter**. Table 4--10 lists the details of the filter.

> ***Table 4--10 Filters used in Load TRG\_SALES***

  Description                               SQL Rule
  ----------------------------------------- ----------------------------------------
  Only retrieve completed orders (CLOSED)   SRC\_ORDERS.STATUS = \'CLO\'
  Orders Application                        Order lines table in the source system

-   Several transformation rules. Table 4--11 lists the details of the
    > transformation rules.

> ***Table 4--11 Transformation Rules used in Load TRG\_SALES***

  Target Column      Origin                                               SQL Rule(Expression)
  ------------------ ---------------------------------------------------- --------------------------------
  CUST\_ID           CUST\_ID from SRC\_ ORDERS                           SRC\_ORDERS.CUST\_ ID
  PRODUCT\_ID        PRODUCT\_ID from SRC\_ORDER\_LINES                   SRC\_ORDER\_ LINES.PRODUCT\_ID
  FIRST\_ORD\_ID     Smallest value of ORDER\_ID                          MIN(SRC\_ ORDERS.ORDER\_ID)
  FIRST\_ORD\_DATE   Smallest value of the ORDER\_DATE from SRC\_ORDERS   MIN(SRC\_ ORDERS.ORDER\_ DATE)
  LAST\_ORD\_ID      Largest value of ORDER\_ID                           MAX(SRC\_ ORDERS.ORDER\_ID)
  LAST\_ORD\_DATE    Largest value of the ORDER\_DATE from SRC\_ORDERS    MAX(SRC\_ ORDERS.ORDER\_ DATE)
  QTY                Sum of the QTY quantities from the order lines       SUM(SRC\_ORDER\_ LINES.QTY)
  AMOUNT             Sum of the amounts from the order lines              SUM(SRC\_ORDER\_ LINES.AMOUNT)
  PROD\_AVG\_PRICE   Average amount from the order lines                  AVG(SRC\_ORDER\_ LINES.AMOUNT)

### Creating the Mapping

This section describes how to create the Load TRG\_SALES mapping. To
create the Load TRG\_SALES mapping perform the following procedure:

1.  Insert a Mapping

2.  Define the Target Datastore

3.  Define the Source Datastores

4.  Define Joins between the Source Datastores

5.  Define the Order Filter

6.  Define the Transformation Rules

7.  Define the Data Loading Strategies (LKM)

8.  Define the Data Integration Strategies (IKM)

9.  Define the Data Control Strategy

    1.  

        3.  

    ```{=html}
    <!-- -->
    ```
    1.  1.  

        2.  

        3.  1.  #### Insert a New Mapping

To create a new mapping:

1.  In Designer Navigator, expand the Demo project node in the Projects
    accordion.

2.  Expand the Sales Administration node.

3.  In the Sales Administration folder, right-click the Mappings node
    and select **New Mapping**.

4.  Enter the name of your mapping (Load TRG\_SALES) in the Name field.
    Create Empty Dataset should be unchecked.

#### Define the Target Datastore

To insert the target datastore in the Load TRG\_SALES mapping:

1.  Go to the Logical tab of the Mapping Editor.

2.  In the Designer Navigator, expand the Models accordion and the
    > *Sales Administration* model.

3.  Select the TRG\_SALES datastore under the *Sales Administration
    > model* and drag it into the mapping.

    1.  #### Define the Source Datastores

> The Load TRG\_SALES mapping example uses datastores from the *Orders
> Application* model.

To add source datastores to the Load TRG\_SALES mapping:

1.  In the Mapping tab, drag the following source datastores into the
    Source Diagram:

-   SRC\_ORDERS from the *Orders Application* model

-   SRC\_ORDER\_LINES from the *Orders Application* model

***Figure 4-21 Load TRG\_SALES Mapping***

> ![](media/image37.png){width="4.122922134733158in"
> height="2.0445363079615047in"}

#### Define the Order Filter

In this example, only completed orders should be retrieved. A filter
needs to be defined on the SRC\_ORDERS datastore.

**To define the filter:**

1.  In the mapping, select the STATUS column of the SRC\_ORDERS
    datastore and drag it onto the Mapping Diagram.

2.  The filter appears as shown in Figure 4--22.

***\
***

> ***Figure 4--22 Filter on SRC\_ORDERS***
>
> ![](media/image38.png){width="4.608799212598425in"
> height="2.2184733158355208in"}

3.  Select the filter in the Source Diagram to display the filter
    properties in the Property Inspector.

4.  In the Condition tab of the Property Inspector, modify the filter
    rule by typing:

SRC\_ORDERS.STATUS = \'CLO\'

#### Define Joins between the Source Datastores

This section describes how to define joins between the source
datastores. To create the join defined in Table 4--9:

1.  Drag the JOIN component into the mapping from the Components palette

2.  Drag the ORDER\_ID column of the SRC\_ORDERS datastore into the
    JOIN.

3.  Drag the ORDER\_ID column of the SRC\_ORDER\_LINES datastore into
    the JOIN.

A join linking the two datastores appears. This is the join on the order
number. The join has the following expression:
SRC\_ORDERS.ORDER\_ID=SRC\_ORDER\_LINES.ORDER\_ID

#### Define the Transformation Rules

Many of the transformations used for this mapping will use an aggregate
function. These functions are implemented using the AGGREGATE Component.

1.  From the Components palette, drag the AGGREGATE component into the
    > mapping.

2.  ##### Drag the AGGREGATE output connector point to the TRG\_SALES input connector point. This action will start an Automap, selecting OK will backfill the AGGREGATE from the Target attributes.

##### ![](media/image39.png){width="3.2030511811023623in" height="1.5570964566929133in"}![](media/image40.png){width="1.6773173665791776in" height="2.4111570428696414in"}

##### Define the following transformations rules.

Define the following transformation rules in the Aggregate component:

-   **CUST\_ID:** Drag the SRC\_ORDERS.CUST\_ID column into the CUST\_ID
    column in the Aggregate Component. This transformation rule maps the
    CUST\_ID column in your SRC\_ORDERS table to the CUST\_ID column in
    your target table.

-   **PRODUCT\_ID:** Drag the SRC\_ORDER\_LINES.PRODUCT\_ID column into
    the PRODUCT\_ID column in the Aggregate Component. This
    transformation rule maps the PRODUCT\_ID column in your
    SRC\_ORDER\_LINES table to the PRODUCT\_ID column in your target
    table.

-   **FIRST\_ORD\_ID**: Drag the SRC\_ORDERS.ORDER\_ID column into the
    Expression field. Enter the following text in the Expression field:

> MIN(SRC\_ORDERS.ORDER\_ID)
>
> This transformation rule maps the minimum value of the ORDER\_ID
> column in your SRC\_ORDERS table to the FIRST\_ORD\_ID column in your
> target table.

-   **FIRST\_ORD\_DATE**: Drag the SRC\_ORDERS.ORDER\_DATE column into
    the Implementation field. Enter the following text in the Expression
    field:

> MIN(SRC\_ORDERS.ORDER\_DATE)
>
> This transformation rule maps the minimum value of the ORDER\_DATE
> column in your SRC\_ORDERS table to the FIRST\_ORD\_DATE column in
> your target table.

-   **LAST\_ORD\_ID**: Drag-and-drop the SRC\_ORDERS.ORDER\_ID column
    into the Expression field. Enter the following text in the
    Expression field:

> MAX(SRC\_ORDERS.ORDER\_ID)
>
> This transformation rule maps the maximum value of the ORDER\_ID
> column in your SRC\_ORDERS table to the LAST\_ORD\_ID column in your
> target table.

-   **LAST\_ORD\_DATE**: Drag the SRC\_ORDERS.ORDER\_DATE column into
    the Expression field. Enter the following text in the Expression
    field:

> MAX(SRC\_ORDERS.ORDER\_DATE)
>
> This transformation rule maps the maximum value of the ORDER\_DATE
> column in your SRC\_ORDERS table to the LAST\_ORD\_DATE column in your
> target table.

-   **QTY**: Enter the following text in the Expression field:

> SUM(SRC\_ORDER\_LINES.QTY)
>
> This transformation rule maps the sum of the product quantities to the
> QTY column in your target table.

-   **AMOUNT**: Enter the following text in the Expression field:

> SUM(SRC\_ORDER\_LINES.AMOUNT)
>
> This transformation rule maps the sum of the product prices to the
> AMOUNT column in your target table.

-   **PROD\_AVG\_PRICE**: Drag the SRC\_ORDERLINES.AMOUNT column into
    the Expression field. Enter the following text in the Expression
    field:

> AVG(SRC\_ORDER\_LINES.AMOUNT)
>
> This transformation rule maps the average of the product prices to the
> PROD\_ AVG\_PRICE column in your target table.

Review carefully your Aggregate rules and make sure that you have
defined the rules as shown in Figure 4--23 below.

Note that even though this example uses aggregation functions, you do
not have to specify the group by rules: Oracle Data Integrator will
infer that from the mappings, applying SQL standard coding practices.

> ***Figure 4--23 Aggregate Properties***
>
> ![](media/image41.png){width="5.49218394575678in"
> height="2.3953488626421695in"}

[]{#_bookmark87 .anchor}

***Figure 4-24 Mapping logical view***

![](media/image42.png){width="5.145190288713911in"
height="1.8148359580052493in"}

**Setting the Integration Type:**

> Click on the TRG\_SALES datastore in the mapping, in the Properties
> panel under Target set the Integration Type to Incremental Update.

#### Define the Data Loading Strategies (LKM)

In the Physical tab, Oracle Data Integrator indicates the various steps
that are performed when the map is executed.

In the Physical tab you define how to load the result of the orders and
order line aggregates into your target environment with a Loading
Knowledge Module (LKM).

To define the loading strategies:

1.  In the Physical tab of the Mapping Editor, select the source set
    that corresponds to the loading of the order line\'s filtered
    aggregate results. In this example, this is the AGGREGATE\_AP access
    point in the ODI\_DEMO\_TRG\_UNIT.

2.  In the Property Inspector, set the LKM to **LKM SQL to SQL
    (Built-In).GLOBAL** using the LKM Selector list as shown in Figure
    4--26.

> ***Figure 4--25 Physical tab of Load TRG\_SALES Mapping***
>
> ![](media/image43.png){width="4.874390857392826in"
> height="1.597716535433071in"}
>
> ***Figure 4-26 AGGREGATE\_AP Properties, Loading Knowledge Module
> Selection***

![](media/image44.png){width="4.002121609798775in"
height="1.232136920384952in"}

#### Define the Data Integration Strategies (IKM)

After defining the loading phase, you need to define the strategy to
adopt for the integration of the data into the target table.

To define the integration strategies:

1.  In the Physical tab of the Mapping Editor, select the Target object
    (**TRG\_SALES**). The Property Inspector should display the
    properties of the target.

2.  In the Property Inspector, set the IKM to **IKM Oracle Incremental
    > Update** using the IKM Selector list. If this IKM is not in the
    > list, make sure you have correctly set the Target Integration Type
    > to Incremental Update in the Logical panel.

3.  In the knowledge module options, leave the default values.

    1.  #### Define the Data Control Strategy

In [Section 4.2.3.7, \"Define the Data Loading Strategies
(LKM)\"](#_bookmark87) and [Section
4.2.3.8,](#define-the-data-integration-strategies-ikm-1) [\"Define the
Data Integration Strategies
(IKM)\"](#define-the-data-integration-strategies-ikm-1) you have
specified the data flow from the source to the target. You must now
define how to check your data (CKM) and the constraints and rules that
must be satisfied before integrating the data.

To define the data control strategy:

1.  In the Physical tab of the Mapping Editor for the Target, verify
    that the **CKM Oracle** is selected.

***Figure 4--27 Load TRG\_SALES Mapping***

![](media/image45.png){width="5.4380588363954505in"
height="1.8441557305336833in"}

2.  In the Logical tab of TRG\_SALES, select Constraints. Set the
    constraints that you wish to verify to true:

-   PK\_TRG\_SALES

-   FK\_SALES\_CUST

-   FK\_SALES\_PROD

***Figure 4-28 Constraint Definition for TRG\_SALES***

![](media/image46.png){width="5.8371139545056865in"
height="3.766233595800525in"}

3.  From **File** main menu, select **Save**.

The Load **TRG\_SALES** mapping is now ready to be executed.

Implementing Data Quality Control
=================================

This chapter describes how to implement data quality control. An
introduction to data integrity control is provided.

Note: ODI provides very basic quality checks. For complex use cases use
Enterprise Data Quality (EDQ)

This chapter includes the following sections:

-   Section 5.1, \"Introduction to Data Integrity Control\"

-   Section 5.2, \"SRC\_CUSTOMER Control Example\"

5.  

    1.  Introduction to Data Integrity Control
        --------------------------------------

Data integrity control is essential in ensuring the overall consistency
of the data in your information systems applications.

Application data is not always valid for the constraints and declarative
rules imposed by the information system. You may, for instance, find
orders with no customer, or order lines with no product, and so forth.

Oracle Data Integrator provides a working environment to detect these
constraint violations and to store them for recycling or reporting
purposes.

> There are two different types of controls: *Static Control* and *Flow
> Control*. We will examine the differences between the two.

###### Static Control

Static Control implies the existence of rules that are used to verify
the integrity of your application data. Some of these rules (referred to
as constraints) may already be implemented in your data servers (using
primary keys, reference constraints, etc.)

With Oracle Data Integrator, you can enhance the quality of your data by
defining and checking additional constraints, without declaring them
directly in your servers. This procedure is called **Static Control**
since it allows you to perform checks directly on existing - or static -
data.

###### Flow Control

The information systems targeted by transformation and integration
processes often implement their own declarative rules. The **Flow
Control** function is used to verify an application\'s incoming data
according to these constraints before loading the data into these
targets. The flow control procedure is detailed in the \"Mappings\"
chapter.

###### Benefits

The main advantages of performing data integrity checks are the
following:

-   *Increased productivity* by using the target database for its entire
    > life cycle. Business rule violations in the data slow down
    > application programming throughout the target database\'s
    > life-cycle. Cleaning the transferred data can therefore reduce
    > application programming time.

-   *Validation of the target database\'s model*. The rule violations
    > detected do not always imply insufficient source data integrity.
    > They may reveal a degree of incompleteness in the target model.
    > Migrating the data before an application is rewritten makes it
    > possible to validate a new data model while providing a test
    > database in line with reality.

-   *Improved quality of service* for the end-users. Ensuring data
    > integrity is not always a simple task. Indeed, it requires that
    > any data violating declarative rules must be isolated and
    > recycled. This implies the development of complex programming, in
    > particular when the target database incorporates a mechanism for
    > verifying integrity constraints. In terms of operational
    > constraints, it is most efficient to implement a method for
    > correcting erroneous data (on the source, target, or recycled
    > flows) and then to reuse this method throughout the enterprise.

    1.  SRC\_CUSTOMER Control Example
        -----------------------------

This example guides you through the data integrity audit process (Static
Control).

The *Orders Application* contains data that does not satisfy business
rule constraints on a number of different levels. The objective is to
determine which data in this application does not satisfy the
constraints imposed by the information system.

This section includes the following topics:

-   Objective

-   Interpreting the Problem

-   Creating Constraints

-   Run the Static Control

-   Follow the Execution of the Control in Operator Navigator

-   Interpreting the Results in Operator Navigator

5.  

    1.  

    2.  1.  ### Objective

Some data in our source may be inconsistent. There may be constraints in
the target table that are not implemented in the source table or there
may be supplementary rules that you wish to add. In our case we have two
constraints that we want to enforce on the SRC\_CUSTOMER table:

-   **Customers must be over 21 years of age.** However there could be
    > some records corresponding to younger customers in the input
    > table.

-   **The CITY\_ID column must refer to an entry in the SRC\_CITY
    > table.** However there could be some values that do not exist in
    > the city table.

We want to determine which rows do not satisfy these two constraints and
automatically copy the corresponding invalid records into an error table
for analysis.

### Interpreting the Problem

> Enforcing these types of rules requires the use of a *check
> constraint* (also referred to as a *condition*), as well as a
> *reference constraint* between the SRC\_CITY and SRC\_ CUSTOMER
> tables.

### Creating Constraints

This section describes how to create the following constraints:

-   Age Constraint

-   Reference Constraint

5.  []{#_bookmark51 .anchor}

    1.  

    2.  3.  

```{=html}
<!-- -->
```
5.  1.  

    2.  1.  

        2.  

        3.  1.  #### Age Constraint

Creating an age constraints consists in adding a data validity condition
on a column. To create the age constraint:

1.  In the Models accordion in Designer Navigator, expand the *Orders
    > Application* model.

2.  Expand the SRC\_CUSTOMER datastore.

3.  Right-click the Constraints node and select **New Condition** as
    > shown in Figure 5--1.

> ***Figure 5--1 Insert New Condition***
>
> ![](media/image47.png){width="2.3565791776027996in"
> height="1.658646106736658in"}

4.  In the Definition tab of the Condition Editor:

-   In the Name field, enter the name of your condition. For example:
    > AGE \> 21.

-   From the Type list, select **Oracle Data Integrator Condition**.

-   In the Where clause field, enter the following SQL code:

> SRC\_CUSTOMER.AGE \> 21
>
> **Note:**

-   You can enter this text directly in the Where clause field or you
    > can use the Expression Editor. To open the Expression Editor click
    > **Launch the expression editor** in the Where clause toolbar menu.

-   The constraints created by Oracle Data Integrator are not actually
    > created on the database. The constraints are stored in the
    > Repository.

```{=html}
<!-- -->
```
-   In the Message field, specify the error message as it will appear in
    your error table:

> Customer age is not over 21!

Figure 5--2 shows the Condition Editor.

> ***Figure 5--2 Condition Editor***
>
> ![](media/image48.png){width="3.960442913385827in"
> height="2.539417104111986in"}

5.  From the File main menu, select **Save** to save the condition.

    1.  #### Reference Constraint

This section describes how to create a reference constraint based on the
CITY\_ID column between the SRC\_CUSTOMER table and the SRC\_CITY table.

This constraint allows checking that customers are located in a city
that exists in the SRC\_CITY table.

To create the reference constraint:

1.  In the Models accordion in Designer Navigator, expand the *Orders
    > Application* model.

2.  Expand the SRC\_CUSTOMER datastore.

3.  Right-click the Constraints node and select **New Reference** as
    > shown in Figure 5--3.

> ***Figure 5--3 Insert New Reference***
>
> ![](media/image49.png){width="3.625in" height="2.59375in"}

4.  In the Definition tab of the Reference Editor:

-   From the Type list, select **User Reference**.

-   From the Model list in the Parent Model/Table section, select
    > **Orders Application**. This is the data model containing the
    > table you want to link to.

-   From the Table list, select **SRC\_CITY**. This is the table you
    > want to link to.

Figure 5--4 shows the Reference Editor.

> ***Figure 5--4 Reference Editor***
>
> ![](media/image50.png){width="5.729166666666667in"
> height="2.2395833333333335in"}

5.  In the Reference Editor, go to the Attributes tab.

6.  On the Columns tab, click **Add** as shown in Figure 5--5.

> ***Figure 5--5 Columns tab of the Reference Editor***
>
> ![](media/image51.png){width="5.758388013998251in"
> height="1.3896106736657918in"}

A new row is inserted in the columns table.

7.  In this step you define the matching columns:

-   Click on the row that appears. This will bring up a drop-down list
    > containing all of the columns in the appropriate table.

-   From the Columns (Foreign Table) list, select **CITY\_ID**.

-   From the Columns (Primary Table) list, select **CITY\_ID**.

Figure 5--6 shows the Columns tab of the Reference Editor with the
selected matching columns.

> ***Figure 5--6 Columns tab of the Reference Editor with matching
> columns***
>
> ![](media/image52.png){width="5.740277777777778in"
> height="1.3506944444444444in"}

Note that in this example the Foreign Table is SRC\_CUSTOMER and the
Primary Table is SRC\_CITY. Note also that it is not required for
foreign keys that the column names of the Foreign Table and the Primary
Table match. It just happens that they do in this example.

8.  Select **File** \> **Save** to save this reference.

**Tip:** You can alternately use the \[CTRL - S\] shortcut to save the
current Editor.

### Run the Static Control

Running the static control verifies the constraints defined on a
datastore. You can now verify the data in the SRC\_CUSTOMER datastore
against the constraints defined in [Section 5.2.3, \"Creating
Constraints\"](#creating-constraints).

To run the static control:

1.  In the Models accordion in Designer Navigator, right-click the
    SRC\_CUSTOMER datastore.

2.  Select **Control** \> **Check**.

3.  The Execution dialog is displayed as shown in Figure 5--7.

> ***Figure 5--7 Execution Dialog***
>
> ![](media/image53.png){width="3.0104166666666665in"
> height="2.2708333333333335in"}

4.  Click **OK** in the Execution dialog.

5.  The Information Dialog is displayed as shown in Figure 5--8.

> ***Figure 5--8 Information Dialog***
>
> ![](media/image54.png){width="2.8541666666666665in" height="1.4375in"}

6.  Click **OK** in the Information Dialog.

Oracle Data Integrator automatically generates all of the code required
to check your data and start an execution session.

### Follow the Execution of the Control in Operator Navigator

Through Operator Navigator, you can view your execution results and
manage your development executions in the sessions.

To view the execution results of your control:

1.  In the Session List accordion in Operator Navigator, expand the All
    > Executions node.

The Session List displays all sessions organized per date, physical
agent, status, keywords, and so forth.

2.  Refresh the displayed information clicking **Refresh** in the
    > Operator Navigator toolbar.

The log for one execution session appears as shown in Figure 5--9.

> ***Figure 5--9 Session List in Operator Navigator***
>
> ![](media/image55.png){width="4.298611111111111in"
> height="2.765972222222222in"}

The log comprises 3 levels:

-   Session (corresponds to an execution of a scenario, a mapping, a
    > package or a procedure undertaken by an execution agent)

-   Step (corresponds to a checked datastore, a mapping, a procedure or
    > a step in a package or in a scenario)

-   Task (corresponds to an elementary task of the mapping, process or
    > check)

    1.  ### Interpreting the Results in Operator Navigator

This section describes how to determine the invalid records. These are
the records that do not satisfy the constraints and has been rejected by
the static control.

This section includes the following topics:

-   [Determining the Number of Invalid Records](#_bookmark56)

-   [Reviewing the Invalid Records](#reviewing-the-invalid-records)

    3.  []{#_bookmark56 .anchor}

    4.  

    5.  

    ```{=html}
    <!-- -->
    ```
    1.  

    2.  

    3.  1.  #### Determining the Number of Invalid Records

To determine the number of invalid records:

1.  In the Session List accordion in Operator Navigator, expand the All
    Executions node and the SRC\_CUSTOMER session.

2.  Double-click the SRC\_CUSTOMER step to open the Session Step Editor.

3.  The Record Statistics section details the changes performed during
    the static control. These changes include the number of inserts,
    updates, deletes, errors, and the total number of rows handled
    during this step.

[Figure 5--10](#_bookmark57) shows the Session Step Editor of the
SRC\_CUSTOMER step.

> []{#_bookmark57 .anchor}***Figure 5--10 SRC\_CUSTOMER Session Step
> Editor***
>
> ![](media/image56.png){width="5.565862860892389in"
> height="2.9220778652668415in"}

The number of invalid records is listed in the No. of Errors field. Note
that the static control of the SRC\_CUSTOMER table has revealed **6**
invalid records. These records have been isolated in an error table. See
[Section 5.2.6.2, \"Reviewing the](#reviewing-the-invalid-records)
[Invalid Records\"](#reviewing-the-invalid-records) for more
information.

#### Reviewing the Invalid Records

You can access the invalid records by right-clicking on the table in
your model and selecting **Control** \> **Errors\...**

To review the error table of the static control on the SRC\_CUSTOMER
table:

1.  In Designer Navigator, expand the *Orders Application* model.

2.  Right-click the SRC\_CUSTOMER datastore.

3.  Select **Control** \> **Errors\...**

4.  The Error Table Editor is displayed as shown in Figure 5--11.

> ***Figure 5--11 Error Table of SRC\_CUSTOMER Table***
>
> ![](media/image57.png){width="6.59375in"
> height="1.4791666666666667in"}

The records that were rejected by the check process are the following:

-   **5** records in violation of the AGE \> 21 constraint (the actual
    > age of the customer is 21 or younger, see the AGE column for
    > details).

-   **1** record in violation of the FK\_CITY\_CUSTOMER constraint (The
    > CITY\_ID value does not exist in the SRC\_CITY table).

You can view the entire record in this Editor. This means that you can
instantly see which values are incorrect, for example the invalid
CITY\_ID value in the top record.

Note that the error message that is displayed is the one that you have
defined when setting up the AGE \> 21 constraint in [Section 6.2.3.1,
\"Age Constraint\"](#_bookmark51).

Now that the static controls have been run on the source data, you are
ready to move on to the implementation of mappings.

Working with Packages
=====================

This chapter describes how to work with Packages in Oracle Data
Integrator. The *Load Sales Administration* package is used as an
example. An introduction to Packages and automating data integration
between applications is provided.

This chapter includes the following sections:

-   Section 6.1, \"Introduction\"

-   Section 6.2, \"Load Sales Administration Package Example\"

6.  

    1.  Introduction
        ------------

This section provides an introduction to automating data integration
using packages in Oracle Data Integrator.

6.  

    1.  1.  ### Automating Data Integration Flows

The automation of the data integration is achieved by sequencing the
execution of the different steps (mappings, procedures, and so forth) in
a package and by producing a production scenario containing the
ready-to-use code for each of these steps.

This chapter describes how to sequence the execution of the different
steps. How to produce the production scenario is covered in Chapter 8,
\"Deploying Integrated
[Applications\"](#deploying-integrated-applications).

### Packages

A *Package* is made up of a sequence of steps organized into an
execution diagram. Packages are the main objects used to generate
scenarios for production. They represent the data integration workflow
and can perform, for example, the following jobs:

-   Start a reverse-engineering process on a datastore or a model

-   Send an email to an administrator

-   Download a file and unzip it

-   Define the order in which mappings must be executed

-   Define loops to iterate over execution commands with changing
    > parameters

In this Getting Started exercise, you will load your *Sales
Administration* application using a sequence of mappings. Since
referential constraints exist between tables of this application, you
must load target tables in a predefined order. For example, you cannot
load the TRG\_CUSTOMER table if the TRG\_CITY table has not been loaded
first.

In the Section 6.2, \"Load Sales Administration Package Example\", you
will create and run a package that includes mappings that are included
in the Demo project and mappings that you've created in Chapter 5,
\"Working with Mappings\".

#### Scenarios

6.  

    1.  3.  

        4.  

        5.  

        6.  

        7.  1.  
            2.  

A *scenario* is designed to put source components (mapping, package,
procedure, variable) into production. A scenario results from the
generation of code (SQL, shell, and so forth) for this component.

Once generated, the code of the source component is frozen and the
scenario is stored inside the Work repository. A scenario can be
exported and then imported into different production environments.

**Note:** Once generated, the scenario\'s code is frozen, and all
subsequent modifications of the package and/or data models which
contributed to its creation will not affect it. If you want to update a
scenario - for example because one of its mappings has been changed -
then you must generate a new version of the scenario from the package or
regenerate the existing scenario.

> See \"Working with Scenarios\" in the *Oracle Fusion Middleware
> Developer\'s Guide for Oracle Data Integrator* for more information.

In Chapter 8, \"Deploying Integrated Applications\", you will generate
the *LOAD\_ SALES\_ADMINISTRATION* scenario from a package and run this
scenario from Oracle Data Integrator Studio.

Load Sales Administration Package Example
-----------------------------------------

This section contains the following topics:

-   Purpose

-   Developments Provided with Oracle Data Integrator

-   Problem Analysis

-   Creating the Package

    1.  

        1.  ### Purpose

The purpose of the Load Sales Administration package is to define the
complete workflow for the loading of the Sales Administration
application and to set the execution sequence.

### Mappings Provided with Oracle Data Integrator

The demo repository is delivered with a number of Mappings. The Demo
project now contains the following objects as shown in Figure 6--1:

**Seven Mappings:**

-   **Load TRG\_CITY**: a mapping that populates the TRG\_CITY table.
    > This mapping is delivered with the demo repository.

-   **Load TRG\_COUNTRY**: a mapping that populates the TRG\_COUNTRY
    > table.

This mapping is delivered with the demo repository.

-   **Load TRG\_CUSTOMER**: a mapping that populates the TRG\_CUSTOMER
    > table. This mapping is created in Section 5.1, \"Load
    > TRG\_CUSTOMER Mapping [Example\"](#_bookmark61).

-   **Load TRG\_PRODUCT**: a mapping populates the TRG\_PRODUCT table.
    > This mapping is delivered with the demo repository.

-   **Load TRG\_PROD\_FAMILY**: a mapping that populates the TRG\_PROD\_
    > FAMILY table. This mapping is delivered with the demo repository.

-   **Load TRG\_REGION**: a mapping that populates the TRG\_REGION
    > table. This mapping is delivered with the demo repository.

-   **Load TRG\_SALES**: a mapping that populates the TRG\_SALES table.
    > This mapping is created in Section 5.2, \"Load TRG\_SALES Mapping
    > Example\".

**One procedure:**

> The **Delete Targets** procedure empties all of the tables in the
> *Sales Administration*

application. This operation is performed by using a *Delete* statement
on each table.

> ***Figure 6--1 Demo Project***
>
> ![](media/image58.png){width="2.5972222222222223in"
> height="3.2729166666666667in"}

### Problem Analysis

In order to load the *Sales Administration* application correctly (in
accordance with the referential integrity constraints), the tasks must
be executed in the following order:

1.  Empty the Sales Administration tables with the Delete Targets
    procedure

2.  Load the TRG\_COUNTRY table with the Load TRG\_COUNTRY mapping

3.  Load the TRG\_REGION table with the Load TRG\_REGION mapping

4.  Load the TRG\_CITY table with the Load TRG\_CITY mapping

5.  Load the TRG\_PROD\_FAMILY table with the Load TRG\_PROD\_FAMILY
    mapping

6.  Load the TRG\_PRODUCT table with the Load TRG\_PRODUCT mapping

7.  Load the TRG\_CUSTOMER table with the Load TRG\_CUSTOMER mapping

8.  Load the TRG\_SALES table with the Load TRG\_SALES mapping

Such an integration process is built in Oracle Data Integrator in the
form of a Package.

### Creating the Package

This section describes how to create the Load Sales Administration
Package. To create the Load Sales Administration Package perform the
following steps:

1.  Create a New Package

2.  Insert the Steps in the Package

3.  Define the Sequence of Steps in the Package

    1.  #### Create a New Package

To create a new Package:

1.  In Designer Navigator, expand the Demo project node in the Projects
    accordion.

2.  Expand the Sales Administration node.

3.  In the Sales Administration folder, right-click the Packages node
    and select **New Package** as shown in Figure 6--2.

> ***Figure 6--2 Insert New Package***
>
> ![](media/image59.png){width="2.9090277777777778in" height="2.0in"}

The Package Editor is started.

4.  Enter the name of your Package 'Load Sales Administration' in the
    Name field.

    1.  #### Insert the Steps in the Package

To insert the steps in the Load Sales Administration Package:

1.  Select the following components one by one from the Projects
    accordion and drag-and-drop them into the diagram:

-   Delete Targets (Procedure)

-   Load TRG\_COUNTRY

-   Load TRG\_REGION

-   Load TRG\_CITY

-   Load TRG\_CUSTOMER

-   Load TRG\_PROD\_FAMILY

-   Load TRG\_PRODUCT

-   Load TRG\_SALES

These components are inserted in the Package and appear as steps in the
diagram. Note that the steps are not sequenced yet.

#### Define the Sequence of Steps in the Package

Once the steps are created, you must reorder them into a data processing
chain. This chain has the following rules:

-   It starts with a unique step defined as the *First Step*.

-   Each step has two termination states: Success or Failure.

-   A step in failure or success can be followed by another step, or by
    > the end of the Package.

-   In case of failure, it is possible to define a number of retries.

A Package has one entry point, the First Step, but several possible
termination steps. The Load Sales Administration Package contains only
steps on Success.

###### Defining the First Step

To define the first step in the Load Sales Administration Package:

**Note:** If you have dragged and dropped the Package components in the
order defined in Section 6.2.4.2, \"Insert the Steps in the Package\",
the Delete Target procedure is already identified as the first step and
the first step symbol is displayed on the step\'s icon. If this is the
case, define the next steps on success.

1.  Select and right-click the *Delete Target* procedure step.

2.  Select **First Step** from the contextual menu. A small green arrow
    > appears on this step.

###### Defining the Next Steps on Success

To define the next steps on success:

1.  In the Package toolbar tab, select **Next Step on Success**.

> ![](media/image60.png){width="0.21666666666666667in"
> height="0.24166666666666667in"}

2.  Select the Delete Targets step.

3.  Keep the mouse button pressed and move the cursor to the icon of the
    step that must follow in case of a success (here the Load
    TRG\_COUNTRY step) and release the mouse button.

A green arrow representing the success path between the steps, with an
ok label on it appears.

4.  Repeat this operation to link all your steps in a success path
    sequence. This sequence should be:

-   Delete Targets (First Step)

-   Load TRG\_COUNTRY

-   Load TRG\_REGION

-   Load TRG\_CITY

-   Load TRG\_CUSTOMER

-   Load TRG\_PROD\_FAMILY

-   Load TRG\_PRODUCT

-   Load TRG\_SALES

The resulting sequence appears in the Package diagram as shown in Figure
6--3.

> ***Figure 6--3 Load Sales Administration Package Diagram***
>
> ![](media/image61.png){width="5.720639763779528in"
> height="3.2089741907261593in"}

5.  From the File main menu, select **Save**. The package is now ready
    to be executed.

Executing Your Developments and Reviewing the Results
=====================================================

This chapter describes how to execute the Load Sales Administration
Package you have created in Chapter 6, \"Working with Packages\" and the
mappings Load TRG\_CUSTOMER and Load TRG\_SALES you have created in
[Chapter 4,](#working-with-mappings) \"Working with Mappings\". This
chapter also describes how to follow the execution and how to interpret
the execution results.

This chapter includes the following sections:

-   Section 7.1, \"Executing the Load Sales Administration Package\"

-   [Section 7.2, \"Executing the Load TRG\_SALES
    > Mapping\"](#_bookmark114)

7.  

    1.  Executing the Load Sales Administration Package
        -----------------------------------------------

This section contains the following topics:

-   Run the Package

-   Follow the Execution of the Package in Operator Navigator

-   Interpreting the Results of the Load TRG\_CUSTOMER Session Step

7.  []{#_bookmark107 .anchor}

    1.  1.  ### Run the Package

To run the Load Sales Administration Package:

1.  In Designer Navigator, expand the Packages node under the Sales
    Administration node.

2.  Select the Load Sales Administration Package.

3.  Right-click and select **Run**.

4.  In the Run Dialog, leave the default settings and click **OK**.

5.  The Session Started Information Dialog is displayed. Click **OK**.

Oracle Data Integrator now starts an execution session.

### Follow the Execution of the Package in Operator Navigator

Through Operator Navigator, you can view your execution results and
manage your development executions in the sessions.

To view the execution results of the Load Sales Administration Package:

1.  In the Session List accordion in Operator Navigator, expand the All
    > Executions node.

2.  Refresh the displayed information by clicking **Refresh** in the
    > Operator Navigator toolbar. The Refresh button is:
    > ![](media/image62.png){width="0.2708333333333333in"
    > height="0.2604166666666667in"}

3.  The log for the execution session of the Load Sales Administration
    > Package appears as shown in Figure 7--1.

> ***Figure 7--1 Load Sales Administration Package Session Log***
>
> ![](media/image63.png){width="3.57502624671916in"
> height="2.831169072615923in"}

### Interpreting the Results of the Load TRG\_CUSTOMER Session Step

This section describes how to determine the invalid records detected by
the Load TRG\_ CUSTOMER mapping. These are the records that do not
satisfy the constraints and have been rejected by the flow control of
the Load TRG\_CUSTOMER mapping.

This section includes the following topics:

-   Determining the Number of Processed Records

-   Viewing the Resulting Data

-   Reviewing the Invalid Records and Incorrect Data

-   Correcting Invalid Data

-   Review the Processed Records

    1.  #### Determining the Number of Processed Records

To determine the number of records that have been processed by the Load
TRG\_ CUSTOMER mapping (this is the number of inserts, updates, deletes,
and errors):

1.  In the Session List accordion in Operator Navigator, expand the All
    > Executions node.

2.  Refresh the displayed information clicking **Refresh** in the
    > Operator Navigator toolbar menu.

3.  Expand the Load Sales Administration Package Session and open the
    > Session Step Editor for the Load TRG\_CUSTOMER step. This is
    > step 4.

4.  On the Definition tab of the Session Step Editor, you can see in the
    > Record Statistics section that the loading of the TRG\_CUSTOMER
    > table produced 31 inserts and isolated 2 errors in an error table.

**[Note:]{.underline}** Your individual results may vary. This is fine
as long as the overall execution is successful.

Figure 7--2 shows the Record Statistics section of the Session Step
Editor:

> ***Figure 7--2 Record Statistics in the Session Step Editor***
>
> ![](media/image64.png){width="4.688194444444444in"
> height="1.1819444444444445in"}

#### Viewing the Resulting Data

In this example, the resulting data are the 31 rows that have been
inserted in the TRG\_ CUSTOMER table during the mapping run.

To view the data resulting of your mapping run:

1.  In Designer Navigator, expand the Models accordion and the *Sales
    > Administration* model.

2.  Select the TRG\_CUSTOMER datastore.

3.  Right-click and select **View Data** to view the data in the target
    > table.

Note that you can also select **Data\...** to view and edit the data of
the target table. The View Data Editor is displayed as shown in Figure
7--3.

> ***Figure 7--3 View Data Editor***
>
> ![](media/image65.png){width="5.804747375328084in"
> height="1.6603827646544183in"}

#### Reviewing the Invalid Records and Incorrect Data

You can access the invalid records by right-clicking on the datastore in
your model and selecting **Control** \> **Errors\...**

To review the error table of the TRG\_CUSTOMER datastore:

1.  In Designer Navigator, expand the *Sales Administration* model.

2.  Select the TRG\_CUSTOMER datastore.

3.  Right-click and select **Control** \> **Errors\...**

4.  The Error Table Editor is displayed as shown in Figure 7--4.

> ***Figure 7--4 Error Table of TRG\_CUSTOMER***
>
> ![](media/image66.png){width="5.4883727034120735in"
> height="0.5541699475065617in"}

The mapping that you have executed has identified and isolated **2**
invalid records in an error table that was automatically created for
you.

In this error table, you can see that the mapping rejected:

-   **R**ecords that did not satisfy the FK\_CUST\_CITY constraint (for
    example, the CITY\_ID value does not exist in the table of cities
    TRG\_CITY table).

You can use the ODI\_CHECK\_DATE field to identify the records rejected
for your latest execution.

The invalid records were saved into an error table and were not
integrated into the target table.[]{#_bookmark114 .anchor}

Deploying Integrated Applications
=================================

This chapter describes how to run the Load Sales Administration Package
in a production environment.

This chapter includes the following sections:

-   Section 8.1, \"Introduction\"

-   Section 8.2, \"Scenario Creation\"

-   Section 8.3, \"Run the Scenario\"

-   Section 8.4, \"Follow the Execution of the Scenario\"

8.  

    1.  Introduction
        ------------

The automation of the data integration flows is achieved by sequencing
the execution of the different steps (mappings, procedures, and so
forth) in a package and by producing a production scenario containing
the ready-to-use code for each of these steps.

Chapter 6, \"Working with Packages\" describes the first part of the
automation process: sequencing the execution of the different processes
in a Package.

This chapter describes the second part: how to produce a scenario that
runs automatically the Load Sales Administration Package in a production
environment.

Scenario Creation
-----------------

To generate the LOAD\_SALES\_ADMINISTRATION scenario that executes the
Load Sales Administration Package:

1.  In the Project accordion, expand Sales Administration and then
    > Packages.

2.  Right click on Load Sales Administration and select **Generate
    > Scenario...** The New Scenario dialog appears as shown in Figure
    > 8--1.

> ***Figure 8--1 New Scenario Dialog***
>
> ![](media/image67.png){width="4.0in" height="1.7395833333333333in"}

3.  The Name and Version fields of the Scenario are preset. Leave these
    > values and click **OK**.

4.  Oracle Data Integrator processes and generates the scenario. The new
    > scenario appears on the Scenarios tab of the Package Editor and in
    > the Demo Project as shown in Figure 8--2.

> ***Figure 8--2 LOAD\_SALES\_ADMINISTRATION Scenario***
>
> ![](media/image68.png){width="5.804747375328084in"
> height="2.086476377952756in"}

Run the Scenario
----------------

Scenarios can be executed in several ways:

-   Executing a Scenario from ODI Studio

-   Executing a Scenario from a Command Line

-   Executing a Scenario from a Web Service.

> This Getting Started describes how to execute a scenario from ODI
> Studio. See \"Executing a Scenario\" in the *Oracle Fusion Middleware
> Developer\'s Guide for Oracle Data Integrator* for more information
> about how to execute a scenario from a command line and a web service.

9.  

    1.  
    2.  

```{=html}
<!-- -->
```
8.  1.  

    2.  

    3.  1.  ### Executing a Scenario from ODI Studio

> You can start a scenario from Oracle Data Integrator Studio from
> Designer or Operator Navigator.

To start the LOAD\_SALES\_ADMINISTRATION scenario from Oracle Data
Integrator Studio:

1.  Select the LOAD\_SALES\_ADMINISTRATION scenario in the Projects
    > accordion (in Designer Navigator) or the Load Plans and Scenarios
    > accordion (in Designer and Operator Navigator).

2.  Right-click, then select **Run**.

3.  In the Execution Dialog, leave the default settings and click
    > **OK**.

4.  The Session Started Information Dialog is displayed. Click **OK**.
    > The scenario is executed.

Follow the Execution of the Scenario
------------------------------------

You can review the scenario execution in Operator Navigator, and find
the same results as those obtained when the package was executed as
described in [Section 7.1.1,](#_bookmark107) \"Run the Package\".

It is also possible to review the scenario execution report in Designer
Navigator.

To view the execution results of the LOAD\_SALES\_ADMINISTRATION
scenario in Designer Navigator:

1.  In the Projects accordion in Designer Navigator, expand the
    > Scenarios node under the Load Sales Administration package.

2.  Refresh the displayed information by clicking **Refresh** in the
    > Designer Navigator toolbar menu.

3.  The log for the execution session of the LOAD\_SALES\_ADMINISTRATION
    > scenario appears as shown in Figure 8--3.

> ***Figure 8--3 LOAD\_SALES\_ADMINISTRATION Scenario Session Log***
>
> ![](media/image69.png){width="5.23778324584427in"
> height="2.6744181977252843in"}

Summary
=======

This chapter provides information for going further with Oracle Data
Integrator. This chapter includes the following sections:

-   Section 9.1, \"Summary\"

9.  

    1.  Summary
        -------

Congratulations! You have now completed an ETL project and learned about
the fundamentals of Oracle Data Integrator.

In this Getting Started guide, you learned how to:

-   Create mappings to load the data from the *Orders Application* and
    > *Parameters* applications into the *Sales Administration* data
    > warehouse (Chapter 4, \"Working with Mappings\")

-   Define and implement data integrity rules in the *Orders
    > Application* application (Chapter 5, \"Implementing Data Quality
    > Control\")

```{=html}
<!-- -->
```
-   Sequence your developments (Chapter 6, \"Working with Packages\")

-   Prepare your process for deployment (Chapter 8, \"Deploying
    > Integrated [Applications\"](#deploying-integrated-applications))

    1.  ### Getting Started Tutorial Solution

9.  

    1.  

Refer to the folder "Sales Administration Demo" for solution to the ETL
project.
