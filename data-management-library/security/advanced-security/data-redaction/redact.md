## Redact EMPLOYEESEARCH Data



In this lab we will redact data from the `EMPLOYEESEARCH_PROD` schema from being seen by applications other than the Glassfish application.

The first thing you will do is view the data in your Glassfish application.  Use your browser and load your browser's public IP into this URL:

`http://PUBLIC_IP:8080/hr_prod_pdb1`

Sign in as **admin** / **Oracle123**


Perform some simple queries in the application and verify you can see Social Identification Number (SIN), Social Security Number (SSN) and National Identification Number (NINO).

Now, in the `Redact_EMPLOYEESEARCH_Data` lab directory, run the following script:

`./01_query_employee_data.sh` 

You should see all of the data in an un-redacted format.

Next, create your redaction policy to redact data for everyone (`1=1`):

`./02_redact_for_all.sh`

Run the next script to view the output after applying the redaction policy:

`./03_query_employee_data.sh`

You will see the SIN column no longer displays any data. You have applied a policy using the `function_type => DBMS_REDACT.FULL`.

Use your web browser to verify that the application data is also redacted. We do **not** want to leave it this way so we will redact everything **except** the application.  Do so by running this script:

`./04_redact_nonapp_queries.sh`

Now, add additional columns to our redaction policy. These columns include `SSN` and `NINO`.

`./05_add_redacted_columns.sh`

Run the query script to view the `DEMO_HR_EMPLOYEES` table data again.

`./06_query_employee_data.sh`

Use your web browser again to verify that the application data is **not** redacted this time. 

When you are satisified with the results, you can remove the redaction policy.

`./07_drop_redact_policy.sh`



## Acknowledgements

- **Authors** - Gian 
- **Contributors** - Kanika Sharma
- **Team** - 
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.