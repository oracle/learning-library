# Mapping 3 - Multi Target Mapping

## Introduction

This chapter describes how to create a single mapping with multiple targets.

*Estimated Lab Time*: 60 minutes

#### Objective
In this chapter you will learn how to create the Multi Target mapping:

  * Load GEOGRAPHY: This mapping loads the data from the SRC\_REGION and SRC\_CITY tables in the *Orders Application* model into the TRG\_ COUNTRY, TRG\_CITY and TRG\_REGION target tables in the *Sales Administration* model.

### Prerequisites
This lab assumes you have:
- Basic knowledge of Oracle Database
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Initialize Environment

## **STEP 1:** Load GEOGRAPHY Mapping Description

This section contains the following topics:

- Purpose
- Mapping Definition

1. Purpose

  The purpose of this mapping is to load the SRC\_REGION table and the SRC\_CITY table from the *Orders Application* model into the TRG\_COUNTRY, TRG\_CITY and TRG\_REGION target tables in the *Sales Administration* model. Need to use the DISTINCT component to load the TRG_COUNTRY table.

2. Mapping Definition

  This section describes the mapping Load GEOGRAPHY that will be created in this example.

  The Load GEOGRAPHY mapping uses the following data and transformations:

    * Three target datastore.
  | Model                 | Datastore            | Description                                           |  Type        |
  |-----------------------|----------------------|-------------------------------------------------------|--------------|
  | Sales Administration  | TRG\_COUNTRY          | Target table in the Sales Administration System | Oracle Table |
  | Sales Administration  | TRG\_CITY         | Target table in the Sales Administration System | Oracle Table |
  | Sales Administration  | TRG\_REGION         | Target table in the Sales Administration System | Oracle Table |

    * Two source datastores.
  | Model                 | Datastore          | Description                                     |  Type        |
  |-----------------------|--------------------|------------------------------------------------------|--------------|
  | Orders Application    | SRC\_REGION        | Region table in the source systems              | Oracle Table |
  | Orders Application    | SRC\_CITY  | City table in the source systems         | Oracle Table |

    * One **Distinct**

  | Description                      | Column Names                                |
  |----------------------------------|-------------------------------------------|
  | Only retrieve distinct fields  | COUNTRY\_ID , COUNTRY               |

    * No transformation rules.

## **STEP 2:** Creating the Mapping

This section describes how to create the Load GEOGRAPHY mapping. To create the Load GEOGRAPHY mapping perform the following procedure:

  * Insert a Mapping
  * Define the Target Datastores
  * Define the Source Datastores
  * Add a Distinct Component
  * Define the Target Load Order
  * Setting the Integration Type
  * Define the Data Loading Strategies (LKM)
  * Define the Data Integration Strategies (IKM)
  * Run the Mapping

1. Insert a New Mapping

  To create a new mapping:
     * In Designer Navigator, expand the Demo project node in the Projects accordion.
     *  Expand the Sales Administration node.
     *  In the Sales Administration folder, right-click the Mappings node and select **New Mapping**.

  ![](./images/1.PNG)

     *  Enter the name of your mapping (Load GEOGRAPHY) in the Name field. Create Empty Dataset should be unchecked.

  ![](./images/2.PNG)

2. Define the Source Datastores

  The Load GEOGRAPHY mapping uses datastores from the *Orders Application* model.

  To add source datastores to the Load GEOGRAPHY mapping:  
     * In the Mapping tab, drag the following source datastores into the Source Diagram:  
       - SRC\_REGION from the *Orders Application* model
       - SRC\_CITY from the *Orders Application* model

  ![](./images/Capture3.PNG)


3. Define the Target Datastore  

  To insert the target datastore in the Load GEOGRAPHY mapping:
     * Go to the Logical tab of the Mapping Editor.
     * In the Designer Navigator, expand the Models accordion and the *Sales Administration* model.
     * Select the following datastores under the *Sales Administration model* and drag it into the mapping:
         - TRG\_COUNTRY
         - TRG\_CITY
         - TRG\_REGION

  ![](./images/Capture4.PNG)

## **STEP 3:** Add a Distinct Component

In this example, only distinct Country fields should be retrieved.

1. Drag the DISTINCT component into the mapping from the Components palette.

2.  Drag and drop the COUNTRY\_ID and the COUNTRY columns from the SRC_REGION table onto the DISTINCT component.

  ![](./images/Capture5.PNG)

3. Now drag and drop the output connector of the DISTINCT component onto the input connector of the TRG_COUNTRY table as shown below:

  ![](./images/4.PNG)

4. When prompted for attributes matching, keep the default options and click Ok.

  ![](./images/5.PNG)

## **STEP 4:** Define the Target Load Order

This section describes how to connect source and target data sources and also define the target load order when there are multiple target tables.

1. Connect the output connector of the SRC\_REGION to the input connector of the TRG\_REGION table.

2. Connect the output connector of the SRC\_CITY table to input connector of the TRG\_CITY table.

3. The mapping should look as shown below:

  ![](./images/6.PNG)

4. Click on the canvas (anywhere on the white background of the mapping) to display the properties window for the mapping. In that window click on the dented wheel on the right (if the wheel is not visible, hover in that vicinity with your cursor and it will eventually show up) to display the wizard that will help you define the order in which the tables have to be loaded.

  ![](./images/7.PNG)

5. Make sure that the tables are listed in the appropriate order. If not, move the tables up and down so that TRG\_COUNTRY is at the top and TRG\_CITY at the bottom.

  ![](./images/Capture8.PNG)

6. When you exit the wizard, you will see the selected order:

  ![](./images/Capture9.PNG)

## **STEP 5:** Setting the Integration Type
Select all the three target tables. In the *properties* window for the target tables, double click on each entry for Integration Type and select *Incremental Update*

  ![](./images/Capture10.PNG)

## **STEP 6:** Define the Data Loading Strategies (LKM)

In the Physical tab, Oracle Data Integrator indicates the various steps that are performed when the map is executed. In the Physical tab you define how to load the data of the source tables into your target environment with a Loading Knowledge Module (LKM).

To define the loading strategies:

1.  In the Physical tab of the Mapping Editor, select the source set that corresponds to the loading of the source data of SRC\_CITY into TRG\_CITY. In this example, this is the SRC\_CITY access point in the ORA\_SALES\_DWH\_UNIT.

2.  In the Property Inspector, set the LKM to **LKM SQL to SQL (Built-In).GLOBAL** using the LKM Selector list as shown:

  ![](./images/Capture11.PNG)

2. Similarly, we set the LKM's of other two access points. Namely SRC\_REGION and DISTINCT in the ORA\_SALES\_DWH\_UNIT to **LKM SQL to SQL (Built-In).GLOBAL**.

  ![](./images/Capture12.PNG)

  ![](./images/Capture13.PNG)

## **STEP 7:** Define the Data Integration Strategies (IKM)

After defining the loading phase, you need to define the strategy to adopt for the integration of the data into the target table.

To define the integration strategies:

1.  In the Physical tab of the Mapping Editor, select the Target object, first(**TRG\_CITY**). The Property Inspector should display the properties of the target.

2. In the Property Inspector, set the IKM to **IKM Oracle Incremental Update** using the IKM Selector list. If this IKM is not in the list, make sure you have correctly set the Target Integration Type to Incremental Update in the Logical panel.

  ![](./images/Capture14.PNG)

2. Similarly, we have to set the IKM for the other two target tables TRG\_REGION and TRG\_COUNTRY to  **IKM Oracle Incremental Update**.

  ![](./images/Capture15.PNG)

  ![](./images/Capture16.PNG)

**Note:** Only the built-in Knowledge Modules or the ones you imported to your Project appear in the KM Selector lists. The demonstration environment already includes the Knowledge Modules required for the getting started examples. You do not need to import KMs into the demonstration Project.

## **STEP 8:** Run the Mapping

In this section , lets save and run the mapping we created to check how the data load is performed.

1. Save the Mapping.

2. Click on the Green Play button on the taskbar to run the Mapping.

  ![](./images/Save.PNG)

3. Run box will appear on screen to select the agent and log level. Select the default values and when clicked ok , the Session starts.

  ![](./images/Capture17.PNG)

  ![](./images/Capture18.PNG)

4. Go to the operator tab and by drilling down on date the job status is shown. We can see that the Job is successfully run.

  ![](./images/Capture19.PNG)

5. Since the data load is successfully performed , lets verify the data in the target datastores.

    - In the Designer Navigator, expand the Models accordion and the *Sales Administration* model.
    - select the TRG\_CITY datastore , right-click and select View data.

  ![](./images/Capture24.PNG)  

    - As seen below the data is loaded from the source to the target datastore.

  ![](./images/Capture20.PNG)  

    - Similarly the data can be seen loaded onto TRG\_COUNTRY and TRG\_REGION datastores.

  ![](./images/Capture21.PNG)  

  ![](./images/Capture22.PNG)  

This concludes the lab on Multiple Target Mappings. You many proceed to the next lab.

## Learn More
- [Oracle Data Integrator](https://docs.oracle.com/en/middleware/fusion-middleware/data-integrator/index.html)

## Acknowledgements

- **Author** - Narayanan Ramakrishnan, December 2020
- **Contributors** - Srivishnu Gullapalli
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
