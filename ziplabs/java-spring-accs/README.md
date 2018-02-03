# Deploy a Spring Application to Oracle Cloud #

## ![](../common/img/32_begin.png) Before You Begin ##
This 15-minute tutorial shows you how to prepare a REST application built using Spring Data REST to be deployed to Oracle Application Container Cloud Service.
                            
### Background ###
Oracle Application Container Cloud Service includes Oracle Java SE Cloud Service, which lets you deploy Java applications to the Oracle Cloud.

For your application to run properly on Oracle Application Container Cloud Service, it must comply with the following requirements:

* The application must be self-contained. The application must include everything it needs to run independently.
* Your application must listen to requests on a port provided by the `PORT` environment variable. Oracle Application Container Cloud uses this port to redirect requests made to your application.
* The application must include a `manifest.json` file. This file specifies information that Oracle Application Container Cloud Service requires to run your application properly. Optionally you can also specify additional information about instance scaling, environment variables, and service bindings in a `deployment.json` file.
* The application must be bundled in a .zip, .tgz, or .tar.gz file. The application archive must include all the project dependencies and optionally the manifest.json file at the root.

### What Do You Need? ###

* Access to an instance of Oracle Application Container Cloud Service
* [Maven 3.0+](http://maven.apache.org/download.cgi)
* [cURL 7.0+](http://curl.haxx.se/download.html) with SSL support
* Book application service [book-service.zip](files/book-service.zip)
* [Git](https://git-scm.com/downloads) (Git CMD shell to execute cURL commands)

## ![](../common/img/32_1.png) Create the Manifest.json File ##
1. Extract the content of the `book-service.zip` file in your local system.
2. Create a `manifest.json` file at the same level than the `pom.xml` file and open it in a text editor.
3. Add the following content and save the file.<br>
```json
{
    "runtime": {
        "majorVersion": "8"
    },
    "command": "java -jar book-service-1.0-SNAPSHOT.jar",
    "release": {
        "build": "150520.1154",
        "commit": "d8c2596364d9584050461",
        "version": "1.0"
    },
    "notes": "Book REST Application using Spring Data REST"
}
```

## ![](../common/img/32_2.png) Prepare the Application to Read the PORT Environment Variable ##
1. In the src/main directory, create the resources folder.
2. In the resources directory, create the application.properties file.
3. Add the following content:<br>
`server.port=${PORT}`

## ![](../common/img/32_3.png) Compile and Package Your Application ##

1. Open a command-line window (or Terminal in Linux) and go to the `book-service` directory.
2. Compile and package your application using the Maven command:<br>
`mvn compile package`
    
## ![](../common/img/32_4.png) Deploy your Application to Oracle Application Container Cloud Service ##
1. Log in to Oracle Cloud at [http://cloud.oracle.com/](http://cloud.oracle.com/). Enter the **Identity Domain**, **User Name**, and **Password** for your account.
2. In the Dashboard, click **Instances** to open the Oracle Application Container Cloud Service console.
<br>![deploy-02.jpg](img/deploy-02.png)
<br>[Description of the illustration deploy-02.png](files/deploy-02.txt)
3. In the **Applications** list view, click **Create Application**.
4. Click **Java SE**.
5. In the Application section, enter a name for your application and click Browse.
6. In the **File Upload** window, select the `book-service-1.0-SNAPSHOT.zip` file located in the `target` directory, and click **Open**.
7. Keep the default values in the **Instances** and **Memory** fields and click Create.
8. When the application is completely created copy the URL. 

## ![](../common/img/32_5.png) Test Your Application ##
1. Open a command-line window (or Terminal in Linux).
2. Create a new book record using the following cURL command. Replace the app_endpoint placeholder with the URL of your application.
<br><code>curl -i -X POST -H "Content-Type:application/json" -d "{ \"title\" : \"Hamlet\",  \"author\" : \"William Shakespeare\",\"isbn\":\"978-0486272788\", \"published\":\"1937\",\"genre\":\"Novel\" }" <b>app_endpoint</b>/books</code>
3. Query all book entities.
<br><code>curl <b>app_endpoint</b>/books</code>
4. Update the published property of the book. 
<br><code>curl -i -X PUT -H "Content-Type:application/json" -d "{ \"title\" : \"Hamlet\",  \"author\" : \"William Shakespeare\",\"isbn\":\"978-0486272788\", \"published\":\"1980\",\"genre\":\"Novel\"}" <b>app_endpoint</b>/books/1</code>
<br>**Note:** The PUT method, update all the properties of the entity, if you don't specify one, the property is replaced with null.
5. Delete the book.
<br><code>curl -i -X DELETE curl -i -X DELETE app_endpoint/books/1/books/1</code>

## ![](../common/img/32_more.png) Want to Learn More? ##

* [Oracle Application Container Cloud Service](http://docs.oracle.com/en/cloud/paas/app-container-cloud/index.html) in the Oracle Help Center
* [Java SE 8: Creating a REST Service with Spring Data REST/JPA, and Tomcat for Oracle Application Container Cloud Service](https://apexapps.oracle.com/pls/apex/f?p=44785:112:::::P112_CONTENT_ID:18875) OBE
