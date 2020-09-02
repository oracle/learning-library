
# Weblogic and Helidon Lab 

## Introduction

This lab walks you through the steps for deploying and testing the interoperability between Weblogic Bank Application and Helidon Microservice for Credit Verification.

## Before You Begin

**What Do You Need?**

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup
 

## Lab Description

  The very purpose of writing microservices is do a small piece of job efficiently and re-use it multiple times in different applications. Helidon SE enables us to write one such microservice in this lab.
BestBank, a hypothetical bank has an application. As part of that application, the bank’s credit division wants to build a simple UI which showcases the details of top 15 customers with their SSN number and IBAN number.  The team wants to have a microservice which provides credit score of the customer as output taking the user details like IBAN/SSN numbers as input.
The IT developers create a CreditScore Microservice in Helidon and consume it in the current UI application listing the top 15 customers.

## Implementation Details and Assumptions
-	The sample application UI is built to showcase JSF and CDI using XHTML
-	The user data is not coming from database
-	The Helidon Microservice written in the lab can be deployed on Docker/Kubernetes, but in this lab, we only run it from the JVM locally 

## Key Takeaways
-	In this lab we showcase, how an application running on WebLogic can seamlessly integrate with a Helidon SE microservice which can be sitting anywhere on-premise/cloud., on Docker/Kubernetes or Local JVM.
-	Learn how easily and quickly how Helidon SE Microservice can be built using Maven Archetype for Helidon
-	How to run a Helidon Microservice
-	Optional – How to put Helidon Microservice application on DOCKER

## Lab Flow
This lab is designed for people with no prior experience with Kubernetes, Docker, WebLogic, Helidon and want to learn the core concepts and basics of how to run WebLogic JEE and Helidon microservices application.
- Setup Lab Environment 
- Verify Basic Bank Application Code and working application
- Develop new Credit Score function as microservice using Helidon SE and deploy on local JVM
- Modify Bank Web Application to use Credit Score microservice and deploy on WebLogic
 
## Step 1: Setup Lab Environment 
-	Logon to VNC console of the ConvergedDB image as oracle user to the instance provisioned to you
-	Open a terminal (Shell window) by clicking the “Terminal” icon on the desktop
-	Change directory to /u01/middleware_demo/scripts 
-	Source the setWLS14Profile.sh and setBankAppEnv.sh to set the environment variables required to start the weblogic 14c Admin server and run commands to build Helidon and Bank applications:



	   cd /u01/middleware_demo/scripts/
 
	   . ./setWLS14Profile.sh 

	   . ./setBankAppEnv.sh


## Step 2: Verify Basic Bank Application Code and working application
-	In the same terminal window, change the working directory to WebLogic 14c domain and start AdminServer in the wl_server domain:


		cd $DOMAIN_HOME/bin

		nohup ./startWeblogic.sh &

		tail -f nohup.out

		Press CTRL + C to end the tail command and return to command prompt after the firefox starts automatically

-	The terminal shows stdout logs for starting the AdminServer of Wait till the firefox browser automatically launch the index.jsp 
-	On the top right corner click on “Start the Administration Console” button
	 ![](../images/adminconsole.png " ")  

-	Open the Weblogic Admin Console and login with credentials:

		username: weblogic
		password: Oracle123!

-	On the left hand side Menu under “Domain Structure” click on “Deployments”. Observe that the bestbank2020 application has been already deployed and available to access.

	 ![](../images/deployments.png " ")  

-	In the firefox open a new Tab and access the bank application UI with URL http://localhost:7101/bestbank2020
-	The existence of base version of the sample bestbank application is confirmed.
-	Change directory to /u01/middleware_demo/wls-helidon

		cd /u01/middleware_demo/wls-helidon/

-	Verify if pom.xml and src/ folder is available under /u01/middleware_demo/wls-helidon

		ls -alrt

## Step 3. Develop new Credit Score function as microservice using Helidon SE and deploy on local JVM
-	In the same terminal, navigate to:

	 /u01/middleware_demo/wls-helidon

		cd /u01/middleware_demo/wls-helidon

-	make a directory called “microservice” under /u01/middleware_demo/wls-helidon and navigate to /u01/middleware_demo/wls-helidon/microservice


		mkdir microservice

		cd /u01/middleware_demo/wls-helidon/microservice

-	Generate the project sources using Helidon SE Maven archetypes. The result is a simple project that shows the basics of configuring the WebServer and implementing basic routing rule


	mvn archetype:generate -DinteractiveMode=false \
    	-DarchetypeGroupId=io.helidon.archetypes \
    	-DarchetypeArtifactId=helidon-quickstart-se \
    	-DarchetypeVersion=1.2.0 \
    	-DgroupId=io.helidon.bestbank \
    	-DartifactId=helidon-creditscore-se \
    	-Dpackage=io.helidon.bestbank.creditscore

-	When the project generation is ready open the Main.java for edit:

	gedit helidon-creditscore-se/src/main/java/io/helidon/bestbank/creditscore/Main.java &

-	Add creditscore route which is basically the context path for the service endpoint. Find the createRouting method (at line 96) and register the new route. 

-	Add ".register("/creditscore", new CreditscoreService())" as indicated below.

  	The complete createRouting method has to look like the following:


		96	private static Routing createRouting(Config config) {
		97    MetricsSupport metrics = MetricsSupport.create();
		98    GreetService greetService = new GreetService(config);
		99    HealthSupport health = HealthSupport.builder()
		100            .add(HealthChecks.healthChecks())   // set of checks
		101            .build();
		102
		103    return Routing.builder()
		104            .register(JsonSupport.create())
		105            .register(health)                   // Health at "/health"
		106            .register(metrics)                  // Metrics at "/metrics"
		107            .register("/greet", greetService)
		108            //THIS IS THE ONLY LINE YOU HAVE TO ADD:
		109            .register("/creditscore", new CreditscoreService())
		110            //END OF ADDED SECTION
		111            .build();
		112		}

-	Now create a new class called CreditscoreService in the same package where the Main.java is located:

		gedit helidon-creditscore-se/src/main/java/io/helidon/bestbank/creditscore/CreditscoreService.java &

-	Copy the code in following file into the newly created CreditscoreService.java in gedit:
 

## The CODE

package io.helidon.bestbank.creditscore;

import java.util.logging.Level;
import java.util.logging.Logger;

import javax.json.Json;
import javax.json.JsonObject;

import io.helidon.webserver.Routing;
import io.helidon.webserver.ServerRequest;
import io.helidon.webserver.ServerResponse;
import io.helidon.webserver.Service;

/**
 *
 */

public class CreditscoreService implements Service {

	private final Logger logger = Logger.getLogger(this.getClass().getName());

	private static final int SCORE_MAX = 800;
	private static final int SCORE_MIN = 550;

	/**
	 * A service registers itself by updating the routine rules.
	 *
	 * @param rules the routing rules.
	 */
	@Override
	public final void update(final Routing.Rules rules) {
		rules
			.get("/healthcheck", this::getTestMessage)
			.post("/", this::postMethodCreditscore);
	}

    /**
     * Return a test greeting message.
     * @param request the server request
     * @param response the server response
     */
    private void getTestMessage(final ServerRequest request,
                                   final ServerResponse response) {

        JsonObject returnObject = Json.createObjectBuilder()
                .add("message", "The creditscore provider is running.")
                .build();
        response.send(returnObject);
    }

	/**
     * POST method to return a customer data including creditscore value, using the data that was provided.
     * @param request the server request
     * @param response the server response
     */
	private void postMethodCreditscore(final ServerRequest request,
            final ServerResponse response) {

		request.content()
		.as(JsonObject.class)
		.thenAccept(json -> {
		    logger.log(Level.INFO, "Request: {0}", json);
		    response.send(
		            Json.createObjectBuilder(json)
		                    .add("score", calculateCreditscore(json.getString("firstname"), json.getString("lastname"),
		            				json.getString("dateofbirth"), json.getString("ssn")))
		                    .build()
		    );
		});
	}

	/**
	 * calculate creditscore based on customer's properties
	 * @param firstname
	 * @param lastname
	 * @param dateofbirth
	 * @param ssn
	 * @return
	 */
	private int calculateCreditscore(String firstname, String lastname, String dateofbirth, String ssn) {

		int score = Math.abs(firstname.hashCode() + lastname.hashCode()
				+ dateofbirth.hashCode() + ssn.hashCode());

		score = score % SCORE_MAX;

		while (score < SCORE_MIN) {
			score = score + 100;
		}
		return score;
	}

}

Please note the code above accepts a GET for healthcheck and POST method to calculate the credit score value based on the account owner's details which passed using JSON.
-	Build the project:


	cd /u01/middleware_demo/wls-helidon/microservice/helidon-creditscore-se/

	mvn package

-	This will create the executable jar file of the Helidon Microservice under the folder “target” 

	cd /u01/middleware_demo/wls-helidon/microservice/helidon-creditscore-se/target

	ls -alrt helidon-creditscore-se.jar

## Step 4: Modify Bank Web Application To Use Credit Score Microservice & Deploy On WebLogic
Before the deployment of the Bank Web Application to consume Microservice, the following changes will be made:

1.	Modify the User Interface. Create View button which opens Account Owner details window. This detail window will show the credit score value of the Account Owner.
2.	Modify the server side bean to invoke Credit Score Microservices Application.
3.	Configure the endpoint for the Bank Web Application.
4.	Deploy new web application

## Modify user Interface
-	Open for edit the /u01/middleware_demo/wls-helidon/src/main/webapp/index.xhtml HTML file.

	Gedit /u01/middleware_demo/wls-helidon/src/main/webapp/index.xhtml &

-	Find and delete all the lines which contain REMOVE THIS LINE comment. 
Only that one(!), but that full line of comment which contains. (4 lines needs to be removed.) Save the file. 
If you familiar with JSF to check what has changed in the code.

 
## Modify Server Side Bean
-	Open for edit /u01/middleware_demo/wls-helidon/src/main/java/com/oracle/oow19/wls/bestbank/AccountOwnerBean.java class file.

	gedit /u01/middleware_demo/wls-helidon/src/main/java/com/oracle/oow19/wls/bestbank/AccountOwnerBean.java &

-	Find and delete all the lines which contain REMOVE THIS LINE comment. Only that one(!), but that full line of comment which contains. (6 lines needs to be removed.) Save the file. Check what has changed in the code. The postConstruct method modified to read the end point URL from the property file. New getCreditScore method created to calculate the credit score value of the Account Owner. Finally include the new method invocation in getSelectedAccountOwner method which is triggered by the View button on the User Interface.

## Configure End-Point
-	The last file to modify is the /u01/middleware_demo/wls-helidon/src/main/resources/app.properties file.

The Bank Web Application reads this properties file to know the endpoint's URL. Obviously this solution is just for demo purposes, because in real microservices architecture the best practice is to use additional tools for better service/API management.

	gedit /u01/middleware_demo/wls-helidon/src/main/resources/app.properties &

-	Replace the URL to your given value and save

	creditscore.url=http://localhost:8080/creditscore

## Deploy Modified Web Application

Make sure you are in the terminal where the environment variables are set. 

Change to the Bank Web Application's directory:

Source the setWLS14Profile.sh and setBankAppEnv.sh to set the environment variables required to start the WebLogic 14c Admin server and run commands to build Helidon and Bank applications

	cd /u01/middleware_demo/scripts/

	. ./setWLS14Profile.sh 

	. ./setBankAppEnv.sh

Change the directory to wls-helidon where the Bank Application code reside

	cd /u01/middleware_demo/wls-helidon/

Run the following Maven command:

	mvn clean package


When the build is complete and successful, open the browser and access the new bank application using the URL http://localhost:7101/bestbank2020_01

Select an Account Owner and click the new View button.

A pop-up window with no information about the credit score of the user is seen.  

This is because the microservice is not yet started !!!

## Start The Helidon Microservice

		Open a new terminal.

		Navigate to /u01/middleware_demo/wls-helidon/microservice/helidon-creditscore-se/target/


		cd /u01/middleware_demo/wls-helidon/microservice/helidon-creditscore-se/target/


		Start the Microservice application as a standalone Java Program using the command:

		java -jar helidon-creditscore-se.jar &
 
![](../images/startmicroservice.png " ")  

		In the browser, check if the CreditScore Microservice application is running by checking the health check url http://localhost:8080/creditscore/healthcheck
 
![](../images/microservicerunning.png " ")  

		Open the browser and access the new bank application using the URL http://localhost:7101/bestbank2020_01 or refresh the existing browser window with the above URL, 

		Select an Account Owner and click the new View button.

		A pop-up window with CreditScore information of the user is seen.  

![](../images/creditscore.png " ")  






## Acknowledgements

- **Authors** - Srinivas Pothukuchi, Pradeep Chandramouli, Chethan BR
- **Contributors** - Srinivas Pothukuchi, Pradeep Chandramouli, Chethan BR, Laxmi Amarappanavar
- **Team** - North America SE Specialists.
- **Last Updated By** -  
- **Expiration Date** -  

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
      

