# Send Log Data to an Autonomous Database with Service Connector Hub

In this lab, you will create a service connector to move log data from the Logging service to an Autonomous Database using Functions and Oracle REST Data Services.

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- You have completed the setup lab.
- You have completed the CSV Functions Lab

## **STEP 1:** Creating a Collection

**If this is your first time accessing the JSON Worksheet, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

### **Create a Collection using the Database Actions UI**

1. The first step here is to create a **collection** for our JSON Documents. We can do this two ways. The first method is to use the UI in Database Actions. We can start by selecting **JSON** in the **Database Actions Menu**.

    ![JSON in the Database Actions Menu](./images/json-1.png)

2. On the JSON worksheet, left click the **Create Collection** button in the middle of the page.

    ![left click the Create Collection button](./images/json-2.png)

3. Using the **New Collection** slider

    ![New Collection slider](./images/json-3.png)

    enter **loggingcollection** in the **Collection Name** field

    ````
    <copy>
    loggingcollection
    </copy>
    ````

    ![Collection Name field](./images/json-4.png)

4. When your **New Collection** slider looks like the below image, left click the **Create** button.

    ![left click the Create button](./images/json-5.png)

### **Create a Collection using the SODA for REST APIs**

1. We can create a collection with the **SODA for REST APIs** as well. To do this, open an **OCI Cloud Shell**. We can do this by clicking the Cloud Shell icon in the upper right of the OCI web console.

    ![Cloud Console Link in OCI Web Console](./images/json-6.png)

2. We can now use the **OCI Cloud Shell** that appears on the bottom of the OCI Web Console Page.

    ![OCI Cloud Shell](./images/json-7.png)

3. To use the SODA for REST APIs, we need to construct the URL. To start, we use cURL and pass in the username/password combination. Be sure to use the password that you set for our user back in the User Setups lab.

    ```
    curl -u "admin:PASSWORD"
    ```

    Also, we can add the -i which tells the cURL command to include the HTTP response headers in the output. This is helpful with debugging

    ```
    curl -u "admin:PASSWORD" -i
    ```

    next, this is going to create a collection, so we will use the **PUT HTTP method**. 

    ```
    curl -u "admin:PASSWORD" -i -X PUT
    ```

    Lastly, we will add the URL. The URL is built up with the hostname followed by ords, followed by our schema name admin

    ```
    https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/
    ```

    then, add soda to indicate we want to use the SODA APIs followed by latest and the name of the collection airportdelayscollection. Your URL should look similar to the below one. (Your hostname will be different then this sample)

    ```
    https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/soda/latest/loggingcollection
    ```

    And when we put it all together, we get the following:

    ```
    curl -u "admin:PASSWORD" -i -X PUT https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/soda/latest/loggingcollection
    ```

4. We now can take this cURL command and run it in the OCI Cloud Shell. **REMEMBER to use *your* password in place of PASSWORD**

    ![OCI Cloud Shell with cURL command](./images/json-8.png)

    ```
    curl -u "admin:PASSWORD" -i -X PUT https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/soda/latest/loggingcollection
    HTTP/1.1 201 Created
    Date: Mon, 26 Apr 2021 15:53:46 GMT
    Content-Length: 0
    Connection: keep-alive
    X-Frame-Options: SAMEORIGIN
    Cache-Control: private,must-revalidate,max-age=0
    Location: https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/soda/latest/loggingcollection/
    ```
    If the collection already exists, you will get a message similar to the following:

    ```
    HTTP/1.1 200 OK
    Date: Mon, 26 Apr 2021 16:07:38 GMT
    Content-Length: 0
    Connection: keep-alive
    X-Frame-Options: SAMEORIGIN
    Cache-Control: private,must-revalidate,max-age=0
    ```

## **STEP 2:** Create and Deploy a Function

1. The next few steps will be using the **OCI Cloud Shell**. We can do this by clicking the **Cloud Shell icon** in the upper right of the OCI web console.

    ![Cloud Console Link in OCI Web Console](./images/json-6.png)

2. Seeing in the previous lab we set up our context and docker repository, we can start by just logging back into the repository so that we can deploy the next function. As a reminder, the command we will be running will be in the format **docker login -u '<tenancy-namespace>/<user-name>' <region-key>.ocir.io** as seen below:

    ```
    docker login -u 'mytenancy/oracleidentitycloudservice/bspendol' fra.ocir.io
    ```

    If your tenancy is federated with Oracle Identity Cloud Service, you will use the above format using oracleidentitycloudservice. If the user you are using is not a federated user, you will use the syntax tenancy_name/user_name. Remember to use the token we created in the setup part of the lab just as we did previously.

    ```
    bspendol@cloudshell:~ (eu-frankfurt-1)$ docker login -u 'mytenancy/oracleidentitycloudservice/bspendol' fra.ocir.io
    Password: 

    Login Succeeded
    ```

3. Next, we verify we can see our application by running fn list apps

    ```
    bspendol@cloudshell:~ (eu-frankfurt-1)$ fn list apps
    NAME            ID
    functionsApp    ocid1.fnapp.oc1.eu-frankfurt-1.aaaaaaaaf2snfvp2gxhghcsvadeffffdddd32rf7hqh3lbcgiztw2xkqrv74ha
    ```

    We are now setup to deploy our function.

4. Download the function code in your OCI Cloud Shell with the following command:

    ```
    curl -o func2.zip https://xxxxxx/func.zip
    ```    

    Once downloaded, unzip it

    ```
    gunzip func2.zip
    ```

    ````
    <copy>
    gunzip func2.zip
    </copy>
    ````

5. Move into that directory that was created

    cd func2

6. Now we can deploy our function to our application. Use the following command (this command can also be found as step number 10 on the Functions Getting Started page):

    ```
    fn -v deploy --app functionsApp
    ```
    
    ````
    <copy>
    fn -v deploy --app functionsApp
    </copy>
    ````

    The OCI Cloud Shell will report back the progress of the function's deployment

    ```
    Pushing fra.ocir.io/mytenancy/livelabsrepo/log-to-adw-with-ords-and-fn:0.0.68 to docker registry...
    The push refers to repository [fra.ocir.io/mytenancy/livelabsrepo/log-to-adw-with-ords-and-fn]
    2775700c8222: Pushed 
    9b50566e770b: Pushed 
    522edf3e7d77: Pushed 
    3613dd225bdd: Pushed 
    c09710e8f799: Pushed 
    43022de19af6: Pushed 
    cdf79d97e316: Pushed 
    88fb2db345cd: Pushed 
    747aa001f428: Pushed 
    f9ef7f1bcb19: Pushed 
    02c055ef67f5: Pushed 
    0.0.68: digest: sha256:2a9b72e1f08abc89ce3ac98bc1b074efe0bfccbc1103a14ba6b0b4c9745c623c size: 2623
    Updating function log-to-adw-with-ords-and-fn using image fra.ocir.io/mytenancy/livelabsrepo/log-to-adw-with-ords-and-fn:0.0.68...
    Successfully created function: log-to-adw-with-ords-and-fn with fra.ocir.io/mytenancy/livelabsrepo/log-to-adw-with-ords-and-fn:0.0.68
    ```

7. With the function deployed, we need to configure some of the parameters needed so that it can find and login to the database. Configuring function parameters is in the following syntax"
    ```
    fn config function <app-name> <function-name> <parameter> <parameter-value>
    ```
    We have the following values to supply:

    ```
    fn config function <app-name> <function-name> ords_base_url <ORDS Base URL>
    fn config function <app-name> <function-name> db_schema <DB schema>
    fn config function <app-name> <function-name> db_user <DB user name>
    fn config function <app-name> <function-name> secret_ocid <secret ocid>
    fn config function <app-name> <function-name> collection <input bucket name>
    ```
    And with the values we need

    ````
    <copy>
    fn config function functionsApp log-to-adw-with-ords-and-fn ords_base_url "https://xxxxxx-xxxxxx/ords/"
    fn config function functionsApp log-to-adw-with-ords-and-fn db_schema "admin"
    fn config function functionsApp log-to-adw-with-ords-and-fn db_user "admin"
    fn config function functionsApp log-to-adw-with-ords-and-fn secret_ocid "xxxxxxxxx"
    fn config function functionsApp log-to-adw-with-ords-and-fn collection "loggingcollection"
    </copy>
    ````

    The above commands need some values specified before running them. First, we need to change the **ords_base_url** with the one you recorded after creating the table earlier in this lab. If you remember mine was **https://myadbhostname-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/sql-developer** so ill want to set this parameter to:
    ```
    fn config function functionsApp log-to-adw-with-ords-and-fn ords_base_url "https://myadbhostname-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/"
    ```
    Your value will be similar (but not the same).

    For the **secret_ocid** parameter, use the OCID of the password you entered in the secrets service during the setup.

    ```
    fn config function functionsApp log-to-adw-with-ords-and-fn secret_ocid "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaau3i6vkyabasdasdasdasdasdasdasd43435ehgdfq"
    ```

    Once the values are entered, run them in the OCI Cloud Shell.
    ```
    bspendol@cloudshell:~ (eu-frankfurt-1)$ fn config function functionsApp log-to-adw-with-ords-and-fn ords_base_url "https://myadbhostname-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/"
    functionsApp log-to-adw-with-ords-and-fn updated ords_base_url with https://myadbhostname-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/
    
    bspendol@cloudshell:~ (eu-frankfurt-1)$ fn config function functionsApp log-to-adw-with-ords-and-fn db_schema "admin"
    functionsApp log-to-adw-with-ords-and-fn updated db_schema with admin
    
    bspendol@cloudshell:~ (eu-frankfurt-1)$ fn config function functionsApp log-to-adw-with-ords-and-fn db_user "admin"
    functionsApp log-to-adw-with-ords-and-fn updated db_user with admin
    
    bspendol@cloudshell:~ (eu-frankfurt-1)$ fn config function functionsApp log-to-adw-with-ords-and-fn secret_ocid "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaau3i6vkyabasdasdasdasdasdasdasd43435ehgdfq"
    functionsApp log-to-adw-with-ords-and-fn updated dbpwd_cipher with ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaau3i6vkyabasdasdasdasdasdasdasd43435ehgdfq
    
    bspendol@cloudshell:~ (eu-frankfurt-1)$ fn config function functionsApp log-to-adw-with-ords-and-fn collection "loggingcollection"
    functionsApp log-to-adw-with-ords-and-fn updated input_bucket with loggingcollection
    ```
    Our function is now configured. At any time you can list the configuration parameters in a function with the command:
    ```
    fn list config fn <application-name> <function-name>
    ```
    so for our function and application it would be
    ```
    fn list config fn functionsApp log-to-adw-with-ords-and-fn
    ```
    The Application Details page will also reflect this function has been created.

    ![Deployed Function](./images/func-3.png)


## **STEP 3:** Create a Service Connector

1. Use the OCI web console drop down menu to go to **Observability & Management** and then **Service Connectors**.

    ![Observability & Management and then Service Connectors](./images/con-1.png)

2. Next, ensure we are using the livelabs compartment for this **Service Connector** we are about to create. Use the **Compartments** drop down on the left side of the page to select **livelabs**.

    ![choose compartment](./images/con-2.png)

3. Click the **Create Service Connector** button.

    ![Click the Create Service Connector button](./images/con-3.png)

4. On the Create Service Connector page, start by giving the Service Connector a name. Use the **Connector Name** field and enter **Send Logs to My Autonomous Database**.

    **Connector Name:** Send Logs to My Autonomous Database

    ````
    <copy>
    Send Logs to My Autonomous Database
    </copy>
    ````
    ![Connector Name Field](./images/con-4.png)

5. For the **Description** field, use the same value as the Connector Name.

    **Description:** Send Logs to My Autonomous Database

    ````
    <copy>
    Send Logs to My Autonomous Database
    </copy>
    ````

    ![Description Field](./images/con-5.png)

6. Ensure the **Resource Compartment** is set to **livelabs**

    ![Resource Compartment](./images/con-6.png)

    And the top naming section should look like the following image:

    ![top naming section](./images/con-7.png)   

7. Now, in the **Configure Service Connector** section, we will be selecting our source and target services to move log data to the database. Starting with the **Source** dropdown

    ![source dropdown](./images/con-8.png)   

    select **Logging** as the **Source**

    ![select Logging as the Source](./images/con-9.png)   

8. In the **Configure source connection** section, ensure the **Compartment Name** is livelabs

    ![compartment name is livelabs](./images/con-10.png)   

9. For **Log Group**, select **Default_Group**

    ![Log Group is Default Group](./images/con-11.png) 

10. And for the **Logs** dropdown, select **functionsApp_invoke**, the log we created in the previous lab to track the batch load insert.

    ![Log is functionsApp_invoke](./images/con-12.png) 

    The **Configure source connection** section should look like the following image:

    ![Completed Configure source connection section](./images/con-13.png) 

11. The **Target** section is next. Use the **Target** dropdown to select **Functions**.

    ![Target dropdown to select Functions](./images/con-14.png) 

12. Once **Functions** has been selected using the **Target** dropdown, scroll down the page to find the **Configure target connection** section, just below the **Configure Function Task (Optional)** section.

    ![Configure target connection** section](./images/con-15.png) 


13. Ensure the **Compartment** dropdown is set to **livelabs**

    ![Resource Compartment](./images/con-16.png)

14. Using the **Function Application** dropdown, select **functionsApp**.

    ![Resource Compartment](./images/con-17.png)


15. Using the **Function** dropdown, select **log-to-adw-with-ords-and-fn**

    ![Function** dropdown, select log-to-adw-with-ords-and-fn](./images/con-18.png)

    Your **Configure target connection** section should look like the following image:

    ![Completed target connection section](./images/con-19.png)

    and if you scroll the page up, you can see the mini-topology map has our services and green checks indicating we are ready to create.

    ![mini-topology map](./images/con-20.png)

16. On the lower part of the page, you may see a prompt to create a policy (required for access to create or update a service connector). If you do, click the **Create** button for this policy to be auto-created.

    ![prompted to create a policy](./images/pol-1.png)

17. When done reviewing, click the **Create** button in the lower left of the page.

    ![click the **Create** button](./images/con-21.png)

18. Our Service Connector is created and ready to be used.

    ![Created Service Connector](./images/con-22.png)

## **STEP 4:** Testing the flow

1. To test the entire flow, we need to put a csv file into the input-bucket bucket just as we did in the previous lab. Use the OCI web console drop down menu to go to **Storage** and then **Buckets**.

    ![Storage then Buckets](./images/full-1.png)

2. Click the **input-bucket** link in the **Name Column**.

    ![Click the input-bucket link](./images/full-2.png)

3. In the **Objects Section**, click the **Upload** button.

    ![click the Upload button](./images/full-3.png)

4. On the **Upload Objects** form, use the **Choose Files from your Computer** section to drag and drop or file browse to the file1.csv file we used when creating the table earlier in this lab.

    ![Find and upload the file](./images/full-4.png)

5. Once selected, click the **Upload** button.

    ![click the Upload button](./images/full-5.png)

6. To see the logs uploaded to the database, we need to go back to the JSON worksheet. Back in **Database Actions**, choose **JSON** in the **Database Actions Menu**.

    ![JSON in the Database Actions Menu](./images/json-1.png)

or select the JSON tile on the **Database Actions** homepage.

    ![JSON in the Database Actions Menu](./images/full-6.png)

7. Click on our collection **loggingcollection** on the left side of the page in the **Collections Navigator**

    ![JSON in the Database Actions Menu](./images/full-7.png)

8. Now using the worksheet, issue a **Query by Example** that will bring back all records. We can do this by typeing **{}** in the worksheet
    ````
    <copy>
    {}
    </copy>
    ````
    ![All records Query by Example](./images/full-8.png)

    and then clicking the **Run Query** button.

    ![All records Query by Example results](./images/full-9.png)

9. We can filter our search to just logs that deal with our CSV file insert. Issue the following **Query by Example** 
    ````
    <copy>
    {"subject": "csv-to-adw-with-ords-and-fn"}
    </copy>
    ````

    ![filtered Query by Example](./images/full-10.png)

    and then clicking the **Run Query** button.

    ![filtered Query by Example results](./images/full-1.png)

## Conclusion

In this section, you created a function to automate the loading of logs into a database using the service connector.

## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager, Greg Verstraeten, Product Manager
- **Last Updated By/Date** - Brian Spendolini, June 2021