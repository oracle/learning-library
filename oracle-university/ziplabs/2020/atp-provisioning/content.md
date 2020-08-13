# Provisioning Autonomous Transaction Processing #

## Before You Begin ##
This 10-minute lab walks you through the steps to get started using the Oracle Autonomous Transaction Processing (ATP) on Oracle Infrastructure Cloud (OCI). You will provision a new ATP database. Later you may connect to the database using Oracle SQL Developer or SQL Developer Web.

### Background ###
Oracle Autonomous Transaction Processing is a fully-managed, performance, and elastic database. You have all of the performance of the market-leading Oracle Database in an environment that is tuned and optimized for transaction processing workloads.

Autonomous Transaction Processing is built upon the Oracle Database, so that all applications and tools that support Oracle Database also support Autonomous Transaction Processing. These tools and applications connect to the Autonomous Transaction Processing database using standard SQL*Net connections. The tools and applications can either be in your data center or in a public cloud. Oracle Analytics Cloud and other Oracle Cloud services are preconfigured for Autonomous Transaction Processing.

### What Do You Need? ###
* Access to an Oracle Cloud account, such as the [Oracle Cloud Free Tier](https://oracle.com/oow19freetier).


## **Step 1:** Create an ATP Instance ##
1. Sign in to the [Oracle Cloud](https://cloud.oracle.com/home).
2. Click the menu icon to expand the menu on the left edge of the screen.
3. Click **Autonomous Transaction Processing**.

    ![](img/OCIMenu.png " ")

    [Description of the illustration OCIMenu.png](files/OCIMenu.txt)

4. Click the **Create Autonomous Database** button to start the instance creation process.
5. On the Create Autonomous Database page, enter the following information:
     * **Compartment**: For this lab, we'll use the `root` compartment.
     * **Display Name**: `atpxweek`
     * **Database Name**: `atpxweek`
     * **Workload Type**: `Transaction Processing`
     * **Deploymen Type**: `Serverless`
     * **CPU Core Count**: `1`
     * **Storage (TB)**:  `1`
     * **Administrator Credentials**: Create a password for the ADMIN user of the service instance. Remember this password! You'll need it in later labs to sign in to various services like Performance Hub and SQL Developer Web.
     * **License Type**: `Bring Your Own License`
6. Click the **Create Autonomous Database** button to start provisioning the instance. 
7. You're taken to the instance's details page. Details include a State field, which indicates the instance is **Provisioning**. When it's complete, the State field changes from **Provisioning** to **Available**. If the status doesn't change after few minutes, try refreshing the page.

    ![](img/atp_instance.png " ")

    [Description of the illustration atp_instance.png](files/atp_instance.txt)


## Want to Learn More? ##
* [Data Management Cloud Courses](https://learn.oracle.com/pls/web_prod-plq-dad/dl4_pages.getpage?page=dl4homepage&get_params=offering:35573#filtersGroup1=&filtersGroup2=.f667&filtersGroup3=&filtersGroup4=&filtersGroup5=&filtersSearch=) from Oracle University 
* [Autonomous Database Cloud Certification](https://education.oracle.com/en/data-management/autonomous-database/product_817?certPage=true) from Oracle University

