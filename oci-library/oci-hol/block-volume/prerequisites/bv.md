# Prerequisites for Block Volume

## Introduction

The following steps represents the prerequisites for the Block Volume Lab.

Estimated time: 10 minutes

### Objectives

- Log into OCI Tenancy.
- Create a compartment if not done yet.
- Create a compute instance.


### Prerequisites

- Your Oracle Cloud Trial Account

## **STEP 1:** Create compartment

If you want to use an existing compartment, skip this step. Otherwise, click **Compartments** and then **Create Compartment**, to create a new compartment.

## **STEP 2**: Creating <if type="freetier">a Web Server on </if>a Compute Instance

Oracle Cloud Infrastructure  offers both Bare Metal and Virtual Machine instances:

- **Bare Metal**  - A bare metal compute instance gives you dedicated physical server access for highest performance and strong isolation.
- **Virtual Machine**  - A Virtual Machine (VM) is an independent computing environment that runs on top of physical bare metal hardware. The virtualization makes it possible to run multiple VMs that are isolated from each other. VMs are ideal for running applications that do not require the performance and resources (CPU, memory, network bandwidth, storage) of an entire physical machine.

An Oracle Cloud Infrastructure VM compute instance runs on the same hardware as a Bare Metal instance, leveraging the same cloud-optimized hardware, firmware, software stack, and networking infrastructure.

1. Navigate to the **Compute** tab and select **Instances**.

<if type="livelabs">
2. Select the Compartment that you were assigned when the reservation was created.

  ![](images/create-compute-livelabs-1.png)
</if>

2. Then click **Create Instance**. We will launch a VM instance for this lab.

3. The Create Compute Instance wizard will launch.
    <if type="freetier">Enter *Web-Server* as the name of the server. Click on the *Show Shape, Networking, Storage Options* link to expand that area of the page.</if>
    <if type="livelabs">Enter your username + *-Instance* as the name of the server.</if>

    <if type="freetier">
    ![Create step 1](images/Create1.png " ")
    </if>
    <if type="livelabs">
    ![](images/create-compute-livelabs-2.png)
    </if>

<if type="livelabs">
4. Click *Change Shape* to choose a VM shape.

    ![](images/create-compute-livelabs-3.png)

5. Select *Intel Skylake*, then select **VM.Standard.2.1** as the shape, and click **Select Shape**.

    ![](images/create-compute-livelabs-4.png)</if>

3. In the Networks section, most of the defaults are perfect for our purposes. However, you will need to scroll down to the Configure Networking area of the page and select the *Assign a public IP address* option.

    <if type="freetier">
    ![Create step 2](images/Create2.png " ")</if>

    <if type="livelabs">
    ![](images/create-compute-livelabs-4b.png)</if>

    ***NOTE:*** *You need a public IP address so that you can SSH into the running instance later in this lab.*

4. Scroll down to the SSH area of the page. Choose SSH key that you created earlier in ***Generate SSH Keys*** Lab. Press the **Create** button to create your instance.

    ![](images/create-compute-livelabs-5.png)

    Launching an instance is simple and intuitive with few options to select. The provisioning of the compute instance will complete in less than a minute and the instance state will change from provisioning to running.

5. Once the instance state changes to Running, you can SSH to the Public IP address of the instance. The Public IP address is noted under *Instance Access*.

    <if type="freetier">
    ![Create step 3](images/Create3.png " ")</if>

    <if type="livelabs">
    ![](images/compute-livelabs-running/png)</if>

You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Rajeshwari Rai
- **Contributors** -  Rajeshwari Rai, Prasenjit Sarkar
- **Last Updated By/Date** - Rajeshwari Rai, February 2021

## Need Help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files. Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
