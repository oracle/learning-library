# Setup Service Broker and Messaging

## Introduction

This lab will show you how to create an Oracle Cloud Infrastructure Service
Broker and bind it to the two existing Autonomous Transaction Processing
databases. This way we will be able to connect the OKE Helidon microservices to
the ATP instances.

![](images/veggie-dash-app-arch.png " ")

### Objectives
-   Create and bind OCI Service Broker to existing ATP instance
-   Setup Oracle Advanced Queuing in existing ATP instances

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* OKE cluster and the ATP databases created
* Microservices code from GitHub built and deployed

## **STEP 1**: Setup OCI Open Service Broker

For the microservices to talk to the ATP instances, we need to create an OCI
    Service Broker. OCI Service Broker for Kubernetes is an implementation of
    the Open Service Broker API. OCI Service Broker for Kubernetes is
    specifically for interacting with Oracle Cloud Infrastructure services from
    Kubernetes clusters. It includes service broker adapters to bind to the
    following OCI services: Object Storage, Autonomous Transaction Processing,
    Autonomous Data Warehouse.

1.  Log in to the Cloud Console and open the Cloud
    Shell by clicking the Cloud Shell icon in the top-right corner of the
    Console.

  ![](images/7feb61fbebb010b7acada8a1e8b5a742.png " ")

2. Inside Cloud Shell go to the service broker folder.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/osb-atp-and-oss</copy>
    ```

  ![](images/b5353f252300596df91d16bd1ef80e51.png " ")

3.  Edit the `setupOSB.sh` with `nano` (or `vi`) and set the following variables. You can expand
    the cloud shell window for convenience, by clicking the maximize button on
    the top-right corner of the Cloud Shell.

  ![](images/d0f8e6db2e57f3c9690e4a6a48c2e487.png " ")

    ```
    <copy>nano setupOSB.sh</copy>
    ```

  ![](images/5585b29d866e1b039318d2e16e84d989.png " ")

4.  Modify the values in **`<>`** brackets:

    ```
    kubectl create clusterrolebinding cluster-admin-brokers --clusterrole=cluster-admin --user=<USER_ID>
    kubectl create secret generic ocicredentials \
    \--from-literal=tenancy=<TENANCY_OCID> \
    \--from-literal=user=<USER_OCID> \
    \--from-literal=fingerprint=<USER_FINGERPRINT> \
    \--from-literal=region=<REGION_CODE> \
    \--from-literal=passphrase=<PRIVATEKEY_PASSPHRASE> \
    \--from-file=privatekey=<PRIVATEKEY_FILE_LOCATION>
    ```

5. Note that `<USER_ID>` is not equal to `<USER_OCID>`. Rather, `<USER_ID>` is the username of your account. If your account is federated, it will begin with `oracleidentitycloudservice/`.

    - `<USER_ID>` - is your username
    - `<TENANCY_OCID>` - is the Tenancy OCID
    - `<USER_OCID>` - is the User OCID
    - `<USER_FINGERPRINT>` - is the fingerprint value created when adding the Public key in the console
    - `<REGION_CODE>` - is the Region identifier
    - `<PRIVATEKEY_PASSPHRASE>` - is the passphrase used to create the Private key file
    - `<PRIVATEKEY_FILE_LOCATION>` - is the absolute path for Private key file location (Do not use `~` in the path.). You should have recorded this information in lab 1 and it should be in the format of /home/USER/.oci/user1\_api\_key\_private.pem(you will need to replace USER in the file path with your user).

    Once you have edited the two `kubectl` commands, the result should look
    something like this.

  ![](images/a1af01b9fe9ccd13e65e4c26d4aec57e.png " ")

6.  Once the script was edited, execute it using the following command. The
    script has basic setup for Kubernetes service catalog. It installs the
    service catalog `cli svcat`, adds the service catalog helm repo. It also
    generates a secret that is being used to install the OCI service broker, and
    set it up with the Kubernetes cluster.

    ```
    <copy>./setupOSB.sh</copy>
    ```

  ![](images/2947a6362b7777c4e1aae1d05ca348ae.png " ")

    It will take a couple of minutes to set the broker, and during the initial check
    performed by the script, you might temporary see Status “ErrorFetchingCatalog”
    for the oci-service-broker.

  ![](images/7fc70a49ddb3a78e095f22785266c3be.png " ")

8. If you run into trouble, run these commands to back out the `ocicredentials` and `clusterrolebinding`:

    ```
    <copy>kubectl delete secret ocicredentials
    kubectl delete clusterrolebinding cluster-admin-brokers</copy>
    ```

9.  (Optional) If the broker is still not ready, continue to check again with the
    commands:

    ```
    <copy>svcat get brokers</copy>
    ```

  Once ready, it should show the `oci-service-broker` with status “Ready”.

  ![](images/51092536338e20f9eff4140550b6d22d.png " ")

    ```
    <copy>svcat get classes</copy>
    ```

  ![](images/c07329fda7472931c6c477c6ccaee2fe.png " ")

    ```
    <copy>svcat get plans</copy>
    ```

  ![](images/e83737c1bd42d58b2310bcd0ac218ef1.png " ")

The commands are used to check the available OCI services that could be accessed
through the service broker, such as Autonomous Transaction Processing, Object
Storage and others.

## **STEP 2**: Using OCI service broker, create binding to 2 existing ATP instances
You will now use the created OCI service broker and create bindings to the
    two Autonomous Transaction Processing databases.

1. In Cloud Shell go to the service broker folder:

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/osb-atp-and-oss</copy>
    ```

  ![](images/670c73c7cd087d66e2043567e402f55a.png " ")

2. Edit the `setupATP.sh` with `nano` or `vi`.

    ```
    <copy>nano setupATP.sh</copy>
    ```

  ![](images/9091a5da45fb894fda742dfe3a91bc5d.png " ")

3. Modify the values in **`<>`** brackets:

    ```
    export orderpdb_ocid=<ORDERPDB_OCID>
    export orderpdb_compartmentId=<ORDERPDB_COMPARTENT_OCID>
    export orderpdb_walletPassword=$(echo <ORDERPDB_WALLET_PW> | base64)
    export orderpdb_admin_password=$(echo <ORDERPDB_ADMIN_PW> | base64)
    export orderpdb_orderuser_password=$(echo <ORDERPDB_ORDERUSER_PW> | base64)
    export inventorypdb_ocid=<INVENTORYPDB_OCID>
    export inventorypdb_compartmentId=<INVENTORYPDB_COMPARTENT_OCID>
    export inventorypdb_walletPassword=$(echo <INVENTORYPDB_WALLET_PW> | base64)
    export inventorypdb_admin_password=$(echo <INVENTORYPDB_ADMIN_PW> | base64)
    export inventorypdb_inventoryuser_password=$(echo <INVENTORYPDB_INVENTORYUSER_PW> | base64)
    ```

  `<ORDERPDB_OCID>` and `<INVENTORYPDB_OCID>` are the OCIDs copied when
  creating the two ATP instances.

  `<ORDERPDB_COMPARTENT_OCID>` and `<INVENTORYPDB_COMPARTENT_OCID>` are the
  OCID used when creating the compartment.

  For all the passwords use the original password when creating the two ATP
  instances.

  Once you have edited the lines, the result should look something like this:

  ![](images/3066d511196e52a4e0e96a89a2510f3a.png " ")

4. Once the script is edited, execute it:

    ```
    <copy>./setupATP.sh</copy>
    ```

  ![](images/8fb73d0ecb40ebccef318632a4241ebe.png " ")

  The script will try to cleanup some of the existing secrets, but since this is
  the first time we are executing, it will show “Error from server (NotFound):
  secrets” messages.

  ![](images/f9ac7d44d03a56aac871f84e5b07df36.png " ")

  Next it will create service catalog instances as well as the corresponding
  binding and secrets.

  ![](images/02c1e1e148a6dc9517e7a4b702ab8ab2.png " ")

  At the end the script displays all the instance bindings with their status.

  ![](images/162620d9980ac83f2084ae4c46838f45.png " ")

## **STEP 3**: Verify and understand ATP connectivity via Helidon microservice deployment in OKE
You will verify the connectivity from the frontend Helidon microservice
    deployment to the ATP using the previously created service broker binding.

1.  First, let’s analyze the Kubernetes deployment YAML file: `atpaqadmin-service.yaml`.

    ```
    <copy>cat ~/msdataworkshop-master/atpaqadmin/atpaqadmin-service.yaml</copy>
    ```

    The volumes are set up and credentials are brought from each of the bindings
    (inventory and order). The credential files in the secret are base64 encoded
    twice and hence they need to be decoded for the program to use them, which
    is what the `initContainer` takes care. Once done, they will be mounted for
    access from the container `helidonatp`. The container also has the DB
    connection information such as the JDBC URL, DB credentials and Wallet,
    created in the previous step.

2.  Let’s analyze the `microprofile-config.properties` file.

    ```
    <copy>cat ~/msdataworkshop-master/atpaqadmin/src/main/resources/META-INF/microprofile-config.properties</copy>
    ```

    This file defines the `microprofile` standard. It also has the definition of
    the data sources that will be injected. You will be using the universal
    connection pool which takes the JDBC URL and DB credentials to connect and
    inject the datasource. The file has default values which will be overwritten
    with the values specific for our Kubernetes deployment.

3.  Let’s also look at the microservice source file `ATPAQAdminResource.java`.

    ```
    <copy>cat ~/msdataworkshop-master/atpaqadmin/src/main/java/oracle/db/microservices/ATPAQAdminResource.java</copy>
    ```

    Look for the inject portion. The `@Inject` will have the two data sources
    under `@Named` as “orderpdb” and “inventorypdb” which were mentioned in the
    `microprofile-config.properties` file.

4.  Go into the ATP admin folder.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/atpaqadmin</copy>
    ```

  ![](images/6ba636763c8534771619ae9a55d3322c.png " ")

5.  Create the `atpaqadmin` deployment and service using the following command.

    ```
    <copy>./deploy.sh</copy>
    ```

  ![](images/2d0ad754b2c2fa85abe1f3dd6dbdf367.png " ")

6.  Once successfully deployed, verify the existence of the deployment and
    service using the following command. You should notice that we now have the
    `atpaqadmin` pod up and running.

    ```
    <copy>pods</copy>
    ```

  ![](images/33ed0b2b6316c6cdbbb2939947759119.png " ")

7.  Use the URL `http://<external-IP>:8080` to open the frontend webpage.

  ![](images/490686705b79e262def7f41968498d8a.png " ")

8. Click **testdatasources**.

  ![](images/430872b9b99ce788dddb45c5e1de71ce.png " ")

  *If you do not see the correct results immediate wait a few minutes and click testdatasources again.*

  The frontend is calling the `atpaqadmin` service and has successfully established
  connections to both databases `orderpdb` and `inventorypdb`.

## **STEP 4**: Setup AQ in the database
In this step you will set up the AQ messaging queue by creating database
    links between the two ATP databases, and perform queue propagation. Advanced
    Queuing provides database-integrated message queuing functionality. We are
    going to download the connection information zip file for each of the ATP
    instances.

1.  Go to the Cloud Console and click **Autonomous Transaction Processing**.

  ![](images/8b3a05eecdbc4b140ac4fc81c8d49c89.png " ")

2.  If you don’t see the two ATP instances, make sure you have selected the
    right compartment.

  ![](images/4097cb788800a3a28dcd3a349698d0f0.png " ")

3.  Click on the `InventoryDB` name.

  ![](images/6873d607319af22e64d0aa11f8bd2ed8.png " ")

4.  On the InventoryDB page click **DB Connection**, select the regional Wallet and download the zip file.

  ![](images/d4ffd87731799f3961dfa13f36dd44a1.png " ")

  *Note: Make sure you select Regional Wallet.*

  ![](images/1b05d273a509a51f681e0efc514f09f4.png " ")

5. On the next page you will be asked to provide the password, please type the same password used when you created the instance and click **Download**.

  ![](images/73b7e7e550731c525b8a93939ef67188.png " ")

6.  Once downloaded, extract the zip file on your computer, and upload the
    `cwallet.sso` into object storage. Go to the Object Storage page and click **Create
    Bucket**. Make sure you are in the `msdataworkshop` compartment.

  ![](images/6fcb7b50a017498192e3d3b268e416b8.png " ")

  ![](images/9f3e11006885ae7e63ddbfd7d1c8fb77.png " ")

7.  Name the compartment `msdataworkshopbucket`, leave the defaults and click
    **Create Bucket**. You should see the newly created bucket in the list.

  ![](images/b40c72b4a398854e5a07c9c219075d73.png " ")

8.  Click `msdataworkshopbucket`, under Object, click **Upload Objects**, select
    the extracted `cwallet.sso` file from your computer and click **Upload
    Objects**.

  ![](images/438426876ac0d4ebbb964ae25d24c8f0.png " ")

  ![](images/8dcb5509c1ff0d7adef8fdde1042c0a5.png " ")

  ![](images/f65f8096ed72e77fe51111fd1a687f44.png " ")

  ![](images/04fa91b2738e69df048f38e9e562a198.png " ")

  ![](images/48599172582ed1a60b4d47307a5c04fc.png " ")

9. Once uploaded, go back to the `msdataworkshopbucket` page, and you should see the uploaded file in the list.

  ![](images/e7d97fd1eeae32cf65f68072fbb497b3.png " ")

10.  For convenience, create a pre-authenticated URL to the Object eliminating
    the need to sign-in when accessing the object. Click the other options icon
    located to the right of the `cwallet.sso` object, and select **Create
    Pre-Authenticated Request**.

  ![](images/ed954be119a3586da81bc9ee928da70c.png " ")

11. On the next page confirm the defaults and click **Create Pre-Authenticated Request**. Once created, copy the Pre-authenticated request URL, as it will not be shown again. Save the URL in your text file.

  ![](images/3caac1410392a9c844675c60b166a371.png " ")

12. Open the Cloud Shell and go to the `atpaqadmin` folder.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/atpaqadmin</copy>
    ```

  ![](images/7b2c01d83a10447de8761c7843183d16.png " ")

13. Edit the Kubernetes deployment file `atpaqadmin-deployment.yaml` with nano.

    ```
    <copy>nano atpaqadmin-deployment.yaml</copy>
    ```

  ![](images/341f75a208337ea66db5a007dc7c1664.png " ")

14.  We need to provide values in the section marked with “\# PROVIDE VALUES FOR
    THE FOLLOWING...”. Provide values for the following items:

    - cwalletobjecturi
    - orderhostname
    - orderport
    - orderservice\_name
    - orderssl\_server\_cert\_dn
    - inventoryhostname
    - inventoryport
    - inventoryservice\_name
    - inventoryssl\_server\_cert\_dn

    `cwalletobjecturi` – is the pre-authenticated URL which we’ve created in the previous step, when uploading `cwallet.sso` to the Object storage.

  The rest of the values should be in the `tnsnames.ora` file which was extracted from the zip file. When looking for the information in `tnsnames.ora` look for the information under the \_HIGH TNS aliases, so for `orderdb` look for values in `orderdb_high` connection string, and for `inventorydb` look for values in `inventorydb_high` connection string.

  ![](images/dd5993c4b3d9fd0bf606fd467c0b5c3f.png " ")

  Once you have edited the lines, the result should look like this:

  ![](images/e0cc650777e2d759de02ed49f6fcc8b8.png " ")

15. Redeploy the `atpaqadmin` image.

    ```
    <copy>./redeploy.sh</copy>
    ```

  ![](images/280c423cdfa5b825b704e8a2bdee2621.png " ")

15.  Once created, run the `pods` command to check that the `atpaqadmin` pod is
    in running state. You should see the `atpaqadmin` pod up and running

    ```
    <copy>pods</copy>
    ```

  ![](images/1f226568abdce39d7fc9eacd9279fbab.png " ")

16.  Open the frontend microservice home page and click the following buttons in
    order: **createUsers**, **createInventoryTable**, **createDBLinks**,
    **setupTablesQueuesAndPropagation**.

  ![](images/3041592eb42deecf17bb9012b09ace18.png " ")

  ![](images/7ecbfad49b0fe271b2d18e7fa297a112.png " ")

  ![](images/cb73b47be1514662756e2dbc5128aebf.png " ")

  ![](images/28321f572e02aaa349e1edc5c89fe1c5.png " ")

  ![](images/17754016120ef6c74ab84c0981eb274f.png " ")

  ![](images/20f00980ce66e36ff6f5992e25e98c4d.png " ")

  ![](images/a9c9c8224138421e5f5e53c9f1ff8a8d.png " ")

  ![](images/b992c2c86bca0ef278b6d608042997e2.png " ")

  The results of `setupTablesQueuesAndPropagation` should take a couple of minutes
  to complete, therefore we could open the Cloud Shell and check the logs, as we
  are waiting until all the messages have been received and confirmed.

17. (Optional) While waiting for `setupTablesQueuesAndPropagation` to complete, open the Cloud Shell and check the logs using the following command:

    ```
    <copy>logpod admin</copy>
    ```

  ![](images/6edf793e660c40736681881d4d59362e.png " ")

  We will see testing messages going in both directions between the two ATP
  instances across the DB link

  ![](images/cf0526b6ef1c3f21bb865947462bdb17.png " ")

18. (Optional) If it is necessary to restart, rerun the process or clean up the
    database:

    If **setupTablesQueuesAndPropagation** was executed, you need to run
    **unschedulePropagation** first.

  ![](images/6198a8af3b2c821a9378d493c60880ae.png " ")

  Afterwards, click **deleteUsers**.

  ![](images/76d791ffeb225ff0249f72b9d74595d8.png " ")

## **STEP 5**: Verify streaming orders into the orders database

1. As you have successfully set up the databases, you can now test the
    “VeggieDash” Food Order application. You will interact with several
    different data types, check the event driven communication, event sourcing
    and Command Query Responsibility Segregation via order and inventory
    services. Go ahead and deploy the related order, inventory and supplier
    Helidon services. The Food Order application consists of the following
    tables shown in the ER diagram

   ![demo-erd.png](images/a0f7c519ae73acfed3a5e47dfc74b324.png " ")

    The Food Order application consists of a mock Mobile App (Frontend Helidon
    microservice) that places and shows orders via REST calls to the order-helidon
    microservice. Managing inventory is done with calls over gRPC to the
    supplier-helidon microservice, as shown in the below architecture diagram.

   ![orderinventoryapp-microservices.png](images/44a8fd16bc5055d852ecde8347244dd6.png " ")

2. To deploy the order Helidon service, open the Cloud Shell and go to the
    order folder, using the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/order-helidon</copy>
    ```

   ![](images/38c28676009bd795b82d21e8ba640224.png " ")

3. Build the order Helidon image, using the following command

    ```
    <copy>./build.sh</copy>
    ```

   ![](images/9c1bb056869004a75b9dc7ad12844d00.png " ")

4. Once you’ve successfully built the docker image, go ahead and deploy it.

    ```
    <copy>./deploy.sh</copy>
    ```

   ![](images/fa8d34335bbf7bd8b98a2f210580135d.png " ")

5. Go ahead and execute the same steps for building and deploying the inventory
    Helidon service. We can actually speed this process by running all the above
    commands sequentially, using the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/inventory-helidon ; ./build.sh ; ./deploy.sh</copy>
    ```

   ![](images/2ee20f868b1d740d8ce7d3a7ec37fc03.png " ")

   Once the image has been deployed in a pod, you should see the following message.

   ![](images/d6bf26644dfc30c29ef27d64d4c5c5c9.png " ")

6. Use the same method to build and deploy the supplier Helidon service. Use
    the following command.

    ```
    <copy>cd $MSDATAWORKSHOP_LOCATION/supplier-helidon-se ; ./build.sh ; ./deploy.sh</copy>
    ```

   ![](images/3e833f33e529bdd714c5e6b94b6dfb94.png " ")

7. You can check that all images have been successfully deployed in pods by executing the following command.

    ```
    <copy>pods</copy>
    ```

   ![](images/5fad32d4c759a78653a31f68cffedfac.png " ")

8. The services are ready, and you can proceed to test the application
    mechanisms. Open the frontend microservices home page.

   ![](images/1c5362a024946b1552d659b0374a87e4.png " ")

9. To allow the inventory service to listen for events click **listenForMessages**.

   ![](images/8375e5e1f5a392735101a1b04ef3c48e.png " ")

10. Check the inventory of a given item such as cucumbers, by typing `cucumbers`
    in the veggie field and clicking **getInventory**. You should see the inventory
    count result 0.

   ![](images/ea46ee63349f987bd43f772ed6562a87.png " ")

11. (Optional) If for any reason you see a different count, click **removeInventory** to bring back the count to 0.

12. Let’s try to place an order for cucumbers by clicking **place order**.

   ![](images/3ed8a96fec2a7ed044dda26b67865df2.png " ")

13. To check the status of the order, click **showorder**. You should see a failed
    order status.

   ![](images/657d263f888691e7f1070d92201757b7.png " ")

   This is expected, because the inventory count for cucumbers was 0.

14. Click **addInventory** to add the cucumbers in the inventory. You
    should see the outcome being an incremental increase by 1.

   ![](images/2acf1d8f9634c598b44b5dd0f3815457.png " ")

15. Go ahead and place another order by clicking **place order**, and then click
    **showorder** to check the order status.

   ![](images/173839f1dd7c467a9706e551433af67b.png " ")

   ![](images/4916798cb22e9cd8a7dfa4d8dc01c5b9.png " ")

   The order should have been successfully placed, which is demonstrated with the order status showing success.

## Conclusion

Although this might look as a basic transactional mechanic, but the difference
in the microservices environment is that it’s not using a two-phase XA commit,
and therefore not using distributed locks. In a microservices environment with
potential latency in the network, service failures during the communication
phase or delays in long running activities, an application shouldn’t have
locking across the services. Instead, the pattern that is used is called the
saga pattern, which instead of defining commits and rollbacks, allows each
service to perform its own local transaction and published an event. The other
services listen to that event and perform the next local transaction.

In this architecture, there is a frontend service which mimics some mobile app
requests for placing orders. The frontend service is communicating with the
order service to place an order. The order service is then inserting the order
into the order database, while also sending a message describing that order.
This approach is called the event sourcing pattern, which due to its decoupled
non-locking nature is prominently used in microservices. Event sourcing pattern
entails sending an event message for every work or any data manipulation that
was conducted. In this example, while the order was inserted in the order
database, an event message was also created in the Advanced Queue of the Oracle
database.

Implementing the messaging queue inside the Oracle database provides a unique
capability of making the event sourcing actions (manipulating data and sending
an event message) atomically within the same transaction. The benefit of this
approach is that it provides a guaranteed once delivery, and it doesn’t require
writing additional application logic to handle possible duplicate message
deliveries, as it would be the case with solutions using separate datastores and
event messaging platforms.

In this example, once the order was inserted into the Oracle database, an event
message was also sent to the interested parties, which in this case is the
inventory service. The inventory service receives the message and checks the
inventory database, modifies the inventory if necessary, and sends back a
message if the inventory exists or not. The inventory message is picked up by
the order service which based on the outcome message, sends back to the frontend
a successful or failed order status.

This approach fits the microservices model, because the inventory service
doesn’t have any REST endpoints, and instead it purely uses messaging. The
services do not talk directly to each other, as each service is isolated and
accesses its datastore, while the only communication path is through the
messaging queue.

This architecture is tied with the Command Query Responsibility Segregation
(CQRS) pattern, meaning that the command and query operations use different
methods. In our example the command was to insert an order into the database,
while the query on the order is receiving events from different interested
parties and putting them together (from suggestive sales, inventory, etc).
Instead of actually going to suggestive sales service or inventory service to
get the necessary information, the service is receiving events.

Let’s look at the Java source code to understand how Advanced Queuing and Oracle
database work together.

![](images/614cf30e428caffbd7b373d5c4d91708.png " ")

What is unique to Oracle and Advanced Queuing is that a JDBC connection can be
invoked from AQ JMS session. Therefore we are using this JMS session to send and
receive messages, while the JDBC connection is used to manipulate the datastore.
This mechanism allows for both the JMS session and JDBC connection to exist
within same atomic local transaction.

You have successfully configured the databases with the necessary users, tables
and message propagation across the two ATP instances. You may proceed to the
next lab.


## Acknowledgements
* **Author** - Paul Parkinson, Consulting Member of Technical Staff
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Tom McGinn, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
