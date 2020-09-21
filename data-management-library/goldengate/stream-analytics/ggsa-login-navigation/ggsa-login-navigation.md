# Lab1: Login and Navigation


## Introduction
In this lab you are going to login to GGSA and get familiar with the menu
and navigation in the home and catalog pages. You will then create a new
user and set credentials for that user. You are also going to import an
example use case for IoT in order to get familiar with various resources
that are available for that use case.

Estimated Lab Time:  25 minutes

### About Product/Technology
Golden Gate Stream Analytics (GGSA) is a tool designed to consume a stream of data from any source such as a database, GoldenGate, kafka, JMS, REST or even a file system.  Once the data is in GGSA you can run analytics on live data in real-time using transformation and action functionality of Spark and send the data downstream to any target of your choice.

### Objectives
- Get familiar with GGSA
- Navigate the tool and get familiar with menu items
- Learn about the multiple resources that are available in GGSA

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## **Step 1:** Log-in


1. Log-in to the GoldenGate Stream Analytics using the url:


    **User Name:** **osaadmin**

    **Password:** **welcome1**

    ![](./images/login.png)

2. You should see the home page

    ![](./images/home.png)


## **Step 2:** Version

1. Click on the drop-down menu in the upper right-hand corner of the
screen.
    ![](./images/about.png)

2. Click on the **About** menu item and make sure the current version of the product is showing as

    **GoldenGate Stream Analytics Version19.1.0.0.3**

    **Java Version1.8.0_131**

    **Superset Version0.17.0**

    ![](./images/version.png)

3. Click **Done**

## **Step 3:** System Settings

1. Again, click on the drop-down menu in the upper right-hand corner of the
screen but this time click on **System Settings**

    ![](./images/systemsetdropdown.png)

2. Verify all the connections to ZooKeeper and Spark are set as below.

    ![](./images/systemsettings.png)

## **Step 4:** User Management

1. Click on the **User Management** in the navbar to the left and **Add
User**:

    'osauser/osauser'

2. Confirm the password and then click on **Create**, verify that the new
user got created and **Save**

    ![](./images/addUser.png)

## **Step 5:** Catalog


1. Click on the Catalog menu on the top right-hand corner of the home page:

    ![](./images/catalog.png)

    Notice there are no resources currently available.

    ![](./images/emptycatalog.png)

2. Navigate back to the **Home** page again


## **Step 6:** Import

1. click on Import in **Distributed Intelligence for IOT** region and see the message the it
was imported **Successfully**.

    ![](./images/homeimport.png)

2. Go to the **Catalog** page. At the bottom right corner of the page click
on the drop down to **Show 25** resource

    ![](./images/show25.png)

3. Verify that **14 of 14 Resources** have been imported into the catalog.
All the resource imported should be tagged with **IOT Sample, IOT**

    The tags help identify the category of each resource.

    ![](./images/resourcesimported.png)

## **Step 7:** Show Me (Nav Bar)

1. Click on the box next to the **Catalog** and then click on **View All**
on the left **Show Me** nav bar to hide all the resources. All the
resources in the **Show Me** nav bar should now be unchecked and you
should see **0 of 0 Resources** in the main page

    ![](./images/hideallresources.png)


    We can now check individual resource types and only see them listed in
the main page.

## **Step 8:** Connections

1. Click on the **Connections** on the left nav bar and verify that only
two types of connections are visible

    ![](./images/twoConnections.png)


2. Click on the **LocalMySQLDB** connection. This is a connection to the
local MySQL database. We are going to use this connection later in the
lab. Verify that it is the **Connection Type** of **Generic Database**
then click **Next**

    ![](./images/localmysqldb.png)

3. Verify the following:

    Database: "MySql"

    Jdbc url: "jdbc:mysql://OSA_DEMO:Welcome123!\@localhost:3306/OSA_DEMO"

4. Then click on **Test connection** and make sure the connection is
**Successful**. Click on **Cancel** button. Do not save this connection
here

    ![](./images/testDBConnection.png)

5. Now click on the **LocalKafka** connection. This is a different type of
a connection to the local Kafka environment. We are going to use this
connection and the topics later in the lab. Verify that it is the
**Connection Type** of **Kafka** then click **Next**

    ![](./images/localkafka.png)

6. You should see the **Edit Connection** screen for **Type:Kafka**. Verify
that **Zookeepers** is running in the local server **localhost**.
Zookeepers are the servers that are going to manage our local Kafka
environments; in this case just one node in the local environment. Leave
all the other settings as default and click on **Test connection** and
make sure the connection is Successful. Click on **Cancel** button. Do
not save this kafka connection

    ![](./images/editKafkaConnection.png)

## **Step 9:** Streams


1. In the left nav bar uncheck the **Connections** resource and check
**Streams** instead and verify that only **VendingMachineStream** is
visible

    ![](./images/streamsvisible.png)

2. Click on the **VendingMachineStream** and verify the **Source Details**,
**Parameter File** and **Type** and the **Shape** for this stream.

3. For this lab we are going to read a stream of data from file
**VendingMachine.csv** with **Loop** set to **true** simulating a
constant stream of data. Do NOT make any changes to any sections here at this time

    

4. Click on the **Edit** to the right of **Source Type Parameters: File**.
Verify the file format as **CSV** and that the **Loop** flag is turned
on. Click **Next**

    ![](./images/vmStreamDetails.png)
    ![](./images/vmEditStream1.png)

5. Verify the settings in the **Data Format** screen then click **Next**

    ![](./images/vmeditstream2.png)

6. In the **Shape** page **Infer Shape** should be selected which means
that the fields and types are inferred from the source csv file. Verify
the field name and types then click **Cancel** then close (**X**) out
the following screen

    ![](./images/vmEditStream3.png)

## **Step 10:** References


    References are typically database tables that might be used to enrich a stream of data.

1. On the left nav bar make sure **References** are checked only. On the
main screen only **MachineDetails** should be visible.

    ![](./images/referencesvisible.png)

2. Click on the **MachineDetails**. Verify that all the param settings then
click on **Edit** to the right of **Source Type Parameters: Database
Table**. Do NOT edit any sections at this time.

    [](./images/editMachineDetails1.png)

3. In the **Source Details** note that **Connection** is set to
**LocalMySQLDB** as we saw earlier in the lab. Click **Next**

    ![](./images/editMachineDetails2.png)

4. In the **Shape** page notice that all the table columns and their types,
(i.e. shape) are all set correctly. Do not save, click **Cancel**

    ![](./images/editmachinedetails3.png)

5. In the next page click on 'X' and exit.

## **Step 11:** Targets


    A Target is a destination environment downstream that is usually used when we are finished with analysis. They are typically of types: JMS, database, REST, Kafka and Coherence.

1. On the left nav bar make sure **Targets** are checked only. On the main
screen only **NotifyMaintenance** and **ReplenishAlert** targets should
be visible. Click on the **NotifyMaintenance.** Do NOT edit any sections
at this time

    ![](./images/targetsVisible.png)

2. In the **Type Properties** page make sure the target name and type are
set correctly as **NotifyMaintenance** and **Kafka** and click **Next**

    ![](./images/editTarget1.png)

3. In the **Target Details** page notice the **Connection** is set to
**LocalKafka** as we saw earlier with the **Topic name** as
**HighTempMachines**. Make sure the **Data Format** for this topic is
set **JSON**. Notice there are other data formats like csv and avro

    ![](./images/edittarget2.png)

4. In the next page make sure the **Create nested json object** is checked
and click **Next**.

5. In the **Shape** page notice that all the table columns and their types,
i.e., shape are all set correctly (about 19 fields). Do not save, click
**Cancel**

    ![](./images/edittarget3.png)

6. In the next page click on 'X' and exit.

7. Click on the **ReplenishAlert** target and repeat all the steps the same
as **NotifyMaintenance** target. Do not make any changes to these
targets. This target should have (about 12 fields).

**Congratulations! You have now completed Lab 1. You are now ready to move on to Lab 2.**

## Learn More

* [GoldenGate Stream Analytics](https://www.oracle.com/middleware/technologies)

## Acknowledgements

* **Author** - Hadi Javaherian, Solution Engineer
* **Contributors** - Shrinidhi Kulkarni, Solution Engineer
* **Last Updated By/Date** - Hadi Javaherian, Septembe 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
