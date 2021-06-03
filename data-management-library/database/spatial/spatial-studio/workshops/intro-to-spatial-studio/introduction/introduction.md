# Introduction

## About this Workshop

In this workshop you will explore the features of Spatial Studio for self-service spatial analysis and visualization. Using datasets of traffic accidents, police stations, and police station service areas, you will load and visualize spatial data, and analyze their spatial relationships as shown below. 

![](./images/spatial-studio-project.png " ")

Estimated Workshop Time: 2 hours


### About Oracle Spatial Studio

 Oracle Spatial Studio (Spatial Studio) provides no-code access to the spatial capabilities of Oracle Database. While these capabilities have historically required coding and/or use of 3rd party tools, Spatial Studio allows business users to create and share spatial analysis and interactive web maps using self-service GUIs. 

  ![img alt text](./images/spatial-studio.png)

Spatial Studio operates on spatial data in Oracle Database, meaning tables and views that include Oracle's geometry data type. This data be be pre-existing spatial data or non-spatial data which is prepared using Spatial Studio to add geometries based on attributes. The end user features of Spatial Studio can be summarized as follows:

Access and prepare spatial data:
  - Access spatial/non-spatial data in Oracle Database
  - Load data from common formats
  - Prepare non-spatial data by geocoding addresses or indexing lat/lon columns
  - Pre-cache large datasets

Analyze and visualize spatial data:
  - Drag-and-drop map visualizations
  - Data driven styling
  - Perform spatial analyses
  - Share results

Spatial Studio also provides integration features for developers and configuration options for application administrators, which are outside the scope of this intro workshop.

For more information please visit [https://oracle.com/goto/spatialstudio] (https://oracle.com/goto/spatialstudio)

### Objectives

Understanding Spatial Studio capabilities to
  - Load spatial data
  - Visualize spatial data
  - Perform spatial analysis


### Prerequisites

This workshop requires access to Spatial Studio and Oracle Database. Before proceeding with this workshop:
  - If you are running this workshop using your own Always Free, Free Trial, or paid Tenancy:
    - You must complete the workshop [Install Oracle Spatial Studio from Cloud Marketplace ](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=778)
  - If you are running this workshop from a LiveLabs Reservation:
    - Spatial Studio and Oracle Autonomous Database instances are automatically created for you 
    - You must complete Lab 3 and Lab 4:STEP 4 in the workshop [Install Oracle Spatial Studio from Cloud Marketplace ](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=778)
    - Note, your Spatial Studio URL will be https://[your reservation Instance IP]:4040/spatialstudio. The  default login user is admin and password is welcome1

No previous experience with Oracle Spatial is required.

*Note: If you have a **Free Trial** account, when your Free Trial expires your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)***


## Acknowledgements

* **Author** - David Lapp, Database Product Management, Oracle
* **Last Updated By/Date** - David Lapp, Database Product Management, April 2021


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-spatial). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 
