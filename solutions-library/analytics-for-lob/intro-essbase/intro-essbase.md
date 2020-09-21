# Introduction to Essbase

## Introduction

This lab provides an introduction to Oracle Essbase and how it can be used to enhance business analytics and data management. Through this lab, you will understand the overall Essbase architecture, as well as perform the prerequisites for the subsequent Essbase labs in this workshop.

Estimated Lab Time: 15 minutes.

### Objectives

* Getting introduced to Essbase
* Understanding the Essbase architecture
* Installing Smart View and Cube Designer plugins

### Prerequisites

This lab will require the following -

* An Oracle public cloud tenancy where you have the resources available to provision an ATP instance with 1 OCPU, an Essbase instance with 1 OCPU.

* [Smartview Plugin](https://docs.oracle.com/en/cloud/paas/analytics-cloud/essug/download-and-run-smart-view-installer.html) (Steps provided in this lab)


## **Step 1:** Features of Oracle Essbase

1. Oracle Essbase provides a complete set of tools and features for deriving and sharing data insights.

2. Both large organizations and small teams can share data easily, without the need to manage or consolidate multiple versions of spreadsheets, and quickly perform ad hoc analysis of the spreadsheet data.

3. Application developers can utilize interfaces that enable them to extend, customize, and embed rich analytic experiences in the application flow.

4. Oracle Essbase, is a multi-dimensional engine that allows you to extract data from any source, handle real-time data and collaborate easily.

5. With Essbase you can create and manage Essbase applications from Microsoft Excel by using Cube Designer.

6. Create connections and data sources for drill-through, data loads, and dimension builds.

7. We can use Essbase to collect collaborative data, create scenarios, and perform what-if analysis using Smart View.

## **Step 2:** Essbase Architecture on OCI

  ![](./images/notionalarchitecture.png "")

## **Step 3:** Working with Essbase

During our workshop we will help a fictitious company Dynamic Corporation to perform financial analysis. Dynamic Corp. is a high-tech manufacturer of hard disk drives. It is headquartered in California, Bay Area. Dynamic Corp., has its operations spread across multiple regions. Various departments within Dynamic Corp. performs financial analysis.

While doing financial analysis the number of reports developed are as follows:

* Monthly sales revenues by product , by customer
* Current year actual, budget , forecast data
* Customer sales by region            
* Current year actual and budget data
* Monthly product development reports
* Details of company cost structures
* Write back for what-if analysis

Dynamic Corp. extensively use Microsoft Excel application for Financial reporting. Financial analyst at Dynamic Corp. are well versed with use of Excel. But with growing business they find it difficult to manage reporting with excel. They found out Excel is a widely used tool for two dimensional data analysis, but presents enlisted limitations when used for multidimensional data analysis -

1. Disconnected
2. Data Security Risks
3. Error Prone
4. Scalability issues
5. Lack of audit trails/log mechanism
6. Tedious and multi-step calculations

To overcome these limitations and to proceed with an efficient and precise multi-dimensional data analysis, Essbase comes to the rescue. Essbase can be defined as a multidimensional database (comparable to Excel pivot table) offering following benefits -

• One single location for data – all analysts are using the same data, business drivers, and metrics for calculating departmental budgets.

• Standardization of Business Drivers – budget drivers can be loaded and calculated by the administrator so that all budgets are using the same methodology.

• Security – the administrator can apply security to certain dimensions and members, giving users access to only the data that they are responsible for. This allows more participation from the field in the budget process.

With the above stated benefits, it’s certainly worthwhile to understand the nitty-gritty of Essbase, its benefits, features and applications. This lab intends towards providing a holistic view of Essbase, its features, and applications.


Note: The steps going forward will have to followed in a Windows operating system

## **Step 4:** Installing Smart View Plugin

#### Smart View Prerequisites
1. The latest release of Smart View
2. On the Oracle Technology Network Downloads tab, the latest release for Smart View is always certified.
3. Microsoft Office 2010, 2013 or 2016
4. .NET Framework 4.0

**Note: You must use .NET Framework 4.5 if you are installing Smart View from Essbase without saving the installer locally.**

#### Installation Steps
1. Navigate to [link](https://www.oracle.com/middleware/technologies/epm-smart-view-downloads.html) to download latest Smart View for office.
2. On the Smart View download page on Oracle Technology Network, click Download Now, and then click Accept License Agreement. If the Oracle sign-in page is displayed, then sign in with your Oracle user name (usually your email address) and password.
3. Follow the steps for your browser to download the .zip file, and save it to a folder on your computer.
4. Go to the folder that you used in Step 5, and then double click smartview.exe to start the installation wizard.
5. Select a destination folder for Smart View, and then click OK. For new installations, Smart View is installed by default in: ``C:\Oracle\smartview``
9. If you are upgrading an installation of Smart View, then the installer defaults to the folder where you previously installed Smart View.
10. When the installation is complete, click OK.

You may proceed to the next lab.


## Acknowledgements

* Author - NATD Cloud Engineering - Bangalore Analytics (Aparana Gupta, Sushil Mule, Sakethvishnu D, Mitsu Mehta, Fabian Reginold, Srikrishna Kambar)
* Reviewed by - Ashish Jain, Product Management
* Last Updated By/Date - Jess Rein, Cloud Engineer, Sept 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
