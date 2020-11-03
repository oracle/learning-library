# Configuration and Compliance Management
## Introduction
The objective of this workshop is to highlight Oracle Enterprise Manager Cloud Control 13c’s Lifecycle Management capabilities related to configuration and security compliance management of managed targets. Each activity focuses on different capabilities for an administrator.

### Objectives

The objective of this workshop is to highlight Oracle Enterprise Manager Cloud Control 13c’s Lifecycle Management capabilities related to configuration and security compliance management of managed targets. Each activity focuses on different capabilities for an administrator.


*Estimated Lab Time*: 60 minutes

### Prerequisites
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Environment Setup
- SSH Private Key to access the host via SSH
- OMS super-user Credentials:
    - Username: **sysman**
    - password: **welcome1**
- EM13c Host Public IP address
- OMS Console URL:
  ````
  <copy>https://<EM13c Host Public IP address>:7803/em</copy>
  e.g: https://111.888.111.888:7803/em
  ````

*Note*: This lab environment is setup with Enterprise Manager Cloud Control Release 13.4 Release Update 5 and Database 19.3 as Oracle Management Repository.

### Lab Timing (Estimated)

| Step No.                                      | Feature                                                                 | Approx. Time | Details                                                                                                                                                                                    | Value proposition                                                                                                   |
|-----------------------------------------------------------|-------------------------------------------------------------------------|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| 1                                                         | Inventory & Usage details                                               | 10 minutes   | IT Manager wants to get an inventory of all existing databases managed by Enterprise Manager including different versions of databases, number of instances deployed over a period of time | Reduce number of different configuration sets and increase standardization across the data center.                  |
| 2                                                         | One-time database comparison                                            | 10 minutes   | Compare latest reference configuration to one or more targets to determine the configuration differences                                                                                   | Validate the configuration of new database provisioned aligns with IT configuration policy                          |
| 3                                                         | Database configuration drift management                                 | 20 minutes   | Compare latest or saved target configuration to one or more targets.                                                                                                                       | Monitor databases in your organization for any configuration drift, remediate to align with reference configuration |
| 4                                                         | Database security compliance using custom compliance standard | 10 minutes   | Database security compliance for Oracle Database 12c target                                                                                      | Monitor security compliance for database targets from one customized dashboard.                                 |
| 5                                                         | Host security compliance using custom compliance standard | 10 minutes   | Host security compliance                                                                                       | Monitor security compliance for host targets from one customized dashboard.                                 |

## **STEP 0:** Running your Workload
### Login to OMS Console
Login to your Enterprise Manager console using the OMS URL and the super-user credentials as indicated above

You may see an error on the browser while accessing the Web Console - “*Your connection is not secure*”. Ignore and add the exception to proceed. Access this URL and ensure that you are able to access Enterprise Manager Web Console.

## **STEP 1:** Inventory & Usage Details

### Overview

IT Manager wants to get an inventory of all existing databases managed by Enterprise Manager including different versions of databases, number of instances deployed over a period of time. This is to reduce number of different configuration sets and increase standardization across the data center.

All the items in this step are read-only, primary goal is to learn about inventory usage details within Enterprise Manager for all supported targets

### Execution

1.  Log into your Enterprise Manager as indicated in the Prerequisites step if not already done.

2.  From the Enterprise menu, select Configuration, then select Inventory and  Usage Details

  ![](images/ecm1_inventory_usage_menu_item.png " ")

3.  In the ‘Show’ filter menu, select **Databases** to see all database instances managed by Enterprise Manager

  ![](images/ecm1_inventory_usage_details1.png " ")

4.  Analyze various database versions and number of instances for each version

5.  Explore pie chart to see the break-down of database inventory by color-code percentages. Also, in the **Graphical View**, choose **Trend** radio button to see the growth of given database instance over a period of time.

  ![](images/ecm1_inventory_usage_details2.png " ")

6.  In the Details table below, you will see details like

  - Database instance name
  - Host on which this database is located
  - Database type - cluster or single instance
  - Database version number
  - OS specific details like OS version, platform, etc.
  - Most importantly, LOB/Department information

    Details table gives more information of each Database instance for you to get a good understanding of number of database targets deployed on a given host with OS version. If your organization uses properties like Lifecycle, Line of Business or Department, then you will be able to determine the number of targets deployed for a given business unit

    Explore these features to get a good handle on Inventory and Usage Details

7.  Export inventory details to excel for reports. These inventory details can be exported to an excel file for offline analysis or sharing the report to management. With the excel report, you can filter based on the properties you are using to show department or line of business specific assets allocation and usage

  ![](images/ecm1_inventory_usage_details_report.png " ")

## **STEP 2:** One Time Database Comparison

### Overview

In this step, you will compare two database targets to determine configuration differences. One of the databases will act as reference target that aligns with your configuration policy. Your objective is to compare initialization parameters to ensure it is compliant with reference target

### Execution

1.  Log into your Enterprise Manager as **sysman** as indicated in the Prerequisites step if not already done.

2.  From the Enterprise menu, select Configuration, then select “Configuration & Drift Management”

  ![](images/ecm2_one_time_database_comparison_menu.png " ")

3.  Review the different types of comparisons supported by mouse-over on the info icon.

  ![](images/ecm2_comparison_drift_management.png " ")

4.	Select “Create Comparison” tab on the left side of the dashboard page. Click ‘Create Comparison’

  ![](images/ecm2_one_time_database_create-comparison.png " ")

5.  Choose the reference target that you want other targets to be compared with.

  ![](images/ecm2_one_time_database_comparison_ref_target1.png " ")

6.  Identify the reference target to compare other targets. To begin with, filter ‘Target Type’ to Database Instance

  ![](images/ecm2_one_time_database_comparison_ref_target2.png " ")

  ![](images/one_time_database_comparison_ref_target3.png " ")

7.  Select emrep.us.oracle.com as reference target

  ![](images/ecm2_one_time_database_comparison_ref_target4.png " ")

8.  Choose Database Instance Template for Comparison Template

  ![](images/ecm2_one_time_database_comparison_ref_target5.png " ")

9.  Provide a name for Comparison

  ![](images/ecm2_one_time_database_comparison_ref_target6.png " ")

10.  Add targets to be compared

  ![](images/ecm2_one_time_database_comparison_ref_target7.png " ")

11. Choose finance.subnet.vcn.oraclevcn.com target to compare with reference target

  ![](images/ecm2_one_time_database_comparison_ref_target8.png " ")

12. Click Submit. Comparison of the selected targets happens and below are the results

  ![](images/ecm2_one_time_database_comparison_results1.png " ")

13. Filter configurations items to review only Initialization Parameters

  ![](images/ecm2_one_time_database_comparison_results2.png " ")

  You can see the differences in the Initialization Parameters between the two targets.

  Under the target compared column, you will see few icons. The icons that appear in the view are mostly intuitive:
  - Equal sign means parameter properties are same across the reference and target compared
  - Not equal sign indicates parameter properties are different across the reference and target compared
  - A red box with 1 (left only) means that the comparison did not find a matching item to compare, this means 2nd target doesn’t have property configured to compare
  - A red box 2 (right only) means that the comparison did not find a matching item to compare to the second configuration


14. Now, let’s go to Comparison and Drift Management dashboard page for further analysis of results

  ![](images/ecm2_one_time_database_comparison_dashboard1.png " ")

15. In the dashboard page, donut chart for Comparison Overview dashlet gives you the summary result. Click on the donut chart to analyze one-time comparison result details.

  ![](images/ecm2_one_time_database_comparison_dashboard2.png " ")

15. Click on One-Time Comparison Results tab to review all corresponding comparison definitions

  ![](images/ecm2_one_time_database_comparison_dashboard3.png " ")

  You should see the comparison definition you created in this page.

16. Export the comparison results into an excel report for offline analysis. In the One-Time Comparison Results page, highlight the definition and choose Export Results. You can choose the specific results to export.

  ![](images/ecm2_one_time_database_comparison_report1.png " ")

17. Exported results in excel for offline analysis looks like:

  ![](images/ecm2_one_time_database_comparison_report2.png " ")

### Summary

In this step, you learned steps to compare two database targets to determine configuration differences. This one-time database (or any Enterprise Manager managed targets) comparison will help you quickly determine specific configuration changes when compared with reference configuration. This is very ideal for troubleshooting any target configuration parameters.

## **STEP 3:** Database Configuration Drift Management

### Overview

In this workshop, you will learn about continuous configuration drift monitoring of database targets against a reference target for initialization parameters using customized configuration monitoring template

1.  Log into your Enterprise Manager VM using the IP provided on your cheat sheet.

2.  Navigate to ***Enterprise >> Configuration >> Comparison & Drift Management***. Review the different types of comparisons supported.

  ![](images/ecm3_database_drift_menu.png " ")

  ![](images/ecm3_drift_management.png " ")

3.  Go to Templates library on the left panel and look for Database Instance Template as shown below.

  ![](images/ecm3_drift_comparison_template1.png " ")

4.  With Database Instance Template highlighted, choose ‘Create Like’ to create a copy of this template for further customization. Provide a unique name to the new template and click OK

  ![](images/ecm3_drift_comparison_template2.png " ")

5.  A complete copy of Database Instance template with unique name is created with all configuration items enabled, by default Highlight this new template and click Edit

  ![](images/ecm3_drift_comparison_template3.png " ")

6.  In this workshop, we will customize this template and monitor configuration drift for two configuration items. To begin with, uncheck all configuration items

  ![](images/ecm3_drift_comparison_template4.png " ")

7.  Select the following three configuration items only
    - Instance Caging Information
    - Instance Information
    - Initialization Parameters under Instance Information configuration item
    - Click Save

      ![](images/ecm3_drift_comparison_template5.png " ")

8.  A new customized configuration drift monitoring template is created. This template can be used for drift monitoring

  ![](images/ecm3_drift_comparison_template6.png " ")

9.  Go to Drift Results tab and create a drift definition

  ![](images/ecm3_create_drift_definiton1.png " ")

10. Click on Create Definition under Drift Management.
    - Choose Database Instance as the Target Type
    - Select the template created in the previous step
    - Click OK

      ![](images/ecm3_create_drift_definiton2.png " ")

11. In the drift definition details page, provide a unique name for the drift definition

  ![](images/ecm3_create_drift_definiton3.png " ")

12. Under Source Configuration, do the following

    -  Select ‘Latest Configuration’
    -  Click search to choose Source Target  

      ![](images/ecm3_create_drift_definiton4.png " ")

13. Choose emrep.us.oracle.com as your source target. Click on Select

  ![](images/ecm3_create_drift_definiton5.png " ")

14. You will see Source Target (***emrep.us.oracle.com***) is selected that acts as your reference target

  ![](images/ecm3_create_drift_definiton6.png " ")

15. Select ‘Save and Associate Targets’ to select targets to be monitored

  ![](images/ecm3_create_drift_definiton7.png " ")

16. Click on Add to select and associate a target to be monitored for drift

  ![](images/ecm3_create_drift_definiton8.png " ")

17. Select finance.subnet.vcn.oraclevcn.com as the target.

  ![](images/ecm3_create_drift_definiton9.png " ")

18. Click Select. You will see one target selected to be associated with drift definition.

  ![](images/ecm3_create_drift_definiton10.png " ")

19. Click OK. A pop-up will ask for confirmation to save association. Select Yes. This will start the association of this target to drift definition and initiated the configuration comparison and continuous drift monitoring.

  ![](images/ecm3_create_drift_definiton11.png " ")

20. Once you select Yes in the previous step, drift monitoring is in progress. Go to Dashboard page. After a minute, refresh the page to see the drift monitoring completed. You should see a new or updated donut chart under ‘Drifted Overview’ dashlet.

  ![](images/ecm3_drift_results_summary.png " ")

21. Click on Drift Results tab on the left panel (2nd tab from the top). This page will show results for all drift definitions managed by this instance of Enterprise Manager. Identify the drift definition you created for further analysis of configuration drift results.

  ![](images/ecm3_drift_results_details1.png " ")

22. Review the drift details. Click on the Drift Definition (ECM003-Drift-Demo – Drift) for detailed analysis of configuration drift

  ![](images/ecm3_drift_results_details2.png " ")

  You can see the differences in the Initialization Parameters between the two targets.

  Under the target compared column, you will see few icons. The icons that appear in the view are mostly intuitive:

    - Equal sign means parameter properties are same across the reference and target compared
    - Not equal sign indicates parameter properties are different across the reference and target compared
    - A red box with 1 (left only) means that the comparison did not find a matching item to compare, this means 2nd target doesn’t have property configured to compare
    - A red box 2 (right only) means that the comparison did not find a matching item to compare to the second configuration


23. Export the comparison results into an excel report for offline analysis. In the Drift Results page, highlight the definition and choose Export Results. You can choose the specific results to export.

  ![](images/ecm3_drift_report1.png " ")

24. Exported results in excel for offline analysis looks like:

  ![](images/ecm3_drift_report2.png " ")

### Summary

In this step, you learned about continuous configuration drift monitoring of database targets against a reference target for initialization parameters using customized configuration monitoring template. This can be customized to align with your policies. By establishing a configuration drift definition, you can continuously monitor any configuration changes that can be potentially secure risk and remediate the drift immediately.

## **STEP 4:** Database Security Compliance

### Overview

Compliance Management provides the ability to evaluate the compliance of targets and systems as they relate to business best practices for configuration, security, and storage.

In this workshop, you will setup a compliance standard for monitoring security compliance of Oracle Database target and analyze the compliance score and violations

Terminology Used in this Compliance specific workshop

#### Compliance Standard

A compliance standard is a collection of checks or rules that follow broadly accepted best practices. It is the Cloud Control representation of a compliance control that must be tested against some set of IT infrastructure to determine if the control is being followed. This ensures that IT infrastructure, applications, business services and processes are organized, configured, managed, and monitored properly. A compliance standard evaluation can provide information related to platform compatibility, known issues affecting other customers with similar configurations, security vulnerabilities, patch recommendations, and more. A compliance standard is also used to define where to perform real-time change monitoring.

A compliance standard is mapped to one or more compliance standard rules and is associated to one or more targets which should be evaluated.

#### Compliance Standard Rule

A compliance standard rule is a specific test to determine if a configuration data change affects compliance. A compliance standard rule is mapped to one or more compliance standards

### Execution

1.  Log into your Enterprise Manager VM using the IP provided on your cheat sheet.

2.  From the Enterprise menu,select Compliance, then select Library

  ![](images/ecm4_db_compliance_library_menu.png " ")

3.  Compliance Standards tab contains all standards for various supported targets.

  ![](images/ecm4_db_compliance_library1.png " ")

4.  In the Compliance Standards tab, search for “Basic Security Configuration for Oracle Database” standard

  ![](images/ecm4_db_compliance_library2.png " ")

5.  Select the Basic Security Configuration for Oracle Database standard

  ![](images/ecm4_db_compliance_library3.png " ")

6.  Create a copy of this database standard by clicking on ‘Create Like’. Give a unique name to the new standard you are creating to imply this is a new database standard. Also change the Author name per your preference

  ![](images/ecm4_db_compliance_library4.png " ")

7.  Review the various compliance rules for Basic Security standard grouped based on the configuration area. Click Save

  ![](images/ecm4_db_compliance_library5.png " ")

8.  A new custom database standard is created. Pop-up confirms the successful creation of this standards

  ![](images/ecm4_db_compliance_library6.png " ")

9.  Select the newly created custom database standard

  ![](images/ecm4_db_compliance_library7.png " ")

10. Click on “Associate Targets” to associate a database target for this newly created custom standard

  ![](images/ecm4_db_compliance_library8.png " ")

11. When Associate Target option is chosen, you will be taken to a page to add database targets.

  Click Add to add targets for association with this compliance standard

  ![](images/ecm4_db_compliance_library9.png " ")

12. Choose emrep.us.oracle.com target to check the compliance security posture

  ![](images/ecm4_db_compliance_library10.png " ")

13. The list of targets chosen will show up in the target association page as shown below

  ![](images/ecm4_db_compliance_library11.png " ")

14. Click OK and a pop-up shows up to confirm association. Click Yes to save the association which initiates compliance check on this target by executing all the compliance rules associated with this compliance standard

  ![](images/ecm4_db_compliance_library12.png " ")

15. To check if the compliance check is complete, click the target number in ‘Association Count’ column.

  ![](images/ecm4_db_compliance_library13.png " ")

16. If the Transfer Status indicates ‘Successfully Done’, it means compliance check is complete. Click cancel button

  ![](images/ecm4_db_compliance_library14.png " ")

17. Go to Compliance Results page to check the compliance posture

  ![](images/ecm4_db_compliance_results1.png " ")

  ![](images/ecm4_db_compliance_results2.png " ")

18. Under Compliance Summary panel at the bottom, explore various tabs to get an understanding of Frameworks, Standards and Targets level compliance. For any given standard, if there are Critical, Warning or Minor Warnings, click on the violation number to see more details of the violation.

  ![](images/ecm4_db_compliance_results3.png " ")

  For each violation, you will see details like last evaluation date, rule name violated and rationale for the violation.

19. Highlight and click on the standard that you created in the previous steps to review the overall compliance score, target evaluations and violation details

  ![](images/ecm4_db_compliance_results4.png " ")

  All these will give you a security posture of database target


## **STEP 5:** Host Security Compliance

### Overview

  Compliance Management provides the ability to evaluate the compliance of targets and systems as they relate to business best practices for configuration, security, and storage.

  In this workshop, you will setup a compliance standard for monitoring security compliance of Oracle Linux host target and analyze the compliance score and violations

  Terminology Used in this Compliance specific workshop

#### Compliance Standard

  A compliance standard is a collection of checks or rules that follow broadly accepted best practices. It is the Cloud Control representation of a compliance control that must be tested against some set of IT infrastructure to determine if the control is being followed. This ensures that IT infrastructure, applications, business services and processes are organized, configured, managed, and monitored properly. A compliance standard evaluation can provide information related to platform compatibility, known issues affecting other customers with similar configurations, security vulnerabilities, patch recommendations, and more. A compliance standard is also used to define where to perform real-time change monitoring.

  A compliance standard is mapped to one or more compliance standard rules and is associated to one or more targets which should be evaluated.

#### Compliance Standard Rule

  A compliance standard rule is a specific test to determine if a configuration data change affects compliance. A compliance standard rule is mapped to one or more compliance standards

### Execution

1.  Log into your Enterprise Manager VM using the IP provided on your cheat sheet.

2.  From the Enterprise menu, select Compliance, then select Library

    ![](images/ecm5_host_compliance_menu.png " ")

3. Search for Secure Configuration for Host and select that standard

  ![](images/ecm5_host_compliance_library1.png " ")

4. Create a copy of this host standard by clicking on ‘Create Like’. Give a unique name to the new standard you are creating to imply this is a new host standard. Also change the Author name per your preference

  ![](images/ecm5_host_compliance_library2.png " ")

5. Review the various compliance rules for Basic Security standard grouped based on the configuration area. Click Save

  ![](images/ecm5_host_compliance_library3.png " ")

6. A new custom host standard is created. Pop-up confirms the successful creation of this standards

  ![](images/ecm5_host_compliance_library4.png " ")

7. Select the newly created custom host standard

  ![](images/ecm5_host_compliance_library5.png " ")

8. Click on “Associate Targets” to associate a host target for this newly created custom standard

  ![](images/ecm5_host_compliance_library6.png " ")

9. When Associate Target option is chosen, you will be taken to a page to add database targets

  ![](images/ecm5_host_compliance_library7.png " ")

10. Choose emcc.marketplace.com target to check the compliance security posture

  ![](images/ecm5_host_compliance_library8.png " ")

11. The list of targets chosen will show up in the target association page as shown below

  ![](images/ecm5_host_compliance_library9.png " ")    

12. Click OK and a pop-up shows up to confirm association. Click Yes to save the association which initiates compliance check on this target by executing all the compliance rules associated with this compliance standard

  ![](images/ecm5_host_compliance_library10.png " ")    

13. Go to Compliance Results page to check the compliance posture

  ![](images/ecm5_host_compliance_results1.png " ")

  ![](images/ecm5_host_compliance_results2.png " ")

14. Under Compliance Summary panel at the bottom, explore various tabs to get an understanding of Frameworks, Standards and Targets level compliance. For any given standard, if there are Critical, Warning or Minor Warnings, click on the violation number to see more details of the violation.

  ![](images/ecm5_host_compliance_results3.png " ")

  All these will give you a security posture of host target


### Summary

With this step, you got a hands-on experience in creating a custom framework to monitor the security compliance of heterogeneous targets (Database and Host, this example). This will help you assess overall security compliance of all
Enterprise Manager managed targets from one aggregated view. And if required, you can drill down into each standard to assess details of target specific security compliance

This completes the Lab.

Thank You!

## Want to Learn More?

  - [Oracle Enterprise Manager](https://www.oracle.com/enterprise-manager/)
  - [Enterprise Manager Documentation Library](https://docs.oracle.com/en/enterprise-manager/index.html)
  - [Database Lifecycle Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/lifecycle.html)

## Acknowledgements
- **Author** - Harish Niddagatta, Oracle Enterprise Manager Product Management
- **Adapted for Cloud by** -  Rene Fontcha, Master Principal Solutions Architect, NA Technology
- **Last Updated By/Date** - Shefali Bhargava - Enterprise Manager Product Management, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the Log In button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*. Please include your workshop name and lab name. You can also include screenshots and attach files. Engage directly with the author of the workshop.
If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
