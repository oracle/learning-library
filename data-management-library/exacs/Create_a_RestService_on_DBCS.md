## Introduction

Application Express (APEX) is a great tool to build Applications, REST API's on Oracle Database. It enables us to creates REST services which can be a single point of access for Developers. The DBA's can provide access to users like developers without even having to share the connection details adding more security to the database.

In this lab, you are going to create a REST service which you will use in the next lab, to send data from a Python Application into Oracle Database.


To **log issues**, click [here](https://github.com/oracle/learning-library/issues/new) to go to the github oracle repository issue submission form.

## Objectives

- Learn how to build REST services using APEX.

## Required Artifacts

- Please ensure you have installed ORDS and APEX on the database instance you want to create a REST service. Refer **lab 16-1**for more information.


## Steps

### **STEP 1: Log into APEX and create a new workspace**

- Log into your APEX account using the default workspace.

```
The Link to connect to APEX is : http://IP_address_of_ORDS_server:ORDS_Port/ords
```
Note :
  1. if you have executed part-1 of this lab, The IP address of the ORDS server will be IP address of the compute instance provisioned in previous lab or the database server itself depending on the architecture you have selected while executing the terraform script.
  2. ORDS Port : This will be the port where ORDS is hosted. This is the port you entered into env-vars.sh before running the terraform script.
  
  - **Workspace**: internal
  - **user**: admin
  - **password**: <DB sys password>
    
    This is the same password we used while running the terraform script.

![](./images/apex/apex-1.png " ")

- Rest the password when prompted

![](./images/apex/apex-2.png " ")

- Click **Create Workspace** button on top right corner of the page.

![](./images/apex/apex-3.png " ")

- Enter Workspace Name and ID and click **next** button.

![](./images/apex/workspace-1.png " ")

- Select YES from the dropdown for Re-use existing schema.
- Select the schema we created earlier from the list.
- Enter the schema password.
- Select the space quota for the schema.

![](./images/apex/workspace-2.png " ")

- Click **Next**.

![](./images/apex/workspace-3.png " ")

- click **Next**
- enter admin password
- enter first name and last name for the apex user.(Optional)
- enter the email.
- click **next**.

![](./images/apex/workspace-4.png " ")

- Review the details and Click **Create Workspace**.

![](./images/apex/workspace-5.png " ")
![](./images/apex/workspace-6.png " ")

- Now logout and login using the workspace we just created. Reset the password if prompted.

![](./images/apex/workspace-7.png " ")
![](./images/apex/workspace-8.png " ")
![](./images/apex/workspace-9.png " ")

- Click on SQL Workshop  and then on RESTful Services tab and Click **Register schema with ORDS**  button, if prompted.

![](./images/apex/Picture300-8.png " ")
![](./images/apex/Picture300-9.png " ")
![](./images/apex/Picture300-7-1.png " ")

- A Pop-up window opens up. Select yes for enable restful services option, select  No for Install Sample service and select No for authorization required option. Click **Save Schema Attributes**.

![](./images/apex/enable_rest_2.png " ")
![](./images/apex/enable_rest.png " ")


- Click on **Modules** on the left panel.

![](./images/apex/Picture300-10.png " ")

- Click **Create Module** on top right of the screen.
- Enter the Module name and the Base Path of your choice. Click **Create Module** button.

![](./images/apex/Picture300-11.png " ")
![](./images/apex/create_module.png " ")

- Now, on the Module Definition page. Click **Create Template** on right side of the screen.

![](./images/apex/create_template.png " ")

- On the Template Definition Page, enter the URI template of your choice. Click **Create Template**.

![](./images/apex/Picture300-13.png " ")

- Now you will see a message on the top of the screen confirming that the Template is created.

- Now, click **Create Handler** button on right side of the screen.

![](./images/apex/create_handler.png " ")

- On the Handler Definition page, select the **Method** as GET and select the **Source Type** as PL/SQL from the dropdown.

-  Now, enter the below PL/SQL procedure in the **source** section below the comments box. This procedure will create a get request to extract data from the table containing tweets.

```
    <copy>begin
      apex_json.open_array;
      for c in ( select * from jsontweets ) loop
        apex_json.open_object;
          apex_json.write( 'timestamp', to_char( c.ts, 'yyyy/mm/dd hh24:mi:ss') );
          apex_json.write( 'tweet', c.tweetjson );
        apex_json.close_object;
      end loop;
      apex_json.close_array;
    end;</copy>
```

    **Note : we will create the tables we are referencing here in the next part of this lab**

- Now, click **Create Handler** button on top right of the page.

- Now, click on the template you created from the panel on the left side.

![](./images/apex/Picture300-16.png " ")

- Now, click on **Create Handler** button on right side of the screen again.

![](./images/apex/Picture300-18.png " ")

- Select the **Method** to be POST and copy the below PL/SQL procedure

```
  <copy>begin
    insert into jsontweets (ts, tweetjson) values (sysdate, :body);
  end;</copy>
```

   **Note : we will create the tables we are referencing here in the next part of this lab**

![](./images/apex/Post_request_apex.png " ")

- Scroll back up and click **Create Handler**.

- Copy the REST Endpoint by clicking on the copy button beside the Full URL on the Handler's Definition Page. 

![](./images/apex/Picture300-19.png " ")

- Now, your REST Service is ready!

- You are going to use this REST endpoint in the Python Application in the next lab.


- You are now ready to move to the next part of this lab.
- **Click on Lab 16-3 from the menu on the right.**
