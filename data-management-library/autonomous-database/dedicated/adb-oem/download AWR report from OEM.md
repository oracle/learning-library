# AWR Management of Autonomous Transaction Processing Dedicated database using Oracle Enterprise Manager

## Introduction
Use Automatic Workload Repository (AWR) and automate database statistics gathering by collecting, processing, and maintaining performance statistics for database problem detection and self-tuning purposes.

*In this lab we will see the capabilities of Oracle Enterprise Manager in generating AWR reports.*

### Objectives

As a Database Administrator,

1. Learn how to generate AWR report of your ATP Dedicated Database using Oracle Enterprise Manager
2. Learn how to change retention period of AWR report generated for your ATP Dedicated Database using Oracle Enterprise Manager
3. Compare the two AWR reports of ATP Dedicated database taken at different intervals, using OEM.
   

### Required Artifacts

   - An Oracle Cloud Infrastructure account.
   - A pre-provisioned dedicated autonomous database instance. Refer to [Lab 7](?lab=lab-7-provisioning-databases).
   - Successful connection of ATP dedicated database from OEM.


## STEP 1: Generate AWR report for ATP dedicated database from OEM.

- Login to your OEM from your browser as sysman user.
    ![](./images/us1_1.png " ")

- Click on "Targets" and select "All Targets"
    ![](./images/us1_2.png " ")

- Click on Autonomous Transaction Processing and select "ADBEM" (name of your ATP database)
    ![](./images/us1_3.png " ")
    ![](./images/us1_4.png " ")
	
- Click on "Performance" select "AWR" and then click on "AWR Report"
    ![](./images/us1_5.png " ")
  
- Select the "Begin Snapshot" and "End Snapshot" and Click on "Generate Report".
    ![](./images/us1_6.png " ") 
    ![](./images/us1_7.png " ") 
	
## STEP2: Change the AWR retention period of the report generated

- On the OEM home page click on "Performance" select "AWR" and then click on "AWR Administration"
    ![](./images/us1_8.png " ")

- Click on "Edit"
    ![](./images/us1_9.png " ")

- Change the "Retention Period"
    ![](./images/us1_10.png " ")
	
- Click "OK"
    ![](./images/us1_10.png " ")
    ![](./images/us1_11.png " ")

## STEP3: Compare two AWR reports of different period

- Click on "Performance" select "AWR" and then click on "Compare Period Reports".
    ![](./images/us1_12.png " ")

- Select the "Begin Snapshot" and "End Snapshot" for "First Period" and "Second Period"
    ![](./images/us1_14.png " ")

- Click on "Generate Report"
    ![](./images/us1_13.png " ")
    
## Acknowledgements

*Congratulations! You have successfully completed AWR report analysis using Oracle Enterprise Manager .*

- **Authors** - Navya M S & Padma Priya Natarajan


## See an issue or have feedback?  
Please submit feedback [here](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1).   Select 'Autonomous DB on Dedicated Exadata' as workshop name, include Lab name and issue / feedback details. Thank you!
