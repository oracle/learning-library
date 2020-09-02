![](./media/adbtitle.png)
# Performance Monitoring with the Autonomous Console

## Table of Contents

- [Module 1: Learn how to use Cloud Management Console to monitor activity](#module-1--learn-how-to-use-cloud-management-console-to-monitor-activity)


***** 


## Module 1:  Learn how to use Cloud Management Console to monitor activity

1. From the Cloud Console used during the provisioning exercise click on your
Autonomous instance:

![](media/6fa762c8806e15b986a89966777c2864.png)
<p align="center">Figure 1-1</p>

2. Select the **Service Console**:

![](media/87e98f43aafbebe2af4b6338a3db0601.png)
<p align="center">Figure 1-2</p>

You will be presented the **Overview** page. The **Overview** page shows
real-time and historical information about the utilization of the service. The
components on this page are:

-   **Storage :** This chart shows the total and used storage capacity of the
    service. It indicates what percentage of the space is currently in-use.

-   **CPU utilization (%):** This chart shows the historical CPU utilization of
    the service.

-   **Running SQL statements :** This chart shows the average number of running
    SQL statements historically.

-   **Average SQL statement response time :** This chart shows the average
    response time of SQL statements historically.

-   **SQL statements executed per second :** This chart shows the SQL statements
    executed per second.

    ![](media/9b7477b1d4b74db7fa45c67c54f1aed9.png)
    <p align="center">Figure 1-3</p>

    3. After reviewing the information on this page, select **Activity** on the
    left. The **Activity** page has two main tabs - **Monitor** and **Monitored
    SQL**.

    The **Monitor** tab (also the landing tab for Activity) shows real-time and
    historical information about the utilization of the service. The components
    on this page are:

-   **Database Activity:** This chart shows the average number of sessions in
    the database using CPU or waiting on a wait event.

-   **CPU Utilization:** This chart shows the CPU utilization of each consumer
    group.

-   **Running Statements:** This chart shows the average number of running SQL
    statements in each consumer group.

-   **Queued Statements:** This chart shows the average number of queued SQL
    statements in each consumer group.

    4. Explore the **Monitor** tab. Notice that as you hover over each chart you
    will see the different metrics for the different services. Running the
    cursor over any of the graphs will provide more detailed information. The
    default is to report **Real Time** activity, but specific time period
    activity can be examined by selecting the **Time Period** button.

    ![](media/569a35651c4e5ab6be90a94df3776747.png)
    <p align="center">Figure 1-4</p>



5. To analyse specific SQL statements, click on the **Monitored SQL** button. This
displays SQL that ran or is running in chronological order. The view below
displays the queries ran in SQL Developer in earlier labs. Line 1 contains the
query run in the **\_TP** service and line 3 contains the query run in the
**\_HIGH** service

![](media/1cfbed493164729fd401ac3bd297efab.png)
<p align="center">Figure 1-5</p>

6. Analyse statements you ran to get additional insight into how they executed and
why they executed differently. In this example I select row 1 by clicking
anywhere in the row and then **Show Details:**

![](media/1fc55fc086471ad4fb53ad27dfba870b.png)
<p align="center">Figure 1-6</p>

7. The overview tab provides information about the SQL that was executed, user,
times, and service used (consumer group). Notice that this was the query
executed in the **\_TP** service and it executed in 6 seconds (look at Duration
in the Time & Wait Statistics block, lower left). Low service does not use
parallelization and to corroborate that click the **Parallel** button:

![](media/653d40021ea15a9011a2abf17fc58315.png)
<p align="center">Figure 1-7</p>

Which brings up an empty page, indicating there was no parallelization for this
query.

![](media/c2ccdb309fc04276a22fd0737634d912.png)
<p align="center">Figure 1-8</p>

8. Close the parallel window and select the other statement, in this case 3 and hit
**Show details** (this will be different in your environment, you can analyse
any statement in the list):

![](media/62f9ff70338ee4e942b25b2d58dee9ca.png)
<p align="center">Figure 1-9</p>

9. This query executed in the **\_HIGH** service (Consumer Group) and it executed
in 2 seconds but used 6 seconds of Database time (look at Duration in the Time &
Wait Statistics block, lower left). This indicates that the query ran in
multiple CPU’s and was parallelized. Click on the **Parallel** button:

![](media/f9a55bfc72cbe224cfb6b05443508c75.png)
<p align="center">Figure 1-10</p>



In this case you will notice that the query executed in parallel, with 4 parallel threads (indicated by the Parallel Server information) and each used about 1.5 seconds for the total of about 6 seconds. That is because the \_HIGH service will automatically parallelize transactions depending on the number of CPU’s available (4 in this case).


![](media/b9d85aa47fa332947488b507293b348a.png)
<p align="center">Figure 1-11</p>

Continue to look at all the statements that appear to understand different
execution and resource characteristics of the Autonomous Database.

**This concludes the Performance Monitoring lab.**

***END OF LAB***

[Back to Top](#table-of-contents) 
