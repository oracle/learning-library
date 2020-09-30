# Defining Web Sources

## Introduction
In this lab, you will learn how to utilize the REST APIs you created in the previous lab as the basis for Web Sources.

Estimated Time: 10 minutes

## **STEP 1** – Create an App  
In a normal development environment, rather than in a lab, at this point you would log out of the remote database, where you defined the REST APIs, and log into your local database where you want to build the application. However, given for this lab you are using the same workspace for both, there is no need to log out and log back in.

1. Return to the APEX Builder tab or window.
2. In the App Builder toolbar, click **App Builder**, and click **Create**.

    ![](images/go-create.png " ")

3. On the Create Application page, click **New Application**.

    ![](images/new-app.png " ")

4. On the Create an Application page, for Name, enter **REST Employees**.

    Click **Create Application**.

    ![](images/create-app.png " ")

    *Note: At this stage you do not want to add any pages as you have not yet defined the Web Source module.*

## **STEP 2** – Add Web Source for EMP

1. In the Application home page, click **Shared Components**.

    ![](images/go-shared.png " ")

2. Under **Data Sources**, click **Web Source Modules**.

    ![](images/go-web-source.png " ")

3. On the Web Source Modules page, click **Create**.

    ![](images/create-web-source-module.png " ")

4. For Method, click **Next**. *Default: From Scratch*

    ![](images/create-web-source-module2.png " ")

5. In the Create Web Source wizard, on the General dialog, enter the following:
    - **Web Source Type:** select **ORACLE REST Data Services**
    - **Name:** enter **REST EMP Source**
    - **URL Endpoint:** enter the REST URI you tested previously

    *Note: Your URL endpoint will be similar to https://{cloud\_url}/ords/{{your_schema}}/emp/hol/*

    Click **Next**.

    ![](images/set-url.png " ")

6. On the Remote Server dialog, review the Base URL and Service URL Path.   
    Click **Next**.

    ![](images/review-urls.png " ")

7. On the Authentication dialog, click **Discover**.

    - **Authentication Required:** Disabled/Grayed out

    ![](images/discover.png " ")

8. On the Preview dialog, click **Create Web Source**.

    ![](images/create-web-source.png " ")

## **STEP 3** – Adding Operations
Given the URL Endpoint used above, the **Create Web Source** operation determined that the **GET** and **POST** operations have been defined. You also defined handlers for **GET**, **PUT**, and **DELETE** for a specific employee record. Therefore, it is important to add additional operations for these handlers. If you do not add the operations then the relevant functionality will not be included, such as selecting a single record, updating a record, or deleting a record.

1. On the Web Source Modules page, click **REST EMP Source**.

    ![](images/edit-web-source.png " ")

2. On REST EMP Source page, click **Add Operation**. You may need to scroll down to see operations.

    ![](images/add-operation.png " ")

3. In the Web Source Operation page, enter the following.
    - **URL Pattern:** enter **:empno**
    - **HTTP Method:** select **GET**
    - **Database Operation:** select **Fetch single row**

    Click **Create**.

    ![](images/add-get.png " ")

4. On REST EMP Source page, click **Add Operation**.

    In the Web Source Operation page, enter the following.
    - **URL Pattern:** enter **:empno**
    - **HTTP Method:** select **PUT**
    - **Database Operation:** select **Update row**

  Click **Create**.

5. On REST EMP Source page, click **Add Operation**.

    In the Web Source Operation page, enter the following.
     - **URL Pattern:** enter **:empno**
     - **HTTP Method:** select **DELETE**
     - **Database Operation:** select **Delete row**

   Click **Create**.

![](images/all-operations.png " ")


## **Summary**
This completes Lab 3. You now know how to define a Web Source module within an application and add the required operations for full CRUD operations. [Click here to navigate to Lab 4](?lab=lab-4-creating-pages).

## **Acknowledgements**

 - **Author/Contributors** -  Salim Hlayel, Principle Product Manager
 - **Contributors** - Oracle LiveLabs Team (Arabella Yao, Product Manager Intern | Jaden McElvey, Technical Lead | Jeffrey Malcolm Jr, Intern)
 - **Last Updated By/Date** - Tom McGinn, Database Innovation Architect, Product Management, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
