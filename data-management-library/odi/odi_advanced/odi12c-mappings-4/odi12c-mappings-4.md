# Mapping 4 - Split and Sort

## Introduction

This chapter describes how to create a single mapping with multiple targets. 

Estimated Lab time: 60 minutes

#### Objectives

In this chapter you will learn how to create the following mapping:

  * Load REGION: In this mapping we create three tables TRG\_CITY\_NAM, TRG\_CITY\_EURO, TRG\_CITY\_APAC using the same structure as TRG\_CITY table in the *Sales Administration* model. Using a single mapping, split the data by continent(North America, Europe, Asia Pacific) and sort based on Population.


### Prerequisites
An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## **STEP  1:** Load REGION Mapping Description

This section contains the following topics:

-   Purpose 

-   Mapping Definition


1. Purpose 

The purpose of this mapping is to create three tables TRG\_CITY\_NAM, TRG\_CITY\_EURO, TRG\_CITY\_APAC using the same structure as TRG\_CITY table in the *Sales Administration* model and split and sort the data into those three datastores.

2. Mapping Definition

This section describes the mapping Load REGION that will be created in this example.

The Load REGION mapping uses the following data and transformations:

  * Three target datastore.
  | Model                 | Datastore            | Description                                           |  Type        |
  |-----------------------|----------------------|-------------------------------------------------------|--------------|
  | Parameters  | TRG\_CITY\_NAM        | New file created in the Parameters model | File delimited by semicolons |
  | Sales Administration  | TRG\_CITY\_EURO        | New target table created in the Sales Administration System | Oracle Table |
  | Sales Administration  | TRG\_CITY\_APAC         | New target table created in the Sales Administration System | Oracle Table |

  * One source datastore.
  | Model                 | Datastore          | Description                                     |  Type        |
  |-----------------------|--------------------|------------------------------------------------------|--------------|
  | Sales Administration   | TRG\_CITY     | City table in the Sales Administration system              | Oracle Table |

  * One **Split**

  | Description                      | Column Names                                |
  |----------------------------------|-------------------------------------------|
  | Split the data into three tables based on regions  | REGION\_ID              |

  * One **Sort**

  | Description                      | Column Names                                |
  |----------------------------------|-------------------------------------------|
  | Sort the data based on a population   | POPULATION             |
  

  * No transformation rules.

## **STEP  2:** Create New Target Datastores

1. In Designer Navigator, expand the Sales Administration model, right-click on the datastore TRG_CITY and select the option "Duplicate Selection".
![](./images/Capture3.PNG)

2. This will create a new datastore: Copy of TRG\_CITY. Double-click on the new datastore to modify its details as follows :
     - Name: TRG\_CITY\_APAC
     - Alias: APAC
     - Resource Name: TRG\_CITY\_APAC

 ![](./images/Capture4.PNG)

3. Similarly we create another Duplicate of TRG\_CITY datastore and modify its details as follows :
     - Name: TRG\_CITY\_EURO
     - Alias: EURO
     - Resource Name: TRG\_CITY\_EURO

 ![](./images/Capture5.PNG)

4. Make a Duplicate selection of the TRG\_CITY datastore as above. Drag the new duplicate datastore from Sales Administration model to Parameters model

 ![](./images/Capture6.PNG)

5. Double-click on the new datastore. In the Definition tab modify its details as follows :
     - Name: TRG\_CITY\_NAM
     - Alias: NAM
     - Resource Name: TRG\_CITY\_NAM

 ![](./images/Capture7.PNG)

6. In the Files tab of the datastore , modify the details as follows:
      - File Format: Delimited
      - Record Separator: Unix
      - Field Separator: Other(In the blank type comma(,))
  
 ![](./images/Capture8.PNG)

7. In the Attributes tab , modify the Length and Physical length as shown in the image below:
 ![](./images/Capture28.PNG)

## **STEP  3:** Create the Mapping

This section describes how to create the Load TRG\_REGION mapping. To create the Load TRG\_REGION mapping perform the following procedure:

### Insert the Mapping

   * In Designer Navigator, expand the Demo project node in the Projects accordion.
   * Expand the Sales Administration node.
   * In the Sales Administration folder, right-click the Mapping node and select **New Mapping**:

 ![](./images/Capture1.PNG)

   * Enter the name of your mapping (Load TRG\_REGION) in the Name field:

 ![](./images/Capture2.PNG)

 Ensure the *Create Empty Dataset* option is not selected.

### Define the Source Datastores
   
  The Load REGION mapping uses datastore from the *Sales Administration* model.To add source datastore to the Load REGION mapping:
   *  In the Mapping tab, drag the TRG\_CITY datastore from the *Sales Administration* model into the diagram.

### Define the Target Datastore  
   
  To insert the target datastore in the Load REGION mapping:
   * Select the following datastores under the *Sales Administration model* and drag it into the mapping:
    - TRG\_CITY\_EURO
    - TRG\_CITY\_APAC
   * Select the TRG\_CITY\_NAM datastore under the *Parameters* model and drag it into the mapping.

After adding the source and target datastores to the mapping, it looks as follows:

 ![](./images/Capture9.PNG)

## **STEP  4:** Add the Split, Sort Components

In this example, the data is split across three different datastores based on the continent. 

1. Drag the SPLIT component into the mapping from the Components palette.
   
2. Drag and drop the output connector of the source table onto the input connector of the SPLIT
component

 ![](./images/Capture10.PNG)

3. Drag and drop the output connector of the SPLIT component to the input connector of the APAC table.Click Ok on the Attribute Matching window.
 ![](./images/Capture11.PNG)

4. Similarly, drag and drop the output connector of the SPLIT component to the input connector of the EURO table and click Ok on the Attribute Matching window.
 ![](./images/Capture12.PNG)

**In this example, the data is sorted based on population for the NAM datastore**

5. Drag the SORT component into the mapping from the Components palette.
 ![](./images/Capture13.PNG)

6. Drag and drop the output connector of the SPLIT component to the input connector of the SORT component. Click Ok on the Attribute Matching window.
 ![](./images/Capture34.PNG)

7. Click on the SPLIT component and select the Split Condition entry. The expressions corresponding to each output connector will be as follows:
       * Check the "IS REMAINDER" box corresponding to OUTPUT1 which connects to the APAC datastore.
       * For the OUTPUT2 which corresponds to EURO datastore, the expression will be as follows:
         ````
         <copy>
          TRG_CITY.REGION_ID BETWEEN 20 AND 29
         </copy>

         ````
       * For the OUTPUT3 which corresponds to the SORT component, the expression will be as follows:
         ````
         <copy>
          TRG_CITY.REGION_ID BETWEEN 30 AND 69
         </copy>

         ````
       * The Split Condition will look like:

 ![](./images/Capture17.PNG)

8. Drag and drop the output connector of the SORT component to the input connector of the NAM datastore.

9.  Click on the SORT component. The SORT has the following expression:
    
     ````
     <copy>
     TRG_CITY.POPULATION
     </copy>

     ````
 ![](./images/Capture18.PNG)

## **STEP  5:** Setting the Integration Type
Select all the three target tables. In the *properties* window for the target tables, double click on each entry for Integration Type:

* select *Incremental Update* for APAC and EURO datastores.
* select *Control Append* for NAM datastore.
 ![](./images/Capture19.PNG)

## **STEP  6:** Define the Data Loading Strategies (LKM)

In the Physical tab, Oracle Data Integrator indicates the various steps that are performed when the map is executed.

In the Physical tab you define how to load the data of the source tables into your target environment with a Loading Knowledge Module (LKM).

To define the loading strategies:

1.  In the Physical tab of the Mapping Editor, select the source set that corresponds to the loading of the sorted source data into NAM. In this example, this is the SORT\_AP access point in the FILE\_DEMO\_SRC\_UNIT.
      * In the Property Inspector, set the LKM to **LKM SQL Multi-Connect.GLOBAL** using the LKM Selector list as shown:

 ![](./images/Capture20.PNG)

## **STEP  7:** Define the Data Integration Strategies (IKM)

After defining the loading phase, you need to define the strategy to adopt for the integration of the data into the target table.

To define the integration strategies:

1.  In the Physical tab of the Mapping Editor, select the Target object, first(**NAM**). The Property Inspector should display the properties of the target.
     * In the Property Inspector, set the IKM to **IKM SQL to File Append** using the IKM Selector list.
 
 ![](./images/Capture27.PNG)

2. Similarly, we have to set the IKM for the other two target tables **APAC** and **EURO** to **IKM Oracle Incremental Update**. and set CREATE\_TARG\_TABLE to True for both the target tables.

 ![](./images/Capture21.PNG)

**Note:** Only the built-in Knowledge Modules or the ones you imported to your Project appear in the KM Selector lists. The demonstration environment already includes the Knowledge Modules required for the getting started examples. You do not need to import KMs into the demonstration Project.

## **STEP  8:** Run the Mapping

In this section , lets save and run the mapping we created to check how the data load is performed.

1. Save the Mapping.

2. Click on the Green Play button on the taskbar to run the Mapping.
![](./images/Save.PNG)

3. Run box will appear on screen to select the agent and log level. Select the default values and when clicked ok , the Session starts.
![](./images/Capture24.PNG)

 ![](./images/Capture25.PNG)

4. Go to the operator tab and by drilling down on date the job status is shown. We can see that the Job is successfully run.
![](./images/Capture29.PNG)

5. Since the data load is successfully performed , lets verify the data in the target datastores.

     - In the Designer Navigator, expand the Models accordion and the *Sales Administration* model.
     - select the TRG\_CITY\_APAC datastore , right-click and select View data.
     - As seen below the data is loaded from the source to the target datastore.
  ![](./images/Capture31.PNG)  
     - Similarly the data can be seen loaded onto TRG\_CITY\_EURO with the REGION\_ID only between 20 and 29.
  ![](./images/Capture32.PNG)  
     - The data loaded into the NAM file has REGION\_ID between 30 and 69. Also, the data is sorted with population low to high.
  ![](./images/Capture33.PNG)  


This concludes the lab on Using Split and Sort Components.


## Acknowledgements

- **Author** - Narayanan Ramakrishnan, December 2020
 - **Contributors** - Srivishnu Gullapalli
 - **Last Updated By/Date** - Narayanan Ramakrishnan, December 2020

## Need Help?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

 



