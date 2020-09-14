# Build a Micronaut Application

## Introduction
In this lab you will build a Micronaut application locally that connects to Oracle Autonomous Database.

Note: If at any point you have trouble completing the Lab the complete working example Micronaut application can be checked out from [Github](https://github.com/graemerocher/micronaut-hol-example).

Estimated Lab Time: 40 minutes

### Objectives

In this lab you will:

* Create Micronaut Data entities that map Oracle Database tables
* Define Micronaut Data repositories to implement queries
* Expose Micronaut Controllers as REST endpoints
* Populate Data on Application Startup
* Write tests for the Micronaut application
* Run the Micronaut application locally

### Prerequisites
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account


## **STEP 1**: Create Micronaut Data entities that map Oracle Database tables

1. The first step is to define entity classes that can be used to read data from database tables.

    Using your favorite IDE create a new class under `src/main/java/example/atp/domain` that looks like the following:

    ```java
    package example.atp.domain;

    import io.micronaut.core.annotation.Creator;
    import io.micronaut.data.annotation.GeneratedValue;
    import io.micronaut.data.annotation.Id;
    import io.micronaut.data.annotation.MappedEntity;


    @MappedEntity
    public class Owner {

        @Id
        @GeneratedValue
        private Long id;
        private final String name;
        private int age;

        @Creator
        public Owner(String name) {
            this.name = name;
        }

        public int getAge() {
            return age;
        }

        public void setAge(int age) {
            this.age = age;
        }

        public String getName() {
            return name;
        }

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }
    }
    ```

2. The `@MappedEntity` annotation is used to indicate that the entity is mapped to a database table. By default this will be a table using the same name as the class (in this case `owner`).

    The columns of the table are represented by each Java property. In the above case an `id` column will be used to represent the primary key and by using `@GeneratedValue` this sets up the mapping to assume the use of an `identity` column in Autonomous Database.

    The `@Creator` annotation is used on the constructor that will be used to instantiate the mapped entity and is also used to express required columns. In this case the `name` column is required and immutable whilst the `age` column is not and can be set independently using the `setAge` setter.

    Now define another entity to model a `pet` table under `src/main/java/example/atp/domain`:

    ```java
    package example.atp.domain;

    import io.micronaut.core.annotation.Creator;
    import io.micronaut.data.annotation.AutoPopulated;
    import io.micronaut.data.annotation.Id;
    import io.micronaut.data.annotation.MappedEntity;
    import io.micronaut.data.annotation.Relation;

    import javax.annotation.Nullable;
    import java.util.UUID;

    @MappedEntity
    public class Pet {

        @Id
        @AutoPopulated
        private UUID id;
        private String name;
        @Relation(Relation.Kind.MANY_TO_ONE)
        private Owner owner;
        private PetType type = PetType.DOG;

        @Creator
        public Pet(String name, @Nullable Owner owner) {
            this.name = name;
            this.owner = owner;
        }

        public Owner getOwner() {
            return owner;
        }

        public String getName() {
            return name;
        }

        public UUID getId() {
            return id;
        }

        public void setId(UUID id) {
            this.id = id;
        }

        public PetType getType() {
            return type;
        }

        public void setType(PetType type) {
            this.type = type;
        }

        public enum PetType {
            DOG,
            CAT
        }
    }
    ```

With that done it is time move onto defining repository interfaces to implement queries.

## **STEP 2**: Define Micronaut Data repositories to implement queries

Micronaut Data supports the notion of defining interfaces that automatically implement SQL queries for you at compilation time using the data repository pattern.

To take advantage of this feature of Micronaut Data define a new repository interface that extends from `CrudRepository` and is annotated with `@JdbcRepository` using the `ORACLE` dialect:

```java
package example.atp.repositories;

import example.atp.domain.Owner;
import io.micronaut.data.jdbc.annotation.JdbcRepository;
import io.micronaut.data.model.query.builder.sql.Dialect;
import io.micronaut.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

@JdbcRepository(dialect = Dialect.ORACLE)
public interface OwnerRepository extends CrudRepository<Owner, Long> {

    @Override
    List<Owner> findAll();

    Optional<Owner> findByName(String name);
}
```

The `CrudRepository` interface takes 2 generic argument types. The first is the type of the entity (in this case `Owner`) and the second is the type if the ID (in this case `Long`).

The `CrudRepository` interface defines methods that allow you to create, read, update and delete (CRUD) entities from the database with the appropriate SQL inserts, selects, updates and deletes computed for you at compilation time. For more information see the javadoc for [CrudRepository](https://micronaut-projects.github.io/micronaut-data/latest/api/io/micronaut/data/repository/CrudRepository.html).

You can define methods within the interface that perform JDBC queries and automatically handle all the intricate details for you such as defining correct transaction semantics (read-only transactions for queries), executing the query and mapping the result set to the `Owner` entity class you defined earlier.

The `findByName` method defined above will produce a query such as `SELECT ID, NAME, AGE FROM OWNER WHERE NAME = ?` automatically at compilation time.

For more information on query methods and the types of queries you can define see the [documentation for query methods](https://micronaut-projects.github.io/micronaut-data/latest/guide/index.html#querying) in the Micronaut Data documentation.

With the `OwnerRepository` in place let's create another repository and this time using a data transfer object (DTO) to perform an optimized query.

First create the DTO under `src/main/java/example/atp/domain`:

```java
package example.atp.domain;

import io.micronaut.core.annotation.Introspected;

@Introspected
public class NameDTO {
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

A DTO is a simple POJO that allows you to select only the columns a particular query needs, thus producing a more optimized query. Define another repository called `PetRepository` for the `Pet` entity that uses the DTO:

```java
package example.atp.repositories;

import example.atp.domain.NameDTO;
import example.atp.domain.Pet;
import io.micronaut.data.annotation.Join;
import io.micronaut.data.jdbc.annotation.JdbcRepository;
import io.micronaut.data.model.query.builder.sql.Dialect;
import io.micronaut.data.repository.PageableRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@JdbcRepository(dialect = Dialect.ORACLE)
public interface PetRepository extends PageableRepository<Pet, UUID> {

    List<NameDTO> list();

    @Join("owner")
    Optional<Pet> findByName(String name);
}
```

Take note of the `list` method that returns the DTO. This method will again be implemented for you at compilation time, but this time instead of retrieving all the columns of the `Pet` column it will only retrieve the `name` column and any other columns you may define.

The `findByName` method is also interesting as it uses another important feature of Micronaut Data which is the `@Join` annotation which allows you to [specify join paths](https://micronaut-projects.github.io/micronaut-data/latest/guide/#joinQueries) so that you retrieve exactly the data you need via database joins resulting in much more efficient queries.

With the data repositories in place let's move on to exposing REST endpoints.

## **STEP 3**: Expose Micronaut Controllers as REST endpoints

REST endpoints in Micronaut are easy to write and defined as [controllers (as per the MVC pattern)](https://docs.micronaut.io/latest/guide/index.html#httpServer).

Define a new `OwnerController` class in `src/main/java/example/atp/controllers` like the following:

```java
package example.atp.controllers;

import java.util.List;
import java.util.Optional;

import javax.validation.constraints.NotBlank;

import example.atp.domain.Owner;
import example.atp.repositories.OwnerRepository;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.scheduling.TaskExecutors;
import io.micronaut.scheduling.annotation.ExecuteOn;

@Controller("/owners")
@ExecuteOn(TaskExecutors.IO)
class OwnerController {

    private final OwnerRepository ownerRepository;

    OwnerController(OwnerRepository ownerRepository) {
        this.ownerRepository = ownerRepository;
    }

    @Get("/")
    List<Owner> all() {
        return ownerRepository.findAll();
    }

    @Get("/{name}")
    Optional<Owner> byName(@NotBlank String name) {
        return ownerRepository.findByName(name);
    }
}
```

A controller class is defined with the `@Controller` annotation which you can use to define the root URI that the controller maps to (in this case `/owners`).

Notice too the `@ExecuteOn` annotation which is used to tell Micronaut that the controller performs I/O communication with a database and therefore operations should [run on the I/O thread pool](https://docs.micronaut.io/latest/guide/index.html#reactiveServer).

The `OwnerController` class uses [Micronaut dependency injection](https://docs.micronaut.io/latest/guide/index.html#ioc) to obtain a reference to the `OwnerRepository` repository interface you defined earlier and is used to implement two endpoints:

* `/` - The root endpoint lists all the owners
* `/{name}` - The second endpoint uses a [URI template](https://docs.micronaut.io/latest/guide/index.html#routing) to allow looking up an owner by name. The value of the URI variable `{name}` is provided as a parameter to the `byName` method.

Next define another REST endpoint called `PetController` under `src/main/java/example/atp/controllers`:

```java
package example.atp.controllers;

import java.util.List;
import java.util.Optional;

import example.atp.domain.NameDTO;
import example.atp.domain.Pet;
import example.atp.repositories.PetRepository;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.scheduling.TaskExecutors;
import io.micronaut.scheduling.annotation.ExecuteOn;

@ExecuteOn(TaskExecutors.IO)
@Controller("/pets")
class PetController {

    private final PetRepository petRepository;

    PetController(PetRepository petRepository) {
        this.petRepository = petRepository;
    }

    @Get("/")
    List<NameDTO> all() {
        return petRepository.list();
    }

    @Get("/{name}")
    Optional<Pet> byName(String name) {
        return petRepository.findByName(name);
    }
}
```

This time the `PetRepository` is injected to expose a list of pets and pets by name.

## **STEP 4**: Populate Data on Application Startup

The next step is to populate some application data on startup. To do this you can use [Micronaut application events](https://docs.micronaut.io/latest/guide/index.html#contextEvents).

Modify your `src/main/java/example/atp/Application.java` class to look like the following:

```java
package example.atp;

import example.atp.domain.Owner;
import example.atp.domain.Pet;
import example.atp.repositories.OwnerRepository;
import example.atp.repositories.PetRepository;
import io.micronaut.context.event.StartupEvent;
import io.micronaut.runtime.Micronaut;
import io.micronaut.runtime.event.annotation.EventListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Singleton;
import javax.transaction.Transactional;
import java.util.Arrays;

@Singleton
public class Application {
    private final OwnerRepository ownerRepository;
    private final PetRepository petRepository;

    Application(OwnerRepository ownerRepository, PetRepository petRepository) {
        this.ownerRepository = ownerRepository;
        this.petRepository = petRepository;
    }

    public static void main(String[] args) {
        System.setProperty("oracle.jdbc.fanEnabled", "false");
        Micronaut.run(Application.class);
    }

    @EventListener
    @Transactional
    void init(StartupEvent event) {
        Owner fred = new Owner("Fred");
        fred.setAge(45);
        Owner barney = new Owner("Barney");
        barney.setAge(40);
        ownerRepository.saveAll(Arrays.asList(fred, barney));

        Pet dino = new Pet("Dino", fred);
        Pet bp = new Pet("Baby Puss", fred);
        bp.setType(Pet.PetType.CAT);
        Pet hoppy = new Pet("Hoppy", barney);

        petRepository.saveAll(Arrays.asList(dino, bp, hoppy));
    }
}
```

Note that the constructor is modified to dependency inject the repository definitions so data can be persisted.

Notice in the `main` method JDBC support for FAN events is disabled as they are not necessary for this application:

```java
System.setProperty("oracle.jdbc.fanEnabled", "false");
```

Finally the `init` method is annotated with `@EventListener` with an argument to receive a `StartupEvent`. This event is called
once the application is up and running and can be used to persist data when your application is ready to do so.

The rest of the example demonstrates saving a few entities using the [saveAll](https://micronaut-projects.github.io/micronaut-data/latest/api/io/micronaut/data/repository/CrudRepository.html#saveAll-java.lang.Iterable-) method of the [CrudRepository](https://micronaut-projects.github.io/micronaut-data/latest/api/io/micronaut/data/repository/CrudRepository.html) interface.

Notice that `javax.transaction.Transactional` is declared on the method which ensures that Micronaut Data wraps the execution of the `init` method in a JDBC transaction that is rolled back if anything goes wrong during the execution of the method.

If you wish to monitor the SQL queries that Micronaut Data performs you can open up `src/main/resources/logback.xml` and add the following line to enable SQL logging:

```xml
<logger name="io.micronaut.data.query" level="debug" />
```

## **STEP 5**: Write Integration Tests for the Micronaut Application

The application will already have been setup with a single test that tests the application can startup successfully (and hence will test the logic of the `init` method defined in the previous section).

This test is configured to use [Testcontainers](https://www.testcontainers.org/) and an Oracle Express image, making sure you are writing integration tests that exercise the correct database.

Note that the test requires a working Docker installation and will take some time (depending on your internet connectivity) to download the Oracle Express image on first execution.

You can execute your tests with:

```bash
./gradlew test
```

## **STEP 6**: Run the Micronaut application locally

To run the application locally and test against the Autonomous Database that was setup in the previous labs. Make sure you have set the `TNS_ADMIN` environment variable to the location of you Wallet directory and set `DATASOURCES_DEFAULT_PASSWORD` to the output value `atp_schema_password` produced by the Terraform script in the previous lab and then execute `./gradlew run -t`

```bash
   export TNS_ADMIN=[Your absolute path to wallet]
   export DATASOURCES_DEFAULT_PASSWORD=[Your atp_schema_password]
   ./gradlew run -t
   ```

Note that the `-t` argument is optional and activates continuous build such that if you make changes to your application it will be automatically restarted.

You can now access [http://localhost:8080/pets](http://localhost:8080/pets) for the `/pet` endpoint and [http://localhost:8080/owners](http://localhost:8080/owners) for the `/owners` endpoint. For example:

```bash
curl -i http://localhost:8080/pets
HTTP/1.1 200 OK
Date: Thu, 20 Aug 2020 15:12:47 GMT
Content-Type: application/json
content-length: 55
connection: keep-alive

[{"name":"Dino"},{"name":"Baby Puss"},{"name":"Hoppy"}]
```

## Learn More
* [Micronaut Documentation](https://micronaut.io/documentation.html)
* [Micronaut Data Documentation](https://micronaut-projects.github.io/micronaut-data/latest/guide/index.html)

You may now *proceed to the next lab*.

## Acknowledgements
- **Owners** - Graeme Rocher, Architect, Oracle Labs - Databases and Optimization
- **Contributors** - Chris Bensen, Todd Sharp, Eric Sedlar
- **Last Updated By** - Kay Malcolm, DB Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
