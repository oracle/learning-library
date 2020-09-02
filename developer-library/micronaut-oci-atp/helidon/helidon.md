# Use Helidon Service

## Introduction

In this lab we will run a Helidon microservice and connect the Micronaut application to it

Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:

* Run a pre-built Helidon MP application as a native image locally
* Update Micronaut controller to invoke the service
* Run the Micronaut application locally to verify setup

### Prerequisites
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account
  
## **STEP 1**: Run Helidon MP microservice

The Helidon MP application is already built and available as a native image
(ahead of time compilation into native code using GraalVM `native-image`).

Source code of the application is available on [Github](https://github.com/tomas-langer/helidon-hol-example.git).

Download the native image binary (this is needed for deployment to cloud)

[https://objectstorage.us-phoenix-1.oraclecloud.com/n/toddrsharp/b/micronaut-lab-assets/o/helidon-mp-service](https://objectstorage.us-phoenix-1.oraclecloud.com/n/toddrsharp/b/micronaut-lab-assets/o/helidon-mp-service)

Run the native image (if you are using a Linux environment):

```bash
wget -O helidon-mp-service https://objectstorage.us-phoenix-1.oraclecloud.com/n/toddrsharp/b/micronaut-lab-assets/o/helidon-mp-service
chmod +x helidon-mp-service
./helidon-mp-service
```

_non Linux environment:_
  - Get the application from github: `git clone https://github.com/tomas-langer/helidon-hol-example.git`
  - Build the application (from application directory): `./mvnw package`
  - Run the application: `java -jar target/helidon-mp-service.jar`

This will open the application on port `8081`

We can verify this application works by exercising the following endpoints:

- `curl -i http://localhost:8081/vaccinated/Dino` - this is our "business" endpoint and should return `true`
- `curl -i http://localhost:8081/health` - returns health status (MicroProfile health format)
- `curl -H 'Accept: application/json' http://localhost:8081/metrics` - returns metrics (MicroProfile metrics format)
- `curl -i http://localhost:8081/openapi` - returns OpenAPI yaml service description (MicroProfile OpenAPI specification)

## **STEP 2**: Update Micronaut code

Now it is time to update the Micronaut application to communicate with the Helidon service by defining a new endpoint. This endpoint will use a service that either connects to a remote
microservice, or if that fails, uses a local fallback.

First create a package `example.atp.services`.

Now define a new interface called `PetHealthOperations` that provides the contract for the service:

```java
package example.atp.services;

import java.util.concurrent.CompletableFuture;

public interface PetHealthOperations {
    CompletableFuture<PetHealth> getHealth(String name);

    enum PetHealth {
        UNKNOWN,
        GOOD,
        REQUIRES_VACCINATION
    }
}
```

With the contract in place, the next step is to implement a fallback for the case when the service is unavailable. Define a new class that implements the contract called `PetHealthFallback` which will implement the fallback:

```java
package example.atp.services;

import io.micronaut.retry.annotation.Fallback;

import javax.inject.Singleton;
import java.util.concurrent.CompletableFuture;

@Fallback
@Singleton
public class PetHealthFallback implements PetHealthOperations {
    @Override
    public CompletableFuture<PetHealth> getHealth(String name) {
        return CompletableFuture.completedFuture(PetHealthOperations.PetHealth.UNKNOWN);
    }
}
```

The class uses Micronaut's [Client Fallbacks](https://docs.micronaut.io/latest/guide/index.html#clientFallback) concept and the `@Fallback` annotation to define logic that will be executed if an error occurs calling the actual service.

With the fallback in place, the next step is to implement the actual service. Define a class called `PetHealthService` that is used to invoke the actual service:

```java
package example.atp.services;

import java.util.concurrent.CompletableFuture;
import javax.inject.Singleton;

import io.micronaut.http.annotation.Get;
import io.micronaut.http.client.annotation.Client;
import io.micronaut.retry.annotation.Recoverable;

@Singleton
@Recoverable(api = PetHealthOperations.class)
public class PetHealthService implements PetHealthOperations {
    private final PetHealthClient petHealthClient;

    PetHealthService(PetHealthClient petHealthClient) {
        this.petHealthClient = petHealthClient;
    }

    @Override
    public CompletableFuture<PetHealth> getHealth(String name) {
        return petHealthClient.isVaccinated(name).thenApply(isVaccinated ->
                isVaccinated ? PetHealth.GOOD : PetHealth.REQUIRES_VACCINATION
        );
    }

    @Client(value = "pet-health", path ="/vaccinated")
    public interface PetHealthClient {
        @Get("/{name}")
        CompletableFuture<Boolean> isVaccinated(String name);
    }
}
```

Key aspects of this example include:

* The class is annotated with `@Singleton` and `@Recoverable`, the latter of which is used to define the api that contains the methods that will trigger fallback behaviour.
* An inner interface called `PetHealthClient` is defined that uses Micronaut's support for [declarative clients HTTP clients](https://docs.micronaut.io/latest/guide/index.html#clientAnnotation). The `@Client` interface is used to specify a named service called `pet-health` which will be used to perform the communication. This client is injected into the constructor of the `PetHealthService` and is used to make the call to the Helidon service.

Micronaut includes comprehensive support for different [service discovery](https://docs.micronaut.io/latest/guide/index.html#serviceDiscovery) strategies. You could configure Micronaut to use a Service Discovery server or discovery services via Kubernetes using the name `pet-health`.

To keep things simple for the moment just define a hard coded URL to the Helidon service:

In `resources/application.yml`, update the `micronaut` section and add the following:
```yaml
micronaut:
  http.services:
    pet-health:
      urls: "http://localhost:8081"
```

By setting `micronaut.http.services.pet-health.urls`, you can define the endpoints the logical name `pet-health` will invoke when called.

Finally, it is time to update the `PetController` controller to invoke the Pet Health service:

```java
// a new field
private final PetHealthOperations petHealthOperations;

//updated constructor
PetController(PetRepository petRepository, PetHealthOperations petHealthOperations) {
    this.petRepository = petRepository;
    this.petHealthOperations = petHealthOperations;
}

// new method
@Get("/{name}/health")
CompletableFuture<PetHealthOperations.PetHealth> getHealth(String name) {
    return petHealthOperations.getHealth(name);
}
```


## **STEP 3**: Run the code

Now when the Micronaut application is rebuilt and restarted,
we can test the new endpoint.

For the sake of simplicity, the `Dino` and `Hoppy` pets are vaccinated,
 and the poor `Baby Puss` is not.

You can now access http://localhost:8080/pets/{name}/health to find out if a pet is healthy:

```bash
curl -i http://localhost:8080/pets/Dino/health
HTTP/1.1 200 OK
Date: Wed, 26 Aug 2020 13:36:58 GMT
Content-Type: application/json
content-length: 6
connection: keep-alive

"GOOD"%
```

We can try another pet (we need to escape the space):
```bash
curl -i http://localhost:8080/pets/Baby%20Puss/health
HTTP/1.1 200 OK
Date: Wed, 26 Aug 2020 13:37:53 GMT
Content-Type: application/json
content-length: 22
connection: keep-alive

"REQUIRES_VACCINATION"%
```

And we can also see what happens when the target service is down.
Please shut down the Helidon service (just press Ctrl+C in the console or kill the process)

Now let's retry the call and see that fallback works:
```bash
curl -i http://localhost:8080/pets/Dino/health
HTTP/1.1 200 OK
Date: Wed, 26 Aug 2020 13:39:28 GMT
Content-Type: application/json
content-length: 9
connection: keep-alive

"UNKNOWN"%
```
You may now *proceed to the next lab*.

## Acknowledgements
- **Owners** - Graeme Rocher, Architect, Oracle Labs - Databases and Optimization
- **Contributors** - Chris Bensen, Todd Sharp, Eric Sedlar
- **Last Updated By** - Kay Malcolm, DB Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.