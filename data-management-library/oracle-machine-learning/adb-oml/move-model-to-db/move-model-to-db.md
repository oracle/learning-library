# Creating the Machine Learning Model

In lab 2 you created a machine learning model that can predict customer credit. Congratulations! But you’re not finished. It’s a good model, but models have to be deployed into production systems, they have to positively impact the business, and too many machine learning projects fail at this point. We are going to spend the next two labs making sure you deploy this model so that Alpha Office employees can use it in their day to day work.

The first step is to move the model from where it was developed into a production transaction processing database where it will be accessible to the Client Service application. This lab will take you through that process.

## Objectives

In this lab, you will:

- In ADW:
    - Log into SQL Developer Web and enable user ml_user access to sqldeveloper web.
    - Grant storage priviledges to ml_user
    - Log in with ml_user and export the model to a temporary table.
- In ATP:
    - Create a database link that will be used to copy (pull) an export of the ml model from ADW to ATP.
    - Create a new ml_user and grant that user access to sqldeveloper web, and to storage.
    - Copy the model from ADW to ATP.
    - Log in with ml_user and import the ml model.
    - Create a virtual column on the table that applies the model to rows in the table.

### Lab Prerequisites

This lab assumes you have completed the following labs:
- Register for Free Tier Account
- Connect and Provision ADB
- Create Machine Learning Model


## Step 1: Grant Privileges to ML\_USER

1. Log in, if you have not already done so.

  ![](./images/001.png  " ")

2. Navigate to Autonomous Data Warehouse and then select your ADW instance.

  ![](./images/002.png  " ")

  ![](./images/003.png  " ")

3. Select the Service Console.

  ![](./images/004.png  " ")

4. Select Development, and then SQL Developer Web.

  ![](./images/005.png  " ")

5. Log in with your adw admin userid and password.

  ![](./images/006.png  " ")

6. Close the popup help notes.

  ![](./images/007.png  " ")

7. By default only the admin userid can use SQL Developer Web.  To enable ml\_user to use it, you need to enable this.  Enter the following and execute the procedure to grant sqldeveloper web access to ml\_user.
  ````
  <copy>BEGIN
    ORDS_ADMIN.ENABLE_SCHEMA(
      p_enabled => TRUE,
      p_schema => 'ML_USER',
      p_url_mapping_type => 'BASE_PATH',
      p_url_mapping_pattern => 'ml_user',
      p_auto_rest_auth => TRUE
    );
    COMMIT;
  END;
  /</copy>
  ````

  ![](./images/008.png  " ")

  ![](./images/009.png  " ")

8. Grant storage priviledges to ml\_user.
  ````
  <copy>alter user ml_user quota 100m on data;</copy>
  ````

  ![](./images/010.png  " ")

## Step 2: Export the machine learning model

1. Go up to the URL and change the admin part of the URL to ml\_user and hit enter to log in as ***ml\_user***.  Copy the URL to a notepad - you will need it later.

  ![](./images/011.png  " ")

2. Log in as ml\_user.

  ![](./images/012.png  " ")

3. Create a temporary table to hold the data mining model.
  ````
  <copy>create table temp(my_model blob);</copy>
  ````

  ![](./images/013.png  " ")

4. Confirm the machine learning model was built.  This would have been done in the lab 1 by executing the steps in the credit scoring notebook.
```
<copy>select * from user_mining_models;</copy>
```

  ![](./images/016.png  " ")

5. Export the ml model to this temporary table.  The model will be stored in a binary large object.
  ````
  <copy>DECLARE
  v_blob blob;
  BEGIN
  dbms_lob.createtemporary(v_blob, FALSE);
  dbms_data_mining.export_sermodel(v_blob, 'N1_CLASS_MODEL');
  insert into temp values(v_blob);
  commit;
  dbms_lob.freetemporary(v_blob);
  END;
  /</copy>
  ````

  ![](./images/014.png  " ")

6. Confirm the model was exported by looking at the length of the blob (you can't see the binary data).  Note your length may differ slightly.
```
<copy>select length(my_model) from temp;</copy>
```

  ![](./images/015.png  " ")

## Step 3: Grant Create Table Privileges

1. Navigate to Autonomous Transaction Processing (ATP) menu item and then select your ATP instance.

  ![](./images/017.png  " ")

  ![](./images/018.png  " ")

2. Select the Service Console.

  ![](./images/019.png  " ")

3. Select Administration, and then Manage Oracle ML Users.

  ![](./images/020.png  " ")

4. Create new ML User.

  ![](./images/021.png  " ")

5. Enter user ml\_user, an emailid, and passwords and select create.

  ![](./images/022.png  " ")

6. Go back to the ADW Console (previous tab in your browser), select Development, and the SQL Developer Web.

  ![](./images/023.png  " ")

7. Log in with your ***ATP admin*** userid.

  ![](./images/024.png  " ")

8. Grant SQL Developer Web rights to ml\_user.
  ````
  <copy>BEGIN
    ORDS_ADMIN.ENABLE_SCHEMA(
      p_enabled => TRUE,
      p_schema => 'ML_USER',
      p_url_mapping_type => 'BASE_PATH',
      p_url_mapping_pattern => 'ml_user',
      p_auto_rest_auth => TRUE
    );
    COMMIT;
  END;
  /</copy>
  ````

  ![](./images/025.png  " ")

9. Grant storage priviledges to ml\_user.
  ```
  <copy>alter user ml_user quota 100m on data;</copy>
  ```

  ![](./images/026.png  " ")


## Step 4: Copy Machine Learning Models between ADW and ATP

1. With the ***admin*** userid in ***ATP*** SQL Developer Web create a credential to copy your ADW wallet from Object Storage to the DATA\_PUMP\_DIR later in this step.  This is your cloud userid and generated auth token.
  ````
  BEGIN
    DBMS_CLOUD.CREATE_CREDENTIAL(
      credential_name => 'adwc_token',
      username => '&lt;your cloud username &gt;',
      password => '&lt; generated auth token &gt;'
    );
  END;
  /</copy>
  ````

  ![](./images/037.png  " ")

2. Create another credential for the ADW database.  This is your database admin userid and password.  This too will be used in the following steps.
  ````
  <copy>BEGIN
    DBMS_CLOUD.CREATE_CREDENTIAL(
      credential_name => 'adw_db',
      username => 'ADMIN',
      password => '&lt;password&gt;'
    );
  END;
  /</copy>
  ````

  ![](./images/028.png  " ")

3. Go back to your main console browser tab and navigate to object storage and select your adwc bucket.  object storage.

  ![](./images/027.png  " ")

  ![](./images/029.png  " ")

4. The database link needs access to your ADW wallet file cwallet.sso.  In Lab 1 we uploaded this file to object storage.

  ![](./images/034.png  " ")

5. Click on the far right menu of the cwallet.sso file and view details.

  ![](./images/035.png  " ")

6. Copy the URL to a notepad.  We'll need it next.

  ![](./images/036.png  " ")

7. Switch browser tabs and go back to SQL Developer Web and copy the wallet to the ATP's DATA\_PUMP\_DIR.  When we create the database link in the next step this wallet will be required.
  ````
  <copy>BEGIN
      DBMS_CLOUD.GET_OBJECT(
          credential_name => 'adwc_token',
          object_uri => '&lt;your object file URI&gt;',
          directory_name => 'DATA_PUMP_DIR');
  END;
  /</copy>
  ````

  ![](./images/038.png  " ")

8. Retrieve values from the tnsnames.ora file which was in the ADW zip wallet file.  You will need the following.  Copy these values to a notepad.
  - hostname
  - service\_name
  - ssl\_server\_cert\_dn

    ![](./images/039.png  " ")

9. Create database link.  This will allow you to copy data from ADW to ATP (in fact, bi-directional).
  ````
  <copy>BEGIN
      DBMS_CLOUD_ADMIN.CREATE_DATABASE_LINK(
            db_link_name => 'adwlink',
            hostname => '&lt;your ADW host&gt;',
            port => '1522',
            service_name => '&lt;your service name&gt;',
            ssl_server_cert_dn => '&lt;your cert&gt;',
            credential_name => 'adw_db',
            directory_name => 'DATA_PUMP_DIR');
  END;
  /</copy>
  ````

  ![](./images/040.png  " ")

10. Test the database link by retrieving the date from the remote ADW instance:
  ````
  <copy>select sysdate from dual@adwlink;</copy>
  ````

  ![](./images/041.png  " ")

## Step 5: Copy tables from ADW to ATP.

1. First copy the credit\_scoring\_100k table into ml\_user in ATP.  Normally this table would already exist in the production system.  We could have loaded it in lab 1 when we loaded the table into ADW, but since we were going to create this database link we can just copy it from ADW.  We also need to copy the ml model, which is in the temp table (blob).  Enter the following.
```
<copy>create table ml_user.credit_scoring_100k as select * from credit_scoring_100k@adwlink;<copy/>
```

  ![](./images/042.png  " ")

2. Now copy the temp table.
```
<copy>create table ml_user.temp as select * from ml_user.temp@adwlink;</copy>
```

  ![](./images/043.png  " ")

## Step 6: Import the ml model.  

1. Start by copying the SQL Developer URL for the admin user and paste that into your browser, but change the admin user value to ml\_user.

  ![](./images/044.png  " ")

2. Change the user from admin to ml\_user and log in.

  ![](./images/045.png  " ")

3. Import your model.  Note you will get a warning error message, but you can then confirm the model was imported.
  ```
  <copy>DECLARE
  v_blob blob;
  BEGIN
  dbms_lob.createtemporary(v_blob, FALSE);
    select my_model into v_blob from temp;
  dbms_data_mining.import_sermodel(v_blob, 'N1_CLASS_MODEL');
  dbms_lob.freetemporary(v_blob);
  END;
  /</copy>
  ```

  ![](./images/046.png  " ")

4. Confirm the ml model was imported.
```
<copy>select * from user_mining_models;</copy>
```

  ![](./images/047.png  " ")

5. Test the model.
```
<copy>select prediction(N1_CLASS_MODEL USING 'Rich' as WEALTH, 2000 as income, 'Silver' as customer_value_segment) credit_prediction
from dual;</copy>
```

  ![](./images/048.png  " ")

6. To make the model prediction available to all applications we will use the Oracle Database's virtual column feature.  We'll add two new virtual columns: the prediction itself, and the probably that the prediction is correct.  **TIP: You can also create a function index in the ml columns (not included here).  If you wish to use a function index the table must be analyzed to be used in queries.
  ```
  <copy>alter table credit_scoring_100k add(
  likely_good_credit_pcnt AS (round((100*(prediction_probability(n1_class_model, 'Good Credit' USING
      wealth
    , customer_dmg_segment
    , income
    , highest_credit_card_limit
    , residental_status
    , max_cc_spent_amount_prev
    , max_cc_spent_amount
    , occupation
    , delinquency_status
    , customer_value_segment
    , residental_status))),1))
  , credit_prediction AS (prediction(n1_class_model USING   
    wealth
    , customer_dmg_segment
    , income
    , highest_credit_card_limit
    , residental_status
    , max_cc_spent_amount_prev
    , max_cc_spent_amount
    , occupation
    , delinquency_status
    , customer_value_segment
    , residental_status))
  );</copy>
  ```

  ![](./images/049.png  " ")

7. Select some data to view predictions.
```
<copy>select customer_id, wealth, income, credit_prediction, likely_good_credit_pcnt from credit_scoring_100k;</copy>
```

  ![](./images/050.png  " ")

Please proceed to the next lab.

## Acknowledgements

- **Author** - Derrick Cameron
- **Last Updated By/Date** - Leah Bracken, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).

