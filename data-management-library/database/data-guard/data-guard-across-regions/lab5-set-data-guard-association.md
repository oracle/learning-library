

# Set Data Guard Association

Setting up Data Guard for Database Cloud Service is a simple process called association.  We enable Data Guard in the primary database and the standby database is automatically created.

Estimated lab time:  10 minutes

### Objective
- Enable Data Guard for Oracle Database Cloud Service

### Prerequisite

- VCN for both the primary and standby regions are created

- Database Cloud Service Enterprise Edition or higher edition is created

- DRGs and RPCs are created

- RPC connection is peered

- Route Rules and Security Lists are configured for secure communication between primary and standby VCNs


Navigate to your Database Cloud Service in your primary region.



![image-20210121190217365](./images/image-20210121190217365.png)


## STEPS
1. Go to your database details page.

2. Select your database under resources.




![image-20210121190255856](./images/image-20210121190255856.png)

3. Select Data Guard Associations.

4. Click Enable Data Guard for your database.



![image-20210121190326859](./images/image-20210121190326859.png)

Data Guard is defaulted to Maximum Performance Protection Mode which means the redo log is transmitted to the standby immediately and does not wait for the standby to complete the redo apply.  It is also set to Async Transport type.  Maximum Protection mode is not available at this time.

5. Enter a name for your peer standby database.

6. Enter the region of your standby.

7. Enter the availability domain you want to install the standby.  Some regions only have one availability domain.

8. Select the shape or size of the standby database.

9. Select your standby VCN.

10. Select the subnet in the standby VCN that will host your standby database.

11. Enter a hostname prefix.

12. Enter the password for the standby database.  It should be the same as the primary database.

13. Click Enable Data Guard.



![](./images/image-20210121182459418.png)



Because the networking and remote peering connection is configured, the standby database and Data Guard will automatically be created.

Check your standby region.  A standby database should be provisioning.



![dbstby-provisioning](./images/dbstby-provisioning-copy.png)



Check the Data Guard association.  You will see the primary being associated.


Completed. The standby database is now ready for a failover.



![image-20210121222339306](./images/image-20210121222339306.png)

You may now proceed to the next lab.
