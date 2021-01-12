# Mapping 2 - Joins

## Introduction

This chapter describes how to work with mappings in Oracle Data Integrator. 

Estimated Lab time: 60 minutes

### Objective

The demonstration environment includes several example mappings. In this chapter you will learn how to create the following mappings:

  * Load TRG\_PRODUCT: This mapping loads the data from the SRC\_PRODUCT, TRG\_PROD\_FAMILY table in the *Orders Application*, *Sales Administration* model into the TRG\_PRODUCT target table in the *Sales Administration* model.


### Prerequisites
An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account  

## **STEP  1:**  Load TRG\_PRODUCT Mapping Example

1. Purpose and Integration Requirements
The purpose of the Load TRG\_PRODUCT mapping is to load the data from the SRC\_PRODUCT table in the *Orders Application* model into the TRG\_PRODUCT target table in the *Sales Administration* model.

However, the SRC\_PRODUCT table does not contain all of the data that is required for this operation. The following information has to be added to the target table:

  * The family id (FAMILY\_ID) that is defined in the TRG\_PROD\_FAMILY table in the *Sales Administration* model corresponds to the family id attribute in the source table.
  
The functional details for these rules and the procedure to follow are described later in this lab.

2. Mapping Definition
This section describes the mapping Load TRG\_PRODUCT that will be created in this example. See *Creating the Mapping* for more information.

The Load TRG\_PRODUCT mapping uses the following data and transformations:
  * One target datastore. Details:

| Model                 | Datastore     | Description |  Type        |
|-----------------------|---------------|-------------|--------------|
| Sales Administration  | TRG\_PRODUCT  |             | Oracle Table |

  * Two source datastores:

| Model                 | Datastore         | Description |  Type        |
|-----------------------|-------------------|-------------|--------------|
| Orders Application    | SRC\_CUSTOMER     | Customers in the source system | Oracle Table |
| Sales Administration  | TRG\_PROD\_FAMILY | Prod Family table in Target system | Oracle Table |

  * One Join:

| Join                  | Description                                | SQL RULE                   |
|-----------------------|--------------------------------------------|----------------------------|
| Product and product family | Join SRC\_PRODUCT and TRG\_PROD\_FAMILY | SRC\_PRODUCT.FAMILY_NAME = TRG\_PRODUCT.FAMILY\_NAME |

  * One **Distinct** table:

| Distinct                   | Description   | SQL RULE                                                        |
|--------------------------|---------------------------------------------|-----------------------------------|
| Joiner Output  | This component is used to eliminate duplicates | NA  |


## **STEP  2:** Creating the Mapping

This section describes how to create the Load TRG\_PRODUCT mapping. To create the Load TRG\_PRODUCT mapping perform the following procedure:
1. Insert a New Mapping

To create a new mapping:
   1. In Designer Navigator, expand the Demo project node in the Projects accordion.
   2. Expand the Sales Administration node.
   3. In the Sales Administration folder, right-click the Mapping node and select **New Mapping**:

  ![](./images/new_mapping.png)

  4. Enter the name of your mapping (Load TRG\_PROD\_FAMILY) in the Name field:

  ![](./images/mapping_name.png)

 Ensure the *Create Empty Dataset* option is not selected.

  5. An empty mapping window will appear on screen.

## **STEP  3:** Define the Target

The target is the element that will be loaded by the mapping.

**To insert the target in the Load TRG\_PRODUCT mapping:**

1.  Verify you are in the Logical tab of the Mapping Editor.

2.  In the Designer Navigator, expand the Models accordion and the *Sales Administration* model.

3.  Select TRG\_CUSTOMER datastore under the *Sales Administration* model and drag it into the mapping editor

  ![](./images/models_tgt.png)

## **STEP  4:** Define the Source

The source datastores contain data used to load the target datastore. Two types of datastores can be used as a mapping source: datastores from the models and reusable mappings. This example uses datastores from the *Orders Application* and *Sales Administration* models.

**To add source datastores to the Load TRG\_PRODUCT mapping:**

1.  Under models, drag the following source datastores into the Source Diagram:

  * SRC\_PRODUCT from the *Orders Application* model
  * TRG\_PROD\_FAMILY from the *Sales Administration* model

  ![](./images/models_src.png)

2.  The Mapping should look like:

  ![](./images/mapping_1.png)


## **STEP  5:** Define the Join between the Source Datastores and use Distinct

This section describes how to define a join between the source datastores and use distinct. To create the join defined in Step 1 above and remove duplicates:

1.  Drag the JOIN, Distinct component into the mapping.

  ![](./images/mapping_2.png)

2.  In the mapping, drag the FAMILY\_NAME column from the SRC\_PRODUCT datastore into the JOIN.

3.  In the mapping, drag the FAMILY\_NAME column from the TRG\_PROD\_FAMILY datastore into the join.

4. Now drag the Join output to the input of DISTINCT component. Also, the output of distinct component to target table (TRG\_PRODUCT). In attribute matching box, select default option and click "OK".

  ![](./images/attribute_match.png)

5. Click on join component and provide the expression as given below.

  ````
  <copy>
    SRC_PRODUCT.FAMILY_NAME=TRG_PROD_FAMILY.FAMILY_NAME
  </copy>
  ````

  ![](./images/mapping_3.png)

***Source Diagram of the Load TRG\_PRODUCT Mapping with a join and a distinct***

  ![](./images/mapping_4.png)

## **STEP  6:** Define the Target Integration Type

The target table integration type is defined in this section. These are mainly of two types.

  * Control Append - To append data to target tables. All the records are considered as inserts.
  
  * Incremental Update - To update the existing data and insert new data. 

We will use control append for this mapping.

1.  Select the target table. Go to target tab in the properties section and change the integration type to control append.

  ![](./images/mapping_5.png)


## **STEP  7:** Define the Data Loading Strategies (LKM)

The data loading strategies are defined in the Physical tab of the Mapping Editor. Oracle Data Integrator automatically computes the flow depending on the configuration in the mapping's diagram. It proposes default Knowldege Modules (KMs) for the data flow. The Physical tab enables you to view the data flow and select the KMs used to load and integrate data.

Loading Knowledge Modules (LKM) are used for loading strategies and Integration Knowledge Modules (IKM) are used for integration strategies.

You have to define the way to retrieve the data from the SRC\_PRODUCT, TRG\_PROD_FAMILY tables.

To define the loading strategies:

1.  In the Physical tab of the Mapping Editor, select the access point that corresponds to the loading of the SRC\_PRODUCT, TRG\_PROD\_FAMILY . In this example, this is the SRC\_PRO. The Property Inspector should display the properties of the access points.

2.  In the Property Inspector, verify that the **LKM SQL to SQL (Built-In)** is selected in the Loading Knowledge Module Selector list:

  ![](./images/load_knowledge_module.png)


## **STEP  8:** Define the Data Integration Strategies (IKM)

After defining the loading phase, you need to define the strategy to adopt for the integration of the data into the target table.

To define the integration strategies:

1.  In the Physical tab of the Mapping Editor, select TRG\_PRODUCT in the TARGET\_GROUP object. The Property Inspector will display the properties of the target.

2.  In the Property Inspector, set the IKM to **IKM Oracle Insert.GLOBAL** in the *Integration Knowledge Module* Selector list. If this IKM is not in the list, make sure you have correctly set the  Target Integration Type to control append in the Logical panel.

3.  In the knowledge module options, leave the default values. The Property Inspector appears as shown:

  ![](./images/integration_knowledge_module.png)

**Note:** Only the built-in Knowledge Modules or the ones you imported to your Project appear in the KM Selector lists. The demonstration environment already includes the Knowledge Modules required for the getting started examples. You do not need to import KMs into the demonstration Project.For more information on importing KMs into your Projects, see *Importing a KM* in the *Oracle Fusion Middleware Developer's Guide for Oracle Data Integrator*.

## **STEP  9:** Define the Data Control Strategy

In the preceeding steps you have specified the data flow from the source to the target. You must now define how to check your data (CKM) and the constraints and rules that must be satisfied before integrating the data.

To define the data control strategy:

1.  In the Mapping Physical tab under the TRG\_PRODUCT Properties, select Check Knowledge Module, verify that the **CKM Oracle** is selected for Check Knowledge Module.

2.  In the Logical view, select the target datastore TRG\_PRODUCT and verify the Constraints panel. Set the constraints that you wish to verify to true.

  * PK\_TRG\_PRODUCT

The Constraints tab appears as shown:

  ![](./images/constraints.png)

3.  From **File** main menu, select **Save**.

The Load TRG\_PRODUCT mapping is now ready to be run.

## **STEP  10:** Run the Mapping

1. In the logical section, click on Data to see the data in the table.

  ![](./images/job_preview_data.png)

2. You can close the editor and click on Run icon to execute the mapping.
  
  ![](./images/run_icon.png)

3. Run box will appear on screen. Click "OK".

  ![](./images/run_box.png)

4. Session started message will appear on screen. Click "OK".

  ![](./images/session_started.png)

5. Go to operator tab and check the status of the job.

  ![](./images/operator.png)

6. Verify the data in target table as we did in step 1.
  
  ![](./images/data_post_run.png)


You may proceed to the next lab.


## Acknowledgements

- **Author** - Narayanan Ramakrishnan, December 2020
 - **Contributors** - Srivishnu Gullapalli
 - **Last Updated By/Date** - Narayanan Ramakrishnan, December 2020

## Need Help?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
