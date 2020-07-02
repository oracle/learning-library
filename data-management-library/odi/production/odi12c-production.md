# Oracle Data Integrator 12c: Deploying Integrated Applications

## Deploying Integrated Applications
This chapter describes how to run the Load Sales Administration Package in a production environment.
This chapter includes the following sections:
  * Introduction
  * Scenario Creation
  * Run the Scenario
  * Follow the Execution of the Scenario

## Step 1: Introduction
The automation of the data integration flows is achieved by sequencing the execution of the different steps (mappings, procedures, and so forth) in a package and by producing a production scenario containing the ready-to-use code for each of these steps.
Lab *Working with Packages* describes the first part of the automation process: sequencing the execution of the different processes in a Package.

This Lab describes the second part: how to produce a scenario that runs automatically the Load Sales Administration Package in a production environment.

## Step 2: Scenario Creation
To generate the LOAD\_SALES\_ADMINISTRATION scenario that executes the Load Sales Administration Package:

1.  In the Project accordion, expand Sales Administration and then Packages.

2.  Right click on Load Sales Administration and select **Generate Scenario...** The New Scenario dialog appears

  ![](./images/new_scenario_dialog.png)

3.  The Name and Version fields of the Scenario are preset. Leave these values and click **OK**.

4.  Oracle Data Integrator processes and generates the scenario. The new scenario appears on the Scenarios tab of the Package Editor and in the Demo Project:

  ![](./images/load_sales_admin.png)

## Step 3 Run the Scenario
Scenarios can be executed in several ways:
  * Executing a Scenario from ODI Studio
  * Executing a Scenario from a Command Line
  * Executing a Scenario from a Web Service.

This Lab describes how to execute a scenario from ODI Studio. See *Executing a Scenario* in the *Oracle Fusion Middleware Developer\'s Guide for Oracle Data Integrator* for more information about how to execute a scenario from a command line and a web service.

**Executing a Scenario from ODI Studio**
You can start a scenario from Oracle Data Integrator Studio from Designer or Operator Navigator.

To start the LOAD\_SALES\_ADMINISTRATION scenario from Oracle Data Integrator Studio:

1. Select the LOAD\_SALES\_ADMINISTRATION scenario in the Projects accordion (in Designer Navigator) or the Load Plans and Scenarios accordion (in Designer and Operator Navigator).

2. Right-click, then select **Run**.

3. In the Execution Dialog, leave the default settings and click **OK**.

4.  The Session Started Information Dialog is displayed. Click **OK**. The scenario is executed.

## Step 4: Follow the Execution of the Scenario
You can review the scenario execution in Operator Navigator, and find the same results as those obtained when the package was executed as described in Lab *Run the Package*.
It is also possible to review the scenario execution report in Designer Navigator.

To view the execution results of the LOAD\_SALES\_ADMINISTRATION scenario in Designer Navigator:

1. In the Projects accordion in Designer Navigator, expand the Scenarios node under the Load Sales Administration package.

2. Refresh the displayed information by clicking **Refresh** in the Designer Navigator toolbar menu.

3.  The log for the execution session of the LOAD\_SALES\_ADMINISTRATION scenario appears as shown:

  ![](./images/load_sales_admin_log.png)

## Step 5: Summary
This chapter provides information for going further with Oracle Data Integrator. This chapter includes the following sections:

Congratulations! You have now completed an ETL project and learned about the fundamentals of Oracle Data Integrator.

In this Getting Started guide, you learned how to:

  * Create mappings to load the data from the *Orders Application* and *Parameters* applications into the *Sales Administration* data warehouse (Lab: *Working with Mappings* *1&2*)
  * Define and implement data integrity rules in the *Orders Application* application (Lab: *Implementing Data Quality Control*)
  * Sequence your developments (Lab: *Working with Packages*)
  * Prepare your process for deployment (Lab: *Deploying Integrated Applications*)

## Acknowledgements

 - **Author** - Jayant Mahto, July 2020
 - **Last Updated By/Date** - Troy Anthony, June 25 2020

 See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
