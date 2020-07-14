# Lab 3: Plot Data and Show Nearest Service Provider on Map

## Before You Begin
### Objectives
- Setup Python application 
- Check the distance between customer and service provider

#### Introduction

Support is interested in a new app that provides insights into customer and service provider data by geography, and would like an intuitive map like interface.  You plan to use the open source GeoPandas extension to quickly mock up an application interface leveraging Oracle Spatial.  You need to assess customer service provider availability for your products, and identify service provider coverage based on customer proximity to those services.  You plan to use some of Oracle's comprehensive library of Spatial functions such as SDO_NN to calculate distances between customers and their nearest service provider, and use this information to assess future service provider outlet requirements.

## STEP 1: Configure project in Visual Studio Code

1. Open the terminal,click on **Applications**, select **Favorites** and then click on **Visual Studio**.

  ![](images/1-1.png " ")

2. Click on **File** and then click on **Open Folder** 

  ![](images/1.png " ")

3. In the Dialog box go to the unzipped **lab-resources** folder, look inside of it, click on **mapplottingpy**, and then click on **OK**.

4. You will the see the files on the left panes.

5.Open the inbuilt Visual Studio Code terminal by clicking on **View** and then click on **Terminal**. You can also open by keyboard shortcut **[Ctrl +]**.

  ![](images/4.png " ")

6. In the terminal enter command 
  ```
  <copy>pip install virtualenv</copy>
  ```

  ![](images/5.png " ")

7. Next enter this to create entry point.
  ```
  <copy>virtualenv env</copy>
  ``` 
  ![](images/6.png " ")

8. To run the virtual environment enter the following.  If successfull you will see (env) before the path that means you are now in virtual env.
  ```
  <copy>source env/bin/activate</copy>
  ```

  ![](images/7.png " ")

9. We have all the required packages in requirements file. To install it run the command.  Ensure you are in the **/home/opc/lab-resources/mapPlottingPy** directory.
  ```
  <copy>pip install -r requirements.txt</copy>
  ```

![](images/8.png " ")

## STEP 2: Plot customers on Map

1. Leave the terminal open. Click on **config.py** file from the left pane and change the details in the file with your Autonomous Transaction Processing Database information.  

  ![](images/9.png " ")

2. We are using **Bokeh** open source library to plot the data we get from  on map. Bokeh is an interactive visualization library that targets modern web browsers for presentation. Its goal is to provide elegant, concise construction of versatile graphics, and to extend this capability with high-performance interactivity over very large or streaming datasets.

3. If you closed the terminal, open it again and make sure to be in virtual env. Run the command.
  ```  
  <copy>bokeh serve customers.py</copy>
  ```
 
4. Now we have our web application running. Leave the terminal as it is.

  ![](images/003.png " ")

5. To confirm everything works fine, open firefox and go to URL [http://localhost:5006/customers](http://localhost:5006/customers).
    
  ![](images/001.png " ")

6. Make sure to have zoom box selected by click the icon as below.

  ![](images/002.png " ")

7. To zoom in drag and make square to get  better visibility of points.

  ![](images/map.gif " ")

8. Points on the map are the location of customer and service provider, when you hover over the points, it shows the customer address and the distance to the nearest service provider.

9.  As seen above the distance between the customer and service provider is calculated using the SQL query and using package **SDO\_NN\_DISTANCE**. To understand more we have two tables( i.e Customers and Service providers) with each having GeoCordinate, **SDO\_NN\_DISTANCE** calculates the distance between these two points and we calculate that distance in miles and sort by distance. All this is done by the query following below.  Go to your cloud console, and then to your ATP instance (menu upper left.)

  ![](images/004.png " ")

10. Select Tools, and then SQL Developer Web.

  ![](images/005.png " ")

  ![](images/006.png " ")

11. Go up to the URL and change the part that says **admin** to **alpha** and hit enter to refresh the screen.

  ![](images/007.png " ")

12. Log in as user **alpha**.

  ![](images/008.png " ")

13. Paste the following into the worksheet.  This queries customers that within a mile of a service provider.
  ``` 
  <copy>SELECT /* ORDERED */
  A1.STREET_ADDRESS,
  A2.CITY,
  A2.STATE_PROVINCE,
  SDO_UTIL.TO_GEOJSON(A1.ADDRESS_POINT) TEST,
  SDO_UTIL.TO_GEOJSON(A2.ADDRESS_POINT) TEST2,
  MDSYS.SDO_NN_DISTANCE(1) DISTANCE_IN_MILES
  FROM
  CUSTOMERS A2,
  SERVICE_PROVIDERS A1
  WHERE
  A2.COUNTRY_ID = 102 AND 
  A1.COUNTRY_ID = 102 AND
  MDSYS.SDO_NN(A1.ADDRESS_POINT, A2.ADDRESS_POINT, 'sdo_num_res=1 unit=mile', 1) = 'TRUE'
  ORDER BY
  MDSYS.SDO_NN_DISTANCE(1)</copy>
  ```

  ![](images/009.png " ")

## Useful Links
- Here are some useful links to show more about the Spatial Database features.
    - [Oracle Documentation](https://docs.oracle.com/database/121/SPATL/sdo_nn.htm#SPATL1032)
    - [Blog on Spatial Database](https://blogs.oracle.com/oraclespatial/spatial-with-python-and-geopandas-made-easy-with-cx_oracle)

Please proceed to the next lab.

## Acknowledgements

- **Authors/Contributors** - Derrick Cameron
- **Last Updated By/Date** - Kay Malcolm, April 2020
- **Workshop Expiration Date** - April 31, 2021

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.    Please include the workshop name and lab in your request. 
