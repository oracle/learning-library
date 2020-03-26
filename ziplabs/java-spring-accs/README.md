---
layout: ziplab
description: Learn how to prepare a REST application built using Spring Data REST to be deployed to Oracle Application Container Cloud Service.
tags: ziplab, oracle cloud
permalink: /ziplabs/java-spring-accs/index.html
---
# Deploy a Spring Application to Oracle Cloud #

## Before You Begin ##
This 15-minute tutorial shows you how to prepare a REST application built using Spring Data REST to be deployed to Oracle Application Container Cloud Service.
                            
### Background ###
Oracle Application Container Cloud Service includes Oracle Java SE Cloud Service, which lets you deploy Java applications to the Oracle Cloud.

For your application to run properly on Oracle Application Container Cloud Service, it must comply with the following requirements:

* The application must be self-contained. The application must include everything it needs to run independently.
* Your application must listen to requests on a port provided by the `PORT` environment variable. Oracle Application Container Cloud uses this port to redirect requests made to your application.
* The application must include a `manifest.json` file. This file specifies information that Oracle Application Container Cloud Service requires to run your application properly. Optionally you can also specify additional information about instance scaling, environment variables, and service bindings in a `deployment.json` file.
* The application must be bundled in a .zip, .tgz, or .tar.gz file. The application archive must include all the project dependencies and optionally the manifest.json file at the root.

### What Do You Need? ###

* [Maven 3.0+](http://maven.apache.org/download.cgi)
* [cURL 7.0+](http://curl.haxx.se/download.html) with SSL support
* Book application service [book-service.zip](files/book-service.zip)
* [Git](https://git-scm.com/downloads) (Git CMD shell to execute cURL commands)
* Access to an instance of Oracle Application Container Cloud Service
* [A storage replication policy for your service instance](https://docs.oracle.com/en/cloud/iaas/storage-cloud/cssto/selecting-replication-policy-your-account.html)
* [A storage container](https://docs.oracle.com/en/cloud/iaas/storage-cloud/cssto/creating-containers.html)

## Create the Manifest.json File ##
1. Extract the content of the `book-service.zip` file in your local system.

    <pre><code>unzip book-service.zip</code></pre>
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

## Prepare the Application to Read the PORT Environment Variable ##
1. In the `src/main` directory, create the resources folder.
2. In the `resources` directory, create the `application.properties` file.
3. Add the following content to the file:

    <pre><code>server.port=${PORT}</code></pre>

## Compile and Package Your Application ##

1. Open a command-line window (or Terminal in Linux) and go to the `book-service` directory.
2. Compile and package your application using the Maven command:

    <pre><code>mvn compile package</code></pre>
    
## Deploy your Application to Oracle Application Container Cloud Service ##
1. In a web browser, go to [https://cloud.oracle.com/home](https://cloud.oracle.com/home) and click **Sign In**.
2. From the **Cloud Account** drop-down menu, select **Cloud Account with Identity Cloud Service**.
3. Enter your Cloud Account Name and click **My Services**.
4. Enter your cloud account credentials and click **Sign In**.
5. If Oracle Application Container Cloud Service isn't listed in the dashboard, click **Customize Dashboard**.
6. In the **Application Container** tile, click **Action** and select **Open Service Console**.
7. Click **Java SE**.
8. On the **Create Application** page, enter `BookService` for the name. On **Application**, be sure **Upload Archive** is selected and click **Browse**.
9. In the **File Upload** window, select the `book-service-1.0-SNAPSHOT.zip` file located in the `target` directory, and click **Open**.
10. Keep the default values in the **Instances** and **Memory** fields and click **Create**.
11. When the application is completely created copy the URL. 

## Test Your Application ##
1. Open a command-line window (or Terminal in Linux).
2. Create a new book record using the following cURL command. Replace the app_endpoint placeholder with the URL of your application.

    <pre><code>curl -i -X POST -H "Content-Type:application/json" -d "{ \"title\" : \"Hamlet\",  \"author\" : \"William Shakespeare\",\"isbn\":\"978-0486272788\", \"published\":\"1937\",\"genre\":\"Novel\" }" <b>app_endpoint</b>/books</code></pre>

3. Query all book entities.

    <pre><code>curl <b>app_endpoint</b>/books</code></pre>

4. Update the published property of the book. 

    <pre><code>curl -i -X PUT -H "Content-Type:application/json" -d "{ \"title\" : \"Hamlet\",  \"author\" : \"William Shakespeare\",\"isbn\":\"978-0486272788\", \"published\":\"1980\",\"genre\":\"Novel\"}" <b>app_endpoint</b>/books/1</code></pre>

    **Note:** The PUT method will update all the properties of the entity. If you don't specify a value, the property is replaced with null.

5. Delete the book.

    <pre><code>curl -i -X DELETE <b>app_endpoint</b>/books/1</code></pre>

## Want to Learn More? ##

* [Oracle Application Container Cloud Service](http://docs.oracle.com/en/cloud/paas/app-container-cloud/index.html) in the Oracle Help Center
* [Java SE 8: Creating a REST Service with Spring Data REST/JPA, and Tomcat for Oracle Application Container Cloud Service](https://apexapps.oracle.com/pls/apex/f?p=44785:112:::::P112_CONTENT_ID:18875) OBE
