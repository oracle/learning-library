# Modern Application Development with Oracle REST Data Services - Securing a REST Endpoint

## Introduction

In this lab you will Securing the REST Endpoints you created in the previous lab.

Estimated Lab Time: 10 minutes

### Objectives

- Create an OAuth2 token
- Secure REST endpoints
- Test the secure end to end flow

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- Completed the [User Setups Lab](../user-setups/user_setups.md)
- Completed the [Create and auto-REST enable a table lab](../create_table/create_table.md)
- Completed the [Loading Data and Creating Business Objects Lab](../load_data_and_biz_objs/load_data_and_biz_objs.md)
- Completed the [REST Enable Business Logic and Custom SQL Lab](../REST_enable_objects/REST_enable_objects.md)

## **STEP 1**: Securing the REST Endpoint

**If this is your first time accessing the REST Workshop, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

1. If not already there from the previous lab, we need to be on the **REST Database Actions** page. To do this, use the Database Actions menu in the upper left of the page and choose **REST** in the Development list.

    ![Database Actions Menu, Development then REST](./images/sec-1.png)

2. Next, we want to select the **Security Tab** on the top of the page and then select **Roles**.

    ![On the Top Menu Bar, click Security Tab then select Roles](./images/sec-2.png)


3. On the **Roles** page, start by left clicking the **+ Create Role** button in the upper right of the page.

    ![Click the Create Role button](./images/sec-3.png)

4. The **Role Definition** modal will pop up.

    ![Role Definition Modal](./images/sec-4.png)

5.  Use the **Role Name** field to name our role. Let's use **oracle.livelabs.role.admin**.

     ````
    <copy>oracle.livelabs.role.admin</copy>
    ````

    ![Role Name Field](./images/sec-5.png)

6.  When your **Role Definition** modal looks like the below image, click the **Create** button.

    ![Click the Create button](./images/sec-6.png)

7. We now must assign **privileges** to this role. Again using the REST Tab Bar on the top of the page, left click **Security** and select **Privileges**

    ![On the Top Menu Bar, click Security Tab then select privileges](./images/sec-7.png)

8. On the **Privileges** page, start by left clicking the **+ Create Privilege** button in the upper right of the page.

    ![Click the Create Privilege button](./images/sec-8.png)

9. The **Create Privilege** slider appears from the right.

    ![Create Privilege slider](./images/sec-9.png)

10. In the **Label** field, we can name this privilege **Livelabs REST Privilege**.

     ````
    <copy>Livelabs REST Privilege</copy>
    ````

    ![Label Field](./images/sec-10.png)

11. For the **Name** field, we can enter this **oracle.livelabs.privilege.admin**.

     ````
    <copy>oracle.livelabs.privilege.admin</copy>
    ````

    ![Name Field](./images/sec-11.png)

12. Next, in the **Description** field, enter **Livelabs Privilege for Business Logic REST Services**.

     ````
    <copy>Livelabs Privilege for Business Logic REST Services</copy>
    ````

    ![Description Field](./images/sec-12.png)

13. When your **Create Privilege** slider looks like the following image

    ![completcompleted Create Privilege** slider](./images/sec-13.png)

    left click the **Roles** tab on the top of the slider.

    ![Roles tab on the top of the slider](./images/sec-14.png)

14. On the **Roles** tab, use the shuttle to move the role we created, **oracle.livelabs.role.admin**, to the right side. We can do this by double left clicking on it or by left clicking it and then clicking the single arrow pointing to the right. Ensure the shuttle looks like the below image where **oracle.livelabs.role.admin** is on the right side.

    ![Roles shuttle](./images/sec-15.png)

    You can see that when we auto-REST enabled our table, privileges and roles where automatically created for us (oracle.dbtools.role.autorest.ADMIN.CSV_DATA)

15. When the single role have been moved to the right of the shuttle, left click the **Protected Modules** tab on the top of the **Create Privilege** slider.

    ![Protected Modules tab](./images/sec-16.png)

16. We see on the **Protected Modules tab** the module name we created in the pervious lab; **com.oracle.livelab.api**. Just as we did in the previous shuttle, move **com.oracle.livelab.api** from the left side to the right side. 

    ![Protected Modules shuttle](./images/sec-17.png)

    When done, left click the **Create** button on the **Create Privilege** slider.

    ![click the Create button on the Create Privilege slider](./images/sec-18.png)

17. Next, we want to select the **Security Tab** on the top of the page and then select **OAuth Clients**.

    ![On the Top Menu Bar, click Security Tab then select OAuth Clients](./images/sec-19.png)

18. To create our OAuth client we will secure our REST endpoints with, click the **+ Create OAuth Client** button in the upper right of the page.

    ![Click the Create OAuth Client button](./images/sec-20.png)

19. The **Create OAuth Client** slider will come out on the right of the page. 

    ![Create OAuth Client slider](./images/sec-21.png)

20. In this form we first need to name our OAuth Client. Enter **oauthclient** into the **Name** field. 

    ````
    <copy>oauthclient</copy>
    ````

    ![Name Field](./images/sec-22.png)
    
21. Next we can give it a description. Let use **Security on my REST Service** as a value in the **Description Field**.
    
    ````
    <copy>Security on my REST Service</copy>
    ````

    ![Description Field](./images/sec-23.png)

22. The following field, **Support URI**, is where a client will be taken upon an authorization error or failure. For this lab, we will use "https://www.oracle.com/rest/"
    
     ````
    <copy>https://www.oracle.com/rest/</copy>
    ````
    
    ![Support URI Field](./images/sec-24.png)

23. Finally, we need an **support email** for contacting someone. You can enter your email address or use admin@dinosaurfootball.com in the **Support Email** field of the form.

     ````
    <copy>admin@dinosaurfootball.com</copy>
    ````

    ![Support Email Field](./images/sec-25.png)

24. Once your form looks similar to the image below:

    ![Support Email Field](./images/sec-26.png)    
    
    left click the **Roles Tab** on the top of the Create OAuth Client slider.

    ![Roles Tab on the OAuth Client Slide Out Panel](./images/sec-27.png)

25. Use the **shuttle** to move the **oracle.livelabs.role.admin** role to the right side.

    ![Use the shuttle to move the oracle.livelabs.role.admin role to the right side](./images/sec-28.png)

26. When your **Roles Tab** looks like the below image in the  Create OAuth Client slider, left click the **Create** button.

    ![left click the create button](./images/sec-29.png)

27. You can now see the created **OAuth Client** tile on the OAuth Clients page.

    ![OAuth Client tile on the OAuth Clients page](./images/sec-30.png)

28. Before we secure the REST endpoint, we need to get a token to pass to the secured REST service once its enabled. To get this token, we can click the pop out menu icon ![pop out menu icon](./images/three-dot-pop.png) on our OAuth tile and select **Get Bearer Token**.

    ![click the pop out menu icon on our OAuth tile and select Get Bearer Token](./images/sec-31.png)

29. The OAuth Token modal will provide the token text in the **Current Token** field. You can use the copy icon ![copy icon](./images/copy-copy.png) to copy this token text. Save it to a text document or notes application because we will need it when calling the secured REST service. The modal also gives us a cURL command to get a token if we need to include this in our applications.

    ![Click the copy icon to save the Token Text](./images/sec-32.png)

    Left click the **OK** button when you are done getting and saving the token text. 

    ![Left click the OK button](./images/sec-33.png)

30. Now its the moment you have been waiting for; time to secure the REST service. Actually, its already secure. When we created the OAuth client with the role, the modules we protected are now secure. We can try this by running a previously working REST API. (**NOTE: your URL hostname will be different than the below command**)

    Remember in the last lab, we created a REST API for our bizlogic? Let's take that cURL command again:

    ```
    curl --location --request POST \
    'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/bizlogic' \
    --header 'Content-Type: application/json' \
    --data-binary '{
    "id": "a1",
    "output": "" 
    }'
    ```
    and using the OCI Cloud Shell, run it again:

    ```
    > curl --location --request POST \
    'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/bizlogic' \
    --header 'Content-Type: application/json' \
    --data-binary '{
    "id": "a1",
    "output": ""
    }'

    {
        "code": "Unauthorized",
        "message": "Unauthorized",
        "type": "tag:oracle.com,2020:error/Unauthorized",
        "instance": "tag:oracle.com,2020:ecid/8576f44b797d6adfbe7b21e3718bf3b6"
    }%  
    ```
    We are not not authorized to use this REST endpoint any longer.

31. To get this REST API working again, we need to add **--header 'Authorization: Bearer VALUE'** to our cURL command. The **VALUE** is going to be the token text we saved off from a few steps back. (**NOTE: your URL hostname will be different than the below command**)

    We can add this to our cURL command as follows:

    ```
    curl -X POST --header 'Authorization: Bearer tW-AM_cDQu0l8oAsh707vw' \
    'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/bizlogic' \
    --header 'Content-Type: application/json' \
    --data-binary '{
    "id": "a1",
    "output": "" 
    }'
    ```    

32. Now using the OCI Cloud Shell and your new cURL command with the **--header 'Authorization: Bearer VALUE'** section added with your token text, run the new cURL command. (**NOTE: your URL hostname will be different than the below command**)

    ```
    curl -X POST --header 'Authorization: Bearer tW-AM_cDQu0l8oAsh707vw' \
    'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/bizlogic' \
    --header 'Content-Type: application/json' \
    --data-binary '{
    "id": "a1",
    "output": ""
    }'
    ``` 

    We now see that we do get a value back from the REST API
    ```
    {"output":8204}% 
    ```
33. We can also use this on our other REST API that takes in a value and returns a report. (**NOTE: your URL hostname will be different than the below command**)

    The endpoint for that REST API was

    ```
    https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/sqlreport/<VALUE>
    ```

    So we can try out the following (**NOTE: your URL hostname will be different than the below command**):
    
    ```
    curl -X GET  'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/sqlreport/a1'
    ```

    and as expection, we get **Unauthorized**.

34. Now lets add the token (**--header 'Authorization: Bearer VALUE'**) to this command. (**NOTE: your URL hostname will be different than the below command**)

    ```
    curl -X GET --header 'Authorization: Bearer tW-AM_cDQu0l8oAsh707vw' 'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/sqlreport/a1'
    ```

    and we see the results we expect

    ```
    {"items":[{"col1":"798812df","col2":"a1","col3":"4166997"},{"col1":"59fd433c","col2":"a1","col3":"32470891"},{"col1":"6c1298ef","col2":"a1",
    "col3":"506747"},{"col1":"243f5660","col2":"a1","col3":"87300261"},{"col1":"f62af3d4","col2":"a1","col3":"31094545"},{"col1":"af2fc686","col2":"a1",
    "col3":"48206518"},{"col1":"9d4f725e","col2":"a1","col3":"36224185"},{"col1":"041d6b03","col2":"a1","col3":"23890702"},{"col1":"f8c87baa","col2":"a1",
    "col3":"852530"},{"col1":"d98f3e5b","col2":"a1","col3":"9864895"},{"col1":"5cbb6ddc","col2":"a1","col3":"60428923"},{"col1":"474c024a","col2":"a1",
    "col3":"85183686"},{"col1":"a0707a73","col2":"a1","col3":"167176502"},{"col1":"3447e214","col2":"a1","col3":"110333373"},{"col1":"69face01",
    "col2":"a1","col3":"18449519"},{"col1":"9198731a","col2":"a1","col3":"150740437"},{"col1":"55789f0a","col2":"a1","col3":"119272860"},
    {"col1":"03801afd","col2":"a1","col3":"75179648"},{"col1":"dbdf5867","col2":"a1","col3":"91475805"},{"col1":"93adc64d","col2":"a1","col3":"39287205"},
    {"col1":"2b130ef8","col2":"a1","col3":"206753925"},{"col1":"1f6bec10","col2":"a1","col3":"17745238"},{"col1":"81f46a8d","col2":"a1","col3":"54692392"}
    ,{"col1":"2ebd5ecb","col2":"a1","col3":"94437756"},{"col1":"4d514c12","col2":"a1","col3":"145885382"}],"hasMore":true,"limit":25,"offset":0,
    "count":25,"links":[{"rel":"self","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/sqlreport/a1"},
    {"rel":"describedby","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/metadata-catalog/api/sqlreport/item"},
    {"rel":"first","href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/sqlreport/a1"},{"rel":"next",
    "href":"https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/sqlreport/a1?offset=25"}]}% 
    ```

## Conclusion

In this lab, you secured your custom REST APIs with OAuth2 authentication.

You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - Brianna Ambler, June 2021
- **Workshop Expiry Date** - April 2022

