![](../../../images/banner_DV.PNG)

# [Lab] Trusted Application Path

Oracle recommends trusted paths be used to increase security on account management by looking at factors such as IP address, program name and time.
This method allows the application to connect, using the application credentials, but prevent misuse or abuse of those application credentials by everything else.

You will use the Glassfish App to view the `EMPLOYEESEARCH_PROD` data.

- Open a web browser and launch the Glassfish app by navigating to this URL:

        http://<YOUR_DBSEC-LAB_VM_PUBLIC_IP>:8080/hr_prod_pdb1

- Login as **hradmin** / **Oracle123**

- Click **Search Employee**

- Click [**Search**]

- Open a SSH session on your DBSec-Lab VM as Oracle User

        sudo su - oracle

- Go to the scripts directory

        cd $DBSEC_HOME/workshops/Database_Security_Labs/Database_Vault/Trusted_App_Path

- Next, run this query to view the session information associated with the Glassfish application

        ./01_query_employeesearch_usage.sh

    ![](../images/DV_019.PNG)

- Now, query the `EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES` table as `SYS` to demonstrate it is accessible

        ./02_query_employeesearch.sh

    ![](../images/DV_020.PNG)

- Begin protecting the application credentials by creating a Database Vault Rule

        ./03_create_rule.sh

    ![](../images/DV_021.PNG)

- We use the Database Vault Rule by adding it to a DV Rule Set. You can have one or more rules in the rule set.<br>
If you have more than one, you can choose between the rule set evaluating all rules must be true or *any* rule must be true. Think of it like the difference between `IN` and `EXISTS` - `IN` includes all while `EXISTS` stops once it identifies one result matches. 

        ./04_create_rule_set.sh

    ![](../images/DV_022.PNG)

- Create a Command Rule on Connect to protect the `EMPLOYEESEARCH_PROD` user.<br>
You can only `CONNECT` AS `EMPLOYEESEARCH_PROD` if you match the Rule Set we created.

        ./05_create_command_rule.sh

    ![](../images/DV_023.PNG)

- Go to your web browser and refresh a few times and run some queries by clicking [Search] and explore employee data

- Go back to your terminal session and re-run our query of the application usage to verify that it still works.<br>

    ./06_query_employeesearch_usage.sh
    
    ![](../images/DV_024.PNG)

- Now, try to query the `DEMO_HR_EMPLOYEES` table as `SYS`. You should be blocked!
    
        ./07_query_employeesearch.sh
    
    ![](../images/DV_025.PNG)
    
- Once you have successfully completed the lab, you can delete the Command Rule, Rule Set, and Rule from Database Vault
    
        ./08_delete_trusted_path.sh
    
    ![](../images/DV_026.PNG)

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
