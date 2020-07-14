# Provisioning Autonomous Data Warehouse #

## Before You Begin ##
This 10-minute lab walks you through the steps to get started using the Oracle Autonomous Data Warehouse (ADW) on Oracle Cloud Infrastructure (OCI). You will provision a new ADW database. Later labs show you how to make use of Machine Learning (ML) services and load data into the database.

### Background ###
The Oracle Autonomous Data Warehouse is built around the market leading Oracle database and comes with fully automated data warehouse specific features that deliver outstanding query performance. This environment is delivered as a fully managed cloud service running on optimized high-end Oracle hardware systems. You don’t need to spend time thinking about how you should store your data, when or how to back it up or how to tune your queries, we take care of everything for you. You can select the exact combination of storage and CPUs to fit your project and your budget. Your data is always backed up and encrypted in Oracle's cloud ensuring your data is safe and secure. Leveraging our client tools you can load different types of data including worksheets on your computer, webstore log files, and data files stored in Oracle's cloud-based object store into your Oracle Autonomous Data Warehouse.

Oracle’s Autonomous Data Warehouse is the perfect quick-start service for fast data loading and sophisticated data reporting and analysis. Oracle manages everything for you so you can focus on your data.

### What Do You Need? ###
* Access to an Oracle Cloud account, such as the [Oracle Cloud Free Tier](https://oracle.com/oow19freetier).


## STEP 1: Create an ADW Instance ##
1. Sign in to the [Oracle Cloud](https://cloud.oracle.com/home).
2. Click the menu icon to expand the menu on the left edge of the screen. If you just provisioned the tenancy this menu may not show all of the options because they are being installed and configured. Wait a couple of minutes and click on refresh.
3. Click **Autonomous Date Warehouse**.

    ![](img/OCIMenu.png " ")

    [Description of the illustration OCIMenu.png](files/OCIMenu.txt)

4. Click the **Create Autonomous Database** button to start the instance creation process.
5. On the Create Autonomous Database page, enter the following information:
     * **Compartment**: For this lab, we'll use the `root` compartment.
     * **Display Name**: `ADW Finance Mart`
     * **Database Name**: `ADWFINANCE`
     * **Workload Type**: `Data Warehouse`
     * **CPU Core Count**: `1`
     * **Storage (TB)**:  `1`
     * **Auto Scaling**: Unchecked
     * **Administrator Credentials**: Create a password for the ADMIN user of the service instance. Remember this password! You'll need it in later labs to sign in to various services like Performance Hub and SQL Developer Web.
     * **License Type**: `Bring Your Own License`
6. Click the **Create Autonomous Database** button to start provisioning the instance. 
7. You're taken to the instance's details page. Details include a State field, which indicates the instance is **Provisioning**. When it's complete, the State field changes from **Provisioning** to **Available**. If the status doesn't change after few minutes, try refreshing the page.

    ![](img/adw_provisioning_state.png " ")

    [Description of the illustration adw_provisioning_state.png](files/adw_provisioning_state.txt)


## Want to Learn More? ##
* [Data Management Cloud Courses](https://learn.oracle.com/pls/web_prod-plq-dad/dl4_pages.getpage?page=dl4homepage&get_params=offering:35573#filtersGroup1=&filtersGroup2=.f667&filtersGroup3=&filtersGroup4=&filtersGroup5=&filtersSearch=) from Oracle University 
* [Autonomous Database Cloud Certification](https://education.oracle.com/en/data-management/autonomous-database/product_817?certPage=true) from Oracle University

