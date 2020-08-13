# Lab 4: Show Customers by Region on Map

## Before You Begin
### Objectives
- Show the regions in map from the shapefile

### Introduction

Marketing is also interested in a map like interface to assess and establish sales and sales forecasts for new proposed sales regions, which are defined in shape files that are maintained in marketing systems.  There was concern that merging and processing external shape files with online Oracle Autonomous Transaction Processing Database customer data on the fly would be complicated and time consuming, but again Oracle's extensive Spatial support that has been developed over decades and used by Oracle's largest enterprise customers has recently been added to Autonomous Databases, is a good fit for this use case.  Derek will take those shape files and display them as regions on the map, and identify and display customers in those regions, and derive sales from within those.  He will use the GeoPandas Python extension, and Oracle's native Spatial functions in the Autonomous Transaction Processing Database.

## **Step 1:** Plot customer based on region

1. If you closed the terminal, open it again and make sure to be in virtual env. Run the command
  ```
  <copy>bokeh serve regions.py</copy>
  ```

2.  Now we have our web service running. Leave the terminal as it is.

  ![](images/001.png " ")

3. To confirm everything works fine, open firefox and go to URL [http://localhost:5006/regions](http://localhost:5006/regions).

  ![](images/003.png " ")

4. The regions you see in the map are plotted from the data in the shapefile. If you want to check the files it is in the application folder named demo_region. We are using **geopandas** to convert the shapefile in dataframe and perform operations on it.

5. To show/hide hover points click on the hover tool in the toolbar as shown below.
 
  ![](images/002.png " ")

## Conclusion

We hoped you have been successful in completing the four labs.  They have shown you how to spin up a new Oracle Cloud Developer Image from the Oracle Marketplace to quickly and easily, and deploy a complete development environment that is accessible from any location. You have also learned how to deploy the Oracle Autonomous Transaction Processing (Autonomous Transaction Processing) Cloud Service in a few minutes with a few simple mouse clicks.  

You were also introduced to the Oracle Cloud Developer Image and created Python microservices in the Visual Studio Code IDE. You used the Flask micro web framework, the Bokeh interactive visualization library and the ReactJS Facebook JavaScript library in deploying a sample Python application.  

Finally you created a pair of spatial applications that utilized the GeoPandas extensions to Python together with Oracle Spatial functionality within the Autonomous Transaction Processing database.


## Acknowledgements

- **Authors/Contributors** - Derrick Cameron
- **Last Updated By/Date** - Kay Malcolm, April 2020
- **Workshop Expiration Date** - April 31, 2021

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request.
