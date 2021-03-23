# Create the Micronaut Application

## Introduction

In this lab you are going to get create a Micronaut application locally and configure the application to communicate with an Oracle Autonomous Database instance.

If at any point you run into trouble completing the steps, the full source code for the application can be cloned from Github using the following command to checkout the code:

    <copy>
    git clone -b lab4 https://github.com/graemerocher/micronaut-hol-example.git
    </copy>

If you were unable to setup the Autonomous Database and necessary cloud resources you can also checkout a version of the code that uses an in-memory database:

    <copy>
    git clone -b lab4-h2 https://github.com/graemerocher/micronaut-hol-example.git
    </copy>


Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:

* Create a new Micronaut application
* Configure the Micronaut application to connect to Autonomous database

### Prerequisites
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account

## **STEP 1**: Create a new Micronaut application

1. There are several ways you can get started creating a new Micronaut application. If you have the Micronaut CLI installed (see the [Installation instructions](https://micronaut-projects.github.io/micronaut-starter/latest/guide/#installation) for how to install) you can use the `mn` command to create a new application. Which will setup an application that uses the Oracle driver and Micronaut Data JDBC.


    ```
    <copy>
      mn create-app example-atp --features oracle,data-jdbc
    cd example-atp
    </copy>
    ```


Note: By default Micronaut will use the [Gradle](https://gradle.org/) build tool, however you can add `--build maven` if you prefer Maven.

2. If you do not have the Micronaut CLI installed and are running on Linux or OS X you can alternatively `curl` and `unzip`:

    ```
    <copy>
    curl https://launch.micronaut.io/example-atp.zip\?javaVersion\=JDK_8\&features\=oracle,data-jdbc -o example-atp.zip
    unzip example-atp.zip -d example-atp
    cd example-atp
    </copy>
    ```

3. If none of these options are viable you can also navigate to [Micronaut Launch](https://micronaut.io/launch/) in a browser and click the `Features` button and select the `oracle` and `data-jdbc` features then click `Generate` which will produce a zip you can download and unzip.

## **STEP 2**: Configure the Micronaut Application

To configure the Micronaut application to work with Autonomous Database open the `src/main/resources/application.yml` file and modify the default datasource connection settings as follows:

    <copy>
    datasources:
      default:
        url: jdbc:oracle:thin:@mnociatp_high
        driverClassName: oracle.jdbc.OracleDriver
        username: mnocidemo
        dialect: ORACLE
        data-source-properties:
          oracle:
            jdbc:
              fanEnabled: false        
    </copy>    

Delete the existing `src/main/resources/application-test.yml` file so that you can run tests against the Autonomous database instance.

    <copy>
    $ rm src/main/resources/application-test.yml
    </copy>

## **STEP 3**: Configure Oracle Autonomous Database JDBC Drivers

If you are using Gradle add the following dependencies to the `build.gradle` file in the root of your project inside the `dependencies` block:

    <copy>
    runtimeOnly("io.micronaut.sql:micronaut-jdbc-hikari")
    runtimeOnly("com.oracle.database.jdbc:ojdbc8")
    runtimeOnly("com.oracle.database.security:oraclepki:21.1.0.0")
    runtimeOnly("com.oracle.database.security:osdt_cert:21.1.0.0")
    runtimeOnly("com.oracle.database.security:osdt_core:21.1.0.0")
    </copy>

Alternatively if you are using Maven, add the following dependencies to your `pom.xml` inside the `<dependencies>` element:

    <copy>
    <dependency>
      <groupId>io.micronaut.sql</groupId>
      <artifactId>micronaut-jdbc-hikari</artifactId>
      <scope>compile</scope>
    </dependency>
    <dependency>
        <groupId>com.oracle.database.jdbc</groupId>
        <artifactId>ojdbc8</artifactId>
        <scope>runtime</scope>
    </dependency>
    <dependency>
        <groupId>com.oracle.database.security</groupId>
        <artifactId>oraclepki</artifactId>
        <version>21.1.0.0</version>
        <scope>runtime</scope>
    </dependency>
    <dependency>
        <groupId>com.oracle.database.security</groupId>
        <artifactId>osdt_cert</artifactId>
        <version>21.1.0.0</version>
        <scope>runtime</scope>
    </dependency>
    <dependency>
        <groupId>com.oracle.database.security</groupId>
        <artifactId>osdt_core</artifactId>
        <version>21.1.0.0</version>
        <scope>runtime</scope>
    </dependency>
    </copy>


## **STEP 4**: Configure Environment Variables with Credentials

Finally, to configure the datasource password you should set an environment variable named `DATASOURCES_DEFAULT_PASSWORD` to the output value `atp_schema_password` produced by the Terraform script in the previous section.



It is recommended to never hard code passwords in configuration so using an environment variable is the preferred approach.

In addition you should also set an environment variable called `TNS_ADMIN` to the location of your wallet created in Step 2.

For example:

   ```
   <copy>
   export TNS_ADMIN=[Your absolute path to wallet]
   export DATASOURCES_DEFAULT_PASSWORD=[Your atp_schema_password]
   </copy>
   ```

If during the setup process of the Cloud resources you ran into any trouble and were not able to complete prior steps you can use `git` to check out a version of the code that uses an in-memory database instead of Autonomous Database which will allow you to proceed with the following sections of the lab:

  ```
  <copy>
  git clone -b lab4-h2 https://github.com/graemerocher/micronaut-hol-example.git example-atp
  </copy>
  ```

Or by downloading a ZIP of the code:

  ```
  <copy>
  curl https://codeload.github.com/graemerocher/micronaut-hol-example/zip/lab4-h2 -o example-atp.zip
  unzip example-atp.zip
  cd micronaut-hol-example-lab4-h2
  </copy>
  ```

You may now *proceed to the next lab*.

## Acknowledgements
- **Owners** - Graeme Rocher, Architect, Oracle Labs - Databases and Optimization
- **Contributors** - Chris Bensen, Todd Sharp, Eric Sedlar
- **Last Updated By** - Kay Malcolm, DB Product Management, August 2020
