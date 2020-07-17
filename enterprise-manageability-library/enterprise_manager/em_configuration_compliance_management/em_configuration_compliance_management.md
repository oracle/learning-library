# Database Configuration and Compliance Management
## Introduction

### Objectives

The objective of this workshop is to highlight Oracle Enterprise Manager Cloud Control 13c’s Lifecycle Management capabilities related to configuration and security compliance management of managed targets. Each activity focuses on different capabilities for an administrator.

### Background
The estimated time to complete the lab is 60 minutes as further detailed below

| Step No.                                      | Feature                                                                 | Approx. Time | Details                                                                                                                                                                                    | Value proposition                                                                                                   |
|-----------------------------------------------------------|-------------------------------------------------------------------------|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| 1                                                         | Inventory & Usage details                                               | 10 minutes   | IT Manager wants to get an inventory of all existing databases managed by Enterprise Manager including different versions of databases, number of instances deployed over a period of time | Reduce number of different configuration sets and increase standardization across the data center.                  |
| 2                                                         | One-time database comparison                                            | 10 minutes   | Compare latest reference configuration to one or more targets to determine the configuration differences                                                                                   | Validate the configuration of new database provisioned aligns with IT configuration policy                          |
| 3                                                         | Database configuration drift management                                 | 20 minutes   | Compare latest or saved target configuration to one or more targets.                                                                                                                       | Monitor databases in your organization for any configuration drift, remediate to align with reference configuration |
| 4                                                         | Database and host security compliance using custom compliance framework | 20 minutes   | Aggregated security compliance framework and standard for Oracle Database 12c and Oracle Host targets                                                                                      | Monitor security compliance for heterogenous targets from one customized dashboard.                                 |

### Prerequisites

This lab assumes you have completed the following labs:
* [Lab 1: Login to Oracle Cloud](https://rfontcha.github.io/learning-library/enterprise-manageability-library/enterprise_manager/freetier/?lab=lab-1-login-oracle-cloud)
* [Lab 2: Generate SSH Key](https://rfontcha.github.io/learning-library/enterprise-manageability-library/enterprise_manager/freetier/?lab=lab-2-generate-ssh-key)
* [Lab 3: Environment Setup](https://rfontcha.github.io/learning-library/enterprise-manageability-library/enterprise_manager/freetier/?lab=lab-3-environment-setup)

Prior to starting, you will need:
- EM Instance Public IP address
- OMS Console URL: http://\{EM Instance Public IP\}:7803/em
- OMS super-user Credentials:
    -   Username: **sysman**
    -   password: **welcome1**
#### Login to OMS Console
Log into your Enterprise Manager VM using the Public IP of your EM instance and the super-user credentials as indicated above”

You may see an error on the browser while accessing the Web Console - “*Your connection is not secure*”. Ignore and add the exception to proceed. Access this URL and ensure that you are able to access Enterprise Manager Web Console.

## Step 1: Inventory & Usage Details

### Overview

IT Manager wants to get an inventory of all existing databases managed by Enterprise Manager including different versions of databases, number of instances deployed over a period of time. This is to reduce number of different configuration sets and increase standardization across the data center.

All the items in this step are read-only, primary goal is to learn about inventory usage details within Enterprise Manager for all supported targets

### Execution

1.  Log into your Enterprise Manager as indicated in the Prerequisites step if not already done.

2.  From the Enterprise menu, select Configuration, then select Inventory and  Usage Details

![](images/0e4c2e20dec851fcdf23fd2e92bdee7a.png)

3.  In the ‘Show’ filter menu, select **Databases** to see all database instances managed by Enterprise Manager

![](images/cd409c11afa638eb7a1ab8f7cbc4f015.png)

4.  Analyze various database versions and number of instances for each version

5.  Explore pie chart to see the break-down of database inventory by color-code percentages. Also, in the **Graphical View**, choose **Trend** radio button to see the growth of given database instance over a period of time.

![](images/f79cd8ba7800098fa43363b5d4329323.png)

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

![](images/c94cba301516e0ea135b3e9cb66e12cc.png)

## Step 2: One Time Database Comparison

### Overview

In this step, you will compare two database targets to determine configuration differences. One of the databases will act as reference target that aligns with your configuration policy. Your objective is to compare initialization parameters to ensure it is compliant with reference target

### Execution

1.  Log into your Enterprise Manager as **sysman** as indicated in the Prerequisites step if not already done.

2.  Navigate to ***Enterprise >> Configuration >> Comparison & Drift Management***

![](images/37238ad74bd47f814d428587fb1c6113.png)

3.  Review the different types of comparisons supported. Select “***Create  Comparison***” under One-Time Comparison to define one-time comparison

![](images/2f5e4a38007bb1c73d2910412d992b96.png)

4.  Choose the reference target that you want other targets to be compared with.

![](images/67ae37025024fc58b2294a0ab5e76191.png)

5.  Identify the reference target to compare other targets. To begin with, filter ‘Target Type’ to Database Instance

![](images/0b8231131420f895fa28a9eda5adb63c.png)

![](images/ca8b1d0f62b13c9d18bce9d9a2fbe41f.png)

6.  Select emrep.us.oracle.com as reference target

![](images/a9eb9557d92b44b49769db5703014f98.png)

7.  Choose Database Instance Template for Comparison Template

![](images/3ee284fe8bcfb393489d04a18e21719a.png)

8.  Provide a name for Comparison

![](images/684bb410e1d774de4eeb8e85f83992b2.png)

9.  Add targets to be compared

![](images/684bb410e1d774de4eeb8e85f83992b2.png)

10. Choose finance.subnet.vcn.oraclevcn.com target to compare with reference target

![](images/74b94658bae8dcf82b789f3913ff708f.png)

11. Click Submit. Comparison of the selected targets happens and below are the results

![](images/7d1ae7e5e1825760327a60ca6d5e47b0.png)

12. Filter configurations items to review only Initialization Parameters

![](images/a790e239f5134908f99d8d95102aa47c.png)

You can see the differences in the Initialization Parameters between the two targets.

Under the target compared column, you will see few icons. The icons that appear in the view are mostly intuitive:
- Equal sign means parameter properties are same across the reference and target compared
- Not equal sign indicates parameter properties are different across the reference and target compared
- A red box with 1 (left only) means that the comparison did not find a matching item to compare, this means 2nd target doesn’t have property configured to compare
- A red box 2 (right only) means that the comparison did not find a matching item to compare to the second configuration

13. Now, let’s go to Comparison and Drift Management dashboard page for further analysis of results

![](images/7b1f049a9f48cd24033a0695ef8b831f.png)

14. In the dashboard page, there are few tabs on the left side of the screen. One of the tab is a page for one-time comparison results

![](images/6fd24a9cc9f980bd16eef6d9819badbc.png)

15. Click on One-Time Comparison Results tab to review all corresponding comparison definitions

![](images/a96aeaccaa80489f6a038e8e80e14a56.png)

You should see the comparison definition you created in this page.

16. Export the comparison results into an excel report for offline analysis. In the One-Time Comparison Results page, highlight the definition and choose Export Results. You can choose the specific results to export.

![](images/72b1417508bfb8aed1f308aabb01f30b.png)

17. Exported results in excel for offline analysis looks like:

![](images/0c50af741770cf96df9c8f65a6a931bc.png)

### Summary

In this step, you learned steps to compare two database targets to determine configuration differences. This one-time database (or any Enterprise Manager managed targets) comparison will help you quickly determine specific configuration changes when compared with reference configuration. This is very ideal for troubleshooting any target configuration parameters.

## Step 3: Database Configuration Drift Management

### Overview

In this workshop, you will learn about continuous configuration drift monitoring of database targets against a reference target for initialization parameters using customized configuration monitoring template

1.  Log into your Enterprise Manager VM using the IP provided on your cheat sheet.

2.  Navigate to ***Enterprise >> Configuration >> Comparison & Drift Management***. Review the different types of comparisons supported.

![](images/133fbb62c871d1ccb0dc8b1f794d4544.png)

![](images/b2083f388a80e86887ca1b4172099834.png)

3.  Go to Templates library on the left panel and look for Database Instance Template as shown below.

![](images/5adb3c98058d26b2f4a293b2accf21c3.png)

4.  With Database Instance Template highlighted, choose ‘Create Like’ to create a copy of this template for further customization. Provide a unique name to the new template and click OK

![](images/bd2caacd4e9de95a80de2e0ff60e903a.png)

5.  A complete copy of Database Instance template with unique name is created with all configuration items enabled, by default Highlight this new template and click Edit

![](images/2490137204f36d4284fba0011681286a.png)

6.  In this workshop, we will customize this template and monitor configuration drift for two configuration items. To begin with, uncheck all configuration items

![](images/41906277250d12aeb21e2ecb60b617fa.png)

7.  Select the following three configuration items only
  - Instance Caging Information
  - Instance Information
  - Initialization Parameters under Instance Information configuration item
  - Click Save

![](images/357e138f7e4e83c065bd3a602c21284f.png)

8.  A new customized configuration drift monitoring template is created. This template can be used for drift monitoring

![](images/8806e0150c8b23ad28107645a68f902a.png)

9.  Go to Overview tab to create Drift Management definition

![](images/69773287e3949b98c6f396a9bba33fa7.png)

10. Click on Create Definition under Drift Management.
  - Choose Database Instance as the Target Type
  - Select the template created in the previous step
  - Click OK

![](images/49133b1d7369795d4928bab7fd4f842b.png)

11. In the drift definition details page, provide a unique name for the drift definition

![](images/d198d1081fd4ae5035dfdb0757edf18f.png)

12. Under Source Configuration, do the following

  -  Select ‘Latest Configuration’
  -  Click search to choose Source Target  

![](images/bd6ec634cc1a0ff215b5344fcfdbfc07.png)

13. Choose emrep.us.oracle.com as your source target. Click on Select

![](images/a1795cc618351de79a2c62259efe0fd8.png)

14. You will see Source Target (***emrep.us.oracle.com***) is selected that acts as your reference target

![](images/d1b9cfa33b29fb02a4437553945dcf14.png)

15. Select ‘Save and Associate Targets’ to select targets to be monitored

![](images/845ceef6b0575df974d16ca15ea3668a.png)

16. Click on Add to select and associate a target to be monitored for drift

![](images/54c89f117d23109909ab91c600f0a3c8.png)

17. Select finance.subnet.vcn.oraclevcn.com as the target.

![](images/4d5efec3df75acd856bed601ee3cc553.png)

18. Click Select. You will see one target selected to be associated with drift definition.

![](images/411c89c5c0a697cd0b27c573c51abe1d.png)

19. Click OK. A pop-up will ask for confirmation to save association. Select Yes. This will start the association of this target to drift definition and initiated the configuration comparison and continuous drift monitoring.

![](images/ce95e718210e8754fbb7e43e1d38b224.png)

20. Once you select Yes in the previous step, you will come to main dashboard page. Drift monitoring has already been initiated. After a minute, refresh the page to see the drift monitoring completed. You should see an update in the ‘Drifted Targets’ widget in the main dashboard

![](images/50df13b44d9331cf225a8f25d0e332c1.png)

21. Click on Drift Results tab on the left panel (2nd tab from the top). This page will show results for all drift definitions managed by this instance of Enterprise Manager. Identify the drift definition you created for further analysis of configuration drift results.

![](images/f53f930cf1d3c26a0835a549dcb2d6e0.png)

22. Review the drift details. Click on the Drift Definition (ECM003-Drift-Demo – Drift) for detailed analysis of configuration drift

![](images/24d11534484b24b7f0dc8f3b17e16bdd.png)

You can see the differences in the Initialization Parameters between the two targets.

Under the target compared column, you will see few icons. The icons that appear in the view are mostly intuitive:

- Equal sign means parameter properties are same across the reference and target compared
- Not equal sign indicates parameter properties are different across the reference and target compared
- A red box with 1 (left only) means that the comparison did not find a matching item to compare, this means 2nd target doesn’t have property configured to compare
- A red box 2 (right only) means that the comparison did not find a matching item to compare to the second configuration

23. Export the comparison results into an excel report for offline analysis. In the Drift Results page, highlight the definition and choose Export Results. You can choose the specific results to export.

![](images/8d3848466300651212e5a3ec61caac04.png)

24. Exported results in excel for offline analysis looks like:

![](images/41c1a47cf0799f69a1837f7d51bab9bb.png)

### Summary

In this step, you learned about continuous configuration drift monitoring of database targets against a reference target for initialization parameters using customized configuration monitoring template. This can be customized to align with your policies. By establishing a configuration drift definition, you can continuously monitor any configuration changes that can be potentially secure risk and remediate the drift immediately.

## Step 4: Database and Host Security Compliance

### Overview

Compliance Management provides the ability to evaluate the compliance of targets and systems as they relate to business best practices for configuration, security, and storage.

In this workshop, you will define and manage compliance framework, two different compliance standards, and corresponding compliance standard rules for managing security compliance of database and host targets.

Terminology Used in this Compliance specific workshop

#### Compliance Framework

A compliance framework is an organized list of control areas that need to be followed for a company to stay in compliance in their industry. Enterprise Manager uses compliance frameworks as a pyramid structure to map standards and rules to the control areas they affect. Compliance frameworks are hierarchical to allow for direct representation of these industry frameworks.

A single framework control area maps to one or more compliance standards. The outcome of these compliance standard evaluations results in a score for the given framework area.

#### Compliance Standard

A compliance standard is a collection of checks or rules that follow broadly accepted best practices. It is the Cloud Control representation of a compliance control that must be tested against some set of IT infrastructure to determine if the control is being followed. This ensures that IT infrastructure, applications, business services and processes are organized, configured, managed, and monitored properly. A compliance standard evaluation can provide information related to platform compatibility, known issues affecting other customers with similar configurations, security vulnerabilities, patch recommendations, and more. A compliance standard is also used to define where to perform real-time change monitoring.

A compliance standard is mapped to one or more compliance standard rules and is associated to one or more targets which should be evaluated.

#### Compliance Standard Rule

A compliance standard rule is a specific test to determine if a configuration data change affects compliance. A compliance standard rule is mapped to one or more compliance standards

### Execution

1.  Log into your Enterprise Manager VM using the IP provided on your cheat sheet.

2.  From the Enterprise menu,select Compliance, then select Library

![](images/f0cb7078dc7b26619211bd41d5059895.png)

3.  Compliance Standards tab contains all standards for various supported targets.

![](images/0ea94ae830a631ed2792d5d0e423c04d.png)

4.  In the Compliance Standards tab, search for “Basic Security Configuration for Oracle Database” standard

![](images/71e078511a08cd3e92ace897af69bccf.png)

5.  Select the Basic Security Configuration for Oracle Database standard

![](images/ccc43e0a40d0e92ce6842d823a3dd440.png)

6.  Create a copy of this database standard by clicking on ‘Create Like’. Give a unique name to the new standard you are creating to imply this is a new database standard. Also change the Author name per your preference

![](images/8ebd9bdeea25fac70a54faedae9f2297.png)

7.  Review the various compliance rules for Basic Security standard grouped based on the configuration area. Click Save

![](images/e29387a24b8fd553e9f6087ff8550f56.png)

8.  A new custom database standard is created. Pop-up confirms the successful creation of this standards

![](images/383384626faa8bf8a1174552f6d17f64.png)

9.  Select the newly created custom database standard

![](images/9049e94e535f59ecea4406e0a4f40657.png)

10. Click on “Associate Targets” to associate a database target for this newly created custom standard

![](images/0f0ec092fe24f44635306284346619e3.png)

11. When Associate Target option is chosen, you will be taken to a page to add database targets.

Click Add to add targets for association with this compliance standard

![](images/4b8f9f5fd15188e7d3031bd40bce4815.png)

12. Choose emrep.us.oracle.com target to check the compliance security posture

![](images/bb10defd8e64f1a4e1a5b75e1915e7c3.png)

13. The list of targets chosen will show up in the target association page as shown below

![](images/0c6ca16ce7541f7e76ffac92330d7663.png)

14. Click OK and a pop-up shows up to confirm association. Click Yes to save the association which initiates compliance check on this target by executing all the compliance rules associated with this compliance standard

![](images/bd66c09acb247b604a6a79ee6e22f21a.png)

15. To check if the compliance check is complete, click the target number in ‘Association Count’ column.

![](images/e9ed8e51970bf8eec4ad0d22fed2be47.png)

16. If the Transfer Status indicates ‘Successfully Done’, it means compliance check is complete. Click cancel button

![](images/19633b4dcc6db721efc5600ecb34e22c.png)

17. Go to Compliance Results page to check the compliance posture

![](images/c227c249d1d7d2011963b5bcc4787769.png)

18. Highlight the standard that you created in the previous steps to review the overall compliance score, target evaluations and violation details

![](images/b30d166f8e80094721414302dc094979.png)

19. Click on the Compliance Standard name to see the details of the result

![](images/e9e704632617015555c81562eb1dc772.png)

20. Explore different tabs in this results page. Result By Compliance Standard Rule tab gives you more details of each compliance rule executed on this selected target

![](images/6630856a69efd3ee50512c8e15c171d1.png)

All these will give you a security posture of database target

21. Now, let’s go repeat these steps for host target. Go to Compliance Library page

![](images/8a928ec977207423de129f1b39ea0d94.png)

22. Search for Secure Configuration for Host and select that standard

![](images/90521cbcf04cce5a7c62c2f7e82bf08b.png)

23. Create a copy of this host standard by clicking on ‘Create Like’. Give a unique name to the new standard you are creating to imply this is a new host standard. Also change the Author name per your preference

![](images/5ac00c32f35425ddbb5185748e0da5c1.png)

24. Review the various compliance rules for Basic Security standard grouped based on the configuration area. Click Save

![](images/eb67f99226f08715d5e5bf45361d00af.png)

25. A new custom host standard is created. Pop-up confirms the successful creation of this standards

![](images/1cf2a908e466c167ad930e3b820b4c5b.png)

26. Select the newly created custom host standard

![](images/65113057e1aceb89a1c3469735413874.png)

27. Click on “Associate Targets” to associate a host target for this newly created custom standard

![](images/764fe3a6ea3c27f3c19a6472a678a960.png)

28. When Associate Target option is chosen, you will be taken to a page to add database targets

![](images/d292fa6f56ed092b61398c2abc864e94.png)

29. Choose emcc.marketplace.com target to check the compliance security posture

![](images/2c75dfc83689f5988b52ae1dc841eb00.png)

30. The list of targets chosen will show up in the target association page as shown below

![](images/d798f57aea9022efa472466690ce2152.png)    

31. Click OK and a pop-up shows up to confirm association. Click Yes to save the association which initiates compliance check on this target by executing all the compliance rules associated with this compliance standard

![](images/a03a851c889aab744c8895fada74fca3.png)    

32. Go to Compliance Results page to check the compliance posture

![](images/d5c600c49dcac9b010d29b9788fa556d.png)

33. Highlight the standard that you created in the previous steps to review the overall compliance score, target evaluations and violation details

![](images/e69faecf29da41db8cbc94f18ca37fe5.png)

34. Click on the Compliance Standard name to see the details of the result

![](images/1e87046f07a787488fa2b15058854563.png)

35. Now, let’s create Compliance Framework to include the two standards you created so far. Objective here is to look at aggregated compliance score of both database and host at framework level. Go to Compliance Library page

![](images/e340f410d134688663c985c8f582bd27.png)

36. Go to Compliance Framework tab

![](images/e175c37661cf28b335e4bec317c461b2.png)

37. Create a new framework. Click Create, provide a unique name for the framework and author

![](images/3fa0c8b11aad2266faddbcdbb1f224e6.png)    

38. Click Continue. This will take you to a new page so that compliance standards can be added

![](images/7a91fe3c117e4011401f81ac8cc7a52e.png)

39. With right-mouse button on the framework name in the left panel, you will see a menu list for adding standards.

![](images/2468ca941d17cacc23d7bce5810d7e10.png)

40. Click Add Standard that will pop-up a window to select the standards to add

![](images/75775a99c565214542a8940d30819d11.png)

41. Filter the standards by choosing Database Instance in “Applicable To” menu. Choose the database compliance standard you created in the previous steps

![](images/25e1f78e471ea906fff67b5737cb28bc.png)

42. Repeat the above steps for adding

![](images/e1d1f0ee030f384e30b10220583113ad.png)

![](images/bbd99e3a29d171104127c80af5229114.png)

43. Now both database and host custom compliance standards have been added to the new custom compliance framework as shown below

![](images/744f3f8412ae9ac692fa878fdcf15fd6.png)

44. Click Save. A pop-up confirms the successful creation of custom framework

![](images/dbb1791108b4cf36102470ff53f04709.png)

45. Since two compliance standards are associated to this new framework, you can review the compliance results at framework level. Go to compliance results page

![](images/f697ca1790163653dea6ae04ba99b912.png)

46. In the results page, go to Compliance Framework tab to see the framework you created. You see an aggregated compliance score at framework level. This is an aggregation of both database and host standard you added to this framework.

![](images/914692ccab1d8d4a3aa636e937dd3989.png)

47. Click on the framework name to see details of the results. You can see the results at target level

![](images/86b6af426fcb18ba52d217f84ac99589.png)

48. You can also look at results at compliance standard level by choosing the standard tab. You will be able to see compliance score for each standard

![](images/4caed891e78778403a46b0dd6eff9d54.png)

49. You can also step into standard level score from the left panel as shown below for database standard

![](images/7ce67aa61ceb1570b24e1d1ee75d207b.png)

50. And below is the compliance score and details for the host standard

![](images/51156affe21b950ea871f65e68498f4b.png)

### Summary

With this step, you got a hands-on experience in creating a custom framework to monitor the security compliance of heterogeneous targets (Database and Host, this example). This will help you assess overall security compliance of all
Enterprise Manager managed targets from one aggregated view. And if required, you can drill down into each standard to assess details of target specific security compliance

This completes the Lab

Thank You!

## Want to Learn More?

  - [Oracle Enterprise Manager](https://www.oracle.com/enterprise-manager/)
  - [Enterprise Manager Documentation Library](https://docs.oracle.com/en/enterprise-manager/index.html)
  - [Database Lifecycle Management](https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/lifecycle.html)

## Acknowledgements
* **Author** - Harish Niddagatta, Oracle Enterprise Manager Product Management
* **Adapted for Cloud by** -  Rene Fontcha, Oracle Enterprise Manager Sales Engineering
* **Last Updated By/Date** - Rene Fontcha, July 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
