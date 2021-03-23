# Exploring Helidon

## Introduction

*Helidon* is an open-source Java-based collection of libraries that one can use to develop lightweight Microservices, it offers 2 programming models:
- Helidon MP: MicroProfile APIs declarative, Java EE/Jakarta EE style (JAX-RS, CDI, etc.).
- Helidon SE: functional style, transparent, no magic (ex. injection).

For more information, please check [https://helidon.io/](https://helidon.io/).

💡 This lab is using Helidon SE as it is simple, lightweight, and fast. Obviously, all the Java features discussed can be used with any framework supporting the latest version of Java. Moreover, this lab is only using a small fraction of Helidon's capabilities.
 
Estimated Lab Time: 5 minutes

### Objectives
- Create a simple Microservices exposing a REST endpoint using Helidon SE. 
- The goal is to have some initial exposure to Helidon, gain some high-level understandings of Helidon and its development workflow.

## **STEP 1**: Initialize a Helidon project

One can generate the skeleton of a microservice using Helidon Maven archetypes. To simplify things, you will use the Helidon CLI (Command Line Interface), which under the hood uses the same approach, to initialize a simple Helidon project.

1. Run `helidon init`, and select the suggested options (**SE flavor**, **bare Minimal Helidon SE project**, and other default values).

    ![](.././images/lab3-1.png " ")

2. Go into the project directory (`cd java-devlive`), and check the newly generated project (`tree -C .`). You should notice it is a Maven project:
* there is `pom.xml`,
* sources are located in `src/main/java/com/devlive/`,
* tests are located in `src/test/java/com/devlive/`, etc.

    ![](.././images/lab3-2.png " ")

## **STEP 2**: Build and test an Helidon project

1. You can build the Helidon project using the `mvn package` command in the `java-devlive` directory. 

    ![](.././images/lab3-3.png " ")

💡 The first time, Maven will populate its local cache so this initial build will take longer!

2. You can now check the project's target directory (`tree -C target`), it contains a lot of files including the dependencies used by the application, and the application itself.

    ![](.././images/lab3-4.png " ")

3. To run the application, simply use `java -jar target/java-devlive.jar`

    ![](.././images/lab3-5.png " ")

The sample service is now accessible on locally port 8080 and given that you have configured earlier the VCN and the instance firewall to allow incoming traffic on port 8080, it should also be accessible via your instance public IP address. 

4. Invoke the endpoint using either `curl` or a web browser and its public IP address (`http://{public-ip}:8080/greet`), it should return the `{"message":"Hello World!"}` json payload.

💡 You might want to use Firefox during this lab as it formats nicely any returned JSON payload.

## **STEP 3**: Check the source code

Let's now try to grasp how things work by checking the sources.

#### _Main.java_

`bat src/main/java/com/devlive/Main.java`

This is the main class of the application. Amongst other things, its `startServer` method
* creates a Webserver instance,
* invokes the `createRouting` method (see below),
* use the `config` object to configure itself,
* add JSON support.

```java
…
WebServer server = WebServer.builder(createRouting(config))
    .config(config.get("server"))
    .addMediaSupport(JsonpSupport.create())
    .build();
…
```

The `startServer` method also invokes the `createRouting` method which amongst other things
* instantiates `GreetService`,
* adds the `greetService instance as the handler under the "/greet" path,
* builds the updated route object and returns it to the `startServer` method.

```java

GreetService greetService = new GreetService(config);
return Routing.builder()
       …
      .register("/greet", greetService)
      .build();
```


The webserver is then started.
```java
…
server.start();
…
```

#### _GreetService.java_

Let's now look at the 2nd class:

`bat src/main/java/com/devlive/GreetService.java`

We can notice that this class implements the [io.helidon.webserver.Service](https://helidon.io/docs/v2/apidocs/io.helidon.webserver/io/helidon/webserver/Service.html) functional interface which has the `update` method.
```Java
public class GreetService implements Service …
```

The `update` method defines a message handler (`getDefaultMessageHandler`) for the "/" path and the HTTP GET method. Rember that `greetService` has been registered under the "/greet" path, so "/" here is the root path under "/greet" which is equivalent to "/greet".

```java
public void update(Routing.Rules rules) {
   rules.get("/", this::getDefaultMessageHandler);
}
```

The `getDefaultMessageHandler` simply creates a JSON object and  sends it downstream using the `response.send`, that's the result of the REST endpoint.

```java
private void getDefaultMessageHandler(ServerRequest request, ServerResponse response) {
 …
   String msg = String.format("%s %s!", greeting, "World");
   JsonObject returnObject = JSON.createObjectBuilder()
       .add("message", msg)
       .build();
   response.send(returnObject);
}
```

See [here](https://helidon.io/docs/v2/#/se/webserver/01_introduction) for more details but at a very high level, to create REST end-points using Helidon:
* a webserver is configured and instantiated,
* using this webserver, route(s) can be defined,
* each route should have at least one handler that will process the request(s).

## **STEP 4**: Helidon CLI devloop

You have just used the Helidon CLI to generate the skeleton of an application and used Maven to build it. The application was then executed from the command line using the java launcher.

The Helidon CLI also enables a convenient development loop (aka 'devloop'). In addition to generating the skeleton of an application, the Helidon CLI can also build and run this application, it then also monitors its source files, and restarts the application on every update.

To use the 'devloop' approach, simply go in the project directory and run `helidon dev`.


💡 You can either run the 'devloop' in the background or run it in a separate shell. The latter approach enables you to easily see any potential errors as they happen.

* Open a 2nd SSh connection and run `helidon dev`

* Using the initial SSH connection, slightly change the source code of the application, save it, and see what is happening.

## Wrap-up

This section gave you some basic exposure to Helidon, just enough to use Helidon in the context of the rest of the lab. Do keep in mind that only a small fraction of Helidon's features will be used and that all Java features presented during this lab apply to all Java-based frameworks/programs.

For more information, please check [https://helidon.io/](https://helidon.io/).

## Acknowledgements

 - **Author** - [David Delabassee](https://delabassee.com)
 - **Last updated By** - Kamryn Vinson, September 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.