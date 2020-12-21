# Oracle Spatial 

## Introduction

This lab walks you through the steps of setting up the environment for Spatial lab. You can connect Oracle Database instance using any client you wish. In this lab, you will connect using Oracle SQLDeveloper.


### Before You Begin

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup

### About Oracle SPATIAL 

Oracle Spatial is an integrated set of functions, procedures, data types, and data models that support spatial analytics. The spatial features enable spatial data to be stored, accessed, and analyzed quickly and efficiently in an Oracle database.

Oracle Spatial is designed to make spatial data management easier and more natural to users of location-enabled applications and geographic information system (GIS) applications. Once spatial data is stored in an Oracle database, it can be easily manipulated, retrieved, and related to all other data stored in the database.

A common example of spatial data can be seen in a road map. A road map is a two-dimensional object that contains points, lines, and polygons that can represent cities, roads, and political boundaries such as states or provinces. A road map is a visualization of geographic information. 

The data that indicates the Earth location (such as longitude and latitude) of these rendered objects is the spatial data. When the map is rendered, this spatial data is used to project the locations of the objects on a two-dimensional piece of paper.

 [](youtube:Q2jm93Rm95g)

Oracle Spatial consists of the following: 

-	Schema (MDSYS)
-	A spatial indexing mechanism  	
-	Operators, functions, and procedures
-	Native data type for vector data called SDO\_GEOMETRY(An Oracle table can contain one or more SDO\_GEOMETRY columns.)


### Scenario
MyCompany has several major warehouses. It needs to locate its customers who are near a given warehouse, to inform them of new advertising promotions. To locate its customers and perform location-based analysis, MyCompany must store location data for both its customers and warehouses.

We will be using three tables – CUSTOMERS, WAREHOUSES and WAREHOUSES\_DTP.

Each table stores location using Oracle's native spatial data type, SDO\_GEOMETRY. A location can be stored as a point in an SDO\_GEOMETRY column of a table. The customer's location is associated with longitude and latitude values on the Earth's surface—for example, -63.13631, 52.485426.



## Step: Connect to the Pluggable Database (PDB)
1. Set the Oracle environment    
    ````
    <copy>
    sudo su - oracle
    </copy>
    ````   
    ````
    <copy>
    . oraenv
    </copy>
    ````

    ````
    <copy>
    ConvergedCDB
    </copy>
    ````

2.  Login as the appspat user using SQL*Plus
    ````
    <copy>
    sqlplus APPSPAT/Oracle_4U@SGRPDB
    </copy>
    ````

1. Make a connection to sqldeveloper.  Provide the details as below and click on connect.
   
    ````
    <copy>
    Name    : Spatial
    Username: APPSPAT
    Password: Oracle_4U
    Hostname: PUBLIC-IP
    Port    : 1521
    Service name: SGRPDB

    </copy>
    ````
 
  ![](./images/spatial_enva.png " ") 

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K, Robert Ruppel.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
      
 
