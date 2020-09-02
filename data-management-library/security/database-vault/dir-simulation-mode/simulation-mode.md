![](../../../images/banner_DV.PNG)

# [Lab] Simulation Mode

Introduced with Oracle Database Vault 12c Release 2, Simulation Mode writes violations to the simulation log instead of preventing SQL execution to quickly test new and modified Oracle Database Vault controls.

Simulation mode stores the errors that are captured in one location for easy analysis. To use simulation mode, when you create or update a realm or command rule, instead of enabling or disabling the realm or command rule, you can set it to simulation mode. The realm or command rule is still enabled, but because violations are not blocked and are instead recorded to the simulation log file, you can test it for any potential errors before you enable it for a production environment. When simulation mode is enabled, the report may include violations for multiple realms or command rules. For more detailed reports that can help you better identify the source of user SQL statements, you can configure simulation mode to include the PL/SQL call stack. The call stack captures the calling procedures and functions recursively to better troubleshoot the Database Vault audit records. Call stack information is stored in the PL_SQL_STACK column in the DVSYS.DBA_DV_SIMULATION_LOG data dictionary view.


- Open a SSH session on your DBSec-Lab VM as Oracle User

        sudo su - oracle

- Go to the scripts directory

        cd $DBSEC_HOME/workshops/Database_Security_Labs/Database_Vault/Simulation_Mode

- First, query the simulation log to show that it has no current values

        ./01_query_simulation_log.sh

    ![](../images/DV_008.PNG)

- Next, create a command rule that will simulate blocking all connections to the database. This is an easy way for us to identify who is connecting and where they are connecting from.    
    
        ./02_command_rule_sim_mode.sh
    
    ![](../images/DV_009.PNG)

- Execute a script to create some db connections and generate some log entries

        ./03_run_queries.sh

    ![](../images/DV_010.PNG)

- Now, we query the simulation log again to see what new entries we have.<br>
Remember we created a command rule to simulate blocking user connections!

        ./04_query_simulation_log.sh

    ![](../images/DV_011.PNG)

    The log shows all the users who connected and would have been blocked by the rule. It also shows where they connected from and what client they used to connect. 

- Run this script to get a list of distinct usernames

        ./05_distinct_users_sim_log.sh

    ![](../images/DV_012.PNG)

- Although we only used Simulation mode on a CONNECT rule, we could have used this on a Realm to show what violations we would had

- Before moving to the next lab, we will remove the command rule and clean out the log

        ./06_purge_sim_log.sh
        ./07_drop_command_rule.sh

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
