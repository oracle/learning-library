# Data Redaction

## Introduction

Version tested in this lab: `Oracle DB 19.8`

In this lab we will redact data from the `EMPLOYEESEARCH_PROD` schema from being seen by applications other than the Glassfish application.

*Estimated Lab Time*: 20 minutes

### Objectives
Dynamically redact sensitive data preventing it from being displayed outside the application

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup

## **STEP 1**: Redact EMPLOYEESEARCH Data
1. Open a SSH session on your DBSec-Lab VM as Oracle User

      ````
      <copy>sudo su - oracle</copy>
      ````

2. Go to the scripts directory

      ````
      <copy>cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/Data_Redaction/Redact_EMPLOYEESEARCH_Data</copy>
      ````

3. First, let's view the data before we redact it

   ````
   <copy>./01_query_employee_data.sh</copy>
   ````        

    ![](./images/dr-001.png " ")

4. Create a redaction policy for the `DEMO_HR_EMPLOYEES` table to redact data for all queries

      ````
      <copy>./02_redact_for_all.sh</copy>
      ````

   ![](./images/dr-002.png " ")

5. Re-run the query to see the redacted data

      ````
      <copy>./03_query_employee_data.sh</copy>
      ````

   ![](./images/dr-003.png " ")

6. Now, modify the redaction policy to only redact non-Glassfish queries

      ````
      <copy>./04_redact_nonapp_queries.sh</copy>
      ````

   ![](./images/dr-004.png " ")

7. Add additional columns to the redaction policy

      ````
      <copy>./05_add_redacted_columns.sh</copy>
      ````

   ![](./images/dr-005.png " ")

8. Run the query to see the redact data again

      ````
      <copy>./06_query_employee_data.sh</copy>
      ````

   ![](./images/dr-006.png " ")

9. When you are finished with the lab, you can drop the redaction policy

   ````
   <copy>./07_drop_redaction_policy.sh</copy>
   ````

   ![](./images/dr-007.png " ")

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Gian Sartor, Rene Fontcha
- **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request. If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
