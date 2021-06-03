# Test the Data Guard Switchover


We will test the Data Guard configuration across regions by switching the roles of the primary and standby database.  Switchover can be used to perform maintenance of the primary database.

Estimated lab time:  5 minutes
Estimated wait time: 15 minutes for Switchover

### Objective
- Perform a switchover

## STEPS
1. Navigate to the Data Guard Associations of the primary database.

2. Click the 3-dot action menu on right  and select Switchover


The process will begin to make the standby database the primary.



![image-20210121222215264](./images/image-20210121222215264.png?lastModify=1611298659)

3. Enter the database password for sys when prompted.



![image-20210121225450775](./images/image-20210121225450775.png)



![image-20210121225530925](./images/image-20210121225530925.png)



![image-20210121225620549](./images/image-20210121225620549.png)

In a few minutes the roles will be changed and the standby database will become the primary.  This use case can be used for maintenance operations in the primary region.

End of workshop.
