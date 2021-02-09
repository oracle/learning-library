# Connecting your application with MDS (MySQL Database Cloud Service) on OCI

## Introduction
This lab walks you through creating an MDS instance on OCI and how to migrate your database from your E-Commerce App MySQL to MDS on OCI. The lab will also focus on how to connect your E-Commerce application with MDS.

Estimated Lab Time: 1 hour

### Objectives
* Create an MDS (MySQL Database Cloud Service)
* Migrate E-Commerce MySQL Database to MDS
* Connect your E-Commerce App with MDS

### Prerequisites
* Complete Lab 1 and 2
* Access to MySQL Database

## **STEP 1:** Create MDS Instance on OCI
1. Please login to OCI Console and click MySQL > DB Systems. And click Create MySQL DB System.

    ![](./images/1.png "")

2. Please provide the name for the MySQL instance. Select your compartment, Availability Domain, and shape. And click Next.

    ![](./images/2.png "")

3. Now, enter the credentials for MDS Instance. Please select the same VCN and public subnet you created in the previous lab. And click Next.

    ![](./images/3.png "")

4. Once complete, Please click create button. This will take few minutes to spin up the MDS Instance on OCI.

    ![](./images/4.png "")

## **STEP 2:** Migrating Database to MDS

1. Please ssh in your primary instance. Run the following command in the terminal.

    ```
    <copy>
    mkdir mysql
    </copy>
    ```
    ```
    <copy>
    cd mkdir
    </copy>
    ```

2. Use the following command to extract the oscommerce database from OsCommerce MySQL instance using MySQL client.

    ```
    <copy>
    mysqldump -u root oscommerce > data-dump.sql
    </copy>
    ```
    ![](./images/5.png "")

3. Use the following command to connect with the MDS instance using MySQL client. You would need to enter the MDS IP address, username, and password created in the previous step.

    ```
    <copy>
    mysql -h <MDS_IP_address> -u admin -p
    </copy>
    ```
    ![](./images/6.png "")


4. Run the following command in the terminal. This will create the oscommerce database and upload the dump to MDS Instance. Using show tables, please check if you can see all tables of oscommerce database.

    ```
    mysql> create database oscommerce;
    mysql> use oscommerce;
    mysql> source data-dump.sql;
    mysql> show tables;
    ```

    ![](./images/7.png "")

5. Run the following command to exit from MDS. And then proceed to the next step.

    ```
    <copy>
    mysql> exit;
    </copy>
    ```

## **STEP 3:** Connecting your E-Commerce App with MDS

1. Now, you would need to update the configure.php file of the OsCommerce application to point to the MDS Database. Run the following command in the terminal.
    ```
    <copy>
    cd /var/www/html/catalog/includes
    </copy>
    ```
    ```
    <copy>
    sudo nano configure.php
    </copy>
    ```
    ![](./images/11.png "")

2. Update following parameters:
    ```
    define('DB_SERVER', '');  # IP address of MDS
    define('DB_SERVER_USERNAME', ''); # username of MDS
    define('DB_SERVER_PASSWORD', ''); # password of MDS
    ```

3. Save the file and proceed to the next steps.

4. Goto the browser and open the IP address. You would see the OsCommerce website up and running as below. Now the E-Commerce application is connected to MDS Database.

    ![](./images/13.png "")

5. Congrats! You've successfully connected your primary instance of the E-Commerce application with MDS. You can repeat the lab for your secondary instance.

## Learn More
* To learn about connecting to MDS on OCI [link](https://docs.oracle.com/en-us/iaas/mysql-database/doc/connecting-db-system.html)
* To learn about MySQL Shell [link](https://dev.mysql.com/doc/mysql-shell/8.0/en/)

## Acknowledgements
* **Author** - Rajsagar Rawool
* **Last Updated By/Date** - Rajsagar Rawool, January 2021

## Need Help?
If you are doing this module as part of an instructor-led lab, take advantage and ask the instructor.

If you are working through this module self-guided, please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please mention your workshop name and lab name.  Please also have screenshots and attach files when appropriate.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one
