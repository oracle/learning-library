# Test online scaling capabilities of the autonomous database service 

## Introduction
Continuous uptime is a key requirement of most business critical applications. While the cloud provides the notion of unlimited scale, this scalability comes at a cost of downtime with most services. The Oracle autonomous database service provides scalability without downtime as demonstrated in this lab.


### Objectives

As an adminstrator,
1. Simulate a production workload using Swingbench load generator.
2. Scale up the OCPUs in your autonomous database service through cloud console and observe effect on the workload performance.
3. Scale down the OCPUs in your autonomous database service through cloud console and observe effect on the workload performance.


### Required Artifacts

- An Oracle Cloud Infrastructure account.
- A pre-provisioned instance of Oracle Developer Client image configured with Swingbench in an application subnet. Refer to [Lab 18](?lab=lab-18-build-always-on-applications).
- A pre-provisioned Autonomous Transaction Processing instance. Refer to [Lab 7](?lab=lab-7-provisioning-databases).
- Successful completion of [Lab 8](?lab=lab-8-configuring-development-system) and [Lab 18](?lab=lab-18-build-always-on-applications).


## STEP 1: Log in to the Oracle Cloud Developer image and start the order entry workload

To complete this lab its mandatory you have a developer client image configured with swingbench, an autonomous dedicated database instance with the wallet uploaded to the dev client. Follow instructions in [Lab 8](?lab=lab-8-configuring-development-system) and [Lab 18](?lab=lab-18-build-always-on-applications).

*The remainder of this lab assumes you are connected to the image through VNC Viewer and are operating from the image itself and not your local machine.*

- SSH into your developer client machine and navigate to folder /home/opc/swingbench/bin

- Start order entry workload.

- You can now generate loads on your database by running the charbench utility.  Use the command below. There are 2 parameters you can change to modify the amount of load and users being generated. 

    ``The –uc flag specifies the number of users that will be ramped up, in the case below 64. The –rt flag specifies the total running time which is set to 30 seconds by default.``  

    You can stop running charbench at any time with *Ctrl C.*

    ```
    <copy>
    /home/opc/swingbench/bin/charbench -c /home/opc/swingbench/configs/SOE_Server_Side_V2.xml \
                -cf ~/Downloads/your_wallet.zip \
                -cs yourdb_tp \
                -u soe \
                -p yourpassword \
                -v users,tpm,tps,vresp \
                -intermin 0 \
                -intermax 0 \
                -min 0 \
                -max 0 \
                -uc 64 
    </copy>
    ```

- Once swingbench starts running your will see results similar to the screen below. The first column is a time stamp, the second column indicates how many users of the total users requested with the *-uc* parameter are active, and of interest is the 3rd column which indicates transactions per second. If you see any intermittent connect or other error messages, ignore those.
    ![](./images/swingbenchoutput.jpeg " ")



## STEP 2: Scale up the OCPUs in your autonomous database service

Now, lets scale the autonomous database you created in previous labs from 1 OCPU to 2 or more while swingbench continues running. You should see the transactions/sec numbers start changing as your database is scaling. Please note that this is also highly influenced by the connection service your are using with the *-cs* parameter. In the statement above we are using the *\_tp* service, but while you are experimenting, stop and start swingbench with a different service, such as *\_low*, or *\_high* to see what differences you observe.

- To scale the system go to your Cloud Database Console and select *Scale Up/Down*:
    ![](./images/scale.jpeg " ")

- When the scaling windows pops up, enter a new *CPU CORE COUNT* and click *UPDATE*.
    ![](./images/scale3.jpeg " ")

- The database status will go into *Scaling*. When done it will turn back to *Available*. Please not that during all this time the swingbench application will continue to run because there is no disruption to the service for scaling. You should also notice that the transactions per second increased. or decreased depending on wether you scale the system up or down in number of CPU's.
    ![](./images/swingout2.jpeg " ")


## Acknowledgements
*Congratulations! You successfully tested online scaling capabilities of your autonomous database service.*

- **Author** - Tejus S. & Kris Bhanushali
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, April 2020


## See an issue or have feedback?  
Please submit feedback [here](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1).   Select 'Autonomous DB on Dedicated Exadata' as workshop name, include Lab name and issue / feedback details. Thank you!
