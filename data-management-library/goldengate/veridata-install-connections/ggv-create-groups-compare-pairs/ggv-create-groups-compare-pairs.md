# Create Groups and Compare Pairs

## Introduction
This lab describes how to groups and compare pairs. Groups are logical containers for one or more compare pairs. They help you to organize and partition large or diverse sets of data into more manageable units. Groups are linked to jobs when jobs are created. Any group can be linked to one or more jobs, allowing you complete control over how and when data is compared.

A group is associated with a set of connections to the source and target data.

A compare pair is the logical relationship between a source table or file and a target table or file for the purpose of comparing their data. Compare pairs are linked to groups. Because of this, all of the source and target objects that you configure into compare pairs for any given group must be accessible from the datasource connections that are associated with that group.

*Estimated Lab Time*: 45 minutes

### Objectives
In this lab, you will:
* Create a Group.
* Create Compare Pairs (on Manual Mapping and Pattern Mapping tabs).
* Create a job for the Compare Pair Groups.
* Run the job.

### Prerequisites
This lab assumes you have:

* A Free Tier, Paid or LiveLabs Oracle Cloud account
* SSH Private Key to access the host via SSH
* You have completed:
    * Lab: Generate SSH Keys (Free-tier and Paid Tenants only)
    * Lab: Prepare Setup (Free-tier and Paid Tenants only)
    * Lab: Environment Setup
    * Lab: Initialize Environment
* The following are required to complete this lab:
    * Source and Target connections are created as described in **Lab: Create Datasource Connections**.

## **STEP 1:** Create a Group

  To create a group:
1. From the left navigation pane, click **Configuration** and then click **Group Configuration** to display the **Group configuration** page.
    ![](./images/1-group-configuration.png " ")
2. Click **New** to display the **New Group Assistant** page to create a group.
3. Enter the **Name** and **Description** for the Group and click **Next**.
  ![](./images/2-new-group-from-name-description.png " ")
4. Click **Next** to enter the connection information.
5. Browse to select the **Source Connection** and **Target Connection** (that you have created in **Lab: Create Datasource Connections**).
  ![](./images/3-new-group-connection-information.png " ")
6. Click **Finish**.

Your new Group has been created.

## **STEP 2:** Create Compare Pairs (on Manual Mapping Tab)
Use the **Manual Mapping** tab to map source objects to target objects one at a time. This method is useful when source and target names differ vastly and cannot be mapped by using wildcards.
To create compare pairs on the **Manual Mapping** tab:
1. After you have created the Group, click **Go to Compare Pair Configuration...** check box in the **New Group Assistant** page to display the **Compare Pair Configuration** page.
2. Click **OK**.
    ![](./images/4-new-group-create-compare-pair-checkbox.png " ")
3. Click **Manual Mapping**.
4. Select a Source **Schema** and a Target **Schema** under **Datasource Information**, and then select the tables from **Source Tables** and **Target Tables** for Manual Compare Pair Mapping. Enter:
    * Source schema: **SOURCE**
    * Target schema: **TARGET**
    * Source Table: **CHAR_TYPES**
    * Target Table: **CHAR_TYPES**
    ![](./images/5-compare-pair-manual-mappng-select-tables.png " ")
5. Click **Generate Compare Pair** to add the compare pair to the preview list.
    ![](./images/6-generate-compare-pair-manual-mappng.png " ")
6. Go the **Preview** tab and click **Save** to save the generated compare pair.
    ![](./images/6A-generate-compare-pair-manual-mapping-preview.png " ")
    The control moves to the **Existing Compare Pairs** tab.
    ![](./images/7-compare-pair-manual-mapping-generated-saved-existingCPtab.png " ")
Similarly, you can create any number of compare pairs for other tables.

## **STEP 3:** Create Compare Pairs (on Pattern Mapping Tab)
If you don’t want to add new compare pairs, you may directly jump to **Lab Create and Execute Job**. Use the **Pattern Mapping** tab to map numerous source and target objects at once by using:

* An exact name match (for example TAB1=TAB1).
* A SQL percent (%) wildcard (for example, %_Table)
* An asterisk (GoldenGate *) wildcard to map differently named source and targets whose naming conventions support wildcarding.

To create compare pairs on the **Pattern Mapping** tab:
1. In the **Compare Pair Configuration** page, click **Pattern Mapping**.
    ![](./images/9a-click-pattern-mapping-tab.png " ")
2. Select a Source **Schema** and a Target **Schema** under **Datasource Information**. Enter:
    * Source schema: **SOURCE**
    * Target schema: **TARGET**

3. Under **Pattern Compare Pair Mapping**, select a **Table Mapping Method**. You can select any of the following:

  a. **Map Source and Target Tables Using Exact Names**: Let's select this option here:
        ![](./images/9-pattern-mapping-pair-mapping-option1.png " ")
  b.  **Map Source and Target Tables Using SQL % Wildcard Pattern. (Use only one % on each side.)**.

    Enter:
    * Where Source Names Like: **%\_Table**

    * Where Target Names Like: **%\_Table**
    ![](./images/8-pattern-mapping-pair-mapping-option2.png " ")

  c. **Map Source and Target Tables Using GoldenGate * Wildcard Pattern. (Use only one * on each side.)**.

    Enter:
    * Pattern for Source Names: **DUMMY_TABLE**

    * Pattern for Target Names: *****
    ![](./images/10-pattern-mapping-pair-mapping-option3.png " ")

4. Click **Generate Mappings**. The control moves to the **Preview** tab. Here, option **3b** has been selected.
    ![](./images/10-pattern-mapping-pair-mapping-option3b_has_been_selected.png " ")

5. Click **Save** to save the generated compare pair. The control moves to the **Existing Compare Pairs** tab.
    ![](./images/11-pattern-mapping-pair-saved-existing-compare-pairs.png " ")

You may now [proceed to the next lab](https://oracle.github.io/learning-library/data-management-library/goldengate/veridata-install-connections/workshops/freetier/?lab=ggv-create-execute-jobs).


Watch our short video that explains the partitioning feature in Oracle GoldenGate Veridata:

[](youtube:N28CsAr5kjw)

## Learn More
* [Oracle GoldenGate Veridata Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/index.html)
* [Configuring Groups](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/configure-workflow-objects.html#GUID-70B42ABB-EA8E-4ADF-8414-7EA1752CA7E6)
* [Compare Pairs](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/configure-workflow-objects.html#GUID-055CE119-0307-4826-98C7-A51F53E28763)
* [Jobs](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/working-jobs.html#GUID-EE434517-18EB-4827-A05F-D420D9E5B0DD)


## Acknowledgements
* **Author** - Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Contributors** -  Nisharahmed Soneji, Senior Principal Product Manager and Sukin Varghese, Senior Member of Technical staff
* **Last Updated By/Date** - Anuradha Chepuri, June 2021
