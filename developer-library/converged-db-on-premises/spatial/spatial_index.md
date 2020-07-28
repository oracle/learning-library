# Oracle Spatial  

## Introduction

This lab walks you through the steps of creating indexes on spatial tables. A spatial index, like any other index, provides a mechanism to limit searches. However, spatial indexes are highly recommended, and not using them can negatively affect performance in some cases.

**Note: Below lab is completed and indexes are already created for the tables.**

### Before You Begin

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup

## Step 1:  Create Indexes 
We have created indexes for each table- CUSTOMERS, WAREHOUSES and WAREHOUSES_DTP

````
    <copy>
CREATE INDEX customers_sidx ON customers(CUST_GEO_LOCATION)
indextype is mdsys.spatial_index; 

CREATE INDEX warehouses_sidx ON warehouses(WH_GEO_LOCATION)
indextype is mdsys.spatial_index;

CREATE INDEX "WAREHOUSES_DTP_SIDX" ON "WAREHOUSES_DTP" ("GEOMETRY") 
INDEXTYPE IS "MDSYS"."SPATIAL_INDEX" ;
</copy>
````

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K, Robert Ruppel.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
      
