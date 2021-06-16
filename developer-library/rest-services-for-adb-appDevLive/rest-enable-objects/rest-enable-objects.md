# Modern Application Development with Oracle REST Data Services - REST Enable Business Logic and Custom SQL

## Introduction

In this lab, you will use Database Actions and the REST console to build a REST API using a parametrized PL/SQL procedure and SQL statement. 

Estimated Lab Time: 20 minutes

#### About RESTful Web Services

Representational State Transfer (REST) is a style of software architecture for distributed hypermedia systems such as the World Wide Web. An API is described as RESTful when it conforms to the tenets of REST. Although a full discussion of REST is outside the scope of this document, a RESTful API has the following characteristics:

- Data is modeled as a set of resources. Resources are identified by URIs.
- A small, uniform set of operations are used to manipulate resources (for example, PUT, POST, GET, DELETE).
- A resource can have multiple representations (for example, a blog might have an HTML representation and an RSS representation).
- Services are stateless and since it is likely that the client will want to access related resources, these should be identified in the representation returned, typically by providing hypertext links.

#### RESTful Services Terminology

This section introduces some common terms that are used throughout this lab:

**RESTful service**: An HTTP web service that conforms to the tenets of the RESTful architectural style.

**Resource module**: An organizational unit that is used to group related resource templates.

**Resource template**: An individual RESTful service that is able to service requests for some set of URIs (Universal Resource Identifiers). The set of URIs is defined by the URI Pattern of the Resource Template

**URI pattern**: A pattern for the resource template. Can be either a route pattern or a URI template, although you are encouraged to use route patterns.

**Route pattern**: A pattern that focuses on decomposing the path portion of a URI into its component parts. For example, a pattern of /:object/:id? will match /emp/101 (matches a request for the item in the emp resource with id of 101) and will also match /emp/ (matches a request for the emp resource, because the :id parameter is annotated with the ? modifier, which indicates that the id parameter is optional).

**URI template**: A simple grammar that defines the specific patterns of URIs that a given resource template can handle. For example, the pattern employees/{id} will match any URI whose path begins with employees/, such as employees/2560.

**Resource handler**: Provides the logic required to service a specific HTTP method for a specific resource template. For example, the logic of the GET HTTP method for the preceding resource template might be:
```
select empno, ename, dept from emp where empno = :id
```
**HTTP operation**: HTTP (HyperText Transport Protocol) defines standard methods that can be performed on resources: GET (retrieve the resource contents), POST (store a new resource), PUT (update an existing resource), and DELETE (remove a resource).



![ORDS Termonology](./images/ords-module-template-uri.png)


### Objectives

- Publish REST API using Custom SQL
- Publish REST API using stored PL/SQL program


### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- Completed the [User Setups Lab](../user-setups/user_setups.md)
- Completed the [Create and auto-REST enable a table lab](../create_table/create_table.md)
- Completed the [Loading Data and Creating Business Objects Lab](../load_data_and_biz_objs/load_data_and_biz_objs.md)

## **STEP 1**: REST Enable a custom SQL Statement

**If this is your first time accessing the REST Workshop, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

1. Start by using the Database Actions Menu in the upper left of the page and select REST

    ![DB Actions Menus, choose REST](./images/rest-1.png)

2. Once on the REST page, use the upper tab bar to select **Modules**

    ![REST Tab Menu, choose Modules](./images/rest-2.png)

3. On the Modules page, left click the **+ Create Module** button in the upper right.

    ![Left click the + Create Modules button](./images/rest-3.png)

4. The **Create Module** slider comes out from the right of the page.

    ![Create Modules slider](./images/rest-4.png)

5. Using the **Create Module** slider, we start with the Module name. Lets use the following value of **com.oracle.livelab.api**:

    ````
    <copy>com.oracle.livelab.api</copy>
    ````

    ![Create Modules slider](./images/rest-5.png)

6. For the **Base Path** field, we can use the default of **/api/**. Enter /api/ in the base path field.

    ````
    <copy>/api/</copy>
    ````

    ![Create Modules slider](./images/rest-6.png)

7. When the **Create Module** slider looks like the below image (**NOTE: your URL hostname will be different than the below image**), left click the **Create** button.

    ![Create Modules slider](./images/rest-7.png)

8. Our module has now been created.

    ![The Modules page](./images/rest-8.png)

    We are now going to create a **Template** for the newly created module. Start by left clicking the **+ Create Template** button on the right side of the page, right under our module we just created.

    ![Left click the + Create Template button](./images/rest-9.png)

9. The **Create Template** slider comes out of the right of the page. 

    ![Create Template slider](./images/rest-10.png)
    
    Here we will create the endpoint or URL location for our REST enabled SQL Statement that takes in a value.

10. In the **URI Template** template field, enter sqlreport/:id

    ````
    <copy>sqlreport/:id</copy>
    ````

    ![URI Template field](./images/rest-11.png)

11. When the **URI Template** slider looks like the below image (**NOTE: your URL hostname will be different than the below image**), left click the **Create** button.

    ![Create Modules slider with all info, left click create](./images/rest-12.png)

12. Now that the template has been created

    ![Templates Page](./images/rest-13.png)

    we need to create the **Handler** that will contain the SQL Statement. Click the **+ Create Handler** button on the right of the page, just below our newly created template.

    ![Left click the + Create Handler button](./images/rest-14.png)

13. The **Create Handler** slider comes out of the right of the page. 

    ![Create Handler slider](./images/rest-15.png)

    Here we will be entering the SQL the REST endpoint will use.

14. Enter **select * from csv_data where col2 = :id** in the **Source** section of the **Create Handler** slider:

    ````
    <copy>select * from csv_data where col2 = :id</copy>
    ````

    ![Source Field](./images/rest-16.png)

15. When the **Create Handler** slider looks like the below image (**NOTE: your URL hostname will be different than the below image**), left click the **Create** button.

    ![Create Handler slider with all info, left click create](./images/rest-17.png)

16. Back on Template page, we can try our handler out. Click the **execute** button ![execute query button](./images/execute-button.png) in the **Source** section of the page.

    ![Execute button in source section of the page](./images/rest-18.png)

17. After clicking the **execute** button ![execute query button](./images/execute-button.png), a **Bind Variables** modal will appear. Enter **a1** for the value in **id field** and then left click **OK** on the modal.

    ![Bind Variables modal](./images/rest-19.png)

18. You can see the results of the query just below the **Source** section. (You may need to scroll the page down)

    ![Source query results](./images/rest-21.png)

19. We can try the REST endpoint by clicking the pop out icon ![pop out icon](./images/popout.png) in the Template region on the top of the page.

    ![pop out icon in the Template region on the top of the page](./images/rest-22.png)

20. In the new browser tab/window with the REST endpoint URL

    ![URL with bind variable](./images/rest-23.png)

    replace the :id with a1 and submit the URL

    ![submitted URL and working REST service](./images/rest-24.png)

## **STEP 2**: REST Enable Business Logic (PL/SQL procedure)

1. It's now time to REST enable our Business Logic or PL/SQL procedure we created in the previous lab. To start, left click our module com.oracle.livelab.api in the Database Actions breadcrumbs in the upper left of the page.

    ![Database Actions breadcrumbs](./images/rest-25.png)

2. As before, we are going to create a new **Template**. Left click the **+ Create Template** button on the right side of the page, right under our module.

    ![Left click the + Create Template button](./images/rest-9.png)

3. The **Create Template** slider comes out of the right of the page. 

    ![Create Template slider](./images/rest-10.png)
    
4. In the **URI Template** template field, enter bizlogic

    ````
    <copy>bizlogic</copy>
    ````

    ![URI Template field](./images/rest-26.png)

5. When the **URI Template** slider looks like the below image (**NOTE: your URL hostname will be different than the below image**), left click the **Create** button.

    ![Create Modules slider with all info, left click create](./images/rest-27.png)

6. Click the **+ Create Handler** button on the right of the page, just below our newly created template just as we did before.

    ![Left click the + Create Handler button](./images/rest-28.png)

7. The **Create Handler** slider comes out of the right of the page. 

    ![Create Handler slider](./images/rest-29.png)

8. We need to change the **Method** from GET to POST because we are submitting a value to the REST Service. Use the dropdown in the **Method** field to select **POST**.

    ![Selecting POST using the dropdown in the Method field](./images/rest-30.png)

    Upon changing the **Method** to post, we see the **Source Type** change to PL/SQL.

9. Now, in the **Source** field, enter the following PL/SQL

    ````
    <copy>
    BEGIN
        return_count(p_input => :id, p_output => :output);
    end;
    </copy>
    ````

    ![Create Handler slider](./images/rest-00.png)

10. When the **Create Handler** slider looks like the below image (**NOTE: your URL hostname will be different than the below image**), left click the **Create** button.

    ![Create Handler slider with all info, left click create](./images/rest-31.png)

11. Next step we need to create an output parameter so we can return the result; the count or rows where the passed in value is equal to the values in col2 in our table. On the bottom on the bizlogic details page, under the **Source** area, we see the **+ Create Parameter** button. Left click the **+ Create Parameter** button.

    ![Left click the + Create Parameter button](./images/rest-32.png)

12. The **Create Parameter** slider comes out of the right of the page. 

    ![Create Parameter slider](./images/rest-33.png)

13. For the **Parameter Name** field and the **Bind Variable Name** field, enter **output**

    ````
    <copy>output</copy>
    ````

    ![Create Parameter name field](./images/rest-34.png)

14. For the **Source Type** field, use the dropdown and select **Response**

    ![Source Type field](./images/rest-36.png)

15. For the **Parameter Type** field, use the dropdown and select **INT**. (We are returning a number remember)

    ![Parameter Type field](./images/rest-37.png)

16. Lastly, for the **Access Method**, use the dropdown and select **Output**

    ![Access Method field](./images/rest-38.png)

17. When the **Create Parameter** slider looks like the below image (**NOTE: your URL hostname will be different than the below image**), left click the **Create** button.

    ![Create Parameter slider with all info, left click create](./images/rest-39.png)

18. You will see the newly created parameter in the parameters table on the bottom of the page.

    ![Parameter created in report](./images/rest-40.png)

    We are now ready to test this REST API.

19. Left click **bizlogic** in the Database Actions breadcrumbs in the upper left of the page.

    ![bizlogic breadcrumb](./images/rest-41.png)

20. Now, using the popout menu icon ![popout menu icon](./images/pop-menu.png) on our bizlogic POST tile, select **Get cURL command**.

    ![selecting Get cURL command](./images/rest-42.png)

21. The cURL Command modal pops up.

    ![cURL Command modal](./images/rest-43.png)

    Use the **Fill Bind Variables Values** icon ![Fill Bind Variables Values icon](./images/fill-bind.png) to fill in the **id** field with the value of **a1** in the **Substitutions** modal. Then click OK when done.
    
    ![Substitutions modal](./images/rest-44.png)

22. Click the copy icon ![Fill Bind Variables Values icon](./images/copy-copy.png) to copy the cURL command with the added Substitution value.

    ![Copied cURL command](./images/rest-45.png)

23. Using the OCI Cloud Shell, paste and run the cURL command and see that the count is returned as the output variable.

    ```
    curl -X POST \
    'https://coolrestlab-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/api/bizlogic' \
    --header 'Content-Type: application/json' \
    --data-binary '{
    "id": "a1",
    "output": "" 
    }'
    {"output":8204}%                                                                
    ```

    ![Cloud shell and cURL](./images/rest-46.png)

    You can test other values by changing the id variable. Valid combinations are the first character is a lowercase **a** through **f** and the second character can be *1* though **9**. Valid examples are a1, e9, d3, b6, etc.

## Conclusion

In this lab, you published a REST API using Custom SQL and accepting an input as well as published a REST API using a stored PL/SQL procedure.

You may now [proceed to the next lab](#next).


## Acknowledgements

- **Author** - Jeff Smith, Distinguished Product Manager and Brian Spendolini, Trainee Product Manager
- **Last Updated By/Date** - Anoosha Pilli, Brianna Ambler, June 2021
- **Workshop Expiry Date** - April 2022

