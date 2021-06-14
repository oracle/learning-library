# Design and Run your ETL Pipeline

![DI Pipeline](images/pipeline_banner.jpeg)

## Introduction

A data flow is a visual program representing the flow of data from source data assets, such as a database or flat file, to target data assets, such as a data lake or data warehouse.

The flow of data from source to target can undergo a series of transforms to aggregate, cleanse, and shape the data.

Data engineers and ETL developers can then analyze or gather insights and use that data to make business decisions.


Estimated Lab Time: 30 minutes.

### Objectives

In this lab, you will:

- Create the Data Flow.
- Create the Integration Task.
- Publish the Integration Task.
- Run the Task.

### Prerequisites

- All previous labs have been successfully completed.

## **STEP 1:** Create the Data Flow

1. Click **Create Data Flow**.

   ![](images/dataflow_create_button.png)

2. Set the **Name**, **Project** and **Description** in the New Data Flow Panel:

      - Name: `CSV to MySQL`
      - Project or Folder: `My First Project`
      - Description: `Data Flow from CSV on Object Storage to MySQL Database`

3. To select the **Project**, click on `My First Project` and **Select**.

   ![](images/dataflow_select_project.png)

   It should look like this:

   ![](images/dataflow_properties.png)

4. From the **Operators** panel, drag and drop the **Source** icon into the canvas.

   ![](images/dataflow_source_dnd.png)

5. Set the **Identifier** and the rest of the info in the **Details** tab from the Source **Properties** panel:

      - Identifier: `FISH_SURVEY`
      - Data Asset: `bucket-study`
      - Connection: `Default Connection`
      - Schema: `bucket-study`
      - Data entity: Click **Browse By Name** and select `reef_life_survey_fish.csv`
      - All the default values are good

   Click **Select**.

6. Set the **Identifier** and then go to **Data Asset** and click **Select**.

   ![](images/dataflow_source_id.png)

7. From the **dropdown**, select `bucket-study`. **Select** `Default Connection` and for **Schema** the name of the bucket `bucket-study`,

   ![](images/dataflow_source_data_asset_bucket.png)

8. Finally, select the **Data Entity**.

   ![](images/dataflow_source_data_entity.png)

9. Browse by **Name**:

   ![](images/dataflow_source_data_entity_browse.png)

10. **Select** `reef_life_survey_fish.csv` file.

   ![](images/dataflow_source_data_entity_file.png)

11. And click **Select**.

   ![](images/dataflow_source_data_entity_file_select.png)

12. On the dropdown for **File Type**, pick `CSV`.

   ![](images/dataflow_source_data_entity_file_type.png)

13. Then click **Select**.

   ![](images/dataflow_source_data_entity_file_type_csv.png)

14. At this point, your source has access to the **Attributes**, where you can see the different fields of your dataset.

   ![](images/dataflow_source_data_entity_attributes.png)

   **Confirm** you can see Attributes and Data.

   Let's move into the target for our **MySQL Database**.

15. Drag and Drop the **Target** icon into the canvas.

   ![](images/dataflow_target_dnd.png)

16. Set the **Identifier** and the rest of the info in the **Target**:

       - Identifier: `MySQL DB`
       - Data Asset: `mysql-database`
       - Connection: `Default Connection`
       - Schema: `nature`
       - Data entity: `fish`

   ![](images/dataflow_target_id.png)

17. This time, pick the `mysql-database` **data asset**. And `Default Connection` one more.

   ![](images/dataflow_target_data_asset_mysql.png)

18. For the **Schema**, select `nature`.

   ![](images/dataflow_target_data_asset_schema_nature.png)

19. For **Data Entity**, we select the table `fish`.

   ![](images/dataflow_target_data_asset_data_entity.png)

   ![](images/dataflow_target_data_asset_data_entity_fish.png)

20. At this point, we can **confirm** we see the attributes from the table.

   ![](images/dataflow_target_attributes.png)

21. Time to **wire source and target**. Draw the link between `FISH_SURVEY` and `MYSQL_DB`. Starting from the circle in `FISH_SURVEY` source box and finishing over `MYSQL_DB` target box.

   ![](images/dataflow_source_to_target.png)

22. The **final result** should look like the following.

   ![](images/dataflow_source_to_target_linked.png)

23. **Make sure** `MYSQL_DB` target is selected (green border) and click on the **Map** tab on the **Properties** panel and drag and drop the fields with NO `Auto` in the row. **Do it until they are all mapped**.

   ![](images/dataflow_source_to_target_map.png)

24. **Make** sure `Not Mapped` in yellow is **0**.

   ![](images/dataflow_source_to_target_map_completed.png)

25. The **final step** is to **validate** the Data flow. Click **Validate**, check there are no warnings or errors and click **Save and Close**.

   ![](images/dataflow_validate.png)

---

## **STEP 2:** Create the Integration Task

1. Go back to **Home** and Click **Create Integration Task**.

   ![](images/integrationtask_create_button.png)

2. Set the **Name** and the rest of the info as follows:

      - Name: `IntegrationTaskMySQL`
      - Description: `Integration Task MySQL`
      - Project or Folder: `My First Project`
      - Data Flow: `CSV to MySQL`

   ![](images/integrationtask_fields.png)

3. Wait for the **Validation** of the Data Flow and click **Save and Close**.

   ![](images/integrationtask_save.png)

---

## **STEP 3:** Publish the Integration Task

1. Go to **Projects** on the home screen.

   ![](images/di_select_projects.png)

2. Click on **My First Project**.

   ![](images/di_select_projects_my_first_project.png)

3. On the Details menu (left), click on **Tasks**.

   ![](images/di_project_tasks_menu.png)

4. Select **IntegrationTaskMySQL**, and click **Publish to Application**.

   ![](images/di_project_tasks_publish_integration.png)

5. **Select** (if not selected by default) your **Default Application**. Click **Publish**.

   ![](images/di_project_tasks_publish_integration_to_default_app.png)

---

## **STEP 4:** Run the Task

1. Go back to the **Home** screen and click **Applications**.

   ![](images/di_application_menu.png)

2. Select **Default Application**, and you will see your task **IntegrationTaskMySQL**.

   ![](images/di_application_integration_dots.png)

3. Click on the **context menu** (three dots) and click **Run**.

   ![](images/di_application_integration_run.png)

4. Wait few seconds and the **Status** will change from `Not Started` to `Queued`, then to `Running`.

   ![](images/di_application_integration_not_started.png)

   ![](images/di_application_integration_queued.png)

   ![](images/di_application_integration_running.png)

5. Feel free to click **Refresh** from time to time until you see `Success` on the Status.

   ![](images/di_application_integration_success.png)

---

## **STEP 5:** It Works

1. On the bastion host in **Cloud Shell** (reconnect if timed out), run the **MySQL docker** image and in the `bash` **Terminal**, run:

   ```
   <copy>mysqlsh --sql root@PRIVATE_IP</copy>
   ```

2. Put the MySQL **password**:

   ```
   <copy>R2d2&C3po!</copy>
   ```

3. Set `nature` as the **Schema** in use.

   ```
   <copy>use nature;</copy>
   ```

4. Count the **number** of rows in the table `fish`.

   ```sql
   <copy>select count(1) from fish;</copy>
   ```

5. **Exit** with:

   ```
   <copy>\exit</copy>
   ```

Congratulations, you are ready for the next Lab!

---

## **Acknowledgements**

- **Author** - Victor Martin, Technology Product Strategy Manager
- **Contributors** - Priscila Iruela
- **Last Updated By/Date** - Brianna Ambler, June 2021