![](../../../images/banner_ASO.PNG)

# [Lab] Data Redaction

Version tested in this lab: `Oracle DB 19.5`

In this lab you will redact sensitive data in the `EMPLOYEESEARCH_PROD` schema.<br>
<br>

- Open a SSH session on your DBSec-Lab VM as Oracle User

        sudo su - oracle

- Go to the scripts directory

        cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/Data_Redaction/Redact_EMPLOYEESEARCH_Data

- First, let's view the data before we redact it

        ./01_query_employee_data.sh        
 
  ![](images/DR_001.PNG)
    
- Create a redaction policy for the `DEMO_HR_EMPLOYEES` table to redact data for all queries
    
        ./02_redact_for_all.sh
    
  ![](images/DR_002.PNG)

- Re-run the query to see the redacted data

        ./03_query_employee_data.sh

  ![](images/DR_003.PNG)

- Now, modify the redaction policy to only redact non-Glassfish queries

        ./04_redact_nonapp_queries.sh

  ![](images/DR_004.PNG)

- Add additional columns to the redaction policy
    
        ./05_add_redacted_columns.sh
    
  ![](images/DR_005.PNG)

- Run the query to see the redact data again
    
        ./06_query_employee_data.sh
    
  ![](images/DR_006.PNG)

- When you are finished with the lab, you can drop the redaction policy

        ./07_drop_redaction_policy.sh
    
  ![](images/DR_007.PNG)

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
