# Polyglot Microservices
## Introduction

This lab will show you how to switch the Inventory microservice to a Python, Node.js or Java Helidon SE implementation while retaining the same application functionality.

![](images/architecture.png " ")

### Objectives
-   Undeploy the existing Java Helidon MP Inventory microservice
-   Deploy an alternate implementation of the Inventory microservice and test the application functionality

### What Do You Need?

This lab assumes you have already completed Labs 1 through 4.

## **STEP 1**: Undeploy the Java Helidon MP Inventory Microservice

1. To undeploy the Inventory Helidon MP service, open the Cloud Shell and go to the
    inventory-helidon folder, using the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-helidon ; ./undeploy.sh</copy>
    ```

   ![](images/undeploy-inventory-helidon-mp.png " ")

## **STEP 2**: Deploy an alternate implementation of the Inventory Microservice

In this step you can choose between three different implementations of the Inventory Microservice: (1) Java Helidon SE, (2) Python, or (3) Node.js

1. Select one of the alternate implementations and deploy the service for the selected implementation.  

   If you selected Java Helidon SE, deploy this service:

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-helidon-se; ./deploy.sh</copy>
    ```

   If you selected Python, deploy this service:

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-python; ./deploy.sh</copy>
    ```

   If you selected Node.js, deploy this service:

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-nodejs; ./deploy.sh</copy>
    ```

## **STEP 3**: Verify application functionality

1. Repeat Lab 4 Step 2 to verify the order and inventory functionality of the GrubDash store remains the same using new order ID's, for example 166 and 167.

## **STEP 4**: Re-deploy the Java Helidon MP Inventory Microservice

1. To undeploy any other inventory services and then deploy the Inventory Helidon MP service, issue the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-helidon-se; ./undeploy.sh; cd $MSDATAWORKSHOP_LOCATION/inventory-python; ./undeploy.sh; cd $MSDATAWORKSHOP_LOCATION/inventory-nodejs; ./undeploy.sh; cd $MSDATAWORKSHOP_LOCATION/inventory-helidon ; ./deploy.sh</copy>
    ```

## Acknowledgements
* **Authors** - Richard Exley, Maximum Avaiability Architecture; Curtis Dinkel, Maximum Avaiability Architecture; Rena Granat, Maximum Avaiability Architecture;
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

## Need Help?
Please submit feedback or ask for help  using this [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/building-microservices-with-oracle-converged-database). Please login using your Oracle Sign On and click the **Ask A Question** button to the left.  You can include screenshots and attach files.  Communicate directly with the authors and support contacts.  Include the *lab* and *step* in your request. 
