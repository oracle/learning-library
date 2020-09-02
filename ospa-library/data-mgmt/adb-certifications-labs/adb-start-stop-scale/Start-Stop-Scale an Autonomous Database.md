![](./media/adbtitle.png)
# Start, Stop, and Scale Autonomous Database

## Table of Contents

- [Module 1: Stopping the Autonomous Database](#module-1--stopping-the-autonomous-database)
- [Module 2: Starting the Autonomous Database](#module-2--starting-the-autonomous-database)
- [Module 3: Scaling the Autonomous Database](#module-3--scaling-the-autonomous-database)

***** 

Start, Stop, and Scale Autonomous Database
==================================================

This section outlines the tasks for starting and stopping the service and
scaling the Autonomous Database.

### Objectives

-   Start and Stop the Autonomous Database service

-   Scale the Autonomous Database service

## Module 1:  Stopping the Autonomous Database

1. Sign in to your Autonomous Database **Service Console** and browse to the
A**utonomous Database Details** page of your service. Select the Stop button.

![](media/c646892c2f584473aa06dc8baea51841.png)
<p align="center">Figure 1-1</p>

The ADB service will go into stopping status. Notice the status of **STOPPING**.

![](media/83b1e723a210d0c619e26c20c861c7c5.png)
<p align="center">Figure 1-2</p>

When the service is stopped, the status will change to **STOPPED**.

![](media/052a68976edef63ff313f5a71daefbd5.png)
<p align="center">Figure 1-3</p>

[Back to Top](#table-of-contents)

## Module 2:  Starting the Autonomous Database

1. From the **Details** page of your ADB service, click **Start** to start your
service.

![](media/868ac8e2ac917ca51e224259e0c6872d.png)
<p align="center">Figure 2-1</p>

2. Click **Start** again when prompted for confirmation.

![](media/a1684875990ec5bc69ad3e3959ff61f0.png)
<p align="center">Figure 2-2</p>

The ADB service will take a few seconds to start. For example, if you
provisioned ATP service, you would notice the status of **STARTING** as follows:

![](media/a73ac7df006529f7bc62daa0282fef49.png)
<p align="center">Figure 2-3</p>

When the service is started, the status will change to **AVAILABLE**.

![](media/5cc6e0cbc80024df3ed610e46600864c.png)
<p align="center">Figure 2-4</p>

[Back to Top](#table-of-contents)

## Module 3:  Scaling the Autonomous Database

1. From the **Details** page of your ADB service, click **Scale Up/Down** to scale
your service.

![](media/04d929a07e7efcd162b02683b1ab2ca1.png)
<p align="center">Figure 3-1</p>

2. In the **Scale Up/Down** pop up, modify the **CPU CORE COUNT** to **2** and
click **Update**.

![](media/c03aaf2ad0be2682158155e58e2e78e6.png)
<p align="center">Figure 3-2</p>

The ADB service will scale. Notice the status of **SCALING IN PROGRESS**. Note
that the ATP square remains green during the scaling process. No interruption to
the service occurs during all scaling operations.

![](media/5901e65383b8b786ef1e13b29f3f54b0.png)
<p align="center">Figure 3-3</p>

When the scaling task is complete, the status will change to **AVAILABLE**. Note
the new **CPU Core Count** is reflected in the service details.

![](media/2aed9ae86ea5b589b4d67adcf1b7f88c.png)
<p align="center">Figure 3-4</p>

3. Use the same process to scale the system back down to 1 CPU by making the CPU
Core Count 1 in the scale pop-up.

**This concludes the starting, stopping, and scaling lab.**

***END OF LAB***

[Back to Top](#table-of-contents)  
